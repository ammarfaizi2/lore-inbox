Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVLSBsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVLSBsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVLSBsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:48:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10354 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030251AbVLSBsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:48:19 -0500
Date: Sun, 18 Dec 2005 20:48:15 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
 <20051218092616.GA17308@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Sun, 18 Dec 2005, Russell King wrote:
> >
> > On Sat, Dec 17, 2005 at 10:30:41PM -0800, Linus Torvalds wrote:
> > > An interrupt can never change the value without changing it back, except 
> > > for the old-fashioned use of "up()" as a completion (which I don't think 
> > > we do any more - we used to do it for IO completion a looong time ago).
> > 
> > I doubt you can guarantee that statement, or has the kernel source
> > been audited for this recently?
> 
> Well, _if_ it's a noticeable performance win, we should just do it. We 
> already know that people don't call "down()" in interrupts (it just 
> wouldn't work), we can instrument "up()" too.

And how would that prevent the kernel preemption issue?

> > Balancing the elimination of 4 instructions per semaphore operation,
> > totalling about 4 to 6 cycles, vs stability I'd go for stability
> > unless we can prove the above assertion via (eg) sparse.
> 
> I agree, if arm interrupt disables are fast. For example, on x86 (where 
> this isn't needed, because you can have an "interrupt-safe" decrement by 
> just having it as a single instruction, even if it isn't SMP-safe), 
> disabling and re-enabling interrupts is just one instruction each, but the 
> combination is usually something like 50+ cycles. So if this was an issue 
> on x86, we'd definitely care.
> 
> But if you don't think it's a big issue on ARM, it just doesn't matter.

Let's see.  The core of the uncontended down() on ARM looks like this:

	mrs     r0, cpsr
	orr     r1, r0, #128
	msr     cpsr_c, r1
	ldr     r1, [%0]
	subs     r1, r1, #1
	str     r1, [%0]
	msr     cpsr_c, r0
	blt	__contention

On a 624MHz ARMv5 processor I can execute this sequence approximately 
266100 times in 10 ms, which means approx 23 cycles.  The uncontended 
up() is the same except the sub is replaced by an add.

Removing the interrupt masking/unmasking reduces the above sequence to 4 
instructions using 6 cycles.  However it becomes completely unsafe wrt 
usage of up() from interrupt handlers, and it is completely preemption 
unsafe.

Now if we consider simple mutexes, the core of it becomes this on ARM:

	mov	r0, #1
	swp	r1, r0, [%0]
	cmp	r1, #0
	bne	__contention

The above takes 8 cycles.  It uses 4 instructions, and it could even be 
reduced to 3 when gcc's cse optimization can find a register that 
already contains the value 1 (then using only 7 cycles).  It is 
interrupt safe.  It is preemption safe.  It is small.

So if you think ARM is important, and if you consider the above a good 
enough improvement (I do), then that should talk in favor of simple 
mutexes for the kernel.  And it will have the nice side effect of making 
it easier on some other more obscur architectures.


Nicolas
