Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWC3XEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWC3XEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWC3XEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:04:47 -0500
Received: from tim.rpsys.net ([194.106.48.114]:9368 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750935AbWC3XEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:04:46 -0500
Subject: Re: Hook collie frontlight into sysfs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       patches@arm.linux.org.uk, Bompart Cedric <cedric.bompart@thales-is.com>
In-Reply-To: <20060330114609.GA14505@elf.ucw.cz>
References: <20060330114609.GA14505@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 23:59:25 +0100
Message-Id: <1143759565.6418.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 13:46 +0200, Pavel Machek wrote:
> Hook backlight handling into backlight subsystem, so that backlight is
> controllable using /sys . I had to shuffle code around a bit in order
> to avoid prototypes.

Hi Pavel,

There are a few issues with this. Firstly,

 CC      arch/arm/common/locomo.o
arch/arm/common/locomo.c: In function `locomo_frontlight_set':
arch/arm/common/locomo.c:1061: error: `LOCOMO_ALC_EN' undeclared (first use in this function)
arch/arm/common/locomo.c:1061: error: (Each undeclared identifier is reported only once
arch/arm/common/locomo.c:1061: error: for each function it appears in.)
make[1]: *** [arch/arm/common/locomo.o] Error 1

> diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
> index 60831bb..a95cd25 100644
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -105,6 +106,38 @@ void locomolcd_power(int on)
>  }
>  EXPORT_SYMBOL(locomolcd_power);
>  
> +
> +static int current_intensity;
> +
> +static int set_intensity(struct backlight_device *bd, int intensity)
> +{
> +	switch (intensity) {
> +	/* AC and non-AC are handled differently, but produce same results in sharp code? */
> +	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
> +	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
> +	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
> +	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
> +	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
> +
> +	default:
> +		locomo_frontlight_set(locomolcd_dev, intensity, 0, 148); break;
> +	}
> +	current_intensity = intensity;
> +	return 0;
> +}

That default statement gives cause for concern. Should it not return
-EINVAL for intensities outside of 0-4?

> +static int get_intensity(struct backlight_device *bd)
> +{
> +	return current_intensity;
> +}
> +
> +static struct backlight_properties locomobl_data = {
> +	.owner		= THIS_MODULE,
> +	.get_brightness = get_intensity,
> +	.set_brightness = set_intensity,
> +	.max_brightness = 5,

Maximum brightness is 4 above?

> +};
> +
>  static int poodle_lcd_probe(struct locomo_dev *dev)
>  {
>  	unsigned long flags;
> @@ -147,8 +183,13 @@ static int __init poodle_lcd_init(void)
>  
>  #ifdef CONFIG_SA1100_COLLIE
>  	sa1100fb_lcd_power = locomolcd_power;
> +
> +	backlight_device_register("collie-bl", NULL, &locomobl_data);
>  #endif
>  	return 0;
>  }

Could this be changed to:

#ifdef CONFIG_SA1100_COLLIE
	sa1100fb_lcd_power = locomolcd_power;
#endif
	backlight_device_register("locomo-bl", NULL, &locomobl_data);

 	return 0;

This means that it will also present a backlight interface on poodle. In
fact I've already helped a poodle user test this and it works!

Also note that there are some backlight interface changes sitting in -mm
(see the linux-fbdev-devel mailing list) which this patch isn't covered
by. If this patch gets merged first, I'll make sure it gets adapted to
the new interface though (which actually brings some benefits like power
attribute implementation for free).

Cheers,

Richard



