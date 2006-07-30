Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWG3WXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWG3WXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWG3WXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:23:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:31975 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932467AbWG3WXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:23:53 -0400
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060730043605.GA2894@oleg>
References: <20060730043605.GA2894@oleg>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 18:23:38 -0400
Message-Id: <1154298218.10074.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 08:36 +0400, Oleg Nesterov wrote:
> I am trying to get some understanding of rt_mutex, but I'm afraid it's
> not possible without your help...

Well, I'll give it a try :)

> 
> // runs on CPU 0
> rt_mutex_slowlock:
> 
> 	// main loop
> 	for (;;) {
> 		...
> 
> 			if (timeout && !timeout->task) {
> 				ret = -ETIMEDOUT;
> 				break;
> 			}
> 
> 		...
> 
> 		schedule();
> 
> 		...
> 
> 		set_current_state(state);
> 	}
> 
> What if timeout->timer is fired on CPU 1 right before set_current_state() ?
> 
> hrtimer_wakeup() does:
> 
> 	timeout->task = NULL;		<----- [1]
> 
> 	spin_lock(runqueues->lock);
> 
> 	task->state = TASK_RUNNING;	<----- [2]
> 
> (task->array != NULL, so try_to_wake_up() just goes to out_running)
> 
> If my understanding correct, [1] may slip into the critical section (because
> spin_lock() is not a wmb), so that CPU 0 will see [2] but not [1]. In that
> case rt_mutex_slowlock() can miss the timeout (set_current_state()->mb()
> doesn't help).

Hmm, that spin_lock and task->state = TASK_RUNNING is in try_to_wake_up,
and at the bottom too.  I don't think there's a CPU that will slip a
write after a call to a function and several branches.  I guess it could
happen. I'm not an expert here. We're only dealing with SMP issues here,
and not worried about PCI bus write outs or anything else.

Does anyone know of a SMP machine that could have a CPU do a write to
memory and postpone it till after several branches?


> 
> Of course, this race (even _if_ I am right) is pure theoretical, but probably
> we need smp_wmb() after [1] in hrtimer_wakeup().

Theoretically, you may be right, and I'm not sure how much a smp_wmb
would hurt to prevent a theoretical problem.

> 
> Note that do_nanosleep() is ok, hrtimer_base->lock provides a necessary
> serialization. In fact, I think it can use __set_current_state(), because
> both hrtimer_start() and run_hrtimer_queue() do lock/unlock of base->lock.
> 

Hmm, that's probably true too.  But this really is a micro-optimization,
since do_nanosleep isn't called that often (it's a syscall and not
called at every schedule or interrupt).

> 
> 
> Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
> owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
> bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
> we drop ->wait_lock.

That's probably true that the owner can't disappear before we let go of
the wait_lock, since the owner should not be disappearing while holding
locks.  But you are missing the point to why we are grabbing the
pi_lock.  We are preventing a race that can have us do unneeded work
(see below).


>  I think we can drop owner->pi_lock right after
> __rt_mutex_adjust_prio(owner), we can't miss owner->pi_blocked_on != NULL
> if it was true before we take owner->pi_lock, and this is the case we should
> worry about, yes?
> 
> In other words (because I myself can't parse the paragraph above :), could
> you explain me why this patch is not correct:
> 
> --- rtmutex.c~	2006-07-30 05:15:38.000000000 +0400
> +++ rtmutex.c	2006-07-30 05:41:44.000000000 +0400
> @@ -407,7 +407,7 @@ static int task_blocks_on_rt_mutex(struc
>  	struct task_struct *owner = rt_mutex_owner(lock);
>  	struct rt_mutex_waiter *top_waiter = waiter;
>  	unsigned long flags;
> -	int boost = 0, res;
> +	int res;
>  
>  	spin_lock_irqsave(&current->pi_lock, flags);
>  	__rt_mutex_adjust_prio(current);
> @@ -431,24 +431,20 @@ static int task_blocks_on_rt_mutex(struc
>  		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
>  
>  		__rt_mutex_adjust_prio(owner);
> -		if (owner->pi_blocked_on) {
> -			boost = 1;
> -			/* gets dropped in rt_mutex_adjust_prio_chain()! */
> -			get_task_struct(owner);
> -		}
>  		spin_unlock_irqrestore(&owner->pi_lock, flags);
> +
> +		if (owner->pi_blocked_on)
> +			goto boost;

OK, this is a little complicated. We might have just upped the owner's
prio with the __rt_mutex_adjust_prio(owner).  Now we want to know if the
owner is blocked on a lock or not.  If it isn't at this moment, we don't
want to add the extra time in calling the rt_mutex_adjust_prio_chain.
If we do the owner->pi_blocked_on test after letting go of the
owner->pi_lock, the owner could than become blocked on a lock.

This isn't a bug in logic, that is, it doesn't break the code, but since
the owner already has been boosted, when it blocks it will do the work
of rt_mutex_adjust_prio_chain too.  So we run the risk of calling
rt_mutex_adjust_prio_chain when we really didn't need to because the
owner already had it's prio boosted when it blocked.

Make sense?


>  	}
>  	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
> -		spin_lock_irqsave(&owner->pi_lock, flags);
> -		if (owner->pi_blocked_on) {
> -			boost = 1;
> -			/* gets dropped in rt_mutex_adjust_prio_chain()! */
> -			get_task_struct(owner);
> -		}
> -		spin_unlock_irqrestore(&owner->pi_lock, flags);
> +		if (owner->pi_blocked_on)
> +			goto boost;
>  	}
> -	if (!boost)
> -		return 0;
> +
> +	return 0;
> +boost:
> +	/* gets dropped in rt_mutex_adjust_prio_chain()! */
> +	get_task_struct(owner);

So the protection was probably more on that boost = 1 and if we _are_
going to boost then we should grab the lock.  But, I think you are right
that the get_task_struct is already protected by the wait_lock so
perhaps this patch would work:




Index: linux-2.6.18-rc2/kernel/rtmutex.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-07-30 18:04:12.000000000 -0400
+++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-07-30 18:07:08.000000000 -0400
@@ -433,25 +433,26 @@ static int task_blocks_on_rt_mutex(struc
 		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
 		__rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on) {
+		if (owner->pi_blocked_on)
 			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
 		spin_lock_irqsave(&owner->pi_lock, flags);
-		if (owner->pi_blocked_on) {
+		if (owner->pi_blocked_on)
 			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 	if (!boost)
 		return 0;
 
+	/*
+	 * The owner can't disappear while holding a lock,
+	 * so the owner struct is protected by wait_lock.
+	 * Gets dropped in rt_mutex_adjust_prio_chain()!
+	 */
+	get_task_struct(owner);
+
 	spin_unlock(&lock->wait_lock);
 
 	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter,




>  
>  	spin_unlock(&lock->wait_lock);
>  
> ----------------------------------------------------------
> The same question for remove_waiter()/rt_mutex_adjust_pi().
> 

Same answer. :)

> 
> The last (stupid) one,

Well, the other questions were definitely not stupid!

> wake_up_new_task:
> 
> 		if (unlikely(!current->array))
> 			__activate_task(p, rq);
> 
> (offtopic) Is it really possible to have current->array == NULL here?

  ** You know, I think you're right. I don't think current->array can 
     ever be NULL outside of schedule. And here we are even holding the 
     rq locks!

     Perhaps this can happen on startup. Is the init thread on any run
     queue on system boot up?


> 
> 		else {
> 			p->prio = current->prio;
> 
> What if current was pi-boosted so that rt_prio(current->prio) == 1,
> who will de-boost the child?

Good point!  Perhaps this can cause a prio leak.

> 
> 			p->normal_prio = current->normal_prio;
> 
> Why? p->normal_prio was calculated by effective_prio() above, could you
> explain why that value is not ok?

I don't know this answer. So I can't help you here.  Seems that these
were not "Stupid" questions after all. ;)


-- Steve


