Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWHASXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWHASXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWHASXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:23:12 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:43673 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751768AbWHASXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:23:10 -0400
Subject: Re: [-rt] Fix race condition and following BUG in PI-futex
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain>
References: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:23:00 -0400
Message-Id: <1154456580.25983.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 19:46 +0100, Esben Nielsen wrote:
> I ran into the bug on 2.6.17-rt8 with the previous posted patches which 
> make pthread_timed_lock() work on UP, but the bug is there without the 
> patches - I just can't trigger it - and it is also in the mainline kernel.
> 
> The problem is that rt_mutex_next_owner() is used unprotected in 
> wake_futex_pi(). At least it isn't probably serialiazed against the next 
> owner being signalled or getting a timeout. The only lock, which is 
> good enough here, is &pi_state->pi_mutex.wait_lock, so I added this 
> protection.
> 
> Esben
> 
>   kernel/futex.c |   12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.17-rt8/kernel/futex.c
> ===================================================================
> --- linux-2.6.17-rt8.orig/kernel/futex.c
> +++ linux-2.6.17-rt8/kernel/futex.c
> @@ -565,6 +565,7 @@ static int wake_futex_pi(u32 __user *uad
>   	if (!pi_state)
>   		return -EINVAL;
> 
> +	spin_lock(&pi_state->pi_mutex.wait_lock);
>   	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
> 
>   	/*
> @@ -590,15 +591,22 @@ static int wake_futex_pi(u32 __user *uad
>   	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
>   	dec_preempt_count();
> 
> -	if (curval == -EFAULT)
> +	if (curval == -EFAULT) {
> +		spin_unlock(&pi_state->pi_mutex.wait_lock);
>   		return -EFAULT;
> -	if (curval != uval)
> +	}
> +	if (curval != uval) {
> +		spin_unlock(&pi_state->pi_mutex.wait_lock);
>   		return -EINVAL;
> +	}
> 
>   	list_del_init(&pi_state->owner->pi_state_list);
>   	list_add(&pi_state->list, &new_owner->pi_state_list);
>   	pi_state->owner = new_owner;
> +	atomic_inc(&pi_state->refcount);

There really needs to be a get_pi_state() or some variant. Having to do
a manual atomic_inc is very dangerous.

> +	spin_unlock(&pi_state->pi_mutex.wait_lock);
>   	rt_mutex_unlock(&pi_state->pi_mutex);
> +	free_pi_state(pi_state);

And to stay in line with the kernel, perhaps we should rename this to
put_pi_state.  We aren't freeing it if there's still references to it.

-- Steve

> 
>   	return 0;
>   }

