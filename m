Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWCHVuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWCHVuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWCHVuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:50:01 -0500
Received: from ozlabs.org ([203.10.76.45]:62342 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932583AbWCHVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:49:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.20862.764098.732463@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 08:49:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
In-Reply-To: <28393.1141823992@warthog.cambridge.redhat.com>
References: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<28393.1141823992@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> > Enabling/disabling interrupts doesn't imply a barrier on powerpc, and
> > nor does taking an interrupt or returning from one.
> 
> Surely it ought to, otherwise what's to stop accesses done with interrupts
> disabled crossing with accesses done inside an interrupt handler?

The rule that the CPU always sees its own loads and stores in program
order.

If a CPU takes an interrupt after doing some stores, and the interrupt
handler does loads from the same location(s), it has to see the new
values, even if they haven't got to memory yet.  The interrupt isn't
special in this situation; if the instruction stream has a store to a
location followed by a load from it, the load *has* to see the value
stored by the store (assuming no other store to the same location in
the meantime, of course).  That's true whether or not the CPU takes an
exception or interrupt between the store and the load.  Anything else
would make programming really ... um ... interesting. :)

> > > +Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
> > ...
> > I don't think this is right, and I don't think it is necessary to
> > achieve the end you state, since a CPU will always see its own memory
> > accesses in program order.
> 
> But what about a driver accessing some memory that its device is going to
> observe under irq disablement, and then getting an interrupt immediately after
> from that same device, the handler for which communicates with the device,
> possibly then being broken because the CPU hasn't completed all the memory
> accesses that the driver made while interrupts are disabled?

Well, we have to be clear about what causes what here.  Is the device
accessing this memory just at a random time, or is the access caused
by (in response to) an MMIO store?  And what causes the interrupt?
Does it just happen to come along at this time or is it in response to
one of the stores?

If the device accesses to memory are in response to an MMIO store,
then the code needs an explicit wmb() between the memory stores and
the MMIO store.  Disabling interrupts isn't going to help here because
the device doesn't see the CPU interrupt enable state.

In general it is possible for the CPU to see a different state of
memory than the device sees.  If the driver needs to be sure that they
both see the same view then it needs to use some sort of
synchronization.  A memory barrier followed by a store to the device,
with no further stores to memory until we have an indication from the
device that it has received the MMIO store, would be a suitable way to
synchronize.  Enabling or disabling interrupts does nothing useful
here because the device doesn't see that.  That applies whether we are
in an interrupt routine or not.

Do you have a specific scenario in mind, with a particular device and
driver?

One thing that driver writers do need to be careful about is that if a
device writes some data to memory and then causes an interrupt, the
fact that the interrupt has reached the CPU and the CPU has invoked
the driver's interrupt routine does *not* mean that the data has got
to memory from the CPU's point of view.  The data could still be
queued up in the PCI host bridge or elsewhere.  Doing an MMIO read
from the device is sufficient to ensure that the CPU will then see the
correct data in memory.

> Alternatively, might it be possible for communications between two CPUs to be
> stuffed because one took an interrupt that also modified common data before
> the it had committed the memory accesses done under interrupt disablement?
> This would suggest using a lock though.

Disabling interrupts doesn't do *anything* to help with communication
between CPUs.  You have to use locks or explicit barriers for that.
It is possible for one CPU to see memory accesses done by another CPU
in a different order from the program order on the CPU that did the
accesses.  That applies whether or not some of the accesses were done
inside an interrupt routine.

> > What does *F+*A mean?
> 
> Combined accesses.

Still opaque, sorry: you mean they both happen in some unspecified
order?

> > Well, the driver should *not* be doing *ADR at all, it should be using
> > read[bwl]/write[bwl].  The architecture code has to implement
> > read*/write* in such a way that the accesses generated can't be
> > reordered.  I _think_ it also has to make sure the write accesses
> > can't be write-combined, but it would be good to have that clarified.
> 
> Than what use mmiowb()?

That was introduced to help some platforms that have difficulty
ensuring that MMIO accesses hit the device in the right order, IIRC.
I'm still not entirely clear on exactly where it's needed or what
guarantees you can rely on if you do or don't use it.

> Surely write combining and out-of-order reads are reasonable for cacheable
> devices like framebuffers.

They are.  read*/write* to non-cacheable non-prefetchable MMIO
shouldn't be reordered or write-combined, but for prefetchable MMIO
I'm not sure whether read*/write* should allow reordering, or whether
drivers should use __raw_read/write* if they want that.  (Of course,
with the __raw_ functions they don't get the endian conversion
either...)

Paul.
