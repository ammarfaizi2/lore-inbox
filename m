Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWAaNof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWAaNof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWAaNmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:42:08 -0500
Received: from tim.rpsys.net ([194.106.48.114]:4499 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750830AbWAaNmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:42:04 -0500
Subject: [PATCH 10/11] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 13:41:58 +0000
Message-Id: <1138714918.6869.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for IDE disk activity to the IDE subsystem.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-disk.c	2006-01-29 14:43:00.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-disk.c	2006-01-29 15:22:48.000000000 +0000
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 
 #define _IDE_DISK
 
@@ -297,6 +298,8 @@
 	}
 }
 
+extern struct led_trigger *ide_led_trigger;
+
 /*
  * 268435455  == 137439 MB or 28bit limit
  * 320173056  == 163929 MB or 48bit addressing
@@ -315,6 +318,8 @@
 		return ide_stopped;
 	}
 
+	led_trigger_event(ide_led_trigger, LED_FULL);
+
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
 		 block, rq->nr_sectors, (unsigned long)rq->buffer);
Index: linux-2.6.15/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-io.c	2006-01-29 14:37:20.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-io.c	2006-01-29 15:28:00.000000000 +0000
@@ -48,6 +48,7 @@
 #include <linux/device.h>
 #include <linux/kmod.h>
 #include <linux/scatterlist.h>
+#include <linux/leds.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -93,6 +94,8 @@
 }
 EXPORT_SYMBOL(__ide_end_request);
 
+extern struct led_trigger *ide_led_trigger;
+
 /**
  *	ide_end_request		-	complete an IDE I/O
  *	@drive: IDE device for the I/O
@@ -123,6 +126,9 @@
 	ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
+
+	led_trigger_event(ide_led_trigger, LED_OFF);
+
 	return ret;
 }
 EXPORT_SYMBOL(ide_end_request);
Index: linux-2.6.15/drivers/ide/ide.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide.c	2006-01-29 14:43:00.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide.c	2006-01-29 15:23:59.000000000 +0000
@@ -154,6 +154,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/bitops.h>
+#include <linux/leds.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1990,6 +1991,8 @@
 
 EXPORT_SYMBOL_GPL(ide_bus_type);
 
+INIT_LED_TRIGGER_GLOBAL(ide_led_trigger);
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
@@ -2036,6 +2039,8 @@
 #ifdef CONFIG_PROC_FS
 	proc_ide_create();
 #endif
+	led_trigger_register_simple("ide-disk", &ide_led_trigger);
+
 	return 0;
 }
 
@@ -2068,6 +2073,8 @@
 {
 	int index;
 
+	led_trigger_unregister_simple(ide_led_trigger);
+
 	for (index = 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
 


