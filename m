Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLTVSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLTVSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLTVSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:18:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39533 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932082AbVLTVS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:18:29 -0500
Date: Tue, 20 Dec 2005 16:18:27 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
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
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
 <20051220193423.GC24199@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 20 Dec 2005, Russell King wrote:
> > 
> > Also, Nico has an alternative idea for mutexes which does not
> > involve decrementing or incrementing - it's an atomic swap.
> > That works out at about the same cycle count on non-Intel ARM
> > CPUs as the present semaphore path.  I'm willing to bet that
> > it will be faster than the present semaphore path on Intel ARM
> > CPUs.
> 
> Don't be so sure, especially not in the future.

I think we agree.  But we still live in the present.

> An atomic "swap" operation is, from a CPU design standpoint, fundamentally 
> more expensive that a "load + store".
> 
> Now, most ARM architectures don't notice this, because they are all 
> in-order, and not SMP-aware anyway. No suble memory ordering, no nothing. 
> Which is the only case when "swap" basically becomes a cheap "load+store".

Indeed.

> What I'm trying to say is that a plain "load + store" is almost always 
> going to be the best option in the long run.
> 
> It's also almost certainly always the best option for UP + non-preempt, 
> for both present and future CPU's. The reason is simply that a 
> microarchitecture will _always_ be optimized for that case, since it's 
> pretty much by definition the common situation.

Which is why each architecture must always have the option of providing 
its own fast path implementation according to a number of factors that 
cannot be made into a generic layer.  But this is the same issue whether 
we talk about semaphores or mutexes.

> Is preemption even the common case on ARM? I'd assume not. Why are people 
> so interested in the preemption case?

Because embedded people want it.  ARM is also about the only 
architecture besides x86 that currently sees most of the RT work for the 
same reason.  And yes preemption does make a difference.

> IOW, why don't you just do
> 
> 	ldr  lr,[%0]
> 	subs lr, lr, %1
> 	str  lr,[%0]
> 	blmi failure
> 
> as the _base_ timings, since that should be the common case. That's the 
> drop-dead fastest UP case.

The above is 5 cycles.  About the same as the preemption-safe swp-based 
mutex implementation on non-Intel ARM.  It is broken wrt interrupts when 
the swp is not.  It doesn't work with preemption while the swp 
implementation is potentially smaller with cse and it works in all 
cases.

I mean...... what is it with mutexes that you dislike to the point of 
bending backward that far, and even after seeing the numbers, with such 
a semaphore implementation that _I_ even wouldn't trust people to use 
correctly?  Yes we should use complete() from interrupt handlers but I 
can bet you that a lot of people are still using up() there, and with 
the current up() implementation it just _works_ at least on ARM.

> (Btw, inlining _any_ of these except perhaps the above trivial case, is 
> probably wrong. None of the ARM chips tend to have caches all that big, I 
> bet).

On XScale you should add 2 cycles to branch to the out of line code and 
2 other cycles to branch back.

The ARM mutex implementation can save that and have an extremely small 
inlined footprint already.

Again what do you dislike so much about mutexes?  It must not have much 
to do with technical issues at this point.  ;-)


Nicolas
