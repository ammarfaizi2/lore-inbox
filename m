Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUJXP4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUJXP4X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUJXP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:56:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17977 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261522AbUJXPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:52:08 -0400
Date: Sun, 24 Oct 2004 16:51:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, Brent Casavant <bcasavan@sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] shmem NUMA policy spinlock
Message-ID: <Pine.LNX.4.44.0410241650010.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA policy for shared memory or tmpfs page allocation was protected
by a semaphore.  It helps to improve scalability if we change that to a
spinlock (and there's only one place that needs to drop and reacquire).
Oh, and don't even bother to get the spinlock while the tree is empty.

Acked-by: Andi Kleen <ak@suse.de>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 include/linux/mempolicy.h |    6 +++---
 mm/mempolicy.c            |   38 +++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 16 deletions(-)

--- 2.6.10-rc1/include/linux/mempolicy.h	2004-10-18 22:55:54.000000000 +0100
+++ linux/include/linux/mempolicy.h	2004-10-23 20:43:24.000000000 +0100
@@ -30,7 +30,7 @@
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
-#include <asm/semaphore.h>
+#include <linux/spinlock.h>
 
 struct vm_area_struct;
 
@@ -134,13 +134,13 @@ struct sp_node {
 
 struct shared_policy {
 	struct rb_root root;
-	struct semaphore sem;
+	spinlock_t lock;
 };
 
 static inline void mpol_shared_policy_init(struct shared_policy *info)
 {
 	info->root = RB_ROOT;
-	init_MUTEX(&info->sem);
+	spin_lock_init(&info->lock);
 }
 
 int mpol_set_shared_policy(struct shared_policy *info,
--- 2.6.10-rc1/mm/mempolicy.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/mempolicy.c	2004-10-23 20:43:24.000000000 +0100
@@ -887,12 +887,12 @@ int mpol_node_valid(int nid, struct vm_a
  *
  * Remember policies even when nobody has shared memory mapped.
  * The policies are kept in Red-Black tree linked from the inode.
- * They are protected by the sp->sem semaphore, which should be held
+ * They are protected by the sp->lock spinlock, which should be held
  * for any accesses to the tree.
  */
 
 /* lookup first element intersecting start-end */
-/* Caller holds sp->sem */
+/* Caller holds sp->lock */
 static struct sp_node *
 sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
 {
@@ -924,7 +924,7 @@ sp_lookup(struct shared_policy *sp, unsi
 }
 
 /* Insert a new shared policy into the list. */
-/* Caller holds sp->sem */
+/* Caller holds sp->lock */
 static void sp_insert(struct shared_policy *sp, struct sp_node *new)
 {
 	struct rb_node **p = &sp->root.rb_node;
@@ -954,13 +954,15 @@ mpol_shared_policy_lookup(struct shared_
 	struct mempolicy *pol = NULL;
 	struct sp_node *sn;
 
-	down(&sp->sem);
+	if (!sp->root.rb_node)
+		return NULL;
+	spin_lock(&sp->lock);
 	sn = sp_lookup(sp, idx, idx+1);
 	if (sn) {
 		mpol_get(sn->policy);
 		pol = sn->policy;
 	}
-	up(&sp->sem);
+	spin_unlock(&sp->lock);
 	return pol;
 }
 
@@ -990,9 +992,10 @@ sp_alloc(unsigned long start, unsigned l
 static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 				 unsigned long end, struct sp_node *new)
 {
-	struct sp_node *n, *new2;
+	struct sp_node *n, *new2 = NULL;
 
-	down(&sp->sem);
+restart:
+	spin_lock(&sp->lock);
 	n = sp_lookup(sp, start, end);
 	/* Take care of old policies in the same range. */
 	while (n && n->start < end) {
@@ -1005,13 +1008,16 @@ static int shared_policy_replace(struct 
 		} else {
 			/* Old policy spanning whole new range. */
 			if (n->end > end) {
-				new2 = sp_alloc(end, n->end, n->policy);
 				if (!new2) {
-					up(&sp->sem);
-					return -ENOMEM;
+					spin_unlock(&sp->lock);
+					new2 = sp_alloc(end, n->end, n->policy);
+					if (!new2)
+						return -ENOMEM;
+					goto restart;
 				}
 				n->end = end;
 				sp_insert(sp, new2);
+				new2 = NULL;
 			}
 			/* Old crossing beginning, but not end (easy) */
 			if (n->start < start && n->end > start)
@@ -1023,7 +1029,11 @@ static int shared_policy_replace(struct 
 	}
 	if (new)
 		sp_insert(sp, new);
-	up(&sp->sem);
+	spin_unlock(&sp->lock);
+	if (new2) {
+		mpol_free(new2->policy);
+		kmem_cache_free(sn_cache, new2);
+	}
 	return 0;
 }
 
@@ -1056,7 +1066,9 @@ void mpol_free_shared_policy(struct shar
 	struct sp_node *n;
 	struct rb_node *next;
 
-	down(&p->sem);
+	if (!p->root.rb_node)
+		return;
+	spin_lock(&p->lock);
 	next = rb_first(&p->root);
 	while (next) {
 		n = rb_entry(next, struct sp_node, nd);
@@ -1065,7 +1077,7 @@ void mpol_free_shared_policy(struct shar
 		mpol_free(n->policy);
 		kmem_cache_free(sn_cache, n);
 	}
-	up(&p->sem);
+	spin_unlock(&p->lock);
 }
 
 /* assumes fs == KERNEL_DS */

