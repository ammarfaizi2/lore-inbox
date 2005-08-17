Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVHQU4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVHQU4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVHQU4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:56:33 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:14485 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751255AbVHQU4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:56:32 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] fix cciss DMA unmap brokenness
Date: Wed, 17 Aug 2005 15:56:29 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10AA4ADC2@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix cciss DMA unmap brokenness
Thread-index: AcWjYCTFTwxco/7nSFuQCOdZXymhpAADcsDA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Williamson, Alex (Linux Kernel Dev)" <alex.williamson@hp.com>,
       "Jens Axboe" <axboe@suse.de>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Aug 2005 20:56:30.0633 (UTC) FILETIME=[24A32990:01C5A36E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex wrote:
> 
>    The CCISS driver seems to loose track of DMA mappings 
> created by it's
> fill_cmd() routine.  Neither callers of this routine are 
> extracting the DMA address created in order to do the unmap.  
> Instead, they simply try to unmap 0x0.  It's easy to see this 
> problem on an x86_64 system when using the "swiotlb=force" 
> boot option.  In this case, the driver is leaking resources 
> of the swiotlb and not causing a sync of the bounce buffer.  Thanks
> 
> Signed-off-by: Alex Williamson <alex.williamson@hp.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> diff -r b9c8e9fdd6b2 drivers/block/cciss.c
> --- a/drivers/block/cciss.c	Wed Aug 17 04:06:25 2005
> +++ b/drivers/block/cciss.c	Wed Aug 17 12:53:40 2005
> @@ -1420,8 +1420,10 @@
>  		}
>  	}	
>  	/* unlock the buffers from DMA */
> +	buff_dma_handle.val32.lower = c->SG[0].Addr.lower;
> +	buff_dma_handle.val32.upper = c->SG[0].Addr.upper;
>  	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
> -			size, PCI_DMA_BIDIRECTIONAL);
> +			c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
>  	cmd_free(h, c, 0);
>          return(return_status);
>  
> @@ -1860,8 +1862,10 @@
>  		
>  cleanup1:	
>  	/* unlock the data buffer from DMA */
> +	buff_dma_handle.val32.lower = c->SG[0].Addr.lower;
> +	buff_dma_handle.val32.upper = c->SG[0].Addr.upper;
>  	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
> -				size, PCI_DMA_BIDIRECTIONAL);
> +				c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
>  	cmd_free(info_p, c, 1);
>  	return (status);
>  } 
> 
> 
> 
