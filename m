Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQKXPwg>; Fri, 24 Nov 2000 10:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129325AbQKXPw0>; Fri, 24 Nov 2000 10:52:26 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4356 "EHLO
        jurassic.park.msu.ru") by vger.kernel.org with ESMTP
        id <S129231AbQKXPwP>; Fri, 24 Nov 2000 10:52:15 -0500
Date: Fri, 24 Nov 2000 18:21:18 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: alpha: small PCI fixes (test11-ac3)
Message-ID: <20001124182118.A551@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just out of curiosity I tried S3 Sonic Vibes sound card, which has
only 24 address lines connected, on sx164. This revealed two bugs
in the pci code:
 - dma mask 0x00ffffff (24 bits) exactly fits the ISA scatter-gather
   window, but was rejected by pci_dma_supported() due to off-by-one bug.
 - this card has some non-standard set of I/O ports, and driver tries to
   allocate resource for it at the runtime.  At this time
   pcibios_update_resource() already has been vanished.

With these fixes the card started to work to the best of its ability,
i.e. screechy and noisy, so after being so helpful the poor thing went
back into the rubbish bin...

Ivan.

--- 2.4.0t11ac3/arch/alpha/kernel/pci_iommu.c	Sat Sep 23 01:07:43 2000
+++ linux/arch/alpha/kernel/pci_iommu.c	Thu Nov 23 14:35:40 2000
@@ -613,10 +613,10 @@ pci_dma_supported(struct pci_dev *pdev, 
 	/* Check that we have a scatter-gather arena that fits.  */
 	hose = pdev ? pdev->sysdata : pci_isa_hose;
 	arena = hose->sg_isa;
-	if (arena && arena->dma_base + arena->size <= mask)
+	if (arena && arena->dma_base + arena->size - 1 <= mask)
 		return 1;
 	arena = hose->sg_pci;
-	if (arena && arena->dma_base + arena->size <= mask)
+	if (arena && arena->dma_base + arena->size - 1 <= mask)
 		return 1;
 
 	return 0;
--- 2.4.0t11ac3/arch/alpha/kernel/pci.c	Thu Nov 23 13:07:02 2000
+++ linux/arch/alpha/kernel/pci.c	Thu Nov 23 15:09:59 2000
@@ -282,7 +282,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void
 pcibios_update_resource(struct pci_dev *dev, struct resource *root,
 			struct resource *res, int resource)
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
