Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317139AbSFBHDv>; Sun, 2 Jun 2002 03:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSFBHDv>; Sun, 2 Jun 2002 03:03:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30995 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317139AbSFBHDh>; Sun, 2 Jun 2002 03:03:37 -0400
Message-ID: <3CF9B58B.9080509@evision-ventures.com>
Date: Sun, 02 Jun 2002 08:04:59 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 IDE 78
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050304000804000408090703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304000804000408090703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sat Jun  1 16:54:57 CEST 2002 ide-clean-78

- Move ide_fixstring() from ide.c to probe.c, since this is the place, where it's
   most used.

- Remove GET_STAT() - it's not used any longer.

- Remove last parameter of ide_error. Rename it to ata_error().

- Don't use ide_fixstring in qd65xx.c host chip driver. The model name is
   already fixed in probe.c.

- Invent ata_irq_enable() for the handling of the trice nIEN bit of the
   control register.  Consistently use ch->intrproc method every time we toggle
   this bit.  This simply wasn't the case before!

- Disable interrupts on a previous channel only when we share them indeed.

- Eliminate simple drive command handling function drive_cmd.

- Simplify the ioctl handler. Move it to ioctl, since that's the only place
   where it's actually used.

--------------050304000804000408090703
Content-Type: text/plain;
 name="ide-clean-78.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-78.diff"

diff -urN linux-2.5.19/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.19/arch/cris/drivers/ide.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/arch/cris/drivers/ide.c	2002-06-01 17:14:44.000000000 +0200
@@ -707,7 +707,7 @@
 		}
 		printk("%s: bad DMA status\n", drive->name);
 	}
-	return ide_error(drive, "dma_intr", drive->status);
+	return ata_error(drive, __FUNCTION__);
 }
 
 /*
diff -urN linux-2.5.19/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.19/drivers/ide/device.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-01 19:45:30.000000000 +0200
@@ -15,6 +15,9 @@
 /*
  * Common low leved device access code. This is the lowest layer of hardware
  * access.
+ *
+ * This is the place where register set access portability will be handled in
+ * the future.
  */
 
 #include <linux/module.h>
@@ -23,11 +26,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
-#include <linux/blkdev.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/cdrom.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 
@@ -92,4 +93,53 @@
 
 EXPORT_SYMBOL(ata_status);
 
+/*
+ * Handle the nIEN - negated Interrupt ENable of the drive.
+ * This is controlling whatever the drive will acnowlenge commands
+ * with interrupts or not.
+ */
+int ata_irq_enable(struct ata_device *drive, int on)
+{
+	struct ata_channel *ch = drive->channel;
+
+	if (!ch->io_ports[IDE_CONTROL_OFFSET])
+		return 0;
+
+	if (on)
+		OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
+	else {
+		if (!ch->intrproc)
+			OUT_BYTE(0x02, ch->io_ports[IDE_CONTROL_OFFSET]);
+		else
+			ch->intrproc(drive);
+	}
+
+	return 1;
+}
+
+EXPORT_SYMBOL(ata_irq_enable);
+
+/*
+ * Perform a reset operation on the currently selected drive.
+ */
+void ata_reset(struct ata_channel *ch)
+{
+	unsigned long timeout = jiffies + WAIT_WORSTCASE;
+	u8 stat;
+
+	if (!ch->io_ports[IDE_CONTROL_OFFSET])
+		return;
+
+	printk("%s: reset\n", ch->name);
+	OUT_BYTE(0x04, ch->io_ports[IDE_CONTROL_OFFSET]);
+	udelay(10);
+	OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
+	do {
+		mdelay(50);
+		stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
+	} while ((stat & BUSY_STAT) && time_before(jiffies, timeout));
+}
+
+EXPORT_SYMBOL(ata_reset);
+
 MODULE_LICENSE("GPL");
diff -urN linux-2.5.19/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.19/drivers/ide/hpt34x.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-01 17:19:02.000000000 +0200
@@ -264,7 +264,7 @@
 	if (drive->type != ATA_DISK)
 		return 0;
 
-	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
 	OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
 	return 0;
diff -urN linux-2.5.19/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.19/drivers/ide/hpt366.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-01 19:41:26.000000000 +0200
@@ -813,31 +813,26 @@
 	if (drive->quirk_list) {
 		/* drives in the quirk_list may not like intr setups/cleanups */
 	} else {
-		OUT_BYTE((drive)->ctl|2, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
+		OUT_BYTE(0x02, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
 	}
 }
 
 static void hpt3xx_maskproc(struct ata_device *drive)
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
-	const int mask = 0;
+	struct ata_channel *ch = drive->channel;
 
 	if (drive->quirk_list) {
 		if (hpt_min_rev(dev, 3)) {
 			u8 reg5a;
 			pci_read_config_byte(dev, 0x5a, &reg5a);
-			if (((reg5a & 0x10) >> 4) != mask)
-				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
-		} else {
-			if (mask) {
-				disable_irq(drive->channel->irq);
-			} else {
-				enable_irq(drive->channel->irq);
-			}
-		}
+			if ((reg5a & 0x10) >> 4)
+				pci_write_config_byte(dev, 0x5a, reg5a & ~0x10);
+		} else
+			enable_irq(drive->channel->irq);
 	} else {
-		if (IDE_CONTROL_REG)
-			OUT_BYTE(mask ? (drive->ctl | 2) : (drive->ctl & ~2), IDE_CONTROL_REG);
+		if (ch->io_ports[IDE_CONTROL_OFFSET])
+			OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
 	}
 }
 
diff -urN linux-2.5.19/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.19/drivers/ide/ht6560b.c	2002-05-29 20:42:48.000000000 +0200
+++ linux/drivers/ide/ht6560b.c	2002-06-01 16:31:10.000000000 +0200
@@ -123,16 +123,16 @@
 static void ht6560b_selectproc(struct ata_device *drive)
 {
 	unsigned long flags;
-	static byte current_select = 0;
-	static byte current_timing = 0;
-	byte select, timing;
-	
+	static u8 current_select = 0;
+	static u8 current_timing = 0;
+	u8 select, timing;
+
 	__save_flags (flags);	/* local CPU only */
 	__cli();		/* local CPU only */
-	
+
 	select = HT_CONFIG(drive);
 	timing = HT_TIMING(drive);
-	
+
 	if (select != current_select || timing != current_timing) {
 		current_select = select;
 		current_timing = timing;
@@ -147,7 +147,7 @@
 		 * Set timing for this drive:
 		 */
 		outb(timing, IDE_SELECT_REG);
-		(void) inb(IDE_STATUS_REG);
+		ata_status(drive, 0, 0);
 #ifdef DEBUG
 		printk("ht6560b: %s: select=%#x timing=%#x\n", drive->name, select, timing);
 #endif
@@ -160,13 +160,13 @@
  */
 static int __init try_to_init_ht6560b(void)
 {
-	byte orig_value;
+	u8 orig_value;
 	int i;
-	
+
 	/* Autodetect ht6560b */
 	if ((orig_value=inb(HT_CONFIG_PORT)) == 0xff)
 		return 0;
-	
+
 	for (i=3;i>0;i--) {
 		outb(0x00, HT_CONFIG_PORT);
 		if (!( (~inb(HT_CONFIG_PORT)) & 0x3f )) {
@@ -183,9 +183,9 @@
 	 * Ht6560b autodetected
 	 */
 	outb(HT_CONFIG_DEFAULT, HT_CONFIG_PORT);
-	outb(HT_TIMING_DEFAULT, 0x1f6);  /* IDE_SELECT_REG */
-	(void) inb(0x1f7);               /* IDE_STATUS_REG */
-	
+	outb(HT_TIMING_DEFAULT, 0x1f6);  /* SELECT */
+	(void) inb(0x1f7);               /* STATUS */
+
 	printk("\nht6560b " HT6560B_VERSION
 	       ": chipset detected and initialized"
 #ifdef DEBUG
@@ -228,19 +228,19 @@
 		if (recovery_cycles < 2)  recovery_cycles = 2;
 		if (active_cycles   > 15) active_cycles   = 15;
 		if (recovery_cycles > 15) recovery_cycles = 0;  /* 0==16 */
-		
+
 #ifdef DEBUG
 		printk("ht6560b: drive %s setting pio=%d recovery=%d (%dns) active=%d (%dns)\n",
 			drive->name, pio - XFER_PIO_0, recovery_cycles, recovery_time, active_cycles, active_time);
 #endif
-		
+
 		return (byte)((recovery_cycles << 4) | active_cycles);
 	} else {
-		
+
 #ifdef DEBUG
 		printk("ht6560b: drive %s setting pio=0\n", drive->name);
 #endif
-		
+
 		return HT_TIMING_DEFAULT;    /* default setting */
 	}
 }
@@ -252,10 +252,10 @@
 {
 	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
-	
+
 	save_flags (flags);	/* all CPUs */
 	cli();		        /* all CPUs */
-	
+
 	/*
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
@@ -267,9 +267,9 @@
 		drive->drive_data &= ~t;  /* disable prefetch mode */
 		drive->channel->no_unmask = 0;
 	}
-	
+
 	restore_flags (flags);	/* all CPUs */
-	
+
 #ifdef DEBUG
 	printk("ht6560b: drive %s prefetch mode %sabled\n", drive->name, (state ? "en" : "dis"));
 #endif
@@ -279,24 +279,24 @@
 {
 	unsigned long flags;
 	byte timing;
-	
+
 	switch (pio) {
 	case 8:         /* set prefetch off */
 	case 9:         /* set prefetch on */
 		ht_set_prefetch(drive, pio & 1);
 		return;
 	}
-	
+
 	timing = ht_pio2timings(drive, pio);
-	
+
 	save_flags (flags);	/* all CPUs */
 	cli();		        /* all CPUs */
-	
+
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
-	
+
 	restore_flags (flags);	/* all CPUs */
-	
+
 #ifdef DEBUG
 	printk("ht6560b: drive %s tuned to pio mode %#x timing=%#x\n", drive->name, pio, timing);
 #endif
@@ -305,7 +305,7 @@
 void __init init_ht6560b (void)
 {
 	int t;
-	
+
 	if (check_region(HT_CONFIG_PORT,1)) {
 		printk(KERN_ERR "ht6560b: PORT %#x ALREADY IN USE\n", HT_CONFIG_PORT);
 	} else {
diff -urN linux-2.5.19/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.19/drivers/ide/icside.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-01 17:20:45.000000000 +0200
@@ -476,7 +476,7 @@
 		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return ide_error(drive, rq, "dma_intr", drive->status);
+	return ata_error(drive, rq, __FUNCTION__);
 }
 
 static int
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-01 19:49:34.000000000 +0200
@@ -378,42 +378,6 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
 		check_crc_errors(&ch->drives[unit]);
 
-#if OK_TO_RESET_CONTROLLER
-	if (!IDE_CONTROL_REG) {
-		__restore_flags(flags);
-
-		return ide_stopped;
-	}
-	/*
-	 * Note that we also set nIEN while resetting the device,
-	 * to mask unwanted interrupts from the interface during the reset.
-	 * However, due to the design of PC hardware, this will cause an
-	 * immediate interrupt due to the edge transition it produces.
-	 * This single interrupt gives us a "fast poll" for drives that
-	 * recover from reset very quickly, saving us the first 50ms wait time.
-	 */
-	OUT_BYTE(drive->ctl|6,IDE_CONTROL_REG);	/* set SRST and nIEN */
-	udelay(10);			/* more than enough time */
-	if (drive->quirk_list == 2) {
-		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* clear SRST and nIEN */
-	} else {
-		OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST, leave nIEN */
-	}
-	udelay(10);			/* more than enough time */
-	ch->poll_timeout = jiffies + WAIT_WORSTCASE;
-	ide_set_handler(drive, reset_pollfunc, HZ/20, NULL);
-
-	/*
-	 * Some weird controller like resetting themselves to a strange
-	 * state when the disks are reset this way. At least, the Winbond
-	 * 553 documentation says that
-	 */
-	if (ch->resetproc != NULL)
-		ch->resetproc(drive);
-
-	/* FIXME: we should handle mulit mode setting here as well ! */
-#endif
-
 	__restore_flags (flags);	/* local CPU only */
 
 	return ide_started;
@@ -421,8 +385,8 @@
 
 static inline u32 read_24(struct ata_device *drive)
 {
-	return  (IN_BYTE(IDE_HCYL_REG)<<16) |
-		(IN_BYTE(IDE_LCYL_REG)<<8) |
+	return  (IN_BYTE(IDE_HCYL_REG) << 16) |
+		(IN_BYTE(IDE_LCYL_REG) << 8) |
 		 IN_BYTE(IDE_SECTOR_REG);
 }
 
@@ -457,11 +421,9 @@
 			    (drive->id->cfs_enable_2 & 0x0400) &&
 			    (drive->addressing == 1)) {
 				/* The following command goes to the hob file! */
-
-				OUT_BYTE(drive->ctl|0x80, IDE_CONTROL_REG);
+				OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
 				args->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
 				args->hobfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
-
 				args->hobfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
 				args->hobfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
@@ -547,13 +509,13 @@
 					__u64 sectors = 0;
 					u32 low = 0, high = 0;
 					low = read_24(drive);
-					OUT_BYTE(drive->ctl|0x80, IDE_CONTROL_REG);
+					OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
 					high = read_24(drive);
 
 					sectors = ((__u64)high << 24) | low;
 					printk(", LBAsect=%lld, high=%d, low=%d", (long long) sectors, high, low);
 				} else {
-					byte cur = IN_BYTE(IDE_SELECT_REG);
+					u8 cur = IN_BYTE(IDE_SELECT_REG);
 					if (cur & 0x40) {	/* using LBA? */
 						printk(", LBAsect=%ld", (unsigned long)
 						 ((cur&0xf)<<24)
@@ -632,9 +594,10 @@
 /*
  * Take action based on the error returned by the drive.
  */
-ide_startstop_t ide_error(struct ata_device *drive, struct request *rq, const char *msg, byte stat)
+ide_startstop_t ata_error(struct ata_device *drive, struct request *rq,	const char *msg)
 {
-	byte err;
+	u8 err;
+	u8 stat = drive->status;
 
 	err = ide_dump_status(drive, rq, msg, stat);
 	if (!drive || !rq)
@@ -645,18 +608,18 @@
 		ide_end_drive_cmd(drive, rq, err);
 		return ide_stopped;
 	}
-
-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) { /* other bits are useless when BUSY */
-		rq->errors |= ERROR_RESET;
-	} else {
+	/* other bits are useless when BUSY */
+	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr))
+		rq->errors |= ERROR_RESET; /* FIXME: What's that?! */
+	else {
 		if (drive->type == ATA_DISK && (stat & ERR_STAT)) {
 			/* err has different meaning on cdrom and tape */
 			if (err == ABRT_ERR) {
 				if (drive->select.b.lba && IN_BYTE(IDE_COMMAND_REG) == WIN_SPECIFY)
 					return ide_stopped; /* some newer drives don't support WIN_SPECIFY */
-			} else if ((err & (ABRT_ERR | ICRC_ERR)) == (ABRT_ERR | ICRC_ERR)) {
+			} else if ((err & (ABRT_ERR | ICRC_ERR)) == (ABRT_ERR | ICRC_ERR))
 				drive->crc_count++; /* UDMA crc error -- just retry the operation */
-			} else if (err & (BBD_ERR | ECC_ERR))	/* retries won't help these */
+			else if (err & (BBD_ERR | ECC_ERR))	/* retries won't help these */
 				rq->errors = ERROR_MAX;
 			else if (err & TRK0_ERR)	/* help it find track zero */
 				rq->errors |= ERROR_RECAL;
@@ -665,7 +628,8 @@
 		if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
 			try_to_flush_leftover_data(drive);
 	}
-	if (!ata_status(drive, 0, BUSY_STAT|DRQ_STAT))
+
+	if (!ata_status(drive, 0, BUSY_STAT | DRQ_STAT))
 		OUT_BYTE(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);	/* force an abort */
 
 	if (rq->errors >= ERROR_MAX) {
@@ -680,6 +644,7 @@
 		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
 			return do_recalibrate(drive);
 	}
+
 	return ide_stopped;
 }
 
@@ -689,10 +654,11 @@
 static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
 {
 	u8 *args = rq->buffer;
-	int retries = 10;
 
 	ide__sti();	/* local CPU only */
 	if (!ata_status(drive, 0, DRQ_STAT) && args && args[3]) {
+		int retries = 10;
+
 		ata_read(drive, &args[4], args[3] * SECTOR_WORDS);
 
 		while (!ata_status(drive, 0, BUSY_STAT) && retries--)
@@ -700,7 +666,7 @@
 	}
 
 	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ide_error(drive, rq, "drive_cmd", drive->status); /* already calls ide_end_drive_cmd */
+		return ata_error(drive, rq, __FUNCTION__); /* already calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, rq, GET_ERR());
 
 	return ide_stopped;
@@ -712,8 +678,7 @@
 static void drive_cmd(struct ata_device *drive, u8 cmd, u8 nsect)
 {
 	ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
-	if (IDE_CONTROL_REG)
-		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
+	ata_irq_enable(drive, 1);
 	ata_mask(drive);
 	OUT_BYTE(nsect, IDE_NSECTOR_REG);
 	OUT_BYTE(cmd, IDE_COMMAND_REG);
@@ -723,7 +688,7 @@
 /*
  * Busy-wait for the drive status to be not "busy".  Check then the status for
  * all of the "good" bits and none of the "bad" bits, and if all is okay it
- * returns 0.  All other cases return 1 after invoking ide_error() -- caller
+ * returns 0.  All other cases return 1 after invoking error handler -- caller
  * should just return.
  *
  * This routine should get fixed to not hog the cpu during extra long waits..
@@ -744,12 +709,13 @@
 		return 1;
 	}
 
-	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
+	/* spec allows drive 400ns to assert "BUSY" */
+	udelay(1);
 	if (!ata_status(drive, 0, BUSY_STAT)) {
 		timeout += jiffies;
 		while (!ata_status(drive, 0, BUSY_STAT)) {
 			if (time_after(jiffies, timeout)) {
-				*startstop = ide_error(drive, rq, "status timeout", drive->status);
+				*startstop = ata_error(drive, rq, "status timeout");
 				return 1;
 			}
 		}
@@ -766,7 +732,7 @@
 		if (ata_status(drive, good, bad))
 			return 0;
 	}
-	*startstop = ide_error(drive, rq, "status error", drive->status);
+	*startstop = ata_error(drive, rq, "status error");
 
 	return 1;
 }
@@ -1134,15 +1100,15 @@
 
 		ch = drive->channel;
 
-		if (channel->sharing_irq && ch != channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
-			/* set nIEN for previous channel */
-			/* FIXME: check this! It appears to act on the current channel! */
-
-			if (ch->intrproc)
-				ch->intrproc(drive);
-			else
-				OUT_BYTE((drive)->ctl|2, ch->io_ports[IDE_CONTROL_OFFSET]);
-		}
+		/* Disable intrerrupts from the drive on the previous channel.
+		 *
+		 * FIXME: This should be only done if we are indeed sharing the same
+		 * interrupt line with it.
+		 *
+		 * FIXME: check this! It appears to act on the current channel!
+		 */
+		if (ch != channel && channel->sharing_irq && ch->irq == channel->irq)
+			ata_irq_enable(drive, 0);
 
 		/* Remember the last drive we where acting on.
 		 */
@@ -1279,7 +1245,7 @@
 					startstop = ide_stopped;
 					dma_timeout_retry(drive, drive->rq);
 				} else
-					startstop = ide_error(drive, drive->rq, "irq timeout", drive->status);
+					startstop = ata_error(drive, drive->rq, "irq timeout");
 			}
 			enable_irq(ch->irq);
 
@@ -1571,33 +1537,6 @@
 	return res;
 }
 
-void ide_fixstring (byte *s, const int bytecount, const int byteswap)
-{
-	byte *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
-
-	if (byteswap) {
-		/* convert from big-endian to host byte order */
-		for (p = end ; p != s;) {
-			unsigned short *pp = (unsigned short *) (p -= 2);
-			*pp = ntohs(*pp);
-		}
-	}
-
-	/* strip leading blanks */
-	while (s != end && *s == ' ')
-		++s;
-
-	/* compress internal blanks and strip trailing blanks */
-	while (s != end && *s) {
-		if (*s++ != ' ' || (s != end && *s && *s != ' '))
-			*p++ = *(s-1);
-	}
-
-	/* wipe out trailing garbage */
-	while (p != end)
-		*p++ = '\0';
-}
-
 struct block_device_operations ide_fops[] = {{
 	owner:			THIS_MODULE,
 	open:			ide_open,
@@ -1616,8 +1555,8 @@
 
 EXPORT_SYMBOL(ide_set_handler);
 EXPORT_SYMBOL(ide_dump_status);
-EXPORT_SYMBOL(ide_error);
-EXPORT_SYMBOL(ide_fixstring);
+EXPORT_SYMBOL(ata_error);
+
 EXPORT_SYMBOL(ide_wait_stat);
 EXPORT_SYMBOL(restart_request);
 EXPORT_SYMBOL(ide_end_drive_cmd);
diff -urN linux-2.5.19/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.19/drivers/ide/ide-cd.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-01 18:40:19.000000000 +0200
@@ -594,7 +594,7 @@
 		pc = (struct packet_command *) rq->special;
 		pc->stat = 1;
 		cdrom_end_request(drive, rq, 1);
-		*startstop = ide_error(drive, rq, "request sense failure", drive->status);
+		*startstop = ata_error(drive, rq, "request sense failure");
 
 		return 1;
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
@@ -673,7 +673,7 @@
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
-			*startstop = ide_error(drive, rq, __FUNCTION__, drive->status);
+			*startstop = ata_error(drive, rq, __FUNCTION__);
 			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
@@ -751,9 +751,7 @@
 
 	OUT_BYTE(xferlen & 0xff, IDE_LCYL_REG);
 	OUT_BYTE(xferlen >> 8  , IDE_HCYL_REG);
-	if (IDE_CONTROL_REG)
-		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
-
+	ata_irq_enable(drive, 1);
 	if (info->dma)
 		udma_start(drive, rq);
 
@@ -918,7 +916,7 @@
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
 			return ide_stopped;
 		} else
-			return ide_error (drive, rq, "dma error", stat);
+			return ata_error(drive, rq, "dma error");
 	}
 
 	/* Read the interrupt reason and the transfer length. */
@@ -1498,7 +1496,7 @@
 	 */
 	if (dma) {
 		if (dma_error)
-			return ide_error(drive, rq, "dma error", stat);
+			return ata_error(drive, rq, "dma error");
 
 		__ide_end_request(drive, rq, 1, rq->nr_sectors);
 		return ide_stopped;
diff -urN linux-2.5.19/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.19/drivers/ide/ide-disk.c	2002-05-29 20:42:43.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-01 19:02:41.000000000 +0200
@@ -257,14 +257,15 @@
 	args.taskfile.sector_number = block;		/* low lba */
 	args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
 	args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
+	args.taskfile.device_head = drive->select.all;
 
 	args.hobfile.sector_number = (block >>= 8);	/* low lba */
 	args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
 	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
+	args.hobfile.device_head = drive->select.all;
+
+	args.hobfile.control = 0x80;
 
-	args.taskfile.device_head = drive->select.all;
-	args.hobfile.device_head = args.taskfile.device_head;
-	args.hobfile.control = (drive->ctl|0x80);
 	args.taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
@@ -727,7 +728,7 @@
 	args.hobfile.high_cylinder = (addr_req >>= 8);
 
 	args.hobfile.device_head = 0x40;
-	args.hobfile.control = (drive->ctl | 0x80);
+	args.hobfile.control = 0x80;
 
         args.handler = task_no_data_intr;
 	/* submit command request */
diff -urN linux-2.5.19/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.19/drivers/ide/ide-floppy.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-01 18:22:08.000000000 +0200
@@ -1064,8 +1064,7 @@
 	}
 #endif
 
-	if (IDE_CONTROL_REG)
-		OUT_BYTE (drive->ctl,IDE_CONTROL_REG);
+	ata_irq_enable(drive, 1);
 	OUT_BYTE (dma_ok ? 1:0,IDE_FEATURE_REG);			/* Use PIO/DMA */
 	OUT_BYTE (bcount.b.high,IDE_BCOUNTH_REG);
 	OUT_BYTE (bcount.b.low,IDE_BCOUNTL_REG);
diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-01 18:17:36.000000000 +0200
@@ -434,7 +434,7 @@
 		goto out;
 	}
 	udelay(10);
-	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
+	ata_irq_enale(drive, 0);
 	OUT_BYTE(command, IDE_NSECTOR_REG);
 	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
 	OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
@@ -443,7 +443,7 @@
 	ide__sti();		/* local CPU only -- for jiffies */
 	result = wait_for_ready(drive);
 	__restore_flags(flags); /* local CPU only */
-	OUT_BYTE(drive->ctl, IDE_CONTROL_REG);
+	ata_irq_enable(drive, 1);
 	if (result)
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready after SET_FEATURE !\n");
 out:
@@ -1330,7 +1330,7 @@
 			/* Normal MultiWord DMA modes. */
 			drive->using_dma = pmac_ide_mdma_enable(drive, idx);
 		}
-		OUT_BYTE(0, IDE_CONTROL_REG);
+		ata_irq_enable(drive, 1);
 		/* Apply settings to controller */
 		pmac_ide_selectproc(drive);
 	}
diff -urN linux-2.5.19/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.19/drivers/ide/ide-tape.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-01 18:32:37.000000000 +0200
@@ -2263,8 +2263,7 @@
 	}
 #endif
 
-	if (IDE_CONTROL_REG)
-		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
+	ata_irq_enable(drive, 1);
 	OUT_BYTE (dma_ok ? 1 : 0,    IDE_FEATURE_REG);			/* Use PIO/DMA */
 	OUT_BYTE (bcount.b.high,     IDE_BCOUNTH_REG);
 	OUT_BYTE (bcount.b.low,      IDE_BCOUNTL_REG);
diff -urN linux-2.5.19/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.19/drivers/ide/ide-taskfile.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-01 19:34:02.000000000 +0200
@@ -169,12 +169,12 @@
 	if (drive->waiting_for_dma)
 		return udma_irq_status(drive);
 
-#if 0
-	/* need to guarantee 400ns since last command was issued */
-	udelay(1);
-#endif
+	/*
+	 * Need to guarantee 400ns since last command was issued?
+	 */
 
-	/* FIXME: promote this to the general status read method perhaps */
+	/* FIXME: promote this to the general status read method perhaps.
+	 */
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*
 	 * We do a passive status test under shared PCI interrupts on
@@ -182,16 +182,16 @@
 	 * an interrupt with another pci card/device.  We make no assumptions
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
-	if (IDE_CONTROL_REG)
+	if (drive->channel->io_ports[IDE_CONTROL_OFFSET])
 		drive->status = GET_ALTSTAT();
 	else
 #endif
-	ata_status(drive, 0, 0);	/* Note: this may clear a pending IRQ!! */
+		ata_status(drive, 0, 0);	/* Note: this may clear a pending IRQ! */
 
 	if (drive->status & BUSY_STAT)
 		return 0;	/* drive busy:  definitely not interrupting */
 
-	return 1;		/* drive ready: *might* be interrupting */
+	return 1;	/* drive ready: *might* be interrupting */
 }
 
 /*
@@ -246,7 +246,7 @@
 
 	if (!ok || !rq->nr_sectors) {
 		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			startstop = ide_error(drive, rq, __FUNCTION__, drive->status);
+			startstop = ata_error(drive, rq, __FUNCTION__);
 
 			return startstop;
 		}
@@ -316,24 +316,9 @@
 	struct hd_driveid *id = drive->id;
 	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
-#if 0
-	printk("ata_taskfile ... %p\n", args->handler);
-
-	printk("   sector feature          %02x\n", args->taskfile.feature);
-	printk("   sector count            %02x\n", args->taskfile.sector_count);
-	printk("   drive/head              %02x\n", args->taskfile.device_head);
-	printk("   command                 %02x\n", args->taskfile.command);
-
-	if (rq)
-		printk("   rq->nr_sectors          %2li\n",  rq->nr_sectors);
-	else
-		printk("   rq->                   = null\n");
-#endif
-
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
 	if (args->handler != task_mulout_intr) {
-		if (IDE_CONTROL_REG)
-			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
+		ata_irq_enable(drive, 1);
 		ata_mask(drive);
 	}
 
@@ -412,7 +397,7 @@
 ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
 {
 	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ide_error(drive, rq, "recal_intr", drive->status);
+		return ata_error(drive, rq, __FUNCTION__);
 
 	return ide_stopped;
 }
@@ -429,7 +414,7 @@
 	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
 		/* Keep quiet for NOP because it is expected to fail. */
 		if (args && args->taskfile.command != WIN_NOP)
-			return ide_error(drive, rq, "task_no_data_intr", drive->status);
+			return ata_error(drive, rq, __FUNCTION__);
 	}
 
 	if (args)
@@ -443,12 +428,12 @@
  */
 static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
-	char *pBuf = NULL;
+	char *buf = NULL;
 	unsigned long flags;
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
 		if (drive->status & (ERR_STAT|DRQ_STAT))
-			return ide_error(drive, rq, __FUNCTION__, drive->status);
+			return ata_error(drive, rq, __FUNCTION__);
 
 		if (!(drive->status & BUSY_STAT)) {
 			DTF("task_in_intr to Soon wait for next interrupt\n");
@@ -458,11 +443,11 @@
 		}
 	}
 	DTF("stat: %02x\n", drive->status);
-	pBuf = ide_map_rq(rq, &flags);
-	DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
+	buf = ide_map_rq(rq, &flags);
+	DTF("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
 
-	ata_read(drive, pBuf, SECTOR_WORDS);
-	ide_unmap_rq(rq, pBuf, &flags);
+	ata_read(drive, buf, SECTOR_WORDS);
+	ide_unmap_rq(rq, buf, &flags);
 
 	/* First segment of the request is complete. note that this does not
 	 * necessarily mean that the entire request is done!! this is only true
@@ -512,22 +497,22 @@
  */
 static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
 {
-	char *pBuf = NULL;
+	char *buf = NULL;
 	unsigned long flags;
 
 	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
-		return ide_error(drive, rq, __FUNCTION__, drive->status);
+		return ata_error(drive, rq, __FUNCTION__);
 
 	if (!rq->current_nr_sectors)
 		if (!ide_end_request(drive, rq, 1))
 			return ide_stopped;
 
 	if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
-		pBuf = ide_map_rq(rq, &flags);
-		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
+		buf = ide_map_rq(rq, &flags);
+		DTF("write: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
 
-		ata_write(drive, pBuf, SECTOR_WORDS);
-		ide_unmap_rq(rq, pBuf, &flags);
+		ata_write(drive, buf, SECTOR_WORDS);
+		ide_unmap_rq(rq, buf, &flags);
 		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
@@ -542,14 +527,14 @@
  */
 static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
 {
-	char *pBuf = NULL;
+	char *buf = NULL;
 	unsigned int msect, nsect;
 	unsigned long flags;
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, rq, __FUNCTION__, drive->status);
-		}
+		if (drive->status & (ERR_STAT|DRQ_STAT))
+			return ata_error(drive, rq, __FUNCTION__);
+
 		/* no data yet, so wait for another interrupt */
 		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
 		return ide_started;
@@ -563,12 +548,12 @@
 		if (nsect > msect)
 			nsect = msect;
 
-		pBuf = ide_map_rq(rq, &flags);
+		buf = ide_map_rq(rq, &flags);
 
 		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
-			pBuf, nsect, rq->current_nr_sectors);
-		ata_read(drive, pBuf, nsect * SECTOR_WORDS);
-		ide_unmap_rq(rq, pBuf, &flags);
+			buf, nsect, rq->current_nr_sectors);
+		ata_read(drive, buf, nsect * SECTOR_WORDS);
+		ide_unmap_rq(rq, buf, &flags);
 		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
diff -urN linux-2.5.19/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.19/drivers/ide/main.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/main.c	2002-06-01 18:59:44.000000000 +0200
@@ -205,9 +205,8 @@
 		struct ata_device *drive = &ch->drives[unit];
 
 		drive->type		= ATA_DISK;
-		drive->select.all	= (unit<<4)|0xa0;
+		drive->select.all	= (unit << 4) | 0xa0;
 		drive->channel		= ch;
-		drive->ctl		= 0x08;
 		drive->ready_stat	= READY_STAT;
 		drive->bad_wstat	= BAD_W_STAT;
 		sprintf(drive->name, "hd%c", 'a' + (index * MAX_DRIVES) + unit);
diff -urN linux-2.5.19/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.19/drivers/ide/ns87415.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-06-01 19:25:31.000000000 +0200
@@ -141,10 +141,6 @@
 	struct pci_dev *dev = hwif->pci_dev;
 	unsigned int ctrl, using_inta;
 	byte progif;
-#ifdef __sparc_v9__
-	int timeout;
-	byte stat;
-#endif
 
 	/* Set a good latency timer and cache line size value. */
 	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
@@ -197,16 +193,7 @@
 		 * XXX: Reset the device, if we don't it will not respond
 		 *      to select properly during first probe.
 		 */
-		timeout = 10000;
-		outb(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
-		udelay(10);
-		outb(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
-		do {
-			udelay(50);
-			stat = inb(hwif->io_ports[IDE_STATUS_OFFSET]);
-			if (stat == 0xff)
-				break;
-		} while ((stat & BUSY_STAT) && --timeout);
+		ata_reset(struct ata_channel *hwif);
 #endif
 	}
 
diff -urN linux-2.5.19/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.19/drivers/ide/pcidma.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-01 17:19:51.000000000 +0200
@@ -41,6 +41,7 @@
 {
 	u8 dma_stat;
 	dma_stat = udma_stop(drive);
+
 	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
@@ -49,7 +50,8 @@
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return ide_error(drive, rq, "dma_intr", drive->status);
+
+	return ata_error(drive, rq, __FUNCTION__);
 }
 
 /*
@@ -118,7 +120,7 @@
 static int dma_timer_expiry(struct ata_device *drive, struct request *rq)
 {
 	/* FIXME: What's that? */
-	u8 dma_stat = inb(drive->channel->dma_base+2);
+	u8 dma_stat = inb(drive->channel->dma_base + 2);
 
 #ifdef DEBUG
 	printk("%s: dma_timer_expiry: dma status == 0x%02x\n", drive->name, dma_stat);
@@ -130,10 +132,11 @@
 
 	if (dma_stat & 2) {	/* ERROR */
 		ata_status(drive, 0, 0);
-		return ide_error(drive, rq, "dma_timer_expiry", drive->status);
+		return ata_error(drive, rq, __FUNCTION__);
 	}
 	if (dma_stat & 1)	/* DMAing */
 		return WAIT_CMD;
+
 	return 0;
 }
 
diff -urN linux-2.5.19/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.19/drivers/ide/pdc202xx.c	2002-05-29 20:42:58.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-01 19:27:10.000000000 +0200
@@ -686,9 +686,11 @@
 
 void pdc202xx_new_reset(struct ata_device *drive)
 {
-	set_reg_and_wait(0x04,IDE_CONTROL_REG, 1000);
-	set_reg_and_wait(0x00,IDE_CONTROL_REG, 1000);
-	printk("PDC202XX: %s channel reset.\n",
+	ata_reset(drive->channel);
+	mdelay(1000);
+	ata_irq_enable(drive, 1);
+	mdelay(1000);
+	printk(KERN_INFO "PDC202XX: %s channel reset.\n",
 		drive->channel->unit ? "Secondary" : "Primary");
 }
 
diff -urN linux-2.5.19/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.19/drivers/ide/pdc4030.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-01 18:24:23.000000000 +0200
@@ -243,9 +243,8 @@
 	if (inb(IDE_NSECTOR_REG) == 0xFF || inb(IDE_SECTOR_REG) == 0xFF) {
 		return 0;
 	}
-	if (IDE_CONTROL_REG)
-		outb(0x08, IDE_CONTROL_REG);
-	if (pdc4030_cmd(drive,PROMISE_GET_CONFIG)) {
+	ata_irq_enable(drive, 1);
+	if (pdc4030_cmd(drive, PROMISE_GET_CONFIG)) {
 		return 0;
 	}
 	if (ide_wait_stat(&startstop, drive, NULL, DATA_READY,BAD_W_STAT,WAIT_DRQ)) {
@@ -379,7 +378,7 @@
 	char *to;
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT))
-		return ide_error(drive, rq, "promise_read_intr", drive->status);
+		return ata_error(drive, rq, __FUNCTION__);
 
 read_again:
 	do {
@@ -438,7 +437,7 @@
 		}
 		printk(KERN_ERR "%s: Eeek! promise_read_intr: sectors left "
 		       "!DRQ !BUSY\n", drive->name);
-		return ide_error(drive, rq, "promise read intr", drive->status);
+		return ata_error(drive, rq, "promise read intr");
 	}
 	return ide_stopped;
 }
@@ -463,7 +462,7 @@
 		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: completion timeout - still busy!\n",
 		       drive->name);
-		return ide_error(drive, rq, "busy timeout", drive->status);
+		return ata_error(drive, rq, "busy timeout");
 	}
 
 	ch->poll_timeout = 0;
@@ -540,9 +539,9 @@
 			return ide_started; /* continue polling... */
 		}
 		ch->poll_timeout = 0;
-		printk(KERN_ERR "%s: write timed out!\n",drive->name);
+		printk(KERN_ERR "%s: write timed out!\n", drive->name);
 		ata_status(drive, 0, 0);
-		return ide_error(drive, rq, "write timeout", drive->status);
+		return ata_error(drive, rq, "write timeout");
 	}
 
 	/*
@@ -616,11 +615,11 @@
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "pdc4030 bad flags");
 		ide_end_request(drive, rq, 0);
+
 		return ide_stopped;
 	}
 
-	if (IDE_CONTROL_REG)
-		outb(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
+	ata_irq_enable(drive, 1);  /* clear nIEN */
 	ata_mask(drive);
 
 	outb(taskfile->feature, IDE_FEATURE_REG);
diff -urN linux-2.5.19/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.19/drivers/ide/probe.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-06-01 19:15:27.000000000 +0200
@@ -267,6 +267,34 @@
 #endif
 }
 
+void ide_fixstring(char *s, const int bytecount, const int byteswap)
+{
+	char *p = s;
+	char *end = &s[bytecount & ~1]; /* bytecount must be even */
+
+	if (byteswap) {
+		/* convert from big-endian to host byte order */
+		for (p = end ; p != s;) {
+			unsigned short *pp = (unsigned short *) (p -= 2);
+			*pp = ntohs(*pp);
+		}
+	}
+
+	/* strip leading blanks */
+	while (s != end && *s == ' ')
+		++s;
+
+	/* compress internal blanks and strip trailing blanks */
+	while (s != end && *s) {
+		if (*s++ != ' ' || (s != end && *s && *s != ' '))
+			*p++ = *(s-1);
+	}
+
+	/* wipe out trailing garbage */
+	while (p != end)
+		*p++ = '\0';
+}
+
 /*
  *  All hosts that use the 80c ribbon must use this!
  */
@@ -280,7 +308,7 @@
 }
 
 /*
- * Similar to ide_wait_stat(), except it never calls ide_error internally.
+ * Similar to ide_wait_stat(), except it never calls ata_error internally.
  * This is a kludge to handle the new ide_config_drive_speed() function,
  * and should not otherwise be used anywhere.  Eventually, the tuneproc's
  * should be updated to return ide_startstop_t, in which case we can get
@@ -292,13 +320,13 @@
  */
 int ide_config_drive_speed(struct ata_device *drive, byte speed)
 {
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 	int i;
 	int error = 1;
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(__CRIS__)
 	u8 unit = (drive->select.b.unit & 0x01);
-	outb(inb(hwif->dma_base + 2) & ~(1 << (5 + unit)), hwif->dma_base + 2);
+	outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
 #endif
 
 	/*
@@ -309,18 +337,17 @@
         /*
          * Select the drive, and issue the SETFEATURES command
          */
-	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
+	disable_irq(ch->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
 	ata_select(drive, 0);
 	ata_mask(drive);
 	udelay(1);
-	if (IDE_CONTROL_REG)
-		OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
+	ata_irq_enable(drive, 0);
 	OUT_BYTE(speed, IDE_NSECTOR_REG);
 	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
 	OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
-	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
-		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);
+	if (drive->quirk_list == 2)
+		ata_irq_enable(drive, 1);
 	udelay(1);
 
 	/*
@@ -355,7 +382,7 @@
 
 	ata_mask(drive);
 
-	enable_irq(hwif->irq);
+	enable_irq(ch->irq);
 
 	if (error) {
 		ide_dump_status(drive, NULL, "set_drive_speed_status", drive->status);
@@ -368,9 +395,9 @@
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(__CRIS__)
 	if (speed > XFER_PIO_4) {
-		outb(inb(hwif->dma_base+2)|(1<<(5+unit)), hwif->dma_base+2);
+		outb(inb(ch->dma_base + 2)|(1 << (5 + unit)), ch->dma_base + 2);
 	} else {
-		outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
+		outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
 	}
 #endif
 
@@ -391,6 +418,7 @@
 		case XFER_SW_DMA_0: drive->id->dma_1word |= 0x0101; break;
 		default: break;
 	}
+
 	return error;
 }
 
@@ -446,9 +474,9 @@
 		 || (id->model[0] == 'P' && id->model[1] == 'i'))/* Pioneer */
 			bswap ^= 1;	/* Vertos drives may still be weird */
 	}
-	ide_fixstring (id->model,     sizeof(id->model),     bswap);
-	ide_fixstring (id->fw_rev,    sizeof(id->fw_rev),    bswap);
-	ide_fixstring (id->serial_no, sizeof(id->serial_no), bswap);
+	ide_fixstring(id->model,     sizeof(id->model),     bswap);
+	ide_fixstring(id->fw_rev,    sizeof(id->fw_rev),    bswap);
+	ide_fixstring(id->serial_no, sizeof(id->serial_no), bswap);
 
 	if (strstr(id->model, "E X A B Y T E N E S T"))
 		goto err_misc;
@@ -566,36 +594,40 @@
  */
 static int identify(struct ata_device *drive, u8 cmd)
 {
-	int rc;
+	struct ata_channel *ch = drive->channel;
+	int rc = 1;
 	int autoprobe = 0;
 	unsigned long cookie = 0;
 	ide_ioreg_t hd_status;
 	unsigned long timeout;
-	u8 s;
-	u8 a;
 
 
-	if (IDE_CONTROL_REG && !drive->channel->irq) {
-		autoprobe = 1;
-		cookie = probe_irq_on();
-		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* enable device irq */
-	}
+	/* FIXME: perhaps we should be just using allways the status register,
+	 * since it should simplify the code significantly.
+	 */
+	if (ch->io_ports[IDE_CONTROL_OFFSET]) {
+		u8 s;
+		u8 a;
+
+		if (!drive->channel->irq) {
+			autoprobe = 1;
+			cookie = probe_irq_on();
+			ata_irq_enable(drive, 1);	/* enable device irq */
+		}
 
-	rc = 1;
-	if (IDE_CONTROL_REG) {
 		/* take a deep breath */
 		mdelay(50);
-		a = IN_BYTE(IDE_ALTSTATUS_REG);
-		s = IN_BYTE(IDE_STATUS_REG);
+		a = IN_BYTE(ch->io_ports[IDE_ALTSTATUS_OFFSET]);
+		s = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
 		if ((a ^ s) & ~INDEX_STAT) {
 			printk("%s: probing with STATUS(0x%02x) instead of ALTSTATUS(0x%02x)\n", drive->name, s, a);
-			hd_status = IDE_STATUS_REG;	/* ancient Seagate drives, broken interfaces */
+			hd_status = ch->io_ports[IDE_STATUS_OFFSET];	/* ancient Seagate drives, broken interfaces */
 		} else {
-			hd_status = IDE_ALTSTATUS_REG;	/* use non-intrusive polling */
+			hd_status = ch->io_ports[IDE_ALTSTATUS_OFFSET];	/* use non-intrusive polling */
 		}
 	} else {
 		mdelay(50);
-		hd_status = IDE_STATUS_REG;
+		hd_status = ch->io_ports[IDE_STATUS_OFFSET];
 	}
 
 	/* set features register for atapi identify command to be sure of reply */
@@ -637,8 +669,8 @@
 	if (autoprobe) {
 		int irq;
 
-		OUT_BYTE(drive->ctl | 0x02, IDE_CONTROL_REG);	/* mask device irq */
-		ata_status(drive, 0, 0);			/* clear drive IRQ */
+		ata_irq_enable(drive, 0);	/* mask device irq */
+		ata_status(drive, 0, 0);	/* clear drive IRQ */
 		udelay(5);
 		irq = probe_irq_off(cookie);
 		if (!drive->channel->irq) {
@@ -855,19 +887,8 @@
 
 	device_register(&ch->dev);
 
-	if (ch->reset && ch->io_ports[IDE_CONTROL_OFFSET]) {
-		unsigned long timeout = jiffies + WAIT_WORSTCASE;
-		u8 stat;
-
-		printk("%s: reset\n", ch->name);
-		OUT_BYTE(12, ch->io_ports[IDE_CONTROL_OFFSET]);
-		udelay(10);
-		OUT_BYTE(8, ch->io_ports[IDE_CONTROL_OFFSET]);
-		do {
-			mdelay(50);
-			stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && time_before(jiffies, timeout));
-	}
+	if (ch->reset)
+		ata_reset(ch);
 
 	__restore_flags(flags);	/* local CPU only */
 
@@ -969,14 +990,19 @@
 	 * Allocate the irq, if not already obtained for another channel
 	 */
 	if (!match || match->irq != ch->irq) {
+		struct ata_device tmp;
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
 		int sa = IDE_CHIPSET_IS_PCI(ch->chipset) ? SA_SHIRQ : SA_INTERRUPT;
 #else
 		int sa = IDE_CHIPSET_IS_PCI(ch->chipset) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
 #endif
 
-		if (ch->io_ports[IDE_CONTROL_OFFSET])
-			OUT_BYTE(0x08, ch->io_ports[IDE_CONTROL_OFFSET]); /* clear nIEN */
+		/* Enable interrupts triggered by the drive.  We use a shallow
+		 * device structure, just to use the generic function very
+		 * early.
+		 */
+		tmp.channel = ch;
+		ata_irq_enable(&tmp, 1);
 
 		if (request_irq(ch->irq, &ata_irq_request, sa, ch->name, ch)) {
 			if (!match) {
@@ -1240,5 +1266,6 @@
 }
 
 EXPORT_SYMBOL(ata_fix_driveid);
+EXPORT_SYMBOL(ide_fixstring);
 EXPORT_SYMBOL(eighty_ninty_three);
 EXPORT_SYMBOL(ide_config_drive_speed);
diff -urN linux-2.5.19/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.19/drivers/ide/qd65xx.c	2002-05-29 20:42:50.000000000 +0200
+++ linux/drivers/ide/qd65xx.c	2002-06-01 16:48:03.000000000 +0200
@@ -173,9 +173,7 @@
 
 	if (!*drive->id->model) return 0;
 
-	strncpy(model,drive->id->model,40);
-	ide_fixstring(model,40,1); /* byte-swap */
-
+	strncpy(model,drive->id->model, 40);
 	for (p = qd65xx_timing ; p->offset != -1 ; p++) {
 		if (!strncmp(p->model, model+p->offset, 4)) {
 			printk(KERN_DEBUG "%s: listed !\n", drive->name);
diff -urN linux-2.5.19/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.19/drivers/ide/tcq.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-01 17:41:40.000000000 +0200
@@ -55,17 +55,6 @@
 static ide_startstop_t ide_dmaq_intr(struct ata_device *drive, struct request *rq);
 static ide_startstop_t service(struct ata_device *drive, struct request *rq);
 
-static inline void drive_ctl_nien(struct ata_device *drive, int set)
-{
-#ifdef IDE_TCQ_NIEN
-	if (IDE_CONTROL_REG) {
-		int mask = set ? 0x02 : 0x00;
-
-		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
-	}
-#endif
-}
-
 static ide_startstop_t tcq_nop_handler(struct ata_device *drive, struct request *rq)
 {
 	struct ata_taskfile *args = rq->special;
@@ -136,11 +125,10 @@
 	rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
 	_elv_add_request(q, rq, 0, 0);
 
-	/*
-	 * make sure that nIEN is cleared
-	 */
 out:
-	drive_ctl_nien(drive, 0);
+#ifdef IDE_TCQ_NIEN
+	ata_irq_enable(drive, 1);
+#endif
 
 	/*
 	 * start doing stuff again
@@ -250,8 +238,9 @@
 	if (drive != drive->channel->drive)
 		ata_select(drive, 10);
 
-	drive_ctl_nien(drive, 1);
-
+#ifdef IDE_TCQ_NIEN
+	ata_irq_enable(drive, 0);
+#endif
 	/*
 	 * send SERVICE, wait 400ns, wait for BUSY_STAT to clear
 	 */
@@ -265,7 +254,9 @@
 		return ide_stopped;
 	}
 
-	drive_ctl_nien(drive, 0);
+#ifdef IDE_TCQ_NIEN
+	ata_irq_enable(drive, 1);
+#endif
 
 	/*
 	 * FIXME, invalidate queue
@@ -559,7 +550,9 @@
 	 * set nIEN, tag start operation will enable again when
 	 * it is safe
 	 */
-	drive_ctl_nien(drive, 1);
+#ifdef IDE_TCQ_NIEN
+	ata_irq_enable(drive, 0);
+#endif
 
 	OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 
@@ -569,7 +562,9 @@
 		return ide_stopped;
 	}
 
-	drive_ctl_nien(drive, 0);
+#ifdef IDE_TCQ_NIEN
+	ata_irq_enable(drive, 1);
+#endif
 
 	if (stat & ERR_STAT) {
 		ide_dump_status(drive, rq, "tcq_start", stat);
diff -urN linux-2.5.19/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.19/drivers/ide/trm290.c	2002-05-29 20:42:48.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-01 17:18:46.000000000 +0200
@@ -222,7 +222,7 @@
 	if (drive->type != ATA_DISK)
 		return 0;
 
-	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
 	OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
 	return 0;
diff -urN linux-2.5.19/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.19/drivers/scsi/ide-scsi.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-01 19:03:48.000000000 +0200
@@ -411,8 +411,7 @@
 	}
 
 	ata_select(drive, 10);
-	if (IDE_CONTROL_REG)
-		OUT_BYTE (drive->ctl,IDE_CONTROL_REG);
+	ata_irq_enable(drive, 1);
 	OUT_BYTE (dma_ok,IDE_FEATURE_REG);
 	OUT_BYTE (bcount >> 8,IDE_BCOUNTH_REG);
 	OUT_BYTE (bcount & 0xff,IDE_BCOUNTL_REG);
diff -urN linux-2.5.19/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.19/include/linux/ide.h	2002-06-01 18:53:06.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-01 19:36:29.000000000 +0200
@@ -38,11 +38,6 @@
 # define SUPPORT_SLOW_DATA_PORTS	1	/* 0 to reduce kernel size */
 #endif
 
-/* Right now this is only needed by a promise controlled.
- */
-#ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
-# define OK_TO_RESET_CONTROLLER	0	/* 0 for use with AH2372A/B interface */
-#endif
 #ifndef FANCY_STATUS_DUMPS		/* 1 for human-readable drive errors */
 # define FANCY_STATUS_DUMPS	1	/* 0 to reduce kernel size */
 #endif
@@ -73,21 +68,22 @@
  */
 
 enum {
-	IDE_DATA_OFFSET	    = 0,
-	IDE_ERROR_OFFSET    = 1,
-	IDE_NSECTOR_OFFSET  = 2,
-	IDE_SECTOR_OFFSET   = 3,
-	IDE_LCYL_OFFSET	    = 4,
-	IDE_HCYL_OFFSET	    = 5,
-	IDE_SELECT_OFFSET   = 6,
-	IDE_STATUS_OFFSET   = 7,
-	IDE_CONTROL_OFFSET  = 8,
-	IDE_IRQ_OFFSET	    = 9,
-	IDE_NR_PORTS	    = 10
+	IDE_DATA_OFFSET		= 0,
+	IDE_ERROR_OFFSET	= 1,
+	IDE_FEATURE_OFFSET	= 1,
+	IDE_NSECTOR_OFFSET	= 2,
+	IDE_SECTOR_OFFSET	= 3,
+	IDE_LCYL_OFFSET		= 4,
+	IDE_HCYL_OFFSET		= 5,
+	IDE_SELECT_OFFSET	= 6,
+	IDE_STATUS_OFFSET	= 7,
+	IDE_COMMAND_OFFSET	= 7,
+	IDE_CONTROL_OFFSET	= 8,
+	IDE_ALTSTATUS_OFFSET	= 8,
+	IDE_IRQ_OFFSET		= 9,
+	IDE_NR_PORTS		= 10
 };
 
-#define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
-#define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
 
 #define IDE_DATA_REG		(drive->channel->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(drive->channel->io_ports[IDE_ERROR_OFFSET])
@@ -96,20 +92,16 @@
 #define IDE_LCYL_REG		(drive->channel->io_ports[IDE_LCYL_OFFSET])
 #define IDE_HCYL_REG		(drive->channel->io_ports[IDE_HCYL_OFFSET])
 #define IDE_SELECT_REG		(drive->channel->io_ports[IDE_SELECT_OFFSET])
-#define IDE_STATUS_REG		(drive->channel->io_ports[IDE_STATUS_OFFSET])
-#define IDE_CONTROL_REG		(drive->channel->io_ports[IDE_CONTROL_OFFSET])
+#define IDE_COMMAND_REG		(drive->channel->io_ports[IDE_STATUS_OFFSET])
 #define IDE_IRQ_REG		(drive->channel->io_ports[IDE_IRQ_OFFSET])
 
 #define IDE_FEATURE_REG		IDE_ERROR_REG
-#define IDE_COMMAND_REG		IDE_STATUS_REG
-#define IDE_ALTSTATUS_REG	IDE_CONTROL_REG
 #define IDE_IREASON_REG		IDE_NSECTOR_REG
 #define IDE_BCOUNTL_REG		IDE_LCYL_REG
 #define IDE_BCOUNTH_REG		IDE_HCYL_REG
 
 #define GET_ERR()		IN_BYTE(IDE_ERROR_REG)
-#define GET_STAT()		IN_BYTE(IDE_STATUS_REG)
-#define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
+#define GET_ALTSTAT()		IN_BYTE(drive->channel->io_ports[IDE_CONTROL_OFFSET])
 #define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
@@ -346,8 +338,6 @@
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 
 	select_t	select;		/* basic drive/head select reg value */
-
-	u8		ctl;		/* "normal" value for IDE_CONTROL_REG */
 	u8		status;		/* last retrived status value for device */
 
 	byte		ready_stat;	/* min status value for drive ready */
@@ -653,25 +643,10 @@
  */
 extern u8 ide_dump_status(struct ata_device *, struct request *rq, const char *, u8);
 
-extern ide_startstop_t ide_error(struct ata_device *, struct request *rq,
-		const char *, byte);
+extern ide_startstop_t ata_error(struct ata_device *, struct request *rq, const char *);
 
-/*
- * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
- * removing leading/trailing blanks and compressing internal blanks.
- * It is primarily used to tidy up the model name/number fields as
- * returned by the WIN_[P]IDENTIFY commands.
- */
-void ide_fixstring(byte *s, const int bytecount, const int byteswap);
+extern void ide_fixstring(char *s, const int bytecount, const int byteswap);
 
-/*
- * This routine busy-waits for the drive status to be not "busy".
- * It then checks the status for all of the "good" bits and none
- * of the "bad" bits, and if all is okay it returns 0.  All other
- * cases return 1 after doing "*startstop = ide_error()", and the
- * caller should return the updated value of "startstop" in this case.
- * "startstop" is unchanged when the function returns 0;
- */
 extern int ide_wait_stat(ide_startstop_t *,
 		struct ata_device *, struct request *rq,
 		byte, byte, unsigned long);
@@ -896,5 +871,7 @@
 extern void ata_select(struct ata_device *, unsigned long);
 extern void ata_mask(struct ata_device *);
 extern int ata_status(struct ata_device *, u8, u8);
+extern int ata_irq_enable(struct ata_device *, int);
+extern void ata_reset(struct ata_channel *);
 
 #endif

--------------050304000804000408090703--

