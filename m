Return-Path: <linux-kernel-owner+w=401wt.eu-S1030494AbXALEY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbXALEY4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbXALEYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030514AbXALEYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:24:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=dF1Hb0w0IUdzUKBmRxLL54k9YZ677xBi/9IAgtTdyEtEsgzasOuJHacnrgVEqwZ+toQVFuYE5Yk+IsmWljLMkrWw6FL5w6rU9x+6kVQi2UrzGymRlpd8c1ExHK8y935Bl86c7JeicTTSCvPVrIV/ozLM31Vy7uRsInh3WpBLo48=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:28:00 +0100
Message-Id: <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: add ide_use_fast_pio() helper

* add ide_use_fast_pio() helper for use by host drivers
* add DMA capability and autodma checks to ide_use_dma()
  - au1xxx-ide/it8213/it821x drivers didn't check for (id->capability & 1)
  - ide-cris driver didn't set ->autodma

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/cris/ide-cris.c    |   12 +++++-------
 drivers/ide/ide-dma.c          |    3 +++
 drivers/ide/ide-lib.c          |   15 +++++++++++++++
 drivers/ide/pci/aec62xx.c      |   14 +++-----------
 drivers/ide/pci/atiixp.c       |   14 +++-----------
 drivers/ide/pci/cmd64x.c       |   14 +++-----------
 drivers/ide/pci/cs5535.c       |   13 +++----------
 drivers/ide/pci/hpt34x.c       |   16 ++++------------
 drivers/ide/pci/hpt366.c       |   11 +++--------
 drivers/ide/pci/pdc202xx_new.c |   12 +++---------
 drivers/ide/pci/pdc202xx_old.c |   14 +++-----------
 drivers/ide/pci/piix.c         |   12 +++---------
 drivers/ide/pci/serverworks.c  |   14 +++-----------
 drivers/ide/pci/siimage.c      |   14 +++-----------
 drivers/ide/pci/sis5513.c      |   14 +++-----------
 drivers/ide/pci/slc90e66.c     |   12 +++---------
 drivers/ide/pci/tc86c001.c     |   12 +++---------
 drivers/ide/pci/triflex.c      |    9 ++-------
 include/linux/ide.h            |    1 +
 19 files changed, 69 insertions(+), 157 deletions(-)

Index: a/drivers/ide/cris/ide-cris.c
===================================================================
--- a.orig/drivers/ide/cris/ide-cris.c
+++ a/drivers/ide/cris/ide-cris.c
@@ -821,6 +821,9 @@ init_e100_ide (void)
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
 		hwif->swdma_mask = 0x07; /* Singleword DMA 0-2 */
+		hwif->autodma = 1;
+		hwif->drives[0].autodma = 1;
+		hwif->drives[1].autodma = 1;
 	}
 
 	/* Reset pulse */
@@ -1046,14 +1049,9 @@ static ide_startstop_t cris_dma_intr (id
 static int cris_dma_check(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	struct hd_driveid* id = drive->id;
 
-	if (id && (id->capability & 1)) {
-		if (ide_use_dma(drive)) {
-			if (cris_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-	}
+	if (ide_use_dma(drive) && cris_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
 	return hwif->ide_dma_off_quietly(drive);
 }
Index: a/drivers/ide/ide-dma.c
===================================================================
--- a.orig/drivers/ide/ide-dma.c
+++ a/drivers/ide/ide-dma.c
@@ -680,6 +680,9 @@ int ide_use_dma(ide_drive_t *drive)
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = drive->hwif;
 
+	if ((id->capability & 1) == 0 || drive->autodma == 0)
+		return 0;
+
 	/* consult the list of known "bad" drives */
 	if (__ide_dma_bad_drive(drive))
 		return 0;
Index: a/drivers/ide/ide-lib.c
===================================================================
--- a.orig/drivers/ide/ide-lib.c
+++ a/drivers/ide/ide-lib.c
@@ -205,6 +205,21 @@ int ide_dma_enable (ide_drive_t *drive)
 
 EXPORT_SYMBOL(ide_dma_enable);
 
+int ide_use_fast_pio(ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+
+	if ((id->capability & 1) && drive->autodma)
+		return 1;
+
+	if ((id->capability & 8) || (id->field_valid & 2))
+		return 1;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ide_use_fast_pio);
+
 /*
  * Standard (generic) timings for PIO modes, from ATA2 specification.
  * These timings are for access to the IDE data port register *only*.
Index: a/drivers/ide/pci/aec62xx.c
===================================================================
--- a.orig/drivers/ide/pci/aec62xx.c
+++ a/drivers/ide/pci/aec62xx.c
@@ -210,19 +210,11 @@ static void aec62xx_tune_drive (ide_driv
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		aec62xx_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/atiixp.c
===================================================================
--- a.orig/drivers/ide/pci/atiixp.c
+++ a/drivers/ide/pci/atiixp.c
@@ -256,22 +256,14 @@ static int atiixp_config_drive_for_dma(i
 static int atiixp_dma_check(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 	u8 tspeed, speed;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && atiixp_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (atiixp_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
 		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
 		hwif->speedproc(drive, speed);
Index: a/drivers/ide/pci/cmd64x.c
===================================================================
--- a.orig/drivers/ide/pci/cmd64x.c
+++ a/drivers/ide/pci/cmd64x.c
@@ -475,19 +475,11 @@ static int config_chipset_for_dma (ide_d
 static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
-	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/cs5535.c
===================================================================
--- a.orig/drivers/ide/pci/cs5535.c
+++ a/drivers/ide/pci/cs5535.c
@@ -196,21 +196,14 @@ static int cs5535_config_drive_for_dma(i
 static int cs5535_dma_check(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= drive->hwif;
-	struct hd_driveid *id	= drive->id;
 	u8 speed;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
-		if (ide_use_dma(drive)) {
-			if (cs5535_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+	if (ide_use_dma(drive) && cs5535_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
 		cs5535_set_drive(drive, speed);
 		return hwif->ide_dma_off_quietly(drive);
Index: a/drivers/ide/pci/hpt34x.c
===================================================================
--- a.orig/drivers/ide/pci/hpt34x.c
+++ a/drivers/ide/pci/hpt34x.c
@@ -125,25 +125,17 @@ static int config_chipset_for_dma (ide_d
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
-
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 #ifndef CONFIG_HPT34X_AUTODMA
-				return hwif->ide_dma_off_quietly(drive);
+		return hwif->ide_dma_off_quietly(drive);
 #else
-				return hwif->ide_dma_on(drive);
+		return hwif->ide_dma_on(drive);
 #endif
-		}
-
-		goto fast_ata_pio;
 
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		hpt34x_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/hpt366.c
===================================================================
--- a.orig/drivers/ide/pci/hpt366.c
+++ a/drivers/ide/pci/hpt366.c
@@ -737,18 +737,13 @@ static void hpt3xx_maskproc(ide_drive_t 
 static int hpt366_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
-		if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		hpt3xx_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_new.c
+++ a/drivers/ide/pci/pdc202xx_new.c
@@ -282,19 +282,13 @@ static int config_chipset_for_dma(ide_dr
 static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		hwif->tuneproc(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_old.c
+++ a/drivers/ide/pci/pdc202xx_old.c
@@ -333,21 +333,13 @@ chipset_is_set:
 static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/piix.c
===================================================================
--- a.orig/drivers/ide/pci/piix.c
+++ a/drivers/ide/pci/piix.c
@@ -387,19 +387,13 @@ static int piix_config_drive_for_dma (id
 static int piix_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		/* Find best PIO mode. */
 		(void) hwif->speedproc(drive, XFER_PIO_0 +
 				       ide_get_best_pio_mode(drive, 255, 4, NULL));
Index: a/drivers/ide/pci/serverworks.c
===================================================================
--- a.orig/drivers/ide/pci/serverworks.c
+++ a/drivers/ide/pci/serverworks.c
@@ -316,21 +316,13 @@ static int config_chipset_for_dma (ide_d
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		config_chipset_for_pio(drive);
 		//	hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
Index: a/drivers/ide/pci/siimage.c
===================================================================
--- a.orig/drivers/ide/pci/siimage.c
+++ a/drivers/ide/pci/siimage.c
@@ -416,19 +416,11 @@ static int config_chipset_for_dma (ide_d
 static int siimage_config_drive_for_dma (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
-	if ((id->capability & 1) != 0 && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/sis5513.c
===================================================================
--- a.orig/drivers/ide/pci/sis5513.c
+++ a/drivers/ide/pci/sis5513.c
@@ -670,23 +670,15 @@ static int config_chipset_for_dma (ide_d
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	config_art_rwp_pio(drive, 5);
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		sis5513_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/slc90e66.c
===================================================================
--- a.orig/drivers/ide/pci/slc90e66.c
+++ a/drivers/ide/pci/slc90e66.c
@@ -180,19 +180,13 @@ static int slc90e66_config_drive_for_dma
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		(void) hwif->speedproc(drive, XFER_PIO_0 +
 				       ide_get_best_pio_mode(drive, 255, 4, NULL));
 		return hwif->ide_dma_off_quietly(drive);
Index: a/drivers/ide/pci/tc86c001.c
===================================================================
--- a.orig/drivers/ide/pci/tc86c001.c
+++ a/drivers/ide/pci/tc86c001.c
@@ -186,17 +186,11 @@ static int config_chipset_for_dma(ide_dr
 static int tc86c001_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
-	if ((id->capability & 1) && drive->autodma) {
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
-		if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-
-		goto fast_ata_pio;
-
-	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
+	if (ide_use_fast_pio(drive)) {
 		tc86c001_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
Index: a/drivers/ide/pci/triflex.c
===================================================================
--- a.orig/drivers/ide/pci/triflex.c
+++ a/drivers/ide/pci/triflex.c
@@ -116,14 +116,9 @@ static int triflex_config_drive_for_dma(
 static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
 
-	if ((id->capability & 1) && drive->autodma) {
-		if (ide_use_dma(drive)) {
-			if (triflex_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
-	}
+	if (ide_use_dma(drive) && triflex_config_drive_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
 	hwif->tuneproc(drive, 255);
 	return hwif->ide_dma_off_quietly(drive);
Index: a/include/linux/ide.h
===================================================================
--- a.orig/include/linux/ide.h
+++ a/include/linux/ide.h
@@ -1325,6 +1325,7 @@ extern int ide_dma_enable(ide_drive_t *d
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
+int ide_use_fast_pio(ide_drive_t *);
 
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
 
