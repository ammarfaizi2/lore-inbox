Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVIHBdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVIHBdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVIHBcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:32:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932859AbVIHB3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:44 -0400
Message-Id: <20050908012855.845291000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 3/9] [PATCH] Fix PCI ROM mapping
Content-Disposition: inline; filename=fix-pci-rom-mapping.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

This fixes a problem with pci_map_rom() which doesn't properly
update the ROM BAR value with the address thas allocated for it by the
PCI code. This problem, among other, breaks boot on Mac laptops.

It'ss a new version based on Linus latest one with better error
checking.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/pci/rom.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

Index: linux-2.6.13.y/drivers/pci/rom.c
===================================================================
--- linux-2.6.13.y.orig/drivers/pci/rom.c
+++ linux-2.6.13.y/drivers/pci/rom.c
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
@@ -71,19 +79,21 @@ void __iomem *pci_map_rom(struct pci_dev
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
 

--
