Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWBJDuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWBJDuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWBJDuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:50:20 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:34013 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751036AbWBJDuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:50:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Date: Fri, 10 Feb 2006 14:49:58 +1100
User-Agent: KMail/1.9.1
Cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
References: <200602101355.41421.kernel@kolivas.org> <20060209192556.2629e36b.akpm@osdl.org>
In-Reply-To: <20060209192556.2629e36b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101449.59486.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 14:25, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Here's a respin with Nick's suggestions and a modification to not cost us
> > extra slab on non-numa.
>
> v23?  I'm sure we can do better than that.

:D

> > This patch implements swap prefetching when the vm is relatively idle and
> > there is free ram available.
>
> I think "free ram available" is the critical thing here.  If it doesn't
> evict anyhing else then OK, it basically uses unutilised disk bandwidth for
> free.
>
> But where does it put the pages?  If it was really "free", they'd go onto
> the tail of the inactive list.

It puts them in swapcache. This seems to work nicely as a nowhere-land place 
where they don't have much affect on anything until we need them or need more 
ram. This has worked well, but I'm open to other suggestions.

> And what about all those unpaged text pages which the app will need to
> fault back in?

Tracking these would make the perceived time to wakeup much much faster but 
also make the list a heck of a lot larger.. but more to the point I have no 
idea how to do it and get what we really want on the list.

> > Once pages have been added to the swapped list, a timer is started,
> > testing for conditions suitable to prefetch swap pages every 5 seconds.
> > Suitable conditions are defined as lack of swapping out or in any pages,
> > and no watermark tests failing. Significant amounts of dirtied ram and
> > changes in free ram representing disk writes or reads also prevent
> > prefetching.
>
> OK.   The has-the-disk-been-used-recently test still isn't there?

No, but you'd have to free up +/- SWAP_SCAN_MAX as many pages as you fill when 
reading from disk for this indirect method to not pick it up. It's easy 
enough to see that it's effective: You can sit and watch vmstat for many 
minutes after say an oom-kill in the hope you see it quiet enough before 
prefetch does anything. After allowing 'tail -f /dev/zero' to be oomkilled in 
a full gui environment it usually takes >5 mins before swap prefetch starts 
prefetching.

> > @@ -844,6 +844,7 @@ int zone_watermark_ok(struct zone *z, in
> >  		if (free_pages <= min)
> >  			return 0;
> >  	}
> > +
> >  	return 1;
> >  }
>
> ?

Legacy of v1->v22..

>
> > +	read_lock(&swapper_space.tree_lock);
>
> That's interesting.  We conventionally do read_lock_irq() on an
> address_space.tree_lock.  Because
> end_page_writeback()->rotate_reclaimable_page()->test_clear_page_writeback(
>) needs to take a write_lock from interrupt context.  end_swap_bio_write()
> calls end_page_writeback() so I don't immediately see why we don't have a
> deadlock here.

Wasn't sure of the semantics. I was lucky I guess.

> Ordinarily we'd just use find_get_page(), but
>
> > +	/* Entry may already exist */
> > +	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
> > +	read_unlock(&swapper_space.tree_lock);
> > +	if (page) {
> > +		remove_from_swapped_list(entry.val);
> > +		goto out;
> > +	}
>
> you don't take a ref on the page.
>
> Which makes one wonder what happens here if `page' got whipped out of
> swapcache between the lookup and the remove_from_swapped_list().  Probably
> nothing much.
>
> Did you consider borrowing swapper_space.tree_lock to provide the list and
> radix-tree locking throughout here?

I did. I was concerned that since most of the functions occur as we swap in or 
out that we'd end up with more contention of that lock.

> > +out:
> > +	if (mru) {
> > +		spin_lock(&swapped.lock);
> > +		swapped.list.next = mru;
> > +		spin_unlock(&swapped.lock);
> > +	}
>
> That looks strange.  What happens to swapped.list.prev?

Left dangling for future null dereferencing... Only would have been hit on 
numa.

> > +			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
>
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	schedule();

Ack.

Thanks! I guess I will be working on v24 in the near future...

Cheers,
Con
