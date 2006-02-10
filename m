Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWBJD0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWBJD0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBJD0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:26:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbWBJD0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:26:33 -0500
Date: Thu, 9 Feb 2006 19:25:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Message-Id: <20060209192556.2629e36b.akpm@osdl.org>
In-Reply-To: <200602101355.41421.kernel@kolivas.org>
References: <200602101355.41421.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Here's a respin with Nick's suggestions and a modification to not cost us
> extra slab on non-numa.

v23?  I'm sure we can do better than that.

> Andrew if it's ok I'd like to see this one get a run in -mm.

hm.

> This patch implements swap prefetching when the vm is relatively idle and
> there is free ram available.

I think "free ram available" is the critical thing here.  If it doesn't
evict anyhing else then OK, it basically uses unutilised disk bandwidth for
free.

But where does it put the pages?  If it was really "free", they'd go onto
the tail of the inactive list.

And what about all those unpaged text pages which the app will need to
fault back in?

> Once pages have been added to the swapped list, a timer is started, testing
> for conditions suitable to prefetch swap pages every 5 seconds. Suitable
> conditions are defined as lack of swapping out or in any pages, and no
> watermark tests failing. Significant amounts of dirtied ram and changes in
> free ram representing disk writes or reads also prevent prefetching.

OK.   The has-the-disk-been-used-recently test still isn't there?

> @@ -844,6 +844,7 @@ int zone_watermark_ok(struct zone *z, in
>  		if (free_pages <= min)
>  			return 0;
>  	}
> +
>  	return 1;
>  }

?

> +	read_lock(&swapper_space.tree_lock);

That's interesting.  We conventionally do read_lock_irq() on an
address_space.tree_lock.  Because
end_page_writeback()->rotate_reclaimable_page()->test_clear_page_writeback()
needs to take a write_lock from interrupt context.  end_swap_bio_write()
calls end_page_writeback() so I don't immediately see why we don't have a
deadlock here.

Ordinarily we'd just use find_get_page(), but

> +	/* Entry may already exist */
> +	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
> +	read_unlock(&swapper_space.tree_lock);
> +	if (page) {
> +		remove_from_swapped_list(entry.val);
> +		goto out;
> +	}

you don't take a ref on the page.

Which makes one wonder what happens here if `page' got whipped out of
swapcache between the lookup and the remove_from_swapped_list().  Probably
nothing much.

Did you consider borrowing swapper_space.tree_lock to provide the list and
radix-tree locking throughout here?

> +out:
> +	if (mru) {
> +		spin_lock(&swapped.lock);
> +		swapped.list.next = mru;
> +		spin_unlock(&swapped.lock);
> +	}

That looks strange.  What happens to swapped.list.prev?

> +static int kprefetchd(void *__unused)
> +{
> +	set_user_nice(current, 19);
> +	/* Set ioprio to lowest if supported by i/o scheduler */
> +	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
> +
> +	do {
> +		try_to_freeze();
> +
> +		/*
> +		 * TRICKLE_FAILED implies no entries left - we do not schedule
> +		 * a wakeup, and further delay the next one.
> +		 */
> +		if (trickle_swap() == TRICKLE_FAILED)
> +			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);

	set_current_state(TASK_INTERRUPTIBLE);
	schedule();

