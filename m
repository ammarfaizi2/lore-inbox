Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVBXPBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVBXPBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVBXPBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:01:42 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:41634 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262377AbVBXOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:55:47 -0500
Date: Thu, 24 Feb 2005 15:49:09 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 9/9] remove unused REQ_DRIVE_TASK handling
Message-ID: <Pine.GSO.4.58.0502241548401.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Tejun Heo <htejun@gmail.com>

diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	2005-02-24 15:30:14 +01:00
+++ b/drivers/block/ll_rw_blk.c	2005-02-24 15:30:14 +01:00
@@ -851,7 +851,6 @@
 	"REQ_QUIET",
 	"REQ_SPECIAL",
 	"REQ_DRIVE_CMD",
-	"REQ_DRIVE_TASK",
 	"REQ_DRIVE_TASKFILE",
 	"REQ_PREEMPT",
 	"REQ_PM_SUSPEND",
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-24 15:30:14 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-24 15:30:14 +01:00
@@ -451,20 +451,6 @@
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
@@ -667,7 +653,7 @@
 		return ide_stopped;

 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -718,7 +704,7 @@
 		return ide_stopped;

 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
@@ -952,33 +938,7 @@
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
@@ -1091,7 +1051,7 @@
 	if (!drive->special.all) {
 		ide_driver_t *drv;

-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
+		if (rq->flags & REQ_DRIVE_CMD)
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c	2005-02-24 15:30:14 +01:00
+++ b/drivers/ide/ide-lib.c	2005-02-24 15:30:14 +01:00
@@ -458,7 +458,7 @@
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+	if (rq->flags & REQ_DRIVE_CMD) {
 		char *args = rq->buffer;
 		if (args) {
 			opcode = args[0];
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	2005-02-24 15:30:14 +01:00
+++ b/include/linux/blkdev.h	2005-02-24 15:30:14 +01:00
@@ -202,7 +202,6 @@
 	__REQ_QUIET,		/* don't worry about errors */
 	__REQ_SPECIAL,		/* driver suplied command */
 	__REQ_DRIVE_CMD,
-	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_TASKFILE,
 	__REQ_PREEMPT,		/* set for "ide_preempt" requests */
 	__REQ_PM_SUSPEND,	/* suspend request */
@@ -229,7 +228,6 @@
 #define REQ_QUIET	(1 << __REQ_QUIET)
 #define REQ_SPECIAL	(1 << __REQ_SPECIAL)
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
-#define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_TASKFILE	(1 << __REQ_DRIVE_TASKFILE)
 #define REQ_PREEMPT	(1 << __REQ_PREEMPT)
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
