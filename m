Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVLENLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVLENLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVLENLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:11:31 -0500
Received: from tim.rpsys.net ([194.106.48.114]:38071 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932410AbVLENLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:11:04 -0500
Subject: [RFC PATCH 7/8] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:10:48 +0000
Message-Id: <1133788248.8101.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for IDE disk activity to the IDE subsystem.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15-rc2/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.15-rc2.orig/drivers/ide/ide-disk.c	2005-11-28 12:31:02.000000000 +0000
+++ linux-2.6.15-rc2/drivers/ide/ide-disk.c	2005-11-28 15:55:36.000000000 +0000
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 
 #define _IDE_DISK
 
@@ -78,6 +79,8 @@
 	struct kref	kref;
 };
 
+INIT_LED_TRIGGER_GLOBAL(ide_led_trigger);
+
 static DECLARE_MUTEX(idedisk_ref_sem);
 
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
@@ -315,6 +318,8 @@
 		return ide_stopped;
 	}
 
+	led_trigger_event(ide_led_trigger, 100);
+
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
 		 block, rq->nr_sectors, (unsigned long)rq->buffer);
@@ -1259,11 +1264,13 @@
 
 static void __exit idedisk_exit (void)
 {
+	led_trigger_unregister_simple(ide_led_trigger);
 	driver_unregister(&idedisk_driver.gen_driver);
 }
 
 static int __init idedisk_init(void)
 {
+	led_trigger_register_simple("ide-disk", &ide_led_trigger);
 	return driver_register(&idedisk_driver.gen_driver);
 }
 
Index: linux-2.6.15-rc2/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.15-rc2.orig/drivers/ide/ide-io.c	2005-11-20 03:25:03.000000000 +0000
+++ linux-2.6.15-rc2/drivers/ide/ide-io.c	2005-11-28 12:31:04.000000000 +0000
@@ -48,6 +48,7 @@
 #include <linux/device.h>
 #include <linux/kmod.h>
 #include <linux/scatterlist.h>
+#include <linux/leds.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -107,6 +108,8 @@
  *	it was tagged may be out of order.
  */
 
+extern struct led_trigger *ide_led_trigger;
+
 int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
 {
 	struct request *rq;
@@ -125,6 +128,9 @@
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
+
+	led_trigger_event(ide_led_trigger, 0);
+
 	return ret;
 }
 EXPORT_SYMBOL(ide_end_request);


