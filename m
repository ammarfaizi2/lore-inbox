Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVBBDMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVBBDMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVBBDHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:07:53 -0500
Received: from [211.58.254.17] ([211.58.254.17]:63114 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262255AbVBBDFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:05:06 -0500
Date: Wed, 2 Feb 2005 12:05:00 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 20/29] ide: task_end_request() fix
Message-ID: <20050202030500.GE1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 20_ide_task_end_request_fix.patch
> 
> 	task_end_request() modified and made global.  ide_dma_intr()
> 	modified to use task_end_request().  These changes enable
> 	TASKFILE ioctls to get valid register outputs on successful
> 	completion.  No in-kernel usage should be affected.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-dma.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-dma.c	2005-02-02 10:28:05.642130143 +0900
+++ linux-ide-export/drivers/ide/ide-dma.c	2005-02-02 10:28:06.035066389 +0900
@@ -175,8 +175,7 @@ ide_startstop_t ide_dma_intr (ide_drive_
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-
-			DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
+			task_end_request(drive, rq, stat);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.851096238 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:06.035066389 +0900
@@ -366,18 +366,13 @@ static ide_startstop_t task_error(ide_dr
 	return ide_error(drive, s, stat);
 }
 
-static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *task = rq->special;
-
-		if (task->tf_out_flags.all) {
-			u8 err = drive->hwif->INB(IDE_ERROR_REG);
-			ide_end_drive_cmd(drive, stat, err);
-			return;
-		}
-	}
-	drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		u8 err = drive->hwif->INB(IDE_ERROR_REG);
+		ide_end_drive_cmd(drive, stat, err);
+	} else
+		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
 }
 
 /*
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:28:04.467320756 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:06.036066227 +0900
@@ -1318,6 +1318,7 @@ extern ide_startstop_t do_rw_taskfile(id
  */
 extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
 
+extern void task_end_request(ide_drive_t *, struct request *, u8);
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
