Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWBEPyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWBEPyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWBEPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:54:40 -0500
Received: from tim.rpsys.net ([194.106.48.114]:45742 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751776AbWBEPyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:54:31 -0500
Subject: [PATCH 9/12] LED: Add device support for tosa
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: dirk@opfer-online.de, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:54:23 +0000
Message-Id: <1139154863.14624.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Opfer <dirk@opfer-online.de>

Adds LED drivers for LEDs found on the Sharp Zaurus c6000 model (tosa).

Signed-off-by: Dirk Opfer <dirk@opfer-online.de>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/leds/Kconfig
===================================================================
--- linux-2.6.15.orig/drivers/leds/Kconfig	2006-01-30 00:25:28.000000000 +0000
+++ linux-2.6.15/drivers/leds/Kconfig	2006-01-30 00:25:52.000000000 +0000
@@ -52,6 +52,13 @@
 	  particular board must have LEDs and they must be connected
 	  to the GPIO lines.  If unsure, say Y.
 
+config LEDS_TOSA
+	tristate "LED Support for the Sharp SL-6000 series"
+	depends LEDS_CLASS && PXA_SHARPSL
+	help
+	  This option enables support for the LEDs on Sharp Zaurus
+	  SL-6000 series.
+
 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
 	depends LEDS_TRIGGERS
Index: linux-2.6.15/drivers/leds/Makefile
===================================================================
--- linux-2.6.15.orig/drivers/leds/Makefile	2006-01-30 00:25:28.000000000 +0000
+++ linux-2.6.15/drivers/leds/Makefile	2006-01-30 00:26:48.000000000 +0000
@@ -9,6 +9,7 @@
 obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.o
 obj-$(CONFIG_LEDS_IXP4XX)		+= leds-ixp4xx-gpio.o
+obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
Index: linux-2.6.15/drivers/leds/leds-tosa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/drivers/leds/leds-tosa.c	2006-01-30 00:28:15.000000000 +0000
@@ -0,0 +1,123 @@
+/*
+ * LED Triggers Core
+ *
+ * Copyright 2005 Dirk Opfer
+ *
+ * Author: Dirk Opfer <Dirk@Opfer-Online.de>
+ *	based on spitz.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <asm/hardware/scoop.h>
+#include <asm/mach-types.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/tosa.h>
+
+static void tosaled_amber_set(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	if (value)
+		set_scoop_gpio(&tosascoop_jc_device.dev, TOSA_SCOOP_JC_CHRG_ERR_LED);
+	else
+		reset_scoop_gpio(&tosascoop_jc_device.dev, TOSA_SCOOP_JC_CHRG_ERR_LED);
+}
+
+static void tosaled_green_set(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	if (value)
+		set_scoop_gpio(&tosascoop_jc_device.dev, TOSA_SCOOP_JC_NOTE_LED);
+	else
+		reset_scoop_gpio(&tosascoop_jc_device.dev, TOSA_SCOOP_JC_NOTE_LED);
+}
+
+static struct led_classdev tosa_amber_led = {
+	.name			= "tosa:amber",
+	.default_trigger	= "sharpsl-charge",
+	.brightness_set		= tosaled_amber_set,
+};
+
+static struct led_classdev tosa_green_led = {
+	.name			= "tosa:green",
+	.default_trigger	= "nand-disk",
+	.brightness_set		= tosaled_green_set,
+};
+
+#ifdef CONFIG_PM
+static int tosaled_suspend(struct platform_device *dev, pm_message_t state)
+{
+#ifdef CONFIG_LEDS_TRIGGERS
+	if (tosa_amber_led.trigger && strcmp(tosa_amber_led.trigger->name, "sharpsl-charge"))
+#endif
+		led_classdev_suspend(&tosa_amber_led);
+	led_classdev_suspend(&tosa_green_led);
+	return 0;
+}
+
+static int tosaled_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&tosa_amber_led);
+	led_classdev_resume(&tosa_green_led);
+	return 0;
+}
+#endif
+
+static int tosaled_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = led_classdev_register(&pdev->dev, &tosa_amber_led);
+	if (ret < 0)
+		return ret;
+
+	ret = led_classdev_register(&pdev->dev, &tosa_green_led);
+	if (ret < 0)
+		led_classdev_unregister(&tosa_amber_led);
+
+	return ret;
+}
+
+static int tosaled_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&tosa_amber_led);
+	led_classdev_unregister(&tosa_green_led);
+
+	return 0;
+}
+
+static struct platform_driver tosaled_driver = {
+	.probe		= tosaled_probe,
+	.remove		= tosaled_remove,
+#ifdef CONFIG_PM
+	.suspend	= tosaled_suspend,
+	.resume		= tosaled_resume,
+#endif
+	.driver		= {
+		.name		= "tosa-led",
+	},
+};
+
+static int __devinit tosaled_init(void)
+{
+	return platform_driver_register(&tosaled_driver);
+}
+
+static void tosaled_exit(void)
+{
+ 	platform_driver_unregister(&tosaled_driver);
+}
+
+module_init(tosaled_init);
+module_exit(tosaled_exit);
+
+MODULE_AUTHOR("Dirk Opfer <Dirk@Opfer-Online.de>");
+MODULE_DESCRIPTION("Tosa LED driver");
+MODULE_LICENSE("GPL");
Index: linux-2.6.15/arch/arm/mach-pxa/tosa.c
===================================================================
--- linux-2.6.15.orig/arch/arm/mach-pxa/tosa.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/arch/arm/mach-pxa/tosa.c	2006-01-30 00:29:25.000000000 +0000
@@ -252,10 +252,19 @@
 	.id		= -1,
 };
 
+/*
+ * Tosa LEDs
+ */
+static struct platform_device tosaled_device = {
+    .name   = "tosa-led",
+    .id     = -1,
+};
+		  
 static struct platform_device *devices[] __initdata = {
 	&tosascoop_device,
 	&tosascoop_jc_device,
 	&tosakbd_device,
+	&tosaled_device,
 };
 
 static void __init tosa_init(void)


