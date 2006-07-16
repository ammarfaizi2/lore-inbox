Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946148AbWGPJAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946148AbWGPJAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGPJAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:00:23 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:58803
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S964856AbWGPJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:00:22 -0400
Message-ID: <44BA0025.6020105@ed-soft.at>
Date: Sun, 16 Jul 2006 11:00:21 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: [PATCH 1/1] Add force of use MMCONFIG [try #1]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org> <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org> <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com> <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com> <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com> <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org> <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch add force for mmconfig.
On Intel Macs the efi firmaware gives
a different memory map then ACPI_MCFG
provides. This makes the chack wether
to use mmconfig or not fail.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

diff -uNr linux-2.6.18-rc2/arch/i386/Kconfig linux-2.6.18-rc2.mactel/arch/i386/Kconfig
--- linux-2.6.18-rc2/arch/i386/Kconfig	2006-07-16 10:38:09.000000000 +0200
+++ linux-2.6.18-rc2.mactel/arch/i386/Kconfig	2006-07-16 10:16:12.000000000 +0200
@@ -1027,6 +1027,7 @@
 	default y
 
 config PCI_MMCONFIG
+	depends on DMI
 	bool
 	depends on PCI && ACPI && (PCI_GOMMCONFIG || PCI_GOANY)
 	default y
diff -uNr linux-2.6.18-rc2/arch/i386/pci/mmconfig.c linux-2.6.18-rc2.mactel/arch/i386/pci/mmconfig.c
--- linux-2.6.18-rc2/arch/i386/pci/mmconfig.c	2006-07-16 10:38:10.000000000 +0200
+++ linux-2.6.18-rc2.mactel/arch/i386/pci/mmconfig.c	2006-07-16 10:18:04.000000000 +0200
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
+static int pci_mmcfg_force_system(struct dmi_system_id *id)
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



