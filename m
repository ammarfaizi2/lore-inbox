Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWG3AgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWG3AgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWG3AgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:36:09 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:63361 "EHLO
	several.ru") by vger.kernel.org with ESMTP id S1750887AbWG3AgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:36:06 -0400
Date: Sun, 30 Jul 2006 08:36:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: rt_mutex_timed_lock() vs hrtimer_wakeup() race ? 
Message-ID: <20060730043605.GA2894@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get some understanding of rt_mutex, but I'm afraid it's
not possible without your help...

// runs on CPU 0
rt_mutex_slowlock:

	// main loop
	for (;;) {
		...

			if (timeout && !timeout->task) {
				ret = -ETIMEDOUT;
				break;
			}

		...

		schedule();

		...

		set_current_state(state);
	}

What if timeout->timer is fired on CPU 1 right before set_current_state() ?

hrtimer_wakeup() does:

	timeout->task = NULL;		<----- [1]

	spin_lock(runqueues->lock);

	task->state = TASK_RUNNING;	<----- [2]

(task->array != NULL, so try_to_wake_up() just goes to out_running)

If my understanding correct, [1] may slip into the critical section (because
spin_lock() is not a wmb), so that CPU 0 will see [2] but not [1]. In that
case rt_mutex_slowlock() can miss the timeout (set_current_state()->mb()
doesn't help).

Of course, this race (even _if_ I am right) is pure theoretical, but probably
we need smp_wmb() after [1] in hrtimer_wakeup().

Note that do_nanosleep() is ok, hrtimer_base->lock provides a necessary
serialization. In fact, I think it can use __set_current_state(), because
both hrtimer_start() and run_hrtimer_queue() do lock/unlock of base->lock.



Another question, task_blocks_on_rt_mutex() does get_task_struct() and checks
owner->pi_blocked_on != NULL under owner->pi_lock. Why ? RT_MUTEX_HAS_WAITERS
bit is set, we are holding ->wait_lock, so the 'owner' can't go away until
we drop ->wait_lock. I think we can drop owner->pi_lock right after
__rt_mutex_adjust_prio(owner), we can't miss owner->pi_blocked_on != NULL
if it was true before we take owner->pi_lock, and this is the case we should
worry about, yes?

In other words (because I myself can't parse the paragraph above :), could
you explain me why this patch is not correct:

--- rtmutex.c~	2006-07-30 05:15:38.000000000 +0400
+++ rtmutex.c	2006-07-30 05:41:44.000000000 +0400
@@ -407,7 +407,7 @@ static int task_blocks_on_rt_mutex(struc
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
 	unsigned long flags;
-	int boost = 0, res;
+	int res;
 
 	spin_lock_irqsave(&current->pi_lock, flags);
 	__rt_mutex_adjust_prio(current);
@@ -431,24 +431,20 @@ static int task_blocks_on_rt_mutex(struc
 		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
 		__rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
+
+		if (owner->pi_blocked_on)
+			goto boost;
 	}
 	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
-		spin_lock_irqsave(&owner->pi_lock, flags);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
-		spin_unlock_irqrestore(&owner->pi_lock, flags);
+		if (owner->pi_blocked_on)
+			goto boost;
 	}
-	if (!boost)
-		return 0;
+
+	return 0;
+boost:
+	/* gets dropped in rt_mutex_adjust_prio_chain()! */
+	get_task_struct(owner);
 
 	spin_unlock(&lock->wait_lock);
 
----------------------------------------------------------
The same question for remove_waiter()/rt_mutex_adjust_pi().


The last (stupid) one,
wake_up_new_task:

		if (unlikely(!current->array))
			__activate_task(p, rq);

(offtopic) Is it really possible to have current->array == NULL here?

		else {
			p->prio = current->prio;

What if current was pi-boosted so that rt_prio(current->prio) == 1,
who will de-boost the child?

			p->normal_prio = current->normal_prio;

Why? p->normal_prio was calculated by effective_prio() above, could you
explain why that value is not ok?

Thanks,

Oleg.

