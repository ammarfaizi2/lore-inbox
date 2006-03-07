Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWCGSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWCGSfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWCGSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:35:20 -0500
Received: from [81.2.110.250] ([81.2.110.250]:43452 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751428AbWCGSfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:35:18 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
References: <31492.1141753245@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Mar 2006 18:40:25 +0000
Message-Id: <1141756825.31814.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 17:40 +0000, David Howells wrote:
> +Older and less complex CPUs will perform memory accesses in exactly the order
> +specified, so if one is given the following piece of code:

Not really true. Some of the fairly old dumb processors don't do this to
the bus, and just about anything with a cache wont (as it'll burst cache
lines to main memory)

> +     want to access to the address register, and then read or write the
> +     appropriate data register to access the chip's internal register:
> +
> +	*ADR = ctl_reg_3;
> +	reg = *DATA;

Not allowed anyway

> +     In this case, the barrier makes a guarantee that all memory accesses
> +     before the barrier will happen before all the memory accesses after the
> +     barrier. It does _not_ guarantee that all memory accesses before the
> +     barrier will be complete by the time the barrier is complete.

Better meaningful example would be barriers versus an IRQ handler. Which
leads nicely onto section 2

> +General memory barriers make a guarantee that all memory accesses specified
> +before the barrier will happen before all memory accesses specified after the
> +barrier.

No. They guarantee that to an observer also running on that set of
processors the accesses to main memory will appear to be ordered in that
manner. They don't guarantee I/O related ordering for non main memory
due to things like PCI posting rules and NUMA goings on.

As an example of the difference here a Geode will reorder stores as it
feels but snoop the bus such that it can ensure an external bus master
cannot observe this by holding it off the bus to fix up ordering
violations first.

> +Read memory barriers make a guarantee that all memory reads specified before
> +the barrier will happen before all memory reads specified after the barrier.
> +
> +Write memory barriers make a guarantee that all memory writes specified before
> +the barrier will happen before all memory writes specified after the barrier.

Both with the caveat above

> +There is no guarantee that any of the memory accesses specified before a memory
> +barrier will be complete by the completion of a memory barrier; the barrier can
> +be considered to draw a line in the access queue that accesses of the
> +appropriate type may not cross.

CPU generated accesses to main memory

> + (*) interrupt disablement and/or interrupts
> + (*) spin locks
> + (*) R/W spin locks
> + (*) mutexes
> + (*) semaphores
> + (*) R/W semaphores

Should probably cover schedule() here.

> +Locks and semaphores may not provide any guarantee of ordering on UP compiled
> +systems, and so can't be counted on in such a situation to actually do
> +anything at all, especially with respect to I/O memory barriering.

_irqsave/_irqrestore ...


> +==============================
> +I386 AND X86_64 SPECIFIC NOTES
> +==============================
> +
> +Earlier i386 CPUs (pre-Pentium-III) are fully ordered - the operations on the
> +bus appear in program order - and so there's no requirement for any sort of
> +explicit memory barriers.

Actually they are not. Processors prior to Pentium Pro ensure that the
perceived ordering between processors of writes to main memory is
preserved. The Pentium Pro is supposed to but does not in SMP cases. Our
spin_unlock code knows about this. It also has some problems with this
situation when handling write combining memory. The IDT Winchip series
processors are run in out of order store mode and our lock functions and
dmamappers should know enough about this. 

On x86 memory barriers for read serialize order using lock instructions,
on write the winchip at least generates serializing instructions.

barrier() is pure CPU level of course

> + (*) Normal writes to memory imply wmb() [and so SFENCE is normally not
> +     required].

Only at an on processor level and not for all clones, also there are
errata here for PPro.

> + (*) Accesses to uncached memory imply mb() [eg: memory mapped I/O].

Not always. MMIO ordering is outside of the CPU ordering rules and into
PCI and other bus ordering rules. Consider

	writel(STOP_DMA, &foodev->ctrl);
	free_dma_buffers(foodev);

This leads to horrible disasters.


> +
> +======================
> +POWERPC SPECIFIC NOTES

Can't comment on PPC 

