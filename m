Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVLSPpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLSPpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVLSPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:45:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38846 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964781AbVLSPpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:45:45 -0500
Date: Mon, 19 Dec 2005 10:45:43 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <20051219092743.GA9609@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512191009170.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
 <20051218092616.GA17308@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain>
 <20051219092743.GA9609@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Russell King wrote:

> On Sun, Dec 18, 2005 at 08:48:15PM -0500, Nicolas Pitre wrote:
> > On Sun, 18 Dec 2005, Linus Torvalds wrote:
> > > I agree, if arm interrupt disables are fast. For example, on x86 (where 
> > > this isn't needed, because you can have an "interrupt-safe" decrement by 
> > > just having it as a single instruction, even if it isn't SMP-safe), 
> > > disabling and re-enabling interrupts is just one instruction each, but the 
> > > combination is usually something like 50+ cycles. So if this was an issue 
> > > on x86, we'd definitely care.
> > > 
> > > But if you don't think it's a big issue on ARM, it just doesn't matter.
> > 
> > Let's see.  The core of the uncontended down() on ARM looks like this:
> > 
> > 	mrs     r0, cpsr
> > 	orr     r1, r0, #128
> > 	msr     cpsr_c, r1
> > 	ldr     r1, [%0]
> > 	subs     r1, r1, #1
> > 	str     r1, [%0]
> > 	msr     cpsr_c, r0
> > 	blt	__contention
> > 
> > On a 624MHz ARMv5 processor I can execute this sequence approximately 
> > 266100 times in 10 ms, which means approx 23 cycles.  The uncontended 
> > up() is the same except the sub is replaced by an add.
> > 
> > Removing the interrupt masking/unmasking reduces the above sequence to 4 
> > instructions using 6 cycles.
> 
> I think you're comparing applies with oranges here - you measured the
> above function by executing it, and the reduced version by some other
> method (you appear to be absolutely certain that it's 6 cycles, but
> the previous was approximate).

They were _all_ measured execution times (I learned not to trust the 
manual for those).  Here's the boring details in case you didn't trust 
me:

The above 6 cycles was deduced from executing the given sequence of 
instructions 1014100 times within 10 ms at 624 MHz.

> > Now if we consider simple mutexes, the core of it becomes this on ARM:
> > 
> > 	mov	r0, #1
> > 	swp	r1, r0, [%0]
> > 	cmp	r1, #0
> > 	bne	__contention
> > 
> > The above takes 8 cycles.  It uses 4 instructions, and it could even be 
> > reduced to 3 when gcc's cse optimization can find a register that 
> > already contains the value 1 (then using only 7 cycles).  It is 
> > interrupt safe.  It is preemption safe.  It is small.

And for completeness: 762700 times within 10 ms at 624 MHz.

> That's over-simplified, and is the easy bit.  Now work out how you handle
> the unlock operation.

I exposed that in a previous post in this thread already.

> You don't know whether the lock is contended or not in the unlock path,
> so you always have to do the "wake up" thing.  (You can't rely on the
> value of the lock since another thread may well be between this swp
> instruction and entering the __contention function.  Hence you can't
> use the value of the lock to determine whether there's anyone sleeping
> on it.)

No.  For simplicity in this mail I only provided the inline portion of 
the mutex.  Let me provide again the __contention part which should be 
out of line:

__contention:
	mov	r0, #2			@ 2 = contended lock flag
	swp	r1, r0, [%0]		@ upgrade the lock, get current value
	cmp	r1, #0			@ has it just been unlocked?
	moveq	pc, lr			@ if so we now own it.
	stmfd	sp!, {r2, r3, ip, lr}	@ save whatever regs (needs %0 too)
	bl	__sleep
	ldmfd	sp!, {r2, r3, ip, lr}
	mov	r0, #1			@ try to lock again
	swp	r1, r0, [%0]		@ and get current state
	cmp	r1, #0			@ if it was locked again
	bne	__contention		@ then we loop again
	mov	pc, lr			@ otherwise we own it at last

Note that it needs task state and wait queue handling added which means 
that part should probably have a C helper like the current semaphore 
implementation.  But you should have the basic idea now.

> Therefore, I suspect that while the lock may be faster, the unlock
> won't be.

Not at all.  The inlined unlock goes like this:

	mov	r0, #0			@ 0 = unlock flag
	swp	r1, r0, [%0]		@ unlock and get current state
	cmp	r1, #2			@ was it contended?
	bleq	__wake_up		@ if so wake up one thread

Again 4 instructions (possibly 3 if cse is possible) and therefore with 
the same 7-8 cycle cost.

The only issue has to do with the fact that the lock might have been 
unlocked right before we go to upgrade it to contended.  We already 
catch that case since by locking the mutex with the contended flag we 
effectively own it at that point.  But then a superfluous wake-up will 
be done even if there is no contention anymore.  But as you see this 
kind of false contention is harmless and should be extremely rare (the 
window for it is really small).


Nicolas
