Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVBEKfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVBEKfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbVBEKeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:34:31 -0500
Received: from [211.58.254.17] ([211.58.254.17]:38033 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266428AbVBEK2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:54 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 09/09] ide: remove REQ_DRIVE_CMD handling
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.C930C132706@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


09_ide_remove_cmd.patch

	Removed unused REQ_DRIVE_CMD handling.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-io.c	2005-02-05 19:27:09.190467092 +0900
+++ linux-ide-series2-export/drivers/ide/ide-io.c	2005-02-05 19:27:09.866357303 +0900
@@ -347,17 +347,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
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
@@ -543,7 +533,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -585,7 +575,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -595,63 +585,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
 }
 
 /**
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
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT) && DRIVER(drive) != NULL)
-		return ide_error(drive, "drive_cmd", stat);
-		/* calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-	return ide_stopped;
-}
-
-/**
  *	do_special		-	issue some special commands
  *	@drive: drive the command is for
  *
@@ -706,80 +639,52 @@ void ide_init_sg_cmd(ide_drive_t *drive,
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
+	ide_task_t *args = rq->special;
+	
+	if (!args) {
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
+	hwif->data_phase = args->data_phase;
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
+	if (args->tf_out_flags.all != 0) 
+		return flagged_taskfile(drive, args);
+	return do_rw_taskfile(drive, args);
 }
 
 /**
@@ -854,10 +759,8 @@ static ide_startstop_t start_request (id
 		return startstop;
 	}
 	if (!drive->special.all) {
-		if (rq->flags & REQ_DRIVE_CMD)
-			return execute_drive_cmd(drive, rq);
-		else if (rq->flags & REQ_DRIVE_TASKFILE)
-			return execute_drive_cmd(drive, rq);
+		if (rq->flags & REQ_DRIVE_TASKFILE)
+			return execute_drive_taskfile(drive, rq);
 		else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
 			printk("%s: start_power_step(step: %d)\n",
Index: linux-ide-series2-export/include/linux/blkdev.h
===================================================================
--- linux-ide-series2-export.orig/include/linux/blkdev.h	2005-02-05 19:27:09.191466929 +0900
+++ linux-ide-series2-export/include/linux/blkdev.h	2005-02-05 19:27:09.867357141 +0900
@@ -201,7 +201,7 @@ enum rq_flag_bits {
 	__REQ_FAILED,		/* set if the request failed */
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
-	__REQ_DRIVE_CMD,
+	__REQ_DRIVE_CMD,	/* obsolete, unused anymore - tj */
 	__REQ_DRIVE_TASK,	/* obsolete, unused anymore - tj */
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
