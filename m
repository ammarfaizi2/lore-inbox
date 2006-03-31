Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWCaH33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCaH33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCaH32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:29:28 -0500
Received: from thsmsgxrt11p.thalesgroup.com ([192.54.144.134]:28595 "EHLO
	thsmsgxrt11p.thalesgroup.com") by vger.kernel.org with ESMTP
	id S1751245AbWCaH31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:29:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hook collie frontlight into sysfs
Date: Fri, 31 Mar 2006 09:29:21 +0200
Message-ID: <6CE648B340455F479A7AE27769282663018A276F@gva0013.ch.intra>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hook collie frontlight into sysfs
Thread-Index: AcZUTlebRW09Q0jcQniz2CxrQql9UQARYAAA
From: "Bompart Cedric" <cedric.bompart@thales-is.com>
To: "Richard Purdie" <rpurdie@rpsys.net>, "Pavel Machek" <pavel@ucw.cz>
Cc: <lenz@cs.wisc.edu>, "kernel list" <linux-kernel@vger.kernel.org>,
       <patches@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

During our test with Richard, we've been thinking can you implement the
full range of brightness intensity values? For example for the others
Zaurus, I think the range is between 0 and 63. So the userspace can
adjust a wider range of levels for the backlight. Another thing, I
didn't see anything different visually between the value 3 and 4.

Regards,
Ced.



-----Original Message-----
From: Richard Purdie [mailto:rpurdie@rpsys.net] 
Sent: 31 March 2006 00:59
To: Pavel Machek
Cc: lenz@cs.wisc.edu; kernel list; patches@arm.linux.org.uk; Bompart
Cedric
Subject: Re: Hook collie frontlight into sysfs

On Thu, 2006-03-30 at 13:46 +0200, Pavel Machek wrote:
> Hook backlight handling into backlight subsystem, so that backlight is
> controllable using /sys . I had to shuffle code around a bit in order
> to avoid prototypes.

Hi Pavel,

There are a few issues with this. Firstly,

 CC      arch/arm/common/locomo.o
arch/arm/common/locomo.c: In function `locomo_frontlight_set':
arch/arm/common/locomo.c:1061: error: `LOCOMO_ALC_EN' undeclared (first
use in this function)
arch/arm/common/locomo.c:1061: error: (Each undeclared identifier is
reported only once
arch/arm/common/locomo.c:1061: error: for each function it appears in.)
make[1]: *** [arch/arm/common/locomo.o] Error 1

> diff --git a/drivers/video/backlight/locomolcd.c
b/drivers/video/backlight/locomolcd.c
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
> +	/* AC and non-AC are handled differently, but produce same
results in sharp code? */
> +	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
> +	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161);
break;
> +	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148);
break;
> +	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161);
break;
> +	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161);
break;
> +
> +	default:
> +		locomo_frontlight_set(locomolcd_dev, intensity, 0, 148);
break;
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





