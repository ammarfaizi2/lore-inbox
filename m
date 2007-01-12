Return-Path: <linux-kernel-owner+w=401wt.eu-S1030510AbXALE0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbXALE0y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbXALEXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:23:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030490AbXALEX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:28 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=Ex71NEPxrDRQkT/+Zci3/i9u2ITv4CNF8A3NUflc6RTNXihYQSW62DTH1BXRjA+rFid3bvwEIuBZuU13V7AjkOAHRswQlMs0tTMebmD7SvRQdml0ZA3vlM0bQcPTOR34UuhNQoYoFiHiW/8oTBWDf7mSp9AR/XYCzipDRwFNJJ0=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:04 +0100
Message-Id: <20070112042704.28794.1506.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 9/19] ide: remove write-only ide_hwif_t.no_dsc flag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: remove write-only ide_hwif_t.no_dsc flag

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-cd.c      |    8 --------
 drivers/ide/ide.c         |    1 -
 drivers/ide/pci/aec62xx.c |    4 +---
 drivers/ide/pci/hpt34x.c  |    1 -
 include/linux/ide.h       |    1 -
 5 files changed, 1 insertion(+), 14 deletions(-)

Index: a/drivers/ide/ide-cd.c
===================================================================
--- a.orig/drivers/ide/ide-cd.c
+++ a/drivers/ide/ide-cd.c
@@ -3247,14 +3247,6 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	if (drive->autotune == IDE_TUNE_DEFAULT ||
 	    drive->autotune == IDE_TUNE_AUTO)
 		drive->dsc_overlap = (drive->next != drive);
-#if 0
-	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
-	if (HWIF(drive)->no_dsc) {
-		printk(KERN_INFO "ide-cd: %s: disabling DSC overlap\n",
-			drive->name);
-		drive->dsc_overlap = 0;
-	}
-#endif
 
 	if (ide_cdrom_register(drive, nslots)) {
 		printk (KERN_ERR "%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
Index: a/drivers/ide/ide.c
===================================================================
--- a.orig/drivers/ide/ide.c
+++ a/drivers/ide/ide.c
@@ -545,7 +545,6 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->extra_ports		= tmp_hwif->extra_ports;
 	hwif->autodma			= tmp_hwif->autodma;
 	hwif->udma_four			= tmp_hwif->udma_four;
-	hwif->no_dsc			= tmp_hwif->no_dsc;
 
 	hwif->hwif_data			= tmp_hwif->hwif_data;
 }
Index: a/drivers/ide/pci/aec62xx.c
===================================================================
--- a.orig/drivers/ide/pci/aec62xx.c
+++ a/drivers/ide/pci/aec62xx.c
@@ -286,10 +286,8 @@ static void __devinit init_hwif_aec62xx(
 	hwif->tuneproc = &aec62xx_tune_drive;
 	hwif->speedproc = &aec62xx_tune_chipset;
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
+	if (hwif->pci_dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
 		hwif->serialized = hwif->channel;
-		hwif->no_dsc = 1;
-	}
 
 	if (hwif->mate)
 		hwif->mate->serialized = hwif->serialized;
Index: a/drivers/ide/pci/hpt34x.c
===================================================================
--- a.orig/drivers/ide/pci/hpt34x.c
+++ a/drivers/ide/pci/hpt34x.c
@@ -209,7 +209,6 @@ static void __devinit init_hwif_hpt34x(i
 
 	hwif->tuneproc = &hpt34x_tune_drive;
 	hwif->speedproc = &hpt34x_tune_chipset;
-	hwif->no_dsc = 1;
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
Index: a/include/linux/ide.h
===================================================================
--- a.orig/include/linux/ide.h
+++ a/include/linux/ide.h
@@ -791,7 +791,6 @@ typedef struct hwif_s {
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned	no_lba48   : 1; /* 1 = cannot do LBA48 */
 	unsigned	no_lba48_dma : 1; /* 1 = cannot do LBA48 DMA */
-	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
