Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVCQP4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVCQP4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVCQP4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:56:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261956AbVCQPzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:55:55 -0500
Date: Thu, 17 Mar 2005 10:55:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Scott Snyder <snyder@fnal.gov>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050317155539.GF853@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com> <20050317102619.GA23494@devserv.devel.redhat.com> <20050317152031.GB16743@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317152031.GB16743@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 03:20:31PM +0000, Jamie Lokier wrote:
> If you change futex_wait to be "atomic", and then have userspace locks
> which _depend_ on that atomicity, it becomes impossible to wait on
> multiple of those locks, or make poll-driven state machines which can
> wait on those locks.

The futex man pages that have been around for years (certainly since mid 2002)
certainly don't document FUTEX_WAIT as token passing operation, but as atomic
operation:

Say http://www.icewalkers.com/Linux/ManPages/futex-2.html

FUTEX_WAIT
This operation atomically verifies that  the  futex
address  still contains the value given, and sleeps
awaiting FUTEX_WAKE on this futex address.  If  the
timeout argument is non-NULL, its contents describe
the maximum duration of the wait, which is infinite
otherwise.   For futex(4), this call is executed if
decrementing the count gave a negative value (indi
cating  contention),  and  will sleep until another
process   releases  the  futex  and  executes   the
FUTEX_WAKE operation.

RETURN VALUE
FUTEX_WAIT
Returns 0 if the process was woken by a  FUTEX_WAKE
call. In case of timeout, ETIMEDOUT is returned. If
the futex was not equal to the expected value,  the
operation  returns  EWOULDBLOCK.  Signals (or other
spurious wakeups) cause FUTEX_WAIT to return EINTR.

so there very well might be programs other than glibc that
depend on this behaviour.  Given that in most cases the race
is not hit every day (after all, we have been living with it for
several years), they probably wouldn't know there is a problem
like that.

> You can do userspace threading and simulate most blocking system calls
> by making them non-blocking and using poll).

Sure, but then you need to write your own locking as well and
can just use the token passing property of futexes there.

> It's not a _huge_ loss, but considering it's only Glibc which is
> demanding this and futexes have another property, token-passing, which
> Glibc could be using instead - why not use it?

Because that requires requeue being done with the cv lock held, which
means an extra context switch.

> > @@ -265,7 +264,6 @@ static inline int get_futex_value_locked
> >  	inc_preempt_count();
> >  	ret = __copy_from_user_inatomic(dest, from, sizeof(int));
> >  	dec_preempt_count();
> > -	preempt_check_resched();
> >  
> >  	return ret ? -EFAULT : 0;
> >  }
> 
> inc_preempt_count() and dec_preempt_count() aren't needed, as
> preemption is disabled by the queue spinlocks.  So
> get_futex_value_locked isn't needed any more: with the spinlocks held,
> __get_user will do.

They aren't needed if CONFIG_PREEMPT.  But with !CONFIG_PREEMPT, they
are IMHO still needed, as spin_lock/spin_unlock call preempt_{disable,enable},
which is a nop if !CONFIG_PREEMPT.
__get_user can't be used though, it should be __get_user_inatomic
(or __copy_from_user_inatomic if the former doesn't exist).

> > [numerous instances of...]
> > +	preempt_check_resched();
> 
> Not required.  The spin unlocks will do this.

True, preempt_check_resched() is a nop if !CONFIG_PREEMPT and for
CONFIG_PREEMPT spin_unlock will handle it.  Will remove them from the
patch.

> > But with the recent changes to futex.c I think kernel can ensure
> > atomicity for free.
> 
> I agree it would probably not slow the kernel, but I would _strongly_
> prefer that Glibc were fixed to use the token-passing property, if
> Glibc is the driving intention behind this patch - instead of this
> becoming a semantic that application-level users of futex (like
> database and IPC libraries) come to depend on and which can't be
> decomposed into a multiple-waiting form.
> 
> (I admit that the kernel code does look nicer with
> get_futex_value_locked gone, though).
> 
> By the way, do you know of Scott Snyder's recent work on fixing Glibc
> in this way?  He bumped into one of Glibc's currently broken corner
> cases, fixed it (according to the algorithm I gave in November), and
> reported that it works fine with the fix.

I certainly haven't seen his patch.

	Jakub
