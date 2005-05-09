Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVEIOfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVEIOfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVEIOek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:34:40 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:39855 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261418AbVEIOcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:32:45 -0400
Message-ID: <427F763B.FEF0EA91@tv-sign.ru>
Date: Mon, 09 May 2005 18:39:55 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 2/4] rt_mutex: add new plist implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new plist implementation, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111547290706136

Changes:

	added plist_next_entry() helper (was plist_entry)

	added plist_unhashed() helper, see PATCH 4/4

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- V0.7.47-01/include/linux/plist.h~1_PLIST	2005-05-09 17:06:05.000000000 +0400
+++ V0.7.47-01/include/linux/plist.h	2005-05-09 20:11:26.000000000 +0400
@@ -0,0 +1,97 @@
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
+static inline int plist_unhashed(const struct pl_node *node)
+{
+	return list_empty(&node->plist.node_list);
+}
+
+/* All functions below assume the pl_head is not empty. */
+
+#define plist_next_entry(head, type, member)	\
+	container_of(plist_next(head), type, member)
+
+#define plist_prev_entry(head, type, member)	\
+	container_of(plist_prev(head), type, member)
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
--- V0.7.47-01/lib/plist.c~1_PLIST	2005-05-09 17:06:05.000000000 +0400
+++ V0.7.47-01/lib/plist.c	2005-05-09 19:55:31.000000000 +0400
@@ -0,0 +1,36 @@
+/*
+ * lib/plist.c - Priority List implementation.
+ */
+
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
--- V0.7.47-01/lib/Makefile~1_PLIST	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/lib/Makefile	2005-05-09 17:12:48.000000000 +0400
@@ -15,6 +15,8 @@ CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
 endif
 
+obj-$(CONFIG_PREEMPT_RT) += plist.o
+
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
