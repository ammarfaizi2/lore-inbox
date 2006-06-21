Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWFUOnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFUOnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWFUOnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:43:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:50252 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932079AbWFUOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:43:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=YVM3iJXHOCdpldIHpJSi1wXBxnFvpgK5Rc5GCRM44/jOWLXc6Ygm8F8vBfADmpqP+v9qHtumObrH8Ype/0tog7snLJNmqJrBRfqVby1SYEZhvK9NrV2ZMtKn860b2v5ch//pHb302EcOZjVpdCKVz8Z5wAOde32YPvIYVQwGy3k=
Date: Wed, 21 Jun 2006 16:43:48 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Esben Nielsen <nielsen.esben@gogglemail.com>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Esben Nielsen wrote:

>
>
> On Wed, 21 Jun 2006, Steven Rostedt wrote:
>
>>
>>  On Tue, 20 Jun 2006, Esben Nielsen wrote:
>> 
>> > 
>> > >  I have to check, whether the priority is propagated when the softirq 
>> > >  is
>> > >  blocked on a lock. If not its a bug and has to be fixed.
>> > 
>> >  I think the simplest solution would be to add
>> > 
>> >           if (p->blocked_on)
>> >                   wake_up_process(p);
>> > 
>> >  in __setscheduler().
>> > 
>>
>>  Except that wake_up_process calls try_to_wakeup which grabs the runqueue
>>  lock, which unfortunately is already held when __setscheduler is called.
>> 
>
> Yeah, I saw. Move it out in setscheduler() then. I'll try to fix it, but I am 
> not sure I can make a test if it works.

What about the patch below. It compiles and my UP labtop runs fine, but I 
haven't otherwise tested it.  My labtop runs RTExec without hichups 
until now.

Esben

Index: linux-2.6.17-rt1/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt1.orig/kernel/rtmutex.c
+++ linux-2.6.17-rt1/kernel/rtmutex.c
@@ -625,6 +625,7 @@ rt_lock_slowlock(struct rt_mutex *lock _

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
+	waiter.save_state = 1;

  	spin_lock(&lock->wait_lock);

@@ -687,6 +688,19 @@ rt_lock_slowlock(struct rt_mutex *lock _
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
+			remove_waiter(lock, &waiter __IP__);
+			waiter.task = NULL;
+		}
+
  	}

  	state = xchg(&current->state, saved_state);
@@ -798,6 +812,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,

  	debug_rt_mutex_init_waiter(&waiter);
  	waiter.task = NULL;
+	waiter.save_state = 0;

  	spin_lock(&lock->wait_lock);

@@ -877,6 +892,18 @@ rt_mutex_slowlock(struct rt_mutex *lock,

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
+			remove_waiter(lock, &waiter __IP__);
+			waiter.task = NULL;
+		}
  	}

  	set_current_state(TASK_RUNNING);
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
