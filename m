Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315612AbSENL3k>; Tue, 14 May 2002 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315613AbSENL3j>; Tue, 14 May 2002 07:29:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28427 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315612AbSENL3T>; Tue, 14 May 2002 07:29:19 -0400
Message-ID: <3CE0E643.4000902@evision-ventures.com>
Date: Tue, 14 May 2002 12:26:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 62a
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050205050703000007090404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050205050703000007090404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon May 13 15:20:18 CEST 2002 ide-clean-62a

62 was crap. This applies on top of 61.

- Streamline device detection reporting to always use ->slot_name.

- Apply 64 bit sector size fixes to the overall code.

- Push ->handler down to the struct ata_channel.

- Introduce channel group based locking instead of a single global lock for all
   operations. There are still some places where we have preserved the ide_lock.
   We can't lock for queues during device probe and we protect global data
   structures during device registration and unregistration in ide.c with it.

- Start replacement of serialized access to the registers of
   channels which share them with proper host chip driver specific locking.
   This affects the following host chip drivers:

   cmd640.c, rz1000, ... ?

   Seems some are setting the serialize flag just in case. So better let's do it
   gradually over time.

   Well, I still have to think whatever we really need to put channels sharing
   an IRQ line in the same locking group.

   From now on the sick concept of a hw group is gone now. We have full blown
   per channel request queues! Hopefully I will be able soon to get my hands on
   a dual Athlon machine to check how this all behaves on a multi SMP machine.

- Move the whole SUPPORT_VLB_SYNC stuff to the only place where it is used: the
   pdc4030 host chip driver.  Eliminate it from the global driver part.

- Eliminate pseudo portability macros from pdc4030. This is a host chip firmly
   based on VLB.

--------------050205050703000007090404
Content-Type: text/plain;
 name="ide-clean-62a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-62a.diff"

diff -urN linux-2.5.15/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.15/drivers/ide/cmd640.c	2002-05-10 00:24:11.000000000 +0200
+++ linux/drivers/ide/cmd640.c	2002-05-13 23:53:42.000000000 +0200
@@ -155,7 +155,7 @@
 #define	CMDTIM		0x52
 #define	ARTTIM0		0x53
 #define	DRWTIM0		0x54
-#define ARTTIM1 	0x55
+#define ARTTIM1		0x55
 #define DRWTIM1		0x56
 #define ARTTIM23	0x57
 #define   ARTTIM23_DIS_RA2	0x04
@@ -166,36 +166,42 @@
 /*
  * Registers and masks for easy access by drive index:
  */
-static byte prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
-static byte prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
+static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
+static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
 
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 
-static byte arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
-static byte drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
+/*
+ * Protects register file access from overlapping on primary and secondary
+ * channel, since those share hardware resources.
+ */
+static spinlock_t cmd640_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+
+static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
+static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
 
 /*
  * Current cmd640 timing values for each drive.
  * The defaults for each are the slowest possible timings.
  */
-static byte setup_counts[4]    = {4, 4, 4, 4};     /* Address setup count (in clocks) */
-static byte active_counts[4]   = {16, 16, 16, 16}; /* Active count   (encoded) */
-static byte recovery_counts[4] = {16, 16, 16, 16}; /* Recovery count (encoded) */
+static u8 setup_counts[4]    = {4, 4, 4, 4};     /* Address setup count (in clocks) */
+static u8 active_counts[4]   = {16, 16, 16, 16}; /* Active count   (encoded) */
+static u8 recovery_counts[4] = {16, 16, 16, 16}; /* Recovery count (encoded) */
 
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 
 /*
  * These are initialized to point at the devices we control
  */
 static struct ata_channel *cmd_hwif0, *cmd_hwif1;
-static ide_drive_t *cmd_drives[4];
+static struct ata_device *cmd_drives[4];
 
 /*
  * Interface to access cmd640x registers
  */
 static unsigned int cmd640_key;
 static void (*put_cmd640_reg)(unsigned short reg, byte val);
-static byte (*get_cmd640_reg)(unsigned short reg);
+static u8 (*get_cmd640_reg)(unsigned short reg);
 
 /*
  * This is read from the CFR reg, and is used in several places.
@@ -221,9 +227,9 @@
 	restore_flags(flags);
 }
 
-static byte get_cmd640_reg_pci1 (unsigned short reg)
+static u8 get_cmd640_reg_pci1 (unsigned short reg)
 {
-	byte b;
+	u8 b;
 	unsigned long flags;
 
 	save_flags(flags);
@@ -236,7 +242,7 @@
 
 /* PCI method 2 access (from CMD datasheet) */
 
-static void put_cmd640_reg_pci2 (unsigned short reg, byte val)
+static void put_cmd640_reg_pci2 (unsigned short reg, u8 val)
 {
 	unsigned long flags;
 
@@ -248,9 +254,9 @@
 	restore_flags(flags);
 }
 
-static byte get_cmd640_reg_pci2 (unsigned short reg)
+static u8 get_cmd640_reg_pci2 (unsigned short reg)
 {
-	byte b;
+	u8 b;
 	unsigned long flags;
 
 	save_flags(flags);
@@ -264,7 +270,7 @@
 
 /* VLB access */
 
-static void put_cmd640_reg_vlb (unsigned short reg, byte val)
+static void put_cmd640_reg_vlb (unsigned short reg, u8 val)
 {
 	unsigned long flags;
 
@@ -275,9 +281,9 @@
 	restore_flags(flags);
 }
 
-static byte get_cmd640_reg_vlb (unsigned short reg)
+static u8 get_cmd640_reg_vlb (unsigned short reg)
 {
-	byte b;
+	u8 b;
 	unsigned long flags;
 
 	save_flags(flags);
@@ -290,7 +296,7 @@
 
 static int __init match_pci_cmd640_device (void)
 {
-	const byte ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
+	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
 	unsigned int i;
 	for (i = 0; i < 4; i++) {
 		if (get_cmd640_reg(i) != ven_dev[i])
@@ -338,7 +344,7 @@
  */
 static int __init probe_for_cmd640_vlb (void)
 {
-	byte b;
+	u8 b;
 
 	get_cmd640_reg = get_cmd640_reg_vlb;
 	put_cmd640_reg = put_cmd640_reg_vlb;
@@ -404,7 +410,7 @@
 static void __init check_prefetch (unsigned int index)
 {
 	struct ata_device *drive = cmd_drives[index];
-	byte b = get_cmd640_reg(prefetch_regs[index]);
+	u8 b = get_cmd640_reg(prefetch_regs[index]);
 
 	if (b & prefetch_masks[index]) {	/* is prefetch off? */
 		drive->channel->no_unmask = 0;
@@ -450,19 +456,19 @@
  */
 static void set_prefetch_mode (unsigned int index, int mode)
 {
-	ide_drive_t *drive = cmd_drives[index];
+	struct ata_device *drive = cmd_drives[index];
 	int reg = prefetch_regs[index];
-	byte b;
+	u8 b;
 	unsigned long flags;
 
 	save_flags(flags);
 	cli();
 	b = get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
-#if CMD640_PREFETCH_MASKS
+# if CMD640_PREFETCH_MASKS
 		drive->channel->no_unmask = 1;
 		drive->channel->unmask = 0;
-#endif
+# endif
 		drive->channel->no_io_32bit = 0;
 		b &= ~prefetch_masks[index];	/* enable prefetch */
 	} else {
@@ -480,7 +486,7 @@
  */
 static void display_clocks (unsigned int index)
 {
-	byte active_count, recovery_count;
+	u8 active_count, recovery_count;
 
 	active_count = active_counts[index];
 	if (active_count == 1)
@@ -497,7 +503,7 @@
  * Pack active and recovery counts into single byte representation
  * used by controller
  */
-inline static byte pack_nibbles (byte upper, byte lower)
+static inline u8 pack_nibbles (u8 upper, u8 lower)
 {
 	return ((upper & 0x0f) << 4) | (lower & 0x0f);
 }
@@ -507,7 +513,7 @@
  */
 static void __init retrieve_drive_counts (unsigned int index)
 {
-	byte b;
+	u8 b;
 
 	/*
 	 * Get the internal setup timing, and convert to clock count
@@ -537,9 +543,9 @@
 static void program_drive_counts (unsigned int index)
 {
 	unsigned long flags;
-	byte setup_count    = setup_counts[index];
-	byte active_count   = active_counts[index];
-	byte recovery_count = recovery_counts[index];
+	u8 setup_count    = setup_counts[index];
+	u8 active_count   = active_counts[index];
+	u8 recovery_count = recovery_counts[index];
 
 	/*
 	 * Set up address setup count and drive read/write timing registers.
@@ -589,10 +595,12 @@
 /*
  * Set a specific pio_mode for a drive
  */
-static void cmd640_set_mode (unsigned int index, byte pio_mode, unsigned int cycle_time, unsigned int active_time, unsigned int setup_time)
+static void cmd640_set_mode (unsigned int index, u8 pio_mode, unsigned int cycle_time, unsigned int active_time, unsigned int setup_time)
 {
 	int recovery_time, clock_time;
-	byte setup_count, active_count, recovery_count, recovery_count2, cycle_count;
+	u8 setup_count, active_count;
+	u8 recovery_count, recovery_count2;
+	u8 cycle_count;
 
 	recovery_time = cycle_time - (setup_time + active_time);
 	clock_time = 1000 / system_bus_speed;
@@ -639,16 +647,19 @@
 /*
  * Drive PIO mode selection:
  */
-static void cmd640_tune_drive (ide_drive_t *drive, byte mode_wanted)
+static void cmd640_tune_drive(struct ata_device *drive, byte mode_wanted)
 {
-	byte b;
+	u8 b;
 	struct ata_timing *t;
 	unsigned int index = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmd640_lock, flags);
 
 	while (drive != cmd_drives[index]) {
 		if (++index > 3) {
-			printk("%s: bad news in cmd640_tune_drive\n", drive->name);
-			return;
+			printk(KERN_ERR "%s: bad news in cmd640_tune_drive\n", drive->name);
+			goto out_lock;
 		}
 	}
 	switch (mode_wanted) {
@@ -659,21 +670,21 @@
 			if (mode_wanted)
 				b |= 0x27;
 			put_cmd640_reg(CNTRL, b);
-			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, mode_wanted ? "en" : "dis");
-			return;
+			printk(KERN_INFO "%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, mode_wanted ? "en" : "dis");
+			goto out_lock;
 
 		case 8: /* set prefetch off */
 		case 9: /* set prefetch on */
 			mode_wanted &= 1;
 			set_prefetch_mode(index, mode_wanted);
 			printk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
-			return;
+			goto out_lock;
 	}
 
 	if (mode_wanted == 255)
 		t = ata_timing_data(ata_timing_mode(drive, XFER_PIO | XFER_EPIO));
 	else
-		t = ata_timing_data(XFER_PIO_0 + min_t(byte, mode_wanted, 4));
+		t = ata_timing_data(XFER_PIO_0 + min_t(u8, mode_wanted, 4));
 
 	cmd640_set_mode(index, t->mode - XFER_PIO_0, t->cycle, t->active, t->setup);
 
@@ -681,10 +692,14 @@
 		drive->name, t->mode, t->cycle);
 
 	display_clocks(index);
+
+out_lock:
+	spin_unlock_irqrestore(&cmd640_lock, flags);
+
 	return;
 }
 
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
@@ -697,7 +712,7 @@
 	int second_port_cmd640 = 0;
 	const char *bus_type, *port2;
 	unsigned int index;
-	byte b, cfr;
+	u8 b, cfr;
 
 	if (cmd640_vlb && probe_for_cmd640_vlb()) {
 		bus_type = "VLB";
@@ -743,7 +758,7 @@
 	cmd_hwif0->chipset = ide_cmd640;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	cmd_hwif0->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 
 	/*
 	 * Ensure compatibility by always using the slowest timings
@@ -777,7 +792,7 @@
 				second_port_cmd640 = 1;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 				second_port_toggled = 1;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 				port2 = "enabled";
 			} else {
 				put_cmd640_reg(CNTRL, b); /* restore original setting */
@@ -796,7 +811,7 @@
 		cmd_hwif1->unit = ATA_SECONDARY;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		cmd_hwif1->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 	}
 	printk("%s: %sserialized, secondary interface %s\n", cmd_hwif1->name,
 		cmd_hwif0->serialized ? "" : "not ", port2);
@@ -806,7 +821,7 @@
 	 * Do not unnecessarily disturb any prior BIOS setup of these.
 	 */
 	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
-		ide_drive_t *drive = cmd_drives[index];
+		struct ata_device *drive = cmd_drives[index];
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		if (drive->autotune || ((index > 1) && second_port_toggled)) {
 			/*
@@ -837,7 +852,7 @@
 		check_prefetch (index);
 		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
 			index, drive->channel->no_io_32bit ? "off" : "on");
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+#endif
 	}
 
 #ifdef CMD640_DUMP_REGS
diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-14 00:50:24.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-14 00:31:15.000000000 +0200
@@ -290,7 +290,7 @@
 	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(drive->channel->lock, flags);
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
@@ -322,7 +322,8 @@
 		ret = 0;
 	}
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
 	return ret;
 }
 
@@ -338,18 +339,19 @@
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	if (hwgroup->handler != NULL) {
+	spin_lock_irqsave(ch->lock, flags);
+
+	if (ch->handler != NULL) {
 		printk("%s: ide_set_handler: handler not null; old=%p, new=%p, from %p\n",
-			drive->name, hwgroup->handler, handler, __builtin_return_address(0));
+			drive->name, ch->handler, handler, __builtin_return_address(0));
 	}
-	hwgroup->handler = handler;
+	ch->handler = handler;
 	ch->expiry = expiry;
 	ch->timer.expires = jiffies + timeout;
 	add_timer(&ch->timer);
-	spin_unlock_irqrestore(&ide_lock, flags);
+
+	spin_unlock_irqrestore(ch->lock, flags);
 }
 
 static void check_crc_errors(struct ata_device *drive)
@@ -1067,20 +1069,21 @@
 ide_startstop_t restart_request(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	hwgroup->handler = NULL;
+	spin_lock_irqsave(ch->lock, flags);
+
+	ch->handler = NULL;
 	del_timer(&ch->timer);
-	spin_unlock_irqrestore(&ide_lock, flags);
+
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	return start_request(drive, drive->rq);
 }
 
 /*
- * This is used by a drive to give excess bandwidth back to the hwgroup by
- * sleeping for timeout jiffies.
+ * This is used by a drive to give excess bandwidth back by sleeping for
+ * timeout jiffies.
  */
 void ide_stall_queue(struct ata_device *drive, unsigned long timeout)
 {
@@ -1096,77 +1099,57 @@
 static unsigned long longest_sleep(struct ata_channel *channel)
 {
 	unsigned long sleep = 0;
-	int i;
-
-	for (i = 0; i < MAX_HWIFS; ++i) {
-		int unit;
-		struct ata_channel *ch = &ide_hwifs[i];
+	int unit;
 
-		if (!ch->present)
-			continue;
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		struct ata_device *drive = &channel->drives[unit];
 
-		if (ch->hwgroup != channel->hwgroup)
+		if (!drive->present)
 			continue;
 
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *drive = &ch->drives[unit];
-
-			if (!drive->present)
-				continue;
-
-			/* This device is sleeping and waiting to be serviced
-			 * later than any other device we checked thus far.
-			 */
-			if (drive->sleep && (!sleep || time_after(sleep, drive->sleep)))
-				sleep = drive->sleep;
-		}
+		/* This device is sleeping and waiting to be serviced
+		 * later than any other device we checked thus far.
+		 */
+		if (drive->sleep && (!sleep || time_after(sleep, drive->sleep)))
+			sleep = drive->sleep;
 	}
 
 	return sleep;
 }
 
 /*
- * Select the next device which will be serviced.
+ * Select the next device which will be serviced.  This selects onlt between
+ * devices on the same channel, since everything else will be scheduled on the
+ * queue level.
  */
 static struct ata_device *choose_urgent_device(struct ata_channel *channel)
 {
 	struct ata_device *choice = NULL;
 	unsigned long sleep = 0;
-	int i;
+	int unit;
 
-	for (i = 0; i < MAX_HWIFS; ++i) {
-		int unit;
-		struct ata_channel *ch = &ide_hwifs[i];
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		struct ata_device *drive = &channel->drives[unit];
 
-		if (!ch->present)
+		if (!drive->present)
 			continue;
 
-		if (ch->hwgroup != channel->hwgroup)
+		/* There are no request pending for this device.
+		 */
+		if (list_empty(&drive->queue.queue_head))
 			continue;
 
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			struct ata_device *drive = &ch->drives[unit];
-
-			if (!drive->present)
-				continue;
-
-			/* There are no request pending for this device.
-			 */
-			if (list_empty(&drive->queue.queue_head))
-				continue;
-
-			/* This device still wants to remain idle.
-			 */
-			if (drive->sleep && time_after(drive->sleep, jiffies))
-				continue;
+		/* This device still wants to remain idle.
+		 */
+		if (drive->sleep && time_after(drive->sleep, jiffies))
+			continue;
 
-			/* Take this device, if there is no device choosen thus far or
-			 * it's more urgent.
-			 */
-			if (!choice || (drive->sleep && (!choice->sleep || time_after(choice->sleep, drive->sleep)))) {
-				if (!blk_queue_plugged(&drive->queue))
-					choice = drive;
-			}
+		/* Take this device, if there is no device choosen thus far or
+		 * it's more urgent.
+		 */
+		if (!choice || (drive->sleep && (!choice->sleep || time_after(choice->sleep, drive->sleep)))) {
+			if (!blk_queue_plugged(&drive->queue))
+				choice = drive;
 		}
 	}
 
@@ -1274,11 +1257,13 @@
 		if (masked_irq && drive->channel->irq != masked_irq)
 			disable_irq_nosync(drive->channel->irq);
 
-		spin_unlock(&ide_lock);
+		spin_unlock(drive->channel->lock);
+
 		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 
-		spin_lock_irq(&ide_lock);
+		spin_lock_irq(drive->channel->lock);
+
 		if (masked_irq && drive->channel->irq != masked_irq)
 			enable_irq(drive->channel->irq);
 
@@ -1301,38 +1286,12 @@
 
 /*
  * Issue a new request.
- * Caller must have already done spin_lock_irqsave(&ide_lock, ...)
- *
- * A hwgroup is a serialized group of IDE interfaces.  Usually there is
- * exactly one hwif (interface) per hwgroup, but buggy controllers (eg. CMD640)
- * may have both interfaces in a single hwgroup to "serialize" access.
- * Or possibly multiple ISA interfaces can share a common IRQ by being grouped
- * together into one hwgroup for serialized access.
- *
- * Note also that several hwgroups can end up sharing a single IRQ,
- * possibly along with many other devices.  This is especially common in
- * PCI-based systems with off-board IDE controller cards.
- *
- * The IDE driver uses the queue spinlock to protect access to the request
- * queues.
- *
- * The first thread into the driver for a particular hwgroup sets the
- * hwgroup->flags IDE_BUSY flag to indicate that this hwgroup is now active,
- * and then initiates processing of the top request from the request queue.
- *
- * Other threads attempting entry notice the busy setting, and will simply
- * queue their new requests and exit immediately.  Note that hwgroup->flags
- * remains busy even when the driver is merely awaiting the next interrupt.
- * Thus, the meaning is "this hwgroup is busy processing a request".
- *
- * When processing of a request completes, the completing thread or IRQ-handler
- * will start the next request from the queue.  If no more work remains,
- * the driver will clear the hwgroup->flags IDE_BUSY flag and exit.
+ * Caller must have already done spin_lock_irqsave(channel->lock, ...)
  */
 static void ide_do_request(struct ata_channel *channel, int masked_irq)
 {
 	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
-	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
+//	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &channel->active)) {
 		struct ata_channel *ch;
@@ -1362,6 +1321,7 @@
 
 		queue_commands(drive, masked_irq);
 	}
+
 }
 
 void do_ide_request(request_queue_t *q)
@@ -1413,7 +1373,6 @@
 void ide_timer_expiry(unsigned long data)
 {
 	struct ata_channel *ch = (struct ata_channel *) data;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	ata_handler_t *handler;
 	ata_expiry_t *expiry;
 	unsigned long flags;
@@ -1424,10 +1383,11 @@
 	 * worth mentioning.
 	 */
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(ch->lock, flags);
 	del_timer(&ch->timer);
 
-	if ((handler = hwgroup->handler) == NULL) {
+	handler = ch->handler;
+	if (!handler) {
 
 		/*
 		 * Either a marginal timeout occurred (got the interrupt just
@@ -1441,31 +1401,35 @@
 	} else {
 		struct ata_device *drive = ch->drive;
 		if (!drive) {
-			printk("ide_timer_expiry: hwgroup->drive was NULL\n");
-			hwgroup->handler = NULL;
+			printk(KERN_ERR "ide_timer_expiry: IRQ handler was NULL\n");
+			ch->handler = NULL;
 		} else {
 			ide_startstop_t startstop;
 
 			/* paranoia */
 			if (!test_and_set_bit(IDE_BUSY, &ch->active))
-				printk("%s: ide_timer_expiry: hwgroup was not busy??\n", drive->name);
+				printk(KERN_ERR "%s: ide_timer_expiry: IRQ handler was not busy??\n", drive->name);
 			if ((expiry = ch->expiry) != NULL) {
 				/* continue */
 				if ((wait = expiry(drive, drive->rq)) != 0) {
 					/* reengage timer */
 					ch->timer.expires  = jiffies + wait;
 					add_timer(&ch->timer);
-					spin_unlock_irqrestore(&ide_lock, flags);
+
+					spin_unlock_irqrestore(ch->lock, flags);
+
 					return;
 				}
 			}
-			hwgroup->handler = NULL;
+			ch->handler = NULL;
 			/*
 			 * We need to simulate a real interrupt when invoking
 			 * the handler() function, which means we need to globally
 			 * mask the specific IRQ:
 			 */
-			spin_unlock(&ide_lock);
+
+			spin_unlock(ch->lock);
+
 			ch = drive->channel;
 #if DISABLE_IRQ_NOSYNC
 			disable_irq_nosync(ch->irq);
@@ -1490,7 +1454,9 @@
 			}
 			set_recovery_timer(ch);
 			enable_irq(ch->irq);
-			spin_lock_irq(&ide_lock);
+
+			spin_lock_irq(ch->lock);
+
 			if (startstop == ide_stopped)
 				clear_bit(IDE_BUSY, &ch->active);
 		}
@@ -1498,7 +1464,7 @@
 
 	ide_do_request(ch->drive->channel, 0);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(ch->lock, flags);
 }
 
 /*
@@ -1560,14 +1526,12 @@
 void ata_irq_request(int irq, void *data, struct pt_regs *regs)
 {
 	struct ata_channel *ch = data;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
-
 	unsigned long flags;
 	struct ata_device *drive;
-	ata_handler_t *handler = hwgroup->handler;
+	ata_handler_t *handler = ch->handler;
 	ide_startstop_t startstop;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(ch->lock, flags);
 
 	if (!ide_ack_intr(ch))
 		goto out_lock;
@@ -1619,16 +1583,17 @@
 	/* paranoia */
 	if (!test_and_set_bit(IDE_BUSY, &ch->active))
 		printk(KERN_ERR "%s: %s: hwgroup was not busy!?\n", drive->name, __FUNCTION__);
-	hwgroup->handler = NULL;
+	ch->handler = NULL;
 	del_timer(&ch->timer);
-	spin_unlock(&ide_lock);
+
+	spin_unlock(ch->lock);
 
 	if (ch->unmask)
 		ide__sti();	/* local CPU only */
 
 	/* service this interrupt, may set handler for next interrupt */
 	startstop = handler(drive, drive->rq);
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(ch->lock);
 
 	/*
 	 * Note that handler() may have set things up for another
@@ -1639,7 +1604,7 @@
 	 */
 	set_recovery_timer(drive->channel);
 	if (startstop == ide_stopped) {
-		if (hwgroup->handler == NULL) {	/* paranoia */
+		if (!ch->handler) {	/* paranoia */
 			clear_bit(IDE_BUSY, &ch->active);
 			ide_do_request(ch, ch->irq);
 		} else {
@@ -1649,7 +1614,7 @@
 		queue_commands(drive, ch->irq);
 
 out_lock:
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(ch->lock, flags);
 }
 
 /*
@@ -1725,7 +1690,9 @@
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
 	if (action == ide_wait)
 		rq->waiting = &wait;
-	spin_lock_irqsave(&ide_lock, flags);
+
+	spin_lock_irqsave(drive->channel->lock, flags);
+
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
 			drive->rq = NULL;
@@ -1737,7 +1704,9 @@
 	}
 	q->elevator.elevator_add_req_fn(q, rq, queue_head);
 	ide_do_request(drive->channel, 0);
-	spin_unlock_irqrestore(&ide_lock, flags);
+
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
 	if (action == ide_wait) {
 		wait_for_completion(&wait);	/* wait for it to be serviced */
 		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
@@ -1764,15 +1733,19 @@
 	if ((drive = get_info_ptr(i_rdev)) == NULL)
 		return -ENODEV;
 
+	/* FIXME: The locking here doesn't make the slightest sense! */
 	spin_lock_irqsave(&ide_lock, flags);
 
 	if (drive->busy || (drive->usage > 1)) {
+
 		spin_unlock_irqrestore(&ide_lock, flags);
+
 		return -EBUSY;
 	}
 
 	drive->busy = 1;
 	MOD_INC_USE_COUNT;
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	res = wipe_partitions(i_rdev);
@@ -1789,6 +1762,7 @@
 	drive->busy = 0;
 	wake_up(&drive->wqueue);
 	MOD_DEC_USE_COUNT;
+
 	return res;
 }
 
@@ -1912,7 +1886,7 @@
 {
 	struct gendisk *gd;
 	struct ata_device *d;
-	ide_hwgroup_t *hwgroup;
+	spinlock_t *lock;
 	int unit;
 	int i;
 	unsigned long flags;
@@ -1950,6 +1924,7 @@
 	 * All clear?  Then blow away the buffer cache
 	 */
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		struct ata_device * drive = &ch->drives[unit];
 
@@ -1964,6 +1939,7 @@
 			}
 		}
 	}
+
 	spin_lock_irqsave(&ide_lock, flags);
 
 	/*
@@ -1987,10 +1963,10 @@
 #endif
 
 	/*
-	 * Remove us from the hwgroup.
+	 * Remove us from the lock group.
 	 */
 
-	hwgroup = ch->hwgroup;
+	lock = ch->lock;
 	d = ch->drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_device *drive = &ch->drives[i];
@@ -2020,7 +1996,7 @@
 	/*
 	 * Free the irq if we were the only channel using it.
 	 *
-	 * Free the hwgroup if we were the only member.
+	 * Free the lock group if we were the only member.
 	 */
 	n_irq = n_ch = 0;
 	for (i = 0; i < MAX_HWIFS; ++i) {
@@ -2031,14 +2007,14 @@
 
 		if (tmp->irq == ch->irq)
 			++n_irq;
-		if (tmp->hwgroup == ch->hwgroup)
+		if (tmp->lock == ch->lock)
 			++n_ch;
 	}
 	if (n_irq == 1)
-		free_irq(ch->irq, ch->hwgroup);
+		free_irq(ch->irq, ch);
 	if (n_ch == 1) {
-		kfree(ch->hwgroup);
-		ch->hwgroup = NULL;
+		kfree(ch->lock);
+		ch->lock = NULL;
 	}
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
@@ -2072,7 +2048,7 @@
 
 	old = *ch;
 	init_hwif_data(ch, ch->index);
-	ch->hwgroup = old.hwgroup;
+	ch->lock = old.lock;
 	ch->tuneproc = old.tuneproc;
 	ch->speedproc = old.speedproc;
 	ch->selectproc = old.selectproc;
@@ -2218,15 +2194,18 @@
 
 	unsigned long timeout = jiffies + (10 * HZ);
 
-	spin_lock_irq(&ide_lock);
+	spin_lock_irq(drive->channel->lock);
 
 	while (test_bit(IDE_BUSY, &drive->channel->active)) {
-		spin_unlock_irq(&ide_lock);
+
+		spin_unlock_irq(drive->channel->lock);
+
 		if (time_after(jiffies, timeout)) {
 			printk("%s: channel busy\n", drive->name);
 			return -EBUSY;
 		}
-		spin_lock_irq(&ide_lock);
+
+		spin_lock_irq(drive->channel->lock);
 	}
 
 	return 0;
@@ -2260,12 +2239,6 @@
 	if (!drive->channel->tuneproc)
 		return -ENOSYS;
 
-	/* FIXME: This is very much the same kind of problem as we have with
-	 * set_mutlmode() see for a edscription there.
-	 */
-	if (HWGROUP(drive)->handler)
-		return -EBUSY;
-
 	if (drive->channel->tuneproc != NULL)
 		drive->channel->tuneproc(drive, (u8) arg);
 
@@ -2334,14 +2307,14 @@
 		case HDIO_SET_32BIT: {
 			int val;
 
-			if (arg < 0 || arg > 1 + (SUPPORT_VLB_SYNC << 1))
+			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
 			if (ide_spin_wait_hwgroup(drive))
 				return -EBUSY;
 
 			val = set_io_32bit(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -2356,7 +2329,7 @@
 				return -EBUSY;
 
 			val = set_pio_mode(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -2382,7 +2355,7 @@
 				return -EBUSY;
 
 			drive->channel->unmask = arg;
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return 0;
 		}
@@ -2406,7 +2379,7 @@
 				return -EBUSY;
 
 			val = set_using_dma(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -3455,7 +3428,7 @@
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 # if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
-		ide_get_lock(&irq_lock, NULL, NULL);/* for atari only */
+		// ide_get_lock(&irq_lock, NULL, NULL);/* for atari only */
 		disable_irq(ide_hwifs[0].irq);	/* disable_irq_nosync ?? */
 //		disable_irq_nosync(ide_hwifs[0].irq);
 	}
diff -urN linux-2.5.15/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.15/drivers/ide/ide-disk.c	2002-05-14 00:50:24.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-13 23:26:11.000000000 +0200
@@ -316,7 +316,7 @@
 		unsigned long flags;
 		int ret;
 
-		spin_lock_irqsave(&ide_lock, flags);
+		spin_lock_irqsave(drive->channel->lock, flags);
 
 		ret = blk_queue_start_tag(&drive->queue, rq);
 
@@ -325,7 +325,7 @@
 		if (ata_pending_commands(drive) > drive->max_last_depth)
 			drive->max_last_depth = ata_pending_commands(drive);
 
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(drive->channel->lock, flags);
 
 		if (ret) {
 			BUG_ON(!ata_pending_commands(drive));
@@ -438,13 +438,6 @@
 	if (!drive->id)
 		return -EIO;
 
-	/* FIXME: Hmm... just bailing out my be problematic, since there *is*
-	 * activity during boot. For now the same problem persists in
-	 * set_pio_mode() we will have to do something about it soon.
-	 */
-	if (HWGROUP(drive)->handler)
-		return -EBUSY;
-
 	if (arg > drive->id->max_multsect)
 		arg = drive->id->max_multsect;
 
@@ -466,9 +459,6 @@
 
 static int set_nowerr(struct ata_device *drive, int arg)
 {
-	if (HWGROUP(drive)->handler)
-		return -EBUSY;
-
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
 
@@ -576,8 +566,8 @@
 		return 0;
 
 	/* wait until all commands are finished */
-	printk("ide_disk_suspend()\n");
-	while (HWGROUP(drive)->handler)
+	/* FIXME: waiting for spinlocks should be done instead. */
+	while (drive->channel->handler)
 		yield();
 
 	/* set the drive to standby */
@@ -1022,7 +1012,7 @@
 				return -EBUSY;
 
 			val = set_lba_addressing(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1048,7 +1038,7 @@
 				return -EBUSY;
 
 			val = set_multcount(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1072,7 +1062,7 @@
 				return -EBUSY;
 
 			val = set_nowerr(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1096,7 +1086,7 @@
 				return -EBUSY;
 
 			val = write_cache(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1119,7 +1109,7 @@
 				return -EBUSY;
 
 			val = set_acoustic(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
@@ -1144,7 +1134,7 @@
 				return -EBUSY;
 
 			val = set_using_tcq(drive, arg);
-			spin_unlock_irq(&ide_lock);
+			spin_unlock_irq(drive->channel->lock);
 
 			return val;
 		}
diff -urN linux-2.5.15/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.15/drivers/ide/ide-pci.c	2002-05-14 00:50:24.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-13 21:08:19.000000000 +0200
@@ -553,15 +553,14 @@
 			}
 		}
 	}
-
-	printk("ATA: %s: controller on PCI bus %02x dev %02x\n",
-			dev->name, dev->bus->number, dev->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+			dev->name, dev->slot_name, dev->devfn);
 	setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("ATA: %s: controller on PCI bus %02x dev %02x\n",
-			dev2->name, dev2->bus->number, dev2->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+			dev2->name, dev2->slot_name, dev2->devfn);
 	setup_pci_device(dev2, d2);
 }
 
@@ -584,8 +583,8 @@
 		}
 	}
 
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
-		dev->name, dev->bus->number, dev->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+		dev->name, dev->slot_name, dev->devfn);
 	setup_pci_device(dev, d);
 	if (!dev2) {
 		return;
@@ -601,8 +600,8 @@
 		}
 	}
 	d2 = d;
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
-		dev2->name, dev2->bus->number, dev2->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+		dev2->name, dev2->slot_name, dev2->devfn);
 	setup_pci_device(dev2, d2);
 
 }
@@ -623,7 +622,7 @@
 	switch(class_rev) {
 		case 5:
 		case 4:
-		case 3:	printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
+		case 3:	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev->name, dev->slot_name);
 			setup_pci_device(dev, d);
 			return;
 		default:	break;
@@ -639,17 +638,17 @@
 			pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
 			if ((pin1 != pin2) && (dev->irq == dev2->irq)) {
 				d->bootable = ON_BOARD;
-				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
+				printk(KERN_INFO "ATAL: %s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
 			}
 			break;
 		}
 	}
-	printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev->name, dev->slot_name);
 	setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("%s: IDE controller on PCI slot %s\n", dev2->name, dev2->slot_name);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev2->name, dev2->slot_name);
 	setup_pci_device(dev2, d2);
 }
 
@@ -679,6 +678,10 @@
 	}
 
 	if (!d) {
+		/* Only check the device calls, if it wasn't listed, since
+		 * there are in esp. some pdc202xx chips which "work around"
+		 * beeing grabbed by generic drivers.
+		 */
 		if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 			printk(KERN_INFO "ATA: unknown interface: %s, on PCI slot %s\n",
 					dev->name, dev->slot_name);
diff -urN linux-2.5.15/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.15/drivers/ide/ide-pmac.c	2002-05-10 00:25:18.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-13 23:13:55.000000000 +0200
@@ -15,12 +15,14 @@
  * Some code taken from drivers/ide/ide-dma.c:
  *
  *  Copyright (c) 1995-1998  Mark Lord
- *  
+ *
  * TODO:
- * 
+ *
  *  - Find a way to duplicate less code with ide-dma and use the
  *    dma fileds in the hwif structure instead of our own
+ *
  *  - Fix check_disk_change() call
+ *
  *  - Make module-able (includes setting ppc_md. hooks from within
  *    this file and not from arch code, and handling module deps with
  *    mediabay (by having both modules do dynamic lookup of each other
@@ -111,7 +113,7 @@
 /* 66Mhz cell, found in KeyLargo. Can do ultra mode 0 to 2 on
  * 40 connector cable and to 4 on 80 connector one.
  * Clock unit is 15ns (66Mhz)
- * 
+ *
  * 3 Values can be programmed:
  *  - Write data setup, which appears to match the cycle time. They
  *    also call it DIOW setup.
@@ -146,7 +148,7 @@
 
 /* 33Mhz cell, found in OHare, Heathrow (& Paddington) and KeyLargo
  * Can do pio & mdma modes, clock unit is 30ns (33Mhz)
- * 
+ *
  * The access time and recovery time can be programmed. Some older
  * Darwin code base limit OHare to 150ns cycle time. I decided to do
  * the same here fore safety against broken old hardware ;)
@@ -180,7 +182,7 @@
 # define GOOD_DMA_DRIVE		1
 
 /* Rounded Multiword DMA timings
- * 
+ *
  * I gave up finding a generic formula for all controller
  * types and instead, built tables based on timing values
  * used by Apple in Darwin's implementation.
@@ -280,7 +282,7 @@
 #endif /* CONFIG_PMAC_PBOOK */
 
 static int __pmac
-pmac_ide_find(ide_drive_t *drive)
+pmac_ide_find(struct ata_device *drive)
 {
 	struct ata_channel *hwif = drive->channel;
 	ide_ioreg_t base;
@@ -352,7 +354,7 @@
  * device for yaboot configuration
  */
 struct device_node*
-pmac_ide_get_devnode(ide_drive_t *drive)
+pmac_ide_get_devnode(struct ata_device *drive)
 {
 	int i = pmac_ide_find(drive);
 	if (i < 0)
@@ -365,7 +367,7 @@
  * is enough, I beleive selectproc will be called whenever an IDE command is started,
  * but... */
 static void __pmac
-pmac_ide_selectproc(ide_drive_t *drive)
+pmac_ide_selectproc(struct ata_device *drive)
 {
 	int i = pmac_ide_find(drive);
 	if (i < 0)
@@ -387,11 +389,11 @@
  * almost identical to the generic one and works, I've not yet
  * managed to figure out what bit is causing the lockup in the
  * generic code, possibly a timing issue...
- * 
+ *
  * --BenH
  */
 static int __pmac
-wait_for_ready(ide_drive_t *drive)
+wait_for_ready(struct ata_device *drive)
 {
 	/* Timeout bumped for some powerbooks */
 	int timeout = 2000;
@@ -417,12 +419,12 @@
 }
 
 static int __pmac
-pmac_ide_do_setfeature(ide_drive_t *drive, byte command)
+pmac_ide_do_setfeature(struct ata_device *drive, byte command)
 {
 	int result = 1;
 	unsigned long flags;
 	struct ata_channel *hwif = drive->channel;
-	
+
 	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
 	SELECT_DRIVE(drive->channel, drive);
@@ -477,7 +479,7 @@
 
 /* Calculate PIO timings */
 static void __pmac
-pmac_ide_tuneproc(ide_drive_t *drive, byte pio)
+pmac_ide_tuneproc(struct ata_device *drive, byte pio)
 {
 	struct ata_timing *t;
 	int i;
@@ -536,8 +538,8 @@
 #ifdef IDE_PMAC_DEBUG
 	printk(KERN_ERR "ide_pmac: Set PIO timing for mode %d, reg: 0x%08x\n",
 		pio,  *timings);
-#endif	
-		
+#endif
+
 	if (drive->select.all == IN_BYTE(IDE_SELECT_REG))
 		pmac_ide_selectproc(drive);
 }
@@ -553,14 +555,14 @@
 	addrTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].addrSetup);
 
 	*timings = ((*timings) & ~(TR_66_UDMA_MASK | TR_66_MDMA_MASK)) |
-			(wrDataSetupTicks << TR_66_UDMA_WRDATASETUP_SHIFT) | 
+			(wrDataSetupTicks << TR_66_UDMA_WRDATASETUP_SHIFT) |
 			(rdyToPauseTicks << TR_66_UDMA_RDY2PAUS_SHIFT) |
 			(addrTicks <<TR_66_UDMA_ADDRSETUP_SHIFT) |
 			TR_66_UDMA_EN;
 #ifdef IDE_PMAC_DEBUG
 	printk(KERN_ERR "ide_pmac: Set UDMA timing for mode %d, reg: 0x%08x\n",
 		speed & 0xf,  *timings);
-#endif	
+#endif
 
 	return 0;
 }
@@ -584,7 +586,7 @@
 	/* Adjust for drive */
 	if (drive_cycle_time && drive_cycle_time > cycleTime)
 		cycleTime = drive_cycle_time;
-	/* OHare limits according to some old Apple sources */	
+	/* OHare limits according to some old Apple sources */
 	if ((intf_type == controller_ohare) && (cycleTime < 150))
 		cycleTime = 150;
 	/* Get the proper timing array for this controller */
@@ -616,7 +618,7 @@
 #ifdef IDE_PMAC_DEBUG
 	printk(KERN_ERR "ide_pmac: MDMA, cycleTime: %d, accessTime: %d, recTime: %d\n",
 		cycleTime, accessTime, recTime);
-#endif	
+#endif
 	if (intf_type == controller_kl_ata4 || intf_type == controller_kl_ata4_80) {
 		/* 66Mhz cell */
 		accessTicks = SYSCLK_TICKS_66(accessTime);
@@ -646,7 +648,7 @@
 		int halfTick = 0;
 		int origAccessTime = accessTime;
 		int origRecTime = recTime;
-		
+
 		accessTicks = SYSCLK_TICKS(accessTime);
 		accessTicks = max(accessTicks, 1U);
 		accessTicks = min(accessTicks, 0x1fU);
@@ -658,7 +660,7 @@
 		if ((accessTicks > 1) &&
 		    ((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
 		    ((recTime - IDE_SYSCLK_NS/2) >= origRecTime)) {
-            		halfTick = 1;
+			halfTick = 1;
 			accessTicks--;
 		}
 		*timings = ((*timings) & ~TR_33_MDMA_MASK) |
@@ -667,19 +669,19 @@
 		if (halfTick)
 			*timings |= TR_33_MDMA_HALFTICK;
 	}
-#ifdef IDE_PMAC_DEBUG
+# ifdef IDE_PMAC_DEBUG
 	printk(KERN_ERR "ide_pmac: Set MDMA timing for mode %d, reg: 0x%08x\n",
 		speed & 0xf,  *timings);
-#endif	
+# endif
 	return 0;
 }
-#endif /* #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC */
+#endif
 
 /* You may notice we don't use this function on normal operation,
  * our, normal mdma function is supposed to be more precise
  */
 static int __pmac
-pmac_ide_tune_chipset (ide_drive_t *drive, byte speed)
+pmac_ide_tune_chipset (struct ata_device *drive, byte speed)
 {
 	int intf		= pmac_ide_find(drive);
 	int unit		= (drive->select.b.unit & 0x01);
@@ -688,21 +690,21 @@
 
 	if (intf < 0)
 		return 1;
-		
+
 	timings = &pmac_ide[intf].timings[unit];
-	
+
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		case XFER_UDMA_4:
 		case XFER_UDMA_3:
 			if (pmac_ide[intf].kind != controller_kl_ata4_80)
-				return 1;		
+				return 1;
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
 			if (pmac_ide[intf].kind != controller_kl_ata4 &&
 				pmac_ide[intf].kind != controller_kl_ata4_80)
-				return 1;		
+				return 1;
 			ret = set_timings_udma(timings, speed);
 			break;
 		case XFER_MW_DMA_2:
@@ -714,7 +716,7 @@
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
 			return 1;
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+#endif
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
@@ -731,8 +733,8 @@
 	ret = pmac_ide_do_setfeature(drive, speed);
 	if (ret)
 		return ret;
-		
-	pmac_ide_selectproc(drive);	
+
+	pmac_ide_selectproc(drive);
 	drive->current_speed = speed;
 
 	return 0;
@@ -742,7 +744,7 @@
 sanitize_timings(int i)
 {
 	unsigned value;
-	
+
 	switch(pmac_ide[i].kind) {
 		case controller_kl_ata4:
 		case controller_kl_ata4_80:
@@ -770,8 +772,8 @@
 pmac_ide_check_base(ide_ioreg_t base)
 {
 	int ix;
-	
- 	for (ix = 0; ix < MAX_HWIFS; ++ix)
+
+	for (ix = 0; ix < MAX_HWIFS; ++ix)
 		if (base == pmac_ide[ix].regbase)
 			return ix;
 	return -1;
@@ -794,7 +796,7 @@
 pmac_find_ide_boot(char *bootdevice, int n)
 {
 	int i;
-	
+
 	/*
 	 * Look through the list of IDE interfaces for this one.
 	 */
@@ -857,7 +859,7 @@
 		int in_bay = 0;
 		u8 pbus, pid;
 		struct pci_dev *pdev = NULL;
-		
+
 		/*
 		 * If this node is not under a mac-io or dbdma node,
 		 * leave it to the generic PCI driver.
@@ -883,7 +885,7 @@
 		if (pdev == NULL)
 			printk(KERN_WARNING "ide: no PCI host for device %s, DMA disabled\n",
 			       np->full_name);
-		
+
 		/*
 		 * If this slot is taken (e.g. by ide-pci.c) try the next one.
 		 */
@@ -950,7 +952,7 @@
 		    && strcasecmp(np->parent->name, "media-bay") == 0) {
 #ifdef CONFIG_PMAC_PBOOK
 			media_bay_set_ide_infos(np->parent,base,irq,i);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif
 			in_bay = 1;
 			if (!bidp)
 				pmif->aapl_bus_id = 1;
@@ -961,7 +963,7 @@
 			 */
 			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, 0, 1);
 		} else {
- 			/* This is necessary to enable IDE when net-booting */
+			/* This is necessary to enable IDE when net-booting */
 			printk(KERN_INFO "pmac_ide: enabling IDE bus ID %d\n",
 				pmif->aapl_bus_id);
 			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 1);
@@ -981,14 +983,14 @@
 #ifdef CONFIG_PMAC_PBOOK
 		if (in_bay && check_media_bay_by_base(base, MB_CD) == 0)
 			hwif->noprobe = 0;
-#endif /* CONFIG_PMAC_PBOOK */
+#endif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		if (pdev && np->n_addrs >= 2) {
 			/* has a DBDMA controller channel */
 			pmac_ide_setup_dma(np, i);
 		}
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+#endif
 
 		++i;
 	}
@@ -998,12 +1000,12 @@
 
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&idepmac_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
-static void __init 
+static void __init
 pmac_ide_setup_dma(struct device_node *np, int ix)
 {
 	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
@@ -1037,7 +1039,7 @@
 	if (pmif->sg_table == NULL) {
 		pci_free_consistent(	ide_hwifs[ix].pci_dev,
 					(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
-				    	pmif->dma_table_cpu, pmif->dma_table_dma);
+					pmif->dma_table_cpu, pmif->dma_table_dma);
 		return;
 	}
 	ide_hwifs[ix].udma_enable = pmac_udma_enable;
@@ -1230,7 +1232,7 @@
 
 /* Calculate MultiWord DMA timings */
 static int __pmac
-pmac_ide_mdma_enable(ide_drive_t *drive, int idx)
+pmac_ide_mdma_enable(struct ata_device *drive, int idx)
 {
 	byte bits = drive->id->dma_mword & 0x07;
 	byte feature = dma_bits_to_command(bits);
@@ -1240,16 +1242,16 @@
 	int ret;
 
 	/* Set feature on drive */
-    	printk(KERN_INFO "%s: Enabling MultiWord DMA %d\n", drive->name, feature & 0xf);
+	printk(KERN_INFO "%s: Enabling MultiWord DMA %d\n", drive->name, feature & 0xf);
 	ret = pmac_ide_do_setfeature(drive, feature);
 	if (ret) {
-	    	printk(KERN_WARNING "%s: Failed !\n", drive->name);
-	    	return 0;
+		printk(KERN_WARNING "%s: Failed !\n", drive->name);
+		return 0;
 	}
 
 	if (!drive->init_speed)
 		drive->init_speed = feature;
-	
+
 	/* which drive is it ? */
 	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
@@ -1265,13 +1267,13 @@
 	/* Calculate controller timings */
 	set_timings_mdma(pmac_ide[idx].kind, timings, feature, drive_cycle_time);
 
-	drive->current_speed = feature;	
+	drive->current_speed = feature;
 	return 1;
 }
 
 /* Calculate Ultra DMA timings */
 static int __pmac
-pmac_ide_udma_enable(ide_drive_t *drive, int idx, int high_speed)
+pmac_ide_udma_enable(struct ata_device *drive, int idx, int high_speed)
 {
 	byte bits = drive->id->dma_ultra & 0x1f;
 	byte feature = udma_bits_to_command(bits, high_speed);
@@ -1279,7 +1281,7 @@
 	int ret;
 
 	/* Set feature on drive */
-    	printk(KERN_INFO "%s: Enabling Ultra DMA %d\n", drive->name, feature & 0xf);
+	printk(KERN_INFO "%s: Enabling Ultra DMA %d\n", drive->name, feature & 0xf);
 	ret = pmac_ide_do_setfeature(drive, feature);
 	if (ret) {
 		printk(KERN_WARNING "%s: Failed !\n", drive->name);
@@ -1297,12 +1299,12 @@
 
 	set_timings_udma(timings, feature);
 
-	drive->current_speed = feature;	
+	drive->current_speed = feature;
 	return 1;
 }
 
 static int __pmac
-pmac_ide_check_dma(ide_drive_t *drive)
+pmac_ide_check_dma(struct ata_device *drive)
 {
 	int ata4, udma, idx;
 	struct hd_driveid *id = drive->id;
@@ -1343,7 +1345,7 @@
 	return 0;
 }
 
-static void ide_toggle_bounce(ide_drive_t *drive, int on)
+static void ide_toggle_bounce(struct ata_device *drive, int on)
 {
 	dma64_addr_t addr = BLK_BOUNCE_HIGH;
 
@@ -1432,7 +1434,7 @@
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
 		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
-			pmac_ide[ix].timings[unit] + 
+			pmac_ide[ix].timings[unit] +
 			((reading) ? 0x00800000UL : 0));
 		(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
 	}
@@ -1530,7 +1532,7 @@
 }
 #endif
 
-static void idepmac_sleep_device(ide_drive_t *drive, int i, unsigned base)
+static void idepmac_sleep_device(struct ata_device *drive, int i, unsigned base)
 {
 	int j;
 
@@ -1568,7 +1570,7 @@
 
 #ifdef CONFIG_PMAC_PBOOK
 static void __pmac
-idepmac_wake_device(ide_drive_t *drive, int used_dma)
+idepmac_wake_device(struct ata_device *drive, int used_dma)
 {
 	/* We force the IDE subdriver to check for a media change
 	 * This must be done first or we may lost the condition
@@ -1581,7 +1583,7 @@
 
 	/* We kick the VFS too (see fix in ide.c revalidate) */
 	check_disk_change(mk_kdev(drive->channel->major, (drive->select.b.unit) << PARTN_BITS));
-	
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* We re-enable DMA on the drive if it was active. */
 	/* This doesn't work with the CD-ROM in the media-bay, probably
@@ -1590,12 +1592,12 @@
 	 */
 	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+		set_bit(IDE_BUSY, &drive->channel->active);
 		pmac_ide_check_dma(drive);
-		clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
-		spin_unlock_irq(&ide_lock);
+		clear_bit(IDE_BUSY, &drive->channel->active);
+		spin_unlock_irq(drive->channel->lock);
 	}
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+#endif
 }
 
 static void __pmac
@@ -1606,11 +1608,11 @@
 	/* We clear the timings */
 	pmac_ide[i].timings[0] = 0;
 	pmac_ide[i].timings[1] = 0;
-	
+
 	/* The media bay will handle itself just fine */
 	if (mediabay)
 		return;
-	
+
 	/* Disable the bus */
 	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmac_ide[i].aapl_bus_id, 0);
 }
@@ -1630,7 +1632,7 @@
 }
 
 static void
-idepmac_sleep_drive(ide_drive_t *drive, int idx, unsigned long base)
+idepmac_sleep_drive(struct ata_device *drive, int idx, unsigned long base)
 {
 	/* Wait for HW group to complete operations */
 	if (ide_spin_wait_hwgroup(drive))
@@ -1639,22 +1641,22 @@
 		return;
 	else {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+		set_bit(IDE_BUSY, &drive->channel->active);
 		/* Stop the device */
 		idepmac_sleep_device(drive, idx, base);
-		spin_unlock_irq(&ide_lock);
+		spin_unlock_irq(drive->channel->lock);
 	}
 }
 
 static void
-idepmac_wake_drive(ide_drive_t *drive, unsigned long base)
+idepmac_wake_drive(struct ata_device *drive, unsigned long base)
 {
 	int j;
-	
+
 	/* Reset timings */
 	pmac_ide_selectproc(drive);
 	mdelay(10);
-	
+
 	/* Wait up to 20 seconds for the drive to be ready */
 	for (j = 0; j < 200; j++) {
 		int status;
@@ -1669,7 +1671,7 @@
 
 	/* We resume processing on the HW group */
 	spin_lock_irq(&ide_lock);
-	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+	clear_bit(IDE_BUSY, &drive->channel->active);
 	if (!list_empty(&drive->queue.queue_head))
 		do_ide_request(&drive->queue);
 	spin_unlock_irq(&ide_lock);
@@ -1685,7 +1687,7 @@
 	int i, ret;
 	unsigned long base;
 	int big_delay;
- 
+
 	switch (when) {
 	case PBOOK_SLEEP_REQUEST:
 		break;
@@ -1707,7 +1709,7 @@
 			}
 			/* Disable irq during sleep */
 			disable_irq(pmac_ide[i].irq);
-			
+
 			/* Check if this is a media bay with an IDE device or not
 			 * a media bay.
 			 */
@@ -1722,8 +1724,8 @@
 
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
-				
-			/* Make sure we have sane timings */		
+
+			/* Make sure we have sane timings */
 			sanitize_timings(i);
 
 			/* Check if this is a media bay with an IDE device or not
@@ -1731,7 +1733,7 @@
 			 */
 			ret = check_media_bay_by_base(base, MB_CD);
 			if ((ret == 0) || (ret == -ENODEV)) {
-				idepmac_wake_interface(i, base, (ret == 0));				
+				idepmac_wake_interface(i, base, (ret == 0));
 				big_delay = 1;
 			}
 
@@ -1739,18 +1741,18 @@
 		/* Let hardware get up to speed */
 		if (big_delay)
 			mdelay(IDE_WAKEUP_DELAY_MS);
-	
+
 		for (i = 0; i < pmac_ide_count; ++i) {
 			struct ata_channel *hwif;
 			int used_dma, dn;
 			int irq_on = 0;
-			
+
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
-				
+
 			hwif = &ide_hwifs[i];
 			for (dn=0; dn<MAX_DRIVES; dn++) {
-				ide_drive_t *drive = &hwif->drives[dn];
+				struct ata_device *drive = &hwif->drives[dn];
 				if (!drive->present)
 					continue;
 				/* We don't have re-configured DMA yet */
diff -urN linux-2.5.15/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.15/drivers/ide/ide-probe.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-13 23:39:29.000000000 +0200
@@ -578,15 +578,15 @@
 {
 	unsigned long flags;
 	int i;
-	ide_hwgroup_t *hwgroup;
-	ide_hwgroup_t *new_hwgroup;
+	spinlock_t *lock;
+	spinlock_t *new_lock;
 	struct ata_channel *match = NULL;
 
 	/* Spare allocation before sleep. */
-	new_hwgroup = kmalloc(sizeof(*hwgroup), GFP_KERNEL);
+	new_lock = kmalloc(sizeof(*lock), GFP_KERNEL);
 
 	spin_lock_irqsave(&ide_lock, flags);
-	ch->hwgroup = NULL;
+	ch->lock = NULL;
 
 #if MAX_HWIFS > 1
 	/*
@@ -596,7 +596,7 @@
 		struct ata_channel *h = &ide_hwifs[i];
 
 		/* scan only initialized channels */
-		if (!h->hwgroup)
+		if (!h->lock)
 			continue;
 
 		if (ch->irq != h->irq)
@@ -606,7 +606,7 @@
 
 		if (ch->chipset != ide_pci || h->chipset != ide_pci ||
 		     ch->serialized || h->serialized) {
-			if (match && match->hwgroup && match->hwgroup != h->hwgroup)
+			if (match && match->lock && match->lock != h->lock)
 				printk("%s: potential irq problem with %s and %s\n", ch->name, h->name, match->name);
 			/* don't undo a prior perfect match */
 			if (!match || match->irq != ch->irq)
@@ -615,19 +615,20 @@
 	}
 #endif
 	/*
-	 * If we are still without a hwgroup, then form a new one
+	 * If we are still without a lock group, then form a new one
 	 */
-	if (match) {
-		hwgroup = match->hwgroup;
-		if(new_hwgroup)
-			kfree(new_hwgroup);
-	} else {
-		hwgroup = new_hwgroup;
-		if (!hwgroup) {
+	if (!match) {
+		lock = new_lock;
+		if (!lock) {
 			spin_unlock_irqrestore(&ide_lock, flags);
+
 			return 1;
 		}
-		memset(hwgroup, 0, sizeof(*hwgroup));
+		spin_lock_init(lock);
+	} else {
+		lock = match->lock;
+		if(new_lock)
+			kfree(new_lock);
 	}
 
 	/*
@@ -645,7 +646,8 @@
 
 		if (request_irq(ch->irq, &ata_irq_request, sa, ch->name, ch)) {
 			if (!match)
-				kfree(hwgroup);
+				kfree(lock);
+
 			spin_unlock_irqrestore(&ide_lock, flags);
 
 			return 1;
@@ -653,9 +655,9 @@
 	}
 
 	/*
-	 * Everything is okay. Tag us as member of this hardware group.
+	 * Everything is okay. Tag us as member of this lock group.
 	 */
-	ch->hwgroup = hwgroup;
+	ch->lock = lock;
 
 	init_timer(&ch->timer);
 	ch->timer.function = &ide_timer_expiry;
@@ -678,7 +680,7 @@
 
 		q = &drive->queue;
 		q->queuedata = drive->channel;
-		blk_init_queue(q, do_ide_request, &ide_lock);
+		blk_init_queue(q, do_ide_request, drive->channel->lock);
 		blk_queue_segment_boundary(q, 0xffff);
 
 		/* ATA can do up to 128K per request, pdc4030 needs smaller limit */
diff -urN linux-2.5.15/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.15/drivers/ide/ide-taskfile.c	2002-05-14 00:50:24.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-14 00:23:19.000000000 +0200
@@ -61,41 +61,6 @@
  * Data transfer functions for polled IO.
  */
 
-#if SUPPORT_VLB_SYNC
-/*
- * Some localbus EIDE interfaces require a special access sequence
- * when using 32-bit I/O instructions to transfer data.  We call this
- * the "vlb_sync" sequence, which consists of three successive reads
- * of the sector count register location, with interrupts disabled
- * to ensure that the reads all happen together.
- */
-static void ata_read_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
-{
-	unsigned long flags;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-	IN_BYTE(IDE_NSECTOR_REG);
-	IN_BYTE(IDE_NSECTOR_REG);
-	IN_BYTE(IDE_NSECTOR_REG);
-	insl(IDE_DATA_REG, buffer, wcount);
-	__restore_flags(flags);	/* local CPU only */
-}
-
-static void ata_write_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
-{
-	unsigned long flags;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-	IN_BYTE(IDE_NSECTOR_REG);
-	IN_BYTE(IDE_NSECTOR_REG);
-	IN_BYTE(IDE_NSECTOR_REG);
-	outsl(IDE_DATA_REG, buffer, wcount);
-	__restore_flags(flags);	/* local CPU only */
-}
-#endif
-
 static void ata_read_32(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
 	insl(IDE_DATA_REG, buffer, wcount);
@@ -157,12 +122,7 @@
 	io_32bit = drive->channel->io_32bit;
 
 	if (io_32bit) {
-#if SUPPORT_VLB_SYNC
-		if (io_32bit & 2)
-			ata_read_vlb(drive, buffer, wcount);
-		else
-#endif
-			ata_read_32(drive, buffer, wcount);
+		ata_read_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
 		if (drive->channel->slow)
@@ -188,12 +148,7 @@
 	io_32bit = drive->channel->io_32bit;
 
 	if (io_32bit) {
-#if SUPPORT_VLB_SYNC
-		if (io_32bit & 2)
-			ata_write_vlb(drive, buffer, wcount);
-		else
-#endif
-			ata_write_32(drive, buffer, wcount);
+		ata_write_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
 		if (drive->channel->slow)
@@ -320,7 +275,6 @@
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
 {
 	u8 stat = GET_STAT();
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	int mcount = drive->mult_count;
 	ide_startstop_t startstop;
 
@@ -349,7 +303,7 @@
 		}
 
 		/* no data yet, so wait for another interrupt */
-		if (hwgroup->handler == NULL)
+		if (!drive->channel->handler)
 			ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
 
 		return ide_started;
@@ -392,7 +346,7 @@
 	} while (mcount);
 
 	rq->errors = 0;
-	if (hwgroup->handler == NULL)
+	if (!drive->channel->handler)
 		ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
 
 	return ide_started;
diff -urN linux-2.5.15/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.15/drivers/ide/pdc4030.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-14 00:22:41.000000000 +0200
@@ -1,14 +1,11 @@
 /*  -*- linux-c -*-
- *  linux/drivers/ide/pdc4030.c		Version 0.92  Jan 15, 2002
  *
  *  Copyright (C) 1995-2002  Linus Torvalds & authors (see below)
- */
-
-/*
+ *
  *  Principal Author/Maintainer:  peterd@pnd-pc.demon.co.uk
  *
  *  This file provides support for the second port and cache of Promise
- *  IDE interfaces, e.g. DC4030VL, DC4030VL-1 and DC4030VL-2.
+ *  VLB based IDE interfaces, e.g. DC4030VL, DC4030VL-1 and DC4030VL-2.
  *
  *  Thanks are due to Mark Lord for advice and patiently answering stupid
  *  questions, and all those mugs^H^H^H^Hbrave souls who've tested this,
@@ -44,14 +41,14 @@
 
 /*
  * Once you've compiled it in, you'll have to also enable the interface
- * setup routine from the kernel command line, as in 
+ * setup routine from the kernel command line, as in
  *
  *	'linux ide0=dc4030' or 'linux ide1=dc4030'
  *
  * It should now work as a second controller also ('ide1=dc4030') but only
  * if you DON'T have BIOS V4.44, which has a bug. If you have this version
  * and EPROM programming facilities, you need to fix 4 bytes:
- * 	2496:	81	81
+ *	2496:	81	81
  *	2497:	3E	3E
  *	2498:	22	98	*
  *	2499:	06	05	*
@@ -67,7 +64,7 @@
  *
  * As of January 1999, Promise Technology Inc. have finally supplied me with
  * some technical information which has shed a glimmer of light on some of the
- * problems I was having, especially with writes. 
+ * problems I was having, especially with writes.
  *
  * There are still potential problems with the robustness and efficiency of
  * this driver because I still don't understand what the card is doing with
@@ -94,20 +91,85 @@
 
 #include "pdc4030.h"
 
-#if SUPPORT_VLB_SYNC != 1
-#error This driver will not work unless SUPPORT_VLB_SYNC is 1
-#endif
+/*
+ * Data transfer functions for polled IO.
+ */
+
+/*
+ * Some localbus EIDE interfaces require a special access sequence
+ * when using 32-bit I/O instructions to transfer data.  We call this
+ * the "vlb_sync" sequence, which consists of three successive reads
+ * of the sector count register location, with interrupts disabled
+ * to ensure that the reads all happen together.
+ */
+static void read_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	unsigned long flags;
+
+	__save_flags(flags);	/* local CPU only */
+	__cli();		/* local CPU only */
+	inb(IDE_NSECTOR_REG);
+	inb(IDE_NSECTOR_REG);
+	inb(IDE_NSECTOR_REG);
+	insl(IDE_DATA_REG, buffer, wcount);
+	__restore_flags(flags);	/* local CPU only */
+}
+
+static void write_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	unsigned long flags;
+
+	__save_flags(flags);	/* local CPU only */
+	__cli();		/* local CPU only */
+	inb(IDE_NSECTOR_REG);
+	inb(IDE_NSECTOR_REG);
+	inb(IDE_NSECTOR_REG);
+	outsl(IDE_DATA_REG, buffer, wcount);
+	__restore_flags(flags);	/* local CPU only */
+}
+
+static void read_16(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	insw(IDE_DATA_REG, buffer, wcount<<1);
+}
+
+static void write_16(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	outsw(IDE_DATA_REG, buffer, wcount<<1);
+}
+
+/*
+ * This is used for most PIO data transfers *from* the device.
+ */
+static void promise_read(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	if (drive->channel->io_32bit)
+		read_vlb(drive, buffer, wcount);
+	else
+		read_16(drive, buffer, wcount);
+}
+
+/*
+ * This is used for most PIO data transfers *to* the device interface.
+ */
+static void promise_write(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	if (drive->channel->io_32bit)
+		write_vlb(drive, buffer, wcount);
+	else
+		write_16(drive, buffer, wcount);
+}
 
 /*
  * promise_selectproc() is invoked by ide.c
  * in preparation for access to the specified drive.
  */
-static void promise_selectproc (ide_drive_t *drive)
+static void promise_selectproc(struct ata_device *drive)
 {
-	unsigned int number;
+	u8 number;
 
 	number = (drive->channel->unit << 1) + drive->select.b.unit;
-	OUT_BYTE(number,IDE_FEATURE_REG);
+	outb(number, IDE_FEATURE_REG);
 }
 
 /*
@@ -115,15 +177,15 @@
  * by command F0. They all have the same success/failure notification -
  * 'P' (=0x50) on success, 'p' (=0x70) on failure.
  */
-int pdc4030_cmd(ide_drive_t *drive, byte cmd)
+int pdc4030_cmd(struct ata_device *drive, byte cmd)
 {
 	unsigned long timeout, timer;
 	byte status_val;
 
 	promise_selectproc(drive);	/* redundant? */
-	OUT_BYTE(0xF3,IDE_SECTOR_REG);
-	OUT_BYTE(cmd,IDE_SELECT_REG);
-	OUT_BYTE(PROMISE_EXTENDED_COMMAND,IDE_COMMAND_REG);
+	outb(0xF3, IDE_SECTOR_REG);
+	outb(cmd, IDE_SELECT_REG);
+	outb(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
 	timeout = HZ * 10;
 	timeout += jiffies;
 	do {
@@ -134,7 +196,7 @@
 		/* Delays at least 10ms to give interface a chance */
 		timer = jiffies + (HZ + 99)/100 + 1;
 		while (time_after(timer, jiffies));
-		status_val = IN_BYTE(IDE_SECTOR_REG);
+		status_val = inb(IDE_SECTOR_REG);
 	} while (status_val != 0x50 && status_val != 0x70);
 
 	if(status_val == 0x50)
@@ -146,7 +208,7 @@
 /*
  * pdc4030_identify sends a vendor-specific IDENTIFY command to the drive
  */
-int pdc4030_identify(ide_drive_t *drive)
+int pdc4030_identify(struct ata_device *drive)
 {
 	return pdc4030_cmd(drive, PROMISE_IDENTIFY);
 }
@@ -164,24 +226,25 @@
  */
 int __init setup_pdc4030(struct ata_channel *hwif)
 {
-        ide_drive_t *drive;
+        struct ata_device *drive;
 	struct ata_channel *hwif2;
 	struct dc_ident ident;
 	int i;
 	ide_startstop_t startstop;
 
-	if (!hwif) return 0;
+	if (!hwif)
+		return 0;
 
 	drive = &hwif->drives[0];
 	hwif2 = &ide_hwifs[hwif->index+1];
 	if (hwif->chipset == ide_pdc4030) /* we've already been found ! */
 		return 1;
 
-	if (IN_BYTE(IDE_NSECTOR_REG) == 0xFF || IN_BYTE(IDE_SECTOR_REG) == 0xFF) {
+	if (inb(IDE_NSECTOR_REG) == 0xFF || inb(IDE_SECTOR_REG) == 0xFF) {
 		return 0;
 	}
 	if (IDE_CONTROL_REG)
-		OUT_BYTE(0x08,IDE_CONTROL_REG);
+		outb(0x08, IDE_CONTROL_REG);
 	if (pdc4030_cmd(drive,PROMISE_GET_CONFIG)) {
 		return 0;
 	}
@@ -190,7 +253,7 @@
 			"%s: Failed Promise read config!\n",hwif->name);
 		return 0;
 	}
-	ata_read(drive, &ident, SECTOR_WORDS);
+	promise_read(drive, &ident, SECTOR_WORDS);
 	if (ident.id[1] != 'P' || ident.id[0] != 'T') {
 		return 0;
 	}
@@ -233,7 +296,9 @@
 	hwif->chipset	= hwif2->chipset = ide_pdc4030;
 	hwif->unit	= ATA_PRIMARY;
 	hwif2->unit	= ATA_SECONDARY;
-	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
+	hwif->ata_read  = hwif2->ata_read = promise_read;
+	hwif->ata_write = hwif2->ata_write = promise_write;
+	hwif->selectproc = hwif2->selectproc = promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 
 /* Shift the remaining interfaces up by one */
@@ -269,20 +334,20 @@
  */
 int __init detect_pdc4030(struct ata_channel *hwif)
 {
-	ide_drive_t *drive = &hwif->drives[0];
+	struct ata_device *drive = &hwif->drives[0];
 
 	if (IDE_DATA_REG == 0) { /* Skip test for non-existent interface */
 		return 0;
 	}
-	OUT_BYTE(0xF3, IDE_SECTOR_REG);
-	OUT_BYTE(0x14, IDE_SELECT_REG);
-	OUT_BYTE(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
-	
+	outb(0xF3, IDE_SECTOR_REG);
+	outb(0x14, IDE_SELECT_REG);
+	outb(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
+
 	ide_delay_50ms();
 
-	if (IN_BYTE(IDE_ERROR_REG) == 'P' &&
-	    IN_BYTE(IDE_NSECTOR_REG) == 'T' &&
-	    IN_BYTE(IDE_SECTOR_REG) == 'I') {
+	if (inb(IDE_ERROR_REG) == 'P' &&
+	    inb(IDE_NSECTOR_REG) == 'T' &&
+	    inb(IDE_SECTOR_REG) == 'I') {
 		return 1;
 	} else {
 		return 0;
@@ -321,9 +386,9 @@
 
 read_again:
 	do {
-		sectors_left = IN_BYTE(IDE_NSECTOR_REG);
-		IN_BYTE(IDE_SECTOR_REG);
-	} while (IN_BYTE(IDE_NSECTOR_REG) != sectors_left);
+		sectors_left = inb(IDE_NSECTOR_REG);
+		inb(IDE_SECTOR_REG);
+	} while (inb(IDE_NSECTOR_REG) != sectors_left);
 	sectors_avail = rq->nr_sectors - sectors_left;
 	if (!sectors_avail)
 		goto read_again;
@@ -334,7 +399,7 @@
 		nsect = sectors_avail;
 	sectors_avail -= nsect;
 	to = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
-	ata_read(drive, to, nsect * SECTOR_WORDS);
+	promise_read(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG_READ
 	printk(KERN_DEBUG "%s:  promise_read: sectors(%ld-%ld), "
 	       "buf=0x%08lx, rem=%ld\n", drive->name, rq->sector,
@@ -458,7 +523,7 @@
 		 * Ok, we're all setup for the interrupt
 		 * re-entering us on the last transfer.
 		 */
-		ata_write(drive, buffer, nsect << 7);
+		promise_write(drive, buffer, nsect << 7);
 		bio_kunmap_irq(buffer, &flags);
 	} while (mcount);
 
@@ -472,7 +537,7 @@
 {
 	struct ata_channel *ch = drive->channel;
 
-	if (IN_BYTE(IDE_NSECTOR_REG) != 0) {
+	if (inb(IDE_NSECTOR_REG) != 0) {
 		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, promise_write_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
@@ -496,13 +561,13 @@
 }
 
 /*
- * promise_write() transfers a block of one or more sectors of data to a
- * drive as part of a disk write operation. All but 4 sectors are transferred
- * in the first attempt, then the interface is polled (nicely!) for completion
- * before the final 4 sectors are transferred. There is no interrupt generated
- * on writes (at least on the DC4030VL-2), we just have to poll for NOT BUSY.
+ * This transfers a block of one or more sectors of data to a drive as part of
+ * a disk write operation. All but 4 sectors are transferred in the first
+ * attempt, then the interface is polled (nicely!) for completion before the
+ * final 4 sectors are transferred. There is no interrupt generated on writes
+ * (at least on the DC4030VL-2), we just have to poll for NOT BUSY.
  */
-static ide_startstop_t promise_write(struct ata_device *drive, struct request *rq)
+static ide_startstop_t promise_do_write(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 
@@ -558,18 +623,18 @@
 	}
 
 	if (IDE_CONTROL_REG)
-		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
+		outb(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
 	SELECT_MASK(drive->channel, drive, 0);
 
-	OUT_BYTE(taskfile->feature, IDE_FEATURE_REG);
-	OUT_BYTE(taskfile->sector_count, IDE_NSECTOR_REG);
+	outb(taskfile->feature, IDE_FEATURE_REG);
+	outb(taskfile->sector_count, IDE_NSECTOR_REG);
 	/* refers to number of sectors to transfer */
-	OUT_BYTE(taskfile->sector_number, IDE_SECTOR_REG);
+	outb(taskfile->sector_number, IDE_SECTOR_REG);
 	/* refers to sector offset or start sector */
-	OUT_BYTE(taskfile->low_cylinder, IDE_LCYL_REG);
-	OUT_BYTE(taskfile->high_cylinder, IDE_HCYL_REG);
-	OUT_BYTE(taskfile->device_head, IDE_SELECT_REG);
-	OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
+	outb(taskfile->low_cylinder, IDE_LCYL_REG);
+	outb(taskfile->high_cylinder, IDE_HCYL_REG);
+	outb(taskfile->device_head, IDE_SELECT_REG);
+	outb(taskfile->command, IDE_COMMAND_REG);
 
 	switch (rq_data_dir(rq)) {
 	case READ:
@@ -590,7 +655,7 @@
 				udelay(1);
 				return promise_read_intr(drive, rq);
 			}
-			if (IN_BYTE(IDE_SELECT_REG) & 0x01) {
+			if (inb(IDE_SELECT_REG) & 0x01) {
 #ifdef DEBUG_READ
 				printk(KERN_DEBUG "%s: read: waiting for "
 				                  "interrupt\n", drive->name);
@@ -621,7 +686,7 @@
 		}
 		if (!drive->channel->unmask)
 			__cli();	/* local CPU only */
-		return promise_write(drive, rq);
+		return promise_do_write(drive, rq);
 	}
 
 	default:
diff -urN linux-2.5.15/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.15/drivers/ide/tcq.c	2002-05-14 00:50:24.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-13 22:03:40.000000000 +0200
@@ -83,7 +83,6 @@
 static void tcq_invalidate_queue(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	request_queue_t *q = &drive->queue;
 	struct ata_taskfile *args;
 	struct request *rq;
@@ -104,7 +103,7 @@
 	drive->queue_depth = 1;
 	clear_bit(IDE_BUSY, &ch->active);
 	clear_bit(IDE_DMA, &ch->active);
-	hwgroup->handler = NULL;
+	ch->handler = NULL;
 
 	/*
 	 * Do some internal stuff -- we really need this command to be
@@ -153,7 +152,6 @@
 {
 	struct ata_device *drive = (struct ata_device *) data;
 	struct ata_channel *ch = drive->channel;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
 
 	printk(KERN_ERR "ATA: %s: timeout waiting for interrupt...\n", __FUNCTION__);
@@ -161,9 +159,9 @@
 	spin_lock_irqsave(&ide_lock, flags);
 
 	if (test_and_set_bit(IDE_BUSY, &ch->active))
-		printk(KERN_ERR "ATA: %s: hwgroup not busy\n", __FUNCTION__);
-	if (hwgroup->handler == NULL)
-		printk(KERN_ERR "ATA: %s: missing isr!\n", __FUNCTION__);
+		printk(KERN_ERR "ATA: %s: IRQ handler not busy\n", __FUNCTION__);
+	if (!ch->handler)
+		printk(KERN_ERR "ATA: %s: missing ISR!\n", __FUNCTION__);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 
@@ -181,7 +179,6 @@
 static void set_irq(struct ata_device *drive, ata_handler_t *handler)
 {
 	struct ata_channel *ch = drive->channel;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ide_lock, flags);
@@ -197,8 +194,8 @@
 	ch->timer.function = ata_tcq_irq_timeout;
 	ch->timer.data = (unsigned long) ch->drive;
 	mod_timer(&ch->timer, jiffies + 5 * HZ);
+	ch->handler = handler;
 
-	hwgroup->handler = handler;
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
diff -urN linux-2.5.15/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.15/drivers/ide/umc8672.c	2002-05-10 00:23:22.000000000 +0200
+++ linux/drivers/ide/umc8672.c	2002-05-13 22:06:19.000000000 +0200
@@ -21,7 +21,7 @@
  */
 
 /*
- * VLB Controller Support from 
+ * VLB Controller Support from
  * Wolfram Podien
  * Rohoefe 3
  * D28832 Achim
@@ -34,7 +34,7 @@
  * #define UMC_DRIVE0 11
  * in the beginning of the driver, which sets the speed of drive 0 to 11 (there
  * are some lines present). 0 - 11 are allowed speed values. These values are
- * the results from the DOS speed test program supplied from UMC. 11 is the 
+ * the results from the DOS speed test program supplied from UMC. 11 is the
  * highest speed (about PIO mode 3)
  */
 #define REALLY_SLOW_IO		/* some systems can safely undef this */
@@ -92,13 +92,11 @@
 	out_umc (0xd7,(speedtab[0][speeds[2]] | (speedtab[0][speeds[3]]<<4)));
 	out_umc (0xd6,(speedtab[0][speeds[0]] | (speedtab[0][speeds[1]]<<4)));
 	tmp = 0;
-	for (i = 3; i >= 0; i--)
-	{
+	for (i = 3; i >= 0; i--) {
 		tmp = (tmp << 2) | speedtab[1][speeds[i]];
 	}
 	out_umc (0xdc,tmp);
-	for (i = 0;i < 4; i++)
-	{
+	for (i = 0;i < 4; i++) {
 		out_umc (0xd0+i,speedtab[2][speeds[i]]);
 		out_umc (0xd8+i,speedtab[2][speeds[i]]);
 	}
@@ -108,10 +106,9 @@
 		speeds[0], speeds[1], speeds[2], speeds[3]);
 }
 
-static void tune_umc (ide_drive_t *drive, byte pio)
+static void tune_umc(struct ata_device *drive, byte pio)
 {
 	unsigned long flags;
-	ide_hwgroup_t *hwgroup = ide_hwifs[drive->channel->index ^ 1].hwgroup;
 
 	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
@@ -121,16 +118,12 @@
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n", drive->name, pio, pio_to_umc[pio]);
 	save_flags(flags);	/* all CPUs */
 	cli();			/* all CPUs */
-	if (hwgroup && hwgroup->handler != NULL) {
-		printk("umc8672: other interface is busy: exiting tune_umc()\n");
-	} else {
-		current_speeds[drive->name[2] - 'a'] = pio_to_umc[pio];
-		umc_set_speeds (current_speeds);
-	}
+	current_speeds[drive->name[2] - 'a'] = pio_to_umc[pio];
+	umc_set_speeds (current_speeds);
 	restore_flags(flags);	/* all CPUs */
 }
 
-void __init init_umc8672 (void)	/* called from ide.c */
+void __init init_umc8672(void)	/* called from ide.c */
 {
 	unsigned long flags;
 
diff -urN linux-2.5.15/include/asm-cris/ide.h linux/include/asm-cris/ide.h
--- linux-2.5.15/include/asm-cris/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-cris/ide.h	2002-05-14 00:32:15.000000000 +0200
@@ -90,9 +90,6 @@
 
 /* some configuration options we don't need */
 
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #undef SUPPORT_SLOW_DATA_PORTS
 #define SUPPORT_SLOW_DATA_PORTS	0
 
diff -urN linux-2.5.15/include/asm-m68k/ide.h linux/include/asm-m68k/ide.h
--- linux-2.5.15/include/asm-m68k/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-m68k/ide.h	2002-05-14 00:31:49.000000000 +0200
@@ -83,9 +83,6 @@
 #undef SUPPORT_SLOW_DATA_PORTS
 #define SUPPORT_SLOW_DATA_PORTS 0
 
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 /* this definition is used only on startup .. */
 #undef HD_DATA
 #define HD_DATA NULL
diff -urN linux-2.5.15/include/asm-mips/ide.h linux/include/asm-mips/ide.h
--- linux-2.5.15/include/asm-mips/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-mips/ide.h	2002-05-14 00:31:56.000000000 +0200
@@ -65,9 +65,6 @@
 #endif
 }
 
-#undef  SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IDE_H */
diff -urN linux-2.5.15/include/asm-ppc/ide.h linux/include/asm-ppc/ide.h
--- linux-2.5.15/include/asm-ppc/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-ppc/ide.h	2002-05-14 00:31:36.000000000 +0200
@@ -43,8 +43,6 @@
 
 #undef	SUPPORT_SLOW_DATA_PORTS
 #define	SUPPORT_SLOW_DATA_PORTS	0
-#undef	SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC	0
 
 #define ide__sti()	__sti()
 
diff -urN linux-2.5.15/include/asm-sparc/ide.h linux/include/asm-sparc/ide.h
--- linux-2.5.15/include/asm-sparc/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-sparc/ide.h	2002-05-14 00:32:09.000000000 +0200
@@ -76,9 +76,6 @@
 #undef  SUPPORT_SLOW_DATA_PORTS
 #define SUPPORT_SLOW_DATA_PORTS 0
 
-#undef  SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #undef  HD_DATA
 #define HD_DATA ((ide_ioreg_t)0)
 
diff -urN linux-2.5.15/include/asm-sparc64/ide.h linux/include/asm-sparc64/ide.h
--- linux-2.5.15/include/asm-sparc64/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/asm-sparc64/ide.h	2002-05-14 00:32:03.000000000 +0200
@@ -72,9 +72,6 @@
 #undef  SUPPORT_SLOW_DATA_PORTS
 #define SUPPORT_SLOW_DATA_PORTS 0
 
-#undef  SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #undef  HD_DATA
 #define HD_DATA ((ide_ioreg_t)0)
 
diff -urN linux-2.5.15/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.15/include/linux/ide.h	2002-05-14 00:50:24.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-14 01:08:54.000000000 +0200
@@ -40,9 +40,6 @@
 
 /* Right now this is only needed by a promise controlled.
  */
-#ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
-# define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
-#endif
 #ifndef DISK_RECOVERY_TIME		/* off=0; on=access_delay_time */
 # define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
 #endif
@@ -74,8 +71,6 @@
  */
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
 
-#define HWGROUP(drive)		(drive->channel->hwgroup)
-
 /*
  * Definitions for accessing IDE controller registers
  */
@@ -444,18 +439,16 @@
 	IDE_DMA		/* DMA in progress */
 };
 
-typedef struct hwgroup_s {
-	/* FIXME: We should look for busy request queues instead of looking at
-	 * the !NULL state of this field.
-	 */
-	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
-} ide_hwgroup_t;
-
 struct ata_channel {
 	struct device	dev;		/* device handle */
 	int		unit;		/* channel number */
 
-	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
+	/* This lock is used to serialize requests on the same device queue or
+	 * between differen queues sharing the same irq line.
+	 */
+	spinlock_t *lock;
+
+	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	struct timer_list timer;	/* failsafe timer */
 	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long poll_timeout;	/* timeout value during polled operations */
@@ -777,11 +770,7 @@
 
 extern int system_bus_speed;
 
-/*
- * ide_stall_queue() can be used by a drive to give excess bandwidth back
- * to the hwgroup by sleeping for timeout jiffies.
- */
-void ide_stall_queue(struct ata_device *, unsigned long);
+extern void ide_stall_queue(struct ata_device *, unsigned long);
 
 /*
  * CompactFlash cards and their brethern pretend to be removable hard disks,

--------------050205050703000007090404--

