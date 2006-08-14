Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWHNU3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWHNU3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWHNU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:29:54 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:64731 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S932724AbWHNU3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:29:54 -0400
Date: Mon, 14 Aug 2006 22:29:41 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup and remove some extra spinlocks from rtmutex
In-Reply-To: <20060813190326.GA2276@oleg>
Message-ID: <Pine.LNX.4.64.0608142217400.10597@frodo.shire>
References: <1154439588.25445.31.camel@localhost.localdomain>
 <20060813190326.GA2276@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Aug 2006, Oleg Nesterov wrote:

> Another question: why should we take ->pi_lock to modify rt_mutex's
> ->wait_list?
> It looks confusing and unneeded to me, because we already
> hold ->wait_lock. For example, wakeup_next_waiter() takes current's
> ->pi_lock before plist_del(), which seems to be completely offtopic,
> since current->pi_blocked_on has nothing to do with that rt_mutex.
>
> Note also that ->pi_blocked_on is always modified while also holding
> ->pi_blocked_on->lock->wait_lock, and things like rt_mutex_top_waiter()
> need ->wait_lock too, so I don't think we need ->pi_lock for ->wait_list.
>

Yes, that was the basic design:

lock->wait_list and related waiter->list_entry is protected by 
lock->wait_lock, while task->pi_waiters and related waiter->pi_list_entry.


> In other words, could you please explain to me whether the patch below
> correct or not?
>

Well, we are talking about small optimizations now, moving only a few 
instructions outside the lock. Except for one of them it is correct, but 
it is worth risking stability for now?

> Thanks,
>
> Oleg.
>
> --- 2.6.18-rc3/kernel/rtmutex.c~2_rtm	2006-08-13 19:07:45.000000000 +0400
> +++ 2.6.18-rc3/kernel/rtmutex.c	2006-08-13 22:09:45.000000000 +0400
> @@ -236,6 +236,10 @@ static int rt_mutex_adjust_prio_chain(st
> 		goto out_unlock_pi;
> 	}
>
> +	/* Release the task */
> +	spin_unlock_irqrestore(&task->pi_lock, flags);
> +	put_task_struct(task);
> +

So you want the task to go away here and use it below?

> 	top_waiter = rt_mutex_top_waiter(lock);
>
> 	/* Requeue the waiter */
> @@ -243,10 +247,6 @@ static int rt_mutex_adjust_prio_chain(st
> 	waiter->list_entry.prio = task->prio;
> 	plist_add(&waiter->list_entry, &lock->wait_list);
>
> -	/* Release the task */
> -	spin_unlock_irqrestore(&task->pi_lock, flags);
> -	put_task_struct(task);
> -

No! It is used in the line just above, so we better be sure it still 
exists!

> 	/* Grab the next task */
> 	task = rt_mutex_owner(lock);
> 	get_task_struct(task);
> @@ -416,15 +416,15 @@ static int task_blocks_on_rt_mutex(struc
> 	plist_node_init(&waiter->list_entry, current->prio);
> 	plist_node_init(&waiter->pi_list_entry, current->prio);
>
> +	current->pi_blocked_on = waiter;
> +
> +	spin_unlock_irqrestore(&current->pi_lock, flags);
> +
> 	/* Get the top priority waiter on the lock */
> 	if (rt_mutex_has_waiters(lock))
> 		top_waiter = rt_mutex_top_waiter(lock);
> 	plist_add(&waiter->list_entry, &lock->wait_list);
>
> -	current->pi_blocked_on = waiter;
> -
> -	spin_unlock_irqrestore(&current->pi_lock, flags);
> -

Ok, this change might work out.

> 	if (waiter == rt_mutex_top_waiter(lock)) {
> 		spin_lock_irqsave(&owner->pi_lock, flags);
> 		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
> @@ -472,11 +472,10 @@ static void wakeup_next_waiter(struct rt
> 	struct task_struct *pendowner;
> 	unsigned long flags;
>
> -	spin_lock_irqsave(&current->pi_lock, flags);
> -
> 	waiter = rt_mutex_top_waiter(lock);
> 	plist_del(&waiter->list_entry, &lock->wait_list);
>
> +	spin_lock_irqsave(&current->pi_lock, flags);

This might be ok, too...

> 	/*
> 	 * Remove it from current->pi_waiters. We do not adjust a
> 	 * possible priority boost right now. We execute wakeup in the
> @@ -530,8 +529,9 @@ static void remove_waiter(struct rt_mute
> 	unsigned long flags;
> 	int chain_walk = 0;
>
> -	spin_lock_irqsave(&current->pi_lock, flags);
> 	plist_del(&waiter->list_entry, &lock->wait_list);
> +
> +	spin_lock_irqsave(&current->pi_lock, flags);
> 	waiter->task = NULL;
> 	current->pi_blocked_on = NULL;
> 	spin_unlock_irqrestore(&current->pi_lock, flags);
>
And ok.
