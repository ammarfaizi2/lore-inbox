Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVDGRzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVDGRzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDGRzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:55:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38396 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262534AbVDGRwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:52:33 -0400
Subject: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@mvista.com, sdietrich@mvista.com, inaky.perez-gonzalez@intel.com
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1112896344.16901.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 Apr 2005 10:52:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Source: Daniel Walker <dwalker@mvista.com> MontaVista Software, Inc
Description:
	This patch adds the priority list data structure from Inaky Perez-Gonzalez 
to the Preempt Real-Time mutex.

the patch order is (starting with a 2.6.11 kernel tree),

patch-2.6.12-rc2
realtime-preempt-2.6.12-rc2-V0.7.44-01
	
Signed-off-by: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.11/include/linux/plist.h
===================================================================
--- linux-2.6.11.orig/include/linux/plist.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/include/linux/plist.h	2005-04-07 17:47:42.000000000 +0000
@@ -0,0 +1,310 @@
+/*
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * 2001-2005 (c) MontaVista Software, Inc.
+ * Daniel Walker <dwalker@mvista.com>
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
+ *
+ * 
+ * This is a priority-sorted list of nodes; each node has a >= 0
+ * priority from 0 (highest) to INT_MAX (lowest). The list itself has
+ * a priority too (the highest of all the nodes), stored in the head
+ * of the list (that is a node itself).
+ *
+ * Addition is O(1), removal is O(1), change of priority of a node is
+ * O(1).
+ *
+ * Addition and change of priority's order is really O(K), where K is
+ * a constant being the maximum number of different priorities you
+ * will store in the list. Being a constant, it means it is O(1).
+ *
+ * This list is really a list of lists:
+ *
+ *  - The tier 1 list is the dp list (Different Priority)
+ *
+ *  - The tier 2 list is the sp list (Same Priority)
+ *
+ * All the nodes in a SP list have the same priority, and all the DP
+ * lists have different priorities (and are sorted by priority, of
+ * course).
+ *
+ * Addition means: look for the DP node in the DP list for the
+ * priority of the node and append to the SP list corresponding to
+ * that node. If it is the first node of that priority, add it to the
+ * DP list in the right position and it will be the head of the SP
+ * list for his priority.
+ *
+ * Removal means remove it from the SP list corresponding to its
+ * prio. If it is the only one, it means its also the head and thus a
+ * DP node, so we remove it from the DP list. If it is the head but
+ * there are others in its SP list, then we remove it from both and
+ * get the first one of the SP list to be the new head.
+ *
+ * INT_MIN is the highest priority, 0 is the medium highest, INT_MAX
+ * is lowest priority.
+ *
+ * No locking is done, up to the caller.
+ *
+ * NOTE: This implementation does not offer as many interfaces as
+ *       linux/list.h does -- it is lazily minimal. You are welcome to
+ *       add them.
+ */
+
+#ifndef _LINUX_PLIST_H_
+#define _LINUX_PLIST_H_
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+
+/* Priority-sorted list */
+struct plist {
+	int prio;
+	struct list_head dp_node;
+	struct list_head sp_node;
+};
+
+#define PLIST_INIT(p,__prio)				\
+{							\
+	.prio = __prio,					\
+	.dp_node = LIST_HEAD_INIT((p).dp_node),	\
+	.sp_node = LIST_HEAD_INIT((p).sp_node),	\
+}
+
+/**
+ * plist_entry - get the struct for this entry
+ * @ptr:        the &struct plist pointer.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_struct within the struct.
+ */
+#define plist_entry(ptr, type, member) \
+        container_of(plist_first (ptr), type, member)
+/**
+ * plist_for_each  -       iterate over the plist
+ * @pos1:        the type * to use as a loop counter.
+ * @pos1:        the type * to use as a second loop counter.
+ * @head:       the head for your list.
+ */
+#define plist_for_each(pos1, pos2, head)	\
+	list_for_each_entry(pos1, &((head)->dp_node), dp_node)	\
+		list_for_each_entry(pos2, &((pos1)->sp_node), sp_node)
+/**
+ * plist_for_each_entry_safe - iterate over a plist of given type safe against removal of list entry
+ * @pos1:        the type * to use as a loop counter.
+ * @pos2:        the type * to use as a loop counter.
+ * @n1:          another type * to use as temporary storage
+ * @n2:          another type * to use as temporary storage
+ * @head:       the head for your list.
+ */
+#define plist_for_each_safe(pos1, pos2, n1, n2, head)			\
+	list_for_each_entry_safe(pos1, n1, &((head)->dp_node), dp_node)	\
+		list_for_each_entry_safe(pos2, n2, &((pos1)->sp_node), sp_node)
+
+/* Initialize a pl */
+static inline
+void plist_init (struct plist *pl, int prio)
+{
+	pl->prio = prio;
+	INIT_LIST_HEAD (&pl->dp_node);
+	INIT_LIST_HEAD (&pl->sp_node);
+}
+
+/* Return the first node (and thus, highest priority)
+ *
+ * Assumes the plist is _not_ empty.
+ */
+static inline
+struct plist * plist_first (struct plist *plist)
+{
+	return list_entry (plist->dp_node.next, struct plist, dp_node);
+}
+
+/* Return if the plist is empty. */
+static inline
+unsigned plist_empty (const struct plist *plist)
+{
+	return list_empty (&plist->dp_node);
+}
+
+/* Update the maximum priority of the whole list
+ *
+ * @returns !0 if the plist prio changed, 0 otherwise.
+ * 
+ * __plist_update_prio() assumes the plist is not empty.
+ */
+static inline
+unsigned __plist_update_prio (struct plist *plist)
+{
+	int prio = plist_first (plist)->prio;
+	if (plist->prio == prio)
+		return 0;
+	plist->prio = prio;
+	return !0;
+}
+
+static inline
+unsigned plist_update_prio (struct plist *plist)
+{
+	int old_prio = plist->prio;
+	/* plist empty, lowest prio = INT_MAX */
+	plist->prio = plist_empty (plist)? INT_MAX : plist_first (plist)->prio;
+	return old_prio != plist->prio;
+}
+
+/* Add a node to the plist [internal]
+ *
+ * pl->prio == INT_MAX is an special case, means low priority, get
+ * down to the end of the plist. Note the we want FIFO behaviour on
+ * the same priority.
+ */
+static inline
+void __plist_add_sorted (struct plist *plist, struct plist *pl)
+{
+	struct list_head *itr;
+	struct plist *itr_pl;
+
+
+	if (pl->prio < INT_MAX) {
+		list_for_each (itr, &plist->dp_node) {
+			itr_pl = list_entry (itr, struct plist, dp_node);
+			if (pl->prio == itr_pl->prio)
+				goto existing_sp_head;
+			else if (pl->prio < itr_pl->prio)
+				goto new_sp_head;
+		}
+		itr_pl = plist;
+		goto new_sp_head;
+	}
+	/* Append to end, SP list for prio INT_MAX */
+	itr_pl = container_of (plist->dp_node.prev, struct plist, dp_node);
+	if (!list_empty (&plist->dp_node) && itr_pl->prio == INT_MAX)
+		goto existing_sp_head;
+	itr_pl = plist;
+
+new_sp_head:
+	list_add_tail (&pl->dp_node, &itr_pl->dp_node);
+	INIT_LIST_HEAD (&pl->sp_node);
+	return;
+	
+existing_sp_head:
+	list_add_tail (&pl->sp_node, &itr_pl->sp_node);
+	INIT_LIST_HEAD (&pl->dp_node);
+	return;
+}
+
+
+/**
+ * Add node @pl to @plist @returns !0 if the plist prio changed, 0
+ * otherwise. 
+ */
+static inline
+unsigned plist_add (struct plist *pl, struct plist *plist)
+{
+	__plist_add_sorted (plist, pl);
+	/* Are we setting a higher priority? */
+	if (pl->prio < plist->prio) {
+		plist->prio = pl->prio;
+		return !0;
+	}
+	return 0;
+}
+
+
+/* Grunt to do the real removal work of @pl from the plist. */
+static inline
+void __plist_del (struct plist *pl)
+{
+	struct list_head *victim;
+	if (list_empty (&pl->dp_node))  	/* SP-node, not head */
+		victim = &pl->sp_node;
+	else if (list_empty (&pl->sp_node)) 	/* DP-node, empty SP list */
+		victim = &pl->dp_node;
+	else {					/* SP list head, not empty */
+		struct plist *pl_new = container_of (pl->sp_node.next,
+						     struct plist, sp_node);
+		victim = &pl->sp_node;
+		list_replace_rcu (&pl->dp_node, &pl_new->dp_node);
+	}
+	list_del_init (victim);
+}
+
+/**
+ * Remove a node @pl from @plist. @returns !0 if the plist prio
+ * changed, 0 otherwise.
+ */
+static inline
+unsigned plist_del (struct plist *plist, struct plist *pl)
+{
+	__plist_del (pl);
+	return plist_update_prio (plist);
+}
+
+/**
+ * plist_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static inline void plist_del_init(struct plist *plist, struct plist *pl)
+{
+        plist_del (plist, pl);
+        plist_init(pl, 0);
+}
+
+/* Return the priority a pl node */
+static inline
+int plist_prio (struct plist *pl)
+{
+	return pl->prio;
+}
+
+/* Change the priority of a pl node, without updating plist position */
+static inline
+void __plist_chprio (struct plist *pl, int new_prio)
+{
+	pl->prio = new_prio;
+}
+
+/**
+ * Change the priority of node @pl in @plist (updating the list's max
+ * priority).  @returns !0 if the plist's maximum priority changes
+ */
+static inline
+unsigned plist_chprio (struct plist *plist, struct plist *pl, int new_prio)
+{
+	if (new_prio == plist->prio)
+		return 0;
+	__plist_chprio (pl, new_prio);
+	__plist_del (pl);
+	__plist_add_sorted (plist, pl);
+	return __plist_update_prio (plist);
+}
+
+
+static inline
+struct plist * __plist_dp_next (struct plist *node_dp) 
+{
+	return container_of (node_dp->dp_node.next, struct plist, dp_node);
+}
+
+
+extern void __plist_splice (struct plist *dst, struct plist *src);
+
+/** Join @src plist to @dst plist and reinitialise @dst. @returns !0 */
+static inline
+unsigned plist_splice_init (struct plist *dst, struct plist *src)
+{
+	int old_prio;
+	if (plist_empty (src))
+		return 0;
+	old_prio = dst->prio;
+	__plist_splice (dst, src);
+	plist_init (src, INT_MAX);
+	return old_prio != dst->prio;
+}
+
+#endif /* #ifndef _LINUX_PLIST_H_ */
+
Index: linux-2.6.11/include/linux/rt_lock.h
===================================================================
--- linux-2.6.11.orig/include/linux/rt_lock.h	2005-04-07 17:47:32.000000000 +0000
+++ linux-2.6.11/include/linux/rt_lock.h	2005-04-07 17:47:42.000000000 +0000
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/plist.h>
 
 /*
  * These are the basic SMP spinlocks, allowing only a single CPU anywhere.
@@ -57,7 +58,7 @@
  */
 struct rt_mutex {
 	raw_spinlock_t		wait_lock;
-	struct list_head	wait_list;
+	struct plist		wait_list;
 	struct task_struct	*owner;
 	int			owner_prio;
 # ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -75,8 +76,8 @@
  */
 struct rt_mutex_waiter {
 	struct rt_mutex *lock;
-	struct list_head list;
-	struct list_head pi_list;
+	struct plist	 list;
+	struct plist	 pi_list;
 	struct task_struct *task;
 
 	unsigned long eip;	// for debugging
@@ -85,12 +86,12 @@
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	.wait_list = LIST_HEAD_INIT((lockname).wait_list), \
+	.wait_list = PLIST_INIT((lockname).wait_list, 0),  \
 	.name = #lockname, .file = __FILE__, .line = __LINE__ }
 #else
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	   LIST_HEAD_INIT((lockname).wait_list) }
+	PLIST_INIT((lockname).wait_list, 0) }
 #endif
 /*
  * RW-semaphores are an RT mutex plus a reader-depth count.
Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-04-07 17:47:32.000000000 +0000
+++ linux-2.6.11/include/linux/sched.h	2005-04-07 17:47:42.000000000 +0000
@@ -837,7 +837,7 @@
 
 	/* realtime bits */
 	struct list_head delayed_put;
-	struct list_head pi_waiters;
+	struct plist pi_waiters;
 
 	/* RT deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *blocked_on;
Index: linux-2.6.11/kernel/fork.c
===================================================================
--- linux-2.6.11.orig/kernel/fork.c	2005-04-07 17:47:32.000000000 +0000
+++ linux-2.6.11/kernel/fork.c	2005-04-07 17:47:42.000000000 +0000
@@ -990,7 +990,7 @@
  	}
 #endif
 	INIT_LIST_HEAD(&p->delayed_put);
-	INIT_LIST_HEAD(&p->pi_waiters);
+	plist_init(&p->pi_waiters, 0);
 	p->blocked_on = NULL; /* not blocked yet */
 
 	p->tgid = p->pid;
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-04-07 17:47:32.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-04-07 17:47:42.000000000 +0000
@@ -31,6 +31,7 @@
 #include <linux/kallsyms.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
+#include <linux/plist.h>
 
 /*
  * These flags are used for allowing of stealing of ownerships.
@@ -417,6 +418,7 @@
 void check_no_held_locks(struct task_struct *task)
 {
 	struct list_head *curr, *next, *cursor = NULL;
+	struct plist *curr1, *curr2;
 	struct rt_mutex *lock;
 	struct rt_mutex_waiter *w;
 	struct task_struct *p;
@@ -452,8 +454,8 @@
 		goto restart;
 	}
 	spin_lock(&pi_lock);
-	list_for_each(curr, &task->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
+	plist_for_each(curr1, curr2, &task->pi_waiters) {
+		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
 		TRACE_OFF();
 		spin_unlock(&pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
@@ -514,13 +516,13 @@
 		      struct task_struct *old_owner)
 {
 	struct rt_mutex_waiter *w;
-	struct list_head *curr;
+	struct plist *curr1, *curr2;
 
-	TRACE_WARN_ON(list_empty(&waiter->pi_list));
+	TRACE_WARN_ON(plist_empty(&waiter->pi_list));
 	TRACE_WARN_ON(lock->owner);
 
-	list_for_each(curr, &old_owner->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
+	plist_for_each(curr1, curr2, &old_owner->pi_waiters) {
+		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
 		if (w == waiter)
 			goto ok;
 	}
@@ -532,10 +534,10 @@
 check_pi_list_empty(struct rt_mutex *lock, struct task_struct *old_owner)
 {
 	struct rt_mutex_waiter *w;
-	struct list_head *curr;
+	struct plist *curr1, curr2;
 
-	list_for_each(curr, &old_owner->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
+	plist_for_each(curr1, curr2, &old_owner->pi_waiters) {
+		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
 			TRACE_OFF();
 			printk("hm, PI interest but no waiter? Old owner:\n");
@@ -569,17 +571,19 @@
 change_owner(struct rt_mutex *lock, struct task_struct *old_owner,
 		   struct task_struct *new_owner)
 {
-	struct list_head *curr, *next;
+	struct plist *next1, *next2, *curr1, *curr2;
 	struct rt_mutex_waiter *w;
 	int requeued = 0, sum = 0;
 
 	if (old_owner == new_owner)
 		return;
-	list_for_each_safe(curr, next, &old_owner->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
+
+	plist_for_each_safe(curr1, curr2, next1, next2, &old_owner->pi_waiters) {
+		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
-			list_del_init(curr);
-			list_add_tail(curr, &new_owner->pi_waiters);
+			plist_del(&w->pi_list, &old_owner->pi_waiters);
+			plist_init(&w->pi_list, w->task->prio);
+			plist_add(&w->pi_list, &new_owner->pi_waiters);
 			requeued++;
 		}
 		sum++;
@@ -626,31 +630,36 @@
 		/*
 		 * If the task is blocked on a lock, and we just made
 		 * it RT, then register the task in the PI list and
-		 * requeue it to the head of the wait list:
+		 * requeue it to the wait list:
 		 */
 		lock = w->lock;
 		TRACE_BUG_ON(!lock);
 		TRACE_BUG_ON(!lock->owner);
-		if (rt_task(p) && list_empty(&w->pi_list)) {
+		if (rt_task(p) && plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON(was_rt);
-			list_add_tail(&w->pi_list, &lock->owner->pi_waiters);
-			list_del(&w->list);
-			list_add(&w->list, &lock->wait_list);
+			plist_init(&w->pi_list, prio);
+			plist_add(&w->pi_list, &lock->owner->pi_waiters);
+
+			plist_del(&w->list, &lock->wait_list);
+			plist_init(&w->list, prio);
+			plist_add(&w->list, &lock->wait_list);
+
 		}
 		/*
 		 * If the task is blocked on a lock, and we just restored
 		 * it from RT to non-RT then unregister the task from
-		 * the PI list and requeue it to the tail of the wait
-		 * list:
+		 * the PI list and requeue it to the wait list.
 		 *
 		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
 		 *        get PI handled.)
 		 */
-		if (!rt_task(p) && !list_empty(&w->pi_list)) {
+		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON(!was_rt);
-			list_del(&w->pi_list);
-			list_del(&w->list);
-			list_add_tail(&w->list, &lock->wait_list);
+			plist_del(&w->pi_list, &lock->owner->pi_waiters);
+			plist_del(&w->list, &lock->wait_list);
+			plist_init(&w->list, prio);
+			plist_add(&w->list, &lock->wait_list);
+
 		}
 
 		pi_walk++;
@@ -679,22 +688,22 @@
 	task->blocked_on = waiter;
 	waiter->lock = lock;
 	waiter->task = task;
-	INIT_LIST_HEAD(&waiter->pi_list);
+	plist_init(&waiter->pi_list, task->prio);
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
 #ifndef ALL_TASKS_PI
 	if (!rt_task(task)) {
-		list_add_tail(&waiter->list, &lock->wait_list);
+		plist_add(&waiter->list, &lock->wait_list);
 		return;
 	}
 #endif
 	spin_lock(&pi_lock);
-	list_add_tail(&waiter->pi_list, &lock->owner->pi_waiters);
+	plist_add(&waiter->pi_list, &lock->owner->pi_waiters);
 	/*
 	 * Add RT tasks to the head:
 	 */
-	list_add(&waiter->list, &lock->wait_list);
+	plist_add(&waiter->list, &lock->wait_list);
 	/*
 	 * If the waiter has higher priority than the owner
 	 * then temporarily boost the owner:
@@ -712,7 +721,7 @@
 {
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
-	INIT_LIST_HEAD(&lock->wait_list);
+	plist_init(&lock->wait_list, 0);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	lock->save_state = save_state;
 	INIT_LIST_HEAD(&lock->held_list);
@@ -754,44 +763,26 @@
 		struct task_struct *old_owner, int save_state,
 		unsigned long eip)
 {
-	struct rt_mutex_waiter *w, *waiter = NULL;
+	struct rt_mutex_waiter *waiter = NULL;
 	struct task_struct *new_owner;
-	struct list_head *curr;
 
 	/*
 	 * Get the highest prio one:
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	list_for_each(curr, &lock->wait_list) {
-		w = list_entry(curr, struct rt_mutex_waiter, list);
-		trace_special_pid(w->task->pid, w->task->prio, 0);
-		/*
-		 * Break out upon meeting the first non-RT-prio
-		 * task - we inserted them to the tail, so if we
-	 	 * see the first one the rest is SCHED_NORMAL too:
-	 	 */
-		if (!rt_task(w->task))
-			break;
-		if (!waiter || w->task->prio <= waiter->task->prio)
-			waiter = w;
-	}
+	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 
-	/*
-	 * If no RT waiter then pick the first one:
-	 */
-	if (!waiter)
-		waiter = list_entry(lock->wait_list.next,
-					struct rt_mutex_waiter, list);
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
 #ifdef ALL_TASKS_PI
 	check_pi_list_present(lock, waiter, old_owner);
 #endif
 	new_owner = waiter->task;
-	list_del_init(&waiter->list);
+	plist_del_init(&lock->wait_list, &waiter->list);
 
-	list_del_init(&waiter->pi_list);
+	plist_del(&waiter->pi_list, &old_owner->pi_waiters);
+	plist_init(&waiter->pi_list, waiter->task->prio);
 
 	set_new_owner(lock, old_owner, new_owner, waiter->eip);
 	/* Don't touch waiter after ->task has been NULLed */
@@ -806,8 +797,8 @@
 static inline void init_lists(struct rt_mutex *lock)
 {
 	// we have to do this until the static initializers get fixed:
-	if (!lock->wait_list.prev && !lock->wait_list.next)
-		INIT_LIST_HEAD(&lock->wait_list);
+	if (!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next)
+		plist_init(&lock->wait_list, 0);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	if (!lock->held_list.prev && !lock->held_list.next)
 		INIT_LIST_HEAD(&lock->held_list);
@@ -936,7 +927,7 @@
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1032,7 +1023,7 @@
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1042,6 +1033,7 @@
 		return;
 	}
 
+	plist_init (&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1171,7 +1163,7 @@
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1183,6 +1175,7 @@
 
 	set_task_state(task, TASK_INTERRUPTIBLE);
 
+	plist_init (&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1207,14 +1200,15 @@
 			trace_lock_irq(&trace_lock);
 			spin_lock(&lock->wait_lock);
 			if (waiter.task) {
-				list_del_init(&waiter.list);
+				plist_del_init(&lock->wait_list, &waiter.list);
 				/*
 				 * Just remove ourselves from the PI list.
 				 * (No big problem if our PI effect lingers
 				 *  a bit - owner will restore prio.)
 				 */
 				spin_lock(&pi_lock);
-				list_del_init(&waiter.pi_list);
+				plist_del(&waiter.pi_list, &lock->owner->pi_waiters);
+				plist_init(&waiter.pi_list, waiter.task->prio);
 				spin_unlock(&pi_lock);
 				ret = -EINTR;
 			}
@@ -1262,7 +1256,7 @@
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!list_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1321,7 +1315,6 @@
 {
 	struct task_struct *old_owner, *new_owner;
 	struct rt_mutex_waiter *w;
-	struct list_head *curr;
 	unsigned long flags;
 	int prio;
 
@@ -1330,7 +1323,7 @@
 	trace_lock_irqsave(&trace_lock, flags);
 	TRACE_BUG_ON(!irqs_disabled());
 	spin_lock(&lock->wait_lock);
-	TRACE_BUG_ON(!lock->wait_list.prev && !lock->wait_list.next);
+	TRACE_BUG_ON(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	TRACE_WARN_ON(list_empty(&lock->held_list));
@@ -1340,12 +1333,12 @@
 
 	old_owner = lock->owner;
 #ifdef ALL_TASKS_PI
-	if (list_empty(&lock->wait_list))
+	if (plist_empty(&lock->wait_list))
 		check_pi_list_empty(lock, old_owner);
 #endif
 	lock->owner = NULL;
 	new_owner = NULL;
-	if (!list_empty(&lock->wait_list))
+	if (!plist_empty(&lock->wait_list))
 		new_owner = pick_new_owner(lock, old_owner, save_state, eip);
 
 	/*
@@ -1354,11 +1347,9 @@
 	 * waiter's priority):
 	 */
 	prio = mutex_getprio(old_owner);
-	list_for_each(curr, &old_owner->pi_waiters) {
-		w = list_entry(curr, struct rt_mutex_waiter, pi_list);
-		if (w->task->prio < prio)
-			prio = w->task->prio;
-		trace_special_pid(w->task->pid, w->task->prio, 0);
+	if (new_owner && !plist_empty(&new_owner->pi_waiters)) {
+		w = plist_entry(&new_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		prio = w->task->prio;
 	}
 	if (prio != old_owner->prio)
 		pi_setprio(lock, old_owner, prio);





