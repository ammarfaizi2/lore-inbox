Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVHVTmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVHVTmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHVTmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:42:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:16519 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750718AbVHVTmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:42:02 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050822183355.GB13888@elte.hu>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 15:40:57 -0400
Message-Id: <1124739657.5809.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to move the pi_lock out of the "fast path".  Thus, only
threads that need to do PI will need to take it.

   Comments?

Please look for any race conditions or side effects that I might have
missed.

Thanks,

-- Steve

(Ingo and Thomas, this is what I already sent you)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/fork.c
===================================================================
--- linux_realtime_goliath/kernel/fork.c	(revision 300)
+++ linux_realtime_goliath/kernel/fork.c	(working copy)
@@ -1011,6 +1011,7 @@
 	plist_init(&p->pi_waiters, MAX_PRIO);
 	preempt_enable();
 	p->blocked_on = NULL; /* not blocked yet */
+	spin_lock_init(&p->rt_lock);
 
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 301)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -759,6 +759,7 @@
 	 * If the task is blocked on some other task then boost that
 	 * other task (or tasks) too:
 	 */
+	__raw_spin_lock(&p->rt_lock);
 	for (;;) {
 		struct rt_mutex_waiter *w = p->blocked_on;
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -777,7 +778,6 @@
 		TRACE_BUG_ON_LOCKED(!lock);
 		TRACE_BUG_ON_LOCKED(!lock_owner(lock));
 		if (rt_task(p) && plist_empty(&w->pi_list)) {
-			TRACE_BUG_ON_LOCKED(was_rt);
 			plist_init(&w->pi_list, prio);
 			plist_add(&w->pi_list, &lock_owner(lock)->task->pi_waiters);
 
@@ -803,8 +803,10 @@
 
 		pi_walk++;
 
+		__raw_spin_unlock(&p->rt_lock);
 		p = lock_owner(lock)->task;
 		TRACE_BUG_ON_LOCKED(!p);
+		__raw_spin_lock(&p->rt_lock);
 		/*
 		 * If the dependee is already higher-prio then
 		 * no need to boost it, and all further tasks down
@@ -813,6 +815,7 @@
 		if (p->prio <= prio)
 			break;
 	}
+	__raw_spin_unlock(&p->rt_lock);
 }
 
 /*
@@ -869,7 +872,7 @@
 	/* mark the current thread as blocked on the lock */
 	waiter->eip = eip;
 #endif
-	__raw_spin_lock(&pi_lock);
+	__raw_spin_lock(&task->rt_lock);
 	task->blocked_on = waiter;
 	waiter->lock = lock;
 	waiter->ti = ti;
@@ -881,15 +884,23 @@
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
 		set_lock_owner_pending(lock);
-		__raw_spin_unlock(&pi_lock);
+		__raw_spin_unlock(&task->rt_lock);
 		return;
 	}
 #endif
-	plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
+	__raw_spin_unlock(&task->rt_lock);
+	__raw_spin_lock(&pi_lock);
 	/*
-	 * Add RT tasks to the head:
+	 * We could have been added to the pi list from another task 
+	 * doing a pi_setprio.
 	 */
-	plist_add(&waiter->list, &lock->wait_list);
+	if (likely(plist_empty(&waiter->pi_list))) {
+		plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
+		/*
+		 * Add RT tasks to the head:
+		 */
+		plist_add(&waiter->list, &lock->wait_list);
+	}
 	set_lock_owner_pending(lock);
 	/*
 	 * If the waiter has higher priority than the owner
Index: linux_realtime_goliath/include/linux/init_task.h
===================================================================
--- linux_realtime_goliath/include/linux/init_task.h	(revision 300)
+++ linux_realtime_goliath/include/linux/init_task.h	(working copy)
@@ -112,6 +112,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED(tsk.proc_lock),		\
 	.delayed_put	= LIST_HEAD_INIT(tsk.delayed_put),		\
 	.pi_waiters	= PLIST_INIT(tsk.pi_waiters, MAX_PRIO),		\
+	.rt_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
Index: linux_realtime_goliath/include/linux/sched.h
===================================================================
--- linux_realtime_goliath/include/linux/sched.h	(revision 301)
+++ linux_realtime_goliath/include/linux/sched.h	(working copy)
@@ -950,6 +950,7 @@
 	/* RT deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *blocked_on;
 	struct rt_mutex *pending_owner;
+	raw_spinlock_t rt_lock;
 	unsigned long rt_flags;
 
 


