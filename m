Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVFEARj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFEARj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFEARi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 20:17:38 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61933
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261447AbVFEAQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 20:16:44 -0400
Subject: patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Oleg Nesterov <oleg@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 02:17:12 +0200
Message-Id: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes a couple of really annoying issues in the PI code of the
Real-Time-Preemption patch

1. Fix the insertion order according to the specified intentions

The desired action was inserting in descending priority and FIFO mode
for matching priority. The resulting action of the code was inserting in
descending priority and inverse FIFO mode for matching priority. 

2. Add the proper list_head initializer in the replacement path.

3. Remove the bogus checks in the delete function for 
 A. !list_empty(&pl->sp_node)
 B. else if (pl->prio == pl_new->prio)

Those checks just covered the dumbest implementation detail of plist at
all. See 4.)

4. Make plist_entry() work as expected by anybody who ever used
list_entry(). Add a plist_first_entry macro for those places where the
provided functionality was accidentaly correct.

Application example:

plist_for_each_safe(curr1, next1, &old_owner->pi_waiters) {
	w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
	.....
}

A moderate experienced Linux programmer would expect, that
plist_entry(curr1,...) returns the first entry of the list
&old_owner->pi_waiters. Looking into the plist_entry macro after
spending hours of witchcrafting reviels that the result is the next
entry of the first entry of the list.

#define plist_entry(ptr, type, member) \
	container_of(plist_first(ptr), type, member)

No further comment necessary.

5. Modify the comments in the header file to explain the real intention
of the implemenation.

Changing fundamental implemtation details and keeping the original
comments is just provoking false assumptions. I apologize hereby for all
maledictions I addressed to the original author.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index linux/lib/plist.c
===================================================================
--- linux/lib/plist.c	(revision 434)
+++ linux/lib/plist.c	(working copy)
@@ -9,6 +9,10 @@
  * 2001-2005 (c) MontaVista Software, Inc.
  * Daniel Walker <dwalker@mvista.com>
  *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ * Tested and made it functional. I'm still pondering if it is
+ * worth the trouble.
+ *
  * Licensed under the FSF's GNU Public License v2 or later.
  *
  * Based on simple lists (include/linux/list.h).
@@ -17,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/rt_lock.h>
 
+
 /* Initialize a pl */
 void plist_init(struct plist *pl, int prio)
 {
@@ -63,7 +68,6 @@
 	struct list_head *itr;
 	struct plist *itr_pl, *itr_pl2;
 
-
 	if (pl->prio < INT_MAX) {
 		list_for_each(itr, &plist->dp_node) {
 			itr_pl = list_entry(itr, struct plist, dp_node);
@@ -82,13 +86,12 @@
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
 
@@ -107,22 +110,21 @@
 	return 0;
 }
 
-
 /* Grunt to do the real removal work of @pl from the plist. */
 static inline
-void __plist_del(struct plist *pl)
+void  __plist_del(struct plist *pl)
 {
-	if (!list_empty(&pl->sp_node) && !list_empty(&pl->dp_node)) {
-		/* SP list head, not empty */
-		struct plist *pl_new = container_of(pl->sp_node.prev,
-							struct plist, sp_node);
-
-		if (pl->dp_node.prev == &pl_new->dp_node) {
+	if (!list_empty(&pl->dp_node)) {
+		struct plist *pl_new = container_of(pl->sp_node.next,
+						    struct plist, sp_node);
+	
+		if (pl->dp_node.next == &pl_new->dp_node) {
 			/* end of this priorities list */
 			list_del_init(&pl->dp_node);
-		} else if (pl->prio == pl_new->prio) {
+		} else {
 			list_replace_rcu(&pl->dp_node, &pl_new->dp_node);
-		} 
+			INIT_LIST_HEAD(&pl->dp_node);
+		}
 	}
 	list_del_init(&pl->sp_node);
 }
@@ -162,7 +164,7 @@
  */
 unsigned plist_chprio(struct plist *plist, struct plist *pl, int new_prio)
 {
-	if (new_prio == plist->prio)
+	if (new_prio == pl->prio)
 		return 0;
 
 	__plist_chprio(pl, new_prio);

Index linux/include/linux/plist.h
===================================================================
--- linux/include/linux/plist.h	(revision 426)
+++ linux/include/linux/plist.h	(working copy)
@@ -7,6 +7,11 @@
  * 2001-2005 (c) MontaVista Software, Inc.
  * Daniel Walker <dwalker@mvista.com>
  *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ * Tested and made it functional. Removed the bogus O(1)
+ * claim from the comment and put some understandable
+ * explanation in it.
+ *
  * Licensed under the FSF's GNU Public License v2 or later.
  *
  * Based on simple lists (include/linux/list.h).
@@ -17,35 +22,50 @@
  * a priority too (the highest of all the nodes), stored in the head
  * of the list (that is a node itself).
  *
- * Addition is O(1), removal is O(1), change of priority of a node is
- * O(1).
+ * Addition is O(N), removal is O(1), change of priority of a node is
+ * O(N).
  *
- * Addition and change of priority's order is really O(K), where K is
- * a constant being the maximum number of different priorities you
- * will store in the list. Being a constant, it means it is O(1).
- *
  * This list is really a list of lists:
  *
  *  - The tier 1 list is the dp list (Different Priority)
  *
- *  - The tier 2 list is the sp list (Same Priority)
+ *  - The tier 2 list is the sp list (Serialized Priority)
  *
- * All the nodes in a SP list have the same priority, and all the DP
- * lists have different priorities (and are sorted by priority, of
- * course).
+ * Simple ASCII art explanation:
  *
- * Addition means: look for the DP node in the DP list for the
- * priority of the node and append to the SP list corresponding to
- * that node. If it is the first node of that priority, add it to the
- * DP list in the right position and it will be the head of the SP
- * list for his priority.
+ * |HEAD   |
+ * |       |
+ * |dp.prev|<------------------------------------|   
+ * |dp.next|<->|dp|<->|dp|<--------------->|dp|<-|
+ * |10     |   |10|   |21|   |21|   |21|   |40|   (prio)
+ * |       |   |  |   |  |   |  |   |  |   |  |
+ * |       |   |  |   |  |   |  |   |  |   |  |
+ * |sp.next|<->|sp|<->|sp|<->|sp|<->|sp|<->|sp|<-|
+ * |sp.prev|<------------------------------------|   
  *
- * Removal means remove it from the SP list corresponding to its
- * prio. If it is the only one, it means its also the head and thus a
- * DP node, so we remove it from the DP list. If it is the head but
- * there are others in its SP list, then we remove it from both and
- * get the first one of the SP list to be the new head.
+ * The nodes on the dp list are sorted by priority to simplify
+ * the insertion of new nodes. There are no nodes with duplicate 
+ * priorites on the list.
  *
+ * The nodes on the sp list are ordered by priority and can contain
+ * entries which have the same priority. Those entries are ordered
+ * FIFO
+ * 
+ * Addition means: look for the dp node in the dp list for the
+ * priority of the node and insert it before the sp entry of the next 
+ * dp node. If it is the first node of that priority, add it to the
+ * dp list in the right position and insert it into the serialized
+ * sp list
+ *
+ * Removal means remove it from the sp list and remove it from the dp
+ * list if the dp list_head is non empty. In case of removal from the 
+ * dp list it must be checked whether other entries of the same 
+ * priority are on the list or not. If there is another entry of
+ * the same priority then this entry has to replace the
+ * removed entry on the dp list. If the entry which is removed is 
+ * the only entry of this priority then a simple remove from both
+ * list is sufficient.
+ *
  * INT_MIN is the highest priority, 0 is the medium highest, INT_MAX
  * is lowest priority.
  *
@@ -83,7 +103,17 @@
  * @member:     the name of the list_struct within the struct.
  */
 #define plist_entry(ptr, type, member) \
+        container_of(ptr, type, member)
+
+/**
+ * plist_first_entry - get the struct for the first entry
+ * @ptr:        the &struct plist pointer.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_struct within the struct.
+ */
+#define plist_first_entry(ptr, type, member) \
         container_of(plist_first(ptr), type, member)
+
 /**
  * plist_for_each  -       iterate over the plist
  * @pos1:        the type * to use as a loop counter.

Index linux/kernel/rt.c
===================================================================
--- linux/kernel/rt.c	(revision 426)
+++ linux/kernel/rt.c	(working copy)
@@ -773,7 +773,7 @@
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
@@ -1351,7 +1351,7 @@
 	 */
 	prio = mutex_getprio(old_owner);
 	if (!plist_empty(&old_owner->pi_waiters)) {
-		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
 		if (w->task->prio < prio)
 			prio = w->task->prio;
 	}


