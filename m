Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVFQDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVFQDf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 23:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVFQDf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 23:35:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbVFQDfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 23:35:16 -0400
Date: Thu, 16 Jun 2005 20:34:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, mason@suse.de
Subject: Re: [patch] vm early reclaim orphaned pages
Message-Id: <20050616203446.796473a7.akpm@osdl.org>
In-Reply-To: <1118978590.5261.4.camel@npiggin-nld.site>
References: <1118978590.5261.4.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  We have workloads where orphaned pages build up and appear to slow
>  the system down when it starts reclaiming memory.
> 
>  Stripping the referenced bit from orphaned pages and putting them
>  on the end of the inactive list should help improve reclaim.

Presumably if do_invalidatepage() failed, there's some reason why this page
is not reclaimable (eg, JBD is still dinking with it).  Hence there's a
very good chance that kswapd won't be able to reclaim it either.

Adding some instrumentation would be useful: set some new page flag on
these pages and then accumulate the success/failure stats in vmscan.c, see
what they say.

>  Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
>  Index: linux-2.6/mm/truncate.c
>  ===================================================================
>  --- linux-2.6.orig/mm/truncate.c	2005-06-01 16:09:34.000000000 +1000
>  +++ linux-2.6/mm/truncate.c	2005-06-17 13:01:01.090334444 +1000
>  @@ -45,11 +45,30 @@
>   static void
>   truncate_complete_page(struct address_space *mapping, struct page *page)
>   {
>  +	int orphaned = 0;
>  +	
>   	if (page->mapping != mapping)
>   		return;
>   
>   	if (PagePrivate(page))
>  -		do_invalidatepage(page, 0);
>  +		orphaned = !(do_invalidatepage(page, 0));
>  +
>  +	if (orphaned) {
>  +		/*
>  +		 * Put orphaned pagecache on the end of the inactive
>  +		 * list so it can get reclaimed quickly.
>  +		 */
>  +		unsigned long flags;
>  +		struct zone *zone = page_zone(page);
>  +		spin_lock_irqsave(&zone->lru_lock, flags);
>  +		ClearPageReferenced(page);
>  +		if (PageLRU(page)) {
>  +			list_move_tail(&page->lru, &zone->inactive_list);
>  +			if (PageActive(page))
>  +				ClearPageActive(page);
>  +		}
>  +		spin_unlock_irqrestore(&zone->lru_lock, flags);
>  +	}

A standalone function in swap.c would be nicer.
