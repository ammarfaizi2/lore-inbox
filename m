Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVCKGqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVCKGqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVCKGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:46:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:38874 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263206AbVCKGpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:45:54 -0500
Subject: [PATCH] ppc64: Add IDE-pmac support for new "Shasta" chipset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:45:40 +1100
Message-Id: <1110523540.5751.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The iMac G5 and new single CPU PowerMac G5 come with a new revision of
the K2 ASIC called Shasta. The PATA cell in there now does 133Mhz. This
patch adds support for it. It also adds some power management bits to
the old 100MHz cell that was in Intrepid based ppc32 machines.
The original iMac G5 bits are from J. Mayer <l_indien@magic.fr>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-01-31 14:18:21.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-03-10 14:58:19.000000000 +1100
@@ -68,6 +68,7 @@
 	struct device_node*		node;
 	struct macio_dev		*mdev;
 	u32				timings[4];
+	volatile u32 __iomem *		*kauai_fcr;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* Those fields are duplicating what is in hwif. We currently
 	 * can't use the hwif ones because of some assumptions that are
@@ -89,7 +90,8 @@
 	controller_kl_ata3,	/* KeyLargo ATA-3 */
 	controller_kl_ata4,	/* KeyLargo ATA-4 */
 	controller_un_ata6,	/* UniNorth2 ATA-6 */
-	controller_k2_ata6	/* K2 ATA-6 */
+	controller_k2_ata6,	/* K2 ATA-6 */
+	controller_sh_ata6,	/* Shasta ATA-6 */
 };
 
 static const char* model_name[] = {
@@ -99,6 +101,7 @@
 	"KeyLargo ATA-4",	/* KeyLargo ATA-4 (UDMA/66) */
 	"UniNorth ATA-6",	/* UniNorth2 ATA-6 (UDMA/100) */
 	"K2 ATA-6",		/* K2 ATA-6 (UDMA/100) */
+	"Shasta ATA-6",		/* Shasta ATA-6 (UDMA/133) */
 };
 
 /*
@@ -122,6 +125,15 @@
 #define IDE_SYSCLK_NS		30	/* 33Mhz cell */
 #define IDE_SYSCLK_66_NS	15	/* 66Mhz cell */
 
+/* 133Mhz cell, found in shasta.
+ * See comments about 100 Mhz Uninorth 2...
+ * Note that PIO_MASK and MDMA_MASK seem to overlap
+ */
+#define TR_133_PIOREG_PIO_MASK		0xff000fff
+#define TR_133_PIOREG_MDMA_MASK		0x00fff800
+#define TR_133_UDMAREG_UDMA_MASK	0x0003ffff
+#define TR_133_UDMAREG_UDMA_EN		0x00000001
+
 /* 100Mhz cell, found in Uninorth 2. I don't have much infos about
  * this one yet, it appears as a pci device (106b/0033) on uninorth
  * internal PCI bus and it's clock is controlled like gem or fw. It
@@ -209,6 +221,13 @@
 #define IDE_INTR_DMA			0x80000000
 #define IDE_INTR_DEVICE			0x40000000
 
+/*
+ * FCR Register on Kauai. Not sure what bit 0x4 is  ...
+ */
+#define KAUAI_FCR_UATA_MAGIC		0x00000004
+#define KAUAI_FCR_UATA_RESET_N		0x00000002
+#define KAUAI_FCR_UATA_ENABLE		0x00000001
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 /* Rounded Multiword DMA timings
@@ -322,6 +341,48 @@
 	{ 0	, 0 },
 };
 
+static struct kauai_timing	shasta_pio_timings[] __pmacdata =
+{
+	{ 930	, 0x08000fff },
+	{ 600	, 0x0A000c97 },
+	{ 383	, 0x07000712 },
+	{ 360	, 0x040003cd },
+	{ 330	, 0x040003cd },
+	{ 300	, 0x040003cd },
+	{ 270	, 0x040003cd },
+	{ 240	, 0x040003cd },
+	{ 239	, 0x040003cd },
+	{ 180	, 0x0400028b },
+	{ 120	, 0x0400010a }
+};
+
+static struct kauai_timing	shasta_mdma_timings[] __pmacdata =
+{
+	{ 1260	, 0x00fff000 },
+	{ 480	, 0x00820800 },
+	{ 360	, 0x00820800 },
+	{ 270	, 0x00820800 },
+	{ 240	, 0x00820800 },
+	{ 210	, 0x00820800 },
+	{ 180	, 0x00820800 },
+	{ 150	, 0x0028b000 },
+	{ 120	, 0x001ca000 },
+	{ 0	, 0 },
+};
+
+static struct kauai_timing	shasta_udma133_timings[] __pmacdata =
+{
+	{ 120   , 0x00035901, },
+	{ 90    , 0x000348b1, },
+	{ 60    , 0x00033881, },
+	{ 45    , 0x00033861, },
+	{ 30    , 0x00033841, },
+	{ 20    , 0x00033031, },
+	{ 15    , 0x00033021, },
+	{ 0	, 0 },
+};
+
+
 static inline u32
 kauai_lookup_timing(struct kauai_timing* table, int cycle_time)
 {
@@ -547,7 +608,9 @@
 	if (pmif == NULL)
 		return;
 
-	if (pmif->kind == controller_un_ata6 || pmif->kind == controller_k2_ata6)
+	if (pmif->kind == controller_sh_ata6 ||
+	    pmif->kind == controller_un_ata6 ||
+	    pmif->kind == controller_k2_ata6)
 		pmac_ide_kauai_selectproc(drive);
 	else
 		pmac_ide_selectproc(drive);
@@ -665,6 +728,14 @@
 	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
 
 	switch (pmif->kind) {
+	case controller_sh_ata6: {
+		/* 133Mhz cell */
+		u32 tr = kauai_lookup_timing(shasta_pio_timings, d.cycle_time);
+		if (tr == 0)
+			return;
+		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
+		break;
+		}
 	case controller_un_ata6:
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
@@ -776,6 +847,26 @@
 }
 
 /*
+ * Calculate Shasta ATA/133 UDMA timings
+ */
+static int __pmac
+set_timings_udma_shasta(u32 *pio_timings, u32 *ultra_timings, u8 speed)
+{
+	struct ide_timing *t = ide_timing_find_mode(speed);
+	u32 tr;
+
+	if (speed > XFER_UDMA_6 || t == NULL)
+		return 1;
+	tr = kauai_lookup_timing(shasta_udma133_timings, (int)t->udma);
+	if (tr == 0)
+		return 1;
+	*ultra_timings = ((*ultra_timings) & ~TR_133_UDMAREG_UDMA_MASK) | tr;
+	*ultra_timings = (*ultra_timings) | TR_133_UDMAREG_UDMA_EN;
+
+	return 0;
+}
+
+/*
  * Calculate MDMA timings for all cells
  */
 static int __pmac
@@ -803,6 +894,7 @@
 		cycleTime = 150;
 	/* Get the proper timing array for this controller */
 	switch(intf_type) {
+	        case controller_sh_ata6:
 		case controller_un_ata6:
 		case controller_k2_ata6:
 			break;
@@ -836,6 +928,14 @@
 #endif
 	}
 	switch(intf_type) {
+	case controller_sh_ata6: {
+		/* 133Mhz cell */
+		u32 tr = kauai_lookup_timing(shasta_mdma_timings, cycleTime);
+		if (tr == 0)
+			return 1;
+		*timings = ((*timings) & ~TR_133_PIOREG_MDMA_MASK) | tr;
+		*timings2 = (*timings2) & ~TR_133_UDMAREG_UDMA_EN;
+		}
 	case controller_un_ata6:
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
@@ -930,9 +1030,13 @@
 	
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
+		case XFER_UDMA_6:
+		        if (pmif->kind != controller_sh_ata6)
+				return 1;
 		case XFER_UDMA_5:
 			if (pmif->kind != controller_un_ata6 &&
-			    pmif->kind != controller_k2_ata6)
+			    pmif->kind != controller_k2_ata6 &&
+			    pmif->kind != controller_sh_ata6)
 				return 1;
 		case XFER_UDMA_4:
 		case XFER_UDMA_3:
@@ -946,6 +1050,8 @@
 			else if (pmif->kind == controller_un_ata6
 				 || pmif->kind == controller_k2_ata6)
 				ret = set_timings_udma_ata6(timings, timings2, speed);
+			else if (pmif->kind == controller_sh_ata6)
+				ret = set_timings_udma_shasta(timings, timings2, speed);
 			else
 				ret = 1;		
 			break;
@@ -992,6 +1098,10 @@
 	unsigned int value, value2 = 0;
 	
 	switch(pmif->kind) {
+		case controller_sh_ata6:
+			value = 0x0a820c97;
+			value2 = 0x00033031;
+			break;
 		case controller_un_ata6:
 		case controller_k2_ata6:
 			value = 0x08618a92;
@@ -1101,6 +1211,13 @@
 	/* Disable the bus */
 	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id, 0);
 
+	/* Kauai has it different */
+	if (pmif->kauai_fcr) {
+		u32 fcr = readl(pmif->kauai_fcr);
+		fcr &= ~(KAUAI_FCR_UATA_RESET_N | KAUAI_FCR_UATA_ENABLE);
+		writel(fcr, pmif->kauai_fcr);		
+	}
+
 	return 0;
 }
 
@@ -1119,6 +1236,13 @@
 		msleep(10);
 		ppc_md.feature_call(PMAC_FTR_IDE_RESET, pmif->node, pmif->aapl_bus_id, 0);
 		msleep(jiffies_to_msecs(IDE_WAKEUP_DELAY));
+
+		/* Kauai has it different */
+		if (pmif->kauai_fcr) {
+			u32 fcr = readl(pmif->kauai_fcr);
+			fcr |= KAUAI_FCR_UATA_RESET_N | KAUAI_FCR_UATA_ENABLE;
+			writel(fcr, pmif->kauai_fcr);		
+		}
 	}
 
 	/* Sanitize drive timings */
@@ -1142,7 +1266,9 @@
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
-	if (device_is_compatible(np, "kauai-ata"))
+	if (device_is_compatible(np, "shasta-ata"))
+		pmif->kind = controller_sh_ata6;
+	else if (device_is_compatible(np, "kauai-ata"))
 		pmif->kind = controller_un_ata6;
 	else if (device_is_compatible(np, "K2-UATA"))
 		pmif->kind = controller_k2_ata6;
@@ -1163,11 +1289,25 @@
 
 	/* Get cable type from device-tree */
 	if (pmif->kind == controller_kl_ata4 || pmif->kind == controller_un_ata6
-	    || pmif->kind == controller_k2_ata6) {
+	    || pmif->kind == controller_k2_ata6
+	    || pmif->kind == controller_sh_ata6) {
 		char* cable = get_property(np, "cable-type", NULL);
 		if (cable && !strncmp(cable, "80-", 3))
 			pmif->cable_80 = 1;
 	}
+	/* G5's seem to have incorrect cable type in device-tree. Let's assume
+	 * they have a 80 conductor cable, this seem to be always the case unless
+	 * the user mucked around
+	 */
+	if (device_is_compatible(np, "K2-UATA") ||
+	    device_is_compatible(np, "shasta-ata"))
+		pmid->cable_80 = 1;
+
+	/* On Kauai-type controllers, we make sure the FCR is correct */
+	if (pmif->kauai_fcr)
+		writel(KAUAI_FCR_UATA_MAGIC |
+		       KAUAI_FCR_UATA_RESET_N |
+		       KAUAI_FCR_UATA_ENABLE, pmif->kauai_fcr);
 
 	pmif->mediabay = 0;
 	
@@ -1217,7 +1357,9 @@
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
 	hwif->tuneproc = pmac_ide_tuneproc;
-	if (pmif->kind == controller_un_ata6 || pmif->kind == controller_k2_ata6)
+	if (pmif->kind == controller_un_ata6
+	    || pmif->kind == controller_k2_ata6
+	    || pmif->kind == controller_sh_ata6)
 		hwif->selectproc = pmac_ide_kauai_selectproc;
 	else
 		hwif->selectproc = pmac_ide_selectproc;
@@ -1327,6 +1469,7 @@
 	pmif->node = mdev->ofdev.node;
 	pmif->regbase = regbase;
 	pmif->irq = irq;
+	pmif->kauai_fcr = NULL;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	if (macio_resource_count(mdev) >= 2) {
 		if (macio_request_resource(mdev, 1, "ide-pmac (dma)"))
@@ -1440,13 +1583,9 @@
 	pmif->regbase = (unsigned long) base + 0x2000;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	pmif->dma_regs = base + 0x1000;
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */	
-
-	/* We use the OF node irq mapping */
-	if (np->n_intrs == 0)
-		pmif->irq = pdev->irq;
-	else
-		pmif->irq = np->intrs[0].line;
+#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+	pmif->kauai_fcr = base;
+	pmif->irq = pdev->irq;
 
 	pci_set_drvdata(pdev, hwif);
 
@@ -1530,6 +1669,8 @@
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVIEC_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 };
 
 static struct pci_driver pmac_ide_pci_driver = {
@@ -1737,10 +1878,15 @@
 	timing_local[1] = *timings2;
 	
 	/* Calculate timings for interface */
-	if (pmif->kind == controller_un_ata6 || pmif->kind == controller_k2_ata6)
+	if (pmif->kind == controller_un_ata6
+	    || pmif->kind == controller_k2_ata6)
 		ret = set_timings_udma_ata6(	&timing_local[0],
 						&timing_local[1],
 						mode);
+	else if (pmif->kind == controller_sh_ata6)
+		ret = set_timings_udma_shasta(	&timing_local[0],
+						&timing_local[1],
+						mode);
 	else
 		ret = set_timings_udma_ata4(&timing_local[0], mode);
 	if (ret)
@@ -1791,14 +1937,19 @@
 		short mode;
 		
 		map = XFER_MWDMA;
-		if (pmif->kind == controller_kl_ata4 || pmif->kind == controller_un_ata6
-		    || pmif->kind == controller_k2_ata6) {
+		if (pmif->kind == controller_kl_ata4
+		    || pmif->kind == controller_un_ata6
+		    || pmif->kind == controller_k2_ata6
+		    || pmif->kind == controller_sh_ata6) {
 			map |= XFER_UDMA;
 			if (pmif->cable_80) {
 				map |= XFER_UDMA_66;
 				if (pmif->kind == controller_un_ata6 ||
-				    pmif->kind == controller_k2_ata6)
+				    pmif->kind == controller_k2_ata6 ||
+				    pmif->kind == controller_sh_ata6)
 					map |= XFER_UDMA_100;
+				if (pmif->kind == controller_sh_ata6)
+					map |= XFER_UDMA_133;
 			}
 		}
 		mode = ide_find_best_mode(drive, map);
@@ -2028,6 +2179,11 @@
 
 	hwif->atapi_dma = 1;
 	switch(pmif->kind) {
+		case controller_sh_ata6:
+			hwif->ultra_mask = pmif->cable_80 ? 0x7f : 0x07;
+			hwif->mwdma_mask = 0x07;
+			hwif->swdma_mask = 0x00;
+			break;
 		case controller_un_ata6:
 		case controller_k2_ata6:
 			hwif->ultra_mask = pmif->cable_80 ? 0x3f : 0x07;


