Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbVCECVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbVCECVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbVCECEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:04:40 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:53138 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263644AbVCEBs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=OF261lBcnRjj4jiunl54Mb/ZQFpQvg64cLc7VNghayYPjie01eVq9QgNDUu50ij7woz4M8jz8xymrlUpHMitcCSD5snUGigjsmXfPH3qwEizUoDsCPp82LXLgpiPLA7L73zqlhmvh+o/WCFdtbsoAswkL3VYYWOvMEmE3Ck3rac=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 05/08] ide: use ide_task_t->tf.protocol instead of ide_task_t->data_phase
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014818.A3D29D43@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:23 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


05_ide_use_protocol.patch

	Remove ide_task_t->{data_phase,command_type,prehandler,rq} and
	use tf->protocol instead.  Now the protocol value wholey
	defines how to drive a taskfile except for NODATA cases where
	a caller can optionally specify handler (for special
	commands).  The following behavior changes occur.

	* ide_taskfile_ioctl(): req_task->command_type is ignored.
	  This doesn't make any difference except for error/crash
	  cases in the original code.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c     |   70 +++++-------
 drivers/ide/ide-io.c       |   29 +----
 drivers/ide/ide-taskfile.c |  257 ++++++++++++++++++---------------------------
 include/linux/ide.h        |   11 -
 4 files changed, 142 insertions(+), 225 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-disk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-disk.c	2005-03-05 10:46:59.081957489 +0900
+++ linux-taskfile-ng/drivers/ide/ide-disk.c	2005-03-05 10:46:59.684863236 +0900
@@ -233,10 +233,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 
 	if (rq_data_dir(rq) == READ) {
 		if (drive->mult_count) {
-			hwif->data_phase = TASKFILE_MULTI_IN;
+			hwif->protocol = ATA_PROT_PIO_MULT;
 			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
 		} else {
-			hwif->data_phase = TASKFILE_IN;
+			hwif->protocol = ATA_PROT_PIO;
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
@@ -245,10 +245,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		return ide_started;
 	} else {
 		if (drive->mult_count) {
-			hwif->data_phase = TASKFILE_MULTI_OUT;
+			hwif->protocol = ATA_PROT_PIO_MULT;
 			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
 		} else {
-			hwif->data_phase = TASKFILE_OUT;
+			hwif->protocol = ATA_PROT_PIO;
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
 
@@ -301,6 +301,7 @@ static u64 idedisk_read_native_max_addre
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_ADDR;
 	tf->device	= ATA_LBA;
 	if (lba48) {
@@ -311,11 +312,8 @@ static u64 idedisk_read_native_max_addre
 		tf->command = WIN_READ_NATIVE_MAX;
 	}
 
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-
         /* submit command request */
-	if (ide_raw_taskfile(drive, &args, NULL) == 0) {
+	if (ide_raw_taskfile(drive, &args, 0, NULL) == 0) {
 		/* if OK, compute maximum address value */
 		addr = ide_tf_get_address(drive, tf);
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
@@ -337,6 +335,7 @@ static u64 idedisk_set_max_address(ide_d
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_ISADDR;
 	tf->device	= ATA_LBA;
 	tf->lbal	= addr_req;
@@ -354,11 +353,8 @@ static u64 idedisk_set_max_address(ide_d
 		tf->command	= WIN_SET_MAX;
 	}
 
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-
 	/* submit command request */
-	if (ide_raw_taskfile(drive, &args, NULL) == 0) {
+	if (ide_raw_taskfile(drive, &args, 0, NULL) == 0) {
 		addr_set = ide_tf_get_address(drive, tf);
 		addr_set++;
 	}
@@ -474,15 +470,14 @@ static int smart_enable(ide_drive_t *dri
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_ENABLE;
 	tf->lbam	= SMART_LCYL_PASS;
 	tf->lbah	= SMART_HCYL_PASS;
 	tf->command	= WIN_SMART;
 
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
+	return ide_raw_taskfile(drive, &args, 0, NULL);
 }
 
 static int get_smart_values(ide_drive_t *drive, u8 *buf)
@@ -490,8 +485,11 @@ static int get_smart_values(ide_drive_t 
 	ide_task_t args;
 	struct ata_taskfile *tf = &args.tf;
 
+	smart_enable(drive);
+
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_PIO;
 	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_READ_VALUES;
 	tf->nsect	= 1;
@@ -499,11 +497,7 @@ static int get_smart_values(ide_drive_t 
 	tf->lbah	= SMART_HCYL_PASS;
 	tf->command	= WIN_SMART;
 
-	args.command_type			= IDE_DRIVE_TASK_IN;
-	args.data_phase				= TASKFILE_IN;
-	args.handler				= &task_in_intr;
-	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
+	return ide_raw_taskfile(drive, &args, READ, buf);
 }
 
 static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
@@ -511,8 +505,11 @@ static int get_smart_thresholds(ide_driv
 	ide_task_t args;
 	struct ata_taskfile *tf = &args.tf;
 
+	smart_enable(drive);
+
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_PIO;
 	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->feature	= SMART_READ_THRESHOLDS;
 	tf->nsect	= 1;
@@ -520,11 +517,7 @@ static int get_smart_thresholds(ide_driv
 	tf->lbah	= SMART_HCYL_PASS;
 	tf->command	= WIN_SMART;
 
-	args.command_type			= IDE_DRIVE_TASK_IN;
-	args.data_phase				= TASKFILE_IN;
-	args.handler				= &task_in_intr;
-	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
+	return ide_raw_taskfile(drive, &args, READ, buf);
 }
 
 static int proc_idedisk_read_cache
@@ -673,13 +666,11 @@ static int write_cache(ide_drive_t *driv
 
 	memset(&args, 0, sizeof(ide_task_t));
 
-	tf->feature = arg ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	tf->command = WIN_SETFEATURES;
-
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
+	tf->protocol	= ATA_PROT_NODATA;
+	tf->feature	= arg ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
+	tf->command	= WIN_SETFEATURES;
 
-	err = ide_raw_taskfile(drive, &args, NULL);
+	err = ide_raw_taskfile(drive, &args, 0, NULL);
 	if (err)
 		return err;
 
@@ -694,14 +685,13 @@ static int set_acoustic (ide_drive_t *dr
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->feature	= arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
 	tf->nsect	= arg;
 	tf->command	= WIN_SETFEATURES;
 
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.handler	  = &task_no_data_intr;
-	ide_raw_taskfile(drive, &args, NULL);
 	drive->acoustic = arg;
+
 	return 0;
 }
 
@@ -884,7 +874,7 @@ static void ide_cacheflush_p(ide_drive_t
 
 	ide_task_init_flush(drive, &task);
 
-	if (ide_raw_taskfile(drive, &task, NULL))
+	if (ide_raw_taskfile(drive, &task, 0, NULL))
 		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
 }
 
@@ -984,16 +974,15 @@ static int idedisk_open(struct inode *in
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
+		args.tf.protocol = ATA_PROT_NODATA;
 		args.tf.command = WIN_DOORLOCK;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_raw_taskfile(drive, &args, 0, NULL))
 			drive->doorlocking = 0;
 	}
 	return 0;
@@ -1010,10 +999,9 @@ static int idedisk_release(struct inode 
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
+		args.tf.protocol = ATA_PROT_NODATA;
 		args.tf.command = WIN_DOORUNLOCK;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  = &task_no_data_intr;
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_raw_taskfile(drive, &args, 0, NULL))
 			drive->doorlocking = 0;
 	}
 	drive->usage--;
Index: linux-taskfile-ng/drivers/ide/ide-io.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-io.c	2005-03-05 10:46:59.084957020 +0900
+++ linux-taskfile-ng/drivers/ide/ide-io.c	2005-03-05 10:46:59.685863080 +0900
@@ -61,6 +61,7 @@ void ide_task_init_flush(ide_drive_t *dr
 
 	memset(task, 0, sizeof(*task));
 
+	tf->protocol = ATA_PROT_NODATA;
 	tf->flags = ATA_TFLAG_IN_ADDR | ATA_TFLAG_IN_DEVICE;
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
@@ -69,9 +70,6 @@ void ide_task_init_flush(ide_drive_t *dr
 		tf->flags |= ATA_TFLAG_IN_LBA48;
 	} else
 		tf->command = WIN_FLUSH_CACHE;
-
-	task->command_type = IDE_DRIVE_TASK_NO_DATA;
-	task->handler	   = &task_no_data_intr;
 }
 
 EXPORT_SYMBOL_GPL(ide_task_init_flush);
@@ -261,17 +259,13 @@ static ide_startstop_t ide_start_power_s
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
+		tf->protocol = ATA_PROT_NODATA;
 		tf->command = WIN_STANDBYNOW1;
-
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
+		tf->protocol = ATA_PROT_NODATA;
 		tf->command = WIN_IDLEIMMEDIATE;
-
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case ide_pm_restore_dma:	/* Resume step 2 (restore DMA) */
@@ -755,6 +749,7 @@ static void ide_init_specify_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_ADDR | ATA_TFLAG_OUT_DEVICE;
 	tf->nsect	= drive->sect;
 	tf->lbal	= drive->sect;
@@ -770,6 +765,7 @@ static void ide_init_restore_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->nsect	= drive->sect;
 	tf->command	= WIN_RESTORE;
@@ -781,6 +777,7 @@ static void ide_init_setmult_cmd(ide_dri
 {
 	struct ata_taskfile *tf = &task->tf;
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_OUT_ADDR;
 	tf->nsect	= drive->mult_req;
 	tf->command	= WIN_SETMULT;
@@ -794,7 +791,6 @@ static ide_startstop_t ide_disk_special(
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	if (s->b.set_geometry) {
 		s->b.set_geometry = 0;
@@ -900,19 +896,6 @@ static ide_startstop_t execute_drive_cmd
 		if (!args)
 			goto done;
 
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
 		return do_rw_taskfile(drive, args);
 	} else if (rq->flags & REQ_DRIVE_CMD) {
 		u8 *args = rq->buffer;
Index: linux-taskfile-ng/drivers/ide/ide-taskfile.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-taskfile.c	2005-03-05 10:46:59.092955770 +0900
+++ linux-taskfile-ng/drivers/ide/ide-taskfile.c	2005-03-05 10:46:59.686862923 +0900
@@ -6,25 +6,6 @@
  *  Copyright (C) 2001-2002	Klaus Smolin
  *					IBM Storage Technology Division
  *  Copyright (C) 2003-2004	Bartlomiej Zolnierkiewicz
- *
- *  The big the bad and the ugly.
- *
- *  Problems to be fixed because of BH interface or the lack therefore.
- *
- *  Fill me in stupid !!!
- *
- *  HOST:
- *	General refers to the Controller and Driver "pair".
- *  DATA HANDLER:
- *	Under the context of Linux it generally refers to an interrupt handler.
- *	However, it correctly describes the 'HOST'
- *  DATA BLOCK:
- *	The amount of data needed to be transfered as predefined in the
- *	setup of the device.
- *  STORAGE ATOMIC:
- *	The 'DATA BLOCK' associated to the 'DATA HANDLER', and can be as
- *	small as a single sector or as large as the entire command block
- *	request.
  */
 
 #include <linux/config.h>
@@ -174,29 +155,44 @@ int taskfile_lib_get_identify (ide_drive
 
 	memset(&args, 0, sizeof(ide_task_t));
 
+	tf->protocol = ATA_PROT_PIO;
 	tf->nsect = 1;
 	if (drive->media == ide_disk)
 		tf->command = WIN_IDENTIFY;
 	else
 		tf->command = WIN_PIDENTIFY;
 
-	args.command_type = IDE_DRIVE_TASK_IN;
-	args.data_phase   = TASKFILE_IN;
-	args.handler	  = &task_in_intr;
-	return ide_raw_taskfile(drive, &args, buf);
+	return ide_raw_taskfile(drive, &args, READ, buf);
+}
+
+static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
+{
+	ide_task_t *args	= HWGROUP(drive)->rq->special;
+	ide_hwif_t *hwif	= HWIF(drive);
+	u8 stat;
+
+	local_irq_enable();
+	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
+		return ide_error(drive, "task_no_data_intr", stat);
+		/* calls ide_end_drive_cmd */
+	}
+	if (args)
+		ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
+
+	return ide_stopped;
 }
 
 ide_startstop_t do_rw_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
 	struct ata_taskfile *tf = &task->tf;
+	ide_handler_t *handler = NULL; /* shut up, gcc */
 
 	/* We check this in ide_taskfile_ioctl(), but the setting could
 	   have been changed inbetween. */
-	if ((task->data_phase == TASKFILE_MULTI_IN ||
-	     task->data_phase == TASKFILE_MULTI_OUT) && !drive->mult_count) {
-		printk(KERN_ERR "%s: multimode not set!\n",
-		       drive->name);
+	if (tf->protocol == ATA_PROT_PIO_MULT && !drive->mult_count) {
+		printk(KERN_ERR "%s: multimode not set!\n", drive->name);
 		/* FIXME: this path is an infinite loop. */
 		return ide_stopped;
 	}
@@ -210,22 +206,24 @@ ide_startstop_t do_rw_taskfile(ide_drive
 		tf->device |= drive->select.all & ~ATA_LBA;
 	ide_load_taskfile(drive, task);
 
-	if (task->handler != NULL) {
-		if (task->prehandler != NULL) {
+	hwif->protocol = tf->protocol;
+
+	switch (tf->protocol) {
+	case ATA_PROT_NODATA:
+		handler = task->handler ?: task_no_data_intr;
+		break;
+	case ATA_PROT_PIO:
+	case ATA_PROT_PIO_MULT:
+		ide_init_sg_cmd(drive, rq);
+		ide_map_sg(drive, rq);
+		if (rq_data_dir(rq) == WRITE) {
 			hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 			ndelay(400);	/* FIXME */
-			return task->prehandler(drive, task->rq);
-		}
-		ide_execute_command(drive, tf->command, task->handler,
-				    WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-
-	switch (task->data_phase) {
-	case TASKFILE_OUT_DMAQ:
-	case TASKFILE_OUT_DMA:
-	case TASKFILE_IN_DMAQ:
-	case TASKFILE_IN_DMA:
+			return pre_task_out_intr(drive, rq);
+		} else
+			handler = task_in_intr;
+		break;
+	case ATA_PROT_DMA:
 		if (!hwif->dma_setup(drive)) {
 			hwif->dma_exec_cmd(drive, tf->command);
 			hwif->dma_start(drive);
@@ -233,8 +231,12 @@ ide_startstop_t do_rw_taskfile(ide_drive
 		}
 		return ide_stopped;
 	default:
-		return ide_stopped;
+		BUG();
 	}
+
+	ide_execute_command(drive, tf->command, handler, WAIT_WORSTCASE, NULL);
+
+	return ide_started;
 }
 
 EXPORT_SYMBOL(do_rw_taskfile);
@@ -294,28 +296,6 @@ ide_startstop_t recal_intr (ide_drive_t 
 	return ide_stopped;
 }
 
-/*
- * Handler for commands without a data phase
- */
-ide_startstop_t task_no_data_intr(ide_drive_t *drive)
-{
-	ide_task_t *args	= HWGROUP(drive)->rq->special;
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat;
-
-	local_irq_enable();
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
-		return ide_error(drive, "task_no_data_intr", stat);
-		/* calls ide_end_drive_cmd */
-	}
-	if (args)
-		ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-
-	return ide_stopped;
-}
-
-EXPORT_SYMBOL(task_no_data_intr);
-
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -403,15 +383,10 @@ static inline void ide_pio_datablock(ide
 			drive->io_32bit = 0;
 	}
 
-	switch (drive->hwif->data_phase) {
-	case TASKFILE_MULTI_IN:
-	case TASKFILE_MULTI_OUT:
+	if (drive->hwif->protocol == ATA_PROT_PIO_MULT)
 		ide_pio_multi(drive, write);
-		break;
-	default:
+	else
 		ide_pio_sector(drive, write);
-		break;
-	}
 
 	drive->io_32bit = saved_io_32bit;
 }
@@ -423,22 +398,12 @@ static ide_startstop_t task_error(ide_dr
 		ide_hwif_t *hwif = drive->hwif;
 		int sectors = hwif->nsect - hwif->nleft;
 
-		switch (hwif->data_phase) {
-		case TASKFILE_IN:
-			if (hwif->nleft)
-				break;
-			/* fall through */
-		case TASKFILE_OUT:
-			sectors--;
-			break;
-		case TASKFILE_MULTI_IN:
-			if (hwif->nleft)
-				break;
-			/* fall through */
-		case TASKFILE_MULTI_OUT:
-			sectors -= drive->mult_count;
-		default:
-			break;
+		if (hwif->protocol == ATA_PROT_PIO) {
+			if (rq_data_dir(rq) == WRITE || hwif->nleft == 0)
+				sectors--;
+		} else {
+			if (rq_data_dir(rq) == WRITE || hwif->nleft == 0)
+				sectors -= drive->mult_count;
 		}
 
 		if (sectors > 0) {
@@ -534,9 +499,9 @@ ide_startstop_t pre_task_out_intr (ide_d
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
 			  drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing %sWRITE%s\n",
-				drive->name,
-				drive->hwif->data_phase ? "MULT" : "",
-				drive->addressing ? "_EXT" : "");
+		       drive->name,
+		       drive->hwif->protocol == ATA_PROT_PIO_MULT ? "MULT" : "",
+		       drive->addressing ? "_EXT" : "");
 		return startstop;
 	}
 
@@ -550,7 +515,8 @@ ide_startstop_t pre_task_out_intr (ide_d
 }
 EXPORT_SYMBOL(pre_task_out_intr);
 
-static int ide_diag_taskfile(ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
+static int ide_diag_taskfile(ide_drive_t *drive, ide_task_t *args,
+			     int rw, unsigned long data_size, u8 *buf)
 {
 	struct request rq;
 
@@ -564,7 +530,7 @@ static int ide_diag_taskfile(ide_drive_t
 	 * if we would find a solution to transfer any size.
 	 * To support special commands like READ LONG.
 	 */
-	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
+	if (args->tf.protocol != ATA_PROT_NODATA) {
 		if (data_size == 0)
 			rq.nr_sectors = (args->tf.hob_nsect << 8) | args->tf.nsect;
 		else
@@ -579,7 +545,7 @@ static int ide_diag_taskfile(ide_drive_t
 		rq.hard_nr_sectors = rq.nr_sectors;
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
 
-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+		if (rw == WRITE)
 			rq.flags |= REQ_RW;
 	}
 
@@ -587,14 +553,14 @@ static int ide_diag_taskfile(ide_drive_t
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
+int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, int rw, u8 *buf)
 {
-	return ide_diag_taskfile(drive, args, 0, buf);
+	return ide_diag_taskfile(drive, args, rw, 0, buf);
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);
 
-int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_taskfile_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	ide_task_request_t	*req_task;
 	ide_task_t		args;
@@ -607,8 +573,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	int taskout		= 0;
 	char __user *buf = (char __user *)arg;
 
-//	printk("IDE Taskfile ...\n");
-
 	req_task = kmalloc(tasksize, GFP_KERNEL);
 	if (req_task == NULL) return -ENOMEM;
 	memset(req_task, 0, tasksize);
@@ -716,54 +680,47 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	tf->flags |= ATA_TFLAG_IO_16BIT;
 
-	args.data_phase   = req_task->data_phase;
-	args.command_type = req_task->req_cmd;
+	if ((req_task->data_phase == TASKFILE_MULTI_IN ||
+	     req_task->data_phase == TASKFILE_MULTI_OUT) && !drive->mult_count) {
+		printk(KERN_ERR "%s: multimode not set!\n", drive->name);
+		err = -EPERM;
+		goto abort;
+	}
 
-	switch(req_task->data_phase) {
-		case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
-			break;
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
-		case TASKFILE_MULTI_OUT:
-			if (!drive->mult_count) {
-				/* (hs): give up if multcount is not set */
-				printk(KERN_ERR "%s: %s Multimode Write " \
-					"multcount is not set\n",
-					drive->name, __FUNCTION__);
-				err = -EPERM;
-				goto abort;
-			}
-			/* fall through */
-		case TASKFILE_OUT:
-			args.prehandler = &pre_task_out_intr;
-			args.handler = &task_out_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
-			break;
-		case TASKFILE_MULTI_IN:
-			if (!drive->mult_count) {
-				/* (hs): give up if multcount is not set */
-				printk(KERN_ERR "%s: %s Multimode Read failure " \
-					"multcount is not set\n",
-					drive->name, __FUNCTION__);
-				err = -EPERM;
-				goto abort;
-			}
-			/* fall through */
-		case TASKFILE_IN:
-			args.handler = &task_in_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
-		case TASKFILE_NO_DATA:
-			args.handler = &task_no_data_intr;
-			err = ide_diag_taskfile(drive, &args, 0, NULL);
-			break;
-		default:
-			err = -EFAULT;
-			goto abort;
+	switch (req_task->data_phase) {
+	case TASKFILE_NO_DATA:
+		tf->protocol = ATA_PROT_NODATA;
+		err = ide_diag_taskfile(drive, &args, 0, 0, NULL);
+		break;
+	case TASKFILE_IN:
+		tf->protocol = ATA_PROT_PIO;
+		err = ide_diag_taskfile(drive, &args, READ, taskin, inbuf);
+		break;
+	case TASKFILE_OUT:
+		tf->protocol = ATA_PROT_PIO;
+		err = ide_diag_taskfile(drive, &args, WRITE, taskout, outbuf);
+		break;
+	case TASKFILE_MULTI_IN:
+		tf->protocol = ATA_PROT_PIO_MULT;
+		err = ide_diag_taskfile(drive, &args, READ, taskin, inbuf);
+		break;
+	case TASKFILE_MULTI_OUT:
+		tf->protocol = ATA_PROT_PIO_MULT;
+		err = ide_diag_taskfile(drive, &args, WRITE, taskout, outbuf);
+		break;
+	case TASKFILE_IN_DMAQ:
+	case TASKFILE_IN_DMA:
+		tf->protocol = ATA_PROT_DMA;
+		err = ide_diag_taskfile(drive, &args, READ, taskin, inbuf);
+		break;
+	case TASKFILE_OUT_DMAQ:
+	case TASKFILE_OUT_DMA:
+		tf->protocol = ATA_PROT_DMA;
+		err = ide_diag_taskfile(drive, &args, WRITE, taskout, outbuf);
+		break;
+	default:
+		err = -EFAULT;	/* FIXME: -EFAULT? really? */
+		goto abort;
 	}
 
 	if (req_task->data_phase == TASKFILE_NO_DATA ||
@@ -810,9 +767,6 @@ abort:
 		kfree(outbuf);
 	if (inbuf != NULL)
 		kfree(inbuf);
-
-//	printk("IDE Taskfile ioctl ended. rc = %i\n", err);
-
 	return err;
 }
 
@@ -901,6 +855,7 @@ int ide_task_ioctl(ide_drive_t *drive, u
 
 	memset(&task, 0, sizeof(task));
 
+	tf->protocol	= ATA_PROT_NODATA;
 	tf->flags	= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 
 	tf->command	= args[0];
@@ -911,11 +866,7 @@ int ide_task_ioctl(ide_drive_t *drive, u
 	tf->lbah	= args[5];
 	tf->device	= args[6] & ~ATA_DEV1;
 
-	task.command_type = IDE_DRIVE_TASK_NO_DATA;
-	task.data_phase = TASKFILE_NO_DATA;
-	task.handler = &task_no_data_intr;
-
-	err = ide_diag_taskfile(drive, &task, 0, NULL);
+	err = ide_diag_taskfile(drive, &task, 0, 0, NULL);
 
 	args[0] = tf->command;
 	args[1] = tf->feature;
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:46:59.483894654 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:46:59.687862767 +0900
@@ -867,8 +867,8 @@ typedef struct hwif_s {
 	int sg_nents;			/* Current number of entries in it */
 	int sg_dma_direction;		/* dma transfer direction */
 
-	/* data phase of the active command (currently only valid for PIO/DMA) */
-	int		data_phase;
+	/* protocol of the active command */
+	int		protocol;
 
 	unsigned int nsect;
 	unsigned int nleft;
@@ -928,11 +928,7 @@ typedef struct ide_task_s {
 	u16			data;
 	unsigned		load_data:1;
 	unsigned		read_data:1;
-	int			data_phase;
-	int			command_type;
-	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
-	struct request		*rq;		/* copy of request */
 } ide_task_t;
 
 typedef struct hwgroup_s {
@@ -1288,11 +1284,10 @@ void task_end_request(ide_drive_t *drive
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
-extern ide_startstop_t task_no_data_intr(ide_drive_t *);
 extern ide_startstop_t task_in_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 
-extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
+extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, int, u8 *);
 
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
