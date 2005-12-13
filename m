Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVLMFmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVLMFmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLMFmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:42:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25576 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751330AbVLMFmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:42:44 -0500
Date: Mon, 12 Dec 2005 21:43:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: Rusty Russell <rusty@rustcorp.com.au>, vatsa@in.ibm.com,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051213054316.GB12539@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru> <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <1134344716.5937.11.camel@localhost.localdomain> <200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512130007.48712.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 12:07:47AM -0500, Andrew James Wade wrote:
> On Sunday 11 December 2005 18:45, Rusty Russell wrote:
> > On Sun, 2005-12-11 at 16:21 -0500, Andrew James Wade wrote:
> > > On Sunday 11 December 2005 12:41, Srivatsa Vaddagiri wrote:
> > > > [Changed the subject line to be more generic in the interest of wider audience]
> > > > 
> > > > We seem to be having some confusion over the exact semantics of smp_mb().
> > > > 
> > > > Specifically, are all stores preceding smp_mb() guaranteed to have finished
> > > > (committed to memory/corresponding cache-lines on other CPUs invalidated) 
> > > > *before* successive loads are issued?
> > > 
> > > I doubt it. That's definitely not true of smp_wmb(), which boils down to
> > > __asm__ __volatile__ ("": : :"memory") on SMP i386 (which the constrains
> > > how the compiler orders write instructions, but is otherwise a nop. i386
> > > has in-order writes.).
> 
> Hrrm, after doing a bit of reading on cache-coherency, verifying that the
> corresponding cache-lines on other CPUs are invalidated can (sometimes)
> be done quite quickly, so waiting for that before issuing reads might not
> destroy performance. I still doubt that i386es do thing this way, but I
> don't think it matters (see below).

Hardware designers need only be concerned with how things -appear-
to the software.  They can and do use optimizations that get the
effect of waiting without actually waiting.  For example, an x86
CPU need not -really- keep writes ordered as long as the software
cannot tell that they have become misordered.  This may sound
strange, but one important example would be a CPU doing writes that
are to variables that it knows do not appear in any other CPU's 
cache.  In this sort of case, the CPU could reorder the writes until
such time as it detected a request from another CPU requsting a
cache line containing one of the variables.

> > > And it makes sense that wmb() wouldn't wait for writes: RCU needs
> > > constraints on the order in which writes become visible, but has very week
> > > constraints on when they do. Waiting for writes to flush would hurt
> > > performance.
> > 
> > On the contrary.  I did some digging and asking and thinking about this
> > for the Unreliable Guide to Kernel Locking, years ago:
> > 
> > wmb() means all writes preceeding will complete before any writes
> > following are started.
> 
> What does it mean for a write to start? For that matter, what does it mean
> for a write to complete?

Potentially many things in both cases:

o	Fetching the store instruction that will do the write.

o	Determining that all instructions whose execution logically
	precedes the write are free of fatal errors (e.g., page
	faults, exceptions, traps, ...).

o	Determining the exact value that is to be written (which might
	have been computed by prior instructions).

o	Determining the exact address that is to be written to (which
	also might have been computed by prior instructions).

o	Determining that the store instruction itself is free of
	fatal errors.  Note that it might be necessary to compute
	the address to be sure.

o	Determining that no hardware interrupt will precede the
	completion of the store instruction.

o	Storing the value to one of the CPU's write buffers (which
	is not yet in the coherence region represented by the CPU's
	cache).

o	Starting the process of fetching the cache line into which
	the value is to be stored.

o	Starting the process of invalidating the corresponding cache
	line from all the other CPUs' caches.

o	Receiving the cache line into which the value is to be stored.

o	Storing the value to the CPU's cache, which involves combining
	the value to be written with the rest of the cache line.

o	Responding to the first request for the corresponding cache
	line from some other CPU.

o	Completing the process of invalidating the corresponding cache
	line from all the other CPUs' caches.  Note that Alpha's
	weak memory-barrier semantics allow this step to complete
	long after the value is stored into the writing CPU's cache.

o	Storing the value to physical DRAM.

Most of these steps can execute in parallel or out of order.  And a
CPU designer would gleefully point out -lots- of steps I have omitted,
some for the sake of brevity, others out of ignorance.

You asked!!!

> I think my focusing on the hardware details (of which I am woefully
> ignorant) was a mistake: the hardware can really do whatever it wants so
> long as it implements the expected abstract machine model, and it is
> ordering that matters in that model. So it makes sense that ordering, not
> time, is what the definitions of the memory barriers focus on.

Yes, maintaining one's sanity requires taking a very simplified view
of memory ordering, especially since no two CPUs order memory references
in exactly the same way.

> I think that Oleg's question:
> > Does this mb() garantees that the new value of ->cur will be visible
> > on other cpus immediately after smp_mb() (so that rcu_pending() will
> > notice it) ?
> is really just about the timeliness with which writes before a smp_mb()
> become visible to other CPUs. Does Linux run on architectures in which
> writes are not propagated in a timely manner (that is: other CPUs can read
> stale values for a "considerable" time)? I rather doubt it.

Remember that smp_mb() is officially about controlling the order in
which values are communicated between the CPU executing the smp_mb()
and the interconnect, -not- between a pair of CPUs.  In the general
case (which includes Alpha), controlling the order in which values
are communicated from one CPU to another requires that -both- CPUs
execute memory barriers.

> But with a proviso to my answer: the compiler will happily hoist reads out
> of loops. So writes won't necessarily get read in a timely manner.

Very good!

And this is in fact why smp_wmb() and friends also contain must directives
instructing the compiler not to mess with ordering.

							Thanx, Paul
