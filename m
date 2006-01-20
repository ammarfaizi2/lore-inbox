Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWATBB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWATBB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWATBB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:01:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030332AbWATBB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:01:28 -0500
Date: Thu, 19 Jan 2006 17:03:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: AChittenden@bluearc.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060119170305.2e8ae353.akpm@osdl.org>
In-Reply-To: <20060119194836.GM21663@redhat.com>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
	<20060119194836.GM21663@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Thu, Jan 19, 2006 at 03:11:45PM -0000, Andy Chittenden wrote:
>  > DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
>  > present:12740kB pages_scanned:4 all_unreclaimable? yes
> 
> Note we only scanned 4 pages before we gave up.
> Larry Woodman came up with this patch below that clears all_unreclaimable
> when in two places where we've made progress at freeing up some pages
> which has helped oom situations for some of our users.
> 

We already clear ->all_unreclaimable in free_pages_bulk, so I guess the
changes here are a) bypass the per-cpu-pages magazining (fair enough I
suppose) and b) clear all_unreclaimable earlier: as a page becomes
reclaimable, not as we reclaim it.

I wonder if it really makes a difference.  Given that various processes are
currently scanning their little hearts out, if a reclaimable page pops up
at the tail of the LRU, we'll reclaim it pretty much immediately and go off
and, after the per-cpu batching, will clear ->all_unreclaimable.


> --- linux-2.6/mm/filemap.c~	2005-12-10 01:47:15.000000000 -0500
> +++ linux-2.6/mm/filemap.c	2005-12-10 01:47:46.000000000 -0500
> @@ -471,11 +471,18 @@ EXPORT_SYMBOL(unlock_page);
>   */
>  void end_page_writeback(struct page *page)
>  {
> +	struct zone *zone = page_zone(page);
>  	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
>  		if (!test_clear_page_writeback(page))
>  			BUG();
>  	}
>  	smp_mb__after_clear_bit();
> +	if (zone->all_unreclaimable) {
> +		spin_lock(&zone->lock);
> +		zone->all_unreclaimable = 0;
> +		zone->pages_scanned = 0;
> +		spin_unlock(&zone->lock);
> +	}
>  	wake_up_page(page, PG_writeback);
>  }

Wouldn't it be better to only clear ->all_unreclaimable if the page was
actually reclaimable?  ie: inside rotate_reclaimable_page()?

Doing that would also fix the deadlock in the above code: zone.lock is
supposed to be irq-safe.

>  EXPORT_SYMBOL(end_page_writeback);
> --- linux-2.6.15/mm/page_alloc.c~	2006-01-09 13:40:03.000000000 -0500
> +++ linux-2.6.15/mm/page_alloc.c	2006-01-09 13:40:50.000000000 -0500
> @@ -722,6 +722,11 @@ static void fastcall free_hot_cold_page(
>  	if (pcp->count >= pcp->high) {
>  		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
>  		pcp->count -= pcp->batch;
> +	} else if (zone->all_unreclaimable) {
> +		spin_lock(&zone->lock);
> +		zone->all_unreclaimable = 0;
> +		zone->pages_scanned = 0;
> +		spin_unlock(&zone->lock);
>  	}

This is the bypass-the-batching patch.  It's a reasonable thing to do, but I'd
just do it unconditionally and remove the code which clears
->all_unreclaimable from free_pages_bulk(), if possible.

Has this patch been shown to have any effect?  If so, what was it, and
under what conditions?

