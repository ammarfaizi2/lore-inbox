Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVBFWz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVBFWz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 17:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBFWz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 17:55:57 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:31730 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261178AbVBFWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 17:55:35 -0500
Date: Sun, 6 Feb 2005 23:54:11 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <tj@home-tj.org>
Subject: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Message-ID: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ against ide-dev-2.6 tree, boot tested on LBA48 drive ]

This small patch fixes unneeded writes/reads to LBA48 taskfile registers
on LBA48 capable disks for following cases:

* Power Management requests
  (WIN_FLUSH_CACHE[_EXT], WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
* special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
* Host Protected Area support (WIN_READ_NATIVE_MAX, WIN_SET_MAX)
* /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
  SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
* write cache enabling/disabling in ide-disk
  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
* write cache flushing in ide-disk (WIN_FLUSH_CACHE[_EXT])
* acoustic management in ide-disk
  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
* door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
* /proc/ide/hd?/identify support (WIN_IDENTIFY)

Patch adds 'unsinged long flags' to ide_task_t and uses ATA_TFLAG_LBA48
flag (from <linux/ata.h>) to indicate need of accessing LBA48 taskfile
registers.

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-06 23:47:44 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-06 23:47:44 +01:00
@@ -362,6 +362,9 @@
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
+
+	args.flags |= ATA_TFLAG_LBA48;
+
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);

@@ -431,6 +434,9 @@
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
+
+	args.flags |= ATA_TFLAG_LBA48;
+
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-06 23:47:44 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-06 23:47:44 +01:00
@@ -487,7 +487,7 @@
 			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
 			args->tfRegister[IDE_STATUS_OFFSET]  = stat;

-			if (drive->addressing == 1) {
+			if (args->flags & ATA_TFLAG_LBA48) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
 				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-06 23:47:44 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-06 23:47:44 +01:00
@@ -101,7 +101,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
+	u8 HIHI			= (task->flags & ATA_TFLAG_LBA48) ? 0xE0 : 0xEF;

 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
@@ -110,7 +110,7 @@
 	}
 	SELECT_MASK(drive, 0);

-	if (drive->addressing == 1) {
+	if (task->flags & ATA_TFLAG_LBA48) {
 		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
 		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
 		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
@@ -577,6 +577,9 @@
 	args.tf_out_flags = req_task->out_flags;
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
+
+	if (drive->addressing == 1)
+		args.flags |= ATA_TFLAG_LBA48;

 	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-06 23:47:44 +01:00
+++ b/include/linux/ide.h	2005-02-06 23:47:44 +01:00
@@ -1258,6 +1258,7 @@
  *	struct hd_drive_hob_hdr		hobf;
  *	hob_struct_t		hobf;
  */
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
 	task_ioreg_t		tfRegister[8];
 	task_ioreg_t		hobRegister[8];
 	ide_reg_valid_t		tf_out_flags;
