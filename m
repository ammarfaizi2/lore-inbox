Return-Path: <linux-kernel-owner+w=401wt.eu-S932806AbXASA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbXASA2r (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbXASA2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbXASA2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:35 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=NAHKAzlLVH+UXmRkTGW6DevSib7GgM65iEKrdzNgcJ1VRzhtcyXvFVn18U9BuVbnwD1pxf34p3hw1YoP7hm+EfMp50oAfd3I1yGh03NBCKbKUP/vSQRascZZDBAXH7M8ZsM9GgUVSFxIfYVhRGgktuhVHom0NgK7kGhjPTIQQD0=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:33 +0100
Message-Id: <20070119003233.14846.5450.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 14/15] ide: rework the code for selecting the best DMA transfer mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: rework the code for selecting the best DMA transfer mode 

Depends on the "ide: fix UDMA/MWDMA/SWDMA masks" patch.

* add ide_hwif_t.filter_udma_mask hook for filtering UDMA mask
  (use it in alim15x3, hpt366, siimage and serverworks drivers)
* add ide_max_dma_mode() for finding best DMA mode for the device
  (loosely based on some older libata-core.c code)
* convert ide_dma_speed() users to use ide_max_dma_mode()
* make ide_rate_filter() take "ide_drive_t *drive" as an argument instead
  of "u8 mode" and teach it to how to use UDMA mask to do filtering
* use ide_rate_filter() in hpt366 driver
* remove no longer needed ide_dma_speed() and *_ratemask()
* unexport eighty_ninty_three()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c       |    2 
 drivers/ide/cris/ide-cris.c    |    2 
 drivers/ide/ide-dma.c          |   74 ++++++++++++++++++++++++
 drivers/ide/ide-iops.c         |    2 
 drivers/ide/ide-lib.c          |  125 +++++------------------------------------
 drivers/ide/ide.c              |    1 
 drivers/ide/pci/aec62xx.c      |   32 ----------
 drivers/ide/pci/alim15x3.c     |   76 +++++-------------------
 drivers/ide/pci/atiixp.c       |   20 ------
 drivers/ide/pci/cmd64x.c       |   66 ++++-----------------
 drivers/ide/pci/cs5535.c       |   20 ------
 drivers/ide/pci/hpt34x.c       |    9 --
 drivers/ide/pci/hpt366.c       |   67 +++++++++++----------
 drivers/ide/pci/it8213.c       |   20 ------
 drivers/ide/pci/it821x.c       |   20 ------
 drivers/ide/pci/jmicron.c      |   21 ------
 drivers/ide/pci/pdc202xx_new.c |   14 ----
 drivers/ide/pci/pdc202xx_old.c |   27 --------
 drivers/ide/pci/piix.c         |   66 ---------------------
 drivers/ide/pci/serverworks.c  |   31 ++++++----
 drivers/ide/pci/siimage.c      |   45 ++++++--------
 drivers/ide/pci/sis5513.c      |   14 ----
 drivers/ide/pci/slc90e66.c     |   13 ----
 drivers/ide/pci/tc86c001.c     |    9 --
 drivers/ide/pci/triflex.c      |    4 -
 include/linux/ide.h            |   10 +--
 26 files changed, 235 insertions(+), 555 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -347,7 +347,7 @@ static int icside_dma_check(ide_drive_t 
 	 * Enable DMA on any drive that has multiword DMA
 	 */
 	if (id->field_valid & 2) {
-		xfer_mode = ide_dma_speed(drive, 0);
+		xfer_mode = ide_max_dma_mode(drive);
 		goto out;
 	}
 
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1006,7 +1006,7 @@ static int cris_ide_build_dmatable (ide_
 
 static int cris_config_drive_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, 1);
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -705,6 +705,80 @@ int ide_use_dma(ide_drive_t *drive)
 
 EXPORT_SYMBOL_GPL(ide_use_dma);
 
+static const u8 xfer_mode_bases[] = {
+	XFER_UDMA_0,
+	XFER_MW_DMA_0,
+	XFER_SW_DMA_0,
+};
+
+static unsigned int ide_get_mode_mask(ide_drive_t *drive, u8 base)
+{
+	struct hd_driveid *id = drive->id;
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned int mask = 0;
+
+	switch(base) {
+	case XFER_UDMA_0:
+		if ((id->field_valid & 4) == 0)
+			break;
+
+		mask = id->dma_ultra & hwif->ultra_mask;
+
+		if (hwif->filter_udma_mask)
+			mask &= hwif->filter_udma_mask(drive);
+
+		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
+			mask &= 0x07;
+		break;
+	case XFER_MW_DMA_0:
+		mask = id->dma_mword & hwif->mwdma_mask;
+		break;
+	case XFER_SW_DMA_0:
+		mask = id->dma_1word & hwif->swdma_mask;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return mask;
+}
+
+/**
+ *	ide_max_dma_mode	-	compute DMA speed
+ *	@drive: IDE device
+ *
+ *	Checks the drive capabilities and returns the speed to use
+ *	for the DMA transfer.  Returns 0 if the drive is incapable
+ *	of DMA transfers.
+ */
+
+u8 ide_max_dma_mode(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned int mask;
+	int x, i;
+	u8 mode = 0;
+
+	if (drive->media != ide_disk && hwif->atapi_dma == 0)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_mode_bases); i++) {
+		mask = ide_get_mode_mask(drive, xfer_mode_bases[i]);
+		x = fls(mask) - 1;
+		if (x >= 0) {
+			mode = xfer_mode_bases[i] + x;
+			break;
+		}
+	}
+
+	printk(KERN_DEBUG "%s: selected mode 0x%x\n", drive->name, mode);
+
+	return mode;
+}
+
+EXPORT_SYMBOL_GPL(ide_max_dma_mode);
+
 void ide_dma_verbose(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -586,8 +586,6 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	return 1;
 }
 
-EXPORT_SYMBOL(eighty_ninty_three);
-
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
 	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -69,123 +69,34 @@ char *ide_xfer_verbose (u8 xfer_rate)
 EXPORT_SYMBOL(ide_xfer_verbose);
 
 /**
- *	ide_dma_speed	-	compute DMA speed
- *	@drive: drive
- *	@mode:	modes available
- *
- *	Checks the drive capabilities and returns the speed to use
- *	for the DMA transfer.  Returns 0 if the drive is incapable
- *	of DMA transfers.
- */
- 
-u8 ide_dma_speed(ide_drive_t *drive, u8 mode)
-{
-	struct hd_driveid *id   = drive->id;
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 ultra_mask, mwdma_mask, swdma_mask;
-	u8 speed = 0;
-
-	if (drive->media != ide_disk && hwif->atapi_dma == 0)
-		return 0;
-
-	/* Capable of UltraDMA modes? */
-	ultra_mask = id->dma_ultra & hwif->ultra_mask;
-
-	if (!(id->field_valid & 4))
-		mode = 0;	/* fallback to MW/SW DMA if no UltraDMA */
-
-	switch (mode) {
-	case 4:
-		if (ultra_mask & 0x40) {
-			speed = XFER_UDMA_6;
-			break;
-		}
-	case 3:
-		if (ultra_mask & 0x20) {
-			speed = XFER_UDMA_5;
-			break;
-		}
-	case 2:
-		if (ultra_mask & 0x10) {
-			speed = XFER_UDMA_4;
-			break;
-		}
-		if (ultra_mask & 0x08) {
-			speed = XFER_UDMA_3;
-			break;
-		}
-	case 1:
-		if (ultra_mask & 0x04) {
-			speed = XFER_UDMA_2;
-			break;
-		}
-		if (ultra_mask & 0x02) {
-			speed = XFER_UDMA_1;
-			break;
-		}
-		if (ultra_mask & 0x01) {
-			speed = XFER_UDMA_0;
-			break;
-		}
-	case 0:
-		mwdma_mask = id->dma_mword & hwif->mwdma_mask;
-
-		if (mwdma_mask & 0x04) {
-			speed = XFER_MW_DMA_2;
-			break;
-		}
-		if (mwdma_mask & 0x02) {
-			speed = XFER_MW_DMA_1;
-			break;
-		}
-		if (mwdma_mask & 0x01) {
-			speed = XFER_MW_DMA_0;
-			break;
-		}
-
-		swdma_mask = id->dma_1word & hwif->swdma_mask;
-
-		if (swdma_mask & 0x04) {
-			speed = XFER_SW_DMA_2;
-			break;
-		}
-		if (swdma_mask & 0x02) {
-			speed = XFER_SW_DMA_1;
-			break;
-		}
-		if (swdma_mask & 0x01) {
-			speed = XFER_SW_DMA_0;
-			break;
-		}
-	}
-
-	return speed;
-}
-EXPORT_SYMBOL(ide_dma_speed);
-
-
-/**
- *	ide_rate_filter		-	return best speed for mode
- *	@mode: modes available
+ *	ide_rate_filter		-	filter transfer mode
+ *	@drive: IDE device
  *	@speed: desired speed
  *
- *	Given the available DMA/UDMA mode this function returns
+ *	Given the available transfer modes this function returns
  *	the best available speed at or below the speed requested.
+ *
+ *	FIXME: filter also PIO/SWDMA/MWDMA modes
  */
 
-u8 ide_rate_filter (u8 mode, u8 speed) 
+u8 ide_rate_filter(ide_drive_t *drive, u8 speed)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	static u8 speed_max[] = {
-		XFER_MW_DMA_2, XFER_UDMA_2, XFER_UDMA_4,
-		XFER_UDMA_5, XFER_UDMA_6
-	};
+	ide_hwif_t *hwif = drive->hwif;
+	u8 mask = hwif->ultra_mask, mode = XFER_MW_DMA_2;
+
+	if (hwif->filter_udma_mask)
+		mask = hwif->filter_udma_mask(drive);
+
+	if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
+		mask &= 0x07;
+
+	if (mask)
+		mode = fls(mask) - 1 + XFER_UDMA_0;
 
 //	printk("%s: mode 0x%02x, speed 0x%02x\n", __FUNCTION__, mode, speed);
 
-	/* So that we remember to update this if new modes appear */
-	BUG_ON(mode > 4);
-	return min(speed, speed_max[mode]);
+	return min(speed, mode);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
 	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -483,6 +483,7 @@ static void ide_hwif_restore(ide_hwif_t 
 
 	hwif->tuneproc			= tmp_hwif->tuneproc;
 	hwif->speedproc			= tmp_hwif->speedproc;
+	hwif->filter_udma_mask		= tmp_hwif->filter_udma_mask;
 	hwif->selectproc		= tmp_hwif->selectproc;
 	hwif->reset_poll		= tmp_hwif->reset_poll;
 	hwif->pre_reset			= tmp_hwif->pre_reset;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -86,38 +86,12 @@ static u8 pci_bus_clock_list_ultra (u8 s
 	return chipset_table->ultra_settings;
 }
 
-static u8 aec62xx_ratemask (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 mode;
-
-	switch(hwif->pci_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			mode = (inb(hwif->channel ?
-				    hwif->mate->dma_status :
-				    hwif->dma_status) & 0x10) ? 4 : 3;
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-			mode = 2;
-			break;
-		case PCI_DEVICE_ID_ARTOP_ATP850UF:
-		default:
-			return 1;
-	}
-
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
 static int aec6210_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u16 d_conf		= 0;
-	u8 speed	= ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	u8 ultra = 0, ultra_conf = 0;
 	u8 tmp0 = 0, tmp1 = 0, tmp2 = 0;
 	unsigned long flags;
@@ -144,7 +118,7 @@ static int aec6260_tune_chipset (ide_dri
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed	= ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
+	u8 speed	= ide_rate_filter(drive, xferspeed);
 	u8 unit		= (drive->select.b.unit & 0x01);
 	u8 tmp1 = 0, tmp2 = 0;
 	u8 ultra = 0, drive_conf = 0, ultra_conf = 0;
@@ -182,7 +156,7 @@ static int aec62xx_tune_chipset (ide_dri
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, aec62xx_ratemask(drive));	
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!(speed))
 		return 0;
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -359,74 +359,31 @@ static void ali15x3_tune_drive (ide_driv
 }
 
 /**
- *	ali15x3_can_ultra	-	check for ultra DMA support
- *	@drive: drive to do the check
+ *	ali_filter_udma_mask	-	compute UDMA mask
+ *	@drive: IDE device
  *
- *	Check the drive and controller revisions. Return 0 if UDMA is
- *	not available, or 1 if UDMA can be used. The actual rules for
- *	the ALi are
+ *	Return available UDMA modes.
+ *
+ *	The actual rules for the ALi are:
  *		No UDMA on revisions <= 0x20
  *		Disk only for revisions < 0xC2
  *		Not WDC drives for revisions < 0xC2
  *
  *	FIXME: WDC ifdef needs to die
  */
- 
-static u8 ali15x3_can_ultra (ide_drive_t *drive)
-{
-#ifndef CONFIG_WDC_ALI15X3
-	struct hd_driveid *id	= drive->id;
-#endif /* CONFIG_WDC_ALI15X3 */
-
-	if (m5229_revision <= 0x20) {
-		return 0;
-	} else if ((m5229_revision < 0xC2) &&
-#ifndef CONFIG_WDC_ALI15X3
-		   ((chip_is_1543c_e && strstr(id->model, "WDC ")) ||
-		    (drive->media!=ide_disk))) {
-#else /* CONFIG_WDC_ALI15X3 */
-		   (drive->media!=ide_disk)) {
-#endif /* CONFIG_WDC_ALI15X3 */
-		return 0;
-	} else {
-		return 1;
-	}
-}
 
-/**
- *	ali15x3_ratemask	-	generate DMA mode list
- *	@drive: drive to compute against
- *
- *	Generate a list of the available DMA modes for the drive. 
- *	FIXME: this function contains lots of bogus masking we can dump
- *
- *	Return the highest available mode (UDMA33, UDMA66, UDMA100,..)
- */
- 
-static u8 ali15x3_ratemask (ide_drive_t *drive)
+static u8 ali_filter_udma_mask(ide_drive_t *drive)
 {
-	u8 mode = 0, can_ultra	= ali15x3_can_ultra(drive);
-
-	if (m5229_revision > 0xC4 && can_ultra) {
-		mode = 4;
-	} else if (m5229_revision == 0xC4 && can_ultra) {
-		mode = 3;
-	} else if (m5229_revision >= 0xC2 && can_ultra) {
-		mode = 2;
-	} else if (can_ultra) {
-		return 1;
-	} else {
-		return 0;
+	if (m5229_revision > 0x20 && m5229_revision < 0xC2) {
+		if (drive->media != ide_disk)
+			return 0;
+#ifndef CONFIG_WDC_ALI15X3
+		if (chip_is_1543c_e && strstr(drive->id->model, "WDC "))
+			return 0;
+#endif
 	}
 
-	/*
-	 *	If the drive sees no suitable cable then UDMA 33
-	 *	is the highest permitted mode
-	 */
-	 
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
+	return drive->hwif->ultra_mask;
 }
 
 /**
@@ -442,7 +399,7 @@ static int ali15x3_tune_chipset (ide_dri
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed		= ide_rate_filter(ali15x3_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	u8 speed1		= speed;
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 tmpbyte		= 0x00;
@@ -492,7 +449,7 @@ static int ali15x3_tune_chipset (ide_dri
  
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, ali15x3_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!(speed))
 		return 0;
@@ -753,6 +710,7 @@ static void __devinit init_hwif_common_a
 	hwif->autodma = 0;
 	hwif->tuneproc = &ali15x3_tune_drive;
 	hwif->speedproc = &ali15x3_tune_chipset;
+	hwif->filter_udma_mask = &ali_filter_udma_mask;
 
 	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
 	hwif->no_lba48_dma = (m5229_revision <= 0xC4) ? 1 : 0;
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -49,22 +49,6 @@ static int save_mdma_mode[4];
 static DEFINE_SPINLOCK(atiixp_lock);
 
 /**
- *	atiixp_ratemask		-	compute rate mask for ATIIXP IDE
- *	@drive: IDE drive to compute for
- *
- *	Returns the available modes for the ATIIXP IDE controller.
- */
-
-static u8 atiixp_ratemask(ide_drive_t *drive)
-{
-	u8 mode = 3;
-
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
-/**
  *	atiixp_dma_2_pio		-	return the PIO mode matching DMA
  *	@xfer_rate: transfer speed
  *
@@ -189,7 +173,7 @@ static int atiixp_speedproc(ide_drive_t 
 	u16 tmp16;
 	u8 speed, pio;
 
-	speed = ide_rate_filter(atiixp_ratemask(drive), xferspeed);
+	speed = ide_rate_filter(drive, xferspeed);
 
 	spin_lock_irqsave(&atiixp_lock, flags);
 
@@ -233,7 +217,7 @@ static int atiixp_speedproc(ide_drive_t 
 
 static int atiixp_config_drive_for_dma(ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, atiixp_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -338,55 +338,6 @@ static void cmd64x_tuneproc (ide_drive_t
 		setup_count, active_count, recovery_count);
 }
 
-static u8 cmd64x_ratemask (ide_drive_t *drive)
-{
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u8 mode = 0;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_CMD_649:
-			mode = 3;
-			break;
-		case PCI_DEVICE_ID_CMD_648:
-			mode = 2;
-			break;
-		case PCI_DEVICE_ID_CMD_643:
-			return 0;
-
-		case PCI_DEVICE_ID_CMD_646:
-		{
-			unsigned int class_rev	= 0;
-			pci_read_config_dword(dev,
-				PCI_CLASS_REVISION, &class_rev);
-			class_rev &= 0xff;
-		/*
-		 * UltraDMA only supported on PCI646U and PCI646U2, which
-		 * correspond to revisions 0x03, 0x05 and 0x07 respectively.
-		 * Actually, although the CMD tech support people won't
-		 * tell me the details, the 0x03 revision cannot support
-		 * UDMA correctly without hardware modifications, and even
-		 * then it only works with Quantum disks due to some
-		 * hold time assumptions in the 646U part which are fixed
-		 * in the 646U2.
-		 *
-		 * So we only do UltraDMA on revision 0x05 and 0x07 chipsets.
-		 */
-			switch(class_rev) {
-				case 0x07:
-				case 0x05:
-					return 1;
-				case 0x03:
-				case 0x01:
-				default:
-					return 0;
-			}
-		}
-	}
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
 static void config_cmd64x_chipset_for_pio (ide_drive_t *drive, u8 set_speed)
 {
 	u8 speed	= 0x00;
@@ -412,7 +363,7 @@ static int cmd64x_tune_chipset (ide_driv
 	u8 regU = 0, pciU	= (hwif->channel) ? UDIDETCR1 : UDIDETCR0;
 	u8 regD = 0, pciD	= (hwif->channel) ? BMIDESR1 : BMIDESR0;
 
-	u8 speed	= ide_rate_filter(cmd64x_ratemask(drive), xferspeed);
+	u8 speed = ide_rate_filter(drive, xferspeed);
 
 	if (speed > XFER_PIO_4) {
 		(void) pci_read_config_byte(dev, pciD, &regD);
@@ -459,7 +410,7 @@ static int cmd64x_tune_chipset (ide_driv
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed	= ide_dma_speed(drive, cmd64x_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	config_chipset_for_pio(drive, !speed);
 
@@ -696,6 +647,19 @@ static void __devinit init_hwif_cmd64x(i
 
 	if (dev->device == PCI_DEVICE_ID_CMD_643)
 		hwif->ultra_mask = 0x00;
+
+	/*
+	 * UltraDMA only supported on PCI646U and PCI646U2, which
+	 * correspond to revisions 0x03, 0x05 and 0x07 respectively.
+	 * Actually, although the CMD tech support people won't
+	 * tell me the details, the 0x03 revision cannot support
+	 * UDMA correctly without hardware modifications, and even
+	 * then it only works with Quantum disks due to some
+	 * hold time assumptions in the 646U part which are fixed
+	 * in the 646U2.
+	 *
+	 * So we only do UltraDMA on revision 0x05 and 0x07 chipsets.
+	 */
 	if (dev->device == PCI_DEVICE_ID_CMD_646)
 		hwif->ultra_mask =
 			(class_rev == 0x05 || class_rev == 0x07) ? 0x07 : 0x00;
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -127,20 +127,6 @@ static void cs5535_set_speed(ide_drive_t
 	}
 }
 
-static u8 cs5535_ratemask(ide_drive_t *drive)
-{
-	/* eighty93 will return 1 if it's 80core and capable of
-	exceeding udma2, 0 otherwise. we need ratemask to set
-	the max speed and if we can > udma2 then we return 2
-	which selects speed_max as udma4 which is the 5535's max
-	speed, and 1 selects udma2 which is the max for 40c */
-	if (!eighty_ninty_three(drive))
-		return 1;
-
-	return 2;
-}
-
-
 /****
  *	cs5535_set_drive         -     Configure the drive to the new speed
  *	@drive: Drive to set up
@@ -151,7 +137,7 @@ static u8 cs5535_ratemask(ide_drive_t *d
  */
 static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
 {
-	speed = ide_rate_filter(cs5535_ratemask(drive), speed);
+	speed = ide_rate_filter(drive, speed);
 	ide_config_drive_speed(drive, speed);
 	cs5535_set_speed(drive, speed);
 
@@ -180,9 +166,7 @@ static void cs5535_tuneproc(ide_drive_t 
 
 static int cs5535_config_drive_for_dma(ide_drive_t *drive)
 {
-	u8 speed;
-
-	speed = ide_dma_speed(drive, cs5535_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	/* If no DMA speed was available then let dma_check hit pio */
 	if (!speed) {
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -43,15 +43,10 @@
 
 #define HPT343_DEBUG_DRIVE_INFO		0
 
-static u8 hpt34x_ratemask (ide_drive_t *drive)
-{
-	return 1;
-}
-
 static int hpt34x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u8 speed	= ide_rate_filter(hpt34x_ratemask(drive), xferspeed);
+	u8 speed = ide_rate_filter(drive, xferspeed);
 	u32 reg1= 0, tmp1 = 0, reg2 = 0, tmp2 = 0;
 	u8			hi_speed, lo_speed;
 
@@ -98,7 +93,7 @@ static void hpt34x_tune_drive (ide_drive
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, hpt34x_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!(speed))
 		return 0;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -513,43 +513,31 @@ static int check_in_drive_list(ide_drive
 	return 0;
 }
 
-static u8 hpt3xx_ratemask(ide_drive_t *drive)
-{
-	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
-	u8 mode			= info->max_mode;
-
-	if (!eighty_ninty_three(drive) && mode)
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
 /*
  *	Note for the future; the SATA hpt37x we must set
  *	either PIO or UDMA modes 0,4,5
  */
- 
-static u8 hpt3xx_ratefilter(ide_drive_t *drive, u8 speed)
+
+static u8 hpt3xx_filter_udma_mask(ide_drive_t *drive)
 {
 	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
 	u8 chip_type		= info->chip_type;
-	u8 mode			= hpt3xx_ratemask(drive);
-
-	if (drive->media != ide_disk)
-		return min(speed, (u8)XFER_PIO_4);
+	u8 mode			= info->max_mode;
+	u8 mask;
 
 	switch (mode) {
 		case 0x04:
-			speed = min_t(u8, speed, XFER_UDMA_6);
+			mask = 0x7f;
 			break;
 		case 0x03:
-			speed = min_t(u8, speed, XFER_UDMA_5);
+			mask = 0x3f;
 			if (chip_type >= HPT374)
 				break;
 			if (!check_in_drive_list(drive, bad_ata100_5))
 				goto check_bad_ata33;
 			/* fall thru */
 		case 0x02:
-			speed = min_t(u8, speed, XFER_UDMA_4);
+			mask = 0x1f;
 
 			/*
 			 * CHECK ME, Does this need to be changed to HPT374 ??
@@ -560,13 +548,13 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
 			    !check_in_drive_list(drive, bad_ata66_4))
 				goto check_bad_ata33;
 
-			speed = min_t(u8, speed, XFER_UDMA_3);
+			mask = 0x0f;
 			if (HPT366_ALLOW_ATA66_3 &&
 			    !check_in_drive_list(drive, bad_ata66_3))
 				goto check_bad_ata33;
 			/* fall thru */
 		case 0x01:
-			speed = min_t(u8, speed, XFER_UDMA_2);
+			mask = 0x07;
 
 		check_bad_ata33:
 			if (chip_type >= HPT370A)
@@ -576,10 +564,10 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
 			/* fall thru */
 		case 0x00:
 		default:
-			speed = min_t(u8, speed, XFER_MW_DMA_2);
+			mask = 0x00;
 			break;
 	}
-	return speed;
+	return mask;
 }
 
 static u32 get_speed_setting(u8 speed, struct hpt_info *info)
@@ -607,12 +595,19 @@ static int hpt36x_tune_chipset(ide_drive
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
+	u8  speed		= ide_rate_filter(drive, xferspeed);
 	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
-	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0x30070000 :
-				 (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
-	u32 new_itr		= get_speed_setting(speed, info);
 	u32 old_itr		= 0;
+	u32 itr_mask, new_itr;
+
+	/* TODO: move this to ide_rate_filter() [ check ->atapi_dma ] */
+	if (drive->media != ide_disk)
+		speed = min_t(u8, speed, XFER_PIO_4);
+
+	itr_mask = speed < XFER_MW_DMA_0 ? 0x30070000 :
+		  (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
+
+	new_itr = get_speed_setting(speed, info);
 
 	/*
 	 * Disable on-chip PIO FIFO/buffer (and PIO MST mode as well)
@@ -632,12 +627,19 @@ static int hpt37x_tune_chipset(ide_drive
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
+	u8  speed		= ide_rate_filter(drive, xferspeed);
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
-	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0x303c0000 :
-				 (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
-	u32 new_itr		= get_speed_setting(speed, info);
 	u32 old_itr		= 0;
+	u32 itr_mask, new_itr;
+
+	/* TODO: move this to ide_rate_filter() [ check ->atapi_dma ] */
+	if (drive->media != ide_disk)
+		speed = min_t(u8, speed, XFER_PIO_4);
+
+	itr_mask = speed < XFER_MW_DMA_0 ? 0x303c0000 :
+		  (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
+
+	new_itr = get_speed_setting(speed, info);
 
 	pci_read_config_dword(dev, itr_addr, &old_itr);
 	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
@@ -675,7 +677,7 @@ static void hpt3xx_tune_drive(ide_drive_
  */
 static int config_chipset_for_dma(ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, hpt3xx_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
@@ -1270,6 +1272,7 @@ static void __devinit init_hwif_hpt366(i
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
 	hwif->busproc			= &hpt3xx_busproc;
+	hwif->filter_udma_mask		= &hpt3xx_filter_udma_mask;
 
 	/*
 	 * HPT3xxN chips have some complications:
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -17,22 +17,6 @@
 
 #include <asm/io.h>
 
-/*
- *	it8213_ratemask	-	Compute available modes
- *	@drive: IDE drive
- *
- *	Compute the available speeds for the devices on the interface. This
- *	is all modes to ATA133 clipped by drive cable setup.
- */
-
-static u8 it8213_ratemask (ide_drive_t *drive)
-{
-	u8 mode	= 4;
-	if (!eighty_ninty_three(drive))
-		mode = min_t(u8, mode, 1);
-	return mode;
-}
-
 /**
  *	it8213_dma_2_pio		-	return the PIO mode matching DMA
  *	@xfer_rate: transfer speed
@@ -145,7 +129,7 @@ static int it8213_tune_chipset (ide_driv
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= 0x40;
-	u8 speed		= ide_rate_filter(it8213_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int a_speed		= 3 << (drive->dn * 4);
 	int u_flag		= 1 << drive->dn;
 	int v_flag		= 0x01 << drive->dn;
@@ -222,7 +206,7 @@ static int it8213_tune_chipset (ide_driv
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, it8213_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -224,22 +224,6 @@ static void it821x_clock_strategy(ide_dr
 }
 
 /**
- *	it821x_ratemask	-	Compute available modes
- *	@drive: IDE drive
- *
- *	Compute the available speeds for the devices on the interface. This
- *	is all modes to ATA133 clipped by drive cable setup.
- */
-
-static u8 it821x_ratemask (ide_drive_t *drive)
-{
-	u8 mode	= 4;
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
-/**
  *	it821x_tuneproc	-	tune a drive
  *	@drive: drive to tune
  *	@mode_wanted: the target operating mode
@@ -448,7 +432,7 @@ static int it821x_tune_chipset (ide_driv
 
 	ide_hwif_t *hwif	= drive->hwif;
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
-	u8 speed		= ide_rate_filter(it821x_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 
 	if(!itdev->smart) {
 		switch(speed) {
@@ -496,7 +480,7 @@ static int it821x_tune_chipset (ide_driv
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed	= ide_dma_speed(drive, it821x_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (speed) {
 		config_it821x_chipset_for_pio(drive, 0);
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -22,22 +22,6 @@ typedef enum {
 } port_type;
 
 /**
- *	jmicron_ratemask	-	Compute available modes
- *	@drive: IDE drive
- *
- *	Compute the available speeds for the devices on the interface. This
- *	is all modes to ATA133 clipped by drive cable setup.
- */
-
-static u8 jmicron_ratemask(ide_drive_t *drive)
-{
-	u8 mode	= 4;
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
-/**
  *	ata66_jmicron		-	Cable check
  *	@hwif: IDE port
  *
@@ -129,8 +113,7 @@ static void config_jmicron_chipset_for_p
 
 static int jmicron_tune_chipset (ide_drive_t *drive, byte xferspeed)
 {
-
-	u8 speed		= ide_rate_filter(jmicron_ratemask(drive), xferspeed);
+	u8 speed = ide_rate_filter(drive, xferspeed);
 
 	return ide_config_drive_speed(drive, speed);
 }
@@ -145,7 +128,7 @@ static int jmicron_tune_chipset (ide_dri
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed	= ide_dma_speed(drive, jmicron_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -82,16 +82,6 @@ static u8 max_dma_rate(struct pci_dev *p
 	return mode;
 }
 
-static u8 pdcnew_ratemask(ide_drive_t *drive)
-{
-	u8 mode = max_dma_rate(HWIF(drive)->pci_dev);
-
-	if (!eighty_ninty_three(drive))
-		mode = min_t(u8, mode, 1);
-
-	return	mode;
-}
-
 /**
  * get_indexed_reg - Get indexed register
  * @hwif: for the port address
@@ -164,7 +154,7 @@ static int pdcnew_tune_chipset(ide_drive
 	u8 adj			= (drive->dn & 1) ? 0x08 : 0x00;
 	int			err;
 
-	speed = ide_rate_filter(pdcnew_ratemask(drive), speed);
+	speed = ide_rate_filter(drive, speed);
 
 	/*
 	 * Issue SETFEATURES_XFER to the drive first. PDC202xx hardware will
@@ -270,7 +260,7 @@ static int config_chipset_for_dma(ide_dr
 		set_indexed_reg(hwif, 0x13 + adj, tmp | 0x03);
 	}
 
-	speed = ide_dma_speed(drive, pdcnew_ratemask(drive));
+	speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -100,35 +100,12 @@ static const char *pdc_quirk_drives[] = 
 #define	MC1		0x02	/* DMA"C" timing */
 #define	MC0		0x01	/* DMA"C" timing */
 
-static u8 pdc202xx_ratemask (ide_drive_t *drive)
-{
-	u8 mode;
-
-	switch(HWIF(drive)->pci_dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-			mode = 3;
-			break;
-		case PCI_DEVICE_ID_PROMISE_20263:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			mode = 2;
-			break;
-		case PCI_DEVICE_ID_PROMISE_20246:
-			return 1;
-		default:
-			return 0;
-	}
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
 static int pdc202xx_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 drive_pci		= 0x60 + (drive->dn << 2);
-	u8 speed	= ide_rate_filter(pdc202xx_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 
 	u32			drive_conf;
 	u8			AP, BP, CP, DP;
@@ -318,7 +295,7 @@ chipset_is_set:
 	if (drive->media == ide_disk)	/* PREFETCH_EN */
 		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
 
-	speed = ide_dma_speed(drive, pdc202xx_ratemask(drive));
+	speed = ide_max_dma_mode(drive);
 
 	if (!(speed)) {
 		/* restore original pci-config space */
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -106,68 +106,6 @@
 static int no_piix_dma;
 
 /**
- *	piix_ratemask		-	compute rate mask for PIIX IDE
- *	@drive: IDE drive to compute for
- *
- *	Returns the available modes for the PIIX IDE controller.
- */
- 
-static u8 piix_ratemask (ide_drive_t *drive)
-{
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u8 mode;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801EB_1:
-			mode = 3;
-			break;
-		/* UDMA 100 capable */
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
-		case PCI_DEVICE_ID_INTEL_82801CA_10:
-		case PCI_DEVICE_ID_INTEL_82801CA_11:
-		case PCI_DEVICE_ID_INTEL_82801E_11:
-		case PCI_DEVICE_ID_INTEL_82801DB_1:
-		case PCI_DEVICE_ID_INTEL_82801DB_10:
-		case PCI_DEVICE_ID_INTEL_82801DB_11:
-		case PCI_DEVICE_ID_INTEL_82801EB_11:
-		case PCI_DEVICE_ID_INTEL_ESB_2:
-		case PCI_DEVICE_ID_INTEL_ICH6_19:
-		case PCI_DEVICE_ID_INTEL_ICH7_21:
-		case PCI_DEVICE_ID_INTEL_ESB2_18:
-		case PCI_DEVICE_ID_INTEL_ICH8_6:
-			mode = 3;
-			break;
-		/* UDMA 66 capable */
-		case PCI_DEVICE_ID_INTEL_82801AA_1:
-		case PCI_DEVICE_ID_INTEL_82372FB_1:
-			mode = 2;
-			break;
-		/* UDMA 33 capable */
-		case PCI_DEVICE_ID_INTEL_82371AB:
-		case PCI_DEVICE_ID_INTEL_82443MX_1:
-		case PCI_DEVICE_ID_INTEL_82451NX:
-		case PCI_DEVICE_ID_INTEL_82801AB_1:
-			return 1;
-		/* Non UDMA capable (MWDMA2) */
-		case PCI_DEVICE_ID_INTEL_82371SB_1:
-		case PCI_DEVICE_ID_INTEL_82371FB_1:
-		case PCI_DEVICE_ID_INTEL_82371FB_0:
-		case PCI_DEVICE_ID_INTEL_82371MX:
-		default:
-			return 0;
-	}
-	
-	/*
-	 *	If we are UDMA66 capable fall back to UDMA33 
-	 *	if the drive cannot see an 80pin cable.
-	 */
-	if (!eighty_ninty_three(drive))
-		mode = min_t(u8, mode, 1);
-	return mode;
-}
-
-/**
  *	piix_dma_2_pio		-	return the PIO mode matching DMA
  *	@xfer_rate: transfer speed
  *
@@ -288,7 +226,7 @@ static int piix_tune_chipset (ide_drive_
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	u8 speed		= ide_rate_filter(piix_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int a_speed		= 3 << (drive->dn * 4);
 	int u_flag		= 1 << drive->dn;
 	int v_flag		= 0x01 << drive->dn;
@@ -363,7 +301,7 @@ static int piix_tune_chipset (ide_drive_
  
 static int piix_config_drive_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, piix_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	/*
 	 * If no DMA speed was available or the chipset has DMA bugs
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -65,16 +65,16 @@ static int check_in_drive_lists (ide_dri
 	return 0;
 }
 
-static u8 svwks_ratemask (ide_drive_t *drive)
+static u8 svwks_filter_udma_mask(ide_drive_t *drive)
 {
 	struct pci_dev *dev     = HWIF(drive)->pci_dev;
-	u8 mode = 0;
+	u8 mask = 0;
 
 	if (!svwks_revision)
 		pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);
 
 	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE)
-		return 2;
+		return 0x1f;
 	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
 		u32 reg = 0;
 		if (isa_dev)
@@ -86,25 +86,31 @@ static u8 svwks_ratemask (ide_drive_t *d
 		if(drive->media == ide_disk)
 			return 0;
 		/* Check the OSB4 DMA33 enable bit */
-		return ((reg & 0x00004000) == 0x00004000) ? 1 : 0;
+		return ((reg & 0x00004000) == 0x00004000) ? 0x07 : 0;
 	} else if (svwks_revision < SVWKS_CSB5_REVISION_NEW) {
-		return 1;
+		return 0x07;
 	} else if (svwks_revision >= SVWKS_CSB5_REVISION_NEW) {
-		u8 btr = 0;
+		u8 btr = 0, mode;
 		pci_read_config_byte(dev, 0x5A, &btr);
 		mode = btr & 0x3;
-		if (!eighty_ninty_three(drive))
-			mode = min(mode, (u8)1);
+
 		/* If someone decides to do UDMA133 on CSB5 the same
 		   issue will bite so be inclusive */
 		if (mode > 2 && check_in_drive_lists(drive, svwks_bad_ata100))
 			mode = 2;
+
+		switch(mode) {
+		case 2:	 mask = 0x1f; break;
+		case 1:	 mask = 0x07; break;
+		default: mask = 0x00; break;
+		}
 	}
 	if (((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 	     (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
-		mode = 2;
-	return mode;
+		mask = 0x1f;
+
+	return mask;
 }
 
 static u8 svwks_csb_check (struct pci_dev *dev)
@@ -141,7 +147,7 @@ static int svwks_tune_chipset (ide_drive
 	if (xferspeed == 255)	/* PIO auto-tuning */
 		speed = XFER_PIO_0 + pio;
 	else
-		speed = ide_rate_filter(svwks_ratemask(drive), xferspeed);
+		speed = ide_rate_filter(drive, xferspeed);
 
 	/* If we are about to put a disk into UDMA mode we screwed up.
 	   Our code assumes we never _ever_ do this on an OSB4 */
@@ -304,7 +310,7 @@ static void svwks_tune_drive (ide_drive_
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, svwks_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!(speed))
 		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
@@ -500,6 +506,7 @@ static void __devinit init_hwif_svwks (i
 
 	hwif->tuneproc = &svwks_tune_drive;
 	hwif->speedproc = &svwks_tune_chipset;
+	hwif->filter_udma_mask = &svwks_filter_udma_mask;
 
 	hwif->atapi_dma = 1;
 
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -116,45 +116,41 @@ static inline unsigned long siimage_seld
 }
 
 /**
- *	siimage_ratemask	-	Compute available modes
- *	@drive: IDE drive
+ *	sil_filter_udma_mask	-	compute UDMA mask
+ *	@drive: IDE device
+ *
+ *	Compute the available UDMA speeds for the device on the interface.
  *
- *	Compute the available speeds for the devices on the interface.
  *	For the CMD680 this depends on the clocking mode (scsc), for the
- *	SI3312 SATA controller life is a bit simpler. Enforce UDMA33
- *	as a limit if there is no 80pin cable present.
+ *	SI3112 SATA controller life is a bit simpler.
  */
- 
-static byte siimage_ratemask (ide_drive_t *drive)
+
+static u8 sil_filter_udma_mask(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 mode	= 0, scsc = 0;
+	ide_hwif_t *hwif = drive->hwif;
 	unsigned long base = (unsigned long) hwif->hwif_data;
+	u8 mask = 0, scsc = 0;
 
 	if (hwif->mmio)
 		scsc = hwif->INB(base + 0x4A);
 	else
 		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
 
-	if(is_sata(hwif))
-	{
-		if(strstr(drive->id->model, "Maxtor"))
-			return 3;
-		return 4;
+	if (is_sata(hwif)) {
+		mask = strstr(drive->id->model, "Maxtor") ? 0x3f : 0x7f;
+		goto out;
 	}
-	
+
 	if ((scsc & 0x30) == 0x10)	/* 133 */
-		mode = 4;
+		mask = 0x7f;
 	else if ((scsc & 0x30) == 0x20)	/* 2xPCI */
-		mode = 4;
+		mask = 0x7f;
 	else if ((scsc & 0x30) == 0x00)	/* 100 */
-		mode = 3;
+		mask = 0x3f;
 	else 	/* Disabled ? */
 		BUG();
-
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
+out:
+	return mask;
 }
 
 /**
@@ -307,7 +303,7 @@ static int siimage_tune_chipset (ide_dri
 	ide_hwif_t *hwif	= HWIF(drive);
 	u16 ultra = 0, multi	= 0;
 	u8 mode = 0, unit	= drive->select.b.unit;
-	u8 speed		= ide_rate_filter(siimage_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 scsc = 0, addr_mask	= ((hwif->channel) ?
 				    ((hwif->mmio) ? 0xF4 : 0x84) :
@@ -390,7 +386,7 @@ static int siimage_tune_chipset (ide_dri
  
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed	= ide_dma_speed(drive, siimage_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	config_chipset_for_pio(drive, !speed);
 
@@ -992,6 +988,7 @@ static void __devinit init_hwif_siimage(
 	hwif->tuneproc	= &siimage_tuneproc;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
+	hwif->filter_udma_mask = &sil_filter_udma_mask;
 
 	if(is_sata(hwif)) {
 		static int first = 1;
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -428,16 +428,6 @@ static int sis_get_info (char *buffer, c
 }
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-static u8 sis5513_ratemask (ide_drive_t *drive)
-{
-	u8 rates[] = { 0, 0, 1, 2, 3, 3, 4, 4 };
-	u8 mode = rates[chipset_family];
-
-	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
-	return mode;
-}
-
 /*
  * Configuration functions
  */
@@ -563,7 +553,7 @@ static int sis5513_tune_chipset (ide_dri
 	u8 drive_pci, reg, speed;
 	u32 regdw;
 
-	speed = ide_rate_filter(sis5513_ratemask(drive), xferspeed);
+	speed = ide_rate_filter(drive, xferspeed);
 
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
@@ -653,7 +643,7 @@ static void sis5513_tune_drive (ide_driv
  */
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	u8 speed	= ide_dma_speed(drive, sis5513_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 #ifdef DEBUG
 	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %x\n",
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -21,15 +21,6 @@
 
 #include <asm/io.h>
 
-static u8 slc90e66_ratemask (ide_drive_t *drive)
-{
-	u8 mode	= 2;
-
-	if (!eighty_ninty_three(drive))
-		mode = min_t(u8, mode, 1);
-	return mode;
-}
-
 static u8 slc90e66_dma_2_pio (u8 xfer_rate) {
 	switch(xfer_rate) {
 		case XFER_UDMA_4:
@@ -119,7 +110,7 @@ static int slc90e66_tune_chipset (ide_dr
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	u8 speed	= ide_rate_filter(slc90e66_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
@@ -168,7 +159,7 @@ static int slc90e66_tune_chipset (ide_dr
 
 static int slc90e66_config_drive_for_dma (ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, slc90e66_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -13,18 +13,13 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static inline u8 tc86c001_ratemask(ide_drive_t *drive)
-{
-	return eighty_ninty_three(drive) ? 2 : 1;
-}
-
 static int tc86c001_tune_chipset(ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long scr_port	= hwif->config_data + (drive->dn ? 0x02 : 0x00);
 	u16 mode, scr		= hwif->INW(scr_port);
 
-	speed = ide_rate_filter(tc86c001_ratemask(drive), speed);
+	speed = ide_rate_filter(drive, speed);
 
 	switch (speed) {
 		case XFER_UDMA_4:	mode = 0x00c0; break;
@@ -174,7 +169,7 @@ static int tc86c001_busproc(ide_drive_t 
 
 static int config_chipset_for_dma(ide_drive_t *drive)
 {
-	u8 speed = ide_dma_speed(drive, tc86c001_ratemask(drive));
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -48,7 +48,7 @@ static int triflex_tune_chipset(ide_driv
 	u16 timing = 0;
 	u32 triflex_timings = 0;
 	u8 unit = (drive->select.b.unit & 0x01);
-	u8 speed = ide_rate_filter(0, xferspeed);
+	u8 speed = ide_rate_filter(drive, xferspeed);
 	
 	pci_read_config_dword(dev, channel_offset, &triflex_timings);
 	
@@ -102,7 +102,7 @@ static void triflex_tune_drive(ide_drive
 
 static int triflex_config_drive_for_dma(ide_drive_t *drive)
 {
-	int speed = ide_dma_speed(drive, 0); /* No ultra speeds */
+	u8 speed = ide_max_dma_mode(drive);
 
 	if (!speed)
 		return 0;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -717,11 +717,8 @@ typedef struct hwif_s {
 	int	(*quirkproc)(ide_drive_t *);
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
-//	/* host rate limiter */
-//	u8	(*ratemask)(ide_drive_t *);
-//	/* device rate limiter */
-//	u8	(*ratefilter)(ide_drive_t *, u8);
 #endif
+	u8 (*filter_udma_mask)(ide_drive_t *);
 
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
 	void (*ata_output_data)(ide_drive_t *, void *, u32);
@@ -1277,6 +1274,7 @@ int ide_in_drive_list(struct hd_driveid 
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 int ide_use_dma(ide_drive_t *);
+u8 ide_max_dma_mode(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
@@ -1303,6 +1301,7 @@ extern int __ide_dma_timeout(ide_drive_t
 
 #else
 static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
+static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
@@ -1347,8 +1346,7 @@ static inline void ide_set_hwifdata (ide
 }
 
 /* ide-lib.c */
-extern u8 ide_dma_speed(ide_drive_t *drive, u8 mode);
-extern u8 ide_rate_filter(u8 mode, u8 speed); 
+u8 ide_rate_filter(ide_drive_t *, u8);
 extern int ide_dma_enable(ide_drive_t *drive);
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
