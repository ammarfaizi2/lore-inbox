Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHCRg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHCRg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUHCRg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:36:58 -0400
Received: from [213.146.154.40] ([213.146.154.40]:20431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266748AbUHCRgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:36:43 -0400
Subject: [PATCH] [2/3] PCI quirks -- PPC.
From: David Woodhouse <dwmw2@infradead.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       benh@kernel.crashing.org
In-Reply-To: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 03 Aug 2004 18:36:39 +0100
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 UPPERCASE_25_50        message body is 25-50% uppercase
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove up the PPC pcibios_fixups[] array. Remove the ifdefs on
CONFIG_PPC_PMAC in the kernel PPC code, moving that stuff into
pmac-specific files where it lives. Add a quirk for the CardBus
controller on WindRiver SBC8260.

===== arch/ppc/kernel/pci.c 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/pci.c	2004-07-26 19:40:32 +01:00
+++ edited/arch/ppc/kernel/pci.c	2004-08-03 16:40:19 +01:00
@@ -45,11 +45,6 @@
 static int reparent_resources(struct resource *parent, struct resource *res);
 static void fixup_rev1_53c810(struct pci_dev* dev);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
-#ifdef CONFIG_PPC_PMAC
-extern void pmac_pci_fixup_cardbus(struct pci_dev* dev);
-extern void pmac_pci_fixup_pciata(struct pci_dev* dev);
-extern void pmac_pci_fixup_k2_sata(struct pci_dev* dev);
-#endif
 #ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
 #endif
@@ -64,20 +59,6 @@
 
 static int pci_bus_count;
 
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TRIDENT,	PCI_ANY_ID,			fixup_broken_pcnet32 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	fixup_rev1_53c810 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64},
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources },
-#ifdef CONFIG_PPC_PMAC
-	/* We should add per-machine fixup support in xxx_setup.c or xxx_pci.c */
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_TI,	PCI_ANY_ID,			pmac_pci_fixup_cardbus },
-	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			pmac_pci_fixup_pciata },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS, 0x0240,			pmac_pci_fixup_k2_sata },
-#endif /* CONFIG_PPC_PMAC */
- 	{ 0 }
-};
-
 static void
 fixup_rev1_53c810(struct pci_dev* dev)
 {
@@ -90,6 +71,7 @@
 		dev->class = PCI_CLASS_STORAGE_SCSI;
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	fixup_rev1_53c810);
 
 static void
 fixup_broken_pcnet32(struct pci_dev* dev)
@@ -100,6 +82,7 @@
 		pci_name_device(dev);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT,	PCI_ANY_ID,			fixup_broken_pcnet32);
 
 static void
 fixup_cpc710_pci64(struct pci_dev* dev)
@@ -112,6 +95,7 @@
 	dev->resource[1].start = dev->resource[1].end = 0;
 	dev->resource[1].flags = 0;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
 
 static void
 pcibios_fixup_resources(struct pci_dev *dev)
@@ -158,6 +142,7 @@
 	if (ppc_md.pcibios_fixup_resources)
 		ppc_md.pcibios_fixup_resources(dev);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources);
 
 void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
===== arch/ppc/platforms/pmac_pci.c 1.21 vs edited =====
--- 1.21/arch/ppc/platforms/pmac_pci.c	2004-07-29 05:58:35 +01:00
+++ edited/arch/ppc/platforms/pmac_pci.c	2004-08-03 15:32:48 +01:00
@@ -1034,6 +1034,8 @@
 	}
 }
 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_ANY_ID, pmac_pci_fixup_cardbus);
+
 void pmac_pci_fixup_pciata(struct pci_dev* dev)
 {
        u8 progif = 0;
@@ -1074,6 +1076,8 @@
 			printk(KERN_ERR "Rewrite of PROGIF failed !\n");
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pmac_pci_fixup_pciata);
+
 
 /*
  * Disable second function on K2-SATA, it's broken
@@ -1104,3 +1108,4 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, 0x0240, pmac_pci_fixup_k2_sata);
===== arch/ppc/platforms/sbc82xx.c 1.5 vs edited =====
--- 1.5/arch/ppc/platforms/sbc82xx.c	2004-06-17 00:01:26 +01:00
+++ edited/arch/ppc/platforms/sbc82xx.c	2004-08-03 16:33:52 +01:00
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pci.h>
 
 #include <asm/mpc8260.h>
 #include <asm/machdep.h>
@@ -237,6 +238,25 @@
 }
 
 
+static void __devinit quirk_sbc8260_cardbus(struct pci_dev *pdev)
+{
+	uint32_t ctrl;
+
+	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(17, 0))
+		return;
+
+	printk(KERN_INFO "Setting up CardBus controller\n");
+
+	/* Set P2CCLK bit in System Control Register */
+	pci_read_config_dword(pdev, 0x80, &ctrl);
+	ctrl |= (1<<27);
+	pci_write_config_dword(pdev, 0x80, ctrl);
+
+	/* Set MFUNC up for PCI IRQ routing via INTA and INTB, and LEDs. */
+	pci_write_config_dword(pdev, 0x8c, 0x00c01d22);
+
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1420, quirk_sbc8260_cardbus);
 
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,


-- 
dwmw2

