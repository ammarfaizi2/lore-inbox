Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVHZCYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVHZCYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 22:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVHZCYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 22:24:23 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:29077 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965043AbVHZCYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 22:24:22 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1125000563.6264.10.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 25 Aug 2005 22:23:30 -0400
Message-Id: <1125023010.5365.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:09 -0400, Steven Rostedt wrote:

> A word of caution (aka. disclaimer). This is still new.  I still expect
> there are some cases in the code that was missed and can cause a dead
> lock or other bad side effect.  Hopefully, we can iron these all out.
> Also, I noticed that since the task takes it's own pi_lock for most of
> the code, if something locks up and a NMI goes off, the down_trylock in
> printk will also lock when it tries to take it's own pi_lock.

OK, found my first bug :-)

Just so everyone knows.  In rt.c, all pi_waiter access (reading or
writing) must be protected by the task's pi_lock, and all access to the
lock's wait_list must be protected by the lock's wait_lock.  The magic
is in the locking order :-).

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 306)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -671,6 +671,7 @@
 	struct rt_mutex_waiter *w;
 	struct plist *curr1;
 
+	__raw_spin_lock(old_owner->task->pi_lock);
 	TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
 	TRACE_WARN_ON_LOCKED(lock_owner(lock));
 
@@ -681,6 +682,7 @@
 	}
 	TRACE_WARN_ON_LOCKED(1);
 ok:
+	__raw_spin_unlock(old_owner->task->pi_lock);
 	return;
 }
 
@@ -734,6 +736,8 @@
 	if (old_owner == new_owner)
 		return;
 
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&old_owner->task->pi_lock));
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&new_owner->task->pi_lock));
 	plist_for_each_safe(curr1, next1, &old_owner->task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
@@ -932,6 +936,8 @@
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&task->pi_lock));
+	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
 #ifndef ALL_TASKS_PI
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
@@ -939,6 +945,7 @@
 		return;
 	}
 #endif
+	__raw_spin_lock(&lock_owner(lock)->task->pi_lock);
 	plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
 	/*
 	 * Add RT tasks to the head:
@@ -949,11 +956,9 @@
 	 * If the waiter has higher priority than the owner
 	 * then temporarily boost the owner:
 	 */
-	if (task->prio < lock_owner(lock)->task->prio) {
-		__raw_spin_lock(&lock_owner(lock)->task->pi_lock);
+	if (task->prio < lock_owner(lock)->task->prio)
 		pi_setprio(lock, lock_owner(lock)->task, task->prio);
-		__raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
-	}
+	__raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
 }
 
 /*


