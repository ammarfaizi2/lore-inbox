Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVBEKfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVBEKfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbVBEKex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:34:53 -0500
Received: from [211.58.254.17] ([211.58.254.17]:39569 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266437AbVBEK2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:55 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 06/09] ide: remove REQ_DRIVE_TASK handling
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.AA0CA132703@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


06_ide_remove_task.patch

	Unused REQ_DRIVE_TASK handling removed.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-io.c	2005-02-05 19:27:08.736540825 +0900
+++ linux-ide-series2-export/drivers/ide/ide-io.c	2005-02-05 19:27:09.190467092 +0900
@@ -357,20 +357,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[1] = err;
 			args[2] = hwif->INB(IDE_NSECTOR_REG);
 		}
-	} else if (rq->flags & REQ_DRIVE_TASK) {
-		u8 *args = (u8 *) rq->buffer;
-		if (rq->errors == 0)
-			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] = stat;
-			args[1] = err;
-			args[2] = hwif->INB(IDE_NSECTOR_REG);
-			args[3] = hwif->INB(IDE_SECTOR_REG);
-			args[4] = hwif->INB(IDE_LCYL_REG);
-			args[5] = hwif->INB(IDE_HCYL_REG);
-			args[6] = hwif->INB(IDE_SELECT_REG);
-		}
 	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
@@ -557,7 +543,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -599,7 +585,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -757,33 +743,7 @@ static ide_startstop_t execute_drive_cmd
 		if (args->tf_out_flags.all != 0) 
 			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
-	} else if (rq->flags & REQ_DRIVE_TASK) {
-		u8 *args = rq->buffer;
-		u8 sel;
- 
-		if (!args)
-			goto done;
-#ifdef DEBUG
- 		printk("%s: DRIVE_TASK_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("fr=0x%02x ", args[1]);
- 		printk("ns=0x%02x ", args[2]);
- 		printk("sc=0x%02x ", args[3]);
- 		printk("lcyl=0x%02x ", args[4]);
- 		printk("hcyl=0x%02x ", args[5]);
- 		printk("sel=0x%02x\n", args[6]);
-#endif
- 		hwif->OUTB(args[1], IDE_FEATURE_REG);
- 		hwif->OUTB(args[3], IDE_SECTOR_REG);
- 		hwif->OUTB(args[4], IDE_LCYL_REG);
- 		hwif->OUTB(args[5], IDE_HCYL_REG);
- 		sel = (args[6] & ~0x10);
- 		if (drive->select.b.unit)
- 			sel |= 0x10;
- 		hwif->OUTB(sel, IDE_SELECT_REG);
- 		ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
- 		return ide_started;
- 	} else if (rq->flags & REQ_DRIVE_CMD) {
+	} else if (rq->flags & REQ_DRIVE_CMD) {
  		u8 *args = rq->buffer;
 
 		if (!args)
@@ -894,7 +854,7 @@ static ide_startstop_t start_request (id
 		return startstop;
 	}
 	if (!drive->special.all) {
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
+		if (rq->flags & REQ_DRIVE_CMD)
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
Index: linux-ide-series2-export/drivers/ide/ide-lib.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-lib.c	2005-02-05 19:26:51.018418868 +0900
+++ linux-ide-series2-export/drivers/ide/ide-lib.c	2005-02-05 19:27:09.191466929 +0900
@@ -458,7 +458,7 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+	if (rq->flags & REQ_DRIVE_CMD) {
 		char *args = rq->buffer;
 		if (args) {
 			opcode = args[0];
Index: linux-ide-series2-export/include/linux/blkdev.h
===================================================================
--- linux-ide-series2-export.orig/include/linux/blkdev.h	2005-02-05 19:26:51.018418868 +0900
+++ linux-ide-series2-export/include/linux/blkdev.h	2005-02-05 19:27:09.191466929 +0900
@@ -202,7 +202,7 @@ enum rq_flag_bits {
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
 	__REQ_DRIVE_CMD,
-	__REQ_DRIVE_TASK,
+	__REQ_DRIVE_TASK,	/* obsolete, unused anymore - tj */
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
 	__REQ_PM_SUSPEND,	/* suspend request */
