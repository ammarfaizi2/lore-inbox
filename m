Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288744AbSAQNrb>; Thu, 17 Jan 2002 08:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSAQNrX>; Thu, 17 Jan 2002 08:47:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60687 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288732AbSAQNrP>;
	Thu, 17 Jan 2002 08:47:15 -0500
Date: Thu, 17 Jan 2002 14:46:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] 2.5.3-pre1 ide updates
Message-ID: <20020117144648.L20994@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes IDE pio and multi mode work again. Changes:

- Properly map in requests, nr_sectors hack was very wrong (me)

- Fix pio interrupt handlers to handle requests properly (me)

- Fix task_mulout_intr to handle requests in chunks of
  current_nr_sectors, regardless of set multi count. This both makes it
  work, but also ensures we do not have to fall back to same hackish
  'copy-of-rq' approach that 2.4 uses. It comes at the cost of handling
  fs block size number of sectors at the time instead of max multi
  count, but I think this is a price worth paying. It's miniscule
  anyway. (me)

- Fix task_mulin_intr to properly loop and handle as many sectors as we
  set up (multi count or nr_sectors, whichever is smallest) (me)

- Fix wrong isr for multi mode enable, caused hdparm hang (Andre)

- ide-disk.c:do_rw_disk() had wrong check of rq flags, couldn't catch
  anything (either the bit is set or not, checking both makes no sense).
  Check for fs request there instead. (me)

- ide_dma_timeout_retry(), set correct next current_nr_sectors and only
  for bio request. (me)

- ll_rw_blk, blk_dump_rq_flags wasn't properly adjusted for new IDE
  flag (me)

diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /ata/linux-2.5.3-pre1/drivers/block/ll_rw_blk.c	Thu Jan 10 19:15:38 2002
+++ linux/drivers/block/ll_rw_blk.c	Wed Jan 16 04:01:52 2002
@@ -302,8 +303,8 @@
 static char *rq_flags[] = { "REQ_RW", "REQ_RW_AHEAD", "REQ_BARRIER",
 			   "REQ_CMD", "REQ_NOMERGE", "REQ_STARTED",
 			   "REQ_DONTPREP", "REQ_DRIVE_CMD", "REQ_DRIVE_TASK",
-			   "REQ_PC", "REQ_BLOCK_PC", "REQ_SENSE",
-			   "REQ_SPECIAL" };
+			   "REQ_DRIVE_ACB", "REQ_PC", "REQ_BLOCK_PC",
+			   "REQ_SENSE", "REQ_SPECIAL" };
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /ata/linux-2.5.3-pre1/drivers/ide/ide-disk.c	Thu Jan 17 06:32:54 2002
+++ linux/drivers/ide/ide-disk.c	Thu Jan 17 03:53:09 2002
@@ -123,12 +123,10 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	if (rq_data_dir(rq) == READ)
-		goto good_command;
-	if (rq_data_dir(rq) == WRITE)
+	if (rq->flags & REQ_CMD)
 		goto good_command;
 
-	printk(KERN_ERR "%s: bad command: %lx\n", drive->name, rq->flags);
+	blk_dump_rq_flags(rq, "do_rw_disk, bad command");
 	ide_end_request(0, HWGROUP(drive));
 	return ide_stopped;
 
@@ -179,8 +177,10 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	int				sectors;
 
 	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
@@ -189,7 +189,16 @@
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= (rq->nr_sectors==256)?0x00:rq->nr_sectors;
+	sectors = rq->nr_sectors;
+	if (sectors == 256)
+		sectors = 0;
+	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+		sectors = drive->mult_count;
+		if (sectors > rq->current_nr_sectors)
+			sectors = rq->current_nr_sectors;
+	}
+
+	taskfile.sector_count	= sectors;
 	taskfile.sector_number	= sect;
 	taskfile.low_cylinder	= cyl;
 	taskfile.high_cylinder	= (cyl>>8);
@@ -225,13 +234,23 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	int				sectors;
 
 	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 
+	sectors = rq->nr_sectors;
+	if (sectors == 256)
+		sectors = 0;
+	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+		sectors = drive->mult_count;
+		if (sectors > rq->current_nr_sectors)
+			sectors = rq->current_nr_sectors;
+	}
+
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= (rq->nr_sectors==256)?0x00:rq->nr_sectors;
+	taskfile.sector_count	= sectors;
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block>>=8);
 	taskfile.high_cylinder	= (block>>=8);
@@ -273,14 +292,24 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	int				sectors;
 
 	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= rq->nr_sectors;
-	hobfile.sector_count	= (rq->nr_sectors>>8);
+	sectors = rq->nr_sectors;
+	if (sectors == 256)
+		sectors = 0;
+	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+		sectors = drive->mult_count;
+		if (sectors > rq->current_nr_sectors)
+			sectors = rq->current_nr_sectors;
+	}
+
+	taskfile.sector_count	= sectors;
+	hobfile.sector_count	= sectors >> 8;
 
 	if (rq->nr_sectors == 65536) {
 		taskfile.sector_count	= 0x00;
@@ -652,7 +681,7 @@
 			memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 			taskfile.sector_count	= drive->mult_req;
 			taskfile.command	= WIN_SETMULT;
-			do_taskfile(drive, &taskfile, &hobfile, ide_handler_parser(&taskfile, &hobfile));
+			do_taskfile(drive, &taskfile, &hobfile, &set_multmode_intr);
 		}
 	} else if (s->all) {
 		int special = s->all;
@@ -789,23 +818,12 @@
 
 #endif	/* CONFIG_PROC_FS */
 
+/*
+ * This is tightly woven into the driver->do_special can not touch.
+ * DON'T do it again until a total personality rewrite is committed.
+ */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-#if 1
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-
-	if (drive->special.b.set_multmode)
-		return -EBUSY;
-
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.sector_count	= drive->mult_req;
-	taskfile.command	= WIN_SETMULT;
-	drive->mult_req		= arg;
-	drive->special.b.set_multmode = 1;
-	ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
-#else
 	struct request rq;
 
 	if (drive->special.b.set_multmode)
@@ -814,7 +832,6 @@
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
-#endif
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c	Thu Jan 17 06:32:54 2002
+++ linux/drivers/ide/ide-taskfile.c	Thu Jan 17 06:29:13 2002
@@ -706,8 +706,8 @@
 	ide__sti();	/* local CPU only */
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, "task_no_data_intr", stat); /* calls ide_end_drive_cmd */
-
+		return ide_error(drive, "task_no_data_intr", stat);
+		/* calls ide_end_drive_cmd */
 	if (args)
 		ide_end_drive_cmd (drive, stat, GET_ERR());
 
@@ -723,6 +723,7 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -735,17 +736,21 @@
 		}
 	}
 	DTF("stat: %02x\n", stat);
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	pBuf = ide_map_rq(rq, &flags);
 	DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
 	drive->io_32bit = 0;
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
+	ide_unmap_rq(rq, pBuf, &flags);
 	drive->io_32bit = io_32bit;
 
 	if (--rq->current_nr_sectors <= 0) {
 		/* (hs): swapped next 2 lines */
 		DTF("Request Ended stat: %02x\n", GET_STAT());
-		ide_end_request(1, HWGROUP(drive));
+		if (ide_end_request(1, HWGROUP(drive))) {
+			ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
+			return ide_started;
+		}
 	} else {
 		ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
 		return ide_started;
@@ -809,13 +814,14 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
 			return ide_error(drive, "task_mulin_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &task_mulin_intr, WAIT_CMD, NULL);
+		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
 		return ide_started;
 	}
 
@@ -834,10 +840,11 @@
 		 */
 		nsect = 1;
 		while (rq->current_nr_sectors) {
-			pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+			pBuf = ide_map_rq(rq, &flags);
 			DTF("Multiread: %p, nsect: %d, rq->current_nr_sectors: %ld\n", pBuf, nsect, rq->current_nr_sectors);
 			drive->io_32bit = 0;
 			taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+			ide_unmap_rq(rq, pBuf, &flags);
 			drive->io_32bit = io_32bit;
 			rq->errors = 0;
 			rq->current_nr_sectors -= nsect;
@@ -848,22 +855,38 @@
 	}
 #endif /* ALTSTAT_SCREW_UP */
 
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	do {
+		nsect = rq->current_nr_sectors;
+		if (nsect > msect)
+			nsect = msect;
 
-	DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-		pBuf, nsect, rq->current_nr_sectors);
-	drive->io_32bit = 0;
-	taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-	drive->io_32bit = io_32bit;
-	rq->errors = 0;
-	rq->current_nr_sectors -= nsect;
-	if (rq->current_nr_sectors != 0) {
-		ide_set_handler(drive, &task_mulin_intr, WAIT_CMD, NULL);
-		return ide_started;
-	}
-	ide_end_request(1, HWGROUP(drive));
-	return ide_stopped;
+		pBuf = ide_map_rq(rq, &flags);
+
+		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
+			pBuf, nsect, rq->current_nr_sectors);
+		drive->io_32bit = 0;
+		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+		ide_unmap_rq(rq, pBuf, &flags);
+		drive->io_32bit = io_32bit;
+		rq->errors = 0;
+		rq->current_nr_sectors -= nsect;
+		msect -= nsect;
+		if (!rq->current_nr_sectors) {
+			if (!ide_end_request(1, HWGROUP(drive)))
+				return ide_stopped;
+		}
+	} while (msect);
+
+#if 0
+	if (!ide_end_request(1, HWGROUP(drive)))
+		return ide_stopped;
+#endif
+
+	/*
+	 * more data left
+	 */
+	ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+	return ide_started;
 }
 
 ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
@@ -879,10 +902,12 @@
 	/* (ks/hs): Fixed Multi Write */
 	if ((args->tfRegister[IDE_COMMAND_OFFSET] != WIN_MULTWRITE) &&
 	    (args->tfRegister[IDE_COMMAND_OFFSET] != WIN_MULTWRITE_EXT)) {
+		unsigned long flags;
+		char *buf = ide_map_rq(rq, &flags);
 		/* For Write_sectors we need to stuff the first sector */
-		taskfile_output_data(drive, rq->buffer, SECTOR_WORDS);
+		taskfile_output_data(drive, buf, SECTOR_WORDS);
 		rq->current_nr_sectors--;
-		return ide_started;
+		ide_unmap_rq(rq, buf, &flags);
 	} else {
 		/*
 		 * (ks/hs): Stuff the first sector(s)
@@ -913,8 +938,10 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!rq->current_nr_sectors) { 
+		printk("task_out_intr: should not trigger\n");
 		ide_end_request(1, HWGROUP(drive));
 		return ide_stopped;
 	}
@@ -922,19 +949,24 @@
 	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
 		return ide_error(drive, "task_out_intr", stat);
 	}
+
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
 		rq = HWGROUP(drive)->rq;
-		pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 		drive->io_32bit = 0;
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
+		ide_unmap_rq(rq, pBuf, &flags);
 		drive->io_32bit = io_32bit;
 		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
 
 	if (rq->current_nr_sectors <= 0) {
-		ide_end_request(1, HWGROUP(drive));
+		if (ide_end_request(1, HWGROUP(drive))) {
+			ide_set_handler(drive, &task_out_intr, WAIT_CMD, NULL);
+			return ide_started;
+		}
 	} else {
 		ide_set_handler(drive, &task_out_intr, WAIT_CMD, NULL);
 		return ide_started;
@@ -961,14 +993,20 @@
 	struct request *rq	= HWGROUP(drive)->rq;
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	/*
 	 * (ks/hs): Handle last IRQ on multi-sector transfer,
-	 * occurs after all data was sent
+	 * occurs after all data was sent in this chunk
 	 */
 	if (rq->current_nr_sectors == 0) {
 		if (stat & (ERR_STAT|DRQ_STAT))
 			return ide_error(drive, "task_mulout_intr", stat);
+
+		/*
+		 * there may be more, ide_do_request will restart it if
+		 * necessary
+		 */
 		ide_end_request(1, HWGROUP(drive));
 		return ide_stopped;
 	}
@@ -994,10 +1032,11 @@
 	if (!msect) {
 		nsect = 1;
 		while (rq->current_nr_sectors) {
-			pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+			pBuf = ide_unmap_buffer(rq, &flags);
 			DTF("Multiwrite: %p, nsect: %d, rq->current_nr_sectors: %ld\n", pBuf, nsect, rq->current_nr_sectors);
 			drive->io_32bit = 0;
 			taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+			ide_unmap_buffer(pBuf, &flags);
 			drive->io_32bit = io_32bit;
 			rq->errors = 0;
 			rq->current_nr_sectors -= nsect;
@@ -1008,12 +1047,16 @@
 	}
 #endif /* ALTSTAT_SCREW_UP */
 
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	nsect = rq->current_nr_sectors;
+	if (nsect > msect)
+		nsect = msect;
+
+	pBuf = ide_map_rq(rq, &flags);
 	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
 		pBuf, nsect, rq->current_nr_sectors);
 	drive->io_32bit = 0;
 	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+	ide_unmap_rq(rq, pBuf, &flags);
 	drive->io_32bit = io_32bit;
 	rq->errors = 0;
 	rq->current_nr_sectors -= nsect;
diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/ide/ide.c linux/drivers/ide/ide.c
--- /ata/linux-2.5.3-pre1/drivers/ide/ide.c	Thu Jan 17 06:32:54 2002
+++ linux/drivers/ide/ide.c	Thu Jan 17 03:07:23 2002
@@ -1458,14 +1458,11 @@
 	HWGROUP(drive)->rq = NULL;
 
 	rq->errors = 0;
-	rq->sector = rq->bio->bi_sector;
-	rq->current_nr_sectors = bio_sectors(rq->bio);
-
-	/*
-	 * just to make sure...
-	 */
-	if (rq->bio)
+	if (rq->bio) {
+		rq->sector = rq->bio->bi_sector;
+		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 		rq->buffer = NULL;
+	}
 }
 
 /*
diff -urN -X exclude /ata/linux-2.5.3-pre1/include/linux/ide.h linux/include/linux/ide.h
--- /ata/linux-2.5.3-pre1/include/linux/ide.h	Thu Jan 17 06:32:55 2002
+++ linux/include/linux/ide.h	Thu Jan 17 03:22:45 2002
@@ -884,6 +884,9 @@
  */
 #define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
+#define task_rq_offset(rq) \
+	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
+
 extern inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
 {
 	return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
@@ -892,6 +895,24 @@
 extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
 {
 	bio_kunmap_irq(buffer, flags);
+}
+
+/*
+ * for now, taskfile requests are special :/
+ */
+extern inline char *ide_map_rq(struct request *rq, unsigned long *flags)
+{
+	if (rq->bio)
+		return ide_map_buffer(rq, flags);
+	else
+		return rq->buffer + task_rq_offset(rq);
+}
+
+extern inline void ide_unmap_rq(struct request *rq, char *buf,
+				unsigned long *flags)
+{
+	if (rq->bio)
+		ide_unmap_buffer(buf, flags);
 }
 
 /*

-- 
Jens Axboe

