Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWDJMIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWDJMIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDJMIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 08:08:43 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:40425 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751147AbWDJMIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 08:08:42 -0400
Date: Mon, 10 Apr 2006 14:09:22 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       Michael Buesch <mb@bu3sch.de>
Subject: Re: + remove-unneeded-check-in-bcm43xx.patch added to -mm tree
Message-ID: <20060410120922.GR27596@ens-lyon.fr>
References: <200604100816.k3A8GUve001390@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604100816.k3A8GUve001390@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 12:15:53AM -0700, akpm@osdl.org wrote:
> 
> The patch titled
> 
>      remove unneeded check in bcm43xx
> 
> has been added to the -mm tree.  Its filename is
> 
>      remove-unneeded-check-in-bcm43xx.patch

It has been NACKed by Michael Buesch. The problem is in the ppc
dma_alloc_coherent that returns a non suitable zone (it doesn't respect
dma_mask).

Please remove from -mm, sorry for bothering.

Benoit
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> 
> From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> 
> Since the driver already sets the correct dma_mask, there is no reason to
> bail there.  In fact if you have an iommu, I think you can have a address
> above 1G which will be ok for the device (if it isn't true then the powerpc
> dma_alloc_coherent with iommu needs to be fixed because it doesn't respect
> the the dma_mask).
> 
> Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>
> Cc: "John W. Linville" <linville@tuxdriver.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/net/wireless/bcm43xx/bcm43xx_dma.c |   23 -------------------
>  1 files changed, 23 deletions(-)
> 
> diff -puN drivers/net/wireless/bcm43xx/bcm43xx_dma.c~remove-unneeded-check-in-bcm43xx drivers/net/wireless/bcm43xx/bcm43xx_dma.c
> --- devel/drivers/net/wireless/bcm43xx/bcm43xx_dma.c~remove-unneeded-check-in-bcm43xx	2006-04-10 00:15:40.000000000 -0700
> +++ devel-akpm/drivers/net/wireless/bcm43xx/bcm43xx_dma.c	2006-04-10 00:15:40.000000000 -0700
> @@ -194,14 +194,6 @@ static int alloc_ringmemory(struct bcm43
>  		printk(KERN_ERR PFX "DMA ringmemory allocation failed\n");
>  		return -ENOMEM;
>  	}
> -	if (ring->dmabase + BCM43xx_DMA_RINGMEMSIZE > BCM43xx_DMA_BUSADDRMAX) {
> -		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RINGMEMORY >1G "
> -				    "(0x%08x, len: %lu)\n",
> -		       ring->dmabase, BCM43xx_DMA_RINGMEMSIZE);
> -		dma_free_coherent(dev, BCM43xx_DMA_RINGMEMSIZE,
> -				  ring->vbase, ring->dmabase);
> -		return -ENOMEM;
> -	}
>  	assert(!(ring->dmabase & 0x000003FF));
>  	memset(ring->vbase, 0, BCM43xx_DMA_RINGMEMSIZE);
>  
> @@ -303,14 +295,6 @@ static int setup_rx_descbuffer(struct bc
>  	if (unlikely(!skb))
>  		return -ENOMEM;
>  	dmaaddr = map_descbuffer(ring, skb->data, ring->rx_buffersize, 0);
> -	if (unlikely(dmaaddr + ring->rx_buffersize > BCM43xx_DMA_BUSADDRMAX)) {
> -		unmap_descbuffer(ring, dmaaddr, ring->rx_buffersize, 0);
> -		dev_kfree_skb_any(skb);
> -		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA RX SKB >1G "
> -				    "(0x%08x, len: %u)\n",
> -		       dmaaddr, ring->rx_buffersize);
> -		return -ENOMEM;
> -	}
>  	meta->skb = skb;
>  	meta->dmaaddr = dmaaddr;
>  	skb->dev = ring->bcm->net_dev;
> @@ -726,13 +710,6 @@ static int dma_tx_fragment(struct bcm43x
>  
>  	meta->skb = skb;
>  	meta->dmaaddr = map_descbuffer(ring, skb->data, skb->len, 1);
> -	if (unlikely(meta->dmaaddr + skb->len > BCM43xx_DMA_BUSADDRMAX)) {
> -		return_slot(ring, slot);
> -		printk(KERN_ERR PFX ">>>FATAL ERROR<<<  DMA TX SKB >1G "
> -				    "(0x%08x, len: %u)\n",
> -		       meta->dmaaddr, skb->len);
> -		return -ENOMEM;
> -	}
>  
>  	desc_addr = (u32)(meta->dmaaddr + ring->memoffset);
>  	desc_ctl = BCM43xx_DMADTOR_FRAMESTART | BCM43xx_DMADTOR_FRAMEEND;
> _
> 
> Patches currently in -mm which might be from benoit.boissinot@ens-lyon.org are
> 
> remove-unneeded-check-in-bcm43xx.patch
> 

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
