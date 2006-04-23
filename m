Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDWWO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDWWO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWDWWO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 18:14:56 -0400
Received: from the.earth.li ([193.201.200.66]:4570 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S932082AbWDWWOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 18:14:55 -0400
Date: Sun, 23 Apr 2006 23:14:53 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Ben Dooks <ben@fluff.org.uk>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>,
       e3-hacking@earth.li
Subject: Re: [PATCH] [LEDS] Amstrad Delta LED support
Message-ID: <20060423221453.GU7570@earth.li>
References: <20060422130823.GP7570@earth.li> <20060423123850.GA18923@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060423123850.GA18923@home.fluff.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 01:38:50PM +0100, Ben Dooks wrote:
> On Sat, Apr 22, 2006 at 02:08:23PM +0100, Jonathan McDowell wrote:
> > [Which tree should I be trying to submit this to? The patch is
> > against and works fine with 2.6.17-rc2]
> I prefer the following PM defines, so there is only one block of
> CONFIG_PM

Seems reasonable; leds-spitz has the two blocks and that's what I'd used
as inspiration. Revised version below.



Use the new LED infrastructure to support the 6 LEDs present on the
Amstrad Delta.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -ruNp -X linux-2.6.17-rc2/Documentation/dontdiff linux-2.6.17-rc2/arch/arm/mach-omap1/board-ams-delta.c linux-2.6.17-rc2-leds/arch/arm/mach-omap1/board-ams-delta.c
--- linux-2.6.17-rc2/arch/arm/mach-omap1/board-ams-delta.c	2006-04-21 18:28:27.618122000 +0100
+++ linux-2.6.17-rc2-leds/arch/arm/mach-omap1/board-ams-delta.c	2006-04-20 20:18:57.243860250 +0100
@@ -84,6 +84,15 @@ static struct omap_board_config_kernel a
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 };
 
+static struct platform_device ams_delta_led_device = {
+	.name	= "ams-delta-led",
+	.id	= -1
+};
+
+static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_led_device,
+};
+
 static void __init ams_delta_init(void)
 {
 	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
@@ -94,6 +103,8 @@ static void __init ams_delta_init(void)
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
+
+	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
 static void __init ams_delta_map_io(void)
diff -ruNp -X linux-2.6.17-rc2/Documentation/dontdiff linux-2.6.17-rc2/drivers/leds/Kconfig linux-2.6.17-rc2-leds/drivers/leds/Kconfig
--- linux-2.6.17-rc2/drivers/leds/Kconfig	2006-04-21 18:28:38.314790500 +0100
+++ linux-2.6.17-rc2-leds/drivers/leds/Kconfig	2006-04-20 18:47:08.076993500 +0100
@@ -60,6 +60,12 @@ config LEDS_S3C24XX
 	  This option enables support for LEDs connected to GPIO lines
 	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
 
+config LEDS_AMS_DELTA
+	tristate "LED Support for the Amstrad Delta (E3)"
+	depends LEDS_CLASS && MACH_AMS_DELTA
+	help
+	  This option enables support for the LEDs on Amstrad Delta (E3).
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff -ruNp -X linux-2.6.17-rc2/Documentation/dontdiff linux-2.6.17-rc2/drivers/leds/leds-ams-delta.c linux-2.6.17-rc2-leds/drivers/leds/leds-ams-delta.c
--- linux-2.6.17-rc2/drivers/leds/leds-ams-delta.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2-leds/drivers/leds/leds-ams-delta.c	2006-04-23 19:47:30.767019500 +0100
@@ -0,0 +1,162 @@
+/*
+ * LEDs driver for Amstrad Delta (E3)
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <asm/arch/board-ams-delta.h>
+
+/*
+ * Our context
+ */
+struct ams_delta_led {
+	struct led_classdev	cdev;
+	u8			bitmask;
+};
+
+static void ams_delta_led_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	struct ams_delta_led *led_dev = 
+		container_of(led_cdev, struct ams_delta_led, cdev);
+
+	if (value)
+		ams_delta_latch1_write(led_dev->bitmask, led_dev->bitmask);
+	else
+		ams_delta_latch1_write(led_dev->bitmask, 0);
+}
+
+static struct ams_delta_led ams_delta_leds[] = {
+	{
+		.cdev		= {
+			.name		= "ams-delta:camera",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_CAMERA,
+	},
+	{
+		.cdev		= {
+			.name		= "ams-delta:advert",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_ADVERT,
+	},
+	{
+		.cdev		= {
+			.name		= "ams-delta:email",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_EMAIL,
+	},
+	{
+		.cdev		= {
+			.name		= "ams-delta:handsfree",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_HANDSFREE,
+	},
+	{
+		.cdev		= {
+			.name		= "ams-delta:voicemail",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_VOICEMAIL,
+	},
+	{
+		.cdev		= {
+			.name		= "ams-delta:voice",
+			.brightness_set = ams_delta_led_set,
+		},
+		.bitmask	= AMS_DELTA_LATCH1_LED_VOICE,
+	},
+};
+
+#ifdef CONFIG_PM
+static int ams_delta_led_suspend(struct platform_device *dev,
+		pm_message_t state)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ams_delta_leds); i++)
+		led_classdev_suspend(&ams_delta_leds[i].cdev);
+
+	return 0;
+}
+
+static int ams_delta_led_resume(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ams_delta_leds); i++)
+		led_classdev_resume(&ams_delta_leds[i].cdev);
+
+	return 0;
+}
+#else
+#define ams_delta_led_suspend NULL
+#define ams_delta_led_resume NULL
+#endif
+
+static int ams_delta_led_probe(struct platform_device *pdev)
+{
+	int i;
+	int ret;
+
+	for (i = ret = 0; ret >= 0 && i < ARRAY_SIZE(ams_delta_leds); i++) {
+		ret = led_classdev_register(&pdev->dev,
+				&ams_delta_leds[i].cdev);
+	}
+
+	if (ret < 0 && i > 1) {
+		for (i = i - 2; i >= 0; i--)
+			led_classdev_unregister(&ams_delta_leds[i].cdev);
+	}
+
+	return ret;
+}
+
+static int ams_delta_led_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(ams_delta_leds) - 1; i >= 0; i--)
+		led_classdev_unregister(&ams_delta_leds[i].cdev);
+
+	return 0;
+}
+
+static struct platform_driver ams_delta_led_driver = {
+	.probe		= ams_delta_led_probe,
+	.remove		= ams_delta_led_remove,
+	.suspend	= ams_delta_led_suspend,
+	.resume		= ams_delta_led_resume,
+	.driver		= {
+		.name = "ams-delta-led",
+	},
+};
+
+static int __init ams_delta_led_init(void)
+{
+	return platform_driver_register(&ams_delta_led_driver);
+}
+
+static void __exit ams_delta_led_exit(void)
+{
+	return platform_driver_unregister(&ams_delta_led_driver);
+}
+
+module_init(ams_delta_led_init);
+module_exit(ams_delta_led_exit);
+
+MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
+MODULE_DESCRIPTION("Amstrad Delta LED driver");
+MODULE_LICENSE("GPL");
diff -ruNp -X linux-2.6.17-rc2/Documentation/dontdiff linux-2.6.17-rc2/drivers/leds/Makefile linux-2.6.17-rc2-leds/drivers/leds/Makefile
--- linux-2.6.17-rc2/drivers/leds/Makefile	2006-04-21 18:28:38.314790500 +0100
+++ linux-2.6.17-rc2-leds/drivers/leds/Makefile	2006-04-20 18:47:18.297632250 +0100
@@ -11,6 +11,7 @@ obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.
 obj-$(CONFIG_LEDS_IXP4XX)		+= leds-ixp4xx-gpio.o
 obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
+obj-$(CONFIG_LEDS_AMS_DELTA)		+= leds-ams-delta.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
-----

J.

-- 
noodles is owned by dr
