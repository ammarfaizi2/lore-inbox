Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUHXAjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUHXAjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUHWTiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:38:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:55235 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266883AbUHWSgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860852863@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860853794@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.12, 2004/08/04 08:43:07-04:00, dwmw2@shinybook.infradead.org

PCI quirks -- ppc64

Remove pcibios_fixups[] array and move the declarations to live with
the implementations. Remove unneeded pcibios_name_device() on iSeries.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc64/kernel/iSeries_pci.c |    4 ----
 arch/ppc64/kernel/pSeries_pci.c |    5 +++--
 arch/ppc64/kernel/pci.c         |   22 ++--------------------
 arch/ppc64/kernel/pmac_pci.c    |    1 +
 4 files changed, 6 insertions(+), 26 deletions(-)


diff -Nru a/arch/ppc64/kernel/iSeries_pci.c b/arch/ppc64/kernel/iSeries_pci.c
--- a/arch/ppc64/kernel/iSeries_pci.c	2004-08-23 11:06:12 -07:00
+++ b/arch/ppc64/kernel/iSeries_pci.c	2004-08-23 11:06:12 -07:00
@@ -820,7 +820,3 @@
 	} while (CheckReturnCode("WWL", DevNode, rc) != 0);
 }
 EXPORT_SYMBOL(iSeries_Write_Long);
-
-void pcibios_name_device(struct pci_dev *dev)
-{
-}
diff -Nru a/arch/ppc64/kernel/pSeries_pci.c b/arch/ppc64/kernel/pSeries_pci.c
--- a/arch/ppc64/kernel/pSeries_pci.c	2004-08-23 11:06:12 -07:00
+++ b/arch/ppc64/kernel/pSeries_pci.c	2004-08-23 11:06:12 -07:00
@@ -519,9 +519,9 @@
 	return 0;
 }
 
+#if 0
 void pcibios_name_device(struct pci_dev *dev)
 {
-#if 0
 	struct device_node *dn;
 
 	/*
@@ -541,8 +541,9 @@
 			}
 		}
 	}
-#endif
 }   
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
+#endif
 
 void __devinit pcibios_fixup_device_resources(struct pci_dev *dev,
 					   struct pci_bus *bus)
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	2004-08-23 11:06:12 -07:00
+++ b/arch/ppc64/kernel/pci.c	2004-08-23 11:06:12 -07:00
@@ -55,12 +55,6 @@
 unsigned long isa_io_base;	/* NULL if no ISA bus */
 unsigned long pci_io_base;
 
-void pcibios_name_device(struct pci_dev* dev);
-void pcibios_final_fixup(void);
-static void fixup_broken_pcnet32(struct pci_dev* dev);
-static void fixup_windbond_82c105(struct pci_dev* dev);
-extern void fixup_k2_sata(struct pci_dev* dev);
-
 void iSeries_pcibios_init(void);
 
 struct pci_controller *hose_head;
@@ -74,20 +68,6 @@
 /* Cached ISA bridge dev. */
 struct pci_dev *ppc64_isabridge_dev = NULL;
 
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TRIDENT,		PCI_ANY_ID,
-	  fixup_broken_pcnet32 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_WINBOND,		PCI_DEVICE_ID_WINBOND_82C105,
-	  fixup_windbond_82c105 },
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,    			PCI_ANY_ID,
-	  pcibios_name_device },
-#ifdef CONFIG_PPC_PMAC
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	0x0240,
-	  fixup_k2_sata },
-#endif
-	{ 0 }
-};
-
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
@@ -96,6 +76,7 @@
 		pci_name_device(dev);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT, PCI_ANY_ID, fixup_broken_pcnet32);
 
 static void fixup_windbond_82c105(struct pci_dev* dev)
 {
@@ -118,6 +99,7 @@
 			dev->resource[i].flags &= ~IORESOURCE_IO;
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, fixup_windbond_82c105);
 
 void 
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
diff -Nru a/arch/ppc64/kernel/pmac_pci.c b/arch/ppc64/kernel/pmac_pci.c
--- a/arch/ppc64/kernel/pmac_pci.c	2004-08-23 11:06:12 -07:00
+++ b/arch/ppc64/kernel/pmac_pci.c	2004-08-23 11:06:12 -07:00
@@ -777,3 +777,4 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, 0x0240, fixup_k2_sata);

