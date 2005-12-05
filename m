Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVLENLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVLENLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVLENLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:11:34 -0500
Received: from tim.rpsys.net ([194.106.48.114]:36535 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932408AbVLENLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:11:00 -0500
Subject: [RFC PATCH 6/8] LED: Add LED device support for LOCOMO devices
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:10:36 +0000
Message-Id: <1133788236.8101.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an LED driver for LEDs exported by the Sharp LOCOMO chip as found on
some models of Sharp Zaurus.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15-rc2/drivers/leds/locomo.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/locomo.c	2005-11-30 17:55:58.000000000 +0000
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
+void locomoled_brightness_set(struct led_device *led_dev, int value, int offset)
+{
+	struct locomo_dev *locomo_dev = LOCOMO_DEV(led_dev->class_dev->dev);
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
+void locomoled_brightness_set0(struct led_device *led_dev, int value)
+{
+	locomoled_brightness_set(led_dev, value, LOCOMO_LPT0);
+}
+
+void locomoled_brightness_set1(struct led_device *led_dev, int value)
+{
+	locomoled_brightness_set(led_dev, value, LOCOMO_LPT1);
+}
+
+static struct led_device locomo_led0 = {
+	.name			= "locomo:amber",
+	.brightness_set		= locomoled_brightness_set0,
+};
+
+static struct led_device locomo_led1 = {
+	.name			= "locomo:green",
+	.brightness_set		= locomoled_brightness_set1,
+};
+
+static int locomoled_probe(struct locomo_dev *ldev)
+{
+	int ret;
+
+	ret = leds_device_register(&ldev->dev, &locomo_led0);
+	if (ret < 0)
+		return ret;
+
+	ret = leds_device_register(&ldev->dev, &locomo_led1);
+	if (ret < 0)
+		leds_device_unregister(&locomo_led0);
+
+	return ret;
+}
+
+static int locomoled_remove(struct locomo_dev *dev)
+{
+	leds_device_unregister(&locomo_led0);
+	leds_device_unregister(&locomo_led1);
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
Index: linux-2.6.15-rc2/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15-rc2.orig/drivers/leds/Kconfig	2005-11-30 16:30:41.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/Kconfig	2005-11-30 17:07:00.000000000 +0000
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
Index: linux-2.6.15-rc2/drivers/leds/Makefile
===================================================================
--- linux-2.6.15-rc2.orig/drivers/leds/Makefile	2005-11-30 16:30:41.000000000 +0000
+++ linux-2.6.15-rc2/drivers/leds/Makefile	2005-11-30 17:07:00.000000000 +0000
@@ -6,6 +6,7 @@
 
 # LED Platform Drivers
 obj-$(CONFIG_LEDS_CORGI)		+= corgi.o
+obj-$(CONFIG_LEDS_LOCOMO)		+= locomo.o
 obj-$(CONFIG_LEDS_SPITZ)		+= spitz.o
 
 # LED Triggers


