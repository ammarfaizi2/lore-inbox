Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTHETBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTHETBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:01:51 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:230 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S270621AbTHETBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:01:45 -0400
To: <linux-kernel@vger.kernel.org>
Subject: pci_alloc_consistent() and/or dma_free_coherent() bug?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Aug 2003 19:14:38 +0200
Message-ID: <m3r84010xt.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm doing something like:
        pci_set_dma_mask(pdev, 0xFFFFFFFF) /* 32 bits */
	pci_set_consistent_dma_mask(pdev, 0x0FFFFFFF); /* 28 bits only */

as this card is able to do 32-bit PCI (bus master) addressing on memory
returned by pci_map_single() but it needs "consistent" region in the first
256 MB of RAM.

On i386, pci_alloc_consistent() calls dma_alloc_coherent().

Now:
void *dma_alloc_coherent(struct device *dev, size_t size,
                           dma_addr_t *dma_handle, int gfp)
{
        void *ret;
        /* ignore region specifiers */
        gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);

        if (dev == NULL || (*dev->dma_mask < 0xffffffff))
                gfp |= GFP_DMA;
        ret = (void *)__get_free_pages(gfp, get_order(size));

        if (ret != NULL) {
                memset(ret, 0, size);
                *dma_handle = virt_to_phys(ret);
        }
        return ret;
}

while:

pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
{
        if (!pci_dma_supported(dev, mask))
                return -EIO;

        dev->consistent_dma_mask = mask;

        return 0;
}

pci_set_consistent_dma_mask() sets dev->consistent_dma_mask while
dma_alloc_coherent() (and thus pci_alloc_consistent()) expects the mask
to be in dev->dma_mask.


The "obvious" fix seems to be:

--- arch/i386/kernel/pci-dma.c.orig	2003-05-27 03:00:25.000000000 +0200
+++ arch/i386/kernel/pci-dma.c	2003-08-05 18:55:42.000000000 +0200
@@ -20,7 +20,7 @@
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+	if (dev == NULL || (*dev->consistent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 

but I'm not sure if we need to adjust dev->consistent_dma_mask in
pci_set_dma_mask() (not only in pci_set_consistent_dma_mask()), in case
a driver only calls pci_set_dma_mask() and assumes it will work for
pci_alloc_consistent() as well.
-- 
Krzysztof Halasa
Network Administrator
