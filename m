Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWBEP4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWBEP4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBEPz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:55:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:46493 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751773AbWBEPzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:55:04 -0500
Subject: [PATCH 11/12] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:54:53 +0000
Message-Id: <1139154893.14624.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for IDE disk activity to the ide-disk driver.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-disk.c	2006-02-04 13:35:37.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-disk.c	2006-02-04 15:17:18.000000000 +0000
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 
 #define _IDE_DISK
 
@@ -80,6 +81,8 @@
 
 static DECLARE_MUTEX(idedisk_ref_sem);
 
+INIT_LED_TRIGGER(ide_led_trigger);
+
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
 
 #define ide_disk_g(disk) \
@@ -311,10 +314,12 @@
 
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "ide_do_rw_disk - bad command");
-		ide_end_request(drive, 0, 0);
+		ide_end_rw_disk(drive, 0, 0);
 		return ide_stopped;
 	}
 
+	led_trigger_event(ide_led_trigger, LED_FULL);
+
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
 		 block, rq->nr_sectors, (unsigned long)rq->buffer);
@@ -325,6 +330,12 @@
 	return __ide_do_rw_disk(drive, rq, block);
 }
 
+static int ide_end_rw_disk(ide_drive_t *drive, int uptodate, int nr_sectors)
+{
+	led_trigger_event(ide_led_trigger, LED_OFF);
+	ide_end_request(drive, uptodate, nr_sectors);
+}
+
 /*
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
@@ -1097,7 +1108,7 @@
 	.media			= ide_disk,
 	.supports_dsc_overlap	= 0,
 	.do_request		= ide_do_rw_disk,
-	.end_request		= ide_end_request,
+	.end_request		= ide_end_rw_disk,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
@@ -1259,11 +1270,13 @@
 
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
 


