Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVILSvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVILSvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVILSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:51:23 -0400
Received: from palrel10.hp.com ([156.153.255.245]:56022 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932144AbVILSvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:51:22 -0400
Date: Mon, 12 Sep 2005 11:51:20 -0700
From: Grant Grundler <iod00d@hp.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       Asit.K.Mallick@intel.com
Subject: Re: [patch 2.6.13 4/6] swiotlb: support syncing DMA_BIDIRECTIONAL mappings
Message-ID: <20050912185120.GD21820@esmail.cup.hp.com>
References: <09122005104851.31056@bilbo.tuxdriver.com> <09122005104851.31120@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09122005104851.31120@bilbo.tuxdriver.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 10:48:51AM -0400, John W. Linville wrote:
...
> +	switch (target) {
> +	case SYNC_FOR_CPU:
> +		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
> +			memcpy(buffer, dma_addr, size);
> +		else if (dir != DMA_TO_DEVICE && dir != DMA_NONE)
> +			BUG();
> +		break;
> +	case SYNC_FOR_DEVICE:
> +		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> +			memcpy(dma_addr, buffer, size);
> +		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
> +			BUG();
> +		break;
> +	default:
>  		BUG();
> +	}

Isn't "DMA_NONE" expected to generate a warning or panic?

Documentation/DMA-mapping.txt says:
	The value PCI_DMA_NONE is to be used for debugging.  One can
	hold this in a data structure before you come to know the
	precise direction, and this will help catch cases where your
	direction tracking logic has failed to set things up properly.


And it just seems wrong to sync a buffer if no DMA has taking place.

...
> @@ -525,14 +540,15 @@ swiotlb_sync_single_for_device(struct de
>   */
>  static inline void
>  swiotlb_sync_single_range(struct device *hwdev, dma_addr_t dev_addr,
> -			  unsigned long offset, size_t size, int dir)
> +			  unsigned long offset, size_t size,
> +			  int dir, int target)
>  {
>  	char *dma_addr = phys_to_virt(dev_addr) + offset;
>  
>  	if (dir == DMA_NONE)
>  		BUG();

This existing code seems to support the idea that DMA sync interfaces
require the direction be set to something other than DMA_NONE.

thanks,
grant
