Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVLREHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVLREHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 23:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVLREHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 23:07:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15692 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965002AbVLREHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 23:07:51 -0500
Date: Sat, 17 Dec 2005 23:07:49 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2005, Linus Torvalds wrote:

> On Sat, 17 Dec 2005, Nicolas Pitre wrote:
> > 
> > Well, if you really want to be honest, you have to consider that the 
> > ldrex/strex instructions are available only on ARM architecture level 6 
> > and above, or in other words with only about 1% of all ARM deployments 
> > out there.  The other 99% of actual ARM processors in the field only 
> > have the atomic swap (swp) instruction which is insufficient for 
> > implementing a counting semaphore (we therefore have to disable 
> > interrupts, do the semaphore update and enable interrupts again which is 
> > much slower than a swp-based mutex).
> 
> Ehh.. Have you seen any SMP arm machines with the old ones?

No.  I never saw any SMP on ARM yet.  About only RMK did.

> As far as I can tell from the Linux arm assembly (which I admittedly don't 
> read very well at all), the non-ARMv6 semaphore code just disables 
> interrupts and does the semaphore without any atomic instructions at all. 

Exact, and that's because on pre-ARMv6 you have UP only, and the only 
atomic instruction on pre-ARMv6 is the swp instruction which doesn't cut 
it for semaphores.

> Which is fine for UP (in fact, I'm not even convinced you need to disable 
> interrupts, since any interrupts - even if they do a "trylock+up" - should 
> always leave the counter in the same state it was before).

I don't think I follow you here.  The down() implementation goes like 
this:

	1) disable interrupts
	2) load semaphore count into register
	3) decrement register value (remember if it goes negative)
	4) store register value to semaphore count location
	5) enable interrupts
	6) if the count went negative go to sleep

The up() goes like this:

	1) disable interrupts
	2) load semaphore count into register
	3) increment register value (remember if it remains < 1)
	4) store register value to semaphore count location
	5) enable interrupts
	6) if the sem count is still < 1 then wake up someone

Now if you don't disable interrupts then nothing prevents an interrupt 
handler, or another thread if kernel preemption is allowed, to come 
along right between (2) and (4) to call up() or down() which will 
make the sem count inconsistent as soon as the interrupted down() or 
up() is resumed.

> So afaik, Linux simply doesn't support pre-ARMv6 in SMP configurations, 
> and never has (and I'd assume never will).

Indeed.

> Or am I missing something?

I understand this thread is about simple mutex (locked/unlocked) vs full 
counting semaphores.  And I'm presuming that we still care about best 
performances with pre-ARMv6 support, maybe even more than ARMv6 and 
above given the current deployment figures using Linux.

In that case, a simple mutex_lock implementation on pre-ARMv6 would look 
like this:

__lock:
	mov	r1, #1			@ 1 = lock flag
	swp	r2, r1, [r0]		@ lock the mutex, get current state
	cmp	r2, #0			@ was it unlocked?
	beq	__continue		@ if so we're done
	mov	r1, #2			@ 2 = contended lock
	swp	r2, r1, [r0]		@ upgrade the lock to contended
	cmp	r2, #0			@ was it unlocked in the mean time?
	beq	__continue		@ if so we just acquired the lock
	bl	__sleep			@ go to sleep
	b	__lock
__continue:

Here you can even have the 4 first instructions inline for the fast 
uncontended case and the rest out of line, making it much smaller than 
the counting semaphore implementation with the same inline property.

And for completeness, here's the mutex_unlock:

__unlock:
	mov	r1, #0			@ 0 = unlocked
	swp	r2, r1, [r0]		@ unlock mutex, get current state
	cmp	r2, #2			@ was it contended?
	bleq	__wake			@ if so call wake_up

And the mutex_trylock is trivial as well.

That's it.  4 inline instructions for locking, 4 inline instructions for 
unlocking, no disabling/enabling of interrupts needed any more.


Nicolas
