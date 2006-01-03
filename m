Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWACRxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWACRxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWACRxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:53:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30709 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750913AbWACRxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:53:33 -0500
Subject: [PATCH 01/02] Add back plist docs
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, tglx@linutronix.de,
       inaky.perez-gonzalez@intel.com
Content-Type: text/plain
Date: Tue, 03 Jan 2006 09:53:30 -0800
Message-Id: <1136310811.5915.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Add back copyrights, documentation, and function descriptions.
Updated with Oleg's comments .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/include/linux/plist.h
===================================================================
--- linux-2.6.15.orig/include/linux/plist.h
+++ linux-2.6.15/include/linux/plist.h
@@ -1,3 +1,77 @@
+/*
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * 2001-2005 (c) MontaVista Software, Inc.
+ * Daniel Walker <dwalker@mvista.com>
+ *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ * Tested and made it functional.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
+ *
+ *
+ * This is a priority-sorted list of nodes; each node has a 
+ * priority from INT_MIN (highest) to INT_MAX (lowest). 
+ *
+ * Addition is O(K), removal is O(1), change of priority of a node is
+ * O(K) and K is the number of RT priority levels used in the system.
+ * (1 <= K <= 99)
+ *
+ * This list is really a list of lists:
+ *
+ *  - The tier 1 list is the prio_list, different priority nodes.
+ *
+ *  - The tier 2 list is the node_list, serialized nodes.
+ *
+ * Simple ASCII art explanation:
+ *
+ * |HEAD          |
+ * |              |
+ * |prio_list.prev|<------------------------------------|
+ * |prio_list.next|<->|pl|<->|pl|<--------------->|pl|<-|
+ * |10            |   |10|   |21|   |21|   |21|   |40|   (prio)
+ * |              |   |  |   |  |   |  |   |  |   |  |
+ * |              |   |  |   |  |   |  |   |  |   |  |
+ * |node_list.next|<->|nl|<->|nl|<->|nl|<->|nl|<->|nl|<-|
+ * |node_list.prev|<------------------------------------|
+ *
+ * The nodes on the prio_list list are sorted by priority to simplify
+ * the insertion of new nodes. There are no nodes with duplicate
+ * priorites on the list.
+ *
+ * The nodes on the node_list is ordered by priority and can contain
+ * entries which have the same priority. Those entries are ordered
+ * FIFO
+ *
+ * Addition means: look for the prio_list node in the prio_list 
+ * for the priority of the node and insert it before the node_list 
+ * entry of the next prio_list node. If it is the first node of 
+ * that priority, add it to the prio_list in the right position and 
+ * insert it into the serialized node_list list
+ *
+ * Removal means remove it from the node_list and remove it from 
+ * the prio_list if the node_list list_head is non empty. In case 
+ * of removal from the prio_list it must be checked whether other 
+ * entries of the same priority are on the list or not. If there 
+ * is another entry of the same priority then this entry has to 
+ * replace the removed entry on the prio_list. If the entry which 
+ * is removed is the only entry of this priority then a simple 
+ * remove from both list is sufficient.
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
 #ifndef _LINUX_PLIST_H_
 #define _LINUX_PLIST_H_
 
@@ -13,24 +87,46 @@ struct pl_node {
 	struct pl_head	plist;
 };
 
+/** 
+ * #PL_HEAD_INIT - static struct pl_head initializer
+ *
+ * @head:	struct pl_head variable name
+ */
 #define PL_HEAD_INIT(head)	\
 {							\
 	.prio_list = LIST_HEAD_INIT((head).prio_list),	\
 	.node_list = LIST_HEAD_INIT((head).node_list),	\
 }
 
+/** 
+ * #PL_NODE_INIT - static struct pl_node initializer
+ *
+ * @node:	struct pl_node variable name
+ * @__prio:	initial node priority	
+ */
 #define PL_NODE_INIT(node, __prio)	\
 {							\
 	.prio  = (__prio),				\
 	.plist = PL_HEAD_INIT((node).plist),		\
 }
 
+/**
+ * pl_head_init - dynamic struct pl_head initializer
+ *
+ * @head:	&struct pl_head pointer
+ */ 
 static inline void pl_head_init(struct pl_head *head)
 {
 	INIT_LIST_HEAD(&head->prio_list);
 	INIT_LIST_HEAD(&head->node_list);
 }
 
+/**
+ * pl_node_init - Dynamic struct pl_node initializer
+ *
+ * @node:	&struct pl_node pointer
+ * @prio:	initial node priority
+ */
 static inline void pl_node_init(struct pl_node *node, int prio)
 {
 	node->prio = prio;
@@ -40,23 +136,63 @@ static inline void pl_node_init(struct p
 extern void plist_add(struct pl_node *node, struct pl_head *head);
 extern void plist_del(struct pl_node *node);
 
+/**
+ * plist_for_each - iterate over the plist
+ *
+ * @pos1:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ */
 #define plist_for_each(pos, head)	\
 	 list_for_each_entry(pos, &(head)->node_list, plist.node_list)
 
+/**
+ * plist_for_each_entry_safe - iterate over a plist of given type safe 
+ * against removal of list entry
+ *
+ * @pos1:	the type * to use as a loop counter.
+ * @n1:	another type * to use as temporary storage
+ * @head:	the head for your list.
+ */
 #define plist_for_each_safe(pos, n, head)	\
 	 list_for_each_entry_safe(pos, n, &(head)->node_list, plist.node_list)
 
+/**
+ * plist_for_each_entry	- iterate over list of given type
+ *
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
 #define plist_for_each_entry(pos, head, mem)	\
 	 list_for_each_entry(pos, &(head)->node_list, mem.plist.node_list)
 
+/**
+ * plist_for_each_entry_safe - iterate over list of given type safe against 
+ * removal of list entry
+ *
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
 #define plist_for_each_entry_safe(pos, n, head, mem)	\
 	 list_for_each_entry_safe(pos, n, &(head)->node_list, mem.plist.node_list)
 
+/** 
+ * plist_empty - return !0 if a plist_head is empty
+ *
+ * @head:	&struct pl_head pointer 
+ */
 static inline int plist_empty(const struct pl_head *head)
 {
 	return list_empty(&head->node_list);
 }
 
+/** 
+ * plist_unhashed - return !0 if plist_node is not on a list
+ *
+ * @node:	&struct pl_node pointer 
+ */
 static inline int plist_unhashed(const struct pl_node *node)
 {
 	return list_empty(&node->plist.node_list);
@@ -64,9 +200,23 @@ static inline int plist_unhashed(const s
 
 /* All functions below assume the pl_head is not empty. */
 
+/**
+ * plist_first_entry - get the struct for the first entry
+ *
+ * @ptr:        the &struct pl_head pointer.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_struct within the struct.
+ */
 #define plist_first_entry(head, type, member)	\
 	container_of(plist_first(head), type, member)
 
+/** 
+ * plist_first - return the first node (and thus, highest priority)
+ *
+ * @head:	the &struct pl_head pointer
+ *
+ * Assumes the plist is _not_ empty.
+ */
 static inline struct pl_node* plist_first(const struct pl_head *head)
 {
 	return list_entry(head->node_list.next, struct pl_node, plist.node_list);
Index: linux-2.6.15/lib/plist.c
===================================================================
--- linux-2.6.15.orig/lib/plist.c
+++ linux-2.6.15/lib/plist.c
@@ -1,9 +1,32 @@
+
 /*
- * lib/plist.c - Priority List implementation.
+ * lib/plist.c
+ *
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * 2001-2005 (c) MontaVista Software, Inc.
+ * Daniel Walker <dwalker@mvista.com>
+ *
+ * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ * Tested and made it functional.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
  */
 
 #include <linux/plist.h>
 
+/**
+ * plist_add - add @node to @head returns !0 if the plist prio changed, 0
+ * otherwise. XXX: Fix return code.
+ *
+ * @node:	&struct pl_node pointer
+ * @head:	&struct pl_head pointer
+ */
 void plist_add(struct pl_node *node, struct pl_head *head)
 {
 	struct pl_node *iter;
@@ -25,6 +48,12 @@ eq_prio:
 	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
 }
 
+/**
+ * plist_del - Remove a @node from plist. returns !0 if the plist prio
+ * changed, 0 otherwise. XXX: Fix return code.
+ *
+ * @node:	&struct pl_node pointer
+ */
 void plist_del(struct pl_node *node)
 {
 	if (!list_empty(&node->plist.prio_list)) {


