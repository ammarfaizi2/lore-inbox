Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313119AbSC1JfH>; Thu, 28 Mar 2002 04:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313121AbSC1Jej>; Thu, 28 Mar 2002 04:34:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:27659 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313119AbSC1JeB>; Thu, 28 Mar 2002 04:34:01 -0500
Message-ID: <3CA2E328.5050403@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:32:24 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.7 IDE 28a
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020402030707060803040707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402030707060803040707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fri Mar 22 13:43:55 CET 2002 ide-clean-28a

- Apply Pavel Macheks suspend resume double resume fix.

- Finally remove the busy field for ata_operations and replace it with
   MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT.

- Fix ali15xx chipset support by removing initialization differences,
   apparently caused by mislead interpretation of the specs or a mismatch
   between the specification and reality.

- Guard calls to ide_set_handler with checks to see whatever the previously
   installed IRQ handler already served it's purpose.

- Convert timeout checks on poll_timeout to the time_before() interface.

- Consolidate the two different IRQ handlers for multi mode PIO writes into
   one. The problems remain the same but at least now we will only have to
   tangle one single problem.

--------------020402030707060803040707
Content-Type: text/plain;
 name="ide-clean-28a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-28a.diff"

diff -urN linux-2.5.7/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.7/arch/cris/drivers/ide.c	Thu Mar 28 06:59:54 2002
+++ linux/arch/cris/drivers/ide.c	Wed Mar 27 02:47:13 2002
@@ -798,7 +798,7 @@
 	 * not a diskdrive.
 	 */
 
-        if (drive->media != ide_disk)
+        if (drive->type != ATA_DISK)
                 return 0;
 
  dma_begin:
@@ -809,7 +809,7 @@
 		WAIT_DMA(ATA_RX_DMA_NBR);
 
 		/* set up the Etrax DMA descriptors */
-		
+
 		if(e100_ide_build_dmatable (drive))
 			return 1;
 
diff -urN linux-2.5.7/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.7/drivers/ide/hpt34x.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/ide/hpt34x.c	Wed Mar 27 02:47:13 2002
@@ -334,6 +334,7 @@
 			drive->waiting_for_dma = 1;
 			if (drive->type != ATA_DISK)
 				return 0;
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
 			OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			return 0;
diff -urN linux-2.5.7/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.7/drivers/ide/icside.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/icside.c	Wed Mar 27 02:47:13 2002
@@ -441,9 +441,10 @@
 			     : DMA_MODE_WRITE);
 
 		drive->waiting_for_dma = 1;
-		if (drive->media != ide_disk)
+		if (drive->type != ATA_DISK)
 			return 0;
 
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &icside_dmaintr, WAIT_CMD, NULL);
 		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA,
 			 IDE_COMMAND_REG);
diff -urN linux-2.5.7/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.7/drivers/ide/ide-cd.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/ide/ide-cd.c	Wed Mar 27 02:47:13 2002
@@ -740,11 +740,12 @@
 	OUT_BYTE (xferlen >> 8  , IDE_HCYL_REG);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
- 
+
 	if (info->dma)
 		(void) drive->channel->dmaproc(ide_dma_begin, drive);
 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler (drive, handler, WAIT_CMD, cdrom_timer_expiry);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
 		return ide_started;
@@ -787,6 +788,7 @@
 	}
 
 	/* Arm the interrupt handler. */
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, handler, timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
@@ -1005,7 +1007,9 @@
 
 	/* Done moving data!
 	   Wait for another interrupt. */
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler(drive, &cdrom_read_intr, WAIT_CMD, NULL);
+
 	return ide_started;
 }
 
@@ -1335,6 +1339,8 @@
 	}
 
 	/* Now we wait for another interrupt. */
+
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, &cdrom_pc_intr, WAIT_CMD, cdrom_timer_expiry);
 	return ide_started;
 }
@@ -1559,6 +1565,7 @@
 	}
 
 	/* re-arm handler */
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler(drive, &cdrom_write_intr, 5 * WAIT_CMD, NULL);
 	return ide_started;
 }
@@ -2984,15 +2991,14 @@
 		memset (info, 0, sizeof (struct cdrom_info));
 		drive->driver_data = info;
 
-		/* ATA-PATTERN */
-		ata_ops(drive)->busy++;
+		MOD_INC_USE_COUNT;
 		if (ide_cdrom_setup (drive)) {
-			ata_ops(drive)->busy--;
+			MOD_DEC_USE_COUNT;
 			if (ide_cdrom_cleanup (drive))
 				printk ("%s: ide_cdrom_cleanup failed in ide_cdrom_init\n", drive->name);
 			continue;
 		}
-		ata_ops(drive)->busy--;
+		MOD_DEC_USE_COUNT;
 
 		failed--;
 	}
diff -urN linux-2.5.7/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.7/drivers/ide/ide-disk.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/ide-disk.c	Wed Mar 27 02:48:05 2002
@@ -323,7 +323,7 @@
 
 	while (drive->blocked) {
 		yield();
-		// panic("ide: Request while drive blocked?");
+		printk("ide: Request while drive blocked?");
 	}
 
 	if (!(rq->flags & REQ_CMD)) {
@@ -380,12 +380,14 @@
 {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr hobfile;
+
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 	if (drive->id->cfs_enable_2 & 0x2400)
 		taskfile.command = WIN_FLUSH_CACHE_EXT;
 	else
 		taskfile.command = WIN_FLUSH_CACHE;
+
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 }
 
@@ -504,7 +506,7 @@
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
 	args.taskfile.command = WIN_SET_MAX;
-	args.handler				= task_no_data_intr;
+	args.handler = task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
@@ -540,7 +542,7 @@
 	args.hobfile.device_head = 0x40;
 	args.hobfile.control = (drive->ctl | 0x80);
 
-        args.handler				= task_no_data_intr;
+        args.handler = task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
@@ -611,10 +613,10 @@
 				drive->select.b.lba = 1;
 				drive->id->lba_capacity_2 = capacity_2;
                         }
-#else /* !CONFIG_IDEDISK_STROKE */
+#else
 			printk("%s: setmax_ext LBA %llu, native  %llu\n",
 				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
+#endif
 		}
 		drive->bios_cyl		= drive->cyl;
 		drive->capacity48	= capacity_2;
@@ -637,10 +639,10 @@
 			drive->select.b.lba = 1;
 			drive->id->lba_capacity = capacity;
 		}
-#else /* !CONFIG_IDEDISK_STROKE */
+#else
 		printk("%s: setmax LBA %lu, native  %lu\n",
 			drive->name, set_max, capacity);
-#endif /* CONFIG_IDEDISK_STROKE */
+#endif
 	}
 
 	drive->capacity = capacity;
@@ -954,6 +956,9 @@
 	 * already been done...
 	 */
 
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+
 	/* wait until all commands are finished */
 	printk("ide_disk_suspend()\n");
 	while (HWGROUP(drive)->handler)
@@ -973,6 +978,9 @@
 static int idedisk_resume(struct device *dev, u32 level)
 {
 	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
 	if (!drive->blocked)
 		panic("ide: Resume but not suspended?\n");
 
@@ -1113,8 +1121,11 @@
 	(void) probe_lba_addressing(drive, 1);
 }
 
-static int idedisk_cleanup (ide_drive_t *drive)
+static int idedisk_cleanup(ide_drive_t *drive)
 {
+	if (!drive)
+	    return 0;
+
 	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (idedisk_flushcache(drive))
diff -urN linux-2.5.7/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.7/drivers/ide/ide-dma.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/ide-dma.c	Wed Mar 27 02:47:13 2002
@@ -588,6 +588,8 @@
 			drive->waiting_for_dma = 1;
 			if (drive->type != ATA_DISK)
 				return 0;
+
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
 			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
diff -urN linux-2.5.7/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.7/drivers/ide/ide-floppy.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/ide/ide-floppy.c	Wed Mar 27 02:47:13 2002
@@ -968,6 +968,7 @@
 			if (temp > pc->buffer_size) {
 				printk (KERN_ERR "ide-floppy: The floppy wants to send us more data than expected - discarding data\n");
 				idefloppy_discard_data (drive,bcount.all);
+				BUG_ON(HWGROUP(drive)->handler);
 				ide_set_handler (drive,&idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -990,7 +991,9 @@
 	pc->actually_transferred+=bcount.all;				/* Update the current position */
 	pc->current_position+=bcount.all;
 
-	ide_set_handler (drive,&idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
+	BUG_ON(HWGROUP(drive)->handler);
+	ide_set_handler(drive,&idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
+
 	return ide_started;
 }
 
@@ -1014,8 +1017,11 @@
 		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
 		return ide_stopped;
 	}
+
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
 	atapi_output_bytes (drive, floppy->pc->c, 12); /* Send the actual packet */
+
 	return ide_started;
 }
 
@@ -1055,17 +1061,19 @@
 		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
 		return ide_stopped;
 	}
-	/* 
+	/*
 	 * The following delay solves a problem with ATAPI Zip 100 drives where the
 	 * Busy flag was apparently being deasserted before the unit was ready to
 	 * receive data. This was happening on a 1200 MHz Athlon system. 10/26/01
-	 * 25msec is too short, 40 and 50msec work well. idefloppy_pc_intr will 
+	 * 25msec is too short, 40 and 50msec work well. idefloppy_pc_intr will
 	 * not be actually used until after the packet is moved in about 50 msec.
 	 */
-	ide_set_handler (drive, 
-	  &idefloppy_pc_intr, 		/* service routine for packet command */
+	BUG_ON(HWGROUP(drive)->handler);
+	ide_set_handler (drive,
+	  &idefloppy_pc_intr,		/* service routine for packet command */
 	  floppy->ticks,			/* wait this long before "failing" */
 	  &idefloppy_transfer_pc2);	/* fail == transfer_pc2 */
+
 	return ide_started;
 }
 
@@ -1143,8 +1151,9 @@
 	} else {
 		pkt_xfer_routine = &idefloppy_transfer_pc;	/* immediate */
 	}
-	
+
 	if (test_bit (IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags)) {
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler (drive, pkt_xfer_routine, IDEFLOPPY_WAIT_CMD, NULL);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);		/* Issue the packet command */
 		return ide_started;
@@ -1156,7 +1165,7 @@
 
 static void idefloppy_rw_callback (ide_drive_t *drive)
 {
-#if IDEFLOPPY_DEBUG_LOG	
+#if IDEFLOPPY_DEBUG_LOG
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_rw_callback\n");
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
@@ -2109,10 +2118,9 @@
 			kfree (floppy);
 			continue;
 		}
-		/* ATA-PATTERN */
-		ata_ops(drive)->busy++;
+		MOD_INC_USE_COUNT;
 		idefloppy_setup (drive, floppy);
-		ata_ops(drive)->busy--;
+		MOD_DEC_USE_COUNT;
 
 		failed--;
 	}
diff -urN linux-2.5.7/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.7/drivers/ide/ide-pmac.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/ide/ide-pmac.c	Wed Mar 27 02:47:13 2002
@@ -931,12 +931,12 @@
 	int enable = 1;
 
 	drive->using_dma = 0;
-	
+
 	idx = pmac_ide_find(drive);
 	if (idx < 0)
 		return 0;
-		
-	if (drive->media == ide_floppy)
+
+	if (drive->type == ATA_FLOPPY)
 		enable = 0;
 	if (((id->capability & 1) == 0) && !check_drive_lists(drive, GOOD_DMA_DRIVE))
 		enable = 0;
@@ -945,9 +945,9 @@
 
 	udma = 0;
 	ata4 = (pmac_ide[idx].kind == controller_kl_ata4);
-			
+
 	if(enable) {
-		if (ata4 && (drive->media == ide_disk) &&
+		if (ata4 && (drive->type == ATA_DISK) &&
 		    (id->field_valid & 0x0004) && (id->dma_ultra & 0x17)) {
 			/* UltraDMA modes. */
 			drive->using_dma = pmac_ide_udma_enable(drive, idx);
@@ -994,8 +994,9 @@
 		if (!pmac_ide_build_dmatable(drive, ix, func==ide_dma_write))
 			return 1;
 		drive->waiting_for_dma = 1;
-		if (drive->media != ide_disk)
+		if (drive->type != ATA_DISK)
 			return 0;
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 		OUT_BYTE(func==ide_dma_write? WIN_WRITEDMA: WIN_READDMA,
 			 IDE_COMMAND_REG);
@@ -1054,12 +1055,12 @@
 static void idepmac_sleep_device(ide_drive_t *drive, int i, unsigned base)
 {
 	int j;
-	
+
 	/* FIXME: We only handle the master IDE disk, we shoud
 	 *        try to fix CD-ROMs here
 	 */
-	switch (drive->media) {
-	case ide_disk:
+	switch (drive->type) {
+	case ATA_DISK:
 		/* Spin down the drive */
 		outb(0xa0, base+0x60);
 		outb(0x0, base+0x30);
@@ -1067,7 +1068,7 @@
 		outb(0x0, base+0x40);
 		outb(0x0, base+0x50);
 		outb(0xe0, base+0x70);
-		outb(0x2, base+0x160);   
+		outb(0x2, base+0x160);
 		for (j = 0; j < 10; j++) {
 			int status;
 			mdelay(100);
@@ -1076,10 +1077,10 @@
 				break;
 		}
 		break;
-	case ide_cdrom:
+	case ATA_ROM:
 		// todo
 		break;
-	case ide_floppy:
+	case ATA_FLOPPY:
 		// todo
 		break;
 	}
diff -urN linux-2.5.7/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.7/drivers/ide/ide-tape.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/ide-tape.c	Wed Mar 27 02:47:13 2002
@@ -2155,7 +2155,8 @@
 			if (temp > pc->buffer_size) {
 				printk (KERN_ERR "ide-tape: The tape wants to send us more data than expected - discarding data\n");
 				idetape_discard_data (drive, bcount.all);
-				ide_set_handler (drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
+				BUG_ON(HWGROUP(drive)->handler);
+				ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 				return ide_started;
 			}
 #if IDETAPE_DEBUG_LOG
@@ -2181,7 +2182,8 @@
 	if (tape->debug_level >= 2)
 		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that interrupt\n", pc->c[0], bcount.all);
 #endif
-	ide_set_handler (drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* And set the interrupt handler again */
+	BUG_ON(HWGROUP(drive)->handler);
+	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* And set the interrupt handler again */
 	return ide_started;
 }
 
@@ -2255,6 +2257,7 @@
 		return ide_stopped;
 	}
 	tape->cmd_start_time = jiffies;
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
 	atapi_output_bytes (drive,pc->c,12);			/* Send the actual packet */
 	return ide_started;
@@ -2328,6 +2331,7 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &idetape_transfer_pc, IDETAPE_WAIT_CMD, NULL);
 		OUT_BYTE(WIN_PACKETCMD, IDE_COMMAND_REG);
 		return ide_started;
@@ -6099,8 +6103,7 @@
 	idetape_chrdevs[minor].drive = NULL;
 	restore_flags (flags);	/* all CPUs (overkill?) */
 
-	/* FIXME: this appears to be totally wrong! */
-	ata_ops(drive)->busy = 0;
+	MOD_DEC_USE_COUNT;
 
 	ide_unregister_subdriver (drive);
 	drive->driver_data = NULL;
diff -urN linux-2.5.7/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.7/drivers/ide/ide-taskfile.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/ide/ide-taskfile.c	Thu Mar 28 06:18:08 2002
@@ -33,7 +33,7 @@
 #define DEBUG_TASKFILE	0	/* unset when fixed */
 
 #if DEBUG_TASKFILE
-#define DTF(x...) printk(##x)
+#define DTF(x...) printk(x)
 #else
 #define DTF(x...)
 #endif
@@ -55,7 +55,7 @@
 				unsigned long *flags)
 {
 	if (rq->bio)
-	    bio_kunmap_irq(to, flags);
+		bio_kunmap_irq(to, flags);
 }
 
 static void bswap_data (void *buffer, int wcount)
@@ -288,73 +288,104 @@
 			break;
 	}
 }
-static ide_startstop_t bio_mulout_intr(ide_drive_t *drive);
 
-/*
- * Handler for command write multiple
- * Called directly from execute_drive_cmd for the first bunch of sectors,
- * afterwards only by the ISR
- */
-static ide_startstop_t task_mulout_intr(ide_drive_t *drive)
+static ide_startstop_t pre_task_mulout_intr(ide_drive_t *drive, struct request *rq)
+{
+	ide_task_t *args = rq->special;
+	ide_startstop_t startstop;
+
+	/*
+	 * assign private copy for multi-write
+	 */
+	memcpy(&HWGROUP(drive)->wrq, rq, sizeof(struct request));
+
+	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ))
+		return startstop;
+
+	ata_poll_drive_ready(drive);
+	return args->handler(drive);
+}
+
+static ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
-	unsigned int		msect, nsect;
 	byte stat		= GET_STAT();
 	byte io_32bit		= drive->io_32bit;
-	struct request *rq	= HWGROUP(drive)->rq;
+	struct request *rq	= &HWGROUP(drive)->wrq;
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	char *pBuf		= NULL;
-	unsigned long flags;
+	int mcount		= drive->mult_count;
+	ide_startstop_t startstop;
 
 	/*
 	 * (ks/hs): Handle last IRQ on multi-sector transfer,
 	 * occurs after all data was sent in this chunk
 	 */
-	if (rq->current_nr_sectors == 0) {
-		if (stat & (ERR_STAT|DRQ_STAT))
-			return ide_error(drive, "task_mulout_intr", stat);
+	if (!rq->nr_sectors) {
+		if (stat & (ERR_STAT|DRQ_STAT)) {
+			startstop = ide_error(drive, "task_mulout_intr", stat);
+			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
+			return startstop;
+		}
 
-		/*
-		 * there may be more, ide_do_request will restart it if
-		 * necessary
-		 */
-		ide_end_request(drive, 1);
+		__ide_end_request(drive, 1, rq->hard_nr_sectors);
+		rq->bio = NULL;
 
 		return ide_stopped;
 	}
 
-	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, "task_mulout_intr", stat);
+	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
+		if (stat & (ERR_STAT | DRQ_STAT)) {
+			startstop = ide_error(drive, "task_mulout_intr", stat);
+			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
+			return startstop;
 		}
+
 		/* no data yet, so wait for another interrupt */
 		if (hwgroup->handler == NULL)
-			ide_set_handler(drive, &task_mulout_intr, WAIT_CMD, NULL);
+			ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
+
 		return ide_started;
 	}
 
-	/* (ks/hs): See task_mulin_intr */
-	msect = drive->mult_count;
-	nsect = rq->current_nr_sectors;
-	if (nsect > msect)
-		nsect = msect;
+	do {
+		char *buffer;
+		int nsect = rq->current_nr_sectors;
+		unsigned long flags;
 
-	pBuf = ide_map_rq(rq, &flags);
-	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-		pBuf, nsect, rq->current_nr_sectors);
+		if (nsect > mcount)
+			nsect = mcount;
+		mcount -= nsect;
 
-	drive->io_32bit = 0;
-	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
+		rq->sector += nsect;
+		rq->nr_sectors -= nsect;
+		rq->current_nr_sectors -= nsect;
 
-	ide_unmap_rq(rq, pBuf, &flags);
+		/* Do we move to the next bio after this? */
+		if (!rq->current_nr_sectors) {
+			/* remember to fix this up /jens */
+			struct bio *bio = rq->bio->bi_next;
 
-	drive->io_32bit = io_32bit;
+			/* end early if we ran out of requests */
+			if (!bio) {
+				mcount = 0;
+			} else {
+				rq->bio = bio;
+				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+			}
+		}
 
-	rq->errors = 0;
-	/* Are we sure that this as all been already transfered? */
-	rq->current_nr_sectors -= nsect;
+		/*
+		 * Ok, we're all setup for the interrupt
+		 * re-entering us on the last transfer.
+		 */
+		taskfile_output_data(drive, buffer, nsect * SECTOR_WORDS);
+		bio_kunmap_irq(buffer, &flags);
+	} while (mcount);
 
+	drive->io_32bit = io_32bit;
+	rq->errors = 0;
 	if (hwgroup->handler == NULL)
-		ide_set_handler(drive, &task_mulout_intr, WAIT_CMD, NULL);
+		ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
 
 	return ide_started;
 }
@@ -371,7 +402,7 @@
 	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (handler != task_mulout_intr && handler != bio_mulout_intr) {
+	if (handler != task_mulout_intr) {
 		if (IDE_CONTROL_REG)
 			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
 		SELECT_MASK(drive->channel, drive, 0);
@@ -583,107 +614,6 @@
 	return ide_started;
 }
 
-static ide_startstop_t pre_bio_out_intr(ide_drive_t *drive, struct request *rq)
-{
-	ide_task_t *args = rq->special;
-	ide_startstop_t startstop;
-
-	/*
-	 * assign private copy for multi-write
-	 */
-	memcpy(&HWGROUP(drive)->wrq, rq, sizeof(struct request));
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ))
-		return startstop;
-
-	ata_poll_drive_ready(drive);
-	return args->handler(drive);
-}
-
-
-static ide_startstop_t bio_mulout_intr (ide_drive_t *drive)
-{
-	byte stat		= GET_STAT();
-	byte io_32bit		= drive->io_32bit;
-	struct request *rq	= &HWGROUP(drive)->wrq;
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	int mcount		= drive->mult_count;
-	ide_startstop_t startstop;
-
-	/*
-	 * (ks/hs): Handle last IRQ on multi-sector transfer,
-	 * occurs after all data was sent in this chunk
-	 */
-	if (!rq->nr_sectors) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			startstop = ide_error(drive, "bio_mulout_intr", stat);
-			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
-			return startstop;
-		}
-
-		__ide_end_request(drive, 1, rq->hard_nr_sectors);
-		HWGROUP(drive)->wrq.bio = NULL;
-		return ide_stopped;
-	}
-
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
-		if (stat & (ERR_STAT | DRQ_STAT)) {
-			startstop = ide_error(drive, "bio_mulout_intr", stat);
-			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
-			return startstop;
-		}
-
-		/* no data yet, so wait for another interrupt */
-		if (hwgroup->handler == NULL)
-			ide_set_handler(drive, bio_mulout_intr, WAIT_CMD, NULL);
-
-		return ide_started;
-	}
-
-	do {
-		char *buffer;
-		int nsect = rq->current_nr_sectors;
-		unsigned long flags;
-
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-
-		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
-		rq->sector += nsect;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bio after this? */
-		if (!rq->current_nr_sectors) {
-			/* remember to fix this up /jens */
-			struct bio *bio = rq->bio->bi_next;
-
-			/* end early early we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
-			}
-		}
-
-		/*
-		 * Ok, we're all setup for the interrupt
-		 * re-entering us on the last transfer.
-		 */
-		taskfile_output_data(drive, buffer, nsect * SECTOR_WORDS);
-		bio_kunmap_irq(buffer, &flags);
-	} while (mcount);
-
-	drive->io_32bit = io_32bit;
-	rq->errors = 0;
-	if (hwgroup->handler == NULL)
-		ide_set_handler(drive, bio_mulout_intr, WAIT_CMD, NULL);
-
-	return ide_started;
-}
-
 /*
  * Handler for command with Read Multiple
  */
@@ -781,8 +711,8 @@
 		case CFA_WRITE_MULTI_WO_ERASE:
 		case WIN_MULTWRITE:
 		case WIN_MULTWRITE_EXT:
-			args->prehandler = pre_bio_out_intr;
-			args->handler = bio_mulout_intr;
+			args->prehandler = pre_task_mulout_intr;
+			args->handler = task_mulout_intr;
 			args->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 			return;
 
@@ -989,7 +919,7 @@
  *
  * The caller has to make sure buf is never NULL!
  */
-static int ide_wait_cmd(ide_drive_t *drive, int cmd, int nsect, int feature, int sectors, byte *argbuf)
+static int ide_wait_cmd(ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *argbuf)
 {
 	struct request rq;
 
@@ -998,10 +928,10 @@
 	memset(argbuf, 0, 4 + SECTOR_WORDS * 4 * sectors);
 	ide_init_drive_cmd(&rq);
 	rq.buffer = argbuf;
-	*argbuf++ = cmd;
-	*argbuf++ = nsect;
-	*argbuf++ = feature;
-	*argbuf++ = sectors;
+	argbuf[0] = cmd;
+	argbuf[1] = nsect;
+	argbuf[2] = feature;
+	argbuf[3] = sectors;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1009,7 +939,8 @@
 int ide_cmd_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
-	byte args[4], *argbuf = args;
+	u8 args[4];
+	u8 *argbuf = args;
 	byte xfer_rate = 0;
 	int argsize = 4;
 	ide_task_t tfargs;
diff -urN linux-2.5.7/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.7/drivers/ide/ide.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/ide.c	Wed Mar 27 02:47:13 2002
@@ -548,7 +548,8 @@
 	if (OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_before(jiffies, hwgroup->poll_timeout)) {
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler (drive, &atapi_reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -573,7 +574,8 @@
 	byte tmp;
 
 	if (!OK_STAT(tmp=GET_STAT(), 0, BUSY_STAT)) {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_before(jiffies, hwgroup->poll_timeout)) {
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -645,6 +647,7 @@
 		udelay (20);
 		OUT_BYTE (WIN_SRST, IDE_COMMAND_REG);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler (drive, &atapi_reset_pollfunc, HZ/20, NULL);
 		__restore_flags (flags);	/* local CPU only */
 		return ide_started;
@@ -679,7 +682,8 @@
 	}
 	udelay(10);			/* more than enough time */
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-	ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
+	BUG_ON(HWGROUP(drive)->handler);
+	ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
 
 	/*
 	 * Some weird controller like resetting themselves to a strange
@@ -931,6 +935,7 @@
  */
 void ide_cmd (ide_drive_t *drive, byte cmd, byte nsect, ide_handler_t *handler)
 {
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, handler, WAIT_CMD, NULL);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
@@ -1553,7 +1558,7 @@
 /*
  * entry point for all interrupts, caller does __cli() for us
  */
-void ide_intr (int irq, void *dev_id, struct pt_regs *regs)
+void ide_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = (ide_hwgroup_t *)dev_id;
@@ -1596,7 +1601,7 @@
 			 * Whack the status register, just in case we have a leftover pending IRQ.
 			 */
 			IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
-#endif /* CONFIG_BLK_DEV_IDEPCI */
+#endif
 		}
 		goto out_lock;
 	}
@@ -3175,10 +3180,19 @@
 
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
-	if (drive->usage || drive->busy || !ata_ops(drive) || ata_ops(drive)->busy) {
+
+#if 0
+	if (__MOD_IN_USE(ata_ops(drive)->owner)) {
+		restore_flags(flags);
+		return 1;
+	}
+#endif
+
+	if (drive->usage || drive->busy || !ata_ops(drive)) {
 		restore_flags(flags);	/* all CPUs */
 		return 1;
 	}
+
 #if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) && defined(MODULE)
 	pnpide_init(0);
 #endif
@@ -3189,7 +3203,10 @@
 #endif
 	auto_remove_settings(drive);
 	drive->driver = NULL;
+	drive->present = 0;
+
 	restore_flags(flags);		/* all CPUs */
+
 	return 0;
 }
 
@@ -3298,6 +3315,7 @@
 		hwif = &ide_hwifs[i];
 		if (!hwif->present)
 			continue;
+
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			drive = &hwif->drives[unit];
 			if (!drive->present)
diff -urN linux-2.5.7/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.7/drivers/ide/pdc4030.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/pdc4030.c	Thu Mar 28 05:42:44 2002
@@ -394,6 +394,7 @@
 
 	if (GET_STAT() & BUSY_STAT) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &promise_complete_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
 		}
@@ -476,6 +477,7 @@
 
 	if (IN_BYTE(IDE_NSECTOR_REG) != 0) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler (drive, &promise_write_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
 		}
@@ -489,6 +491,7 @@
 	 */
 	promise_multwrite(drive, 4);
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler(drive, &promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Done last 4 sectors - status = %02x\n",
@@ -523,6 +526,7 @@
 		if (promise_multwrite(drive, rq->nr_sectors - 4))
 			return ide_stopped;
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler (drive, &promise_write_pollfunc, HZ/100, NULL);
 		return ide_started;
 	} else {
@@ -533,6 +537,7 @@
 		if (promise_multwrite(drive, rq->nr_sectors))
 			return ide_stopped;
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 		printk(KERN_DEBUG "%s: promise_write: <= 4 sectors, "
@@ -554,6 +559,13 @@
 	unsigned long timeout;
 	byte stat;
 
+	/* Check that it's a regular command. If not, bomb out early. */
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "pdc4030 bad flags");
+		ide_end_request(drive, 0);
+		return ide_stopped;
+	}
+
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
 	SELECT_MASK(drive->channel, drive, 0);
@@ -568,20 +580,12 @@
 	OUT_BYTE(taskfile->device_head, IDE_SELECT_REG);
 	OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
 
-/* Check that it's a regular command. If not, bomb out early. */
-	if (!(rq->flags & REQ_CMD)) {
-		blk_dump_rq_flags(rq, "pdc4030 bad flags");
-		ide_end_request(drive, 0);
-		return ide_stopped;
-	}
-
 	switch (rq_data_dir(rq)) {
 	case READ:
-		OUT_BYTE(PROMISE_READ, IDE_COMMAND_REG);
 /*
  * The card's behaviour is odd at this point. If the data is
  * available, DRQ will be true, and no interrupt will be
- * generated by the card. If this is the case, we need to call the 
+ * generated by the card. If this is the case, we need to call the
  * "interrupt" handler (promise_read_intr) directly. Otherwise, if
  * an interrupt is going to occur, bit0 of the SELECT register will
  * be high, so we can set the handler the just return and be interrupted.
@@ -600,6 +604,7 @@
 				printk(KERN_DEBUG "%s: read: waiting for "
 				                  "interrupt\n", drive->name);
 #endif
+				BUG_ON(HWGROUP(drive)->handler);
 				ide_set_handler(drive, &promise_read_intr, WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -612,7 +617,6 @@
 
 	case WRITE: {
 		ide_startstop_t startstop;
-		OUT_BYTE(PROMISE_WRITE, IDE_COMMAND_REG);
 /*
  * Strategy on write is:
  *	look for the DRQ that should have been immediately asserted
@@ -624,7 +628,7 @@
 			printk(KERN_ERR "%s: no DRQ after issuing "
 			       "PROMISE_WRITE\n", drive->name);
 			return startstop;
-	    	}
+		}
 		if (!drive->unmask)
 			__cli();	/* local CPU only */
 		HWGROUP(drive)->wrq = *rq; /* scratchpad */
diff -urN linux-2.5.7/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.7/drivers/ide/trm290.c	Thu Mar 28 06:59:56 2002
+++ linux/drivers/ide/trm290.c	Wed Mar 27 02:47:13 2002
@@ -194,6 +194,7 @@
 			outw((count * 2) - 1, hwif->dma_base+2); /* start DMA */
 			if (drive->type != ATA_DISK)
 				return 0;
+			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			return 0;
diff -urN linux-2.5.7/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.7/drivers/scsi/ide-scsi.c	Thu Mar 28 06:59:54 2002
+++ linux/drivers/scsi/ide-scsi.c	Wed Mar 27 02:47:13 2002
@@ -508,7 +508,7 @@
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi, int id)
 {
-	ata_ops(drive)->busy++;
+	MOD_INC_USE_COUNT;
 
 	idescsi_drives[id] = drive;
 	drive->driver_data = scsi;
@@ -629,8 +629,9 @@
 
 	for (id = 0; id < MAX_HWIFS * MAX_DRIVES; id++) {
 		drive = idescsi_drives[id];
-		if (drive)
-			ata_ops(drive)->busy--;
+		if (drive) {
+			MOD_DEC_USE_COUNT;
+		}
 	}
 	return 0;
 }
diff -urN linux-2.5.7/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.7/include/linux/ide.h	Thu Mar 28 06:59:56 2002
+++ linux/include/linux/ide.h	Thu Mar 28 05:42:51 2002
@@ -300,10 +300,13 @@
 	byte     slow;			/* flag: slow data port */
 	byte     bswap;			/* flag: byte swap data */
 	byte     dsc_overlap;		/* flag: DSC overlap */
+
 	unsigned waiting_for_dma: 1;	/* dma currently in progress */
+	unsigned busy		: 1;	/* currently doing revalidate_disk() */
+	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
+
 	unsigned present	: 1;	/* drive is physically present */
 	unsigned noprobe	: 1;	/* from:  hdx=noprobe */
-	unsigned busy		: 1;	/* currently doing revalidate_disk() */
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
@@ -315,7 +318,6 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
-	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	select_t	select;		/* basic drive/head select reg value */
@@ -620,7 +622,6 @@
 
 struct ata_operations {
 	struct module *owner;
-	unsigned busy: 1; /* FIXME: this will go soon away... */
 	int (*cleanup)(ide_drive_t *);
 	int (*standby)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
@@ -635,6 +636,7 @@
 	void (*pre_reset)(ide_drive_t *);
 	unsigned long (*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
+
 	ide_proc_entry_t *proc;
 };
 

--------------020402030707060803040707--

