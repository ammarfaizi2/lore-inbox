Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVBJIjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVBJIjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVBJIjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:39:08 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:54483 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262054AbVBJIiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=S67vttCC1oz4wNURLoJZapmlczd9hcRbXdPLTwWiwKDye0zzxa2soTiQJ790mbA/YkVtIHlD78nPbnrGNOnbX7SNrtYZK4bOAXpfzR92p8frlyG6IktSgbLnZAWx6uarFkid8AgDcjeIRPpM2hSzFiuziHlG+/OLWqQEk8oZyds=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083809.63BF53E6@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:14 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01_ide_task_end_request_fix.patch

	task_end_request() modified to always call ide_end_drive_cmd()
	for taskfile requests.  Previously, ide_end_drive_cmd() was
	called only when task->tf_out_flags.all was set.  Also,
	ide_dma_intr() is modified to use task_end_request().

	* fixes taskfile ioctl oops bug which was caused by referencing
	  NULL rq->rq_disk of taskfile requests.
	* enables TASKFILE ioctls to get valid register outputs on
	  successful completion.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-dma.c      |    5 +----
 drivers/ide/ide-taskfile.c |   12 ++++--------
 include/linux/ide.h        |    1 +
 3 files changed, 6 insertions(+), 12 deletions(-)

Index: linux-ide/drivers/ide/ide-dma.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-dma.c	2005-02-10 17:31:48.917654643 +0900
+++ linux-ide/drivers/ide/ide-dma.c	2005-02-10 17:38:00.033092056 +0900
@@ -175,10 +175,7 @@ ide_startstop_t ide_dma_intr (ide_drive_
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-			ide_driver_t *drv;
-
-			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
-			drv->end_request(drive, 1, rq->nr_sectors);
+			task_end_request(drive, rq, stat);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:31:48.917654643 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.042090547 +0900
@@ -364,18 +364,14 @@ static ide_startstop_t task_error(ide_dr
 	return ide_error(drive, s, stat);
 }
 
-static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
 	ide_driver_t *drv;
 
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *task = rq->special;
-
-		if (task->tf_out_flags.all) {
-			u8 err = drive->hwif->INB(IDE_ERROR_REG);
-			ide_end_drive_cmd(drive, stat, err);
-			return;
-		}
+		u8 err = drive->hwif->INB(IDE_ERROR_REG);
+		ide_end_drive_cmd(drive, stat, err);
+		return;
 	}
 
 	drv = *(ide_driver_t **)rq->rq_disk->private_data;
Index: linux-ide/include/linux/ide.h
===================================================================
--- linux-ide.orig/include/linux/ide.h	2005-02-10 17:31:48.917654643 +0900
+++ linux-ide/include/linux/ide.h	2005-02-10 17:38:00.044090212 +0900
@@ -1290,6 +1290,7 @@ extern ide_startstop_t do_rw_taskfile(id
  */
 extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
 
+void task_end_request(ide_drive_t *, struct request *, u8);
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
