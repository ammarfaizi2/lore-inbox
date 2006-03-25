Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCYStJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCYStJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCYStI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:08 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30419 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932232AbWCYSsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:38 -0500
Date: Sat, 25 Mar 2006 19:45:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 03/10] PI-futex: add plist implementation
Message-ID: <20060325184558.GD16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add the priority-sorted list (plist) implementation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/plist.h |  226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig           |    6 +
 lib/Makefile          |    1 
 lib/plist.c           |   72 +++++++++++++++
 4 files changed, 305 insertions(+)

Index: linux-pi-futex.mm.q/include/linux/plist.h
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/include/linux/plist.h
@@ -0,0 +1,226 @@
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
+ *
+ * Simplifications of the original code by
+ * Oleg Nesterov <oleg@tv-sign.ru>
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
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
+ */
+#ifndef _LINUX_PLIST_H_
+#define _LINUX_PLIST_H_
+
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+
+struct plist_head {
+	struct list_head prio_list;
+	struct list_head node_list;
+};
+
+struct plist_node {
+	int			prio;
+	struct plist_head	plist;
+};
+
+/**
+ * #PLIST_HEAD_INIT - static struct plist_head initializer
+ *
+ * @head:	struct plist_head variable name
+ */
+#define PLIST_HEAD_INIT(head)				\
+{							\
+	.prio_list = LIST_HEAD_INIT((head).prio_list),	\
+	.node_list = LIST_HEAD_INIT((head).node_list),	\
+}
+
+/**
+ * #PLIST_NODE_INIT - static struct plist_node initializer
+ *
+ * @node:	struct plist_node variable name
+ * @__prio:	initial node priority
+ */
+#define PLIST_NODE_INIT(node, __prio)			\
+{							\
+	.prio  = (__prio),				\
+	.plist = PLIST_HEAD_INIT((node).plist, NULL),	\
+}
+
+/**
+ * plist_head_init - dynamic struct plist_head initializer
+ *
+ * @head:	&struct plist_head pointer
+ */
+static inline void
+plist_head_init(struct plist_head *head)
+{
+	INIT_LIST_HEAD(&head->prio_list);
+	INIT_LIST_HEAD(&head->node_list);
+}
+
+/**
+ * plist_node_init - Dynamic struct plist_node initializer
+ *
+ * @node:	&struct plist_node pointer
+ * @prio:	initial node priority
+ */
+static inline void plist_node_init(struct plist_node *node, int prio)
+{
+	node->prio = prio;
+	plist_head_init(&node->plist);
+}
+
+extern void plist_add(struct plist_node *node, struct plist_head *head);
+extern void plist_del(struct plist_node *node, struct plist_head *head);
+
+/**
+ * plist_for_each - iterate over the plist
+ *
+ * @pos1:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define plist_for_each(pos, head)	\
+	 list_for_each_entry(pos, &(head)->node_list, plist.node_list)
+
+/**
+ * plist_for_each_entry_safe - iterate over a plist of given type safe
+ * against removal of list entry
+ *
+ * @pos1:	the type * to use as a loop counter.
+ * @n1:	another type * to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define plist_for_each_safe(pos, n, head)	\
+	 list_for_each_entry_safe(pos, n, &(head)->node_list, plist.node_list)
+
+/**
+ * plist_for_each_entry	- iterate over list of given type
+ *
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define plist_for_each_entry(pos, head, mem)	\
+	 list_for_each_entry(pos, &(head)->node_list, mem.plist.node_list)
+
+/**
+ * plist_for_each_entry_safe - iterate over list of given type safe against
+ * removal of list entry
+ *
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @m:		the name of the list_struct within the struct.
+ */
+#define plist_for_each_entry_safe(pos, n, head, m)	\
+	list_for_each_entry_safe(pos, n, &(head)->node_list, m.plist.node_list)
+
+/**
+ * plist_head_empty - return !0 if a plist_head is empty
+ *
+ * @head:	&struct plist_head pointer
+ */
+static inline int plist_head_empty(const struct plist_head *head)
+{
+	return list_empty(&head->node_list);
+}
+
+/**
+ * plist_node_empty - return !0 if plist_node is not on a list
+ *
+ * @node:	&struct plist_node pointer
+ */
+static inline int plist_node_empty(const struct plist_node *node)
+{
+	return plist_head_empty(&node->plist);
+}
+
+/* All functions below assume the plist_head is not empty. */
+
+/**
+ * plist_first_entry - get the struct for the first entry
+ *
+ * @ptr:	the &struct plist_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define plist_first_entry(head, type, member)	\
+	container_of(plist_first(head), type, member)
+
+/**
+ * plist_first - return the first node (and thus, highest priority)
+ *
+ * @head:	the &struct plist_head pointer
+ *
+ * Assumes the plist is _not_ empty.
+ */
+static inline struct plist_node* plist_first(const struct plist_head *head)
+{
+	return list_entry(head->node_list.next,
+			  struct plist_node, plist.node_list);
+}
+
+#endif
Index: linux-pi-futex.mm.q/lib/Kconfig
===================================================================
--- linux-pi-futex.mm.q.orig/lib/Kconfig
+++ linux-pi-futex.mm.q/lib/Kconfig
@@ -86,4 +86,10 @@ config TEXTSEARCH_BM
 config TEXTSEARCH_FSM
 	tristate
 
+#
+# plist support is select#ed if needed
+#
+config PLIST
+	boolean
+
 endmenu
Index: linux-pi-futex.mm.q/lib/Makefile
===================================================================
--- linux-pi-futex.mm.q.orig/lib/Makefile
+++ linux-pi-futex.mm.q/lib/Makefile
@@ -25,6 +25,7 @@ lib-$(CONFIG_SEMAPHORE_SLEEPERS) += sema
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
+obj-$(CONFIG_PLIST) += plist.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
Index: linux-pi-futex.mm.q/lib/plist.c
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/lib/plist.c
@@ -0,0 +1,72 @@
+/*
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
+ *
+ * Simplifications of the original code by
+ * Oleg Nesterov <oleg@tv-sign.ru>
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
+ *
+ * This file contains the add / del functions which are considered to
+ * be too large to inline. See include/linux/plist.h for further
+ * information.
+ */
+
+#include <linux/plist.h>
+#include <linux/spinlock.h>
+
+/**
+ * plist_add - add @node to @head
+ *
+ * @node:	&struct plist_node pointer
+ * @head:	&struct plist_head pointer
+ */
+void plist_add(struct plist_node *node, struct plist_head *head)
+{
+	struct plist_node *iter;
+
+	WARN_ON(!plist_node_empty(node));
+
+	list_for_each_entry(iter, &head->prio_list, plist.prio_list)
+		if (node->prio < iter->prio)
+			goto lt_prio;
+		else if (node->prio == iter->prio) {
+			iter = list_entry(iter->plist.prio_list.next,
+					struct plist_node, plist.prio_list);
+			goto eq_prio;
+		}
+
+lt_prio:
+	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
+eq_prio:
+	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
+}
+
+/**
+ * plist_del - Remove a @node from plist.
+ *
+ * @node:	&struct plist_node pointer - entry to be removed
+ * @head:	&struct plist_head pointer - list head
+ */
+void plist_del(struct plist_node *node, struct plist_head *head)
+{
+	if (!list_empty(&node->plist.prio_list)) {
+		struct plist_node *next = plist_first(&node->plist);
+
+		list_move_tail(&next->plist.prio_list, &node->plist.prio_list);
+		list_del_init(&node->plist.prio_list);
+	}
+
+	list_del_init(&node->plist.node_list);
+}
