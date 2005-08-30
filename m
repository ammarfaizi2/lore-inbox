Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVH3EmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVH3EmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVH3EmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:42:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932124AbVH3EmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:42:20 -0400
Date: Mon, 29 Aug 2005 21:40:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <20050829.212021.43291105.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston> <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org> <20050829.212021.43291105.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, David S. Miller wrote:
> 
> So I think the kernel, by not enabling the ROM, is doing the
> right thing here.

Notice that on ppc even older versions didn't actually _enable_ the rom,
but they would write the non-enabled address to the PCI_ROM_ADDRESS
register, so that anybody who read that register would see _where_ the ROM
would be enabled if it was enabled.

That's the thing that changed in the commit Ben dislikes. Now, if the ROM
is disabled, we won't even write the disabled address to the PCI register,
because it led to trouble on some strange Matrox card. Probably a card
that nobody has ever used on PPC, and certainly not on a Powerbook, so in
that sense the apparent breakage on ppc is arguably "unnecessary" as far
as Ben is concerned.

But I notice the problem: pci_enable_rom() is indeed broken with the 
change.

Ben, does this (totally untested) patch fix it for you?

			Linus

----
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -23,11 +23,14 @@
  */
 static void pci_enable_rom(struct pci_dev *pdev)
 {
-	u32 rom_addr;
+	struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
+	struct pci_bus_region region;
 
-	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
-	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
-	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+	if (!res->flags)
+		return;
+
+	pcibios_resource_to_bus(pdev, &region, res);
+	pci_write_config_dword(pdev, pdev->rom_base_reg, region.start | PCI_ROM_ADDRESS_ENABLE);
 }
 
 /**
