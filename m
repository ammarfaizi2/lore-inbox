Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbVBDHio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbVBDHio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBDHhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:37:17 -0500
Received: from [211.58.254.17] ([211.58.254.17]:37545 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263258AbVBDHNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:20 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 04/14] ide_pci: Merges cy82c693.h into cy82c693.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071318.1206813264F@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04_ide_pci_cy82c693_merge.patch

	Merges ide/pci/cy82c693.h into cy82c693.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/cy82c693.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/cy82c693.c	2005-02-04 16:07:36.959349793 +0900
+++ linux-idepci-export/drivers/ide/pci/cy82c693.c	2005-02-04 16:08:24.953533218 +0900
@@ -54,7 +54,64 @@
 
 #include <asm/io.h>
 
-#include "cy82c693.h"
+/* the current version */
+#define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
+
+/*
+ *	The following are used to debug the driver.
+ */
+#define	CY82C693_DEBUG_LOGS	0
+#define	CY82C693_DEBUG_INFO	0
+
+/* define CY82C693_SETDMA_CLOCK to set DMA Controller Clock Speed to ATCLK */
+#undef CY82C693_SETDMA_CLOCK
+
+/*
+ *	NOTE: the value for busmaster timeout is tricky and I got it by
+ *	 trial and error!  By using a to low value will cause DMA timeouts
+ *	 and drop IDE performance, and by using a to high value will cause
+ *	 audio playback to scatter.
+ *	 If you know a better value or how to calc it, please let me know.
+ */
+
+/* twice the value written in cy82c693ub datasheet */
+#define BUSMASTER_TIMEOUT	0x50
+/*
+ * the value above was tested on my machine and it seems to work okay
+ */
+
+/* here are the offset definitions for the registers */
+#define CY82_IDE_CMDREG		0x04
+#define CY82_IDE_ADDRSETUP	0x48
+#define CY82_IDE_MASTER_IOR	0x4C	
+#define CY82_IDE_MASTER_IOW	0x4D	
+#define CY82_IDE_SLAVE_IOR	0x4E	
+#define CY82_IDE_SLAVE_IOW	0x4F
+#define CY82_IDE_MASTER_8BIT	0x50	
+#define CY82_IDE_SLAVE_8BIT	0x51	
+
+#define CY82_INDEX_PORT		0x22
+#define CY82_DATA_PORT		0x23
+
+#define CY82_INDEX_CTRLREG1	0x01
+#define CY82_INDEX_CHANNEL0	0x30
+#define CY82_INDEX_CHANNEL1	0x31
+#define CY82_INDEX_TIMEOUT	0x32
+
+/* the max PIO mode - from datasheet */
+#define CY82C693_MAX_PIO	4
+
+/* the min and max PCI bus speed in MHz - from datasheet */
+#define CY82C963_MIN_BUS_SPEED	25
+#define CY82C963_MAX_BUS_SPEED	33
+
+/* the struct for the PIO mode timings */
+typedef struct pio_clocks_s {
+        u8	address_time;	/* Address setup (clocks) */
+	u8	time_16r;	/* clocks for 16bit IOR (0xF0=Active/data, 0x0F=Recovery) */
+	u8	time_16w;	/* clocks for 16bit IOW (0xF0=Active/data, 0x0F=Recovery) */
+	u8	time_8;		/* clocks for 8bit (0xF0=Active/data, 0x0F=Recovery) */
+} pio_clocks_t;
 
 /*
  * calc clocks using bus_speed
@@ -422,6 +479,18 @@ void __init init_iops_cy82c693(ide_hwif_
 	}
 }
 
+static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "CY82C693",
+		.init_chipset	= init_chipset_cy82c693,
+		.init_iops	= init_iops_cy82c693,
+		.init_hwif	= init_hwif_cy82c693,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &cy82c693_chipsets[id->driver_data];
Index: linux-idepci-export/drivers/ide/pci/cy82c693.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/cy82c693.h	2005-02-04 16:07:36.959349793 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,83 +0,0 @@
-#ifndef CY82C693_H
-#define CY82C693_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-/* the current version */
-#define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
-
-/*
- *	The following are used to debug the driver.
- */
-#define	CY82C693_DEBUG_LOGS	0
-#define	CY82C693_DEBUG_INFO	0
-
-/* define CY82C693_SETDMA_CLOCK to set DMA Controller Clock Speed to ATCLK */
-#undef CY82C693_SETDMA_CLOCK
-
-/*
- *	NOTE: the value for busmaster timeout is tricky and I got it by
- *	 trial and error!  By using a to low value will cause DMA timeouts
- *	 and drop IDE performance, and by using a to high value will cause
- *	 audio playback to scatter.
- *	 If you know a better value or how to calc it, please let me know.
- */
-
-/* twice the value written in cy82c693ub datasheet */
-#define BUSMASTER_TIMEOUT	0x50
-/*
- * the value above was tested on my machine and it seems to work okay
- */
-
-/* here are the offset definitions for the registers */
-#define CY82_IDE_CMDREG		0x04
-#define CY82_IDE_ADDRSETUP	0x48
-#define CY82_IDE_MASTER_IOR	0x4C	
-#define CY82_IDE_MASTER_IOW	0x4D	
-#define CY82_IDE_SLAVE_IOR	0x4E	
-#define CY82_IDE_SLAVE_IOW	0x4F
-#define CY82_IDE_MASTER_8BIT	0x50	
-#define CY82_IDE_SLAVE_8BIT	0x51	
-
-#define CY82_INDEX_PORT		0x22
-#define CY82_DATA_PORT		0x23
-
-#define CY82_INDEX_CTRLREG1	0x01
-#define CY82_INDEX_CHANNEL0	0x30
-#define CY82_INDEX_CHANNEL1	0x31
-#define CY82_INDEX_TIMEOUT	0x32
-
-/* the max PIO mode - from datasheet */
-#define CY82C693_MAX_PIO	4
-
-/* the min and max PCI bus speed in MHz - from datasheet */
-#define CY82C963_MIN_BUS_SPEED	25
-#define CY82C963_MAX_BUS_SPEED	33
-
-/* the struct for the PIO mode timings */
-typedef struct pio_clocks_s {
-        u8	address_time;	/* Address setup (clocks) */
-	u8	time_16r;	/* clocks for 16bit IOR (0xF0=Active/data, 0x0F=Recovery) */
-	u8	time_16w;	/* clocks for 16bit IOW (0xF0=Active/data, 0x0F=Recovery) */
-	u8	time_8;		/* clocks for 8bit (0xF0=Active/data, 0x0F=Recovery) */
-} pio_clocks_t;
-
-static unsigned int init_chipset_cy82c693(struct pci_dev *, const char *);
-static void init_hwif_cy82c693(ide_hwif_t *);
-static void init_iops_cy82c693(ide_hwif_t *);
-
-static ide_pci_device_t cy82c693_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "CY82C693",
-		.init_chipset	= init_chipset_cy82c693,
-		.init_iops	= init_iops_cy82c693,
-		.init_hwif	= init_hwif_cy82c693,
-		.channels	= 1,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* CY82C693_H */
