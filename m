Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267813AbUGWPn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267813AbUGWPn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267816AbUGWPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:43:14 -0400
Received: from fmr05.intel.com ([134.134.136.6]:42117 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267803AbUGWPkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:40:31 -0400
Date: Fri, 23 Jul 2004 08:48:53 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 2/11: priority based O(1) lists
Message-ID: <0407230848.sbNbGcKasaWc~dJbcd.aMbgbvagckbtd17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230848.EcGcBbZblaAaZdEd0b6aedFc7aRb4bva17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are lists similar to the ones in linux/list.h; however,
they are sorted by descending priority, which each node has;
as well, nodes with the same priority are queued together in
sublist, so insertion is O(K), where K is a constant meaning
the number of different priorities you are using [in the case
of the scheduler, it'd be O(140)].


 include/linux/plist.h |  268 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile          |    2 
 lib/plist.c           |   96 +++++++++++++++++
 3 files changed, 365 insertions(+), 1 deletion(-)

--- /dev/null	Thu Jul 22 14:30:56 2004
+++ include/linux/plist.h Tue Jul 20 03:21:03 2004
@@ -0,0 +1,268 @@
+/*
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
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
+#include <linux/list.h>
+
+/* Priority-sorted list */
+struct plist {
+	int prio;
+	struct list_head dp_node;
+	struct list_head sp_node;
+};
+
+#define plist_INIT(p,__prio)				\
+{							\
+	.prio = __prio,					\
+	.dp_node = LIST_HEAD_INIT((p)->dp_node),	\
+	.sp_node = LIST_HEAD_INIT((p)->sp_node),	\
+}
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
+unsigned plist_add (struct plist *plist, struct plist *pl)
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
+		list_replace (&pl_new->dp_node, &pl->dp_node);
+	}
+	list_del_init (victim);
+}
+
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
+/** Join @src plist to @src plist and reinitialise @src. @returns !0 */
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
--- lib/Makefile:1.1.1.6 Tue Apr 6 00:23:06 2004
+++ lib/Makefile Sun Jul 18 19:19:38 2004
@@ -6,7 +6,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o
+	 bitmap.o extable.o plist.o
 
 # hack for now till some static code uses krefs, then it can move up above...
 obj-y += kref.o
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ lib/plist.c Sun Jul 18 19:19:27 2004
@@ -0,0 +1,96 @@
+
+/*
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2004 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
+ *
+ * See include/linux/plist.h for the whole story.
+ */
+
+#include <linux/plist.h>
+
+/**
+ * Join @src plist to @dst plist.
+ */
+void __plist_splice (struct plist *dst, struct plist *src)
+{
+#warning FIXME: Lame plist_splice--fix the optimized version
+#if 1
+	/*
+	 * Lame quick version that for sure doesn't fail but is O(N^2)
+	 * and pretty slow.
+	 */
+	struct plist *itr;
+	while (!plist_empty (src)) {
+		itr = plist_first (src);
+		plist_del (src, itr);
+		plist_add (dst, itr);
+	}
+#else
+	/*
+	 * This version is broken, don't use it. Works generally, but
+	 * sometimes it screws up, so I need to check it in detail.
+	 */
+	
+	struct plist *src_dp_itr, *dst_dp_itr, *src_dp_next;
+	
+	if (plist_empty (src))
+		return;
+
+	src_dp_itr = __plist_dp_next (src);
+	dst_dp_itr = __plist_dp_next (dst);
+	
+	while (1) {
+		/* Insert src before dst */
+		if (src_dp_itr->prio < dst_dp_itr->prio) {
+			src_dp_next = __plist_dp_next (src_dp_itr);
+			list_del_init (&src_dp_itr->dp_node);
+			list_add_tail (&src_dp_itr->dp_node,
+				       &dst_dp_itr->dp_node);
+			if (src_dp_next == src)
+				break;
+			src_dp_itr = src_dp_next;
+			continue;
+		}
+		/* Append to dst's SP list--note our first SP node is
+		 * not just a head, is also part of the list
+		 * itself, so we have to do it manually */
+		else if (src_dp_itr->prio == dst_dp_itr->prio) {
+			struct list_head *src_sp_first, *src_sp_last,
+				*dst_sp_first, *dst_sp_last;
+
+			src_dp_next = __plist_dp_next (src_dp_itr);
+			list_del_init (&dst_dp_itr->dp_node);
+			
+			src_sp_first = &src_dp_itr->sp_node;
+			src_sp_last = src_dp_itr->sp_node.prev;
+			dst_sp_first = &dst_dp_itr->sp_node;
+			dst_sp_last = dst_dp_itr->sp_node.prev;
+
+			dst_sp_first->prev = src_sp_last;
+			dst_sp_last->next = src_sp_first;
+			src_sp_first->prev = dst_sp_last;
+			src_sp_last->next = dst_sp_first;
+				
+			if (src_dp_next == src)
+				break;
+			src_dp_itr = src_dp_next;
+			continue;
+		}
+		dst_dp_itr = __plist_dp_next (dst_dp_itr);
+		/* Dest list finished, we just can append the
+		 * remainder of the source list */
+		if (dst_dp_itr == dst) {
+			__list_splice (src_dp_itr->dp_node.prev,
+				       dst_dp_itr->dp_node.prev);
+			break;
+		}
+	}
+	dst->prio = __plist_dp_next (dst)->prio;
+#endif /* #if 1 */
+}
