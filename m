Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263597AbVCECXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbVCECXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbVCECIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:08:23 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:8603 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263649AbVCEBsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=T+YuGKkaByy045Vd9bbzbbYmwKHTuLHLuBiUvrFQy5fefvC7jvXoBe4xEjD/9slBDcrowws8Y/HWeeYDUKtxMvSDjHK23IBPkSmWdz1rO6fwED0E54feOZ0OppHnYP9RtJDn/DcOCobARcVyaBu/57VnIJDKls0dFOBwr6oBZLA=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 08/08] ide: remove REQ_DRIVE_CMD handling
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014834.996DF4EB@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:39 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


08_ide_remove_REQ_DRIVE_CMD.patch

	Remove REQ_DRIVE_CMD handling.  ide_init_drive_cmd() now
	defaults to REQ_DRIVE_TASKFILE (now the only drive command :-).

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |    1 
 drivers/ide/ide-disk.c    |    1 
 drivers/ide/ide-io.c      |  132 +++++-----------------------------------------
 drivers/ide/ide-lib.c     |    8 --
 include/linux/blkdev.h    |    2 
 5 files changed, 17 insertions(+), 127 deletions(-)

Index: linux-taskfile-ng/drivers/block/ll_rw_blk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/block/ll_rw_blk.c	2005-03-05 10:37:51.398401518 +0900
+++ linux-taskfile-ng/drivers/block/ll_rw_blk.c	2005-03-05 10:47:00.319763980 +0900
@@ -850,7 +850,6 @@ static char *rq_flags[] = {
 	"REQ_FAILED",
 	"REQ_QUIET",
 	"REQ_SPECIAL",
-	"REQ_DRIVE_CMD",
 	"REQ_DRIVE_TASKFILE",
 	"REQ_PREEMPT",
 	"REQ_PM_SUSPEND",
Index: linux-taskfile-ng/drivers/ide/ide-disk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-disk.c	2005-03-05 10:46:59.684863236 +0900
+++ linux-taskfile-ng/drivers/ide/ide-disk.c	2005-03-05 10:47:00.319763980 +0900
@@ -638,7 +638,6 @@ static int set_multcount(ide_drive_t *dr
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
-	rq.flags = REQ_DRIVE_CMD;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: linux-taskfile-ng/drivers/ide/ide-io.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-io.c	2005-03-05 10:46:59.685863080 +0900
+++ linux-taskfile-ng/drivers/ide/ide-io.c	2005-03-05 10:47:00.320763824 +0900
@@ -97,7 +97,7 @@ static struct request *ide_queue_flush_c
 	ide_task_init_flush(drive, task);
 
 	ide_init_drive_cmd(flush_rq);
-	flush_rq->flags = REQ_DRIVE_TASKFILE | REQ_STARTED;
+	flush_rq->flags = REQ_STARTED;
 	flush_rq->nr_sectors = rq->nr_sectors;
 	flush_rq->special = task;
 
@@ -429,7 +429,6 @@ static void ide_complete_barrier(ide_dri
  
 void ide_end_drive_cmd (ide_drive_t *drive, u8 stat, u8 err)
 {
-	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
 
@@ -437,17 +436,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
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
@@ -622,7 +611,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -673,7 +662,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -688,63 +677,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
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
 	struct ata_taskfile *tf = &task->tf;
@@ -886,53 +818,23 @@ EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
  *	all commands to finish. Don't do this as that is due to change
  */
 
-static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
-		struct request *rq)
+static ide_startstop_t execute_drive_cmd(ide_drive_t *drive, struct request *rq)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
- 		ide_task_t *args = rq->special;
- 
-		if (!args)
-			goto done;
-
-		return do_rw_taskfile(drive, args);
-	} else if (rq->flags & REQ_DRIVE_CMD) {
-		u8 *args = rq->buffer;
+	ide_hwif_t *hwif = drive->hwif;
+	ide_task_t *task = rq->special;
 
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
+	if (task)
+		return do_rw_taskfile(drive, task);
 
-done:
  	/*
  	 * NULL is actually a valid way of waiting for
  	 * all current requests to be flushed from the queue.
  	 */
-#ifdef DEBUG
- 	printk("%s: DRIVE_CMD (null)\n", drive->name);
-#endif
+
  	ide_end_drive_cmd(drive,
-			hwif->INB(IDE_STATUS_REG),
-			hwif->INB(IDE_ERROR_REG));
+			  hwif->INB(IDE_STATUS_REG),
+			  hwif->INB(IDE_ERROR_REG));
+
  	return ide_stopped;
 }
 
@@ -1010,9 +912,7 @@ static ide_startstop_t start_request (id
 	if (!drive->special.all) {
 		ide_driver_t *drv;
 
-		if (rq->flags & REQ_DRIVE_CMD)
-			return execute_drive_cmd(drive, rq);
-		else if (rq->flags & REQ_DRIVE_TASKFILE)
+		if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
@@ -1662,10 +1562,10 @@ irqreturn_t ide_intr (int irq, void *dev
  *	nasty suprise.
  */
 
-void ide_init_drive_cmd (struct request *rq)
+void ide_init_drive_cmd(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
+	rq->flags = REQ_DRIVE_TASKFILE;
 	rq->ref_count = 1;
 }
 
Index: linux-taskfile-ng/drivers/ide/ide-lib.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-lib.c	2005-03-05 10:37:51.398401518 +0900
+++ linux-taskfile-ng/drivers/ide/ide-lib.c	2005-03-05 10:47:00.321763668 +0900
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
 			opcode = args->tf.command;
Index: linux-taskfile-ng/include/linux/blkdev.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/blkdev.h	2005-03-05 10:37:51.398401518 +0900
+++ linux-taskfile-ng/include/linux/blkdev.h	2005-03-05 10:47:00.321763668 +0900
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
