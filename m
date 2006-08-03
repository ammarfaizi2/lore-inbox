Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWHCDwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWHCDwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHCDwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:52:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15853 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932180AbWHCDwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:52:44 -0400
Date: Wed, 2 Aug 2006 22:57:24 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 2 of 4] [x86-64] Calgary: only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
Message-ID: <20060803035723.GA7323@us.ibm.com>
References: <patchbomb.1154559547@rhun.haifa.ibm.com> <515131a26b151f1e4596.1154559549@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515131a26b151f1e4596.1154559549@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:59:09AM +0300, Muli Ben-Yehuda wrote:
> 1 files changed, 36 insertions(+), 10 deletions(-)
> arch/x86_64/kernel/pci-calgary.c |   46 +++++++++++++++++++++++++++++---------
> 
> 
> # HG changeset patch
> # User Muli Ben-Yehuda <muli@il.ibm.com>
> # Date 1154558421 -10800
> # Node ID 515131a26b151f1e459642268184d98099e72a6c
> # Parent  9cd758467ce15605504369cf56f790aea8c74748
> [x86-64] Calgary: only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
> 
> Introduce new function verify_bit_range(). Define two versions, one
> for CONFIG_IOMMU_DEBUG enabled and one for disabled. Previously we
> were checking that the bitmap was consistent every time we allocated
> or freed an entry in the TCE table, which is good for debugging but
> incurs an unnecessary penalty on non debug builds.
> 
> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> 
> diff -r 9cd758467ce1 -r 515131a26b15 arch/x86_64/kernel/pci-calgary.c
> --- a/arch/x86_64/kernel/pci-calgary.c	Thu Aug 03 01:37:12 2006 +0300
> +++ b/arch/x86_64/kernel/pci-calgary.c	Thu Aug 03 01:40:21 2006 +0300
> @@ -133,12 +133,35 @@ static inline void tce_cache_blast_stres
>  {
>  	tce_cache_blast(tbl);
>  }
> +
> +static inline unsigned long verify_bit_range(unsigned long* bitmap,
> +	int expected, unsigned long start, unsigned long end)
> +{
> +	unsigned long idx = start;
> +
> +	BUG_ON(start > end);

This should be ">=".

Thanks,
Jon

> +
> +	while (idx < end) {
> +		if (!!test_bit(idx, bitmap) != expected)
> +			return idx;
> +		++idx;
> +	}
> +
> +	/* all bits have the expected value */
> +	return ~0UL;
> +}
>  #else /* debugging is disabled */
>  int debugging __read_mostly = 0;
>  
>  static inline void tce_cache_blast_stress(struct iommu_table *tbl)
>  {
>  }
> +
> +static inline unsigned long verify_bit_range(unsigned long* bitmap,
> +	int expected, unsigned long start, unsigned long end)
> +{
> +	return ~0UL;
> +}
>  #endif /* CONFIG_IOMMU_DEBUG */
>  
>  static inline unsigned int num_dma_pages(unsigned long dma, unsigned int dmalen)
> @@ -162,6 +185,7 @@ static void iommu_range_reserve(struct i
>  {
>  	unsigned long index;
>  	unsigned long end;
> +	unsigned long badbit;
>  
>  	index = start_addr >> PAGE_SHIFT;
>  
> @@ -173,14 +197,15 @@ static void iommu_range_reserve(struct i
>  	if (end > tbl->it_size) /* don't go off the table */
>  		end = tbl->it_size;
>  
> -	while (index < end) {
> -		if (test_bit(index, tbl->it_map))
> +	badbit = verify_bit_range(tbl->it_map, 0, index, end);
> +	if (badbit != ~0UL) {
> +		if (printk_ratelimit())
>  			printk(KERN_ERR "Calgary: entry already allocated at "
>  			       "0x%lx tbl %p dma 0x%lx npages %u\n",
> -			       index, tbl, start_addr, npages);
> -		++index;
> -	}
> -	set_bit_string(tbl->it_map, start_addr >> PAGE_SHIFT, npages);
> +			       badbit, tbl, start_addr, npages);
> +	}
> +
> +	set_bit_string(tbl->it_map, index, npages);
>  }
>  
>  static unsigned long iommu_range_alloc(struct iommu_table *tbl,
> @@ -247,7 +272,7 @@ static void __iommu_free(struct iommu_ta
>  	unsigned int npages)
>  {
>  	unsigned long entry;
> -	unsigned long i;
> +	unsigned long badbit;
>  
>  	entry = dma_addr >> PAGE_SHIFT;
>  
> @@ -255,11 +280,12 @@ static void __iommu_free(struct iommu_ta
>  
>  	tce_free(tbl, entry, npages);
>  
> -	for (i = 0; i < npages; ++i) {
> -		if (!test_bit(entry + i, tbl->it_map))
> +	badbit = verify_bit_range(tbl->it_map, 1, entry, entry + npages);
> +	if (badbit != ~0UL) {
> +		if (printk_ratelimit())
>  			printk(KERN_ERR "Calgary: bit is off at 0x%lx "
>  			       "tbl %p dma 0x%Lx entry 0x%lx npages %u\n",
> -			       entry + i, tbl, dma_addr, entry, npages);
> +			       badbit, tbl, dma_addr, entry, npages);
>  	}
>  
>  	__clear_bit_string(tbl->it_map, entry, npages);
