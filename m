Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVLSJ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVLSJ16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLSJ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:27:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30728 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932709AbVLSJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:27:57 -0500
Date: Mon, 19 Dec 2005 09:27:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
Message-ID: <20051219092743.GA9609@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>,
	David Howells <dhowells@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	Andrew Morton <akpm@osdl.org>
References: <1134791914.13138.167.camel@localhost.localdomain> <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org> <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain> <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org> <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain> <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org> <20051218092616.GA17308@flint.arm.linux.org.uk> <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org> <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 08:48:15PM -0500, Nicolas Pitre wrote:
> On Sun, 18 Dec 2005, Linus Torvalds wrote:
> > I agree, if arm interrupt disables are fast. For example, on x86 (where 
> > this isn't needed, because you can have an "interrupt-safe" decrement by 
> > just having it as a single instruction, even if it isn't SMP-safe), 
> > disabling and re-enabling interrupts is just one instruction each, but the 
> > combination is usually something like 50+ cycles. So if this was an issue 
> > on x86, we'd definitely care.
> > 
> > But if you don't think it's a big issue on ARM, it just doesn't matter.
> 
> Let's see.  The core of the uncontended down() on ARM looks like this:
> 
> 	mrs     r0, cpsr
> 	orr     r1, r0, #128
> 	msr     cpsr_c, r1
> 	ldr     r1, [%0]
> 	subs     r1, r1, #1
> 	str     r1, [%0]
> 	msr     cpsr_c, r0
> 	blt	__contention
> 
> On a 624MHz ARMv5 processor I can execute this sequence approximately 
> 266100 times in 10 ms, which means approx 23 cycles.  The uncontended 
> up() is the same except the sub is replaced by an add.
> 
> Removing the interrupt masking/unmasking reduces the above sequence to 4 
> instructions using 6 cycles.

I think you're comparing applies with oranges here - you measured the
above function by executing it, and the reduced version by some other
method (you appear to be absolutely certain that it's 6 cycles, but
the previous was approximate).

> Now if we consider simple mutexes, the core of it becomes this on ARM:
> 
> 	mov	r0, #1
> 	swp	r1, r0, [%0]
> 	cmp	r1, #0
> 	bne	__contention
> 
> The above takes 8 cycles.  It uses 4 instructions, and it could even be 
> reduced to 3 when gcc's cse optimization can find a register that 
> already contains the value 1 (then using only 7 cycles).  It is 
> interrupt safe.  It is preemption safe.  It is small.

That's over-simplified, and is the easy bit.  Now work out how you handle
the unlock operation.

You don't know whether the lock is contended or not in the unlock path,
so you always have to do the "wake up" thing.  (You can't rely on the
value of the lock since another thread may well be between this swp
instruction and entering the __contention function.  Hence you can't
use the value of the lock to determine whether there's anyone sleeping
on it.)

Therefore, I suspect that while the lock may be faster, the unlock
won't be.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
