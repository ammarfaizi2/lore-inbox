Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318684AbSHAJlu>; Thu, 1 Aug 2002 05:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSHAJlu>; Thu, 1 Aug 2002 05:41:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12804 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318684AbSHAJjq>; Thu, 1 Aug 2002 05:39:46 -0400
Message-ID: <3D488361.4070604@evision.ag>
Date: Thu, 01 Aug 2002 02:40:01 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de, martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.29 IDE 110
Content-Type: multipart/mixed;
 boundary="------------090403010804080306020609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090403010804080306020609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Integrate patches by Adam J. Richter, Alan Cox and Andre Hedrick
    for CMD640 PCI configuration space register access.

- cs5530 patches by Adam J. Richter. Small indent style adjustments.

- qd65xx cli()/sti() adjustments.

- Fix bogous command in ide.c pointed out by Peter Vendroviec.

- Eliminate ide_stall_queue(). For those worried: we didn't sleep at
    all.

- Eliminate support for "sector remapping". loop devices can handle
    stuff like that. All the custom DOS high system memmory loaded
    BIOS workaround tricks are obsolete right now. If anywhere it should
    be the FAT filesystem code which should be clever enough to deal with
    it by adjusting it's read/write methods.

- PCI "scather gather" allocation handling revamp by Adam J. Richter.

- Simplify do_ide_request after ->sleep removal.

- Make do_ide_request preferr to handle the device matching the request
    queue it was called for first. RQ-queues are unique for devices.
    In a next step queuedata will be changed to point to the device
    not the channel.


--------------090403010804080306020609
Content-Type: text/plain;
 name="ide-110.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-110.diff"

diff -durNp -X /tmp/diff.V3naum linux-2.5.29/Documentation/ide.txt linux/Documentation/ide.txt
--- linux-2.5.29/Documentation/ide.txt	2002-07-29 22:51:57.000000000 +0200
+++ linux/Documentation/ide.txt	2002-07-30 03:48:20.000000000 +0200
@@ -46,7 +46,7 @@ Common pitfalls:
 - If you mix devices on the same cable, please consider using similar devices
   in respect of the data transfer mode they support.
 
-- Even better tru to stick to the same vendor and device type on the same
+- Even better try to stick to the same vendor and device type on the same
   cable.
 
 ================================================================================
@@ -66,7 +66,8 @@ sixth..     ide5, usually PCI, probed
 To access devices on interfaces > ide0, device entries please make sure that
 device files for them are present in /dev.  If not, please create such
 entries, by simply running the included shell script:
-/usr/src/linux/scripts/MAKEDEV.ide
+
+	/usr/src/linux/scripts/MAKEDEV.ide
 
 This driver automatically probes for most IDE interfaces (including all PCI
 ones), for the drives/geometries attached to those interfaces, and for the IRQ
@@ -192,11 +193,10 @@ and still allows newer hardware to run o
 under control of ide.c.   To have ide.c also "take over" the primary
 IDE port in this situation, use the "command line" parameter:  ide0=0x1f0
 
-The IDE driver is partly modularized.  The high level disk/cdrom/tape/floppy
+The IDE driver is modularized.  The high level disk/CD-ROM/tape/floppy
 drivers can always be compiled as loadable modules, the chipset drivers
 can only be compiled into the kernel, and the core code (ide.c) can be
-compiled as a loadable module provided no chipset support and no special
-partition table translations are needed.
+compiled as a loadable module provided no chipset support is needed.
 
 When using ide.c/ide-tape.c as modules in combination with kerneld, add:
 
@@ -214,8 +214,9 @@ driver using the "options=" keyword to i
 
 ================================================================================
 
-Summary of ide driver parameters for kernel "command line":
-----------------------------------------------------------
+Summary of ide driver parameters for kernel command line
+--------------------------------------------------------
+
  "hdx="  is recognized for all "x" from "a" to "h", such as "hdc".
  
  "idex=" is recognized for all "x" from "0" to "3", such as "ide1".
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.29/drivers/ide/cmd640.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/cmd640.c	2002-07-31 23:00:43.000000000 +0200
@@ -109,6 +109,7 @@
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 
@@ -222,10 +223,10 @@ static void put_cmd640_reg_pci1 (unsigne
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci1 (unsigned short reg)
@@ -233,10 +234,10 @@ static u8 get_cmd640_reg_pci1 (unsigned 
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	b = inb_p((reg & 3) | 0xcfc);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 	return b;
 }
 
@@ -246,11 +247,11 @@ static void put_cmd640_reg_pci2 (unsigne
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 }
 
 static u8 get_cmd640_reg_pci2 (unsigned short reg)
@@ -258,11 +259,11 @@ static u8 get_cmd640_reg_pci2 (unsigned 
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outb_p(0x10, 0xcf8);
 	b = inb_p(cmd640_key + reg);
 	outb_p(0, 0xcf8);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 	return b;
 }
 
@@ -272,10 +273,10 @@ static void put_cmd640_reg_vlb (unsigned
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cmd640_lock, flags);
+	spin_lock_irqsave(&pci_lock, flags);
 	outb_p(reg, cmd640_key);
 	outb_p(val, cmd640_key + 4);
-	spin_unlock_irqrestore(&cmd640_lock, flags);
+	spin_unlock_irqrestore(&pci_lock, flags);
 }
 
 static u8 get_cmd640_reg_vlb (unsigned short reg)
@@ -694,6 +695,57 @@ out_lock:
 
 #endif
 
+/**
+ *	pci_conf1	-	check for PCI type 1 configuration
+ *	
+ *	Issues a safe probe sequence for PCI configuration type 1 and
+ *	returns non-zero if conf1 is supported. Takes the pci_config lock
+ */
+ 
+static int pci_conf1(void)
+{
+	u32 tmp;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&pci_lock, flags);
+
+	OUT_BYTE(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000) {
+		spin_unlock_irqrestore(&pci_lock, flags);
+		outl(tmp, 0xCF8);
+		return 1;
+	}
+	outl(tmp, 0xCF8);
+	spin_unlock_irqrestore(&pci_lock, flags);
+	return 0;
+}
+
+/**
+ *	pci_conf2	-	check for PCI type 2 configuration
+ *	
+ *	Issues a safe probe sequence for PCI configuration type 2 and
+ *	returns non-zero if conf2 is supported. Takes the pci_config lock.
+ */
+ 
+
+static int pci_conf2(void)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&pci_lock, flags);
+	
+	OUT_BYTE(0x00, 0xCFB);
+	OUT_BYTE(0x00, 0xCF8);
+	OUT_BYTE(0x00, 0xCFA);
+	if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCFA) == 0x00) {
+		spin_unlock_irqrestore(&pci_lock, flags);
+		return 1;
+	}
+	spin_unlock_irqrestore(&pci_lock, flags);
+	return 0;
+}
+
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
@@ -711,9 +763,9 @@ int __init ide_probe_for_cmd640x(void)
 		bus_type = "VLB";
 	} else {
 		cmd640_vlb = 0;
-		if (probe_for_cmd640_pci1())
+		if (pci_conf1() && probe_for_cmd640_pci1())
 			bus_type = "PCI (type1)";
-		else if (probe_for_cmd640_pci2())
+		else if (pci_conf2() && probe_for_cmd640_pci2())
 			bus_type = "PCI (type2)";
 		else
 			return 0;
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.29/drivers/ide/cs5530.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-07-31 23:12:13.000000000 +0200
@@ -58,19 +58,18 @@ static unsigned int cs5530_pio_timings[2
  * After chip reset, the PIO timings are set to 0x0000e132, which is not valid.
  */
 #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
-#define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->unit ? 0x30 : 0x20))
+#define CS5530_BASEREG(ch)	(((ch)->dma_base & ~0xf) + ((ch)->unit ? 0x30 : 0x20))
 
 /*
- * cs5530_tuneproc() handles selection/setting of PIO modes
- * for both the chipset and drive.
+ * Handle selection/setting of PIO modes for both the chipset and drive.
  *
- * The ide_init_cs5530() routine guarantees that all drives
- * will have valid default PIO timings set up before we get here.
+ * The ide_init_cs5530() routine guarantees that all drives will have valid
+ * default PIO timings set up before we get here.
  */
 static void cs5530_tuneproc(struct ata_device *drive, u8 pio)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned int	format, basereg = CS5530_BASEREG(hwif);
+	unsigned int format;
+	unsigned int basereg = CS5530_BASEREG(drive->channel);
 
 	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
@@ -84,25 +83,26 @@ static void cs5530_tuneproc(struct ata_d
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+
 /*
- * cs5530_config_dma() handles selection/setting of DMA/UDMA modes
- * for both the chipset and drive.
+ * Handle selection/setting of DMA/UDMA modes for both the chipset and drive.
  */
 static int cs5530_config_dma(struct ata_device *drive)
 {
-	int			udma_ok = 1, mode = 0;
-	struct ata_channel *hwif = drive->channel;
-	int			unit = drive->select.b.unit;
-	struct ata_device		*mate = &hwif->drives[unit^1];
-	struct hd_driveid	*id = drive->id;
-	unsigned int		basereg, reg, timings;
+	int udma_ok = 1;
+	int mode = 0;
+	struct ata_channel *ch = drive->channel;
+	int unit = drive->select.b.unit;
+	struct ata_device *mate = &ch->drives[unit^1];
+	struct hd_driveid *id = drive->id;
+	unsigned int basereg, reg, timings;
 
 
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
 	udma_enable(drive, 0, 0);
-	outb(inb(hwif->dma_base+2)&~(unit?0x40:0x20), hwif->dma_base+2); /* clear DMA_capable bit */
+	outb(inb(ch->dma_base+2)&~(unit?0x40:0x20), ch->dma_base+2); /* clear DMA_capable bit */
 
 	/*
 	 * The CS5530 specifies that two drives sharing a cable cannot
@@ -129,7 +129,7 @@ static int cs5530_config_dma(struct ata_
 	 * Now see what the current drive is capable of,
 	 * selecting UDMA only if the mate said it was ok.
 	 */
-	if (id && (id->capability & 1) && hwif->autodma && !udma_black_list(drive)) {
+	if (id && (id->capability & 1) && ch->autodma && !udma_black_list(drive)) {
 		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
 			if      (id->dma_ultra & 4)
 				mode = XFER_UDMA_2;
@@ -168,7 +168,7 @@ static int cs5530_config_dma(struct ata_
 			printk("%s: cs5530_config_dma: huh? mode=%02x\n", drive->name, mode);
 			return 1;	/* failure */
 	}
-	basereg = CS5530_BASEREG(hwif);
+	basereg = CS5530_BASEREG(ch);
 	reg = inl(basereg+4);			/* get drive0 config register */
 	timings |= reg & 0x80000000;		/* preserve PIO format bit */
 	if (unit == 0) {			/* are we configuring drive0? */
@@ -181,7 +181,7 @@ static int cs5530_config_dma(struct ata_
 		outl(reg,     basereg+4);	/* write drive0 config register */
 		outl(timings, basereg+12);	/* write drive1 config register */
 	}
-	outb(inb(hwif->dma_base+2)|(unit?0x40:0x20), hwif->dma_base+2);	/* set DMA_capable bit */
+	outb(inb(ch->dma_base+2)|(unit?0x40:0x20), ch->dma_base+2);	/* set DMA_capable bit */
 
 	/*
 	 * Finally, turn DMA on in software, and exit.
@@ -202,7 +202,8 @@ static int cs5530_udma_setup(struct ata_
  */
 static unsigned int __init pci_init_cs5530(struct pci_dev *dev)
 {
-	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
+	struct pci_dev *master_0 = NULL;
+	struct pci_dev *cs5530_0 = NULL;
 	unsigned short pcicmd = 0;
 	unsigned long flags;
 
@@ -280,35 +281,40 @@ static unsigned int __init pci_init_cs55
 }
 
 /*
- * This gets invoked by the IDE driver once for each channel,
- * and performs channel-specific pre-initialization before drive probing.
+ * This gets invoked once for each channel, and performs channel-specific
+ * pre-initialization before drive probing.
  */
-static void __init ide_init_cs5530(struct ata_channel *hwif)
+static void __init ide_init_cs5530(struct ata_channel *ch)
 {
-	u32 basereg, d0_timings;
+	u32 basereg;
+	u32 d0_timings;
 
-	hwif->serialized = 1;
+	ch->serialized = 1;
+
+	/* We think a 64kB transfer is a 0 byte transfer, so set our
+	   segment size to be one sector smaller than 64kB. */
+	ch->max_segment_size = (1<<16) - 512;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->dma_base) {
-		hwif->highmem = 1;
-		hwif->udma_setup = cs5530_udma_setup;
+	if (ch->dma_base) {
+		ch->highmem = 1;
+		ch->udma_setup = cs5530_udma_setup;
 	}
 #endif
 
-		hwif->tuneproc = &cs5530_tuneproc;
-		basereg = CS5530_BASEREG(hwif);
-		d0_timings = inl(basereg+0);
-		if (CS5530_BAD_PIO(d0_timings)) {	/* PIO timings not initialized? */
-			outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+0);
-			if (!hwif->drives[0].autotune)
-				hwif->drives[0].autotune = 1;	/* needs autotuning later */
-		}
-		if (CS5530_BAD_PIO(inl(basereg+8))) {	/* PIO timings not initialized? */
-			outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+8);
-			if (!hwif->drives[1].autotune)
-				hwif->drives[1].autotune = 1;	/* needs autotuning later */
-		}
+	ch->tuneproc = &cs5530_tuneproc;
+	basereg = CS5530_BASEREG(ch);
+	d0_timings = inl(basereg+0);
+	if (CS5530_BAD_PIO(d0_timings)) {	/* PIO timings not initialized? */
+		outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+0);
+		if (!ch->drives[0].autotune)
+			ch->drives[0].autotune = 1;	/* needs autotuning later */
+	}
+	if (CS5530_BAD_PIO(inl(basereg+8))) {	/* PIO timings not initialized? */
+		outl(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+8);
+		if (!ch->drives[1].autotune)
+			ch->drives[1].autotune = 1;	/* needs autotuning later */
+	}
 }
 
 
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.29/drivers/ide/ide.c	2002-07-27 04:58:46.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-08-01 00:22:29.000000000 +0200
@@ -481,12 +481,9 @@ ide_startstop_t ata_error(struct ata_dev
 		udelay(1);
 		ata_irq_enable(drive, 0);
 
-		/* This command actually looks suspicious, since I couldn't
-		 * find it in any standard document.
-		 */
 		OUT_BYTE(0x04, ch->io_ports[IDE_CONTROL_OFFSET]);
 		udelay(10);
-		OUT_BYTE(WIN_NOP, ch->io_ports[IDE_CONTROL_OFFSET]);
+		OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
 		ret = ata_status_poll(drive, 0, BUSY_STAT, WAIT_WORSTCASE, NULL);
 		ata_mask(drive);
 
@@ -503,161 +500,121 @@ ide_startstop_t ata_error(struct ata_dev
 }
 
 /*
- * This is used by a drive to give excess bandwidth back by sleeping for
- * timeout jiffies.
- */
-void ide_stall_queue(struct ata_device *drive, unsigned long timeout)
-{
-	if (timeout > WAIT_WORSTCASE)
-		timeout = WAIT_WORSTCASE;
-	drive->sleep = timeout + jiffies;
-}
-
-/*
  * Issue a new request.
  * Caller must have already done spin_lock_irqsave(channel->lock, ...)
  */
 void do_ide_request(request_queue_t *q)
 {
+	/* FIXME: queuedata should contain the device instead.
+	 */
 	struct ata_channel *channel = q->queuedata;
 
 	while (!test_and_set_bit(IDE_BUSY, channel->active)) {
-		struct ata_channel *ch;
 		struct ata_device *drive = NULL;
 		unsigned int unit;
 		ide_startstop_t ret;
 
 		/*
-		 * Select the next device which will be serviced.  This selects
-		 * only between devices on the same channel, since everything
-		 * else will be scheduled on the queue level.
+		 * Select the device corresponding to the queue.
 		 */
-
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			struct ata_device *tmp = &channel->drives[unit];
 
-			if (!tmp->present)
-				continue;
-
-			/* There are no requests pending for this device.
-			 */
-			if (blk_queue_empty(&tmp->queue))
-				continue;
-
-
-			/* This device still wants to remain idle.
-			 */
-			if (tmp->sleep && time_after(tmp->sleep, jiffies))
-				continue;
-
-			/* Take this device, if there is no device choosen thus
-			 * far or which is more urgent.
-			 */
-			if (!drive || (tmp->sleep && (!drive->sleep || time_after(drive->sleep, tmp->sleep)))) {
-				if (!blk_queue_plugged(&tmp->queue))
-					drive = tmp;
+			if (&tmp->queue == q) {
+				drive = tmp;
+				break;
 			}
 		}
 
-		if (!drive) {
-			unsigned long sleep = 0;
+		if (drive) {
+			/* No request pending?! */
+			if (blk_queue_empty(&drive->queue))
+				drive = NULL;
+			/* Still resorting requests?! */
+			else if (blk_queue_plugged(&drive->queue))
+				drive = NULL;
+		}
 
+		if (!drive) {
+			/* We should never get here! */
+			/* Unless someone called us from IRQ context after
+			 * finishing the actual request already. (Shrug!)
+			 */
+			// printk(KERN_INFO "no device found!\n");
 			for (unit = 0; unit < MAX_DRIVES; ++unit) {
 				struct ata_device *tmp = &channel->drives[unit];
 
 				if (!tmp->present)
 					continue;
 
-				/* This device is sleeping and waiting to be serviced
-				 * earlier than any other device we checked thus far.
+				/* There are no requests pending for this
+				 * device.
 				 */
-				if (tmp->sleep && (!sleep || time_after(sleep, tmp->sleep)))
-					sleep = tmp->sleep;
-			}
+				if (blk_queue_empty(&tmp->queue))
+					continue;
 
-			if (sleep) {
-				/*
-				 * Take a short snooze, and then wake up again.  Just
-				 * in case there are big differences in relative
-				 * throughputs.. don't want to hog the cpu too much.
+				/* Take this device, if there is no device
+				 * choosen thus far and the queue is ready for
+				 * processing.
 				 */
+				if (!drive && !blk_queue_plugged(&tmp->queue))
+					drive = tmp;
+			}
+		}
 
-				if (time_after(jiffies, sleep - WAIT_MIN_SLEEP))
-					sleep = jiffies + WAIT_MIN_SLEEP;
-#if 1
-				if (timer_pending(&channel->timer))
-					printk(KERN_ERR "%s: timer already active\n", __FUNCTION__);
-#endif
-				set_bit(IDE_SLEEP, channel->active);
-				mod_timer(&channel->timer, sleep);
-
-				/*
-				 * We purposely leave us busy while sleeping becouse we
-				 * are prepared to handle the IRQ from it.
-				 *
-				 * FIXME: Make sure sleeping can't interferre with
-				 * operations of other devices on the same channel.
-				 */
-			} else {
-				/* FIXME: use queue plugging instead of active to block
-				 * upper layers from stomping on us */
-				/* Ugly, but how can we sleep for the lock otherwise?
-				 * */
+		if (!drive) {
+			/* Ugly, but how can we sleep for the lock otherwise?
+			 */
 
-				ide_release_lock(&ide_irq_lock);/* for atari only */
-				clear_bit(IDE_BUSY, channel->active);
+			ide_release_lock(&ide_irq_lock);/* for atari only */
+			clear_bit(IDE_BUSY, channel->active);
 
-				/* All requests are done.
-				 *
-				 * Disable IRQs from the last drive on this channel, to
-				 * make sure that it wan't throw stones at us when we
-				 * are not prepared to take them.
-				 */
+			/* All requests are done.
+			 *
+			 * Disable IRQs from the last drive on this channel, to
+			 * make sure that it wan't throw stones at us when we
+			 * are not prepared to take them.
+			 */
 
-				if (channel->drive && !channel->drive->using_tcq)
-					ata_irq_enable(channel->drive, 0);
-			}
+			if (channel->drive && !channel->drive->using_tcq)
+				ata_irq_enable(channel->drive, 0);
 
 			return;
 		}
 
 		/* Remember the last drive we where acting on.
 		 */
-		ch = drive->channel;
-		ch->drive = drive;
+		channel->drive = drive;
 
 		/* Feed commands to a drive until it barfs.
 		 */
 		do {
 			struct request *rq = NULL;
-			sector_t block;
 
-			/* Abort early if we can't queue another command. for non tcq,
-			 * ata_can_queue is always 1 since we never get here unless the
-			 * drive is idle.
+			/* Abort early if we can't queue another command. for
+			 * non tcq, ata_can_queue is always 1 since we never
+			 * get here unless the drive is idle.
 			 */
 
 			if (!ata_can_queue(drive)) {
 				if (!ata_pending_commands(drive)) {
-					clear_bit(IDE_BUSY, ch->active);
+					clear_bit(IDE_BUSY, channel->active);
 					if (drive->using_tcq)
 						ata_irq_enable(drive, 0);
 				}
 				break;
 			}
 
-			drive->sleep = 0;
-
-			if (test_bit(IDE_DMA, ch->active)) {
+			if (test_bit(IDE_DMA, channel->active)) {
 				printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
 				break;
 			}
 
-			/* There's a small window between where the queue could be
-			 * replugged while we are in here when using tcq (in which case
-			 * the queue is probably empty anyways...), so check and leave
-			 * if appropriate. When not using tcq, this is still a severe
-			 * BUG!
+			/* There's a small window between where the queue could
+			 * be replugged while we are in here when using tcq (in
+			 * which case the queue is probably empty anyways...),
+			 * so check and leave if appropriate. When not using
+			 * tcq, this is still a severe BUG!
 			 */
 
 			if (blk_queue_plugged(&drive->queue)) {
@@ -667,7 +624,7 @@ void do_ide_request(request_queue_t *q)
 
 			if (!(rq = elv_next_request(&drive->queue))) {
 				if (!ata_pending_commands(drive)) {
-					clear_bit(IDE_BUSY, ch->active);
+					clear_bit(IDE_BUSY, channel->active);
 					if (drive->using_tcq)
 						ata_irq_enable(drive, 0);
 				}
@@ -685,37 +642,19 @@ void do_ide_request(request_queue_t *q)
 
 			drive->rq = rq;
 
-			spin_unlock(ch->lock);
+			spin_unlock(channel->lock);
 			/* allow other IRQs while we start this request */
 			local_irq_enable();
 
 			/*
 			 * This initiates handling of a new I/O request.
 			 */
-
 			BUG_ON(!(rq->flags & REQ_STARTED));
 
-#ifdef DEBUG
-			printk("%s: %s: current=0x%08lx\n", ch->name, __FUNCTION__, (unsigned long) rq);
-#endif
-
 			/* bail early if we've exceeded max_failures */
 			if (drive->max_failures && (drive->failures > drive->max_failures))
 				goto kill_rq;
 
-			block = rq->sector;
-
-			/* Strange disk manager remap.
-			 */
-			if (rq->flags & REQ_CMD)
-				if (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)
-					block += drive->sect0;
-
-			/* Yecch - this will shift the entire interval, possibly killing some
-			 * innocent following sector.
-			 */
-			if (block == 0 && drive->remap_0_to_1 == 1)
-				block = 1;  /* redirect MBR access to EZ-Drive partn table */
 
 			ata_select(drive, 0);
 			ret = ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
@@ -737,9 +676,9 @@ void do_ide_request(request_queue_t *q)
 			 * handler down to the device type driver.
 			 */
 
-			if (ata_ops(drive)->do_request) {
-				ret = ata_ops(drive)->do_request(drive, rq, block);
-			} else {
+			if (ata_ops(drive)->do_request)
+				ret = ata_ops(drive)->do_request(drive, rq, rq->sector);
+			else {
 kill_rq:
 				if (ata_ops(drive) && ata_ops(drive)->end_request)
 					ata_ops(drive)->end_request(drive, rq, 0);
@@ -748,13 +687,9 @@ kill_rq:
 				ret = ATA_OP_FINISHED;
 
 			}
-			spin_lock_irq(ch->lock);
-
+			spin_lock_irq(channel->lock);
 			/* continue if command started, so we are busy */
 		} while (ret != ATA_OP_CONTINUES);
-		/* make sure the BUSY bit is set */
-		/* FIXME: perhaps there is some place where we miss to set it? */
-		//		set_bit(IDE_BUSY, ch->active);
 	}
 }
 
@@ -1200,6 +1135,5 @@ EXPORT_SYMBOL(ata_dump);
 EXPORT_SYMBOL(ata_error);
 
 EXPORT_SYMBOL(ata_end_request);
-EXPORT_SYMBOL(ide_stall_queue);
 
 EXPORT_SYMBOL(ide_setup_ports);
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.29/drivers/ide/ide-cd.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-07-30 00:06:42.000000000 +0200
@@ -1617,16 +1617,11 @@ ide_cdrom_do_request(struct ata_device *
 
 	if (rq->flags & REQ_CMD) {
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
-			unsigned long elpased = jiffies - info->start_seek;
-
-			if (!ata_status(drive, SEEK_STAT, 0)) {
-				if (elpased < IDECD_SEEK_TIMEOUT) {
-					ide_stall_queue(drive, IDECD_SEEK_TIMER);
-					return ATA_OP_FINISHED;
-				}
+			if (ATA_OP_READY != ata_status_poll(drive, SEEK_STAT, 0, IDECD_SEEK_TIMEOUT, rq)) {
 				printk ("%s: DSC timeout\n", drive->name);
-			}
-			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
+				CDROM_CONFIG_FLAGS(drive)->seeking = 0;
+			} else
+				return ATA_OP_FINISHED;
 		}
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			ret = cdrom_start_seek(drive, rq, block);
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.29/drivers/ide/ide-disk.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-07-30 03:37:53.000000000 +0200
@@ -723,7 +723,7 @@ static int idedisk_check_media_change(st
 
 static sector_t idedisk_capacity(struct ata_device *drive)
 {
-	return drive->capacity - drive->sect0;
+	return drive->capacity;
 }
 
 /*
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.29/drivers/ide/ide-tape.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-07-31 22:52:35.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/atapi.h>
+#include <linux/delay.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1067,7 +1068,8 @@ static void idetape_analyze_error(struct
 
 	if (tape->onstream && result->sense_key == 2 && result->asc == 0x53 && result->ascq == 2) {
 		clear_bit(PC_DMA_ERROR, &pc->flags);
-		ide_stall_queue(drive, HZ / 2);
+		/* FIXME: we should use timeouts here */
+		mdelay(HZ / 2 * 1000);
 		return;
 	}
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -1434,7 +1436,8 @@ static void idetape_postpone_request(str
 		printk(KERN_INFO "ide-tape: idetape_postpone_request\n");
 #endif
 	tape->postponed_rq = rq;
-	ide_stall_queue(drive, tape->dsc_polling_frequency);
+	/* FIXME: we should use timeouts here */
+	mdelay(tape->dsc_polling_frequency * 1000);
 }
 
 /*
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.29/drivers/ide/main.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/main.c	2002-07-31 23:13:41.000000000 +0200
@@ -176,18 +176,26 @@ static void init_hwif_data(struct ata_ch
 	};
 
 	unsigned int unit;
-	hw_regs_t hw;
 
 	/* bulk initialize channel & drive info with zeros */
 	memset(ch, 0, sizeof(struct ata_channel));
-	memset(&hw, 0, sizeof(hw_regs_t));
 
 	/* fill in any non-zero initial values */
 	ch->index = index;
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &ch->irq);
+	ide_init_hwif_ports(&ch->hw, ide_default_io_base(index), 0, &ch->irq);
 
-	memcpy(&ch->hw, &hw, sizeof(hw));
-	memcpy(ch->io_ports, hw.io_ports, sizeof(hw.io_ports));
+	memcpy(ch->io_ports, ch->hw.io_ports, sizeof(ch->hw.io_ports));
+
+	/* Most controllers cannot do transfers across 64kB boundaries.
+	   trm290 can do transfers within a 4GB boundary, so it changes
+	   this mask accordingly. */
+	ch->seg_boundary_mask = 0xffff;
+
+	/* Some chipsets (cs5530, any others?) think a 64kB transfer
+	   is 0 byte transfer, so set the limit one sector smaller.
+	   In the future, we may default to 64kB transfers and let
+	   invidual chipsets with this problem change ch->max_segment_size. */
+	ch->max_segment_size = (1<<16) - 512;
 
 	ch->noprobe	= !ch->io_ports[IDE_DATA_OFFSET];
 #ifdef CONFIG_BLK_DEV_HD
@@ -728,7 +736,7 @@ static int __init ata_hd_setup(char *s)
 	if (s[0] >= 'a' && s[0] <= max_drive) {
 		static const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
-				"slow", "flash", "remap", "noremap", "scsi", NULL};
+				"slow", "flash", "scsi", NULL};
 		unit = s[0] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -783,13 +791,7 @@ static int __init ata_hd_setup(char *s)
 			case -9: /* "flash" */
 				drive->ata_flash = 1;
 				goto done;
-			case -10: /* "remap" */
-				drive->remap_0_to_1 = 1;
-				goto done;
-			case -11: /* "noremap" */
-				drive->remap_0_to_1 = 2;
-				goto done;
-			case -12: /* "scsi" */
+			case -10: /* "scsi" */
 #if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
 				drive->scsi = 1;
 				goto done;
@@ -836,14 +838,14 @@ int __init ide_setup(char *s)
 	unsigned int hw;
 	const char max_ch  = '0' + (MAX_HWIFS - 1);
 
-	printk(KERN_INFO  "ide_setup: ide%s", s);
+	printk(KERN_INFO  "ide%s", s);
 	init_global_data();
 
 #ifdef CONFIG_BLK_DEV_IDEDOUBLER
 	if (!strcmp(s, "=doubler")) {
 		extern int ide_doubler;
 
-		printk(KERN_INFO" : Enabled support for IDE doublers\n");
+		printk(KERN_INFO" : Enabled support for ATA doublers\n");
 		ide_doubler = 1;
 		return 1;
 	}
@@ -888,7 +890,7 @@ int __init ide_setup(char *s)
 		ch = &ide_hwifs[hw];
 
 
-		switch (match_parm(s+1, ide_options, vals, 1)) {
+		switch (match_parm(s + 1, ide_options, vals, 1)) {
 			case -7: /* ata66 */
 #ifdef CONFIG_PCI
 				ch->udma_four = 1;
@@ -929,7 +931,7 @@ int __init ide_setup(char *s)
 		/*
 		 * Check for specific chipset name
 		 */
-		i = match_parm(s+1, ide_words, vals, 3);
+		i = match_parm(s + 1, ide_words, vals, 3);
 
 		/*
 		 * Cryptic check to ensure chipset not already set for a channel:
@@ -956,7 +958,7 @@ int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_ALI14XX
 			case -6:  /* "ali14xx" */
 			{
-				extern void init_ali14xx (void);
+				extern void init_ali14xx(void);
 				init_ali14xx();
 				goto done;
 			}
@@ -964,7 +966,7 @@ int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_UMC8672
 			case -5:  /* "umc8672" */
 			{
-				extern void init_umc8672 (void);
+				extern void init_umc8672(void);
 				init_umc8672();
 				goto done;
 			}
@@ -972,7 +974,7 @@ int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_DTC2278
 			case -4:  /* "dtc2278" */
 			{
-				extern void init_dtc2278 (void);
+				extern void init_dtc2278(void);
 				init_dtc2278();
 				goto done;
 			}
@@ -988,7 +990,7 @@ int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -2:  /* "ht6560b" */
 			{
-				extern void init_ht6560b (void);
+				extern void init_ht6560b(void);
 				init_ht6560b();
 				goto done;
 			}
@@ -996,7 +998,7 @@ int __init ide_setup(char *s)
 #if CONFIG_BLK_DEV_QD65XX
 			case -1:  /* "qd65xx" */
 			{
-				extern void init_qd65xx (void);
+				extern void init_qd65xx(void);
 				init_qd65xx();
 				goto done;
 			}
@@ -1136,7 +1138,7 @@ int register_ata_driver(struct ata_opera
 EXPORT_SYMBOL(register_ata_driver);
 
 /*
- * Unregister an ATA subdriver for a particular device type.
+ * Unregister an ATA sub-driver for a particular device type.
  */
 void unregister_ata_driver(struct ata_operations *driver)
 {
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.29/drivers/ide/pcidma.c	2002-07-27 04:58:31.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-07-31 23:03:54.000000000 +0200
@@ -379,12 +379,6 @@ int udma_new_table(struct ata_device *dr
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned int *table = ch->dmatable_cpu;
-#ifdef CONFIG_BLK_DEV_TRM290
-	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
-#else
-	const int is_trm290_chipset = 0;
-#endif
-	unsigned int count = 0;
 	int i;
 	struct scatterlist *sg;
 
@@ -392,68 +386,29 @@ int udma_new_table(struct ata_device *dr
 	if (!i)
 		return 0;
 
-	sg = ch->sg_table;
-	while (i) {
-		u32 cur_addr;
-		u32 cur_len;
-
-		cur_addr = sg_dma_address(sg);
-		cur_len = sg_dma_len(sg);
-
-		/*
-		 * Fill in the dma table, without crossing any 64kB boundaries.
-		 * Most hardware requires 16-bit alignment of all blocks,
-		 * but the trm290 requires 32-bit alignment.
-		 */
-
-		while (cur_len) {
-			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
+	BUG_ON(i > PRD_ENTRIES);
 
-			if (count++ >= PRD_ENTRIES) {
-				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
-						count, ch->sg_nents, cur_len, cur_addr);
-				BUG();
-			}
+	sg = ch->sg_table;
+	while (i--) {
+		u32 cur_addr = sg_dma_address(sg);
+		u32 cur_len = sg_dma_len(sg) & 0xffff;
 
-			if (bcount > cur_len)
-				bcount = cur_len;
-			*table++ = cpu_to_le32(cur_addr);
-			xcount = bcount & 0xffff;
-			if (is_trm290_chipset)
-				xcount = ((xcount >> 2) - 1) << 16;
-			if (xcount == 0x0000) {
-		        /*
-			 * Most chipsets correctly interpret a length of
-			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
-			 * misinterprets it as zero (!). So here we break
-			 * the 64KB entry into two 32KB entries instead.
-			 */
-				if (count++ >= PRD_ENTRIES) {
-					pci_unmap_sg(ch->pci_dev, sg,
-						     ch->sg_nents,
-						     ch->sg_dma_direction);
-					return 0;
-				}
+		/* Delete this test after linux ~2.5.35, as we care
+		   about performance in this loop. */
+		BUG_ON(cur_len > ch->max_segment_size);
 
-				*table++ = cpu_to_le32(0x8000);
-				*table++ = cpu_to_le32(cur_addr + 0x8000);
-				xcount = 0x8000;
-			}
-			*table++ = cpu_to_le32(xcount);
-			cur_addr += bcount;
-			cur_len -= bcount;
-		}
+		*table++ = cpu_to_le32(cur_addr);
+		*table++ = cpu_to_le32(cur_len);
 
 		sg++;
-		i--;
 	}
 
-	if (!count)
-		printk(KERN_ERR "%s: empty DMA table?\n", ch->name);
-	else if (!is_trm290_chipset)
+#ifdef CONFIG_BLK_DEV_TRM290
+	if (ch->chipset == ide_trm290)
 		*--table |= cpu_to_le32(0x80000000);
+#endif
 
-	return count;
+	return ch->sg_nents;
 }
 
 /*
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.29/drivers/ide/probe.c	2002-07-29 21:27:35.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-07-31 23:05:16.000000000 +0200
@@ -41,19 +41,10 @@
 extern struct ata_device * get_info_ptr(kdev_t);
 
 /*
- * This is called from the partition-table code in pt/msdos.c.
- *
- * It has two tasks:
- *
- * (I) to handle Ontrack DiskManager by offsetting everything by 63 sectors,
- *  or to handle EZdrive by remapping sector 0 to sector 1.
- *
- * (II) to invent a translated geometry.
- *
- * Part (I) is suppressed if the user specifies the "noremap" option
- * on the command line.
+ * This is called from the partition-table code in pt/msdos.c
+ * to invent a translated geometry.
  *
- * Part (II) is suppressed if the user specifies an explicit geometry.
+ * This is suppressed if the user specifies an explicit geometry.
  *
  * The ptheads parameter is either 0 or tells about the number of
  * heads shown by the end of the first nonempty partition.
@@ -83,21 +74,6 @@ int ide_xlate_1024(kdev_t i_rdev, int xp
 	if (!drive)
 		return 0;
 
-	/* remap? */
-	if (drive->remap_0_to_1 != 2) {
-		if (xparm == 1) {		/* DM */
-			drive->sect0 = 63;
-			msg1 = " [remap +63]";
-			ret = 1;
-		} else if (xparm == -1) {	/* EZ-Drive */
-			if (drive->remap_0_to_1 == 0) {
-				drive->remap_0_to_1 = 1;
-				msg1 = " [remap 0->1]";
-				ret = 1;
-			}
-		}
-	}
-
 	/* There used to be code here that assigned drive->id->CHS to
 	 * drive->CHS and that to drive->bios_CHS. However, some disks have
 	 * id->C/H/S = 4092/16/63 but are larger than 2.1 GB.  In such cases
@@ -1007,7 +983,8 @@ static int init_irq(struct ata_channel *
 		q = &drive->queue;
 		q->queuedata = drive->channel;
 		blk_init_queue(q, do_ide_request, drive->channel->lock);
-		blk_queue_segment_boundary(q, 0xffff);
+		blk_queue_segment_boundary(q, ch->seg_boundary_mask);
+		blk_queue_max_segment_size(q, ch->max_segment_size);
 
 		/* ATA can do up to 128K per request, pdc4030 needs smaller limit */
 #ifdef CONFIG_BLK_DEV_PDC4030
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.29/drivers/ide/qd65xx.c	2002-07-29 22:51:57.000000000 +0200
+++ linux/drivers/ide/qd65xx.c	2002-07-29 23:45:01.000000000 +0200
@@ -262,15 +262,11 @@ static int __init qd_testreg(int port)
 {
 	u8 savereg;
 	u8 readreg;
-	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	restore_flags(flags);	/* all CPUs */
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.29/drivers/ide/trm290.c	2002-07-27 04:58:31.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-07-31 23:03:54.000000000 +0200
@@ -255,6 +255,7 @@ static void __init trm290_init_channel(s
 	struct pci_dev *dev = hwif->pci_dev;
 
 	hwif->chipset = ide_trm290;
+	hwif->seg_boundary_mask = 0xffffffff;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase)
 	{
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.29/drivers/ide/umc8672.c	2002-07-27 04:58:34.000000000 +0200
+++ linux/drivers/ide/umc8672.c	2002-07-29 23:41:53.000000000 +0200
@@ -108,19 +108,14 @@ static void umc_set_speeds(u8 speeds[])
 
 static void tune_umc(struct ata_device *drive, u8 pio)
 {
-	unsigned long flags;
-
 	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 	else
 		pio = min_t(u8, pio, 4);
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n", drive->name, pio, pio_to_umc[pio]);
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
 	current_speeds[drive->name[2] - 'a'] = pio_to_umc[pio];
 	umc_set_speeds (current_speeds);
-	restore_flags(flags);	/* all CPUs */
 }
 
 void __init init_umc8672(void)	/* called from ide.c */
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/drivers/pci/access.c linux/drivers/pci/access.c
--- linux-2.5.29/drivers/pci/access.c	2002-07-27 04:58:46.000000000 +0200
+++ linux/drivers/pci/access.c	2002-07-31 23:00:43.000000000 +0200
@@ -7,7 +7,7 @@
  * configuration space.
  */
 
-static spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  *  Wrappers for all PCI configuration access functions.  They just check
@@ -44,3 +44,4 @@ EXPORT_SYMBOL(pci_read_config_dword);
 EXPORT_SYMBOL(pci_write_config_byte);
 EXPORT_SYMBOL(pci_write_config_word);
 EXPORT_SYMBOL(pci_write_config_dword);
+EXPORT_SYMBOL(pci_lock);
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.29/include/linux/ide.h	2002-07-29 22:51:57.000000000 +0200
+++ linux/include/linux/ide.h	2002-07-31 23:03:54.000000000 +0200
@@ -764,8 +764,6 @@ struct ata_device {
 	request_queue_t	queue;		/* per device request queue */
 	struct request *rq;		/* current request */
 
-	unsigned long sleep;		/* sleep until this time */
-
 	u8	 retry_pio;		/* retrying dma capable host in pio */
 	u8	 state;			/* retry state */
 
@@ -785,7 +783,6 @@ struct ata_device {
 	unsigned atapi_overlap	: 1;	/* flag: ATAPI overlap (not supported) */
 	unsigned doorlocking	: 1;	/* flag: for removable only: door lock/unlock works */
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
-	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	u8		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
@@ -797,7 +794,6 @@ struct ata_device {
 	u8		mult_count;	/* current multiple sector setting */
 	u8		bad_wstat;	/* used for ignoring WRERR_STAT */
 	u8		nowerr;		/* used for ignoring WRERR_STAT */
-	u8		sect0;		/* offset of first sector for DM6:DDO */
 	u8		head;		/* "real" number of heads */
 	u8		sect;		/* "real" sectors per track */
 	u8		bios_head;	/* BIOS/fdisk/LILO number of heads */
@@ -947,6 +943,8 @@ struct ata_channel {
 	void (*udma_timeout) (struct ata_device *);
 	void (*udma_irq_lost) (struct ata_device *);
 
+	unsigned long	seg_boundary_mask;
+	unsigned int	max_segment_size;
 	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
 	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
 	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/include/linux/pci.h linux/include/linux/pci.h
--- linux-2.5.29/include/linux/pci.h	2002-07-27 04:58:37.000000000 +0200
+++ linux/include/linux/pci.h	2002-07-31 23:00:43.000000000 +0200
@@ -567,6 +567,8 @@ int pci_write_config_byte(struct pci_dev
 int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);
 
+extern spinlock_t pci_lock;
+
 int pci_enable_device(struct pci_dev *dev);
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
diff -durNp -X /tmp/diff.V3naum linux-2.5.29/sound/oss/i810_audio.c linux/sound/oss/i810_audio.c
--- linux-2.5.29/sound/oss/i810_audio.c	2002-07-27 04:58:41.000000000 +0200
+++ linux/sound/oss/i810_audio.c	2002-07-30 00:04:06.000000000 +0200
@@ -1733,7 +1733,6 @@ static int i810_ioctl(struct inode *inod
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
-		synchronize_irq(state->card->irq);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;

--------------090403010804080306020609--


