//
//  ViewController.m
//  粒子动效
//
//  Created by wyb on 2017/5/25.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (UIColor *)radomColor
{
    NSInteger r = arc4random_uniform(256)%255;
    NSInteger g = arc4random_uniform(256)%255;
    NSInteger b = arc4random_uniform(256)%255;

    
    UIColor *color =  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    return color;
}

- (IBAction)btnClick:(id)sender {
    
    CAEmitterCell *cell1 = [self cellWithImage:imageWithColor([self radomColor])];
    cell1.name = @"cell1";
    CAEmitterCell *cell2 = [self cellWithImage:imageWithColor([self radomColor])];
    cell2.name = @"cell2";
    CAEmitterCell *cell3 = [self cellWithImage:imageWithColor([self radomColor])];
    cell3.name = @"cell3";
    
    
    CAEmitterLayer  *emitterLayer = [CAEmitterLayer layer];
    //:发射位置
    emitterLayer.emitterPosition = self.view.center;
    //发射源的大小
    emitterLayer.emitterSize = self.view.bounds.size;
    //发射模式
//    NSString * const kCAEmitterLayerPoints;
//    NSString * const kCAEmitterLayerOutline;
//    NSString * const kCAEmitterLayerSurface;
//    NSString * const kCAEmitterLayerVolume;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    //发射源的形状：
//    NSString * const kCAEmitterLayerPoint;
//    NSString * const kCAEmitterLayerLine;
//    NSString * const kCAEmitterLayerRectangle;
//    NSString * const kCAEmitterLayerCuboid;
//    NSString * const kCAEmitterLayerCircle;
//    NSString * const kCAEmitterLayerSphere;
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    //渲染模式：
//    NSString * const kCAEmitterLayerUnordered;
//    NSString * const kCAEmitterLayerOldestFirst;
//    NSString * const kCAEmitterLayerOldestLast;
//    NSString * const kCAEmitterLayerBackToFront;
//    NSString * const kCAEmitterLayerAdditive;
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
//    装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；
    emitterLayer.emitterCells = @[cell1,cell2,cell3];
    [self.view.layer addSublayer:emitterLayer];
     startAnimate(emitterLayer);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [emitterLayer removeFromSuperlayer];
        
    });
    
    
}

void startAnimate(CAEmitterLayer *emitterLayer)
{
    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell1.birthRate"];
    redBurst.fromValue		= [NSNumber numberWithFloat:40];
    redBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    redBurst.duration		= 0.5;
    redBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell2.birthRate"];
    yellowBurst.fromValue		= [NSNumber numberWithFloat:40];
    yellowBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    yellowBurst.duration		= 0.5;
    yellowBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //数量粒子
    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell3.birthRate"];
    blueBurst.fromValue		= [NSNumber numberWithFloat:40];
    blueBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    blueBurst.duration		= 0.5;
    blueBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[redBurst,yellowBurst,blueBurst];
    [emitterLayer addAnimation:group forKey:@"heartsBurst"];
}

- (CAEmitterCell *)cellWithImage:(UIImage *)image
{
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"wang";
    cell.contents = (__bridge id _Nullable)(image.CGImage);
    // :粒子的缩放比例
    cell.scale      = 0.6;
    //缩放比例范围
    cell.scaleRange = 0.6;
    // 每秒产生的数量粒子产生系数，默认1.0；
    //    cell.birthRate  = 40;
    //生命周期
    cell.lifetime   = 20;
    // 每秒变透明的速度,粒子透明度在生命周期内的改变速度
    //    snowCell.alphaSpeed = -0.7;
    //粒子red在生命周期内的改变速度
    //    snowCell.redSpeed = 0.1;
    // 秒速粒子速度
    cell.velocity      = 200;
    cell.velocityRange = 200;
    cell.yAcceleration = 9.8;
    cell.xAcceleration = 0;
    //掉落的角度范围
    cell.emissionRange  = M_PI;
    
    cell.scaleSpeed		= -0.05;
    ////    cell.alphaSpeed		= -0.3;
    //子旋转角度
    cell.spin			= 2 * M_PI;
    //子旋转角度范围
    cell.spinRange		= 2 * M_PI;
    
    return cell;
}

UIImage *imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0, 0, 10, 15);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
