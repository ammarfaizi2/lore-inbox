Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHVIgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHVIgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHVIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:36:06 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35719 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751360AbWHVIgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:36:04 -0400
Date: Tue, 22 Aug 2006 17:39:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com
Subject: [RFC][PATCH] ps command race fix take2 [1/4] list token
Message-Id: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is ps command race fix take2. Unfortunately, against 2.6.18-rc4.
I'll rebase this to appropriate kernel if O.K. (I think this is RFC)

This patch implements Paul Jackson's idea, 'inserting false link in task list'.

Good point of this approach is cost of searching task is O(N) (N=num of tgids).
Bad point is lock and kmalloc/kfree.
I didin't modified thread_list and cpuset's proc list, maybe future work.

If searching pid bitmap is better, please take Erics.

consists of 4 patches.
- listoken.patch -- implements token in list
- tasklist.patch -- make task list to use list_with_token
- profile.patch  -- fix oprofile
- proc_pid_readdir.patch -- implements proc_pid_readdir for /proc/<pid>

Works well on x86/SMP system.

-Kame
==

listtoken , a helper for walking a list by intermittent access.

When we walk a list intermittently and the list is being modified at the
same time, it's hard to remember our position in it.

With this list token, a user can remember where he is reading by inserting
a token in the list.

Now this is designed just to support /proc/<pid> readdir() access. Not very
rich functions are supporetd.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 include/linux/listtoken.h |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile              |    2 -
 lib/listtoken.c           |   25 ++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4/include/linux/listtoken.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4/include/linux/listtoken.h
@@ -0,0 +1,62 @@
+/*
+  helper routine for intermittent list walker.
+  token saves position in a list.
+*/
+
+
+#ifndef _LINUX_LISTTOKEN_H
+#define _LINUX_LISTTOKEN_H
+
+#ifdef __KERNEL__
+#include <linux/list.h>
+#include <linux/rcupdate.h>
+
+struct list_token {
+	struct list_head list;
+	long		token; /* 0: data 1: token */
+	struct rcu_head rcu;	/* useful when walking list with RCU */
+};
+
+#define LIST_TOKEN_INIT(token)	{LIST_HEAD_INIT((token).list),0,}
+
+static inline void
+list_add_rcu_token(struct list_token *new, struct list_token *head)
+{
+	list_add_rcu(&new->list, &head->list);
+}
+
+static inline void
+list_add_tail_rcu_token(struct list_token *new, struct list_token *head)
+{
+	list_add_tail_rcu(&new->list, &head->list);
+}
+
+static inline void
+list_del_rcu_token(struct list_token *token)
+{
+	list_del_rcu(&token->list);
+}
+
+/* returns next valid ent in a list skip token. */
+static inline struct list_token *
+list_next_rcu_skiptoken(struct list_token *ent)
+{
+	do {
+		ent = list_entry(rcu_dereference(ent->list.next),
+				struct list_token, list);
+	} while (ent->token);
+	return ent;
+}
+/* set *token* before specfied list entry */
+static inline void
+insert_list_token_rcu(struct list_token *token, struct list_token *ent)
+{
+	token->token = 1; /* mark this as token */
+	list_add_tail_rcu_token(token, ent);
+}
+
+/* remove token */
+extern void remove_list_token_rcu(struct list_token *ent);
+
+#endif
+#endif
Index: linux-2.6.18-rc4/lib/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/lib/Makefile
+++ linux-2.6.18-rc4/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o listtoken.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
Index: linux-2.6.18-rc4/lib/listtoken.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4/lib/listtoken.c
@@ -0,0 +1,25 @@
+/*
+  implements token to remember the place in a list. useful for
+  traversing busily modified list by intermittent access
+*/
+#include <linux/types.h>
+#include <linux/gfp.h>
+#include <linux/listtoken.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+/*
+ * for freeing RCU token.
+ */
+static void delayed_free_token(struct rcu_head *rhp)
+{
+	kfree(container_of(rhp, struct list_token , rcu));
+}
+
+void remove_list_token_rcu(struct list_token *token)
+{
+	BUG_ON(!token->token);
+	list_del_rcu_token(token);
+	call_rcu(&token->rcu, delayed_free_token);
+}
+
+EXPORT_SYMBOL_GPL(remove_list_token_rcu);





