Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWC3XaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWC3XaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWC3XaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:30:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10899 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751150AbWC3XaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:30:21 -0500
Date: Fri, 31 Mar 2006 01:30:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       patches@arm.linux.org.uk, Bompart Cedric <cedric.bompart@thales-is.com>
Subject: Re: Hook collie frontlight into sysfs
Message-ID: <20060330233005.GE1663@elf.ucw.cz>
References: <20060330114609.GA14505@elf.ucw.cz> <1143759565.6418.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143759565.6418.74.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hook backlight handling into backlight subsystem, so that backlight is
> > controllable using /sys . I had to shuffle code around a bit in order
> > to avoid prototypes.
> 
> Hi Pavel,
> 
> There are a few issues with this. Firstly,

>  CC      arch/arm/common/locomo.o
> arch/arm/common/locomo.c: In function `locomo_frontlight_set':
> arch/arm/common/locomo.c:1061: error: `LOCOMO_ALC_EN' undeclared (first use in this function)
> arch/arm/common/locomo.c:1061: error: (Each undeclared identifier is reported only once
> arch/arm/common/locomo.c:1061: error: for each function it appears in.)
> make[1]: *** [arch/arm/common/locomo.o] Error 1

Oops, too much hand editing, probably.

> > +static int set_intensity(struct backlight_device *bd, int intensity)
> > +{
> > +	switch (intensity) {
> > +	/* AC and non-AC are handled differently, but produce same results in sharp code? */
> > +	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
> > +	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
> > +	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
> > +	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
> > +	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
> > +
> > +	default:
> > +		locomo_frontlight_set(locomolcd_dev, intensity, 0, 148); break;
> > +	}
> > +	current_intensity = intensity;
> > +	return 0;
> > +}
> 
> That default statement gives cause for concern. Should it not return
> -EINVAL for intensities outside of 0-4?

Well.. I noticed that values 80..194 actually provide continuous
selection of backlights, so this was my little hack to play with.

I am not sure if it is okay to leave backlight at some state like that
for long ammount of time, nor how is third parameter related...

I guess I'll simply return -EINVAL. 

> > +static int get_intensity(struct backlight_device *bd)
> > +{
> > +	return current_intensity;
> > +}
> > +
> > +static struct backlight_properties locomobl_data = {
> > +	.owner		= THIS_MODULE,
> > +	.get_brightness = get_intensity,
> > +	.set_brightness = set_intensity,
> > +	.max_brightness = 5,
> 
> Maximum brightness is 4 above?

It seems to be ignored, anyway, but will fix.

> > @@ -147,8 +183,13 @@ static int __init poodle_lcd_init(void)
> >  
> >  #ifdef CONFIG_SA1100_COLLIE
> >  	sa1100fb_lcd_power = locomolcd_power;
> > +
> > +	backlight_device_register("collie-bl", NULL, &locomobl_data);
> >  #endif
> >  	return 0;
> >  }
> 
> Could this be changed to:
> 
> #ifdef CONFIG_SA1100_COLLIE
> 	sa1100fb_lcd_power = locomolcd_power;
> #endif
> 	backlight_device_register("locomo-bl", NULL, &locomobl_data);
> 
>  	return 0;
> 
> This means that it will also present a backlight interface on poodle. In
> fact I've already helped a poodle user test this and it works!

Good -- I had no idea if it would work. Changed.

> Also note that there are some backlight interface changes sitting in -mm
> (see the linux-fbdev-devel mailing list) which this patch isn't covered
> by. If this patch gets merged first, I'll make sure it gets adapted to
> the new interface though (which actually brings some benefits like power
> attribute implementation for free).

Perhaps I can merge it into your tree (instead of rmk's?).
								Pavel

This incremental diff should fix these issues...

Signed-off-by: Pavel Machek <pavel@suse.cz>
PATCH FOLLOWS
KernelVersion: 2.6.16-git-previouspatch

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index bcce028..84b0226 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -1090,6 +1090,7 @@ void locomo_frontlight_set(struct locomo
 	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	udelay(100);
 	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+#define LOCOMO_ALC_EN	0x8000
 	locomo_writel(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	spin_unlock_irqrestore(&lchip->lock, flags);
 }
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index a95cd25..d033471 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -120,7 +120,9 @@ static int set_intensity(struct backligh
 	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
 
 	default:
-		locomo_frontlight_set(locomolcd_dev, intensity, 0, 148); break;
+		return -EINVAL;
+		/* Actually, other values are possible, too. Everything between 80..194
+		   seems to work as duty parameter */
 	}
 	current_intensity = intensity;
 	return 0;
@@ -135,7 +137,7 @@ static struct backlight_properties locom
 	.owner		= THIS_MODULE,
 	.get_brightness = get_intensity,
 	.set_brightness = set_intensity,
-	.max_brightness = 5,
+	.max_brightness = 4,
 };
 
 static int poodle_lcd_probe(struct locomo_dev *dev)
@@ -183,9 +185,9 @@ static int __init poodle_lcd_init(void)
 
 #ifdef CONFIG_SA1100_COLLIE
 	sa1100fb_lcd_power = locomolcd_power;
-
-	backlight_device_register("collie-bl", NULL, &locomobl_data);
 #endif
+	backlight_device_register("collie-bl", NULL, &locomobl_data);
+
 	return 0;
 }
 device_initcall(poodle_lcd_init);

-- 
Picture of sleeping (Linux) penguin wanted...
