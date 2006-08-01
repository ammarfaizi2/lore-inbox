Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWHANkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWHANkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWHANkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:40:12 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27121 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161027AbWHANkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:40:10 -0400
Subject: [PATCH] cleanup and remove some extra spinlocks from rtmutex
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:39:48 -0400
Message-Id: <1154439588.25445.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg brought up some interesting points about grabbing the pi_lock for
some protections. In this discussion, I realized that there are some
places that the pi_lock is being grabbed when it really wasn't
necessary.  Also this patch does a little bit of clean up.

This patch basically does three things:

1) renames the "boost" variable to "chain_walk".  Since it is used in
the debugging case when it isn't going to be boosted. It better
describes what the test is going to do if it succeeds.

2) moves get_task_struct to just before the unlocking of the wait_lock.
This removes duplicate code, and makes it a little easier to read.  The
owner wont go away while either the pi_lock or the wait_lock are held.

3) removes the pi_locking and owner blocked checking completely from the
debugging case.  This is because the grabbing the lock and doing the
check, then releasing the lock is just so full of races. It's just as
good to go ahead and call the pi_chain_walk function, since after
releasing the lock the owner can then block anyway, and we would have
missed that.  For the debug case, we really do want to do the chain walk
to test for deadlocks anyway.

-- Steve

Signed-of-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/kernel/rtmutex.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/rtmutex.c	2006-08-01 09:22:07.000000000 -0400
+++ linux-2.6.18-rc2/kernel/rtmutex.c	2006-08-01 09:26:14.000000000 -0400
@@ -409,7 +409,7 @@ static int task_blocks_on_rt_mutex(struc
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
 	unsigned long flags;
-	int boost = 0, res;
+	int chain_walk = 0, res;
 
 	spin_lock_irqsave(&current->pi_lock, flags);
 	__rt_mutex_adjust_prio(current);
@@ -433,25 +433,23 @@ static int task_blocks_on_rt_mutex(struc
 		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
 		__rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
+		if (owner->pi_blocked_on)
+			chain_walk = 1;
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
-	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
-		spin_lock_irqsave(&owner->pi_lock, flags);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
-		spin_unlock_irqrestore(&owner->pi_lock, flags);
-	}
-	if (!boost)
+	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock))
+		chain_walk = 1;
+
+	if (!chain_walk)
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
@@ -532,7 +530,7 @@ static void remove_waiter(struct rt_mute
 	int first = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	unsigned long flags;
-	int boost = 0;
+	int chain_walk = 0;
 
 	spin_lock_irqsave(&current->pi_lock, flags);
 	plist_del(&waiter->list_entry, &lock->wait_list);
@@ -554,19 +552,20 @@ static void remove_waiter(struct rt_mute
 		}
 		__rt_mutex_adjust_prio(owner);
 
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			/* gets dropped in rt_mutex_adjust_prio_chain()! */
-			get_task_struct(owner);
-		}
+		if (owner->pi_blocked_on)
+			chain_walk = 1;
+
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 
 	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
 
-	if (!boost)
+	if (!chain_walk)
 		return;
 
+	/* gets dropped in rt_mutex_adjust_prio_chain()! */
+	get_task_struct(owner);
+
 	spin_unlock(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL, current);


