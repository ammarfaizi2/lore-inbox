Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263262AbVBDH3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbVBDH3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVBDH3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:29:08 -0500
Received: from [211.58.254.17] ([211.58.254.17]:43689 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263392AbVBDHNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:24 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 11/14] ide_pci: Merges pdc202xx_old.h into pdc202xx_old.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071319.3E7CB1326FC@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


11_ide_pci_pdc202xx_old_merge.patch

	Merges ide/pci/pdc202xx_old.h into pdc202xx_old.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_old.c	2005-02-04 16:08:26.197330649 +0900
+++ linux-idepci-export/drivers/ide/pci/pdc202xx_old.c	2005-02-04 16:08:26.404296941 +0900
@@ -46,9 +46,60 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "pdc202xx_old.h"
+#define PDC202_DEBUG_CABLE		0
+#define PDC202XX_DEBUG_DRIVE_INFO	0
 
-#define PDC202_DEBUG_CABLE	0
+static const char *pdc_quirk_drives[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP KX13.6",
+	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
+	"QUANTUM FIREBALLP LM20.5",
+	NULL
+};
+
+/* A Register */
+#define	SYNC_ERRDY_EN	0xC0
+
+#define	SYNC_IN		0x80	/* control bit, different for master vs. slave drives */
+#define	ERRDY_EN	0x40	/* control bit, different for master vs. slave drives */
+#define	IORDY_EN	0x20	/* PIO: IOREADY */
+#define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
+
+#define	PA3		0x08	/* PIO"A" timing */
+#define	PA2		0x04	/* PIO"A" timing */
+#define	PA1		0x02	/* PIO"A" timing */
+#define	PA0		0x01	/* PIO"A" timing */
+
+/* B Register */
+
+#define	MB2		0x80	/* DMA"B" timing */
+#define	MB1		0x40	/* DMA"B" timing */
+#define	MB0		0x20	/* DMA"B" timing */
+
+#define	PB4		0x10	/* PIO_FORCE 1:0 */
+
+#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
+#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
+#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
+#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
+
+/* C Register */
+#define	IORDYp_NO_SPEED	0x4F
+#define	SPEED_DIS	0x0F
+
+#define	DMARQp		0x80
+#define	IORDYp		0x40
+#define	DMAR_EN		0x20
+#define	DMAW_EN		0x10
+
+#define	MC3		0x08	/* DMA"C" timing */
+#define	MC2		0x04	/* DMA"C" timing */
+#define	MC1		0x02	/* DMA"C" timing */
+#define	MC0		0x01	/* DMA"C" timing */
 
 #if 0
 	unsigned long bibma  = pci_resource_start(dev, 4);
@@ -726,6 +777,77 @@ static int __devinit init_setup_pdc202xx
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PDC20246",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 16,
+	},{	/* 1 */
+		.name		= "PDC20262",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
+	},{	/* 2 */
+		.name		= "PDC20263",
+		.init_setup	= init_setup_pdc202ata4,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+	},{	/* 3 */
+		.name		= "PDC20265",
+		.init_setup	= init_setup_pdc20265,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+		.flags		= IDEPCI_FLAG_FORCE_PDC,
+	},{	/* 4 */
+		.name		= "PDC20267",
+		.init_setup	= init_setup_pdc202xx,
+		.init_chipset	= init_chipset_pdc202xx,
+		.init_hwif	= init_hwif_pdc202xx,
+		.init_dma	= init_dma_pdc202xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+		.extra		= 48,
+	}
+};
+
 /**
  *	pdc202xx_init_one	-	called when a PDC202xx is found
  *	@dev: the pdc202xx device
Index: linux-idepci-export/drivers/ide/pci/pdc202xx_old.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_old.h	2005-02-04 16:08:26.197330649 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,140 +0,0 @@
-#ifndef PDC202XX_H
-#define PDC202XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define PDC202XX_DEBUG_DRIVE_INFO		0
-
-static const char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
-/* A Register */
-#define	SYNC_ERRDY_EN	0xC0
-
-#define	SYNC_IN		0x80	/* control bit, different for master vs. slave drives */
-#define	ERRDY_EN	0x40	/* control bit, different for master vs. slave drives */
-#define	IORDY_EN	0x20	/* PIO: IOREADY */
-#define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
-
-#define	PA3		0x08	/* PIO"A" timing */
-#define	PA2		0x04	/* PIO"A" timing */
-#define	PA1		0x02	/* PIO"A" timing */
-#define	PA0		0x01	/* PIO"A" timing */
-
-/* B Register */
-
-#define	MB2		0x80	/* DMA"B" timing */
-#define	MB1		0x40	/* DMA"B" timing */
-#define	MB0		0x20	/* DMA"B" timing */
-
-#define	PB4		0x10	/* PIO_FORCE 1:0 */
-
-#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
-#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
-#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
-#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
-
-/* C Register */
-#define	IORDYp_NO_SPEED	0x4F
-#define	SPEED_DIS	0x0F
-
-#define	DMARQp		0x80
-#define	IORDYp		0x40
-#define	DMAR_EN		0x20
-#define	DMAW_EN		0x10
-
-#define	MC3		0x08	/* DMA"C" timing */
-#define	MC2		0x04	/* DMA"C" timing */
-#define	MC1		0x02	/* DMA"C" timing */
-#define	MC0		0x01	/* DMA"C" timing */
-
-static int init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
-static int init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc202xx(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_pdc202xx(struct pci_dev *, const char *);
-static void init_hwif_pdc202xx(ide_hwif_t *);
-static void init_dma_pdc202xx(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PDC20246",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 16,
-	},{	/* 1 */
-		.name		= "PDC20262",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
-	},{	/* 2 */
-		.name		= "PDC20263",
-		.init_setup	= init_setup_pdc202ata4,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-	},{	/* 3 */
-		.name		= "PDC20265",
-		.init_setup	= init_setup_pdc20265,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
-	},{	/* 4 */
-		.name		= "PDC20267",
-		.init_setup	= init_setup_pdc202xx,
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-		.extra		= 48,
-	}
-};
-
-#endif /* PDC202XX_H */
