Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269027AbUIBUkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269027AbUIBUkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269084AbUIBUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:40:00 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:33789 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269027AbUIBUip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:38:45 -0400
Date: Thu, 02 Sep 2004 20:38:28 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 2/2] leds: new class for led devices
In-reply-to: <1094157190l.4235l.2l@hydra>
To: linux-kernel@vger.kernel.org
Message-id: <1094157508l.4235l.4l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: multipart/mixed; boundary="Boundary_(ID_ronA8JKF9jFFX7TyCJCdYw)"
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CT 0, __CTYPE_HAS_BOUNDARY 0,
 __CTYPE_MULTIPART 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-8, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.2.1, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_ronA8JKF9jFFX7TyCJCdYw)
Content-type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-transfer-encoding: 7BIT
Content-disposition: inline

This is an example driver for the leds on the Sharp Zaurus using the  
locomo bus.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

--Boundary_(ID_ronA8JKF9jFFX7TyCJCdYw)
Content-type: text/x-patch; charset=us-ascii; name=locomo_led.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=locomo_led.patch


#
# Patch managed by http://www.holgerschurig.de/patcher.html
#

--- /dev/null
+++ linux/drivers/leds/locomo.c
@@ -0,0 +1,112 @@
+/*
+ * linux/drivers/leds/locomo.c
+ *
+ * Copyright (C) 2004 John Lenz <lenz@cs.wisc.edu>
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
+struct locomoled_data {
+	unsigned long		offset;
+	int			registered;
+	struct led_properties	props;
+};
+#define to_locomoled_data(d) container_of(d, struct locomoled_data, props)
+
+void locomoled_light(struct device *dev, struct led_properties *props)
+{
+	struct locomo_dev *locomo_dev = LOCOMO_DEV(dev);
+	struct locomoled_data *data = to_locomoled_data(props);
+	
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (props->light_state)
+		locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + data->offset);
+	else
+		locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + data->offset);
+	local_irq_restore(flags);
+}
+
+static struct locomoled_data leds[] = {
+	{
+		.offset	= LOCOMO_LPT0,
+		.props	= {
+			.owner		= THIS_MODULE,
+			.color		= "amber",
+			.light_state	= 0,
+	
+			.light		= locomoled_light,
+
+			.function	= leds_timer,
+		}
+	},
+	{
+		.offset	= LOCOMO_LPT1,
+		.props	= {
+			.owner		= THIS_MODULE,
+			.color		= "green",
+			.light_state	= 0,
+
+			.light		= locomoled_light,
+
+			.function	= leds_idle,
+		}
+	},
+};
+
+static int locomoled_probe(struct locomo_dev *dev)
+{
+	int i, ret = 0;
+	
+	for (i = 0; i < ARRAY_SIZE(leds); i++) {
+		ret = leds_device_register(&dev->dev, &leds[i].props);
+		leds[i].registered = 1;
+		if (unlikely(ret)) {
+			printk(KERN_WARNING "Unable to register locomo led %s\n", leds[i].props.color);
+			leds[i].registered = 0;
+		}
+	}
+	
+	return ret;
+}
+
+static int locomoled_remove(struct locomo_dev *dev) {
+	int i;
+	
+	for (i = 0; i < ARRAY_SIZE(leds); i++) {
+		if (leds[i].registered) {
+			leds_device_unregister(&leds[i].props);
+		}
+	}
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
--- linux/drivers/leds/Kconfig~locomo_led
+++ linux/drivers/leds/Kconfig
@@ -15,4 +15,11 @@
 	  This option enables support for the old leds_event interface used by
 	  the arm port.  This driver can not be compiled as a module.
 
+config LEDS_LOCOMO
+	tristate "LED Support for Locomo device"
+	depends CLASS_LEDS && SHARP_LOCOMO
+	help
+	  This option enables support for the LEDs on Sharp Locomo.
+
+
 endmenu
--- linux/drivers/leds/Makefile~locomo_led
+++ linux/drivers/leds/Makefile
@@ -1,3 +1,6 @@
 
 # Core functionality.
 obj-$(CONFIG_CLASS_LEDS)		+= ledscore.o
+
+# drivers
+obj-$(CONFIG_LEDS_LOCOMO)		+= locomo.o


--Boundary_(ID_ronA8JKF9jFFX7TyCJCdYw)--
