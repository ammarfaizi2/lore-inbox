Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263606AbVCECXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbVCECXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbVCECSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:18:06 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:17300 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263614AbVCEBsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=CbsA5Wl0UlM7ITIV923MgPuNUKPGnOMMj5VuZEUIOLATw1aig2zoqFilDiFMKCVyIrFHy/svJSQZhiR3n6DRxMcz1zKCalVXkkJswiLfMK6+xnEPROcVnLbdeyBItndJAqsblKGSU+nHnkqiUJV+D5O+Z5HttATYFUK+DS8XXMw=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/08] ide: add individual ATA_TFLAG_{OUT|IN}_* flags
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014758.E19E52FE@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:03 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01_ide_TFLAG_OUT_IN.patch

	This patch replaces ide_task_t->tf_{out|in}_flags handling
	with newly defined individual ATA_TFLAG_{OUT|IN}_* flags and
	helper functions ide_{load|read}_taskfile().  To ease
	transition of the IDE code, temporary flags
	ATA_TFLAG_IDE_FLAGGED and ATA_TFLAG_IDE_LBA48 are defined.
	This patch is tit-for-tat and shouldn't change any behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c     |    4 
 drivers/ide/ide-io.c       |   35 +------
 drivers/ide/ide-taskfile.c |  220 +++++++++++++++++++++++++++------------------
 include/linux/ata.h        |   66 ++++++++++++-
 include/linux/ide.h        |   10 +-
 5 files changed, 213 insertions(+), 122 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-disk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-disk.c	2005-03-05 10:37:51.738348597 +0900
+++ linux-taskfile-ng/drivers/ide/ide-disk.c	2005-03-05 10:46:58.305078940 +0900
@@ -337,7 +337,7 @@ static u64 idedisk_read_native_max_addre
 	tf->device	= 0x40;
 	if (lba48) {
 		tf->command = WIN_READ_NATIVE_MAX_EXT;
-		tf->flags |= ATA_TFLAG_LBA48;
+		tf->flags |= ATA_TFLAG_IDE_LBA48;
 	} else
 		tf->command = WIN_READ_NATIVE_MAX;
 
@@ -379,7 +379,7 @@ static u64 idedisk_set_max_address(ide_d
 		tf->device	= 0x40;
 		tf->command	= WIN_SET_MAX_EXT;
 
-		tf->flags |= ATA_TFLAG_LBA48;
+		tf->flags |= ATA_TFLAG_IDE_LBA48;
 	} else {
 		tf->device	= ((addr_req >> 24) & 0xf) | 0x40;
 		tf->command	= WIN_SET_MAX;
Index: linux-taskfile-ng/drivers/ide/ide-io.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-io.c	2005-03-05 10:37:51.738348597 +0900
+++ linux-taskfile-ng/drivers/ide/ide-io.c	2005-03-05 10:46:58.307078627 +0900
@@ -64,7 +64,7 @@ void ide_task_init_flush(ide_drive_t *dr
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28))) {
 		tf->command = WIN_FLUSH_CACHE_EXT;
-		tf->flags |= ATA_TFLAG_LBA48;
+		tf->flags |= ATA_TFLAG_IDE_LBA48;
 	} else
 		tf->command = WIN_FLUSH_CACHE;
 
@@ -322,7 +322,7 @@ u64 ide_tf_get_address(ide_drive_t *driv
 {
 	u32 high, low;
 
-	if (tf->flags & ATA_TFLAG_LBA48) {
+	if (tf->flags & ATA_TFLAG_IDE_LBA48) {
 		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
 		low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 	} else {
@@ -458,31 +458,10 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			
 		if (args) {
 			struct ata_taskfile *tf = &args->tf;
-
-			if (args->tf_in_flags.b.data)
-				args->data = hwif->INW(IDE_DATA_REG);
-
-			tf->feature	= err;
-
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-
-			tf->nsect	= hwif->INB(IDE_NSECTOR_REG);
-			tf->lbal	= hwif->INB(IDE_SECTOR_REG);
-			tf->lbam	= hwif->INB(IDE_LCYL_REG);
-			tf->lbah	= hwif->INB(IDE_HCYL_REG);
-			tf->device	= hwif->INB(IDE_SELECT_REG);
-			tf->command	= stat;
-
-			if (tf->flags & ATA_TFLAG_LBA48) {
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-
-				tf->hob_feature	= hwif->INB(IDE_FEATURE_REG);
-				tf->hob_nsect	= hwif->INB(IDE_NSECTOR_REG);
-				tf->hob_lbal	= hwif->INB(IDE_SECTOR_REG);
-				tf->hob_lbam	= hwif->INB(IDE_LCYL_REG);
-				tf->hob_lbah	= hwif->INB(IDE_HCYL_REG);
-			}
+			tf->flags |= ATA_TFLAG_IN_ADDR | ATA_TFLAG_IN_DEVICE;
+			if (tf->flags & ATA_TFLAG_IDE_LBA48)
+				tf->flags |= ATA_TFLAG_IN_LBA48;
+			ide_read_taskfile(drive, args, stat, err);
 		}
 	} else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
@@ -935,7 +914,7 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (args->tf_out_flags.all != 0) 
+		if (args->tf.flags & ATA_TFLAG_IDE_FLAGGED)
 			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
 	} else if (rq->flags & REQ_DRIVE_CMD) {
Index: linux-taskfile-ng/drivers/ide/ide-taskfile.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-taskfile.c	2005-03-05 10:37:51.739348441 +0900
+++ linux-taskfile-ng/drivers/ide/ide-taskfile.c	2005-03-05 10:46:58.315077377 +0900
@@ -53,6 +53,92 @@
 
 #define DEBUG_TASKFILE	0	/* unset when fixed */
 
+void ide_load_taskfile(ide_drive_t *drive, ide_task_t *task)
+{
+	struct ata_taskfile *tf = &task->tf;
+	ide_hwif_t *hwif = drive->hwif;
+
+	/* The caller is responsible for supplying a valid device value. */
+	if (tf->flags & ATA_TFLAG_OUT_DEVICE)
+		hwif->OUTB(tf->device,	IDE_SELECT_REG);
+
+	/* Load HOB registers. */
+	if (tf->flags & ATA_TFLAG_OUT_HOB_FEATURE)
+		hwif->OUTB(tf->hob_feature,	IDE_FEATURE_REG);
+	if (tf->flags & ATA_TFLAG_OUT_HOB_NSECT)
+		hwif->OUTB(tf->hob_nsect,	IDE_NSECTOR_REG);
+	if (tf->flags & ATA_TFLAG_OUT_HOB_LBAL)
+		hwif->OUTB(tf->hob_lbal,	IDE_SECTOR_REG);
+	if (tf->flags & ATA_TFLAG_OUT_HOB_LBAM)
+		hwif->OUTB(tf->hob_lbam,	IDE_LCYL_REG);
+	if (tf->flags & ATA_TFLAG_OUT_HOB_LBAH)
+		hwif->OUTB(tf->hob_lbah,	IDE_HCYL_REG);
+
+	/* Now push HOBs upward by loading LOBs.  The caller is
+	   responsible for supplying matching LOB for each matching
+	   HOB; otherwise, HOB won't be pushed upward. */
+	if (tf->flags & ATA_TFLAG_OUT_FEATURE)
+		hwif->OUTB(tf->feature,		IDE_FEATURE_REG);
+	if (tf->flags & ATA_TFLAG_OUT_NSECT)
+		hwif->OUTB(tf->nsect,		IDE_NSECTOR_REG);
+	if (tf->flags & ATA_TFLAG_OUT_LBAL)
+		hwif->OUTB(tf->lbal,		IDE_SECTOR_REG);
+	if (tf->flags & ATA_TFLAG_OUT_LBAM)
+		hwif->OUTB(tf->lbam,		IDE_LCYL_REG);
+	if (tf->flags & ATA_TFLAG_OUT_LBAH)
+		hwif->OUTB(tf->lbah,		IDE_HCYL_REG);
+
+	/* Load data.  This is for the brain-damaged TASKFILE ioctl. */
+	if (task->load_data)
+		hwif->OUTW(task->data,		IDE_DATA_REG);
+}
+EXPORT_SYMBOL(ide_load_taskfile);
+
+void ide_read_taskfile(ide_drive_t *drive, ide_task_t *task, u8 stat, u8 err)
+{
+	struct ata_taskfile *tf = &task->tf;
+	ide_hwif_t *hwif = drive->hwif;
+
+	/* Read HOB registers first such that the HOB bit in the control
+	   register stays cleared when we leave this function. */
+	if (tf->flags & ATA_TFLAG_IN_LBA48) {
+		hwif->OUTB(drive->ctl | ATA_HOB, IDE_CONTROL_REG);
+
+		if (tf->flags & ATA_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature	= hwif->INB(IDE_FEATURE_REG);
+		if (tf->flags & ATA_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect	= hwif->INB(IDE_NSECTOR_REG);
+		if (tf->flags & ATA_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal	= hwif->INB(IDE_SECTOR_REG);
+		if (tf->flags & ATA_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam	= hwif->INB(IDE_LCYL_REG);
+		if (tf->flags & ATA_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah	= hwif->INB(IDE_HCYL_REG);
+
+		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	}
+
+	if (tf->flags & ATA_TFLAG_IN_FEATURE)
+		tf->feature	= err;
+	if (tf->flags & ATA_TFLAG_IN_NSECT)
+		tf->nsect	= hwif->INB(IDE_NSECTOR_REG);
+	if (tf->flags & ATA_TFLAG_IN_LBAL)
+		tf->lbal	= hwif->INB(IDE_SECTOR_REG);
+	if (tf->flags & ATA_TFLAG_IN_LBAM)
+		tf->lbam	= hwif->INB(IDE_LCYL_REG);
+	if (tf->flags & ATA_TFLAG_IN_LBAH)
+		tf->lbah	= hwif->INB(IDE_HCYL_REG);
+
+	if (tf->flags & ATA_TFLAG_IN_DEVICE)
+		tf->device	= hwif->INB(IDE_SELECT_REG);
+
+	tf->command = stat;
+
+	/* And, for the braindamaged TASKFILE ioctl. */
+	if (task->read_data)
+		task->data	= hwif->INW(IDE_DATA_REG);
+}
+
 static void ata_bswap_data (void *buffer, int wcount)
 {
 	u16 *p = buffer;
@@ -104,7 +190,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct ata_taskfile *tf = &task->tf;
-	u8 HIHI			= (tf->flags & ATA_TFLAG_LBA48) ? 0xE0 : 0xEF;
+	u8 HIHI			= (tf->flags & ATA_TFLAG_IDE_LBA48) ? 0xE0 : 0xEF;
 
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
@@ -113,21 +199,13 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	}
 	SELECT_MASK(drive, 0);
 
-	if (tf->flags & ATA_TFLAG_LBA48) {
-		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
-		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
-		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
-		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
-		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-	}
-
-	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
+	if (tf->flags & ATA_TFLAG_IDE_LBA48)
+		tf->flags |= ATA_TFLAG_OUT_LBA48;
+	tf->flags |= ATA_TFLAG_OUT_ADDR;
+	tf->flags |= ATA_TFLAG_OUT_DEVICE;
+	tf->device = (tf->device & HIHI) | (drive->select.all & 0xBF);
 
-	hwif->OUTB((tf->device & HIHI) | (drive->select.all & 0xBF), IDE_SELECT_REG);
+	ide_load_taskfile(drive, task);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
@@ -383,7 +461,7 @@ static void task_end_request(ide_drive_t
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *task = rq->special;
 
-		if (task->tf_out_flags.all) {
+		if (task->tf.flags & ATA_TFLAG_IDE_FLAGGED) {
 			u8 err = drive->hwif->INB(IDE_ERROR_REG);
 			ide_end_drive_cmd(drive, stat, err);
 			return;
@@ -596,14 +674,46 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	tf->device	= req_task->io_ports[6];
 	tf->command	= req_task->io_ports[7];
 
-	args.tf_in_flags  = req_task->in_flags;
-	args.tf_out_flags = req_task->out_flags;
+	/* Translate out/in flags. */
+	if (req_task->out_flags.all)
+		tf->flags |= ATA_TFLAG_IDE_FLAGGED;
+
+	if (req_task->out_flags.b.error_feature_hob)
+		tf->flags |= ATA_TFLAG_OUT_HOB_FEATURE;
+	if (req_task->out_flags.b.nsector_hob)
+		tf->flags |= ATA_TFLAG_OUT_HOB_NSECT;
+	if (req_task->out_flags.b.sector_hob)
+		tf->flags |= ATA_TFLAG_OUT_HOB_LBAL;
+	if (req_task->out_flags.b.lcyl_hob)
+		tf->flags |= ATA_TFLAG_OUT_HOB_LBAM;
+	if (req_task->out_flags.b.hcyl_hob)
+		tf->flags |= ATA_TFLAG_OUT_HOB_LBAH;
+
+	if (req_task->out_flags.b.error_feature)
+		tf->flags |= ATA_TFLAG_OUT_FEATURE;
+	if (req_task->out_flags.b.nsector)
+		tf->flags |= ATA_TFLAG_OUT_NSECT;
+	if (req_task->out_flags.b.sector)
+		tf->flags |= ATA_TFLAG_OUT_LBAL;
+	if (req_task->out_flags.b.lcyl)
+		tf->flags |= ATA_TFLAG_OUT_LBAM;
+	if (req_task->out_flags.b.hcyl)
+		tf->flags |= ATA_TFLAG_OUT_LBAH;
+
+	if (req_task->out_flags.b.select)
+		tf->flags |= ATA_TFLAG_OUT_DEVICE;
+	if (req_task->out_flags.b.data)
+		args.load_data = 1;
+
+	if (req_task->in_flags.b.data)
+		args.read_data = 1;
+
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
-	tf->flags = ATA_TFLAG_IO_16BIT;
+	tf->flags |= ATA_TFLAG_IO_16BIT;
 	if (drive->addressing == 1)
-		tf->flags |= ATA_TFLAG_LBA48;
+		tf->flags |= ATA_TFLAG_IDE_LBA48;
 
 	if (drive->select.b.lba)
 		tf->device |= ATA_LBA;
@@ -672,9 +782,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	req_task->io_ports[6] = tf->device;
 	req_task->io_ports[7] = tf->command;
 
-	req_task->in_flags  = args.tf_in_flags;
-	req_task->out_flags = args.tf_out_flags;
-
 	if (copy_to_user(buf, req_task, tasksize)) {
 		err = -EFAULT;
 		goto abort;
@@ -838,76 +945,19 @@ ide_startstop_t flagged_taskfile (ide_dr
 		}
 	}
 
-	/*
-	 * (ks) Check taskfile in/out flags.
-	 * If set, then execute as it is defined.
-	 * If not set, then define default settings.
-	 * The default values are:
-	 *	write and read all taskfile registers (except data) 
-	 *	write and read the hob registers (sector,nsector,lcyl,hcyl)
-	 */
-	if (task->tf_out_flags.all == 0) {
-		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
-        }
-
-	if (task->tf_in_flags.all == 0) {
-		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
-        }
-
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG)
 		/* clear nIEN */
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	SELECT_MASK(drive, 0);
 
-#if DEBUG_TASKFILE
-	status = hwif->INB(IDE_STATUS_REG);
-	if (status & 0x80) {
-		printk("flagged_taskfile -> Bad status. Status = %02x. wait 100 usec ...\n", status);
-		udelay(100);
-		status = hwif->INB(IDE_STATUS_REG);
-		printk("flagged_taskfile -> Status = %02x\n", status);
-	}
-#endif
+	/* Adjust task. */
+	tf->flags &= ~ATA_TFLAG_OUT_HOB_FEATURE;
+	tf->flags |= ATA_TFLAG_OUT_DEVICE;
+	tf->device |= drive->select.all & 0xBF;
 
-	if (task->tf_out_flags.b.data)
-		hwif->OUTW(task->data, IDE_DATA_REG);
+	ide_load_taskfile(drive, task);
 
-	/* (ks) send hob registers first */
-	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
-	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-
-	/* (ks) Send now the standard registers */
-	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	/* refers to number of sectors to transfer */
-	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	/* refers to sector offset or start sector */
-	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
-
-        /*
-	 * (ks) In the flagged taskfile approch, we will use all specified
-	 * registers and the register value will not be changed, except the
-	 * select bit (master/slave) in the drive_head register. We must make
-	 * sure that the desired drive is selected.
-	 */
-	hwif->OUTB(tf->device | (drive->select.all & 0xBF), IDE_SELECT_REG);
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
Index: linux-taskfile-ng/include/linux/ata.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ata.h	2005-03-05 10:37:51.739348441 +0900
+++ linux-taskfile-ng/include/linux/ata.h	2005-03-05 10:46:58.316077220 +0900
@@ -168,11 +168,67 @@ enum {
 	SCR_NOTIFICATION	= 4,
 
 	/* struct ata_taskfile flags */
-	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
-	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
-	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
-	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
-	ATA_TFLAG_IO_16BIT	= (1 << 4), /* force 16bit pio */
+	ATA_TFLAG_OUT_FEATURE	= (1 <<  0),
+	ATA_TFLAG_OUT_NSECT	= (1 <<  1),
+	ATA_TFLAG_OUT_LBAL	= (1 <<  2),
+	ATA_TFLAG_OUT_LBAM	= (1 <<  3),
+	ATA_TFLAG_OUT_LBAH	= (1 <<  4),
+	ATA_TFLAG_OUT_HOB_FEATURE = (1 <<  5),
+	ATA_TFLAG_OUT_HOB_NSECT	= (1 <<  6),
+	ATA_TFLAG_OUT_HOB_LBAL	= (1 <<  7),
+	ATA_TFLAG_OUT_HOB_LBAM	= (1 <<  8),
+	ATA_TFLAG_OUT_HOB_LBAH	= (1 <<  9),
+	ATA_TFLAG_OUT_DEVICE	= (1 << 10),
+
+	ATA_TFLAG_IN_FEATURE	= (1 << 11),
+	ATA_TFLAG_IN_NSECT	= (1 << 12),
+	ATA_TFLAG_IN_LBAL	= (1 << 13),
+	ATA_TFLAG_IN_LBAM	= (1 << 14),
+	ATA_TFLAG_IN_LBAH	= (1 << 15),
+	ATA_TFLAG_IN_HOB_FEATURE = (1 << 16),
+	ATA_TFLAG_IN_HOB_NSECT	= (1 << 17),
+	ATA_TFLAG_IN_HOB_LBAL	= (1 << 18),
+	ATA_TFLAG_IN_HOB_LBAM	= (1 << 19),
+	ATA_TFLAG_IN_HOB_LBAH	= (1 << 20),
+	ATA_TFLAG_IN_DEVICE	= (1 << 21),
+
+	/* The following four aggreate flags are used by IDE to control
+	   register IO. */
+	ATA_TFLAG_OUT_LBA48	= (ATA_TFLAG_OUT_HOB_FEATURE	|
+				   ATA_TFLAG_OUT_HOB_NSECT	|
+				   ATA_TFLAG_OUT_HOB_LBAL	|
+				   ATA_TFLAG_OUT_HOB_LBAM	|
+				   ATA_TFLAG_OUT_HOB_LBAH	),
+	ATA_TFLAG_OUT_ADDR	= (ATA_TFLAG_OUT_FEATURE	|
+				   ATA_TFLAG_OUT_NSECT		|
+				   ATA_TFLAG_OUT_LBAL		|
+				   ATA_TFLAG_OUT_LBAM		|
+				   ATA_TFLAG_OUT_LBAH		),
+	ATA_TFLAG_IN_LBA48	= (ATA_TFLAG_IN_HOB_FEATURE	|
+				   ATA_TFLAG_IN_HOB_NSECT	|
+				   ATA_TFLAG_IN_HOB_LBAL	|
+				   ATA_TFLAG_IN_HOB_LBAM	|
+				   ATA_TFLAG_IN_HOB_LBAH	),
+	ATA_TFLAG_IN_ADDR	= (ATA_TFLAG_IN_FEATURE		|
+				   ATA_TFLAG_IN_NSECT		|
+				   ATA_TFLAG_IN_LBAL		|
+				   ATA_TFLAG_IN_LBAM		|
+				   ATA_TFLAG_IN_LBAH		),
+
+	/* These three aggregate flags are used by libata, as it doesn't
+	   really need to optimize register INs */
+	ATA_TFLAG_LBA48		= (ATA_TFLAG_OUT_LBA48  | ATA_TFLAG_IN_LBA48 ),
+	ATA_TFLAG_ISADDR	= (ATA_TFLAG_OUT_ADDR   | ATA_TFLAG_IN_ADDR  ),
+	ATA_TFLAG_DEVICE	= (ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_DEVICE),
+
+	ATA_TFLAG_WRITE		= (1 << 22), /* data dir */
+	ATA_TFLAG_IO_16BIT	= (1 << 23), /* force 16bit PIO (IDE) */
+
+	/* Following two flags are just to ease migration to the new
+	   taskfile implementation.  They will go away as soon as the
+	   transition is complete. */
+	ATA_TFLAG_IDE_FLAGGED	= (1 << 24),
+	ATA_TFLAG_IDE_LBA48	= (1 << 25),
 };
 
 enum ata_tf_protocols {
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:37:51.739348441 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:46:58.318076908 +0900
@@ -927,8 +927,8 @@ typedef int (ide_expiry_t)(ide_drive_t *
 typedef struct ide_task_s {
 	struct ata_taskfile	tf;
 	u16			data;
-	ide_reg_valid_t		tf_out_flags;
-	ide_reg_valid_t		tf_in_flags;
+	unsigned		load_data:1;
+	unsigned		read_data:1;
 	int			data_phase;
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
@@ -1276,6 +1276,12 @@ extern int drive_is_ready(ide_drive_t *)
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
 /*
+ * Taskfile load/read functions
+ */
+void ide_load_taskfile(ide_drive_t *drive, ide_task_t *task);
+void ide_read_taskfile(ide_drive_t *drive, ide_task_t *task, u8 stat, u8 err);
+
+/*
  * taskfile io for disks for now...and builds request from ide_ioctl
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
