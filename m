Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWFVRGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWFVRGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWFVRGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:06:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42773 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932558AbWFVRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:06:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=S5tEg1sYyXVNcY1c4pRLPk9GtNFzSbSLzfdIRsCHYFcNJFi66aU7WK2auqkslOJFwEWZKfuoE5Jy9jbPWoMQfJ2Q5dpTZy10mZZLHd+frDt9Jj2xWJanKSTIq7/FNl0VS+Y9RCxU9/0//PFFZXejyWNggzZ23jxTloHJrHJP1dY=
Date: Thu, 22 Jun 2006 19:06:29 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150986396.25491.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606221902560.10511@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> 
 <1150824092.6780.255.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> 
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> 
 <1150907165.25491.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0606220936290.15236@gandalf.stny.rr.com> 
 <1150986041.25491.53.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com>
 <1150986396.25491.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Thomas Gleixner wrote:

> On Thu, 2006-06-22 at 10:23 -0400, Steven Rostedt wrote:
>>> What's nasty ?
>>>
>>
>> The fact that sched_setscheduler can never be called by interrupt context.
>> So I don't know how you're going to handle the high_res dynamic priority
>> now.
>
> Thats a seperate issue. Though you are right.

Why not use my original patch and solve both issues?
I have even updated it to avoid the double traversal. It also removes 
one other traversal which shouldn't be needed. (I have not had time 
to boot the kernel with it, though, but it does compile...:-)

Esben

>
> 	tglx
>
>

Index: linux-2.6.17-rt1/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt1.orig/kernel/rtmutex.c
+++ linux-2.6.17-rt1/kernel/rtmutex.c
@@ -539,7 +539,8 @@ static void wakeup_next_waiter(struct rt
   * Must be called with lock->wait_lock held
   */
  static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter  __IP_DECL__)
+			  struct rt_mutex_waiter *waiter,
+			  int fix_prio __IP_DECL__)
  {
  	int first = (waiter == rt_mutex_top_waiter(lock));
  	int boost = 0;
@@ -564,10 +565,12 @@ static void remove_waiter(struct rt_mute
  			next = rt_mutex_top_waiter(lock);
  			plist_add(&next->pi_list_entry, &owner->pi_waiters);
  		}
-		__rt_mutex_adjust_prio(owner);
+		if (fix_prio) {
+			__rt_mutex_adjust_prio(owner);
+		}

  		if (owner->pi_blocked_on) {
-			boost = 1;
+			boost = fix_prio;
  			get_task_struct(owner);
  		}
  		spin_unlock_irqrestore(&owner->pi_lock, flags);
@@ -625,6 +628,7 @@ rt_lock_slowlock(struct rt_mutex *lock _

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
+	waiter.save_state = 1;

  	spin_lock(&lock->wait_lock);

@@ -687,6 +691,19 @@ rt_lock_slowlock(struct rt_mutex *lock _
  		state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
  		if (unlikely(state == TASK_RUNNING))
  			saved_state = TASK_RUNNING;
+
+		if (unlikely(waiter.task) &&
+		    waiter.list_entry.prio != current->prio) {
+			/*
+			 * We still not have the lock, but we are woken up with
+			 * a different prio than the one we waited with
+			 * originally. We remove the wait entry now and then
+			 * reinsert ourselves with the right priority
+			 */
+			remove_waiter(lock, &waiter, 0 __IP__);
+			waiter.task = NULL;
+		}
+
  	}

  	state = xchg(&current->state, saved_state);
@@ -700,7 +717,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
  	 * can end up with a non-NULL waiter.task:
  	 */
  	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+		remove_waiter(lock, &waiter, 0 __IP__);
  	/*
  	 * try_to_take_rt_mutex() sets the waiter bit
  	 * unconditionally. We might have to fix that up:
@@ -798,6 +815,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
+	waiter.save_state = 0;

  	spin_lock(&lock->wait_lock);

@@ -877,12 +895,24 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  		current->flags |= saved_flags;
  		set_current_state(state);
+
+		if (unlikely(waiter.task) &&
+		    waiter.list_entry.prio != current->prio) {
+			/*
+			 * We still not have the lock, but we are woken up with
+			 * a different prio than the one we waited with
+			 * originally. We remove the wait entry now and then
+			 * reinsert ourselves with the right priority
+			 */
+			remove_waiter(lock, &waiter, 0 __IP__);
+			waiter.task = NULL;
+		}
  	}

  	set_current_state(TASK_RUNNING);

  	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+		remove_waiter(lock, &waiter, 1 __IP__);

  	/*
  	 * try_to_take_rt_mutex() sets the waiter bit
Index: linux-2.6.17-rt1/kernel/sched.c
===================================================================
--- linux-2.6.17-rt1.orig/kernel/sched.c
+++ linux-2.6.17-rt1/kernel/sched.c
@@ -57,6 +57,8 @@

  #include <asm/unistd.h>

+#include "rtmutex_common.h"
+
  /*
   * Convert user-nice values [ -20 ... 0 ... 19 ]
   * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -646,7 +648,9 @@ static inline void sched_info_switch(tas
  #define sched_info_switch(t, next)	do { } while (0)
  #endif /* CONFIG_SCHEDSTATS */

+#ifdef CONFIG_SMP
  static __cacheline_aligned_in_smp atomic_t rt_overload;
+#endif

  static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
  {
@@ -1473,10 +1477,11 @@ static inline int wake_idle(int cpu, tas
  static int try_to_wake_up(task_t *p, unsigned int state, int sync, int mutex)
  {
  	int cpu, this_cpu, success = 0;
-	runqueue_t *this_rq, *rq;
+	runqueue_t *rq;
  	unsigned long flags;
  	long old_state;
  #ifdef CONFIG_SMP
+	runqueue_t *this_rq;
  	unsigned long load, this_load;
  	struct sched_domain *sd, *this_sd = NULL;
  	int new_cpu;
@@ -4351,6 +4356,18 @@ int setscheduler(struct task_struct *p,
  			resched_task(rq->curr);
  	}
  	task_rq_unlock(rq, &flags);
+
+	/*
+	 * If the process is blocked on rt-mutex, it will now wake up and
+	 * reinsert itself into the wait list and boost the owner correctly
+	 */
+	if (p->pi_blocked_on) {
+		if (p->pi_blocked_on->save_state)
+			wake_up_process_mutex(p);
+		else
+			wake_up_process(p);
+	}
+
  	spin_unlock_irqrestore(&p->pi_lock, fp);
  	return 0;
  }
@@ -7086,4 +7103,3 @@ void notrace preempt_enable_no_resched(v

  EXPORT_SYMBOL(preempt_enable_no_resched);
  #endif
-
Index: linux-2.6.17-rt1/kernel/rtmutex_common.h
===================================================================
--- linux-2.6.17-rt1.orig/kernel/rtmutex_common.h
+++ linux-2.6.17-rt1/kernel/rtmutex_common.h
@@ -49,6 +49,7 @@ struct rt_mutex_waiter {
  	struct plist_node	pi_list_entry;
  	struct task_struct	*task;
  	struct rt_mutex		*lock;
+	int                     save_state;
  #ifdef CONFIG_DEBUG_RT_MUTEXES
  	unsigned long		ip;
  	pid_t			deadlock_task_pid;
