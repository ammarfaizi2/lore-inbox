Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSFBUoP>; Sun, 2 Jun 2002 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFBUoO>; Sun, 2 Jun 2002 16:44:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61190 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314083AbSFBUoD>; Sun, 2 Jun 2002 16:44:03 -0400
Message-ID: <3CFA75DF.1020401@evision-ventures.com>
Date: Sun, 02 Jun 2002 21:45:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 IDE 81
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080001060901040808080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080001060901040808080905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sun Jun  2 07:29:17 CEST 2002 ide-clean-81

- Don't use ata_taskfiles cmd field for drive status reporting,
   we can now simply use drive->status instead.

- Unify command type parser entries which could be unified due to the
   unification of corresponding interrupt handlers.

- Eliminate reading parameter from ata_do_udma(). We have this information
   already in the rq. This allows us to merge several methods.

- Rename XXX_udma to udma_setup, since we have finally settled up on this
   semantics.

- Simplify tons of host chip code by removing wrapper functions.

--------------080001060901040808080905
Content-Type: text/plain;
 name="ide-clean-81.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-81.diff"

diff -urN linux-2.5.19/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.19/drivers/ide/aec62xx.c	2002-06-01 18:53:06.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-06-02 12:24:11.000000000 +0200
@@ -150,7 +150,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int aec62xx_dmaproc(struct ata_device *drive)
+static int aec62xx_udma_setup(struct ata_device *drive)
 {
 	u32 bmide = pci_resource_start(drive->channel->pci_dev, 4);
 	short speed;
@@ -244,8 +244,8 @@
 {
 	int i;
 
-	ch->tuneproc = &aec62xx_tune_drive;
-	ch->speedproc = &aec_set_drive;
+	ch->tuneproc = aec62xx_tune_drive;
+	ch->speedproc = aec_set_drive;
 	ch->autodma = 0;
 
 	ch->io_32bit = 1;
@@ -259,7 +259,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (ch->dma_base) {
 		ch->highmem = 1;
-		ch->XXX_udma = aec62xx_dmaproc;
+		ch->udma_setup = aec62xx_udma_setup;
 #ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			ch->autodma = 1;
diff -urN linux-2.5.19/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.19/drivers/ide/alim15x3.c	2002-06-01 18:53:01.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-06-02 12:05:13.000000000 +0200
@@ -199,7 +199,7 @@
 	return !ali15x3_tune_chipset(drive, mode);
 }
 
-static int ali15x3_config_drive_for_dma(struct ata_device *drive)
+static int ali15x3_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	struct ata_channel *hwif = drive->channel;
@@ -261,17 +261,12 @@
 	return 0;
 }
 
-static int ali15x3_udma_write(struct ata_device *drive, struct request *rq)
+static int ali15x3_udma_init(struct ata_device *drive, struct request *rq)
 {
 	if ((m5229_revision < 0xC2) && (drive->type != ATA_DISK))
 		return 1;	/* try PIO instead of DMA */
 
-	return ata_do_udma(0, drive, rq);
-}
-
-static int ali15x3_dmaproc(struct ata_device *drive)
-{
-	return ali15x3_config_drive_for_dma(drive);
+	return udma_pci_init(drive, rq);
 }
 #endif
 
@@ -447,8 +442,8 @@
 		/*
 		 * M1543C or newer for DMAing
 		 */
-		hwif->udma_write = ali15x3_udma_write;
-		hwif->XXX_udma = ali15x3_dmaproc;
+		hwif->udma_init = ali15x3_udma_init;
+		hwif->udma_setup = ali15x3_udma_setup;
 		hwif->autodma = 1;
 	}
 
diff -urN linux-2.5.19/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.19/drivers/ide/amd74xx.c	2002-06-01 18:53:01.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-06-02 11:46:59.000000000 +0200
@@ -177,7 +177,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-int amd74xx_dmaproc(struct ata_device *drive)
+static int amd74xx_udma_setup(struct ata_device *drive)
 {
 	short w80 = drive->channel->udma_four;
 
@@ -291,7 +291,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->XXX_udma = amd74xx_dmaproc;
+		hwif->udma_setup = amd74xx_udma_setup;
 # ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.19/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.19/drivers/ide/cmd64x.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-06-02 11:45:19.000000000 +0200
@@ -627,7 +627,7 @@
 	return 0;
 }
 
-static int cmd680_dmaproc(struct ata_device *drive)
+static int cmd680_udma_setup(struct ata_device *drive)
 {
 	return cmd64x_config_drive_for_dma(drive);
 }
@@ -680,7 +680,7 @@
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static int cmd64x_dmaproc(struct ata_device *drive)
+static int cmd64x_udma_setup(struct ata_device *drive)
 {
 	return cmd64x_config_drive_for_dma(drive);
 }
@@ -703,7 +703,7 @@
  * ASUS P55T2P4D with CMD646 chipset revision 0x01 requires the old
  * event order for DMA transfers.
  */
-static int cmd646_1_dmaproc(struct ata_device *drive)
+static int cmd646_1_udma_setup(struct ata_device *drive)
 {
 	return cmd64x_config_drive_for_dma(drive);
 }
@@ -903,7 +903,7 @@
 			hwif->busproc	= cmd680_busproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA
 			if (hwif->dma_base)
-				hwif->XXX_udma	= cmd680_dmaproc;
+				hwif->udma_setup = cmd680_udma_setup;
 #endif
 			hwif->resetproc = cmd680_reset;
 			hwif->speedproc	= cmd680_tune_chipset;
@@ -914,7 +914,7 @@
 		case PCI_DEVICE_ID_CMD_643:
 #ifdef CONFIG_BLK_DEV_IDEDMA
 			if (hwif->dma_base) {
-				hwif->XXX_udma	= cmd64x_dmaproc;
+				hwif->udma_setup = cmd64x_udma_setup;
 				hwif->udma_stop	= cmd64x_udma_stop;
 				hwif->udma_irq_status = cmd64x_udma_irq_status;
 			}
@@ -927,10 +927,10 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 			if (hwif->dma_base) {
 				if (class_rev == 0x01) {
-					hwif->XXX_udma = cmd646_1_dmaproc;
+					hwif->udma_setup = cmd646_1_udma_setup;
 					hwif->udma_stop = cmd646_1_udma_stop;
 				} else {
-					hwif->XXX_udma = cmd64x_dmaproc;
+					hwif->udma_setup = cmd64x_udma_setup;
 					hwif->udma_stop = cmd64x_udma_stop;
 					hwif->udma_irq_status = cmd64x_udma_irq_status;
 				}
diff -urN linux-2.5.19/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.19/drivers/ide/cs5530.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-06-02 11:47:25.000000000 +0200
@@ -191,7 +191,7 @@
 	return 0;
 }
 
-int cs5530_dmaproc(struct ata_device *drive)
+static int cs5530_udma_setup(struct ata_device *drive)
 {
 	return cs5530_config_dma(drive);
 }
@@ -292,7 +292,7 @@
 		unsigned int basereg, d0_timings;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->XXX_udma = cs5530_dmaproc;
+	hwif->udma_setup = cs5530_udma_setup;
 	hwif->highmem = 1;
 #else
 	hwif->autodma = 0;
diff -urN linux-2.5.19/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.19/drivers/ide/cy82c693.c	2002-05-29 20:42:49.000000000 +0200
+++ linux/drivers/ide/cy82c693.c	2002-06-02 11:40:41.000000000 +0200
@@ -236,7 +236,7 @@
 /*
  * used to set DMA mode for CY82C693 (single and multi modes)
  */
-static int cy82c693_dmaproc(struct ata_device *drive)
+static int cy82c693_udma_setup(struct ata_device *drive)
 {
 	/*
 	 * Set dma mode for drive everything else is done by the defaul func.
@@ -443,7 +443,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->XXX_udma = cy82c693_dmaproc;
+		hwif->udma_setup = cy82c693_udma_setup;
 		if (!noautodma)
 			hwif->autodma = 1;
 	}
diff -urN linux-2.5.19/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.19/drivers/ide/hpt34x.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-02 11:55:16.000000000 +0200
@@ -172,7 +172,7 @@
 	return !hpt34x_tune_chipset(drive, mode);
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive)
+static int hpt34x_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	int on = 1;
@@ -246,18 +246,23 @@
 	return (dma_stat & 7) != 4;		/* verify good DMA status */
 }
 
-static int do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+static int hpt34x_udma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
 	unsigned int count;
+	u8 cmd;
 
 	if (!(count = udma_new_table(ch, rq)))
 		return 1;	/* try PIO instead of DMA */
 
-	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
-	reading |= 0x01;
-	outb(reading, dma_base);		/* specify r/w */
+	if (rq_data_dir(rq) == READ)
+		cmd = 0x09;
+	else
+		cmd = 0x01;
+
+	outl(ch->dmatable_dma, dma_base + 4);	/* PRD table */
+	outb(cmd, dma_base);			/* specify r/w */
 	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
 	drive->waiting_for_dma = 1;
 
@@ -265,30 +270,10 @@
 		return 0;
 
 	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
-	OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+	OUT_BYTE((cmd == 0x09) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
 	return 0;
 }
-
-static int hpt34x_udma_read(struct ata_device *drive, struct request *rq)
-{
-	return do_udma(1 << 3, drive, rq);
-}
-
-static int hpt34x_udma_write(struct ata_device *drive, struct request *rq)
-{
-	return do_udma(0, drive, rq);
-}
-
-/*
- * This is specific to the HPT343 UDMA bios-less chipset
- * and HPT345 UDMA bios chipset (stamped HPT363)
- * by HighPoint|Triones Technologies, Inc.
- */
-static int hpt34x_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
 #endif
 
 /*
@@ -356,9 +341,8 @@
 			hwif->autodma = 0;
 
 		hwif->udma_stop = hpt34x_udma_stop;
-		hwif->udma_read = hpt34x_udma_read;
-		hwif->udma_write = hpt34x_udma_write;
-		hwif->XXX_udma = hpt34x_dmaproc;
+		hwif->udma_init = hpt34x_udma_init;
+		hwif->udma_setup = hpt34x_udma_setup;
 		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
diff -urN linux-2.5.19/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.19/drivers/ide/hpt366.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-02 12:13:53.000000000 +0200
@@ -836,7 +836,7 @@
 	}
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive)
+static int hpt3xx_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	int on = 1;
@@ -903,15 +903,6 @@
 		pci_write_config_byte(drive->channel->pci_dev, 0x5a, reg5ah & ~0x10);
 }
 
-/*
- * This is specific to the HPT366 UDMA bios chipset
- * by HighPoint|Triones Technologies, Inc.
- */
-static int hpt366_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
-
 static void do_udma_start(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
@@ -992,11 +983,6 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-static int hpt370_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
-
 static int hpt374_udma_stop(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
@@ -1019,11 +1005,6 @@
 
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
-
-static int hpt374_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
 #endif
 
 /*
@@ -1364,27 +1345,27 @@
 
 			if (hpt_min_rev(dev, 7)) {
 				ch->udma_stop = hpt374_udma_stop;
-				ch->XXX_udma = hpt374_dmaproc;
+				ch->udma_setup = hpt3xx_udma_setup;
 			} else if (hpt_min_rev(dev, 5)) {
 				ch->udma_stop = hpt374_udma_stop;
-				ch->XXX_udma = hpt374_dmaproc;
+				ch->udma_setup = hpt3xx_udma_setup;
 			} else if (hpt_min_rev(dev, 3)) {
 			        ch->udma_start = hpt370_udma_start;
 				ch->udma_stop = hpt370_udma_stop;
 				ch->udma_timeout = hpt370_udma_timeout;
 				ch->udma_irq_lost = hpt370_udma_irq_lost;
-				ch->XXX_udma = hpt370_dmaproc;
+				ch->udma_setup = hpt3xx_udma_setup;
 			}
 		} else if (hpt_min_rev(dev, 2)) {
 			ch->udma_irq_lost = hpt366_udma_irq_lost;
 //			ch->resetproc = hpt3xx_reset;
 //			ch->busproc = hpt3xx_tristate;
-			ch->XXX_udma = hpt366_dmaproc;
+			ch->udma_setup = hpt3xx_udma_setup;
 		} else {
 			ch->udma_irq_lost = hpt366_udma_irq_lost;
 //			ch->resetproc = hpt3xx_reset;
 //			ch->busproc = hpt3xx_tristate;
-			ch->XXX_udma = hpt366_dmaproc;
+			ch->udma_setup = hpt3xx_udma_setup;
 		}
 		if (!noautodma)
 			ch->autodma = 1;
diff -urN linux-2.5.19/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.19/drivers/ide/icside.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-02 11:54:10.000000000 +0200
@@ -544,7 +544,7 @@
 	return 0;
 }
 
-static int icside_dma_write(struct ata_device *drive, struct request *rq)
+static int icside_dma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned int cmd;
@@ -612,12 +612,11 @@
 	ch->dmatable_cpu    = NULL;
 	ch->dmatable_dma    = 0;
 	ch->speedproc       = icside_set_speed;
-	ch->XXX_udma        = icside_dma_check;
+	ch->udma_setup	    = icside_dma_check;
 	ch->udma_enable     = icside_dma_enable;
 	ch->udma_start      = icside_dma_start;
 	ch->udma_stop       = icside_dma_stop;
-	ch->udma_read       = icside_dma_read;
-	ch->udma_write      = icside_dma_write;
+	ch->udma_init	    = icside_dma_init;
 	ch->udma_irq_status = icside_irq_status;
 	ch->udma_timeout    = icside_dma_timeout;
 	ch->udma_irq_lost   = icside_irq_lost;
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-02 12:32:10.000000000 +0200
@@ -184,31 +184,6 @@
 	spin_unlock_irqrestore(ch->lock, flags);
 }
 
-static u8 auto_reduce_xfer(struct ata_device *drive)
-{
-	if (!drive->crc_count)
-		return drive->current_speed;
-	drive->crc_count = 0;
-
-	switch(drive->current_speed) {
-		case XFER_UDMA_7:	return XFER_UDMA_6;
-		case XFER_UDMA_6:	return XFER_UDMA_5;
-		case XFER_UDMA_5:	return XFER_UDMA_4;
-		case XFER_UDMA_4:	return XFER_UDMA_3;
-		case XFER_UDMA_3:	return XFER_UDMA_2;
-		case XFER_UDMA_2:	return XFER_UDMA_1;
-		case XFER_UDMA_1:	return XFER_UDMA_0;
-			/*
-			 * OOPS we do not goto non Ultra DMA modes
-			 * without iCRC's available we force
-			 * the system to PIO and make the user
-			 * invoke the ATA-1 ATA-2 DMA modes.
-			 */
-		case XFER_UDMA_0:
-		default:		return XFER_PIO_4;
-	}
-}
-
 static void check_crc_errors(struct ata_device *drive)
 {
 	if (!drive->using_dma)
@@ -218,7 +193,34 @@
 	if (drive->crc_count) {
 		udma_enable(drive, 0, 0);
 		if (drive->channel->speedproc) {
-			u8 pio = auto_reduce_xfer(drive);
+			u8 pio = XFER_PIO_4;
+			drive->crc_count = 0;
+
+			switch (drive->current_speed) {
+			case XFER_UDMA_7: pio = XFER_UDMA_6;
+				break;
+			case XFER_UDMA_6: pio = XFER_UDMA_5;
+				break;
+			case XFER_UDMA_5: pio = XFER_UDMA_4;
+				break;
+			case XFER_UDMA_4: pio = XFER_UDMA_3;
+				break;
+			case XFER_UDMA_3: pio = XFER_UDMA_2;
+				break;
+			case XFER_UDMA_2: pio = XFER_UDMA_1;
+				break;
+			case XFER_UDMA_1: pio = XFER_UDMA_0;
+				break;
+			/*
+			 * OOPS we do not goto non Ultra DMA modes
+			 * without iCRC's available we force
+			 * the system to PIO and make the user
+			 * invoke the ATA-1 ATA-2 DMA modes.
+			 */
+			case XFER_UDMA_0:
+			default:
+				pio = XFER_PIO_4;
+			}
 		        drive->channel->speedproc(drive, pio);
 		}
 		if (drive->current_speed >= XFER_SW_DMA_0)
@@ -408,7 +410,6 @@
 			ar->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
 			ar->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
-			ar->cmd = drive->status;
 			if ((drive->id->command_set_2 & 0x0400) &&
 			    (drive->id->cfs_enable_2 & 0x0400) &&
 			    (drive->addressing == 1)) {
diff -urN linux-2.5.19/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.19/drivers/ide/ide-cd.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-02 11:59:16.000000000 +0200
@@ -736,10 +736,8 @@
 		return startstop;
 
 	if (info->dma) {
-		if (info->cmd == READ)
-			info->dma = !udma_read(drive, rq);
-		else if (info->cmd == WRITE)
-			info->dma = !udma_write(drive, rq);
+		if (info->cmd == READ || info->cmd == WRITE)
+			info->dma = !udma_init(drive, rq);
 		else
 			printk("ide-cd: DMA set, but not allowed\n");
 	}
diff -urN linux-2.5.19/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.19/drivers/ide/ide-disk.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-02 11:34:39.000000000 +0200
@@ -517,7 +517,7 @@
 	if (!drive->driver)
 		return -EPERM;
 
-	if (!drive->channel->XXX_udma)
+	if (!drive->channel->udma_setup)
 		return -EPERM;
 
 	if (arg == drive->queue_depth && drive->using_tcq)
@@ -629,7 +629,7 @@
 	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
-	if ((args.cmd & 0x01) == 0) {
+	if (!(drive->status & ERR_STAT)) {
 		addr = ((args.taskfile.device_head & 0x0f) << 24)
 		     | (args.taskfile.high_cylinder << 16)
 		     | (args.taskfile.low_cylinder <<  8)
@@ -657,7 +657,7 @@
         ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
-	if ((args.cmd & 0x01) == 0) {
+	if (!(drive->status & ERR_STAT)) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
 			   (args.hobfile.low_cylinder << 8) |
 			    args.hobfile.sector_number;
@@ -696,7 +696,7 @@
 	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 	/* if OK, read new maximum address value */
-	if ((args.cmd & 0x01) == 0) {
+	if (!(drive->status & ERR_STAT)) {
 		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
 			 | (args.taskfile.high_cylinder << 16)
 			 | (args.taskfile.low_cylinder <<  8)
@@ -731,7 +731,7 @@
 	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
-	if ((args.cmd & 0x01) == 0) {
+	if (!(drive->status & ERR_STAT)) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
 			   (args.hobfile.low_cylinder << 8) |
 			    args.hobfile.sector_number;
diff -urN linux-2.5.19/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.19/drivers/ide/ide-floppy.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-02 11:56:51.000000000 +0200
@@ -1060,12 +1060,8 @@
 	if (test_and_clear_bit (PC_DMA_ERROR, &pc->flags))
 		udma_enable(drive, 0, 1);
 
-	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit (PC_WRITING, &pc->flags))
-			dma_ok = !udma_write(drive, rq);
-		else
-			dma_ok = !udma_read(drive, rq);
-	}
+	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		dma_ok = !udma_init(drive, rq);
 #endif
 
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-02 12:02:01.000000000 +0200
@@ -260,11 +260,9 @@
 static void pmac_udma_enable(struct ata_device *drive, int on, int verbose);
 static int pmac_udma_start(struct ata_device *drive, struct request *rq);
 static int pmac_udma_stop(struct ata_device *drive);
-static int pmac_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq);
-static int pmac_udma_read(struct ata_device *drive, struct request *rq);
-static int pmac_udma_write(struct ata_device *drive, struct request *rq);
+static int pmac_udma_init(struct ata_device *drive, struct request *rq);
 static int pmac_udma_irq_status(struct ata_device *drive);
-static int pmac_ide_dmaproc(struct ata_device *drive);
+static int pmac_udma_setup(struct ata_device *drive);
 static int pmac_ide_build_dmatable(struct ata_device *drive, struct request *rq, int ix, int wr);
 static int pmac_ide_tune_chipset(struct ata_device *drive, byte speed);
 static void pmac_ide_tuneproc(struct ata_device *drive, byte pio);
@@ -334,10 +332,9 @@
 		ide_hwifs[ix].udma_enable = pmac_udma_enable;
 		ide_hwifs[ix].udma_start = pmac_udma_start;
 		ide_hwifs[ix].udma_stop = pmac_udma_stop;
-		ide_hwifs[ix].udma_read = pmac_udma_read;
-		ide_hwifs[ix].udma_write = pmac_udma_write;
+		ide_hwifs[ix].udma_init = pmac_udma_init;
 		ide_hwifs[ix].udma_irq_status = pmac_udma_irq_status;
-		ide_hwifs[ix].XXX_udma = pmac_ide_dmaproc;
+		ide_hwifs[ix].udma_setup = pmac_udma_setup;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 		if (!noautodma)
 			ide_hwifs[ix].autodma = 1;
@@ -1043,10 +1040,9 @@
 	ide_hwifs[ix].udma_enable = pmac_udma_enable;
 	ide_hwifs[ix].udma_start = pmac_udma_start;
 	ide_hwifs[ix].udma_stop = pmac_udma_stop;
-	ide_hwifs[ix].udma_read = pmac_udma_read;
-	ide_hwifs[ix].udma_write = pmac_udma_write;
+	ide_hwifs[ix].udma_init = pmac_udma_init;
 	ide_hwifs[ix].udma_irq_status = pmac_udma_irq_status;
-	ide_hwifs[ix].XXX_udma = pmac_ide_dmaproc;
+	ide_hwifs[ix].udma_setup = pmac_udma_setup;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
 		ide_hwifs[ix].autodma = 1;
@@ -1405,11 +1401,12 @@
 	return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
 }
 
-static int pmac_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+static int pmac_udma_init(struct ata_device *drive, struct request *rq)
 {
 	int ix, ata4;
 	volatile struct dbdma_regs *dma;
-	byte unit = (drive->select.b.unit & 0x01);
+	u8 unit = (drive->select.b.unit & 0x01);
+	int reading;
 
 	/* Can we stuff a pointer to our intf structure in config_data
 	 * or select_data in hwif ?
@@ -1417,6 +1414,12 @@
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
 		return 0;
+
+	if (rq_data_dir(rq) == READ)
+		reading = 1;
+	else
+		reading = 0;
+
 	dma = pmac_ide[ix].dma_regs;
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
 		pmac_ide[ix].kind == controller_kl_ata4_80);
@@ -1447,16 +1450,6 @@
 	return udma_start(drive, rq);
 }
 
-static int pmac_udma_read(struct ata_device *drive, struct request *rq)
-{
-	return pmac_do_udma(1, drive, rq);
-}
-
-static int pmac_udma_write(struct ata_device *drive, struct request *rq)
-{
-	return pmac_do_udma(0, drive, rq);
-}
-
 /*
  * FIXME: This should be attached to a channel as we can see now!
  */
@@ -1514,7 +1507,7 @@
 	return 0;
 }
 
-static int pmac_ide_dmaproc(struct ata_device *drive)
+static int pmac_udma_setup(struct ata_device *drive)
 {
 	/* Change this to better match ide-dma.c */
 	pmac_ide_check_dma(drive);
diff -urN linux-2.5.19/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.19/drivers/ide/ide-tape.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-02 11:55:34.000000000 +0200
@@ -2258,12 +2258,8 @@
 		printk (KERN_WARNING "ide-tape: DMA disabled, reverting to PIO\n");
 		udma_enable(drive, 0, 1);
 	}
-	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit (PC_WRITING, &pc->flags))
-			dma_ok = !udma_write(drive, rq);
-		else
-			dma_ok = !udma_read(drive, rq);
-	}
+	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		dma_ok = !udma_init(drive, rq);
 #endif
 
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.19/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.19/drivers/ide/ide-taskfile.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-02 11:59:28.000000000 +0200
@@ -350,19 +350,19 @@
 			return ar->prehandler(drive, rq);
 	} else {
 		/*
-		 * FIXME: this is a gross hack, need to unify tcq dma proc and
-		 * regular dma proc.
+		 * FIXME: This is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc. It should now be easier.
 		 */
 
 		if (!drive->using_dma)
 			return ide_started;
 
 		/* for dma commands we don't set the handler */
-		if (ar->cmd == WIN_WRITEDMA  || ar->cmd == WIN_WRITEDMA_EXT)
-			return !udma_write(drive, rq);
-		else if (ar->cmd == WIN_READDMA
+		if (ar->cmd == WIN_WRITEDMA
+		      || ar->cmd == WIN_WRITEDMA_EXT
+		      || ar->cmd == WIN_READDMA
 		      || ar->cmd == WIN_READDMA_EXT)
-			return !udma_read(drive, rq);
+			return !udma_init(drive, rq);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
 		else if (ar->cmd == WIN_WRITEDMA_QUEUED
 		      || ar->cmd == WIN_WRITEDMA_QUEUED_EXT
@@ -371,7 +371,7 @@
 			return udma_tcq_taskfile(drive, rq);
 #endif
 		else {
-			printk("ata_taskfile: unknown command %x\n", ar->cmd);
+			printk(KERN_ERR "%s: unknown command %x\n", __FUNCTION__, ar->cmd);
 			return ide_stopped;
 		}
 	}
@@ -556,31 +556,28 @@
 	 * more data left
 	 */
 	ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+
 	return ide_started;
 }
 
 /* Called to figure out the type of command being called.
  */
-void ide_cmd_type_parser(struct ata_taskfile *args)
+void ide_cmd_type_parser(struct ata_taskfile *ar)
 {
-	struct hd_drive_task_hdr *taskfile = &args->taskfile;
+	struct hd_drive_task_hdr *taskfile = &ar->taskfile;
 
-	args->prehandler = NULL;
-	args->handler = NULL;
+	ar->prehandler = NULL;
+	ar->handler = NULL;
 
-	switch (args->cmd) {
+	switch (ar->cmd) {
 		case WIN_IDENTIFY:
 		case WIN_PIDENTIFY:
-			args->handler = task_in_intr;
-			args->command_type = IDE_DRIVE_TASK_IN;
-			return;
-
 		case CFA_TRANSLATE_SECTOR:
 		case WIN_READ:
 		case WIN_READ_EXT:
 		case WIN_READ_BUFFER:
-			args->handler = task_in_intr;
-			args->command_type = IDE_DRIVE_TASK_IN;
+			ar->handler = task_in_intr;
+			ar->command_type = IDE_DRIVE_TASK_IN;
 			return;
 
 		case CFA_WRITE_SECT_WO_ERASE:
@@ -589,56 +586,56 @@
 		case WIN_WRITE_VERIFY:
 		case WIN_WRITE_BUFFER:
 		case WIN_DOWNLOAD_MICROCODE:
-			args->prehandler = pre_task_out_intr;
-			args->handler = task_out_intr;
-			args->command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			ar->prehandler = pre_task_out_intr;
+			ar->handler = task_out_intr;
+			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 			return;
 
 		case WIN_MULTREAD:
 		case WIN_MULTREAD_EXT:
-			args->handler = task_mulin_intr;
-			args->command_type = IDE_DRIVE_TASK_IN;
+			ar->handler = task_mulin_intr;
+			ar->command_type = IDE_DRIVE_TASK_IN;
 			return;
 
 		case CFA_WRITE_MULTI_WO_ERASE:
 		case WIN_MULTWRITE:
 		case WIN_MULTWRITE_EXT:
-			args->prehandler = pre_task_mulout_intr;
-			args->handler = task_mulout_intr;
-			args->command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			ar->prehandler = pre_task_mulout_intr;
+			ar->handler = task_mulout_intr;
+			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 			return;
 
 		case WIN_SECURITY_DISABLE:
 		case WIN_SECURITY_ERASE_UNIT:
 		case WIN_SECURITY_SET_PASS:
 		case WIN_SECURITY_UNLOCK:
-			args->handler = task_out_intr;
-			args->command_type = IDE_DRIVE_TASK_OUT;
+			ar->handler = task_out_intr;
+			ar->command_type = IDE_DRIVE_TASK_OUT;
 			return;
 
 		case WIN_SMART:
 			if (taskfile->feature == SMART_WRITE_LOG_SECTOR)
-				args->prehandler = pre_task_out_intr;
+				ar->prehandler = pre_task_out_intr;
 
-			args->taskfile.low_cylinder = SMART_LCYL_PASS;
-			args->taskfile.high_cylinder = SMART_HCYL_PASS;
+			ar->taskfile.low_cylinder = SMART_LCYL_PASS;
+			ar->taskfile.high_cylinder = SMART_HCYL_PASS;
 
-			switch(args->taskfile.feature) {
+			switch(ar->taskfile.feature) {
 				case SMART_READ_VALUES:
 				case SMART_READ_THRESHOLDS:
 				case SMART_READ_LOG_SECTOR:
-					args->handler = task_in_intr;
-					args->command_type = IDE_DRIVE_TASK_IN;
+					ar->handler = task_in_intr;
+					ar->command_type = IDE_DRIVE_TASK_IN;
 					return;
 
 				case SMART_WRITE_LOG_SECTOR:
-					args->handler = task_out_intr;
-					args->command_type = IDE_DRIVE_TASK_OUT;
+					ar->handler = task_out_intr;
+					ar->command_type = IDE_DRIVE_TASK_OUT;
 					return;
 
 				default:
-					args->handler = task_no_data_intr;
-					args->command_type = IDE_DRIVE_TASK_NO_DATA;
+					ar->handler = task_no_data_intr;
+					ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 					return;
 
 			}
@@ -648,22 +645,22 @@
 		case WIN_READDMA_QUEUED:
 		case WIN_READDMA_EXT:
 		case WIN_READDMA_QUEUED_EXT:
-			args->command_type = IDE_DRIVE_TASK_IN;
+			ar->command_type = IDE_DRIVE_TASK_IN;
 			return;
 
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_QUEUED:
 		case WIN_WRITEDMA_EXT:
 		case WIN_WRITEDMA_QUEUED_EXT:
-			args->command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 			return;
 
 #endif
 		case WIN_SETFEATURES:
-			args->handler = task_no_data_intr;
-			switch(args->taskfile.feature) {
+			ar->handler = task_no_data_intr;
+			switch (ar->taskfile.feature) {
 				case SETFEATURES_XFER:
-					args->command_type = IDE_DRIVE_TASK_SET_XFER;
+					ar->command_type = IDE_DRIVE_TASK_SET_XFER;
 					return;
 				case SETFEATURES_DIS_DEFECT:
 				case SETFEATURES_EN_APM:
@@ -681,18 +678,18 @@
 				case SETFEATURES_DIS_RI:
 				case SETFEATURES_DIS_SI:
 				default:
-					args->command_type = IDE_DRIVE_TASK_NO_DATA;
+					ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 					return;
 			}
 
 		case WIN_SPECIFY:
-			args->handler = task_no_data_intr;
-			args->command_type = IDE_DRIVE_TASK_NO_DATA;
+			ar->handler = task_no_data_intr;
+			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
 		case WIN_RESTORE:
-			args->handler = recal_intr;
-			args->command_type = IDE_DRIVE_TASK_NO_DATA;
+			ar->handler = recal_intr;
+			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
 		case WIN_DIAGNOSE:
@@ -722,19 +719,10 @@
 		case WIN_DOORUNLOCK:
 		case DISABLE_SEAGATE:
 		case EXABYTE_ENABLE_NEST:
-
-			args->handler = task_no_data_intr;
-			args->command_type = IDE_DRIVE_TASK_NO_DATA;
-			return;
-
 		case WIN_SETMULT:
-			args->handler = task_no_data_intr;
-			args->command_type = IDE_DRIVE_TASK_NO_DATA;
-			return;
-
 		case WIN_NOP:
-			args->handler = task_no_data_intr;
-			args->command_type = IDE_DRIVE_TASK_NO_DATA;
+			ar->handler = task_no_data_intr;
+			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
 		case WIN_FORMAT:
@@ -743,7 +731,7 @@
 		case WIN_QUEUED_SERVICE:
 		case WIN_PACKETCMD:
 		default:
-			args->command_type = IDE_DRIVE_TASK_INVALID;
+			ar->command_type = IDE_DRIVE_TASK_INVALID;
 			return;
 	}
 }
diff -urN linux-2.5.19/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.19/drivers/ide/ioctl.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-02 11:40:55.000000000 +0200
@@ -235,7 +235,7 @@
 			if (!drive->driver)
 				return -EPERM;
 
-			if (!drive->id || !(drive->id->capability & 1) || !drive->channel->XXX_udma)
+			if (!drive->id || !(drive->id->capability & 1) || !drive->channel->udma_setup)
 				return -EPERM;
 
 			if (ide_spin_wait_hwgroup(drive))
diff -urN linux-2.5.19/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.19/drivers/ide/main.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/main.c	2002-06-02 11:53:37.000000000 +0200
@@ -520,12 +520,11 @@
 	ch->ata_write = old.ata_write;
 	ch->atapi_read = old.atapi_read;
 	ch->atapi_write = old.atapi_write;
-	ch->XXX_udma = old.XXX_udma;
+	ch->udma_setup = old.udma_setup;
 	ch->udma_enable = old.udma_enable;
 	ch->udma_start = old.udma_start;
 	ch->udma_stop = old.udma_stop;
-	ch->udma_read = old.udma_read;
-	ch->udma_write = old.udma_write;
+	ch->udma_init = old.udma_init;
 	ch->udma_irq_status = old.udma_irq_status;
 	ch->udma_timeout = old.udma_timeout;
 	ch->udma_irq_lost = old.udma_irq_lost;
@@ -1092,7 +1091,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 	/* Default autotune or requested autotune */
 	if (drive->autotune != 2) {
-		if (drive->channel->XXX_udma) {
+		if (drive->channel->udma_setup) {
 
 			/*
 			 * Force DMAing for the beginning of the check.  Some
@@ -1103,7 +1102,7 @@
 			 */
 
 			udma_enable(drive, 0, 0);
-			drive->channel->XXX_udma(drive);
+			drive->channel->udma_setup(drive);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 			udma_tcq_enable(drive, 1);
 #endif
diff -urN linux-2.5.19/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.19/drivers/ide/ns87415.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-06-02 12:08:52.000000000 +0200
@@ -101,11 +101,11 @@
 
 }
 
-static int ns87415_udma_read(struct ata_device *drive, struct request *rq)
+static int ns87415_udma_init(struct ata_device *drive, struct request *rq)
 {
 	ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
 
-	if (!ata_do_udma(1, drive, rq))		/* use standard DMA stuff */
+	if (!udma_pci_init(drive, rq))		/* use standard DMA stuff */
 		return 0;
 
 	ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
@@ -113,26 +113,14 @@
 	return 1;
 }
 
-static int ns87415_udma_write(struct ata_device *drive, struct request *rq)
-{
-	ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
-
-	if (!ata_do_udma(0, drive, rq))		/* use standard DMA stuff */
-		return 0;
-
-	ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
-
-	return 1;
-}
-
-static int ns87415_dmaproc(struct ata_device *drive)
+static int ns87415_udma_setup(struct ata_device *drive)
 {
 	if (drive->type != ATA_DISK) {
 		udma_enable(drive, 0, 0);
 
 		return 0;
 	}
-	return XXX_ide_dmaproc(drive);
+	return udma_pci_setup(drive);
 }
 #endif
 
@@ -218,9 +206,8 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->udma_stop = ns87415_udma_stop;
-		hwif->udma_read = ns87415_udma_read;
-		hwif->udma_write = ns87415_udma_write;
-		hwif->XXX_udma = ns87415_dmaproc;
+		hwif->udma_init = ns87415_udma_init;
+		hwif->udma_setup = ns87415_udma_setup;
 	}
 #endif
 
diff -urN linux-2.5.19/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.19/drivers/ide/pcidma.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-02 12:10:14.000000000 +0200
@@ -164,7 +164,7 @@
 /*
  * Configure a device for DMA operation.
  */
-int XXX_ide_dmaproc(struct ata_device *drive)
+int udma_pci_setup(struct ata_device *drive)
 {
 	int config_allows_dma = 1;
 	struct hd_driveid *id = drive->id;
@@ -427,16 +427,6 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-int udma_pci_read(struct ata_device *drive, struct request *rq)
-{
-	return ata_do_udma(1, drive, rq);
-}
-
-int udma_pci_write(struct ata_device *drive, struct request *rq)
-{
-	return ata_do_udma(0, drive, rq);
-}
-
 /*
  * FIXME: This should be attached to a channel as we can see now!
  */
@@ -490,18 +480,16 @@
 	 * We could just assign them, and then leave it up to the chipset
 	 * specific code to override these after they've called this function.
 	 */
-	if (!ch->XXX_udma)
-		ch->XXX_udma = XXX_ide_dmaproc;
+	if (!ch->udma_setup)
+		ch->udma_setup = udma_pci_setup;
 	if (!ch->udma_enable)
 		ch->udma_enable = udma_pci_enable;
 	if (!ch->udma_start)
 		ch->udma_start = udma_pci_start;
 	if (!ch->udma_stop)
 		ch->udma_stop = udma_pci_stop;
-	if (!ch->udma_read)
-		ch->udma_read = udma_pci_read;
-	if (!ch->udma_write)
-		ch->udma_write = udma_pci_write;
+	if (!ch->udma_init)
+		ch->udma_init = udma_pci_init;
 	if (!ch->udma_irq_status)
 		ch->udma_irq_status = udma_pci_irq_status;
 	if (!ch->udma_timeout)
@@ -528,16 +516,20 @@
  * It's exported only for host chips which use it for fallback or (too) late
  * capability checking.
  */
-
-int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+int udma_pci_init(struct ata_device *drive, struct request *rq)
 {
+	u8 cmd;
+
 	if (ata_start_dma(drive, rq))
 		return 1;
 
 	if (drive->type != ATA_DISK)
 		return 0;
 
-	reading <<= 3;
+	if (rq_data_dir(rq) == READ)
+		cmd = 0x08;
+	else
+		cmd = 0x00;
 
 	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
 	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
@@ -545,22 +537,19 @@
 		struct ata_taskfile *args = rq->special;
 
 		outb(args->cmd, IDE_COMMAND_REG);
-	} else if (drive->addressing) {
-		outb(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-	} else {
-		outb(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-	}
+	} else if (drive->addressing)
+		outb(cmd ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+	else
+		outb(cmd ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
 	return udma_start(drive, rq);
 }
 
-EXPORT_SYMBOL(ata_do_udma);
 EXPORT_SYMBOL(ide_dma_intr);
 EXPORT_SYMBOL(udma_pci_enable);
 EXPORT_SYMBOL(udma_pci_start);
 EXPORT_SYMBOL(udma_pci_stop);
-EXPORT_SYMBOL(udma_pci_read);
-EXPORT_SYMBOL(udma_pci_write);
+EXPORT_SYMBOL(udma_pci_init);
 EXPORT_SYMBOL(udma_pci_irq_status);
 EXPORT_SYMBOL(udma_pci_timeout);
 EXPORT_SYMBOL(udma_pci_irq_lost);
diff -urN linux-2.5.19/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.19/drivers/ide/pdc202xx.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-02 11:51:21.000000000 +0200
@@ -563,7 +563,7 @@
 	return !(hwif->speedproc(drive, mode));
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive)
+static int pdc202xx_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	struct ata_channel *hwif = drive->channel;
@@ -670,7 +670,7 @@
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static void pdc202xx_bug (struct ata_device *drive)
+static void pdc202xx_bug(struct ata_device *drive)
 {
 	if (!drive->channel->resetproc)
 		return;
@@ -678,10 +678,6 @@
 	drive->channel->resetproc(drive);
 }
 
-static int pdc202xx_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
 #endif
 
 void pdc202xx_new_reset(struct ata_device *drive)
@@ -838,7 +834,7 @@
 	if (hwif->dma_base) {
 		hwif->udma_irq_lost = pdc202xx_bug;
 		hwif->udma_timeout = pdc202xx_bug;
-		hwif->XXX_udma = pdc202xx_dmaproc;
+		hwif->udma_setup = pdc202xx_udma_setup;
 		hwif->highmem = 1;
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.19/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.19/drivers/ide/pdc4030.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-02 10:21:42.000000000 +0200
@@ -619,16 +619,11 @@
 		return ide_stopped;
 	}
 
-	ata_irq_enable(drive, 1);  /* clear nIEN */
+	ata_irq_enable(drive, 1);
 	ata_mask(drive);
 
-	outb(taskfile->feature, IDE_FEATURE_REG);
-	outb(taskfile->sector_count, IDE_NSECTOR_REG);
-	/* refers to number of sectors to transfer */
-	outb(taskfile->sector_number, IDE_SECTOR_REG);
-	/* refers to sector offset or start sector */
-	outb(taskfile->low_cylinder, IDE_LCYL_REG);
-	outb(taskfile->high_cylinder, IDE_HCYL_REG);
+	ata_out_regfile(drive, taskfile);
+
 	outb(taskfile->device_head, IDE_SELECT_REG);
 	outb(args->cmd, IDE_COMMAND_REG);
 
@@ -708,14 +703,9 @@
 	args.taskfile.low_cylinder	= (block>>=8);
 	args.taskfile.high_cylinder	= (block>>=8);
 	args.taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
-	args.cmd			= (rq_data_dir(rq)==READ)?PROMISE_READ:PROMISE_WRITE;
-
-	/* We can't call ide_cmd_type_parser here, since it won't understand
-	   our command, but that doesn't matter, since we don't use the
-	   generic interrupt handlers either. Setup the bits of args that we
-	   will need. */
-	args.handler		= NULL;
-	rq->special		= &args;
+	args.cmd = (rq_data_dir(rq) == READ) ? PROMISE_READ : PROMISE_WRITE;
+	args.handler	= NULL;
+	rq->special	= &args;
 
 	return do_pdc4030_io(drive, &args, rq);
 }
diff -urN linux-2.5.19/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.19/drivers/ide/piix.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-06-02 11:46:11.000000000 +0200
@@ -253,7 +253,7 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
-int piix_dmaproc(struct ata_device *drive)
+static int piix_udma_setup(struct ata_device *drive)
 {
 	short w80 = drive->channel->udma_four;
 
@@ -399,7 +399,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->XXX_udma = piix_dmaproc;
+		hwif->udma_setup = piix_udma_setup;
 # ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.19/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.19/drivers/ide/serverworks.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-06-02 12:14:42.000000000 +0200
@@ -290,7 +290,7 @@
 	return !svwks_tune_chipset(drive, mode);
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive)
+static int svwks_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	int on = 1;
@@ -387,11 +387,6 @@
 
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
-
-static int svwks_dmaproc(struct ata_device *drive)
-{
-	return config_drive_xfer_rate(drive);
-}
 #endif
 
 static unsigned int __init svwks_init_chipset(struct pci_dev *dev)
@@ -506,7 +501,7 @@
 			hwif->autodma = 1;
 #endif
 		hwif->udma_stop = svwks_udma_stop;
-		hwif->XXX_udma = svwks_dmaproc;
+		hwif->udma_setup = svwks_udma_setup;
 		hwif->highmem = 1;
 	} else {
 		hwif->autodma = 0;
diff -urN linux-2.5.19/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.19/drivers/ide/sis5513.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-06-02 12:23:59.000000000 +0200
@@ -466,12 +466,14 @@
 	return !sis5513_tune_chipset(drive, mode);
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive)
+static int sis5513_udma_setup(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	int on = 0;
 	int verbose = 1;
 
+	config_drive_art_rwp(drive);
+	config_art_rwp_pio(drive, 5);
 	config_chipset_for_pio(drive, 5);
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
@@ -520,14 +522,6 @@
 
 	return 0;
 }
-
-static int sis5513_dmaproc(struct ata_device *drive)
-{
-	config_drive_art_rwp(drive);
-	config_art_rwp_pio(drive, 5);
-
-	return config_drive_xfer_rate(drive);
-}
 #endif
 
 /* Chip detection and general config */
@@ -633,7 +627,7 @@
 		if (chipset_family > ATA_16) {
 			hwif->autodma = noautodma ? 0 : 1;
 			hwif->highmem = 1;
-			hwif->XXX_udma = sis5513_dmaproc;
+			hwif->udma_setup = sis5513_udma_setup;
 		} else {
 #endif
 			hwif->autodma = 0;
diff -urN linux-2.5.19/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.19/drivers/ide/sl82c105.c	2002-05-29 20:42:50.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-06-02 12:04:05.000000000 +0200
@@ -130,7 +130,7 @@
  * Check to see if the drive and
  * chipset is capable of DMA mode
  */
-static int sl82c105_check_drive(struct ata_device *drive)
+static int sl82c105_dma_setup(struct ata_device *drive)
 {
 	int on = 0;
 
@@ -173,15 +173,6 @@
 }
 
 /*
- * Our very own dmaproc.  We need to intercept various calls
- * to fix up the SL82C105 specific behaviour.
- */
-static int sl82c105_dmaproc(struct ata_device *drive)
-{
-	return sl82c105_check_drive(drive);
-}
-
-/*
  * The SL82C105 holds off all IDE interrupts while in DMA mode until
  * all DMA activity is completed.  Sometimes this causes problems (eg,
  * when the drive wants to report an error condition).
@@ -215,16 +206,10 @@
  * The generic IDE core will have disabled the BMEN bit before this
  * function is called.
  */
-static int sl82c105_dma_read(struct ata_device *drive, struct request *rq)
-{
-	sl82c105_reset_host(drive->channel->pci_dev);
-	return udma_pci_read(drive, rq);
-}
-
-static int sl82c105_dma_write(struct ata_device *drive, struct request *rq)
+static int sl82c105_dma_init(struct ata_device *drive, struct request *rq)
 {
 	sl82c105_reset_host(drive->channel->pci_dev);
-	return udma_pci_write(drive, rq);
+	return udma_pci_init(drive, rq);
 }
 
 static void sl82c105_timeout(struct ata_device *drive)
@@ -354,12 +339,11 @@
 	ata_init_dma(ch, dma_base);
 
 	if (bridge_rev <= 5)
-		ch->XXX_udma = NULL;
+		ch->udma_setup = NULL;
 	else {
-		ch->XXX_udma      = sl82c105_dmaproc;
+		ch->udma_setup    = sl82c105_dma_setup;
 		ch->udma_enable   = sl82c105_dma_enable;
-		ch->udma_read     = sl82c105_dma_read;
-		ch->udma_write    = sl82c105_dma_write;
+		ch->udma_init	  = sl82c105_dma_init;
 		ch->udma_timeout  = sl82c105_timeout;
 		ch->udma_irq_lost = sl82c105_lostirq;
 	}
diff -urN linux-2.5.19/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.19/drivers/ide/trm290.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-02 12:08:38.000000000 +0200
@@ -191,10 +191,18 @@
 	return (inw(ch->dma_base + 2) != 0x00ff);
 }
 
-static int do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+static int trm290_udma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned int count, writing;
+	unsigned int count;
+	int writing;
+	int reading;
+
+
+	if (rq_data_dir(rq) == READ)
+		reading = 1;
+	else
+		reading = 0;
 
 	if (!reading) {
 		reading = 0;
@@ -228,24 +236,14 @@
 	return 0;
 }
 
-static int trm290_udma_read(struct ata_device *drive, struct request *rq)
-{
-	return do_udma(1, drive, rq);
-}
-
-static int trm290_udma_write(struct ata_device *drive, struct request *rq)
-{
-	return do_udma(0, drive, rq);
-}
-
 static int trm290_udma_irq_status(struct ata_device *drive)
 {
 	return (inw(drive->channel->dma_base + 2) == 0x00ff);
 }
 
-static int trm290_dmaproc(struct ata_device *drive)
+static int trm290_udma_setup(struct ata_device *drive)
 {
-	return XXX_ide_dmaproc(drive);
+	return udma_pci_setup(drive);
 }
 #endif
 
@@ -301,10 +299,9 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->udma_start = trm290_udma_start;
 	hwif->udma_stop = trm290_udma_stop;
-	hwif->udma_read = trm290_udma_read;
-	hwif->udma_write = trm290_udma_write;
+	hwif->udma_init = trm290_udma_init;
 	hwif->udma_irq_status = trm290_udma_irq_status;
-	hwif->XXX_udma = trm290_dmaproc;
+	hwif->udma_setup = trm290_udma_setup;
 #endif
 
 	hwif->selectproc = &trm290_selectproc;
diff -urN linux-2.5.19/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.19/drivers/ide/via82cxxx.c	2002-06-01 18:53:02.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-06-02 11:42:53.000000000 +0200
@@ -223,7 +223,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int via82cxxx_dmaproc(struct ata_device *drive)
+static int via82cxxx_udma_setup(struct ata_device *drive)
 {
 	short w80 = drive->channel->udma_four;
 
@@ -368,7 +368,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->XXX_udma = &via82cxxx_dmaproc;
+		hwif->udma_setup = via82cxxx_udma_setup;
 # ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.19/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.19/drivers/scsi/ide-scsi.c	2002-06-02 09:41:16.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-02 11:53:22.000000000 +0200
@@ -407,12 +407,8 @@
 	pc->current_position=pc->buffer;
 	bcount = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
-	if (drive->using_dma && rq->bio) {
-		if (test_bit (PC_WRITING, &pc->flags))
-			dma_ok = !udma_write(drive, rq);
-		else
-			dma_ok = !udma_read(drive, rq);
-	}
+	if (drive->using_dma && rq->bio)
+		dma_ok = !udma_init(drive, rq);
 
 	ata_select(drive, 10);
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.19/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.19/include/linux/ide.h	2002-06-02 09:41:16.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-02 12:33:06.000000000 +0200
@@ -425,7 +425,7 @@
 	 * mode itself.
 	 */
 
-	/* setup disk on a channel for a particular transfer mode */
+	/* setup disk on a channel for a particular PIO transfer mode */
 	void (*tuneproc) (struct ata_device *, byte pio);
 
 	/* setup the chipset timing for a particular transfer mode */
@@ -455,18 +455,13 @@
 	void (*atapi_read)(struct ata_device *, void *, unsigned int);
 	void (*atapi_write)(struct ata_device *, void *, unsigned int);
 
-	int (*XXX_udma)(struct ata_device *);
+	int (*udma_setup)(struct ata_device *);
 
 	void (*udma_enable)(struct ata_device *, int, int);
-
 	int (*udma_start) (struct ata_device *, struct request *rq);
 	int (*udma_stop) (struct ata_device *);
-
-	int (*udma_read) (struct ata_device *, struct request *rq);
-	int (*udma_write) (struct ata_device *, struct request *rq);
-
+	int (*udma_init) (struct ata_device *, struct request *rq);
 	int (*udma_irq_status) (struct ata_device *);
-
 	void (*udma_timeout) (struct ata_device *);
 	void (*udma_irq_lost) (struct ata_device *);
 
@@ -770,14 +765,12 @@
 	return drive->channel->udma_stop(drive);
 }
 
-static inline int udma_read(struct ata_device *drive, struct request *rq)
-{
-	return drive->channel->udma_read(drive, rq);
-}
-
-static inline int udma_write(struct ata_device *drive, struct request *rq)
+/*
+ * Initiate actual DMA data transfer. The direction is encoded in the request.
+ */
+static inline int udma_init(struct ata_device *drive, struct request *rq)
 {
-	return drive->channel->udma_write(drive, rq);
+	return drive->channel->udma_init(drive, rq);
 }
 
 static inline int udma_irq_status(struct ata_device *drive)
@@ -797,14 +790,14 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
-void udma_pci_enable(struct ata_device *drive, int on, int verbose);
-int udma_pci_start(struct ata_device *drive, struct request *rq);
-int udma_pci_stop(struct ata_device *drive);
-int udma_pci_read(struct ata_device *drive, struct request *rq);
-int udma_pci_write(struct ata_device *drive, struct request *rq);
-int udma_pci_irq_status(struct ata_device *drive);
-void udma_pci_timeout(struct ata_device *drive);
-void udma_pci_irq_lost(struct ata_device *);
+extern void udma_pci_enable(struct ata_device *drive, int on, int verbose);
+extern int udma_pci_start(struct ata_device *drive, struct request *rq);
+extern int udma_pci_stop(struct ata_device *drive);
+extern int udma_pci_init(struct ata_device *drive, struct request *rq);
+extern int udma_pci_irq_status(struct ata_device *drive);
+extern void udma_pci_timeout(struct ata_device *drive);
+extern void udma_pci_irq_lost(struct ata_device *);
+extern int udma_pci_setup(struct ata_device *);
 
 extern int udma_new_table(struct ata_channel *, struct request *);
 extern void udma_destroy_table(struct ata_channel *);
@@ -813,14 +806,11 @@
 extern int udma_black_list(struct ata_device *);
 extern int udma_white_list(struct ata_device *);
 
-extern int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq);
-
 extern ide_startstop_t udma_tcq_taskfile(struct ata_device *, struct request *);
 extern int udma_tcq_enable(struct ata_device *, int);
 
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 extern int check_drive_lists(struct ata_device *, int good_bad);
-extern int XXX_ide_dmaproc(struct ata_device *);
 extern void ide_release_dma(struct ata_channel *);
 extern int ata_start_dma(struct ata_device *, struct request *rq);
 

--------------080001060901040808080905--

