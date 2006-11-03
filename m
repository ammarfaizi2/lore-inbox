Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753450AbWKCSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbWKCSyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWKCSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:54:39 -0500
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:9158 "EHLO
	outbound1-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1753450AbWKCSyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:54:38 -0500
X-BigFish: V
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
Message-Id: <20061103185420.B3FA6CBD48@localhost.localdomain>
Date: Fri,  3 Nov 2006 13:54:20 -0500 (EST)
From: luugi.marsan@amd.com (Luugi Marsan)
X-OriginalArrivalTime: 03 Nov 2006 18:54:15.0193 (UTC) FILETIME=[755F1890:01C6FF79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: conke.hu@amd.com

ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID.IDE modes are used for compatibility with some old OS without AHCI driver,but now they are not necessary for Linux since the kernel has supported AHCI.Some BIOS set Legacy IDE as SB600 SATA's default mode, but the AHCI driver cannot run in Legacy IDE.So, we should set the controller back to AHCI mode if it has been set as IDE by BIOS.

Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>

--- linux-2.6.19-rc4-git5/drivers/pci/quirks.c.orig     2006-11-04 03:50:25.000000000 +0800
+++ linux-2.6.19-rc4-git5/drivers/pci/quirks.c  2006-11-04 03:53:56.000000000 +0800
@@ -796,6 +796,35 @@ static void __init quirk_mediagx_master(
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,   PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
 
+
+/*
+ * ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI
+ * and RAID.
+ * IDE modes are used for compatibility with some old OS without AHCI driver,
+ * but now they are not necessary for Linux since the kernel has supported
+ * AHCI.
+ * Some BIOS set Legacy IDE as SB600 SATA's default mode, but the AHCI driver
+ * cannot run in Legacy IDE.
+ * So, we should set the controller back to AHCI mode if it has been set as IDE
+ * by BIOS.
+ */
+static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
+{
+       if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
+       {
+               u8 tmp;
+
+               pci_read_config_byte(pdev, 0x40, &tmp);
+               pci_write_config_byte(pdev, 0x40, tmp|1);
+               pci_write_config_byte(pdev, 0x9, 1);
+               pci_write_config_byte(pdev, 0xa, 6);
+               pci_write_config_byte(pdev, 0x40, tmp);
+              
+               pdev->class = 0x010601;
+       }
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
+
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
  * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and 

