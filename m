Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbUKQKLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUKQKLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUKQKLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:11:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262260AbUKQKL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:11:28 -0500
Date: Wed, 17 Nov 2004 04:06:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Ross <chris@tebibyte.org>, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041117060648.GA19107@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117012346.5bfdf7bc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:23:46AM -0800, Andrew Morton wrote:
> Chris Ross <chris@tebibyte.org> wrote:
> >
> > As I suspected, like a recalcitrant teenager it was sneakily waiting 
> >  until everyone was out then it threw a wild party with several ooms and 
> >  an oops. See below...
> 
> That's not an oops - it's just a stack trace.
> 
> >  This, obviously is still without Kame's patch, just the same tree as 
> >  before with the one change you asked for.
> 
> Please ignore the previous patch and try the below.  It looks like Rik's
> analysis is correct: when the caller doesn't have the swap token it just
> cannot reclaim referenced pages and scans its way into an oom.  Defeating
> that logic when we've hit the highest scanning priority does seem to fix
> the problem and those nice qsbench numbers which the thrashing control gave
> us appear to be unaffected.

Oh, this fixes my testcase, and was the reason for the hog slow speed.

Excellent, wasted several days in vain. :(

> diff -puN mm/vmscan.c~vmscan-ignore-swap-token-when-in-trouble mm/vmscan.c
> --- 25/mm/vmscan.c~vmscan-ignore-swap-token-when-in-trouble	2004-11-16 20:30:00.000000000 -0800
> +++ 25-akpm/mm/vmscan.c	2004-11-16 20:30:00.000000000 -0800
> @@ -380,7 +380,7 @@ static int shrink_list(struct list_head 
>  		if (page_mapped(page) || PageSwapCache(page))
>  			sc->nr_scanned++;
>  
> -		referenced = page_referenced(page, 1);
> +		referenced = page_referenced(page, 1, sc->priority <= 0);
>  		/* In active use or really unfreeable?  Activate it. */
>  		if (referenced && page_mapping_inuse(page))
>  			goto activate_locked;
> @@ -724,7 +724,7 @@ refill_inactive_zone(struct zone *zone, 
>  		if (page_mapped(page)) {
>  			if (!reclaim_mapped ||
>  			    (total_swap_pages == 0 && PageAnon(page)) ||
> -			    page_referenced(page, 0)) {
> +			    page_referenced(page, 0, sc->priority <= 0)) {
>  				list_add(&page->lru, &l_active);
>  				continue;
>  			}
> diff -puN mm/rmap.c~vmscan-ignore-swap-token-when-in-trouble mm/rmap.c
> --- 25/mm/rmap.c~vmscan-ignore-swap-token-when-in-trouble	2004-11-16 20:30:00.000000000 -0800
> +++ 25-akpm/mm/rmap.c	2004-11-16 20:30:00.000000000 -0800
> @@ -248,7 +248,7 @@ unsigned long page_address_in_vma(struct
>   * repeatedly from either page_referenced_anon or page_referenced_file.
>   */
>  static int page_referenced_one(struct page *page,
> -	struct vm_area_struct *vma, unsigned int *mapcount)
> +	struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address;
> @@ -288,7 +288,7 @@ static int page_referenced_one(struct pa
>  	if (ptep_clear_flush_young(vma, address, pte))
>  		referenced++;
>  
> -	if (mm != current->mm && has_swap_token(mm))
> +	if (mm != current->mm && !ignore_token && has_swap_token(mm))
>  		referenced++;
>  
>  	(*mapcount)--;
> @@ -301,7 +301,7 @@ out:
>  	return referenced;
>  }
>  
> -static int page_referenced_anon(struct page *page)
> +static int page_referenced_anon(struct page *page, int ignore_token)
>  {
>  	unsigned int mapcount;
>  	struct anon_vma *anon_vma;
> @@ -314,7 +314,8 @@ static int page_referenced_anon(struct p
>  
>  	mapcount = page_mapcount(page);
>  	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
> -		referenced += page_referenced_one(page, vma, &mapcount);
> +		referenced += page_referenced_one(page, vma, &mapcount,
> +							ignore_token);
>  		if (!mapcount)
>  			break;
>  	}
> @@ -333,7 +334,7 @@ static int page_referenced_anon(struct p
>   *
>   * This function is only called from page_referenced for object-based pages.
>   */
> -static int page_referenced_file(struct page *page)
> +static int page_referenced_file(struct page *page, int ignore_token)
>  {
>  	unsigned int mapcount;
>  	struct address_space *mapping = page->mapping;
> @@ -371,7 +372,8 @@ static int page_referenced_file(struct p
>  			referenced++;
>  			break;
>  		}
> -		referenced += page_referenced_one(page, vma, &mapcount);
> +		referenced += page_referenced_one(page, vma, &mapcount,
> +							ignore_token);
>  		if (!mapcount)
>  			break;
>  	}
> @@ -388,7 +390,7 @@ static int page_referenced_file(struct p
>   * Quick test_and_clear_referenced for all mappings to a page,
>   * returns the number of ptes which referenced the page.
>   */
> -int page_referenced(struct page *page, int is_locked)
> +int page_referenced(struct page *page, int is_locked, int ignore_token)
>  {
>  	int referenced = 0;
>  
> @@ -400,14 +402,15 @@ int page_referenced(struct page *page, i
>  
>  	if (page_mapped(page) && page->mapping) {
>  		if (PageAnon(page))
> -			referenced += page_referenced_anon(page);
> +			referenced += page_referenced_anon(page, ignore_token);
>  		else if (is_locked)
> -			referenced += page_referenced_file(page);
> +			referenced += page_referenced_file(page, ignore_token);
>  		else if (TestSetPageLocked(page))
>  			referenced++;
>  		else {
>  			if (page->mapping)
> -				referenced += page_referenced_file(page);
> +				referenced += page_referenced_file(page,
> +								ignore_token);
>  			unlock_page(page);
>  		}
>  	}
> diff -puN include/linux/rmap.h~vmscan-ignore-swap-token-when-in-trouble include/linux/rmap.h
> --- 25/include/linux/rmap.h~vmscan-ignore-swap-token-when-in-trouble	2004-11-16 20:30:00.000000000 -0800
> +++ 25-akpm/include/linux/rmap.h	2004-11-16 20:30:00.000000000 -0800
> @@ -89,7 +89,7 @@ static inline void page_dup_rmap(struct 
>  /*
>   * Called from mm/vmscan.c to handle paging out
>   */
> -int page_referenced(struct page *, int is_locked);
> +int page_referenced(struct page *, int is_locked, int ignore_token);
>  int try_to_unmap(struct page *);
>  
>  /*
> @@ -103,7 +103,7 @@ unsigned long page_address_in_vma(struct
>  #define anon_vma_prepare(vma)	(0)
>  #define anon_vma_link(vma)	do {} while (0)
>  
> -#define page_referenced(page,l)	TestClearPageReferenced(page)
> +#define page_referenced(page,l,i) TestClearPageReferenced(page)
>  #define try_to_unmap(page)	SWAP_FAIL
>  
>  #endif	/* CONFIG_MMU */
> _
