Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTJCXzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTJCXyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:54:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8406 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261602AbTJCXxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:53:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] remove PDC-ADMA placeholders
Date: Sat, 4 Oct 2003 01:56:35 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040156.35902.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove PDC-ADMA placeholders

They do not contain any real code.

 dev/null                 |  218 -----------------------------------------------
 drivers/ide/pci/Makefile |    1 
 2 files changed, 219 deletions(-)

diff -puN drivers/ide/pci/Makefile~ide-pdcadma-removal drivers/ide/pci/Makefile
--- linux-2.6.0-test6-bk2/drivers/ide/pci/Makefile~ide-pdcadma-removal	2003-10-04 01:48:54.073350864 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/Makefile	2003-10-04 01:48:54.082349496 +0200
@@ -18,7 +18,6 @@ obj-$(CONFIG_BLK_DEV_NS87415)		+= ns8741
 obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_OLD)	+= pdc202xx_old.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_NEW)	+= pdc202xx_new.o
-obj-$(CONFIG_BLK_DEV_PDC_ADMA)		+= pdcadma.o ide-adma.o
 obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
 obj-$(CONFIG_BLK_DEV_RZ1000)		+= rz1000.o
 obj-$(CONFIG_BLK_DEV_SVWKS)		+= serverworks.o
diff -puN -L drivers/ide/pci/pdcadma.c drivers/ide/pci/pdcadma.c~ide-pdcadma-removal /dev/null
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdcadma.c
+++ /dev/null	2003-01-30 11:24:37.000000000 +0100
@@ -1,162 +0,0 @@
-/*
- * linux/drivers/ide/pci/pdcadma.c		Version 0.05	Sept 10, 2002
- *
- * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
- * May be copied or modified under the terms of the GNU General Public License
- *
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include "pdcadma.h"
-
-#if defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdcadma_proc = 0;
-#define PDC_MAX_DEVS		5
-static struct pci_dev *pdc_devs[PDC_MAX_DEVS];
-static int n_pdc_devs;
-
-static int pdcadma_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i;
-
-	for (i = 0; i < n_pdc_devs; i++) {
-		struct pci_dev *dev	= pdc_devs[i];
-		unsigned long bibma = pci_resource_start(dev, 4);
-
-		p += sprintf(p, "\n                                "
-			"PDC ADMA %04X Chipset.\n", dev->device);
-		p += sprintf(p, "UDMA\n");
-		p += sprintf(p, "PIO\n");
-
-	}
-	return p-buffer;	/* => must be less than 4k! */
-}
-#endif  /* defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-/*
- * pdcadma_dma functions() initiates/aborts (U)DMA read/write
- * operations on a drive.
- */
-#if 0
-        int (*ide_dma_read)(ide_drive_t *drive);
-        int (*ide_dma_write)(ide_drive_t *drive);
-        int (*ide_dma_begin)(ide_drive_t *drive);
-        int (*ide_dma_end)(ide_drive_t *drive);
-        int (*ide_dma_check)(ide_drive_t *drive);
-        int (*ide_dma_on)(ide_drive_t *drive);
-        int (*ide_dma_off)(ide_drive_t *drive);
-        int (*ide_dma_off_quietly)(ide_drive_t *drive);
-        int (*ide_dma_test_irq)(ide_drive_t *drive);
-        int (*ide_dma_host_on)(ide_drive_t *drive);
-        int (*ide_dma_host_off)(ide_drive_t *drive);
-        int (*ide_dma_bad_drive)(ide_drive_t *drive);
-        int (*ide_dma_good_drive)(ide_drive_t *drive);
-        int (*ide_dma_count)(ide_drive_t *drive);
-        int (*ide_dma_verbose)(ide_drive_t *drive);
-        int (*ide_dma_retune)(ide_drive_t *drive);
-        int (*ide_dma_lostirq)(ide_drive_t *drive);
-        int (*ide_dma_timeout)(ide_drive_t *drive);
-
-#endif
-
-static unsigned int __init init_chipset_pdcadma (struct pci_dev *dev, const char *name)
-{
-#if defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS)
-	pdc_devs[n_pdc_devs++] = dev;
-
-	if (!pdcadma_proc) {
-		pdcadma_proc = 1;
-		ide_pci_register_host_proc(&pdcadma_procs[0]);
-	}
-#endif /* DISPLAY_PDCADMA_TIMINGS && CONFIG_PROC_FS */
-	return 0;
-}
-
-static void __init init_hwif_pdcadma (ide_hwif_t *hwif)
-{
-	hwif->autodma = 0;
-	hwif->dma_base = 0;
-
-//	hwif->tuneproc = &pdcadma_tune_drive;
-//	hwif->speedproc = &pdcadma_tune_chipset;
-
-//	if (hwif->dma_base) {
-//		hwif->autodma = 1;
-//	}
-
-	hwif->udma_four = 1;
-
-//	hwif->atapi_dma = 1;
-//	hwif->ultra_mask = 0x7f;
-//	hwif->mwdma_mask = 0x07;
-//	hwif->swdma_mask = 0x07;
-
-}
-
-static void __init init_dma_pdcadma (ide_hwif_t *hwif, unsigned long dmabase)
-{
-#if 0
-	ide_setup_dma(hwif, dmabase, 8);
-#endif
-}
-
-extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
-
-static int __devinit pdcadma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	ide_pci_device_t *d = &pdcadma_chipsets[id->driver_data];
-	if (dev->device != d->device)
-		BUG();
-	ide_setup_pci_device(dev, d);
-	MOD_INC_USE_COUNT;
-	return 1;
-}
-
-static struct pci_device_id pdcadma_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_1841, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ 0, },
-};
-
-static struct pci_driver driver = {
-	.name		= "PDCADMA-IDE",
-	.id_table	= pdcadma_pci_tbl,
-	.probe		= pdcadma_init_one,
-};
-
-static int pdcadma_ide_init(void)
-{
-	return ide_pci_register_driver(&driver);
-}
-
-static void pdcadma_ide_exit(void)
-{
-	ide_pci_unregister_driver(&driver);
-}
-
-module_init(pdcadma_ide_init);
-module_exit(pdcadma_ide_exit);
-
-MODULE_AUTHOR("Andre Hedrick");
-MODULE_DESCRIPTION("PCI driver module for PDCADMA IDE");
-MODULE_LICENSE("GPL");
diff -puN -L drivers/ide/pci/pdcadma.h drivers/ide/pci/pdcadma.h~ide-pdcadma-removal /dev/null
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdcadma.h
+++ /dev/null	2003-01-30 11:24:37.000000000 +0100
@@ -1,56 +0,0 @@
-#ifndef PDC_ADMA_H
-#define PDC_ADMA_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#undef DISPLAY_PDCADMA_TIMINGS
-
-#if defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdcadma_proc;
-
-static int pdcadma_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t pdcadma_procs[] __initdata = {
-	{
-		.name		= "pdcadma",
-		.set		= 1,
-		.get_info	= pdcadma_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS) */
-
-static void init_setup_pdcadma(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_pdcadma(struct pci_dev *, const char *);
-static void init_hwif_pdcadma(ide_hwif_t *);
-static void init_dma_pdcadma(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t pdcadma_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.vendor		= PCI_VENDOR_ID_PDC,
-		.device		= PCI_DEVICE_ID_PDC_1841,
-		.name		= "PDCADMA",
-		.init_setup	= init_setup_pdcadma,
-		.init_chipset	= init_chipset_pdcadma,
-		.init_iops	= NULL,
-		.init_hwif	= init_hwif_pdcadma,
-		.init_dma	= init_dma_pdcadma,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.bootable	= OFF_BOARD,
-		.extra		= 0,
-	},{
-		.vendor		= 0,
-		.device		= 0,
-		.channels	= 0,
-		.bootable	= EOL,
-	}
-};
-
-#endif /* PDC_ADMA_H */

_

