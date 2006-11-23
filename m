Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757412AbWKWQg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbWKWQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757414AbWKWQg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:36:29 -0500
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:2791 "EHLO
	outbound5-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1757412AbWKWQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:36:27 -0500
X-BigFish: V
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add IDE mode support for SB600 SATA
Message-Id: <20061123163547.5D7CDCBD6B@localhost.localdomain>
Date: Thu, 23 Nov 2006 11:35:47 -0500 (EST)
From: luugi.marsan@amd.com (Luugi Marsan)
X-OriginalArrivalTime: 23 Nov 2006 16:36:16.0970 (UTC) FILETIME=[7F6D82A0:01C70F1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conke Hu <conke.hu@amd.com> 

ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch provides users with two options when the SB600 SATA is set as IDE mode by BIOS:
1. Setting the controller back to AHCI mode and using ahci as its driver.
2. Using the controller as a normal IDE.
What's more, without this patch, ahci driver always tries to claim all 4 modes of SB600 SATA, but fails in legacy IDE mode.

Signed-off-by; Felix Kuehling

diff -Nur linux-2.6.19-rc5-git7.orig/drivers/ata/ahci.c linux-2.6.19-rc5-git7/drivers/ata/ahci.c
--- linux-2.6.19-rc5-git7.orig/drivers/ata/ahci.c	2006-11-17 00:39:48.000000000 +0800
+++ linux-2.6.19-rc5-git7/drivers/ata/ahci.c	2006-11-17 00:40:48.000000000 +0800
@@ -1502,6 +1502,24 @@
 
 	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
+	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x4380 && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+#ifdef CONFIG_SB600_AHCI_IDE
+		/* Make sure the SB600 SATA runs in AHCI mode. */
+		u8 tmp;
+
+		pci_read_config_byte(pdev, 0x40, &tmp);
+		pci_write_config_byte(pdev, 0x40, tmp|1);
+		pci_write_config_byte(pdev, 0x9, 1);
+		pci_write_config_byte(pdev, 0xa, 6);
+		pci_write_config_byte(pdev, 0x40, tmp);
+		
+		pdev->class = 0x010601;
+#else
+		return -ENODEV;
+#endif
+	}
+
+
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
diff -Nur linux-2.6.19-rc5-git7.orig/drivers/ata/Kconfig linux-2.6.19-rc5-git7/drivers/ata/Kconfig
--- linux-2.6.19-rc5-git7.orig/drivers/ata/Kconfig	2006-11-17 00:39:48.000000000 +0800
+++ linux-2.6.19-rc5-git7/drivers/ata/Kconfig	2006-11-17 00:41:01.000000000 +0800
@@ -27,6 +27,18 @@
 
 	  If unsure, say N.
 
+config SB600_AHCI_IDE
+	bool "ATI SB600 IDE mode of SATA controller support"
+	depends on SATA_AHCI
+	default y
+	help
+	  ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native 
+	  IDE, AHCI and RAID. If this option is enabled, the contoller 
+	  will run in AHCI mode and use ahci.ko as it's driver, otherwise
+	  it will work as an IDE controller using atiixp.ko as it's driver.
+
+	  If unsure, say y.
+
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
 	depends on PCI
diff -Nur linux-2.6.19-rc5-git7.orig/drivers/ide/pci/atiixp.c linux-2.6.19-rc5-git7/drivers/ide/pci/atiixp.c
--- linux-2.6.19-rc5-git7.orig/drivers/ide/pci/atiixp.c	2006-11-17 00:39:41.000000000 +0800
+++ linux-2.6.19-rc5-git7/drivers/ide/pci/atiixp.c	2006-11-17 00:41:19.000000000 +0800
@@ -318,7 +318,8 @@
 	hwif->drives[0].autodma = hwif->autodma;
 }
 
-static void __devinit init_hwif_sb600_legacy(ide_hwif_t *hwif)
+#ifndef CONFIG_SB600_AHCI_IDE
+static void __devinit init_hwif_sb600_sata(ide_hwif_t *hwif)
 {
 
 	hwif->atapi_dma = 1;
@@ -331,6 +332,7 @@
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
 }
+#endif
 
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
@@ -340,13 +342,16 @@
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "ATI SB600 SATA Legacy IDE",
-		.init_hwif	= init_hwif_sb600_legacy,
-		.channels	= 2,
+	},
+#ifndef CONFIG_SB600_AHCI_IDE
+	{	/* 1 */
+		.name		= "ATI SB600 SATA (IDE mode)",
+		.init_hwif	= init_hwif_sb600_sata,
+		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	}
+#endif
 };
 
 /**
@@ -368,7 +373,9 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},
+#ifndef CONFIG_SB600_AHCI_IDE
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE<<8, 0xffff00, 1},
+#endif
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);

