Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbREZCl0>; Fri, 25 May 2001 22:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262552AbREZClQ>; Fri, 25 May 2001 22:41:16 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45677 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262550AbREZClK>; Fri, 25 May 2001 22:41:10 -0400
Date: Fri, 25 May 2001 22:40:52 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <20010526042623.Q9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252229110.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> It does, but only for the create_bounces. As said if you want to "fix",
> not to "hide" you need to address every single case, a generic reserved
> pool is just useless. Now try to get a dealdock in 2.4.5 with tasks
> locked up in create_bounces() if you say it does not protect against
> irqs. see?

So?  It just deadlocks in create_buffers/alloc_pages.  We finished
debugging that weeks ago, and I'm not interested in repeating that.

> What I said is that instead of handling the pool by hand in every single
> place one could write an API to generalize it, but very often a simple
> API hooked into the page allocator may not be flexible enough to
> guarantee the kind of allocations we need, highmem is just one example
> where we need more flexibility not just for the pages but also for the
> bh (but ok that's mostly an implementation issue, if you do the math
> right, it's harder but you can still use a generic API).

Well, this is the infrastructure for guaranteeing atomic allocations.  The
only beautifying it really needs is in adding an alloc_pages variant that
takes the reservation pool as a parameter instead of the current mucking
with current->page_reservation.

> > Re-read the above and reconsider.  The reservation doesn't need to be
> > permitted until after page_alloc has blocked.  Heck, do a schedule before
>
> I don't see what you mean here, could you elaborate?

I simply meant that the reservation code wasn't bent on providing atomic
allocations for non-atomic allocators.  IIRC, I hooked into __alloc_pages
after the normal mechanism of allocating pages failed, but where it may
have already slept, but I think that was part of the other patch I posted
in the last email.  Our tree contains a lot of patches, and some of the
effects like this are built on top of each other, so I'm not surprised
that a critical piece like that was missing.

		-ben

