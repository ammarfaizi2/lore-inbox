Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbVLRSnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVLRSnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVLRSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 13:43:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932704AbVLRSnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 13:43:20 -0500
Date: Sun, 18 Dec 2005 10:42:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nicolas Pitre <nico@cam.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <20051218092616.GA17308@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org> <20051218092616.GA17308@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Dec 2005, Russell King wrote:
>
> On Sat, Dec 17, 2005 at 10:30:41PM -0800, Linus Torvalds wrote:
> > An interrupt can never change the value without changing it back, except 
> > for the old-fashioned use of "up()" as a completion (which I don't think 
> > we do any more - we used to do it for IO completion a looong time ago).
> 
> I doubt you can guarantee that statement, or has the kernel source
> been audited for this recently?

Well, _if_ it's a noticeable performance win, we should just do it. We 
already know that people don't call "down()" in interrupts (it just 
wouldn't work), we can instrument "up()" too.

It's easy enough to add a "might_sleep()" to the up(). Not strictly true, 
but conceptually it would make sense to make up/down match in that sense. 
We'd have to mark the (few) places that do down_trylock() + up() in 
interrupt context with a special "up_in_interrupt()", but that would be ok 
even from a documentation standpoint.

> However, the real consideration is stability - if a semaphore was
> used for a completion and it was merged, would it be found and
> fixed?  Probably not, because it won't cause any problems on
> architectures where semaphores have atomic properties.

Actually, the reason we have completions is that using semaphores as 
completions caused some really subtle problems that had nothing to do with 
atomicity of the operations themselves, so if you find somebody who uses a 
semaphore from an interrupt, I think we want to know about it.

Completions actually have another - and more important - property than the 
fact that they have a more logical name for a particular usage.

The completion has "don't touch me" guarantees. A thread or interrupt that 
does an "up()" on a semaphore may still touch the memory that was 
allocated for the semaphore after the "down()" part has been released. 
And THAT was the reason for the completions: we allocate them on the stack 
or in temporary allocations, and the thing that does the "down()" to wait 
for something to finish will also do the _release_ of the memory.

With semaphores, that caused problems, because the side doing the "up()" 
would thus possibly touch memory that got released from under it.

This problem happens only on SMP (since you need to have the downer and 
the upper running at the same time), but it's totally independent of the 
other atomicity issues. And almost any semaphore that is used as a 
completion from an interrupt will have this problem, so yes, if you find 
somebody doing an "up()" in interrupt context, we'll fix it.

It would be good to make the rules clear, that you can never touch a 
semaphore from irq context without changing it back before you return.

Of course, that still leaves the following sequence

	if (!down_trylock(..)) {
		... do something ..
		up(..);
	}

which is actually used from interrupts too. At least the console layer 
does that (printk() can happen from interrupts, and we do a down_trylock 
on the console semaphore. But that one shouldn't mess with the _count_, 
although it does mean that the wait-queue preparation etc (for when the 
fast case fails) does still need to be protected against interrupts.

But that would be the slow case, so from a performance standpoint, it 
would still allow the case that really _matters_ to be done with 
interrupts enabled.

> Unless of course sparse can be extended to detect the use of unbalanced 
> semaphores in interrupt contexts.

In theory, yes, but in practice I'd much rather just do the stupid brute 
force things.

> > (Of course, maybe it's not worth it. It might not be a big performance 
> > issue).
> 
> Balancing the elimination of 4 instructions per semaphore operation,
> totalling about 4 to 6 cycles, vs stability I'd go for stability
> unless we can prove the above assertion via (eg) sparse.

I agree, if arm interrupt disables are fast. For example, on x86 (where 
this isn't needed, because you can have an "interrupt-safe" decrement by 
just having it as a single instruction, even if it isn't SMP-safe), 
disabling and re-enabling interrupts is just one instruction each, but the 
combination is usually something like 50+ cycles. So if this was an issue 
on x86, we'd definitely care.

But if you don't think it's a big issue on ARM, it just doesn't matter.

			Linus
