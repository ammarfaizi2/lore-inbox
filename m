Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWHAN4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWHAN4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWHAN4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:56:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58509 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751619AbWHAN4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:56:54 -0400
Subject: [PATCH -rt] clean up pi_lock in rtmutex
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Esben Nielsen <nielsen.esben@googlemail.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:56:46 -0400
Message-Id: <1154440606.13175.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

This is pretty much the same patch that I sent to mainline to clean up
the  rtmutex code.  I gave the reasons why in that patch, so I'm not
going to repeat them here.  This is for 2.6.17-rt7

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rt7/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/rtmutex.c	2006-08-01 09:40:36.000000000 -0400
+++ linux-2.6.17-rt7/kernel/rtmutex.c	2006-08-01 09:53:41.000000000 -0400
@@ -419,7 +419,7 @@ static int task_blocks_on_rt_mutex(struc
 {
 	struct rt_mutex_waiter *top_waiter = waiter;
 	task_t *owner = rt_mutex_owner(lock);
-	int boost = 0, res;
+	int chain_walk = 0, res;
 	unsigned long flags;
 
 	spin_lock_irqsave(&current->pi_lock, flags);
@@ -444,23 +444,24 @@ static int task_blocks_on_rt_mutex(struc
 		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
 		__rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			get_task_struct(owner);
-		}
-		spin_unlock_irqrestore(&owner->pi_lock, flags);
-	}
-	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
-		spin_lock_irqsave(&owner->pi_lock, flags);
-		if (owner->pi_blocked_on) {
-			boost = 1;
-			get_task_struct(owner);
-		}
+		if (owner->pi_blocked_on)
+			chain_walk = 1;
+
 		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
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
 
 	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
@@ -542,7 +543,7 @@ static void remove_waiter(struct rt_mute
 			  struct rt_mutex_waiter *waiter  __IP_DECL__)
 {
 	int first = (waiter == rt_mutex_top_waiter(lock));
-	int boost = 0;
+	int chain_walk = 0;
 	task_t *owner = rt_mutex_owner(lock);
 	unsigned long flags;
 
@@ -566,18 +567,20 @@ static void remove_waiter(struct rt_mute
 		}
 		__rt_mutex_adjust_prio(owner);
 
-		if (owner->pi_blocked_on) {
-			boost = 1;
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
 
 	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL __IP__);


