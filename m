Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWCZXTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCZXTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWCZXTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:19:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54217 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932190AbWCZXT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:19:29 -0500
Date: Mon, 27 Mar 2006 01:16:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org, Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] PI-futex: -V3
Message-ID: <20060326231638.GA18395@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326160353.GA13282@elte.hu>
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

this is version -V3 of the PI-futex patchset (ontop of current -mm plus 
the -V2 delta patch). Changes since -V2:

 - do the -> set_current_state() cleanups for real
 - make plist_add() more readable
 - whitespace cleanups in kernel/futex.c
 - further cleanups in rtmutex_common.h
 - fix cornercase race in the PI-locking code (it triggered in the -rt tree)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/futex.c          |    4 
 kernel/rtmutex.c        |  245 +++++++++++++++++++++++++-----------------------
 kernel/rtmutex_common.h |    6 -
 lib/plist.c             |    3 
 4 files changed, 136 insertions(+), 122 deletions(-)

Index: linux-pi-futex.mm.q/kernel/futex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/futex.c
+++ linux-pi-futex.mm.q/kernel/futex.c
@@ -425,7 +425,7 @@ void exit_pi_state_list(struct task_stru
 	 */
 	spin_lock(&curr->pi_lock);
 	while (!list_empty(head)) {
-		
+
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
@@ -439,7 +439,7 @@ void exit_pi_state_list(struct task_stru
 			spin_unlock(&hb->lock);
 			continue;
 		}
-		
+
 		list_del_init(&pi_state->list);
 
 		WARN_ON(pi_state->owner != curr);
Index: linux-pi-futex.mm.q/kernel/rtmutex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex.c
+++ linux-pi-futex.mm.q/kernel/rtmutex.c
@@ -173,11 +173,12 @@ static int lock_pi_chain(struct rt_mutex
 	struct task_struct *owner;
 	struct rt_mutex *nextlock, *lock = act_lock;
 	struct rt_mutex_waiter *nextwaiter;
+	int deadlock_detect;
 
 	/*
 	 * Debugging might turn deadlock detection on, unconditionally:
 	 */
-	detect_deadlock = debug_rt_mutex_detect_deadlock(detect_deadlock);
+	deadlock_detect = debug_rt_mutex_detect_deadlock(detect_deadlock);
 
 	for (;;) {
 		owner = rt_mutex_owner(lock);
@@ -185,7 +186,7 @@ static int lock_pi_chain(struct rt_mutex
 		/* Check for circular dependencies */
 		if (unlikely(owner->pi_locked_by == current)) {
 			debug_rt_mutex_deadlock(detect_deadlock, waiter, lock);
-			return detect_deadlock ? -EDEADLK : 0;
+			return detect_deadlock ? -EDEADLK : 1;
 		}
 
 		while (!spin_trylock(&owner->pi_lock)) {
@@ -211,7 +212,7 @@ static int lock_pi_chain(struct rt_mutex
 
 		/* End of chain? */
 		if (!nextwaiter)
-			return 0;
+			return 1;
 
 		nextlock = nextwaiter->lock;
 
@@ -223,7 +224,7 @@ static int lock_pi_chain(struct rt_mutex
 			list_del_init(&owner->pi_lock_chain);
 			owner->pi_locked_by = NULL;
 			spin_unlock(&owner->pi_lock);
-			return detect_deadlock ? -EDEADLK : 0;
+			return detect_deadlock ? -EDEADLK : 1;
 		}
 
 		/* Try to get nextlock->wait_lock: */
@@ -242,7 +243,7 @@ static int lock_pi_chain(struct rt_mutex
 		 * for userspace locks), we have to walk the full chain
 		 * unconditionally.
 		 */
-		if (detect_deadlock)
+		if (deadlock_detect)
 			continue;
 
 		/*
@@ -255,11 +256,11 @@ static int lock_pi_chain(struct rt_mutex
 			/* If the top waiter has higher priority, stop: */
 			if (rt_mutex_top_waiter(lock)->list_entry.prio <=
 			    waiter->list_entry.prio)
-				return 0;
+				return 1;
 		} else {
 			/* If nextwaiter is not the top waiter, stop: */
 			if (rt_mutex_top_waiter(lock) != nextwaiter)
-				return 0;
+				return 1;
 		}
 	}
 }
@@ -340,103 +341,6 @@ static void adjust_pi_chain(struct rt_mu
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
@@ -542,6 +446,117 @@ static int try_to_take_rt_mutex(struct r
 }
 
 /*
+ * Task blocks on lock.
+ *
+ * Prepare waiter and potentially propagate our priority into the pi chain.
+ *
+ * This must be called with lock->wait_lock held.
+ * return values: 1: waiter queued, 0: got the lock,
+ *		  -EDEADLK: deadlock detected.
+ */
+static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
+				   struct rt_mutex_waiter *waiter,
+				   int detect_deadlock __IP_DECL__)
+{
+	struct rt_mutex_waiter *top_waiter = waiter;
+	LIST_HEAD(lock_chain);
+	int res = 1;
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
+	if (likely(res == 1))
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
+		res = 0;
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
+	if (likely(res == 1))
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
@@ -641,11 +656,11 @@ static int remove_waiter(struct rt_mutex
 
 	spin_lock(&pi_conflicts_lock);
 
+	spin_lock(&lock->wait_lock);
+
 	spin_lock(&current->pi_lock);
 	current->pi_locked_by = current;
 
-	spin_lock(&lock->wait_lock);
-
 	/* We might have been woken up: */
 	if (!waiter->task) {
 		spin_unlock(&pi_conflicts_lock);
@@ -709,7 +724,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 	BUG_ON(rt_mutex_owner(lock) == current);
 
-	set_task_state(current, state);
+	set_current_state(state);
 
 	/* Setup the timer, when timeout != NULL */
 	if (unlikely(timeout))
@@ -743,10 +758,10 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		if (!waiter.task) {
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
-			if (ret == -EDEADLK)
+			/* got the lock or deadlock: */
+			if (ret == 0 || ret == -EDEADLK)
 				break;
-			if (ret == -EBUSY)
-				continue;
+			ret = 0;
 		}
 
 		spin_unlock_irqrestore(&lock->wait_lock, flags);
@@ -757,10 +772,10 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 			schedule_rt_mutex(lock);
 
 		spin_lock_irqsave(&lock->wait_lock, flags);
-		set_task_state(current, state);
+		set_current_state(state);
 	}
 
-	set_task_state(current, TASK_RUNNING);
+	set_current_state(TASK_RUNNING);
 
 	if (unlikely(waiter.task))
 		remove_waiter(lock, &waiter __IP__);
@@ -806,11 +821,9 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
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
Index: linux-pi-futex.mm.q/kernel/rtmutex_common.h
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex_common.h
+++ linux-pi-futex.mm.q/kernel/rtmutex_common.h
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
Index: linux-pi-futex.mm.q/lib/plist.c
===================================================================
--- linux-pi-futex.mm.q.orig/lib/plist.c
+++ linux-pi-futex.mm.q/lib/plist.c
@@ -38,7 +38,7 @@ void plist_add(struct plist_node *node, 
 
 	WARN_ON(!plist_node_empty(node));
 
-	list_for_each_entry(iter, &head->prio_list, plist.prio_list)
+	list_for_each_entry(iter, &head->prio_list, plist.prio_list) {
 		if (node->prio < iter->prio)
 			goto lt_prio;
 		else if (node->prio == iter->prio) {
@@ -46,6 +46,7 @@ void plist_add(struct plist_node *node, 
 					struct plist_node, plist.prio_list);
 			goto eq_prio;
 		}
+	}
 
 lt_prio:
 	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
