Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWC2ARy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWC2ARy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWC2ARy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:17:54 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14524 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932494AbWC2ARd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:17:33 -0500
Subject: [PATCH -mm 4/4] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:17:25 +0100
Message-Id: <1143591445.14682.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for IDE disk activity to the ide-disk driver.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.16/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.16.orig/drivers/ide/ide-disk.c	2006-03-28 17:22:51.000000000 +0100
+++ linux-2.6.16/drivers/ide/ide-disk.c	2006-03-28 17:25:12.000000000 +0100
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 
 #define _IDE_DISK
 
@@ -316,6 +317,8 @@
 		return ide_stopped;
 	}
 
+	ledtrig_ide_activity();
+
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
 		 (unsigned long long)block, rq->nr_sectors,
Index: linux-2.6.16/drivers/leds/ledtrig-ide-disk.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/drivers/leds/ledtrig-ide-disk.c	2006-03-28 17:36:43.000000000 +0100
@@ -0,0 +1,62 @@
+/*
+ * LED IDE-Disk Activity Trigger
+ *
+ * Copyright 2006 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
+
+static void ledtrig_ide_timerfunc(unsigned long data);
+
+DEFINE_LED_TRIGGER(ledtrig_ide);
+static DEFINE_TIMER(ledtrig_ide_timer, ledtrig_ide_timerfunc, 0, 0);
+static int ide_activity;
+static int ide_lastactivity;
+
+void ledtrig_ide_activity(void)
+{
+	ide_activity++;
+	if (!timer_pending(&ledtrig_ide_timer))
+		mod_timer(&ledtrig_ide_timer, jiffies + msecs_to_jiffies(10));
+}
+EXPORT_SYMBOL(ledtrig_ide_activity);
+
+static void ledtrig_ide_timerfunc(unsigned long data)
+{
+	if (ide_lastactivity != ide_activity) {
+		ide_lastactivity = ide_activity;
+		led_trigger_event(ledtrig_ide, LED_FULL);
+	    	mod_timer(&ledtrig_ide_timer, jiffies + msecs_to_jiffies(10));
+	} else {
+		led_trigger_event(ledtrig_ide, LED_OFF);
+	}
+}
+
+static int __init ledtrig_ide_init(void)
+{
+	led_trigger_register_simple("ide-disk", &ledtrig_ide);
+	return 0;
+}
+
+static void __exit ledtrig_ide_exit(void)
+{
+	led_trigger_unregister_simple(ledtrig_ide);
+}
+
+module_init(ledtrig_ide_init);
+module_exit(ledtrig_ide_exit);
+
+MODULE_AUTHOR("Richard Purdie <rpurdie@openedhand.com>");
+MODULE_DESCRIPTION("LED IDE Disk Activity Trigger");
+MODULE_LICENSE("GPL");
Index: linux-2.6.16/include/linux/leds.h
===================================================================
--- linux-2.6.16.orig/include/linux/leds.h	2006-03-28 17:25:12.000000000 +0100
+++ linux-2.6.16/include/linux/leds.h	2006-03-28 17:25:12.000000000 +0100
@@ -98,4 +98,12 @@
 #define led_trigger_event(x, y) do {} while(0)
 
 #endif
+
+/* Trigger specific functions */
+#ifdef CONFIG_LEDS_TRIGGER_IDE_DISK
+extern void ledtrig_ide_activity(void);
+#else
+#define ledtrig_ide_activity() do {} while(0)
+#endif
+
 #endif		/* __LINUX_LEDS_H_INCLUDED */
Index: linux-2.6.16/drivers/leds/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/leds/Kconfig	2006-03-28 17:25:12.000000000 +0100
+++ linux-2.6.16/drivers/leds/Kconfig	2006-03-28 17:25:12.000000000 +0100
@@ -66,5 +66,12 @@
 	  This allows LEDs to be controlled by a programmable timer
 	  via sysfs. If unsure, say Y.
 
+config LEDS_TRIGGER_IDE_DISK
+	bool "LED Timer Trigger"
+	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
+	help
+	  This allows LEDs to be controlled by IDE disk activity.
+	  If unsure, say Y.
+
 endmenu
 
Index: linux-2.6.16/drivers/leds/Makefile
===================================================================
--- linux-2.6.16.orig/drivers/leds/Makefile	2006-03-28 17:25:12.000000000 +0100
+++ linux-2.6.16/drivers/leds/Makefile	2006-03-28 17:28:18.000000000 +0100
@@ -13,3 +13,4 @@
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
+obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o



