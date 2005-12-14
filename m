Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVLNLq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVLNLq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLNLq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:46:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932453AbVLNLqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:46:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439FFF63.6020105@yahoo.com.au> 
References: <439FFF63.6020105@yahoo.com.au>  <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 14 Dec 2005 11:46:07 +0000
Message-ID: <15157.1134560767@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >  (1) If it's using spinlocks, then it's pointless to use atomic_cmpxchg.
> > 
> 
> Why?

Because you're going to end up with loops around the cmpxchg bit in certain
places, and if you do, then you've effectively got this:

	spin_lock_irqsave(mutexlock, flags);
	do {
		new = calc_state(orig, oldstate);
		spin_lock_irqsave(atomiclock, flags2);
		oldstate = __cmpxchg(&mutex->count, orig, new)
		spin_unlock_irqrestore(atomiclock, flags2);
	} while (oldstate != orig);
	spin_unlock_irqrestore(mutexlock, flags);

which is very bad. You _should_ have:

	spin_lock_irqsave(mutexlock, flags);
	oldstate = mutex->count;
	mutex->count = modify_state(mutex->count);
	spin_unlock_irqrestore(mutexlock, flags);

instead.

No. If you have XCHG/TAS/BSET/SWAP, but not CMPXCHG/CAS then you can do a lot
better by not pretending that cmpxchg exists. That way the fast paths don't
have to take any spinlocks at all.

And if you've got LLD/SCD or LDARX/STDCX or similar then you can probably do
better than CMPXCHG also.

If you want an illustration, then consider this:

	#define __mutex_trylock(mutex)					\
	({								\
		int oldstate;						\
									\
		asm volatile("swap%I0 %M0,%1"				\
			     : "+m"(mutex->state), "=r"(oldstate)	\
			     : "1"(1)					\
			     : "memory");				\
									\
		oldstate == 0;						\
	})

	static inline int down_trylock(struct mutex *mutex)
	{
		if (likely(__mutex_trylock(mutex))) {
			/* success */
			return 0;
		}

		/* failure */
		return 1;
	}

	void fastcall __sched down(struct mutex *mutex)
	{
		if (down_trylock(mutex) == 1)
			__down(mutex);
	}

	EXPORT_SYMBOL(down);

On FRV, this can be made to map to:

	setlos	0x1,gr4
	ori	gr4,0,gr5
	swap	@(gr8,gr0),gr5
	subicc	gr5,0,gr0,icc0
	beqlr	icc0,0x2	<-- probable-rated conditional return
	sethi.p	0xc01c,gr14
	setlo	0x9df0,gr14
	jmpl	@(gr14,gr0)

That's an out-of-line fast path of _5_ instructions. Attempting to emulate
CMPXCHG requires a lot more. On FRV, the case is alleviated somewhat since it
doesn't yet provide spinlocks and support SMP, but you'd be very hard pressed
to squeeze it down to just five instructions.

> >  (2) atomic_t is a 32-bit type, and on a 64-bit platform I will want a
> >      64-bit type so that I can stick the owner address in there (I've got
> >      a second variant not yet released).
> > 
> 
> I'm sure you could use a seperate field as it would be a debug
> option, right?

True. Ingo suggested this, and it seems reasonable. OTOH, shrinking the count
by 4 bytes would allow the whole structure to shrink by 8 on a 64-bit platform
with a 4-byte spinlock, which would be even better.

> But atomic longs are coming along and it is probably feasable to
> do 64-bit atomic_cmpxchg on all 64-bit word architectures if you
> really needed that.

That would be fine; except they don't yet exist. The way I'd do it is to
provide a default __mutex_cmpxchg() that the arch can override if it wants to.

> Send instant messages to your online friends http://au.messenger.yahoo.com 

No thanks.

David
