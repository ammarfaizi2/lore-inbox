Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSFNLIy>; Fri, 14 Jun 2002 07:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317594AbSFNLIx>; Fri, 14 Jun 2002 07:08:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25355 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317473AbSFNLIE>; Fri, 14 Jun 2002 07:08:04 -0400
Message-ID: <3D09CE91.9010109@evision-ventures.com>
Date: Fri, 14 Jun 2002 13:08:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 IDE 90
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070304040700070308020507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304040700070308020507
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Thu Jun 13 20:29:06 CEST 2002 ide-clean-90

- Implement the assertion that the lock is already held, if we run
   ata_status_poll.

- The usual host chip code load from Bartomiej onierkiewicz.  Fortunately
   I'm able to check the sis5513 fixes on a life system.

   More serious stuff... for IDE 88:

	- implement ata_best_pio_mode() in ata-timing.c
	  (play safer than driver's config_chipset_for_pio())

	- replace config_chipset_for_pio() by ata_best_pio_mode()
	  in host chips drivers
	  (trivial for hpt34x.c, hpt366.c and serverworks.c,
	   non-trivial for cmd64x.c and sis5513.c)

	- set PIO also for (U)DMA modes in cmd64x_tune_chipset()
	  (cmd64x.c)

	- fix bug in setting PIO0-2 for devices also supporting PIO3/4
	  (sis5513.c)

	- misc cleanups

- Rename XXX_do_request back do do_request. This was just tmporary tagging.

- Move ata_taskfile() call down to the ide-disk request handler.c, which is the
   only place needing it. Rename ata_taskfile to ata_do_taskfile().  This
   allowed us to implement the assertion that ata_do_taskfile() will be only
   called with the channel lock already held.




--------------070304040700070308020507
Content-Type: text/plain;
 name="ide-clean-90.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-90.diff"

diff -urN linux-2.5.21/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.21/drivers/ide/alim15x3.c	2002-06-09 07:30:37.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-06-13 22:53:06.000000000 +0200
@@ -176,11 +176,6 @@
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void config_chipset_for_pio(struct ata_device *drive)
-{
-	ali15x3_tune_drive(drive, 5);
-}
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static int config_chipset_for_dma(struct ata_device *drive, u8 udma)
 {
@@ -253,7 +248,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		config_chipset_for_pio(drive);
+		ali15x3_tune_drive(drive, 255);
 	}
 
 	udma_enable(drive, on, verbose);
diff -urN linux-2.5.21/drivers/ide/ata-timing.c linux/drivers/ide/ata-timing.c
--- linux-2.5.21/drivers/ide/ata-timing.c	2002-06-09 17:44:23.000000000 +0200
+++ linux/drivers/ide/ata-timing.c	2002-06-13 22:53:06.000000000 +0200
@@ -270,3 +270,25 @@
 
 	return 0;
 }
+
+u8 ata_best_pio_mode(struct ata_device *drive)
+{
+	static u16 eide_pio_timing[6] = { 600, 383, 240, 180, 120, 90 };
+	u16 pio_min;
+	u8 pio;
+
+	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+
+	/* downgrade mode if necessary */
+	pio_min = (pio > 2) ? drive->id->eide_pio_iordy : drive->id->eide_pio;
+
+	if (pio_min)
+		while (pio && pio_min > eide_pio_timing[pio])
+			pio--;
+
+	if (!pio && drive->id->tPIO)
+		return XFER_PIO_SLOW;
+
+	/* don't allow XFER_PIO_5 for now */
+	return XFER_PIO_0 + min_t(u8, pio, 4);
+}
diff -urN linux-2.5.21/drivers/ide/ata-timing.h linux/drivers/ide/ata-timing.h
--- linux-2.5.21/drivers/ide/ata-timing.h	2002-06-09 17:44:23.000000000 +0200
+++ linux/drivers/ide/ata-timing.h	2002-06-13 22:53:06.000000000 +0200
@@ -83,5 +83,6 @@
 extern struct ata_timing* ata_timing_data(short speed);
 extern int ata_timing_compute(struct ata_device *drive,
 		short speed, struct ata_timing *t, int T, int UT);
+extern u8 ata_best_pio_mode(struct ata_device *drive);
 
 #endif
diff -urN linux-2.5.21/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.21/drivers/ide/cmd64x.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-06-13 22:53:06.000000000 +0200
@@ -152,16 +152,14 @@
 }
 
 /*
- * Attempts to set the interface PIO mode.
- * The preferred method of selecting PIO modes (e.g. mode 4) is
- * "echo 'piomode:4' > /proc/ide/hdx/settings".  Special cases are
+ * Attempts to set the interface PIO mode. Special cases are
  * 8: prefetch off, 9: prefetch on, 255: auto-select best mode.
  * Called with 255 at boot time.
  */
 static void cmd64x_tuneproc(struct ata_device *drive, byte mode_wanted)
 {
 	int recovery_time, clock_time;
-	byte recovery_count2, cycle_count;
+	u8 recovery_count2, cycle_count, speed;
 	int setup_count, active_count, recovery_count;
 	struct ata_timing *t;
 
@@ -172,10 +170,14 @@
 			/*set_prefetch_mode(index, mode_wanted);*/
 			cmdprintk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
 			return;
-		case 255: mode_wanted = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
 	}
 
-	t = ata_timing_data(XFER_PIO_0 + min_t(byte, mode_wanted, 4));
+	if (mode_wanted == 255)
+		speed = ata_best_pio_mode(drive);
+	else
+		speed = XFER_PIO_0 + min_t(u8, mode_wanted, 4);
+
+	t = ata_timing_data(speed);
 
 	/*
 	 * I copied all this complicated stuff from cmd640.c and made a few minor changes.
@@ -213,6 +215,9 @@
 	cmdprintk("%s: selected cmd646 PIO mode%d : %d (%dns), clocks=%d/%d/%d\n",
 		drive->name, t.mode - XFER_PIO_0, mode_wanted, cycle_time,
 		setup_count, active_count, recovery_count);
+
+	drive->current_speed = speed;
+	ide_config_drive_speed(drive, speed);
 }
 
 static int cmd64x_ratemask(struct ata_device *drive)
@@ -283,13 +288,26 @@
 	}
 }
 
-static void cmd680_tuneproc(struct ata_device *drive, u8 mode_wanted)
+static void cmd680_tuneproc(struct ata_device *drive, u8 pio)
 {
-	struct ata_channel *hwif = drive->channel;
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 drive_pci;
+	struct ata_channel *ch = drive->channel;
+	struct pci_dev *dev = ch->pci_dev;
+	u8 unit	= (drive->select.b.unit & 0x01);
+	u8 addr_mask = (ch->unit) ? 0x84 : 0x80;
+	u8 drive_pci, mode_pci, speed;
+	u8 channel_timings = cmd680_taskfile_timing(ch);
 	u16 speedt;
 
+	pci_read_config_byte(dev, addr_mask, &mode_pci);
+	mode_pci &= ~(unit ? 0x30 : 0x03);
+
+	if (pio == 255)
+		pio = ata_best_pio_mode(drive) - XFER_PIO_0;
+
+	/* WARNING PIO timing mess is going to happen b/w devices, argh */
+	if ((channel_timings != pio) && (pio > channel_timings))
+		pio = channel_timings;
+
 	switch (drive->dn) {
 		case 0: drive_pci = 0xA4; break;
 		case 1: drive_pci = 0xA6; break;
@@ -302,7 +320,7 @@
 
 	/* cheat for now and use the docs */
 //	switch(cmd680_taskfile_timing(hwif)) {
-	switch(mode_wanted) {
+	switch(pio) {
 		case 4:		speedt = 0x10c1; break;
 		case 3:		speedt = 0x10C3; break;
 		case 2:		speedt = 0x1104; break;
@@ -311,50 +329,11 @@
 		default:	speedt = 0x328A; break;
 	}
 	pci_write_config_word(dev, drive_pci, speedt);
-}
-
-static void config_cmd64x_chipset_for_pio(struct ata_device *drive, u8 set_speed)
-{
-	u8 set_pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	cmd64x_tuneproc(drive, set_pio);
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, XFER_PIO_0 + set_pio);
-}
-
-static void config_cmd680_chipset_for_pio(struct ata_device *drive, u8 set_speed)
-{
-	struct ata_channel *hwif = drive->channel;
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 addr_mask		= (hwif->unit) ? 0x84 : 0x80;
-	u8 speed;
-	u8 mode_pci;
-	u8 channel_timings	= cmd680_taskfile_timing(hwif);
-	u8 set_pio		= ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	pci_read_config_byte(dev, addr_mask, &mode_pci);
-	mode_pci &= ~((unit) ? 0x30 : 0x03);
 
-	/* WARNING PIO timing mess is going to happen b/w devices, argh */
-	if ((channel_timings != set_pio) && (set_pio > channel_timings))
-		set_pio = channel_timings;
+	speed = XFER_PIO_0 + min_t(u8, pio, 4);
 
-	cmd680_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	if (set_speed) {
-		(void) ide_config_drive_speed(drive, speed);
-		drive->current_speed = speed;
-	}
-}
-
-static void config_chipset_for_pio(struct ata_device *drive, byte set_speed)
-{
-        if (drive->channel->pci_dev->device == PCI_DEVICE_ID_CMD_680) {
-		config_cmd680_chipset_for_pio(drive, set_speed);
-	} else {
-		config_cmd64x_chipset_for_pio(drive, set_speed);
-	}
+	drive->current_speed = speed;
+	ide_config_drive_speed(drive, speed);
 }
 
 static int cmd64x_tune_chipset(struct ata_device *drive, byte speed)
@@ -403,11 +382,13 @@
 		case XFER_PIO_1:
 		case XFER_PIO_0:
 			cmd64x_tuneproc(drive, speed - XFER_PIO_0);
-			break;
+			/* FIXME: error checking  --bkz */
+			return 0;
 		default:
 			return 1;
 	}
 
+	cmd64x_tuneproc(drive, 255);
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	(void) pci_write_config_byte(dev, pciU, regU);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -510,14 +491,13 @@
 		case XFER_PIO_1:
 		case XFER_PIO_0:
 			cmd680_tuneproc(drive, speed - XFER_PIO_0);
-			break;
+			/* FIXME: error checking  --bkz */
+			return 0;
 		default:
 			return 1;
 	}
 
-	if (speed >= XFER_MW_DMA_0) 
-		config_cmd680_chipset_for_pio(drive, 0);
-
+	cmd680_tuneproc(drive, 255);
 	if (speed >= XFER_UDMA_0)
 		mode_pci |= ((unit) ? 0x30 : 0x03);
 	else if (speed >= XFER_MW_DMA_0)
@@ -552,12 +532,6 @@
 
 	mode = ata_timing_mode(drive, map);
 
-	if (mode < XFER_SW_DMA_0) {
-		config_chipset_for_pio(drive, 1);
-		return 0;
-	}
-
-	config_chipset_for_pio(drive, 0);
 	return !drive->channel->speedproc(drive, mode);
 }
 
@@ -568,6 +542,8 @@
 	int on = 1;
 	int verbose = 1;
 
+	hwif->tuneproc(drive, 255);
+
 	if ((id != NULL) && ((id->capability & 1) != 0) &&
 	    hwif->autodma && (drive->type == ATA_DISK)) {
 		/* Consult the list of known "bad" drives */
@@ -610,7 +586,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		config_chipset_for_pio(drive, 1);
+		hwif->tuneproc(drive, 255);
 	}
 
 	udma_enable(drive, on, verbose);
diff -urN linux-2.5.21/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.21/drivers/ide/device.c	2002-06-11 00:17:34.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-14 00:02:43.000000000 +0200
@@ -126,9 +126,8 @@
  * setting a timer to wake up at half second intervals thereafter, until
  * timeout is achieved, before timing out.
  *
- * FIXME: Channel lock should be held.
+ * Channel lock should be held.
  */
-
 int ata_status_poll(struct ata_device *drive, u8 good, u8 bad,
 		unsigned long timeout,
 		struct request *rq, ide_startstop_t *startstop)
@@ -159,6 +158,7 @@
 		if (ata_status(drive, good, bad))
 			return 0;
 	}
+
 	*startstop = ata_error(drive, rq, "status error");
 
 	return 1;
diff -urN linux-2.5.21/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.21/drivers/ide/hpt34x.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-13 22:53:06.000000000 +0200
@@ -67,43 +67,6 @@
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void config_chipset_for_pio(struct ata_device *drive)
-{
-	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
-	unsigned short xfer_pio = drive->id->eide_pio_modes;
-
-	u8 timing, speed, pio;
-
-	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	if (xfer_pio > 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0) {
-		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
-			xfer_pio--);
-	} else {
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 : xfer_pio;
-	}
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
-	switch(timing) {
-		case 4: speed = XFER_PIO_4;break;
-		case 3: speed = XFER_PIO_3;break;
-		case 2: speed = XFER_PIO_2;break;
-		case 1: speed = XFER_PIO_1;break;
-		default:
-			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
-			break;
-		}
-	(void) hpt34x_tune_chipset(drive, speed);
-}
-
 static void hpt34x_tune_drive(struct ata_device *drive, u8 pio)
 {
 	(void) hpt34x_tune_chipset(drive, XFER_PIO_0 + min_t(u8, pio, 4));
@@ -177,7 +140,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		config_chipset_for_pio(drive);
+		hpt34x_tune_chipset(drive, ata_best_pio_mode(drive));
 	}
 
 #ifndef CONFIG_HPT34X_AUTODMA
diff -urN linux-2.5.21/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.21/drivers/ide/hpt366.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-13 22:53:06.000000000 +0200
@@ -682,44 +682,6 @@
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void config_chipset_for_pio(struct ata_device *drive)
-{
-	static unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
-	unsigned short xfer_pio = drive->id->eide_pio_modes;
-	u8 timing, speed, pio;
-
-	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	if (xfer_pio > 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0) {
-		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
-			xfer_pio--);
-	} else {
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 :
-			   (drive->id->tPIO & 2) ? 0x02 :
-			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
-	}
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
-	switch(timing) {
-		case 4: speed = XFER_PIO_4;break;
-		case 3: speed = XFER_PIO_3;break;
-		case 2: speed = XFER_PIO_2;break;
-		case 1: speed = XFER_PIO_1;break;
-		default:
-			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
-			break;
-	}
-	hpt3xx_tune_chipset(drive, speed);
-}
-
 static void hpt3xx_tune_drive(struct ata_device *drive, u8 pio)
 {
 	u8 speed;
@@ -866,8 +828,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-
-		config_chipset_for_pio(drive);
+		hpt3xx_tune_chipset(drive, ata_best_pio_mode(drive));
 	}
 	udma_enable(drive, on, verbose);
 
diff -urN linux-2.5.21/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.21/drivers/ide/ide.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-13 23:34:16.000000000 +0200
@@ -671,28 +671,12 @@
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
 
 	ata_select(drive, 0);
-	spin_unlock_irq(ch->lock);
 	if (ata_status_poll(drive, drive->ready_stat, BUSY_STAT | DRQ_STAT,
 				WAIT_READY, rq, &ret)) {
 		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
-		spin_lock_irq(ch->lock);
 
-		return ret;
+		goto kill_rq;
 	}
-	spin_lock_irq(ch->lock);
-
-	/* This issues a special drive command.
-	 *
-	 * FIXME: move this down to idedisk_do_request().
-	 */
-	if (rq->flags & REQ_SPECIAL)
-		if (drive->type == ATA_DISK) {
-			spin_unlock_irq(ch->lock);
-			ret = ata_taskfile(drive, rq->special, NULL);
-			spin_lock_irq(ch->lock);
-
-			return ret;
-		}
 
 	if (!ata_ops(drive)) {
 		printk(KERN_WARNING "%s: device type %d not supported\n",
@@ -704,8 +688,8 @@
 	 * handler down to the device type driver.
 	 */
 
-	if (ata_ops(drive)->XXX_do_request) {
-		ret = ata_ops(drive)->XXX_do_request(drive, rq, block);
+	if (ata_ops(drive)->do_request) {
+		ret = ata_ops(drive)->do_request(drive, rq, block);
 	} else {
 		__ata_end_request(drive, rq, 0, 0);
 		ret = ide_stopped;
diff -urN linux-2.5.21/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.21/drivers/ide/ide-cd.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-13 23:39:32.000000000 +0200
@@ -732,46 +732,49 @@
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
+	int ret;
 
+	spin_lock_irqsave(ch->lock, flags);
 	/* Wait for the controller to be idle. */
 	if (ata_status_poll(drive, 0, BUSY_STAT, WAIT_READY, rq, &startstop))
-		return startstop;
-
-	spin_lock_irqsave(ch->lock, flags);
-
-	if (info->dma) {
-		if (info->cmd == READ || info->cmd == WRITE)
-			info->dma = !udma_init(drive, rq);
-		else
-			printk("ide-cd: DMA set, but not allowed\n");
-	}
-
-	/* Set up the controller registers. */
-	OUT_BYTE(info->dma, IDE_FEATURE_REG);
-	OUT_BYTE(0, IDE_NSECTOR_REG);
-	OUT_BYTE(0, IDE_SECTOR_REG);
-
-	OUT_BYTE(xferlen & 0xff, IDE_LCYL_REG);
-	OUT_BYTE(xferlen >> 8  , IDE_HCYL_REG);
-	ata_irq_enable(drive, 1);
-	if (info->dma)
-		udma_start(drive, rq);
-
-	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
-		ata_set_handler(drive, handler, WAIT_CMD, cdrom_timer_expiry);
-		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
-		spin_unlock_irqrestore(ch->lock, flags);
+		ret = startstop;
+	else {
+		if (info->dma) {
+			if (info->cmd == READ || info->cmd == WRITE)
+				info->dma = !udma_init(drive, rq);
+			else
+				printk("ide-cd: DMA set, but not allowed\n");
+		}
 
-		return ide_started;
-	} else {
-		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
-		spin_unlock_irqrestore(ch->lock, flags);
+		/* Set up the controller registers. */
+		OUT_BYTE(info->dma, IDE_FEATURE_REG);
+		OUT_BYTE(0, IDE_NSECTOR_REG);
+		OUT_BYTE(0, IDE_SECTOR_REG);
+
+		OUT_BYTE(xferlen & 0xff, IDE_LCYL_REG);
+		OUT_BYTE(xferlen >> 8  , IDE_HCYL_REG);
+		ata_irq_enable(drive, 1);
+		if (info->dma)
+			udma_start(drive, rq);
+
+		if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
+			ata_set_handler(drive, handler, WAIT_CMD, cdrom_timer_expiry);
+			OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
+			ret = ide_started;
+		} else {
+			OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG); /* packet command */
 
-		/* FIXME: Woah we have to ungrab the lock before the IRQ
-		 * handler gets called.
-		 */
-		return handler(drive, rq);
+			/* FIXME: Oj kurwa! We have to ungrab the lock before
+			 * the IRQ handler gets called.
+			 */
+			spin_unlock_irqrestore(ch->lock, flags);
+			ret = handler(drive, rq);
+			spin_lock_irqsave(ch->lock, flags);
+		}
 	}
+	spin_unlock_irqrestore(ch->lock, flags);
+
+	return ret;
 }
 
 /*
@@ -797,10 +800,16 @@
 		if (cdrom_decode_status(&startstop, drive, rq, DRQ_STAT, &stat_dum))
 			return startstop;
 	} else {
+		/* FIXME: make this locking go away */
+		spin_lock_irqsave(ch->lock, flags);
 		/* Otherwise, we must wait for DRQ to get set. */
 		if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
-					WAIT_READY, rq, &startstop))
+					WAIT_READY, rq, &startstop)) {
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return startstop;
+		}
+		spin_unlock_irqrestore(ch->lock, flags);
 	}
 
 	/* Arm the interrupt handler and send the command to the device. */
@@ -1687,8 +1696,6 @@
 
 		return ret;
 	} else if (rq->flags & REQ_SPECIAL) {
-	        /* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		/*
 		 * FIXME: Kill REQ_SEPCIAL and replace it with commands queued
 		 * at the request queue instead as suggested by Linus.
@@ -1696,6 +1703,8 @@
 		 * right now this can only be a reset...
 		 */
 
+	        /* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		cdrom_end_request(drive, rq, 1);
 		spin_lock_irq(ch->lock);
 
@@ -1704,8 +1713,6 @@
 		struct packet_command pc;
 		ide_startstop_t startstop;
 
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		memset(&pc, 0, sizeof(pc));
 		pc.quiet = 1;
 		pc.timeout = 60 * HZ;
@@ -1713,10 +1720,13 @@
 		/* FIXME --mdcki */
 		rq->special = (char *) &pc;
 
+		/* FIXME: make this unlocking go away*/
+		spin_unlock_irq(ch->lock);
 		startstop = cdrom_do_packet_command(drive, rq);
+		spin_lock_irq(ch->lock);
+
 		if (pc.stat)
 			++rq->errors;
-		spin_lock_irq(ch->lock);
 
 		return startstop;
 	}
@@ -2990,7 +3000,7 @@
 	attach:			ide_cdrom_attach,
 	cleanup:		ide_cdrom_cleanup,
 	standby:		NULL,
-	XXX_do_request:		ide_cdrom_do_request,
+	do_request:		ide_cdrom_do_request,
 	end_request:		NULL,
 	ioctl:			ide_cdrom_ioctl,
 	open:			ide_cdrom_open,
diff -urN linux-2.5.21/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.21/drivers/ide/ide-disk.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-13 23:42:53.000000000 +0200
@@ -456,7 +456,7 @@
 
 	rq->special = &args;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_do_taskfile(drive, &args, rq);
 }
 
 static ide_startstop_t lba28_do_request(struct ata_device *drive, struct request *rq, sector_t block)
@@ -496,7 +496,7 @@
 
 	rq->special = &args;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_do_taskfile(drive, &args, rq);
 }
 
 /*
@@ -548,7 +548,7 @@
 
 	rq->special = &args;
 
-	return ata_taskfile(drive, &args, rq);
+	return ata_do_taskfile(drive, &args, rq);
 }
 
 /*
@@ -560,14 +560,16 @@
  */
 static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	unsigned long flags;
-	struct ata_channel *ch = drive->channel;
-	int ret;
+	/* This issues a special drive command.
+	 */
+	if (rq->flags & REQ_SPECIAL)
+		return ata_do_taskfile(drive, rq->special, rq);
 
 	/* FIXME: this check doesn't make sense */
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
 		__ata_end_request(drive, rq, 0, 0);
+
 		return ide_stopped;
 	}
 
@@ -590,6 +592,7 @@
 
 		if (st) {
 			BUG_ON(!ata_pending_commands(drive));
+
 			return ide_started;
 		}
 	}
@@ -1405,7 +1408,7 @@
 	attach:			idedisk_attach,
 	cleanup:		idedisk_cleanup,
 	standby:		idedisk_standby,
-	XXX_do_request:		idedisk_do_request,
+	do_request:		idedisk_do_request,
 	end_request:		NULL,
 	ioctl:			idedisk_ioctl,
 	open:			idedisk_open,
diff -urN linux-2.5.21/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.21/drivers/ide/ide-floppy.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-13 23:22:32.000000000 +0200
@@ -958,27 +958,25 @@
 	idefloppy_ireason_reg_t ireason;
 	int ret;
 
+	/* FIXME: Move this lock upwards.
+	 */
+	spin_lock_irqsave(ch->lock, flags);
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
 
-		return startstop;
-	}
-
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
-
-	spin_lock_irqsave(ch->lock, flags);
-	ireason.all=IN_BYTE (IDE_IREASON_REG);
-
-	if (!ireason.b.cod || ireason.b.io) {
-		printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
-		ret = ide_stopped;
+		ret = startstop;
 	} else {
-		ata_set_handler (drive, idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
-		atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
-		ret = ide_started;
+		ireason.all=IN_BYTE (IDE_IREASON_REG);
+
+		if (!ireason.b.cod || ireason.b.io) {
+			printk (KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while issuing a packet command\n");
+			ret = ide_stopped;
+		} else {
+			ata_set_handler (drive, idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
+			atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
+			ret = ide_started;
+		}
 	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
@@ -2047,7 +2045,7 @@
 	attach:			idefloppy_attach,
 	cleanup:		idefloppy_cleanup,
 	standby:		NULL,
-	XXX_do_request:		idefloppy_do_request,
+	do_request:		idefloppy_do_request,
 	end_request:		idefloppy_end_request,
 	ioctl:			idefloppy_ioctl,
 	open:			idefloppy_open,
diff -urN linux-2.5.21/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.21/drivers/ide/ide-tape.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-13 23:21:33.000000000 +0200
@@ -2067,6 +2067,7 @@
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_FAST;
 			tape->dsc_timeout = jiffies + IDETAPE_DSC_MA_TIMEOUT;
 			idetape_postpone_request(drive, rq);		/* Allow ide.c to handle other requests */
+
 			return ide_stopped;
 		}
 		if (tape->failed_pc == pc)
@@ -2074,20 +2075,22 @@
 		pc->callback(drive, rq);	/* Command finished - Call the callback function */
 		return ide_stopped;
 	}
+	/* FIXME: this locking should encompass the above register
+	 * file access too.
+	 */
+
+	spin_lock_irqsave(ch->lock, flags);
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk (KERN_ERR "ide-tape: The tape wants to issue more interrupts in DMA mode\n");
 		printk (KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
 		udma_enable(drive, 0, 1);
+		spin_unlock_irqrestore(ch->lock, flags);
 
 		return ide_stopped;
 	}
 #endif
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
 
-	spin_lock_irqsave(ch->lock, flags);
 	bcount.b.high = IN_BYTE (IDE_BCOUNTH_REG);			/* Get the number of bytes to transfer */
 	bcount.b.low  = IN_BYTE (IDE_BCOUNTL_REG);			/* on this interrupt */
 	ireason.all   = IN_BYTE (IDE_IREASON_REG);
@@ -2198,37 +2201,35 @@
 	ide_startstop_t startstop;
 	int ret;
 
+	/* FIXME: Move this lock upwards.
+	 */
+	spin_lock_irqsave(ch->lock, flags);
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ isn't asserted\n");
 
-		return startstop;
-	}
-
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
-
-	spin_lock_irqsave(ch->lock, flags);
-	ireason.all = IN_BYTE (IDE_IREASON_REG);
-	while (retries-- && (!ireason.b.cod || ireason.b.io)) {
-		printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing a packet command, retrying\n");
-		udelay(100);
-		ireason.all = IN_BYTE(IDE_IREASON_REG);
-		if (retries == 0) {
-			printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing a packet command, ignoring\n");
-			ireason.b.cod = 1;
-			ireason.b.io = 0;
-		}
-	}
-	if (!ireason.b.cod || ireason.b.io) {
-		printk (KERN_ERR "ide-tape: (IO,CoD) != (0,1) while issuing a packet command\n");
-		ret = ide_stopped;
+		ret = startstop;
 	} else {
-		tape->cmd_start_time = jiffies;
-		ata_set_handler(drive, idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
-		atapi_write(drive,pc->c,12);	/* Send the actual packet */
-		ret = ide_started;
+		ireason.all = IN_BYTE (IDE_IREASON_REG);
+		while (retries-- && (!ireason.b.cod || ireason.b.io)) {
+			printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing a packet command, retrying\n");
+			udelay(100);
+			ireason.all = IN_BYTE(IDE_IREASON_REG);
+			if (retries == 0) {
+				printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing a packet command, ignoring\n");
+				ireason.b.cod = 1;
+				ireason.b.io = 0;
+			}
+		}
+		if (!ireason.b.cod || ireason.b.io) {
+			printk (KERN_ERR "ide-tape: (IO,CoD) != (0,1) while issuing a packet command\n");
+			ret = ide_stopped;
+		} else {
+			tape->cmd_start_time = jiffies;
+			ata_set_handler(drive, idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
+			atapi_write(drive,pc->c,12);	/* Send the actual packet */
+			ret = ide_started;
+		}
 	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
@@ -2736,10 +2737,8 @@
 			}
 		} else if (jiffies - tape->dsc_polling_start > IDETAPE_DSC_MA_THRESHOLD)
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_SLOW;
-		/* FIXME: make this unlocking go away*/
-		spin_unlock_irq(ch->lock);
 		idetape_postpone_request(drive, rq);
-		spin_lock_irq(ch->lock);
+
 		return ide_stopped;
 	}
 	switch (rq->flags) {
@@ -6128,7 +6127,7 @@
 	attach:			idetape_attach,
 	cleanup:		idetape_cleanup,
 	standby:		NULL,
-	XXX_do_request:		idetape_do_request,
+	do_request:		idetape_do_request,
 	end_request:		idetape_end_request,
 	ioctl:			idetape_blkdev_ioctl,
 	open:			idetape_blkdev_open,
diff -urN linux-2.5.21/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.21/drivers/ide/ide-taskfile.c	2002-06-13 20:15:09.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-13 23:41:56.000000000 +0200
@@ -177,9 +177,9 @@
 }
 
 /*
- * FIXME: Channel lock should be held on entry.
+ * Channel lock should be held on entry.
  */
-ide_startstop_t ata_taskfile(struct ata_device *drive,
+ide_startstop_t ata_do_taskfile(struct ata_device *drive,
 		struct ata_taskfile *ar, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
@@ -196,27 +196,21 @@
 	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
 	    (drive->addressing == 1))
 		ata_out_regfile(drive, &ar->hobfile);
+
 	ata_out_regfile(drive, &ar->taskfile);
 
 	OUT_BYTE((ar->taskfile.device_head & (drive->addressing ? 0xE0 : 0xEF)) | drive->select.all,
 			IDE_SELECT_REG);
 
 	if (ar->handler) {
-		unsigned long flags;
 		struct ata_channel *ch = drive->channel;
 
 		/* This is apparently supposed to reset the wait timeout for
 		 * the interrupt to accur.
 		 */
 
-		/* FIXME: this locking should encompass the above register
-		 * file access too.
-		 */
-
-		spin_lock_irqsave(ch->lock, flags);
 		ata_set_handler(drive, ar->handler, WAIT_CMD, NULL);
 		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
-		spin_unlock_irqrestore(ch->lock, flags);
 
 		/* FIXME: Warning check for race between handler and prehandler
 		 * for writing first block of data.  however since we are well
@@ -240,6 +234,7 @@
 						WAIT_DRQ, rq, &startstop)) {
 				printk(KERN_ERR "%s: no DRQ after issuing %s\n",
 						drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
+
 				return startstop;
 			}
 
@@ -261,6 +256,7 @@
 				return ide_started;
 			} else {
 				int i;
+				int ret;
 
 				/* Polling wait until the drive is ready.
 				 *
@@ -278,7 +274,12 @@
 				if (!drive_is_ready(drive)) {
 					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
 				}
-				return ar->handler(drive, rq);
+				/* FIXME: make this unlocking go away*/
+				spin_unlock_irq(ch->lock);
+				ret =  ar->handler(drive, rq);
+				spin_lock_irq(ch->lock);
+
+				return ret;
 			}
 		}
 	} else {
@@ -448,6 +449,6 @@
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
-EXPORT_SYMBOL(ata_taskfile);
+EXPORT_SYMBOL(ata_do_taskfile);
 EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.21/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.21/drivers/ide/pdc202xx.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-13 22:53:06.000000000 +0200
@@ -364,12 +364,12 @@
  * 180, 120,  90,  90,  90,  60,  30
  *  11,   5,   4,   3,   2,   1,   0
  */
-static void config_chipset_for_pio(struct ata_device *drive, byte pio)
+static void pdc202xx_tune_drive(struct ata_device *drive, u8 pio)
 {
-	byte speed;
+	u8 speed;
 
 	if (pio == 255)
-		speed = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
+		speed = ata_best_pio_mode(drive);
 	else	speed = XFER_PIO_0 + min_t(byte, pio, 4);
 
 	pdc202xx_tune_chipset(drive, speed);
@@ -543,7 +543,7 @@
 		} else goto no_dma_set;
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 no_dma_set:
-		config_chipset_for_pio(drive, 5);
+		pdc202xx_tune_drive(drive, 255);
 	}
 
 	udma_enable(drive, on, verbose);
@@ -723,7 +723,7 @@
 
 static void __init ide_init_pdc202xx(struct ata_channel *hwif)
 {
-	hwif->tuneproc  = &config_chipset_for_pio;
+	hwif->tuneproc  = &pdc202xx_tune_drive;
 	hwif->quirkproc = &check_in_drive_lists;
 
         switch(hwif->pci_dev->device) {
diff -urN linux-2.5.21/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.21/drivers/ide/pdc4030.c	2002-06-10 23:47:13.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-13 21:54:55.000000000 +0200
@@ -247,12 +247,19 @@
 	if (pdc4030_cmd(drive, PROMISE_GET_CONFIG)) {
 		return 0;
 	}
+
+	/* FIXME: Make this go away. */
+	spin_lock_irq(hwif->lock);
 	if (ata_status_poll(drive, DATA_READY, BAD_W_STAT,
 				WAIT_DRQ, NULL, &startstop)) {
 		printk(KERN_INFO
 			"%s: Failed Promise read config!\n",hwif->name);
+		spin_unlock_irq(hwif->lock);
+
 		return 0;
 	}
+	spin_unlock_irq(hwif->lock);
+
 	promise_read(drive, &ident, SECTOR_WORDS);
 	if (ident.id[1] != 'P' || ident.id[0] != 'T') {
 		return 0;
@@ -720,21 +727,34 @@
 
 	case WRITE: {
 		ide_startstop_t startstop;
-/*
- * Strategy on write is:
- *	look for the DRQ that should have been immediately asserted
- *	copy the request into the hwgroup's scratchpad
- *	call the promise_write function to deal with writing the data out
- * NOTE: No interrupts are generated on writes. Write completion must be polled
- */
+		unsigned long flags;
+		struct ata_channel *ch = drive->channel;
+
+		/*
+		 * Strategy on write is: look for the DRQ that should have been
+		 * immediately asserted copy the request into the hwgroup's
+		 * scratchpad call the promise_write function to deal with
+		 * writing the data out.
+		 *
+		 * NOTE: No interrupts are generated on writes. Write
+		 * completion must be polled
+		 */
+
+		/* FIXME: Move this lock upwards.
+		 */
+		spin_lock_irqsave(ch->lock, flags);
 		if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
 					WAIT_DRQ, rq, &startstop )) {
 			printk(KERN_ERR "%s: no DRQ after issuing "
 			       "PROMISE_WRITE\n", drive->name);
+			spin_unlock_irqrestore(ch->lock, flags);
+
 			return startstop;
 		}
 		if (!drive->channel->unmask)
 			__cli();	/* local CPU only */
+		spin_unlock_irqrestore(ch->lock, flags);
+
 		return promise_do_write(drive, rq);
 	}
 
diff -urN linux-2.5.21/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.21/drivers/ide/serverworks.c	2002-06-09 17:44:23.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-06-13 22:53:06.000000000 +0200
@@ -226,44 +226,6 @@
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void config_chipset_for_pio(struct ata_device *drive)
-{
-	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
-	unsigned short xfer_pio = drive->id->eide_pio_modes;
-	byte timing, speed, pio;
-
-	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	if (xfer_pio > 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0)
-		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
-			xfer_pio--);
-	else
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 :
-			   (drive->id->tPIO & 2) ? 0x02 :
-			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
-	switch(timing) {
-		case 4: speed = XFER_PIO_4;break;
-		case 3: speed = XFER_PIO_3;break;
-		case 2: speed = XFER_PIO_2;break;
-		case 1: speed = XFER_PIO_1;break;
-		default:
-			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
-			break;
-	}
-	(void) svwks_tune_chipset(drive, speed);
-	drive->current_speed = speed;
-}
-
 static void svwks_tune_drive(struct ata_device *drive, byte pio)
 {
 	byte speed;
@@ -337,7 +299,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		config_chipset_for_pio(drive);
+		svwks_tune_chipset(drive, ata_best_pio_mode(drive));
 	}
 
 	udma_enable(drive, on, verbose);
diff -urN linux-2.5.21/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.21/drivers/ide/sis5513.c	2002-06-09 07:29:00.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-06-13 22:53:06.000000000 +0200
@@ -263,15 +263,11 @@
 
 
 /* Set per-drive active and recovery time */
-static void config_art_rwp_pio(struct ata_device *drive, u8 pio)
+static int config_art_rwp_pio(struct ata_device *drive, u8 pio)
 {
 	struct ata_channel *hwif = drive->channel;
-	struct pci_dev *dev	= hwif->pci_dev;
-
-	byte			timing, drive_pci, test1, test2;
-
-	unsigned short eide_pio_timing[6] = {600, 390, 240, 180, 120, 90};
-	unsigned short xfer_pio = drive->id->eide_pio_modes;
+	struct pci_dev *dev = hwif->pci_dev;
+	u8 drive_pci, test1, test2, speed;
 
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
@@ -279,25 +275,6 @@
 
 	config_drive_art_rwp(drive);
 
-	if (pio == 255)
-		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
-
-	if (xfer_pio> 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0) {
-		for (xfer_pio = 5;
-			(xfer_pio > 0) &&
-			(drive->id->eide_pio_iordy > eide_pio_timing[xfer_pio]);
-			xfer_pio--);
-	} else {
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 : xfer_pio;
-	}
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
 #ifdef DEBUG
 	printk("SIS5513: config_drive_art_rwp_pio, drive %d, pio %d, timing %d\n",
 	       drive->dn, pio, timing);
@@ -308,7 +285,7 @@
 		case 1:		drive_pci = 0x42; break;
 		case 2:		drive_pci = 0x44; break;
 		case 3:		drive_pci = 0x46; break;
-		default:	return;
+		default:	return 1;
 	}
 
 	/* register layout changed with newer ATA100 chips */
@@ -320,7 +297,7 @@
 		test1 &= ~0x0F;
 		test2 &= ~0x07;
 
-		switch(timing) {
+		switch(pio) {
 			case 4:		test1 |= 0x01; test2 |= 0x03; break;
 			case 3:		test1 |= 0x03; test2 |= 0x03; break;
 			case 2:		test1 |= 0x04; test2 |= 0x04; break;
@@ -330,7 +307,7 @@
 		pci_write_config_byte(dev, drive_pci, test1);
 		pci_write_config_byte(dev, drive_pci+1, test2);
 	} else {
-		switch(timing) { /*   active  recovery
+		switch(pio) { /*   active  recovery
 					  v     v */
 			case 4:		test1 = 0x30|0x01; break;
 			case 3:		test1 = 0x30|0x03; break;
@@ -344,21 +321,7 @@
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
 #endif
-}
-
-static int config_chipset_for_pio(struct ata_device *drive, u8 pio)
-{
-	u8 speed;
-
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4; break;
-		case 3:		speed = XFER_PIO_3; break;
-		case 2:		speed = XFER_PIO_2; break;
-		case 1:		speed = XFER_PIO_1; break;
-		default:	speed = XFER_PIO_0; break;
-	}
-
-	config_art_rwp_pio(drive, pio);
+	speed = XFER_PIO_0 + min_t(u8, pio, 4);
 	drive->current_speed = speed;
 	return ide_config_drive_speed(drive, speed);
 }
@@ -424,12 +387,14 @@
 		case XFER_SW_DMA_0:
 			break;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
-		case XFER_PIO_4: return((int) config_chipset_for_pio(drive, 4));
-		case XFER_PIO_3: return((int) config_chipset_for_pio(drive, 3));
-		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
-		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:
-		default:	 return((int) config_chipset_for_pio(drive, 0));
+			return config_art_rwp_pio(drive, speed - XFER_PIO_0);
+		default:
+			return config_art_rwp_pio(drive, 0);
 	}
 	drive->current_speed = speed;
 #ifdef DEBUG
@@ -440,7 +405,10 @@
 
 static void sis5513_tune_drive(struct ata_device *drive, u8 pio)
 {
-	(void) config_chipset_for_pio(drive, pio);
+	if (pio == 255)
+		pio = ata_best_pio_mode(drive) - XFER_PIO_0;
+
+	(void)config_art_rwp_pio(drive, min_t(u8, pio, 4));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -473,8 +441,7 @@
 	int verbose = 1;
 
 	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-	config_chipset_for_pio(drive, 5);
+	sis5513_tune_drive(drive, 255);
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
@@ -515,7 +482,7 @@
 		on = 0;
 		verbose = 0;
 no_dma_set:
-		(void) config_chipset_for_pio(drive, 5);
+		sis5513_tune_drive(drive, 255);
 	}
 
 	udma_enable(drive, on, verbose);
diff -urN linux-2.5.21/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.21/drivers/scsi/ide-scsi.c	2002-06-13 20:29:39.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-13 23:23:25.000000000 +0200
@@ -403,25 +403,24 @@
 	ide_startstop_t startstop;
 	int ret;
 
+	/* FIXME: Move this lock upwards.
+	 */
+	spin_lock_irqsave(ch->lock, flags);
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
 				WAIT_READY, rq, &startstop)) {
 		printk (KERN_ERR "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted\n");
-		return startstop;
-	}
-
-	/* FIXME: this locking should encompass the above register
-	 * file access too.
-	 */
-	spin_lock_irqsave(ch->lock, flags);
-	ireason = IN_BYTE(IDE_IREASON_REG);
-
-	if ((ireason & (IDESCSI_IREASON_IO | IDESCSI_IREASON_COD)) != IDESCSI_IREASON_COD) {
-		printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
-		ret = ide_stopped;
+		ret = startstop;
 	} else {
-		ata_set_handler(drive, idescsi_pc_intr, get_timeout(pc), NULL);
-		atapi_write(drive, scsi->pc->c, 12);
-		ret = ide_started;
+		ireason = IN_BYTE(IDE_IREASON_REG);
+
+		if ((ireason & (IDESCSI_IREASON_IO | IDESCSI_IREASON_COD)) != IDESCSI_IREASON_COD) {
+			printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
+			ret = ide_stopped;
+		} else {
+			ata_set_handler(drive, idescsi_pc_intr, get_timeout(pc), NULL);
+			atapi_write(drive, scsi->pc->c, 12);
+			ret = ide_started;
+		}
 	}
 	spin_unlock_irqrestore(ch->lock, flags);
 
@@ -549,7 +548,7 @@
 	owner:			THIS_MODULE,
 	attach:			idescsi_attach,
 	cleanup:		idescsi_cleanup,
-	XXX_do_request:		idescsi_do_request,
+	do_request:		idescsi_do_request,
 	end_request:		idescsi_end_request,
 	open:			idescsi_open,
 	release:		idescsi_release,
diff -urN linux-2.5.21/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.21/include/linux/ide.h	2002-06-13 20:29:39.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-13 23:29:55.000000000 +0200
@@ -545,7 +545,7 @@
 	void (*attach) (struct ata_device *);
 	int (*cleanup)(struct ata_device *);
 	int (*standby)(struct ata_device *);
-	ide_startstop_t	(*XXX_do_request)(struct ata_device *, struct request *, sector_t);
+	ide_startstop_t	(*do_request)(struct ata_device *, struct request *, sector_t);
 	int (*end_request)(struct ata_device *, struct request *, int);
 
 	int (*ioctl)(struct ata_device *, struct inode *, struct file *, unsigned int, unsigned long);
@@ -657,7 +657,7 @@
 extern void ata_read(struct ata_device *, void *, unsigned int);
 extern void ata_write(struct ata_device *, void *, unsigned int);
 
-extern ide_startstop_t ata_taskfile(struct ata_device *,
+extern ide_startstop_t ata_do_taskfile(struct ata_device *,
 	struct ata_taskfile *, struct request *);
 
 /*

--------------070304040700070308020507--

