Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSHNNNF>; Wed, 14 Aug 2002 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHNNNF>; Wed, 14 Aug 2002 09:13:05 -0400
Received: from elin.scali.no ([62.70.89.10]:36881 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S318067AbSHNNNE>;
	Wed, 14 Aug 2002 09:13:04 -0400
Date: Wed, 14 Aug 2002 15:16:59 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-home.isdn.scali.no
To: linux-kernel@vger.kernel.org
cc: "David S. Miller" <davem@redhat.com>
Subject: pci-dma bug in pci_alloc_consistent on i386 ?
In-Reply-To: <1029328630.26226.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208141448350.5329-100000@sp-home.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I _think_ I found a little snag in the pci_alloc_consistent code for i386. 
What I've discovered is that modern GbE drivers (such as the tg3 driver 
written by David and the e1000 driver by Intel), does something like this 
in setup :

	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff)) {
		pci_using_dac = 1;
	} else {
		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
		if (err) {
			printk(KERN_ERR PFX "No usable DMA configuration, "
			       "aborting.\n");
				goto err_out_free_res;
		}
		pci_using_dac = 0;
	}

	if (pci_using_dac)
		dev->features |= NETIF_F_HIGHDMA;


On i386 the first pci_set_dma_mask will succeed, because :

(in include/asm-i386/pci.h)
static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
{
        /*
         * we fall back to GFP_DMA when the mask isn't all 1s,
         * so we can't guarantee allocations that must be
         * within a tighter range than GFP_DMA..
         */
        if(mask < 0x00ffffff)
                return 0;

	return 1;
}

(in drivers/pci/pci.c)
int
pci_set_dma_mask(struct pci_dev *dev, u64 mask)
{
	if (!pci_dma_supported(dev, mask))
		return -EIO;

	dev->dma_mask = mask;

	return 0;
}

And this is just fine, the ethernet adapter will be able to DMA directly 
to any memory (even highmem).


However when they are allocating RX and TX descriptors (and thus using 
pci_alloc_consistent), they are getting GFP_DMA pages. This is why :

(in arch/i386/kernel/pci-dma.c)
void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
			   dma_addr_t *dma_handle)
{
	void *ret;
	int gfp = GFP_ATOMIC;

	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
		gfp |= GFP_DMA;
	ret = (void *)__get_free_pages(gfp, get_order(size));

	if (ret != NULL) {
		memset(ret, 0, size);
		*dma_handle = virt_to_bus(ret);
	}
	return ret;
}


IMHO the criteria for when to select GFP_DMA pages is wrong, it should be :

        if (hwdev == NULL || hwdev->dma_mask < 0xffffffff)
                gfp |= GFP_DMA;

Here's a patch :

--- pci-dma.c.~1~       Wed Aug 14 15:06:49 2002
+++ pci-dma.c   Wed Aug 14 15:08:29 2002
@@ -19,7 +19,7 @@
	void *ret;
	int gfp = GFP_ATOMIC;
 
-	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
+	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff)
		gfp |= GFP_DMA;
	ret = (void *)__get_free_pages(gfp, get_order(size));
 

Regards,
 -- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency


