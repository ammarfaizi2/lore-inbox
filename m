Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSFNLGp>; Fri, 14 Jun 2002 07:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317325AbSFNLGo>; Fri, 14 Jun 2002 07:06:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22283 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317308AbSFNLGj>; Fri, 14 Jun 2002 07:06:39 -0400
Message-ID: <3D09CE3B.1080108@evision-ventures.com>
Date: Fri, 14 Jun 2002 13:06:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 IDE 89
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010606070007000506060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606070007000506060003
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Thu Jun 13 11:49:15 CEST 2002 ide-clean-89

- fix lock initialization  for device tree handling. Well I would be lucky if
   it would be just a device tree like in Solaris.  But after studying the code
   which goes in right now it appears to develop quite fast in to a "just in
   case" and "ad-hoc" inferface mess we have already in /proc. Shit!

   Look for example at the initialization of a device struct. First we have a
   name to the directory encompassing the device and the immediately we fill in
   the georgeous name field - which is enterly unnecessary.

- Pull locking out from the device type drivers do_request handlers.  This
   allowed us to remove the draddy unlocking on entry to start_request.

   Much more of host controller rigister acces on crutial code paths is
   now covered by the queue access lock.

--------------010606070007000506060003
Content-Type: text/plain;
 name="ide-clean-89.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-89.diff"

diff -urN linux-2.5.21/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.21/drivers/ide/ide.c	2002-06-11 01:02:30.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-13 18:32:20.000000000 +0200
@@ -635,15 +635,16 @@
  */
 static ide_startstop_t start_request(struct ata_device *drive, struct request *rq)
 {
+	struct ata_channel *ch = drive->channel;
 	sector_t block;
 	unsigned int minor = minor(rq->rq_dev);
 	unsigned int unit = minor >> PARTN_BITS;
-	struct ata_channel *ch = drive->channel;
+	ide_startstop_t ret;
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
 #ifdef DEBUG
-	printk("%s: start_request: current=0x%08lx\n", ch->name, (unsigned long) rq);
+	printk("%s: %s: current=0x%08lx\n", ch->name, __FUNCTION__, (unsigned long) rq);
 #endif
 
 	/* bail early if we've exceeded max_failures */
@@ -663,55 +664,63 @@
 		if (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)
 			block += drive->sect0;
 
-
 	/* Yecch - this will shift the entire interval, possibly killing some
 	 * innocent following sector.
 	 */
 	if (block == 0 && drive->remap_0_to_1 == 1)
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
-	{
-		ide_startstop_t res;
 
-		ata_select(drive, 0);
-		if (ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
-					WAIT_READY, rq, &res)) {
-			printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
+	ata_select(drive, 0);
+	spin_unlock_irq(ch->lock);
+	if (ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
+				WAIT_READY, rq, &ret)) {
+		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
+		spin_lock_irq(ch->lock);
 
-			return res;
-		}
+		return ret;
 	}
+	spin_lock_irq(ch->lock);
 
 	/* This issues a special drive command.
+	 *
+	 * FIXME: move this down to idedisk_do_request().
 	 */
 	if (rq->flags & REQ_SPECIAL)
-		if (drive->type == ATA_DISK)
-			return ata_taskfile(drive, rq->special, NULL);
+		if (drive->type == ATA_DISK) {
+			spin_unlock_irq(ch->lock);
+			ret = ata_taskfile(drive, rq->special, NULL);
+			spin_lock_irq(ch->lock);
 
-	/* The normal way of execution is to pass and execute the request
-	 * handler down to the device type driver.
-	 */
-	if (ata_ops(drive)) {
-		if (ata_ops(drive)->do_request)
-			return ata_ops(drive)->do_request(drive, rq, block);
-		else {
-			ata_end_request(drive, rq, 0);
-
-			return ide_stopped;
+			return ret;
 		}
+
+	if (!ata_ops(drive)) {
+		printk(KERN_WARNING "%s: device type %d not supported\n",
+				drive->name, drive->type);
+		goto kill_rq;
 	}
 
-	/*
-	 * Error handling:
+	/* The normal way of execution is to pass and execute the request
+	 * handler down to the device type driver.
 	 */
 
-	printk(KERN_WARNING "%s: device type %d not supported\n",
-			drive->name, drive->type);
+	if (ata_ops(drive)->XXX_do_request) {
+		ret = ata_ops(drive)->XXX_do_request(drive, rq, block);
+	} else {
+		__ata_end_request(drive, rq, 0, 0);
+		ret = ide_stopped;
+	}
+	return ret;
 
 kill_rq:
-	if (ata_ops(drive) && ata_ops(drive)->end_request)
-		ata_ops(drive)->end_request(drive, rq, 0);
-	else
-		ata_end_request(drive, rq, 0);
+	if (ata_ops(drive)) {
+		if (ata_ops(drive)->end_request) {
+			spin_unlock_irq(ch->lock);
+			ata_ops(drive)->end_request(drive, rq, 0);
+			spin_lock_irq(ch->lock);
+		}
+	} else
+		__ata_end_request(drive, rq, 0, 0);
 
 	return ide_stopped;
 }
@@ -726,13 +735,8 @@
 
 	ch->handler = NULL;
 	del_timer(&ch->timer);
-
-	spin_unlock_irqrestore(ch->lock, flags);
-
-	/* FIXME make start_request do the unlock itself and
-	 * push this locking further down. */
-
 	ret = start_request(drive, drive->rq);
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -902,11 +906,8 @@
 
 		drive->rq = rq;
 
-		/* FIXME: push this locaing further down */
-		spin_unlock(drive->channel->lock);
 		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
-		spin_lock_irq(drive->channel->lock);
 
 		/* command started, we are busy */
 		if (startstop == ide_started)
diff -urN linux-2.5.21/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.21/drivers/ide/ide-cd.c	2002-06-11 00:02:07.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-13 17:23:46.000000000 +0200
@@ -804,6 +804,7 @@
 	}
 
 	/* Arm the interrupt handler and send the command to the device. */
+	/* FIXME: make this locking go away */
 	spin_lock_irqsave(ch->lock, flags);
 	ata_set_handler(drive, handler, timeout, cdrom_timer_expiry);
 	atapi_write(drive, cmd, CDROM_PACKET_SIZE);
@@ -1648,7 +1649,8 @@
 static ide_startstop_t
 ide_cdrom_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	ide_startstop_t action;
+	struct ata_channel *ch = drive->channel;
+	int ret;
 	struct cdrom_info *info = drive->driver_data;
 
 	if (rq->flags & REQ_CMD) {
@@ -1664,19 +1666,29 @@
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
-		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap)
-			action = cdrom_start_seek(drive, rq, block);
-		else {
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
+		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
+			ret = cdrom_start_seek(drive, rq, block);
+		} else {
 			if (rq_data_dir(rq) == READ)
-				action = cdrom_start_read(drive, rq, block);
+				ret = cdrom_start_read(drive, rq, block);
 			else
-				action = cdrom_start_write(drive, rq);
+				ret = cdrom_start_write(drive, rq);
 		}
 		info->last_block = block;
-		return action;
+		spin_lock_irq(ch->lock);
+		return ret;
 	} else if (rq->flags & (REQ_PC | REQ_SENSE)) {
-		return cdrom_do_packet_command(drive, rq);
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
+		ret = cdrom_do_packet_command(drive, rq);
+		spin_lock_irq(ch->lock);
+
+		return ret;
 	} else if (rq->flags & REQ_SPECIAL) {
+	        /* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		/*
 		 * FIXME: Kill REQ_SEPCIAL and replace it with commands queued
 		 * at the request queue instead as suggested by Linus.
@@ -1685,11 +1697,15 @@
 		 */
 
 		cdrom_end_request(drive, rq, 1);
+		spin_lock_irq(ch->lock);
+
 		return ide_stopped;
 	} else if (rq->flags & REQ_BLOCK_PC) {
 		struct packet_command pc;
 		ide_startstop_t startstop;
 
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		memset(&pc, 0, sizeof(pc));
 		pc.quiet = 1;
 		pc.timeout = 60 * HZ;
@@ -1700,12 +1716,17 @@
 		startstop = cdrom_do_packet_command(drive, rq);
 		if (pc.stat)
 			++rq->errors;
+		spin_lock_irq(ch->lock);
 
 		return startstop;
 	}
 
 	blk_dump_rq_flags(rq, "ide-cd bad flags");
+	/* FIXME: make this unlocking go away*/
+	spin_unlock_irq(ch->lock);
 	cdrom_end_request(drive, rq, 0);
+	spin_lock_irq(ch->lock);
+
 	return ide_stopped;
 }
 
@@ -2969,7 +2990,7 @@
 	attach:			ide_cdrom_attach,
 	cleanup:		ide_cdrom_cleanup,
 	standby:		NULL,
-	do_request:		ide_cdrom_do_request,
+	XXX_do_request:		ide_cdrom_do_request,
 	end_request:		NULL,
 	ioctl:			ide_cdrom_ioctl,
 	open:			ide_cdrom_open,
diff -urN linux-2.5.21/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.21/drivers/ide/ide-disk.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-13 17:02:38.000000000 +0200
@@ -555,6 +555,8 @@
  * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
+ *
+ * Channel lock should be held.
  */
 static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
@@ -562,30 +564,16 @@
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	/* make sure all request have bin finished
-	 * FIXME: this check doesn't make sense go! */
-	while (drive->blocked) {
-		yield();
-		printk(KERN_ERR "ide: Request while drive blocked?");
-	}
-
-	/* FIXME: Move this lock entiery upstream. */
-	spin_lock_irqsave(ch->lock, flags);
-
 	/* FIXME: this check doesn't make sense */
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
 		__ata_end_request(drive, rq, 0, 0);
-		spin_unlock_irqrestore(ch->lock, flags);
-
 		return ide_stopped;
 	}
 
 	if (IS_PDC4030_DRIVE) {
 		extern ide_startstop_t promise_do_request(struct ata_device *, struct request *, sector_t);
 
-		spin_unlock_irqrestore(drive->channel->lock, flags);
-
 		return promise_do_request(drive, rq, block);
 	}
 
@@ -593,33 +581,25 @@
 	 * start a tagged operation
 	 */
 	if (drive->using_tcq) {
-		int ret;
-
-		ret = blk_queue_start_tag(&drive->queue, rq);
+		int st = blk_queue_start_tag(&drive->queue, rq);
 
 		if (ata_pending_commands(drive) > drive->max_depth)
 			drive->max_depth = ata_pending_commands(drive);
 		if (ata_pending_commands(drive) > drive->max_last_depth)
 			drive->max_last_depth = ata_pending_commands(drive);
 
-		if (ret) {
+		if (st) {
 			BUG_ON(!ata_pending_commands(drive));
-			spin_unlock_irqrestore(ch->lock, flags);
-
 			return ide_started;
 		}
 	}
 
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		ret = lba48_do_request(drive, rq, block);
+		return lba48_do_request(drive, rq, block);
 	else if (drive->select.b.lba)
-		ret = lba28_do_request(drive, rq, block);
+		return lba28_do_request(drive, rq, block);
 	else
-		ret = chs_do_request(drive, rq, block);
-
-	spin_unlock_irqrestore(ch->lock, flags);
-
-	return ret;
+		return chs_do_request(drive, rq, block);
 }
 
 static int idedisk_open(struct inode *inode, struct file *filp, struct ata_device *drive)
@@ -868,9 +848,10 @@
 /* This is just a hook for the overall driver tree.
  */
 
-static struct device_driver idedisk_devdrv = {
-	suspend: idedisk_suspend,
-	resume: idedisk_resume,
+static struct device_driver disk_devdrv = {
+	.lock = RW_LOCK_UNLOCKED,
+	.suspend = idedisk_suspend,
+	.resume = idedisk_resume,
 };
 
 /*
@@ -1011,6 +992,7 @@
 	sector_t capacity;
 	sector_t set_max;
 	int drvid = -1;
+	struct ata_channel *ch = drive->channel;
 
 	if (id == NULL)
 		return;
@@ -1020,35 +1002,31 @@
 	 * to us, but they are removable and don't have a doorlock mechanism.
 	 */
 	if (drive->removable && !drive_is_flashcard(drive)) {
-		/*
-		 * Removable disks (eg. SYQUEST); ignore 'WD' drives.
+		/* Removable disks (eg. SYQUEST); ignore 'WD' drives.
 		 */
-		if (id->model[0] != 'W' || id->model[1] != 'D') {
+		if (!strncmp(id->model, "WD", 2))
 			drive->doorlocking = 1;
-		}
 	}
-	for (i = 0; i < MAX_DRIVES; ++i) {
-		struct ata_channel *hwif = drive->channel;
 
-		if (drive != &hwif->drives[i])
+	for (i = 0; i < MAX_DRIVES; ++i) {
+		if (drive != &ch->drives[i])
 		    continue;
 		drvid = i;
-		hwif->gd->de_arr[i] = drive->de;
+		ch->gd->de_arr[i] = drive->de;
 		if (drive->removable)
-			hwif->gd->flags[i] |= GENHD_FL_REMOVABLE;
+			ch->gd->flags[i] |= GENHD_FL_REMOVABLE;
 		break;
 	}
 
 	/* Register us within the device tree.
 	 */
-
 	if (drvid != -1) {
-		sprintf(drive->device.bus_id, "%d", drvid);
-		sprintf(drive->device.name, "ide-disk");
-		drive->device.driver = &idedisk_devdrv;
-		drive->device.parent = &drive->channel->dev;
-		drive->device.driver_data = drive;
-		device_register(&drive->device);
+		sprintf(drive->dev.bus_id, "sd@%x,%x", ch->unit, drvid);
+		strcpy(drive->dev.name, "ATA-Disk");
+		drive->dev.driver = &disk_devdrv;
+		drive->dev.parent = &ch->dev;
+		drive->dev.driver_data = drive;
+		device_register(&drive->dev);
 	}
 
 	/* Extract geometry if we did not already have one for the drive */
@@ -1173,7 +1151,6 @@
 	printk(KERN_INFO " %s: %ld sectors", drive->name, capacity);
 
 #if 0
-
 	/* Right now we avoid this calculation, since it can result in the
 	 * usage of not supported compiler internal functions on 32 bit hosts.
 	 * However since the calculation appears to be an interesting piece of
@@ -1428,7 +1405,7 @@
 	attach:			idedisk_attach,
 	cleanup:		idedisk_cleanup,
 	standby:		idedisk_standby,
-	do_request:		idedisk_do_request,
+	XXX_do_request:		idedisk_do_request,
 	end_request:		NULL,
 	ioctl:			idedisk_ioctl,
 	open:			idedisk_open,
diff -urN linux-2.5.21/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.21/drivers/ide/ide-floppy.c	2002-06-10 23:58:47.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-13 17:27:12.000000000 +0200
@@ -1279,8 +1279,10 @@
  */
 static ide_startstop_t idefloppy_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
+	struct ata_channel *ch = drive->channel;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct atapi_packet_command *pc;
+	int ret;
 
 #if IDEFLOPPY_DEBUG_LOG
 	printk (KERN_INFO "rq_status: %d, rq_dev: %u, flags: %lx, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->flags,rq->errors);
@@ -1293,13 +1295,22 @@
 				drive->name, floppy->failed_pc->c[0], floppy->sense_key, floppy->asc, floppy->ascq);
 		else
 			printk (KERN_ERR "ide-floppy: %s: I/O error\n", drive->name);
+
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		idefloppy_end_request(drive, rq, 0);
+		spin_lock_irq(ch->lock);
+
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
 		if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
 			printk ("%s: unsupported r/w request size\n", drive->name);
+			/* FIXME: make this unlocking go away*/
+			spin_unlock_irq(ch->lock);
 			idefloppy_end_request(drive, rq, 0);
+			spin_lock_irq(ch->lock);
+
 			return ide_stopped;
 		}
 		pc = idefloppy_next_pc_storage(drive);
@@ -1309,11 +1320,20 @@
 		pc = (struct atapi_packet_command *) rq->buffer;
 	} else {
 		blk_dump_rq_flags(rq, "ide-floppy: unsupported command in queue");
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		idefloppy_end_request(drive, rq, 0);
+		spin_lock_irq(ch->lock);
+
 		return ide_stopped;
 	}
 
-	return idefloppy_issue_pc(drive, rq, pc);
+	/* FIXME: make this unlocking go away*/
+	spin_unlock_irq(ch->lock);
+	ret = idefloppy_issue_pc(drive, rq, pc);
+	spin_lock_irq(ch->lock);
+
+	return ret;
 }
 
 /*
@@ -2027,7 +2047,7 @@
 	attach:			idefloppy_attach,
 	cleanup:		idefloppy_cleanup,
 	standby:		NULL,
-	do_request:		idefloppy_do_request,
+	XXX_do_request:		idefloppy_do_request,
 	end_request:		idefloppy_end_request,
 	ioctl:			idefloppy_ioctl,
 	open:			idefloppy_open,
diff -urN linux-2.5.21/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.21/drivers/ide/ide-tape.c	2002-06-11 00:18:38.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-13 17:14:25.000000000 +0200
@@ -2604,10 +2604,12 @@
  */
 static ide_startstop_t idetape_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
+	struct ata_channel *ch = drive->channel;
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc;
 	struct request *postponed_rq = tape->postponed_rq;
 	idetape_status_reg_t status;
+	int ret;
 
 #if IDETAPE_DEBUG_LOG
 /*	if (tape->debug_level >= 5)
@@ -2621,7 +2623,7 @@
 		 *	We do not support buffer cache originated requests.
 		 */
 		printk (KERN_NOTICE "ide-tape: %s: Unsupported command in request queue (%ld)\n", drive->name, rq->flags);
-		ata_end_request(drive, rq, 0);			/* Let the common code handle it */
+		__ata_end_request(drive, rq, 0, 0);			/* Let the common code handle it */
 		return ide_stopped;
 	}
 
@@ -2629,13 +2631,24 @@
 	 *	Retry a failed packet command
 	 */
 	if (tape->failed_pc != NULL && tape->pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {
-		return idetape_issue_packet_command(drive, rq, tape->failed_pc);
+		int ret;
+
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
+		ret = idetape_issue_packet_command(drive, rq, tape->failed_pc);
+		spin_lock_irq(ch->lock);
+
+		return ret;
 	}
 #if IDETAPE_DEBUG_BUGS
 	if (postponed_rq != NULL)
 		if (rq != postponed_rq) {
 			printk (KERN_ERR "ide-tape: ide-tape.c bug - Two DSC requests were queued\n");
+			/* FIXME: make this unlocking go away*/
+			spin_unlock_irq(ch->lock);
 			idetape_end_request(drive, rq, 0);
+			spin_lock_irq(ch->lock);
+
 			return ide_stopped;
 		}
 #endif
@@ -2656,7 +2669,7 @@
 	if (tape->onstream)
 		status.b.dsc = 1;
 	if (!drive->dsc_overlap && rq->flags != IDETAPE_PC_RQ2)
-		set_bit (IDETAPE_IGNORE_DSC, &tape->flags);
+		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
 
 	/*
 	 * For the OnStream tape, check the current status of the tape
@@ -2701,7 +2714,7 @@
 			tape->req_buffer_fill = 1;
 		}
 #if ONSTREAM_DEBUG
-		else if (tape->debug_level >= 4) 
+		else if (tape->debug_level >= 4)
 			printk(KERN_INFO "ide-tape: %s: postpone_cnt %d\n", tape->name, tape->postpone_cnt);
 #endif
 	}
@@ -2713,14 +2726,20 @@
 		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
 			printk (KERN_ERR "ide-tape: %s: DSC timeout\n", tape->name);
 			if (rq->flags == IDETAPE_PC_RQ2) {
+				/* FIXME: make this unlocking go away*/
+				spin_unlock_irq(ch->lock);
 				idetape_media_access_finished(drive, rq);
+				spin_lock_irq(ch->lock);
 				return ide_stopped;
 			} else {
 				return ide_stopped;
 			}
 		} else if (jiffies - tape->dsc_polling_start > IDETAPE_DSC_MA_THRESHOLD)
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_SLOW;
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		idetape_postpone_request(drive, rq);
+		spin_lock_irq(ch->lock);
 		return ide_stopped;
 	}
 	switch (rq->flags) {
@@ -2737,8 +2756,8 @@
 				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
 					tape->req_buffer_fill = 1;
 			}
-			pc = idetape_next_pc_storage (drive);
-			idetape_create_read_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
+			pc = idetape_next_pc_storage(drive);
+			idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_WRITE_RQ:
 			tape->buffer_head++;
@@ -2755,12 +2774,12 @@
 				calculate_speeds(drive);
 			}
 			pc = idetape_next_pc_storage (drive);
-			idetape_create_write_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
+			idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_READ_BUFFER_RQ:
 			tape->postpone_cnt = 0;
 			pc = idetape_next_pc_storage (drive);
-			idetape_create_read_buffer_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
+			idetape_create_read_buffer_cmd(tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_ABORTED_WRITE_RQ:
 			rq->flags = IDETAPE_WRITE_RQ;
@@ -2780,14 +2799,25 @@
 			rq->flags = IDETAPE_PC_RQ2;
 			break;
 		case IDETAPE_PC_RQ2:
+			/* FIXME: make this unlocking go away*/
+			spin_unlock_irq(ch->lock);
 			idetape_media_access_finished(drive, rq);
+			spin_lock_irq(ch->lock);
 			return ide_stopped;
 		default:
 			printk (KERN_ERR "ide-tape: bug in IDETAPE_RQ_CMD macro\n");
+			/* FIXME: make this unlocking go away*/
+			spin_unlock_irq(ch->lock);
 			idetape_end_request(drive, rq, 0);
+			spin_lock_irq(ch->lock);
 			return ide_stopped;
 	}
-	return idetape_issue_packet_command(drive, rq, pc);
+	/* FIXME: make this unlocking go away*/
+	spin_unlock_irq(ch->lock);
+	ret = idetape_issue_packet_command(drive, rq, pc);
+	spin_lock_irq(ch->lock);
+
+	return ret;
 }
 
 /*
@@ -6098,7 +6128,7 @@
 	attach:			idetape_attach,
 	cleanup:		idetape_cleanup,
 	standby:		NULL,
-	do_request:		idetape_do_request,
+	XXX_do_request:		idetape_do_request,
 	end_request:		idetape_end_request,
 	ioctl:			idetape_blkdev_ioctl,
 	open:			idetape_blkdev_open,
diff -urN linux-2.5.21/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.21/drivers/ide/main.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/main.c	2002-06-13 15:16:57.000000000 +0200
@@ -622,8 +622,6 @@
 		struct ata_operations *tmp;
 		unsigned long flags;
 
-		struct ata_operations *sd = NULL;
-
 		spin_lock_irqsave(&ata_drivers_lock, flags);
 		for(tmp = ata_drivers; tmp; tmp = tmp->next) {
 			if (subdriver_match(ch, tmp) > 0)
diff -urN linux-2.5.21/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.21/drivers/ide/pdc202xx.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-13 15:59:20.000000000 +0200
@@ -159,7 +159,10 @@
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
 	u32 drive_conf;
-	u8 drive_pci, AP, BP, CP, DP, TA = 0, TB, TC = 0;
+	u8 drive_pci, AP, BP, CP, TA = 0, TB, TC = 0;
+#if PDC202XX_DECODE_REGISTER_INFO
+	u8 DP;
+#endif
 
 	if (drive->dn > 3) /* FIXME: remove this --bkz */
 		return -1;
@@ -188,7 +191,7 @@
 		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;
 		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;
 		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 		case XFER_PIO_4:	TA = 0x01; TB = 0x04; break;
 		case XFER_PIO_3:	TA = 0x02; TB = 0x06; break;
 		case XFER_PIO_2:	TA = 0x03; TB = 0x08; break;
diff -urN linux-2.5.21/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.21/drivers/ide/probe.c	2002-06-11 00:18:00.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-06-13 15:34:50.000000000 +0200
@@ -850,10 +850,11 @@
 		goto not_found;
 
 	/* Register this hardware interface within the global device tree.
+	 *
+	 * FIXME: This should be handled as a pci subdevice in a generic way.
 	 */
-	sprintf(ch->dev.bus_id, "%04lx",
-		(unsigned long) ch->io_ports[IDE_DATA_OFFSET]);
-	sprintf(ch->dev.name, "ide");
+	sprintf(ch->dev.bus_id, "ata@%02x", ch->unit);
+	strcpy(ch->dev.name, "ATA/ATAPI Host-Channel");
 	ch->dev.driver_data = ch;
 #ifdef CONFIG_PCI
 	if (ch->pci_dev)
diff -urN linux-2.5.21/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.21/drivers/scsi/ide-scsi.c	2002-06-10 23:54:50.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-13 17:29:27.000000000 +0200
@@ -482,6 +482,9 @@
  */
 static ide_startstop_t idescsi_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
+	struct ata_channel *ch = drive->channel;
+	int ret;
+
 #ifdef DEBUG
 	printk(KERN_INFO "rq_status: %d, cmd: %d, errors: %d\n",
 			rq->rq_status,
@@ -494,12 +497,18 @@
 			rq->current_nr_sectors);
 #endif
 
+	/* FIXME: make this unlocking go away*/
+	spin_unlock_irq(ch->lock);
 	if (rq->flags & REQ_PC) {
-		return idescsi_issue_pc(drive, rq, (struct atapi_packet_command *) rq->special);
+		ret = idescsi_issue_pc(drive, rq, (struct atapi_packet_command *) rq->special);
+	} else {
+	    blk_dump_rq_flags(rq, "ide-scsi: unsup command");
+	    idescsi_end_request(drive, rq, 0);
+	    ret = ide_stopped;
 	}
-	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
-	idescsi_end_request(drive, rq, 0);
-	return ide_stopped;
+	spin_lock_irq(ch->lock);
+
+	return ret;
 }
 
 static int idescsi_open(struct inode *inode, struct file *filp, struct ata_device *drive)
@@ -540,7 +549,7 @@
 	owner:			THIS_MODULE,
 	attach:			idescsi_attach,
 	cleanup:		idescsi_cleanup,
-	do_request:		idescsi_do_request,
+	XXX_do_request:		idescsi_do_request,
 	end_request:		idescsi_end_request,
 	open:			idescsi_open,
 	release:		idescsi_release,
diff -urN linux-2.5.21/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.21/include/linux/ide.h	2002-06-13 20:15:09.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-13 15:52:17.000000000 +0200
@@ -357,7 +357,7 @@
 	byte		queue_depth;	/* max queue depth */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
-	struct device	device;		/* global device tree handle */
+	struct device	dev;		/* global device tree handle */
 
 	/*
 	 * tcq statistics
@@ -545,7 +545,7 @@
 	void (*attach) (struct ata_device *);
 	int (*cleanup)(struct ata_device *);
 	int (*standby)(struct ata_device *);
-	ide_startstop_t	(*do_request)(struct ata_device *, struct request *, sector_t);
+	ide_startstop_t	(*XXX_do_request)(struct ata_device *, struct request *, sector_t);
 	int (*end_request)(struct ata_device *, struct request *, int);
 
 	int (*ioctl)(struct ata_device *, struct inode *, struct file *, unsigned int, unsigned long);

--------------010606070007000506060003--

