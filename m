Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVBDHUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVBDHUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVBDHS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:18:29 -0500
Received: from [211.58.254.17] ([211.58.254.17]:38313 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263266AbVBDHNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:20 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 03/14] ide_pci: Merges cmd64x.h into cmd64x.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071317.E373913264E@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:17 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03_ide_pci_cmd64x_merge.patch

	Merges ide/pci/cmd64x.h into cmd64x.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/cmd64x.c	2005-02-04 16:07:37.029338395 +0900
+++ linux-idepci-export/drivers/ide/pci/cmd64x.c	2005-02-04 16:08:24.687576532 +0900
@@ -25,7 +25,56 @@
 
 #include <asm/io.h>
 
-#include "cmd64x.h"
+#define DISPLAY_CMD64X_TIMINGS
+
+#define CMD_DEBUG 0
+
+#if CMD_DEBUG
+#define cmdprintk(x...)	printk(x)
+#else
+#define cmdprintk(x...)
+#endif
+
+/*
+ * CMD64x specific registers definition.
+ */
+#define CFR		0x50
+#define   CFR_INTR_CH0		0x02
+#define CNTRL		0x51
+#define	  CNTRL_DIS_RA0		0x40
+#define   CNTRL_DIS_RA1		0x80
+#define	  CNTRL_ENA_2ND		0x08
+
+#define	CMDTIM		0x52
+#define	ARTTIM0		0x53
+#define	DRWTIM0		0x54
+#define ARTTIM1 	0x55
+#define DRWTIM1		0x56
+#define ARTTIM23	0x57
+#define   ARTTIM23_DIS_RA2	0x04
+#define   ARTTIM23_DIS_RA3	0x08
+#define   ARTTIM23_INTR_CH1	0x10
+#define ARTTIM2		0x57
+#define ARTTIM3		0x57
+#define DRWTIM23	0x58
+#define DRWTIM2		0x58
+#define BRST		0x59
+#define DRWTIM3		0x5b
+
+#define BMIDECR0	0x70
+#define MRDMODE		0x71
+#define   MRDMODE_INTR_CH0	0x04
+#define   MRDMODE_INTR_CH1	0x08
+#define   MRDMODE_BLK_CH0	0x10
+#define   MRDMODE_BLK_CH1	0x20
+#define BMIDESR0	0x72
+#define UDIDETCR0	0x73
+#define DTPR0		0x74
+#define BMIDECR1	0x78
+#define BMIDECSR	0x79
+#define BMIDESR1	0x7A
+#define UDIDETCR1	0x7B
+#define DTPR1		0x7C
 
 #if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -707,6 +756,39 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "CMD643",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "CMD646",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "CMD648",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{
+		.name		= "CMD649",
+		.init_chipset	= init_chipset_cmd64x,
+		.init_hwif	= init_hwif_cmd64x,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
Index: linux-idepci-export/drivers/ide/pci/cmd64x.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/cmd64x.h	2005-02-04 16:07:37.029338395 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,95 +0,0 @@
-#ifndef CMD64X_H
-#define CMD64X_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DISPLAY_CMD64X_TIMINGS
-
-#define CMD_DEBUG 0
-
-#if CMD_DEBUG
-#define cmdprintk(x...)	printk(x)
-#else
-#define cmdprintk(x...)
-#endif
-
-/*
- * CMD64x specific registers definition.
- */
-#define CFR		0x50
-#define   CFR_INTR_CH0		0x02
-#define CNTRL		0x51
-#define	  CNTRL_DIS_RA0		0x40
-#define   CNTRL_DIS_RA1		0x80
-#define	  CNTRL_ENA_2ND		0x08
-
-#define	CMDTIM		0x52
-#define	ARTTIM0		0x53
-#define	DRWTIM0		0x54
-#define ARTTIM1 	0x55
-#define DRWTIM1		0x56
-#define ARTTIM23	0x57
-#define   ARTTIM23_DIS_RA2	0x04
-#define   ARTTIM23_DIS_RA3	0x08
-#define   ARTTIM23_INTR_CH1	0x10
-#define ARTTIM2		0x57
-#define ARTTIM3		0x57
-#define DRWTIM23	0x58
-#define DRWTIM2		0x58
-#define BRST		0x59
-#define DRWTIM3		0x5b
-
-#define BMIDECR0	0x70
-#define MRDMODE		0x71
-#define   MRDMODE_INTR_CH0	0x04
-#define   MRDMODE_INTR_CH1	0x08
-#define   MRDMODE_BLK_CH0	0x10
-#define   MRDMODE_BLK_CH1	0x20
-#define BMIDESR0	0x72
-#define UDIDETCR0	0x73
-#define DTPR0		0x74
-#define BMIDECR1	0x78
-#define BMIDECSR	0x79
-#define BMIDESR1	0x7A
-#define UDIDETCR1	0x7B
-#define DTPR1		0x7C
-
-static unsigned int init_chipset_cmd64x(struct pci_dev *, const char *);
-static void init_hwif_cmd64x(ide_hwif_t *);
-
-static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CMD643",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "CMD646",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "CMD648",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{
-		.name		= "CMD649",
-		.init_chipset	= init_chipset_cmd64x,
-		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* CMD64X_H */
