Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTEHMXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTEHMXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:23:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46982 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261710AbTEHMXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:23:41 -0400
Date: Thu, 8 May 2003 14:36:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508123617.GX823@suse.de>
References: <20030508115950.GQ823@suse.de> <Pine.SOL.4.30.0305081406310.12362-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305081406310.12362-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> 	if (!hwif->rqsize)
> 		hwif->rqsize = hwif->addressing ? 65536 : 256;

btw, you didn't get this right this time either :-)

drive->addressing == 1, 48-bit is ok
hwif->addressing == 1, 48-bit is _not_ ok

below patch covers the lat change as well, boots and works on my router.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1119  -> 1.1122 
#	drivers/ide/ide-taskfile.c	1.16    -> 1.17   
#	drivers/ide/ppc/pmac.c	1.10    -> 1.11   
#	   drivers/ide/ide.c	1.59    -> 1.60   
#	 include/linux/ide.h	1.48    -> 1.49   
#	drivers/ide/setup-pci.c	1.13    -> 1.15   
#	drivers/ide/ide-disk.c	1.40    -> 1.41   
#	drivers/ide/arm/icside.c	1.6     -> 1.7    
#	drivers/ide/ide-dma.c	1.13    -> 1.14   
#	drivers/ide/ide-probe.c	1.41    -> 1.43   
#	drivers/ide/ide-io.c	1.8     -> 1.9    
#	drivers/ide/pci/pdc202xx_old.c	1.13    -> 1.14   
#	drivers/ide/ide-tcq.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/08	axboe@smithers.home.kernel.dk	1.1120
# Proper 48-bit lba support
# --------------------------------------------
# 03/05/08	axboe@smithers.home.kernel.dk	1.1121
# IDE 48-bit adjustments
# --------------------------------------------
# 03/05/08	axboe@smithers.home.kernel.dk	1.1122
# fix max sectors init logic
# --------------------------------------------
#
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/arm/icside.c	Thu May  8 14:32:59 2003
@@ -657,7 +657,7 @@
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
+	} else if (rq_lba48(rq)) {
 		cmd = WIN_READDMA_EXT;
 	} else {
 		cmd = WIN_READDMA;
@@ -698,7 +698,7 @@
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
+	} else if (rq_lba48(rq)) {
 		cmd = WIN_WRITEDMA_EXT;
 	} else {
 		cmd = WIN_WRITEDMA;
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-disk.c	Thu May  8 14:32:59 2003
@@ -358,7 +358,7 @@
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= rq_lba48(rq);
 	task_ioreg_t command	= WIN_NOP;
 	ata_nsector_t		nsectors;
 
@@ -383,7 +383,7 @@
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
 	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
+		if (lba48) {
 			task_ioreg_t tasklets[10];
 
 			if (blk_rq_tagged(rq)) {
@@ -593,7 +593,7 @@
 		return ide_started;
 	}
 
-	if (drive->addressing == 1)		/* 48-bit LBA */
+	if (rq_lba48(rq))			/* 48-bit LBA */
 		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
 		return lba_28_rw_disk(drive, rq, (unsigned long) block);
@@ -602,9 +602,10 @@
 	return chs_rw_disk(drive, rq, (unsigned long) block);
 }
 
-static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
+static task_ioreg_t get_command (ide_drive_t *drive, struct request *rq)
 {
-	int lba48bit = (drive->addressing == 1) ? 1 : 0;
+	int lba48bit = rq_lba48(rq);
+	int cmd = rq_data_dir(rq);
 
 	if ((cmd == READ) && drive->using_tcq)
 		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
@@ -631,7 +632,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
@@ -663,6 +664,7 @@
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 0;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -673,7 +675,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -701,6 +703,7 @@
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 0;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -717,7 +720,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -753,6 +756,7 @@
 	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= drive->select.all;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 1;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -1479,7 +1483,7 @@
 
 static int set_lba_addressing (ide_drive_t *drive, int arg)
 {
-	return (probe_lba_addressing(drive, arg));
+	return probe_lba_addressing(drive, arg);
 }
 
 static void idedisk_add_settings(ide_drive_t *drive)
@@ -1565,6 +1569,18 @@
 	}
 
 	(void) probe_lba_addressing(drive, 1);
+
+	if (drive->addressing == 1) {
+		ide_hwif_t *hwif = HWIF(drive);
+		int max_s = 2048;
+
+		if (max_s > hwif->rqsize)
+			max_s = hwif->rqsize;
+
+		blk_queue_max_sectors(&drive->queue, max_s);
+	}
+
+	printk("%s: max request size: %dKiB\n", drive->name, drive->queue.max_sectors / 2);
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-dma.c	Thu May  8 14:32:59 2003
@@ -653,7 +653,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 1 << 3;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= rq_lba48(rq);
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try pio */
@@ -685,7 +685,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 0;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= rq_lba48(rq);
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try PIO instead of DMA */
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-io.c	Thu May  8 14:32:59 2003
@@ -205,7 +205,7 @@
 			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
 			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 
-			if (drive->addressing == 1) {
+			if (args->addressing == 1) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
 				args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
 				args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-probe.c	Thu May  8 14:32:59 2003
@@ -998,6 +998,7 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
+	ide_hwif_t *hwif = HWIF(drive);
 	int max_sectors = 256;
 
 	/*
@@ -1013,8 +1014,10 @@
 	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
 
-	if (HWIF(drive)->rqsize)
-		max_sectors = HWIF(drive)->rqsize;
+	if (!hwif->rqsize)
+		hwif->rqsize = hwif->addressing ? 256 : 65536;
+	if (hwif->rqsize < max_sectors)
+		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-taskfile.c	Thu May  8 14:32:59 2003
@@ -138,7 +138,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
+	u8 HIHI			= (task->addressing == 1) ? 0xE0 : 0xEF;
 
 #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
 	void debug_taskfile(drive, task);
@@ -151,7 +151,7 @@
 	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
+	if (task->addressing == 1) {
 		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
 		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
 		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
@@ -241,7 +241,7 @@
 	args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 	if ((drive->id->command_set_2 & 0x0400) &&
 	    (drive->id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
+	    (args->addressing == 1)) {
 		hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
 		args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
 		args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
@@ -1272,6 +1272,13 @@
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
+	/*
+	 * this forces 48-bit commands if the drive is configured to do so.
+	 * it would also be possible to lookup the command type based on the
+	 * opcode, but this is way simpler.
+	 */
+	args.addressing = drive->addressing;
+
 #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
 	DTF("%s: ide_ioctl_cmd %s:  ide_task_cmd %s\n",
 		drive->name,
@@ -1611,13 +1618,13 @@
 	 */
 	if (task->tf_out_flags.all == 0) {
 		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
+		if (task->addressing == 1)
 			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
         }
 
 	if (task->tf_in_flags.all == 0) {
 		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
+		if (task->addressing == 1)
 			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
         }
 
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- a/drivers/ide/ide-tcq.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide-tcq.c	Thu May  8 14:32:59 2003
@@ -664,20 +664,20 @@
 
 ide_startstop_t __ide_dma_queued_read(ide_drive_t *drive)
 {
-	u8 command = WIN_READDMA_QUEUED;
+	struct request *rq = hwgroup->rq;
+	u8 command;
 
-	if (drive->addressing == 1)
-		 command = WIN_READDMA_QUEUED_EXT;
+	command = rq_lba48(rq) ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
 
 	return ide_dma_queued_rw(drive, command);
 }
 
 ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive)
 {
-	u8 command = WIN_WRITEDMA_QUEUED;
+	struct request *rq = hwgroup->rq;
+	u8 command;
 
-	if (drive->addressing == 1)
-		 command = WIN_WRITEDMA_QUEUED_EXT;
+	command = rq_lba48(rq) ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
 
 	return ide_dma_queued_rw(drive, command);
 }
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ide.c	Thu May  8 14:32:59 2003
@@ -400,9 +400,20 @@
 			if (err & MARK_ERR)	printk("AddrMarkNotFound ");
 			printk("}");
 			if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
+				struct request *rq = HWGROUP(drive)->rq;
+				int lba48 = drive->addressing;
+
+				if (rq) {
+					if (rq->flags & REQ_DRIVE_TASKFILE) {
+						ide_task_t *t = rq->special;
+						lba48 = t->addressing;
+					} else
+						lba48 = rq_lba48(rq);
+				}
+
 				if ((drive->id->command_set_2 & 0x0400) &&
 				    (drive->id->cfs_enable_2 & 0x0400) &&
-				    (drive->addressing == 1)) {
+				    lba48) {
 					u64 sectors = 0;
 					u32 high = 0;
 					u32 low = ide_read_24(drive);
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/pci/pdc202xx_old.c	Thu May  8 14:32:59 2003
@@ -535,8 +535,9 @@
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
-		struct request *rq	= HWGROUP(drive)->rq;
+	struct request *rq = HWGROUP(drive)->rq;
+
+	if (rq_lba48(rq)) {
 		ide_hwif_t *hwif	= HWIF(drive);
 //		struct pci_dev *dev	= hwif->pci_dev;
 //		unsgned long high_16	= pci_resource_start(dev, 4);
@@ -557,7 +558,9 @@
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
+	struct request *rq = HWGROUP(drive)->rq;
+
+	if (rq_lba48(rq)) {
 		ide_hwif_t *hwif	= HWIF(drive);
 //		unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
 		unsigned long high_16	= hwif->dma_master;
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	Thu May  8 14:32:59 2003
+++ b/drivers/ide/ppc/pmac.c	Thu May  8 14:32:59 2003
@@ -1240,7 +1240,6 @@
 //	ide_task_t *args = rq->special;
 	u8 unit = (drive->select.b.unit & 0x01);
 	u8 ata4;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command = WIN_NOP;
 
 	if (pmif == NULL)
@@ -1272,7 +1271,7 @@
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
 #else
-	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
+	command = rq_lba48(rq) ? WIN_READDMA_EXT : WIN_READDMA;
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
@@ -1293,7 +1292,6 @@
 //	ide_task_t *args = rq->special;
 	u8 unit = (drive->select.b.unit & 0x01);
 	u8 ata4;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command = WIN_NOP;
 
 	if (pmif == NULL)
@@ -1325,7 +1323,7 @@
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
 #else
-	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+	command = rq_lba48(rq) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Thu May  8 14:32:59 2003
+++ b/include/linux/ide.h	Thu May  8 14:32:59 2003
@@ -846,6 +846,12 @@
 		bio_kunmap_irq(buffer, flags);
 }
 
+/*
+ * must be addressed with 48-bit lba
+ */
+#define rq_lba48(rq)	\
+	(((rq)->sector + (rq)->nr_sectors) > 0xfffffff || rq->nr_sectors > 256)
+
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
@@ -1387,6 +1393,7 @@
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
 	int			command_type;
+	int			addressing;	/* 1 for 48-bit */
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	ide_post_handler_t	*posthandler;

-- 
Jens Axboe

