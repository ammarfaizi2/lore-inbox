Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965394AbWKGQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbWKGQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbWKGQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:53:25 -0500
Received: from jail1.krisk.org ([216.139.201.203]:33028 "EHLO jail1.krisk.org")
	by vger.kernel.org with ESMTP id S965394AbWKGQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:53:18 -0500
Message-ID: <4550C7F4.9040601@krisk.org>
Date: Tue, 07 Nov 2006 12:52:52 -0500
From: Kristian Kielhofner <kris@krisk.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bootc@bootc.net, rpurdie@rpsys.net
CC: linux-kernel@vger.kernel.org
Subject: PATCH: PCEngines WRAP LED Support
Content-Type: multipart/mixed;
 boundary="------------090904010208010504070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904010208010504070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

	I have "created" a driver for the PCEngines WRAP boards 
(http://www.pcengines.ch), which are very similar to the Soekris net4801 
(same NS SC1100 geode reference design).  It was developed for, applies 
to, and works quite well (for me) on 2.6.18.

	The LEDs on the WRAP are on different GPIO lines and I have modified 
and copied the net48xx error led support for this.  It also includes 
support for an "extra" led (in addition to error).  The three LEDs on 
the WRAP are at GPIO lines 2,3,18 (WRAP LEDs from left to right).  This 
driver gives access to the second and third LEDs by twiddling GPIO lines 
3 & 18.

	Because these boards are so similar to the net48xx, I basically sed-ed 
that driver to form the basis for leds-wrap.c.  The only changes from 
leds-net48xx.c are:

- #define WRAP_EXTRA_LED_GPIO
- name changes
- duplicate relevant sections to provide support for the "extra" led
- reverse the various *_led_set values.  The WRAP is "backwards" from 
the net48xx, and these needed to be updated for that.

	This does need a little work though...  Due to my VERY limited 
knowledge of C (sorry), I don't know how to properly handle and return 
error status from multiple led_classdev_register() calls inside of 
wrap_led_probe().  I'm sure someone can fix this up in a jiffy :).

Signed-off-by: Kristian Kielhofner <kris@krisk.org>

My mail reader does not appear to let me insert text inline, so I have 
attached the patch.  Hopefully it will be rendered correctly by most 
mail readers (sure beats bad wrapping).  If it doesn't work out, I can 
try again.

--------------090904010208010504070902
Content-Type: text/x-patch;
 name="wrap-led.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wrap-led.patch"

diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/leds/Kconfig linux-2.6.18/drivers/leds/Kconfig
--- linux-2.6.18-vanilla/drivers/leds/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/drivers/leds/Kconfig	2006-11-03 16:15:44.000000000 -0500
@@ -76,6 +76,12 @@ config LEDS_NET48XX
 	  This option enables support for the Soekris net4801 and net4826 error
 	  LED.
 
+config LEDS_WRAP
+	tristate "LED Support for the WRAP series LEDs"
+	depends on LEDS_CLASS && SCx200_GPIO
+	help
+	  This option enables support for the PCEngines WRAP programmable LEDs.
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/leds/leds-wrap.c linux-2.6.18/drivers/leds/leds-wrap.c
--- linux-2.6.18-vanilla/drivers/leds/leds-wrap.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.18/drivers/leds/leds-wrap.c	2006-11-03 16:27:46.000000000 -0500
@@ -0,0 +1,135 @@
+/*
+ * LEDs driver for PCEngines WRAP
+ *
+ * Copyright (C) 2006 Kristian Kielhofner <kris@krisk.org>
+ *
+ * Based on leds-net48xx.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <asm/io.h>
+#include <linux/scx200_gpio.h>
+
+#define DRVNAME "wrap-led"
+#define WRAP_ERROR_LED_GPIO	3
+#define	WRAP_EXTRA_LED_GPIO	18
+
+static struct platform_device *pdev;
+
+static void wrap_error_led_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	if (value)
+		scx200_gpio_set_low(WRAP_ERROR_LED_GPIO);
+	else
+		scx200_gpio_set_high(WRAP_ERROR_LED_GPIO);
+}
+
+static void wrap_extra_led_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	if (value)
+		scx200_gpio_set_low(WRAP_EXTRA_LED_GPIO);
+	else
+		scx200_gpio_set_high(WRAP_EXTRA_LED_GPIO);
+}
+
+static struct led_classdev wrap_error_led = {
+	.name		= "wrap:error",
+	.brightness_set	= wrap_error_led_set,
+};
+
+static struct led_classdev wrap_extra_led = {
+	.name           = "wrap:extra",
+	.brightness_set = wrap_extra_led_set,
+};
+
+#ifdef CONFIG_PM
+static int wrap_led_suspend(struct platform_device *dev,
+		pm_message_t state)
+{
+	led_classdev_suspend(&wrap_error_led);
+	led_classdev_suspend(&wrap_extra_led);
+	return 0;
+}
+
+static int wrap_led_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&wrap_error_led);
+	led_classdev_resume(&wrap_extra_led);
+	return 0;
+}
+#else
+#define wrap_led_suspend NULL
+#define wrap_led_resume NULL
+#endif
+
+static int wrap_led_probe(struct platform_device *pdev)
+{
+	led_classdev_register(&pdev->dev, &wrap_error_led);
+	return led_classdev_register(&pdev->dev, &wrap_extra_led);
+}
+
+static int wrap_led_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&wrap_error_led);
+	led_classdev_unregister(&wrap_extra_led);
+	return 0;
+}
+
+static struct platform_driver wrap_led_driver = {
+	.probe		= wrap_led_probe,
+	.remove		= wrap_led_remove,
+	.suspend	= wrap_led_suspend,
+	.resume		= wrap_led_resume,
+	.driver		= {
+		.name		= DRVNAME,
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init wrap_led_init(void)
+{
+	int ret;
+
+	if (!scx200_gpio_present()) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = platform_driver_register(&wrap_led_driver);
+	if (ret < 0)
+		goto out;
+
+	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		platform_driver_unregister(&wrap_led_driver);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static void __exit wrap_led_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&wrap_led_driver);
+}
+
+module_init(wrap_led_init);
+module_exit(wrap_led_exit);
+
+MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
+MODULE_DESCRIPTION("PCEngines WRAP LED driver");
+MODULE_LICENSE("GPL");
+
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/leds/Makefile linux-2.6.18/drivers/leds/Makefile
--- linux-2.6.18-vanilla/drivers/leds/Makefile	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/drivers/leds/Makefile	2006-11-03 16:15:44.000000000 -0500
@@ -13,6 +13,7 @@ obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 obj-$(CONFIG_LEDS_AMS_DELTA)		+= leds-ams-delta.o
 obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
+obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o

--------------090904010208010504070902--
