Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVBJJJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVBJJJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVBJJHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:07:37 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:27610 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262069AbVBJIjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:39:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=PvcxtBUpotT4IDvBNc5k5svPhd1tVd9VY0eQO4Sl/hhWiuk5FGDw1SGYeSl8b+LS6bvaO4LcRm+3Xhu4xCbz+0w16ROS2sLONt249Q0AMM4D/F3eD0LwQn41SQU6F+j6oQKcRzQyAWO65uMmhcoUa6KiEToRzDF0UCICJWe7yak=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 11/11] ide: remove REQ_DRIVE_CMD handling
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083859.CC18790D@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:39:04 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


11_ide_remove_cmd.patch

	Unused REQ_DRIVE_CMD handling removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |    1 
 drivers/ide/ide-io.c      |  181 ++++++++++------------------------------------
 drivers/ide/ide-lib.c     |    8 --
 include/linux/blkdev.h    |    2 
 4 files changed, 43 insertions(+), 149 deletions(-)

Index: linux-ide/drivers/block/ll_rw_blk.c
===================================================================
--- linux-ide.orig/drivers/block/ll_rw_blk.c	2005-02-10 17:38:02.165734368 +0900
+++ linux-ide/drivers/block/ll_rw_blk.c	2005-02-10 17:38:02.831622702 +0900
@@ -850,7 +850,6 @@ static char *rq_flags[] = {
 	"REQ_FAILED",
 	"REQ_QUIET",
 	"REQ_SPECIAL",
-	"REQ_DRIVE_CMD",
 	"REQ_DRIVE_TASKFILE",
 	"REQ_PREEMPT",
 	"REQ_PM_SUSPEND",
Index: linux-ide/drivers/ide/ide-io.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-io.c	2005-02-10 17:38:02.162734871 +0900
+++ linux-ide/drivers/ide/ide-io.c	2005-02-10 17:38:02.829623038 +0900
@@ -443,17 +443,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	rq = HWGROUP(drive)->rq;
 	spin_unlock_irqrestore(&ide_lock, flags);
 
-	if (rq->flags & REQ_DRIVE_CMD) {
-		u8 *args = (u8 *) rq->buffer;
-		if (rq->errors == 0)
-			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] = stat;
-			args[1] = err;
-			args[2] = hwif->INB(IDE_NSECTOR_REG);
-		}
-	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
@@ -652,7 +642,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -703,7 +693,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -718,63 +708,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return __ide_abort(drive, rq);
 }
 
-/**
- *	ide_cmd		-	issue a simple drive command
- *	@drive: drive the command is for
- *	@cmd: command byte
- *	@nsect: sector byte
- *	@handler: handler for the command completion
- *
- *	Issue a simple drive command with interrupts.
- *	The drive must be selected beforehand.
- */
-
-static void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect,
-		ide_handler_t *handler)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
-	SELECT_MASK(drive,0);
-	hwif->OUTB(nsect,IDE_NSECTOR_REG);
-	ide_execute_command(drive, cmd, handler, WAIT_CMD, NULL);
-}
-
-/**
- *	drive_cmd_intr		- 	drive command completion interrupt
- *	@drive: drive the completion interrupt occurred on
- *
- *	drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
- *	We do any necessary daya reading and then wait for the drive to
- *	go non busy. At that point we may read the error data and complete
- *	the request
- */
- 
-static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	ide_hwif_t *hwif = HWIF(drive);
-	u8 *args = (u8 *) rq->buffer;
-	u8 stat = hwif->INB(IDE_STATUS_REG);
-	int retries = 10;
-
-	local_irq_enable();
-	if ((stat & DRQ_STAT) && args && args[3]) {
-		u8 io_32bit = drive->io_32bit;
-		drive->io_32bit = 0;
-		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
-		drive->io_32bit = io_32bit;
-		while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-			udelay(100);
-	}
-
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, "drive_cmd", stat);
-		/* calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-	return ide_stopped;
-}
-
 static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
 {
 	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
@@ -894,80 +827,52 @@ void ide_init_sg_cmd(ide_drive_t *drive,
 EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
 
 /**
- *	execute_drive_command	-	issue special drive command
+ *	execute_drive_taskfile	-	issue special drive command
  *	@drive: the drive to issue th command on
  *	@rq: the request structure holding the command
  *
- *	execute_drive_cmd() issues a special drive command,  usually 
- *	initiated by ioctl() from the external hdparm program. The
- *	command can be a drive command, drive task or taskfile 
- *	operation. Weirdly you can call it with NULL to wait for
- *	all commands to finish. Don't do this as that is due to change
+ *	execute_drive_taskfile() issues a special drive command,
+ *	usually initiated by ioctl() from the external hdparm program.
+ *	Weirdly you can call it with NULL to wait for all commands to
+ *	finish. Don't do this as that is due to change
  */
 
-static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
-		struct request *rq)
+static ide_startstop_t execute_drive_taskfile (ide_drive_t *drive,
+					       struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
- 		ide_task_t *args = rq->special;
- 
-		if (!args)
-			goto done;
-
-		hwif->data_phase = args->data_phase;
-
-		switch (hwif->data_phase) {
-		case TASKFILE_MULTI_OUT:
-		case TASKFILE_OUT:
-		case TASKFILE_MULTI_IN:
-		case TASKFILE_IN:
-			ide_init_sg_cmd(drive, rq);
-			ide_map_sg(drive, rq);
-		default:
-			break;
-		}
-
-		if (args->tf_out_flags.all != 0) 
-			return flagged_taskfile(drive, args);
-		return do_rw_taskfile(drive, args);
-	} else if (rq->flags & REQ_DRIVE_CMD) {
- 		u8 *args = rq->buffer;
-
-		if (!args)
-			goto done;
-#ifdef DEBUG
- 		printk("%s: DRIVE_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("sc=0x%02x ", args[1]);
- 		printk("fr=0x%02x ", args[2]);
- 		printk("xx=0x%02x\n", args[3]);
-#endif
- 		if (args[0] == WIN_SMART) {
- 			hwif->OUTB(0x4f, IDE_LCYL_REG);
- 			hwif->OUTB(0xc2, IDE_HCYL_REG);
- 			hwif->OUTB(args[2],IDE_FEATURE_REG);
- 			hwif->OUTB(args[1],IDE_SECTOR_REG);
- 			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
- 			return ide_started;
- 		}
- 		hwif->OUTB(args[2],IDE_FEATURE_REG);
- 		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
- 		return ide_started;
- 	}
-
-done:
- 	/*
- 	 * NULL is actually a valid way of waiting for
- 	 * all current requests to be flushed from the queue.
- 	 */
+	ide_task_t *task = rq->special;
+	
+	if (!task) {
+		/*
+		 * NULL is actually a valid way of waiting for
+		 * all current requests to be flushed from the queue.
+		 */
 #ifdef DEBUG
- 	printk("%s: DRIVE_CMD (null)\n", drive->name);
+		printk("%s: DRIVE_TASKFILE (null)\n", drive->name);
 #endif
- 	ide_end_drive_cmd(drive,
-			hwif->INB(IDE_STATUS_REG),
-			hwif->INB(IDE_ERROR_REG));
- 	return ide_stopped;
+		ide_end_drive_cmd(drive,
+				  hwif->INB(IDE_STATUS_REG),
+				  hwif->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}
+
+	hwif->data_phase = task->data_phase;
+
+	switch (hwif->data_phase) {
+	case TASKFILE_MULTI_OUT:
+	case TASKFILE_OUT:
+	case TASKFILE_MULTI_IN:
+	case TASKFILE_IN:
+		ide_init_sg_cmd(drive, rq);
+		ide_map_sg(drive, rq);
+	default:
+		break;
+	}
+
+	if (task->tf_out_flags.all != 0) 
+		return flagged_taskfile(drive, task);
+	return do_rw_taskfile(drive, task);
 }
 
 /**
@@ -1044,10 +949,8 @@ static ide_startstop_t start_request (id
 	if (!drive->special.all) {
 		ide_driver_t *drv;
 
-		if (rq->flags & REQ_DRIVE_CMD)
-			return execute_drive_cmd(drive, rq);
-		else if (rq->flags & REQ_DRIVE_TASKFILE)
-			return execute_drive_cmd(drive, rq);
+		if (rq->flags & REQ_DRIVE_TASKFILE)
+			return execute_drive_taskfile(drive, rq);
 		else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
 			printk("%s: start_power_step(step: %d)\n",
Index: linux-ide/drivers/ide/ide-lib.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-lib.c	2005-02-10 17:38:02.163734703 +0900
+++ linux-ide/drivers/ide/ide-lib.c	2005-02-10 17:38:02.830622870 +0900
@@ -458,13 +458,7 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->flags & REQ_DRIVE_CMD) {
-		char *args = rq->buffer;
-		if (args) {
-			opcode = args[0];
-			found = 1;
-		}
-	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		if (args) {
 			task_struct_t *tf = (task_struct_t *) args->tfRegister;
Index: linux-ide/include/linux/blkdev.h
===================================================================
--- linux-ide.orig/include/linux/blkdev.h	2005-02-10 17:38:02.163734703 +0900
+++ linux-ide/include/linux/blkdev.h	2005-02-10 17:38:02.829623038 +0900
@@ -201,7 +201,6 @@ enum rq_flag_bits {
 	__REQ_FAILED,		/* set if the request failed */
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
-	__REQ_DRIVE_CMD,
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
 	__REQ_PM_SUSPEND,	/* suspend request */
@@ -227,7 +226,6 @@ enum rq_flag_bits {
 #define REQ_FAILED	(1 << __REQ_FAILED)
 #define REQ_QUIET	(1 << __REQ_QUIET)
 #define REQ_SPECIAL	(1 << __REQ_SPECIAL)
-#define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
 #define REQ_PREEMPT	(1 << __REQ_PREEMPT)
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
