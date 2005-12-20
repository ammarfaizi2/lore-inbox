Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVLTGaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVLTGaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 01:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVLTGaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 01:30:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13873 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750810AbVLTGaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 01:30:15 -0500
Date: Tue, 20 Dec 2005 01:30:14 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <20051220043109.GC32039@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Ingo Molnar wrote:

> 
> * David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
> > > Hi Ingo,
> > >         Doesn't this corrupt caller saved registers?
> > 
> > Looks like it. I _really_ don't like calling functions from inline 
> > asm. It's not nice. Can't we use atomic_dec_return() for this?
> 
> we can use atomic_dec_return(), but that will add one more instruction 
> to the fastpath. OTOH, atomic_dec_return() is available on every 
> architecture, so it's a really tempting thing. I'll experiment with it.

Please consider using (a variant of) xchg() instead.  Although 
atomic_dec() is available on all architectures, its implementation is 
far from being the most efficient thing to do for them all.  For 
example, see my discussion about swp on ARM:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0512.2/0727.html

What would be the most efficient implementation on ARM might look like:

static inline void mutex_lock(struct mutex *m)
{
        if (unlikely(atomic_xchg(&m->count, 0) != 1))
                __mutex_lock_nonatomic(m);
}

static inline void mutex_unlock(struct mutex *m)
{
	if (unlikely(atomic_xchg(&m->count, 1) == -1))
		__mutex_unlock_nonatomic(m);
}

Yet we might want to use special wrappers with non-standard calling 
convention for getting to the contention handlers 
(__mutex_lock_nonatomic() and __mutex_unlock_nonatomic() in this case).

Furthermore trying to make atomic_inc_call_if_nonpositive() looks like a 
generic thing is rather counter productive.  It is likely to be useful 
to the mutex code only anyway, so why not make it implicit what the 
contention handlers are?  This will allow for each architectures to 
implement the mutex interface with the best fast path they can come 
with.

I'd propose this:

First, rename some functions to make it clearer what they are used for:

	s/__mutex_lock_nonatomic/__mutex_lock_contended/
	s/__mutex_unlock_nonatomic/__mutex_unlock_contended/

Next, please make it possible for architecture specific implementation 
of mutex_lock(), mutex_unlock(), mutex_trylock(), and so on to exist.  
A default implementation in include/asm-generic/mutex.h should probably 
exist and the two examples above is certainly a good start.

mutex_lock should have the following definition: it should try to lock 
the mutex (set the count to 0, or any value < 1).  If the count was 1 
prior setting it to 0 then the lock is successful and we're done.  
Otherwise it should call __mutex_lock_contended.  Knowing the previous 
value and setting the new value must be done atomically. Whether it uses 
atomic_xchg() or atomic_dec_return(), or even open code some clever 
assembly trick to achieve that like your i386 
atomic_dec_call_if_negative() implementation is the architecture's own 
business.  I can imagine the ARM implementation which inlined fast path 
would be between 3 and 4 instructions only.  But that's possible only if 
the implementation allows any flexibility in achieving the above.

Similarly, mutex_unlock should set the mutex count to 1.  It also should 
call __mutex_unlock_contended if the count wasn't 0 before.  And again 
the atomic nature of the count (which might be renamed to "state" since 
"count" is misleading for a mutex) must be preserved of course.  Again 
the architecture is free to implement it in whatever way as long as it 
has this behavior.

The main header file for mutex users would be include/linux/mutex.h.  
If mutex debugging is enabled, then architecture fast path is ignored so 
mutex(lock() would simply become an alias for __mutex_lock_contended() 
or whatever wrapper you have for that purpose.  If debugging is disabled 
only then is asm/mutex.h included from linux/mutex.h to get the 
architecture fast path code (which is possibly including 
asm-generic/mutex.h with reasonnable reference/default implementations).

What do you think?


Nicolas
