Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVBEAEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVBEAEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbVBEADd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:03:33 -0500
Received: from [211.58.254.17] ([211.58.254.17]:33253 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S264081AbVBEABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:01:39 -0500
Date: Sat, 5 Feb 2005 09:01:36 +0900
From: Tejun Heo <tj@home-tj.org>
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST 2.6.11-rc2 14/14] ide_pci: Merges serverworks.h into serverworks.c
Message-ID: <20050205000136.GA2420@htj.dyndns.org>
References: <42032014.1020606@home-tj.org> <20050204071319.0ED0E132703@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204071319.0ED0E132703@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry, the original #14 added back SVWKS_DEBUG_DRIVE_INFO which #13
removed.  This is the regenerated patch.

14_ide_pci_serverworks_merge.patch

	Merges ide/pci/serverworks.h into serverworks.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/serverworks.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/serverworks.c	2005-02-05 08:56:34.184740697 +0900
+++ linux-idepci-export/drivers/ide/pci/serverworks.c	2005-02-05 08:57:24.673562622 +0900
@@ -39,7 +39,18 @@
 
 #include <asm/io.h>
 
-#include "serverworks.h"
+#define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
+#define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
+
+/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5 */
+static const char *svwks_bad_ata100[] = {
+	"ST320011A",
+	"ST340016A",
+	"ST360021A",
+	"ST380021A",
+	NULL
+};
 
 static u8 svwks_revision = 0;
 static struct pci_dev *isa_dev;
@@ -582,6 +593,48 @@ static int __init init_setup_csb6 (struc
 	return ide_setup_pci_device(dev, d);
 }
 
+/*
+ *	Table of the various serverworks capability blocks
+ */
+
+static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "SvrWks OSB4",
+		.init_setup	= init_setup_svwks,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "SvrWks CSB5",
+		.init_setup	= init_setup_svwks,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "SvrWks CSB6",
+		.init_setup	= init_setup_csb6,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 3 */
+		.name		= "SvrWks CSB6",
+		.init_setup	= init_setup_csb6,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 1,	/* 2 */
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
 
 /**
  *	svwks_init_one	-	called when a OSB/CSB is found
Index: linux-idepci-export/drivers/ide/pci/serverworks.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/serverworks.h	2005-02-05 08:57:24.477594365 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,67 +0,0 @@
-
-#ifndef SERVERWORKS_H
-#define SERVERWORKS_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
-#define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
-
-/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
- * can overrun their FIFOs when used with the CSB5 */
-static const char *svwks_bad_ata100[] = {
-	"ST320011A",
-	"ST340016A",
-	"ST360021A",
-	"ST380021A",
-	NULL
-};
-
-static int init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
-static unsigned int init_chipset_svwks(struct pci_dev *, const char *);
-static void init_hwif_svwks(ide_hwif_t *);
-static void init_dma_svwks(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "SvrWks OSB4",
-		.init_setup	= init_setup_svwks,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "SvrWks CSB5",
-		.init_setup	= init_setup_svwks,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 3 */
-		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
-		.init_chipset	= init_chipset_svwks,
-		.init_hwif	= init_hwif_svwks,
-		.init_dma	= init_dma_svwks,
-		.channels	= 1,	/* 2 */
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* SERVERWORKS_H */
