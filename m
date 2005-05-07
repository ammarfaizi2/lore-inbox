Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbVEGNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVEGNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbVEGNap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:30:45 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:33417 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S263112AbVEGN1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:27:48 -0400
Message-ID: <427CC3FD.86D8EEB4@tv-sign.ru>
Date: Sat, 07 May 2005 17:34:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [RFC][PATCH] alternative implementation of Priority Lists
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds priority lists to the kernel, see this thread:
http://marc.theaimsgroup.com/?t=111289685000001&r=1

It was thoroughly tested in userspace, you can get the test here:
http://tv-sign.ru/update/plist.tgz

It lacks documentation, so it is for review only.

Notes:

	This patch adds 2 structures: pl_head and pl_node.
	I think it is good for typechecking.

	plist_add() does not require that the new node is
	initialized (except ->prio).

	no plist_del_init(), plist_del() does initialization
	on the deleted node.

	no plist_entry(), use container_of()


The code snippet from original patch:

	struct plist *next1, *next2, *curr1, *curr2;
	struct rt_mutex_waiter *w;

	plist_for_each_safe(curr1, curr2, next1, next2, &old_owner->pi_waiters) {
		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
		if (w->lock == lock) {
			plist_del(&w->pi_list, &old_owner->pi_waiters);
			plist_init(&w->pi_list, w->task->prio);
			plist_add(&w->pi_list, &new_owner->pi_waiters);

This becomes:

	struct rt_mutex_waiter *w, tmp;

	plist_for_each_entry_safe(w, tmp, &old_owner->pi_waiters) {
		if (w->lock == lock) {
			plist_del(&w->pi_list, &old_owner->pi_waiters);
			w->pi_list.prio = w->task->prio;
			plist_add(&w->pi_list, &new_owner->pi_waiters);

Please comment.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- /dev/null	Sat Jan  1 03:00:00 2000
+++ kernel/include/linux/plist.h	Sat May  7 16:42:05 2005
@@ -0,0 +1,84 @@
+#ifndef _LINUX_PLIST_H_
+#define _LINUX_PLIST_H_
+
+#include <linux/list.h>
+
+struct pl_head {
+	struct list_head prio_list;
+	struct list_head node_list;
+};
+
+struct pl_node {
+	int		prio;
+	struct pl_head	plist;
+};
+
+#define PL_HEAD_INIT(head)	\
+{							\
+	.prio_list = LIST_HEAD_INIT((head).prio_list),	\
+	.node_list = LIST_HEAD_INIT((head).node_list),	\
+}
+
+#define PL_NODE_INIT(node, __prio)	\
+{							\
+	.prio  = (__prio),				\
+	.plist = PL_HEAD_INIT((node).plist),		\
+}
+
+static inline void pl_head_init(struct pl_head *head)
+{
+	INIT_LIST_HEAD(&head->prio_list);
+	INIT_LIST_HEAD(&head->node_list);
+}
+
+static inline void pl_node_init(struct pl_node *node, int prio)
+{
+	node->prio = prio;
+	pl_head_init(&node->plist);
+}
+
+extern void plist_add(struct pl_node *node, struct pl_head *head);
+extern void plist_del(struct pl_node *node);
+
+#define plist_for_each(pos, head)	\
+	 list_for_each_entry(pos, &(head)->node_list, plist.node_list)
+
+#define plist_for_each_safe(pos, n, head)	\
+	 list_for_each_entry_safe(pos, n, &(head)->node_list, plist.node_list)
+
+#define plist_for_each_entry(pos, head, mem)	\
+	 list_for_each_entry(pos, &(head)->node_list, mem.plist.node_list)
+
+#define plist_for_each_entry_safe(pos, n, head, mem)	\
+	 list_for_each_entry_safe(pos, n, &(head)->node_list, mem.plist.node_list)
+
+static inline int plist_empty(const struct pl_head *head)
+{
+	return list_empty(&head->node_list);
+}
+
+#define __pl_head_node(head, list, dir)	\
+	list_entry((head)->list.dir, struct pl_node, plist.list)
+
+static inline struct pl_node* plist_next(const struct pl_head *head)
+{
+	return __pl_head_node(head, node_list, next);
+}
+
+static inline struct pl_node* plist_prev(const struct pl_head *head)
+{
+	return __pl_head_node(head, node_list, prev);
+}
+
+static inline struct pl_node* plist_prio_next(const struct pl_head *head)
+{
+	return __pl_head_node(head, prio_list, next);
+}
+
+static inline struct pl_node* plist_prio_prev(const struct pl_head *head)
+{
+	return __pl_head_node(head, prio_list, prev);
+}
+
+#undef	__pl_head_node
+#endif
--- /dev/null	Sat Jan  1 03:00:00 2000
+++ kernel/lib/plist.c	Sat May  7 16:30:50 2005
@@ -0,0 +1,32 @@
+#include <linux/plist.h>
+
+void plist_add(struct pl_node *node, struct pl_head *head)
+{
+	struct pl_node *iter;
+
+	INIT_LIST_HEAD(&node->plist.prio_list);
+
+	list_for_each_entry(iter, &head->prio_list, plist.prio_list)
+		if (node->prio < iter->prio)
+			goto lt_prio;
+		else if (node->prio == iter->prio) {
+			iter = plist_prio_next(&iter->plist);
+			goto eq_prio;
+		}
+
+lt_prio:
+	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
+eq_prio:
+	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
+}
+
+void plist_del(struct pl_node *node)
+{
+	if (!list_empty(&node->plist.prio_list)) {
+		struct pl_node *next = plist_next(&node->plist);
+		list_move_tail(&next->plist.prio_list, &node->plist.prio_list);
+		list_del_init(&node->plist.prio_list);
+	}
+
+	list_del_init(&node->plist.node_list);
+}
_
