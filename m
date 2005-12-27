Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVL0V7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVL0V7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVL0V7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:59:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43160 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932368AbVL0V7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:59:21 -0500
Date: Tue, 27 Dec 2005 16:59:20 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
In-reply-to: <20051227115525.GC23587@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
 <20051227115525.GC23587@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > Some architectures, notably ARM for instance, might benefit from 
> > inlining the mutex fast paths. [...]
> 
> what is the effect on text size? Could you post the before- and 
> after-patch vmlinux 'size kernel/test.o' output in the nondebug case, 
> with Arjan's latest 'convert a couple of semaphore users to mutexes' 
> patch applied? [make sure you've got enough of those users compiled in, 
> so that the inlining cost is truly measured. Perhaps also do 
> before/after 'size' output of a few affected .o files, without mixing 
> kernel/mutex.o into it, like vmlinux does.]

Theory should be convincing enough.  First of all, all the semaphore 
fast paths are always inlined currently, on all architectures I've 
looked at.  A down() fast path is always looking like this:

        mrs     ip, cpsr
        orr     lr, ip, #128
        msr     cpsr_c, lr
        ldr     lr, [r0]
        subs    lr, lr, #1
        str     lr, [r0]
        msr     cpsr_c, ip
        movmi   ip, r0
        blmi    __down_failed

So our starting point for comparison is 9 instructions for every down() 
occurence in the kernel.  Same thing for up().  Every instruction is 
invariably 4 bytes.

Now let's look at the typical mutex_lock():

        mov     r4, #0
        swp     r3, r4, [r0]
        cmp     r3, #1
        blne      __mutex_lock_noinline

This is 4 instructions.  Further more, the first "mov r4, #0" can often 
be eliminated when gcc can cse the constant 0 from another 
register.  We're talking about 3 instructions then, down from 9 !

We therefore saves between 20 and 24 bytes of kernel .text for every 
down() and every up() simply going with mutexes.

Now if the mutex_lock and mutex_unlock were not inlined, the above 3 or 
4 instructions would become one or two per call site, which is still a 
gain in space, however not as important as the one provided by the move 
from semaphores to mutexes.  It however would be more costly in terms of 
cycles since a function prologue and epilogue is somewhat costly on ARM, 
especially with frame pointer enabled (I'll let RMK elaborate on his 
reasons for not disabling them).

And for mutex_lock_interruptible(), the inlined fastpath is not bigger 
than the non-inlined one, considering that the return value has to be 
tested (the test is done twice in the non-inlined case: once inside the 
function, and once outside of it) while the inlined version needs only 
one test.  They are therefore equivalent in terms of space.


Nicolas
