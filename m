Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVL0UrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVL0UrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 15:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVL0UrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 15:47:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32545 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751140AbVL0UrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 15:47:23 -0500
Date: Tue, 27 Dec 2005 15:47:18 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <20051227115129.GB23587@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <20051227115129.GB23587@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > In the spirit of uniformity, this patch provides architecture specific 
> > trylock implementations.  This allows for a pure xchg-based 
> > implementation, as well as an optimized ARMv6 implementation.
> 
> hm, i dont really like the xchg variant:
> 
> > +static inline int
> > +__mutex_trylock(atomic_t *count)
> > +{
> > +	int prev = atomic_xchg(count, 0);
> > +
> > +	if (unlikely(prev < 0)) {
> > +		/*
> > +		 * The lock was marked contended so we must restore that
> > +		 * state. If while doing so we get back a prev value of 1
> > +		 * then we just own it.
> > +		 *
> > +		 * IN all cases this has the potential to trigger the
> > +		 * slowpath for the owner's unlock path - but this is not
> > +		 * a big problem in practice.
> > +		 */
> > +		prev = atomic_xchg(count, -1);
> > +		if (prev < 0)
> > +			prev = 0;
> > +	}
> 
> here we go to great trouble trying to avoid the 'slowpath', while we 
> unconditionally force the next unlock into the slowpath! So we have not 
> won anything. (on a cycle count basis it's probably even a net loss)

I disagree.  There is no unconditional forcing into the slow path 
at all. Please consider again.

1) We try to lock with 0.
   If the previous value was 1 (likely) or 0 (less likely) we return
   that value right away.  We therefore cover 2 out of 3 cases already 
   with no more instructions or cycles than the successful fastpath 
   lock. Note the if (unlikely(prev < 0)) above that handles those two 
   cases with one test, and if it gets inlined then the outer code 
   testing for the return value would rely on the same test to decide 
   what to do since the condition flags are already set (gcc apparently 
   gets it right on ARM at least). This is the likely case solved.

2) If the previous value wasn't 1 nor 0 it is therefore contended 
   already.  We agree that the "already locked with contention" is the 
   less likely of all 3 cases, right?  So it is already unlikely 
   that this case will be considered. Still, since in this case we changed
   the lock from contended to simply locked, we have to 
   mark it contended again otherwise we risk missing on waking up 
   waiters.  But if by chance, and you'd have to be extremely lucky 
   since the window is really small, if by chance the value changed from 
   0 to 1 (remember we set it to 0 above) before we swap it back to -1 
   then we simply own the lock.  If it was still 0 then we simply set it 
   back to contended as it was previously.  And if it became -1 then we 
   didn't change anything by setting it to -1. But in all cases (whether 
   the owner unlocked it (from 0 to 1), or even someone else came along 
   to lock it (from 0 to 1 to 0), we know that there is/are sleeping 
   waiters that the previous owner failed to wake up because we made the
   value 0 for a while.  So whether we are the new owner, or someone else is, 
   there is still the need for waking up a waiter upon unlock 
   regardless.

So, as you can see, my xchg-based trylock doesn't force anything in 
99.999% of the cases.  The only possibility for a false contention state 
would involve:

 - process A locking the mutex (set to 0)

 - process B locking the mutex and failing (now set to -1)

 - process C attempting a trylock (new 0, prev = -1)

 - process A unlocking (from 0 to 1 -> no waking process B)

 - process D locking (from 1 to 0)

 - process E locking and failing (from 0 to -1)

 - process D unlocking (it is -1 so wake up process B, leave it to -1)

 - process B unlocking (it is -1 so wake up process E, set to 0)

 - process E unlock (from 0 to 1)

 - process C, midway into trylock, restore contention flag (from 1 to -1)

 - when process C unlocks, it branches to the slow path needlessly.

Do you really think we should care about such a twisted scenario?

> The same applies to atomic_dec_return() based trylock variant. Only the 
> cmpxchg based one, and the optimized ARM variant should be used as a 
> 'fastpath'.

On ARM prior version 6 a cmpxchg is what we need to avoid as much as 
possible, for the same reason I've been advocating for xchg.  On ARM 
prior version 6 trying to perform a cmpxchg is as costly as an 
atomic_dec, and they are both more costly and bigger than my xchg-based 
trylock algorithm.  And contrary to the atomic_dec-based trylock, the 
xchg-based one does not unconditionally force any unlock into the slow 
path.



 avoidance with mutexes.

> Furthermore, both the mutex-xchg.h and the mutex-dec.h non-cmpxchg 
> variant will fall back to the spinlock implementation.

Given the above demonstration I really think you should use my 
xchg-based trylock in mutex-xchg.h.  At least on ARM it is _still_ 
cheaper and smaller than a preemption disable implied by a spinlock.


Nicolas
