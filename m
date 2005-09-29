Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVI2Wse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVI2Wse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVI2Wse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:48:34 -0400
Received: from dvhart.com ([64.146.134.43]:62606 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932299AbVI2Wsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:48:33 -0400
Date: Thu, 29 Sep 2005 15:48:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: "Seth, Rohit" <rohit.seth@intel.com>, akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in __alloc_pages
Message-ID: <719460000.1128034108@[10.10.2.4]>
In-Reply-To: <20050929150155.A15646@unix-os.sc.intel.com>
References: <20050929150155.A15646@unix-os.sc.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Try to service a order 0 page request from pcp list.  This will allow us to not check and possibly start the reclaim activity when there are free pages present on the pcp.  This early allocation does not try to replenish an empty pcp.
> 
>         Signed-off-by: Rohit Seth <rohit.seth@intel.com>

It seems a bit odd to copy more code to do this, which I think we already
have in buffered_rmqueue? Can we clean up the flow a bit here ... it 
is already looking messy in __alloc_pages with various gotos and crud
there. I'm not saying what you're trying to do is bad, but the flow
in there is getting more and move convoluted, and we perhaps need to
straighten it. 

It looks like we're now dropping into direct reclaim as the first thing
in __alloc_pages before even trying to kick off kswapd. When the hell
did that start? Or is that only meant to trigger if we're already below
the low watermark level?

What do we want to do at a higher level?

	if (order 0) and (have stuff in the local lists)
		take from local lists
	else if (we're under a little pressure)
		do kswapd reclaim
	else if (we're under a lot of pressure)
		do direct reclaim?

That whole code area seems to have been turned into spagetti, without
any clear comments.

M.
	
	
 
> --- linux-2.6.14-rc2-mm1.org/mm/page_alloc.c	2005-09-27 10:03:51.000000000 -0700
> +++ linux-2.6.14-rc2-mm1/mm/page_alloc.c	2005-09-28 17:38:15.000000000 -0700
> @@ -716,6 +716,39 @@
>  		clear_highpage(page + i);
>  }
>  
> +/* This routine allocates a order 0 page from cpu's pcp list when one is present.
> + * It does not try to remove the pages from zone_free_list as the zone low
> + * water mark has not yet been checked.
> + */
> +
> +static struct page *
> +remove_from_pcp(struct zone *zone, unsigned int __nocast gfp_flags)
> +{
> +	unsigned long flags;
> +	struct per_cpu_pages *pcp;
> +	struct page *page = NULL;
> +	int cold = !!(gfp_flags & __GFP_COLD);
> +
> +	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
> +	local_irq_save(flags);
> +	if (pcp->count > pcp->low) {
> +		page = list_entry(pcp->list.next, struct page, lru);
> +		list_del(&page->lru);
> +		pcp->count--;
> +	}
> +	local_irq_restore(flags);
> +	put_cpu();
> +
> +	if (page != NULL) {
> +		mod_page_state_zone(zone, pgalloc, 1 );
> +		prep_new_page(page, 0);
> +
> +		if (gfp_flags & __GFP_ZERO)
> +			prep_zero_page(page, 0, gfp_flags);
> +	}
> +	return page;
> +}
> +
>  /*
>   * Really, prep_compound_page() should be called from __rmqueue_bulk().  But
>   * we cheat by calling it from here, in the order > 0 path.  Saves a branch
> @@ -905,6 +938,12 @@
>  		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
>  			continue;
>  
> +		if (order == 0) {
> +			page = remove_from_pcp(z, gfp_mask);
> +			if (page)
> +				goto got_pg;
> +		}
> +
>  		/*
>  		 * If the zone is to attempt early page reclaim then this loop
>  		 * will try to reclaim pages and check the watermark a second
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
> 


