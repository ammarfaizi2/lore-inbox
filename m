Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWCZWG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWCZWG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWCZWG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:06:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57805 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932146AbWCZWG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:06:57 -0500
Date: Mon, 27 Mar 2006 00:04:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt7 and deadlock detection.
Message-ID: <20060326220422.GA6052@elte.hu>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Sun, 26 Mar 2006, Esben Nielsen wrote:
> 
> > I don't get any print outs of any deadlock detection with many of my
> > tests.
> > When there is a deadlock down() simply returns instead of blocking
> > forever.
> 
> rt_mutex_slowlock seems to return -EDEADLK even though caller didn't 
> ask for deadlock detection (detect_deadlock=0). That is bad because 
> then the caller will not check for it. It ought to simply leave the 
> task blocked.
> 
> It only happens with CONFIG_DEBUG_RT_MUTEXES. That one also messes up 
> the task->pi_waiters as earlier reported.

FYI, here are my current fixes relative to -rt9. The deadlock-detection 
issue is not yet fixed i think, but i found a couple of other PI related 
bugs.

	Ingo

Index: linux/kernel/rtmutex.c
===================================================================
--- linux.orig/kernel/rtmutex.c
+++ linux/kernel/rtmutex.c
@@ -360,103 +360,6 @@ static void adjust_pi_chain(struct rt_mu
 }
 
 /*
- * Task blocks on lock.
- *
- * Prepare waiter and potentially propagate our priority into the pi chain.
- *
- * This must be called with lock->wait_lock held.
- */
-static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
-				   struct rt_mutex_waiter *waiter,
-				   int detect_deadlock __IP_DECL__)
-{
-	int res = 0;
-	struct rt_mutex_waiter *top_waiter = waiter;
-	LIST_HEAD(lock_chain);
-
-	waiter->task = current;
-	waiter->lock = lock;
-	debug_rt_mutex_reset_waiter(waiter);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
-
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-
-	current->pi_blocked_on = waiter;
-
-	/*
-	 * Call adjust_prio_chain, when waiter is the new top waiter
-	 * or when deadlock detection is requested:
-	 */
-	if (waiter != rt_mutex_top_waiter(lock) &&
-	    !debug_rt_mutex_detect_deadlock(detect_deadlock))
-		goto out;
-
-	/* Try to lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 1, detect_deadlock);
-
-	if (likely(!res))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
-
-	/* Common case: we managed to lock it: */
-	if (res != -EBUSY)
-		goto out_unlock;
-
-	/* Rare case: we hit some other task running a pi chain operation: */
-	unlock_pi_chain(&lock_chain);
-
-	plist_del(&waiter->list_entry, &lock->wait_list);
-	current->pi_blocked_on = NULL;
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
-	fixup_rt_mutex_waiters(lock);
-
-	spin_unlock(&lock->wait_lock);
-
-	spin_lock(&pi_conflicts_lock);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
-	spin_lock(&lock->wait_lock);
-	if (!rt_mutex_owner(lock)) {
-		waiter->task = NULL;
-		spin_unlock(&pi_conflicts_lock);
-		goto out;
-	}
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
-
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-
-	current->pi_blocked_on = waiter;
-
-	/* Lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 0, detect_deadlock);
-
-	/* Drop the conflicts lock before adjusting: */
-	spin_unlock(&pi_conflicts_lock);
-
-	if (likely(!res))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
-
- out_unlock:
-	unlock_pi_chain(&lock_chain);
- out:
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
-	return res;
-}
-
-/*
  * Optimization: check if we can steal the lock from the
  * assigned pending owner [which might not have taken the
  * lock yet]:
@@ -562,6 +465,117 @@ static int try_to_take_rt_mutex(struct r
 }
 
 /*
+ * Task blocks on lock.
+ *
+ * Prepare waiter and potentially propagate our priority into the pi chain.
+ *
+ * This must be called with lock->wait_lock held.
+ * return values: 0: waiter queued, 1: got the lock,
+ *		  -EDEADLK: deadlock detected.
+ */
+static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
+				   struct rt_mutex_waiter *waiter,
+				   int detect_deadlock __IP_DECL__)
+{
+	struct rt_mutex_waiter *top_waiter = waiter;
+	LIST_HEAD(lock_chain);
+	int res = 0;
+
+	waiter->task = current;
+	waiter->lock = lock;
+	debug_rt_mutex_reset_waiter(waiter);
+
+	spin_lock(&current->pi_lock);
+	current->pi_locked_by = current;
+	plist_node_init(&waiter->list_entry, current->prio);
+	plist_node_init(&waiter->pi_list_entry, current->prio);
+
+	/* Get the top priority waiter of the lock: */
+	if (rt_mutex_has_waiters(lock))
+		top_waiter = rt_mutex_top_waiter(lock);
+	plist_add(&waiter->list_entry, &lock->wait_list);
+
+	current->pi_blocked_on = waiter;
+
+	/*
+	 * Call adjust_prio_chain, when waiter is the new top waiter
+	 * or when deadlock detection is requested:
+	 */
+	if (waiter != rt_mutex_top_waiter(lock) &&
+	    !debug_rt_mutex_detect_deadlock(detect_deadlock))
+		goto out_unlock_pi;
+
+	/* Try to lock the full chain: */
+	res = lock_pi_chain(lock, waiter, &lock_chain, 1, detect_deadlock);
+
+	if (likely(!res))
+		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
+
+	/* Common case: we managed to lock it: */
+	if (res != -EBUSY)
+		goto out_unlock_chain_pi;
+
+	/* Rare case: we hit some other task running a pi chain operation: */
+	unlock_pi_chain(&lock_chain);
+
+	plist_del(&waiter->list_entry, &lock->wait_list);
+	current->pi_blocked_on = NULL;
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+	fixup_rt_mutex_waiters(lock);
+
+	spin_unlock(&lock->wait_lock);
+
+	/*
+	 * Here we have dropped all locks, and take the global
+	 * pi_conflicts_lock. We have to redo all the work, no
+	 * previous information about the lock is valid anymore:
+	 */
+	spin_lock(&pi_conflicts_lock);
+
+	spin_lock(&lock->wait_lock);
+	if (try_to_take_rt_mutex(lock __IP__)) {
+		/*
+		 * Rare race: against all odds we got the lock.
+		 */
+		res = 1;
+		goto out;
+	}
+
+	WARN_ON(!rt_mutex_owner(lock) || rt_mutex_owner(lock) == current);
+
+	spin_lock(&current->pi_lock);
+	current->pi_locked_by = current;
+
+	plist_node_init(&waiter->list_entry, current->prio);
+	plist_node_init(&waiter->pi_list_entry, current->prio);
+
+	/* Get the top priority waiter of the lock: */
+	if (rt_mutex_has_waiters(lock))
+		top_waiter = rt_mutex_top_waiter(lock);
+	plist_add(&waiter->list_entry, &lock->wait_list);
+
+	current->pi_blocked_on = waiter;
+
+	/* Lock the full chain: */
+	res = lock_pi_chain(lock, waiter, &lock_chain, 0, detect_deadlock);
+
+	/* Drop the conflicts lock before adjusting: */
+	spin_unlock(&pi_conflicts_lock);
+
+	if (likely(!res))
+		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
+
+ out_unlock_chain_pi:
+	unlock_pi_chain(&lock_chain);
+ out_unlock_pi:
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+ out:
+	return res;
+}
+
+/*
  * Wake up the next waiter on the lock.
  *
  * Remove the top waiter from the current tasks waiter list and from
@@ -773,7 +787,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 
 	for (;;) {
 		unsigned long saved_flags;
-		int saved_lock_depth = current->lock_depth;
+		int ret, saved_lock_depth = current->lock_depth;
 
 		/* Try to acquire the lock */
 		if (try_to_take_rt_mutex(lock __IP__))
@@ -783,8 +797,16 @@ rt_lock_slowlock(struct rt_mutex *lock _
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (unlikely(!waiter.task))
-			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
+		if (!waiter.task) {
+			ret = task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
+			/* got the lock: */
+			if (ret == 1) {
+				ret = 0;
+				break;
+			}
+			/* deadlock_detect == 0, so return should be 0 or 1: */
+			WARN_ON(ret);
+		}
 
 		/*
 		 * Prevent schedule() to drop BKL, while waiting for
@@ -974,10 +996,9 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		if (!waiter.task) {
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
-			if (ret == -EDEADLK)
+			/* got the lock or deadlock: */
+			if (ret == 1 || ret == -EDEADLK)
 				break;
-			if (ret == -EBUSY)
-				continue;
 		}
 
 		saved_flags = current->flags & PF_NOSCHED;
@@ -1043,16 +1064,15 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 
 	if (likely(rt_mutex_owner(lock) != current)) {
 
+		/* FIXME: why is this done here and not above? */
 		init_lists(lock);
 
 		ret = try_to_take_rt_mutex(lock __IP__);
 		/*
 		 * try_to_take_rt_mutex() sets the lock waiters
-		 * bit. We might be the only waiter. Check if this
-		 * needs to be cleaned up.
+		 * bit unconditionally. Clean this up.
 		 */
-		if (!ret)
-			fixup_rt_mutex_waiters(lock);
+		fixup_rt_mutex_waiters(lock);
 	}
 
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
Index: linux/kernel/rtmutex_common.h
===================================================================
--- linux.orig/kernel/rtmutex_common.h
+++ linux/kernel/rtmutex_common.h
@@ -98,18 +98,18 @@ task_top_pi_waiter(struct task_struct *p
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 {
 	return (struct task_struct *)
-		((unsigned long)((lock)->owner) & ~RT_MUTEX_OWNER_MASKALL);
+		((unsigned long)lock->owner & ~RT_MUTEX_OWNER_MASKALL);
 }
 
 static inline struct task_struct *rt_mutex_real_owner(struct rt_mutex *lock)
 {
  	return (struct task_struct *)
-		((unsigned long)((lock)->owner) & ~RT_MUTEX_HAS_WAITERS);
+		((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
 static inline unsigned long rt_mutex_owner_pending(struct rt_mutex *lock)
 {
-	return ((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);
+	return (unsigned long)lock->owner & RT_MUTEX_OWNER_PENDING;
 }
 
 /*
