Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUKFD2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUKFD2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUKFD2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:28:06 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:32930 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261303AbUKFDXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:23:31 -0500
Date: Fri, 5 Nov 2004 19:23:14 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] WIN_* -> ATA_CMD_* conversion: update WIN_* users to use ATA_CMD_*
Message-ID: <20041106032314.GC6060@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041105051635c15281@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 ide/ide-cd.c         |    6 ++--
 ide/ide-disk.c       |   68 +++++++++++++++++++++++++--------------------------
 ide/ide-floppy.c     |    4 +--
 ide/ide-io.c         |   14 +++++-----
 ide/ide-iops.c       |   10 +++----
 ide/ide-probe.c      |   30 +++++++++++-----------
 ide/ide-tape.c       |    4 +--
 ide/ide-taskfile.c   |   21 ++++++---------
 ide/ide.c            |    2 -
 ide/legacy/hd.c      |   11 +++-----
 ide/ppc/pmac.c       |    2 -
 scsi/ide-scsi.c      |    6 ++--
 usb/storage/isd200.c |   10 +++----
 13 files changed, 91 insertions(+), 97 deletions(-)

===== drivers/ide/ide-cd.c 1.96 vs edited =====
--- 1.96/drivers/ide/ide-cd.c	2004-10-25 13:06:46 -07:00
+++ edited/drivers/ide/ide-cd.c	2004-11-05 18:50:43 -08:00
@@ -585,7 +585,7 @@
 	}
 	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
 		/* force an abort */
-		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_IDLEIMMEDIATE,IDE_COMMAND_REG);
 	if (rq->errors >= ERROR_MAX) {
 		DRIVER(drive)->end_request(drive, 0, 0);
 	} else {
@@ -887,11 +887,11 @@
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* packet command */
-		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
+		ide_execute_command(drive, ATA_CMD_PACKET, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
 	} else {
 		/* packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return (*handler) (drive);
 	}
 }
===== drivers/ide/ide-disk.c 1.108 vs edited =====
--- 1.108/drivers/ide/ide-disk.c	2004-10-29 09:34:09 -07:00
+++ edited/drivers/ide/ide-disk.c	2004-11-05 18:50:43 -08:00
@@ -126,7 +126,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int dma	= drive->using_dma;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
+	task_ioreg_t command	= ATA_CMD_NOP;
 	ata_nsector_t		nsectors;
 
 	nsectors.all		= (u16) rq->nr_sectors;
@@ -213,13 +213,13 @@
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
 			if (rq_data_dir(rq)) {
-				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+				command = lba48 ? ATA_CMD_WRITE_EXT : ATA_CMD_WRITE;
 				if (drive->vdma)
-					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+					command = lba48 ? ATA_CMD_PIO_WRITE_EXT: ATA_CMD_PIO_WRITE;
 			} else {
-				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+				command = lba48 ? ATA_CMD_READ_EXT : ATA_CMD_READ;
 				if (drive->vdma)
-					command = lba48 ? WIN_READ_EXT: WIN_READ;
+					command = lba48 ? ATA_CMD_PIO_READ_EXT: ATA_CMD_PIO_READ;
 			}
 			hwif->dma_exec_cmd(drive, command);
 			hwif->dma_start(drive);
@@ -233,10 +233,10 @@
 
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_IN;
-			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+			command = lba48 ? ATA_CMD_MULTREAD_EXT : ATA_CMD_MULTREAD;
 		} else {
 			hwif->data_phase = TASKFILE_IN;
-			command = lba48 ? WIN_READ_EXT : WIN_READ;
+			command = lba48 ? ATA_CMD_PIO_READ_EXT : ATA_CMD_PIO_READ;
 		}
 
 		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
@@ -244,10 +244,10 @@
 	} else {
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_OUT;
-			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			command = lba48 ? ATA_CMD_MULTWRITE_EXT : ATA_CMD_MULTWRITE;
 		} else {
 			hwif->data_phase = TASKFILE_OUT;
-			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
+			command = lba48 ? ATA_CMD_PIO_WRITE_EXT : ATA_CMD_PIO_WRITE;
 		}
 
 		/* FIXME: ->OUTBSYNC ? */
@@ -416,8 +416,8 @@
 		/* err has different meaning on cdrom and tape */
 		if (err == ABRT_ERR) {
 			if (drive->select.b.lba &&
-			    /* some newer drives don't support WIN_SPECIFY */
-			    hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
+			    /* some newer drives don't support ATA_CMD_SPECIFY */
+			    hwif->INB(IDE_COMMAND_REG) == ATA_CMD_SPECIFY)
 				return ide_stopped;
 		} else if ((err & BAD_CRC) == BAD_CRC) {
 			/* UDMA crc error, just retry the operation */
@@ -434,7 +434,7 @@
 		try_to_flush_leftover_data(drive);
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		hwif->OUTB(ATA_CMD_IDLEIMMEDIATE,IDE_COMMAND_REG);
 	}
 	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
 		DRIVER(drive)->end_request(drive, 0, 0);
@@ -482,7 +482,7 @@
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_READ_NATIVE_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
@@ -508,7 +508,7 @@
 	memset(&args, 0, sizeof(ide_task_t));
 
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_READ_NATIVE_MAX_EXT;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
         /* submit command request */
@@ -544,7 +544,7 @@
 	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>  8) & 0xff);
 	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >> 16) & 0xff);
 	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SET_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
@@ -572,7 +572,7 @@
 	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
 	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
 	args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX_EXT;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SET_MAX_EXT;
 	args.hobRegister[IDE_SECTOR_OFFSET]	= (addr_req >>= 8) & 0xff;
 	args.hobRegister[IDE_LCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
 	args.hobRegister[IDE_HCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
@@ -716,7 +716,7 @@
 			args.tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
 			args.tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
 			args.tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
+			args.tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_SPECIFY;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &set_geometry_intr;
 			do_rw_taskfile(drive, &args);
@@ -727,7 +727,7 @@
 			ide_task_t args;
 			memset(&args, 0, sizeof(ide_task_t));
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
+			args.tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_RESTORE;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &recal_intr;
 			do_rw_taskfile(drive, &args);
@@ -740,7 +740,7 @@
 			ide_task_t args;
 			memset(&args, 0, sizeof(ide_task_t));
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
+			args.tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_MULTSET;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &set_multmode_intr;
 			do_rw_taskfile(drive, &args);
@@ -779,7 +779,7 @@
 	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_ENABLE;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SMART;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -794,7 +794,7 @@
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
 	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
@@ -810,7 +810,7 @@
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
 	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
@@ -900,9 +900,9 @@
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
+		rq->cmd[0] = ATA_CMD_FLUSH_EXT;
 	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
+		rq->cmd[0] = ATA_CMD_FLUSH;
 
 
 	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
@@ -959,7 +959,7 @@
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SET_FEATURES;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 
@@ -977,9 +977,9 @@
 
 	memset(&args, 0, sizeof(ide_task_t));
 	if (ide_id_has_flush_cache_ext(drive->id))
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
+		args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_FLUSH_EXT;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
+		args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_FLUSH;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -993,7 +993,7 @@
 	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ? SETFEATURES_EN_AAM :
 							  SETFEATURES_DIS_AAM;
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_SET_FEATURES;
 	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 	args.handler	  = &task_no_data_intr;
 	ide_raw_taskfile(drive, &args, NULL);
@@ -1084,21 +1084,21 @@
 			return ide_stopped;
 		}
 		if (ide_id_has_flush_cache_ext(drive->id))
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+			args->tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_FLUSH_EXT;
 		else
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+			args->tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_FLUSH;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
+		args->tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
+		args->tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler = task_no_data_intr;
 		return do_rw_taskfile(drive, args);
@@ -1378,7 +1378,7 @@
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
+		args.tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_DOORLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
@@ -1401,7 +1401,7 @@
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
+		args.tfRegister[IDE_COMMAND_OFFSET] = ATA_CMD_DOORUNLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
===== drivers/ide/ide-floppy.c 1.44 vs edited =====
--- 1.44/drivers/ide/ide-floppy.c	2004-10-20 01:37:15 -07:00
+++ edited/drivers/ide/ide-floppy.c	2004-11-05 17:49:35 -08:00
@@ -1092,14 +1092,14 @@
 	
 	if (test_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags)) {
 		/* Issue the packet command */
-		ide_execute_command(drive, WIN_PACKETCMD,
+		ide_execute_command(drive, ATA_CMD_PACKET,
 				pkt_xfer_routine,
 				IDEFLOPPY_WAIT_CMD,
 				NULL);
 		return ide_started;
 	} else {
 		/* Issue the packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return (*pkt_xfer_routine) (drive);
 	}
 }
===== drivers/ide/ide-io.c 1.35 vs edited =====
--- 1.35/drivers/ide/ide-io.c	2004-11-01 09:06:49 -08:00
+++ edited/drivers/ide/ide-io.c	2004-11-05 18:50:43 -08:00
@@ -66,11 +66,11 @@
 
 	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
 	rq->buffer = buf;
-	rq->buffer[0] = WIN_FLUSH_CACHE;
+	rq->buffer[0] = ATA_CMD_FLUSH;
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
+		rq->buffer[0] = ATA_CMD_FLUSH_EXT;
 }
 
 /*
@@ -505,9 +505,9 @@
 			/* err has different meaning on cdrom and tape */
 			if (err == ABRT_ERR) {
 				if (drive->select.b.lba &&
-				    (hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY))
+				    (hwif->INB(IDE_COMMAND_REG) == ATA_CMD_SPECIFY))
 					/* some newer drives don't
-					 * support WIN_SPECIFY
+					 * support ATA_CMD_SPECIFY
 					 */
 					return ide_stopped;
 			} else if ((err & BAD_CRC) == BAD_CRC) {
@@ -527,7 +527,7 @@
 	}
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		hwif->OUTB(ATA_CMD_IDLEIMMEDIATE,IDE_COMMAND_REG);
 	}
 	if (rq->errors >= ERROR_MAX) {
 		DRIVER(drive)->end_request(drive, 0, 0);
@@ -644,7 +644,7 @@
  *	do_special		-	issue some special commands
  *	@drive: drive the command is for
  *
- *	do_special() is used to issue WIN_SPECIFY, WIN_RESTORE, and WIN_SETMULT
+ *	do_special() is used to issue ATA_CMD_SPECIFY, ATA_CMD_RESTORE, and ATA_CMD_MULTSET
  *	commands to a drive.  It used to do much more, but has been scaled
  *	back.
  */
@@ -770,7 +770,7 @@
  		printk("fr=0x%02x ", args[2]);
  		printk("xx=0x%02x\n", args[3]);
 #endif
- 		if (args[0] == WIN_SMART) {
+ 		if (args[0] == ATA_CMD_SMART) {
  			hwif->OUTB(0x4f, IDE_LCYL_REG);
  			hwif->OUTB(0xc2, IDE_HCYL_REG);
  			hwif->OUTB(args[2],IDE_FEATURE_REG);
===== drivers/ide/ide-iops.c 1.31 vs edited =====
--- 1.31/drivers/ide/ide-iops.c	2004-11-01 09:06:50 -08:00
+++ edited/drivers/ide/ide-iops.c	2004-11-05 18:50:43 -08:00
@@ -650,7 +650,7 @@
 
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
+	if ((args->tfRegister[IDE_COMMAND_OFFSET] == ATA_CMD_SET_FEATURES) &&
 	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
 	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
 #ifndef CONFIG_IDEDMA_IVB
@@ -680,7 +680,7 @@
  */
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
+	if ((args->tfRegister[IDE_COMMAND_OFFSET] == ATA_CMD_SET_FEATURES) &&
 	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
 	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
 	    (drive->id->dma_ultra ||
@@ -752,7 +752,7 @@
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
 	msleep(50);
-	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
+	hwif->OUTB(ATA_CMD_ID_ATA, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
 		if (time_after(jiffies, timeout)) {
@@ -842,7 +842,7 @@
 		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 	hwif->OUTB(speed, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
-	hwif->OUTB(WIN_SETFEATURES, IDE_COMMAND_REG);
+	hwif->OUTB(ATA_CMD_SET_FEATURES, IDE_COMMAND_REG);
 	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	udelay(1);
@@ -1168,7 +1168,7 @@
 		pre_reset(drive);
 		SELECT_DRIVE(drive);
 		udelay (20);
-		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
+		hwif->OUTB(ATA_CMD_SRST, IDE_COMMAND_REG);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
 		spin_unlock_irqrestore(&ide_lock, flags);
===== drivers/ide/ide-probe.c 1.88 vs edited =====
--- 1.88/drivers/ide/ide-probe.c	2004-11-05 15:30:38 -08:00
+++ edited/drivers/ide/ide-probe.c	2004-11-05 18:50:43 -08:00
@@ -151,10 +151,10 @@
 #endif /* CONFIG_SCSI_EATA_DMA || CONFIG_SCSI_EATA_PIO */
 
 	/*
-	 *  WIN_IDENTIFY returns little-endian info,
-	 *  WIN_PIDENTIFY *usually* returns little-endian info.
+	 *  ATA_CMD_ID_ATA returns little-endian info,
+	 *  ATA_CMD_ID_ATAPI *usually* returns little-endian info.
 	 */
-	if (cmd == WIN_PIDENTIFY) {
+	if (cmd == ATA_CMD_ID_ATAPI) {
 		if ((id->model[0] == 'N' && id->model[1] == 'E') /* NEC */
 		 || (id->model[0] == 'F' && id->model[1] == 'X') /* Mitsumi */
 		 || (id->model[0] == 'P' && id->model[1] == 'i'))/* Pioneer */
@@ -177,7 +177,7 @@
 	/*
 	 * Check for an ATAPI device
 	 */
-	if (cmd == WIN_PIDENTIFY) {
+	if (cmd == ATA_CMD_ID_ATAPI) {
 		u8 type = (id->config >> 8) & 0x1f;
 		printk("ATAPI ");
 		switch (type) {
@@ -287,14 +287,14 @@
 	/* set features register for atapi
 	 * identify command to be sure of reply
 	 */
-	if ((cmd == WIN_PIDENTIFY))
+	if ((cmd == ATA_CMD_ID_ATAPI))
 		/* disable dma & overlap */
 		hwif->OUTB(0, IDE_FEATURE_REG);
 
 	/* ask drive for ID */
 	hwif->OUTB(cmd, IDE_COMMAND_REG);
 
-	timeout = ((cmd == WIN_IDENTIFY) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
+	timeout = ((cmd == ATA_CMD_ID_ATA) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
 	timeout += jiffies;
 	do {
 		if (time_after(jiffies, timeout)) {
@@ -414,13 +414,13 @@
 
 	if (drive->present) {
 		/* avoid waiting for inappropriate probes */
-		if ((drive->media != ide_disk) && (cmd == WIN_IDENTIFY))
+		if ((drive->media != ide_disk) && (cmd == ATA_CMD_ID_ATA))
 			return 4;
 	}
 #ifdef DEBUG
 	printk("probing for %s: present=%d, media=%d, probetype=%s\n",
 		drive->name, drive->present, drive->media,
-		(cmd == WIN_IDENTIFY) ? "ATA" : "ATAPI");
+		(cmd == ATA_CMD_ID_ATA) ? "ATA" : "ATAPI");
 #endif
 
 	/* needed for some systems
@@ -441,7 +441,7 @@
 	}
 
 	if (OK_STAT((hwif->INB(IDE_STATUS_REG)), READY_STAT, BUSY_STAT) ||
-	    drive->present || cmd == WIN_PIDENTIFY) {
+	    drive->present || cmd == ATA_CMD_ID_ATAPI) {
 		/* send cmd and wait */
 		if ((rc = try_to_identify(drive, cmd))) {
 			/* failed: try again */
@@ -450,7 +450,7 @@
 		if (hwif->INB(IDE_STATUS_REG) == (BUSY_STAT|READY_STAT))
 			return 4;
 
-		if ((rc == 1 && cmd == WIN_PIDENTIFY) &&
+		if ((rc == 1 && cmd == ATA_CMD_ID_ATAPI) &&
 			((drive->autotune == IDE_TUNE_DEFAULT) ||
 			(drive->autotune == IDE_TUNE_AUTO))) {
 			unsigned long timeout;
@@ -460,7 +460,7 @@
 			msleep(50);
 			hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 			msleep(50);
-			hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
+			hwif->OUTB(ATA_CMD_SRST, IDE_COMMAND_REG);
 			timeout = jiffies;
 			while (((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) &&
 			       time_before(jiffies, timeout + WAIT_WORSTCASE))
@@ -516,9 +516,9 @@
 	}
 
 	/* if !(success||timed-out) */
-	if (do_probe(drive, WIN_IDENTIFY) >= 2) {
+	if (do_probe(drive, ATA_CMD_ID_ATA) >= 2) {
 		/* look for ATAPI device */
-		(void) do_probe(drive, WIN_PIDENTIFY);
+		(void) do_probe(drive, ATA_CMD_ID_ATAPI);
 	}
 }
 
@@ -559,9 +559,9 @@
 	if (!drive->noprobe)
 	{
 		/* if !(success||timed-out) */
-		if (do_probe(drive, WIN_IDENTIFY) >= 2) {
+		if (do_probe(drive, ATA_CMD_ID_ATA) >= 2) {
 			/* look for ATAPI device */
-			(void) do_probe(drive, WIN_PIDENTIFY);
+			(void) do_probe(drive, ATA_CMD_ID_ATAPI);
 		}
 		if (strstr(drive->id->model, "E X A B Y T E N E S T"))
 			enable_nest(drive);
===== drivers/ide/ide-tape.c 1.47 vs edited =====
--- 1.47/drivers/ide/ide-tape.c	2004-10-20 01:37:15 -07:00
+++ edited/drivers/ide/ide-tape.c	2004-11-05 17:49:36 -08:00
@@ -2148,10 +2148,10 @@
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
 		ide_set_handler(drive, &idetape_transfer_pc, IDETAPE_WAIT_CMD, NULL);
-		hwif->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		hwif->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return ide_started;
 	} else {
-		hwif->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		hwif->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return idetape_transfer_pc(drive);
 	}
 }
===== drivers/ide/ide-taskfile.c 1.72 vs edited =====
--- 1.72/drivers/ide/ide-taskfile.c	2004-11-01 09:06:50 -08:00
+++ edited/drivers/ide/ide-taskfile.c	2004-11-05 18:50:43 -08:00
@@ -87,9 +87,9 @@
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
 	if (drive->media == ide_disk)
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_IDENTIFY;
+		args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_ID_ATA;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_PIDENTIFY;
+		args.tfRegister[IDE_COMMAND_OFFSET]	= ATA_CMD_ID_ATAPI;
 	args.command_type = IDE_DRIVE_TASK_IN;
 	args.data_phase   = TASKFILE_IN;
 	args.handler	  = &task_in_intr;
@@ -140,13 +140,10 @@
 		return ide_stopped;
 
 	switch (taskfile->command) {
-		case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_EXT:
-		case WIN_READDMA_ONCE:
-		case WIN_READDMA:
-		case WIN_READDMA_EXT:
-		case WIN_IDENTIFY_DMA:
+		case ATA_CMD_WRITE:
+		case ATA_CMD_WRITE_EXT:
+		case ATA_CMD_READ:
+		case ATA_CMD_READ_EXT:
 			if (!hwif->dma_setup(drive)) {
 				hwif->dma_exec_cmd(drive, taskfile->command);
 				hwif->dma_start(drive);
@@ -164,7 +161,7 @@
 EXPORT_SYMBOL(do_rw_taskfile);
 
 /*
- * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
+ * set_multmode_intr() is invoked on completion of a ATA_CMD_MULTSET cmd.
  */
 ide_startstop_t set_multmode_intr (ide_drive_t *drive)
 {
@@ -184,7 +181,7 @@
 EXPORT_SYMBOL(set_multmode_intr);
 
 /*
- * set_geometry_intr() is invoked on completion of a WIN_SPECIFY cmd.
+ * set_geometry_intr() is invoked on completion of a ATA_CMD_SPECIFY cmd.
  */
 ide_startstop_t set_geometry_intr (ide_drive_t *drive)
 {
@@ -210,7 +207,7 @@
 EXPORT_SYMBOL(set_geometry_intr);
 
 /*
- * recal_intr() is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
+ * recal_intr() is invoked on completion of a ATA_CMD_RESTORE (recalibrate) cmd.
  */
 ide_startstop_t recal_intr (ide_drive_t *drive)
 {
===== drivers/ide/ide.c 1.169 vs edited =====
--- 1.169/drivers/ide/ide.c	2004-11-05 15:30:38 -08:00
+++ edited/drivers/ide/ide.c	2004-11-05 17:49:36 -08:00
@@ -1390,7 +1390,7 @@
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
 	int err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
+			ATA_CMD_SET_FEATURES, (u8) arg,
 			SETFEATURES_XFER, 0, NULL);
 
 	if (!err && arg) {
===== drivers/ide/legacy/hd.c 1.24 vs edited =====
--- 1.24/drivers/ide/legacy/hd.c	2004-06-21 07:11:51 -07:00
+++ edited/drivers/ide/legacy/hd.c	2004-11-05 18:57:56 -08:00
@@ -65,9 +65,6 @@
 #define HD_HCYL		0x1f5		/* high byte of starting cyl */
 #define HD_CURRENT	0x1f6		/* 101dhhhh , d=drive, hhhh=head */
 #define HD_STATUS	0x1f7		/* see status-bits */
-#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
-#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
-#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
 
 #define HD_CMD		0x3f6		/* used for resets */
 #define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
@@ -370,7 +367,7 @@
 		struct hd_i_struct *disk = &hd_info[i];
 		disk->special_op = disk->recalibrate = 1;
 		hd_out(disk,disk->sect,disk->sect,disk->head-1,
-			disk->cyl,WIN_SPECIFY,&reset_hd);
+			disk->cyl,ATA_CMD_SPECIFY,&reset_hd);
 		if (reset)
 			goto repeat;
 	} else
@@ -555,7 +552,7 @@
 {
 	if (disk->recalibrate) {
 		disk->recalibrate = 0;
-		hd_out(disk,disk->sect,0,0,0,WIN_RESTORE,&recal_intr);
+		hd_out(disk,disk->sect,0,0,0,ATA_CMD_RESTORE,&recal_intr);
 		return reset;
 	}
 	if (disk->head > 16) {
@@ -627,12 +624,12 @@
 	if (req->flags & REQ_CMD) {
 		switch (rq_data_dir(req)) {
 		case READ:
-			hd_out(disk,nsect,sec,head,cyl,WIN_READ,&read_intr);
+			hd_out(disk,nsect,sec,head,cyl,ATA_CMD_PIO_READ,&read_intr);
 			if (reset)
 				goto repeat;
 			break;
 		case WRITE:
-			hd_out(disk,nsect,sec,head,cyl,WIN_WRITE,&write_intr);
+			hd_out(disk,nsect,sec,head,cyl,ATA_CMD_PIO_WRITE,&write_intr);
 			if (reset)
 				goto repeat;
 			if (wait_DRQ()) {
===== drivers/ide/ppc/pmac.c 1.43 vs edited =====
--- 1.43/drivers/ide/ppc/pmac.c	2004-11-01 09:06:50 -08:00
+++ edited/drivers/ide/ppc/pmac.c	2004-11-05 17:49:35 -08:00
@@ -594,7 +594,7 @@
 	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 	hwif->OUTB(command, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
-	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
+	hwif->OUTBSYNC(drive, ATA_CMD_SET_FEATURES, IDE_COMMAND_REG);
 	udelay(1);
 	/* Timeout bumped for some powerbooks */
 	result = wait_for_ready(drive, 2000);
===== drivers/scsi/ide-scsi.c 1.47 vs edited =====
--- 1.47/drivers/scsi/ide-scsi.c	2004-10-21 16:46:25 -07:00
+++ edited/drivers/scsi/ide-scsi.c	2004-11-05 18:51:29 -08:00
@@ -320,7 +320,7 @@
 
 	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
 		/* force an abort */
-		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_IDLEIMMEDIATE,IDE_COMMAND_REG);
 
 	rq->errors++;
 	DRIVER(drive)->end_request(drive, 0, 0);
@@ -657,11 +657,11 @@
 		ide_set_handler(drive, &idescsi_transfer_pc,
 				get_timeout(pc), idescsi_expiry);
 		/* Issue the packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return ide_started;
 	} else {
 		/* Issue the packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		HWIF(drive)->OUTB(ATA_CMD_PACKET, IDE_COMMAND_REG);
 		return idescsi_transfer_pc(drive);
 	}
 }
===== drivers/usb/storage/isd200.c 1.41 vs edited =====
--- 1.41/drivers/usb/storage/isd200.c	2004-10-06 14:35:10 -07:00
+++ edited/drivers/usb/storage/isd200.c	2004-11-05 18:51:42 -08:00
@@ -470,14 +470,14 @@
 		ata.generic.ActionSelect = ACTION_SELECT_1|ACTION_SELECT_5;
 		ata.generic.RegisterSelect = REG_DEVICE_HEAD | REG_COMMAND;
 		ata.write.DeviceHeadByte = info->DeviceHead;
-		ata.write.CommandByte = WIN_SRST;
+		ata.write.CommandByte = ATA_CMD_SRST;
 		srb->sc_data_direction = DMA_NONE;
 		break;
 
 	case ACTION_IDENTIFY:
 		US_DEBUGP("   isd200_action(IDENTIFY)\n");
 		ata.generic.RegisterSelect = REG_COMMAND;
-		ata.write.CommandByte = WIN_IDENTIFY;
+		ata.write.CommandByte = ATA_CMD_ID_ATA;
 		srb->sc_data_direction = DMA_FROM_DEVICE;
 		srb->request_buffer = (void *) info->id;
 		srb->request_bufflen = sizeof(struct hd_driveid);
@@ -1242,7 +1242,7 @@
 		ataCdb->write.CylinderHighByte = (unsigned char)(cylinder>>8);
 		ataCdb->write.CylinderLowByte = (unsigned char)cylinder;
 		ataCdb->write.DeviceHeadByte = (head | ATA_ADDRESS_DEVHEAD_STD);
-		ataCdb->write.CommandByte = WIN_READ;
+		ataCdb->write.CommandByte = ATA_CMD_PIO_READ;
 		break;
 
 	case WRITE_10:
@@ -1272,7 +1272,7 @@
 		ataCdb->write.CylinderHighByte = (unsigned char)(cylinder>>8);
 		ataCdb->write.CylinderLowByte = (unsigned char)cylinder;
 		ataCdb->write.DeviceHeadByte = (head | ATA_ADDRESS_DEVHEAD_STD);
-		ataCdb->write.CommandByte = WIN_WRITE;
+		ataCdb->write.CommandByte = ATA_CMD_PIO_WRITE;
 		break;
 
 	case ALLOW_MEDIUM_REMOVAL:
@@ -1286,7 +1286,7 @@
 			ataCdb->generic.TransferBlockSize = 1;
 			ataCdb->generic.RegisterSelect = REG_COMMAND;
 			ataCdb->write.CommandByte = (srb->cmnd[4] & 0x1) ?
-				WIN_DOORLOCK : WIN_DOORUNLOCK;
+				ATA_CMD_DOORLOCK : ATA_CMD_DOORUNLOCK;
 			srb->request_bufflen = 0;
 		} else {
 			US_DEBUGP("   Not removeable media, just report okay\n");
