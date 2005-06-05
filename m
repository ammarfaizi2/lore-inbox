Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFECe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFECe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 22:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFECeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 22:34:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23026 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261423AbVFECeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 22:34:07 -0400
Date: Sat, 4 Jun 2005 19:33:56 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@tv-sign.ru>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Plist cleanup on RT
In-Reply-To: <Pine.LNX.4.44.0506041748060.17923-100000@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.44.0506041924100.19520-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	This includes a change from Thomas Gleixner to make the sp_nodes 
FIFO ordered, plus some other small code changes and some small 
documentation cleanup.

	I fixed plist_entry() to work more like list_entry() , and made 
the proper update to kernel/rt.c .


	Oleg, do you have any correctness concerns with this patch?


Daniel



Index: linux-2.6.11/include/linux/plist.h
===================================================================
--- linux-2.6.11.orig/include/linux/plist.h	2005-06-05 01:32:38.000000000 +0000
+++ linux-2.6.11/include/linux/plist.h	2005-06-05 01:44:50.000000000 +0000
@@ -7,6 +7,8 @@
  * 2001-2005 (c) MontaVista Software, Inc.
  * Daniel Walker <dwalker@mvista.com>
  *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ *
  * Licensed under the FSF's GNU Public License v2 or later.
  *
  * Based on simple lists (include/linux/list.h).
@@ -28,11 +30,14 @@
  *
  *  - The tier 1 list is the dp list (Different Priority)
  *
- *  - The tier 2 list is the sp list (Same Priority)
+ *  - The tier 2 list is the sp list (Serialized Priority)
+ *
+ * The nodes on the sp list are ordered by priority and can contain
+ * entries which have the same priority. Those entries are ordered
+ * FIFO.
  *
- * All the nodes in a SP list have the same priority, and all the DP
- * lists have different priorities (and are sorted by priority, of
- * course).
+ * The DP lists have different priorities (and are sorted by priority, 
+ * of course).
  *
  * Addition means: look for the DP node in the DP list for the
  * priority of the node and append to the SP list corresponding to
@@ -83,7 +88,7 @@ struct plist {
  * @member:     the name of the list_struct within the struct.
  */
 #define plist_entry(ptr, type, member) \
-        container_of(plist_first(ptr), type, member)
+        container_of(ptr, type, member)
 /**
  * plist_for_each  -       iterate over the plist
  * @pos1:        the type * to use as a loop counter.
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-06-05 01:32:38.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-06-05 01:33:20.000000000 +0000
@@ -773,7 +773,7 @@ static inline struct task_struct * pick_
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	waiter = plist_entry(plist_first(&lock->wait_list), struct rt_mutex_waiter, list);
 
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
@@ -1351,7 +1351,7 @@ static void __up_mutex(struct rt_mutex *
 	 */
 	prio = mutex_getprio(old_owner);
 	if (!plist_empty(&old_owner->pi_waiters)) {
-		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		w = plist_entry(plist_first(&old_owner->pi_waiters), struct rt_mutex_waiter, pi_list);
 		if (w->task->prio < prio)
 			prio = w->task->prio;
 	}
Index: linux-2.6.11/lib/plist.c
===================================================================
--- linux-2.6.11.orig/lib/plist.c	2005-06-05 01:33:15.000000000 +0000
+++ linux-2.6.11/lib/plist.c	2005-06-05 01:33:34.000000000 +0000
@@ -9,6 +9,8 @@
  * 2001-2005 (c) MontaVista Software, Inc.
  * Daniel Walker <dwalker@mvista.com>
  *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ *
  * Licensed under the FSF's GNU Public License v2 or later.
  *
  * Based on simple lists (include/linux/list.h).
@@ -80,13 +82,12 @@ static inline void __plist_add_sorted(st
 	itr_pl = plist;
 
 new_sp_head:
-	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
 	list_add_tail(&pl->dp_node, &itr_pl->dp_node);
-	list_add(&pl->sp_node, &itr_pl2->sp_node);
+	list_add_tail(&pl->sp_node, &itr_pl->sp_node);
 	return;
 existing_sp_head:
-	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
-	list_add(&pl->sp_node, &itr_pl2->sp_node);
+	itr_pl2 = container_of(itr_pl->dp_node.next, struct plist, dp_node);
+	list_add_tail(&pl->sp_node, &itr_pl2->sp_node);
 	return;
 }
 
@@ -110,16 +111,17 @@ unsigned plist_add(struct plist *pl, str
 static inline
 void __plist_del(struct plist *pl)
 {
-	if (!list_empty(&pl->sp_node) && !list_empty(&pl->dp_node)) {
+	if (!list_empty(&pl->sp_node)) {
 		/* SP list head, not empty */
-		struct plist *pl_new = container_of(pl->sp_node.prev,
+		struct plist *pl_new = container_of(pl->sp_node.next,
 							struct plist, sp_node);
 
-		if (pl->dp_node.prev == &pl_new->dp_node) {
+		if (pl->dp_node.next == &pl_new->dp_node) {
 			/* end of this priorities list */
 			list_del_init(&pl->dp_node);
-		} else if (pl->prio == pl_new->prio) {
+		} else {
 			list_replace_rcu(&pl->dp_node, &pl_new->dp_node);
+			INIT_LIST_HEAD(&pl->dp_node);
 		} 
 	}
 	list_del_init(&pl->sp_node);
@@ -160,7 +162,7 @@ void __plist_chprio(struct plist *pl, in
  */
 unsigned plist_chprio(struct plist *plist, struct plist *pl, int new_prio)
 {
-	if (new_prio == plist->prio)
+	if (new_prio == pl->prio)
 		return 0;
 
 	__plist_chprio(pl, new_prio);

