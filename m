Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVBJIvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVBJIvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVBJInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:43:43 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:32984 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262066AbVBJIi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=fcfAkyUtQ2bg6eJLe1IoRxlo1PvnBpshFWxj9bk3LxhH5xlBDwmz4RCK4m+vhA9Y+fnQsXZ5pATXVbnOhRHBCbaORipYdO4FqenK/ozZj3KypcJhNIiJ09mhx0Hp+sIHPfkQ9EcKEcOn2uGa+xgai7V18iBpRxLtFlpPXGS2624=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 08/11] ide: remove REQ_DRIVE_TASK handling
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083844.AD987173@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:49 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


08_ide_remove_task.patch

	Unused REQ_DRIVE_TASK handling removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |    1 
 drivers/ide/ide-io.c      |   48 +++-------------------------------------------
 drivers/ide/ide-lib.c     |    2 -
 include/linux/blkdev.h    |    2 -
 4 files changed, 5 insertions(+), 48 deletions(-)

Index: linux-ide/drivers/block/ll_rw_blk.c
===================================================================
--- linux-ide.orig/drivers/block/ll_rw_blk.c	2005-02-10 17:31:48.393751059 +0900
+++ linux-ide/drivers/block/ll_rw_blk.c	2005-02-10 17:38:02.165734368 +0900
@@ -851,7 +851,6 @@ static char *rq_flags[] = {
 	"REQ_QUIET",
 	"REQ_SPECIAL",
 	"REQ_DRIVE_CMD",
-	"REQ_DRIVE_TASK",
 	"REQ_DRIVE_TASKFILE",
 	"REQ_PREEMPT",
 	"REQ_PM_SUSPEND",
Index: linux-ide/drivers/ide/ide-io.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-io.c	2005-02-10 17:38:01.746804625 +0900
+++ linux-ide/drivers/ide/ide-io.c	2005-02-10 17:38:02.162734871 +0900
@@ -453,20 +453,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
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
@@ -666,7 +652,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -717,7 +703,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -945,33 +931,7 @@ static ide_startstop_t execute_drive_cmd
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
@@ -1084,7 +1044,7 @@ static ide_startstop_t start_request (id
 	if (!drive->special.all) {
 		ide_driver_t *drv;
 
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
+		if (rq->flags & REQ_DRIVE_CMD)
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
Index: linux-ide/drivers/ide/ide-lib.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-lib.c	2005-02-10 17:31:48.393751059 +0900
+++ linux-ide/drivers/ide/ide-lib.c	2005-02-10 17:38:02.163734703 +0900
@@ -458,7 +458,7 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+	if (rq->flags & REQ_DRIVE_CMD) {
 		char *args = rq->buffer;
 		if (args) {
 			opcode = args[0];
Index: linux-ide/include/linux/blkdev.h
===================================================================
--- linux-ide.orig/include/linux/blkdev.h	2005-02-10 17:31:48.393751059 +0900
+++ linux-ide/include/linux/blkdev.h	2005-02-10 17:38:02.163734703 +0900
@@ -202,7 +202,6 @@ enum rq_flag_bits {
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
 	__REQ_DRIVE_CMD,
-	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
 	__REQ_PM_SUSPEND,	/* suspend request */
@@ -229,7 +228,6 @@ enum rq_flag_bits {
 #define REQ_QUIET	(1 << __REQ_QUIET)
 #define REQ_SPECIAL	(1 << __REQ_SPECIAL)
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
-#define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
 #define REQ_PREEMPT	(1 << __REQ_PREEMPT)
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
