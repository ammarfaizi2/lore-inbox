Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBPBWO>; Thu, 15 Feb 2001 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRBPBWE>; Thu, 15 Feb 2001 20:22:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9479 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129066AbRBPBVx>; Thu, 15 Feb 2001 20:21:53 -0500
Date: Thu, 15 Feb 2001 17:21:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Feb 2001, Manfred Spraul wrote:
> 
> > Now, I will agree that I suspect most x86 _implementations_ will not do
> > this. TLB's are too timing-critical, and nobody tends to want to make
> > them bigger than necessary - so saving off the source address is
> > unlikely. Also, setting the D bit is not a very common operation, so
> > it's easy enough to say that an internal D-bit-fault will just cause a
> > TLB re-load, where the TLB re-load just sets the A and D bits as it
> > fetches the entry (and then page fault handling is an automatic result
> > of the reload).
> 
> But then the cpu would support setting the D bit in the page directory,
> but it doesn't.

Not necessarily. The TLB walker is a nasty piece of business, and
simplifying it as much as possible is important for hardware. Not setting
the D bit in the page directory is likely to be because it is unnecessary,
and not because it couldn't be done.

> But if we change the interface, could we think about the poor s390
> developers?
> 
> s390 only has a "clear the present bit in the pte and flush the tlb"
> instruction.

Now, that ends up being fairly close to what it seems mm/vmscan.c needs to
do, so yes, it would not necessarily be a bad idea to join the
"ptep_get_and_clear()" and "flush_tlb_page()" operations into one.

However, the mm/memory.c use (ie region unmapping with zap_page_range())
really needs to do something different, because it inherently works with a
range of entries, and abstacting it to be a per-entry thing would be
really bad for performance anywhere else (S/390 might be ok with it,
assuming that their special instruction is really fast - I don't know. But
I do know that everybody else wants to do it with one single flush for the
whole region, especially for SMP).

> Perhaps try to schedule away, just to improve the probability that
> mm->cpu_vm_mask is clear.
> 
> I just benchmarked a single flush_tlb_page().
> 
> Pentium II 350: ~ 2000 cpu ticks.
> Pentium III 850: ~ 3000 cpu ticks.

Note that there is some room for concurrency here - we can fire off the
IPI, and continue to do "local" work until we actually need the "results"
in the form of stable D bits etc. So we _might_ want to take this into
account in the interfaces: allow for a "prepare_to_gather()" which just
sends the IPI but doesn't wait for it to necessarily get accepted, and
then only by the time we actually start checking the dirty bits (ie the
second phase, after we've invalidated the page tables) do we need to wait
and make sure that nobody else is using the TLB any more.

Done right, this _might_ be of the type

 - prepare_to_gather(): sends IPI to all CPU's indicated in
   mm->cpu_vm_mask
 - go on, invalidating all VM entries
 - busy-wait until "mm->cpu_vm_mask" only contains the local CPU (where
   the busy-wait is hopefully not a wait at all - the other CPU's would
   have exited the mm while we were cleaning up the page tables)
 - go back, gather up any potential dirty bits and free the pages
 - release the mm

Note that there are tons of optimizations for the common case: for
example, if we're talking about private read-only mappings, we can
possibly skip some or all of this, because we know that we simply won't
care about whether the pages were dirty or not as they're going to be
thrown away in any case.

So we can have several layers of optimizations: for UP or the SMP case
where we have "mm->cpu_vm_mask & ~(1 << current_cpu) == 0" we don't need
the IPI or the careful multi-CPU case at all. And for private stuff, we
need the careful invalidation, but we don't need to go back and gather the
dirty bits. So the only case that ends up being fairly heavy may be a case
that is very uncommon in practice (only for unmapping shared mappings in
threaded programs or the lazy TLB case).

I suspect getting a good interface for this, so that zap_page_range()
doesn't end up being the function for hell, is the most important thing.

			Linus

