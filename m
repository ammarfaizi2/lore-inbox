Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbREZCC3>; Fri, 25 May 2001 22:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbREZCCJ>; Fri, 25 May 2001 22:02:09 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:59496 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262531AbREZCB6>; Fri, 25 May 2001 22:01:58 -0400
Date: Fri, 25 May 2001 22:01:37 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <20010526034922.O9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252151160.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> On Fri, May 25, 2001 at 09:38:36PM -0400, Ben LaHaise wrote:
> > You're missing a few subtle points:
> >
> > 	1. reservations are against a specific zone
>
> A single zone is not used only for one thing, period. In my previous
> email I enlighted the only conditions under which a reserved pool can
> avoid a deadlock.

Well, until we come up with a better design for a zone allocator that
doesn't involve walking lists and polluting the cache all over the place,
it'll be against a single zone.

> > 	2. try_to_free_pages uses the swap reservation
>
> try_to_free_pages has an huge stacking under it, bounce
> bufferes/loop/nbd/whatever being just some of them.

Fine, then add one to the bounce buffer allocation code, it's all of about
3 lines added.

> > 	3. irqs can no longer eat memory allocations that are needed for
> > 	   swap
>
> you don't even need irq to still deadlock.

I never said you didn't.  But Ingo's patch DOES NOT PROTECT AGAINST
DEADLOCKS CAUSED BY INTERRUPT ALLOCATIONS.  Heck, it doesn't even fix the
deadlock that started this discussion.  Think about what happens when
your network interfaces start rapidly eating all of the memory kswapd is
freeing.  Also, I haven't posted this patch previously exactly because it
is against a specific kind of deadlock that nobody cares about right now,
plus it touches the core of the page allocator, which isn't nescessarily a
good idea during the 2.4 timeframe.

That said, the reservation concept is generic code, which the bounce
buffer patch most certainly isn't.  It can even be improved to overlap
with the page cache pages in the zone, so it isn't even really "free" ram
as currently implemented.


> > Note that with this patch the current garbage in the zone structure with
> > pages_min (which doesn't work reliably) becomes obsolete.
>
> The "garbage" is just an heuristic to allow atomic allocation to work in
> the common case dynamically. Anything deadlock related cannot rely on
> pages_min.

> I am talking about fixing the thing, of course I perfectly know you can
> hide it pretty well, but I definitely hate those kind of hiding patches.

Re-read the above and reconsider.  The reservation doesn't need to be
permitted until after page_alloc has blocked.  Heck, do a schedule before
attempting to use the reservation.

> > > The only case where a reserved pool make sense is when you know that
> > > waiting (i.e. running a task queue, scheduling and trying again to
> > > allocate later) you will succeed the allocation for sure eventually
> > > (possibly with a FIFO policy to make also starvation impossible, not
> > > only deadlocks). If you don't have that guarantee those pools
> > > atuomatically become only a sourcecode and runtime waste, possibly they
> > > could hide core bugs in the allocator or stuff like that.
> >
> > You're completely wrong here.
>
> I don't think so.

Atomicity isn't what I care about.  It's about being able to keep memory
around so that certain allocations can proceed, and those pools cannot be
eaten into by other tasks.  Extend the concept a little further, and you
can even reclaim higher order pages by having a reservation outstanding on
that order.  But I'm just dreaming.

		-ben

