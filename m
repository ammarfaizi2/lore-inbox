Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVH3EyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVH3EyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVH3EyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:54:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:41942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932138AbVH3EyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:54:13 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:49:26 +1000
Message-Id: <1125377367.11948.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 21:40 -0700, Linus Torvalds wrote:
> 
> On Mon, 29 Aug 2005, David S. Miller wrote:
> > 
> > So I think the kernel, by not enabling the ROM, is doing the
> > right thing here.
> 
> Notice that on ppc even older versions didn't actually _enable_ the rom,
> but they would write the non-enabled address to the PCI_ROM_ADDRESS
> register, so that anybody who read that register would see _where_ the ROM
> would be enabled if it was enabled.
> 
> That's the thing that changed in the commit Ben dislikes. Now, if the ROM
> is disabled, we won't even write the disabled address to the PCI register,
> because it led to trouble on some strange Matrox card. Probably a card
> that nobody has ever used on PPC, and certainly not on a Powerbook, so in
> that sense the apparent breakage on ppc is arguably "unnecessary" as far
> as Ben is concerned.
> 
> But I notice the problem: pci_enable_rom() is indeed broken with the 
> change.
> 
> Ben, does this (totally untested) patch fix it for you?

I was just testing a slightly different one that appear to fix the
problem :

Index: linux-work/drivers/pci/rom.c
===================================================================
--- linux-work.orig/drivers/pci/rom.c	2005-08-01 22:03:44.000000000 +1000
+++ linux-work/drivers/pci/rom.c	2005-08-30 14:46:26.000000000 +1000
@@ -23,9 +23,12 @@
  */
 static void pci_enable_rom(struct pci_dev *pdev)
 {
+	struct pci_bus_region region;
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	u32 rom_addr;
 
-	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
+	pcibios_resource_to_bus(pdev, &region, res);
+	rom_addr = region.start | (res->flags & PCI_REGION_FLAG_MASK);
 	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
 }
@@ -71,12 +74,17 @@
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
+			if (res->parent == NULL) {
+				int err;
+				err = pci_assign_resource(pdev,
+							  PCI_ROM_RESOURCE);
+				if (err)
+					return NULL;
+			}
 			start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			if (*size == 0)


