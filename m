Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWC2ARK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWC2ARK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWC2ARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:17:10 -0500
Received: from tim.rpsys.net ([194.106.48.114]:8636 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932215AbWC2ARI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:17:08 -0500
Subject: [PATCH -mm 0/4] LED Updates
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:16:55 +0100
Message-Id: <1143591415.14682.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches update the LED subsystem to fix a few issues:

A potential irq deadlock issue in led_trigger_event is resolved by only
writing to leddev_list_lock with irqs held (it can be read without) and
removing led_cdev->lock entirely. The led_cdev lock is no longer
required as other locks now provide all the protection needed.

The IDE trigger has been reworked to reduce its impact on IDE
performance. This currently adds the overhead of a mod_timer call for
the first IDE transaction in a given activity period but this could also
be avoided if need by at the expense of the timer continually running
although I'd prefer to avoid that.

The ensure-ide-taskfile-calls-any-driver-specific patch in -mm is not
needed after these IDE trigger changes (although it might be a valid
piece of cleanup).

Also add some missing externs.

I've included the flattened differences below for transparency and easy
of evaluation of the changes. Following this email are replacement
patches for those currently in -mm that have changed.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

diff -urN old-led/drivers/ide/ide-disk.c new-led/drivers/ide/ide-disk.c
--- old-led/drivers/ide/ide-disk.c	2006-03-23 22:02:44.000000000 +0000
+++ new-led/drivers/ide/ide-disk.c	2006-03-29 00:30:27.000000000 +0100
@@ -81,8 +81,6 @@
 
 static DECLARE_MUTEX(idedisk_ref_sem);
 
-DEFINE_LED_TRIGGER(ide_led_trigger);
-
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
 
 #define ide_disk_g(disk) \
@@ -301,13 +299,6 @@
 	}
 }
 
-static int ide_end_rw_disk(ide_drive_t *drive, int uptodate, int nr_sectors)
-{
-	if (blk_fs_request(HWGROUP(drive)->rq))
-		led_trigger_event(ide_led_trigger, LED_OFF);
-	return ide_end_request(drive, uptodate, nr_sectors);
-}
-
 /*
  * 268435455  == 137439 MB or 28bit limit
  * 320173056  == 163929 MB or 48bit addressing
@@ -322,11 +313,11 @@
 
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "ide_do_rw_disk - bad command");
-		ide_end_rw_disk(drive, 0, 0);
+		ide_end_request(drive, 0, 0);
 		return ide_stopped;
 	}
 
-	led_trigger_event(ide_led_trigger, LED_FULL);
+	ledtrig_ide_activity();
 
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
@@ -1075,7 +1066,7 @@
 	.media			= ide_disk,
 	.supports_dsc_overlap	= 0,
 	.do_request		= ide_do_rw_disk,
-	.end_request		= ide_end_rw_disk,
+	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
@@ -1248,16 +1239,12 @@
 
 static void __exit idedisk_exit (void)
 {
-	led_trigger_unregister_simple(ide_led_trigger);
 	driver_unregister(&idedisk_driver.gen_driver);
 }
 
 static int __init idedisk_init(void)
 {
-	int ret = driver_register(&idedisk_driver.gen_driver);
-	if (ret >= 0)
-		led_trigger_register_simple("ide-disk", &ide_led_trigger);
-	return ret;
+	return driver_register(&idedisk_driver.gen_driver);
 }
 
 MODULE_ALIAS("ide:*m-disk*");
diff -urN old-led/drivers/leds/Kconfig new-led/drivers/leds/Kconfig
--- old-led/drivers/leds/Kconfig	2006-03-23 22:02:43.000000000 +0000
+++ new-led/drivers/leds/Kconfig	2006-03-29 00:30:27.000000000 +0100
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
 
diff -urN old-led/drivers/leds/Makefile new-led/drivers/leds/Makefile
--- old-led/drivers/leds/Makefile	2006-03-23 22:02:43.000000000 +0000
+++ new-led/drivers/leds/Makefile	2006-03-29 00:38:47.000000000 +0100
@@ -13,3 +13,4 @@
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
+obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o
diff -urN old-led/drivers/leds/led-class.c new-led/drivers/leds/led-class.c
--- old-led/drivers/leds/led-class.c	2006-03-23 22:02:41.000000000 +0000
+++ new-led/drivers/leds/led-class.c	2006-03-29 00:30:27.000000000 +0100
@@ -46,9 +46,7 @@
 
 	if (after - buf > 0) {
 		ret = after - buf;
-		write_lock(&led_cdev->lock);
 		led_set_brightness(led_cdev, state);
-		write_unlock(&led_cdev->lock);
 	}
 
 	return ret;
@@ -66,10 +64,8 @@
  */
 void led_classdev_suspend(struct led_classdev *led_cdev)
 {
-	write_lock(&led_cdev->lock);
 	led_cdev->flags |= LED_SUSPENDED;
 	led_cdev->brightness_set(led_cdev, 0);
-	write_unlock(&led_cdev->lock);
 }
 EXPORT_SYMBOL_GPL(led_classdev_suspend);
 
@@ -79,10 +75,8 @@
  */
 void led_classdev_resume(struct led_classdev *led_cdev)
 {
-	write_lock(&led_cdev->lock);
-	led_cdev->flags &= ~LED_SUSPENDED;
 	led_cdev->brightness_set(led_cdev, led_cdev->brightness);
-	write_unlock(&led_cdev->lock);
+	led_cdev->flags &= ~LED_SUSPENDED;
 }
 EXPORT_SYMBOL_GPL(led_classdev_resume);
 
@@ -98,7 +92,6 @@
 	if (unlikely(IS_ERR(led_cdev->class_dev)))
 		return PTR_ERR(led_cdev->class_dev);
 
-	rwlock_init(&led_cdev->lock);
 	class_set_devdata(led_cdev->class_dev, led_cdev);
 
 	/* register the attributes */
diff -urN old-led/drivers/leds/led-triggers.c new-led/drivers/leds/led-triggers.c
--- old-led/drivers/leds/led-triggers.c	2006-03-23 22:02:41.000000000 +0000
+++ new-led/drivers/leds/led-triggers.c	2006-03-29 00:30:27.000000000 +0100
@@ -24,7 +24,7 @@
 #include "leds.h"
 
 /*
- * Nests outside led_cdev->lock and led_cdev->trigger_lock
+ * Nests outside led_cdev->trigger_lock
  */
 static rwlock_t triggers_list_lock = RW_LOCK_UNLOCKED;
 static LIST_HEAD(trigger_list);
@@ -109,9 +109,7 @@
 		struct led_classdev *led_cdev;
 
 		led_cdev = list_entry(entry, struct led_classdev, trig_list);
-		write_lock(&led_cdev->lock);
 		led_set_brightness(led_cdev, brightness);
-		write_unlock(&led_cdev->lock);
 	}
 	read_unlock(&trigger->leddev_list_lock);
 }
@@ -119,18 +117,20 @@
 /* Caller must ensure led_cdev->trigger_lock held */
 void led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trigger)
 {
+	unsigned long flags;
+
 	/* Remove any existing trigger */
 	if (led_cdev->trigger) {
-		write_lock(&led_cdev->trigger->leddev_list_lock);
+		write_lock_irqsave(&led_cdev->trigger->leddev_list_lock, flags);
 		list_del(&led_cdev->trig_list);
-		write_unlock(&led_cdev->trigger->leddev_list_lock);
+		write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock, flags);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
 	}
 	if (trigger) {
-		write_lock(&trigger->leddev_list_lock);
+		write_lock_irqsave(&trigger->leddev_list_lock, flags);
 		list_add_tail(&led_cdev->trig_list, &trigger->led_cdevs);
-		write_unlock(&trigger->leddev_list_lock);
+		write_unlock_irqrestore(&trigger->leddev_list_lock, flags);
 		if (trigger->activate)
 			trigger->activate(led_cdev);
 	}
diff -urN old-led/drivers/leds/leds.h new-led/drivers/leds/leds.h
--- old-led/drivers/leds/leds.h	2006-03-23 22:02:41.000000000 +0000
+++ new-led/drivers/leds/leds.h	2006-03-29 00:30:27.000000000 +0100
@@ -15,7 +15,6 @@
 
 #include <linux/leds.h>
 
-/* led_cdev->lock must be held as write */
 static inline void led_set_brightness(struct led_classdev *led_cdev,
 					enum led_brightness value)
 {
diff -urN old-led/drivers/leds/ledtrig-ide-disk.c new-led/drivers/leds/ledtrig-ide-disk.c
--- old-led/drivers/leds/ledtrig-ide-disk.c	1970-01-01 01:00:00.000000000 +0100
+++ new-led/drivers/leds/ledtrig-ide-disk.c	2006-03-29 00:30:27.000000000 +0100
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
diff -urN old-led/drivers/leds/ledtrig-timer.c new-led/drivers/leds/ledtrig-timer.c
--- old-led/drivers/leds/ledtrig-timer.c	2006-03-23 22:02:41.000000000 +0000
+++ new-led/drivers/leds/ledtrig-timer.c	2006-03-29 00:30:27.000000000 +0100
@@ -37,9 +37,7 @@
 	unsigned long delay = timer_data->delay_off;
 
 	if (!timer_data->delay_on || !timer_data->delay_off) {
-		write_lock(&led_cdev->lock);
 		led_set_brightness(led_cdev, LED_OFF);
-		write_unlock(&led_cdev->lock);
 		return;
 	}
 
@@ -48,9 +46,7 @@
 		delay = timer_data->delay_on;
 	}
 
-	write_lock(&led_cdev->lock);
 	led_set_brightness(led_cdev, brightness);
-	write_unlock(&led_cdev->lock);
 
 	mod_timer(&timer_data->timer, jiffies + msecs_to_jiffies(delay));
 }
diff -urN old-led/include/linux/leds.h new-led/include/linux/leds.h
--- old-led/include/linux/leds.h	2006-03-23 22:02:41.000000000 +0000
+++ new-led/include/linux/leds.h	2006-03-29 01:11:15.000000000 +0100
@@ -38,9 +38,6 @@
 	/* LED Device linked list */
 	struct list_head node;
 
-	/* Protects the LED properties data above */
-	rwlock_t lock;
-
 	/* Trigger data */
 	char *default_trigger;
 #ifdef CONFIG_LEDS_TRIGGERS
@@ -81,16 +78,17 @@
 };
 
 /* Registration functions for complex triggers */
-int led_trigger_register(struct led_trigger *trigger);
-void led_trigger_unregister(struct led_trigger *trigger);
+extern int led_trigger_register(struct led_trigger *trigger);
+extern void led_trigger_unregister(struct led_trigger *trigger);
 
 /* Registration functions for simple triggers */
 #define DEFINE_LED_TRIGGER(x)		static struct led_trigger *x;
 #define DEFINE_LED_TRIGGER_GLOBAL(x)	struct led_trigger *x;
-void led_trigger_register_simple(const char *name,
+extern void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
-void led_trigger_unregister_simple(struct led_trigger *trigger);
-void led_trigger_event(struct led_trigger *trigger, enum led_brightness event);
+extern void led_trigger_unregister_simple(struct led_trigger *trigger);
+extern void led_trigger_event(struct led_trigger *trigger,
+				enum led_brightness event);
 
 #else
 
@@ -102,4 +100,12 @@
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


