Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWCHDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWCHDKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWCHDKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:10:12 -0500
Received: from ozlabs.org ([203.10.76.45]:21411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932141AbWCHDKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:10:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
Date: Wed, 8 Mar 2006 14:10:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
References: <31492.1141753245@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> The attached patch documents the Linux kernel's memory barriers.

Thanks for venturing into this particular lion's den. :)

> +Memory barriers are instructions to both the compiler and the CPU to impose a
> +partial ordering between the memory access operations specified either side of
> +the barrier.

... as observed from another agent in the system - another CPU or a
bus-mastering I/O device.  A given CPU will always see its own memory
accesses in order.

> + (*) reads are synchronous and may need to be done immediately to permit

Leave out the "are synchronous and".  It's not true.

I also think you need to avoid talking about "the bus".  Some systems
don't have a bus, but rather have an interconnection fabric between
the CPUs and the memories.  Talking about a bus implies that all
memory accesses in fact get serialized (by having to be sent one after
the other over the bus) and that you can therefore talk about the
order in which they get to memory.  In some systems, no such order
exists.

It's possible to talk sensibly about the order in which memory
accesses get done without talking about a bus or requiring a total
ordering on the memory access.  The PowerPC architecture spec does
this by specifying that in certain circumstances one load or store has
to be "performed with respect to other processors and mechanisms"
before another.  A load is said to be performed with respect to
another agent when a store by that agent can no longer change the
value returned by the load.  Similarly, a store is performed w.r.t.
an agent when any load done by the agent will return the value stored
(or a later value).

> +     The way to deal with this is to insert an I/O memory barrier between the
> +     two accesses:
> +
> +	*ADR = ctl_reg_3;
> +	mb();
> +	reg = *DATA;

Ummm, this implies mb() is "an I/O memory barrier".  I can see people
getting confused if they read this and then see mb() being used when
no I/O is being done.

> +The Linux kernel has six basic memory barriers:
> +
> +		MANDATORY (I/O)	SMP
> +		===============	================
> +	GENERAL	mb()		smp_mb()
> +	READ	rmb()		smp_rmb()
> +	WRITE	wmb()		smp_wmb()
> +
> +General memory barriers make a guarantee that all memory accesses specified
> +before the barrier will happen before all memory accesses specified after the
> +barrier.

By "memory accesses" do you mean accesses to system memory, or do you
mean loads and stores - which may be to system memory, memory on an I/O
device (e.g. a framebuffer) or to memory-mapped I/O registers?

Linus explained recently that wmb() on x86 does not order stores to
system memory w.r.t. stores to stores to prefetchable I/O memory (at
least that's what I think he said ;).

> +Some of the other functions in the linux kernel imply memory barriers. For
> +instance all the following (pseudo-)locking functions imply barriers.
> +
> + (*) interrupt disablement and/or interrupts

Enabling/disabling interrupts doesn't imply a barrier on powerpc, and
nor does taking an interrupt or returning from one.

> + (*) spin locks

I think it's still an open question as to whether spin locks do any
ordering between accesses to system memory and accesses to I/O
registers.

> + (*) R/W spin locks
> + (*) mutexes
> + (*) semaphores
> + (*) R/W semaphores
> +
> +In all cases there are variants on a LOCK operation and an UNLOCK operation.
> +
> + (*) LOCK operation implication:
> +
> +     Memory accesses issued after the LOCK will be completed after the LOCK
> +     accesses have completed.
> +
> +     Memory accesses issued before the LOCK may be completed after the LOCK
> +     accesses have completed.
> +
> + (*) UNLOCK operation implication:
> +
> +     Memory accesses issued before the UNLOCK will be completed before the
> +     UNLOCK accesses have completed.
> +
> +     Memory accesses issued after the UNLOCK may be completed before the UNLOCK
> +     accesses have completed.

And therefore an UNLOCK followed by a LOCK is equivalent to a full
barrier, but a LOCK followed by an UNLOCK isn't.

> +Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
> +memory and I/O accesses individually, or interrupt handling will barrier
> +memory and I/O accesses on entry and on exit. This prevents an interrupt
> +routine interfering with accesses made in a disabled-interrupt section of code
> +and vice versa.

I don't think this is right, and I don't think it is necessary to
achieve the end you state, since a CPU will always see its own memory
accesses in program order.

> +The following sequence of events on the bus is acceptable:
> +
> +	LOCK, *F+*A, *E, *C+*D, *B, UNLOCK

What does *F+*A mean?

> +Consider also the following (going back to the AMD PCnet example):
> +
> +	DISABLE IRQ
> +	*ADR = ctl_reg_3;
> +	mb();
> +	x = *DATA;
> +	*ADR = ctl_reg_4;
> +	mb();
> +	*DATA = y;
> +	*ADR = ctl_reg_5;
> +	mb();
> +	z = *DATA;
> +	ENABLE IRQ
> +	<interrupt>
> +	*ADR = ctl_reg_7;
> +	mb();
> +	q = *DATA
> +	</interrupt>
> +
> +What's to stop "z = *DATA" crossing "*ADR = ctl_reg_7" and reading from the
> +wrong register? (There's no guarantee that the process of handling an
> +interrupt will barrier memory accesses in any way).

Well, the driver should *not* be doing *ADR at all, it should be using
read[bwl]/write[bwl].  The architecture code has to implement
read*/write* in such a way that the accesses generated can't be
reordered.  I _think_ it also has to make sure the write accesses
can't be write-combined, but it would be good to have that clarified.

> +======================
> +POWERPC SPECIFIC NOTES
> +======================
> +
> +The powerpc is weakly ordered, and its read and write accesses may be
> +completed generally in any order. It's memory barriers are also to some extent
> +more substantial than the mimimum requirement, and may directly effect
> +hardware outside of the CPU.

Unfortunately mb()/smp_mb() are quite expensive on PowerPC, since the
only instruction we have that implies a strong enough barrier is sync,
which also performs several other kinds of synchronization, such as
waiting until all previous instructions have completed executing to
the point where they can no longer cause an exception.

Paul.
