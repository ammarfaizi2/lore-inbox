Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWBGWzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWBGWzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWBGWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:55:10 -0500
Received: from [69.3.150.202] ([69.3.150.202]:2032 "EHLO alpha.penguintown.net")
	by vger.kernel.org with ESMTP id S1030194AbWBGWzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:55:08 -0500
Message-ID: <37389.10.0.0.8.1139352883.squirrel@mail>
Date: Tue, 7 Feb 2006 14:54:43 -0800 (PST)
Subject: [PATCH 2.6.15.3] alpha/pci: set cache line size for cards ignored 
     by SRM
From: "Gabriele Gorla" <gorlik@penguintown.net>
To: ink@jurassic.park.msu.ru, rth@twiddle.net, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriele Gorla <gorlik@yahoo.com>

Set the cache line size in the PCI configuration space to a reasonable
value. SRM does not seem to set this register for the PCI cards that it
does not recognize. This makes drivers that expect cache line size to be
set by the card bios work on alpha.

Signed-off-by: Gabriele Gorla <gorlik@yahoo.com>

---

--- linux-2.6.15.3/arch/alpha/kernel/pci.c.orig 2006-02-07 14:24:59 -0800
+++ linux-2.6.15.3/arch/alpha/kernel/pci.c      2006-02-07 14:19:59 -0800
@@ -108,11 +108,24 @@ static void __init
 pcibios_fixup_final(struct pci_dev *dev)
 {
        unsigned int class = dev->class >> 8;
+       u8 cache_line_size;

        if (class == PCI_CLASS_BRIDGE_ISA || class ==
PCI_CLASS_BRIDGE_EISA) {
                dev->dma_mask = MAX_ISA_DMA_ADDRESS - 1;
                isa_bridge = dev;
        }
+
+       /* if the cache line is not set by SRM attempt to fix it */
+       pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cache_line_size);
+       if(cache_line_size == 0) {
+               pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
+                                     L1_CACHE_BYTES >> 2);
+               pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE,
+                                    &cache_line_size);
+               if(cache_line_size == (L1_CACHE_BYTES >> 2) )
+                       printk("PCI: Setting cache line size of device %s"
+                              " to %d\n", pci_name(dev), L1_CACHE_BYTES );
+       }
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_final);


