Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWDJECP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWDJECP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 00:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDJECP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 00:02:15 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:54985 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750758AbWDJECO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 00:02:14 -0400
Date: Mon, 10 Apr 2006 06:01:20 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Subject: [RFC/PATCH] remove unneeded check in bcm43xx
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Message-id: <20060410040120.GA4860@ens-lyon.fr>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the driver already sets the correct dma_mask, there is no reason
to bail there. In fact if you have an iommu, I think you can have a
address above 1G which will be ok for the device (if it isn't true then
the powerpc dma_alloc_coherent with iommu needs to be fixed because it
doesn't respect the the dma_mask).

Please comment or apply.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>

Index: linux/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
===================================================================
--- linux.orig/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
+++ linux/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
@@ -194,14 +194,6 @@ static int alloc_ringmemory(struct bcm43
 		printk(KERN_ERR PFX "DMA ringmemory allocation failed\n");
 		return -ENOMEM;
 	}
-	if (ring->dmabase + BCM43xx_DMA_RINGMEMSIZE > BCM43xx_DMA_BUSADDRMAX) {
-		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RINGMEMORY >1G "
-				    "(0x%08x, len: %lu)\n",
-		       ring->dmabase, BCM43xx_DMA_RINGMEMSIZE);
-		dma_free_coherent(dev, BCM43xx_DMA_RINGMEMSIZE,
-				  ring->vbase, ring->dmabase);
-		return -ENOMEM;
-	}
 	assert(!(ring->dmabase & 0x000003FF));
 	memset(ring->vbase, 0, BCM43xx_DMA_RINGMEMSIZE);
 
@@ -303,14 +295,6 @@ static int setup_rx_descbuffer(struct bc
 	if (unlikely(!skb))
 		return -ENOMEM;
 	dmaaddr = map_descbuffer(ring, skb->data, ring->rx_buffersize, 0);
-	if (unlikely(dmaaddr + ring->rx_buffersize > BCM43xx_DMA_BUSADDRMAX)) {
-		unmap_descbuffer(ring, dmaaddr, ring->rx_buffersize, 0);
-		dev_kfree_skb_any(skb);
-		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RX SKB >1G "
-				    "(0x%08x, len: %u)\n",
-		       dmaaddr, ring->rx_buffersize);
-		return -ENOMEM;
-	}
 	meta->skb = skb;
 	meta->dmaaddr = dmaaddr;
 	skb->dev = ring->bcm->net_dev;
@@ -726,13 +710,6 @@ static int dma_tx_fragment(struct bcm43x
 
 	meta->skb = skb;
 	meta->dmaaddr = map_descbuffer(ring, skb->data, skb->len, 1);
-	if (unlikely(meta->dmaaddr + skb->len > BCM43xx_DMA_BUSADDRMAX)) {
-		return_slot(ring, slot);
-		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA TX SKB >1G "
-				    "(0x%08x, len: %u)\n",
-		       meta->dmaaddr, skb->len);
-		return -ENOMEM;
-	}
 
 	desc_addr = (u32)(meta->dmaaddr + ring->memoffset);
 	desc_ctl = BCM43xx_DMADTOR_FRAMESTART | BCM43xx_DMADTOR_FRAMEEND;
