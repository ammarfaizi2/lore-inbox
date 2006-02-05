Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWBEPyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWBEPyt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBEPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:54:45 -0500
Received: from tim.rpsys.net ([194.106.48.114]:43438 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751777AbWBEPyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:54:20 -0500
Subject: [PATCH 7/12] LED: Add LED device support for LOCOMO devices
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:54:11 +0000
Message-Id: <1139154851.14624.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an LED driver for LEDs exported by the Sharp LOCOMO chip as found on
some models of Sharp Zaurus.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15.orig/drivers/leds/Kconfig	2006-01-29 16:04:22.000000000 +0000
+++ linux-2.6.15/drivers/leds/Kconfig	2006-01-29 16:04:23.000000000 +0000
@@ -29,6 +29,13 @@
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-C7x0 series (C700, C750, C760, C860).
 
+config LEDS_LOCOMO
+	tristate "LED Support for Locomo device"
+	depends LEDS_CLASS && SHARP_LOCOMO
+	help
+	  This option enables support for the LEDs on Sharp Locomo.
+	  Zaurus models SL-5500 and SL-5600.
+
 config LEDS_SPITZ
 	tristate "LED Support for the Sharp SL-Cxx00 series"
 	depends LEDS_CLASS && PXA_SHARP_Cxx00
Index: linux-2.6.15/drivers/leds/Makefile
===================================================================
--- linux-2.6.15.orig/drivers/leds/Makefile	2006-01-29 16:04:22.000000000 +0000
+++ linux-2.6.15/drivers/leds/Makefile	2006-01-29 16:04:23.000000000 +0000
@@ -6,6 +6,7 @@
 
 # LED Platform Drivers
 obj-$(CONFIG_LEDS_CORGI)		+= leds-corgi.o
+obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.o
 
 # LED Triggers
Index: linux-2.6.15/drivers/leds/leds-locomo.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/drivers/leds/leds-locomo.c	2006-01-29 16:09:46.000000000 +0000
@@ -0,0 +1,91 @@
+/*
+ * linux/drivers/leds/locomo.c
+ *
+ * Copyright (C) 2005 John Lenz <lenz@cs.wisc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+
+#include <asm/hardware.h>
+#include <asm/hardware/locomo.h>
+
+static void locomoled_brightness_set(struct led_classdev *led_cdev, enum led_brightness value, int offset)
+{
+	struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->class_dev->dev);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (value)
+		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
+	else
+		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
+	local_irq_restore(flags);
+}
+
+static void locomoled_brightness_set0(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT0);
+}
+
+static void locomoled_brightness_set1(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT1);
+}
+
+static struct led_classdev locomo_led0 = {
+	.name			= "locomo:amber",
+	.brightness_set		= locomoled_brightness_set0,
+};
+
+static struct led_classdev locomo_led1 = {
+	.name			= "locomo:green",
+	.brightness_set		= locomoled_brightness_set1,
+};
+
+static int locomoled_probe(struct locomo_dev *ldev)
+{
+	int ret;
+
+	ret = led_classdev_register(&ldev->dev, &locomo_led0);
+	if (ret < 0)
+		return ret;
+
+	ret = led_classdev_register(&ldev->dev, &locomo_led1);
+	if (ret < 0)
+		led_classdev_unregister(&locomo_led0);
+
+	return ret;
+}
+
+static int locomoled_remove(struct locomo_dev *dev)
+{
+	led_classdev_unregister(&locomo_led0);
+	led_classdev_unregister(&locomo_led1);
+	return 0;
+}
+
+static struct locomo_driver locomoled_driver = {
+	.drv = {
+		.name = "locomoled"
+	},
+	.devid	= LOCOMO_DEVID_LED,
+	.probe	= locomoled_probe,
+	.remove	= locomoled_remove,
+};
+
+static int __init locomoled_init(void) {
+	return locomo_driver_register(&locomoled_driver);
+}
+module_init(locomoled_init);
+
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
+MODULE_DESCRIPTION("Locomo LED driver");
+MODULE_LICENSE("GPL");


