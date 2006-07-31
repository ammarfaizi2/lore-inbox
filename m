Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGaI2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGaI2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGaI2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:28:16 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:61124
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751357AbWGaI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:28:15 -0400
Message-ID: <44CDBF1E.2010001@ed-soft.at>
Date: Mon, 31 Jul 2006 10:28:14 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] add-force-of-use-mmconfig.patch
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch add force for mmconfig. On Intel Macs the efi firmaware gives
a different memory map then ACPI_MCFG provides. This makes the check wether
to use mmconfig or not fail.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>


diff -uNr linux-2.6.18-rc3/arch/i386/Kconfig linux-2.6.18-rc3.mactel/arch/i386/Kconfig
--- linux-2.6.18-rc3/arch/i386/Kconfig	2006-07-31 09:24:20.000000000 +0200
+++ linux-2.6.18-rc3.mactel/arch/i386/Kconfig	2006-07-31 09:27:55.000000000 +0200
@@ -1027,6 +1027,7 @@
 	default y
 
 config PCI_MMCONFIG
+	depends on DMI
 	bool
 	depends on PCI && ACPI && (PCI_GOMMCONFIG || PCI_GOANY)
 	default y
diff -uNr linux-2.6.18-rc3/arch/i386/pci/mmconfig.c linux-2.6.18-rc3.mactel/arch/i386/pci/mmconfig.c
--- linux-2.6.18-rc3/arch/i386/pci/mmconfig.c	2006-07-31 09:24:20.000000000 +0200
+++ linux-2.6.18-rc3.mactel/arch/i386/pci/mmconfig.c	2006-07-31 09:27:57.000000000 +0200
@@ -12,6 +12,8 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/efi.h>
 #include <asm/e820.h>
 #include "pci.h"
 
@@ -187,6 +189,54 @@
 	}
 }
 
+/*
+ * Print system on which MMCONFIG is forced.
+ */
+
+static int __init pci_mmcfg_force_system(struct dmi_system_id *id)
+{
+	printk(KERN_INFO "PCI: System %s detected. Force MMCONFIG\n",
+		id->ident);
+
+	return 0;
+}
+
+/*
+ * DMI table of forced MMCONFIG systems.
+ */
+
+static struct dmi_system_id __initdata pci_mmcfg_dmi_system_apple[] = {
+	{ pci_mmcfg_force_system, "iMac4,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_BIOS_VERSION,"iMac4,1") }},
+	{ pci_mmcfg_force_system, "MacBookPro1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_BIOS_VERSION,"MacBookPro1,1") }},
+	{ pci_mmcfg_force_system, "MacBook1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook1,1")}},
+	{ pci_mmcfg_force_system, "Macmini1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"Macmini1,1")}},
+	{},
+};
+
+/*
+ * Check force MMCONFIG.
+ */
+
+int __init pci_mmcfg_force(void)
+{
+	if (efi_enabled) {
+		if (dmi_check_system(pci_mmcfg_dmi_system_apple)) {
+			add_memory_region(pci_mmcfg_config[0].base_address,
+				pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN, E820_RESERVED);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 void __init pci_mmcfg_init(void)
 {
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
@@ -198,13 +248,15 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
-	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
-			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
-				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
+ 	if (!pci_mmcfg_force()) {
+		if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
+				pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
+				E820_RESERVED)) {
+			printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+					pci_mmcfg_config[0].base_address);
+			printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+			return;
+		}
 	}
 
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");


