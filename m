Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWCaTZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCaTZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWCaTZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:25:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30357 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751434AbWCaTZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:25:45 -0500
Date: Fri, 31 Mar 2006 21:23:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] PI-futex patchset: -V4
Message-ID: <20060331192314.GA7060@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu> <20060326231638.GA18395@elte.hu> <20060331191445.GA2250@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331191445.GA2250@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> this is version -V4 of the PI-futex patchset (ontop of current -mm2, 
> which includes -V3.)
> 
> A clean queue of split-up patches can be found at:
> 
>   http://redhat.com/~mingo/PI-futex-patches/PI-futex-patches-V4.tar.gz

oops, the plist debugging changes were missing from the delta. Find 
incremental patch ontop of -V4 below. The tarball above contains all the 
needed patches.

	Ingo

-----
PI-futex -V4 part #2

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--

 include/asm-generic/bug.h |    6 ++++++
 include/linux/plist.h     |   29 +++++++++++++++++++++++++----
 lib/plist.c               |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 4 deletions(-)

Index: linux-pi-futex.mm.q/include/asm-generic/bug.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/asm-generic/bug.h
+++ linux-pi-futex.mm.q/include/asm-generic/bug.h
@@ -39,4 +39,10 @@
 #endif
 #endif
 
+#ifdef CONFIG_SMP
+# define WARN_ON_SMP(x)			WARN_ON(x)
+#else
+# define WARN_ON_SMP(x)			do { } while (0)
+#endif
+
 #endif
Index: linux-pi-futex.mm.q/include/linux/plist.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/plist.h
+++ linux-pi-futex.mm.q/include/linux/plist.h
@@ -79,6 +79,9 @@
 struct plist_head {
 	struct list_head prio_list;
 	struct list_head node_list;
+#ifdef CONFIG_DEBUG_PI_LIST
+	spinlock_t *lock;
+#endif
 };
 
 struct plist_node {
@@ -86,15 +89,22 @@ struct plist_node {
 	struct plist_head	plist;
 };
 
+#ifdef CONFIG_DEBUG_PI_LIST
+# define PLIST_HEAD_LOCK_INIT(_lock)	.lock = _lock
+#else
+# define PLIST_HEAD_LOCK_INIT(_lock)
+#endif
+
 /**
  * #PLIST_HEAD_INIT - static struct plist_head initializer
  *
  * @head:	struct plist_head variable name
  */
-#define PLIST_HEAD_INIT(head)				\
+#define PLIST_HEAD_INIT(head, _lock)			\
 {							\
 	.prio_list = LIST_HEAD_INIT((head).prio_list),	\
 	.node_list = LIST_HEAD_INIT((head).node_list),	\
+	PLIST_HEAD_LOCK_INIT(&(_lock))			\
 }
 
 /**
@@ -115,10 +125,13 @@ struct plist_node {
  * @head:	&struct plist_head pointer
  */
 static inline void
-plist_head_init(struct plist_head *head)
+plist_head_init(struct plist_head *head, spinlock_t *lock)
 {
 	INIT_LIST_HEAD(&head->prio_list);
 	INIT_LIST_HEAD(&head->node_list);
+#ifdef CONFIG_DEBUG_PI_LIST
+	head->lock = lock;
+#endif
 }
 
 /**
@@ -130,7 +143,7 @@ plist_head_init(struct plist_head *head)
 static inline void plist_node_init(struct plist_node *node, int prio)
 {
 	node->prio = prio;
-	plist_head_init(&node->plist);
+	plist_head_init(&node->plist, NULL);
 }
 
 extern void plist_add(struct plist_node *node, struct plist_head *head);
@@ -207,8 +220,16 @@ static inline int plist_node_empty(const
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
-#define plist_first_entry(head, type, member)	\
+#ifdef CONFIG_DEBUG_PI_LIST
+# define plist_first_entry(head, type, member)	\
+({ \
+	WARN_ON(plist_head_empty(head)); \
+	container_of(plist_first(head), type, member); \
+})
+#else
+# define plist_first_entry(head, type, member)	\
 	container_of(plist_first(head), type, member)
+#endif
 
 /**
  * plist_first - return the first node (and thus, highest priority)
Index: linux-pi-futex.mm.q/lib/plist.c
===================================================================
--- linux-pi-futex.mm.q.orig/lib/plist.c
+++ linux-pi-futex.mm.q/lib/plist.c
@@ -26,6 +26,44 @@
 #include <linux/plist.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_DEBUG_PI_LIST
+
+static void plist_check_prev_next(struct list_head *t, struct list_head *p,
+				  struct list_head *n)
+{
+	if (n->prev != p || p->next != n) {
+		printk("top: %p, n: %p, p: %p\n", t, t->next, t->prev);
+		printk("prev: %p, n: %p, p: %p\n", p, p->next, p->prev);
+		printk("next: %p, n: %p, p: %p\n", n, n->next, n->prev);
+		WARN_ON(1);
+	}
+}
+
+static void plist_check_list(struct list_head *top)
+{
+	struct list_head *prev = top, *next = top->next;
+
+	plist_check_prev_next(top, prev, next);
+	while (next != top) {
+		prev = next;
+		next = prev->next;
+		plist_check_prev_next(top, prev, next);
+	}
+}
+
+static void plist_check_head(struct plist_head *head)
+{
+	WARN_ON(!head->lock);
+	if (head->lock)
+		WARN_ON_SMP(!spin_is_locked(head->lock));
+	plist_check_list(&head->prio_list);
+	plist_check_list(&head->node_list);
+}
+
+#else
+# define plist_check_head(h)	do { } while (0)
+#endif
+
 /**
  * plist_add - add @node to @head
  *
@@ -36,6 +74,7 @@ void plist_add(struct plist_node *node, 
 {
 	struct plist_node *iter;
 
+	plist_check_head(head);
 	WARN_ON(!plist_node_empty(node));
 
 	list_for_each_entry(iter, &head->prio_list, plist.prio_list) {
@@ -52,6 +91,8 @@ lt_prio:
 	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
 eq_prio:
 	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
+
+	plist_check_head(head);
 }
 
 /**
@@ -62,6 +103,8 @@ eq_prio:
  */
 void plist_del(struct plist_node *node, struct plist_head *head)
 {
+	plist_check_head(head);
+
 	if (!list_empty(&node->plist.prio_list)) {
 		struct plist_node *next = plist_first(&node->plist);
 
@@ -70,4 +113,6 @@ void plist_del(struct plist_node *node, 
 	}
 
 	list_del_init(&node->plist.node_list);
+
+	plist_check_head(head);
 }
