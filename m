Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWBGAgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWBGAgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWBGAgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:36:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964893AbWBGAgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:36:44 -0500
Date: Mon, 6 Feb 2006 16:38:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
Message-Id: <20060206163842.7ff70c49.akpm@osdl.org>
In-Reply-To: <200602071028.30721.kernel@kolivas.org>
References: <200602071028.30721.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Andrew et al
> 
> I'm resubmitting the swap prefetching patch for inclusion in -mm and hopefully
> mainline.

Resubmitting is good, thanks.

> After you removed it from -mm there were some people that described
> the benefits it afforded their workloads. -mm being ever so slightly quieter
> at the moment please reconsider.
> 

I wish I could convince myself this is sufficiently beneficial..

I've been running 2.6.15-rc2-mm2 on my main workstation (x86, 2G) since
whenever.  (Am lazy, haven't gotten around to upgrading that machine).  It
has swap prefetch.

I can't say I noticed any difference, although I did turn it off in /proc a
few reboots ago because it was irritating me for some reason which I forget
(sorry).

One thing about 2.6.15-rc2-mm2 is that the `so' and `si' columns in
`vmstat' always read zero.  I don't know whether that bug is due to the
prefetch patch or not.

> 
> The amount prefetched in each group is configurable via the tunable in
> /proc/sys/vm/swap_prefetch. This is set to a value based on memory size. When
> laptop_mode is enabled it prefetches in ten times larger blocks to minimise
> the time spent reading.

That's incomprehensible, sorry.

I think it'd be much clearer if the thing was called swap_prefetch_kbytes
or swap_prefetch_mbytes or (worse) swap_prefetch_pages - putting the units in the
name really helps clarify things.

And if such a change is made, the internal variable should also be renamed.
 Right now it's "swap_prefetch", which sounds like a boolean.

> +swap_prefetch
> +
> +This is the amount of data prefetched per prefetching interval when
> +swap prefetching is compiled in. The value means multiples of 128K,
> +except when laptop_mode is enabled and then it is ten times larger.
> +Setting it to 0 disables prefetching entirely.

What does "ten times larger" mean?  If laptop_mode, this thing is in units
of 1280 kbytes and if !laptop_mode it's in units of 128 kbytes?

If so (or if not), this tunable is quite obscure and hard-to-understand. 
Can you find a way to make this more user-friendly?

> +/* only used by prefetch externally */
> +/*	mm/swap_prefetch.c */
> +extern void prepare_prefetch(void);
> +extern void add_to_swapped_list(unsigned long index);
> +extern void remove_from_swapped_list(unsigned long index);
> +extern void delay_prefetch(void);

I'd suggest that "prefetch" is too generic a term.  We prefetch lots of
things in the kernel.  Please rename all globally-visible identifiers with
s/prefetch/swap_prefetch/.


> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.16-rc2-ck1/mm/swap_prefetch.c	2006-02-04 18:38:24.000000000 +1100
> @@ -0,0 +1,431 @@
> +/*
> + * linux/mm/swap_prefetch.c
> + *
> + * Copyright (C) 2005 Con Kolivas
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
> +/* Time to delay prefetching if vm is busy or prefetching unsuccessful */
> +#define PREFETCH_DELAY	(HZ * 5)
> +/* Time between attempting prefetching when vm is idle */
> +#define PREFETCH_INTERVAL (HZ)
> +
> +/* sysctl - how many SWAP_CLUSTER_MAX pages to prefetch at a time */
> +int swap_prefetch __read_mostly;
> +
> +struct swapped_root {
> +	unsigned long		busy;		/* vm busy */
> +	spinlock_t		lock;		/* protects all data */
> +	struct list_head	list;		/* MRU list of swapped pages */
> +	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
> +	unsigned int		count;		/* Number of entries */
> +	unsigned int		maxcount;	/* Maximum entries allowed */
> +	kmem_cache_t		*cache;
						/* Of struct swapped_entry */
> +};

> +struct swapped_entry {
> +	swp_entry_t		swp_entry;
> +	struct list_head	swapped_list;
> +};
> +
> +static struct swapped_root swapped = {
> +	.busy 		= 0,
> +	.lock		= SPIN_LOCK_UNLOCKED,
> +	.list  		= LIST_HEAD_INIT(swapped.list),
> +	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
> +	.count 		= 0,
> +};

Description of `busy' and `count'?

> +static task_t *kprefetchd_task;
> +
> +/* Max mapped we will prefetch to */
> +static unsigned long mapped_limit __read_mostly;
> +/* Last total free pages */
> +static unsigned long last_free = 0;
> +static unsigned long temp_free = 0;

Unneeded initialisation.

> +
> +/*
> + * Accounting is sloppy on purpose. As adding and removing entries from the
> + * list happens during swapping in and out we don't want to be spinning on
> + * locks. It is cheaper to just miss adding an entry since having a reference
> + * to every entry is not critical.
> + */
> +void add_to_swapped_list(unsigned long index)
> +{
> +	struct swapped_entry *entry;
> +	int error;
> +
> +	if (unlikely(!spin_trylock(&swapped.lock)))
> +		goto out;

hm, spin_trylock() should internally do unlikely(), but it doesn't.  (It's
a bit of a mess, too).

> +	if (swapped.count >= swapped.maxcount) {

		/*
		 * <comment about LRU>
		 */
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
> +	entry->swp_entry.val = index;
> +
> +	error = radix_tree_preload(GFP_ATOMIC);

I suspect we don't need to preload here.  We can handle radix_tree_insert()
failure, so just go ahead and do it.

> +static inline int high_zone(struct zone *zone)
> +{
> +	if (zone == NULL)
> +		return 0;
> +	return is_highmem(zone);
> +}
> +
> +/*
> + * Find the zone with the most free pages, recheck the watermarks and
> + * then directly allocate the ram. We don't want prefetch to use
> + * __alloc_pages and go calling on reclaim.
> + */
> +static struct page *prefetch_get_page(void)
> +{
> +	struct zone *zone = NULL, *z;
> +	struct page *page = NULL;
> +	struct zonelist *zonelist;
> +	long most_free = 0;
> +
> +	for_each_zone(z) {
> +		long free;
> +
> +		if (z->present_pages == 0)
> +			continue;
> +
> +		/* We don't prefetch into DMA */
> +		if (zone_idx(z) == ZONE_DMA)
> +			continue;
> +
> +		free = z->free_pages;
> +		/* Select the zone with the most free ram preferring high */
> +		if ((free > most_free && (!high_zone(zone) || high_zone(z))) ||
> +			(!high_zone(zone) && high_zone(z))) {
> +				most_free = free;
> +				zone = z;
> +		}
> +	}

<stares at the above expression for three minutes>

I think it'll always select ZONE_HIGHMEM no matter what.  Users of 1G x86
boxes not happy.

> +/*
> + * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
> + * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much at a
> + * time in laptop_mode to minimise the time we keep the disk spinning.
> + */
> +static inline unsigned long prefetch_pages(void)
> +{
> +	return (SWAP_CLUSTER_MAX * swap_prefetch * (1 + 9 * !!laptop_mode));
> +}

I don't think this should be done in-kernel.  There's a nice script to
start and stop laptop mode.  We can make this decision in that script.

> +/*
> + * We want to be absolutely certain it's ok to start prefetching.
> + */
> +static int prefetch_suitable(void)
> +{
> +	struct page_state ps;
> +	unsigned long limit;
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
> +		if (temp_free + SWAP_CLUSTER_MAX < last_free) {
> +			last_free = temp_free;
> +			goto out;
> +		}
> +	} else
> +		last_free = temp_free;

What is the actual threshold rate here?
SWAP_CLUSTER_MAX/(how fast your CPU is)?  Seems a bit vague?

> +	get_page_state(&ps);

get_page_state() can be super-expensive.  How frequently is this called?

> +
> +static int kprefetchd(void *__unused)
> +{
> +	set_user_nice(current, 19);
> +	/* Set ioprio to lowest if supported by i/o scheduler */
> +	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
> +
> +	do {
> +		enum trickle_return prefetched;
> +
> +		try_to_freeze();
> +
> +		/*
> +		 * TRICKLE_FAILED implies no entries left - we do not schedule
> +		 * a wakeup, and further delay the next one.
> +		 */
> +		prefetched = trickle_swap();
> +		switch (prefetched) {
> +		case TRICKLE_SUCCESS:
> +			last_free = temp_free;

This `last_free' thing is really confusing.  It's central to the algorithms
yet its name is largely meaningless.  last_free *what*?  It seems to mean
"total number of free pages on the last prefetching pass", yes?  Wanna
think of a better name and a better comment for it?


