Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEMKv6>; Mon, 13 May 2002 06:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSEMKv5>; Mon, 13 May 2002 06:51:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25355 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311885AbSEMKvt>; Mon, 13 May 2002 06:51:49 -0400
Message-ID: <3CDF8BFB.5060203@evision-ventures.com>
Date: Mon, 13 May 2002 11:48:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 61
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010705060600070608000708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010705060600070608000708
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Sat May 11 18:45:08 CEST 2002 ide-clean-61

- Fix typo in pdc202xx driver.

- Fix locking order in ioctl.

- Fix wrong time_after usage introduced in 60. Maybe the fact I always get is
   wrong is related to the fact that I'm using the mouse with the left hand!?

- Apply arch-clean-2 by Bartlomiej Zolnierkiewicz.

- Don't disable interrupts during ide_wait_stat(). I see no reason too.

- Push flags down from hwgroup to the ata_chaannel structure.

- Apply small fixes from Franz Sirl to make AEC6280 working properly again.


--------------010705060600070608000708
Content-Type: text/plain;
 name="ide-clean-61.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-61.diff"

diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-13 12:44:17.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-13 02:13:30.000000000 +0200
@@ -317,7 +317,7 @@
 			blkdev_dequeue_request(rq);
 		else
 			blk_queue_end_tag(&drive->queue, rq);
-		HWGROUP(drive)->rq = NULL;
+		drive->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
 	}
@@ -635,7 +635,7 @@
 	}
 
 	blkdev_dequeue_request(rq);
-	HWGROUP(drive)->rq = NULL;
+	drive->rq = NULL;
 	end_that_request_last(rq);
 }
 
@@ -886,7 +886,6 @@
 {
 	u8 stat;
 	int i;
-	unsigned long flags;
 
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
@@ -896,24 +895,20 @@
 
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
 	if ((stat = GET_STAT()) & BUSY_STAT) {
-		__save_flags(flags);	/* local CPU only */
-		ide__sti();		/* local CPU only */
 		timeout += jiffies;
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (time_after(timeout, jiffies)) {
-				__restore_flags(flags);	/* local CPU only */
+			if (time_after(jiffies, timeout)) {
 				*startstop = ide_error(drive, rq, "status timeout", stat);
 				return 1;
 			}
 		}
-		__restore_flags(flags);	/* local CPU only */
 	}
+
 	/*
-	 * Allow status to settle, then read it again.
-	 * A few rare drives vastly violate the 400ns spec here,
-	 * so we'll wait up to 10usec for a "good" status
-	 * rather than expensively fail things immediately.
-	 * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
+	 * Allow status to settle, then read it again.  A few rare drives
+	 * vastly violate the 400ns spec here, so we'll wait up to 10usec for a
+	 * "good" status rather than expensively fail things immediately.  This
+	 * fix courtesy of Matthew Faupel & Niccolo Rigacci.
 	 */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
@@ -1074,15 +1069,13 @@
 	struct ata_channel *ch = drive->channel;
 	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	unsigned long flags;
-	struct request *rq;
 
 	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup->handler = NULL;
 	del_timer(&ch->timer);
-	rq = hwgroup->rq;
 	spin_unlock_irqrestore(&ide_lock, flags);
 
-	return start_request(drive, rq);
+	return start_request(drive, drive->rq);
 }
 
 /*
@@ -1180,7 +1173,6 @@
 	if (choice)
 		return choice;
 
-	channel->hwgroup->rq = NULL;
 	sleep = longest_sleep(channel);
 
 	if (sleep) {
@@ -1197,14 +1189,14 @@
 		if (timer_pending(&channel->timer))
 			printk(KERN_ERR "ide_set_handler: timer already active\n");
 #endif
-		set_bit(IDE_SLEEP, &channel->hwgroup->flags);
+		set_bit(IDE_SLEEP, &channel->active);
 		mod_timer(&channel->timer, sleep);
 		/* we purposely leave hwgroup busy while sleeping */
 	} else {
 		/* Ugly, but how can we sleep for the lock otherwise? perhaps
 		 * from tq_disk? */
 		ide_release_lock(&irq_lock);/* for atari only */
-		clear_bit(IDE_BUSY, &channel->hwgroup->flags);
+		clear_bit(IDE_BUSY, &channel->active);
 	}
 
 	return NULL;
@@ -1217,13 +1209,13 @@
  */
 static void queue_commands(struct ata_device *drive, int masked_irq)
 {
-	ide_hwgroup_t *hwgroup = drive->channel->hwgroup;
+	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop = -1;
 
 	for (;;) {
 		struct request *rq = NULL;
 
-		if (!test_bit(IDE_BUSY, &hwgroup->flags))
+		if (!test_bit(IDE_BUSY, &ch->active))
 			printk(KERN_ERR"%s: error: not busy while queueing!\n", drive->name);
 
 		/* Abort early if we can't queue another command. for non
@@ -1232,13 +1224,13 @@
 		 */
 		if (!ata_can_queue(drive)) {
 			if (!ata_pending_commands(drive))
-				clear_bit(IDE_BUSY, &hwgroup->flags);
+				clear_bit(IDE_BUSY, &ch->active);
 			break;
 		}
 
 		drive->sleep = 0;
 
-		if (test_bit(IDE_DMA, &hwgroup->flags)) {
+		if (test_bit(IDE_DMA, &ch->active)) {
 			printk("ide_do_request: DMA in progress...\n");
 			break;
 		}
@@ -1256,8 +1248,8 @@
 
 		if (!(rq = elv_next_request(&drive->queue))) {
 			if (!ata_pending_commands(drive))
-				clear_bit(IDE_BUSY, &hwgroup->flags);
-			hwgroup->rq = NULL;
+				clear_bit(IDE_BUSY, &ch->active);
+			drive->rq = NULL;
 			break;
 		}
 
@@ -1268,7 +1260,7 @@
 		if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
 			break;
 
-		hwgroup->rq = rq;
+		drive->rq = rq;
 
 		/* Some systems have trouble with IDE IRQs arriving while the
 		 * driver is still setting things up.  So, here we disable the
@@ -1339,12 +1331,10 @@
  */
 static void ide_do_request(struct ata_channel *channel, int masked_irq)
 {
-	ide_hwgroup_t *hwgroup = channel->hwgroup;
-
 	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
-	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
+	while (!test_and_set_bit(IDE_BUSY, &channel->active)) {
 		struct ata_channel *ch;
 		struct ata_device *drive;
 
@@ -1405,7 +1395,7 @@
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
 	 * make sure request is sane
 	 */
-	HWGROUP(drive)->rq = NULL;
+	drive->rq = NULL;
 
 	rq->errors = 0;
 	if (rq->bio) {
@@ -1446,8 +1436,8 @@
 		 * complain about anything.
 		 */
 
-		if (test_and_clear_bit(IDE_SLEEP, &hwgroup->flags))
-			clear_bit(IDE_BUSY, &hwgroup->flags);
+		if (test_and_clear_bit(IDE_SLEEP, &ch->active))
+			clear_bit(IDE_BUSY, &ch->active);
 	} else {
 		struct ata_device *drive = ch->drive;
 		if (!drive) {
@@ -1457,11 +1447,11 @@
 			ide_startstop_t startstop;
 
 			/* paranoia */
-			if (!test_and_set_bit(IDE_BUSY, &hwgroup->flags))
+			if (!test_and_set_bit(IDE_BUSY, &ch->active))
 				printk("%s: ide_timer_expiry: hwgroup was not busy??\n", drive->name);
 			if ((expiry = ch->expiry) != NULL) {
 				/* continue */
-				if ((wait = expiry(drive, HWGROUP(drive)->rq)) != 0) {
+				if ((wait = expiry(drive, drive->rq)) != 0) {
 					/* reengage timer */
 					ch->timer.expires  = jiffies + wait;
 					add_timer(&ch->timer);
@@ -1484,25 +1474,25 @@
 #endif
 			__cli();	/* local CPU only, as if we were handling an interrupt */
 			if (ch->poll_timeout != 0) {
-				startstop = handler(drive, ch->hwgroup->rq);
+				startstop = handler(drive, drive->rq);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
 					udma_irq_lost(drive);
 				(void) ide_ack_intr(ch);
 				printk("%s: lost interrupt\n", drive->name);
-				startstop = handler(drive, ch->hwgroup->rq);
+				startstop = handler(drive, drive->rq);
 			} else {
 				if (drive->waiting_for_dma) {
 					startstop = ide_stopped;
-					dma_timeout_retry(drive, ch->hwgroup->rq);
+					dma_timeout_retry(drive, drive->rq);
 				} else
-					startstop = ide_error(drive, ch->hwgroup->rq, "irq timeout", GET_STAT());
+					startstop = ide_error(drive, drive->rq, "irq timeout", GET_STAT());
 			}
 			set_recovery_timer(ch);
 			enable_irq(ch->irq);
 			spin_lock_irq(&ide_lock);
 			if (startstop == ide_stopped)
-				clear_bit(IDE_BUSY, &hwgroup->flags);
+				clear_bit(IDE_BUSY, &ch->active);
 		}
 	}
 
@@ -1627,7 +1617,7 @@
 		goto out_lock;
 	}
 	/* paranoia */
-	if (!test_and_set_bit(IDE_BUSY, &hwgroup->flags))
+	if (!test_and_set_bit(IDE_BUSY, &ch->active))
 		printk(KERN_ERR "%s: %s: hwgroup was not busy!?\n", drive->name, __FUNCTION__);
 	hwgroup->handler = NULL;
 	del_timer(&ch->timer);
@@ -1637,7 +1627,7 @@
 		ide__sti();	/* local CPU only */
 
 	/* service this interrupt, may set handler for next interrupt */
-	startstop = handler(drive, hwgroup->rq);
+	startstop = handler(drive, drive->rq);
 	spin_lock_irq(&ide_lock);
 
 	/*
@@ -1650,7 +1640,7 @@
 	set_recovery_timer(drive->channel);
 	if (startstop == ide_stopped) {
 		if (hwgroup->handler == NULL) {	/* paranoia */
-			clear_bit(IDE_BUSY, &hwgroup->flags);
+			clear_bit(IDE_BUSY, &ch->active);
 			ide_do_request(ch, ch->irq);
 		} else {
 			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
@@ -1738,7 +1728,7 @@
 	spin_lock_irqsave(&ide_lock, flags);
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
-			HWGROUP(drive)->rq = NULL;
+			drive->rq = NULL;
 	} else {
 		if (action == ide_wait || action == ide_end)
 			queue_head = queue_head->prev;
@@ -2222,8 +2212,6 @@
 
 int ide_spin_wait_hwgroup(struct ata_device *drive)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-
 	/* FIXME: Wait on a proper timer. Instead of playing games on the
 	 * spin_lock().
 	 */
@@ -2232,7 +2220,7 @@
 
 	spin_lock_irq(&ide_lock);
 
-	while (test_bit(IDE_BUSY, &hwgroup->flags)) {
+	while (test_bit(IDE_BUSY, &drive->channel->active)) {
 		spin_unlock_irq(&ide_lock);
 		if (time_after(jiffies, timeout)) {
 			printk("%s: channel busy\n", drive->name);
@@ -2316,7 +2304,9 @@
 	kdev_t dev;
 
 	dev = inode->i_rdev;
-	major = major(dev); minor = minor(dev);
+	major = major(dev);
+	minor = minor(dev);
+
 	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
 		return -ENODEV;
 
@@ -2376,6 +2366,7 @@
 
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
+
 			return 0;
 		}
 
@@ -2384,12 +2375,12 @@
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
-			if (ide_spin_wait_hwgroup(drive))
-				return -EBUSY;
-
 			if (drive->channel->no_unmask)
 				return -EIO;
 
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
 			drive->channel->unmask = arg;
 			spin_unlock_irq(&ide_lock);
 
@@ -2426,11 +2417,20 @@
 
 			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
 				return -EINVAL;
-			if (put_user(drive->bios_head, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(drive->bios_sect, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(bios_cyl, (unsigned short *) &loc->cylinders)) return -EFAULT;
+
+			if (put_user(drive->bios_head, (byte *) &loc->heads))
+				return -EFAULT;
+
+			if (put_user(drive->bios_sect, (byte *) &loc->sectors))
+				return -EFAULT;
+
+			if (put_user(bios_cyl, (unsigned short *) &loc->cylinders))
+				return -EFAULT;
+
 			if (put_user((unsigned)drive->part[minor(inode->i_rdev)&PARTN_MASK].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
+				(unsigned long *) &loc->start))
+				return -EFAULT;
+
 			return 0;
 		}
 
@@ -2440,48 +2440,59 @@
 			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
 				return -EINVAL;
 
-			if (put_user(drive->head, (u8 *) &loc->heads)) return -EFAULT;
-			if (put_user(drive->sect, (u8 *) &loc->sectors)) return -EFAULT;
-			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
+			if (put_user(drive->head, (u8 *) &loc->heads))
+				return -EFAULT;
+
+			if (put_user(drive->sect, (u8 *) &loc->sectors))
+				return -EFAULT;
+
+			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders))
+				return -EFAULT;
+
 			if (put_user((unsigned)drive->part[minor(inode->i_rdev)&PARTN_MASK].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
+				(unsigned long *) &loc->start))
+				return -EFAULT;
+
 			return 0;
 		}
 
 		case BLKRRPART: /* Re-read partition tables */
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
 			return ide_revalidate_disk(inode->i_rdev);
 
 		case HDIO_GET_IDENTITY:
 			if (minor(inode->i_rdev) & PARTN_MASK)
 				return -EINVAL;
+
 			if (drive->id == NULL)
 				return -ENOMSG;
+
 			if (copy_to_user((char *)arg, (char *)drive->id, sizeof(*drive->id)))
 				return -EFAULT;
+
 			return 0;
 
 		case HDIO_GET_NICE:
-			return put_user(drive->dsc_overlap	<<	IDE_NICE_DSC_OVERLAP	|
-					drive->atapi_overlap	<<	IDE_NICE_ATAPI_OVERLAP,
+			return put_user(drive->dsc_overlap << IDE_NICE_DSC_OVERLAP |
+					drive->atapi_overlap << IDE_NICE_ATAPI_OVERLAP,
 					(long *) arg);
 
 		case HDIO_DRIVE_CMD:
-			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			if (!capable(CAP_SYS_RAWIO))
 				return -EACCES;
+
 			return ide_cmd_ioctl(drive, arg);
 
 		case HDIO_SET_NICE:
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP))))
 				return -EPERM;
+
 			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
 			/* Only CD-ROM's and tapes support DSC overlap. */
 			if (drive->dsc_overlap && !(drive->type == ATA_ROM || drive->type == ATA_TAPE)) {
 				drive->dsc_overlap = 0;
 				return -EPERM;
 			}
+
 			return 0;
 
 		case BLKGETSIZE:
@@ -2505,25 +2516,24 @@
 			return block_ioctl(inode->i_bdev, cmd, arg);
 
 		case HDIO_GET_BUSSTATE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
 			if (put_user(drive->channel->bus_state, (long *)arg))
 				return -EFAULT;
+
 			return 0;
 
 		case HDIO_SET_BUSSTATE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
 			if (drive->channel->busproc)
 				drive->channel->busproc(drive, (int)arg);
+
 			return 0;
 
-		/* Now check whatever this particular ioctl has a special
-		 * implementation.
+		/* Now check whatever this particular ioctl has a device type
+		 * specific implementation.
 		 */
 		default:
 			if (ata_ops(drive) && ata_ops(drive)->ioctl)
 				return ata_ops(drive)->ioctl(drive, inode, file, cmd, arg);
+
 			return -EINVAL;
 	}
 }
@@ -2545,6 +2555,7 @@
 			res = 1; /* assume it was changed */
 		ata_put(ata_ops(drive));
 	}
+
 	return res;
 }
 
diff -urN linux-2.5.15/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.15/drivers/ide/ide-disk.c	2002-05-13 12:44:17.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-12 16:12:30.000000000 +0200
@@ -1058,6 +1058,7 @@
 
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
+
 			return 0;
 		}
 
@@ -1081,6 +1082,7 @@
 
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
+
 			return 0;
 		}
 
@@ -1100,7 +1102,7 @@
 		}
 
 		case HDIO_GET_ACOUSTIC: {
-			u8 val = drive->acoustic;
+			unsigned long val = drive->acoustic;
 
 			if (put_user(val, (u8 *) arg))
 				return -EFAULT;
@@ -1128,6 +1130,7 @@
 
 			if (put_user(val, (u8 *) arg))
 				return -EFAULT;
+
 			return 0;
 		}
 
@@ -1153,7 +1156,7 @@
 
 
 /*
- *      IDE subdriver functions, registered with ide.c
+ * Subdriver functions.
  */
 static struct ata_operations idedisk_driver = {
 	owner:			THIS_MODULE,
@@ -1178,11 +1181,9 @@
 
 	while ((drive = ide_scan_devices(ATA_DISK, "ide-disk", &idedisk_driver, failed)) != NULL) {
 		if (idedisk_cleanup (drive)) {
-			printk (KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
-			failed++;
+			printk(KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
+			++failed;
 		}
-		/* We must remove proc entries defined in this module.
-		   Otherwise we oops while accessing these entries */
 	}
 }
 
@@ -1203,10 +1204,11 @@
 			idedisk_cleanup(drive);
 			continue;
 		}
-		failed--;
+		--failed;
 	}
 	revalidate_drives();
 	MOD_DEC_USE_COUNT;
+
 	return 0;
 }
 
diff -urN linux-2.5.15/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.15/drivers/ide/ide-dma.c	2002-05-13 12:44:17.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-11 23:23:14.000000000 +0200
@@ -382,10 +382,10 @@
 
 #ifdef DEBUG
 	printk("%s: dma_timer_expiry: dma status == 0x%02x\n", drive->name, dma_stat);
-#endif /* DEBUG */
+#endif
 
 #if 0
-	HWGROUP(drive)->expiry = NULL;	/* one free ride for now */
+	drive->expiry = NULL;	/* one free ride for now */
 #endif
 
 	if (dma_stat & 2) {	/* ERROR */
diff -urN linux-2.5.15/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.15/drivers/ide/ide-pci.c	2002-05-10 00:25:29.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-13 12:37:07.000000000 +0200
@@ -122,7 +122,7 @@
 	 * Unless there is a bootable card that does not use the standard
 	 * ports 1f0/170 (the ide0/ide1 defaults). The (bootable) flag.
 	 */
-	if (bootable) {
+	if (bootable == ON_BOARD) {
 		for (h = 0; h < MAX_HWIFS; ++h) {
 			hwif = &ide_hwifs[h];
 			if (hwif->chipset == ide_unknown)
@@ -703,7 +703,7 @@
 			hpt374_device_order_fixup(dev, d);
 	} else if (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268R)
 		pdc20270_device_order_fixup(dev, d);
-	else if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+	else {
 		printk(KERN_INFO "ATA: %s (%04x:%04x) on PCI slot %s\n",
 				dev->name, vendor, device, dev->slot_name);
 		setup_pci_device(dev, d);
diff -urN linux-2.5.15/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.15/drivers/ide/ide-taskfile.c	2002-05-13 12:44:17.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-12 17:47:58.000000000 +0200
@@ -279,6 +279,7 @@
 
 	if (stat & BUSY_STAT)
 		return 0;	/* drive busy:  definitely not interrupting */
+
 	return 1;		/* drive ready: *might* be interrupting */
 }
 
diff -urN linux-2.5.15/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.15/drivers/ide/pdc202xx.c	2002-05-10 00:25:39.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-12 16:16:37.000000000 +0200
@@ -1450,7 +1450,7 @@
 		init_chipset: pdc202xx_init_chipset,
 		ata66_check: ata66_pdc202xx,
 		init_channel: ide_init_pdc202xx,
-		exnablebits: {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+		enablebits: {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 		bootable: OFF_BOARD,
 		extra: 48,
 		flags: ATA_F_IRQ  | ATA_F_DMA
diff -urN linux-2.5.15/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.15/drivers/ide/sl82c105.c	2002-05-10 00:23:12.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-05-12 03:35:22.000000000 +0200
@@ -76,7 +76,7 @@
 	if (ide_config_drive_speed(drive, xfer_mode) == 0)
 		drv_ctrl = get_timing_sl82c105(t);
 
-	if (drive->using_dma == 0) {
+	if (!drive->using_dma) {
 		/*
 		 * If we are actually using MW DMA, then we can not
 		 * reprogram the interface drive control register.
diff -urN linux-2.5.15/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.15/drivers/ide/tcq.c	2002-05-13 12:44:17.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-13 02:17:33.000000000 +0200
@@ -95,15 +95,15 @@
 
 	del_timer(&ch->timer);
 
-	if (test_bit(IDE_DMA, &hwgroup->flags))
+	if (test_bit(IDE_DMA, &ch->active))
 		udma_stop(drive);
 
 	blk_queue_invalidate_tags(q);
 
 	drive->using_tcq = 0;
 	drive->queue_depth = 1;
-	clear_bit(IDE_BUSY, &hwgroup->flags);
-	clear_bit(IDE_DMA, &hwgroup->flags);
+	clear_bit(IDE_BUSY, &ch->active);
+	clear_bit(IDE_DMA, &ch->active);
 	hwgroup->handler = NULL;
 
 	/*
@@ -152,6 +152,7 @@
 static void ata_tcq_irq_timeout(unsigned long data)
 {
 	struct ata_device *drive = (struct ata_device *) data;
+	struct ata_channel *ch = drive->channel;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
 
@@ -159,7 +160,7 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 
-	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
+	if (test_and_set_bit(IDE_BUSY, &ch->active))
 		printk(KERN_ERR "ATA: %s: hwgroup not busy\n", __FUNCTION__);
 	if (hwgroup->handler == NULL)
 		printk(KERN_ERR "ATA: %s: missing isr!\n", __FUNCTION__);
@@ -170,7 +171,7 @@
 	 * if pending commands, try service before giving up
 	 */
 	if (ata_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
-		if (service(drive, hwgroup->rq) == ide_started)
+		if (service(drive, drive->rq) == ide_started)
 			return;
 
 	if (drive)
@@ -241,7 +242,7 @@
 	 * Could be called with IDE_DMA in-progress from invalidate
 	 * handler, refuse to do anything.
 	 */
-	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+	if (test_bit(IDE_DMA, &drive->channel->active))
 		return ide_stopped;
 
 	/*
@@ -283,7 +284,7 @@
 	 * should not happen, a buggy device could introduce loop
 	 */
 	if ((feat = GET_FEAT()) & NSEC_REL) {
-		HWGROUP(drive)->rq = NULL;
+		drive->rq = NULL;
 		printk("%s: release in service\n", drive->name);
 		return ide_stopped;
 	}
@@ -298,7 +299,7 @@
 		return ide_stopped;
 	}
 
-	HWGROUP(drive)->rq = rq;
+	drive->rq = rq;
 
 	/*
 	 * we'll start a dma read or write, device will trigger
@@ -529,7 +530,7 @@
 	struct ata_channel *ch = drive->channel;
 
 	TCQ_PRINTK("%s: setting up queued %d\n", __FUNCTION__, rq->tag);
-	if (!test_bit(IDE_BUSY, &ch->hwgroup->flags))
+	if (!test_bit(IDE_BUSY, &ch->active))
 		printk("queued_rw: IDE_BUSY not set\n");
 
 	if (tcq_wait_dataphase(drive))
@@ -584,7 +585,7 @@
 	 */
 	if ((feat = GET_FEAT()) & NSEC_REL) {
 		drive->immed_rel++;
-		HWGROUP(drive)->rq = NULL;
+		drive->rq = NULL;
 		set_irq(drive, ide_dmaq_intr);
 
 		TCQ_PRINTK("REL in queued_start\n");
diff -urN linux-2.5.15/include/asm-alpha/ide.h linux/include/asm-alpha/ide.h
--- linux-2.5.15/include/asm-alpha/ide.h	2002-05-10 00:23:17.000000000 +0200
+++ linux/include/asm-alpha/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -82,10 +82,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMalpha_IDE_H */
diff -urN linux-2.5.15/include/asm-arm/ide.h linux/include/asm-arm/ide.h
--- linux-2.5.15/include/asm-arm/ide.h	2002-05-10 00:24:07.000000000 +0200
+++ linux/include/asm-arm/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -21,10 +21,6 @@
 
 #include <asm/arch/ide.h>
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 /*
  * We always use the new IDE port registering,
  * so these are fixed here.
diff -urN linux-2.5.15/include/asm-cris/ide.h linux/include/asm-cris/ide.h
--- linux-2.5.15/include/asm-cris/ide.h	2002-05-10 00:22:28.000000000 +0200
+++ linux/include/asm-cris/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -96,10 +96,6 @@
 #undef SUPPORT_SLOW_DATA_PORTS
 #define SUPPORT_SLOW_DATA_PORTS	0
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 /* the drive addressing is done through a controller register on the Etrax CPU */
 void OUT_BYTE(unsigned char data, ide_ioreg_t reg);
 unsigned char IN_BYTE(ide_ioreg_t reg);
diff -urN linux-2.5.15/include/asm-i386/ide.h linux/include/asm-i386/ide.h
--- linux-2.5.15/include/asm-i386/ide.h	2002-05-10 00:21:52.000000000 +0200
+++ linux/include/asm-i386/ide.h	2002-05-13 03:09:01.000000000 +0200
@@ -86,10 +86,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMi386_IDE_H */
diff -urN linux-2.5.15/include/asm-ia64/ide.h linux/include/asm-ia64/ide.h
--- linux-2.5.15/include/asm-ia64/ide.h	2002-05-10 00:24:57.000000000 +0200
+++ linux/include/asm-ia64/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -92,10 +92,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IA64_IDE_H */
diff -urN linux-2.5.15/include/asm-m68k/ide.h linux/include/asm-m68k/ide.h
--- linux-2.5.15/include/asm-m68k/ide.h	2002-05-10 00:21:32.000000000 +0200
+++ linux/include/asm-m68k/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -145,10 +145,13 @@
 
 #endif /* CONFIG_ATARI || CONFIG_Q40 */
 
+#define ATA_ARCH_ACK_INTR
+
+#ifdef CONFIG_ATARI
+#define ATA_ARCH_LOCK
 
 static __inline__ void ide_release_lock (int *ide_lock)
 {
-#ifdef CONFIG_ATARI
 	if (MACH_IS_ATARI) {
 		if (*ide_lock == 0) {
 			printk("ide_release_lock: bug\n");
@@ -157,12 +160,10 @@
 		*ide_lock = 0;
 		stdma_release();
 	}
-#endif /* CONFIG_ATARI */
 }
 
 static __inline__ void ide_get_lock (int *ide_lock, void (*handler)(int, void *, struct pt_regs *), void *data)
 {
-#ifdef CONFIG_ATARI
 	if (MACH_IS_ATARI) {
 		if (*ide_lock == 0) {
 			if (in_interrupt() > 0)
@@ -171,10 +172,8 @@
 			*ide_lock = 1;
 		}
 	}
-#endif /* CONFIG_ATARI */
 }
-
-#define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
+#endif /* CONFIG_ATARI */
 
 /*
  * On the Atari, we sometimes can't enable interrupts:
diff -urN linux-2.5.15/include/asm-mips/ide.h linux/include/asm-mips/ide.h
--- linux-2.5.15/include/asm-mips/ide.h	2002-05-10 00:22:38.000000000 +0200
+++ linux/include/asm-mips/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -68,10 +68,6 @@
 #undef  SUPPORT_VLB_SYNC
 #define SUPPORT_VLB_SYNC 0
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IDE_H */
diff -urN linux-2.5.15/include/asm-mips64/ide.h linux/include/asm-mips64/ide.h
--- linux-2.5.15/include/asm-mips64/ide.h	2002-05-10 00:21:32.000000000 +0200
+++ linux/include/asm-mips64/ide.h	2002-05-12 16:28:28.000000000 +0200
@@ -68,10 +68,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IDE_H */
diff -urN linux-2.5.15/include/asm-parisc/ide.h linux/include/asm-parisc/ide.h
--- linux-2.5.15/include/asm-parisc/ide.h	2002-05-10 00:23:34.000000000 +0200
+++ linux/include/asm-parisc/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -81,10 +81,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMi386_IDE_H */
diff -urN linux-2.5.15/include/asm-ppc/ide.h linux/include/asm-ppc/ide.h
--- linux-2.5.15/include/asm-ppc/ide.h	2002-05-10 00:23:34.000000000 +0200
+++ linux/include/asm-ppc/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -108,12 +108,8 @@
 }
 
 #if (defined CONFIG_APUS || defined CONFIG_BLK_DEV_MPC8xx_IDE )
-#define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
-#else
-#define ide_ack_intr(hwif)		(1)
+#define ATA_ARCH_ACK_INTR
 #endif
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
 
 #endif /* __KERNEL__ */
 
diff -urN linux-2.5.15/include/asm-ppc64/ide.h linux/include/asm-ppc64/ide.h
--- linux-2.5.15/include/asm-ppc64/ide.h	2002-05-10 00:24:22.000000000 +0200
+++ linux/include/asm-ppc64/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -50,10 +50,6 @@
 {
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMPPC64_IDE_H */
diff -urN linux-2.5.15/include/asm-s390/ide.h linux/include/asm-s390/ide.h
--- linux-2.5.15/include/asm-s390/ide.h	2002-05-10 00:24:47.000000000 +0200
+++ linux/include/asm-s390/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -18,14 +18,6 @@
 #define ide__sti()	do {} while (0)
 
 /*
- * The following are not needed for the non-m68k ports
- */
-#define ide_ack_intr(hwif)		(1)
-#define ide_fix_driveid(id)		do {} while (0)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
-/*
  * We always use the new IDE port registering,
  * so these are fixed here.
  */
diff -urN linux-2.5.15/include/asm-s390x/ide.h linux/include/asm-s390x/ide.h
--- linux-2.5.15/include/asm-s390x/ide.h	2002-05-10 00:21:33.000000000 +0200
+++ linux/include/asm-s390x/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -17,10 +17,6 @@
 
 #define ide__sti()	do {} while (0)
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 /*
  * We always use the new IDE port registering,
  * so these are fixed here.
diff -urN linux-2.5.15/include/asm-sh/ide.h linux/include/asm-sh/ide.h
--- linux-2.5.15/include/asm-sh/ide.h	2002-05-10 00:22:55.000000000 +0200
+++ linux/include/asm-sh/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -107,10 +107,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_IDE_H */
diff -urN linux-2.5.15/include/asm-sparc/ide.h linux/include/asm-sparc/ide.h
--- linux-2.5.15/include/asm-sparc/ide.h	2002-05-10 00:24:45.000000000 +0200
+++ linux/include/asm-sparc/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -165,11 +165,6 @@
 	/* __flush_dcache_range((unsigned long)src, end); */ /* P3 see hme */
 }
 
-#define ide_ack_intr(hwif)		(1)
-/* #define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1) */
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* _SPARC_IDE_H */
diff -urN linux-2.5.15/include/asm-sparc64/ide.h linux/include/asm-sparc64/ide.h
--- linux-2.5.15/include/asm-sparc64/ide.h	2002-05-10 00:23:37.000000000 +0200
+++ linux/include/asm-sparc64/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -181,10 +181,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* _SPARC64_IDE_H */
diff -urN linux-2.5.15/include/asm-x86_64/ide.h linux/include/asm-x86_64/ide.h
--- linux-2.5.15/include/asm-x86_64/ide.h	2002-05-10 00:24:22.000000000 +0200
+++ linux/include/asm-x86_64/ide.h	2002-05-12 16:28:29.000000000 +0200
@@ -86,10 +86,6 @@
 #endif
 }
 
-#define ide_ack_intr(hwif)		(1)
-#define ide_release_lock(lock)		do {} while (0)
-#define ide_get_lock(lock, hdlr, data)	do {} while (0)
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMi386_IDE_H */
diff -urN linux-2.5.15/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.15/include/linux/ide.h	2002-05-13 12:44:17.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-13 03:09:01.000000000 +0200
@@ -239,6 +239,19 @@
 
 #include <asm/ide.h>
 
+/* Currently only m68k, apus and m8xx need it */
+#ifdef ATA_ARCH_ACK_INTR
+# define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
+#else
+# define ide_ack_intr(hwif) (1)
+#endif
+
+/* Currently only Atari needs it */
+#ifndef ATA_ARCH_LOCK
+# define ide_release_lock(lock)		do {} while (0)
+# define ide_get_lock(lock, hdlr, data)	do {} while (0)
+#endif
+
 /*
  * If the arch-dependant ide.h did not declare/define any OUT_BYTE or IN_BYTE
  * functions, we make some defaults here. The only architecture currently
@@ -324,14 +337,16 @@
 	 * magically just go away.
 	 */
 	request_queue_t	queue;	/* per device request queue */
+	struct request *rq;		/* current request */
 
 	unsigned long sleep;	/* sleep until this time */
 
-	byte     using_dma;		/* disk is using dma for read/write */
-	byte	 using_tcq;		/* disk is using queueing */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
-	byte     dsc_overlap;		/* flag: DSC overlap */
+
+	unsigned using_dma	: 1;	/* disk is using dma for read/write */
+	unsigned using_tcq	: 1;	/* disk is using queueing */
+	unsigned dsc_overlap	: 1;	/* flag: DSC overlap */
 
 	unsigned waiting_for_dma: 1;	/* dma currently in progress */
 	unsigned busy		: 1;	/* currently doing revalidate_disk() */
@@ -403,11 +418,39 @@
 	int		max_depth;
 } ide_drive_t;
 
+/*
+ * Status returned by various functions.
+ */
+typedef enum {
+	ide_stopped,	/* no drive operation was started */
+	ide_started,	/* a drive operation was started, and a handler was set */
+	ide_released	/* started and released bus */
+} ide_startstop_t;
+
+/*
+ *  Interrupt and timeout handler type.
+ */
+typedef ide_startstop_t (ata_handler_t)(struct ata_device *, struct request *);
+typedef int (ata_expiry_t)(struct ata_device *, struct request *);
+
 enum {
 	ATA_PRIMARY	= 0,
 	ATA_SECONDARY	= 1
 };
 
+enum {
+	IDE_BUSY,	/* awaiting an interrupt */
+	IDE_SLEEP,
+	IDE_DMA		/* DMA in progress */
+};
+
+typedef struct hwgroup_s {
+	/* FIXME: We should look for busy request queues instead of looking at
+	 * the !NULL state of this field.
+	 */
+	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
+} ide_hwgroup_t;
+
 struct ata_channel {
 	struct device	dev;		/* device handle */
 	int		unit;		/* channel number */
@@ -415,7 +458,9 @@
 	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	struct timer_list timer;	/* failsafe timer */
 	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
+	unsigned long poll_timeout;	/* timeout value during polled operations */
 	struct ata_device *drive;	/* last serviced drive */
+	unsigned long active;		/* active processing request */
 
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
@@ -506,9 +551,8 @@
 #endif
 	/* driver soft-power interface */
 	int (*busproc)(struct ata_device *, int);
-	byte		bus_state;	/* power state of the IDE bus */
 
-	unsigned long poll_timeout; /* timeout value during polled operations */
+	byte		bus_state;	/* power state of the IDE bus */
 };
 
 /*
@@ -517,27 +561,8 @@
 extern int ide_register_hw(hw_regs_t *hw, struct ata_channel **hwifp);
 extern void ide_unregister(struct ata_channel *hwif);
 
-/*
- * Status returned by various functions.
- */
-typedef enum {
-	ide_stopped,	/* no drive operation was started */
-	ide_started,	/* a drive operation was started, and a handler was set */
-	ide_released	/* started and released bus */
-} ide_startstop_t;
-
-/*
- *  Interrupt and timeout handler type.
- */
-typedef ide_startstop_t (ata_handler_t)(struct ata_device *, struct request *);
-typedef int (ata_expiry_t)(struct ata_device *, struct request *);
-
 struct ata_taskfile;
 
-#define IDE_BUSY	0	/* awaiting an interrupt */
-#define IDE_SLEEP	1
-#define IDE_DMA		2	/* DMA in progress */
-
 #define IDE_MAX_TAG	32
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
@@ -561,15 +586,6 @@
 # define ata_can_queue(drive)		(1)
 #endif
 
-typedef struct hwgroup_s {
-	/* FIXME: We should look for busy request queues instead of looking at
-	 * the !NULL state of this field.
-	 */
-	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
-	unsigned long flags;		/* BUSY, SLEEPING */
-	struct request *rq;		/* current request */
-} ide_hwgroup_t;
-
 /* FIXME: kill this as soon as possible */
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 

--------------010705060600070608000708--

