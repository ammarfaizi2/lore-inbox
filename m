Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbVCECWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbVCECWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbVCECO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:14:29 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:41106 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263640AbVCEBsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=DjfMnNyLiNGsFebRs8hH3M7FMN6ZYe7D+b+XrnojdaBHgdr+w9iiJ/cAShjR83elcoVVB7QT2dBL4qM7b9vcoW6TZuuH4HlM7NYj/F7XyxLvGn/rbV4dV2QsE0JyiCKI2t4mfJYMCQiKogSoYV9RCzqbTLYplM79qi5o67iyS/4=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 03/08] ide: remove flagged_taskfile() and unify taskfile paths
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014808.822445CF@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:13 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03_ide_remove_flagged_taskfile.patch

	This patch removes flagged_taskfile().  All taskfile command
	issuing goes through do_rw_taskfile().  do_rw_taskfile()
	doesn't modify mangle with load flags anymore.  It's now
	caller's responsibility to set appropriate flags.  Likewise,
	ide_end_drive_cmd() is modified not to mangle with read flags,
	and ide_dma_intr() now also finishes commands with
	task_end_request().  Above changes make taskfile path unified
	& generic.

	As all ioctl subtleties are now responsibility of respective
	ioctl functions.  TASKFILE and TASK ioctl functions are
	updated to set flags according to old behaviors.  The
	following two behavior changes occur.

	* TASKFILE ioctl: taskfile registers are read back whether or
	  not the command fails.  As copying back to user doesn't
	  happen in cases where reading back didn't occur before, this
	  change isn't user-visible.  Defining & using a flag like
	  ATA_TFLAG_READ_ON_ERROR will remove this issue.
	* TASK ioctl: drive->select.all & ~ATA_LBA is OR'd to device
	  value.  Previously, only ATA_DEV bit was OR'd.

	Also, all ide_{raw|diag}_taskfile(), do_rw_taskfile() users
	are converted to use the new individual OUT/IN flags.  As
	results, the following behavior changes occur.

	* idedisk_read_native_max_address(): ADDR/LBA48 regs are not
	  loaded.  LBA48/DEVICE registers are not read back unless
	  necessary.
	* idedisk_set_max_address(): DEVICE register is not read
	  unless necessary.
	* smart_enable(): DEVICE register is not loaded.  Registers
	  are not read back.
	* smart_disable(): ditto
	* get_smart_threshold(): DEVICE register is not loaded.
	* ide_task_init_flush(): ADDR/LBA48/DEVICE registers are not
	  loaded.
	* ide_init_specify_cmd(): Register aren't read back.
	* ide_init_restore_cmd(): DEVICE register not loaded.  No read back.
	* ide_init_setmult_cmd(): ditto

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c     |   31 ++---
 drivers/ide/ide-dma.c      |   16 --
 drivers/ide/ide-io.c       |   21 +--
 drivers/ide/ide-taskfile.c |  263 +++++++++++++++++----------------------------
 include/linux/ata.h        |    6 -
 include/linux/ide.h        |    6 -
 6 files changed, 136 insertions(+), 207 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-disk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-disk.c	2005-03-05 10:46:58.762007508 +0900
+++ linux-taskfile-ng/drivers/ide/ide-disk.c	2005-03-05 10:46:59.081957489 +0900
@@ -301,21 +301,22 @@ static u64 idedisk_read_native_max_addre
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 
-	tf->device	= 0x40;
+	tf->flags	= ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_ADDR;
+	tf->device	= ATA_LBA;
 	if (lba48) {
+		tf->flags |= ATA_TFLAG_IN_LBA48;
 		tf->command = WIN_READ_NATIVE_MAX_EXT;
-		tf->flags |= ATA_TFLAG_IDE_LBA48;
-	} else
+	} else {
+		tf->flags |= ATA_TFLAG_IN_DEVICE;
 		tf->command = WIN_READ_NATIVE_MAX;
+	}
 
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 
         /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((tf->command & 1) == 0) {
+	if (ide_raw_taskfile(drive, &args, NULL) == 0) {
+		/* if OK, compute maximum address value */
 		addr = ide_tf_get_address(drive, tf);
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
@@ -336,19 +337,20 @@ static u64 idedisk_set_max_address(ide_d
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->flags	= ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_ISADDR;
+	tf->device	= ATA_LBA;
 	tf->lbal	= addr_req;
 	tf->lbam	= addr_req >> 8;
 	tf->lbah	= addr_req >> 16;
 	if (lba48) {
+		tf->flags	|= ATA_TFLAG_LBA48;
 		tf->hob_lbal	= addr_req >> 24;
 		tf->hob_lbam	= addr_req >> 32;
 		tf->hob_lbah	= addr_req >> 40;
-		tf->device	= 0x40;
 		tf->command	= WIN_SET_MAX_EXT;
-
-		tf->flags |= ATA_TFLAG_IDE_LBA48;
 	} else {
-		tf->device	= ((addr_req >> 24) & 0xf) | 0x40;
+		tf->flags	|= ATA_TFLAG_IN_DEVICE;
+		tf->device	|= (addr_req >> 24) & 0xf;
 		tf->command	= WIN_SET_MAX;
 	}
 
@@ -356,9 +358,7 @@ static u64 idedisk_set_max_address(ide_d
 	args.handler				= &task_no_data_intr;
 
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, compute maximum address value */
-	if ((tf->command & 1) == 0) {
+	if (ide_raw_taskfile(drive, &args, NULL) == 0) {
 		addr_set = ide_tf_get_address(drive, tf);
 		addr_set++;
 	}
@@ -474,6 +474,7 @@ static int smart_enable(ide_drive_t *dri
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_ENABLE;
 	tf->lbam	= SMART_LCYL_PASS;
 	tf->lbah	= SMART_HCYL_PASS;
@@ -491,6 +492,7 @@ static int get_smart_values(ide_drive_t 
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_READ_VALUES;
 	tf->nsect	= 1;
 	tf->lbam	= SMART_LCYL_PASS;
@@ -511,6 +513,7 @@ static int get_smart_thresholds(ide_driv
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_READ_THRESHOLDS;
 	tf->nsect	= 1;
 	tf->lbam	= SMART_LCYL_PASS;
Index: linux-taskfile-ng/drivers/ide/ide-dma.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-05 10:46:58.188097228 +0900
+++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-05 10:46:59.082957333 +0900
@@ -168,21 +168,15 @@ static int in_drive_list(struct hd_drive
  
 ide_startstop_t ide_dma_intr (ide_drive_t *drive)
 {
-	u8 stat = 0, dma_stat = 0;
+	u8 stat, dma_stat;
 
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	dma_stat = HWIF(drive)->ide_dma_end(drive);
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);	/* get drive status */
-	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+
+	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-
-			if (rq->rq_disk) {
-				ide_driver_t *drv;
-
-				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
-				drv->end_request(drive, 1, rq->nr_sectors);
-			} else
-				ide_end_request(drive, 1, rq->nr_sectors);
+			task_end_request(drive, rq, stat);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
Index: linux-taskfile-ng/drivers/ide/ide-io.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-io.c	2005-03-05 10:46:58.307078627 +0900
+++ linux-taskfile-ng/drivers/ide/ide-io.c	2005-03-05 10:46:59.084957020 +0900
@@ -61,10 +61,12 @@ void ide_task_init_flush(ide_drive_t *dr
 
 	memset(task, 0, sizeof(*task));
 
+	tf->flags = ATA_TFLAG_IN_ADDR | ATA_TFLAG_IN_DEVICE;
+
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28))) {
 		tf->command = WIN_FLUSH_CACHE_EXT;
-		tf->flags |= ATA_TFLAG_IDE_LBA48;
+		tf->flags |= ATA_TFLAG_IN_LBA48;
 	} else
 		tf->command = WIN_FLUSH_CACHE;
 
@@ -322,7 +324,7 @@ u64 ide_tf_get_address(ide_drive_t *driv
 {
 	u32 high, low;
 
-	if (tf->flags & ATA_TFLAG_IDE_LBA48) {
+	if (tf->flags & ATA_TFLAG_IN_LBA48) {
 		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
 		low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 	} else {
@@ -455,14 +457,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-			
-		if (args) {
-			struct ata_taskfile *tf = &args->tf;
-			tf->flags |= ATA_TFLAG_IN_ADDR | ATA_TFLAG_IN_DEVICE;
-			if (tf->flags & ATA_TFLAG_IDE_LBA48)
-				tf->flags |= ATA_TFLAG_IN_LBA48;
+		if (args)
 			ide_read_taskfile(drive, args, stat, err);
-		}
 	} else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
 		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
@@ -759,11 +755,12 @@ static void ide_init_specify_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR | ATA_TFLAG_OUT_DEVICE;
 	tf->nsect	= drive->sect;
 	tf->lbal	= drive->sect;
 	tf->lbam	= drive->cyl;
 	tf->lbah	= drive->cyl >> 8;
-	tf->device	= ((drive->head - 1) | drive->select.all) & 0xBF;
+	tf->device	= drive->head - 1;
 	tf->command	= WIN_SPECIFY;
 
 	task->handler = &set_geometry_intr;
@@ -773,6 +770,7 @@ static void ide_init_restore_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->nsect	= drive->sect;
 	tf->command	= WIN_RESTORE;
 
@@ -783,6 +781,7 @@ static void ide_init_setmult_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->nsect	= drive->mult_req;
 	tf->command	= WIN_SETMULT;
 
@@ -914,8 +913,6 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (args->tf.flags & ATA_TFLAG_IDE_FLAGGED)
-			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
 	} else if (rq->flags & REQ_DRIVE_CMD) {
 		u8 *args = rq->buffer;
Index: linux-taskfile-ng/drivers/ide/ide-taskfile.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-taskfile.c	2005-03-05 10:46:58.315077377 +0900
+++ linux-taskfile-ng/drivers/ide/ide-taskfile.c	2005-03-05 10:46:59.092955770 +0900
@@ -186,25 +186,28 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t do_rw_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
+	ide_hwif_t *hwif = drive->hwif;
 	struct ata_taskfile *tf = &task->tf;
-	u8 HIHI			= (tf->flags & ATA_TFLAG_IDE_LBA48) ? 0xE0 : 0xEF;
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG) {
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	/* We check this in ide_taskfile_ioctl(), but the setting could
+	   have been changed inbetween. */
+	if ((task->data_phase == TASKFILE_MULTI_IN ||
+	     task->data_phase == TASKFILE_MULTI_OUT) && !drive->mult_count) {
+		printk(KERN_ERR "%s: multimode not set!\n",
+		       drive->name);
+		/* FIXME: this path is an infinite loop. */
+		return ide_stopped;
 	}
-	SELECT_MASK(drive, 0);
 
-	if (tf->flags & ATA_TFLAG_IDE_LBA48)
-		tf->flags |= ATA_TFLAG_OUT_LBA48;
-	tf->flags |= ATA_TFLAG_OUT_ADDR;
-	tf->flags |= ATA_TFLAG_OUT_DEVICE;
-	tf->device = (tf->device & HIHI) | (drive->select.all & 0xBF);
+	/* ALL Command Block Executions SHALL clear nIEN. */
+	if (IDE_CONTROL_REG)
+		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	SELECT_MASK(drive, 0);
 
+	if (tf->flags & ATA_TFLAG_OUT_DEVICE)
+		tf->device |= drive->select.all & ~ATA_LBA;
 	ide_load_taskfile(drive, task);
 
 	if (task->handler != NULL) {
@@ -213,33 +216,25 @@ ide_startstop_t do_rw_taskfile (ide_driv
 			ndelay(400);	/* FIXME */
 			return task->prehandler(drive, task->rq);
 		}
-		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
+		ide_execute_command(drive, tf->command, task->handler,
+				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
-	if (!drive->using_dma)
+	switch (task->data_phase) {
+	case TASKFILE_OUT_DMAQ:
+	case TASKFILE_OUT_DMA:
+	case TASKFILE_IN_DMAQ:
+	case TASKFILE_IN_DMA:
+		if (!hwif->dma_setup(drive)) {
+			hwif->dma_exec_cmd(drive, tf->command);
+			hwif->dma_start(drive);
+			return ide_started;
+		}
+		return ide_stopped;
+	default:
 		return ide_stopped;
-
-	switch (tf->command) {
-		case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_EXT:
-		case WIN_READDMA_ONCE:
-		case WIN_READDMA:
-		case WIN_READDMA_EXT:
-		case WIN_IDENTIFY_DMA:
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, tf->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
-		default:
-			if (task->handler == NULL)
-				return ide_stopped;
 	}
-
-	return ide_stopped;
 }
 
 EXPORT_SYMBOL(do_rw_taskfile);
@@ -302,7 +297,7 @@ ide_startstop_t recal_intr (ide_drive_t 
 /*
  * Handler for commands without a data phase
  */
-ide_startstop_t task_no_data_intr (ide_drive_t *drive)
+ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 {
 	ide_task_t *args	= HWGROUP(drive)->rq->special;
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -456,19 +451,16 @@ static ide_startstop_t task_error(ide_dr
 	return ide_error(drive, s, stat);
 }
 
-static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *task = rq->special;
-
-		if (task->tf.flags & ATA_TFLAG_IDE_FLAGGED) {
-			u8 err = drive->hwif->INB(IDE_ERROR_REG);
-			ide_end_drive_cmd(drive, stat, err);
-			return;
-		}
+		u8 err = drive->hwif->INB(IDE_ERROR_REG);
+		ide_end_drive_cmd(drive, stat, err);
+		return;
+	} else {
+		ide_driver_t *drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+		drv->end_request(drive, 1, rq->hard_nr_sectors);
 	}
-
-	ide_end_request(drive, 1, rq->hard_nr_sectors);
 }
 
 /*
@@ -674,49 +666,58 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	tf->device	= req_task->io_ports[6];
 	tf->command	= req_task->io_ports[7];
 
-	/* Translate out/in flags. */
-	if (req_task->out_flags.all)
-		tf->flags |= ATA_TFLAG_IDE_FLAGGED;
-
-	if (req_task->out_flags.b.error_feature_hob)
-		tf->flags |= ATA_TFLAG_OUT_HOB_FEATURE;
-	if (req_task->out_flags.b.nsector_hob)
-		tf->flags |= ATA_TFLAG_OUT_HOB_NSECT;
-	if (req_task->out_flags.b.sector_hob)
-		tf->flags |= ATA_TFLAG_OUT_HOB_LBAL;
-	if (req_task->out_flags.b.lcyl_hob)
-		tf->flags |= ATA_TFLAG_OUT_HOB_LBAM;
-	if (req_task->out_flags.b.hcyl_hob)
-		tf->flags |= ATA_TFLAG_OUT_HOB_LBAH;
-
-	if (req_task->out_flags.b.error_feature)
-		tf->flags |= ATA_TFLAG_OUT_FEATURE;
-	if (req_task->out_flags.b.nsector)
-		tf->flags |= ATA_TFLAG_OUT_NSECT;
-	if (req_task->out_flags.b.sector)
-		tf->flags |= ATA_TFLAG_OUT_LBAL;
-	if (req_task->out_flags.b.lcyl)
-		tf->flags |= ATA_TFLAG_OUT_LBAM;
-	if (req_task->out_flags.b.hcyl)
-		tf->flags |= ATA_TFLAG_OUT_LBAH;
+	/* Translate & adjust flags */
+	tf->flags |= ATA_TFLAG_OUT_DEVICE;
+	tf->flags |= ATA_TFLAG_IN_ADDR | ATA_TFLAG_IN_DEVICE;
+
+	if (drive->addressing == 1)
+		tf->flags |= ATA_TFLAG_IN_LBA48;
+
+	if (req_task->out_flags.all) {
+		/* out_flags.b.error_feature_hob is ignored */
+		if (req_task->out_flags.b.nsector_hob)
+			tf->flags |= ATA_TFLAG_OUT_HOB_NSECT;
+		if (req_task->out_flags.b.sector_hob)
+			tf->flags |= ATA_TFLAG_OUT_HOB_LBAL;
+		if (req_task->out_flags.b.lcyl_hob)
+			tf->flags |= ATA_TFLAG_OUT_HOB_LBAM;
+		if (req_task->out_flags.b.hcyl_hob)
+			tf->flags |= ATA_TFLAG_OUT_HOB_LBAH;
+
+		if (req_task->out_flags.b.error_feature)
+			tf->flags |= ATA_TFLAG_OUT_FEATURE;
+		if (req_task->out_flags.b.nsector)
+			tf->flags |= ATA_TFLAG_OUT_NSECT;
+		if (req_task->out_flags.b.sector)
+			tf->flags |= ATA_TFLAG_OUT_LBAL;
+		if (req_task->out_flags.b.lcyl)
+			tf->flags |= ATA_TFLAG_OUT_LBAM;
+		if (req_task->out_flags.b.hcyl)
+			tf->flags |= ATA_TFLAG_OUT_LBAH;
+
+		/* FIXME: tf->device isn't filtered to keep the old
+		   behavior, so TASKFILE ioctl can issue commands to
+		   slave with permissions to master. */
+	} else {
+		tf->flags |= ATA_TFLAG_OUT_ADDR;
+		if (drive->addressing == 1)
+			tf->flags |= ATA_TFLAG_OUT_LBA48;
+
+		/* FIXME: The DEV bit is filtered when no out_flags is
+		   set, but other drives still can be selected on
+		   four-drive-per-port chipsets. */
+		tf->device &= drive->addressing == 1 ? 0xE0 : 0xEF;
+	}
 
-	if (req_task->out_flags.b.select)
-		tf->flags |= ATA_TFLAG_OUT_DEVICE;
 	if (req_task->out_flags.b.data)
 		args.load_data = 1;
-
 	if (req_task->in_flags.b.data)
 		args.read_data = 1;
 
-	args.data_phase   = req_task->data_phase;
-	args.command_type = req_task->req_cmd;
-
 	tf->flags |= ATA_TFLAG_IO_16BIT;
-	if (drive->addressing == 1)
-		tf->flags |= ATA_TFLAG_IDE_LBA48;
 
-	if (drive->select.b.lba)
-		tf->device |= ATA_LBA;
+	args.data_phase   = req_task->data_phase;
+	args.command_type = req_task->req_cmd;
 
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
@@ -765,22 +766,25 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			goto abort;
 	}
 
-	req_task->io_ports[0]	= args.data;
-	req_task->hob_ports[0]	= args.data << 8;
-
-	req_task->hob_ports[1] = tf->hob_feature;
-	req_task->hob_ports[2] = tf->hob_nsect;
-	req_task->hob_ports[3] = tf->hob_lbal;
-	req_task->hob_ports[4] = tf->hob_lbam;
-	req_task->hob_ports[5] = tf->hob_lbah;
-
-	req_task->io_ports[1] = tf->feature;
-	req_task->io_ports[2] = tf->nsect;
-	req_task->io_ports[3] = tf->lbal;
-	req_task->io_ports[4] = tf->lbam;
-	req_task->io_ports[5] = tf->lbah;
-	req_task->io_ports[6] = tf->device;
-	req_task->io_ports[7] = tf->command;
+	if (req_task->data_phase == TASKFILE_NO_DATA ||
+	    req_task->out_flags.all || err) {
+		req_task->io_ports[0]	= args.data;
+		req_task->hob_ports[0]	= args.data << 8;
+
+		req_task->hob_ports[1]	= tf->hob_feature;
+		req_task->hob_ports[2]	= tf->hob_nsect;
+		req_task->hob_ports[3]	= tf->hob_lbal;
+		req_task->hob_ports[4]	= tf->hob_lbam;
+		req_task->hob_ports[5]	= tf->hob_lbah;
+
+		req_task->io_ports[1]	= tf->feature;
+		req_task->io_ports[2]	= tf->nsect;
+		req_task->io_ports[3]	= tf->lbal;
+		req_task->io_ports[4]	= tf->lbam;
+		req_task->io_ports[5]	= tf->lbah;
+		req_task->io_ports[6]	= tf->device;
+		req_task->io_ports[7]	= tf->command;
+	}
 
 	if (copy_to_user(buf, req_task, tasksize)) {
 		err = -EFAULT;
@@ -897,13 +901,15 @@ int ide_task_ioctl(ide_drive_t *drive, u
 
 	memset(&task, 0, sizeof(task));
 
+	tf->flags	= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+
 	tf->command	= args[0];
 	tf->feature	= args[1];
 	tf->nsect	= args[2];
 	tf->lbal	= args[3];
 	tf->lbam	= args[4];
 	tf->lbah	= args[5];
-	tf->device	= args[6];
+	tf->device	= args[6] & ~ATA_DEV1;
 
 	task.command_type = IDE_DRIVE_TASK_NO_DATA;
 	task.data_phase = TASKFILE_NO_DATA;
@@ -923,64 +929,3 @@ int ide_task_ioctl(ide_drive_t *drive, u
 		err = -EFAULT;
 	return err;
 }
-
-/*
- * NOTICE: This is additions from IBM to provide a discrete interface,
- * for selective taskregister access operations.  Nice JOB Klaus!!!
- * Glad to be able to work and co-develop this with you and IBM.
- */
-ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct ata_taskfile *tf = &task->tf;
-#if DEBUG_TASKFILE
-	u8 status;
-#endif
-
-	if (task->data_phase == TASKFILE_MULTI_IN ||
-	    task->data_phase == TASKFILE_MULTI_OUT) {
-		if (!drive->mult_count) {
-			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
-			return ide_stopped;
-		}
-	}
-
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG)
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	SELECT_MASK(drive, 0);
-
-	/* Adjust task. */
-	tf->flags &= ~ATA_TFLAG_OUT_HOB_FEATURE;
-	tf->flags |= ATA_TFLAG_OUT_DEVICE;
-	tf->device |= drive->select.all & 0xBF;
-
-	ide_load_taskfile(drive, task);
-
-	switch(task->data_phase) {
-
-   	        case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			hwif->dma_setup(drive);
-			hwif->dma_exec_cmd(drive, tf->command);
-			hwif->dma_start(drive);
-			break;
-
-	        default:
- 			if (task->handler == NULL)
-				return ide_stopped;
-
-			/* Issue the command */
-			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
-				ndelay(400);	/* FIXME */
-				return task->prehandler(drive, task->rq);
-			}
-			ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
-	}
-
-	return ide_started;
-}
Index: linux-taskfile-ng/include/linux/ata.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ata.h	2005-03-05 10:46:58.316077220 +0900
+++ linux-taskfile-ng/include/linux/ata.h	2005-03-05 10:46:59.093955614 +0900
@@ -223,12 +223,6 @@ enum {
 
 	ATA_TFLAG_WRITE		= (1 << 22), /* data dir */
 	ATA_TFLAG_IO_16BIT	= (1 << 23), /* force 16bit PIO (IDE) */
-
-	/* Following two flags are just to ease migration to the new
-	   taskfile implementation.  They will go away as soon as the
-	   transition is complete. */
-	ATA_TFLAG_IDE_FLAGGED	= (1 << 24),
-	ATA_TFLAG_IDE_LBA48	= (1 << 25),
 };
 
 enum ata_tf_protocols {
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:46:58.318076908 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:46:59.095955301 +0900
@@ -1285,11 +1285,7 @@ void ide_read_taskfile(ide_drive_t *driv
  * taskfile io for disks for now...and builds request from ide_ioctl
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
-
-/*
- * Special Flagged Register Validation Caller
- */
-extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat);
 
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
