Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbREZC10>; Fri, 25 May 2001 22:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbREZC1F>; Fri, 25 May 2001 22:27:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33332 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261735AbREZC0x>; Fri, 25 May 2001 22:26:53 -0400
Date: Sat, 26 May 2001 04:26:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
Message-ID: <20010526042623.Q9634@athlon.random>
In-Reply-To: <20010526034922.O9634@athlon.random> <Pine.LNX.4.33.0105252151160.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252151160.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 10:01:37PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 10:01:37PM -0400, Ben LaHaise wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > On Fri, May 25, 2001 at 09:38:36PM -0400, Ben LaHaise wrote:
> > > You're missing a few subtle points:
> > >
> > > 	1. reservations are against a specific zone
> >
> > A single zone is not used only for one thing, period. In my previous
> > email I enlighted the only conditions under which a reserved pool can
> > avoid a deadlock.
> 
> Well, until we come up with a better design for a zone allocator that
> doesn't involve walking lists and polluting the cache all over the place,
> it'll be against a single zone.

I meant each zone is used by more than one user, that definitely won't
change.

> > > 	2. try_to_free_pages uses the swap reservation
> >
> > try_to_free_pages has an huge stacking under it, bounce
> > bufferes/loop/nbd/whatever being just some of them.
> 
> Fine, then add one to the bounce buffer allocation code, it's all of about
> 3 lines added.

Yes, you should add it to the bounce buffers to the loop to nbd to
whatever and then remove it from all other places that you put into it
right now. That's why I'm saying your patch won't fix anything (but
hide) as it was in its first revision.

> I never said you didn't.  But Ingo's patch DOES NOT PROTECT AGAINST
> DEADLOCKS CAUSED BY INTERRUPT ALLOCATIONS.  Heck, it doesn't even fix the

It does, but only for the create_bounces. As said if you want to "fix",
not to "hide" you need to address every single case, a generic reserved
pool is just useless. Now try to get a dealdock in 2.4.5 with tasks
locked up in create_bounces() if you say it does not protect against
irqs. see?

> That said, the reservation concept is generic code, which the bounce
> buffer patch most certainly isn't.  It can even be improved to overlap

What I said is that instead of handling the pool by hand in every single
place one could write an API to generalize it, but very often a simple
API hooked into the page allocator may not be flexible enough to
guarantee the kind of allocations we need, highmem is just one example
where we need more flexibility not just for the pages but also for the
bh (but ok that's mostly an implementation issue, if you do the math
right, it's harder but you can still use a generic API).

> with the page cache pages in the zone, so it isn't even really "free" ram
> as currently implemented.

yes that would be a very nice property, again I'm not against a generic
interface for creating reserved pool of memory (I mentioned that
possibilty before reading your patch after all). It's just the
implemetation (mainly the per-task hook overwritten) that didn't
convinced me and the usage that was at least apparently obviously wrong
to my eyes.

> Re-read the above and reconsider.  The reservation doesn't need to be
> permitted until after page_alloc has blocked.  Heck, do a schedule before

I don't see what you mean here, could you elaborate?

> Atomicity isn't what I care about.  It's about being able to keep memory
> around so that certain allocations can proceed, and those pools cannot be
> eaten into by other tasks.  [..]

Those pools needs to be gloabl unless
you want to allocate them at fork() for every single task like you did
for some the kernel threads, and if you make them global per-zone or
per-whatever not every single case it will deadlock.  Or better it will
works by luck, it proceeds until you don't have a case where you didn't
only needed 32 pages reserved, but where you needed 33 pages reserved to
avoid the deadlock, it's on the same lines of the pci_map_* brokeness in
some sense.

Allocating those pools per-task is just a total waste, those are
"security" pools, in the 99% of cases you won't need them and you will
allocate the memory dynamically, they just needs to be there for
correctness and to avoid the dealdock very seldom.

Andrea
