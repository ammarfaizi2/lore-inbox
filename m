Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVHaEYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHaEYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVHaEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:24:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:30178 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932352AbVHaEYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:24:08 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292226580.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
	 <1125377367.11948.54.camel@gaston>
	 <Pine.LNX.4.58.0508292226580.3243@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 14:16:53 +1000
Message-Id: <1125461814.11948.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new patch based on Linus latest one with better error checking.
Please push if you are fine with it.

This patch fixes a problem with pci_map_rom() which doesn't properly
update the ROM BAR value with the address thas allocated for it by the
PCI code. This problem, among other, breaks boot on Mac laptops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/drivers/pci/rom.c
===================================================================
--- linux-work.orig/drivers/pci/rom.c	2005-08-01 22:03:44.000000000 +1000
+++ linux-work/drivers/pci/rom.c	2005-08-31 14:09:02.000000000 +1000
@@ -21,13 +21,21 @@
  * between the ROM and other resources, so enabling it may disable access
  * to MMIO registers or other card memory.
  */
-static void pci_enable_rom(struct pci_dev *pdev)
+static int pci_enable_rom(struct pci_dev *pdev)
 {
+	struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
+	struct pci_bus_region region;
 	u32 rom_addr;
 
+	if (!res->flags)
+		return -1;
+
+	pcibios_resource_to_bus(pdev, &region, res);
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
-	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	rom_addr &= ~PCI_ROM_ADDRESS_MASK;
+	rom_addr |= region.start | PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+	return 0;
 }
 
 /**
@@ -71,19 +79,21 @@
 	} else {
 		if (res->flags & IORESOURCE_ROM_COPY) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-			return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+			return (void __iomem *)pci_resource_start(pdev,
+							     PCI_ROM_RESOURCE);
 		} else {
 			/* assign the ROM an address if it doesn't have one */
-			if (res->parent == NULL)
-				pci_assign_resource(pdev, PCI_ROM_RESOURCE);
-
+			if (res->parent == NULL &&
+			    pci_assign_resource(pdev,PCI_ROM_RESOURCE))
+				return NULL;
 			start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			if (*size == 0)
 				return NULL;
 
 			/* Enable ROM space decodes */
-			pci_enable_rom(pdev);
+			if (pci_enable_rom(pdev))
+				return NULL;
 		}
 	}
 


