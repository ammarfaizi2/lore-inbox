Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSFYG3R>; Tue, 25 Jun 2002 02:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSFYG3R>; Tue, 25 Jun 2002 02:29:17 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:4559 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315438AbSFYG3E>; Tue, 25 Jun 2002 02:29:04 -0400
Date: Tue, 25 Jun 2002 07:59:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] IDE locking #2
Message-ID: <Pine.LNX.4.44.0206250756430.2033-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Jens

This patch gets a little further and is independent of the first one. 
However it is still not there yet.

This patch tries to address the following;

CURRENT
o remove racy spin_unlock_irq() ... foo() .. spin_lock_irq() scenarios
o moves locking from interrupt handling helpers/primitives 
(ide-disk.c:*_intr) to the caller.
o removes ide__sti() from some areas, personally i think this is an evil
  macro for many reasons, is it supposed to be disable_irq(ide_irq); 
__sti(); ?

o fixes some 'FIXME' entries... adds a couple more ;)

TODO
o fix breakage in ide-floppy/tape etc...
o fix ide device setup/tear down locking
o remove ide_wait commands from interrupt paths

Index: linux-2.5.24/drivers/ide//ide-cd.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide-cd.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-cd.c
--- linux-2.5.24/drivers/ide//ide-cd.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//ide-cd.c	23 Jun 2002 20:45:52 -0000
@@ -319,6 +319,8 @@
 
 /****************************************************************************
  * Generic packet command support and error handling routines.
+ * Note. these are called with the channel lock held and irq disabled in most
+ * cases.
  */
 
 /* Mark that we've seen a media change, and invalidate our internal
@@ -728,13 +730,13 @@
 						  int xferlen,
 						  ata_handler_t handler)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	/* Wait for the controller to be idle. */
 	if (ata_status_poll(drive, 0, BUSY_STAT, WAIT_READY, rq, &startstop))
 		ret = startstop;
@@ -763,16 +765,9 @@
 			ret = ide_started;
 		} else {
 			OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
-
-			/* FIXME: Oj kurwa! We have to ungrab the lock before
-			 * the IRQ handler gets called.
-			 */
-			spin_unlock_irqrestore(ch->lock, flags);
 			ret = handler(drive, rq);
-			spin_lock_irqsave(ch->lock, flags);
 		}
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -787,10 +782,11 @@
 		unsigned char *cmd, unsigned long timeout,
 		ata_handler_t handler)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
 		   from the device.  DRQ should how be set. */
@@ -800,24 +796,16 @@
 		if (cdrom_decode_status(&startstop, drive, rq, DRQ_STAT, &stat_dum))
 			return startstop;
 	} else {
-		/* FIXME: make this locking go away */
-		spin_lock_irqsave(ch->lock, flags);
 		/* Otherwise, we must wait for DRQ to get set. */
 		if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 					WAIT_READY, rq, &startstop)) {
-			spin_unlock_irqrestore(ch->lock, flags);
-
 			return startstop;
 		}
-		spin_unlock_irqrestore(ch->lock, flags);
 	}
 
 	/* Arm the interrupt handler and send the command to the device. */
-	/* FIXME: make this locking go away */
-	spin_lock_irqsave(ch->lock, flags);
 	ata_set_handler(drive, handler, timeout, cdrom_timer_expiry);
 	atapi_write(drive, cmd, CDROM_PACKET_SIZE);
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -917,7 +905,6 @@
  */
 static ide_startstop_t cdrom_read_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int stat;
 	int ireason, len, sectors_to_transfer, nskip;
@@ -925,6 +912,8 @@
 	int dma = info->dma, dma_error = 0;
 	ide_startstop_t startstop;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
@@ -937,14 +926,7 @@
 
 	if (dma) {
 		if (!dma_error) {
-			/* FIXME: this locking should encompass the above register
-			 * file access too.
-			 */
-
-			spin_lock_irqsave(ch->lock, flags);
 			__ata_end_request(drive, rq, 1, rq->nr_sectors);
-			spin_unlock_irqrestore(ch->lock, flags);
-
 			return ide_stopped;
 		} else
 			return ata_error(drive, rq, "dma error");
@@ -1040,10 +1022,8 @@
 	}
 
 	/* Done moving data! Wait for another interrupt. */
-	spin_lock_irqsave(ch->lock, flags);
 	ata_set_handler(drive, cdrom_read_intr, WAIT_CMD, NULL);
-	spin_unlock_irqrestore(ch->lock, flags);
-
+	
 	return ide_started;
 }
 
@@ -1269,7 +1249,6 @@
 /* Interrupt routine for packet command completion. */
 static ide_startstop_t cdrom_pc_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ireason, len, stat, thislen;
 
@@ -1277,6 +1256,8 @@
 	struct packet_command *pc = (struct packet_command *) rq->special;
 	ide_startstop_t startstop;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	/* Check for errors. */
 	if (cdrom_decode_status (&startstop, drive, rq, 0, &stat))
 		return startstop;
@@ -1363,9 +1344,7 @@
 	}
 
 	/* Now we wait for another interrupt. */
-	spin_lock_irqsave(ch->lock, flags);
 	ata_set_handler(drive, cdrom_pc_intr, WAIT_CMD, cdrom_timer_expiry);
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -1508,13 +1487,14 @@
 
 static ide_startstop_t cdrom_write_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int stat, ireason, len, sectors_to_transfer, uptodate;
 	struct cdrom_info *info = drive->driver_data;
 	int dma_error = 0, dma = info->dma;
 	ide_startstop_t startstop;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
@@ -1536,14 +1516,7 @@
 		if (dma_error)
 			return ata_error(drive, rq, "dma error");
 
-		/* FIXME: this locking should encompass the above register
-		 * file access too.
-		 */
-
-		spin_lock_irqsave(ch->lock, flags);
 		__ata_end_request(drive, rq, 1, rq->nr_sectors);
-		spin_unlock_irqrestore(ch->lock, flags);
-
 		return ide_stopped;
 	}
 
@@ -1607,9 +1580,7 @@
 	}
 
 	/* re-arm handler */
-	spin_lock_irqsave(ch->lock, flags);
 	ata_set_handler(drive, cdrom_write_intr, 5 * WAIT_CMD, NULL);
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -1662,6 +1633,8 @@
 	int ret;
 	struct cdrom_info *info = drive->driver_data;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	if (rq->flags & REQ_CMD) {
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
 			unsigned long elpased = jiffies - info->start_seek;
@@ -1675,8 +1648,6 @@
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			ret = cdrom_start_seek(drive, rq, block);
 		} else {
@@ -1686,14 +1657,9 @@
 				ret = cdrom_start_write(drive, rq);
 		}
 		info->last_block = block;
-		spin_lock_irq(ch->lock);
 		return ret;
 	} else if (rq->flags & (REQ_PC | REQ_SENSE)) {
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		ret = cdrom_do_packet_command(drive, rq);
-		spin_lock_irq(ch->lock);
-
 		return ret;
 	} else if (rq->flags & REQ_SPECIAL) {
 		/*
@@ -1703,10 +1669,7 @@
 		 * right now this can only be a reset...
 		 */
 
-	        /* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		cdrom_end_request(drive, rq, 1);
-		spin_lock_irq(ch->lock);
 
 		return ide_stopped;
 	} else if (rq->flags & REQ_BLOCK_PC) {
@@ -1721,9 +1684,7 @@
 		rq->special = (char *) &pc;
 
 		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		startstop = cdrom_do_packet_command(drive, rq);
-		spin_lock_irq(ch->lock);
 
 		if (pc.stat)
 			++rq->errors;
@@ -1732,10 +1693,7 @@
 	}
 
 	blk_dump_rq_flags(rq, "ide-cd bad flags");
-	/* FIXME: make this unlocking go away*/
-	spin_unlock_irq(ch->lock);
 	cdrom_end_request(drive, rq, 0);
-	spin_lock_irq(ch->lock);
 
 	return ide_stopped;
 }
Index: linux-2.5.24/drivers/ide//ide-disk.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide-disk.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-disk.c
--- linux-2.5.24/drivers/ide//ide-disk.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//ide-disk.c	25 Jun 2002 05:47:47 -0000
@@ -91,22 +91,23 @@
 }
 
 /*
+ * The following irq handling primitives/helpers (*_intr) should be called with the channel
+ * lock held and interrupts disabled. -Zwane
+ */
+
+/*
  * Handler for command with PIO data-in phase.
  */
 static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			spin_unlock_irqrestore(ch->lock, flags);
-
+		if (drive->status & (ERR_STAT | DRQ_STAT))
 			return ata_error(drive, rq, __FUNCTION__);
-		}
 
 		/* no data yet, so wait for another interrupt */
 		ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
@@ -134,8 +135,6 @@
 		if (rq->current_nr_sectors <= 0) {
 			if (!__ata_end_request(drive, rq, 1, 0)) {
 			//		printk("Request Ended stat: %02x\n", drive->status);
-				spin_unlock_irqrestore(ch->lock, flags);
-
 				return ide_stopped;
 			}
 		}
@@ -145,7 +144,6 @@
 
 		ret = ide_started;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -155,16 +153,13 @@
  */
 static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
-	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat)) {
-		spin_unlock_irqrestore(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
 
+	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
 		return ata_error(drive, rq, __FUNCTION__);
-	}
 
 	if (!rq->current_nr_sectors && !__ata_end_request(drive, rq, 1, 0)) {
 		ret = ide_stopped;
@@ -185,7 +180,6 @@
 
 		ret = ide_started;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -195,17 +189,14 @@
  */
 static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
-	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			spin_unlock_irqrestore(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
 
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT | DRQ_STAT))
 			return ata_error(drive, rq, __FUNCTION__);
-		}
 
 		/* no data yet, so wait for another interrupt */
 		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
@@ -242,11 +233,8 @@
 
 			/* FIXME: this seems buggy */
 			if (rq->current_nr_sectors <= 0) {
-				if (!__ata_end_request(drive, rq, 1, 0)) {
-					spin_unlock_irqrestore(ch->lock, flags);
-
+				if (!__ata_end_request(drive, rq, 1, 0))
 					return ide_stopped;
-				}
 			}
 			msect -= nsect;
 		} while (msect);
@@ -256,19 +244,17 @@
 
 		ret = ide_started;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
 
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ok;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
 
 	/*
 	 * FIXME: the drive->status checks here seem to be messy.
@@ -280,11 +266,8 @@
 	ok = ata_status(drive, DATA_READY, BAD_R_STAT);
 
 	if (!ok || !rq->nr_sectors) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			spin_unlock_irqrestore(ch->lock, flags);
-
+		if (drive->status & (ERR_STAT | DRQ_STAT))
 			return ata_error(drive, rq, __FUNCTION__);
-		}
 	}
 	if (!rq->nr_sectors) {
 		__ata_end_request(drive, rq, 1, rq->hard_nr_sectors);
@@ -341,7 +324,6 @@
 
 		ret = ide_started;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -436,15 +418,13 @@
 				for (i = 0; i < 100; ++i) {
 					if (drive_is_ready(drive))
 						break;
+					cpu_relax();
 				}
 				if (!drive_is_ready(drive)) {
 					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
 				}
-				/* FIXME: make this unlocking go away*/
-				spin_unlock_irq(ch->lock);
+				
 				ret =  ar->XXX_handler(drive, rq);
-				spin_lock_irq(ch->lock);
-
 				return ret;
 			}
 		}
@@ -495,6 +475,9 @@
 
 	/* This issues a special drive command.
 	 */
+
+	BUG_ON(!spin_is_locked(drive->channel->lock));
+
 	if (rq->flags & REQ_SPECIAL)
 		return __do_request(drive, rq->special, rq);
 
@@ -622,8 +605,7 @@
 			} else if (drive->using_dma) {
 				args.cmd = WIN_READDMA;
 			} else if (drive->mult_count) {
-				/* FIXME : Shouldn't this be task_mulin_intr?! */
-				args.XXX_handler = task_in_intr;
+				args.XXX_handler = task_mulin_intr;
 				args.cmd = WIN_MULTREAD;
 			} else {
 				args.XXX_handler = task_in_intr;
@@ -675,7 +657,10 @@
 
 static int idedisk_open(struct inode *inode, struct file *__fp, struct ata_device *drive)
 {
+	unsigned long flags;
+
 	MOD_INC_USE_COUNT;
+	spin_lock_irqsave(drive->channel->lock, flags);
 	if (drive->removable && drive->usage == 1) {
 		check_disk_change(inode->i_rdev);
 
@@ -694,13 +679,14 @@
 		}
 	}
 
+	spin_unlock_irqrestore(drive->channel->lock, flags);
 	return 0;
 }
 
 static int flush_cache(struct ata_device *drive)
 {
 	struct ata_taskfile args;
-
+	
 	memset(&args, 0, sizeof(args));
 
 	if (drive->id->cfs_enable_2 & 0x2400)
@@ -713,6 +699,9 @@
 
 static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(drive->channel->lock, flags);
 	if (drive->removable && !drive->usage) {
 		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
 		invalidate_bdev(inode->i_bdev, 0);
@@ -730,6 +719,8 @@
 		if (flush_cache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
+
+	spin_unlock_irqrestore(drive->channel->lock, flags);
 	MOD_DEC_USE_COUNT;
 }
 
@@ -751,17 +742,19 @@
 static int set_multcount(struct ata_device *drive, int arg)
 {
 	struct ata_taskfile args;
+	unsigned long flags;
+	int ret = -EIO;
 
 	/* Setting multi mode count on this channel type is not supported/not
 	 * handled.
 	 */
 	if (IS_PDC4030_DRIVE)
-		return -EIO;
+		return ret;
 
 	/* Hugh, we still didn't detect the devices capabilities.
 	 */
 	if (!drive->id)
-		return -EIO;
+		return ret;
 
 	if (arg > drive->id->max_multsect)
 		arg = drive->id->max_multsect;
@@ -769,15 +762,19 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
+	
+	spin_lock_irqsave(drive->channel->lock, flags);
 	if (!ide_raw_taskfile(drive, &args)) {
 		/* all went well track this setting as valid */
 		drive->mult_count = arg;
-
-		return 0;
+		ret = 0;
+		goto done;
 	} else
 		drive->mult_count = 0; /* reset */
 
-	return -EIO;
+done:
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+	return ret;
 }
 
 static int set_nowerr(struct ata_device *drive, int arg)
@@ -808,23 +805,33 @@
 static int idedisk_standby(struct ata_device *drive)
 {
 	struct ata_taskfile args;
+	unsigned long flags;
+	int ret;
 
 	memset(&args, 0, sizeof(args));
 	args.cmd = WIN_STANDBYNOW1;
-	return ide_raw_taskfile(drive, &args);
+
+	spin_lock_irqsave(drive->channel->lock, flags);
+	ret = ide_raw_taskfile(drive, &args);
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
+	return ret;
 }
 
 static int set_acoustic(struct ata_device *drive, int arg)
 {
 	struct ata_taskfile args;
+	unsigned long flags;
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
+	
+	spin_lock_irqsave(drive->channel->lock, flags);	
 	ide_raw_taskfile(drive, &args);
-
 	drive->acoustic = arg;
+	spin_unlock_irqrestore(drive->channel->lock, flags);
 
 	return 0;
 }
@@ -933,7 +940,7 @@
 {
 	struct ata_taskfile args;
 	unsigned long addr = 0;
-
+	
 	if (!(drive->id->command_set_1 & 0x0400) &&
 	    !(drive->id->cfs_enable_2 & 0x0100))
 		return addr;
@@ -942,8 +949,8 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX;
+	
 	ide_raw_taskfile(drive, &args);
-
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
 		addr = ((args.taskfile.device_head & 0x0f) << 24)
@@ -951,9 +958,9 @@
 		     | (args.taskfile.low_cylinder <<  8)
 		     | args.taskfile.sector_number;
 	}
-
+	
 	addr++;	/* since the return value is (maxlba - 1), we add 1 */
-
+	
 	return addr;
 }
 
@@ -967,7 +974,8 @@
 
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX_EXT;
-        ide_raw_taskfile(drive, &args);
+
+	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1014,6 +1022,7 @@
 			 | (args.taskfile.low_cylinder <<  8)
 			 | args.taskfile.sector_number;
 	}
+	
 	addr_set++;
 	return addr_set;
 }
@@ -1021,6 +1030,7 @@
 static u64 set_max_address_ext(struct ata_device *drive, u64 addr_req)
 {
 	struct ata_taskfile args;
+	unsigned long flags;
 	u64 addr_set = 0;
 
 	addr_req--;
@@ -1050,6 +1060,7 @@
 			    args.taskfile.sector_number;
 		addr_set = ((u64)high << 24) | low;
 	}
+
 	return addr_set;
 }
 
@@ -1072,6 +1083,7 @@
 	 * CompactFlash cards and their brethern look just like hard drives
 	 * to us, but they are removable and don't have a doorlock mechanism.
 	 */
+
 	if (drive->removable && !drive_is_flashcard(drive)) {
 		/* Removable disks (eg. SYQUEST); ignore 'WD' drives.
 		 */
@@ -1135,6 +1147,7 @@
 	 * in above order (i.e., if value of higher priority is available,
 	 * reset will be ignored).
 	 */
+
 	capacity = drive->cyl * drive->head * drive->sect;
 	set_max = native_max_address(drive);
 
@@ -1153,10 +1166,12 @@
 
 		drive->select.b.lba = 1;
 		set_max_ext = native_max_address_ext(drive);
+
 		if (set_max_ext > capacity_2) {
 #ifdef CONFIG_IDEDISK_STROKE
 			set_max_ext = native_max_address_ext(drive);
 			set_max_ext = set_max_address_ext(drive, set_max_ext);
+
 			if (set_max_ext) {
 				drive->capacity = capacity_2 = set_max_ext;
 				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
@@ -1286,7 +1301,7 @@
 	probe_lba_addressing(drive, 1);
 }
 
-static int idedisk_cleanup(struct ata_device *drive)
+static int __idedisk_cleanup(struct ata_device *drive)
 {
 	int ret;
 
@@ -1298,6 +1313,7 @@
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
 	}
+
 	ret = ide_unregister_subdriver(drive);
 
 	/* FIXME: This is killing the kernel with BUG 185 at asm/spinlocks.h
@@ -1307,7 +1323,17 @@
 #if 0
 	put_device(&drive->device);
 #endif
+	return ret;
+}
+
+static int idedisk_cleanup(struct ata_device *drive)
+{
+	unsigned long flags;
+	int ret;
 
+	spin_lock_irqsave(drive->channel->lock, flags);
+	ret = __idedisk_cleanup(drive);
+	spin_unlock_irqrestore(drive->channel->lock, flags);
 	return ret;
 }
 
@@ -1475,30 +1501,41 @@
 	char *req;
 	struct ata_channel *channel;
 	int unit;
+	unsigned long flags;
 
+	spin_lock_irqsave(drive->channel->lock, flags);
 	if (drive->type != ATA_DISK)
-		return;
+		goto out_lock;
 
 	req = drive->driver_req;
-	if (req[0] != '\0' && strcmp(req, "ide-disk"))
-		return;
+	if (req[0] != '\0' && strcmp(req, "ide-disk")) 
+		goto out_lock;
 
 	if (ide_register_subdriver(drive, &idedisk_driver)) {
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		return;
+		goto out_lock;
 	}
-
+	
 	idedisk_setup(drive);
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n", drive->name, drive->head);
-		idedisk_cleanup(drive);
-		return;
+		__idedisk_cleanup(drive);
+		goto out_lock;
 	}
 
 	channel = drive->channel;
 	unit = drive - channel->drives;
+	
+	/* FIXME: drop the lock for block layer -Zwane */
+	spin_unlock(drive->channel->lock);
 
 	ata_revalidate(mk_kdev(channel->major, unit << PARTN_BITS));
+	local_irq_restore(flags);
+	return;
+
+out_lock:
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
 }
 
 static void __exit idedisk_exit(void)
Index: linux-2.5.24/drivers/ide//ide-floppy.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide-floppy.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-floppy.c
--- linux-2.5.24/drivers/ide//ide-floppy.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//ide-floppy.c	23 Jun 2002 20:57:50 -0000
@@ -821,7 +821,6 @@
  */
 static ide_startstop_t idefloppy_pc_intr(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_status_reg_t status;
@@ -830,6 +829,8 @@
 	struct atapi_packet_command *pc = floppy->pc;
 	unsigned int temp;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 #if IDEFLOPPY_DEBUG_LOG
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_pc_intr interrupt handler\n");
 #endif
@@ -885,24 +886,16 @@
 		return ide_stopped;
 	}
 #endif
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
-
-	spin_lock_irqsave(ch->lock, flags);
+	
 	bcount.b.high=IN_BYTE (IDE_BCOUNTH_REG);			/* Get the number of bytes to transfer */
 	bcount.b.low=IN_BYTE (IDE_BCOUNTL_REG);			/* on this interrupt */
 	ireason.all=IN_BYTE (IDE_IREASON_REG);
 
 	if (ireason.b.cod) {
-		spin_unlock_irqrestore(ch->lock, flags);
-
 		printk (KERN_ERR "ide-floppy: CoD != 0 in idefloppy_pc_intr\n");
 		return ide_stopped;
 	}
 	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {	/* Hopefully, we will never get here */
-		spin_unlock_irqrestore(ch->lock, flags);
-
 		printk (KERN_ERR "ide-floppy: We wanted to %s, ", ireason.b.io ? "Write":"Read");
 		printk (KERN_ERR "but the floppy wants us to %s !\n",ireason.b.io ? "Read":"Write");
 		return ide_stopped;
@@ -915,7 +908,6 @@
 
 				atapi_discard_data (drive,bcount.all);
 				ata_set_handler(drive, idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);
-				spin_unlock_irqrestore(ch->lock, flags);
 
 				return ide_started;
 			}
@@ -939,7 +931,6 @@
 	pc->current_position+=bcount.all;
 
 	ata_set_handler(drive, idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_started;
 }
@@ -951,16 +942,12 @@
  */
 static ide_startstop_t idefloppy_transfer_pc(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_ireason_reg_t ireason;
 	int ret;
 
-	/* FIXME: Move this lock upwards.
-	 */
-	spin_lock_irqsave(ch->lock, flags);
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
@@ -978,7 +965,6 @@
 			ret = ide_started;
 		}
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -1006,13 +992,14 @@
 
 static ide_startstop_t idefloppy_transfer_pc1(struct ata_device *drive, struct request *rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
 	idefloppy_ireason_reg_t ireason;
 	int ret;
 
+	BUG_ON(!spin_is_locked(ch->lock));
+
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
@@ -1020,11 +1007,6 @@
 		return startstop;
 	}
 
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
-
-	spin_lock_irqsave(ch->lock, flags);
 	ireason.all=IN_BYTE(IDE_IREASON_REG);
 	if (!ireason.b.cod || ireason.b.io) {
 		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
@@ -1045,7 +1027,6 @@
 				idefloppy_transfer_pc2);	/* fail == transfer_pc2 */
 		ret = ide_started;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -1061,6 +1042,8 @@
 	int dma_ok = 0;
 	ata_handler_t *pkt_xfer_routine;
 
+	BUG_ON(!spin_is_locked(drive->channel->lock));
+
 #if IDEFLOPPY_DEBUG_BUGS
 	if (floppy->pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD && pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
 		printk(KERN_ERR "ide-floppy: possible ide-floppy.c bug - Two request sense in serial were issued\n");
@@ -1129,14 +1112,8 @@
 		unsigned long flags;
 		struct ata_channel *ch = drive->channel;
 
-		/* FIXME: this locking should encompass the above register
-		 * file access too.
-		 */
-
-		spin_lock_irqsave(ch->lock, flags);
 		ata_set_handler(drive, pkt_xfer_routine, IDEFLOPPY_WAIT_CMD, NULL);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);		/* Issue the packet command */
-		spin_unlock_irqrestore(ch->lock, flags);
 
 		return ide_started;
 	} else {
@@ -1294,20 +1271,14 @@
 		else
 			printk (KERN_ERR "ide-floppy: %s: I/O error\n", drive->name);
 
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		idefloppy_end_request(drive, rq, 0);
-		spin_lock_irq(ch->lock);
 
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
 		if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
 			printk ("%s: unsupported r/w request size\n", drive->name);
-			/* FIXME: make this unlocking go away*/
-			spin_unlock_irq(ch->lock);
 			idefloppy_end_request(drive, rq, 0);
-			spin_lock_irq(ch->lock);
 
 			return ide_stopped;
 		}
@@ -1318,18 +1289,12 @@
 		pc = (struct atapi_packet_command *) rq->buffer;
 	} else {
 		blk_dump_rq_flags(rq, "ide-floppy: unsupported command in queue");
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		idefloppy_end_request(drive, rq, 0);
-		spin_lock_irq(ch->lock);
 
 		return ide_stopped;
 	}
 
-	/* FIXME: make this unlocking go away*/
-	spin_unlock_irq(ch->lock);
 	ret = idefloppy_issue_pc(drive, rq, pc);
-	spin_lock_irq(ch->lock);
 
 	return ret;
 }
Index: linux-2.5.24/drivers/ide//ide-taskfile.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide-taskfile.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-taskfile.c
--- linux-2.5.24/drivers/ide//ide-taskfile.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//ide-taskfile.c	25 Jun 2002 05:53:15 -0000
@@ -193,26 +193,29 @@
  * and the function returns immediately without waiting for the new rq to be
  * completed. This is again intended for careful use by the ATAPI tape/cdrom
  * driver code.
+ *
  */
 int ide_do_drive_cmd(struct ata_device *drive, struct request *rq, ide_action_t action)
 {
-	unsigned long flags;
 	unsigned int major = drive->channel->major;
 	request_queue_t *q = &drive->queue;
 	struct list_head *queue_head = &q->queue_head;
 	DECLARE_COMPLETION(wait);
 
+	BUG_ON(!spin_is_locked(drive->channel->lock));
+
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
+
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
-	if (action == ide_wait)
+	if (action == ide_wait) {
+		printk("%s: WARNING: %s doing ide_wait\n", drive->name, __FUNCTION__);
 		rq->waiting = &wait;
-
-	spin_lock_irqsave(drive->channel->lock, flags);
+	}
 
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
@@ -224,20 +227,23 @@
 			queue_head = queue_head->next;
 	}
 	q->elevator.elevator_add_req_fn(q, rq, queue_head);
-
+	
 	do_ide_request(q);
 
-	spin_unlock_irqrestore(drive->channel->lock, flags);
-
+	/* FIXME: This needs to move from here to simplify things -Zwane */
 	if (action == ide_wait) {
 		wait_for_completion(&wait);	/* wait for it to be serviced */
 		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
-	}
 
+	}
 	return 0;
 
 }
 
+/*
+ * These interrupt handling primitives/helpers should be called with the channel lock
+ * held and interrupts disabled.
+ */
 
 /*
  * Invoked on completion of a special REQ_SPECIAL command.
@@ -247,11 +253,8 @@
 
 	struct ata_taskfile *ar = rq->special;
 	ide_startstop_t ret = ide_stopped;
-	unsigned long flags;
-
-	ide__sti();	/* local CPU only */
 
-	spin_lock_irqsave(drive->channel->lock, flags);
+	BUG_ON(!spin_is_locked(drive->channel->lock));
 
 	if (rq->buffer && ar->taskfile.sector_number) {
 		if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
@@ -286,8 +289,6 @@
 	blkdev_dequeue_request(rq);
 	drive->rq = NULL;
 	end_that_request_last(rq);
-
-	spin_unlock_irqrestore(drive->channel->lock, flags);
 
 	return ret;
 }
Index: linux-2.5.24/drivers/ide//ide.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide.c
--- linux-2.5.24/drivers/ide//ide.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//ide.c	23 Jun 2002 21:20:29 -0000
@@ -107,7 +107,7 @@
 }
 
 /*
- * Not locking variabt of the end_request method.
+ * None locking variant of the end_request method.
  *
  * Channel lock should be held.
  */
@@ -152,13 +152,11 @@
  */
 int ata_end_request(struct ata_device *drive, struct request *rq, int uptodate)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
+	BUG_ON(!spin_is_locked(ch->lock));
 	ret = __ata_end_request(drive, rq, uptodate, 0);
-	spin_unlock_irqrestore(drive->channel->lock, flags);
 
 	return ret;
 }
@@ -374,8 +372,7 @@
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
+	local_irq_save(flags);
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (try_atapi) {
@@ -385,7 +382,7 @@
 			OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
 			ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 			ata_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
-			__restore_flags(flags);	/* local CPU only */
+			local_irq_restore(flags);
 
 			return ide_started;
 		}
@@ -398,8 +395,7 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
 		check_crc_errors(&ch->drives[unit]);
 
-	__restore_flags(flags);	/* local CPU only */
-
+	local_irq_restore(flags);
 	return ide_started;
 }
 
@@ -467,8 +463,10 @@
 	unsigned long flags;
 	u8 err = 0;
 
-	__save_flags (flags);	/* local CPU only */
-	ide__sti();		/* local CPU only */
+	/* FIXME: This shouldn't be necessary as we should have the lock and irqs
+	 * disabled on entry -zwane
+	 */
+	local_irq_save(flags);
 
 	printk("%s: %s: status=0x%02x", drive->name, msg, drive->status);
 	dump_bits(ata_status_msgs, ARRAY_SIZE(ata_status_msgs), drive->status);
@@ -516,7 +514,8 @@
 #endif
 		printk("\n");
 	}
-	__restore_flags (flags);	/* local CPU only */
+	
+	local_irq_restore(flags);
 	return err;
 }
 
@@ -626,8 +625,12 @@
 		++rq->errors;
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET)
 			return do_reset1(drive, 1);
-		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			return do_recalibrate(drive);
+		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL) {
+			ide_startstop_t ret;
+			/* FIXME: do_recalibrate tries to acquire the channel lock -zwane */
+			ret = do_recalibrate(drive);
+			return ret;
+		}
 	}
 
 	return ide_stopped;
@@ -702,9 +705,7 @@
 kill_rq:
 	if (ata_ops(drive)) {
 		if (ata_ops(drive)->end_request) {
-			spin_unlock_irq(ch->lock);
 			ata_ops(drive)->end_request(drive, rq, 0);
-			spin_lock_irq(ch->lock);
 		} else
 			__ata_end_request(drive, rq, 0, 0);
 	} else
@@ -894,7 +895,6 @@
 
 		drive->rq = rq;
 
-		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 
 		/* command started, we are busy */
@@ -921,7 +921,6 @@
 static void do_request(struct ata_channel *channel)
 {
 	ide_get_lock(&ide_irq_lock, ata_irq_request, channel);/* for atari only: POSSIBLY BROKEN HERE(?) */
-//	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, channel->active)) {
 		struct ata_channel *ch;
@@ -1021,15 +1020,12 @@
 
 		handler = ch->handler;
 		ch->handler = NULL;
-		spin_unlock(ch->lock);
-
 		ch = drive->channel;
 #if DISABLE_IRQ_NOSYNC
 		disable_irq_nosync(ch->irq);
 #else
 		disable_irq(ch->irq);	/* disable_irq_nosync ?? */
 #endif
-		__cli();	/* local CPU only, as if we were handling an interrupt */
 		if (ch->poll_timeout) {
 			ret = handler(drive, drive->rq);
 		} else if (drive_is_ready(drive)) {
@@ -1078,8 +1074,6 @@
 
 		enable_irq(ch->irq);
 
-		spin_lock_irq(ch->lock);
-
 		if (ret == ide_stopped)
 			clear_bit(IDE_BUSY, ch->active);
 
@@ -1151,12 +1145,11 @@
 void ata_irq_request(int irq, void *data, struct pt_regs *regs)
 {
 	struct ata_channel *ch = data;
-	unsigned long flags;
 	struct ata_device *drive;
 	ata_handler_t *handler = ch->handler;
 	ide_startstop_t startstop;
 
-	spin_lock_irqsave(ch->lock, flags);
+	spin_lock(ch->lock);
 
 	if (!ide_ack_intr(ch))
 		goto out_lock;
@@ -1211,14 +1204,14 @@
 	ch->handler = NULL;
 	del_timer(&ch->timer);
 
-	spin_unlock(ch->lock);
-
-	if (ch->unmask)
-		ide__sti();	/* local CPU only */
+	if (ch->unmask) {
+		/* FIXME: perhaps disable_irq(irq); __sti(); ? -Zwane
+		ide__sti();
+		*/
+	}
 
 	/* service this interrupt, may set handler for next interrupt */
 	startstop = handler(drive, drive->rq);
-	spin_lock_irq(ch->lock);
 
 	/*
 	 * Note that handler() may have set things up for another
@@ -1238,7 +1231,7 @@
 		queue_commands(drive);
 
 out_lock:
-	spin_unlock_irqrestore(ch->lock, flags);
+	spin_unlock(ch->lock);
 }
 
 static int ide_open(struct inode * inode, struct file * filp)
Index: linux-2.5.24/drivers/ide//pcidma.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/pcidma.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pcidma.c
--- linux-2.5.24/drivers/ide//pcidma.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//pcidma.c	23 Jun 2002 22:34:58 -0000
@@ -44,17 +44,7 @@
 
 	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
-			unsigned long flags;
-			struct ata_channel *ch = drive->channel;
-
-			/* FIXME: this locking should encompass the above register
-			 * file access too.
-			 */
-
-			spin_lock_irqsave(ch->lock, flags);
 			__ata_end_request(drive, rq, 1, rq->nr_sectors);
-			spin_unlock_irqrestore(ch->lock, flags);
-
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
Index: linux-2.5.24/drivers/ide//tcq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/tcq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 tcq.c
--- linux-2.5.24/drivers/ide//tcq.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
+++ linux-2.5.24/drivers/ide//tcq.c	23 Jun 2002 19:37:11 -0000
@@ -229,7 +229,6 @@
  *
  * Also, nIEN must be set as not to need protection against ide_dmaq_intr
  *
- * Channel lock should be held.
  */
 static ide_startstop_t service(struct ata_device *drive, struct request *rq)
 {
@@ -287,6 +286,7 @@
 	 * should not happen, a buggy device could introduce loop
 	 */
 	if ((feat = GET_FEAT()) & NSEC_REL) {
+		/* XXX is this safe w/o the lock? -Zwane */
 		drive->rq = NULL;
 		printk("%s: release in service\n", drive->name);
 		return ide_stopped;

-- 
http://function.linuxpower.ca
		


