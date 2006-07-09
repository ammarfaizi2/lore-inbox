Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWGIKV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWGIKV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWGIKV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:21:27 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:14548 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S965013AbWGIKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:21:26 -0400
Message-ID: <44B0D8A4.5070108@bootc.net>
Date: Sun, 09 Jul 2006 11:21:24 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net>
In-Reply-To: <44AF7B00.9060108@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hi all,
> 
> After many years using Linux and hanging about on LKML without having 
> done much actual kernel hacking, I've decided to have a go! The module 
> below adds LED Class device support for the Soekris net48xx Error LED. 
> Tested only on a net4801, but should work on a net4826 as well. I'd love 
> to find a way of detecting a Soekris net48xx device but there is no DMI 
> or any Soekris-specific PCI devices.
> 
> The patch is attached because Thunderbird kills tabs.
> 
> 
> ------------------------------------------------------------------------
> 

And here's the really belated sign-off!

Signed-off-by: Chris Boot <bootc@bootc.net>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 196a31c..c55f690 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2666,6 +2666,11 @@ M:	shemminger@osdl.org
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  
> +SOEKRIS NET48XX LED SUPPORT
> +P:	Chris Boot
> +M:	bootc@bootc.net
> +S:	Maintained
> +
>  SPARC (sparc32):
>  P:	William L. Irwin
>  M:	wli@holomorphy.com
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9650998..9c39b98 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -69,6 +69,13 @@ config LEDS_AMS_DELTA
>  	help
>  	  This option enables support for the LEDs on Amstrad Delta (E3).
>  
> +config LEDS_NET48XX
> +	tristate "LED Support for Soekris net48xx series Error LED"
> +	depends on LEDS_CLASS && SCx200_GPIO
> +	help
> +	  This option enables support for the Soekris net4801 and net4826 error
> +	  LED.
> +
>  comment "LED Triggers"
>  
>  config LEDS_TRIGGERS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 88d3b6e..6aa2aed 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_LEDS_IXP4XX)		+= leds-ixp4x
>  obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
>  obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
>  obj-$(CONFIG_LEDS_AMS_DELTA)		+= leds-ams-delta.o
> +obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
>  
>  # LED Triggers
>  obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
> diff --git a/drivers/leds/leds-net48xx.c b/drivers/leds/leds-net48xx.c
> new file mode 100644
> index 0000000..157b561
> --- /dev/null
> +++ b/drivers/leds/leds-net48xx.c
> @@ -0,0 +1,116 @@
> +/*
> + * LEDs driver for Soekris net48xx
> + *
> + * Copyright (C) 2006 Chris Boot <bootc@bootc.net>
> + *
> + * Based on leds-ams-delta.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/err.h>
> +#include <asm/io.h>
> +#include <linux/scx200_gpio.h>
> +
> +#define NET48XX_ERROR_LED_GPIO	20
> +
> +static struct platform_device *pdev;
> +
> +static void net48xx_error_led_set(struct led_classdev *led_cdev,
> +		enum led_brightness value)
> +{
> +	if (value)
> +		scx200_gpio_set_high(NET48XX_ERROR_LED_GPIO);
> +	else
> +		scx200_gpio_set_low(NET48XX_ERROR_LED_GPIO);
> +}
> +
> +static struct led_classdev net48xx_error_led = {
> +	.name		= "net48xx:error",
> +	.brightness_set	= net48xx_error_led_set,
> +};
> +
> +#ifdef CONFIG_PM
> +static int net48xx_led_suspend(struct platform_device *dev,
> +		pm_message_t state)
> +{
> +	return led_classdev_suspend(&net48xx_error_led);
> +}
> +
> +static int net48xx_led_resume(struct platform_device *dev)
> +{
> +	return led_classdev_resume(&net48xx_error_led);
> +}
> +#else
> +#define net48xx_led_suspend NULL
> +#define net48xx_led_resume NULL
> +#endif
> +
> +static int net48xx_led_probe(struct platform_device *pdev)
> +{
> +	if (!scx200_gpio_present())
> +		return ENODEV;
> +	
> +	return led_classdev_register(&pdev->dev,
> +		&net48xx_error_led);
> +}
> +
> +static int net48xx_led_remove(struct platform_device *pdev)
> +{
> +	led_classdev_unregister(&net48xx_error_led);
> +	return 0;
> +}
> +
> +static struct platform_driver net48xx_led_driver = {
> +	.probe		= net48xx_led_probe,
> +	.remove		= net48xx_led_remove,
> +	.suspend	= net48xx_led_suspend,
> +	.resume		= net48xx_led_resume,
> +	.driver		= {
> +		.name = "net48xx-led",
> +	},
> +};
> +
> +static int __init net48xx_led_init(void)
> +{
> +	int ret;
> +	
> +	if (!scx200_gpio_present()) {
> +		ret = ENODEV;
> +		goto out;
> +	}
> +	
> +	ret = platform_driver_register(&net48xx_led_driver);
> +	if (ret < 0)
> +		goto out;
> +	
> +	pdev = platform_device_register_simple("net48xx-led", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		platform_driver_unregister(&net48xx_led_driver);
> +		goto out;
> +	}
> +	
> +out:
> +	return ret;
> +}
> +
> +static void __exit net48xx_led_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&net48xx_led_driver);
> +}
> +
> +module_init(net48xx_led_init);
> +module_exit(net48xx_led_exit);
> +
> +MODULE_AUTHOR("Chris Boot <bootc@bootc.net>");
> +MODULE_DESCRIPTION("Soekris net48xx LED driver");
> +MODULE_LICENSE("GPL");
> +


-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
