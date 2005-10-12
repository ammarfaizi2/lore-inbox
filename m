Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVJLFex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVJLFex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 01:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVJLFex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 01:34:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932453AbVJLFew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 01:34:52 -0400
Date: Tue, 11 Oct 2005 22:34:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm - implement swap prefetching
Message-Id: <20051011223419.4250ecf6.akpm@osdl.org>
In-Reply-To: <200510111648.31504.kernel@kolivas.org>
References: <200510110023.02426.kernel@kolivas.org>
	<200510111648.31504.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> This patch implements swap prefetching when the vm is relatively idle and
> there is free ram available.
> ...
> +/*
> + * Find the zone with the most free pages, recheck the watermarks and
> + * then directly allocate the ram. We don't want prefetch to use
> + * __alloc_pages and go calling on reclaim.
> + */
> +static struct page *prefetch_get_page(void)
> +{
> +	struct zone *zone = NULL, *z;
> +	struct page *page = NULL;
> +	long most_free = 0;
> +
> +	for_each_zone(z) {
> +		long free;
> +
> +		if (z->present_pages == 0)
> +			continue;
> +
> +		free = z->free_pages;
> +
> +		/* We don't prefetch into DMA */
> +		if (zone_idx(z) == ZONE_DMA)
> +			continue;
> +
> +		/* Select the zone with the most free ram */
> +		if (free > most_free) {
> +			most_free = free;
> +			zone = z;
> +		}
> +	}
> +
> +	if (zone == NULL)
> +		goto out;
> +
> +	page = buffered_rmqueue(zone, 0, GFP_HIGHUSER);
> +	if (likely(page)) {
> +		struct zonelist *zonelist;
> +
> +		zonelist = NODE_DATA(numa_node_id())->node_zonelists +
> +		(GFP_HIGHUSER & GFP_ZONEMASK);
> +
> +		zone_statistics(zonelist, zone);
> +	}
> +out:
> +	return page;
> +}

Why use the "zone with most free pages"?  Generally it would be better to
use up ZONE_HIGHMEM first: ZONE_NORMAL is valuable.

> +/*
> + * We want to be absolutely certain it's ok to start prefetching.
> + */
> +static int prefetch_suitable(void)
> +{
> +	struct page_state ps;
> +	unsigned long pending_writes, limit;
> +	struct zone *z;
> +	int ret = 0;
> +
> +	/* Purposefully racy and might return false positive which is ok */
> +	if (__test_and_clear_bit(0, &swapped.busy))
> +		goto out;
> +
> +	temp_free = 0;
> +	/*
> +	 * Have some hysteresis between where page reclaiming and prefetching
> +	 * will occur to prevent ping-ponging between them.
> +	 */
> +	for_each_zone(z) {
> +		unsigned long free;
> +
> +		if (z->present_pages == 0)
> +			continue;
> +		free = z->free_pages;
> +		if (z->pages_high * 3 > free)
> +			goto out;
> +		temp_free += free;
> +	}
> +
> +	/*
> +	 * We check to see that pages are not being allocated elsewhere
> +	 * at any significant rate implying any degree of memory pressure
> +	 * (eg during file reads)
> +	 */
> +	if (last_free) {
> +		if (temp_free + SWAP_CLUSTER_MAX + prefetch_pages() <
> +			last_free) {
> +				last_free = temp_free;
> +				goto out;
> +		}
> +	} else
> +		last_free = temp_free;
> +
> +	get_page_state(&ps);
> +
> +	/* We shouldn't prefetch when we are doing writeback */
> +	if (ps.nr_writeback)
> +		goto out;

Yeah, this really needs to become per-disk-queue-aware.

> +	/* Delay prefetching if we have significant amounts of dirty data */
> +	pending_writes = ps.nr_dirty + ps.nr_unstable;
> +	if (pending_writes > SWAP_CLUSTER_MAX)
> +		goto out;

Surely this is too aggressive.  There are almost always a few tens of dirty
pages floating about, especially when atime updates are enabled.  I'd
suggest that you stick a printk in here - I expect you'll find that this
test triggers a lot - too much.


> +	/* >2/3 of the ram is mapped, we need some free for pagecache */
> +	limit = ps.nr_mapped + ps.nr_slab + pending_writes;
> +	if (limit > mapped_limit)
> +		goto out;
> +
> +	/*
> +	 * Add swapcache to limit as well, but check this last since it needs
> +	 * locking
> +	 */
> +	if (unlikely(!read_trylock(&swapper_space.tree_lock)))
> +		goto out;
> +	limit += total_swapcache_pages;
> +	read_unlock(&swapper_space.tree_lock);

I'd just not bother with the locking at all here.

> +static int kprefetchd(void *data)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	daemonize("kprefetchd");

kthread(), please.

> +	set_user_nice(current, 19);
> +	/* Set ioprio to lowest if supported by i/o scheduler */
> +	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
> +
> +	for ( ; ; ) {
> +		enum trickle_return prefetched;
> +
> +		try_to_freeze();
> +		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
> +		schedule();
> +		finish_wait(&kprefetchd_wait, &wait);
> +
> +		/* FAILED implies no entries left - the timer is not reset */
> +		prefetched = trickle_swap();
> +		switch (prefetched) {
> +		case SUCCESS:
> +			last_free = temp_free;
> +			reset_prefetch_timer();
> +			break;
> +		case DELAY:
> +			last_free = 0;
> +			delay_prefetch_timer();
> +			break;
> +		case FAILED:
> +			last_free = 0;
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Wake up kprefetchd. It will reset the timer itself appropriately so no
> + * need to do it here
> + */
> +static void prefetch_wakeup(unsigned long data)
> +{
> +	if (waitqueue_active(&kprefetchd_wait))
> +		wake_up_interruptible(&kprefetchd_wait);
> +}
> +
> +static int __init kprefetchd_init(void)
> +{
> +	/*
> +	 * Prepare the prefetch timer. It is inactive until entries are placed
> +	 * on the swapped_list
> +	 */
> +	init_timer(&prefetch_timer);
> +	prefetch_timer.data = 0;
> +	prefetch_timer.function = prefetch_wakeup;
> +
> +	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
> +
> +	return 0;
> +}

Might be able to use a boring old wake_up_process() here rather than a
waitqueue.

Is the timer actually needed?  Could just do schedule_timeout() in
kprefetchd()?

