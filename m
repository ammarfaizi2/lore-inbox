Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVLRRCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVLRRCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVLRRCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:02:09 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57021 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965224AbVLRRCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:02:07 -0500
Message-ID: <43A5A7BB.D65B737A@tv-sign.ru>
Date: Sun, 18 Dec 2005 21:17:31 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH rc5-rt2 2/3] plist: add new implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New implementation. It is smaller, and in my opinion cleaner.
User-space test: http://www.tv-sign.ru/oleg/plist.tgz

Like hlist, it has different types for head and node: pl_head/pl_node.

pl_head does not have ->prio field. This saves sizeof(int), and we
don't need to have it in plist_del's parameter list. This is also good
for typechecking.

Like list_add(), plist_add() does not require initialization on pl_node,
except ->prio.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- /dev/null	2000-01-01 03:00:00.000000000 +0300
+++ RT/include/linux/plist.h	2005-12-18 22:48:59.000000000 +0300
@@ -0,0 +1,75 @@
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
+#define plist_first_entry(head, type, member)	\
+	container_of(plist_first(head), type, member)
+
+static inline struct pl_node* plist_first(const struct pl_head *head)
+{
+	return list_entry((head)->node_list.next, struct pl_node, plist.node_list);
+}
+
+#endif
--- /dev/null	2000-01-01 03:00:00.000000000 +0300
+++ RT/lib/plist.c	2005-05-09 19:55:31.000000000 +0400
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
