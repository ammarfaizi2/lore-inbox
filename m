Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWBIN3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWBIN3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBIN3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:29:33 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:2161 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932486AbWBIN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:29:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=G/c/qFxA44ZRayvl3TNdZtxpbKLgNOtmXuWD5dkui2sdxGj32U8a2nzwxYXkBZOq6NqTMACaJNliDSsG0sIXIZWefH72IPsMqUunxIClKTfGTf4rBoe6Fiv+McV3shgXV2e6aTLklpMUff4LnW9/jmU2tlKBDPMwVUVSaSaOZ5E=  ;
Message-ID: <43EB43B9.5040001@yahoo.com.au>
Date: Fri, 10 Feb 2006 00:29:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
References: <200602092339.49719.kernel@kolivas.org>
In-Reply-To: <200602092339.49719.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

busy Con Kolivas wrote:
> Here's a significant rewrite of the swap prefetching code. I've tried to 
> address the numa issues Nick and Paul brought up. I use the node id of the
> swapped page to create an appropriate zonelist to prefetch pages into now,
> and the watermarks for prefetching are done on a per-node basis.
> 

- Looking a lot better from an impact-on-rest-of-vm code wise inspection.
I got a couple of suggestions to make it even better.

- I still have big reservations about it. For example the fact that if you
thrash memory and force everything to swap out, then exit your memory
hog, it won't do anything if you just happened to `cat bigfile > /dev/null`

- Then, it has the potential to make *useful* swapping much less useful
(ie. it will page back in your unused programs and libraries, which will
kick out unmapped pagecache on desktop workloads).

- It does not appear to necessarily solve the updatedb problem.

- People complaining about their browser getting swapped out of their 1GB+
desktop systems due to a midnight cron run must be angering the VM gods.
I'd rather try to work out what to sacrifice in order to appease them before
sending another one up there to beat them into submission.

Sorry to sound negative about it. Lucky for you nobody listens to me.

> Index: linux-2.6.16-rc2-sp/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.16-rc2-sp.orig/mm/page_alloc.c	2006-02-08 23:22:30.000000000 +1100
> +++ linux-2.6.16-rc2-sp/mm/page_alloc.c	2006-02-08 23:28:01.000000000 +1100
> @@ -833,7 +833,7 @@ int zone_watermark_ok(struct zone *z, in
>  		min -= min / 4;
>  
>  	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
> -		return 0;
> +		goto out_failed;
>  	for (o = 0; o < order; o++) {
>  		/* At the next order, this order's pages become unavailable */
>  		free_pages -= z->free_area[o].nr_free << o;
> @@ -842,9 +842,15 @@ int zone_watermark_ok(struct zone *z, in
>  		min >>= 1;
>  
>  		if (free_pages <= min)
> -			return 0;
> +			goto out_failed;
>  	}
> +
>  	return 1;
> +out_failed:
> +	/* Swap prefetching is delayed if any watermark is low */
> +	delay_swap_prefetch();
> +
> +	return 0;
>  }
>  

Do we really need to delay here? We do the watermark check anyway and it
would eliminate a hot cacheline bouncing site and further reduce impact
on vm code.

>  /*
> Index: linux-2.6.16-rc2-sp/mm/swap.c
> ===================================================================
> --- linux-2.6.16-rc2-sp.orig/mm/swap.c	2006-02-08 23:22:30.000000000 +1100
> +++ linux-2.6.16-rc2-sp/mm/swap.c	2006-02-08 23:28:01.000000000 +1100
> @@ -502,5 +502,8 @@ void __init swap_setup(void)
>  	 * Right now other parts of the system means that we
>  	 * _really_ don't want to cluster much more
>  	 */
> +
> +	prepare_swap_prefetch();
> +
>  	hotcpu_notifier(cpu_swap_callback, 0);
>  }
> Index: linux-2.6.16-rc2-sp/mm/swap_prefetch.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.16-rc2-sp/mm/swap_prefetch.c	2006-02-09 22:51:24.000000000 +1100
> @@ -0,0 +1,478 @@
> +/*
> + * linux/mm/swap_prefetch.c
> + *
> + * Copyright (C) 2005-2006 Con Kolivas
> + *
> + * Written by Con Kolivas <kernel@kolivas.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/swap.h>
> +#include <linux/ioprio.h>
> +#include <linux/kthread.h>
> +#include <linux/pagemap.h>
> +#include <linux/syscalls.h>
> +#include <linux/writeback.h>
> +
> +/*
> + * Time to delay prefetching if vm is busy or prefetching unsuccessful. There
> + * needs to be at least this duration of idle time meaning in practice it can
> + * be much longer
> + */
> +#define PREFETCH_DELAY	(HZ * 5)
> +
> +/* sysctl - enable/disable swap prefetching */
> +int swap_prefetch __read_mostly = 1;
> +
> +struct swapped_root {
> +	unsigned long		busy;		/* vm busy */
> +	spinlock_t		lock;		/* protects all data */
> +	struct list_head	list;		/* MRU list of swapped pages */
> +	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */

Umm... what is swap_tree for, exactly?

> +	unsigned int		count;		/* Number of entries */
> +	unsigned int		maxcount;	/* Maximum entries allowed */
> +	kmem_cache_t		*cache;		/* Of struct swapped_entry */
> +};
> +
> +static struct swapped_root swapped = {
> +	.busy 		= 0,			/* Any vm activity */
> +	.lock		= SPIN_LOCK_UNLOCKED,
> +	.list  		= LIST_HEAD_INIT(swapped.list),
> +	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
> +	.count 		= 0,			/* Number of swapped entries */
> +};
> +
> +struct swapped_entry {
> +	swp_entry_t		swp_entry;	/* The actual swap entry */
> +	struct list_head	swapped_list;	/* Linked list of entries */
> +	int			node;		/* Node id */
> +} __attribute__((packed));
> +
> +static task_t *kprefetchd_task;
> +
> +/*
> + * We check to see no part of the vm is busy. If it is this will interrupt
> + * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
> + */
> +inline void delay_swap_prefetch(void)
> +{
> +	__set_bit(0, &swapped.busy);
> +}
> +

Test this first so you don't bounce the cacheline around in page
reclaim too much.

> +/*
> + * Drop behind accounting which keeps a list of the most recently used swap
> + * entries.
> + */
> +void add_to_swapped_list(struct page *page)
> +{
> +	struct swapped_entry *entry;
> +	unsigned long index;
> +
> +	spin_lock(&swapped.lock);
> +	if (swapped.count >= swapped.maxcount) {
> +		/*
> +		 * We limit the number of entries to the size of physical ram.
> +		 * Once the number of entries exceeds this we start removing
> +		 * the least recently used entries.
> +		 */
> +		entry = list_entry(swapped.list.next,
> +			struct swapped_entry, swapped_list);
> +		radix_tree_delete(&swapped.swap_tree, entry->swp_entry.val);
> +		list_del(&entry->swapped_list);
> +		swapped.count--;
> +	} else {
> +		entry = kmem_cache_alloc(swapped.cache, GFP_ATOMIC);
> +		if (unlikely(!entry))
> +			/* bad, can't allocate more mem */
> +			goto out_locked;
> +	}
> +
> +	index = page_private(page);
> +	entry->swp_entry.val = index;
> +	/*
> +	 * On numa we need to store the node id to ensure that we prefetch to
> +	 * the same node it came from.
> +	 */
> +	entry->node = page_to_nid(page);
> +
> +	if (likely(!radix_tree_insert(&swapped.swap_tree, index, entry))) {
> +		/*
> +		 * If this is the first entry, kprefetchd needs to be
> +		 * (re)started
> +		 */
> +		if (list_empty(&swapped.list))
> +			wake_up_process(kprefetchd_task);

Move this wake up outside the swapped.lock to keep lock hold times down.

> +		list_add(&entry->swapped_list, &swapped.list);
> +		swapped.count++;
> +	}
> +
> +out_locked:
> +	spin_unlock(&swapped.lock);
> +	return;
> +}
> +
> +/*
> + * Cheaper to not spin on the lock and remove the entry lazily via
> + * add_to_swap_cache when we hit it in trickle_swap_cache_async
> + */
> +void remove_from_swapped_list(const unsigned long index)
> +{
> +	struct swapped_entry *entry;
> +	unsigned long flags;
> +
> +	if (unlikely(!spin_trylock_irqsave(&swapped.lock, flags)))
> +		return;

You never really hold swapped.lock long do you? By the time you disable
interrupts and hit the cacheline here, if it is contended you may as
well wait the few extra cycles for it to become unlocked no?

> +	entry = radix_tree_delete(&swapped.swap_tree, index);
> +	if (likely(entry)) {
> +		list_del_init(&entry->swapped_list);
> +		swapped.count--;
> +		kmem_cache_free(swapped.cache, entry);
> +	}
> +	spin_unlock_irqrestore(&swapped.lock, flags);
> +}
> +
> +enum trickle_return {
> +	TRICKLE_SUCCESS,
> +	TRICKLE_FAILED,
> +	TRICKLE_DELAY,
> +};
> +
> +/*
> + * prefetch_stats stores the free ram data of each node and this is used to
> + * determine if a node is suitable for prefetching into.
> + */
> +struct prefetch_stats{
> +	unsigned long	last_free[MAX_NUMNODES];
> +	/* Free ram after a cycle of prefetching */
> +	unsigned long	current_free[MAX_NUMNODES];
> +	/* Free ram on this cycle of checking prefetch_suitable */
> +	unsigned long	prefetch_watermark[MAX_NUMNODES];
> +	/* Maximum amount we will prefetch to */
> +	nodemask_t	prefetch_nodes;
> +	/* Which nodes are currently suited to prefetching */
> +	unsigned long	prefetched_pages;
> +	/* Total pages we've prefetched on this wakeup of kprefetchd */
> +};
> +
> +static struct prefetch_stats sp_stat;
> +
> +/*
> + * This tries to read a swp_entry_t into swap cache for swap prefetching.
> + * If it returns TRICKLE_DELAY we should delay further prefetching.
> + */
> +static enum trickle_return trickle_swap_cache_async(const swp_entry_t entry,
> +	const int node)
> +{
> +	enum trickle_return ret = TRICKLE_FAILED;
> +	struct zonelist *zonelist;
> +	struct page *page;
> +
> +	read_lock(&swapper_space.tree_lock);
> +	/* Entry may already exist */
> +	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
> +	read_unlock(&swapper_space.tree_lock);
> +	if (page) {
> +		remove_from_swapped_list(entry.val);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Create a zonelist based on the node data of the page that was
> +	 * originally swapped out.
> +	 */
> +	zonelist = NODE_DATA(node)->node_zonelists + gfp_zone(GFP_HIGHUSER);
> +
> +	/*
> +	 * Get a new page to read from swap. We have already checked the
> +	 * watermarks so __alloc_pages will not call on reclaim.
> +	 */
> +	page = __alloc_pages(GFP_HIGHUSER & ~__GFP_WAIT, 0, zonelist);

We have an alloc_pages_node for this.

The whole function reminds me of read_swap_cache_async. I wonder if there
could be some sharing, or at least format it similarly and use things like
find_get_page rather than open coding?

> +	if (unlikely(!page)) {
> +		ret = TRICKLE_DELAY;
> +		goto out;
> +	}
> +
> +	if (add_to_swap_cache(page, entry)) {
> +		/* Failed to add to swap cache */
> +		goto out_release;
> +	}
> +
> +	lru_cache_add(page);
> +	if (unlikely(swap_readpage(NULL, page))) {
> +		ret = TRICKLE_DELAY;
> +		goto out_release;
> +	}
> +
> +	sp_stat.last_free[node]--;
> +	ret = TRICKLE_SUCCESS;
> +out_release:
> +	page_cache_release(page);
> +out:
> +	return ret;
> +}
> +
> +static void clear_last_prefetch_free(void)
> +{
> +	int node;
> +
> +	/*
> +	 * Reset the nodes suitable for prefetching to all nodes. We could
> +	 * update the data to take into account memory hotplug if desired..
> +	 */
> +	sp_stat.prefetch_nodes = node_online_map;
> +	for_each_node_mask(node, sp_stat.prefetch_nodes)
> +		sp_stat.last_free[node] = 0;
> +}
> +
> +static void clear_current_prefetch_free(void)
> +{
> +	int node;
> +
> +	sp_stat.prefetch_nodes = node_online_map;
> +	for_each_node_mask(node, sp_stat.prefetch_nodes)
> +		sp_stat.current_free[node] = 0;
> +}
> +
> +/*
> + * We want to be absolutely certain it's ok to start prefetching.
> + */
> +static int prefetch_suitable(void)
> +{
> +	struct page_state ps;
> +	unsigned long limit;
> +	struct zone *z;
> +	int node, ret = 0;
> +
> +	/* Purposefully racy and might return false positive which is ok */
> +	if (__test_and_clear_bit(0, &swapped.busy))
> +		goto out;
> +
> +	clear_current_prefetch_free();
> +
> +	/*
> +	 * Have some hysteresis between where page reclaiming and prefetching
> +	 * will occur to prevent ping-ponging between them.
> +	 */
> +	for_each_zone(z) {
> +		unsigned long free;
> +
> +		if (!populated_zone(z))
> +			continue;
> +		node = z->zone_pgdat->node_id;
> +
> +		free = z->free_pages;
> +		if (z->pages_high * 3 > free) {
> +			node_clear(node, sp_stat.prefetch_nodes);
> +			continue;
> +		}

This ignores the reserve ratio stuff.

> +		sp_stat.current_free[node] += free;
> +	}
> +
> +	/*
> +	 * We iterate over each node testing to see if it is suitable for
> +	 * prefetching and clear the nodemask if it is not.
> +	 */
> +	for_each_node_mask(node, sp_stat.prefetch_nodes) {
> +		/*
> +		 * We check to see that pages are not being allocated
> +		 * elsewhere at any significant rate implying any
> +		 * degree of memory pressure (eg during file reads)
> +		 */
> +		if (sp_stat.last_free[node]) {
> +			if (sp_stat.current_free[node] + SWAP_CLUSTER_MAX <
> +				sp_stat.last_free[node]) {
> +					sp_stat.last_free[node] =
> +						sp_stat.current_free[node];
> +					node_clear(node,
> +						sp_stat.prefetch_nodes);
> +					continue;
> +			}
> +		} else
> +			sp_stat.last_free[node] = sp_stat.current_free[node];
> +
> +		/*
> +		 * get_page_state is super expensive so we only perform it
> +		 * every SWAP_CLUSTER_MAX prefetched_pages
> +		 */
> +		if (sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)
> +			continue;
> +
> +		get_page_state_node(&ps, node);
> +
> +		/* We shouldn't prefetch when we are doing writeback */
> +		if (ps.nr_writeback) {
> +			node_clear(node, sp_stat.prefetch_nodes);
> +			continue;
> +		}
> +
> +		/*
> +		 * >2/3 of the ram on this node is mapped, slab, swapcache or
> +		 * dirty, we need to leave some free for pagecache.
> +		 * Note that currently nr_slab is innacurate on numa because
> +		 * nr_slab is incremented on the node doing the accounting
> +		 * even if the slab is being allocated on a remote node. This
> +		 * would be expensive to fix and not of great significance.
> +		 */
> +		limit = ps.nr_mapped + ps.nr_slab + ps.nr_dirty +
> +			ps.nr_unstable + total_swapcache_pages;
> +		if (limit > sp_stat.prefetch_watermark[node]) {
> +			node_clear(node, sp_stat.prefetch_nodes);
> +			continue;
> +		}
> +	}
> +
> +	if (nodes_empty(sp_stat.prefetch_nodes))
> +		goto out;
> +
> +	/* Survived all that? Hooray we can prefetch! */
> +	ret = 1;
> +out:
> +	return ret;
> +}
> +
> +/*
> + * trickle_swap is the main function that initiates the swap prefetching. It
> + * first checks to see if the busy flag is set, and does not prefetch if it
> + * is, as the flag implied we are low on memory or swapping in currently.
> + * Otherwise it runs until prefetch_suitable fails which occurs when the
> + * vm is busy, we prefetch to the watermark, or the list is empty.
> + */
> +static enum trickle_return trickle_swap(void)
> +{
> +	enum trickle_return ret = TRICKLE_DELAY;
> +	struct swapped_entry *entry;
> +	struct list_head *mru = NULL;
> +
> +	if (!swap_prefetch)
> +		return ret;
> +
> +	for ( ; ; ) {
> +		enum trickle_return got_page;
> +		swp_entry_t swp_entry;
> +		int node;
> +
> +		if (!prefetch_suitable())
> +			break;
> +
> +		/* Check we haven't iterated over everything */
> +		if (unlikely(swapped.list.next == mru))
> +			break;
> +
> +		spin_lock(&swapped.lock);
> +		if (list_empty(&swapped.list)) {
> +			ret = TRICKLE_FAILED;
> +			spin_unlock(&swapped.lock);
> +			goto out;
> +		}
> +		entry = list_entry(swapped.list.next,
> +			struct swapped_entry, swapped_list);
> +		node = entry->node;
> +		if (!node_isset(node, sp_stat.prefetch_nodes)) {
> +			/*
> +			 * We found an entry that belongs to a node that is
> +			 * not suitable for prefetching so skip it, storing
> +			 * the mru position if necessary
> +			 */
> +			if (!mru)
> +				mru = swapped.list.next;
> +			list_move_tail(&swapped.list, swapped.list.next);
> +			spin_unlock(&swapped.lock);
> +			continue;
> +		}
> +		swp_entry = entry->swp_entry;
> +		spin_unlock(&swapped.lock);
> +

Doing this in pagevecs should improve icache utilisation and locking
efficiency. However at this stage you probably don't need to worry about
that.

> +		got_page = trickle_swap_cache_async(swp_entry, node);
> +		switch (got_page) {
> +		case TRICKLE_FAILED:
> +			break;
> +		case TRICKLE_SUCCESS:
> +			sp_stat.prefetched_pages++;
> +			break;
> +		case TRICKLE_DELAY:
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	if (mru) {
> +		spin_lock(&swapped.lock);
> +			if (likely(mru))

Why do you need to retest mru here?

The list manipulation in this routine is a bit ugly. You should be able to
do basically the whole thing without touching .next or .prev (except maybe
to find the initial entry) shouldn't you?

> +				swapped.list.next = mru;
> +		spin_unlock(&swapped.lock);
> +	}
> +	if (sp_stat.prefetched_pages) {
> +		lru_add_drain();
> +		sp_stat.prefetched_pages = 0;
> +	}
> +	return ret;
> +}
> +
> +static int kprefetchd(void *__unused)
> +{
> +	set_user_nice(current, 19);
> +	/* Set ioprio to lowest if supported by i/o scheduler */
> +	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
> +

What happens if your app suddenly faults the page while it is being
read in? Gets stuck with low prio still, I guess.

Probably not a big deal.

Can you make it delay prefetch if the swap device is busy as well?
Then you can probably leave it with regular ioprio.

> +	do {
> +		try_to_freeze();
> +
> +		/*
> +		 * TRICKLE_FAILED implies no entries left - we do not schedule
> +		 * a wakeup, and further delay the next one.
> +		 */
> +		if (trickle_swap() == TRICKLE_FAILED)
> +			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
> +		clear_last_prefetch_free();
> +		schedule_timeout_interruptible(PREFETCH_DELAY);
> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +
> +/*
> + * Create kmem cache for swapped entries
> + */
> +void __init prepare_swap_prefetch(void)
> +{
> +	pg_data_t *pgdat;
> +	int node;
> +
> +	swapped.cache = kmem_cache_create("swapped_entry",
> +		sizeof(struct swapped_entry), 0, SLAB_PANIC, NULL, NULL);
> +
> +	/*
> +	 * Set max number of entries to 2/3 the size of physical ram  as we
> +	 * only ever prefetch to consume 2/3 of the ram.
> +	 */
> +	swapped.maxcount = nr_free_pagecache_pages() / 3 * 2;
> +
> +	for_each_pgdat(pgdat) {
> +		unsigned long present;
> +
> +		present = pgdat->node_present_pages;
> +		if (!present)
> +			continue;
> +		node = pgdat->node_id;
> +		sp_stat.prefetch_watermark[node] += present / 3 * 2;
> +	}
> +}
> +
> +static int __init kprefetchd_init(void)
> +{
> +	kprefetchd_task = kthread_run(kprefetchd, NULL, "kprefetchd");
> +
> +	return 0;
> +}
> +
> +static void __exit kprefetchd_exit(void)
> +{
> +	kthread_stop(kprefetchd_task);
> +}
> +
> +module_init(kprefetchd_init);
> +module_exit(kprefetchd_exit);


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
