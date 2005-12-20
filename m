Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVLTTej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVLTTej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVLTTej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:34:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22794 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751029AbVLTTei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:34:38 -0500
Date: Tue, 20 Dec 2005 19:34:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220193423.GC24199@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 10:27:12AM -0800, Linus Torvalds wrote:
> On Tue, 20 Dec 2005, Nicolas Pitre wrote:
> >
> > Sure, and we're now more costly than the current implementation with irq 
> > disabling.
> 
> Do the timing. It may be more instructions, but I think it was you 
> yourself that timed the current thing at 23 cycles, no?

That's PXA, which is Intel.  Most other ARM CPUs are far faster
than that at IRQ disable.  Typically you're looking at 6 cycles
to disable + 3 cycles to re-enable.

However, Nico's analysis of 14 instructions vs 9 instructions
pretty much paints the picture - those 14 instructions for the
preempt_disable _will_ be more heavy weight than Nico's idea.

Also, Nico has an alternative idea for mutexes which does not
involve decrementing or incrementing - it's an atomic swap.
That works out at about the same cycle count on non-Intel ARM
CPUs as the present semaphore path.  I'm willing to bet that
it will be faster than the present semaphore path on Intel ARM
CPUs.

Here's the cycle counts for ARM926, assuming hot caches and the
failure path not taken for the existing semaphore code:

mrs     ip, cpsr		2
orr     lr, ip, #128		1
msr     cpsr_c, lr		3
ldr     lr, [%0]		2
subs    lr, lr, %1		1
str     lr, [%0]		1
msr     cpsr_c, ip		3
movmi   ip, %0			1
blmi    failure			1
			total:	15 cycles

Here's nico's version (with a couple of fixes to ensure we don't
schedule if preempt count is non-zero):

        mov     r0, sp, lsr #13				1
        mov     r0, r0, lsl #13				1
        ldr     r1, [r0, #PREEMPT_COUNT]		2
        add     r2, r1, #1				1
        str     r2, [r0, #PREEMPT_COUNT]		1
        ldr     r4, [r3]				2
        sub     r4, r4, #1				1
        str     r4, [r3]				1
        str     r1, [r0, #PREEMPT_COUNT]		1
        teq     r1, #0					1
        bne     no_preempt_check			1
        ldr     r1, [r0, #FLAGS]			2
        tst     r1, #TIF_NEED_RESCHED			1
        blne    schedule				1
no_preempt_check:
        cmp     r4, #0					1
        blmi    failed					1
						total:	19 cycles

That's a 26% increase in the cost of a mutex implemented this way
over a plain semaphore.

Hence, mutexes implemented this way will be _more_ costly.
Significantly so.  Enough to make them worthless.

I think the approach needs completely rethinking.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
