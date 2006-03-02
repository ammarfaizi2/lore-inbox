Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWCBU0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWCBU0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWCBU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:26:40 -0500
Received: from silver.veritas.com ([143.127.12.111]:64572 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751429AbWCBU0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:26:39 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,160,1139212800"; 
   d="scan'208"; a="35302033:sNHT27048156"
Date: Thu, 2 Mar 2006 20:27:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: hugepage: Fix hugepage logic in free_pgtables()
In-Reply-To: <200603021942.k22JgFg13221@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0603022002500.23669@goblin.wat.veritas.com>
References: <200603021942.k22JgFg13221@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Mar 2006 20:26:38.0543 (UTC) FILETIME=[9BD8ADF0:01C63E37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Chen, Kenneth W wrote:
> Hugh Dickins wrote on Thursday, March 02, 2006 10:53 AM
> 
> > Whereas there's still a real ia64 get_unmapped_area bug to be fixed,
> > arising from the same confusion, that is_hugepage_only_range needs
> > to mean overlaps_hugepage_only_range (as on PowerPC) rather than
> > within_hugepage_only_range (as on IA64).  Is Ken fixing that one?
> 
> Yes, I'm fixing it.  See patch below.

Great, thanks.  The second part, using REGION_NUMBER instead of
is_hugepage_only_range in the ia64 hugetlb_free_pgd_range, looks nice.

But the first part, || instead of && in is_hugepage_only_range, looks
insufficient: the start and end of the range might each fall in a
non-huge region, but the range still cross a huge region.

Ah, does RGN_HPAGE nestle up against the TASK_SIZE roof, so any range
already tested against TASK_SIZE (as get_unmapped_area has) cannot
cross RGN_HPAGE?  If so, perhaps it deserves a comment there.  And
if that is so, and can be relied upon, is_hugepage_only_range need
only be testing REGION_NUMBER(addr+len-1) - but it does seem fragile.

Hugh

> 
> [patch] ia64: fix is_hugepage_only_range() definition to be overlaps
>         instead of within architectural restricted hugetlb address
>         range.  Fix all affected usages.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> --- ./include/asm-ia64/page.h.orig	2006-03-02 12:16:00.636688455 -0800
> +++ ./include/asm-ia64/page.h	2006-03-02 12:23:30.151331386 -0800
> @@ -147,7 +147,7 @@ typedef union ia64_va {
>  				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
>  # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
>  # define is_hugepage_only_range(mm, addr, len)		\
> -	 (REGION_NUMBER(addr) == RGN_HPAGE &&	\
> +	 (REGION_NUMBER(addr) == RGN_HPAGE ||	\
>  	  REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
>  extern unsigned int hpage_shift;
>  #endif
> --- ./arch/ia64/mm/hugetlbpage.c.orig	2006-03-02 12:31:12.020466353 -0800
> +++ ./arch/ia64/mm/hugetlbpage.c	2006-03-02 12:31:02.944294589 -0800
> @@ -112,8 +112,7 @@ void hugetlb_free_pgd_range(struct mmu_g
>  			unsigned long floor, unsigned long ceiling)
>  {
>  	/*
> -	 * This is called only when is_hugepage_only_range(addr,),
> -	 * and it follows that is_hugepage_only_range(end,) also.
> +	 * This is called to free hugetlb page tables.
>  	 *
>  	 * The offset of these addresses from the base of the hugetlb
>  	 * region must be scaled down by HPAGE_SIZE/PAGE_SIZE so that
> @@ -125,9 +124,9 @@ void hugetlb_free_pgd_range(struct mmu_g
>  
>  	addr = htlbpage_to_page(addr);
>  	end  = htlbpage_to_page(end);
> -	if (is_hugepage_only_range(tlb->mm, floor, HPAGE_SIZE))
> +	if (REGION_NUMBER(floor) == RGN_HPAGE)
>  		floor = htlbpage_to_page(floor);
> -	if (is_hugepage_only_range(tlb->mm, ceiling, HPAGE_SIZE))
> +	if (REGION_NUMBER(ceiling) == RGN_HPAGE)
>  		ceiling = htlbpage_to_page(ceiling);
>  
>  	free_pgd_range(tlb, addr, end, floor, ceiling);
