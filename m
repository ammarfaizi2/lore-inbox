Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSDJOQP>; Wed, 10 Apr 2002 10:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313133AbSDJOQO>; Wed, 10 Apr 2002 10:16:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45062 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313122AbSDJOQC>; Wed, 10 Apr 2002 10:16:02 -0400
Message-ID: <3CB43A9A.7050200@evision-ventures.com>
Date: Wed, 10 Apr 2002 15:14:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8-pre3 IDE 30
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030509050105040206040504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509050105040206040504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tought this was patched against 2.5.8-pre2 it still applyes
cleanly to 2.5.8-pre3.

Tue Apr  9 01:02:05 CEST 2002 ide-clean-30

- Sync up with 2.5.8-pre3 patch.

- Eliminate ide_task_t and rename struct ide_task_s to struct ata_taskfile.
   This should become the entity which is holding all data for a request in the
   future. If this turns out to be the case, we will just rename it to
   ata_request.

- Reduce the number of arguments for the ata_taskfile() function. This helps to
   wipe quite a lot of code out as well.

This stage is not sensitive, so let's make a patch before we start to integrate
the last work of Jens Axboe.


--------------030509050105040206040504
Content-Type: text/plain;
 name="ide-clean-30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-30.diff"

diff -urN linux-2.5.8-pre2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8-pre2/drivers/ide/ide-disk.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-disk.c	Tue Apr  9 02:25:53 2002
@@ -154,7 +154,7 @@
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	struct ata_taskfile		args;
 	int				sectors;
 
 	unsigned int track	= (block / drive->sect);
@@ -193,19 +193,14 @@
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
-	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
-			rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
 static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	struct ata_taskfile		args;
 	int				sectors;
 
 	sectors = rq->nr_sectors;
@@ -239,12 +234,7 @@
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
-	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
-			rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
 /*
@@ -257,7 +247,7 @@
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	struct ata_taskfile		args;
 	int				sectors;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
@@ -302,12 +292,7 @@
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
-	return ata_taskfile(drive,
-			&args.taskfile,
-			&args.hobfile,
-			args.handler,
-			args.prehandler,
-			rq);
+	return ata_taskfile(drive, &args, rq);
 }
 
 /*
@@ -426,7 +411,8 @@
  */
 static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
 {
-	ide_task_t args;
+	/* FIXME: This is on stack! */
+	struct ata_taskfile args;
 	unsigned long addr = 0;
 
 	if (!(drive->id->command_set_1 & 0x0400) &&
@@ -434,7 +420,7 @@
 		return addr;
 
 	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
+	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.taskfile.command = WIN_READ_NATIVE_MAX;
 	args.handler = task_no_data_intr;
@@ -457,11 +443,11 @@
 
 static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
 {
-	ide_task_t args;
+	struct ata_taskfile args;
 	unsigned long long addr = 0;
 
 	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
+	memset(&args, 0, sizeof(args));
 
 	args.taskfile.device_head = 0x40;
 	args.taskfile.command = WIN_READ_NATIVE_MAX_EXT;
@@ -493,12 +479,12 @@
  */
 static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
 {
-	ide_task_t args;
+	struct ata_taskfile args;
 	unsigned long addr_set = 0;
 
 	addr_req--;
 	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
+	memset(&args, 0, sizeof(args));
 
 	args.taskfile.sector_number = (addr_req >> 0);
 	args.taskfile.low_cylinder = (addr_req >> 8);
@@ -522,12 +508,12 @@
 
 static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
 {
-	ide_task_t args;
+	struct ata_taskfile args;
 	unsigned long long addr_set = 0;
 
 	addr_req--;
 	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
+	memset(&args, 0, sizeof(args));
 
 	args.taskfile.sector_number = (addr_req >>  0);
 	args.taskfile.low_cylinder = (addr_req >>= 8);
@@ -667,47 +653,45 @@
 	special_t *s = &drive->special;
 
 	if (s->b.set_geometry) {
-		struct hd_drive_task_hdr taskfile;
-		struct hd_drive_hob_hdr hobfile;
-		ide_handler_t *handler = NULL;
-
-		memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+		struct ata_taskfile args;
 
 		s->b.set_geometry	= 0;
-		taskfile.sector_number	= drive->sect;
-		taskfile.low_cylinder	= drive->cyl;
-		taskfile.high_cylinder	= drive->cyl>>8;
-		taskfile.device_head	= ((drive->head-1)|drive->select.all)&0xBF;
+
+		memset(&args, 0, sizeof(args));
+		args.taskfile.sector_number	= drive->sect;
+		args.taskfile.low_cylinder	= drive->cyl;
+		args.taskfile.high_cylinder	= drive->cyl>>8;
+		args.taskfile.device_head	= ((drive->head-1)|drive->select.all)&0xBF;
 		if (!IS_PDC4030_DRIVE) {
-			taskfile.sector_count = drive->sect;
-			taskfile.command = WIN_SPECIFY;
-			handler	= set_geometry_intr;;
+			args.taskfile.sector_count = drive->sect;
+			args.taskfile.command = WIN_SPECIFY;
+			args.handler = set_geometry_intr;;
 		}
-		ata_taskfile(drive, &taskfile, &hobfile, handler, NULL, NULL);
+		ata_taskfile(drive, &args, NULL);
 	} else if (s->b.recalibrate) {
 		s->b.recalibrate = 0;
 		if (!IS_PDC4030_DRIVE) {
-			struct hd_drive_task_hdr taskfile;
-			struct hd_drive_hob_hdr hobfile;
-			memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-			memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-			taskfile.sector_count	= drive->sect;
-			taskfile.command	= WIN_RESTORE;
-			ata_taskfile(drive, &taskfile, &hobfile, recal_intr, NULL, NULL);
+			struct ata_taskfile args;
+
+			memset(&args, 0, sizeof(args));
+			args.taskfile.sector_count = drive->sect;
+			args.taskfile.command = WIN_RESTORE;
+			args.handler = recal_intr;
+			ata_taskfile(drive, &args, NULL);
 		}
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
 		if (drive->id && drive->mult_req > drive->id->max_multsect)
 			drive->mult_req = drive->id->max_multsect;
 		if (!IS_PDC4030_DRIVE) {
-			struct hd_drive_task_hdr taskfile;
-			struct hd_drive_hob_hdr hobfile;
-			memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-			memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-			taskfile.sector_count	= drive->mult_req;
-			taskfile.command	= WIN_SETMULT;
-			ata_taskfile(drive, &taskfile, &hobfile, set_multmode_intr, NULL, NULL);
+			struct ata_taskfile args;
+
+			memset(&args, 0, sizeof(args));
+			args.taskfile.sector_count = drive->mult_req;
+			args.taskfile.command = WIN_SETMULT;
+			args.handler = set_multmode_intr;
+
+			ata_taskfile(drive, &args, NULL);
 		}
 	} else if (s->all) {
 		int special = s->all;
diff -urN linux-2.5.8-pre2/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8-pre2/drivers/ide/ide-dma.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/ide-dma.c	Tue Apr  9 01:43:45 2002
@@ -82,6 +82,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ide.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -238,29 +239,33 @@
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
-static int ide_raw_build_sglist(struct ata_channel *hwif, struct request *rq)
+/*
+ * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
+ * FIXME: I agree with Jens --mdcki!
+ */
+static int raw_build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	struct scatterlist *sg = hwif->sg_table;
+	struct scatterlist *sg = ch->sg_table;
 	int nents = 0;
-	ide_task_t *args = rq->special;
+	struct ata_taskfile *args = rq->special;
 #if 1
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
 #else
-        nents = blk_rq_map_sg(rq->q, rq, hwif->sg_table);
+        nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
 
 	if (nents > rq->nr_segments)
 		printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
 #endif
 
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+		ch->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
 
-#if 1	
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
+
 		sg[nents].page = virt_to_page(virt_addr);
 		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 		sg[nents].length = 128  * SECTOR_SIZE;
@@ -273,9 +278,8 @@
 	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
- #endif
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
 }
 
 /*
@@ -297,7 +301,7 @@
 	struct scatterlist *sg;
 
 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		hwif->sg_nents = i = ide_raw_build_sglist(hwif, HWGROUP(drive)->rq);
+		hwif->sg_nents = i = raw_build_sglist(hwif, HWGROUP(drive)->rq);
 	} else {
 		hwif->sg_nents = i = ide_build_sglist(hwif, HWGROUP(drive)->rq);
 	}
@@ -593,7 +597,7 @@
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
 			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
+				struct ata_taskfile *args = HWGROUP(drive)->rq->special;
 				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 			} else if (drive->addressing) {
 				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -urN linux-2.5.8-pre2/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.8-pre2/drivers/ide/ide-features.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-features.c	Tue Apr  9 01:42:38 2002
@@ -184,7 +184,7 @@
  * in combination with the device (usually a disk) properly detect
  * and acknowledge each end of the ribbon.
  */
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
+int ide_ata66_check (ide_drive_t *drive, struct ata_taskfile *args)
 {
 	if ((args->taskfile.command == WIN_SETFEATURES) &&
 	    (args->taskfile.sector_number > XFER_UDMA_2) &&
@@ -211,7 +211,7 @@
  * 1 : Safe to update drive->id DMA registers.
  * 0 : OOPs not allowed.
  */
-int set_transfer (ide_drive_t *drive, ide_task_t *args)
+int set_transfer (ide_drive_t *drive, struct ata_taskfile *args)
 {
 	if ((args->taskfile.command == WIN_SETFEATURES) &&
 	    (args->taskfile.sector_number >= XFER_SW_DMA_0) &&
diff -urN linux-2.5.8-pre2/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.8-pre2/drivers/ide/ide-pmac.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/ide-pmac.c	Tue Apr  9 01:53:06 2002
@@ -1055,13 +1055,13 @@
 }
 
 static int
-pmac_ide_raw_build_sglist (int ix, struct request *rq)
+pmac_raw_build_sglist (int ix, struct request *rq)
 {
 	struct ata_channel *hwif = &ide_hwifs[ix];
 	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
 	struct scatterlist *sg = pmif->sg_table;
 	int nents = 0;
-	ide_task_t *args = rq->special;
+	struct ata_taskfile *args = rq->special;
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
 
@@ -1111,7 +1111,7 @@
 
 	/* Build sglist */
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		pmac_ide[ix].sg_nents = i = pmac_ide_raw_build_sglist(ix, rq);
+		pmac_ide[ix].sg_nents = i = pmac_raw_build_sglist(ix, rq);
 	} else {
 		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
 	}
@@ -1389,7 +1389,7 @@
 		ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
 		    (drive->addressing == 1)) {
-			ide_task_t *args = HWGROUP(drive)->rq->special;
+			struct ata_taskfile *args = HWGROUP(drive)->rq->special;
 			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 		} else if (drive->addressing) {
 			OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -urN linux-2.5.8-pre2/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8-pre2/drivers/ide/ide-taskfile.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Apr  9 02:48:27 2002
@@ -291,7 +291,7 @@
 
 static ide_startstop_t pre_task_mulout_intr(ide_drive_t *drive, struct request *rq)
 {
-	ide_task_t *args = rq->special;
+	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
 	/*
@@ -303,6 +303,7 @@
 		return startstop;
 
 	ata_poll_drive_ready(drive);
+
 	return args->handler(drive);
 }
 
@@ -391,18 +392,13 @@
 }
 
 ide_startstop_t ata_taskfile(ide_drive_t *drive,
-		struct hd_drive_task_hdr *taskfile,
-		struct hd_drive_hob_hdr *hobfile,
-		ide_handler_t *handler,
-		ide_pre_handler_t *prehandler,
-		struct request *rq
-		)
+		struct ata_taskfile *args, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
 	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (handler != task_mulout_intr) {
+	if (args->handler != task_mulout_intr) {
 		if (IDE_CONTROL_REG)
 			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
 		SELECT_MASK(drive->channel, drive, 0);
@@ -411,35 +407,38 @@
 	if ((id->command_set_2 & 0x0400) &&
 	    (id->cfs_enable_2 & 0x0400) &&
 	    (drive->addressing == 1)) {
-		OUT_BYTE(hobfile->feature, IDE_FEATURE_REG);
-		OUT_BYTE(hobfile->sector_count, IDE_NSECTOR_REG);
-		OUT_BYTE(hobfile->sector_number, IDE_SECTOR_REG);
-		OUT_BYTE(hobfile->low_cylinder, IDE_LCYL_REG);
-		OUT_BYTE(hobfile->high_cylinder, IDE_HCYL_REG);
+		OUT_BYTE(args->hobfile.feature, IDE_FEATURE_REG);
+		OUT_BYTE(args->hobfile.sector_count, IDE_NSECTOR_REG);
+		OUT_BYTE(args->hobfile.sector_number, IDE_SECTOR_REG);
+		OUT_BYTE(args->hobfile.low_cylinder, IDE_LCYL_REG);
+		OUT_BYTE(args->hobfile.high_cylinder, IDE_HCYL_REG);
 	}
 
-	OUT_BYTE(taskfile->feature, IDE_FEATURE_REG);
-	OUT_BYTE(taskfile->sector_count, IDE_NSECTOR_REG);
+	OUT_BYTE(args->taskfile.feature, IDE_FEATURE_REG);
+	OUT_BYTE(args->taskfile.sector_count, IDE_NSECTOR_REG);
 	/* refers to number of sectors to transfer */
-	OUT_BYTE(taskfile->sector_number, IDE_SECTOR_REG);
+	OUT_BYTE(args->taskfile.sector_number, IDE_SECTOR_REG);
 	/* refers to sector offset or start sector */
-	OUT_BYTE(taskfile->low_cylinder, IDE_LCYL_REG);
-	OUT_BYTE(taskfile->high_cylinder, IDE_HCYL_REG);
+	OUT_BYTE(args->taskfile.low_cylinder, IDE_LCYL_REG);
+	OUT_BYTE(args->taskfile.high_cylinder, IDE_HCYL_REG);
 
-	OUT_BYTE((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
-	if (handler != NULL) {
-		ide_set_handler(drive, handler, WAIT_CMD, NULL);
-		OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
+	OUT_BYTE((args->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+	if (args->handler != NULL) {
+		ide_set_handler(drive, args->handler, WAIT_CMD, NULL);
+		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 		/*
 		 * Warning check for race between handler and prehandler for
 		 * writing first block of data.  however since we are well
 		 * inside the boundaries of the seek, we should be okay.
 		 */
-		if (prehandler != NULL)
-			return prehandler(drive, rq);
+		if (args->prehandler != NULL)
+			return args->prehandler(drive, rq);
 	} else {
 		/* for dma commands we down set the handler */
-		if (drive->using_dma && !(drive->channel->dmaproc(((taskfile->command == WIN_WRITEDMA) || (taskfile->command == WIN_WRITEDMA_EXT)) ? ide_dma_write : ide_dma_read, drive)));
+		if (drive->using_dma &&
+		!(drive->channel->dmaproc(((args->taskfile.command == WIN_WRITEDMA)
+					|| (args->taskfile.command == WIN_WRITEDMA_EXT))
+					? ide_dma_write : ide_dma_read, drive)));
 	}
 
 	return ide_started;
@@ -496,7 +495,7 @@
  */
 ide_startstop_t task_no_data_intr (ide_drive_t *drive)
 {
-	ide_task_t *args	= HWGROUP(drive)->rq->special;
+	struct ata_taskfile *args = HWGROUP(drive)->rq->special;
 	byte stat		= GET_STAT();
 
 	ide__sti();	/* local CPU only */
@@ -554,9 +553,9 @@
 	return ide_stopped;
 }
 
-static ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 {
-	ide_task_t *args = rq->special;
+	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
@@ -669,7 +668,7 @@
 }
 
 /* Called by ioctl to feature out type of command being called */
-void ide_cmd_type_parser(ide_task_t *args)
+void ide_cmd_type_parser(struct ata_taskfile *args)
 {
 	struct hd_drive_task_hdr *taskfile = &args->taskfile;
 
@@ -877,9 +876,9 @@
 {
 	struct request rq;
 	/* FIXME: This is on stack! */
-	ide_task_t args;
+	struct ata_taskfile args;
 
-	memset(&args, 0, sizeof(ide_task_t));
+	memset(&args, 0, sizeof(args));
 
 	args.taskfile = *taskfile;
 	args.hobfile = *hobfile;
@@ -897,7 +896,7 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *args, byte *buf)
+int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
 	init_taskfile_request(&rq);
@@ -943,7 +942,8 @@
 	u8 *argbuf = args;
 	byte xfer_rate = 0;
 	int argsize = 4;
-	ide_task_t tfargs;
+	/* FIXME: this should not reside on the stack */
+	struct ata_taskfile tfargs;
 
 	if (NULL == (void *) arg) {
 		struct request rq;
diff -urN linux-2.5.8-pre2/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8-pre2/drivers/ide/ide.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/ide.c	Tue Apr  9 03:07:51 2002
@@ -709,7 +709,7 @@
 /*
  * Clean up after success/failure of an explicit drive cmd
  */
-void ide_end_drive_cmd (ide_drive_t *drive, byte stat, byte err)
+void ide_end_drive_cmd(ide_drive_t *drive, byte stat, byte err)
 {
 	unsigned long flags;
 	struct request *rq;
@@ -738,8 +738,8 @@
 			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
 	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = (ide_task_t *) rq->special;
-		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
+		struct ata_taskfile *args = rq->special;
+		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -1023,9 +1023,9 @@
 }
 
 /*
- * start_request() initiates handling of a new I/O request
+ * This initiates handling of a new I/O request.
  */
-static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t start_request(ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
 	unsigned long block;
@@ -1083,15 +1083,12 @@
 			 */
 
 			if (rq->flags & REQ_DRIVE_TASKFILE) {
-				ide_task_t *args = rq->special;
+				struct ata_taskfile *args = rq->special;
 
 				if (!(args))
 					goto args_error;
 
-				ata_taskfile(drive,
-						&args->taskfile,
-						&args->hobfile,
-						args->handler, NULL, NULL);
+				ata_taskfile(drive, args, NULL);
 
 				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
 					(args->command_type == IDE_DRIVE_TASK_OUT)) &&
@@ -1185,7 +1182,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t restart_request (ide_drive_t *drive)
+ide_startstop_t restart_request(ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
@@ -1417,9 +1414,9 @@
 }
 
 /*
- * ide_timer_expiry() is our timeout function for all drive operations.
- * But note that it can also be invoked as a result of a "sleep" operation
- * triggered by the mod_timer() call in ide_do_request.
+ * This is our timeout function for all drive operations.  But note that it can
+ * also be invoked as a result of a "sleep" operation triggered by the
+ * mod_timer() call in ide_do_request.
  */
 void ide_timer_expiry(unsigned long data)
 {
@@ -1478,7 +1475,7 @@
 			disable_irq_nosync(hwif->irq);
 #else
 			disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
-#endif /* DISABLE_IRQ_NOSYNC */
+#endif
 			__cli();	/* local CPU only, as if we were handling an interrupt */
 			if (hwgroup->poll_timeout != 0) {
 				startstop = handler(drive);
@@ -1608,7 +1605,8 @@
 	drive = hwgroup->drive;
 	if (!drive) {
 		/*
-		 * This should NEVER happen, and there isn't much we could do about it here.
+		 * This should NEVER happen, and there isn't much we could do
+		 * about it here.
 		 */
 		goto out_lock;
 	}
@@ -1734,9 +1732,9 @@
 		if (action == ide_preempt)
 			hwgroup->rq = NULL;
 	} else {
-		if (action == ide_wait || action == ide_end) {
+		if (action == ide_wait || action == ide_end)
 			queue_head = queue_head->prev;
-		} else
+		else
 			queue_head = queue_head->next;
 	}
 	q->elevator.elevator_add_req_fn(q, rq, queue_head);
@@ -1848,7 +1846,7 @@
 
 	/* Request a particular device type module.
 	 *
-	 * FIXME: The function which should rather requests the drivers is
+	 * FIXME: The function which should rather requests the drivers in
 	 * ide_driver_module(), since it seems illogical and even a bit
 	 * dangerous to delay this until open time!
 	 */
@@ -2088,7 +2086,7 @@
 	 * it.
 	 */
 
-	old_hwif		= *channel;
+	old_hwif = *channel;
 	init_hwif_data(channel, channel->index);
 	channel->hwgroup = old_hwif.hwgroup;
 	channel->tuneproc = old_hwif.tuneproc;
diff -urN linux-2.5.8-pre2/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8-pre2/drivers/ide/pdc4030.c	Tue Apr  9 20:36:00 2002
+++ linux/drivers/ide/pdc4030.c	Tue Apr  9 01:45:39 2002
@@ -551,7 +551,7 @@
  * already set up. It issues a READ or WRITE command to the Promise
  * controller, assuming LBA has been used to set up the block number.
  */
-ide_startstop_t do_pdc4030_io (ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t do_pdc4030_io(ide_drive_t *drive, struct ata_taskfile *task)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	struct hd_drive_task_hdr *taskfile = &task->taskfile;
@@ -644,7 +644,7 @@
 ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
 	struct hd_drive_task_hdr taskfile;
-	ide_task_t		 args;
+	struct ata_taskfile args;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 
diff -urN linux-2.5.8-pre2/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8-pre2/include/linux/ide.h	Tue Apr  9 20:36:00 2002
+++ linux/include/linux/ide.h	Tue Apr  9 02:09:37 2002
@@ -13,7 +13,9 @@
 #include <linux/proc_fs.h>
 #include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/interrupt.h>
 #include <asm/hdreg.h>
+#include <asm/bitops.h>
 
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
@@ -111,6 +113,7 @@
 #define GET_ERR()		IN_BYTE(IDE_ERROR_REG)
 #define GET_STAT()		IN_BYTE(IDE_STATUS_REG)
 #define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
+#define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 #define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
@@ -132,6 +135,7 @@
  */
 #define PRD_BYTES	8
 #define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
+#define PRD_SEGMENTS	32
 
 /*
  * Some more useful definitions
@@ -275,7 +279,7 @@
 	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
 
 	/* NOTE: If we had proper separation between channel and host chip, we
-	 * could move this to the chanell and many sync problems would
+	 * could move this to the channel and many sync problems would
 	 * magically just go away.
 	 */
 	request_queue_t	queue;	/* per device request queue */
@@ -500,16 +504,18 @@
 extern void ide_unregister(struct ata_channel *hwif);
 
 /*
- * Status returned from various ide_ functions
+ * Status returned by various functions.
  */
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
-	ide_started	/* a drive operation was started, and a handler was set */
+	ide_started,	/* a drive operation was started, and a handler was set */
+	ide_released	/* started and released bus */
 } ide_startstop_t;
 
 /*
- *  internal ide interrupt handler type
+ *  Interrupt handler types.
  */
+struct ata_taskfile;
 typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct request *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 
@@ -519,15 +525,18 @@
  */
 typedef int (ide_expiry_t)(ide_drive_t *);
 
-#define IDE_BUSY	0
+#define IDE_BUSY	0	/* awaiting an interrupt */
 #define IDE_SLEEP	1
+#define IDE_DMA		2	/* DMA in progress */
 
 typedef struct hwgroup_s {
 	ide_handler_t		*handler;/* irq handler, if active */
 	unsigned long		flags;	/* BUSY, SLEEPING */
 	ide_drive_t		*drive;	/* current drive */
 	struct ata_channel	*hwif;	/* ptr to current hwif in linked-list */
+
 	struct request		*rq;	/* current request */
+
 	struct timer_list	timer;	/* failsafe timer */
 	struct request		wrq;	/* local copy of current write rq */
 	unsigned long		poll_timeout;	/* timeout value during long polls */
@@ -736,7 +745,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-void ide_init_drive_cmd (struct request *rq);
+extern void ide_init_drive_cmd (struct request *rq);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -760,13 +769,13 @@
  */
 void ide_end_drive_cmd (ide_drive_t *drive, byte stat, byte err);
 
-typedef struct ide_task_s {
+struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr  hobfile;
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
-} ide_task_t;
+};
 
 void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 void ata_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
@@ -776,11 +785,7 @@
 void taskfile_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
 
 extern ide_startstop_t ata_taskfile(ide_drive_t *drive,
-		struct hd_drive_task_hdr *taskfile,
-		struct hd_drive_hob_hdr *hobfile,
-		ide_handler_t *handler,
-		ide_pre_handler_t *prehandler,
-		struct request *rq);
+		struct ata_taskfile *args, struct request *rq);
 
 /*
  * Special Flagged Register Validation Caller
@@ -793,10 +798,11 @@
 
 int ide_wait_taskfile (ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf);
 
-int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *cmd, byte *buf);
+int ide_raw_taskfile (ide_drive_t *drive, struct ata_taskfile *cmd, byte *buf);
 
-/* Expects args is a full set of TF registers and parses the command type */
-extern void ide_cmd_type_parser(ide_task_t *args);
+/* This is setting up all fields in args, which depend upon the command type.
+ */
+extern void ide_cmd_type_parser(struct ata_taskfile *args);
 
 int ide_cmd_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
 int ide_task_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
@@ -805,10 +811,10 @@
 
 byte ide_auto_reduce_xfer (ide_drive_t *drive);
 int ide_driveid_update (ide_drive_t *drive);
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args);
+int ide_ata66_check (ide_drive_t *drive, struct ata_taskfile *args);
 int ide_config_drive_speed (ide_drive_t *drive, byte speed);
 byte eighty_ninty_three (ide_drive_t *drive);
-int set_transfer (ide_drive_t *drive, ide_task_t *args);
+int set_transfer (ide_drive_t *drive, struct ata_taskfile *args);
 
 extern int system_bus_speed;
 
@@ -896,6 +902,8 @@
 
 extern spinlock_t ide_lock;
 
+#define DRIVE_LOCK(drive)		((drive)->queue.queue_lock)
+
 extern int drive_is_ready(ide_drive_t *drive);
 extern void revalidate_drives(void);
 

--------------030509050105040206040504--

