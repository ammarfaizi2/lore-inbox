Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUBIOrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBIOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:47:12 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6628 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265232AbUBIOqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:46:34 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove ide_dma_{good,bad}_drive from ide_hwif_t
Date: Mon, 9 Feb 2004 15:51:44 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402091551.44365.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use __ide_dma_{good,bad}_drive() directly and remove these wrappers.

 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c          |    8 ++------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c              |    2 --
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/aec62xx.c      |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/alim15x3.c     |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/cmd64x.c       |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/hpt34x.c       |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/hpt366.c       |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/it8172.c       |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_new.c |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_old.c |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/piix.c         |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/serverworks.c  |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c      |    2 --
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/siimage.c      |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sis5513.c      |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sl82c105.c     |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/slc90e66.c     |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c         |    2 --
 linux-2.6.3-rc1-bk1-root/include/linux/ide.h            |    4 ----
 19 files changed, 30 insertions(+), 44 deletions(-)

diff -puN drivers/ide/ide.c~ide_dma_good_bad_cleanup drivers/ide/ide.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.525502560 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c	2004-02-09 15:44:40.611489488 +0100
@@ -844,8 +844,6 @@ void ide_unregister (unsigned int index)
 	hwif->ide_dma_test_irq		= old_hwif.ide_dma_test_irq;
 	hwif->ide_dma_host_on		= old_hwif.ide_dma_host_on;
 	hwif->ide_dma_host_off		= old_hwif.ide_dma_host_off;
-	hwif->ide_dma_bad_drive		= old_hwif.ide_dma_bad_drive;
-	hwif->ide_dma_good_drive	= old_hwif.ide_dma_good_drive;
 	hwif->ide_dma_count		= old_hwif.ide_dma_count;
 	hwif->ide_dma_verbose		= old_hwif.ide_dma_verbose;
 	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
diff -puN drivers/ide/ide-dma.c~ide_dma_good_bad_cleanup drivers/ide/ide-dma.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-dma.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.529501952 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c	2004-02-09 15:44:40.623487664 +0100
@@ -413,7 +413,7 @@ static int config_drive_for_dma (ide_dri
 
 	if ((id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			return hwif->ide_dma_off(drive);
 
 		/*
@@ -432,7 +432,7 @@ static int config_drive_for_dma (ide_dri
 				return hwif->ide_dma_on(drive);
 
 		/* Consult the list of known "good" drives */
-		if (hwif->ide_dma_good_drive(drive))
+		if (__ide_dma_good_drive(drive))
 			return hwif->ide_dma_on(drive);
 	}
 //	if (hwif->tuneproc != NULL) hwif->tuneproc(drive, 255);
@@ -1084,10 +1084,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
 		hwif->ide_dma_test_irq = &__ide_dma_test_irq;
-	if (!hwif->ide_dma_bad_drive)
-		hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
-	if (!hwif->ide_dma_good_drive)
-		hwif->ide_dma_good_drive = &__ide_dma_good_drive;
 	if (!hwif->ide_dma_verbose)
 		hwif->ide_dma_verbose = &__ide_dma_verbose;
 	if (!hwif->ide_dma_timeout)
diff -puN drivers/ide/pci/aec62xx.c~ide_dma_good_bad_cleanup drivers/ide/pci/aec62xx.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/aec62xx.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.534501192 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/aec62xx.c	2004-02-09 15:44:40.624487512 +0100
@@ -330,7 +330,7 @@ static int aec62xx_config_drive_xfer_rat
 
 	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -347,7 +347,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/alim15x3.c~ide_dma_good_bad_cleanup drivers/ide/pci/alim15x3.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/alim15x3.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.539500432 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/alim15x3.c	2004-02-09 15:44:40.626487208 +0100
@@ -516,7 +516,7 @@ static int ali15x3_config_drive_for_dma(
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto ata_pio;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -533,7 +533,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/cmd64x.c~ide_dma_good_bad_cleanup drivers/ide/pci/cmd64x.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/cmd64x.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.543499824 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/cmd64x.c	2004-02-09 15:44:40.627487056 +0100
@@ -459,7 +459,7 @@ static int cmd64x_config_drive_for_dma (
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if ((id->field_valid & 4) && cmd64x_ratemask(drive)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -476,7 +476,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/hpt34x.c~ide_dma_good_bad_cleanup drivers/ide/pci/hpt34x.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/hpt34x.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.548499064 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/hpt34x.c	2004-02-09 15:44:40.628486904 +0100
@@ -190,7 +190,7 @@ static int hpt34x_config_drive_xfer_rate
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -207,7 +207,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/hpt366.c~ide_dma_good_bad_cleanup drivers/ide/pci/hpt366.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/hpt366.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.552498456 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/hpt366.c	2004-02-09 15:44:40.630486600 +0100
@@ -514,7 +514,7 @@ static int hpt366_config_drive_xfer_rate
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -530,7 +530,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/it8172.c~ide_dma_good_bad_cleanup drivers/ide/pci/it8172.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/it8172.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.556497848 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/it8172.c	2004-02-09 15:44:40.634485992 +0100
@@ -202,7 +202,7 @@ static int it8172_config_drive_xfer_rate
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -219,7 +219,7 @@ try_dma_modes:
 				if (!it8172_config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!it8172_config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/pdc202xx_new.c~ide_dma_good_bad_cleanup drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/pdc202xx_new.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.559497392 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_new.c	2004-02-09 15:44:40.636485688 +0100
@@ -393,7 +393,7 @@ static int pdcnew_config_drive_xfer_rate
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -410,7 +410,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			    (id->eide_dma_time < 150)) {
 				goto no_dma_set;
 			/* Consult the list of known "good" drives */
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_dma_good_bad_cleanup drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/pdc202xx_old.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.566496328 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_old.c	2004-02-09 15:44:40.638485384 +0100
@@ -482,7 +482,7 @@ static int pdc202xx_config_drive_xfer_ra
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -499,7 +499,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			    (id->eide_dma_time < 150)) {
 				goto no_dma_set;
 			/* Consult the list of known "good" drives */
diff -puN drivers/ide/pci/piix.c~ide_dma_good_bad_cleanup drivers/ide/pci/piix.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/piix.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.569495872 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/piix.c	2004-02-09 15:44:40.639485232 +0100
@@ -563,7 +563,7 @@ static int piix_config_drive_xfer_rate (
 
 	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -580,7 +580,7 @@ try_dma_modes:
 				if (!piix_config_drive_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!piix_config_drive_for_dma(drive))
diff -puN drivers/ide/pci/serverworks.c~ide_dma_good_bad_cleanup drivers/ide/pci/serverworks.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/serverworks.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.574495112 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/serverworks.c	2004-02-09 15:44:40.641484928 +0100
@@ -464,7 +464,7 @@ static int svwks_config_drive_xfer_rate 
 
 	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -481,7 +481,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_good_bad_cleanup drivers/ide/pci/sgiioc4.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sgiioc4.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.578494504 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c	2004-02-09 15:44:40.642484776 +0100
@@ -649,8 +649,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
 	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
-	hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
-	hwif->ide_dma_good_drive = &__ide_dma_good_drive;
 	hwif->ide_dma_count = &__ide_dma_count;
 	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
diff -puN drivers/ide/pci/siimage.c~ide_dma_good_bad_cleanup drivers/ide/pci/siimage.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/siimage.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.584493592 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/siimage.c	2004-02-09 15:44:40.643484624 +0100
@@ -490,7 +490,7 @@ static int siimage_config_drive_for_dma 
 
 	if ((id->capability & 1) != 0 && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 
 		if ((id->field_valid & 4) && siimage_ratemask(drive)) {
@@ -508,7 +508,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/sis5513.c~ide_dma_good_bad_cleanup drivers/ide/pci/sis5513.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sis5513.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.589492832 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sis5513.c	2004-02-09 15:44:40.644484472 +0100
@@ -671,7 +671,7 @@ static int sis5513_config_drive_xfer_rat
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & hwif->ultra_mask) {
@@ -688,7 +688,7 @@ try_dma_modes:
 				if (!config_chipset_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!config_chipset_for_dma(drive))
diff -puN drivers/ide/pci/sl82c105.c~ide_dma_good_bad_cleanup drivers/ide/pci/sl82c105.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sl82c105.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.592492376 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sl82c105.c	2004-02-09 15:44:40.646484168 +0100
@@ -158,7 +158,7 @@ static int sl82c105_check_drive (ide_dri
 			break;
 
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			break;
 
 		if (id->field_valid & 2) {
@@ -167,7 +167,7 @@ static int sl82c105_check_drive (ide_dri
 				return hwif->ide_dma_on(drive);
 		}
 
-		if (hwif->ide_dma_good_drive(drive))
+		if (__ide_dma_good_drive(drive))
 			return hwif->ide_dma_on(drive);
 	} while (0);
 
diff -puN drivers/ide/pci/slc90e66.c~ide_dma_good_bad_cleanup drivers/ide/pci/slc90e66.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/slc90e66.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.596491768 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/slc90e66.c	2004-02-09 15:44:40.649483712 +0100
@@ -275,7 +275,7 @@ static int slc90e66_config_drive_xfer_ra
 
 	if (id && (id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (hwif->ide_dma_bad_drive(drive))
+		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
 
 		if (id->field_valid & 4) {
@@ -293,7 +293,7 @@ try_dma_modes:
 				if (!slc90e66_config_drive_for_dma(drive))
 					goto no_dma_set;
 			}
-		} else if (hwif->ide_dma_good_drive(drive) &&
+		} else if (__ide_dma_good_drive(drive) &&
 			   (id->eide_dma_time < 150)) {
 			/* Consult the list of known "good" drives */
 			if (!slc90e66_config_drive_for_dma(drive))
diff -puN drivers/ide/ppc/pmac.c~ide_dma_good_bad_cleanup drivers/ide/ppc/pmac.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ppc/pmac.c~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.601491008 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c	2004-02-09 15:44:40.650483560 +0100
@@ -2160,8 +2160,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
 	hwif->ide_dma_host_on = &pmac_ide_dma_host_on;
-	hwif->ide_dma_good_drive = &__ide_dma_good_drive;
-	hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
 	hwif->ide_dma_verbose = &__ide_dma_verbose;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
diff -puN include/linux/ide.h~ide_dma_good_bad_cleanup include/linux/ide.h
--- linux-2.6.3-rc1-bk1/include/linux/ide.h~ide_dma_good_bad_cleanup	2004-02-09 15:44:40.605490400 +0100
+++ linux-2.6.3-rc1-bk1-root/include/linux/ide.h	2004-02-09 15:44:40.653483104 +0100
@@ -795,8 +795,6 @@ typedef struct ide_dma_ops_s {
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_bad_drive)(ide_drive_t *drive);
-	int (*ide_dma_good_drive)(ide_drive_t *drive);
 	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
@@ -934,8 +932,6 @@ typedef struct hwif_s {
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_bad_drive)(ide_drive_t *drive);
-	int (*ide_dma_good_drive)(ide_drive_t *drive);
 	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);

_

