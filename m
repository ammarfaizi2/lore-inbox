Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSC1JYP>; Thu, 28 Mar 2002 04:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSC1JX7>; Thu, 28 Mar 2002 04:23:59 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16651 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313112AbSC1JXd>; Thu, 28 Mar 2002 04:23:33 -0500
Message-ID: <3CA2E0B4.9010006@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:21:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.7 IDE 23
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080204060100030402040906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080204060100030402040906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon Mar 18 19:02:07 CET 2002 ide-clean-23

- Support for additional Promise controller id's (PDC20276).

- Remove code duplication between do_rw_taskfile and do_taskfile.
   This will evolve into a more reasonable ata_command() function
   finally. The ata_taskfile function has far too many arguments, but
   I favour this over having two different code paths for getting
   actual data to the drive.

--------------080204060100030402040906
Content-Type: text/plain;
 name="ide-clean-23.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-23.diff"

diff -urN linux-2.5.7-pre2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.7-pre2/drivers/ide/ide-disk.c	Tue Mar 19 03:32:11 2002
+++ linux/drivers/ide/ide-disk.c	Tue Mar 19 03:25:58 2002
@@ -106,50 +106,6 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-static ide_startstop_t chs_do_request(ide_drive_t *drive, struct request *rq, unsigned long block);
-static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block);
-static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct request *rq, unsigned long long block);
-
-/*
- * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
- * otherwise, to address sectors.  It also takes care of issuing special
- * DRIVE_CMDs.
- */
-static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
-{
-	/*
-	 * Wait until all request have bin finished.
-	 */
-
-	while (drive->blocked) {
-		yield();
-		// panic("ide: Request while drive blocked?");
-	}
-
-	if (!(rq->flags & REQ_CMD)) {
-		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
-		ide_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	if (IS_PDC4030_DRIVE) {
-		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
-
-		return promise_rw_disk(drive, rq, block);
-	}
-
-	/* 48-bit LBA */
-	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		return lba48_do_request(drive, rq, block);
-
-	/* 28-bit LBA */
-	if (drive->select.b.lba)
-		return lba28_do_request(drive, rq, block);
-
-	/* 28-bit CHS */
-	return chs_do_request(drive, rq, block);
-}
-
 static task_ioreg_t get_command(ide_drive_t *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
@@ -158,20 +114,38 @@
 	lba48bit = drive->addressing;
 #endif
 
-	if (cmd == READ) {
-		if (drive->using_dma)
-			return (lba48bit) ? WIN_READDMA_EXT : WIN_READDMA;
-		else if (drive->mult_count)
-			return (lba48bit) ? WIN_MULTREAD_EXT : WIN_MULTREAD;
-		else
-			return (lba48bit) ? WIN_READ_EXT : WIN_READ;
-	} else if (cmd == WRITE) {
-		if (drive->using_dma)
-			return (lba48bit) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-		else if (drive->mult_count)
-			return (lba48bit) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
-		else
-			return (lba48bit) ? WIN_WRITE_EXT : WIN_WRITE;
+	if (lba48bit) {
+		if (cmd == READ) {
+			if (drive->using_dma)
+				return WIN_READDMA_EXT;
+			else if (drive->mult_count)
+				return WIN_MULTREAD_EXT;
+			else
+				return WIN_READ_EXT;
+		} else if (cmd == WRITE) {
+			if (drive->using_dma)
+				return WIN_WRITEDMA_EXT;
+			else if (drive->mult_count)
+				return WIN_MULTWRITE_EXT;
+			else
+				return WIN_WRITE_EXT;
+		}
+	} else {
+		if (cmd == READ) {
+			if (drive->using_dma)
+				return WIN_READDMA;
+			else if (drive->mult_count)
+				return WIN_MULTREAD;
+			else
+				return WIN_READ;
+		} else if (cmd == WRITE) {
+			if (drive->using_dma)
+				return WIN_WRITEDMA;
+			else if (drive->mult_count)
+				return WIN_MULTWRITE;
+			else
+				return WIN_WRITE;
+		}
 	}
 	return WIN_NOP;
 }
@@ -183,8 +157,6 @@
 	ide_task_t			args;
 	int				sectors;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
-
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
@@ -203,7 +175,7 @@
 	taskfile.high_cylinder	= (cyl>>8);
 	taskfile.device_head	= head;
 	taskfile.device_head	|= drive->select.all;
-	taskfile.command	= command;
+	taskfile.command	=  get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -221,7 +193,12 @@
 	args.block = block;
 	rq->special = &args;
 
-	return do_rw_taskfile(drive, &args);
+	return ata_taskfile(drive,
+			(struct hd_drive_task_hdr *) &args.tfRegister,
+			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			args.handler,
+			args.prehandler,
+			args.rq);
 }
 
 static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
@@ -231,8 +208,6 @@
 	ide_task_t			args;
 	int				sectors;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
-
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
@@ -246,7 +221,7 @@
 	taskfile.high_cylinder	= (block>>=8);
 	taskfile.device_head	= ((block>>8)&0x0f);
 	taskfile.device_head	|= drive->select.all;
-	taskfile.command	= command;
+	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -264,7 +239,12 @@
 	args.block = block;
 	rq->special = &args;
 
-	return do_rw_taskfile(drive, &args);
+	return ata_taskfile(drive,
+			(struct hd_drive_task_hdr *) &args.tfRegister,
+			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			args.handler,
+			args.prehandler,
+			args.rq);
 }
 
 /*
@@ -280,8 +260,6 @@
 	ide_task_t			args;
 	int				sectors;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
-
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
@@ -306,7 +284,7 @@
 	taskfile.device_head	= drive->select.all;
 	hobfile.device_head	= taskfile.device_head;
 	hobfile.control		= (drive->ctl|0x80);
-	taskfile.command	= command;
+	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -324,7 +302,52 @@
 	args.block = block;
 	rq->special = &args;
 
-	return do_rw_taskfile(drive, &args);
+	return ata_taskfile(drive,
+			(struct hd_drive_task_hdr *) &args.tfRegister,
+			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			args.handler,
+			args.prehandler,
+			args.rq);
+}
+
+/*
+ * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
+ * otherwise, to address sectors.  It also takes care of issuing special
+ * DRIVE_CMDs.
+ */
+static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+{
+	/*
+	 * Wait until all request have bin finished.
+	 */
+
+	while (drive->blocked) {
+		yield();
+		// panic("ide: Request while drive blocked?");
+	}
+
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
+		ide_end_request(drive, 0);
+		return ide_stopped;
+	}
+
+	if (IS_PDC4030_DRIVE) {
+		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
+
+		return promise_rw_disk(drive, rq, block);
+	}
+
+	/* 48-bit LBA */
+	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
+		return lba48_do_request(drive, rq, block);
+
+	/* 28-bit LBA */
+	if (drive->select.b.lba)
+		return lba28_do_request(drive, rq, block);
+
+	/* 28-bit CHS */
+	return chs_do_request(drive, rq, block);
 }
 
 static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
@@ -333,10 +356,13 @@
 	if (drive->removable && drive->usage == 1) {
 		struct hd_drive_task_hdr taskfile;
 		struct hd_drive_hob_hdr hobfile;
+
 		memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+
 		check_disk_change(inode->i_rdev);
 		taskfile.command = WIN_DOORLOCK;
+
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
@@ -355,11 +381,10 @@
 	struct hd_drive_hob_hdr hobfile;
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	if (drive->id->cfs_enable_2 & 0x2400) {
+	if (drive->id->cfs_enable_2 & 0x2400)
 		taskfile.command	= WIN_FLUSH_CACHE_EXT;
-	} else {
+	else
 		taskfile.command	= WIN_FLUSH_CACHE;
-	}
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 }
 
@@ -643,7 +668,7 @@
 			taskfile.command = WIN_SPECIFY;
 			handler	= set_geometry_intr;;
 		}
-		do_taskfile(drive, &taskfile, &hobfile, handler);
+		ata_taskfile(drive, &taskfile, &hobfile, handler, NULL, NULL);
 	} else if (s->b.recalibrate) {
 		s->b.recalibrate = 0;
 		if (!IS_PDC4030_DRIVE) {
@@ -653,7 +678,7 @@
 			memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 			taskfile.sector_count	= drive->sect;
 			taskfile.command	= WIN_RESTORE;
-			do_taskfile(drive, &taskfile, &hobfile, recal_intr);
+			ata_taskfile(drive, &taskfile, &hobfile, recal_intr, NULL, NULL);
 		}
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
@@ -666,7 +691,7 @@
 			memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 			taskfile.sector_count	= drive->mult_req;
 			taskfile.command	= WIN_SETMULT;
-			do_taskfile(drive, &taskfile, &hobfile, &set_multmode_intr);
+			ata_taskfile(drive, &taskfile, &hobfile, set_multmode_intr, NULL, NULL);
 		}
 	} else if (s->all) {
 		int special = s->all;
diff -urN linux-2.5.7-pre2/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.7-pre2/drivers/ide/ide-pci.c	Tue Mar 19 03:32:11 2002
+++ linux/drivers/ide/ide-pci.c	Tue Mar 19 00:52:41 2002
@@ -229,6 +229,7 @@
 	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ  | ATA_F_DMA },
 	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, pci_init_pdc202xx, ata66_pdc202xx, ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
 	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, pci_init_pdc202xx, ata66_pdc202xx,	ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
+	{PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, pci_init_pdc202xx, ata66_pdc202xx,	ide_init_pdc202xx, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_DMA },
 #endif
 #ifdef CONFIG_BLK_DEV_RZ1000
 	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000, NULL, NULL,	ide_init_rz1000, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
diff -urN linux-2.5.7-pre2/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.7-pre2/drivers/ide/ide-taskfile.c	Tue Mar 19 03:32:12 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Mar 19 03:26:14 2002
@@ -48,7 +48,7 @@
 	if (rq->bio)
 		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
 	else
-		return rq->buffer + task_rq_offset(rq);
+		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
 }
 
 static inline void ide_unmap_rq(struct request *rq, char *to,
@@ -341,27 +341,37 @@
 	pBuf = ide_map_rq(rq, &flags);
 	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
 		pBuf, nsect, rq->current_nr_sectors);
+
 	drive->io_32bit = 0;
 	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+
 	ide_unmap_rq(rq, pBuf, &flags);
+
 	drive->io_32bit = io_32bit;
+
 	rq->errors = 0;
 	/* Are we sure that this as all been already transfered? */
 	rq->current_nr_sectors -= nsect;
+
 	if (hwgroup->handler == NULL)
 		ide_set_handler(drive, &task_mulout_intr, WAIT_CMD, NULL);
+
 	return ide_started;
 }
 
-ide_startstop_t do_rw_taskfile(ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t ata_taskfile(ide_drive_t *drive,
+		struct hd_drive_task_hdr *taskfile,
+		struct hd_drive_hob_hdr *hobfile,
+		ide_handler_t *handler,
+		ide_pre_handler_t *prehandler,
+		struct request *rq
+		)
 {
-	task_struct_t *taskfile = (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile = (hob_struct_t *) task->hobRegister;
 	struct hd_driveid *id = drive->id;
-	byte HIHI = (drive->addressing) ? 0xE0 : 0xEF;
+	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (task->handler != task_mulout_intr && task->handler != bio_mulout_intr) {
+	if (handler != task_mulout_intr && handler != bio_mulout_intr) {
 		if (IDE_CONTROL_REG)
 			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
 		SELECT_MASK(HWIF(drive), drive, 0);
@@ -386,17 +396,16 @@
 	OUT_BYTE(taskfile->high_cylinder, IDE_HCYL_REG);
 
 	OUT_BYTE((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
-	if (task->handler != NULL) {
-		ide_set_handler (drive, task->handler, WAIT_CMD, NULL);
+	if (handler != NULL) {
+		ide_set_handler(drive, handler, WAIT_CMD, NULL);
 		OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
 		/*
 		 * Warning check for race between handler and prehandler for
 		 * writing first block of data.  however since we are well
 		 * inside the boundaries of the seek, we should be okay.
 		 */
-		if (task->prehandler != NULL) {
-			return task->prehandler(drive, task->rq);
-		}
+		if (prehandler != NULL)
+			return prehandler(drive, rq);
 	} else {
 		/* for dma commands we down set the handler */
 		if (drive->using_dma && !(HWIF(drive)->dmaproc(((taskfile->command == WIN_WRITEDMA) || (taskfile->command == WIN_WRITEDMA_EXT)) ? ide_dma_write : ide_dma_read, drive)));
@@ -405,48 +414,6 @@
 	return ide_started;
 }
 
-void do_taskfile(ide_drive_t *drive, struct hd_drive_task_hdr *taskfile,
-		struct hd_drive_hob_hdr *hobfile,
-		ide_handler_t *handler)
-{
-	struct hd_driveid *id = drive->id;
-	byte HIHI = (drive->addressing) ? 0xE0 : 0xEF;
-
-	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (*handler != task_mulout_intr && handler != bio_mulout_intr) {
-		if (IDE_CONTROL_REG)
-			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
-		SELECT_MASK(HWIF(drive), drive, 0);
-	}
-
-	if ((id->command_set_2 & 0x0400) &&
-	    (id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
-		OUT_BYTE(hobfile->feature, IDE_FEATURE_REG);
-		OUT_BYTE(hobfile->sector_count, IDE_NSECTOR_REG);
-		OUT_BYTE(hobfile->sector_number, IDE_SECTOR_REG);
-		OUT_BYTE(hobfile->low_cylinder, IDE_LCYL_REG);
-		OUT_BYTE(hobfile->high_cylinder, IDE_HCYL_REG);
-	}
-
-	OUT_BYTE(taskfile->feature, IDE_FEATURE_REG);
-	OUT_BYTE(taskfile->sector_count, IDE_NSECTOR_REG);
-	/* refers to number of sectors to transfer */
-	OUT_BYTE(taskfile->sector_number, IDE_SECTOR_REG);
-	/* refers to sector offset or start sector */
-	OUT_BYTE(taskfile->low_cylinder, IDE_LCYL_REG);
-	OUT_BYTE(taskfile->high_cylinder, IDE_HCYL_REG);
-
-	OUT_BYTE((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
-	if (handler != NULL) {
-		ide_set_handler (drive, handler, WAIT_CMD, NULL);
-		OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
-	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma && !(HWIF(drive)->dmaproc(((taskfile->command == WIN_WRITEDMA) || (taskfile->command == WIN_WRITEDMA_EXT)) ? ide_dma_write : ide_dma_read, drive)));
-	}
-}
-
 /*
  * This is invoked on completion of a WIN_SETMULT cmd.
  */
@@ -1162,8 +1129,7 @@
 EXPORT_SYMBOL(atapi_output_bytes);
 EXPORT_SYMBOL(taskfile_input_data);
 EXPORT_SYMBOL(taskfile_output_data);
-EXPORT_SYMBOL(do_rw_taskfile);
-EXPORT_SYMBOL(do_taskfile);
+EXPORT_SYMBOL(ata_taskfile);
 
 EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(set_geometry_intr);
diff -urN linux-2.5.7-pre2/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.7-pre2/drivers/ide/ide.c	Mon Mar 18 16:15:28 2002
+++ linux/drivers/ide/ide.c	Tue Mar 19 03:14:40 2002
@@ -978,7 +978,7 @@
  * setting a timer to wake up at half second intervals thereafter,
  * until timeout is achieved, before timing out.
  */
-int ide_wait_stat (ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout) {
+int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout) {
 	byte stat;
 	int i;
 	unsigned long flags;
@@ -1020,90 +1020,6 @@
 }
 
 /*
- * execute_drive_cmd() issues a special drive command,
- * usually initiated by ioctl() from the external hdparm program.
- */
-static ide_startstop_t execute_drive_cmd (ide_drive_t *drive, struct request *rq)
-{
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-
-		if (!(args))
-			goto args_error;
-
-		do_taskfile(drive,
-				(struct hd_drive_task_hdr *)&args->tfRegister,
-				(struct hd_drive_hob_hdr *)&args->hobRegister,
-				args->handler);
-
-		if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
-		     (args->command_type == IDE_DRIVE_TASK_OUT)) &&
-		      args->prehandler && args->handler)
-			return args->prehandler(drive, rq);
-		return ide_started;
-
-	} else if (rq->flags & REQ_DRIVE_TASK) {
-		byte *args = rq->buffer;
-		byte sel;
-
-		if (!(args)) goto args_error;
-#ifdef DEBUG
-			printk("%s: DRIVE_TASK_CMD ", drive->name);
-			printk("cmd=0x%02x ", args[0]);
-			printk("fr=0x%02x ", args[1]);
-			printk("ns=0x%02x ", args[2]);
-			printk("sc=0x%02x ", args[3]);
-			printk("lcyl=0x%02x ", args[4]);
-			printk("hcyl=0x%02x ", args[5]);
-			printk("sel=0x%02x\n", args[6]);
-#endif
-		OUT_BYTE(args[1], IDE_FEATURE_REG);
-		OUT_BYTE(args[3], IDE_SECTOR_REG);
-		OUT_BYTE(args[4], IDE_LCYL_REG);
-		OUT_BYTE(args[5], IDE_HCYL_REG);
-		sel = (args[6] & ~0x10);
-		if (drive->select.b.unit)
-			sel |= 0x10;
-		OUT_BYTE(sel, IDE_SELECT_REG);
-		ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
-		return ide_started;
-	} else if (rq->flags & REQ_DRIVE_CMD) {
-
-		byte *args = rq->buffer;
-		if (!(args)) goto args_error;
-#ifdef DEBUG
-		printk("%s: DRIVE_CMD ", drive->name);
-		printk("cmd=0x%02x ", args[0]);
-		printk("sc=0x%02x ", args[1]);
-		printk("fr=0x%02x ", args[2]);
-		printk("xx=0x%02x\n", args[3]);
-#endif
-		if (args[0] == WIN_SMART) {
-			OUT_BYTE(0x4f, IDE_LCYL_REG);
-			OUT_BYTE(0xc2, IDE_HCYL_REG);
-			OUT_BYTE(args[2],IDE_FEATURE_REG);
-			OUT_BYTE(args[1],IDE_SECTOR_REG);
-			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
-			return ide_started;
-		}
-		OUT_BYTE(args[2],IDE_FEATURE_REG);
-		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
-		return ide_started;
-	}
-
-args_error:
-	/*
-	 * NULL is actually a valid way of waiting for
-	 * all current requests to be flushed from the queue.
-	 */
-#ifdef DEBUG
-	printk("%s: DRIVE_CMD (null)\n", drive->name);
-#endif
-	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
-	return ide_stopped;
-}
-
-/*
  * start_request() initiates handling of a new I/O request
  */
 static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
@@ -1150,9 +1066,100 @@
 		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
 		return startstop;
 	}
+
+	/* FIXME: We can see nicely here that all commands should be submitted
+	 * through the request queue and that the special field in drive should
+	 * go as soon as possible!
+	 */
+
 	if (!drive->special.all) {
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE))
-			return execute_drive_cmd(drive, rq);
+		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+			/* This issues a special drive command, usually
+			 * initiated by ioctl() from the external hdparm
+			 * program.
+			 */
+
+			if (rq->flags & REQ_DRIVE_TASKFILE) {
+				ide_task_t *args = rq->special;
+
+				if (!(args))
+					goto args_error;
+
+				ata_taskfile(drive,
+						(struct hd_drive_task_hdr *)&args->tfRegister,
+						(struct hd_drive_hob_hdr *)&args->hobRegister,
+						args->handler, NULL, NULL);
+
+				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
+							(args->command_type == IDE_DRIVE_TASK_OUT)) &&
+						args->prehandler && args->handler)
+					return args->prehandler(drive, rq);
+				return ide_started;
+
+			} else if (rq->flags & REQ_DRIVE_TASK) {
+				byte *args = rq->buffer;
+				byte sel;
+
+				if (!(args)) goto args_error;
+#ifdef DEBUG
+				printk("%s: DRIVE_TASK_CMD ", drive->name);
+				printk("cmd=0x%02x ", args[0]);
+				printk("fr=0x%02x ", args[1]);
+				printk("ns=0x%02x ", args[2]);
+				printk("sc=0x%02x ", args[3]);
+				printk("lcyl=0x%02x ", args[4]);
+				printk("hcyl=0x%02x ", args[5]);
+				printk("sel=0x%02x\n", args[6]);
+#endif
+				OUT_BYTE(args[1], IDE_FEATURE_REG);
+				OUT_BYTE(args[3], IDE_SECTOR_REG);
+				OUT_BYTE(args[4], IDE_LCYL_REG);
+				OUT_BYTE(args[5], IDE_HCYL_REG);
+				sel = (args[6] & ~0x10);
+				if (drive->select.b.unit)
+					sel |= 0x10;
+				OUT_BYTE(sel, IDE_SELECT_REG);
+				ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
+				return ide_started;
+			} else if (rq->flags & REQ_DRIVE_CMD) {
+				byte *args = rq->buffer;
+				if (!(args)) goto args_error;
+#ifdef DEBUG
+				printk("%s: DRIVE_CMD ", drive->name);
+				printk("cmd=0x%02x ", args[0]);
+				printk("sc=0x%02x ", args[1]);
+				printk("fr=0x%02x ", args[2]);
+				printk("xx=0x%02x\n", args[3]);
+#endif
+				if (args[0] == WIN_SMART) {
+					OUT_BYTE(0x4f, IDE_LCYL_REG);
+					OUT_BYTE(0xc2, IDE_HCYL_REG);
+					OUT_BYTE(args[2],IDE_FEATURE_REG);
+					OUT_BYTE(args[1],IDE_SECTOR_REG);
+					ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
+
+					return ide_started;
+				}
+				OUT_BYTE(args[2],IDE_FEATURE_REG);
+				ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
+				return ide_started;
+			}
+
+args_error:
+			/*
+			 * NULL is actually a valid way of waiting for all
+			 * current requests to be flushed from the queue.
+			 */
+#ifdef DEBUG
+			printk("%s: DRIVE_CMD (null)\n", drive->name);
+#endif
+			ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+			return ide_stopped;
+		}
+
+		/* The normal way of execution is to pass execute the request
+		 * handler.
+		 */
 
 		if (ata_ops(drive)) {
 			if (ata_ops(drive)->do_request)
@@ -1699,31 +1706,29 @@
 }
 
 /*
- * This function issues a special IDE device request
- * onto the request queue.
+ * This function issues a special IDE device request onto the request queue.
  *
- * If action is ide_wait, then the rq is queued at the end of the
- * request queue, and the function sleeps until it has been processed.
- * This is for use when invoked from an ioctl handler.
+ * If action is ide_wait, then the rq is queued at the end of the request
+ * queue, and the function sleeps until it has been processed.  This is for use
+ * when invoked from an ioctl handler.
  *
- * If action is ide_preempt, then the rq is queued at the head of
- * the request queue, displacing the currently-being-processed
- * request and this function returns immediately without waiting
- * for the new rq to be completed.  This is VERY DANGEROUS, and is
- * intended for careful use by the ATAPI tape/cdrom driver code.
+ * If action is ide_preempt, then the rq is queued at the head of the request
+ * queue, displacing the currently-being-processed request and this function
+ * returns immediately without waiting for the new rq to be completed.  This is
+ * VERY DANGEROUS, and is intended for careful use by the ATAPI tape/cdrom
+ * driver code.
  *
- * If action is ide_next, then the rq is queued immediately after
- * the currently-being-processed-request (if any), and the function
- * returns without waiting for the new rq to be completed.  As above,
- * This is VERY DANGEROUS, and is intended for careful use by the
- * ATAPI tape/cdrom driver code.
+ * If action is ide_next, then the rq is queued immediately after the
+ * currently-being-processed-request (if any), and the function returns without
+ * waiting for the new rq to be completed.  As above, This is VERY DANGEROUS,
+ * and is intended for careful use by the ATAPI tape/cdrom driver code.
  *
- * If action is ide_end, then the rq is queued at the end of the
- * request queue, and the function returns immediately without waiting
- * for the new rq to be completed. This is again intended for careful
- * use by the ATAPI tape/cdrom driver code.
+ * If action is ide_end, then the rq is queued at the end of the request queue,
+ * and the function returns immediately without waiting for the new rq to be
+ * completed. This is again intended for careful use by the ATAPI tape/cdrom
+ * driver code.
  */
-int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t action)
+int ide_do_drive_cmd(ide_drive_t *drive, struct request *rq, ide_action_t action)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -2403,7 +2408,7 @@
 	ide_init_drive_cmd(&rq);
 	drive->tune_req = (byte) arg;
 	drive->special.b.set_tune = 1;
-	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
+	ide_do_drive_cmd(drive, &rq, ide_wait);
 	return 0;
 }
 
diff -urN linux-2.5.7-pre2/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.7-pre2/drivers/ide/pdc202xx.c	Mon Mar 18 16:15:28 2002
+++ linux/drivers/ide/pdc202xx.c	Tue Mar 19 00:49:59 2002
@@ -217,6 +217,9 @@
 		case PCI_DEVICE_ID_PROMISE_20275:
 			p += sprintf(p, "\n                                PDC20275 Chipset.\n");
 			break;
+		case PCI_DEVICE_ID_PROMISE_20276:
+			p += sprintf(p, "\n                                PDC20276 Chipset.\n");
+			break;
 		case PCI_DEVICE_ID_PROMISE_20269:
 			p += sprintf(p, "\n                                PDC20269 TX2 Chipset.\n");
 			break;
@@ -236,6 +239,7 @@
 	char *p = buffer;
 	switch(bmide_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268:
 		case PCI_DEVICE_ID_PROMISE_20268R:
@@ -732,6 +736,7 @@
 
 	switch(dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 			udma_133 = (udma_66) ? 1 : 0;
 			udma_100 = (udma_66) ? 1 : 0;
@@ -989,6 +994,7 @@
 
 	switch (dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268R:
 		case PCI_DEVICE_ID_PROMISE_20268:
@@ -1121,6 +1127,7 @@
 
 	switch (dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268R:
 		case PCI_DEVICE_ID_PROMISE_20268:
@@ -1215,6 +1222,7 @@
 
         switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268:
 		case PCI_DEVICE_ID_PROMISE_20268R:
@@ -1233,6 +1241,7 @@
 
         switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
 		case PCI_DEVICE_ID_PROMISE_20269:
 		case PCI_DEVICE_ID_PROMISE_20268:
 		case PCI_DEVICE_ID_PROMISE_20268R:
diff -urN linux-2.5.7-pre2/drivers/pci/pci.ids linux/drivers/pci/pci.ids
--- linux-2.5.7-pre2/drivers/pci/pci.ids	Tue Mar 19 03:32:12 2002
+++ linux/drivers/pci/pci.ids	Tue Mar 19 00:55:59 2002
@@ -1108,12 +1108,14 @@
 1059  Teknor Industrial Computers Inc
 105a  Promise Technology, Inc.
 	0d30  20265
+	1275  20275
 	4d30  20267
 	4d33  20246
 	4d38  20262
 	4d68  20268
 	6268  20268R
 	4d69  20269
+	5275  20276
 	5300  DC5300
 105b  Foxconn International, Inc.
 105c  Wipro Infotech Limited
diff -urN linux-2.5.7-pre2/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.7-pre2/include/linux/ide.h	Tue Mar 19 03:32:12 2002
+++ linux/include/linux/ide.h	Tue Mar 19 03:21:55 2002
@@ -771,35 +771,7 @@
  */
 #define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-#define task_rq_offset(rq) \
-	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
-
-/*
- * This function issues a special IDE device request
- * onto the request queue.
- *
- * If action is ide_wait, then the rq is queued at the end of the
- * request queue, and the function sleeps until it has been processed.
- * This is for use when invoked from an ioctl handler.
- *
- * If action is ide_preempt, then the rq is queued at the head of
- * the request queue, displacing the currently-being-processed
- * request and this function returns immediately without waiting
- * for the new rq to be completed.  This is VERY DANGEROUS, and is
- * intended for careful use by the ATAPI tape/cdrom driver code.
- *
- * If action is ide_next, then the rq is queued immediately after
- * the currently-being-processed-request (if any), and the function
- * returns without waiting for the new rq to be completed.  As above,
- * This is VERY DANGEROUS, and is intended for careful use by the
- * ATAPI tape/cdrom driver code.
- *
- * If action is ide_end, then the rq is queued at the end of the
- * request queue, and the function returns immediately without waiting
- * for the new rq to be completed. This is again intended for careful
- * use by the ATAPI tape/cdrom driver code.
- */
-int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t action);
+extern int ide_do_drive_cmd(ide_drive_t *drive, struct request *rq, ide_action_t action);
 
 /*
  * Clean up after success/failure of an explicit drive cmd.
@@ -827,15 +799,12 @@
 void taskfile_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void taskfile_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 
-/*
- * taskfile io for disks for now...
- */
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task);
-
-/*
- * Builds request from ide_ioctl
- */
-void do_taskfile (ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, ide_handler_t *handler);
+extern ide_startstop_t ata_taskfile(ide_drive_t *drive,
+		struct hd_drive_task_hdr *taskfile,
+		struct hd_drive_hob_hdr *hobfile,
+		ide_handler_t *handler,
+		ide_pre_handler_t *prehandler,
+		struct request *rq);
 
 /*
  * Special Flagged Register Validation Caller
@@ -871,7 +840,7 @@
  * idedisk_input_data() is a wrapper around ide_input_data() which copes
  * with byte-swapping the input data if required.
  */
-inline void idedisk_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
+extern void idedisk_input_data(ide_drive_t *drive, void *buffer, unsigned int wcount);
 
 /*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
diff -urN linux-2.5.7-pre2/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.5.7-pre2/include/linux/pci_ids.h	Tue Mar 19 03:32:12 2002
+++ linux/include/linux/pci_ids.h	Tue Mar 19 00:44:14 2002
@@ -608,6 +608,7 @@
 #define PCI_DEVICE_ID_PROMISE_20268R	0x6268
 #define PCI_DEVICE_ID_PROMISE_20269	0x4d69
 #define PCI_DEVICE_ID_PROMISE_20275	0x1275
+#define PCI_DEVICE_ID_PROMISE_20276	0x5275
 #define PCI_DEVICE_ID_PROMISE_5300	0x5300
 
 #define PCI_VENDOR_ID_N9		0x105d

--------------080204060100030402040906--

