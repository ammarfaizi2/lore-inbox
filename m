Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSFTNiX>; Thu, 20 Jun 2002 09:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314448AbSFTNiW>; Thu, 20 Jun 2002 09:38:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36620 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314446AbSFTNiK>; Thu, 20 Jun 2002 09:38:10 -0400
Message-ID: <3D11DABF.6070809@evision-ventures.com>
Date: Thu, 20 Jun 2002 15:38:07 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.23
References: <Pine.LNX.4.33.0206181915001.1773-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090804060405010904060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804060405010904060800
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Sun Jun 16 20:03:45 CEST 2002 ide-clean-93

- Revert patch number 92. It turned out to be broken behind hope.  Personally I
   attribute this to the recent heat wave over here and apologize for the
   problems this may have caused. Turned out that my note about the change
   beeing dnagerous in the last change log was more then true...

- Locking issues for ioctl handling.

- Remove waiting_for_dma bit field. Use IDE_DMA bit flag instead.
   Apply this bit globally and not in the corresponding implementation
   functions.


--------------090804060405010904060800
Content-Type: text/plain;
 name="ide-clean-93.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-93.diff"

diff -urN linux-2.5.23/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.23/drivers/ide/cmd64x.c	2002-06-19 04:11:52.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-06-20 13:27:03.000000000 +0200
@@ -597,7 +602,6 @@
 	struct pci_dev *dev	= ch->pci_dev;
 	u8 jack_slap		= ((dev->device == PCI_DEVICE_ID_CMD_648) || (dev->device == PCI_DEVICE_ID_CMD_649)) ? 1 : 0;
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
@@ -647,7 +651,6 @@
 	unsigned long dma_base = ch->dma_base;
 	u8 dma_stat;
 
-	drive->waiting_for_dma = 0;
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
diff -urN linux-2.5.23/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.23/drivers/ide/hpt34x.c	2002-06-19 04:11:47.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-20 13:25:25.000000000 +0200
@@ -157,7 +158,6 @@
 	unsigned long dma_base = ch->dma_base;
 	u8 dma_stat;
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
@@ -184,7 +184,6 @@
 	outl(ch->dmatable_dma, dma_base + 4);	/* PRD table */
 	outb(cmd, dma_base);			/* specify r/w */
 	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
-	drive->waiting_for_dma = 1;
 
 	if (drive->type == ATA_DISK) {
 		ata_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
diff -urN linux-2.5.23/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.23/drivers/ide/hpt366.c	2002-06-19 04:11:48.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-20 13:25:12.000000000 +0200
@@ -890,7 +918,6 @@
 		do_udma_start(drive);
 	}
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
@@ -913,7 +940,6 @@
 	if ((bwsr_stat & bwsr_mask) == bwsr_mask)
 	        pci_write_config_byte(dev, mscreg, msc_stat|0x30);
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
diff -urN linux-2.5.23/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.23/drivers/ide/icside.c	2002-06-19 04:11:47.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-20 13:27:16.000000000 +0200
@@ -440,7 +440,6 @@
 {
 	struct ata_channel *ch = drive->channel;
 
-	drive->waiting_for_dma = 0;
 	disable_dma(ch->hw.dma);
 	icside_destroy_dmatable(drive);
 
@@ -508,8 +507,6 @@
 	set_dma_sg(ch->hw.dma, ch->sg_table, count);
 	set_dma_mode(ch->hw.dma, dma_mode);
 
-	drive->waiting_for_dma = 1;
-
 	return 0;
 }
 
diff -urN linux-2.5.23/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.23/drivers/ide/ide.c	2002-06-19 04:11:59.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-20 13:28:43.000000000 +0200
@@ -262,14 +262,14 @@
  * Poll the interface for completion every 50ms during an ATAPI drive reset
  * operation. If the drive has not yet responded, and we have not yet hit our
  * maximum waiting time, then the timer is restarted for another 50ms.
+ *
+ * Channel lock should be held.
  */
 static ide_startstop_t atapi_reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret = ide_stopped;
 
-	spin_lock_irqsave(ch->lock, flags);
 	ata_select(drive, 10);
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
@@ -287,7 +287,6 @@
 
 		ret = ide_stopped;
 	}
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ret;
 }
@@ -296,14 +295,14 @@
  * Poll the interface for completion every 50ms during an ata reset operation.
  * If the drives have not yet responded, and we have not yet hit our maximum
  * waiting time, then the timer is restarted for another 50ms.
+ *
+ * Channel lock should be held.
  */
 static ide_startstop_t reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
-	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	int ret;
 
-	spin_lock_irqsave(ch->lock, flags);
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
 			ata_set_handler(drive, reset_pollfunc, HZ/20, NULL);
@@ -347,7 +346,6 @@
 		ret = ide_stopped;
 	}
 	ch->poll_timeout = 0;	/* done polling */
-	spin_unlock_irqrestore(ch->lock, flags);
 
 	return ide_stopped;
 }
@@ -443,12 +441,17 @@
 static void dump_bits(struct ata_bit_messages *msgs, int nr, byte bits)
 {
 	int i;
+	int first = 1;
 
 	printk(" [ ");
 
 	for (i = 0; i < nr; i++, msgs++)
-		if ((bits & msgs->mask) == msgs->match)
-			printk("%s ", msgs->msg);
+		if ((bits & msgs->mask) == msgs->match) {
+			if (!first)
+				printk(",");
+			printk("%s", msgs->msg);
+			first = 0;
+		}
 
 	printk("] ");
 }
@@ -560,7 +563,7 @@
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
-		ide_raw_taskfile(drive, &args, NULL);
+		ide_raw_taskfile(drive, &args);
 		printk(KERN_INFO "%s: done!\n", drive->name);
 	}
 
@@ -1030,12 +1033,12 @@
 		if (ch->poll_timeout) {
 			ret = handler(drive, drive->rq);
 		} else if (drive_is_ready(drive)) {
-			if (drive->waiting_for_dma)
+			if (test_bit(IDE_DMA, ch->active))
 				udma_irq_lost(drive);
 			(void) ide_ack_intr(ch);
 			printk("%s: lost interrupt\n", drive->name);
 			ret = handler(drive, drive->rq);
-		} else if (drive->waiting_for_dma) {
+		} else if (test_bit(IDE_DMA, ch->active)) {
 			struct request *rq = drive->rq;
 
 			/*
diff -urN linux-2.5.23/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.23/drivers/ide/ide-disk.c	2002-06-19 04:11:45.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-20 12:49:05.000000000 +0200
@@ -93,74 +93,61 @@
 /*
  * Handler for command with PIO data-in phase.
  */
-static ide_startstop_t pio_in_intr(struct ata_device *drive, struct request *rq)
+static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	unsigned int msect;
+	int ret;
 
 	spin_lock_irqsave(ch->lock, flags);
+
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
 			spin_unlock_irqrestore(ch->lock, flags);
 
 			return ata_error(drive, rq, __FUNCTION__);
 		}
 
-		if (!(drive->status & BUSY_STAT))
-			goto cont;
-	}
-
-	msect = drive->mult_count;
-	do {
-		unsigned int nsect;
+		/* no data yet, so wait for another interrupt */
+		ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
 
-		if (drive->mult_count) {
-			nsect = rq->current_nr_sectors;
-			/* Don't try to transfer more sectors at once then one
-			 * multi sector command can swallow.
-			 */
-			if (nsect > msect)
-				nsect = msect;
-		} else {
-			nsect = rq->current_nr_sectors;
-			nsect = 1;
-		}
+		ret = ide_started;
+	} else {
 
-//		printk("Read: rq->current_nr_sectors: %d %d %d\n", msect, nsect,  (int) rq->current_nr_sectors);
+		//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
 		{
 			unsigned long flags;
 			char *buf;
 
 			buf = ide_map_rq(rq, &flags);
-			ata_read(drive, buf, nsect * SECTOR_WORDS);
+			ata_read(drive, buf, SECTOR_WORDS);
 			ide_unmap_rq(rq, buf, &flags);
 		}
 
-		/* Segment of the request is complete. note that this does not
-		 * necessarily mean that the entire request is done!! this is
-		 * only true if ata_end_request() returns 0.
+		/* First segment of the request is complete. note that this does not
+		 * necessarily mean that the entire request is done!! this is only true
+		 * if ata_end_request() returns 0.
 		 */
-
 		rq->errors = 0;
-		rq->current_nr_sectors -= nsect;
+		--rq->current_nr_sectors;
 
 		if (rq->current_nr_sectors <= 0) {
 			if (!__ata_end_request(drive, rq, 1, 0)) {
+			//		printk("Request Ended stat: %02x\n", drive->status);
 				spin_unlock_irqrestore(ch->lock, flags);
 
 				return ide_stopped;
 			}
 		}
-		msect -= nsect;
-	} while (msect > 0);
 
-cont:
-	/* still data left to transfer */
-	ata_set_handler(drive, pio_in_intr,  WAIT_CMD, NULL);
+		/* still data left to transfer */
+		ata_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
+
+		ret = ide_started;
+	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ide_started;
+	return ret;
 }
 
 /*
@@ -203,6 +190,77 @@
 	return ret;
 }
 
+/*
+ * Handler for command with Read Multiple
+ */
+static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
+{
+	unsigned long flags;
+	struct ata_channel *ch = drive->channel;
+	int ret;
+
+	spin_lock_irqsave(ch->lock, flags);
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
+			spin_unlock_irqrestore(ch->lock, flags);
+
+			return ata_error(drive, rq, __FUNCTION__);
+		}
+
+		/* no data yet, so wait for another interrupt */
+		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+
+		ret = ide_started;
+	} else {
+		unsigned int msect;
+
+		/* (ks/hs): Fixed Multi-Sector transfer */
+		msect = drive->mult_count;
+
+		do {
+			unsigned int nsect;
+
+			nsect = rq->current_nr_sectors;
+			if (nsect > msect)
+				nsect = msect;
+
+#if 0
+			printk("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
+					buf, nsect, rq->current_nr_sectors);
+#endif
+			{
+				unsigned long flags;
+				char *buf;
+
+				buf = ide_map_rq(rq, &flags);
+				ata_read(drive, buf, nsect * SECTOR_WORDS);
+				ide_unmap_rq(rq, buf, &flags);
+			}
+
+			rq->errors = 0;
+			rq->current_nr_sectors -= nsect;
+
+			/* FIXME: this seems buggy */
+			if (rq->current_nr_sectors <= 0) {
+				if (!__ata_end_request(drive, rq, 1, 0)) {
+					spin_unlock_irqrestore(ch->lock, flags);
+
+					return ide_stopped;
+				}
+			}
+			msect -= nsect;
+		} while (msect);
+
+		/* more data left */
+		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+
+		ret = ide_started;
+	}
+	spin_unlock_irqrestore(ch->lock, flags);
+
+	return ret;
+}
+
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
@@ -552,10 +610,10 @@
 			} else if (drive->using_dma) {
 				args.cmd = WIN_READDMA_EXT;
 			} else if (drive->mult_count) {
-				args.XXX_handler = pio_in_intr;
+				args.XXX_handler = task_mulin_intr;
 				args.cmd = WIN_MULTREAD_EXT;
 			} else {
-				args.XXX_handler = pio_in_intr;
+				args.XXX_handler = task_in_intr;
 				args.cmd = WIN_READ_EXT;
 			}
 		} else {
@@ -564,10 +622,11 @@
 			} else if (drive->using_dma) {
 				args.cmd = WIN_READDMA;
 			} else if (drive->mult_count) {
-				args.XXX_handler = pio_in_intr;
+				/* FIXME : Shouldn't this be task_mulin_intr?! */
+				args.XXX_handler = task_in_intr;
 				args.cmd = WIN_MULTREAD;
 			} else {
-				args.XXX_handler = pio_in_intr;
+				args.XXX_handler = task_in_intr;
 				args.cmd = WIN_READ;
 			}
 		}
@@ -614,19 +673,6 @@
 	return __do_request(drive, &args, rq);
 }
 
-/*
- * Small helper function used to execute simple commands.
- */
-static int simple_taskfile(struct ata_device *drive, u8 cmd)
-{
-	struct ata_taskfile args;
-
-	memset(&args, 0, sizeof(args));
-	args.cmd = cmd;
-
-	return ide_raw_taskfile(drive, &args, NULL);
-}
-
 static int idedisk_open(struct inode *inode, struct file *__fp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
@@ -635,11 +681,15 @@
 
 		/*
 		 * Ignore the return code from door_lock, since the open() has
-		 * already succeeded once, and the door_lock is irrelevant at
-		 * this time.
+		 * already succeeded once, and the door_lock is irrelevant at this
+		 * time.
 		 */
 		if (drive->doorlocking) {
-			if (simple_taskfile(drive, WIN_DOORLOCK))
+			struct ata_taskfile args;
+
+			memset(&args, 0, sizeof(args));
+			args.cmd = WIN_DOORLOCK;
+			if (ide_raw_taskfile(drive, &args))
 				drive->doorlocking = 0;
 		}
 	}
@@ -649,21 +699,30 @@
 
 static int flush_cache(struct ata_device *drive)
 {
-	u8 cmd;
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
 
 	if (drive->id->cfs_enable_2 & 0x2400)
-		cmd = WIN_FLUSH_CACHE_EXT;
+		args.cmd = WIN_FLUSH_CACHE_EXT;
 	else
-		cmd = WIN_FLUSH_CACHE;
+		args.cmd = WIN_FLUSH_CACHE;
 
-	return simple_taskfile(drive, cmd);
+	return ide_raw_taskfile(drive, &args);
 }
 
 static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	if (drive->removable && !drive->usage) {
+		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
+		invalidate_bdev(inode->i_bdev, 0);
+
 		if (drive->doorlocking) {
-			if (simple_taskfile(drive, WIN_DOORUNLOCK))
+			struct ata_taskfile args;
+
+			memset(&args, 0, sizeof(args));
+			args.cmd = WIN_DOORUNLOCK;
+			if (ide_raw_taskfile(drive, &args))
 				drive->doorlocking = 0;
 		}
 	}
@@ -710,7 +769,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
-	if (!ide_raw_taskfile(drive, &args, NULL)) {
+	if (!ide_raw_taskfile(drive, &args)) {
 		/* all went well track this setting as valid */
 		drive->mult_count = arg;
 
@@ -739,7 +798,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	drive->wcache = arg;
 
@@ -748,7 +807,11 @@
 
 static int idedisk_standby(struct ata_device *drive)
 {
-	return simple_taskfile(drive, WIN_STANDBYNOW1);
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.cmd = WIN_STANDBYNOW1;
+	return ide_raw_taskfile(drive, &args);
 }
 
 static int set_acoustic(struct ata_device *drive, int arg)
@@ -759,7 +822,7 @@
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	drive->acoustic = arg;
 
@@ -879,7 +942,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -901,9 +964,10 @@
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(args));
+
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX_EXT;
-        ide_raw_taskfile(drive, &args, NULL);
+        ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -941,7 +1005,7 @@
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
 	args.cmd = WIN_SET_MAX;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	/* if OK, read new maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -974,7 +1038,7 @@
 	args.hobfile.high_cylinder = (addr_req >>= 8);
 	args.hobfile.device_head = 0x40;
 
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1292,11 +1356,7 @@
 			if (arg < 0 || arg > (id ? id->max_multsect : 0))
 				return -EINVAL;
 
-			if (ide_spin_wait_hwgroup(drive))
-				return -EBUSY;
-
 			val = set_multcount(drive, arg);
-			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1316,11 +1376,7 @@
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
-			if (ide_spin_wait_hwgroup(drive))
-				return -EBUSY;
-
 			val = set_nowerr(drive, arg);
-			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1340,11 +1396,7 @@
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
-			if (ide_spin_wait_hwgroup(drive))
-				return -EBUSY;
-
 			val = write_cache(drive, arg);
-			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1363,11 +1415,7 @@
 			if (arg < 0 || arg > 254)
 				return -EINVAL;
 
-			if (ide_spin_wait_hwgroup(drive))
-				return -EBUSY;
-
 			val = set_acoustic(drive, arg);
-			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
diff -urN linux-2.5.23/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.23/drivers/ide/ide-pmac.c	2002-06-19 04:11:57.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-20 13:31:16.000000000 +0200
@@ -1378,7 +1393,6 @@
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
 		pmac_ide[ix].kind == controller_kl_ata4_80);
 
-	drive->waiting_for_dma = 0;
 	dstat = in_le32(&dma->status);
 	out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
 	pmac_ide_destroy_dmatable(drive->channel, ix);
@@ -1418,7 +1432,7 @@
 			((reading) ? 0x00800000UL : 0));
 		(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
 	}
-	drive->waiting_for_dma = 1;
+
 	if (drive->type != ATA_DISK)
 		return ide_started;
 
@@ -1466,6 +1480,8 @@
 	 * - The dbdma fifo hasn't yet finished flushing to to system memory
 	 * when the disk interrupt occurs.
 	 *
+	 * FIXME: The following *trick* is broken:
+	 *
 	 * The trick here is to increment drive->waiting_for_dma, and return as
 	 * if no interrupt occured. If the counter reach a certain timeout
 	 * value, we then return 1. If we really got the interrupt, it will
@@ -1480,15 +1496,16 @@
 	 */
 	if (!(in_le32(&dma->status) & ACTIVE))
 		return 1;
-	if (!drive->waiting_for_dma)
+
+	if (!test_bit(IDE_DMA, drive->channel->active))
 		printk(KERN_WARNING "ide%d, ide_dma_test_irq \
 				called while not waiting\n", ix);
 
 	/* If dbdma didn't execute the STOP command yet, the
 	 * active bit is still set */
-	drive->waiting_for_dma++;
-	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-		printk(KERN_WARNING "ide%d, timeout waiting \
+	set_bit(IDE_DMA, drive->channel->active);
+//	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
+//		printk(KERN_WARNING "ide%d, timeout waiting \
 				for dbdma command stop\n", ix);
 		return 1;
 	}
diff -urN linux-2.5.23/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.23/drivers/ide/ide-taskfile.c	2002-06-19 04:11:55.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-20 13:32:55.000000000 +0200
@@ -148,7 +148,7 @@
  */
 int drive_is_ready(struct ata_device *drive)
 {
-	if (drive->waiting_for_dma)
+	if (test_bit(IDE_DMA, drive->channel->active))
 		return udma_irq_status(drive);
 
 	/*
@@ -242,9 +242,8 @@
 /*
  * Invoked on completion of a special REQ_SPECIAL command.
  */
-static ide_startstop_t special_intr(struct ata_device *drive,
-		struct request *rq)
-{
+ide_startstop_t ata_special_intr(struct ata_device *drive, struct
+		request *rq) {
 
 	struct ata_taskfile *ar = rq->special;
 	ide_startstop_t ret = ide_stopped;
@@ -293,18 +292,16 @@
 	return ret;
 }
 
-int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar,
-		char *buffer)
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar)
 {
 	struct request req;
 
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-	ar->XXX_handler = special_intr;
+	ar->XXX_handler = ata_special_intr;
 
 	memset(&req, 0, sizeof(req));
 	req.flags = REQ_SPECIAL;
 	req.special = ar;
-	req.buffer = buffer;
 
 	return ide_do_drive_cmd(drive, &req, ide_wait);
 }
@@ -313,4 +310,5 @@
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
+EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.23/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.23/drivers/ide/ioctl.c	2002-06-19 04:11:50.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-20 11:45:13.000000000 +0200
@@ -47,6 +47,7 @@
 	u8 *argbuf = vals;
 	int argsize = 4;
 	struct ata_taskfile args;
+	struct request req;
 
 	/* Second phase.
 	 */
@@ -77,7 +78,17 @@
 		memset(argbuf + 4, 0, argsize - 4);
 	}
 
-	err = ide_raw_taskfile(drive, &args, argbuf + 4);
+	/* Issue ATA command and wait for completion.
+	 */
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.XXX_handler = ata_special_intr;
+
+	memset(&req, 0, sizeof(req));
+	req.flags = REQ_SPECIAL;
+	req.special = &args;
+
+	req.buffer = argbuf + 4;
+	err = ide_do_drive_cmd(drive, &req, ide_wait);
 
 	argbuf[0] = drive->status;
 	argbuf[1] = args.taskfile.feature;
diff -urN linux-2.5.23/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.23/drivers/ide/ns87415.c	2002-06-19 04:11:52.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-06-20 13:26:50.000000000 +0200
@@ -91,7 +91,6 @@
 	unsigned long dma_base = ch->dma_base;
 	u8 dma_stat;
 
-	drive->waiting_for_dma = 0;
 	dma_stat = inb(ch->dma_base+2);
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	outb(inb(dma_base)|6, dma_base);	/* from ERRATA: clear the INTR & ERROR bits */
diff -urN linux-2.5.23/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.23/drivers/ide/pcidma.c	2002-06-19 04:11:49.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-20 13:34:48.000000000 +0200
@@ -167,7 +167,6 @@
 	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
 	outb(reading, dma_base);		/* specify r/w */
 	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
-	drive->waiting_for_dma = 1;
 
 	return 0;
 }
@@ -436,7 +435,6 @@
 	unsigned long dma_base = ch->dma_base;
 	u8 dma_stat;
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
diff -urN linux-2.5.23/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.23/drivers/ide/pdc202xx.c	2002-06-19 04:11:58.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-20 13:38:06.000000000 +0200
@@ -571,7 +575,7 @@
 	outb(inb(ch->dma_base) | 1, ch->dma_base); /* start DMA */
 }
 
-int pdc202xx_udma_stop(struct ata_device *drive)
+static int pdc202xx_udma_stop(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	u32 high_16 = pci_resource_start(ch->pci_dev, 4);
@@ -585,7 +589,6 @@
 		OUT_BYTE(clock & ~(ch->unit ? 0x08:0x02), high_16 + PDC_CLK);
 	}
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
@@ -604,7 +607,7 @@
 
 #endif
 
-void pdc202xx_new_reset(struct ata_device *drive)
+static void pdc202xx_new_reset(struct ata_device *drive)
 {
 	ata_reset(drive->channel);
 	mdelay(1000);
diff -urN linux-2.5.23/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.23/drivers/ide/serverworks.c	2002-06-19 04:11:55.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-06-20 13:26:38.000000000 +0200
@@ -331,7 +341,6 @@
 #endif
 	}
 
-	drive->waiting_for_dma = 0;
 	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
diff -urN linux-2.5.23/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.23/drivers/ide/tcq.c	2002-06-19 04:11:57.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-20 11:45:13.000000000 +0200
@@ -441,7 +441,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = 0x01;
 	args.cmd = WIN_NOP;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 	if (args.taskfile.feature & ABRT_ERR)
 		return 1;
 
@@ -469,7 +469,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
 	}
@@ -481,7 +481,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
 	}
@@ -493,7 +493,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
 	}
diff -urN linux-2.5.23/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.23/drivers/ide/trm290.c	2002-06-19 04:11:49.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-20 13:38:52.000000000 +0200
@@ -185,8 +185,8 @@
 {
 	struct ata_channel *ch = drive->channel;
 
-	drive->waiting_for_dma = 0;
 	udma_destroy_table(ch);	/* purge DMA mappings */
+
 	return (inw(ch->dma_base + 2) != 0x00ff);
 }
 
@@ -224,7 +224,6 @@
 	trm290_prepare_drive(drive, 1);	/* select DMA xfer */
 
 	outl(ch->dmatable_dma|reading|writing, ch->dma_base);
-	drive->waiting_for_dma = 1;
 	outw((count * 2) - 1, ch->dma_base+2); /* start DMA */
 
 	if (drive->type == ATA_DISK) {
diff -urN linux-2.5.23/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.23/include/linux/ide.h	2002-06-19 04:11:49.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-20 13:35:15.000000000 +0200
@@ -298,7 +298,6 @@
 	unsigned using_tcq	: 1;	/* disk is using queueing */
 	unsigned dsc_overlap	: 1;	/* flag: DSC overlap */
 
-	unsigned waiting_for_dma: 1;	/* dma currently in progress */
 	unsigned busy		: 1;	/* currently doing revalidate_disk() */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 
@@ -681,7 +680,8 @@
 		bio_kunmap_irq(to, flags);
 }
 
-extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *, char *);
+extern ide_startstop_t ata_special_intr(struct ata_device *, struct request *);
+extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
 
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_config_drive_speed(struct ata_device *, byte);
@@ -756,6 +756,8 @@
 
 static inline int udma_stop(struct ata_device *drive)
 {
+	clear_bit(IDE_DMA, drive->channel->active);
+
 	return drive->channel->udma_stop(drive);
 }
 
@@ -764,7 +766,11 @@
  */
 static inline ide_startstop_t udma_init(struct ata_device *drive, struct request *rq)
 {
-	return drive->channel->udma_init(drive, rq);
+	int ret = drive->channel->udma_init(drive, rq);
+	if (ret == ide_started)
+		set_bit(IDE_DMA, drive->channel->active);
+
+	return ret;
 }
 
 static inline int udma_irq_status(struct ata_device *drive)

--------------090804060405010904060800--

