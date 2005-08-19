Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVHSNBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVHSNBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVHSNBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:01:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51942 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932616AbVHSNBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:01:00 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1124433586.5186.119.camel@localhost.localdomain>
References: <20050818060126.GA13152@elte.hu>
	 <1124433586.5186.119.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 09:00:45 -0400
Message-Id: <1124456445.5186.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 02:39 -0400, Steven Rostedt wrote:

> Ingo, can't you get rt.c to be more confusing. I mean it is too simple.
> We need to add a few more underscores here and there :-)  Seriously,
> that rt.c is mind boggling. It was nice before, now it is just screaming
> for a cleanup (come now, do we really need the four underscores?).  Same
> with latency.c. 

Ingo,

Here's one example of cleaning up rt.c.  I like an extra parameter
instead of having two functions that are exactly the same except for one
line.  I'll probably submit more.

I haven't thought of a good way yet to solve the race condition with
dependent sleeper. (Except by turning off CONFIG_WAKEUP_TIMING :-)

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux_realtime_ernie/kernel/rt.c
===================================================================
--- linux_realtime_ernie/kernel/rt.c	(revision 296)
+++ linux_realtime_ernie/kernel/rt.c	(working copy)
@@ -1331,8 +1331,7 @@
 	FREE_WAITER(&waiter);
 }
 
-static void __up_mutex_waiter_savestate(struct rt_mutex *lock __EIP_DECL__);
-static void __up_mutex_waiter_nosavestate(struct rt_mutex *lock __EIP_DECL__);
+static void __up_mutex_waiter(struct rt_mutex *lock, int save_state __EIP_DECL__);
 
 /*
  * release the lock:
@@ -1361,12 +1360,9 @@
 	if (plist_empty(&lock->wait_list))
 		check_pi_list_empty(lock, lock_owner(lock));
 #endif
-	if (unlikely(!plist_empty(&lock->wait_list))) {
-		if (save_state)
-			__up_mutex_waiter_savestate(lock __EIP__);
-		else
-			__up_mutex_waiter_nosavestate(lock __EIP__);
-	} else
+	if (unlikely(!plist_empty(&lock->wait_list)))
+			__up_mutex_waiter(lock, save_state __EIP__);
+	else
 		lock->owner = NULL;
 	__raw_spin_unlock(&pi_lock);
 	__raw_spin_unlock(&lock->wait_lock);
@@ -1759,7 +1755,7 @@
 	return __down_trylock(&rwsem->lock __CALLER0__);
 }
 
-static void __up_mutex_waiter_nosavestate(struct rt_mutex *lock __EIP_DECL__)
+static void __up_mutex_waiter(struct rt_mutex *lock, int save_state __EIP_DECL__)
 {
 	struct thread_info *old_owner_ti, *new_owner_ti;
 	struct task_struct *old_owner, *new_owner;
@@ -1790,43 +1786,12 @@
 		new_owner->pending_owner = lock;
 	}
 #endif
-	wake_up_process(new_owner);
+	if (save_state)
+		wake_up_process_mutex(new_owner);
+	else
+		wake_up_process(new_owner);
 }
 
-static void __up_mutex_waiter_savestate(struct rt_mutex *lock __EIP_DECL__)
-{
-	struct thread_info *old_owner_ti, *new_owner_ti;
-	struct task_struct *old_owner, *new_owner;
-	struct rt_mutex_waiter *w;
-	int prio;
-
-	old_owner_ti = lock_owner(lock);
-	old_owner = old_owner_ti->task;
-	new_owner_ti = pick_new_owner(lock, old_owner_ti, 1 __EIP__);
-	new_owner = new_owner_ti->task;
-
-	/*
-	 * If the owner got priority-boosted then restore it
-	 * to the previous priority (or to the next highest prio
-	 * waiter's priority):
-	 */
-	prio = old_owner->normal_prio;
-	if (unlikely(!plist_empty(&old_owner->pi_waiters))) {
-		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
-		if (w->ti->task->prio < prio)
-			prio = w->ti->task->prio;
-	}
-	if (unlikely(prio != old_owner->prio))
-		pi_setprio(lock, old_owner, prio);
-#ifdef CAPTURE_LOCK
-	if (lock != &kernel_sem.lock) {
-		new_owner->rt_flags |= RT_PENDOWNER;
-		new_owner->pending_owner = lock;
-	}
-#endif
-	wake_up_process_mutex(new_owner);
-}
-
 /*
  * Do owner check too:
  */


