Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272123AbTHNBYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 21:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272127AbTHNBYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 21:24:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51876 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272123AbTHNBYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 21:24:01 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: [PATCH] ide: limit drive capacity to 137GB if host doesn't support LBA48
Date: Thu, 14 Aug 2003 03:24:45 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308140324.45524.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think this simple patch is sufficient.

Block layer shouldn't issue request for sectors > capacity so
there is no need to add additional checks to __do_rw_disk().

--bartlomiej

ide: limit drive capacity to 137GB if host doesn't support LBA48

Noticed by Andries.Brouwer@cwi.nl.

Also:
- kill probe_lba_addressing() wrapper
- rename hwif->addressing to hwif->no_lba48


 drivers/ide/ide-disk.c         |   26 ++++++++++++++++++--------
 drivers/ide/ide-probe.c        |    2 +-
 drivers/ide/ide.c              |    2 +-
 drivers/ide/legacy/pdc4030.c   |    2 +-
 drivers/ide/pci/alim15x3.c     |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    2 +-
 drivers/ide/pci/siimage.c      |    2 +-
 drivers/ide/pci/trm290.c       |    2 +-
 include/linux/ide.h            |    2 +-
 9 files changed, 26 insertions(+), 16 deletions(-)

diff -puN drivers/ide/ide.c~ide-disk-no-lba48-fix drivers/ide/ide.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide.c~ide-disk-no-lba48-fix	2003-08-14 02:47:38.877667440 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide.c	2003-08-14 02:47:57.257873224 +0200
@@ -904,7 +904,7 @@ void ide_unregister (unsigned int index)
 
 	hwif->mmio			= old_hwif.mmio;
 	hwif->rqsize			= old_hwif.rqsize;
-	hwif->addressing		= old_hwif.addressing;
+	hwif->no_lba48			= old_hwif.no_lba48;
 #ifndef CONFIG_BLK_DEV_IDECS
 	hwif->irq			= old_hwif.irq;
 #endif /* CONFIG_BLK_DEV_IDECS */
diff -puN drivers/ide/ide-disk.c~ide-disk-no-lba48-fix drivers/ide/ide-disk.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide-disk.c~ide-disk-no-lba48-fix	2003-08-14 02:32:50.571710472 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide-disk.c	2003-08-14 03:03:02.895195424 +0200
@@ -1445,11 +1445,17 @@ static int set_using_tcq(ide_drive_t *dr
 }
 #endif
 
-static int probe_lba_addressing (ide_drive_t *drive, int arg)
+/*
+ * drive->addressing:
+ *	0: 28-bit
+ *	1: 48-bit
+ *	2: 48-bit capable doing 28-bit
+ */
+static int set_lba_addressing(ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
 
-	if (HWIF(drive)->addressing)
+	if (HWIF(drive)->no_lba48)
 		return 0;
 
 	if (!idedisk_supports_lba48(drive->id))
@@ -1458,11 +1464,6 @@ static int probe_lba_addressing (ide_dri
 	return 0;
 }
 
-static int set_lba_addressing (ide_drive_t *drive, int arg)
-{
-	return probe_lba_addressing(drive, arg);
-}
-
 static void idedisk_add_settings(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1578,7 +1579,7 @@ static void idedisk_setup (ide_drive_t *
 		}
 	}
 
-	(void) probe_lba_addressing(drive, 1);
+	(void)set_lba_addressing(drive, 1);
 
 	if (drive->addressing == 1) {
 		ide_hwif_t *hwif = HWIF(drive);
@@ -1617,6 +1618,15 @@ static void idedisk_setup (ide_drive_t *
 	/* calculate drive capacity, and select LBA if possible */
 	init_idedisk_capacity (drive);
 
+	/* limit drive capacity to 137GB if LBA48 cannot be used */
+	if (drive->addressing == 0 && drive->capacity64 > 1ULL << 28) {
+		printk("%s: cannot use LBA48 - full capacity "
+		       "%llu sectors (%llu MB)\n",
+		       drive->name,
+		       drive->capacity64, sectors_to_MB(drive->capacity64));
+		drive->capacity64 = 1ULL << 28;
+	}
+
 	/*
 	 * if possible, give fdisk access to more of the drive,
 	 * by correcting bios_cyls:
diff -puN drivers/ide/ide-probe.c~ide-disk-no-lba48-fix drivers/ide/ide-probe.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide-probe.c~ide-disk-no-lba48-fix	2003-08-14 02:48:07.696286344 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide-probe.c	2003-08-14 02:48:15.649077336 +0200
@@ -930,7 +930,7 @@ static int ide_init_queue(ide_drive_t *d
 	blk_queue_segment_boundary(q, 0xffff);
 
 	if (!hwif->rqsize)
-		hwif->rqsize = hwif->addressing ? 256 : 65536;
+		hwif->rqsize = hwif->no_lba48 ? 256 : 65536;
 	if (hwif->rqsize < max_sectors)
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
diff -puN drivers/ide/legacy/pdc4030.c~ide-disk-no-lba48-fix drivers/ide/legacy/pdc4030.c
--- linux-2.6.0-test2-bk7/drivers/ide/legacy/pdc4030.c~ide-disk-no-lba48-fix	2003-08-14 02:46:06.325737472 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/legacy/pdc4030.c	2003-08-14 02:46:21.465435888 +0200
@@ -227,7 +227,7 @@ int __init setup_pdc4030(ide_hwif_t *hwi
 	hwif2->mate	= hwif;
 	hwif2->channel	= 1;
 	hwif->rqsize	= hwif2->rqsize = 127;
-	hwif->addressing = hwif2->addressing = 1;
+	hwif->no_lba48 = hwif2->no_lba48 = 1;
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 	/* DC4030 hosted drives need their own identify... */
diff -puN drivers/ide/pci/alim15x3.c~ide-disk-no-lba48-fix drivers/ide/pci/alim15x3.c
--- linux-2.6.0-test2-bk7/drivers/ide/pci/alim15x3.c~ide-disk-no-lba48-fix	2003-08-14 02:44:37.468245864 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/pci/alim15x3.c	2003-08-14 02:44:57.401215592 +0200
@@ -745,7 +745,7 @@ static void __init init_hwif_common_ali1
 	hwif->speedproc = &ali15x3_tune_chipset;
 
 	/* Don't use LBA48 on ALi devices before rev 0xC5 */
-	hwif->addressing = (m5229_revision <= 0xC4) ? 1 : 0;
+	hwif->no_lba48 = (m5229_revision <= 0xC4) ? 1 : 0;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
diff -puN drivers/ide/pci/pdc202xx_old.c~ide-disk-no-lba48-fix drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.0-test2-bk7/drivers/ide/pci/pdc202xx_old.c~ide-disk-no-lba48-fix	2003-08-14 02:45:30.043253248 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/pci/pdc202xx_old.c	2003-08-14 02:45:49.325321928 +0200
@@ -750,7 +750,7 @@ static void __init init_hwif_pdc202xx (i
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
 	if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
-		hwif->addressing = (hwif->channel) ? 0 : 1;
+		hwif->no_lba48 = (hwif->channel) ? 0 : 1;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		hwif->busproc   = &pdc202xx_tristate;
diff -puN drivers/ide/pci/siimage.c~ide-disk-no-lba48-fix drivers/ide/pci/siimage.c
--- linux-2.6.0-test2-bk7/drivers/ide/pci/siimage.c~ide-disk-no-lba48-fix	2003-08-14 02:45:06.437841816 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/pci/siimage.c	2003-08-14 02:45:20.050772336 +0200
@@ -724,7 +724,7 @@ static void __init init_mmio_iops_siimag
 	}
 
 #ifdef SIIMAGE_BUFFERED_TASKFILE
-        hwif->addressing = 1;
+	hwif->no_lba48 = 1;
 #endif /* SIIMAGE_BUFFERED_TASKFILE */
 	hwif->irq			= hw.irq;
 	hwif->hwif_data			= pci_get_drvdata(hwif->pci_dev);
diff -puN drivers/ide/pci/trm290.c~ide-disk-no-lba48-fix drivers/ide/pci/trm290.c
--- linux-2.6.0-test2-bk7/drivers/ide/pci/trm290.c~ide-disk-no-lba48-fix	2003-08-14 02:44:11.963123232 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/pci/trm290.c	2003-08-14 02:44:28.650586352 +0200
@@ -309,7 +309,7 @@ void __init init_hwif_trm290 (ide_hwif_t
 	u8 reg = 0;
 	struct pci_dev *dev = hwif->pci_dev;
 
-	hwif->addressing = 1;
+	hwif->no_lba48 = 1;
 	hwif->chipset = ide_trm290;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase) {
diff -puN include/linux/ide.h~ide-disk-no-lba48-fix include/linux/ide.h
--- linux-2.6.0-test2-bk7/include/linux/ide.h~ide-disk-no-lba48-fix	2003-08-14 02:48:24.553723624 +0200
+++ linux-2.6.0-test2-bk7-root/include/linux/ide.h	2003-08-14 02:59:59.076140168 +0200
@@ -1007,7 +1007,6 @@ typedef struct hwif_s {
 
 	int		mmio;		/* hosts iomio (0), mmio (1) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
-	int		addressing;	/* hosts addressing */
 	int		irq;		/* our irq number */
 	int		initializing;	/* set while initializing self */
 
@@ -1036,6 +1035,7 @@ typedef struct hwif_s {
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* auto-attempt using DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned	no_lba48   : 1; /* 1 = cannot do LBA48 */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 

_

