Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTDDMUR (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTDDMUR (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:20:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263698AbTDDMSO (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 07:18:14 -0500
Date: Fri, 4 Apr 2003 14:29:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030404122936.GB786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

48-bit lba has a non-significant overhead (twice the outb's, 12 instead
of 6 per command), so it makes sense to use 28-bit lba commands whenever
we can.

Patch is against 2.5.66-BK.

===== drivers/ide/ide-disk.c 1.36 vs edited =====
--- 1.36/drivers/ide/ide-disk.c	Wed Mar 26 21:23:01 2003
+++ edited/drivers/ide/ide-disk.c	Fri Apr  4 14:18:41 2003
@@ -367,12 +367,15 @@
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= 0;
 	task_ioreg_t command	= WIN_NOP;
 	ata_nsector_t		nsectors;
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
+	if (drive->addressing == 1 && block > 0xfffffff)
+		lba48 = 1;
+
 	if (driver_blocked)
 		panic("Request while ide driver is blocked?");
 
@@ -392,7 +395,7 @@
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
 	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
+		if (lba48) {
 			task_ioreg_t tasklets[10];
 
 			if (blk_rq_tagged(rq)) {
@@ -502,6 +505,7 @@
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
 			   ((lba48) ? WIN_READ_EXT : WIN_READ));
+
 		ide_execute_command(drive, command, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	} else if (rq_data_dir(rq) == WRITE) {
@@ -577,6 +581,11 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
+	int lba48bit = 0;
+
+	if (drive->addressing == 1 && block > 0xfffffff)
+		lba48bit = 1;
+
 	BUG_ON(drive->blocked);
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
@@ -602,7 +611,7 @@
 		return ide_started;
 	}
 
-	if (drive->addressing == 1)		/* 48-bit LBA */
+	if (lba48bit && block > 0xfffffff)
 		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
 		return lba_28_rw_disk(drive, rq, (unsigned long) block);
@@ -611,9 +620,13 @@
 	return chs_rw_disk(drive, rq, (unsigned long) block);
 }
 
-static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
+static task_ioreg_t get_command (ide_drive_t *drive, struct request *rq)
 {
-	int lba48bit = (drive->addressing == 1) ? 1 : 0;
+	int cmd = rq_data_dir(rq);
+	int lba48bit = 0;
+
+	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+		lba48bit = 1;
 
 	if ((cmd == READ) && drive->using_tcq)
 		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
@@ -640,7 +653,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
@@ -672,6 +685,7 @@
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 0;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -682,7 +696,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -710,6 +724,7 @@
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 0;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -726,7 +741,7 @@
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -762,6 +777,7 @@
 	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= drive->select.all;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= ide_cmd_type_parser(&args);
+	args.addressing				= 1;
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
===== drivers/ide/ide-dma.c 1.13 vs edited =====
--- 1.13/drivers/ide/ide-dma.c	Fri Mar  7 18:14:31 2003
+++ edited/drivers/ide/ide-dma.c	Fri Apr  4 14:15:37 2003
@@ -653,7 +653,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 1 << 3;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= 0;
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try pio */
@@ -663,11 +663,14 @@
 	if (drive->media != ide_disk)
 		return 0;
 
+	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+		lba48 = 1;
+
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	
+
 	if (drive->vdma)
 		command = (lba48) ? WIN_READ_EXT: WIN_READ;
-		
+
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
@@ -685,7 +688,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 0;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= 0;
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try PIO instead of DMA */
@@ -695,10 +698,13 @@
 	if (drive->media != ide_disk)
 		return 0;
 
+	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+		lba48 = 1;
+
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	if (drive->vdma)
 		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
-		
+
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
===== drivers/ide/ide-taskfile.c 1.14 vs edited =====
--- 1.14/drivers/ide/ide-taskfile.c	Wed Mar 26 21:22:22 2003
+++ edited/drivers/ide/ide-taskfile.c	Fri Apr  4 14:20:26 2003
@@ -147,7 +147,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
+	u8 HIHI			= task->addressing == 1 ? 0xE0 : 0xEF;
 
 #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
 	void debug_taskfile(drive, task);
@@ -160,7 +160,7 @@
 	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
+	if (task->addressing == 1) {
 		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
 		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
 		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
@@ -332,7 +332,7 @@
 	args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 	if ((drive->id->command_set_2 & 0x0400) &&
 	    (drive->id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
+	    (args->addressing == 1)) {
 		hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
 		args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
 		args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
@@ -1795,13 +1795,13 @@
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
 
===== include/linux/ide.h 1.42 vs edited =====
--- 1.42/include/linux/ide.h	Thu Mar 20 19:23:19 2003
+++ edited/include/linux/ide.h	Fri Apr  4 14:07:50 2003
@@ -1408,6 +1408,7 @@
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
 	int			command_type;
+	int			addressing;	/* 1 for 48-bit */
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	ide_post_handler_t	*posthandler;

-- 
Jens Axboe

