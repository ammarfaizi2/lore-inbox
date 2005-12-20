Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVLTQgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVLTQgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVLTQgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:36:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:4681 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751124AbVLTQgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:36:21 -0500
Date: Tue, 20 Dec 2005 11:35:22 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <43A81DD4.30906@yahoo.com.au>
X-X-Sender: nico@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <43A81DD4.30906@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Nick Piggin wrote:

> Nicolas Pitre wrote:
> > On Wed, 21 Dec 2005, Nick Piggin wrote:
> > 
> > 
> > > Nicolas Pitre wrote:
> > > 
> > > > On Tue, 20 Dec 2005, Nick Piggin wrote:
> > > 
> > > > > Considering that on UP, the arm should not need to disable interrupts
> > > > > for this function (or has someone refuted Linus?), how about:
> > > > 
> > > > 
> > > > Kernel preemption.
> > > > 
> > > 
> > > preempt_disable() ?
> > 
> > 
> > Sure, and we're now more costly than the current implementation with irq
> > disabling.
> > 
> 
> Why? It is just a plain increment of a location that will almost certainly
> be in cache. I can't see how it would be more than half the cost of the
> irq implementation (based on looking at your measurements). How do you
> figure?

ARM is a load/store architecture.  So the preempt_count has to be 
loaded, incremented, and stored back (3 instructions just there).  Then 
the preempt_count itself isn't straight there, it is reached with the 
thread_info pointer which requires 2 additional instructions to 
generate.  So we're already up to 5 instructions while the disabling of 
interrupts takes 3.

OK now we want to decrement the semaphore count.  One load, one 
decrement, one store, i.e. 3 more instructions.  We're up to 8.

Oh and we're still supposed to be in a fast path.  And we even aren't 
ready to decide if we acquired the semaphore just yet.

Now we have to call preempt_enable().  Given that preempt_count() will 
use 2 instructions again to get to the thread_info pointer, let's say 
for the demonstration that we instead open coded our own 
preempt_enable() and preempt_disable() so to be able to cache the 
thread_info pointer amongst those two.  So let's forget about those 2 
additional instructions.

Let's also suppose that we preserved the original preempt count so that 
we don't have to re-load and decrement it which would have used 2 other 
additional instructions.  Good!  But register pressure is increasing, 
and btw we're using completely non generic kernel infrastructure at this 
point.

We nevertheless still have to store the original preempt count back.  
One instruction i.e. we're up to 9.

And with 9 instructions we're already worse than the implementation with 
interrupt disabling.  Maybe not in terms of cycles but hey we're not 
done yet!

Any preempt_enable() equivalent look at the TIF_NEED_RESCHED flag 
(luckily we still have the thread_info pointer handy since we're not 
using test_thread_flag() but loading the flag directly i.e. one 
instruction), testing it (one instruction), conditionally branching to 
preempt_schedule (one instruction).  Now up to 12 instructions.  Amd to 
make things even worse: since the flag has to be tested right after it 
has been loaded you must account for result delays (more cycles) for the 
load.

OK, did we acquire that damn semaphore or not?  Oh since we clobbered 
the processor's condition flag while testing the TIF_NEED_RESCHED flag 
we are now forced to test that semaphore count again to see if it went 
negative: one instruction.  And finally branch to the contention routine 
if the semaphore was already locked: one instruction.

So 14 instructions total with preemption disabling, and that's with the 
best implementation possible by open coding everything instead of 
relying on generic functions/macros.

Compare that to my 4 (or 3 when gcc can cse a constant) 
instructions needed for the mutex equivalent.


Nicolas
