Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267349AbUBSPMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUBSPDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:03:49 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267298AbUBSOzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:39 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (8/9)
Date: Thu, 19 Feb 2004 15:59:55 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191559.55278.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove unused ide_end_taskfile()

Additionally ide_end_drive_cmd() contains all functionality of this function.

 linux-2.6.3-root/drivers/ide/ide-disk.c     |    7 ---
 linux-2.6.3-root/drivers/ide/ide-io.c       |    2 
 linux-2.6.3-root/drivers/ide/ide-taskfile.c |   60 ----------------------------
 linux-2.6.3-root/include/linux/ide.h        |    3 -
 4 files changed, 72 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_end_taskfile drivers/ide/ide-disk.c
--- linux-2.6.3/drivers/ide/ide-disk.c~ide_end_taskfile	2004-02-19 02:12:33.246160184 +0100
+++ linux-2.6.3-root/drivers/ide/ide-disk.c	2004-02-19 02:12:33.265157296 +0100
@@ -834,13 +834,6 @@ ide_startstop_t idedisk_error (ide_drive
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
 	}
-#if 0
-	else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		rq->errors = 1;
-		ide_end_taskfile(drive, stat, err);
-		return ide_stopped;
-	}
-#endif
 #ifdef CONFIG_IDE_TASKFILE_IO
 	/* make rq completion pointers new submission pointers */
 	blk_rq_prep_restart(rq);
diff -puN drivers/ide/ide-io.c~ide_end_taskfile drivers/ide/ide-io.c
--- linux-2.6.3/drivers/ide/ide-io.c~ide_end_taskfile	2004-02-19 02:12:33.250159576 +0100
+++ linux-2.6.3-root/drivers/ide/ide-io.c	2004-02-19 02:12:33.267156992 +0100
@@ -300,7 +300,6 @@ ide_startstop_t ide_error (ide_drive_t *
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
-//		ide_end_taskfile(drive, stat, err);
 		return ide_stopped;
 	}
 
@@ -387,7 +386,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
-//		ide_end_taskfile(drive, BUSY_STAT, 0);
 		return ide_stopped;
 	}
 
diff -puN drivers/ide/ide-taskfile.c~ide_end_taskfile drivers/ide/ide-taskfile.c
--- linux-2.6.3/drivers/ide/ide-taskfile.c~ide_end_taskfile	2004-02-19 02:12:33.254158968 +0100
+++ linux-2.6.3-root/drivers/ide/ide-taskfile.c	2004-02-19 02:12:33.269156688 +0100
@@ -219,66 +219,6 @@ ide_startstop_t do_rw_taskfile (ide_driv
 EXPORT_SYMBOL(do_rw_taskfile);
 
 /*
- * Clean up after success/failure of an explicit taskfile operation.
- */
-void ide_end_taskfile (ide_drive_t *drive, u8 stat, u8 err)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	struct request *rq;
-	ide_task_t *args;
-	task_ioreg_t command;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	args = (ide_task_t *) rq->special;
-
-	command = args->tfRegister[IDE_COMMAND_OFFSET];
-
-	if (rq->errors == 0)
-		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-	if (args->tf_in_flags.b.data) {
-		u16 data = hwif->INW(IDE_DATA_REG);
-		args->tfRegister[IDE_DATA_OFFSET] = (data) & 0xFF;
-		args->hobRegister[IDE_DATA_OFFSET_HOB]	= (data >> 8) & 0xFF;
-	}
-	args->tfRegister[IDE_ERROR_OFFSET]   = err;
-	args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
-	args->tfRegister[IDE_SECTOR_OFFSET]  = hwif->INB(IDE_SECTOR_REG);
-	args->tfRegister[IDE_LCYL_OFFSET]    = hwif->INB(IDE_LCYL_REG);
-	args->tfRegister[IDE_HCYL_OFFSET]    = hwif->INB(IDE_HCYL_REG);
-	args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
-	args->tfRegister[IDE_STATUS_OFFSET]  = stat;
-	if ((drive->id->command_set_2 & 0x0400) &&
-	    (drive->id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
-		hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
-		args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
-		args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
-		args->hobRegister[IDE_SECTOR_OFFSET_HOB]  = hwif->INB(IDE_SECTOR_REG);
-		args->hobRegister[IDE_LCYL_OFFSET_HOB]    = hwif->INB(IDE_LCYL_REG);
-		args->hobRegister[IDE_HCYL_OFFSET_HOB]    = hwif->INB(IDE_HCYL_REG);
-	}
-
-#if 0
-/*	taskfile_settings_update(drive, args, command); */
-
-	if (args->posthandler != NULL)
-		args->posthandler(drive, args);
-#endif
-
-	spin_lock_irqsave(&ide_lock, flags);
-	blkdev_dequeue_request(rq);
-	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq);
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-EXPORT_SYMBOL(ide_end_taskfile);
-
-/*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */
 ide_startstop_t set_multmode_intr (ide_drive_t *drive)
diff -puN include/linux/ide.h~ide_end_taskfile include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_end_taskfile	2004-02-19 02:12:33.261157904 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 02:12:33.273156080 +0100
@@ -1433,9 +1433,6 @@ extern int wait_for_ready(ide_drive_t *,
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
-/* (ide_drive_t *drive, u8 stat, u8 err) */
-extern void ide_end_taskfile(ide_drive_t *, u8, u8);
-
 /*
  * Special Flagged Register Validation Caller
  */

_

