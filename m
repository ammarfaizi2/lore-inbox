Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVEIOkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVEIOkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVEIOjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:39:54 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:34223 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261408AbVEIOcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:32:39 -0400
Message-ID: <427F7637.4D2DDF3E@tv-sign.ru>
Date: Mon, 09 May 2005 18:39:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 1/4] rt_mutex: remove old plist implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All these patches are against -RT-2.6.12-rc4-V0.7.47-01.
The patched kernel has survived after "make -j8 bzImage" on 2 CPU box.

This one removes old plist's implementation (include/linux/plist.h).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- V0.7.47-01/include/linux/plist.h~0_DEL	2005-05-09 20:41:47.000000000 +0400
+++ V0.7.47-01/include/linux/plist.h	2005-05-09 20:55:04.672805728 +0400
@@ -1,310 +0,0 @@
-/*
- * Descending-priority-sorted double-linked list
- *
- * (C) 2002-2003 Intel Corp
- * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
- *
- * 2001-2005 (c) MontaVista Software, Inc.
- * Daniel Walker <dwalker@mvista.com>
- *
- * Licensed under the FSF's GNU Public License v2 or later.
- *
- * Based on simple lists (include/linux/list.h).
- *
- * 
- * This is a priority-sorted list of nodes; each node has a >= 0
- * priority from 0 (highest) to INT_MAX (lowest). The list itself has
- * a priority too (the highest of all the nodes), stored in the head
- * of the list (that is a node itself).
- *
- * Addition is O(1), removal is O(1), change of priority of a node is
- * O(1).
- *
- * Addition and change of priority's order is really O(K), where K is
- * a constant being the maximum number of different priorities you
- * will store in the list. Being a constant, it means it is O(1).
- *
- * This list is really a list of lists:
- *
- *  - The tier 1 list is the dp list (Different Priority)
- *
- *  - The tier 2 list is the sp list (Same Priority)
- *
- * All the nodes in a SP list have the same priority, and all the DP
- * lists have different priorities (and are sorted by priority, of
- * course).
- *
- * Addition means: look for the DP node in the DP list for the
- * priority of the node and append to the SP list corresponding to
- * that node. If it is the first node of that priority, add it to the
- * DP list in the right position and it will be the head of the SP
- * list for his priority.
- *
- * Removal means remove it from the SP list corresponding to its
- * prio. If it is the only one, it means its also the head and thus a
- * DP node, so we remove it from the DP list. If it is the head but
- * there are others in its SP list, then we remove it from both and
- * get the first one of the SP list to be the new head.
- *
- * INT_MIN is the highest priority, 0 is the medium highest, INT_MAX
- * is lowest priority.
- *
- * No locking is done, up to the caller.
- *
- * NOTE: This implementation does not offer as many interfaces as
- *       linux/list.h does -- it is lazily minimal. You are welcome to
- *       add them.
- */
-
-#ifndef _LINUX_PLIST_H_
-#define _LINUX_PLIST_H_
-
-#include <linux/kernel.h>
-#include <linux/list.h>
-
-/* Priority-sorted list */
-struct plist {
-	int prio;
-	struct list_head dp_node;
-	struct list_head sp_node;
-};
-
-#define PLIST_INIT(p,__prio)				\
-{							\
-	.prio = __prio,					\
-	.dp_node = LIST_HEAD_INIT((p).dp_node),	\
-	.sp_node = LIST_HEAD_INIT((p).sp_node),	\
-}
-
-/**
- * plist_entry - get the struct for this entry
- * @ptr:        the &struct plist pointer.
- * @type:       the type of the struct this is embedded in.
- * @member:     the name of the list_struct within the struct.
- */
-#define plist_entry(ptr, type, member) \
-        container_of(plist_first (ptr), type, member)
-/**
- * plist_for_each  -       iterate over the plist
- * @pos1:        the type * to use as a loop counter.
- * @pos1:        the type * to use as a second loop counter.
- * @head:       the head for your list.
- */
-#define plist_for_each(pos1, pos2, head)	\
-	list_for_each_entry(pos1, &((head)->dp_node), dp_node)	\
-		list_for_each_entry(pos2, &((pos1)->sp_node), sp_node)
-/**
- * plist_for_each_entry_safe - iterate over a plist of given type safe against removal of list entry
- * @pos1:        the type * to use as a loop counter.
- * @pos2:        the type * to use as a loop counter.
- * @n1:          another type * to use as temporary storage
- * @n2:          another type * to use as temporary storage
- * @head:       the head for your list.
- */
-#define plist_for_each_safe(pos1, pos2, n1, n2, head)			\
-	list_for_each_entry_safe(pos1, n1, &((head)->dp_node), dp_node)	\
-		list_for_each_entry_safe(pos2, n2, &((pos1)->sp_node), sp_node)
-
-/* Initialize a pl */
-static inline
-void plist_init (struct plist *pl, int prio)
-{
-	pl->prio = prio;
-	INIT_LIST_HEAD (&pl->dp_node);
-	INIT_LIST_HEAD (&pl->sp_node);
-}
-
-/* Return the first node (and thus, highest priority)
- *
- * Assumes the plist is _not_ empty.
- */
-static inline
-struct plist * plist_first (struct plist *plist)
-{
-	return list_entry (plist->dp_node.next, struct plist, dp_node);
-}
-
-/* Return if the plist is empty. */
-static inline
-unsigned plist_empty (const struct plist *plist)
-{
-	return list_empty (&plist->dp_node);
-}
-
-/* Update the maximum priority of the whole list
- *
- * @returns !0 if the plist prio changed, 0 otherwise.
- * 
- * __plist_update_prio() assumes the plist is not empty.
- */
-static inline
-unsigned __plist_update_prio (struct plist *plist)
-{
-	int prio = plist_first (plist)->prio;
-	if (plist->prio == prio)
-		return 0;
-	plist->prio = prio;
-	return !0;
-}
-
-static inline
-unsigned plist_update_prio (struct plist *plist)
-{
-	int old_prio = plist->prio;
-	/* plist empty, lowest prio = INT_MAX */
-	plist->prio = plist_empty (plist)? INT_MAX : plist_first (plist)->prio;
-	return old_prio != plist->prio;
-}
-
-/* Add a node to the plist [internal]
- *
- * pl->prio == INT_MAX is an special case, means low priority, get
- * down to the end of the plist. Note the we want FIFO behaviour on
- * the same priority.
- */
-static inline
-void __plist_add_sorted (struct plist *plist, struct plist *pl)
-{
-	struct list_head *itr;
-	struct plist *itr_pl;
-
-
-	if (pl->prio < INT_MAX) {
-		list_for_each (itr, &plist->dp_node) {
-			itr_pl = list_entry (itr, struct plist, dp_node);
-			if (pl->prio == itr_pl->prio)
-				goto existing_sp_head;
-			else if (pl->prio < itr_pl->prio)
-				goto new_sp_head;
-		}
-		itr_pl = plist;
-		goto new_sp_head;
-	}
-	/* Append to end, SP list for prio INT_MAX */
-	itr_pl = container_of (plist->dp_node.prev, struct plist, dp_node);
-	if (!list_empty (&plist->dp_node) && itr_pl->prio == INT_MAX)
-		goto existing_sp_head;
-	itr_pl = plist;
-
-new_sp_head:
-	list_add_tail (&pl->dp_node, &itr_pl->dp_node);
-	INIT_LIST_HEAD (&pl->sp_node);
-	return;
-	
-existing_sp_head:
-	list_add_tail (&pl->sp_node, &itr_pl->sp_node);
-	INIT_LIST_HEAD (&pl->dp_node);
-	return;
-}
-
-
-/**
- * Add node @pl to @plist @returns !0 if the plist prio changed, 0
- * otherwise. 
- */
-static inline
-unsigned plist_add (struct plist *pl, struct plist *plist)
-{
-	__plist_add_sorted (plist, pl);
-	/* Are we setting a higher priority? */
-	if (pl->prio < plist->prio) {
-		plist->prio = pl->prio;
-		return !0;
-	}
-	return 0;
-}
-
-
-/* Grunt to do the real removal work of @pl from the plist. */
-static inline
-void __plist_del (struct plist *pl)
-{
-	struct list_head *victim;
-	if (list_empty (&pl->dp_node))  	/* SP-node, not head */
-		victim = &pl->sp_node;
-	else if (list_empty (&pl->sp_node)) 	/* DP-node, empty SP list */
-		victim = &pl->dp_node;
-	else {					/* SP list head, not empty */
-		struct plist *pl_new = container_of (pl->sp_node.next,
-						     struct plist, sp_node);
-		victim = &pl->sp_node;
-		list_replace_rcu (&pl->dp_node, &pl_new->dp_node);
-	}
-	list_del_init (victim);
-}
-
-/**
- * Remove a node @pl from @plist. @returns !0 if the plist prio
- * changed, 0 otherwise.
- */
-static inline
-unsigned plist_del (struct plist *pl, struct plist *plist)
-{
-	__plist_del (pl);
-	return plist_update_prio (plist);
-}
-
-/**
- * plist_del_init - deletes entry from list and reinitialize it.
- * @entry: the element to delete from the list.
- */
-static inline void plist_del_init(struct plist *pl, struct plist *plist)
-{
-        plist_del (pl, plist);
-        plist_init(pl, INT_MAX);
-}
-
-/* Return the priority a pl node */
-static inline
-int plist_prio (struct plist *pl)
-{
-	return pl->prio;
-}
-
-/* Change the priority of a pl node, without updating plist position */
-static inline
-void __plist_chprio (struct plist *pl, int new_prio)
-{
-	pl->prio = new_prio;
-}
-
-/**
- * Change the priority of node @pl in @plist (updating the list's max
- * priority).  @returns !0 if the plist's maximum priority changes
- */
-static inline
-unsigned plist_chprio (struct plist *plist, struct plist *pl, int new_prio)
-{
-	if (new_prio == plist->prio)
-		return 0;
-	__plist_chprio (pl, new_prio);
-	__plist_del (pl);
-	__plist_add_sorted (plist, pl);
-	return __plist_update_prio (plist);
-}
-
-
-static inline
-struct plist * __plist_dp_next (struct plist *node_dp) 
-{
-	return container_of (node_dp->dp_node.next, struct plist, dp_node);
-}
-
-
-extern void __plist_splice (struct plist *dst, struct plist *src);
-
-/** Join @src plist to @dst plist and reinitialise @dst. @returns !0 */
-static inline
-unsigned plist_splice_init (struct plist *dst, struct plist *src)
-{
-	int old_prio;
-	if (plist_empty (src))
-		return 0;
-	old_prio = dst->prio;
-	__plist_splice (dst, src);
-	plist_init (src, INT_MAX);
-	return old_prio != dst->prio;
-}
-
-#endif /* #ifndef _LINUX_PLIST_H_ */
-
