Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVBBDZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVBBDZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVBBDRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:17:14 -0500
Received: from [211.58.254.17] ([211.58.254.17]:14731 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262262AbVBBDIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:08:45 -0500
Date: Wed, 2 Feb 2005 12:08:43 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 24/29] ide: remove REQ_DRIVE_TASK handling
Message-ID: <20050202030843.GI1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 24_ide_remove_task.patch
> 
> 	Unused REQ_DRIVE_TASK handling removed.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:06.528986250 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:06.952917467 +0900
@@ -350,20 +350,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
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
@@ -550,7 +536,7 @@ ide_startstop_t ide_error (ide_drive_t *
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -592,7 +578,7 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return ide_stopped;
 
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -748,33 +734,7 @@ static ide_startstop_t execute_drive_cmd
 		}
 
 		return do_taskfile(drive, args);
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
@@ -885,7 +845,7 @@ static ide_startstop_t start_request (id
 		return startstop;
 	}
 	if (!drive->special.all) {
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
+		if (rq->flags & REQ_DRIVE_CMD)
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
Index: linux-ide-export/drivers/ide/ide-lib.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-lib.c	2005-02-02 10:27:14.733389689 +0900
+++ linux-ide-export/drivers/ide/ide-lib.c	2005-02-02 10:28:06.953917305 +0900
@@ -458,7 +458,7 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+	if (rq->flags & REQ_DRIVE_CMD) {
 		char *args = rq->buffer;
 		if (args) {
 			opcode = args[0];
Index: linux-ide-export/include/linux/blkdev.h
===================================================================
--- linux-ide-export.orig/include/linux/blkdev.h	2005-02-02 10:27:14.733389689 +0900
+++ linux-ide-export/include/linux/blkdev.h	2005-02-02 10:28:06.954917143 +0900
@@ -202,7 +202,7 @@ enum rq_flag_bits {
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
 	__REQ_DRIVE_CMD,
-	__REQ_DRIVE_TASK,
+	__REQ_DRIVE_TASK,	/* obsolete, unused anymore - tj */
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
 	__REQ_PM_SUSPEND,	/* suspend request */
