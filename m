Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWDAP2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWDAP2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 10:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWDAP2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 10:28:11 -0500
Received: from host-84-9-202-240.bulldogdsl.com ([84.9.202.240]:13687 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751537AbWDAP2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 10:28:10 -0500
Date: Sat, 1 Apr 2006 16:28:04 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, rpurdie@rpsys.net, akpm@osdl.org
Subject: [LEDS] S3C24XX GPIO LED support
Message-ID: <20060401152458.GA11239@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

GPIO LED support for Samsung S3C24XX SoC series
processors.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2616-s3c24xx-gpio-leds.patch"

diff -urpN -X ../dontdiff linux-2.6.16-git20/drivers/leds/Kconfig linux-2.6.16-git20-bjd3/drivers/leds/Kconfig
--- linux-2.6.16-git20/drivers/leds/Kconfig	2006-04-01 12:38:55.000000000 +0100
+++ linux-2.6.16-git20-bjd3/drivers/leds/Kconfig	2006-04-01 14:49:22.000000000 +0100
@@ -59,6 +59,13 @@ config LEDS_TOSA
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-6000 series.
 
+config LEDS_S3C24XX
+	tristate "LED Support for Samsung S3C24XX GPIO LEDs"
+	depends on LEDS_CLASS && ARCH_S3C2410
+	help
+	  This option enables support for LEDs connected to GPIO lines
+	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
+
 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
 	depends LEDS_TRIGGERS
diff -urpN -X ../dontdiff linux-2.6.16-git20/drivers/leds/Makefile linux-2.6.16-git20-bjd3/drivers/leds/Makefile
--- linux-2.6.16-git20/drivers/leds/Makefile	2006-04-01 12:38:55.000000000 +0100
+++ linux-2.6.16-git20-bjd3/drivers/leds/Makefile	2006-04-01 14:15:54.000000000 +0100
@@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locom
 obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.o
 obj-$(CONFIG_LEDS_IXP4XX)		+= leds-ixp4xx-gpio.o
 obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
+obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
diff -urpN -X ../dontdiff linux-2.6.16-git20/drivers/leds/leds-s3c24xx.c linux-2.6.16-git20-bjd3/drivers/leds/leds-s3c24xx.c
--- linux-2.6.16-git20/drivers/leds/leds-s3c24xx.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-git20-bjd3/drivers/leds/leds-s3c24xx.c	2006-04-01 16:17:11.000000000 +0100
@@ -0,0 +1,163 @@
+/* drivers/leds/leds-s3c24xx.c
+ *
+ * (c) 2006 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C24XX - LEDs GPIO driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/leds-gpio.h>
+
+/* our context */
+
+struct s3c24xx_gpio_led {
+	struct led_classdev		 cdev;
+	struct s3c24xx_led_platdata	*pdata;
+};
+
+static inline struct s3c24xx_gpio_led *pdev_to_gpio(struct platform_device *dev)
+{
+	return (struct s3c24xx_gpio_led *)platform_get_drvdata(dev);
+}
+
+static inline struct s3c24xx_gpio_led *to_gpio(struct led_classdev *led_cdev)
+{
+	return container_of(led_cdev, struct s3c24xx_gpio_led, cdev);
+}
+
+static void s3c24xx_led_set(struct led_classdev *led_cdev,
+			    enum led_brightness value)
+{
+	struct s3c24xx_gpio_led *led = to_gpio(led_cdev);
+	struct s3c24xx_led_platdata *pd = led->pdata;
+
+	/* there will be a sort delay between setting the output and
+	 * going from output to input when using tristate. */
+	
+	s3c2410_gpio_setpin(pd->gpio, (value ? 1 : 0) ^
+			    (pd->flags & S3C24XX_LEDF_ACTLOW));
+
+	if (pd->flags & S3C24XX_LEDF_TRISTATE)
+		s3c2410_gpio_cfgpin(pd->gpio,
+				    value ? S3C2410_GPIO_OUTPUT : S3C2410_GPIO_INPUT);
+
+}
+
+static int s3c24xx_led_remove(struct platform_device *dev)
+{
+	struct s3c24xx_gpio_led *led = pdev_to_gpio(dev);
+
+	led_classdev_unregister(&led->cdev);
+	kfree(led);
+
+	return 0;
+}
+
+static int s3c24xx_led_probe(struct platform_device *dev)
+{
+	struct s3c24xx_led_platdata *pdata = dev->dev.platform_data;
+	struct s3c24xx_gpio_led *led;
+	int ret;
+
+	led = kzalloc(sizeof(struct s3c24xx_gpio_led), GFP_KERNEL);
+	if (led == NULL) {
+		dev_err(&dev->dev, "No memory for device\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(dev, led);
+
+	led->cdev.brightness_set = s3c24xx_led_set;
+	led->cdev.default_trigger = pdata->def_trigger;
+	led->cdev.name = pdata->name;
+
+	led->pdata = pdata;
+
+	/* no point in having a pull-up if we are always driving */
+
+	if (pdata->flags & S3C24XX_LEDF_TRISTATE) {
+		s3c2410_gpio_setpin(pdata->gpio, 0);
+		s3c2410_gpio_cfgpin(pdata->gpio, S3C2410_GPIO_INPUT);
+	} else {
+		s3c2410_gpio_pullup(pdata->gpio, 0);
+		s3c2410_gpio_setpin(pdata->gpio, 0);
+		s3c2410_gpio_cfgpin(pdata->gpio, S3C2410_GPIO_OUTPUT);
+	}
+
+	/* register our new led device */
+
+	ret = led_classdev_register(&dev->dev, &led->cdev);
+	if (ret < 0) {
+		dev_err(&dev->dev, "led_classdev_register failed\n");
+		goto exit_err1;
+	}
+
+	return 0;
+
+ exit_err1:
+	kfree(led);
+	return ret;
+}
+
+
+#ifdef CONFIG_PM
+static int s3c24xx_led_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct s3c24xx_gpio_led *led = pdev_to_gpio(dev);
+
+	led_classdev_suspend(&led->cdev);
+	return 0;
+}
+
+static int s3c24xx_led_resume(struct platform_device *dev)
+{
+	struct s3c24xx_gpio_led *led = pdev_to_gpio(dev);
+
+	led_classdev_resume(&led->cdev);
+	return 0;
+}
+#else
+#define s3c24xx_led_suspend NULL
+#define s3c24xx_led_resume NULL
+#endif
+
+static struct platform_driver s3c24xx_led_driver = {
+	.probe		= s3c24xx_led_probe,
+	.remove		= s3c24xx_led_remove,
+	.suspend	= s3c24xx_led_suspend,
+	.resume		= s3c24xx_led_resume,
+	.driver		= {
+		.name		= "s3c24xx_led",
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init s3c24xx_led_init(void)
+{
+	return platform_driver_register(&s3c24xx_led_driver);
+}
+
+static void __exit s3c24xx_led_exit(void)
+{
+ 	platform_driver_unregister(&s3c24xx_led_driver);
+}
+
+module_init(s3c24xx_led_init);
+module_exit(s3c24xx_led_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("S3C24XX LED driver");
+MODULE_LICENSE("GPL");
diff -urpN -X ../dontdiff linux-2.6.16-git20/include/asm-arm/arch-s3c2410/leds-gpio.h linux-2.6.16-git20-bjd3/include/asm-arm/arch-s3c2410/leds-gpio.h
--- linux-2.6.16-git20/include/asm-arm/arch-s3c2410/leds-gpio.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-git20-bjd3/include/asm-arm/arch-s3c2410/leds-gpio.h	2006-04-01 15:07:12.000000000 +0100
@@ -0,0 +1,28 @@
+/* linux/include/asm-arm/arch-s3c2410/leds-gpio.h
+ *
+ * (c) 2006 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C24XX - LEDs GPIO connector
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_LEDSGPIO_H
+#define __ASM_ARCH_LEDSGPIO_H "leds-gpio.h"
+
+#define S3C24XX_LEDF_ACTLOW	(1<<0)		/* LED is on when GPIO low */
+#define S3C24XX_LEDF_TRISTATE	(1<<1)		/* tristate to turn off */
+
+struct s3c24xx_led_platdata {
+	unsigned int		 gpio;
+	unsigned int		 flags;
+
+	char			*name;
+	char			*def_trigger;
+};
+
+#endif /* __ASM_ARCH_LEDSGPIO_H */

--uXxzq0nDebZQVNAZ--
