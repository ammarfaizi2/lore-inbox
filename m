Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVBJIlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVBJIlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVBJIkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:40:02 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:54485 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262058AbVBJIii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=C33NrLG0X9ayCyt0JH4XCMTiybBqPHCJGAUOKfaX1Yfyjq4RABVl6OWzodIBp4EBr+reGsF2RV0dtDlVYIGkvC4o9qQlhHnuqBIQ57duDIKrDaY3cdTKJ/QHvvc9LtvCPZ2UU71ebkSlpp9wSrDHGC2ptbJpH5bh7SQ04skPoZg=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 04/11] ide: removes unneeded HOB access using ATA_TFLAG_LBA48 flag
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083824.97E549BE@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:29 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04_ide_ATA_TFLAG_LBA48.patch

	This small patch fixes unneeded writes/reads to LBA48 taskfile
	registers on LBA48 capable disks for following cases:

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

	Patch adds 'unsinged long flags' to ide_task_t and uses
	ATA_TFLAG_LBA48 flag (from <linux/ata.h>) to indicate need of
	accessing LBA48 taskfile registers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 drivers/ide/ide-disk.c     |    6 ++++++
 drivers/ide/ide-io.c       |    2 +-
 drivers/ide/ide-taskfile.c |    7 +++++--
 include/linux/ide.h        |    1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-ide/drivers/ide/ide-disk.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-disk.c	2005-02-10 17:31:48.698694939 +0900
+++ linux-ide/drivers/ide/ide-disk.c	2005-02-10 17:38:01.169901379 +0900
@@ -362,6 +362,9 @@ static unsigned long long idedisk_read_n
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
+
+	args.flags |= ATA_TFLAG_LBA48;
+
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
 
@@ -431,6 +434,9 @@ static unsigned long long idedisk_set_ma
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
+
+	args.flags |= ATA_TFLAG_LBA48;
+
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
Index: linux-ide/drivers/ide/ide-io.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-io.c	2005-02-10 17:38:00.436024471 +0900
+++ linux-ide/drivers/ide/ide-io.c	2005-02-10 17:38:01.171901044 +0900
@@ -487,7 +487,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
 			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 
-			if (drive->addressing == 1) {
+			if (args->flags & ATA_TFLAG_LBA48) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
 				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.832957893 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.172900876 +0900
@@ -101,7 +101,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
+	u8 HIHI			= (task->flags & ATA_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
@@ -110,7 +110,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
+	if (task->flags & ATA_TFLAG_LBA48) {
 		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
 		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
 		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
@@ -573,6 +573,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
+	if (drive->addressing == 1)
+		args.flags |= ATA_TFLAG_LBA48;
+
 	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
Index: linux-ide/include/linux/ide.h
===================================================================
--- linux-ide.orig/include/linux/ide.h	2005-02-10 17:38:00.044090212 +0900
+++ linux-ide/include/linux/ide.h	2005-02-10 17:38:01.174900541 +0900
@@ -1258,6 +1258,7 @@ typedef struct ide_task_s {
  *	struct hd_drive_hob_hdr		hobf;
  *	hob_struct_t		hobf;
  */
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
 	task_ioreg_t		tfRegister[8];
 	task_ioreg_t		hobRegister[8];
 	ide_reg_valid_t		tf_out_flags;
