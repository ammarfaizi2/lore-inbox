Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTEXAkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbTEXAkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:40:18 -0400
Received: from palrel13.hp.com ([156.153.255.238]:25271 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264212AbTEXAkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:40:16 -0400
Message-ID: <75A9FEBA25015040A761C1F74975667D01442109@hplex4.hpl.hp.com>
From: "Boehm, Hans" <hans_boehm@hp.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "Boehm, Hans" <hans_boehm@hp.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
Date: Fri, 23 May 2003 17:53:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer.  In the statically linked case, I get 200/568/345
for custom/pthread_mutex/pthread_spin.

I agree that this is not a fair comparison.  That was my point.  An implementation
with custom yield/sleep
code can do things that you can't do with blocking pthreads primitives at the
same performance.  (Of course pthreads_mutex_lock will win in other cases.)

Please forget about the abort() in the contention case.  I put that there for
brevity since it is not exercised by the test.  The intent was to time the
noncontention performance of a custom lock that first spins, then yields,
and then sleeps, as was stated in the comment.

You are forgetting two issues in your analysis of what pthreads is/should be doing
relative to the spin-lock-like code:

1) The unlock code is different.  If you potentially do a waitforunlocks()
in the locking code, you need to at least check whether the corresponding
notification is necessary when you unlock().  For NPTL that requires another
atomic operation, and hence another dozen to a couple of hundred cycles,
depending on the processor.  You need to look at both the lock and unlock
code.

2) (I hadn't mentioned this before.) The (standard interpretation of)
the memory barrier semantics of the pthreads primitives is too strong.
Arguably they need to be full memory barriers in both directions.
The pthread_spin_lock code inserts an extra full
memory barrier on IA64 as a result, instead of just
using the acquire barrier associated with the cmpxchg.acq instruction. 
(I think the spin unlock code doesn't do this.  One could argue that that's a bug,
though I would argue that the bug is really  in the pthreads spec.)

Hans

> -----Original Message-----
> From: Davide Libenzi [mailto:davidel@xmailserver.org]
> Sent: Friday, May 23, 2003 5:20 PM
> To: Boehm, Hans
> Cc: 'Arjan van de Ven'; Hans Boehm; MOSBERGER, DAVID
> (HP-PaloAlto,unix3); Linux Kernel Mailing List; 
> linux-ia64@linuxia64.org
> Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
> 
> 
> On Fri, 23 May 2003, Boehm, Hans wrote:
> 
> > Pthread_spin_lock() under the NPTL version in RH9 does 
> basically what my
> > custom locks do in the uncontested case, aside from the 
> function call.
> > But remember that this began with a discussion about whether it was
> > reasonable for user locking code to explicitly yield rather 
> than relying
> > on pthreads to suspend the thread.  I don't think 
> pthread_spin_lock is
> > relevant in this context, for two reasons:
> >
> > 1) At least the RH9 version of pthread_spin_lock in NPTL 
> literally spins
> > and makes no attempt to yield or block.  This only makes 
> sense at user
> > level if you are 100% certain that the processors won't be
> > overcommitted. Otherwise there is little to be lost by 
> blocking once you
> > have spun for sufficiently long.  You could use 
> pthread_spin_trylock and
> > block explicitly, but that gets us back to custom blocking code.
> 
> Yes, that would be a spinlock. Your code was basically a spinlock that
> instead of spinning was doing abort() in contention case. Again, you
> measured two different things. Even if the pthread mutex does 
> something
> very simple like :
> 
> 	spinlock(mtx->lock);
> 	while (mtx->busy) {
> 		spinunlock(mtx->lock);
> 		waitforunlocks();
> 		spinlock(mtx->lock);
> 	}
> 	mtx->busy++;
> 	spinunlock(mtx->lock);
> 
> Only the fact that this code likely reside inside a deeper 
> call lever will
> make you pay in a tight loop like your.
> 
> 
> > 2) AFAICT, pthread_spin_lock is currently a little too 
> bleeding edge to
> > be widely used.  I tried to time it, but failed.  Pthread.h doesn't
> > include the declaration for pthread_spin_lock_t by default, 
> at least not
> > yet.  It doesn't seem to have a Linux man page, yet.  I 
> tried to define
> > the magic macro to get it declared, but that broke something else.
> 
> $ gcc -D_GNU_SOURCE ...
> 
> 
> 
> - Davide
> 
