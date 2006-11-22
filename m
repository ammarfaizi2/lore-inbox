Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757089AbWKVW1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089AbWKVW1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757087AbWKVW1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:27:05 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:3581 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1757094AbWKVW1B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:27:01 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Add IDE mode support for SB600 SATA 
Date: Thu, 23 Nov 2006 06:23:50 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F3586020108CD36@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add IDE mode support for SB600 SATA 
Thread-Index: AccOhOKGFIUHSdMtQb+ThXa6T2VB/w==
From: "Conke Hu" <conke.hu@amd.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Nov 2006 22:23:54.0227 (UTC) FILETIME=[E4E89C30:01C70E84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch provides users with two options when the SB600 SATA is set as IDE mode by BIOS:
1. Setting the controller back to AHCI mode and using ahci as its driver.
2. Using the controller as a normal IDE.
What's more, without this patch, ahci driver always tries to claim all 4 modes of SB600 SATA, but fails in legacy IDE mode.

Signed-off-by: conke.hu@amd.com
-------
diff -Nur linux-2.6.19-rc6-git4.orig/drivers/ata/ahci.c linux-2.6.19-rc6-git4/drivers/ata/ahci.c
--- linux-2.6.19-rc6-git4.orig/drivers/ata/ahci.c	2006-11-23 13:36:52.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/ata/ahci.c	2006-11-23 13:50:13.000000000 +0800
@@ -323,7 +323,14 @@
 	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci }, /* JMicron JMB366 */
 
 	/* ATI */
+#ifdef CONFIG_SB600_AHCI_IDE
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
+#else
+	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_RAID<<8, 0xffff00, 
+	  board_ahci },
+	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0x010600, 0xffff00, 
+	  board_ahci },
+#endif
 	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
 
 	/* VIA */
diff -Nur linux-2.6.19-rc6-git4.orig/drivers/ata/Kconfig linux-2.6.19-rc6-git4/drivers/ata/Kconfig
--- linux-2.6.19-rc6-git4.orig/drivers/ata/Kconfig	2006-11-23 13:36:52.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/ata/Kconfig	2006-11-23 13:37:50.000000000 +0800
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
diff -Nur linux-2.6.19-rc6-git4.orig/drivers/ide/pci/atiixp.c linux-2.6.19-rc6-git4/drivers/ide/pci/atiixp.c
--- linux-2.6.19-rc6-git4.orig/drivers/ide/pci/atiixp.c	2006-11-23 13:36:51.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/ide/pci/atiixp.c	2006-11-23 13:38:08.000000000 +0800
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
+	},
+#ifndef CONFIG_SB600_AHCI_IDE
+	{	/* 1 */
+		.name		= "ATI SB600 SATA (IDE mode)",
+		.init_hwif	= init_hwif_sb600_sata,
 		.channels	= 2,
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
diff -Nur linux-2.6.19-rc6-git4.orig/drivers/pci/quirks.c linux-2.6.19-rc6-git4/drivers/pci/quirks.c
--- linux-2.6.19-rc6-git4.orig/drivers/pci/quirks.c	2006-11-23 13:36:52.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/pci/quirks.c	2006-11-23 13:38:17.000000000 +0800
@@ -796,6 +796,25 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
 
+#ifdef CONFIG_SB600_AHCI_IDE
+static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
+{
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		u8 tmp;
+
+		pci_read_config_byte(pdev, 0x40, &tmp);
+		pci_write_config_byte(pdev, 0x40, tmp|1);
+		pci_write_config_byte(pdev, 0x9, 1);
+		pci_write_config_byte(pdev, 0xa, 6);
+		pci_write_config_byte(pdev, 0x40, tmp);
+		
+		pdev->class = 0x010601;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
+#endif
+
+
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
  * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and

