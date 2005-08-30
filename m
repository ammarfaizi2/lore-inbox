Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVH3FbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVH3FbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVH3FbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:31:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750752AbVH3FbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:31:21 -0400
Date: Mon, 29 Aug 2005 22:29:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <1125377367.11948.54.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508292226580.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>  <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
  <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>  <20050829.212021.43291105.davem@davemloft.net>
  <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org> <1125377367.11948.54.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> I was just testing a slightly different one that appear to fix the
> problem :
...
> +	rom_addr = region.start | (res->flags & PCI_REGION_FLAG_MASK);

I worry about this one. It's not really correct. The low en bits are 
"reserved", and while I don't know whether writing zero is always correct, 
I do know that just writing the low 4 bits with the old value is a bit 
strange. And the flags don't save the other bits.

So I'd prefer either my previous diff, or one that just re-reads the bits 
entirely, something like the appended..

What does the PCI spec say about the reserved bits? Do we have to save 
them?

			Linus

---
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -24,9 +24,16 @@
 static void pci_enable_rom(struct pci_dev *pdev)
 {
 	u32 rom_addr;
+	struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
+	struct pci_bus_region region;
 
+	if (!res->flags)
+		return;
+
+	pcibios_resource_to_bus(pdev, &region, res);
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
-	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	rom_addr &= ~PCI_ROM_ADDRESS_MASK;
+	rom_addr |= region.start | PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
 }
 
