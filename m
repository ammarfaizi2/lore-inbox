Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVBBDz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVBBDz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBDEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:04:08 -0500
Received: from [211.58.254.17] ([211.58.254.17]:20106 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262236AbVBBCyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:54:52 -0500
Date: Wed, 2 Feb 2005 11:54:48 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Message-ID: <20050202025448.GL621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 11_ide_drive_sleeping_fix.patch
> 
> 	ide_drive_t.sleeping field added.  0 in sleep field used to
> 	indicate inactive sleeping but because 0 is a valid jiffy
> 	value, though slim, there's a chance that something can go
> 	weird.  And while at it, explicit jiffy comparisons are
> 	converted to use time_{after|before} macros.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:03.340503581 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:04.260354336 +0900
@@ -933,6 +933,7 @@ void ide_stall_queue (ide_drive_t *drive
 	if (timeout > WAIT_WORSTCASE)
 		timeout = WAIT_WORSTCASE;
 	drive->sleep = timeout + jiffies;
+	drive->sleeping = 1;
 }
 
 EXPORT_SYMBOL(ide_stall_queue);
@@ -972,18 +973,18 @@ repeat:	
 	}
 
 	do {
-		if ((!drive->sleep || time_after_eq(jiffies, drive->sleep))
+		if ((!drive->sleeping || time_after_eq(jiffies, drive->sleep))
 		    && !elv_queue_empty(drive->queue)) {
 			if (!best
-			 || (drive->sleep && (!best->sleep || 0 < (signed long)(best->sleep - drive->sleep)))
-			 || (!best->sleep && 0 < (signed long)(WAKEUP(best) - WAKEUP(drive))))
+			 || (drive->sleeping && (!best->sleeping || time_before(drive->sleep, best->sleep)))
+			 || (!best->sleeping && time_before(WAKEUP(drive), WAKEUP(best))))
 			{
 				if (!blk_queue_plugged(drive->queue))
 					best = drive;
 			}
 		}
 	} while ((drive = drive->next) != hwgroup->drive);
-	if (best && best->nice1 && !best->sleep && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
+	if (best && best->nice1 && !best->sleeping && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
 		long t = (signed long)(WAKEUP(best) - jiffies);
 		if (t >= WAIT_MIN_SLEEP) {
 		/*
@@ -992,10 +993,9 @@ repeat:	
 		 */
 			drive = best->next;
 			do {
-				if (!drive->sleep
-				/* FIXME: use time_before */
-				 && 0 < (signed long)(WAKEUP(drive) - (jiffies - best->service_time))
-				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive)))
+				if (!drive->sleeping
+				 && time_before(jiffies - best->service_time, WAKEUP(drive))
+				 && time_before(WAKEUP(drive), jiffies + t))
 				{
 					ide_stall_queue(best, min_t(long, t, 10 * WAIT_MIN_SLEEP));
 					goto repeat;
@@ -1058,14 +1058,17 @@ static void ide_do_request (ide_hwgroup_
 		hwgroup->busy = 1;
 		drive = choose_drive(hwgroup);
 		if (drive == NULL) {
-			unsigned long sleep = 0;
+			int sleeping = 0;
+			unsigned long sleep = 0; /* shut up, gcc */
 			hwgroup->rq = NULL;
 			drive = hwgroup->drive;
 			do {
-				if (drive->sleep && (!sleep || 0 < (signed long)(sleep - drive->sleep)))
+				if (drive->sleeping && (!sleeping || time_before(drive->sleep, sleep))) {
+					sleeping = 1;
 					sleep = drive->sleep;
+				}
 			} while ((drive = drive->next) != hwgroup->drive);
-			if (sleep) {
+			if (sleeping) {
 		/*
 		 * Take a short snooze, and then wake up this hwgroup again.
 		 * This gives other hwgroups on the same a chance to
@@ -1105,7 +1108,7 @@ static void ide_do_request (ide_hwgroup_
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
-		drive->sleep = 0;
+		drive->sleeping = 0;
 		drive->service_start = jiffies;
 
 		if (blk_queue_plugged(drive->queue)) {
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:27:15.687234943 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:04.261354174 +0900
@@ -721,6 +721,7 @@ typedef struct ide_drive_s {
 					 *  3=64-bit
 					 */
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
+	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
