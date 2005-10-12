Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVJLMA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVJLMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJLMA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:00:56 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:18123 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932430AbVJLMA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:00:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm - implement swap prefetching
Date: Wed, 12 Oct 2005 22:00:46 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510110023.02426.kernel@kolivas.org> <200510111648.31504.kernel@kolivas.org> <20051011223419.4250ecf6.akpm@osdl.org>
In-Reply-To: <20051011223419.4250ecf6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510122200.47074.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005 15:34, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > +		/* Select the zone with the most free ram */
> > +		if (free > most_free) {
> > +			most_free = free;

> Why use the "zone with most free pages"?  Generally it would be better to
> use up ZONE_HIGHMEM first: ZONE_NORMAL is valuable.

Ok. Sounds fair.

> > +	/* We shouldn't prefetch when we are doing writeback */
> > +	if (ps.nr_writeback)
> > +		goto out;
>
> Yeah, this really needs to become per-disk-queue-aware.

I looked but it started looking like I was going to over-engineer.

> > +	/* Delay prefetching if we have significant amounts of dirty data */
> > +	pending_writes = ps.nr_dirty + ps.nr_unstable;
> > +	if (pending_writes > SWAP_CLUSTER_MAX)
> > +		goto out;
>
> Surely this is too aggressive.  There are almost always a few tens of dirty
> pages floating about, especially when atime updates are enabled.  I'd
> suggest that you stick a printk in here - I expect you'll find that this
> test triggers a lot - too much.

Actually I was quite aware of how frequently this hits. What I found in 
practice was that the amount of dirty ram was an extraordinarily good marker 
of whether the system was globally idle / low stressed or not. It did not 
seem to stop prefetching from occurring in the real world on the machines I 
tried it on.

> > +	if (unlikely(!read_trylock(&swapper_space.tree_lock)))
> > +		goto out;
> > +	limit += total_swapcache_pages;
> > +	read_unlock(&swapper_space.tree_lock);
>
> I'd just not bother with the locking at all here.

Ok.

> > +	daemonize("kprefetchd");
>
> kthread(), please.

Check.

> > +	init_timer(&prefetch_timer);
> > +	prefetch_timer.data = 0;
> > +	prefetch_timer.function = prefetch_wakeup;
> > +
> > +	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
> > +
> > +	return 0;
> > +}
>
> Might be able to use a boring old wake_up_process() here rather than a
> waitqueue.
>
> Is the timer actually needed?  Could just do schedule_timeout() in
> kprefetchd()?

I guess. The timer just made it easy to start and stop it completely before I 
turned prefetch into a daemon and it kinda stayed that way. It's not run that 
frequently and only does miniscule things in that context; is it of a 
significant advantage?

Thanks very much!

Cheers,
Con
