Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWHAUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWHAUYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWHAUYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:24:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65004 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161035AbWHAUYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:24:21 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [-rt] Fix race condition and following BUG in PI-futex
Date: Tue, 1 Aug 2006 13:22:52 -0700
User-Agent: KMail/1.9.1
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain> <1154456580.25983.25.camel@localhost.localdomain>
In-Reply-To: <1154456580.25983.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011322.53638.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 11:23, you wrote:
> On Tue, 2006-08-01 at 19:46 +0100, Esben Nielsen wrote:
> > I ran into the bug on 2.6.17-rt8 with the previous posted patches which
> > make pthread_timed_lock() work on UP, but the bug is there without the
> > patches - I just can't trigger it - and it is also in the mainline
> > kernel.
> >
> > The problem is that rt_mutex_next_owner() is used unprotected in
> > wake_futex_pi(). At least it isn't probably serialiazed against the next
> > owner being signalled or getting a timeout. The only lock, which is
> > good enough here, is &pi_state->pi_mutex.wait_lock, so I added this
> > protection.
> >
> > Esben
> >
> >   kernel/futex.c |   12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6.17-rt8/kernel/futex.c
> > ===================================================================
> > --- linux-2.6.17-rt8.orig/kernel/futex.c
> > +++ linux-2.6.17-rt8/kernel/futex.c
> > @@ -565,6 +565,7 @@ static int wake_futex_pi(u32 __user *uad
> >   	if (!pi_state)
> >   		return -EINVAL;
> >
> > +	spin_lock(&pi_state->pi_mutex.wait_lock);
> >   	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
> >
> >   	/*
> > @@ -590,15 +591,22 @@ static int wake_futex_pi(u32 __user *uad
> >   	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
> >   	dec_preempt_count();
> >
> > -	if (curval == -EFAULT)
> > +	if (curval == -EFAULT) {
> > +		spin_unlock(&pi_state->pi_mutex.wait_lock);
> >   		return -EFAULT;
> > -	if (curval != uval)
> > +	}
> > +	if (curval != uval) {
> > +		spin_unlock(&pi_state->pi_mutex.wait_lock);
> >   		return -EINVAL;
> > +	}
> >
> >   	list_del_init(&pi_state->owner->pi_state_list);
> >   	list_add(&pi_state->list, &new_owner->pi_state_list);
> >   	pi_state->owner = new_owner;
> > +	atomic_inc(&pi_state->refcount);
>
> There really needs to be a get_pi_state() or some variant. Having to do
> a manual atomic_inc is very dangerous.

I understand the need to grab the wait_lock in order to serialize 
rt_mutex_next_owner(), but why the addition of of the atomic_inc() and the 
free_pi_state() ?  And if we do need them, shouldn't we place them around the 
use of the pi_state, rather than just before the unlock calls?

>
> > +	spin_unlock(&pi_state->pi_mutex.wait_lock);
> >   	rt_mutex_unlock(&pi_state->pi_mutex);
> > +	free_pi_state(pi_state);
>
> And to stay in line with the kernel, perhaps we should rename this to
> put_pi_state.  We aren't freeing it if there's still references to it.
>
> -- Steve
>
> >   	return 0;
> >   }
>

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
