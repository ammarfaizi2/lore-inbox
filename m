Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUBIOs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUBIOs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:48:27 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27620 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265246AbUBIOr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:47:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove __ide_dma_count() and ide_hwif_t->ide_dma_count
Date: Mon, 9 Feb 2004 15:53:07 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402091553.07941.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to "[PATCH] remove ide_dma_{good,bad}_drive from ide_hwif_t".

->ide_dma_count() was introduced in kernel 2.5.35 and was meant to add support
for host FIFO counters (for VDMA), but is only a wrapper for ->ide_dma_begin()
(even for siimage.c b/c SIIMAGE_VIRTUAL_DMAPIO is undefined).

Moreover it should be possible to add VDMA code directly to ->ide_dma_begin().

 linux-2.6.3-rc1-bk1-root/drivers/ide/arm/icside.c  |    6 ------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c     |   17 ++---------------
 linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c         |    1 -
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c |    1 -
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/siimage.c |    3 ++-
 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/trm290.c  |    4 ++--
 linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c    |    7 -------
 linux-2.6.3-rc1-bk1-root/include/linux/ide.h       |    3 ---
 8 files changed, 6 insertions(+), 36 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide_dma_count_cleanup drivers/ide/arm/icside.c
--- linux-2.6.3-rc1-bk1/drivers/ide/arm/icside.c~ide_dma_count_cleanup	2004-02-09 15:45:44.561767568 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/arm/icside.c	2004-02-09 15:45:44.596762248 +0100
@@ -428,11 +428,6 @@ static int icside_dma_begin(ide_drive_t 
 	return 0;
 }
 
-static int icside_dma_count(ide_drive_t *drive)
-{
-	return icside_dma_begin(drive);
-}
-
 /*
  * dma_intr() is the handler for disk read/write DMA interrupts
  */
@@ -653,7 +648,6 @@ static int icside_dma_init(ide_hwif_t *h
 	hwif->ide_dma_on	= icside_dma_on;
 	hwif->ide_dma_read	= icside_dma_read;
 	hwif->ide_dma_write	= icside_dma_write;
-	hwif->ide_dma_count	= icside_dma_count;
 	hwif->ide_dma_begin	= icside_dma_begin;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
diff -puN drivers/ide/ide.c~ide_dma_count_cleanup drivers/ide/ide.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide.c~ide_dma_count_cleanup	2004-02-09 15:45:44.565766960 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide.c	2004-02-09 15:45:44.599761792 +0100
@@ -844,7 +844,6 @@ void ide_unregister (unsigned int index)
 	hwif->ide_dma_test_irq		= old_hwif.ide_dma_test_irq;
 	hwif->ide_dma_host_on		= old_hwif.ide_dma_host_on;
 	hwif->ide_dma_host_off		= old_hwif.ide_dma_host_off;
-	hwif->ide_dma_count		= old_hwif.ide_dma_count;
 	hwif->ide_dma_verbose		= old_hwif.ide_dma_verbose;
 	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
 	hwif->ide_dma_timeout		= old_hwif.ide_dma_timeout;
diff -puN drivers/ide/ide-dma.c~ide_dma_count_cleanup drivers/ide/ide-dma.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ide-dma.c~ide_dma_count_cleanup	2004-02-09 15:45:44.569766352 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ide-dma.c	2004-02-09 15:45:44.601761488 +0100
@@ -662,7 +662,7 @@ int __ide_dma_read (ide_drive_t *drive /
 
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
-	return HWIF(drive)->ide_dma_count(drive);
+	return hwif->ide_dma_begin(drive);
 }
 
 EXPORT_SYMBOL(__ide_dma_read);
@@ -694,7 +694,7 @@ int __ide_dma_write (ide_drive_t *drive 
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
 
-	return HWIF(drive)->ide_dma_count(drive);
+	return hwif->ide_dma_begin(drive);
 }
 
 EXPORT_SYMBOL(__ide_dma_write);
@@ -791,17 +791,6 @@ int __ide_dma_good_drive (ide_drive_t *d
 EXPORT_SYMBOL(__ide_dma_good_drive);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-/*
- * Used for HOST FIFO counters for VDMA
- * PIO over DMA, effective ATA-Bridge operator.
- */
-int __ide_dma_count (ide_drive_t *drive)
-{
-	return HWIF(drive)->ide_dma_begin(drive);
-}
-
-EXPORT_SYMBOL(__ide_dma_count);
-
 int __ide_dma_verbose (ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
@@ -1076,8 +1065,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_read = &__ide_dma_read;
 	if (!hwif->ide_dma_write)
 		hwif->ide_dma_write = &__ide_dma_write;
-	if (!hwif->ide_dma_count)
-		hwif->ide_dma_count = &__ide_dma_count;
 	if (!hwif->ide_dma_begin)
 		hwif->ide_dma_begin = &__ide_dma_begin;
 	if (!hwif->ide_dma_end)
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_count_cleanup drivers/ide/pci/sgiioc4.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/sgiioc4.c~ide_dma_count_cleanup	2004-02-09 15:45:44.576765288 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/sgiioc4.c	2004-02-09 15:45:44.602761336 +0100
@@ -649,7 +649,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
 	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
-	hwif->ide_dma_count = &__ide_dma_count;
 	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
diff -puN drivers/ide/pci/siimage.c~ide_dma_count_cleanup drivers/ide/pci/siimage.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/siimage.c~ide_dma_count_cleanup	2004-02-09 15:45:44.580764680 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/siimage.c	2004-02-09 15:45:44.605760880 +0100
@@ -545,6 +545,7 @@ static int siimage_io_ide_dma_test_irq (
 	return 0;
 }
 
+#if 0
 /**
  *	siimage_mmio_ide_dma_count	-	DMA bytes done
  *	@drive
@@ -572,6 +573,7 @@ static int siimage_mmio_ide_dma_count (i
 #endif /* SIIMAGE_VIRTUAL_DMAPIO */
 	return __ide_dma_count(drive);
 }
+#endif
 
 /**
  *	siimage_mmio_ide_dma_test_irq	-	check we caused an IRQ
@@ -1133,7 +1135,6 @@ static void __init init_hwif_siimage (id
 		hwif->udma_four = ata66_siimage(hwif);
 
 	if (hwif->mmio) {
-		hwif->ide_dma_count = &siimage_mmio_ide_dma_count;
 		hwif->ide_dma_test_irq = &siimage_mmio_ide_dma_test_irq;
 		hwif->ide_dma_verbose = &siimage_mmio_ide_dma_verbose;
 	} else {
diff -puN drivers/ide/pci/trm290.c~ide_dma_count_cleanup drivers/ide/pci/trm290.c
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/trm290.c~ide_dma_count_cleanup	2004-02-09 15:45:44.583764224 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/trm290.c	2004-02-09 15:45:44.607760576 +0100
@@ -225,7 +225,7 @@ static int trm290_ide_dma_write (ide_dri
 #endif
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
-	return HWIF(drive)->ide_dma_count(drive);
+	return hwif->ide_dma_begin(drive);
 }
 
 static int trm290_ide_dma_read (ide_drive_t *drive  /*, struct request *rq */)
@@ -269,7 +269,7 @@ static int trm290_ide_dma_read (ide_driv
 #endif
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
-	return HWIF(drive)->ide_dma_count(drive);
+	return hwif->ide_dma_begin(drive);
 }
 
 static int trm290_ide_dma_begin (ide_drive_t *drive)
diff -puN drivers/ide/ppc/pmac.c~ide_dma_count_cleanup drivers/ide/ppc/pmac.c
--- linux-2.6.3-rc1-bk1/drivers/ide/ppc/pmac.c~ide_dma_count_cleanup	2004-02-09 15:45:44.587763616 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/ppc/pmac.c	2004-02-09 15:45:44.608760424 +0100
@@ -1977,12 +1977,6 @@ pmac_ide_dma_write (ide_drive_t *drive)
 	return pmac_ide_dma_begin(drive);
 }
 
-static int __pmac
-pmac_ide_dma_count (ide_drive_t *drive)
-{
-	return HWIF(drive)->ide_dma_begin(drive);
-}
-
 /*
  * Kick the DMA controller into life after the DMA command has been issued
  * to the drive.
@@ -2154,7 +2148,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->ide_dma_read = &pmac_ide_dma_read;
 	hwif->ide_dma_write = &pmac_ide_dma_write;
-	hwif->ide_dma_count = &pmac_ide_dma_count;
 	hwif->ide_dma_begin = &pmac_ide_dma_begin;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
diff -puN include/linux/ide.h~ide_dma_count_cleanup include/linux/ide.h
--- linux-2.6.3-rc1-bk1/include/linux/ide.h~ide_dma_count_cleanup	2004-02-09 15:45:44.592762856 +0100
+++ linux-2.6.3-rc1-bk1-root/include/linux/ide.h	2004-02-09 15:45:44.610760120 +0100
@@ -795,7 +795,6 @@ typedef struct ide_dma_ops_s {
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
@@ -932,7 +931,6 @@ typedef struct hwif_s {
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
@@ -1618,7 +1616,6 @@ extern int __ide_dma_write(ide_drive_t *
 extern int __ide_dma_begin(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
-extern int __ide_dma_count(ide_drive_t *);
 extern int __ide_dma_verbose(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);

_

