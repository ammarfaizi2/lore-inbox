Return-Path: <linux-kernel-owner+w=401wt.eu-S932815AbXASA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbXASA2e (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXASA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932815AbXASA2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=nYSvu3LWVZLNt45MXF0PV++P64+Uyi2UmyuKayHRuGtbBpyTkrsoKOGxOpiyzJ38rsZ13FEExtHQKrXXCTGMgmSNBFcYDkDVZwgUveeIGskkxvHYjY4aiy8ojisaRFb/HkNUHZTdtVlovqiA2pH1umShKgrbiSPzjeZtMx3brE0=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:20 +0100
Message-Id: <20070119003220.14846.14258.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: make ide_hwif_t.ide_dma_host_on void

* since ide_hwif_t.ide_dma_host_on is called either when drive->using_dma == 1
  or when return value is discarded make it void, also drop "ide_" prefix
* make __ide_dma_host_on() void and drop "__" prefix

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c      |    8 ++++----
 drivers/ide/cris/ide-cris.c   |    2 +-
 drivers/ide/ide-dma.c         |   17 +++++++----------
 drivers/ide/ide-iops.c        |    2 +-
 drivers/ide/ide.c             |    2 +-
 drivers/ide/mips/au1xxx-ide.c |    8 ++++----
 drivers/ide/pci/atiixp.c      |    6 +++---
 drivers/ide/pci/sgiioc4.c     |   11 +++--------
 drivers/ide/ppc/pmac.c        |    6 ++----
 include/linux/ide.h           |    4 ++--
 10 files changed, 28 insertions(+), 38 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -316,15 +316,15 @@ static void icside_dma_off_quietly(ide_d
 	drive->using_dma = 0;
 }
 
-static int icside_dma_host_on(ide_drive_t *drive)
+static void icside_dma_host_on(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int icside_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
-	return icside_dma_host_on(drive);
+
+	return 0;
 }
 
 static int icside_dma_check(ide_drive_t *drive)
@@ -494,7 +494,7 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->ide_dma_check	= icside_dma_check;
 	hwif->dma_host_off	= icside_dma_host_off;
 	hwif->dma_off_quietly	= icside_dma_off_quietly;
-	hwif->ide_dma_host_on	= icside_dma_host_on;
+	hwif->dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->dma_setup		= icside_dma_setup;
 	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -818,7 +818,7 @@ init_e100_ide (void)
 		hwif->INB = &cris_ide_inb;
 		hwif->INW = &cris_ide_inw;
 		hwif->dma_host_off = &cris_dma_off;
-		hwif->ide_dma_host_on = &cris_dma_on;
+		hwif->dma_host_on = &cris_dma_on;
 		hwif->dma_off_quietly = &cris_dma_off;
 		hwif->udma_four = 0;
 		hwif->ultra_mask = cris_ultra_mask;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -468,14 +468,14 @@ EXPORT_SYMBOL(ide_dma_off);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
- *	__ide_dma_host_on	-	Enable DMA on a host
+ *	ide_dma_host_on	-	Enable DMA on a host
  *	@drive: drive to enable for DMA
  *
  *	Enable DMA on an IDE controller following generic bus mastering
  *	IDE controller behaviour
  */
- 
-int __ide_dma_host_on (ide_drive_t *drive)
+
+void ide_dma_host_on(ide_drive_t *drive)
 {
 	if (drive->using_dma) {
 		ide_hwif_t *hwif	= HWIF(drive);
@@ -483,12 +483,10 @@ int __ide_dma_host_on (ide_drive_t *driv
 		u8 dma_stat		= hwif->INB(hwif->dma_status);
 
 		hwif->OUTB((dma_stat|(1<<(5+unit))), hwif->dma_status);
-		return 0;
 	}
-	return 1;
 }
 
-EXPORT_SYMBOL(__ide_dma_host_on);
+EXPORT_SYMBOL(ide_dma_host_on);
 
 /**
  *	__ide_dma_on		-	Enable DMA on a device
@@ -506,8 +504,7 @@ int __ide_dma_on (ide_drive_t *drive)
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 
-	if (HWIF(drive)->ide_dma_host_on(drive))
-		return 1;
+	drive->hwif->dma_host_on(drive);
 
 	return 0;
 }
@@ -940,8 +937,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->dma_host_off = &ide_dma_host_off;
 	if (!hwif->ide_dma_on)
 		hwif->ide_dma_on = &__ide_dma_on;
-	if (!hwif->ide_dma_host_on)
-		hwif->ide_dma_host_on = &__ide_dma_host_on;
+	if (!hwif->dma_host_on)
+		hwif->dma_host_on = &ide_dma_host_on;
 	if (!hwif->ide_dma_check)
 		hwif->ide_dma_check = &__ide_dma_check;
 	if (!hwif->dma_setup)
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -830,7 +830,7 @@ int ide_config_drive_speed (ide_drive_t 
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (speed >= XFER_SW_DMA_0)
-		hwif->ide_dma_host_on(drive);
+		hwif->dma_host_on(drive);
 	else if (hwif->ide_dma_check)	/* check if host supports DMA */
 		hwif->dma_off_quietly(drive);
 #endif
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -508,7 +508,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
 	hwif->dma_off_quietly		= tmp_hwif->dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
-	hwif->ide_dma_host_on		= tmp_hwif->ide_dma_host_on;
+	hwif->dma_host_on		= tmp_hwif->dma_host_on;
 	hwif->dma_host_off		= tmp_hwif->dma_host_off;
 	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
 	hwif->ide_dma_timeout		= tmp_hwif->ide_dma_timeout;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -438,15 +438,15 @@ static int auide_dma_test_irq(ide_drive_
 	return 0;
 }
 
-static int auide_dma_host_on(ide_drive_t *drive)
+static void auide_dma_host_on(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int auide_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
-	return auide_dma_host_on(drive);
+
+	return 0;
 }
 
 static void auide_dma_host_off(ide_drive_t *drive)
@@ -731,7 +731,7 @@ static int au_ide_probe(struct device *d
 	hwif->dma_setup                 = &auide_dma_setup;
 	hwif->ide_dma_test_irq          = &auide_dma_test_irq;
 	hwif->dma_host_off		= &auide_dma_host_off;
-	hwif->ide_dma_host_on           = &auide_dma_host_on;
+	hwif->dma_host_on		= &auide_dma_host_on;
 	hwif->ide_dma_lostirq           = &auide_dma_lostirq;
 	hwif->ide_dma_on                = &auide_dma_on;
 
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -101,7 +101,7 @@ static u8 atiixp_dma_2_pio(u8 xfer_rate)
 	}
 }
 
-static int atiixp_ide_dma_host_on(ide_drive_t *drive)
+static void atiixp_ide_dma_host_on(ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
@@ -118,7 +118,7 @@ static int atiixp_ide_dma_host_on(ide_dr
 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 
-	return __ide_dma_host_on(drive);
+	ide_dma_host_on(drive);
 }
 
 static void atiixp_ide_dma_host_off(ide_drive_t *drive)
@@ -305,7 +305,7 @@ static void __devinit init_hwif_atiixp(i
 	else
 		hwif->udma_four = 0;
 
-	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
+	hwif->dma_host_on = &atiixp_ide_dma_host_on;
 	hwif->dma_host_off = &atiixp_ide_dma_host_off;
 	hwif->ide_dma_check = &atiixp_dma_check;
 	if (!noautodma)
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -279,7 +279,7 @@ sgiioc4_ide_dma_on(ide_drive_t * drive)
 {
 	drive->using_dma = 1;
 
-	return HWIF(drive)->ide_dma_host_on(drive);
+	return 0;
 }
 
 static void sgiioc4_ide_dma_off_quietly(ide_drive_t *drive)
@@ -307,13 +307,8 @@ sgiioc4_ide_dma_test_irq(ide_drive_t * d
 	return sgiioc4_checkirq(HWIF(drive));
 }
 
-static int
-sgiioc4_ide_dma_host_on(ide_drive_t * drive)
+static void sgiioc4_ide_dma_host_on(ide_drive_t * drive)
 {
-	if (drive->using_dma)
-		return 0;
-
-	return 1;
 }
 
 static void sgiioc4_ide_dma_host_off(ide_drive_t * drive)
@@ -610,7 +605,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
 	hwif->dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
-	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
+	hwif->dma_host_on = &sgiioc4_ide_dma_host_on;
 	hwif->dma_host_off = &sgiioc4_ide_dma_host_off;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1984,10 +1984,8 @@ static void pmac_ide_dma_host_off(ide_dr
 {
 }
 
-static int
-pmac_ide_dma_host_on (ide_drive_t *drive)
+static int pmac_ide_dma_host_on(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int
@@ -2042,7 +2040,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->dma_host_off = &pmac_ide_dma_host_off;
-	hwif->ide_dma_host_on = &pmac_ide_dma_host_on;
+	hwif->dma_host_on = &pmac_ide_dma_host_on;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -737,7 +737,7 @@ typedef struct hwif_s {
 	int (*ide_dma_on)(ide_drive_t *drive);
 	void (*dma_off_quietly)(ide_drive_t *);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
-	int (*ide_dma_host_on)(ide_drive_t *drive);
+	void (*dma_host_on)(ide_drive_t *);
 	void (*dma_host_off)(ide_drive_t *);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
@@ -1290,7 +1290,7 @@ extern void ide_setup_dma(ide_hwif_t *, 
 
 void ide_dma_host_off(ide_drive_t *);
 void ide_dma_off_quietly(ide_drive_t *);
-extern int __ide_dma_host_on(ide_drive_t *);
+void ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);
 extern int ide_dma_setup(ide_drive_t *);
