Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSEEQ66>; Sun, 5 May 2002 12:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSEEQ65>; Sun, 5 May 2002 12:58:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20494 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313189AbSEEQ6e>; Sun, 5 May 2002 12:58:34 -0400
Message-ID: <3CD55601.9030604@evision-ventures.com>
Date: Sun, 05 May 2002 17:55:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.13 IDE 53
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090604010305080904000201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604010305080904000201
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Sun May  5 16:26:37 CEST 2002 ide-clean-53

- Start splitting the functions for host chip handling in to separate entities.
   This change is quite sensitive and may cause some trouble but it's for
   certain worth it anyway, because it should for example provide a much better
   infrastructure for th handling of different architectures.


--------------090604010305080904000201
Content-Type: text/plain;
 name="ide-clean-53.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-53.diff"

diff -urN linux-2.5.13/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.13/drivers/ide/aec62xx.c	2002-05-03 02:22:49.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-05 06:42:36.000000000 +0200
@@ -437,7 +437,7 @@
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -459,7 +459,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
diff -urN linux-2.5.13/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.13/drivers/ide/alim15x3.c	2002-05-03 02:22:54.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-05 06:43:33.000000000 +0200
@@ -441,7 +441,7 @@
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -463,7 +463,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -483,21 +483,25 @@
 	return hwif->udma(dma_func, drive, NULL);
 }
 
+static int ali15x3_udma_write(struct ata_device *drive, struct request *rq)
+{
+	if ((m5229_revision < 0xC2) && (drive->type != ATA_DISK))
+		return 1;	/* try PIO instead of DMA */
+
+	return ata_do_udma(0, drive, rq);
+}
+
 static int ali15x3_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	switch(func) {
 		case ide_dma_check:
 			return ali15x3_config_drive_for_dma(drive);
-		case ide_dma_write:
-			if ((m5229_revision < 0xC2) && (drive->type != ATA_DISK))
-				return 1;	/* try PIO instead of DMA */
-			break;
 		default:
 			break;
 	}
 	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 unsigned int __init pci_init_ali15x3(struct pci_dev *dev)
 {
@@ -679,6 +683,7 @@
 		/*
 		 * M1543C or newer for DMAing
 		 */
+		hwif->udma_write = ali15x3_udma_write;
 		hwif->udma = ali15x3_dmaproc;
 		hwif->autodma = 1;
 	}
diff -urN linux-2.5.13/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.13/drivers/ide/cmd64x.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-05 06:44:24.000000000 +0200
@@ -783,7 +783,7 @@
 	if ((id != NULL) && ((id->capability & 1) != 0) &&
 	    hwif->autodma && (drive->type == ATA_DISK)) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -805,7 +805,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -837,6 +837,34 @@
         return ide_dmaproc(func, drive, rq);
 }
 
+static int cmd64x_udma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	u8 dma_stat = 0;
+	unsigned long dma_base	= ch->dma_base;
+	struct pci_dev *dev	= ch->pci_dev;
+	u8 jack_slap		= ((dev->device == PCI_DEVICE_ID_CMD_648) || (dev->device == PCI_DEVICE_ID_CMD_649)) ? 1 : 0;
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	if (jack_slap) {
+		byte dma_intr = 0;
+		byte dma_mask = (ch->unit) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+		byte dma_reg = (ch->unit) ? ARTTIM2 : CFR;
+		(void) pci_read_config_byte(dev, dma_reg, &dma_intr);
+		/*
+		 * DAMN BMIDE is not connected to PCI space!
+		 * Have to manually jack-slap that bitch!
+		 * To allow the PCI side to read incoming interrupts.
+		 */
+		(void) pci_write_config_byte(dev, dma_reg, dma_intr|dma_mask);	/* clear the INTR bit */
+	}
+	udma_destroy_table(ch);	/* purge DMA mappings */
+	return (dma_stat & 7) != 4;		/* verify good DMA status */
+}
+
 static int cmd64x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
@@ -845,30 +873,10 @@
 	u8 mask	= (ch->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
 	unsigned long dma_base	= ch->dma_base;
 	struct pci_dev *dev	= ch->pci_dev;
-	byte jack_slap		= ((dev->device == PCI_DEVICE_ID_CMD_648) || (dev->device == PCI_DEVICE_ID_CMD_649)) ? 1 : 0;
 
 	switch (func) {
 		case ide_dma_check:
 			return cmd64x_config_drive_for_dma(drive);
-		case ide_dma_end: /* returns 1 on error, 0 otherwise */
-			drive->waiting_for_dma = 0;
-			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			dma_stat = inb(dma_base+2);		/* get DMA status */
-			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-			if (jack_slap) {
-				byte dma_intr = 0;
-				byte dma_mask = (ch->unit) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-				byte dma_reg = (ch->unit) ? ARTTIM2 : CFR;
-				(void) pci_read_config_byte(dev, dma_reg, &dma_intr);
-				/*
-				 * DAMN BMIDE is not connected to PCI space!
-				 * Have to manually jack-slap that bitch!
-				 * To allow the PCI side to read incoming interrupts.
-				 */
-				(void) pci_write_config_byte(dev, dma_reg, dma_intr|dma_mask);	/* clear the INTR bit */
-			}
-			udma_destroy_table(ch);	/* purge DMA mappings */
-			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
 			(void) pci_read_config_byte(dev, MRDMODE, &dma_alt_stat);
@@ -886,26 +894,29 @@
 	return ide_dmaproc(func, drive, rq);
 }
 
+static int cmd646_1_udma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	drive->waiting_for_dma = 0;
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* and free any DMA resources */
+	return (dma_stat & 7) != 4;		/* verify good DMA status */
+}
+
 /*
  * ASUS P55T2P4D with CMD646 chipset revision 0x01 requires the old
  * event order for DMA transfers.
  */
 static int cmd646_1_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	byte dma_stat;
-
 	switch (func) {
 		case ide_dma_check:
 			return cmd64x_config_drive_for_dma(drive);
-		case ide_dma_end:
-			drive->waiting_for_dma = 0;
-			dma_stat = inb(dma_base+2);		/* get DMA status */
-			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-			udma_destroy_table(ch);			/* and free any DMA resources */
-			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		default:
 			break;
 	}
@@ -1134,19 +1145,22 @@
 		case PCI_DEVICE_ID_CMD_649:
 		case PCI_DEVICE_ID_CMD_648:
 		case PCI_DEVICE_ID_CMD_643:
-			hwif->udma	= &cmd64x_dmaproc;
-			hwif->tuneproc	= &cmd64x_tuneproc;
-			hwif->speedproc = &cmd64x_tune_chipset;
+			hwif->udma_stop	= cmd64x_udma_stop;
+			hwif->udma	= cmd64x_dmaproc;
+			hwif->tuneproc	= cmd64x_tuneproc;
+			hwif->speedproc = cmd64x_tune_chipset;
 			break;
 		case PCI_DEVICE_ID_CMD_646:
 			hwif->chipset = ide_cmd646;
 			if (class_rev == 0x01) {
+				hwif->udma_stop = &cmd646_1_udma_stop;
 				hwif->udma = &cmd646_1_dmaproc;
 			} else {
-				hwif->udma = &cmd64x_dmaproc;
+				hwif->udma_stop = cmd64x_udma_stop;
+				hwif->udma = cmd64x_dmaproc;
 			}
-			hwif->tuneproc	= &cmd64x_tuneproc;
-			hwif->speedproc	= &cmd64x_tune_chipset;
+			hwif->tuneproc	= cmd64x_tuneproc;
+			hwif->speedproc	= cmd64x_tune_chipset;
 			break;
 		default:
 			break;
diff -urN linux-2.5.13/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.13/drivers/ide/Config.in	2002-05-05 07:04:50.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-05-05 03:56:46.000000000 +0200
@@ -33,16 +33,16 @@
    dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
 
-   comment 'IDE chipset support'
+   comment 'ATA host chipset support'
    dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
    dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
-   dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
+   dep_bool '  ISA-PNP support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
    if [ "$CONFIG_PCI" = "y" ]; then
       dep_bool '  RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
-      bool '  Generic PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
+      bool '  PCI host chipset support' CONFIG_BLK_DEV_IDEPCI
       if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
 	 bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
-	 bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
+	 bool '    Sharing PCI ATA interrupts support' CONFIG_IDEPCI_SHARE_IRQ
 	 bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
@@ -82,11 +82,9 @@
 	 dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
 	 dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    VIA chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105 $CONFIG_BLK_DEV_IDEDMA_PCI
       fi
 
-      if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
-	 bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
-      fi
    fi
    if [ "$CONFIG_ALL_PPC" = "y" ]; then
       bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
diff -urN linux-2.5.13/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.13/drivers/ide/cs5530.c	2002-05-03 02:22:54.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-05-05 06:45:29.000000000 +0200
@@ -158,7 +158,7 @@
 	 */
 	if (mate->present) {
 		struct hd_driveid *mateid = mate->id;
-		if (mateid && (mateid->capability & 1) && !hwif->udma(ide_dma_bad_drive, mate, NULL)) {
+		if (mateid && (mateid->capability & 1) && !udma_black_list(mate)) {
 			if ((mateid->field_valid & 4) && (mateid->dma_ultra & 7))
 				udma_ok = 1;
 			else if ((mateid->field_valid & 2) && (mateid->dma_mword & 7))
@@ -172,7 +172,7 @@
 	 * Now see what the current drive is capable of,
 	 * selecting UDMA only if the mate said it was ok.
 	 */
-	if (id && (id->capability & 1) && hwif->autodma && !hwif->udma(ide_dma_bad_drive, drive, NULL)) {
+	if (id && (id->capability & 1) && hwif->autodma && !udma_black_list(drive)) {
 		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
 			if      (id->dma_ultra & 4)
 				mode = XFER_UDMA_2;
diff -urN linux-2.5.13/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.13/drivers/ide/hpt34x.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-05 06:46:35.000000000 +0200
@@ -256,7 +256,7 @@
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, rq)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -278,7 +278,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, rq)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -304,6 +304,55 @@
 	return drive->channel->udma(dma_func, drive, rq);
 }
 
+static int hpt34x_udma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4;		/* verify good DMA status */
+}
+
+static int do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	unsigned int count;
+
+	if (!(count = udma_new_table(ch, rq)))
+		return 1;	/* try PIO instead of DMA */
+
+	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
+	reading |= 0x01;
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+
+	if (drive->type != ATA_DISK)
+		return 0;
+
+	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
+	OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+
+	return 0;
+}
+
+static int hpt34x_udma_read(struct ata_device *drive, struct request *rq)
+{
+	return do_udma(1 << 3, drive, rq);
+}
+
+static int hpt34x_udma_write(struct ata_device *drive, struct request *rq)
+{
+	return do_udma(0, drive, rq);
+}
+
 /*
  * hpt34x_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
  *
@@ -311,45 +360,17 @@
  * and HPT345 UDMA bios chipset (stamped HPT363)
  * by HighPoint|Triones Technologies, Inc.
  */
-
 int hpt34x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	unsigned int count, reading = 0;
-	byte dma_stat;
-
 	switch (func) {
 		case ide_dma_check:
 			return config_drive_xfer_rate(drive, rq);
-		case ide_dma_read:
-			reading = 1 << 3;
-		case ide_dma_write:
-			if (!(count = udma_new_table(ch, rq)))
-				return 1;	/* try PIO instead of DMA */
-			outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
-			reading |= 0x01;
-			outb(reading, dma_base);		/* specify r/w */
-			outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
-			drive->waiting_for_dma = 1;
-			if (drive->type != ATA_DISK)
-				return 0;
-			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
-			OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-			return 0;
-		case ide_dma_end:	/* returns 1 on error, 0 otherwise */
-			drive->waiting_for_dma = 0;
-			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			dma_stat = inb(dma_base+2);		/* get DMA status */
-			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-			udma_destroy_table(ch);			/* purge DMA mappings */
-			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		default:
 			break;
 	}
 	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * If the BIOS does not set the IO base addaress to XX00, 343 will fail.
@@ -423,7 +444,10 @@
 		else
 			hwif->autodma = 0;
 
-		hwif->udma = &hpt34x_dmaproc;
+		hwif->udma_stop = hpt34x_udma_stop;
+		hwif->udma_read = hpt34x_udma_read;
+		hwif->udma_write = hpt34x_udma_write;
+		hwif->udma = hpt34x_dmaproc;
 		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
diff -urN linux-2.5.13/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.13/drivers/ide/hpt366.c	2002-05-05 07:04:50.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-05 06:47:24.000000000 +0200
@@ -748,7 +748,7 @@
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -769,7 +769,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -830,6 +830,86 @@
 	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
 
+static void do_udma_start(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+
+	u8 regstate = ch->unit ? 0x54 : 0x50;
+	pci_write_config_byte(ch->pci_dev, regstate, 0x37);
+	udelay(10);
+}
+
+static int hpt370_udma_start(struct ata_device *drive, struct request *__rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	do_udma_start(drive);
+
+	/* Note that this is done *after* the cmd has been issued to the drive,
+	 * as per the BM-IDE spec.  The Promise Ultra33 doesn't work correctly
+	 * when we do this part before issuing the drive cmd.
+	 */
+
+	outb(inb(ch->dma_base) | 1, ch->dma_base);	/* start DMA */
+
+	return 0;
+}
+
+static void do_timeout_irq(struct ata_device *drive)
+{
+	u8 dma_stat;
+	u8 regstate = drive->channel->unit ? 0x54 : 0x50;
+	u8 reginfo = drive->channel->unit ? 0x56 : 0x52;
+	unsigned long dma_base = drive->channel->dma_base;
+
+	pci_read_config_byte(drive->channel->pci_dev, reginfo, &dma_stat);
+	printk(KERN_INFO "%s: %d bytes in FIFO\n", drive->name, dma_stat);
+	pci_write_config_byte(drive->channel->pci_dev, regstate, 0x37);
+	udelay(10);
+	dma_stat = inb(dma_base);
+	outb(dma_stat & ~0x1, dma_base); /* stop dma */
+	dma_stat = inb(dma_base + 2);
+	outb(dma_stat | 0x6, dma_base+2); /* clear errors */
+
+}
+
+static void hpt370_udma_timeout(struct ata_device *drive)
+{
+	do_timeout_irq(drive);
+	do_udma_start(drive);
+}
+
+static void hpt370_udma_lost_irq(struct ata_device *drive)
+{
+	do_timeout_irq(drive);
+	do_udma_start(drive);
+}
+
+static int hpt370_udma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	dma_stat = inb(dma_base + 2);
+	if (dma_stat & 0x01) {
+		udelay(20); /* wait a little */
+		dma_stat = inb(dma_base + 2);
+	}
+	if ((dma_stat & 0x01) != 0) {
+		do_timeout_irq(drive);
+		do_udma_start(drive);
+	}
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
+}
+
 int hpt370_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *hwif = drive->channel;
@@ -845,18 +925,6 @@
 			dma_stat = inb(dma_base+2);
 			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 
-		case ide_dma_end:
-			dma_stat = inb(dma_base + 2);
-			if (dma_stat & 0x01) {
-				udelay(20); /* wait a little */
-				dma_stat = inb(dma_base + 2);
-			}
-			if ((dma_stat & 0x01) == 0) 
-				break;
-
-			func = ide_dma_timeout;
-			/* fallthrough */
-
 		case ide_dma_timeout:
 		case ide_dma_lostirq:
 			pci_read_config_byte(hwif->pci_dev, reginfo, 
@@ -871,11 +939,7 @@
 			outb(dma_stat | 0x6, dma_base+2); /* clear errors */
 			/* fallthrough */
 
-#ifdef HPT_RESET_STATE_ENGINE
-	        case ide_dma_begin:
-#endif
-			pci_write_config_byte(hwif->pci_dev, regstate, 0x37);
-			udelay(10);
+			do_udma_start(drive);
 			break;
 
 		default:
@@ -883,7 +947,7 @@
 	}
 	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * Since SUN Cobalt is attempting to do this operation, I should disclose
@@ -1183,6 +1247,8 @@
 			pci_read_config_byte(hwif->pci_dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */
 				pci_write_config_byte(hwif->pci_dev, 0x5a, reg5ah & ~0x10);
+			hwif->udma_start = hpt370_udma_start;
+			hwif->udma_stop = hpt370_udma_stop;
 			hwif->udma = hpt370_dmaproc;
 		} else {
 			hwif->udma = hpt366_dmaproc;
diff -urN linux-2.5.13/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.13/drivers/ide/ide.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-05 04:27:55.000000000 +0200
@@ -1407,7 +1407,7 @@
 	/*
 	 * end current dma transaction
 	 */
-	ch->udma(ide_dma_end, drive, rq);
+	ch->udma_stop(drive);
 
 	/*
 	 * complain a little, later we might remove some of this verbosity
@@ -2127,6 +2127,13 @@
 	ch->atapi_read = old.atapi_read;
 	ch->atapi_write = old.atapi_write;
 	ch->udma = old.udma;
+	ch->udma_start = old.udma_start;
+	ch->udma_stop = old.udma_stop;
+	ch->udma_read = old.udma_read;
+	ch->udma_write = old.udma_write;
+	ch->udma_irq_status = old.udma_irq_status;
+	ch->udma_timeout = old.udma_timeout;
+	ch->udma_lost_irq = old.udma_lost_irq;
 	ch->busproc = old.busproc;
 	ch->bus_state = old.bus_state;
 	ch->dma_base = old.dma_base;
diff -urN linux-2.5.13/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.13/drivers/ide/ide-cd.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-05 06:36:30.000000000 +0200
@@ -737,9 +737,9 @@
 
 	if (info->dma) {
 		if (info->cmd == READ)
-			info->dma = !drive->channel->udma(ide_dma_read, drive, rq);
+			info->dma = !udma_read(drive, rq);
 		else if (info->cmd == WRITE)
-			info->dma = !drive->channel->udma(ide_dma_write, drive, rq);
+			info->dma = !udma_write(drive, rq);
 		else
 			printk("ide-cd: DMA set, but not allowed\n");
 	}
@@ -755,7 +755,7 @@
 		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
 
 	if (info->dma)
-		drive->channel->udma(ide_dma_begin, drive, NULL);
+		udma_start(drive, rq);
 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		ide_set_handler(drive, handler, WAIT_CMD, cdrom_timer_expiry);
@@ -905,7 +905,7 @@
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
-		if ((dma_error = drive->channel->udma(ide_dma_end, drive, NULL)))
+		if ((dma_error = udma_stop(drive)))
 			drive->channel->udma(ide_dma_off, drive, NULL);
 	}
 
@@ -1480,7 +1480,7 @@
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
-		if ((dma_error = drive->channel->udma(ide_dma_end, drive, NULL))) {
+		if ((dma_error = udma_stop(drive))) {
 			printk("ide-cd: write dma error\n");
 			drive->channel->udma(ide_dma_off, drive, NULL);
 		}
diff -urN linux-2.5.13/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.13/drivers/ide/ide-dma.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-05 06:55:44.000000000 +0200
@@ -199,7 +199,7 @@
 {
 	u8 stat, dma_stat;
 
-	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
+	dma_stat = udma_stop(drive);
 	if (OK_STAT(stat = GET_STAT(),DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
@@ -288,7 +288,7 @@
 			printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
 		return(blacklist);
 	}
-#else /* !CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
+#else
 	const char **list;
 
 	if (good_bad) {
@@ -309,7 +309,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_IDEDMA_NEW_DRIVE_LISTINGS */
+#endif
 	return 0;
 }
 
@@ -326,7 +326,7 @@
 
 	if (id && (id->capability & 1) && ch->autodma && config_allows_dma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL))
+		if (udma_black_list(drive))
 			return ch->udma(ide_dma_off, drive, NULL);
 
 		/* Enable DMA on any drive that has UltraDMA (mode 6/7/?) enabled */
@@ -346,7 +346,7 @@
 			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404)
 				return ch->udma(ide_dma_on, drive, NULL);
 		/* Consult the list of known "good" drives */
-		if (ide_dmaproc(ide_dma_good_drive, drive, NULL))
+		if (udma_white_list(drive))
 			return ch->udma(ide_dma_on, drive, NULL);
 	}
 	return ch->udma(ide_dma_off_quietly, drive, NULL);
@@ -420,7 +420,7 @@
  *
  * For ATAPI devices, we just prepare for DMA and return. The caller should
  * then issue the packet command to the drive and call us again with
- * ide_dma_begin afterwards.
+ * udma_start afterwards.
  *
  * Returns 0 if all went well.
  * Returns 1 if DMA read/write could not be started, in which case
@@ -432,7 +432,7 @@
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
 	u8 unit = (drive->select.b.unit & 0x01);
-	unsigned int reading = 0, set_high = 1;
+	unsigned int set_high = 1;
 	u8 dma_stat;
 
 	switch (func) {
@@ -456,41 +456,6 @@
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
-		case ide_dma_read:
-			reading = 1 << 3;
-		case ide_dma_write:
-			if (ata_start_dma(drive, rq))
-				return 1;
-
-			if (drive->type != ATA_DISK)
-				return 0;
-
-			ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-			if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
-				struct ata_taskfile *args = rq->special;
-
-				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
-			} else if (drive->addressing) {
-				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-			} else {
-				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-			}
-			return drive->channel->udma(ide_dma_begin, drive, NULL);
-		case ide_dma_begin:
-			/* Note that this is done *after* the cmd has
-			 * been issued to the drive, as per the BM-IDE spec.
-			 * The Promise Ultra33 doesn't work correctly when
-			 * we do this part before issuing the drive cmd.
-			 */
-			outb(inb(dma_base)|1, dma_base);		/* start DMA */
-			return 0;
-		case ide_dma_end: /* returns 1 on error, 0 otherwise */
-			drive->waiting_for_dma = 0;
-			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
-			dma_stat = inb(dma_base+2);		/* get DMA status */
-			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
-			udma_destroy_table(ch);	/* purge DMA mappings */
-			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
 #if 0  /* do not set unless you know what you are doing */
@@ -500,13 +465,9 @@
 			}
 #endif
 			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		case ide_dma_bad_drive:
-		case ide_dma_good_drive:
-			return check_drive_lists(drive, (func == ide_dma_good_drive));
 		case ide_dma_timeout:
 			printk(KERN_ERR "%s: DMA timeout occured!\n", __FUNCTION__);
 			return 1;
-		case ide_dma_retune:
 		case ide_dma_lostirq:
 			printk(KERN_ERR "%s: chipset supported func only: %d\n", __FUNCTION__,  func);
 			return 1;
@@ -585,7 +546,64 @@
 /****************************************************************************
  * UDMA function which should have architecture specific counterparts where
  * neccessary.
+ *
+ * The intention is that at some point in time we will move this whole to
+ * architecture specific kernel sections. For now I would love the architecture
+ * maintainers to just #ifdef #endif this stuff directly here. I have for now
+ * tryed to update as much as I could in the architecture specific code.  But
+ * of course I may have done mistakes, so please bear with me and update it
+ * here the proper way.
+ *
+ * Thank you a lot in advance!
+ *
+ * Sat May  4 20:29:46 CEST 2002 Marcin Dalecki.
+ */
+
+/*
+ * This is the generic part of the DMA setup used by the host chipset drivers
+ * in the corresponding DMA setup method.
+ *
+ * FIXME: there are some places where this gets used driectly for "error
+ * recovery" in the ATAPI drivers. This was just plain wrong before, in esp.
+ * not portable, and just got uncovered now.
  */
+void udma_enable(struct ata_device *drive, int on, int verbose)
+{
+	struct ata_channel *ch = drive->channel;
+	int set_high = 1;
+	u8 unit = (drive->select.b.unit & 0x01);
+	u64 addr = BLK_BOUNCE_HIGH;
+
+	if (!on) {
+		if (verbose)
+			printk("%s: DMA disabled\n", drive->name);
+		set_high = 0;
+		outb(inb(ch->dma_base + 2) & ~(1 << (5 + unit)), ch->dma_base + 2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		udma_tcq_enable(drive, 0);
+#endif
+	}
+
+	/* toggle bounce buffers */
+
+	if (on && drive->type == ATA_DISK && drive->channel->highmem) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = drive->channel->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+
+	drive->using_dma = on;
+
+	if (on) {
+		outb(inb(ch->dma_base + 2) | (1 << (5 + unit)), ch->dma_base + 2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+		udma_tcq_enable(drive, 1);
+#endif
+	}
+}
 
 /*
  * This prepares a dma request.  Returns 0 if all went okay, returns 1
@@ -718,4 +736,157 @@
 #endif
 }
 
+/*
+ * Drive back/white list handling for UDMA capability:
+ */
+
+int udma_black_list(struct ata_device *drive)
+{
+	return check_drive_lists(drive, 0);
+}
+
+int udma_white_list(struct ata_device *drive)
+{
+	return check_drive_lists(drive, 1);
+}
+
+/*
+ * Generic entry points for functions provided possibly by the host chip set
+ * drivers.
+ */
+
+/*
+ * Prepare the channel for a DMA startfer. Please note that only the broken
+ * Pacific Digital host chip needs the reques to be passed there to decide
+ * about addressing modes.
+ */
+
+int udma_start(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+
+	if (ch->udma_start)
+		return ch->udma_start(drive, rq);
+
+	/* Note that this is done *after* the cmd has
+	 * been issued to the drive, as per the BM-IDE spec.
+	 * The Promise Ultra33 doesn't work correctly when
+	 * we do this part before issuing the drive cmd.
+	 */
+	outb(inb(dma_base)|1, dma_base);		/* start DMA */
+	return 0;
+}
+
+int udma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	if (ch->udma_stop)
+		return ch->udma_stop(drive);
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
+}
+
+/*
+ * This is the default read write function.
+ *
+ * It's exported only for host chips which use it for fallback or (too) late
+ * capability checking.
+ */
+
+int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+{
+	if (ata_start_dma(drive, rq))
+		return 1;
+
+	if (drive->type != ATA_DISK)
+		return 0;
+
+	reading <<= 3;
+
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
+	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
+		struct ata_taskfile *args = rq->special;
+
+		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+	} else if (drive->addressing) {
+		OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+	} else {
+		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+	}
+
+	return udma_start(drive, rq);
+}
+
+int udma_read(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	if (ch->udma_read)
+		return ch->udma_read(drive, rq);
+
+	return ata_do_udma(1, drive, rq);
+}
+
+int udma_write(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	if (ch->udma_write)
+		return ch->udma_write(drive, rq);
+
+	return ata_do_udma(0, drive, rq);
+}
+
+/*
+ * FIXME: This should be attached to a channel as we can see now!
+ */
+int udma_irq_status(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	u8 dma_stat;
+
+	if (ch->udma_irq_status)
+		return ch->udma_irq_status(drive);
+
+	/* default action */
+	dma_stat = inb(ch->dma_base + 2);
+
+	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
+}
+
+void udma_timeout(struct ata_device *drive)
+{
+	printk(KERN_ERR "ATA: UDMA timeout occured %s!\n", drive->name);
+
+	/* Invoke the chipset specific handler now. */
+	if (drive->channel->udma_timeout)
+		drive->channel->udma_timeout(drive);
+
+}
+
+void udma_lost_irq(struct ata_device *drive)
+{
+	if (drive->channel->udma_lost_irq)
+		drive->channel->udma_lost_irq(drive);
+}
+
+EXPORT_SYMBOL(udma_enable);
+EXPORT_SYMBOL(udma_start);
+EXPORT_SYMBOL(udma_stop);
+EXPORT_SYMBOL(udma_read);
+EXPORT_SYMBOL(udma_write);
+EXPORT_SYMBOL(ata_do_udma);
+EXPORT_SYMBOL(udma_irq_status);
 EXPORT_SYMBOL(udma_print);
+EXPORT_SYMBOL(udma_black_list);
+EXPORT_SYMBOL(udma_white_list);
diff -urN linux-2.5.13/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.13/drivers/ide/ide-floppy.c	2002-05-03 02:22:45.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-05-05 06:39:44.000000000 +0200
@@ -901,7 +901,7 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
-		if (drive->channel->udma(ide_dma_end, drive, NULL)) {
+		if (udma_stop(drive)) {
 			set_bit (PC_DMA_ERROR, &pc->flags);
 		} else {
 			pc->actually_transferred=pc->request_transfer;
@@ -1122,8 +1122,12 @@
 	if (test_and_clear_bit (PC_DMA_ERROR, &pc->flags)) {
 		(void) drive->channel->udma(ide_dma_off, drive, NULL);
 	}
-	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		dma_ok=!drive->channel->udma(test_bit (PC_WRITING, &pc->flags) ? ide_dma_write : ide_dma_read, drive, rq);
+	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
+		if (test_bit (PC_WRITING, &pc->flags))
+			dma_ok = !udma_write(drive, rq);
+		else
+			dma_ok = !udma_read(drive, rq);
+	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 	if (IDE_CONTROL_REG)
@@ -1136,7 +1140,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (dma_ok) {							/* Begin DMA, if necessary */
 		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) drive->channel->udma(ide_dma_begin, drive, NULL);
+		udma_start(drive, rq);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
diff -urN linux-2.5.13/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.13/drivers/ide/ide-pci.c	2002-05-05 07:04:47.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-05 03:56:46.000000000 +0200
@@ -709,7 +709,7 @@
 		d->bootable = (pcicmd & PCI_COMMAND_MEMORY) ? OFF_BOARD : NEVER_BOARD;
 	}
 
-	printk("%s: chipset revision %d\n", dev->name, class_rev);
+	printk(KERN_INFO "ATA: chipset rev.: %d\n", class_rev);
 
 	/*
 	 * Can we trust the reported IRQ?
@@ -722,11 +722,11 @@
 		   to act otherwise on those. The Supertrak however we need
 		   to skip */
 		if (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20265) {
-			printk(KERN_INFO "ide: Found promise 20265 in RAID mode.\n");
+			printk(KERN_INFO "ATA: Found promise 20265 in RAID mode.\n");
 			if(dev->bus->self && dev->bus->self->vendor == PCI_VENDOR_ID_INTEL &&
 				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
 			{
-				printk(KERN_INFO "ide: Skipping Promise PDC20265 attached to I2O RAID controller.\n");
+				printk(KERN_INFO "ATA: Skipping Promise PDC20265 attached to I2O RAID controller.\n");
 				return;
 			}
 		}
@@ -734,9 +734,10 @@
 		   Suspect a fastrak and fall through */
 	}
 	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
-		printk("%s: not 100%% native mode: will probe irqs later\n", dev->name);
+		printk(KERN_INFO "ATA: non-legacy mode: IRQ probe delayed\n");
+
 		/*
-		 * This allows off board ide-pci cards the enable a BIOS,
+		 * This allows off board ide-pci cards to enable a BIOS,
 		 * verify interrupt settings of split-mirror pci-config
 		 * space, place chipset into init-mode, and/or preserve
 		 * an interrupt if the card is not native ide support.
@@ -746,19 +747,18 @@
 		else
 			pciirq = trust_pci_irq(d, dev);
 	} else if (tried_config) {
-		printk("%s: will probe IRQs later\n", dev->name);
+		printk(KERN_INFO "ATA: will probe IRQs later\n");
 		pciirq = 0;
 	} else if (!pciirq) {
-		printk("%s: bad IRQ (%d): will probe later\n", dev->name, pciirq);
+		printk(KERN_INFO "ATA: invalid IRQ (%d): will probe later\n", pciirq);
 		pciirq = 0;
 	} else {
 		if (d->init_chipset)
 			d->init_chipset(dev);
 #ifdef __sparc__
-		printk("%s: 100%% native mode on irq %s\n",
-		       dev->name, __irq_itoa(pciirq));
+		printk(KERN_INFO "ATA: 100%% native mode on irq\n", __irq_itoa(pciirq));
 #else
-		printk("%s: 100%% native mode on irq %d\n", dev->name, pciirq);
+		printk(KERN_INFO "ATA: 100%% native mode on irq %d\n", pciirq);
 #endif
 	}
 
@@ -889,10 +889,10 @@
 		pdc20270_device_order_fixup(dev, d);
 	else if (!(d->vendor == 0 && d->device == 0) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (d->vendor == 0 && d->device == 0)
-			printk(KERN_INFO "ATA: unknown ATA interface %s (%04x:%04x) on PCI slot %s\n",
+			printk(KERN_INFO "ATA: unknown interface: %s (%04x:%04x) on PCI slot %s\n",
 			       dev->name, vendor, device, dev->slot_name);
 		else
-			printk(KERN_INFO "ATA: interface %s on PCI slot %s\n", dev->name, dev->slot_name);
+			printk(KERN_INFO "ATA: interface: %s, on PCI slot %s\n", dev->name, dev->slot_name);
 		setup_pci_device(dev, d);
 	}
 }
diff -urN linux-2.5.13/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.13/drivers/ide/ide-pmac.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-05 06:55:24.000000000 +0200
@@ -1449,7 +1449,6 @@
 	case ide_dma_bad_drive:
 	case ide_dma_good_drive:
 		return check_drive_lists(drive, (func == ide_dma_good_drive));
-	case ide_dma_retune:
 	case ide_dma_lostirq:
 	case ide_dma_timeout:
 		printk(KERN_WARNING "ide_pmac_dmaproc: chipset supported func only: %d\n", func);
diff -urN linux-2.5.13/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.13/drivers/ide/ide-tape.c	2002-05-03 02:22:43.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-05 06:37:08.000000000 +0200
@@ -2058,7 +2058,7 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
-		if (drive->channel->udma(ide_dma_end, drive, NULL)) {
+		if (udma_stop(drive)) {
 			/*
 			 * A DMA error is sometimes expected. For example,
 			 * if the tape is crossing a filemark during a
@@ -2311,9 +2311,13 @@
 		printk (KERN_WARNING "ide-tape: DMA disabled, reverting to PIO\n");
 		(void) drive->channel->udma(ide_dma_off, drive, NULL);
 	}
-	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		dma_ok = !drive->channel->udma(test_bit (PC_WRITING, &pc->flags) ? ide_dma_write : ide_dma_read, drive, rq);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
+		if (test_bit (PC_WRITING, &pc->flags))
+			dma_ok = !udma_write(drive, rq);
+		else
+			dma_ok = !udma_read(drive, rq);
+	}
+#endif
 
 	if (IDE_CONTROL_REG)
 		OUT_BYTE (drive->ctl, IDE_CONTROL_REG);
@@ -2324,7 +2328,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (dma_ok) {						/* Begin DMA, if necessary */
 		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) drive->channel->udma(ide_dma_begin, drive, NULL);
+		udma_start(drive, rq);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
diff -urN linux-2.5.13/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.13/drivers/ide/ide-taskfile.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-05 06:20:42.000000000 +0200
@@ -461,7 +461,6 @@
 		 * regular dma proc -- basically split stuff that needs to act
 		 * on a request from things like ide_dma_check etc.
 		 */
-		ide_dma_action_t dma_act;
 
 		if (!drive->using_dma)
 			return ide_started;
@@ -469,10 +468,10 @@
 		/* for dma commands we don't set the handler */
 		if (args->taskfile.command == WIN_WRITEDMA
 		 || args->taskfile.command == WIN_WRITEDMA_EXT)
-			dma_act = ide_dma_write;
+			udma_write(drive, rq);
 		else if (args->taskfile.command == WIN_READDMA
 		      || args->taskfile.command == WIN_READDMA_EXT)
-			dma_act = ide_dma_read;
+			udma_read(drive, rq);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
 		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED
 		      || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT
@@ -484,10 +483,6 @@
 			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
 			return ide_stopped;
 		}
-
-
-		if (drive->channel->udma(dma_act, drive, rq))
-			return ide_stopped;
 	}
 
 	return ide_started;
diff -urN linux-2.5.13/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.13/drivers/ide/ns87415.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-05-05 06:29:10.000000000 +0200
@@ -82,26 +82,50 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int ns87415_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+
+static int ns87415_udma_stop(struct ata_device *drive)
 {
-	struct ata_channel *hwif = drive->channel;
-	byte		dma_stat;
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	drive->waiting_for_dma = 0;
+	dma_stat = inb(ch->dma_base+2);
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	outb(inb(dma_base)|6, dma_base);	/* from ERRATA: clear the INTR & ERROR bits */
+	udma_destroy_table(ch);				/* and free any DMA resources */
+
+	return (dma_stat & 7) != 4;	/* verify good DMA status */
+
+}
+
+static int ns87415_udma_read(struct ata_device *drive, struct request *rq)
+{
+	ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
+
+	if (!ata_do_udma(1, drive, rq))		/* use standard DMA stuff */
+		return 0;
+
+	ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
+
+	return 1;
+}
 
+static int ns87415_udma_write(struct ata_device *drive, struct request *rq)
+{
+	ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
+
+	if (!ata_do_udma(0, drive, rq))		/* use standard DMA stuff */
+		return 0;
+
+	ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
+
+	return 1;
+}
+
+static int ns87415_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+{
 	switch (func) {
-		case ide_dma_end: /* returns 1 on error, 0 otherwise */
-			drive->waiting_for_dma = 0;
-			dma_stat = inb(hwif->dma_base+2);
-			outb(inb(hwif->dma_base)&~1, hwif->dma_base);	/* stop DMA */
-			outb(inb(hwif->dma_base)|6, hwif->dma_base);	/* from ERRATA: clear the INTR & ERROR bits */
-			udma_destroy_table(hwif);			/* and free any DMA resources */
-			return (dma_stat & 7) != 4;		/* verify good DMA status */
-		case ide_dma_write:
-		case ide_dma_read:
-			ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
-			if (!ide_dmaproc(func, drive, rq))		/* use standard DMA stuff */
-				return 0;
-			ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
-			return 1;
 		case ide_dma_check:
 			if (drive->type != ATA_DISK)
 				return ide_dmaproc(ide_dma_off_quietly, drive, rq);
@@ -205,8 +229,12 @@
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->dma_base)
+	if (hwif->dma_base) {
+		hwif->udma_stop = ns87415_udma_stop;
+		hwif->udma_read = ns87415_udma_read;
+		hwif->udma_write = ns87415_udma_write;
 		hwif->udma = ns87415_dmaproc;
+	}
 #endif
 
 	hwif->selectproc = &ns87415_selectproc;
diff -urN linux-2.5.13/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.13/drivers/ide/pdc202xx.c	2002-05-03 02:22:57.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-05 06:51:02.000000000 +0200
@@ -916,7 +916,7 @@
 	return ((int)	((id->dma_ultra >> 14) & 3) ? ide_dma_on :
 			((id->dma_ultra >> 11) & 7) ? ide_dma_on :
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on : 
+			((id->dma_mword >> 8) & 7) ? ide_dma_on :
 			((id->dma_1word >> 8) & 7) ? ide_dma_on :
 						     ide_dma_off_quietly);
 }
@@ -929,7 +929,7 @@
 
 	if (id && (id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -951,7 +951,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -977,20 +977,107 @@
 	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
 }
 
+static int pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
+{
+	u8 clock		= 0;
+	u8 hardware48hack	= 0;
+	struct ata_channel *ch = drive->channel;
+	struct pci_dev *dev	= ch->pci_dev;
+	unsigned long high_16	= pci_resource_start(dev, 4);
+	unsigned long atapi_reg	= high_16 + (ch->unit ? 0x24 : 0x00);
+
+
+	switch (dev->device) {
+		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
+		case PCI_DEVICE_ID_PROMISE_20269:
+		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20268:
+			break;
+		case PCI_DEVICE_ID_PROMISE_20267:
+		case PCI_DEVICE_ID_PROMISE_20265:
+		case PCI_DEVICE_ID_PROMISE_20262:
+			hardware48hack = 1;
+			clock = IN_BYTE(high_16 + 0x11);
+		default:
+			break;
+	}
+
+	if ((drive->addressing) && (hardware48hack)) {
+		unsigned long word_count = 0;
+
+		outb(clock|(ch->unit ? 0x08 : 0x02), high_16 + 0x11);
+		word_count = (rq->nr_sectors << 8);
+		word_count = (rq_data_dir(rq) == READ) ? word_count | 0x05000000 : word_count | 0x06000000;
+		outl(word_count, atapi_reg);
+	}
+
+	/* Note that this is done *after* the cmd has been issued to the drive,
+	 * as per the BM-IDE spec.  The Promise Ultra33 doesn't work correctly
+	 * when we do this part before issuing the drive cmd.
+	 */
+
+	outb(inb(ch->dma_base) | 1, ch->dma_base); /* start DMA */
+
+	return 0;
+}
+
+int pdc202xx_udma_stop(struct ata_device *drive)
+{
+	u8 newchip		= 0;
+	u8 clock		= 0;
+	u8 hardware48hack	= 0;
+	struct ata_channel *ch = drive->channel;
+	struct pci_dev *dev	= ch->pci_dev;
+	unsigned long high_16	= pci_resource_start(dev, 4);
+	unsigned long atapi_reg	= high_16 + (ch->unit ? 0x24 : 0x00);
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
+
+	switch (dev->device) {
+		case PCI_DEVICE_ID_PROMISE_20275:
+		case PCI_DEVICE_ID_PROMISE_20276:
+		case PCI_DEVICE_ID_PROMISE_20269:
+		case PCI_DEVICE_ID_PROMISE_20268R:
+		case PCI_DEVICE_ID_PROMISE_20268:
+			newchip = 1;
+			break;
+		case PCI_DEVICE_ID_PROMISE_20267:
+		case PCI_DEVICE_ID_PROMISE_20265:
+		case PCI_DEVICE_ID_PROMISE_20262:
+			hardware48hack = 1;
+			clock = IN_BYTE(high_16 + 0x11);
+ 		default:
+			break;
+	}
+	if ((drive->addressing) && (hardware48hack)) {
+		outl(0, atapi_reg);	/* zero out extra */
+		clock = IN_BYTE(high_16 + 0x11);
+		OUT_BYTE(clock & ~(ch->unit ? 0x08:0x02), high_16 + 0x11);
+	}
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
+}
+
 /*
  * pdc202xx_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
  */
 int pdc202xx_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	byte dma_stat		= 0;
-	byte sc1d		= 0;
-	byte newchip		= 0;
-	byte clock		= 0;
-	byte hardware48hack	= 0;
+	u8 dma_stat	= 0;
+	u8 sc1d		= 0;
+	u8 newchip	= 0;
+	u8 clock	= 0;
+	u8 hardware48hack = 0;
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long atapi_reg	= high_16 + (hwif->unit ? 0x24 : 0x00);
 	unsigned long dma_base	= hwif->dma_base;
 
 	switch (dev->device) {
@@ -1013,29 +1100,6 @@
 	switch (func) {
 		case ide_dma_check:
 			return config_drive_xfer_rate(drive);
-		case ide_dma_begin:
-			/* Note that this is done *after* the cmd has
-			 * been issued to the drive, as per the BM-IDE spec.
-			 * The Promise Ultra33 doesn't work correctly when
-			 * we do this part before issuing the drive cmd.
-			 */
-			if ((drive->addressing) && (hardware48hack)) {
-				struct request *rq = HWGROUP(drive)->rq;
-				unsigned long word_count = 0;
-
-				outb(clock|(hwif->unit ? 0x08 : 0x02), high_16 + 0x11);
-				word_count = (rq->nr_sectors << 8);
-				word_count = (rq_data_dir(rq) == READ) ? word_count | 0x05000000 : word_count | 0x06000000;
-				outl(word_count, atapi_reg);
-			}
-			break;
-		case ide_dma_end:
-			if ((drive->addressing) && (hardware48hack)) {
-				outl(0, atapi_reg);	/* zero out extra */
-				clock = IN_BYTE(high_16 + 0x11);
-				OUT_BYTE(clock & ~(hwif->unit ? 0x08:0x02), high_16 + 0x11);
-			}
-			break;
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = IN_BYTE(dma_base+2);
 			if (newchip)
@@ -1268,6 +1332,8 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
+		hwif->udma_start = pdc202xx_udma_start;
+		hwif->udma_stop = pdc202xx_udma_stop;
 		hwif->udma = pdc202xx_dmaproc;
 		hwif->highmem = 1;
 		if (!noautodma)
diff -urN linux-2.5.13/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.13/drivers/ide/serverworks.c	2002-05-03 02:22:54.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-05 06:50:07.000000000 +0200
@@ -431,14 +431,14 @@
 						     ide_dma_off_quietly);
 }
 
-static int config_drive_xfer_rate (ide_drive_t *drive)
+static int config_drive_xfer_rate(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -460,7 +460,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive, NULL)) {
+		} else if (udma_white_list(drive)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -480,45 +480,54 @@
 	return drive->channel->udma(dma_func, drive, NULL);
 }
 
-static int svwks_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int svwks_udma_stop(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		case ide_dma_end:
-		{
-			struct ata_channel *hwif = drive->channel;
-			unsigned long dma_base		= hwif->dma_base;
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 dma_stat;
 
-			if(inb(dma_base+0x02)&1)
-			{
+	if(inb(dma_base+0x02)&1)
+	{
 #if 0
-				int i;
-				printk(KERN_ERR "Curious - OSB4 thinks the DMA is still running.\n");
-				for(i=0;i<10;i++)
-				{
-					if(!(inb(dma_base+0x02)&1))
-					{
-						printk(KERN_ERR "OSB4 now finished.\n");
-						break;
-					}
-					udelay(5);
-				}
+		int i;
+		printk(KERN_ERR "Curious - OSB4 thinks the DMA is still running.\n");
+		for(i=0;i<10;i++)
+		{
+			if(!(inb(dma_base+0x02)&1))
+			{
+				printk(KERN_ERR "OSB4 now finished.\n");
+				break;
+			}
+			udelay(5);
+		}
 #endif
-				printk(KERN_CRIT "Serverworks OSB4 in impossible state.\n");
-				printk(KERN_CRIT "Disable UDMA or if you are using Seagate then try switching disk types\n");
-				printk(KERN_CRIT "on this controller. Please report this event to osb4-bug@ide.cabal.tm\n");
+		printk(KERN_CRIT "Serverworks OSB4 in impossible state.\n");
+		printk(KERN_CRIT "Disable UDMA or if you are using Seagate then try switching disk types\n");
+		printk(KERN_CRIT "on this controller. Please report this event to osb4-bug@ide.cabal.tm\n");
 #if 0
-				/* Panic might sys_sync -> death by corrupt disk */
-				panic("OSB4: continuing might cause disk corruption.\n");
+		/* Panic might sys_sync -> death by corrupt disk */
+		panic("OSB4: continuing might cause disk corruption.\n");
 #else
-				printk(KERN_CRIT "OSB4: continuing might cause disk corruption.\n");
-				while(1)
-					cpu_relax();
+		printk(KERN_CRIT "OSB4: continuing might cause disk corruption.\n");
+		while(1)
+			cpu_relax();
 #endif
-			}
-			/* and drop through */
-		}
+	}
+
+	drive->waiting_for_dma = 0;
+	outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
+	dma_stat = inb(dma_base+2);		/* get DMA status */
+	outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
+	udma_destroy_table(ch);			/* purge DMA mappings */
+
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
+}
+
+static int svwks_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+{
+	switch (func) {
+		case ide_dma_check:
+			return config_drive_xfer_rate(drive);
 		default:
 			break;
 	}
@@ -645,6 +654,7 @@
 		if (!noautodma)
 			hwif->autodma = 1;
 #endif
+		hwif->udma_stop = svwks_udma_stop;
 		hwif->udma = svwks_dmaproc;
 		hwif->highmem = 1;
 	} else {
diff -urN linux-2.5.13/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.13/drivers/ide/sis5513.c	2002-05-03 02:22:49.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-05-05 06:52:10.000000000 +0200
@@ -685,7 +685,7 @@
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -707,7 +707,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if ((ide_dmaproc(ide_dma_good_drive, drive, NULL)) &&
+		} else if ((udma_white_list(drive)) &&
 			   (id->eide_dma_time > 150)) {
 			/* Consult the list of known "good" drives */
 			dma_func = config_chipset_for_dma(drive, 0);
diff -urN linux-2.5.13/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.13/drivers/ide/sl82c105.c	2002-05-03 02:22:46.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-05-05 06:53:08.000000000 +0200
@@ -114,7 +114,7 @@
  * Check to see if the drive and
  * chipset is capable of DMA mode
  */
-static int sl82c105_check_drive(ide_drive_t *drive)
+static int sl82c105_check_drive(ide_drive_t *drive, struct request *rq)
 {
 	ide_dma_action_t dma_func = ide_dma_off_quietly;
 
@@ -129,7 +129,7 @@
 			break;
 
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
+		if (udma_black_list(drive)) {
 			dma_func = ide_dma_off;
 			break;
 		}
@@ -140,23 +140,23 @@
 			break;
 		}
 
-		if (ide_dmaproc(ide_dma_good_drive, drive)) {
+		if (udma_white_list(drive)) {
 			dma_func = ide_dma_on;
 			break;
 		}
 	} while (0);
 
-	return drive->channel->dmaproc(dma_func, drive);
+	return drive->channel->udma(dma_func, drive, rq);
 }
 
 /*
  * Our own dmaproc, only to intercept ide_dma_check
  */
-static int sl82c105_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+static int sl82c105_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	switch (func) {
 	case ide_dma_check:
-		return sl82c105_check_drive(drive);
+		return sl82c105_check_drive(drive, rq);
 	case ide_dma_on:
 		if (config_for_dma(drive))
 			func = ide_dma_off;
@@ -168,7 +168,7 @@
 	default:
 		break;
 	}
-	return ide_dmaproc(func, drive);
+	return ide_dmaproc(func, drive, rq);
 }
 
 /*
@@ -183,8 +183,8 @@
 	 * We support 32-bit I/O on this interface, and it
 	 * doesn't have problems with interrupts.
 	 */
-	drive->io_32bit = 1;
-	drive->unmask = 1;
+	drive->channel->io_32bit = 1;
+	drive->channel->unmask = 1;
 }
 
 /*
@@ -252,10 +252,10 @@
 	}
 	outb(dma_state, dma_base + 2);
 
-	hwif->dmaproc = NULL;
+	hwif->udma = NULL;
 	ide_setup_dma(hwif, dma_base, 8);
-	if (hwif->dmaproc)
-		hwif->dmaproc = sl82c105_dmaproc;
+	if (hwif->udma)
+		hwif->udma = sl82c105_dmaproc;
 }
 
 /*
diff -urN linux-2.5.13/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.13/drivers/ide/tcq.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-05 06:03:18.000000000 +0200
@@ -95,7 +95,7 @@
 	del_timer(&hwgroup->timer);
 
 	if (test_bit(IDE_DMA, &hwgroup->flags))
-		drive->channel->udma(ide_dma_end, drive, hwgroup->rq);
+		udma_stop(drive);
 
 	blk_queue_invalidate_tags(q);
 
@@ -328,7 +328,7 @@
 	/*
 	 * transfer was in progress, stop DMA engine
 	 */
-	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
+	dma_stat = udma_stop(drive);
 
 	/*
 	 * must be end of I/O, check status and complete as necessary
@@ -531,7 +531,7 @@
 		return ide_stopped;
 
 	set_irq(drive, ide_dmaq_intr);
-	if (!ch->udma(ide_dma_begin, drive, rq))
+	if (!udma_start(drive, rq))
 		return ide_started;
 
 	return ide_stopped;
diff -urN linux-2.5.13/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.13/drivers/ide/trm290.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-05-05 06:32:15.000000000 +0200
@@ -173,36 +173,73 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int trm290_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int trm290_udma_start(struct ata_device *drive, struct request *__rq)
+{
+	/* Nothing to be done here. */
+	return 0;
+}
+
+static int trm290_udma_stop(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned int count, reading = 2, writing = 0;
 
-	switch (func) {
-		case ide_dma_write:
-			reading = 0;
-			writing = 1;
+	drive->waiting_for_dma = 0;
+	udma_destroy_table(ch);	/* purge DMA mappings */
+	return (inw(ch->dma_base + 2) != 0x00ff);
+}
+
+static int do_udma(unsigned int reading, struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned int count, writing;
+
+	if (!reading) {
+		reading = 0;
+		writing = 1;
 #ifdef TRM290_NO_DMA_WRITES
-			break;	/* always use PIO for writes */
+		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
+
+		return 1;
 #endif
-		case ide_dma_read:
-			if (!(count = udma_new_table(ch, rq)))
-				break;		/* try PIO instead of DMA */
-			trm290_prepare_drive(drive, 1);	/* select DMA xfer */
-			outl(ch->dmatable_dma|reading|writing, ch->dma_base);
-			drive->waiting_for_dma = 1;
-			outw((count * 2) - 1, ch->dma_base+2); /* start DMA */
-			if (drive->type != ATA_DISK)
-				return 0;
-			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-			return 0;
-		case ide_dma_begin:
-			return 0;
-		case ide_dma_end:
-			drive->waiting_for_dma = 0;
-			udma_destroy_table(ch);	/* purge DMA mappings */
-			return (inw(ch->dma_base + 2) != 0x00ff);
+	} else {
+		reading = 2;
+		writing = 0;
+	}
+
+	if (!(count = udma_new_table(ch, rq))) {
+		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
+		return 1;	/* try PIO instead of DMA */
+	}
+
+	trm290_prepare_drive(drive, 1);	/* select DMA xfer */
+	outl(ch->dmatable_dma|reading|writing, ch->dma_base);
+	drive->waiting_for_dma = 1;
+	outw((count * 2) - 1, ch->dma_base+2); /* start DMA */
+
+	if (drive->type != ATA_DISK)
+		return 0;
+
+	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
+	OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+
+	return 0;
+}
+
+static int trm290_udma_read(struct ata_device *drive, struct request *rq)
+{
+	return do_udma(1, drive, rq);
+}
+
+static int trm290_udma_write(struct ata_device *drive, struct request *rq)
+{
+	return do_udma(0, drive, rq);
+}
+
+static int trm290_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	switch (func) {
 		case ide_dma_test_irq:
 			return (inw(ch->dma_base + 2) == 0x00ff);
 		default:
@@ -263,6 +300,10 @@
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->unit ? 0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+	hwif->udma_start = trm290_udma_start;
+	hwif->udma_stop = trm290_udma_stop;
+	hwif->udma_read = trm290_udma_read;
+	hwif->udma_write = trm290_udma_write;
 	hwif->udma = trm290_dmaproc;
 #endif
 
diff -urN linux-2.5.13/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.13/drivers/scsi/ide-scsi.c	2002-05-03 02:22:38.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-05-05 06:41:03.000000000 +0200
@@ -328,7 +328,7 @@
 		printk ("ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
 		pc->actually_transferred=pc->request_transfer;
-		(void) drive->channel->udma(ide_dma_end, drive, NULL);
+		udma_stop(drive);
 	}
 
 	status = GET_STAT();						/* Clear the interrupt */
@@ -429,8 +429,12 @@
 	pc->current_position=pc->buffer;
 	bcount = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
-	if (drive->using_dma && rq->bio)
-		dma_ok = !drive->channel->udma(test_bit (PC_WRITING, &pc->flags) ? ide_dma_write : ide_dma_read, drive, rq);
+	if (drive->using_dma && rq->bio) {
+		if (test_bit (PC_WRITING, &pc->flags))
+			dma_ok = !udma_write(drive, rq);
+		else
+			dma_ok = !udma_read(drive, rq);
+	}
 
 	SELECT_DRIVE(drive->channel, drive);
 	if (IDE_CONTROL_REG)
@@ -441,7 +445,7 @@
 
 	if (dma_ok) {
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) drive->channel->udma(ide_dma_begin, drive, NULL);
+		udma_start(drive, rq);
 	}
 	if (test_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
 		ide_set_handler(drive, idescsi_transfer_pc, get_timeout(pc), NULL);
diff -urN linux-2.5.13/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.13/include/linux/ide.h	2002-05-05 07:04:53.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-05 06:54:29.000000000 +0200
@@ -375,15 +375,10 @@
 } ide_drive_t;
 
 typedef enum {
-	ide_dma_read,	ide_dma_write,
-	ide_dma_begin,	ide_dma_end,
 	ide_dma_check,
 	ide_dma_on, ide_dma_off,
 	ide_dma_off_quietly,
 	ide_dma_test_irq,
-	ide_dma_bad_drive,
-	ide_dma_good_drive,
-	ide_dma_retune,
 	ide_dma_lostirq,
 	ide_dma_timeout
 } ide_dma_action_t;
@@ -437,7 +432,19 @@
 	void (*atapi_read)(struct ata_device *, void *, unsigned int);
 	void (*atapi_write)(struct ata_device *, void *, unsigned int);
 
-	int (*udma)(ide_dma_action_t, struct ata_device *, struct request *); /* dma read/write/abort routine */
+	int (*udma)(ide_dma_action_t, struct ata_device *, struct request *);
+
+	int (*udma_start) (struct ata_device *, struct request *rq);
+	int (*udma_stop) (struct ata_device *);
+
+	int (*udma_read) (struct ata_device *, struct request *rq);
+	int (*udma_write) (struct ata_device *, struct request *rq);
+
+	int (*udma_irq_status) (struct ata_device *);
+
+	void (*udma_timeout) (struct ata_device *);
+	void (*udma_lost_irq) (struct ata_device *);
+
 	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
 	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
 	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
@@ -874,13 +881,25 @@
 extern void udma_destroy_table(struct ata_channel *);
 extern void udma_print(struct ata_device *);
 
+extern void udma_enable(struct ata_device *, int, int);
+extern int udma_black_list(struct ata_device *);
+extern int udma_white_list(struct ata_device *);
+extern void udma_timeout(struct ata_device *);
+extern void udma_lost_irq(struct ata_device *);
+extern int udma_start(struct ata_device *, struct request *rq);
+extern int udma_stop(struct ata_device *);
+extern int udma_read(struct ata_device *, struct request *rq);
+extern int udma_write(struct ata_device *, struct request *rq);
+extern int udma_irq_status(struct ata_device *);
+
+extern int ata_do_udma(unsigned int reading, struct ata_device *drive, struct request *rq);
+
 extern ide_startstop_t udma_tcq_taskfile(struct ata_device *, struct request *);
 extern int udma_tcq_enable(struct ata_device *, int);
 
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 extern int check_drive_lists(struct ata_device *, int good_bad);
 extern int ide_dmaproc(ide_dma_action_t func, struct ata_device *, struct request *);
-extern ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t, struct ata_device *, struct request *);
 extern void ide_release_dma(struct ata_channel *);
 extern void ide_setup_dma(struct ata_channel *,	unsigned long, unsigned int) __init;
 extern int ata_start_dma(struct ata_device *, struct request *rq);

--------------090604010305080904000201--

