Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRLQPGV>; Mon, 17 Dec 2001 10:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRLQPGC>; Mon, 17 Dec 2001 10:06:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280059AbRLQPGA>; Mon, 17 Dec 2001 10:06:00 -0500
Date: Mon, 17 Dec 2001 16:04:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <20011217160426.U2431@athlon.random>
In-Reply-To: <20011215134711.A30548@redhat.com> <Pine.LNX.4.33.0112152235340.26748-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0112152235340.26748-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 15, 2001 at 11:18:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 11:18:33PM +0100, Ingo Molnar wrote:
> 
> On Sat, 15 Dec 2001, Benjamin LaHaise wrote:
> 
> > [...] The design for reservations is to use enforced accounting limits
> > to achive the effect of seperate memory pools. [...]
> 
> how is this going to handle higher-order pools? How is this going to
> handle the need for composite allocations?
> 
> I think putting in reservation for higher-order pages is going to make
> some parts of page_alloc.c *really* complex, and this complexity i dont
> think we need.
> 
> > [...] Mempool's design is to build seperate pools on top of existing
> > pools of memory. Can't you see the obvious duplication that implies?
> 
> no. Mempool's design is to build preallocated, reserved,
> guaranteed-allocation pools on top of simpler allocators. Simpler
> allocators will try reasonably hard to get something allocated, but might
> fail as well. The majority of allocations within the kernel has no
> deadlock relevance at all. If we allocate a new file structure, or create
> a new socket, or are trying to page in overcommitted memory then we can
> return with -ENOMEM (or OOM) just fine. Allocators are simpler and faster
> without built-in deadlock avoidance and 'reserves'.
> 
> so the difference in design is that you are trying to add reservations as
> a feature of the allocators themselves, while i'm trying to add it as a
> generic, allocator-independent subsystem, which also solved a number of
> other problems we always had in the IO code. Under this design, the 'pure'
> allocators themselves have no concept of reserved pools at all, so there
> is no duplication in concepts. (and no duplication of code.)
> 
> so the fundamental question is, should reservation be a core functionality
> of allocators, or should it be a separate subsystem. *If* it can be put
> into the core allocators (page allocator, SLAB) that gives us all the
> features that mempool gives us today then i think i'd like that approach.
> But i cannot really see how the composite allocation thing can be done via
> reservations.

This whole long thread can be resumed in two points:

1	mempool reserved memory is "wasted" i.e. not usable as cache
2	if the mempool code is moved inside the memory balancing of the
	VM we could use this memory as clean, atomically-freeable cache

however the option 2 is quite complex, think when somebody mmap the page
and we find_lock etc... we cannot "lock" a reserved page, or it would be
unfreeable, at least unless we're sure this "lock" will go away without
us deadlocking on it while waiting.

so in short solution 1 is much simpler and much more obviously correct,
and the only disavantage is that it reduces the amount of clean cache
that could be pontentially be used by the kernel.

If implementation details and code complexity would be our last design
priority  solution 2 advocated by Ben, Rik and SCT would be obviously
superior.

At the moment in 2.5 and also in 2.4 we use the "mempool outside VM"
logic just because we can keep it under control without being killed by
the huge complexity of the implementation details with the locking of
clean cache, nesting into the vm etc... Of course I'm considering a
correct implementation of it, not an hack where cache can be mlocked and
the kernel deadlocks because the reserved memory isn't freeable anymore.

Personally I'm more relaxed with the mempool approch because it reduces
the complexity of an order of magnitude, it abstracts the thing without
making the memory balancing more complex and it definitely solve the
problem (if used correctly i.e. not two alloc_bio in a row from the same
pool from multiple tasks at the same time as pointed out by Ingo).

If somebody wants such 1% of ram back he can buy another dimm of ram and
plug it into his hardware. I mean such 1% of ram lost is something that
can be solved by throwing a few euros into the hardware (and people buys
gigabyte boxes anyways so they don't need all of the 100% of ram), the
other complexy cannot be solved with a few euros, that can only be
solved with lots braincycles and it would be a maintainance work as
well. Abstraction and layering definitely helps cutting down the
complexity of the code.

Andrea
