Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVBDHOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVBDHOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVBDHOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:14:54 -0500
Received: from [211.58.254.17] ([211.58.254.17]:36777 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263257AbVBDHNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:20 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 02/14] ide_pci: Merges aec62xx.h into aec62xx.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071317.C864C13264D@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:17 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02_ide_pci_aec62xx_merge.patch

	Merges ide/pci/aec62xx.h into aec62xx.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/aec62xx.c	2005-02-04 16:08:23.966693938 +0900
+++ linux-idepci-export/drivers/ide/pci/aec62xx.c	2005-02-04 16:08:24.332634340 +0900
@@ -16,7 +16,54 @@
 
 #include <asm/io.h>
 
-#include "aec62xx.h"
+struct chipset_bus_clock_list_entry {
+	byte		xfer_speed;
+	byte		chipset_settings;
+	byte		ultra_settings;
+};
+
+static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
+	{	XFER_UDMA_6,	0x31,	0x07	},
+	{	XFER_UDMA_5,	0x31,	0x06	},
+	{	XFER_UDMA_4,	0x31,	0x05	},
+	{	XFER_UDMA_3,	0x31,	0x04	},
+	{	XFER_UDMA_2,	0x31,	0x03	},
+	{	XFER_UDMA_1,	0x31,	0x02	},
+	{	XFER_UDMA_0,	0x31,	0x01	},
+
+	{	XFER_MW_DMA_2,	0x31,	0x00	},
+	{	XFER_MW_DMA_1,	0x31,	0x00	},
+	{	XFER_MW_DMA_0,	0x0a,	0x00	},
+	{	XFER_PIO_4,	0x31,	0x00	},
+	{	XFER_PIO_3,	0x33,	0x00	},
+	{	XFER_PIO_2,	0x08,	0x00	},
+	{	XFER_PIO_1,	0x0a,	0x00	},
+	{	XFER_PIO_0,	0x00,	0x00	},
+	{	0,		0x00,	0x00	}
+};
+
+static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
+	{	XFER_UDMA_6,	0x41,	0x06	},
+	{	XFER_UDMA_5,	0x41,	0x05	},
+	{	XFER_UDMA_4,	0x41,	0x04	},
+	{	XFER_UDMA_3,	0x41,	0x03	},
+	{	XFER_UDMA_2,	0x41,	0x02	},
+	{	XFER_UDMA_1,	0x41,	0x01	},
+	{	XFER_UDMA_0,	0x41,	0x01	},
+
+	{	XFER_MW_DMA_2,	0x41,	0x00	},
+	{	XFER_MW_DMA_1,	0x42,	0x00	},
+	{	XFER_MW_DMA_0,	0x7a,	0x00	},
+	{	XFER_PIO_4,	0x41,	0x00	},
+	{	XFER_PIO_3,	0x43,	0x00	},
+	{	XFER_PIO_2,	0x78,	0x00	},
+	{	XFER_PIO_1,	0x7a,	0x00	},
+	{	XFER_PIO_0,	0x70,	0x00	},
+	{	0,		0x00,	0x00	}
+};
+
+#define BUSCLOCK(D)	\
+	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
 
 #if 0
 		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
@@ -344,6 +391,58 @@ static int __devinit init_setup_aec6x80(
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "AEC6210",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+	},{	/* 1 */
+		.name		= "AEC6260",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 2 */
+		.name		= "AEC6260R",
+		.init_setup	= init_setup_aec62xx,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= NEVER_BOARD,
+	},{	/* 3 */
+		.name		= "AEC6X80",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 4 */
+		.name		= "AEC6X80R",
+		.init_setup	= init_setup_aec6x80,
+		.init_chipset	= init_chipset_aec62xx,
+		.init_hwif	= init_hwif_aec62xx,
+		.init_dma	= init_dma_aec62xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
+		.bootable	= OFF_BOARD,
+	}
+};
+
 /**
  *	aec62xx_init_one	-	called when a AEC is found
  *	@dev: the aec62xx device
Index: linux-idepci-export/drivers/ide/pci/aec62xx.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/aec62xx.h	2005-02-04 16:08:23.967693775 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,112 +0,0 @@
-#ifndef AEC62XX_H
-#define AEC62XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-struct chipset_bus_clock_list_entry {
-	byte		xfer_speed;
-	byte		chipset_settings;
-	byte		ultra_settings;
-};
-
-static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
-	{	XFER_UDMA_6,	0x31,	0x07	},
-	{	XFER_UDMA_5,	0x31,	0x06	},
-	{	XFER_UDMA_4,	0x31,	0x05	},
-	{	XFER_UDMA_3,	0x31,	0x04	},
-	{	XFER_UDMA_2,	0x31,	0x03	},
-	{	XFER_UDMA_1,	0x31,	0x02	},
-	{	XFER_UDMA_0,	0x31,	0x01	},
-
-	{	XFER_MW_DMA_2,	0x31,	0x00	},
-	{	XFER_MW_DMA_1,	0x31,	0x00	},
-	{	XFER_MW_DMA_0,	0x0a,	0x00	},
-	{	XFER_PIO_4,	0x31,	0x00	},
-	{	XFER_PIO_3,	0x33,	0x00	},
-	{	XFER_PIO_2,	0x08,	0x00	},
-	{	XFER_PIO_1,	0x0a,	0x00	},
-	{	XFER_PIO_0,	0x00,	0x00	},
-	{	0,		0x00,	0x00	}
-};
-
-static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
-	{	XFER_UDMA_6,	0x41,	0x06	},
-	{	XFER_UDMA_5,	0x41,	0x05	},
-	{	XFER_UDMA_4,	0x41,	0x04	},
-	{	XFER_UDMA_3,	0x41,	0x03	},
-	{	XFER_UDMA_2,	0x41,	0x02	},
-	{	XFER_UDMA_1,	0x41,	0x01	},
-	{	XFER_UDMA_0,	0x41,	0x01	},
-
-	{	XFER_MW_DMA_2,	0x41,	0x00	},
-	{	XFER_MW_DMA_1,	0x42,	0x00	},
-	{	XFER_MW_DMA_0,	0x7a,	0x00	},
-	{	XFER_PIO_4,	0x41,	0x00	},
-	{	XFER_PIO_3,	0x43,	0x00	},
-	{	XFER_PIO_2,	0x78,	0x00	},
-	{	XFER_PIO_1,	0x7a,	0x00	},
-	{	XFER_PIO_0,	0x70,	0x00	},
-	{	0,		0x00,	0x00	}
-};
-
-static int init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_aec62xx(struct pci_dev *, const char *);
-static void init_hwif_aec62xx(ide_hwif_t *);
-static void init_dma_aec62xx(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "AEC6210",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= OFF_BOARD,
-	},{	/* 1 */
-		.name		= "AEC6260",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 2 */
-		.name		= "AEC6260R",
-		.init_setup	= init_setup_aec62xx,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= NEVER_BOARD,
-	},{	/* 3 */
-		.name		= "AEC6X80",
-		.init_setup	= init_setup_aec6x80,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 4 */
-		.name		= "AEC6X80R",
-		.init_setup	= init_setup_aec6x80,
-		.init_chipset	= init_chipset_aec62xx,
-		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.bootable	= OFF_BOARD,
-	}
-};
-
-#endif /* AEC62XX_H */
