Return-Path: <linux-kernel-owner+w=401wt.eu-S932826AbXASA2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbXASA2m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXASA2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXASA2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=XouqMndmtEtKSz4iaREE/0RVTivFWNNTRvSNi8iOrJQ/i04Jh61EbbnwoUxRkIFygvw74T14jMkEQcjltHeTejVnERLubULNBE/iR/Pp1LPvLIy+479+qmmsvCEx4UchBW/fcICuVvivt69XxU4Lng1SFhZSSJMR1ge4PvCIc6Q=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:06 +0100
Message-Id: <20070119003206.14846.59852.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 10/15] ide: add ide_set_dma() helper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: add ide_set_dma() helper

* add ide_set_dma() helper and make ide_hwif_t.ide_dma_check return
  -1 when DMA needs to be disabled (== need to call ->ide_dma_off_quietly)
   0 when DMA needs to be enabled  (== need to call ->ide_dma_on)
   1 when DMA setting shouldn't be changed
* fix IDE code to use ide_set_dma() instead if using ->ide_dma_check directly

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c       |    5 +----
 drivers/ide/cris/ide-cris.c    |    6 ++----
 drivers/ide/ide-dma.c          |   37 ++++++++++++++++++++++++++++++-------
 drivers/ide/ide-io.c           |    2 +-
 drivers/ide/ide-probe.c        |    2 +-
 drivers/ide/ide.c              |    3 ++-
 drivers/ide/mips/au1xxx-ide.c  |    4 ++--
 drivers/ide/pci/aec62xx.c      |    6 ++----
 drivers/ide/pci/alim15x3.c     |   11 +++++------
 drivers/ide/pci/amd74xx.c      |    5 +++--
 drivers/ide/pci/atiixp.c       |    7 +++----
 drivers/ide/pci/cmd64x.c       |    6 ++----
 drivers/ide/pci/cs5520.c       |    5 ++---
 drivers/ide/pci/cs5530.c       |    5 +----
 drivers/ide/pci/cs5535.c       |    5 ++---
 drivers/ide/pci/hpt34x.c       |    8 +++-----
 drivers/ide/pci/hpt366.c       |    6 ++----
 drivers/ide/pci/it8213.c       |   14 ++++++--------
 drivers/ide/pci/it821x.c       |   12 +++++-------
 drivers/ide/pci/jmicron.c      |   10 ++++------
 drivers/ide/pci/ns87415.c      |    3 ++-
 drivers/ide/pci/pdc202xx_new.c |    8 +++-----
 drivers/ide/pci/pdc202xx_old.c |    8 +++-----
 drivers/ide/pci/piix.c         |   10 ++++------
 drivers/ide/pci/sc1200.c       |    5 +----
 drivers/ide/pci/serverworks.c  |    6 ++----
 drivers/ide/pci/sgiioc4.c      |    4 ++--
 drivers/ide/pci/siimage.c      |    6 ++----
 drivers/ide/pci/sis5513.c      |    6 ++----
 drivers/ide/pci/sl82c105.c     |    6 +++---
 drivers/ide/pci/slc90e66.c     |   10 ++++------
 drivers/ide/pci/tc86c001.c     |    6 ++----
 drivers/ide/pci/triflex.c      |    9 ++++-----
 drivers/ide/pci/via82cxxx.c    |    5 +++--
 include/linux/ide.h            |    2 ++
 35 files changed, 118 insertions(+), 135 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -365,10 +365,7 @@ static int icside_dma_check(ide_drive_t 
 out:
 	on = icside_set_speed(drive, xfer_mode);
 
-	if (on)
-		return icside_dma_on(drive);
-	else
-		return icside_dma_off_quietly(drive);
+	return on ? 0 : -1;
 }
 
 static int icside_dma_end(ide_drive_t *drive)
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1048,12 +1048,10 @@ static ide_startstop_t cris_dma_intr (id
 
 static int cris_dma_check(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
-
 	if (ide_use_dma(drive) && cris_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int cris_dma_end(ide_drive_t *drive)
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -348,15 +348,14 @@ EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
 static int config_drive_for_dma (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	ide_hwif_t *hwif = HWIF(drive);
 
-	if ((id->capability & 1) && hwif->autodma) {
+	if ((id->capability & 1) && drive->hwif->autodma) {
 		/*
 		 * Enable DMA on any drive that has
 		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
 		 */
 		if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
-			return hwif->ide_dma_on(drive);
+			return 0;
 		/*
 		 * Enable DMA on any drive that has mode2 DMA
 		 * (multi or single) enabled
@@ -364,14 +363,14 @@ static int config_drive_for_dma (ide_dri
 		if (id->field_valid & 2)	/* regular DMA */
 			if ((id->dma_mword & 0x404) == 0x404 ||
 			    (id->dma_1word & 0x404) == 0x404)
-				return hwif->ide_dma_on(drive);
+				return 0;
 
 		/* Consult the list of known "good" drives */
 		if (__ide_dma_good_drive(drive))
-			return hwif->ide_dma_on(drive);
+			return 0;
 	}
-//	if (hwif->tuneproc != NULL) hwif->tuneproc(drive, 255);
-	return hwif->ide_dma_off_quietly(drive);
+
+	return -1;
 }
 
 /**
@@ -765,6 +764,30 @@ bug_dma_off:
 
 EXPORT_SYMBOL(ide_dma_verbose);
 
+int ide_set_dma(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	int rc;
+
+	rc = hwif->ide_dma_check(drive);
+
+	switch(rc) {
+	case -1: /* DMA needs to be disabled */
+		return hwif->ide_dma_off_quietly(drive);
+	case  0: /* DMA needs to be enabled */
+		return hwif->ide_dma_on(drive);
+	case  1: /* DMA setting cannot be changed */
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(ide_set_dma);
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 int __ide_dma_lostirq (ide_drive_t *drive)
 {
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -226,7 +226,7 @@ static ide_startstop_t ide_start_power_s
 			break;
 		if (drive->hwif->ide_dma_check == NULL)
 			break;
-		drive->hwif->ide_dma_check(drive);
+		ide_set_dma(drive);
 		break;
 	}
 	pm->pm_step = ide_pm_state_completed;
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -857,7 +857,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 #ifdef CONFIG_IDEDMA_ONLYDISK
 				if (drive->media == ide_disk)
 #endif
-					hwif->ide_dma_check(drive);
+					ide_set_dma(drive);
 			}
 		}
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1134,7 +1134,8 @@ static int set_using_dma (ide_drive_t *d
 	if (HWIF(drive)->ide_dma_check == NULL)
 		return -EPERM;
 	if (arg) {
-		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
+		if (ide_set_dma(drive))
+			return -EIO;
 		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
 	} else {
 		if (__ide_dma_off(drive))
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -414,9 +414,9 @@ static int auide_dma_check(ide_drive_t *
 	speed = ide_find_best_mode(drive, XFER_PIO | XFER_MWDMA);
 	
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
+		return 0;
 
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int auide_dma_test_irq(ide_drive_t *drive)
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -209,15 +209,13 @@ static void aec62xx_tune_drive (ide_driv
 
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		aec62xx_tune_drive(drive, 5);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int aec62xx_irq_timeout (ide_drive_t *drive)
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -507,17 +507,15 @@ static int config_chipset_for_dma (ide_d
  *
  *	Configure a drive for DMA operation. If DMA is not possible we
  *	drop the drive into PIO mode instead.
- *
- *	FIXME: exactly what are we trying to return here
  */
- 
+
 static int ali15x3_config_drive_for_dma(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
-		return hwif->ide_dma_off_quietly(drive);
+		goto no_dma_set;
 
 	drive->init_speed = 0;
 
@@ -552,9 +550,10 @@ try_dma_modes:
 ata_pio:
 		hwif->tuneproc(drive, 255);
 no_dma_set:
-		return hwif->ide_dma_off_quietly(drive);
+		return -1;
 	}
-	return hwif->ide_dma_on(drive);
+
+	return 0;
 }
 
 /**
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -304,8 +304,9 @@ static int amd74xx_ide_dma_check(ide_dri
 	amd_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return 0;
+
+	return -1;
 }
 
 /*
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -252,21 +252,20 @@ static int atiixp_config_drive_for_dma(i
 
 static int atiixp_dma_check(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	u8 tspeed, speed;
 
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && atiixp_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive)) {
 		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
 		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
-		hwif->speedproc(drive, speed);
+		atiixp_speedproc(drive, speed);
 	}
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /**
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -474,15 +474,13 @@ static int config_chipset_for_dma (ide_d
 
 static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive, 1);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int cmd64x_alt_dma_status (struct pci_dev *dev)
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -132,12 +132,11 @@ static void cs5520_tune_drive(ide_drive_
 
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-
 	/* Tune the drive for PIO modes up to PIO 4 */	
 	cs5520_tune_drive(drive, 4);
+
 	/* Then tell the core to use DMA operations */
-	return hwif->ide_dma_on(drive);
+	return 0;
 }
 
 /*
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -196,10 +196,7 @@ static int cs5530_config_dma (ide_drive_
 		outl(timings, basereg + 12);	/* write drive1 config register */
 	}
 
-	/*
-	 * Finally, turn DMA on in software, and exit.
-	 */
-	return hwif->ide_dma_on(drive);	/* success */
+	return 0;	/* success */
 }
 
 /**
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -195,20 +195,19 @@ static int cs5535_config_drive_for_dma(i
 
 static int cs5535_dma_check(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
 	u8 speed;
 
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && cs5535_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive)) {
 		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
 		cs5535_set_drive(drive, speed);
 	}
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static u8 __devinit cs5535_cable_detect(struct pci_dev *dev)
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -109,21 +109,19 @@ static int config_chipset_for_dma (ide_d
 
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 #ifndef CONFIG_HPT34X_AUTODMA
-		return hwif->ide_dma_off_quietly(drive);
+		return -1;
 #else
-		return hwif->ide_dma_on(drive);
+		return 0;
 #endif
 
 	if (ide_use_fast_pio(drive))
 		hpt34x_tune_drive(drive, 255);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /*
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -736,17 +736,15 @@ static void hpt3xx_maskproc(ide_drive_t 
 
 static int hpt366_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		hpt3xx_tune_drive(drive, 255);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /*
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -244,17 +244,15 @@ static int config_chipset_for_dma (ide_d
 
 static int it8213_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
+	u8 pio;
 
-	if (ide_use_dma(drive)) {
-		if (config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-	}
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return 0;
 
-	hwif->speedproc(drive, XFER_PIO_0
-			+ ide_get_best_pio_mode(drive, 255, 4, NULL));
+	pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
+	it8213_tune_chipset(drive, XFER_PIO_0 + pio);
 
- 	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /**
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -520,14 +520,12 @@ static int config_chipset_for_dma (ide_d
 
 static int it821x_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return 0;
 
-	if (ide_use_dma(drive)) {
-		if (config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-	}
 	config_it821x_chipset_for_pio(drive, 1);
-	return hwif->ide_dma_off_quietly(drive);
+
+	return -1;
 }
 
 /**
@@ -612,7 +610,7 @@ static void __devinit it821x_fixups(ide_
 #ifdef CONFIG_IDEDMA_ONLYDISK
 			if (drive->media == ide_disk)
 #endif
-				hwif->ide_dma_check(drive);
+				ide_set_dma(drive);
 		} else {
 			/* Non RAID volume. Fixups to stop the core code
 			   doing unsupported things */
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -164,14 +164,12 @@ static int config_chipset_for_dma (ide_d
 
 static int jmicron_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
+	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+		return 0;
 
-	if (ide_use_dma(drive)) {
-		if (config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
-	}
 	config_jmicron_chipset_for_pio(drive, 1);
-	return hwif->ide_dma_off_quietly(drive);
+
+	return -1;
 }
 
 /**
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -190,7 +190,8 @@ static int ns87415_ide_dma_setup(ide_dri
 static int ns87415_ide_dma_check (ide_drive_t *drive)
 {
 	if (drive->media != ide_disk)
-		return HWIF(drive)->ide_dma_off_quietly(drive);
+		return -1;
+
 	return __ide_dma_check(drive);
 }
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -281,17 +281,15 @@ static int config_chipset_for_dma(ide_dr
 
 static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
-		hwif->tuneproc(drive, 255);
+		pdcnew_tune_drive(drive, 255);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int pdcnew_quirkproc(ide_drive_t *drive)
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -332,17 +332,15 @@ chipset_is_set:
 
 static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
-		hwif->tuneproc(drive, 5);
+		config_chipset_for_pio(drive, 5);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static int pdc202xx_quirkproc (ide_drive_t *drive)
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -386,20 +386,18 @@ static int piix_config_drive_for_dma (id
  
 static int piix_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive)) {
 		/* Find best PIO mode. */
-		(void) hwif->speedproc(drive, XFER_PIO_0 +
-				       ide_get_best_pio_mode(drive, 255, 4, NULL));
+		u8 pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
+		(void)piix_tune_chipset(drive, XFER_PIO_0 + pio);
 	}
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /**
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -241,10 +241,7 @@ static int sc1200_config_dma2 (ide_drive
 
 	outb(inb(hwif->dma_base+2)|(unit?0x40:0x20), hwif->dma_base+2);	/* set DMA_capable bit */
 
-	/*
-	 * Finally, turn DMA on in software, and exit.
-	 */
-	return hwif->ide_dma_on(drive);	/* success */
+	return 0;	/* success */
 }
 
 /*
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -315,17 +315,15 @@ static int config_chipset_for_dma (ide_d
 
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -296,9 +296,9 @@ static int sgiioc4_ide_dma_check(ide_dri
 	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
 		printk(KERN_WARNING "%s: couldn't set MWDMA2 mode, "
 				    "using PIO instead\n", drive->name);
-		return sgiioc4_ide_dma_off_quietly(drive);
+		return -1;
 	} else
-		return sgiioc4_ide_dma_on(drive);
+		return 0;
 }
 
 /* returns 1 if dma irq issued, 0 otherwise */
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -415,15 +415,13 @@ static int config_chipset_for_dma (ide_d
  
 static int siimage_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		config_chipset_for_pio(drive, 1);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /* returns 1 if dma irq issued, 0 otherwise */
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -669,19 +669,17 @@ static int config_chipset_for_dma (ide_d
 
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	config_art_rwp_pio(drive, 5);
 
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		sis5513_tune_drive(drive, 5);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /* Chip detection and general config */
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -161,14 +161,14 @@ static int sl82c105_check_drive (ide_dri
 		if (id->field_valid & 2) {
 			if ((id->dma_mword & hwif->mwdma_mask) ||
 			    (id->dma_1word & hwif->swdma_mask))
-				return hwif->ide_dma_on(drive);
+				return 0;
 		}
 
 		if (__ide_dma_good_drive(drive))
-			return hwif->ide_dma_on(drive);
+			return 0;
 	} while (0);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 /*
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -179,19 +179,17 @@ static int slc90e66_config_drive_for_dma
 
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive)) {
-		(void) hwif->speedproc(drive, XFER_PIO_0 +
-				       ide_get_best_pio_mode(drive, 255, 4, NULL));
+		u8 pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
+		(void)slc90e66_tune_chipset(drive, XFER_PIO_0 + pio);
 	}
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -185,15 +185,13 @@ static int config_chipset_for_dma(ide_dr
 
 static int tc86c001_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
 
 	if (ide_use_fast_pio(drive))
 		tc86c001_tune_drive(drive, 255);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -113,13 +113,12 @@ static int triflex_config_drive_for_dma(
 
 static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	if (ide_use_dma(drive) && triflex_config_drive_for_dma(drive))
-		return hwif->ide_dma_on(drive);
+		return 0;
+
+	triflex_tune_drive(drive, 255);
 
-	hwif->tuneproc(drive, 255);
-	return hwif->ide_dma_off_quietly(drive);
+	return -1;
 }
 
 static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -240,8 +240,9 @@ static int via82cxxx_ide_dma_check (ide_
 	via_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return hwif->ide_dma_on(drive);
-	return hwif->ide_dma_off_quietly(drive);
+		return 0;
+
+	return -1;
 }
 
 static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1278,6 +1278,7 @@ int __ide_dma_good_drive(ide_drive_t *);
 int ide_use_dma(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
+int ide_set_dma(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
@@ -1303,6 +1304,7 @@ extern int __ide_dma_timeout(ide_drive_t
 static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
 static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
+static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 #ifndef CONFIG_BLK_DEV_IDEDMA_PCI
