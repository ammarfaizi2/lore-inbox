Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSD3JOB>; Tue, 30 Apr 2002 05:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSD3JOA>; Tue, 30 Apr 2002 05:14:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33799 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313173AbSD3JNq>; Tue, 30 Apr 2002 05:13:46 -0400
Message-ID: <3CCE519C.1060306@evision-ventures.com>
Date: Tue, 30 Apr 2002 10:11:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: Linux 2.5.7
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020904000009040301060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904000009040301060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Rewrite choose_drive() to iterate explicitely over the channels and devices
   on them. It is not performance critical to iterate over this typically quite
   small array of disks and allows us to let them act on the natural entity,
   namely the channel as well as to remove the drive->next field from struct
   ata_device.  Make the device eviction code in ide_do_request() more
   intelliglible.  Add some comments explaining the reasoning behind the code
   there.

- Now finally since the code for choosing the drive which will be serviced next
   is intelliglibly it became obvious that the attempt to choose the next drive
   based on the duration of the last request was entierly bogous. (Because for
   example wakeups can take a long time, but this doesn't indicate that the
   drive is slow.) Remove this criterium and the corresponding accounting
   therefore. Threat all drives fairly right now.

Surprise surprise the overall system throughput increased :-).

--------------020904000009040301060408
Content-Type: text/plain;
 name="ide-clean-47.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-47.diff"

diff -urN linux-2.5.11/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.11/drivers/ide/ide.c	2002-04-30 03:48:19.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-04-30 03:41:06.000000000 +0200
@@ -285,7 +285,7 @@
 	hwif->bus_state = BUSSTATE_ON;
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
+		struct ata_device *drive = &hwif->drives[unit];
 
 		drive->type			= ATA_DISK;
 		drive->select.all		= (unit<<4)|0xa0;
@@ -507,19 +507,21 @@
 /*
  * This is called exactly *once* for each channel.
  */
-void ide_geninit(struct ata_channel *hwif)
+void ide_geninit(struct ata_channel *ch)
 {
 	unsigned int unit;
-	struct gendisk *gd = hwif->gd;
+	struct gendisk *gd = ch->gd;
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
+		struct ata_device *drive = &ch->drives[unit];
 
 		if (!drive->present)
 			continue;
+
 		if (drive->type != ATA_DISK && drive->type != ATA_FLOPPY)
 			continue;
-		register_disk(gd,mk_kdev(hwif->major,unit<<PARTN_BITS),
+
+		register_disk(gd,mk_kdev(ch->major,unit<<PARTN_BITS),
 #ifdef CONFIG_BLK_DEV_ISAPNP
 			(drive->forced_geom && drive->noprobe) ? 1 :
 #endif
@@ -1189,30 +1191,89 @@
 }
 
 /*
- * Select the next drive which will be serviced.
+ * Select the next device which will be serviced.
  */
-static struct ata_device *choose_drive(struct ata_device *cur)
+static struct ata_device *choose_urgent_device(struct ata_channel *channel)
 {
-	struct ata_device *drive = cur;
 	struct ata_device *best = NULL;
+	int i;
 
-	do {
-		if (!list_empty(&drive->queue.queue_head)
-		&& (!drive->PADAM_sleep	|| time_after_eq(drive->PADAM_sleep, jiffies))) {
-			if (!best
-			 || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep)))
-			 || (!best->PADAM_sleep && time_after(best->PADAM_service_start + 2 * best->PADAM_service_time, drive->PADAM_service_start + 2 * drive->PADAM_service_time)))
+	for (i = 0; i < MAX_HWIFS; ++i) {
+		int unit;
+		struct ata_channel *ch = &ide_hwifs[i];
+
+		if (!ch->present)
+			continue;
+
+		if (ch->hwgroup != channel->hwgroup)
+			continue;
+
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			struct ata_device *drive = &ch->drives[unit];
+
+			if (!drive->present)
+				continue;
+
+			/* There are no request pending for this device.
+			 */
+			if (list_empty(&drive->queue.queue_head))
+				continue;
+
+			/* This device still want's to remain idle.
+			 */
+			if (drive->PADAM_sleep && time_after(jiffies, drive->PADAM_sleep))
+				continue;
+
+			/* Take this device, if there is no device choosen thus far or
+			 * it's more urgent.
+			 */
+			if (!best || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep))))
 			{
 				if (!blk_queue_plugged(&drive->queue))
 					best = drive;
 			}
 		}
-		drive = drive->next;
-	} while (drive != cur);
+	}
+
 	return best;
 }
 
 /*
+ * Determine the longes sleep time for the devices in our hwgroup.
+ */
+static unsigned long longest_sleep(struct ata_channel *channel)
+{
+	unsigned long sleep = 0;
+	int i;
+
+	for (i = 0; i < MAX_HWIFS; ++i) {
+		int unit;
+		struct ata_channel *ch = &ide_hwifs[i];
+
+		if (!ch->present)
+			continue;
+
+		if (ch->hwgroup != channel->hwgroup)
+			continue;
+
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			struct ata_device *drive = &ch->drives[unit];
+
+			if (!drive->present)
+				continue;
+
+			/* This device is sleeping and waiting to be serviced
+			 * later than any other device we checked thus far.
+			 */
+			if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
+				sleep = drive->PADAM_sleep;
+		}
+	}
+
+	return sleep;
+}
+
+/*
  * Issue a new request to a drive from hwgroup.
  * Caller must have already done spin_lock_irqsave(&ide_lock, ...)
  *
@@ -1242,42 +1303,33 @@
  * will start the next request from the queue.  If no more work remains,
  * the driver will clear the hwgroup->flags IDE_BUSY flag and exit.
  */
-static void ide_do_request(struct ata_channel *ch, int masked_irq)
+static void ide_do_request(struct ata_channel *channel, int masked_irq)
 {
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
-	struct ata_device *drive;
-	ide_startstop_t	startstop;
-	struct request	*rq;
-
+	ide_hwgroup_t *hwgroup = channel->hwgroup;
 	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 
 	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
-		drive = choose_drive(hwgroup->drive);
+		struct ata_channel *ch;
+		ide_startstop_t	startstop;
+		struct ata_device *drive = choose_urgent_device(channel);
 
 		if (drive == NULL) {
 			unsigned long sleep = 0;
 
 			hwgroup->rq = NULL;
-
-			drive = hwgroup->drive;
-			do {
-				if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
-					sleep = drive->PADAM_sleep;
-
-				drive = drive->next;
-			} while (drive!= hwgroup->drive);
+			sleep = longest_sleep(channel);
 
 			if (sleep) {
+
 				/*
-				 * Take a short snooze, and then wake up this
-				 * hwgroup again.  This gives other hwgroups on
-				 * the same a chance to play fairly with us,
-				 * just in case there are big differences in
+				 * Take a short snooze, and then wake up again.
+				 * Just in case there are big differences in
 				 * relative throughputs.. don't want to hog the
 				 * cpu too much.
 				 */
+
 				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
 					sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
@@ -1293,29 +1345,35 @@
 				ide_release_lock(&irq_lock);/* for atari only */
 				clear_bit(IDE_BUSY, &hwgroup->flags);
 			}
-			return;		/* no more work for this hwgroup (for now) */
+
+			return;
 		}
 		ch = drive->channel;
 
-		if (hwgroup->drive->channel->sharing_irq && ch != hwgroup->drive->channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
+		if (hwgroup->XXX_drive->channel->sharing_irq && ch != hwgroup->XXX_drive->channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
 			/* set nIEN for previous channel */
+			/* FIXME: check this! It appears to act on the current channel! */
 
 			if (ch->intrproc)
 				ch->intrproc(drive);
 			else
 				OUT_BYTE((drive)->ctl|2, ch->io_ports[IDE_CONTROL_OFFSET]);
 		}
-		hwgroup->drive = drive;
+
+		/* Remember the last drive we where acting on.
+		 */
+		hwgroup->XXX_drive = drive;
+
+		/* Reset wait timeout.
+		 */
 		drive->PADAM_sleep = 0;
-		drive->PADAM_service_start = jiffies;
 
 		if (blk_queue_plugged(&drive->queue))
 			BUG();
 
-		/*
-		 * just continuing an interrupted request maybe
+		/* Just continuing an interrupted request maybe.
 		 */
-		rq = hwgroup->rq = elv_next_request(&drive->queue);
+		hwgroup->rq = elv_next_request(&drive->queue);
 
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while the
@@ -1331,7 +1389,7 @@
 			disable_irq_nosync(ch->irq);
 		spin_unlock(&ide_lock);
 		ide__sti();	/* allow other IRQs while we start this request */
-		startstop = start_request(drive, rq);
+		startstop = start_request(drive, hwgroup->rq);
 		spin_lock_irq(&ide_lock);
 		if (masked_irq && ch->irq != masked_irq)
 			enable_irq(ch->irq);
@@ -1432,7 +1490,7 @@
 		if (test_and_clear_bit(IDE_SLEEP, &hwgroup->flags))
 			clear_bit(IDE_BUSY, &hwgroup->flags);
 	} else {
-		struct ata_device *drive = hwgroup->drive;
+		struct ata_device *drive = hwgroup->XXX_drive;
 		if (!drive) {
 			printk("ide_timer_expiry: hwgroup->drive was NULL\n");
 			hwgroup->handler = NULL;
@@ -1483,7 +1541,6 @@
 					startstop = ide_error(drive, "irq timeout", GET_STAT());
 			}
 			set_recovery_timer(ch);
-			drive->PADAM_service_time = jiffies - drive->PADAM_service_start;
 			enable_irq(ch->irq);
 			spin_lock_irq(&ide_lock);
 			if (startstop == ide_stopped)
@@ -1491,7 +1548,7 @@
 		}
 	}
 
-	ide_do_request(hwgroup->drive->channel, 0);
+	ide_do_request(hwgroup->XXX_drive->channel, 0);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
@@ -1525,15 +1582,15 @@
 
 	for (i = 0; i < MAX_HWIFS; ++i) {
 		u8 stat;
-		struct ata_channel *tmp = &ide_hwifs[i];
+		struct ata_channel *ch = &ide_hwifs[i];
 
-		if (!tmp->present)
+		if (!ch->present)
 			continue;
 
-		if (tmp->irq != irq)
+		if (ch->irq != irq)
 			continue;
 
-		stat = IN_BYTE(tmp->io_ports[IDE_STATUS_OFFSET]);
+		stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
 		if (!OK_STAT(stat, READY_STAT, BAD_STAT)) {
 			/* Try to not flood the console with msgs */
 			static unsigned long last_msgtime;
@@ -1543,7 +1600,7 @@
 			if (time_after(jiffies, last_msgtime + HZ)) {
 				last_msgtime = jiffies;
 				printk("%s: unexpected interrupt, status=0x%02x, count=%d\n",
-						tmp->name, stat, count);
+						ch->name, stat, count);
 			}
 		}
 	}
@@ -1601,14 +1658,7 @@
 		}
 		goto out_lock;
 	}
-	drive = hwgroup->drive;
-	if (!drive) {
-		/*
-		 * This should NEVER happen, and there isn't much we could do
-		 * about it here.
-		 */
-		goto out_lock;
-	}
+	drive = hwgroup->XXX_drive;
 	if (!drive_is_ready(drive)) {
 		/*
 		 * This happens regularly when we share a PCI IRQ with another device.
@@ -1640,7 +1690,6 @@
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
 	set_recovery_timer(drive->channel);
-	drive->PADAM_service_time = jiffies - drive->PADAM_service_start;
 	if (startstop == ide_stopped) {
 		if (hwgroup->handler == NULL) {	/* paranoia */
 			clear_bit(IDE_BUSY, &hwgroup->flags);
@@ -1668,7 +1717,7 @@
 		if (hwif->present && major == hwif->major) {
 			int unit = DEVICE_NR(i_rdev);
 			if (unit < MAX_DRIVES) {
-				ide_drive_t *drive = &hwif->drives[unit];
+				struct ata_device *drive = &hwif->drives[unit];
 				if (drive->present)
 					return drive;
 			}
@@ -1800,46 +1849,44 @@
  */
 void revalidate_drives(void)
 {
-	struct ata_channel *hwif;
-	ide_drive_t *drive;
-	int h;
+	int i;
 
-	for (h = 0; h < MAX_HWIFS; ++h) {
+	for (i = 0; i < MAX_HWIFS; ++i) {
 		int unit;
-		hwif = &ide_hwifs[h];
+		struct ata_channel *ch = &ide_hwifs[i];
+
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			drive = &ide_hwifs[h].drives[unit];
+			struct ata_device *drive = &ch->drives[unit];
+
 			if (drive->revalidate) {
 				drive->revalidate = 0;
 				if (!initializing)
-					ide_revalidate_disk(mk_kdev(hwif->major, unit<<PARTN_BITS));
+					ide_revalidate_disk(mk_kdev(ch->major, unit<<PARTN_BITS));
 			}
 		}
 	}
 }
 
-static void ide_probe_module(void)
-{
-	ideprobe_init();
-	revalidate_drives();
-}
-
 static void ide_driver_module (void)
 {
-	int index;
+	int i;
+
+	/* Don't reinit the probe if there is already one channel detected. */
 
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (ide_hwifs[index].present)
-			goto search;
-	ide_probe_module();
-search:
+	for (i = 0; i < MAX_HWIFS; ++i) {
+		if (ide_hwifs[i].present)
+			goto revalidate;
+	}
 
+	ideprobe_init();
+
+revalidate:
 	revalidate_drives();
 }
 
 static int ide_open(struct inode * inode, struct file * filp)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 
 	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
 		return -ENXIO;
@@ -1901,7 +1948,7 @@
  */
 static int ide_release(struct inode * inode, struct file * file)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 
 	if (!(drive = get_info_ptr(inode->i_rdev)))
 		return 0;
@@ -1977,7 +2024,7 @@
 void ide_unregister(struct ata_channel *ch)
 {
 	struct gendisk *gd;
-	ide_drive_t *drive, *d;
+	struct ata_device *d;
 	ide_hwgroup_t *hwgroup;
 	int unit, i;
 	unsigned long flags;
@@ -1986,15 +2033,20 @@
 	int n = 0;
 
 	spin_lock_irqsave(&ide_lock, flags);
+
 	if (!ch->present)
 		goto abort;
+
 	put_device(&ch->dev);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &ch->drives[unit];
+		struct ata_device * drive = &ch->drives[unit];
+
 		if (!drive->present)
 			continue;
+
 		if (drive->busy || drive->usage)
 			goto abort;
+
 		if (ata_ops(drive)) {
 			if (ata_ops(drive)->cleanup) {
 				if (ata_ops(drive)->cleanup(drive))
@@ -2010,9 +2062,11 @@
 	 */
 	spin_unlock_irqrestore(&ide_lock, flags);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &ch->drives[unit];
+		struct ata_device * drive = &ch->drives[unit];
+
 		if (!drive->present)
 			continue;
+
 		minor = drive->select.b.unit << PARTN_BITS;
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
@@ -2029,25 +2083,24 @@
 	hwif_unregister(ch);
 
 	/*
-	 * Remove us from the hwgroup, and free the hwgroup if we were the only
-	 * member.
+	 * Remove us from the hwgroup
 	 */
 
 	hwgroup = ch->hwgroup;
-	d = hwgroup->drive;
+	d = hwgroup->XXX_drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
-		drive = &ch->drives[i];
+		struct ata_device *drive = &ch->drives[i];
+
 		if (drive->de) {
 			devfs_unregister (drive->de);
 			drive->de = NULL;
 		}
 		if (!drive->present)
 			continue;
-		while (hwgroup->drive->next != drive)
-			hwgroup->drive = hwgroup->drive->next;
-		hwgroup->drive->next = drive->next;
-		if (hwgroup->drive == drive)
-			hwgroup->drive = NULL;
+
+		if (hwgroup->XXX_drive == drive)
+			hwgroup->XXX_drive = NULL;
+
 		if (drive->id != NULL) {
 			kfree(drive->id);
 			drive->id = NULL;
@@ -2056,8 +2109,10 @@
 		blk_cleanup_queue(&drive->queue);
 	}
 	if (d->present)
-		hwgroup->drive = d;
+		hwgroup->XXX_drive = d;
 
+	/* Free the hwgroup if we were the only member.
+	 */
 	n = 0;
 	for (i = 0; i < MAX_HWIFS; ++i) {
 		struct ata_channel *tmp = &ide_hwifs[i];
@@ -2215,10 +2270,12 @@
 	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
-		ide_probe_module();
+		ideprobe_init();
+		revalidate_drives();
 #ifdef CONFIG_PROC_FS
 		create_proc_ide_interfaces();
 #endif
+		/* FIXME: Do we really have to call it second time here?! */
 		ide_driver_module();
 	}
 
@@ -3121,25 +3178,29 @@
 }
 
 /*
- * Lookup IDE devices, which requested a particular driver
+ * Lookup ATA devices, which requested a particular driver.
  */
 ide_drive_t *ide_scan_devices(byte type, const char *name, struct ata_operations *driver, int n)
 {
 	unsigned int unit, index, i;
 
 	for (index = 0, i = 0; index < MAX_HWIFS; ++index) {
-		struct ata_channel *hwif = &ide_hwifs[index];
-		if (!hwif->present)
+		struct ata_channel *ch = &ide_hwifs[index];
+
+		if (!ch->present)
 			continue;
+
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			ide_drive_t *drive = &hwif->drives[unit];
+			struct ata_device *drive = &ch->drives[unit];
 			char *req = drive->driver_req;
+
 			if (*req && !strstr(name, req))
 				continue;
 			if (drive->present && drive->type == type && drive->driver == driver && ++i > n)
 				return drive;
 		}
 	}
+
 	return NULL;
 }
 
@@ -3179,9 +3240,21 @@
 			drive->channel->udma(ide_dma_off_quietly, drive, NULL);
 			drive->channel->udma(ide_dma_check, drive, NULL);
 		}
-		/* Only CD-ROMs and tape drives support DSC overlap. */
-		drive->dsc_overlap = (drive->next != drive
-				&& (drive->type == ATA_ROM || drive->type == ATA_TAPE));
+
+		/* Only CD-ROMs and tape drives support DSC overlap.  But only
+		 * if they are alone on a channel. */
+		if (drive->type == ATA_ROM || drive->type == ATA_TAPE) {
+			int single = 0;
+			int unit;
+
+			for (unit = 0; unit < MAX_DRIVES; ++unit)
+				if (drive->channel->drives[unit].present)
+					++single;
+
+			drive->dsc_overlap = (single == 1);
+		} else
+			drive->dsc_overlap = 0;
+
 	}
 	drive->revalidate = 1;
 	drive->suspend_reset = 0;
@@ -3319,9 +3392,7 @@
 
 static int ide_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
 {
-	struct ata_channel *hwif;
-	ide_drive_t *drive;
-	int i, unit;
+	int i;
 
 	switch (event) {
 		case SYS_HALT:
@@ -3335,12 +3406,15 @@
 	printk("flushing ide devices: ");
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		hwif = &ide_hwifs[i];
-		if (!hwif->present)
+		int unit;
+		struct ata_channel *ch = &ide_hwifs[i];
+
+		if (!ch->present)
 			continue;
 
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			drive = &hwif->drives[unit];
+			struct ata_device *drive = &ch->drives[unit];
+
 			if (!drive->present)
 				continue;
 
diff -urN linux-2.5.11/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.11/drivers/ide/ide-probe.c	2002-04-29 05:11:17.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-04-30 03:30:13.000000000 +0200
@@ -438,10 +438,11 @@
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
  */
-static void probe_hwif(struct ata_channel *ch)
+static void channel_probe(struct ata_channel *ch)
 {
 	unsigned int unit;
 	unsigned long flags;
+	int error;
 
 	if (ch->noprobe)
 		return;
@@ -454,96 +455,97 @@
 	/*
 	 * Check for the presence of a channel by probing for drives on it.
 	 */
-
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		struct ata_device *drive = &ch->drives[unit];
 
 		probe_for_drive(drive);
 
-		if (drive->present && !ch->present) {
+		/* drive found, there is a channel it is attached too. */
+		if (drive->present)
 			ch->present = 1;
-		}
 	}
 
-	if (ch->present) {
-		int error = 0;
+	if (!ch->present)
+		goto not_found;
 
-		if (((unsigned long)ch->io_ports[IDE_DATA_OFFSET] | 7) ==
-				((unsigned long)ch->io_ports[IDE_STATUS_OFFSET])) {
-			error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 8, ch->name);
-			ch->straight8 = 1;
-		} else {
-			if (ch->io_ports[IDE_DATA_OFFSET])
-				error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_ERROR_OFFSET])
-				error += !request_region(ch->io_ports[IDE_ERROR_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_NSECTOR_OFFSET])
-				error += !request_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_SECTOR_OFFSET])
-				error += !request_region(ch->io_ports[IDE_SECTOR_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_LCYL_OFFSET])
-				error += !request_region(ch->io_ports[IDE_LCYL_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_HCYL_OFFSET])
-				error += !request_region(ch->io_ports[IDE_HCYL_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_SELECT_OFFSET])
-				error += !request_region(ch->io_ports[IDE_SELECT_OFFSET], 1, ch->name);
-			if (ch->io_ports[IDE_STATUS_OFFSET])
-				error += !request_region(ch->io_ports[IDE_STATUS_OFFSET], 1, ch->name);
+	error = 0;
 
-		}
-		if (ch->io_ports[IDE_CONTROL_OFFSET])
-			error += !request_region(ch->io_ports[IDE_CONTROL_OFFSET], 1, ch->name);
+	if (((unsigned long)ch->io_ports[IDE_DATA_OFFSET] | 7) ==
+			((unsigned long)ch->io_ports[IDE_STATUS_OFFSET])) {
+		error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 8, ch->name);
+		ch->straight8 = 1;
+	} else {
+		if (ch->io_ports[IDE_DATA_OFFSET])
+			error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_ERROR_OFFSET])
+			error += !request_region(ch->io_ports[IDE_ERROR_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_NSECTOR_OFFSET])
+			error += !request_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_SECTOR_OFFSET])
+			error += !request_region(ch->io_ports[IDE_SECTOR_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_LCYL_OFFSET])
+			error += !request_region(ch->io_ports[IDE_LCYL_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_HCYL_OFFSET])
+			error += !request_region(ch->io_ports[IDE_HCYL_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_SELECT_OFFSET])
+			error += !request_region(ch->io_ports[IDE_SELECT_OFFSET], 1, ch->name);
+		if (ch->io_ports[IDE_STATUS_OFFSET])
+			error += !request_region(ch->io_ports[IDE_STATUS_OFFSET], 1, ch->name);
+
+	}
+	if (ch->io_ports[IDE_CONTROL_OFFSET])
+		error += !request_region(ch->io_ports[IDE_CONTROL_OFFSET], 1, ch->name);
 #if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-		if (ch->io_ports[IDE_IRQ_OFFSET])
-			error += !request_region(ch->io_ports[IDE_IRQ_OFFSET], 1, ch->name);
+	if (ch->io_ports[IDE_IRQ_OFFSET])
+		error += !request_region(ch->io_ports[IDE_IRQ_OFFSET], 1, ch->name);
 #endif
 
-		/* Some neccessary register area was already used. Skip this
-		 * device.
-		 */
-		if (
+	/* Some neccessary register area was already used. Skip this device.
+	 */
+
+	if (
 #if CONFIG_BLK_DEV_PDC4030
-				(ch->chipset != ide_pdc4030 || ch->unit == 0) &&
+			(ch->chipset != ide_pdc4030 || ch->unit == 0) &&
 #endif
-				error) {
-			/* FIXME: We should be dealing properly with partial IO
-			 * region allocations here.
-			 */
-			ch->present = 0;
-			printk("%s: error: ports already in use!\n", ch->name);
+			error) {
 
-		}
+		/* FIXME: We should be dealing properly with partial IO region
+		 * allocations here.
+		 */
+
+		ch->present = 0;
+		printk("%s: error: ports already in use!\n", ch->name);
 	}
 
-	if (ch->present) {
-		/* Register this hardware interface within the global device tree.
-		 */
-		sprintf(ch->dev.bus_id, "%04x", ch->io_ports[IDE_DATA_OFFSET]);
-		sprintf(ch->dev.name, "ide");
-		ch->dev.driver_data = ch;
+	if (!ch->present)
+		goto not_found;
+
+	/* Register this hardware interface within the global device tree.
+	 */
+	sprintf(ch->dev.bus_id, "%04x", ch->io_ports[IDE_DATA_OFFSET]);
+	sprintf(ch->dev.name, "ide");
+	ch->dev.driver_data = ch;
 #ifdef CONFIG_BLK_DEV_IDEPCI
-		if (ch->pci_dev)
-			ch->dev.parent = &ch->pci_dev->dev;
-		else
+	if (ch->pci_dev)
+		ch->dev.parent = &ch->pci_dev->dev;
+	else
 #endif
-			ch->dev.parent = NULL; /* Would like to do = &device_legacy */
+		ch->dev.parent = NULL; /* Would like to do = &device_legacy */
 
-		device_register(&ch->dev);
+	device_register(&ch->dev);
 
-		if (ch->io_ports[IDE_CONTROL_OFFSET] && ch->reset) {
-			unsigned long timeout = jiffies + WAIT_WORSTCASE;
-			byte stat;
-
-			printk("%s: reset\n", ch->name);
-			OUT_BYTE(12, ch->io_ports[IDE_CONTROL_OFFSET]);
-			udelay(10);
-			OUT_BYTE(8, ch->io_ports[IDE_CONTROL_OFFSET]);
-			do {
-				ide_delay_50ms();
-				stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
-			} while ((stat & BUSY_STAT) && 0 < (signed long)(timeout - jiffies));
-
-		}
+	if (ch->io_ports[IDE_CONTROL_OFFSET] && ch->reset) {
+		unsigned long timeout = jiffies + WAIT_WORSTCASE;
+		byte stat;
+
+		printk("%s: reset\n", ch->name);
+		OUT_BYTE(12, ch->io_ports[IDE_CONTROL_OFFSET]);
+		udelay(10);
+		OUT_BYTE(8, ch->io_ports[IDE_CONTROL_OFFSET]);
+		do {
+			ide_delay_50ms();
+			stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
+		} while ((stat & BUSY_STAT) && 0 < (signed long)(timeout - jiffies));
 	}
 
 	__restore_flags(flags);	/* local CPU only */
@@ -551,16 +553,19 @@
 	/*
 	 * Now setup the PIO transfer modes of the drives on this channel.
 	 */
-	if (ch->present) {
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *drive = &ch->drives[unit];
-
-			if (drive->present && (drive->autotune == 1)) {
-				if (drive->channel->tuneproc)
-					drive->channel->tuneproc(drive, 255);	/* auto-tune PIO mode */
-			}
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		struct ata_device *drive = &ch->drives[unit];
+
+		if (drive->present && (drive->autotune == 1)) {
+			if (drive->channel->tuneproc)
+				drive->channel->tuneproc(drive, 255);	/* auto-tune PIO mode */
 		}
 	}
+
+	return;
+
+not_found:
+	__restore_flags(flags);
 }
 
 /*
@@ -682,12 +687,7 @@
 			spin_unlock_irqrestore(&ide_lock, flags);
 			return 1;
 		}
-		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
-		hwgroup->rq       = NULL;
-		hwgroup->handler  = NULL;
-		hwgroup->drive    = NULL;
-		hwgroup->flags	  = 0;
-
+		memset(hwgroup, 0, sizeof(*hwgroup));
 		init_timer(&hwgroup->timer);
 		hwgroup->timer.function = &ide_timer_expiry;
 		hwgroup->timer.data = (unsigned long) hwgroup;
@@ -716,21 +716,17 @@
 	}
 
 	/*
-	 * Everything is okay.
+	 * Everything is okay. Tag us as member of this hardware group.
 	 */
 	ch->hwgroup = hwgroup;
-
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_device *drive = &ch->drives[i];
 
 		if (!drive->present)
 			continue;
 
-		if (!hwgroup->drive)
-			hwgroup->drive = drive;
-
-		drive->next = hwgroup->drive->next;
-		hwgroup->drive->next = drive;
+		if (!hwgroup->XXX_drive)
+			hwgroup->XXX_drive = drive;
 
 		init_device_queue(drive);
 	}
@@ -833,58 +829,65 @@
 	return;
 }
 
-static int hwif_init(struct ata_channel *hwif)
+static void channel_init(struct ata_channel *ch)
 {
-	if (!hwif->present)
-		return 0;
-	if (!hwif->irq) {
-		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
-		{
-			printk("%s: DISABLED, NO IRQ\n", hwif->name);
-			return (hwif->present = 0);
+	if (!ch->present)
+		return;
+
+	/* we set it back to 1 if all is ok below */
+	ch->present = 0;
+
+	if (!ch->irq) {
+		if (!(ch->irq = ide_default_irq(ch->io_ports[IDE_DATA_OFFSET]))) {
+			printk("%s: DISABLED, NO IRQ\n", ch->name);
+
+			return;
 		}
 	}
 #ifdef CONFIG_BLK_DEV_HD
-	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
-		printk("%s: CANNOT SHARE IRQ WITH OLD HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return (hwif->present = 0);
+	if (ch->irq == HD_IRQ && ch->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
+		printk("%s: CANNOT SHARE IRQ WITH OLD HARDDISK DRIVER (hd.c)\n", ch->name);
+
+		return;
 	}
 #endif
 
-	hwif->present = 0; /* we set it back to 1 if all is ok below */
+	if (devfs_register_blkdev (ch->major, ch->name, ide_fops)) {
+		printk("%s: UNABLE TO GET MAJOR NUMBER %d\n", ch->name, ch->major);
 
-	if (devfs_register_blkdev (hwif->major, hwif->name, ide_fops)) {
-		printk("%s: UNABLE TO GET MAJOR NUMBER %d\n", hwif->name, hwif->major);
-		return (hwif->present = 0);
+		return;
 	}
 
-	if (init_irq(hwif)) {
-		int i = hwif->irq;
+	if (init_irq(ch)) {
+		int irq = ch->irq;
 		/*
-		 *	It failed to initialise. Find the default IRQ for 
-		 *	this port and try that.
+		 * It failed to initialise. Find the default IRQ for
+		 * this port and try that.
 		 */
-		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET]))) {
-			printk("%s: Disabled unable to get IRQ %d.\n", hwif->name, i);
-			(void) unregister_blkdev (hwif->major, hwif->name);
-			return (hwif->present = 0);
+		if (!(ch->irq = ide_default_irq(ch->io_ports[IDE_DATA_OFFSET]))) {
+			printk(KERN_INFO "%s: disabled; unable to get IRQ %d.\n", ch->name, irq);
+			(void) unregister_blkdev (ch->major, ch->name);
+
+			return;
 		}
-		if (init_irq(hwif)) {
-			printk("%s: probed IRQ %d and default IRQ %d failed.\n",
-				hwif->name, i, hwif->irq);
-			(void) unregister_blkdev (hwif->major, hwif->name);
-			return (hwif->present = 0);
+		if (init_irq(ch)) {
+			printk(KERN_INFO "%s: probed IRQ %d and default IRQ %d failed.\n",
+				ch->name, irq, ch->irq);
+			(void) unregister_blkdev(ch->major, ch->name);
+
+			return;
 		}
-		printk("%s: probed IRQ %d failed, using default.\n",
-			hwif->name, hwif->irq);
+		printk(KERN_INFO "%s: probed IRQ %d failed, using default.\n", ch->name, ch->irq);
 	}
 
-	init_gendisk(hwif);
-	blk_dev[hwif->major].data = hwif;
-	blk_dev[hwif->major].queue = ide_get_queue;
-	hwif->present = 1;	/* success */
+	init_gendisk(ch);
+	blk_dev[ch->major].data = ch;
+	blk_dev[ch->major].queue = ide_get_queue;
 
-	return hwif->present;
+	/* all went well, flag this channel entry as valid */
+	ch->present = 1;
+
+	return;
 }
 
 int ideprobe_init (void)
@@ -901,9 +904,9 @@
 	 */
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
-			probe_hwif(&ide_hwifs[index]);
+			channel_probe(&ide_hwifs[index]);
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
-			hwif_init(&ide_hwifs[index]);
+			channel_init(&ide_hwifs[index]);
 	return 0;
 }
diff -urN linux-2.5.11/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.11/include/linux/ide.h	2002-04-30 03:48:19.000000000 +0200
+++ linux/include/linux/ide.h	2002-04-30 03:30:21.000000000 +0200
@@ -283,16 +283,10 @@
 	 */
 	request_queue_t	queue;	/* per device request queue */
 
-	struct ata_device	*next;	/* circular list of hwgroup drives */
-
 	/* Those are directly injected jiffie values. They should go away and
 	 * we should use generic timers instead!!!
 	 */
-
-	unsigned long PADAM_sleep;		/* sleep until this time */
-	unsigned long PADAM_service_start;	/* time we started last request */
-	unsigned long PADAM_service_time;	/* service time of last request */
-	unsigned long PADAM_timeout;		/* max time to wait for irq */
+	unsigned long PADAM_sleep;	/* sleep until this time */
 
 	/* Flags requesting/indicating one of the following special commands
 	 * executed on the request queue.
@@ -512,7 +506,7 @@
 typedef struct hwgroup_s {
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long flags;		/* BUSY, SLEEPING */
-	struct ata_device *drive;	/* current drive */
+	struct ata_device *XXX_drive;	/* current drive */
 	struct request *rq;		/* current request */
 	struct timer_list timer;	/* failsafe timer */
 	unsigned long poll_timeout;	/* timeout value during long polls */

--------------020904000009040301060408--

