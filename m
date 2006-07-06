Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWGFFYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWGFFYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWGFFYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:24:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40832 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932309AbWGFFYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:24:00 -0400
Message-ID: <44AC9F1C.70308@in.ibm.com>
Date: Thu, 06 Jul 2006 10:56:52 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: clameter@sgi.com
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: - zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2.patch
 removed from -mm tree
References: <200606300639.k5U6dnMk029031@shell0.pdx.osdl.net>
In-Reply-To: <200606300639.k5U6dnMk029031@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Correct me if I am wrong :

I was wondering if we are hiding the real bug here. All the pages 
allocated should have the zone set properly. Also, we would not be 
playing with invalid pages, since the pages allocated through 
kmem_getpages() should be contiguous. Also, I did a check in 
kmem_getpages() to see if the zone is set for the pages, properly.. 
surprisingly it was not set for the last page in the allocation!


Thanks,

Suzuki K P
Linux Technology Centre
IBM Software Labs.


akpm@osdl.org wrote:
> The patch titled
> 
>      Fix potential use of out of range page in kmem_getpages.
> 
> has been removed from the -mm tree.  Its filename is
> 
>      zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2.patch
> 
> This patch was dropped because it was folded into zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
> 
> ------------------------------------------------------
> Subject: Fix potential use of out of range page in kmem_getpages.
> From: Christoph Lameter <clameter@sgi.com>
> 
> 
> ZVC: Fix potential use of out of range page in kmem_getpages.
> 
> We use page_zone(page) following several page increments in kmem_getpages().
> Which page in a zone we use really does not matter. However, we may reach an
> invalid page and then oops.
> 
> So move the counter decrement before we increment page.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  mm/slab.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN mm/slab.c~zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2 mm/slab.c
> --- 25/mm/slab.c~zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2	Tue Jun 27 15:22:51 2006
> +++ 25-akpm/mm/slab.c	Tue Jun 27 15:22:51 2006
> @@ -1522,12 +1522,12 @@ static void kmem_freepages(struct kmem_c
>  	struct page *page = virt_to_page(addr);
>  	const unsigned long nr_freed = i;
>  
> +	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
>  	while (i--) {
>  		BUG_ON(!PageSlab(page));
>  		__ClearPageSlab(page);
>  		page++;
>  	}
> -	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += nr_freed;
>  	free_pages((unsigned long)addr, cachep->gfporder);
> _
> 
> Patches currently in -mm which might be from clameter@sgi.com are
> 
> origin.patch
> usb-remove-empty-destructor-from-drivers-usb-mon-mon_textc.patch
> zoned-vm-counters-create-vmstatc-h-from-page_allocc-h.patch
> zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation.patch
> zoned-vm-counters-convert-nr_mapped-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter.patch
> zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure.patch
> zoned-vm-counters-split-nr_anon_pages-off-from-nr_file_mapped.patch
> zoned-vm-counters-zone_reclaim-remove-proc-sys-vm-zone_reclaim_interval.patch
> zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2.patch
> zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
> zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix-2.patch
> zoned-vm-counters-remove-useless-struct-wbs.patch
> use-zoned-vm-counters-for-numa-statistics-v3.patch
> light-weight-event-counters-v5.patch
> slab-consolidate-code-to-free-slabs-from-freelist.patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
