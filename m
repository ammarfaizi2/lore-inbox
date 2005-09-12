Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVILX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVILX7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVILX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:59:39 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30924 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932229AbVILX7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:59:38 -0400
Date: Mon, 12 Sep 2005 16:59:36 -0700
From: Grant Grundler <iod00d@hp.com>
To: Grant Grundler <iod00d@hp.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org, ak@suse.de,
       tony.luck@intel.com, Asit.K.Mallick@intel.com
Subject: Re: [patch 2.6.13 (take #2)] swiotlb: BUG() for DMA_NONE in sync_single
Message-ID: <20050912235936.GK21820@esmail.cup.hp.com>
References: <09122005104851.31056@bilbo.tuxdriver.com> <09122005104851.31120@bilbo.tuxdriver.com> <20050912185120.GD21820@esmail.cup.hp.com> <20050912195110.GC19644@tuxdriver.com> <20050912195356.GD19644@tuxdriver.com> <20050912202333.GF21820@esmail.cup.hp.com> <20050912234532.GH19644@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912234532.GH19644@tuxdriver.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 07:45:34PM -0400, John W. Linville wrote:
> Call BUG() if DMA_NONE is passed-in as direction for sync_single.
> Also remove unnecessary checks for DMA_NONE in callers of sync_single.

Looks good to me! :^)

> Signed-off-by: John W. Linville <linville@tuxdriver.com>

In case it matters:
	ACKed-by: Grant Grundler <iod00d@hp.com>

thanks
grant

> ---
> This patch replaces the previous patch with (almost) the same subject.
> 
>  lib/swiotlb.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -315,13 +315,13 @@ sync_single(struct device *hwdev, char *
>  	case SYNC_FOR_CPU:
>  		if (likely(dir == DMA_FROM_DEVICE || dma == DMA_BIDIRECTIONAL))
>  			memcpy(buffer, dma_addr, size);
> -		else if (dir != DMA_TO_DEVICE && dir != DMA_NONE)
> +		else if (dir != DMA_TO_DEVICE)
>  			BUG();
>  		break;
>  	case SYNC_FOR_DEVICE:
>  		if (likely(dir == DMA_TO_DEVICE || dma == DMA_BIDIRECTIONAL))
>  			memcpy(dma_addr, buffer, size);
> -		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
> +		else if (dir != DMA_FROM_DEVICE)
>  			BUG();
>  		break;
>  	default:
> @@ -515,8 +515,6 @@ swiotlb_sync_single(struct device *hwdev
>  {
>  	char *dma_addr = phys_to_virt(dev_addr);
>  
> -	if (dir == DMA_NONE)
> -		BUG();
>  	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
>  		sync_single(hwdev, dma_addr, size, dir, target);
>  	else if (dir == DMA_FROM_DEVICE)
> @@ -547,8 +545,6 @@ swiotlb_sync_single_range(struct device 
>  {
>  	char *dma_addr = phys_to_virt(dev_addr) + offset;
>  
> -	if (dir == DMA_NONE)
> -		BUG();
>  	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
>  		sync_single(hwdev, dma_addr, size, dir, target);
>  	else if (dir == DMA_FROM_DEVICE)
> @@ -651,9 +647,6 @@ swiotlb_sync_sg(struct device *hwdev, st
>  {
>  	int i;
>  
> -	if (dir == DMA_NONE)
> -		BUG();
> -
>  	for (i = 0; i < nelems; i++, sg++)
>  		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
>  			sync_single(hwdev, (void *) sg->dma_address,
> -- 
> John W. Linville
> linville@tuxdriver.com
