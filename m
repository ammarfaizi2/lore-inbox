Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVLVGvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVLVGvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLVGvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:51:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30417 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965050AbVLVGu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:50:59 -0500
Date: Thu, 22 Dec 2005 01:50:56 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/3] mutex subsystem: move the core to the new atomic
 helpers
In-reply-to: <20051221231218.GA6747@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512220023060.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
 <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
 <20051221231218.GA6747@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > This patch moves the core mutex code over to the atomic helpers from 
> > previous patch.  There is no change for i386 and x86_64, except for 
> > the forced unlock state that is now done outside the spinlock (doing 
> > so doesn't matter since another CPU could have locked the mutex right 
> > away even if it was unlocked inside the spinlock).  This however 
> > brings great improvements on ARM for example.
> 
> i'm wondering how much difference it makes on ARM - could you show us 
> the before and after disassembly of the fastpath, to see the 
> improvement?

The only way to do an atomic decrement on 99% of all ARM processors in 
the field requires disabling interrupts.  So for instance:

void __mutex_lock(struct mutex *lock)
{
	if (atomic_dec_return(&lock->count) < 0)
		__mutex_lock_failed(lock);
}

Would produce:

__mutex_lock_atomic:
	mrs	r1, cpsr		@ local_irq_save
	orr	r3, r1, #128
	msr	cpsr_c, r3
	ldr	r3, [r0, #0]
	sub	r3, r3, #1
	str	r3, [r0, #0]
	msr	cpsr_c, r1		@ local_irq_restore
	cmp	r3, #0
	movge	pc, lr
	b	__mutex_lock_failed

I can measure 23 cycles on an XScale processor for the first 8 
instructions which corresponds to the "if (atomic_dec_return(v) < 0)".

It was suggested that a preempt_disable()/preempt_enable() would be 
sufficient and probably faster than the IRQ disable... which turned not 
to be true for non-XScale ARM variants.  It would take 14 instructions 
on all variants, and on XScale it needs 20 cycles.

Now with my patch applied, it looks like this:

void __mutex_lock(struct mutex *lock)
{
	if (atomic_xchg(&lock->count, 0) != 1)
		__mutex_lock_failed(lock);
}

with the following assembly:

__mutex_lock_atomic:
	mov	r3, #0
	swp	r2, r3, [r0]
	cmp	r2, #1
	moveq	pc, lr
	b	__mutex_lock_failed

The equivalent of the first 8 instructions in the first example is now 
down to 3.  And when gcc can cse the constant 0 (which is not 
possible with the first example) then it would be only 2 instructions, 
which is really nice to inline.  And the above takes only 8 cycles on an 
XScale instead of 20-23 cycles.

> your patches look OK to me, only one small detail sticks out: i'd 
> suggest to rename the atomic_*_contended macros to be arch_mutex_*_..., 
> i dont think any other code can make use of it.

OK.

> Also, it would be nice 
> to see the actual ARM patches as well, which make use of the new 
> infrastructure.

Well, with the generic functions based on atomic_xchg() the generated 
code is pretty good actually.  I don't think I could pack it more with a 
special handler.  Well for ARM version 6 I have a kunning idea though... 
maybe for tomorrow.

> could you resend them against my latest queue that i just posted? I'll 
> look at integrating them tomorrow.

Yes, please find them in following emails.


Nicolas
