Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEERAQ>; Sun, 5 May 2002 13:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313194AbSEERAP>; Sun, 5 May 2002 13:00:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21774 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313190AbSEEQ7r>; Sun, 5 May 2002 12:59:47 -0400
Message-ID: <3CD5564A.6030308@evision-ventures.com>
Date: Sun, 05 May 2002 17:56:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.13 IDE 54
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040906080502080705040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040906080502080705040302
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Sun May  5 16:32:22 CEST 2002 ide-clean-54

- Finish the changes from patch 53. ide_dma_actaion_t is gone now as well as
   whole hidden code paths associated with it. I hope I didn't mess too many
   things up with this, since the sheer size of the changes make them sensitive.
   (Tested on tree different host chip sets so it shouldn't be too bad...)

   Just still some minor cleanup remaining to be done in this area. The tags
   lefts there are intentional.

   In esp. the ide_dma_on method in cy82c693 looks suspicious.

   Using udma_enable in ide-cd.c, ide-floppy.c and ide-tape.c is suspicious as
   well. We have just uncovered it.

   In the next round we will concentrate on the fixes people did send me
   last time.

--------------040906080502080705040302
Content-Type: text/plain;
 name="ide-clean-54.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-54.diff"

diff -urN linux-2.5.13/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.13/drivers/ide/aec62xx.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-05 17:56:44.000000000 +0200
@@ -310,7 +310,7 @@
 	byte speed		= -1;
 
 	if (drive->type != ATA_DISK)
-		return ide_dma_off_quietly;
+		return 0;
 
 	if (((id->dma_ultra & 0x0010) ||
 	     (id->dma_ultra & 0x0008) ||
@@ -333,17 +333,17 @@
 	} else if (id->dma_1word & 0x0001) {
 		speed = XFER_SW_DMA_0;
 	} else {
- 		return ((int) ide_dma_off_quietly);
- 	}
+		return 0;
+	}
 
 	outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 	(void) aec6210_tune_chipset(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 11) & 3) ? ide_dma_off :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 11) & 3) ? 0 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
 static int config_aec6260_chipset_for_dma (ide_drive_t *drive, byte ultra)
@@ -356,7 +356,7 @@
 	byte ultra66		= eighty_ninty_three(drive);
 
 	if (drive->type != ATA_DISK)
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	if ((id->dma_ultra & 0x0010) && (ultra) && (ultra66)) {
 		speed = XFER_UDMA_4;
@@ -381,17 +381,17 @@
 	} else if (id->dma_1word & 0x0001) {
 		speed = XFER_SW_DMA_0;
 	} else {
-		return ((int) ide_dma_off_quietly);
+		return 0;
 	}
 
 	outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 	(void) aec6260_tune_chipset(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 11) & 3) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 11) & 3) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive, byte ultra)
@@ -403,7 +403,7 @@
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
 			return config_aec6260_chipset_for_dma(drive, ultra);
 		default:
-			return ((int) ide_dma_off_quietly);
+			return 0;
 	}
 }
 
@@ -433,21 +433,23 @@
 static int config_drive_xfer_rate (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x001F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, 1);
+				on = config_chipset_for_dma(drive, 1);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -455,8 +457,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, 0);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, 0);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -464,53 +466,29 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, 0);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, 0);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		aec62xx_tune_drive(drive, 5);
 	}
-	return drive->channel->udma(dma_func, drive, NULL);
+	udma_enable(drive, on, verbose);
+	return 0;
 }
 
-/*
- * aec62xx_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- */
-int aec62xx_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int aec62xx_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		case ide_dma_lostirq:
-		case ide_dma_timeout:
-			switch(drive->channel->pci_dev->device) {
-				case PCI_DEVICE_ID_ARTOP_ATP860:
-				case PCI_DEVICE_ID_ARTOP_ATP860R:
-//					{
-//						int i = 0;
-//						byte reg49h = 0;
-//						pci_read_config_byte(drive->channel->pci_dev, 0x49, &reg49h);
-//						for (i=0;i<256;i++)
-//							pci_write_config_byte(drive->channel->pci_dev, 0x49, reg49h|0x10);
-//						pci_write_config_byte(drive->channel->pci_dev, 0x49, reg49h & ~0x10);
-//					}
-//					return 0;
-				default:
-					break;
-			}
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	return config_drive_xfer_rate(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-#endif /* CONFIG_AEC62XX_TUNING */
+#endif
+#endif
 
 unsigned int __init pci_init_aec62xx (struct pci_dev *dev)
 {
@@ -546,7 +524,7 @@
 	hwif->speedproc = aec62xx_tune_chipset;
 # ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base)
-		hwif->udma = aec62xx_dmaproc;
+		hwif->XXX_udma = aec62xx_dmaproc;
 	hwif->highmem = 1;
 # else
 	hwif->drives[0].autotune = 1;
diff -urN linux-2.5.13/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.13/drivers/ide/alim15x3.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-05 17:58:09.000000000 +0200
@@ -297,7 +297,7 @@
 			pci_write_config_byte(dev, portFIFO, cd_dma_fifo & 0xF0);
 		}
 	}
-	
+
 	pci_write_config_byte(dev, port, s_clc);
 	pci_write_config_byte(dev, port+drive->select.b.unit+2, (a_clc << 4) | r_clc);
 	__restore_flags(flags);
@@ -391,7 +391,7 @@
 	} else if (id->dma_1word & 0x0001) {
 		speed = XFER_SW_DMA_0;
 	} else {
-		return ((int) ide_dma_off_quietly);
+		return 0;
 	}
 
 	(void) ali15x3_tune_chipset(drive, speed);
@@ -399,11 +399,11 @@
 	if (!drive->init_speed)
 		drive->init_speed = speed;
 
-	rval = (int)(	((id->dma_ultra >> 11) & 3) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	rval = (int)(	((id->dma_ultra >> 11) & 3) ? 1:
+			((id->dma_ultra >> 8) & 7) ? 1:
+			((id->dma_mword >> 8) & 7) ? 1:
+			((id->dma_1word >> 8) & 7) ? 1:
+						     0);
 
 	return rval;
 }
@@ -433,25 +433,29 @@
 {
 	struct hd_driveid *id = drive->id;
 	struct ata_channel *hwif = drive->channel;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 	byte can_ultra_dma = ali15x3_can_ultra(drive);
 
-	if ((m5229_revision<=0x20) && (drive->type != ATA_DISK))
-		return hwif->udma(ide_dma_off_quietly, drive, NULL);
+	if ((m5229_revision<=0x20) && (drive->type != ATA_DISK)) {
+		udma_enable(drive, 0, 0);
+		return 0;
+	}
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, can_ultra_dma);
+				on = config_chipset_for_dma(drive, can_ultra_dma);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -459,8 +463,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, can_ultra_dma);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, can_ultra_dma);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -468,19 +472,23 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, can_ultra_dma);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, can_ultra_dma);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		config_chipset_for_pio(drive);
 	}
-	return hwif->udma(dma_func, drive, NULL);
+
+	udma_enable(drive, on, verbose);
+
+	return 0;
 }
 
 static int ali15x3_udma_write(struct ata_device *drive, struct request *rq)
@@ -491,15 +499,9 @@
 	return ata_do_udma(0, drive, rq);
 }
 
-static int ali15x3_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int ali15x3_dmaproc(struct ata_device *drive)
 {
-	switch(func) {
-		case ide_dma_check:
-			return ali15x3_config_drive_for_dma(drive);
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	return ali15x3_config_drive_for_dma(drive);
 }
 #endif
 
@@ -684,7 +686,7 @@
 		 * M1543C or newer for DMAing
 		 */
 		hwif->udma_write = ali15x3_udma_write;
-		hwif->udma = ali15x3_dmaproc;
+		hwif->XXX_udma = ali15x3_dmaproc;
 		hwif->autodma = 1;
 	}
 
diff -urN linux-2.5.13/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.13/drivers/ide/amd74xx.c	2002-05-03 02:22:54.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-05-05 17:59:25.000000000 +0200
@@ -275,36 +275,23 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-
-/*
- * amd74xx_dmaproc() is a callback from upper layers that can do
- * a lot, but we use it for DMA/PIO tuning only, delegating everything
- * else to the default ide_dmaproc().
- */
-
-int amd74xx_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int amd74xx_dmaproc(struct ata_device *drive)
 {
+	short w80 = drive->channel->udma_four;
 
-	if (func == ide_dma_check) {
-
-		short w80 = drive->channel->udma_four;
-
-		short speed = ata_timing_mode(drive,
+	short speed = ata_timing_mode(drive,
 			XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
 			((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
 			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
 			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ? XFER_UDMA_100 : 0));
 
-		amd_set_drive(drive, speed);
+	amd_set_drive(drive, speed);
 
-		func = (drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO)
-			? ide_dma_on : ide_dma_off_quietly;
-	}
+	udma_enable(drive, drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO, 0);
 
-	return ide_dmaproc(func, drive, rq);
+	return 0;
 }
-
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * The initialization callback. Here we determine the IDE chip type
@@ -433,7 +420,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->udma = amd74xx_dmaproc;
+		hwif->XXX_udma = amd74xx_dmaproc;
 # ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.13/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.13/drivers/ide/cmd64x.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-05 18:00:56.000000000 +0200
@@ -636,7 +636,7 @@
 
 	if (drive->type != ATA_DISK) {
 		cmdprintk("CMD64X: drive is not a disk at double check, inital check failed!!\n");
-		return ((int) ide_dma_off);
+		return 0;
 	}
 
 	/* UltraDMA only supported on PCI646U and PCI646U2,
@@ -683,16 +683,16 @@
 	config_chipset_for_pio(drive, set_pio);
 
 	if (set_pio)
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	if (cmd64x_tune_chipset(drive, speed))
-		return ((int) ide_dma_off);
+		return 0;
 
-	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	rval = (int)(	((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 
 	return rval;
 }
@@ -725,17 +725,17 @@
 	config_chipset_for_pio(drive, set_pio);
 
 	if (set_pio)
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	if (cmd680_tune_chipset(drive, speed))
-		return ((int) ide_dma_off);
+		return 0;
 
-	rval = (int)(	((id->dma_ultra >> 14) & 3) ? ide_dma_on :
-			((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	rval = (int)(	((id->dma_ultra >> 14) & 3) ? 1 :
+			((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 	return rval;
 }
 
@@ -756,7 +756,8 @@
 	byte can_ultra_66	= 0;
 	byte can_ultra_100	= 0;
 	byte can_ultra_133	= 0;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
@@ -777,23 +778,26 @@
 			can_ultra_100 = 0;
 			break;
 		default:
-			return hwif->udma(ide_dma_off, drive, NULL);
+			udma_enable(drive, 0, 1);
+
+			return 0;
 	}
 
 	if ((id != NULL) && ((id->capability & 1) != 0) &&
 	    hwif->autodma && (drive->type == ATA_DISK)) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if ((id->field_valid & 4) && (can_ultra_33)) {
 			if (id->dma_ultra & 0x007F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, class_rev, can_ultra_66);
+				on = config_chipset_for_dma(drive, class_rev, can_ultra_66);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -801,8 +805,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, class_rev, 0);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, class_rev, 0);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -810,31 +814,28 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, class_rev, 0);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, class_rev, 0);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		config_chipset_for_pio(drive, 1);
 	}
-	return drive->channel->udma(dma_func, drive, NULL);
+
+	udma_enable(drive, on, verbose);
+
+	return 0;
 }
 
-static int cmd680_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int cmd680_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return cmd64x_config_drive_for_dma(drive);
-		default:
-			break;
-	}
-	/* Other cases are done by generic IDE-DMA code. */
-        return ide_dmaproc(func, drive, rq);
+	return cmd64x_config_drive_for_dma(drive);
 }
 
 static int cmd64x_udma_stop(struct ata_device *drive)
@@ -865,33 +866,29 @@
 	return (dma_stat & 7) != 4;		/* verify good DMA status */
 }
 
-static int cmd64x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int cmd64x_udma_irq_status(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	u8 dma_stat = 0;
 	u8 dma_alt_stat	= 0;
-	u8 mask	= (ch->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
 	unsigned long dma_base	= ch->dma_base;
 	struct pci_dev *dev	= ch->pci_dev;
+	u8 mask	= (ch->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
 
-	switch (func) {
-		case ide_dma_check:
-			return cmd64x_config_drive_for_dma(drive);
-		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
-			dma_stat = inb(dma_base+2);
-			(void) pci_read_config_byte(dev, MRDMODE, &dma_alt_stat);
+	dma_stat = inb(dma_base+2);
+	(void) pci_read_config_byte(dev, MRDMODE, &dma_alt_stat);
 #ifdef DEBUG
-			printk("%s: dma_stat: 0x%02x dma_alt_stat: 0x%02x mask: 0x%02x\n", drive->name, dma_stat, dma_alt_stat, mask);
+	printk("%s: dma_stat: 0x%02x dma_alt_stat: 0x%02x mask: 0x%02x\n", drive->name, dma_stat, dma_alt_stat, mask);
 #endif
-			if (!(dma_alt_stat & mask)) {
-				return 0;
-			}
-			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		default:
-			break;
+	if (!(dma_alt_stat & mask)) {
+		return 0;
 	}
-	/* Other cases are done by generic IDE-DMA code. */
-	return ide_dmaproc(func, drive, rq);
+	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
+}
+
+static int cmd64x_dmaproc(struct ata_device *drive)
+{
+	return cmd64x_config_drive_for_dma(drive);
 }
 
 static int cmd646_1_udma_stop(struct ata_device *drive)
@@ -912,19 +909,11 @@
  * ASUS P55T2P4D with CMD646 chipset revision 0x01 requires the old
  * event order for DMA transfers.
  */
-static int cmd646_1_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int cmd646_1_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return cmd64x_config_drive_for_dma(drive);
-		default:
-			break;
-	}
-
-	/* Other cases are done by generic IDE-DMA code. */
-	return ide_dmaproc(func, drive, rq);
+	return cmd64x_config_drive_for_dma(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 static int cmd680_busproc(struct ata_device * drive, int state)
 {
@@ -1136,28 +1125,30 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	switch(dev->device) {
 		case PCI_DEVICE_ID_CMD_680:
-			hwif->busproc	= &cmd680_busproc;
-			hwif->udma	= &cmd680_dmaproc;
-			hwif->resetproc = &cmd680_reset;
-			hwif->speedproc	= &cmd680_tune_chipset;
-			hwif->tuneproc	= &cmd680_tuneproc;
+			hwif->busproc	= cmd680_busproc;
+			hwif->XXX_udma	= cmd680_dmaproc;
+			hwif->resetproc = cmd680_reset;
+			hwif->speedproc	= cmd680_tune_chipset;
+			hwif->tuneproc	= cmd680_tuneproc;
 			break;
 		case PCI_DEVICE_ID_CMD_649:
 		case PCI_DEVICE_ID_CMD_648:
 		case PCI_DEVICE_ID_CMD_643:
 			hwif->udma_stop	= cmd64x_udma_stop;
-			hwif->udma	= cmd64x_dmaproc;
+			hwif->udma_irq_status = cmd64x_udma_irq_status;
+			hwif->XXX_udma	= cmd64x_dmaproc;
 			hwif->tuneproc	= cmd64x_tuneproc;
 			hwif->speedproc = cmd64x_tune_chipset;
 			break;
 		case PCI_DEVICE_ID_CMD_646:
 			hwif->chipset = ide_cmd646;
 			if (class_rev == 0x01) {
-				hwif->udma_stop = &cmd646_1_udma_stop;
-				hwif->udma = &cmd646_1_dmaproc;
+				hwif->udma_stop = cmd646_1_udma_stop;
+				hwif->XXX_udma = cmd646_1_dmaproc;
 			} else {
 				hwif->udma_stop = cmd64x_udma_stop;
-				hwif->udma = cmd64x_dmaproc;
+				hwif->udma_irq_status = cmd64x_udma_irq_status;
+				hwif->XXX_udma = cmd64x_dmaproc;
 			}
 			hwif->tuneproc	= cmd64x_tuneproc;
 			hwif->speedproc	= cmd64x_tune_chipset;
diff -urN linux-2.5.13/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.13/drivers/ide/cs5530.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-05-05 18:01:52.000000000 +0200
@@ -144,7 +144,7 @@
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
-	hwif->udma(ide_dma_off_quietly, drive, NULL);
+	udma_enable(drive, 0, 0);
 	outb(inb(hwif->dma_base+2)&~(unit?0x40:0x20), hwif->dma_base+2); /* clear DMA_capable bit */
 
 	/*
@@ -229,26 +229,16 @@
 	/*
 	 * Finally, turn DMA on in software, and exit.
 	 */
-	return hwif->udma(ide_dma_on, drive, NULL);	/* success */
+	udma_enable(drive, 1, 1);	/* success */
+
+	return 0;
 }
 
-/*
- * This is a CS5530-specific wrapper for the standard ide_dmaproc().
- * We need it for our custom "ide_dma_check" function.
- * All other requests are forwarded to the standard ide_dmaproc().
- */
-int cs5530_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int cs5530_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return cs5530_config_dma(drive);
-		default:
-			break;
-	}
-	/* Other cases are done by generic IDE-DMA code. */
-	return ide_dmaproc(func, drive, rq);
+	return cs5530_config_dma(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * Initialize the cs5530 bridge for reliable IDE DMA operation.
@@ -353,11 +343,11 @@
 		unsigned int basereg, d0_timings;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->udma = cs5530_dmaproc;
+	hwif->XXX_udma = cs5530_dmaproc;
 	hwif->highmem = 1;
 #else
 	hwif->autodma = 0;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 		hwif->tuneproc = &cs5530_tuneproc;
 		basereg = CS5530_BASEREG(hwif);
diff -urN linux-2.5.13/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.13/drivers/ide/cy82c693.c	2002-05-03 02:22:45.000000000 +0200
+++ linux/drivers/ide/cy82c693.c	2002-05-05 18:03:30.000000000 +0200
@@ -8,7 +8,7 @@
  *
  * The CY82C693 chipset is used on Digital's PC-Alpha 164SX boards.
  * Writting the driver was quite simple, since most of the job is
- * done by the generic pci-ide support. 
+ * done by the generic pci-ide support.
  * The hard part was finding the CY82C693's datasheet on Cypress's
  * web page :-(. But Altavista solved this problem :-).
  *
@@ -17,12 +17,12 @@
  * - I recently got a 16.8G IBM DTTA, so I was able to test it with
  *   a large and fast disk - the results look great, so I'd say the
  *   driver is working fine :-)
- *   hdparm -t reports 8.17 MB/sec at about 6% CPU usage for the DTTA 
- * - this is my first linux driver, so there's probably a lot  of room 
+ *   hdparm -t reports 8.17 MB/sec at about 6% CPU usage for the DTTA
+ * - this is my first linux driver, so there's probably a lot  of room
  *   for optimizations and bug fixing, so feel free to do it.
  * - use idebus=xx parameter to set PCI bus speed - needed to calc
  *   timings for PIO modes (default will be 40)
- * - if using PIO mode it's a good idea to set the PIO mode and 
+ * - if using PIO mode it's a good idea to set the PIO mode and
  *   32-bit I/O support (if possible), e.g. hdparm -p2 -c1 /dev/hda
  * - I had some problems with my IBM DHEA with PIO modes < 2
  *   (lost interrupts) ?????
@@ -71,7 +71,7 @@
  * note: the value for busmaster timeout is tricky and i got it by trial and error !
  *       using a to low value will cause DMA timeouts and drop IDE performance
  *       using a to high value will cause audio playback to scatter
- *       if you know a better value or how to calc it, please let me know 
+ *       if you know a better value or how to calc it, please let me know
  */
 #define BUSMASTER_TIMEOUT	0x50	/* twice the value written in cy82c693ub datasheet */
 /*
@@ -81,12 +81,12 @@
 /* here are the offset definitions for the registers */
 #define CY82_IDE_CMDREG		0x04
 #define CY82_IDE_ADDRSETUP	0x48
-#define CY82_IDE_MASTER_IOR	0x4C	
-#define CY82_IDE_MASTER_IOW	0x4D	
-#define CY82_IDE_SLAVE_IOR	0x4E	
+#define CY82_IDE_MASTER_IOR	0x4C
+#define CY82_IDE_MASTER_IOW	0x4D
+#define CY82_IDE_SLAVE_IOR	0x4E
 #define CY82_IDE_SLAVE_IOW	0x4F
-#define CY82_IDE_MASTER_8BIT	0x50	
-#define CY82_IDE_SLAVE_8BIT	0x51	
+#define CY82_IDE_MASTER_8BIT	0x50
+#define CY82_IDE_SLAVE_8BIT	0x51
 
 #define CY82_INDEX_PORT		0x22
 #define CY82_DATA_PORT		0x23
@@ -188,14 +188,14 @@
 
         if (mode>2)	/* make sure we set a valid mode */
 		mode = 2;
-			   
+
 	if (mode > drive->id->tDMA)  /* to be absolutly sure we have a valid mode */
 		mode = drive->id->tDMA;
-	
+
         index = (drive->channel->unit == 0) ? CY82_INDEX_CHANNEL0 : CY82_INDEX_CHANNEL1;
 
 #if CY82C693_DEBUG_LOGS
-       	/* for debug let's show the previous values */
+	/* for debug let's show the previous values */
 
 	OUT_BYTE(index, CY82_INDEX_PORT);
 	data = IN_BYTE(CY82_DATA_PORT);
@@ -212,7 +212,7 @@
 	printk (KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n", drive->name, drive->channel->unit, drive->select.b.unit, mode, single);
 #endif /* CY82C693_DEBUG_INFO */
 
-	/* 
+	/*
 	 * note: below we set the value for Bus Master IDE TimeOut Register
 	 * I'm not absolutly sure what this does, but it solved my problem
 	 * with IDE DMA and sound, so I now can play sound and work with
@@ -226,45 +226,44 @@
 	OUT_BYTE(CY82_INDEX_TIMEOUT, CY82_INDEX_PORT);
 	OUT_BYTE(data, CY82_DATA_PORT);
 
-#if CY82C693_DEBUG_INFO	
+#if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s: Set IDE Bus Master TimeOut Register to 0x%X\n", drive->name, data);
 #endif /* CY82C693_DEBUG_INFO */
 }
 
-/* 
+/*
  * used to set DMA mode for CY82C693 (single and multi modes)
  */
-static int cy82c693_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int cy82c693_dmaproc(struct ata_device *drive)
 {
 	/*
-	 * if the function is dma on, set dma mode for drive everything
-	 * else is done by the defaul func
+	 * Set dma mode for drive everything else is done by the defaul func.
 	 */
-	if (func == ide_dma_on) {
-		struct hd_driveid *id = drive->id;
+	struct hd_driveid *id = drive->id;
 
 #if CY82C693_DEBUG_INFO
-		printk (KERN_INFO "dma_on: %s\n", drive->name);
-#endif /* CY82C693_DEBUG_INFO */
+	printk (KERN_INFO "dma_on: %s\n", drive->name);
+#endif
 
-		if (id != NULL) {
-                       /* Enable DMA on any drive that has DMA (multi or single) enabled */
-                       if (id->field_valid & 2) {       /* regular DMA */
-			       int mmode, smode;
-
-			       mmode = id->dma_mword & (id->dma_mword >> 8);
-			       smode = id->dma_1word & (id->dma_1word >> 8);
-
-		               if (mmode != 0)
-				     cy82c693_dma_enable(drive, (mmode >> 1), 0); /* enable multi */
-			       else if (smode != 0)
-				     cy82c693_dma_enable(drive, (smode >> 1), 1); /* enable single */
-			}
+	if (id != NULL) {
+		/* Enable DMA on any drive that has DMA (multi or single) enabled */
+		if (id->field_valid & 2) {       /* regular DMA */
+			int mmode, smode;
+
+			mmode = id->dma_mword & (id->dma_mword >> 8);
+			smode = id->dma_1word & (id->dma_1word >> 8);
+
+			if (mmode != 0)
+				cy82c693_dma_enable(drive, (mmode >> 1), 0); /* enable multi */
+			else if (smode != 0)
+				cy82c693_dma_enable(drive, (smode >> 1), 1); /* enable single */
 		}
 	}
-        return ide_dmaproc(func, drive, rq);
+	udma_enable(drive, 1, 1);
+
+	return 0;
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * tune ide drive - set PIO mode
@@ -287,14 +286,14 @@
 
 #if CY82C693_DEBUG_LOGS
 	/* for debug let's show the register values */
-	
-       	if (drive->select.b.unit == 0) {
+
+	if (drive->select.b.unit == 0) {
 		/*
-		 * get master drive registers               	
+		 * get master drive registers
 		 * address setup control register
 		 * is 32 bit !!!
-		 */ 
-	  	pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);                
+		 */
+		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
 		addrCtrl &= 0x0F;
 
 		/* now let's get the remaining registers */
@@ -306,7 +305,7 @@
 		 * set slave drive registers
 		 * address setup control register
 		 * is 32 bit !!!
-		 */ 
+		 */
 		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
 
 		addrCtrl &= 0xF0;
@@ -336,9 +335,9 @@
 		 * set master drive
 		 * address setup control register
 		 * is 32 bit !!!
-		 */ 
+		 */
 		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
-		
+
 		addrCtrl &= (~0xF);
 		addrCtrl |= (unsigned int)pclk.address_time;
 		pci_write_config_dword(dev, CY82_IDE_ADDRSETUP, addrCtrl);
@@ -347,14 +346,14 @@
 		pci_write_config_byte(dev, CY82_IDE_MASTER_IOR, pclk.time_16r);
 		pci_write_config_byte(dev, CY82_IDE_MASTER_IOW, pclk.time_16w);
 		pci_write_config_byte(dev, CY82_IDE_MASTER_8BIT, pclk.time_8);
-		
+
 		addrCtrl &= 0xF;
 	} else {
 		/*
 		 * set slave drive
 		 * address setup control register
 		 * is 32 bit !!!
-		 */ 
+		 */
 		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
 
 		addrCtrl &= (~0xF0);
@@ -368,7 +367,7 @@
 
 		addrCtrl >>= 4;
 		addrCtrl &= 0xF;
-	}	
+	}
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s (ch=%d, dev=%d): set PIO timing to (addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n", drive->name, hwif->unit, drive->select.b.unit, addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
@@ -388,14 +387,14 @@
 {
 #ifdef CY82C693_SETDMA_CLOCK
         byte data;
-#endif /* CY82C693_SETDMA_CLOCK */ 
+#endif /* CY82C693_SETDMA_CLOCK */
 
 	/* write info about this verion of the driver */
 	printk (KERN_INFO CY82_VERSION "\n");
 
 #ifdef CY82C693_SETDMA_CLOCK
        /* okay let's set the DMA clock speed */
-        
+
         OUT_BYTE(CY82_INDEX_CTRLREG1, CY82_INDEX_PORT);
         data = IN_BYTE(CY82_DATA_PORT);
 
@@ -406,11 +405,11 @@
         /*
 	 * for some reason sometimes the DMA controller
 	 * speed is set to ATCLK/2 ???? - we fix this here
-	 * 
+	 *
 	 * note: i don't know what causes this strange behaviour,
 	 *       but even changing the dma speed doesn't solve it :-(
-	 *       the ide performance is still only half the normal speed 
-	 * 
+	 *       the ide performance is still only half the normal speed
+	 *
 	 *       if anybody knows what goes wrong with my machine, please
 	 *       let me know - ASK
          */
@@ -442,7 +441,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->udma = cy82c693_dmaproc;
+		hwif->XXX_udma = cy82c693_dmaproc;
 		if (!noautodma)
 			hwif->autodma = 1;
 	}
diff -urN linux-2.5.13/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.13/drivers/ide/hpt34x.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-05 18:05:45.000000000 +0200
@@ -210,7 +210,7 @@
 	byte speed		= 0x00;
 
 	if (drive->type != ATA_DISK)
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	hpt34x_clear_chipset(drive);
 
@@ -237,36 +237,38 @@
 	} else if (id->dma_1word & 0x0001) {
 		speed = XFER_SW_DMA_0;
         } else {
-		return ((int) ide_dma_off_quietly);
+		return 0;
 	}
 
 	(void) hpt34x_tune_chipset(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 11) & 3) ? ide_dma_off :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 11) & 3) ? 0 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
-static int config_drive_xfer_rate(struct ata_device *drive, struct request *rq)
+static int config_drive_xfer_rate(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x0007) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, 1);
+				on = config_chipset_for_dma(drive, 1);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -274,8 +276,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, 0);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, 0);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -283,25 +285,27 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, 0);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, 0);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		config_chipset_for_pio(drive);
 	}
 
 #ifndef CONFIG_HPT34X_AUTODMA
-	if (dma_func == ide_dma_on)
-		dma_func = ide_dma_off;
-#endif /* CONFIG_HPT34X_AUTODMA */
+	if (on)
+		on = 0;
+#endif
+	udma_enable(drive, on, verbose);
 
-	return drive->channel->udma(dma_func, drive, rq);
+	return 0;
 }
 
 static int hpt34x_udma_stop(struct ata_device *drive)
@@ -354,21 +358,13 @@
 }
 
 /*
- * hpt34x_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- *
  * This is specific to the HPT343 UDMA bios-less chipset
  * and HPT345 UDMA bios chipset (stamped HPT363)
  * by HighPoint|Triones Technologies, Inc.
  */
-int hpt34x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int hpt34x_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive, rq);
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	return config_drive_xfer_rate(drive);
 }
 #endif
 
@@ -447,7 +443,7 @@
 		hwif->udma_stop = hpt34x_udma_stop;
 		hwif->udma_read = hpt34x_udma_read;
 		hwif->udma_write = hpt34x_udma_write;
-		hwif->udma = hpt34x_dmaproc;
+		hwif->XXX_udma = hpt34x_dmaproc;
 		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
diff -urN linux-2.5.13/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.13/drivers/ide/hpt366.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-05 18:06:29.000000000 +0200
@@ -661,7 +661,7 @@
 	int  rval;
 
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	if ((id->dma_ultra & 0x0020) &&
 	    (!check_in_drive_lists(drive, bad_ata100_5)) &&
@@ -694,15 +694,15 @@
 	} else if (id->dma_mword & 0x0001) {
 		speed = XFER_MW_DMA_0;
 	} else {
-		return ((int) ide_dma_off_quietly);
+		return 0;
 	}
 
 	(void) hpt3xx_tune_chipset(drive, speed);
 
-	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	rval = (int)(	((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+						     0);
 	return rval;
 }
 
@@ -744,29 +744,31 @@
 static int config_drive_xfer_rate (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x002F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive);
+				on = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
 try_dma_modes:
 			if (id->dma_mword & 0x0007) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -774,60 +776,45 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 
 		config_chipset_for_pio(drive);
 	}
-	return drive->channel->udma(dma_func, drive, NULL);
+	udma_enable(drive, on, verbose);
+
+	return 0;
+}
+
+static void hpt366_udma_irq_lost(struct ata_device *drive)
+{
+	u8 reg50h = 0, reg52h = 0, reg5ah = 0;
+
+	pci_read_config_byte(drive->channel->pci_dev, 0x50, &reg50h);
+	pci_read_config_byte(drive->channel->pci_dev, 0x52, &reg52h);
+	pci_read_config_byte(drive->channel->pci_dev, 0x5a, &reg5ah);
+	printk("%s: (%s)  reg50h=0x%02x, reg52h=0x%02x, reg5ah=0x%02x\n",
+			drive->name, __FUNCTION__, reg50h, reg52h, reg5ah);
+	if (reg5ah & 0x10)
+		pci_write_config_byte(drive->channel->pci_dev, 0x5a, reg5ah & ~0x10);
 }
 
 /*
- * hpt366_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- *
  * This is specific to the HPT366 UDMA bios chipset
  * by HighPoint|Triones Technologies, Inc.
  */
-int hpt366_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int hpt366_dmaproc(struct ata_device *drive)
 {
-	byte reg50h = 0, reg52h = 0, reg5ah = 0, dma_stat = 0;
-	unsigned long dma_base = drive->channel->dma_base;
-
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
-			dma_stat = inb(dma_base+2);
-			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		case ide_dma_lostirq:
-			pci_read_config_byte(drive->channel->pci_dev, 0x50, &reg50h);
-			pci_read_config_byte(drive->channel->pci_dev, 0x52, &reg52h);
-			pci_read_config_byte(drive->channel->pci_dev, 0x5a, &reg5ah);
-			printk("%s: (ide_dma_lostirq)  reg50h=0x%02x, reg52h=0x%02x, reg5ah=0x%02x\n",
-				drive->name, reg50h, reg52h, reg5ah);
-			if (reg5ah & 0x10)
-				pci_write_config_byte(drive->channel->pci_dev, 0x5a, reg5ah & ~0x10);
-			/* fall through to a reset */
-#if 0
-		case ide_dma_begin:
-		case ide_dma_end:
-			/* reset the chips state over and over.. */
-			pci_write_config_byte(drive->channel->pci_dev, 0x51, 0x13);
-#endif
-			break;
-		case ide_dma_timeout:
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	return config_drive_xfer_rate(drive);
 }
 
 static void do_udma_start(struct ata_device *drive)
@@ -879,7 +866,7 @@
 	do_udma_start(drive);
 }
 
-static void hpt370_udma_lost_irq(struct ata_device *drive)
+static void hpt370_udma_irq_lost(struct ata_device *drive)
 {
 	do_timeout_irq(drive);
 	do_udma_start(drive);
@@ -910,42 +897,10 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-int hpt370_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *hwif = drive->channel;
-	unsigned long dma_base = hwif->dma_base;
-	byte regstate = hwif->unit ? 0x54 : 0x50;
-	byte reginfo = hwif->unit ? 0x56 : 0x52;
-	byte dma_stat;
-
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
-			dma_stat = inb(dma_base+2);
-			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-
-		case ide_dma_timeout:
-		case ide_dma_lostirq:
-			pci_read_config_byte(hwif->pci_dev, reginfo, 
-					     &dma_stat); 
-			printk("%s: %d bytes in FIFO\n", drive->name, 
-			       dma_stat);
-			pci_write_config_byte(hwif->pci_dev, regstate, 0x37);
-			udelay(10);
-			dma_stat = inb(dma_base);
-			outb(dma_stat & ~0x1, dma_base); /* stop dma */
-			dma_stat = inb(dma_base + 2); 
-			outb(dma_stat | 0x6, dma_base+2); /* clear errors */
-			/* fallthrough */
-
-			do_udma_start(drive);
-			break;
 
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+static int hpt370_dmaproc(struct ata_device *drive)
+{
+	return config_drive_xfer_rate(drive);
 }
 #endif
 
@@ -1249,9 +1204,12 @@
 				pci_write_config_byte(hwif->pci_dev, 0x5a, reg5ah & ~0x10);
 			hwif->udma_start = hpt370_udma_start;
 			hwif->udma_stop = hpt370_udma_stop;
-			hwif->udma = hpt370_dmaproc;
+			hwif->udma_timeout = hpt370_udma_timeout;
+			hwif->udma_irq_lost = hpt370_udma_irq_lost;
+			hwif->XXX_udma = hpt370_dmaproc;
 		} else {
-			hwif->udma = hpt366_dmaproc;
+			hwif->udma_irq_lost = hpt366_udma_irq_lost;
+			hwif->XXX_udma = hpt366_dmaproc;
 		}
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.13/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.13/drivers/ide/ide.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-05 17:54:40.000000000 +0200
@@ -311,7 +311,7 @@
 
 	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
 		drive->state = 0;
-		drive->channel->udma(ide_dma_on, drive, rq);
+		udma_enable(drive, 1, 1);
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
@@ -364,13 +364,13 @@
 
 	/* check the DMA crc count */
 	if (drive->crc_count) {
-		drive->channel->udma(ide_dma_off_quietly, drive, NULL);
+		udma_enable(drive, 0, 0);
 		if ((drive->channel->speedproc) != NULL)
 		        drive->channel->speedproc(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >= XFER_SW_DMA_0)
-			drive->channel->udma(ide_dma_on, drive, NULL);
+			udma_enable(drive, 1, 1);
 	} else
-		drive->channel->udma(ide_dma_off, drive, NULL);
+		udma_enable(drive, 0, 1);
 }
 
 /*
@@ -1402,18 +1402,11 @@
  */
 static void dma_timeout_retry(struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
-
 	/*
 	 * end current dma transaction
 	 */
-	ch->udma_stop(drive);
-
-	/*
-	 * complain a little, later we might remove some of this verbosity
-	 */
-	printk("%s: timeout waiting for DMA\n", drive->name);
-	ch->udma(ide_dma_timeout, drive, rq);
+	udma_stop(drive);
+	udma_timeout(drive);
 
 	/*
 	 * Disable dma for now, but remember that we did so because of
@@ -1422,7 +1415,7 @@
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	ch->udma(ide_dma_off_quietly, drive, rq);
+	udma_enable(drive, 0, 0);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
@@ -1510,7 +1503,7 @@
 				startstop = handler(drive, ch->hwgroup->rq);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
-					ch->udma(ide_dma_lostirq, drive, ch->hwgroup->rq);
+					udma_irq_lost(drive);
 				(void) ide_ack_intr(ch);
 				printk("%s: lost interrupt\n", drive->name);
 				startstop = handler(drive, ch->hwgroup->rq);
@@ -2126,14 +2119,14 @@
 	ch->ata_write = old.ata_write;
 	ch->atapi_read = old.atapi_read;
 	ch->atapi_write = old.atapi_write;
-	ch->udma = old.udma;
+	ch->XXX_udma = old.XXX_udma;
 	ch->udma_start = old.udma_start;
 	ch->udma_stop = old.udma_stop;
 	ch->udma_read = old.udma_read;
 	ch->udma_write = old.udma_write;
 	ch->udma_irq_status = old.udma_irq_status;
 	ch->udma_timeout = old.udma_timeout;
-	ch->udma_lost_irq = old.udma_lost_irq;
+	ch->udma_irq_lost = old.udma_irq_lost;
 	ch->busproc = old.busproc;
 	ch->bus_state = old.bus_state;
 	ch->dma_base = old.dma_base;
@@ -2409,10 +2402,11 @@
 {
 	if (!drive->driver)
 		return -EPERM;
-	if (!drive->id || !(drive->id->capability & 1) || !drive->channel->udma)
+
+	if (!drive->id || !(drive->id->capability & 1) || !drive->channel->XXX_udma)
 		return -EPERM;
-	if (drive->channel->udma(arg ? ide_dma_on : ide_dma_off, drive, NULL))
-		return -EIO;
+
+	udma_enable(drive, arg, 1);
 	return 0;
 }
 
@@ -3184,7 +3178,7 @@
 	restore_flags(flags);		/* all CPUs */
 	/* FIXME: Check what this magic number is supposed to be about? */
 	if (drive->autotune != 2) {
-		if (drive->channel->udma) {
+		if (drive->channel->XXX_udma) {
 
 			/*
 			 * Force DMAing for the beginning of the check.  Some
@@ -3194,8 +3188,8 @@
 			 *   PARANOIA!!!
 			 */
 
-			drive->channel->udma(ide_dma_off_quietly, drive, NULL);
-			drive->channel->udma(ide_dma_check, drive, NULL);
+			udma_enable(drive, 0, 0);
+			drive->channel->XXX_udma(drive);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 			udma_tcq_enable(drive, 1);
 #endif
diff -urN linux-2.5.13/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.13/drivers/ide/ide-cd.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-05 17:40:50.000000000 +0200
@@ -906,7 +906,7 @@
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = udma_stop(drive)))
-			drive->channel->udma(ide_dma_off, drive, NULL);
+			udma_enable(drive, 0, 1);
 	}
 
 	if (cdrom_decode_status(&startstop, drive, rq, 0, &stat))
@@ -1482,7 +1482,7 @@
 		info->dma = 0;
 		if ((dma_error = udma_stop(drive))) {
 			printk("ide-cd: write dma error\n");
-			drive->channel->udma(ide_dma_off, drive, NULL);
+			udma_enable(drive, 0, 1);
 		}
 	}
 
diff -urN linux-2.5.13/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.13/drivers/ide/ide-disk.c	2002-05-05 07:04:53.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-05 17:39:03.000000000 +0200
@@ -736,7 +736,7 @@
 {
 	if (!drive->driver)
 		return -EPERM;
-	if (!drive->channel->udma)
+	if (!drive->channel->XXX_udma)
 		return -EPERM;
 	if (arg == drive->queue_depth && drive->using_tcq)
 		return 0;
diff -urN linux-2.5.13/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.13/drivers/ide/ide-dma.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-05 18:07:13.000000000 +0200
@@ -326,30 +326,50 @@
 
 	if (id && (id->capability & 1) && ch->autodma && config_allows_dma) {
 		/* Consult the list of known "bad" drives */
-		if (udma_black_list(drive))
-			return ch->udma(ide_dma_off, drive, NULL);
+		if (udma_black_list(drive)) {
+			udma_enable(drive, 0, 1);
+
+			return 0;
+		}
 
 		/* Enable DMA on any drive that has UltraDMA (mode 6/7/?) enabled */
 		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
-			if ((id->dma_ultra & (id->dma_ultra >> 14) & 2))
-				return ch->udma(ide_dma_on, drive, NULL);
+			if ((id->dma_ultra & (id->dma_ultra >> 14) & 2)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
 		/* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */
 		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
-			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7))
-				return ch->udma(ide_dma_on, drive, NULL);
+			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
 		/* Enable DMA on any drive that has UltraDMA (mode 0/1/2) enabled */
 		if (id->field_valid & 4)	/* UltraDMA */
-			if ((id->dma_ultra & (id->dma_ultra >> 8) & 7))
-				return ch->udma(ide_dma_on, drive, NULL);
+			if ((id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
 		/* Enable DMA on any drive that has mode2 DMA (multi or single) enabled */
 		if (id->field_valid & 2)	/* regular DMA */
-			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404)
-				return ch->udma(ide_dma_on, drive, NULL);
+			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404) {
+				udma_enable(drive, 1, 1);
+
+				return 0;
+			}
 		/* Consult the list of known "good" drives */
-		if (udma_white_list(drive))
-			return ch->udma(ide_dma_on, drive, NULL);
+		if (udma_white_list(drive)) {
+			udma_enable(drive, 1, 1);
+
+			return 0;
+		}
 	}
-	return ch->udma(ide_dma_off_quietly, drive, NULL);
+	udma_enable(drive, 0, 0);
+
+	return 0;
 }
 
 /*
@@ -377,20 +397,6 @@
 	return 0;
 }
 
-static void ide_toggle_bounce(struct ata_device *drive, int on)
-{
-	u64 addr = BLK_BOUNCE_HIGH;
-
-	if (on && drive->type == ATA_DISK && drive->channel->highmem) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else
-			addr = drive->channel->pci_dev->dma_mask;
-	}
-
-	blk_queue_bounce_limit(&drive->queue, addr);
-}
-
 int ata_start_dma(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
@@ -427,54 +433,9 @@
  * the caller should revert to PIO for the current request.
  * May also be invoked from trm290.c
  */
-int ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int XXX_ide_dmaproc(struct ata_device *drive)
 {
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	u8 unit = (drive->select.b.unit & 0x01);
-	unsigned int set_high = 1;
-	u8 dma_stat;
-
-	switch (func) {
-		case ide_dma_off:
-			printk("%s: DMA disabled\n", drive->name);
-		case ide_dma_off_quietly:
-			set_high = 0;
-			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-			udma_tcq_enable(drive, 0);
-#endif
-		case ide_dma_on:
-			ide_toggle_bounce(drive, set_high);
-			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma) {
-				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-				udma_tcq_enable(drive, 1);
-#endif
-			}
-			return 0;
-		case ide_dma_check:
-			return config_drive_for_dma (drive);
-		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
-			dma_stat = inb(dma_base+2);
-#if 0  /* do not set unless you know what you are doing */
-			if (dma_stat & 4) {
-				u8 stat = GET_STAT();
-				outb(dma_base+2, dma_stat & 0xE4);
-			}
-#endif
-			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		case ide_dma_timeout:
-			printk(KERN_ERR "%s: DMA timeout occured!\n", __FUNCTION__);
-			return 1;
-		case ide_dma_lostirq:
-			printk(KERN_ERR "%s: chipset supported func only: %d\n", __FUNCTION__,  func);
-			return 1;
-		default:
-			printk(KERN_ERR "%s: unsupported func: %d\n", __FUNCTION__, func);
-			return 1;
-	}
+	return config_drive_for_dma(drive);
 }
 
 /*
@@ -528,7 +489,7 @@
 		goto dma_alloc_failure;
 	}
 
-	ch->udma = ide_dmaproc;
+	ch->XXX_udma = XXX_ide_dmaproc;
 
 	if (ch->chipset != ide_trm290) {
 		u8 dma_stat = inb(dma_base+2);
@@ -874,10 +835,10 @@
 
 }
 
-void udma_lost_irq(struct ata_device *drive)
+void udma_irq_lost(struct ata_device *drive)
 {
-	if (drive->channel->udma_lost_irq)
-		drive->channel->udma_lost_irq(drive);
+	if (drive->channel->udma_irq_lost)
+		drive->channel->udma_irq_lost(drive);
 }
 
 EXPORT_SYMBOL(udma_enable);
diff -urN linux-2.5.13/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.13/drivers/ide/ide-floppy.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-05-05 17:43:37.000000000 +0200
@@ -944,10 +944,11 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk (KERN_ERR "ide-floppy: The floppy wants to issue more interrupts in DMA mode\n");
-		drive->channel->udma(ide_dma_off, drive, NULL);
+		udma_enable(drive, 0, 1);
+
 		return ide_stopped;
 	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 	bcount.b.high=IN_BYTE (IDE_BCOUNTH_REG);			/* Get the number of bytes to transfer */
 	bcount.b.low=IN_BYTE (IDE_BCOUNTL_REG);			/* on this interrupt */
 	ireason.all=IN_BYTE (IDE_IREASON_REG);
@@ -1119,9 +1120,9 @@
 	bcount.all = min(pc->request_transfer, 63 * 1024);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (test_and_clear_bit (PC_DMA_ERROR, &pc->flags)) {
-		(void) drive->channel->udma(ide_dma_off, drive, NULL);
-	}
+	if (test_and_clear_bit (PC_DMA_ERROR, &pc->flags))
+		udma_enable(drive, 0, 1);
+
 	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
 		if (test_bit (PC_WRITING, &pc->flags))
 			dma_ok = !udma_write(drive, rq);
diff -urN linux-2.5.13/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.13/drivers/ide/ide-tape.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-05 17:41:55.000000000 +0200
@@ -2132,7 +2132,8 @@
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk (KERN_ERR "ide-tape: The tape wants to issue more interrupts in DMA mode\n");
 		printk (KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
-		drive->channel->udma(ide_dma_off, drive, NULL);
+		udma_enable(drive, 0, 1);
+
 		return ide_stopped;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -2309,7 +2310,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_and_clear_bit (PC_DMA_ERROR, &pc->flags)) {
 		printk (KERN_WARNING "ide-tape: DMA disabled, reverting to PIO\n");
-		(void) drive->channel->udma(ide_dma_off, drive, NULL);
+		udma_enable(drive, 0, 1);
 	}
 	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
 		if (test_bit (PC_WRITING, &pc->flags))
diff -urN linux-2.5.13/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.13/drivers/ide/ide-taskfile.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-05 15:08:48.000000000 +0200
@@ -260,7 +260,7 @@
 {
 	byte stat = 0;
 	if (drive->waiting_for_dma)
-		return drive->channel->udma(ide_dma_test_irq, drive, NULL);
+		return udma_irq_status(drive);
 #if 0
 	/* need to guarantee 400ns since last command was issued */
 	udelay(1);
diff -urN linux-2.5.13/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.13/drivers/ide/ns87415.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-05-05 18:08:31.000000000 +0200
@@ -123,18 +123,16 @@
 	return 1;
 }
 
-static int ns87415_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int ns87415_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			if (drive->type != ATA_DISK)
-				return ide_dmaproc(ide_dma_off_quietly, drive, rq);
-			/* Fallthrough... */
-		default:
-			return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	if (drive->type != ATA_DISK) {
+		udma_enable(drive, 0, 0);
+
+		return 0;
 	}
+	return XXX_ide_dmaproc(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 void __init ide_init_ns87415(struct ata_channel *hwif)
 {
@@ -233,7 +231,7 @@
 		hwif->udma_stop = ns87415_udma_stop;
 		hwif->udma_read = ns87415_udma_read;
 		hwif->udma_write = ns87415_udma_write;
-		hwif->udma = ns87415_dmaproc;
+		hwif->XXX_udma = ns87415_dmaproc;
 	}
 #endif
 
diff -urN linux-2.5.13/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.13/drivers/ide/pdc202xx.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-05 18:10:02.000000000 +0200
@@ -829,7 +829,7 @@
 
 	if (jumpbit) {
 		if (drive->type != ATA_DISK)
-			return ide_dma_off_quietly;
+			return 0;
 		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
 			OUT_BYTE((iordy + adj), indexreg);
 			OUT_BYTE((IN_BYTE(datareg)|0x03), datareg);
@@ -873,13 +873,13 @@
 				pci_write_config_byte(dev, (drive_pci), test2|SYNC_ERRDY_EN);
 			break;
 		default:
-			return ide_dma_off;
+			return 0;
 	}
 
 chipset_is_set:
 
 	if (drive->type != ATA_DISK)
-		return ide_dma_off_quietly;
+		return 0;
 
 	pci_read_config_byte(dev, (drive_pci), &AP);
 	if (id->capability & 4)	/* IORDY_EN */
@@ -907,39 +907,41 @@
 		/* restore original pci-config space */
 		if (!jumpbit)
 			pci_write_config_dword(dev, drive_pci, drive_conf);
-		return ide_dma_off_quietly;
+		return 0;
 	}
 
 	outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 	(void) hwif->speedproc(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 14) & 3) ? ide_dma_on :
-			((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 14) & 3) ? 1 :
+			((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
 static int config_drive_xfer_rate (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	struct ata_channel *hwif = drive->channel;
-	ide_dma_action_t dma_func = ide_dma_off_quietly;
+	int on = 0;
+	int verbose = 1;
 
 	if (id && (id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x007F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, 1);
+				on = config_chipset_for_dma(drive, 1);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -947,8 +949,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, 0);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, 0);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -956,20 +958,23 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, 0);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, 0);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		(void) config_chipset_for_pio(drive, 5);
 	}
 
-	return drive->channel->udma(dma_func, drive, NULL);
+	udma_enable(drive, on, verbose);
+
+	return 0;
 }
 
 int pdc202xx_quirkproc (ide_drive_t *drive)
@@ -1065,20 +1070,17 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-/*
- * pdc202xx_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- */
-int pdc202xx_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int pdc202xx_udma_irq_status(struct ata_device *drive)
 {
-	u8 dma_stat	= 0;
-	u8 sc1d		= 0;
-	u8 newchip	= 0;
-	u8 clock	= 0;
+	struct ata_channel *ch = drive->channel;
+	u8 dma_stat = 0;
+	u8 sc1d	= 0;
+	u8 newchip = 0;
+	u8 clock = 0;
 	u8 hardware48hack = 0;
-	struct ata_channel *hwif = drive->channel;
-	struct pci_dev *dev	= hwif->pci_dev;
-	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long dma_base	= hwif->dma_base;
+	struct pci_dev *dev = ch->pci_dev;
+	unsigned long high_16 = pci_resource_start(dev, 4);
+	unsigned long dma_base = ch->dma_base;
 
 	switch (dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20275:
@@ -1097,36 +1099,45 @@
 			break;
 	}
 
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
-			dma_stat = IN_BYTE(dma_base+2);
-			if (newchip)
-				return (dma_stat & 4) == 4;
-
-			sc1d = IN_BYTE(high_16 + 0x001d);
-			if (drive->channel->unit) {
-				if ((sc1d & 0x50) == 0x50) goto somebody_else;
-				else if ((sc1d & 0x40) == 0x40)
-					return (dma_stat & 4) == 4;
-			} else {
-				if ((sc1d & 0x05) == 0x05) goto somebody_else;
-				else if ((sc1d & 0x04) == 0x04)
-					return (dma_stat & 4) == 4;
-			}
-somebody_else:
-			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		case ide_dma_lostirq:
-		case ide_dma_timeout:
-			if (drive->channel->resetproc != NULL)
-				drive->channel->resetproc(drive);
-		default:
-			break;
+	dma_stat = IN_BYTE(dma_base + 2);
+	if (newchip)
+		return (dma_stat & 4) == 4;
+
+	sc1d = IN_BYTE(high_16 + 0x001d);
+	if (ch->unit) {
+		if ((sc1d & 0x50) == 0x50) goto somebody_else;
+		else if ((sc1d & 0x40) == 0x40)
+			return (dma_stat & 4) == 4;
+	} else {
+		if ((sc1d & 0x05) == 0x05) goto somebody_else;
+		else if ((sc1d & 0x04) == 0x04)
+			return (dma_stat & 4) == 4;
 	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+somebody_else:
+	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+
+static void pdc202xx_udma_timeout(struct ata_device *drive)
+{
+	if (!drive->channel->resetproc)
+		return;
+	/* Assume naively that resetting the drive may help. */
+	drive->channel->resetproc(drive);
+}
+
+static void pdc202xx_udma_irq_lost(struct ata_device *drive)
+{
+	if (!drive->channel->resetproc)
+		return;
+	/* Assume naively that resetting the drive may help. */
+	drive->channel->resetproc(drive);
+}
+
+static int pdc202xx_dmaproc(struct ata_device *drive)
+{
+	return config_drive_xfer_rate(drive);
+}
+#endif
 
 void pdc202xx_new_reset (ide_drive_t *drive)
 {
@@ -1334,7 +1345,10 @@
 	if (hwif->dma_base) {
 		hwif->udma_start = pdc202xx_udma_start;
 		hwif->udma_stop = pdc202xx_udma_stop;
-		hwif->udma = pdc202xx_dmaproc;
+		hwif->udma_irq_status = pdc202xx_udma_irq_status;
+		hwif->udma_irq_lost = pdc202xx_udma_irq_lost;
+		hwif->udma_timeout = pdc202xx_udma_timeout;
+		hwif->XXX_udma = pdc202xx_dmaproc;
 		hwif->highmem = 1;
 		if (!noautodma)
 			hwif->autodma = 1;
diff -urN linux-2.5.13/drivers/ide/pdcadma.c linux/drivers/ide/pdcadma.c
--- linux-2.5.13/drivers/ide/pdcadma.c	2002-05-03 02:22:45.000000000 +0200
+++ linux/drivers/ide/pdcadma.c	2002-05-05 18:10:46.000000000 +0200
@@ -58,15 +58,11 @@
 /*
  * This initiates/aborts (U)DMA read/write operations on a drive.
  */
-int pdcadma_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int pdcadma_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			func = ide_dma_off_quietly;
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	udma_enable(drive, 0, 0);
+
+	return 0;
 }
 #endif
 
@@ -96,7 +92,7 @@
 //	hwif->speedproc = &pdcadma_tune_chipset;
 
 //	if (hwif->dma_base) {
-//		hwif->dmaproc = &pdcadma_dmaproc;
+//		hwif->XXX_dmaproc = &pdcadma_dmaproc;
 //		hwif->autodma = 1;
 //	}
 }
diff -urN linux-2.5.13/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.13/drivers/ide/piix.c	2002-05-03 02:22:50.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-05-05 18:12:04.000000000 +0200
@@ -376,38 +376,26 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
-/*
- * piix_dmaproc() is a callback from upper layers that can do
- * a lot, but we use it for DMA/PIO tuning only, delegating everything
- * else to the default ide_dmaproc().
- */
-
-int piix_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int piix_dmaproc(struct ata_device *drive)
 {
+	short w80 = drive->channel->udma_four;
 
-	if (func == ide_dma_check) {
-
-		short w80 = drive->channel->udma_four;
-
-		short speed = ata_timing_mode(drive,
-			XFER_PIO | XFER_EPIO | 
+	short speed = ata_timing_mode(drive,
+			XFER_PIO | XFER_EPIO |
 			(piix_config->flags & PIIX_NODMA ? 0 : (XFER_SWDMA | XFER_MWDMA |
 			(piix_config->flags & PIIX_UDMA ? XFER_UDMA : 0) |
 			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 ? XFER_UDMA_66 : 0) |
 			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0) |
 			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_133 ? XFER_UDMA_133 : 0))));
 
-		piix_set_drive(drive, speed);
+	piix_set_drive(drive, speed);
 
-		func = (drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO)
-			? ide_dma_on : ide_dma_off_quietly;
+	udma_enable(drive, drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO, 0);
 
-	}
-
-	return ide_dmaproc(func, drive, rq);
+	return 0;
 }
 
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * The initialization callback. Here we determine the IDE chip type
@@ -566,13 +554,13 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->udma = piix_dmaproc;
-#ifdef CONFIG_IDEDMA_AUTO
+		hwif->XXX_udma = piix_dmaproc;
+# ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
-#endif
+# endif
 	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 }
 
 /*
diff -urN linux-2.5.13/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.13/drivers/ide/serverworks.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-05 18:09:24.000000000 +0200
@@ -424,31 +424,33 @@
 
 	(void) svwks_tune_chipset(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
 static int config_drive_xfer_rate(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
-	ide_dma_action_t dma_func = ide_dma_on;
+	int on = 1;
+	int verbose = 1;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive);
+				on = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -456,8 +458,8 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if (udma_white_list(drive)) {
@@ -465,19 +467,23 @@
 				goto no_dma_set;
 			}
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		config_chipset_for_pio(drive);
 	}
-	return drive->channel->udma(dma_func, drive, NULL);
+
+	udma_enable(drive, on, verbose);
+
+	return 0;
 }
 
 static int svwks_udma_stop(struct ata_device *drive)
@@ -523,18 +529,11 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-static int svwks_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int svwks_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
-		default:
-			break;
-	}
-	/* Other cases are done by generic IDE-DMA code. */
-	return ide_dmaproc(func, drive, rq);
+	return config_drive_xfer_rate(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 unsigned int __init pci_init_svwks(struct pci_dev *dev)
 {
@@ -655,7 +654,7 @@
 			hwif->autodma = 1;
 #endif
 		hwif->udma_stop = svwks_udma_stop;
-		hwif->udma = svwks_dmaproc;
+		hwif->XXX_udma = svwks_dmaproc;
 		hwif->highmem = 1;
 	} else {
 		hwif->autodma = 0;
diff -urN linux-2.5.13/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.13/drivers/ide/sis5513.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-05-05 18:12:55.000000000 +0200
@@ -556,7 +556,7 @@
 		case 1:		drive_pci = 0x42; break;
 		case 2:		drive_pci = 0x44; break;
 		case 3:		drive_pci = 0x46; break;
-		default:	return ide_dma_off;
+		default:	return 0;
 	}
 
 #ifdef BROKEN_LEVEL
@@ -663,39 +663,41 @@
 	else if (id->dma_1word & 0x0001)
 		speed = XFER_SW_DMA_0;
 	else
-		return ((int) ide_dma_off_quietly);
+		return 0;
 
 	outb(inb(hwif->dma_base+2)|(1<<(5+unit)), hwif->dma_base+2);
 
 	sis5513_tune_chipset(drive, speed);
 
-	return ((int)	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-			((id->dma_mword >> 8) & 7) ? ide_dma_on :
-			((id->dma_1word >> 8) & 7) ? ide_dma_on :
-						     ide_dma_off_quietly);
+	return ((int)	((id->dma_ultra >> 11) & 7) ? 1 :
+			((id->dma_ultra >> 8) & 7) ? 1 :
+			((id->dma_mword >> 8) & 7) ? 1 :
+			((id->dma_1word >> 8) & 7) ? 1 :
+						     0);
 }
 
 static int config_drive_xfer_rate (ide_drive_t *drive)
 {
-	struct hd_driveid *id		= drive->id;
-	ide_dma_action_t dma_func	= ide_dma_off_quietly;
+	struct hd_driveid *id = drive->id;
+	int on = 0;
+	int verbose = 1;
 
 	config_chipset_for_pio(drive, 5);
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			goto fast_ata_pio;
 		}
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
-				dma_func = config_chipset_for_dma(drive, 1);
+				on = config_chipset_for_dma(drive, 1);
 				if ((id->field_valid & 2) &&
-				    (dma_func != ide_dma_on))
+				    (!on))
 					goto try_dma_modes;
 			}
 		} else if (id->field_valid & 2) {
@@ -703,43 +705,40 @@
 			if ((id->dma_mword & 0x0007) ||
 			    (id->dma_1word & 0x0007)) {
 				/* Force if Capable regular DMA modes */
-				dma_func = config_chipset_for_dma(drive, 0);
-				if (dma_func != ide_dma_on)
+				on = config_chipset_for_dma(drive, 0);
+				if (!on)
 					goto no_dma_set;
 			}
 		} else if ((udma_white_list(drive)) &&
 			   (id->eide_dma_time > 150)) {
 			/* Consult the list of known "good" drives */
-			dma_func = config_chipset_for_dma(drive, 0);
-			if (dma_func != ide_dma_on)
+			on = config_chipset_for_dma(drive, 0);
+			if (!on)
 				goto no_dma_set;
 		} else {
 			goto fast_ata_pio;
 		}
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		dma_func = ide_dma_off_quietly;
+		on = 0;
+		verbose = 0;
 no_dma_set:
 		(void) config_chipset_for_pio(drive, 5);
 	}
 
-	return drive->channel->udma(dma_func, drive, NULL);
+	udma_enable(drive, on, verbose);
+
+	return 0;
 }
 
-/* initiates/aborts (U)DMA read/write operations on a drive. */
-int sis5513_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int sis5513_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-		case ide_dma_check:
-			config_drive_art_rwp(drive);
-			config_art_rwp_pio(drive, 5);
-			return config_drive_xfer_rate(drive);
-		default:
-			break;
-	}
-	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+	config_drive_art_rwp(drive);
+	config_art_rwp_pio(drive, 5);
+
+	return config_drive_xfer_rate(drive);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /* Chip detection and general config */
 unsigned int __init pci_init_sis5513(struct pci_dev *dev)
@@ -852,7 +851,7 @@
 		if (chipset_family > ATA_16) {
 			hwif->autodma = noautodma ? 0 : 1;
 			hwif->highmem = 1;
-			hwif->udma = sis5513_dmaproc;
+			hwif->XXX_udma = sis5513_dmaproc;
 		} else {
 #endif
 			hwif->autodma = 0;
diff -urN linux-2.5.13/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.13/drivers/ide/sl82c105.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-05-05 18:13:41.000000000 +0200
@@ -114,9 +114,9 @@
  * Check to see if the drive and
  * chipset is capable of DMA mode
  */
-static int sl82c105_check_drive(ide_drive_t *drive, struct request *rq)
+static int sl82c105_check_drive(ide_drive_t *drive)
 {
-	ide_dma_action_t dma_func = ide_dma_off_quietly;
+	int on = 0;
 
 	do {
 		struct hd_driveid *id = drive->id;
@@ -130,45 +130,38 @@
 
 		/* Consult the list of known "bad" drives */
 		if (udma_black_list(drive)) {
-			dma_func = ide_dma_off;
+			on = 0;
 			break;
 		}
 
 		if (id->field_valid & 2) {
 			if  (id->dma_mword & 7 || id->dma_1word & 7)
-				dma_func = ide_dma_on;
+				on = 1;
 			break;
 		}
 
 		if (udma_white_list(drive)) {
-			dma_func = ide_dma_on;
+			on = 1;
 			break;
 		}
 	} while (0);
+	if (on)
+		config_for_dma(drive);
+	else
+		config_for_pio(drive, 4, 0);
+
+	udma_enable(drive, on, 0);
+
 
-	return drive->channel->udma(dma_func, drive, rq);
+	return 0;
 }
 
 /*
  * Our own dmaproc, only to intercept ide_dma_check
  */
-static int sl82c105_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int sl82c105_dmaproc(struct ata_device *drive)
 {
-	switch (func) {
-	case ide_dma_check:
-		return sl82c105_check_drive(drive, rq);
-	case ide_dma_on:
-		if (config_for_dma(drive))
-			func = ide_dma_off;
-		/* fall through */
-	case ide_dma_off_quietly:
-	case ide_dma_off:
-		config_for_pio(drive, 4, 0);
-		break;
-	default:
-		break;
-	}
-	return ide_dmaproc(func, drive, rq);
+	return sl82c105_check_drive(drive);
 }
 
 /*
@@ -252,10 +245,10 @@
 	}
 	outb(dma_state, dma_base + 2);
 
-	hwif->udma = NULL;
+	hwif->XXX_udma = NULL;
 	ide_setup_dma(hwif, dma_base, 8);
-	if (hwif->udma)
-		hwif->udma = sl82c105_dmaproc;
+	if (hwif->XXX_udma)
+		hwif->XXX_udma = sl82c105_dmaproc;
 }
 
 /*
diff -urN linux-2.5.13/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.13/drivers/ide/trm290.c	2002-05-05 07:13:21.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-05-05 18:14:33.000000000 +0200
@@ -235,18 +235,14 @@
 	return do_udma(0, drive, rq);
 }
 
-static int trm290_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int trm290_udma_irq_status(struct ata_device *drive)
 {
-	struct ata_channel *ch = drive->channel;
+	return (inw(drive->channel->dma_base + 2) == 0x00ff);
+}
 
-	switch (func) {
-		case ide_dma_test_irq:
-			return (inw(ch->dma_base + 2) == 0x00ff);
-		default:
-			return ide_dmaproc(func, drive, rq);
-	}
-	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
-	return 1;
+static int trm290_dmaproc(struct ata_device *drive)
+{
+	return XXX_ide_dmaproc(drive);
 }
 #endif
 
@@ -304,7 +300,8 @@
 	hwif->udma_stop = trm290_udma_stop;
 	hwif->udma_read = trm290_udma_read;
 	hwif->udma_write = trm290_udma_write;
-	hwif->udma = trm290_dmaproc;
+	hwif->udma_irq_status = trm290_udma_irq_status;
+	hwif->XXX_udma = trm290_dmaproc;
 #endif
 
 	hwif->selectproc = &trm290_selectproc;
diff -urN linux-2.5.13/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.13/drivers/ide/via82cxxx.c	2002-05-03 02:22:47.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-05-05 18:15:37.000000000 +0200
@@ -356,37 +356,24 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-
-/*
- * via82cxxx_dmaproc() is a callback from upper layers that can do
- * a lot, but we use it for DMA/PIO tuning only, delegating everything
- * else to the default ide_dmaproc().
- */
-
-int via82cxxx_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+static int via82cxxx_dmaproc(struct ata_device *drive)
 {
+	short w80 = drive->channel->udma_four;
 
-	if (func == ide_dma_check) {
-
-		short w80 = drive->channel->udma_four;
-
-		short speed = ata_timing_mode(drive,
+	short speed = ata_timing_mode(drive,
 			XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
 			(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
 			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
 			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
 			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
 
-		via_set_drive(drive, speed);
+	via_set_drive(drive, speed);
 
-		func = (drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO)
-			? ide_dma_on : ide_dma_off_quietly;
-	}
+	udma_enable(drive, drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO, 0);
 
-	return ide_dmaproc(func, drive, rq);
+	return 0;
 }
-
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * The initialization callback. Here we determine the IDE chip type
@@ -546,13 +533,13 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
-		hwif->udma = &via82cxxx_dmaproc;
-#ifdef CONFIG_IDEDMA_AUTO
+		hwif->XXX_udma = &via82cxxx_dmaproc;
+# ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
-#endif
+# endif
 	}
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 }
 
 /*
diff -urN linux-2.5.13/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.13/include/linux/ide.h	2002-05-05 07:13:21.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-05 17:54:04.000000000 +0200
@@ -374,15 +374,6 @@
 	int		max_depth;
 } ide_drive_t;
 
-typedef enum {
-	ide_dma_check,
-	ide_dma_on, ide_dma_off,
-	ide_dma_off_quietly,
-	ide_dma_test_irq,
-	ide_dma_lostirq,
-	ide_dma_timeout
-} ide_dma_action_t;
-
 enum {
 	ATA_PRIMARY	= 0,
 	ATA_SECONDARY	= 1
@@ -432,7 +423,7 @@
 	void (*atapi_read)(struct ata_device *, void *, unsigned int);
 	void (*atapi_write)(struct ata_device *, void *, unsigned int);
 
-	int (*udma)(ide_dma_action_t, struct ata_device *, struct request *);
+	int (*XXX_udma)(struct ata_device *);
 
 	int (*udma_start) (struct ata_device *, struct request *rq);
 	int (*udma_stop) (struct ata_device *);
@@ -443,7 +434,7 @@
 	int (*udma_irq_status) (struct ata_device *);
 
 	void (*udma_timeout) (struct ata_device *);
-	void (*udma_lost_irq) (struct ata_device *);
+	void (*udma_irq_lost) (struct ata_device *);
 
 	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
 	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
@@ -885,7 +876,7 @@
 extern int udma_black_list(struct ata_device *);
 extern int udma_white_list(struct ata_device *);
 extern void udma_timeout(struct ata_device *);
-extern void udma_lost_irq(struct ata_device *);
+extern void udma_irq_lost(struct ata_device *);
 extern int udma_start(struct ata_device *, struct request *rq);
 extern int udma_stop(struct ata_device *);
 extern int udma_read(struct ata_device *, struct request *rq);
@@ -899,7 +890,7 @@
 
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 extern int check_drive_lists(struct ata_device *, int good_bad);
-extern int ide_dmaproc(ide_dma_action_t func, struct ata_device *, struct request *);
+extern int XXX_ide_dmaproc(struct ata_device *);
 extern void ide_release_dma(struct ata_channel *);
 extern void ide_setup_dma(struct ata_channel *,	unsigned long, unsigned int) __init;
 extern int ata_start_dma(struct ata_device *, struct request *rq);

--------------040906080502080705040302--

