Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUHXBHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUHXBHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUHWTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:24:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:64707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267189AbUHWSgo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:44 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <109328608438@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <10932860843026@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.7, 2004/08/04 07:56:07-04:00, dwmw2@shinybook.infradead.org

[2/3] PCI quirks -- PPC.

Remove up the PPC pcibios_fixups[] array. Remove the ifdefs on
CONFIG_PPC_PMAC in the kernel PPC code, moving that stuff into
pmac-specific files where it lives. Add a quirk for the CardBus
controller on WindRiver SBC8260.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/kernel/pci.c         |   23 ++++-------------------
 arch/ppc/platforms/pmac_pci.c |    5 +++++
 arch/ppc/platforms/sbc82xx.c  |   20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 19 deletions(-)


diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2004-08-23 11:06:40 -07:00
+++ b/arch/ppc/kernel/pci.c	2004-08-23 11:06:40 -07:00
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
diff -Nru a/arch/ppc/platforms/pmac_pci.c b/arch/ppc/platforms/pmac_pci.c
--- a/arch/ppc/platforms/pmac_pci.c	2004-08-23 11:06:40 -07:00
+++ b/arch/ppc/platforms/pmac_pci.c	2004-08-23 11:06:40 -07:00
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
diff -Nru a/arch/ppc/platforms/sbc82xx.c b/arch/ppc/platforms/sbc82xx.c
--- a/arch/ppc/platforms/sbc82xx.c	2004-08-23 11:06:40 -07:00
+++ b/arch/ppc/platforms/sbc82xx.c	2004-08-23 11:06:40 -07:00
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

