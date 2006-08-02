Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHBFtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHBFtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHBFtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:49:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750987AbWHBFtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:49:08 -0400
Date: Tue, 1 Aug 2006 22:48:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clear vm_reclaimable when we free pages.
Message-Id: <20060801224857.2459184e.akpm@osdl.org>
In-Reply-To: <20060801175716.GB22240@redhat.com>
References: <20060801175716.GB22240@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 13:57:16 -0400
Dave Jones <davej@redhat.com> wrote:

> There are two places where we reclaim free pages, but we never
> update the all_unreclaimable flag for the relevant zone.
> This patch helped reduce the frequency of oom-kills under high load
> for us a while back, and we've been carrying it since.
> I posted this a few months back and from what I recall it didn't
> get a great deal of interest.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
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

We're not actually freeing the page here though.  We _might_ be making it
reclaimable, but we don't know that.  If page reclaim later _does_ reclaim
the page, then ->all_unreclaimable will get cleared then.  A little later,
but if that's enough to make a difference, I suspect we're already rather
doomed.

Also, if rotate_reclaimable_page() returned non-zero we know this page
isn't immediately reclaimable, so the patch shouldn't be clearing
->all_unreclaimable in that case.

And zone->lock is supposed to be irq-safe.  Yes, we're in an interrupt, but
many different interrupt sources will vector into this code - if we take an
interrupt from /dev/sda while serving a /dev/hda interrupt we'll deadlock
here.  File a bug against lockdep ;)

>  EXPORT_SYMBOL(end_page_writeback);
> --- linux-2.6/mm/page_alloc.c~	2006-01-09 13:40:03.000000000 -0500
> +++ linux-2.6/mm/page_alloc.c	2006-01-09 13:40:50.000000000 -0500
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
>  	local_irq_restore(flags);
>  	put_cpu();

free_pages_bulk() will clear ->all_unreclaimable.  If this really makes a
difference then we're already skating along the raggedy edge.

There is a string of oom-killer patches in -mm from Nick.  I suspect we'll
be in much better shape after those are merged.
