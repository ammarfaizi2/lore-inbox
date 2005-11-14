Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVKNV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVKNV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVKNV6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:58:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751293AbVKNVz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:29 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELsc6T007521@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 4/12] FS-Cache: Permit pre-allocation of radix-tree nodes 
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch permits advance allocation of radix-tree nodes on a per-task
basis to make sure that ENOMEM doesn't crop up at an inconvenient moment in
CacheFS.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 radix-cache-2614mm2.diff
 include/linux/radix-tree.h |   14 ++++
 include/linux/sched.h      |    2 
 kernel/exit.c              |    1 
 kernel/fork.c              |    2 
 lib/radix-tree.c           |  134 ++++++++++++++++++++++++++++++++++-----------
 5 files changed, 122 insertions(+), 31 deletions(-)

diff -uNrp linux-2.6.14-mm2/include/linux/radix-tree.h linux-2.6.14-mm2-cachefs/include/linux/radix-tree.h
--- linux-2.6.14-mm2/include/linux/radix-tree.h	2005-11-14 16:17:59.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/include/linux/radix-tree.h	2005-11-14 16:23:41.000000000 +0000
@@ -51,7 +51,6 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
-int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
 			unsigned long index, int tag);
@@ -64,6 +63,19 @@ radix_tree_gang_lookup_tag(struct radix_
 		unsigned long first_index, unsigned int max_items, int tag);
 int radix_tree_tagged(struct radix_tree_root *root, int tag);
 
+/*
+ * radix tree advance loading
+ */
+struct radix_tree_preload {
+	int count;
+	struct radix_tree_node *nodes;
+};
+
+int radix_tree_preload(unsigned int gfp_mask);
+
+extern int radix_tree_preload_task(unsigned int gfp_mask, int nitems);
+extern void radix_tree_preload_drain_task(void);
+
 static inline void radix_tree_preload_end(void)
 {
 	preempt_enable();
diff -uNrp linux-2.6.14-mm2/include/linux/sched.h linux-2.6.14-mm2-cachefs/include/linux/sched.h
--- linux-2.6.14-mm2/include/linux/sched.h	2005-11-14 16:17:59.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/include/linux/sched.h	2005-11-14 16:25:59.000000000 +0000
@@ -35,6 +35,7 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 #include <linux/rcupdate.h>
+#include <linux/radix-tree.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -863,6 +864,7 @@ struct task_struct {
 
 /* VM state */
 	struct reclaim_state *reclaim_state;
+	struct radix_tree_preload radix_preload;
 
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
diff -uNrp linux-2.6.14-mm2/kernel/exit.c linux-2.6.14-mm2-cachefs/kernel/exit.c
--- linux-2.6.14-mm2/kernel/exit.c	2005-11-14 16:17:59.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/kernel/exit.c	2005-11-14 16:23:41.000000000 +0000
@@ -64,6 +64,7 @@ void release_task(struct task_struct * p
 	struct dentry *proc_dentry;
 
 repeat: 
+	radix_tree_preload_drain_task();
 	atomic_dec(&p->user->processes);
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
diff -uNrp linux-2.6.14-mm2/kernel/fork.c linux-2.6.14-mm2-cachefs/kernel/fork.c
--- linux-2.6.14-mm2/kernel/fork.c	2005-11-14 16:17:59.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/kernel/fork.c	2005-11-14 16:23:41.000000000 +0000
@@ -122,6 +122,7 @@ void __put_task_struct(struct task_struc
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
+EXPORT_SYMBOL(__put_task_struct);
 
 void __init fork_init(unsigned long mempages)
 {
@@ -940,6 +941,7 @@ static task_t *copy_process(unsigned lon
 			goto bad_fork_cleanup;
 
 	p->proc_dentry = NULL;
+	memset(&p->radix_preload, 0, sizeof(p->radix_preload));
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
diff -uNrp linux-2.6.14-mm2/lib/radix-tree.c linux-2.6.14-mm2-cachefs/lib/radix-tree.c
--- linux-2.6.14-mm2/lib/radix-tree.c	2005-11-14 16:18:00.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/lib/radix-tree.c	2005-11-14 16:47:06.000000000 +0000
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/sched.h>
 
 
 #ifdef __KERNEL__
@@ -69,10 +70,6 @@ static kmem_cache_t *radix_tree_node_cac
 /*
  * Per-cpu pool of preloaded nodes
  */
-struct radix_tree_preload {
-	int nr;
-	struct radix_tree_node *nodes[RADIX_TREE_MAX_PATH];
-};
 DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
 
 /*
@@ -89,10 +86,12 @@ radix_tree_node_alloc(struct radix_tree_
 		struct radix_tree_preload *rtp;
 
 		rtp = &__get_cpu_var(radix_tree_preloads);
-		if (rtp->nr) {
-			ret = rtp->nodes[rtp->nr - 1];
-			rtp->nodes[rtp->nr - 1] = NULL;
-			rtp->nr--;
+		ret = rtp->nodes;
+		if (ret) {
+			rtp->nodes = ret->slots[0];
+			if (rtp->nodes)
+				ret->slots[0] = NULL;
+			rtp->count--;
 		}
 	}
 	return ret;
@@ -113,29 +112,89 @@ radix_tree_node_free(struct radix_tree_n
 int radix_tree_preload(gfp_t gfp_mask)
 {
 	struct radix_tree_preload *rtp;
-	struct radix_tree_node *node;
-	int ret = -ENOMEM;
+	struct radix_tree_node *node, *sp;
+	int ret = -ENOMEM, n;
 
 	preempt_disable();
+
 	rtp = &__get_cpu_var(radix_tree_preloads);
-	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
-		preempt_enable();
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
-		if (node == NULL)
-			goto out;
-		preempt_disable();
-		rtp = &__get_cpu_var(radix_tree_preloads);
-		if (rtp->nr < ARRAY_SIZE(rtp->nodes))
-			rtp->nodes[rtp->nr++] = node;
-		else
-			kmem_cache_free(radix_tree_node_cachep, node);
+	if (rtp->count < RADIX_TREE_MAX_PATH) {
+		/* load up from the per-task cache first */
+		n = current->radix_preload.count;
+		if (n > 0) {
+			if (RADIX_TREE_MAX_PATH - rtp->count < n)
+				n = RADIX_TREE_MAX_PATH - rtp->count;
+			current->radix_preload.count -= n;
+			rtp->count += n;
+
+			sp = current->radix_preload.nodes;
+
+			for (; n > 0; n--) {
+				node = sp;
+				sp = node->slots[0];
+				node->slots[0] = rtp->nodes;
+				rtp->nodes = node;
+			}
+
+			current->radix_preload.nodes = sp;
+		}
+
+		/* then load up from the slab */
+		while (rtp->count < RADIX_TREE_MAX_PATH) {
+			preempt_enable();
+			node = kmem_cache_alloc(radix_tree_node_cachep,
+						gfp_mask);
+			if (node == NULL)
+				goto out;
+			preempt_disable();
+			rtp = &__get_cpu_var(radix_tree_preloads);
+
+			if (rtp->count < RADIX_TREE_MAX_PATH) {
+				node->slots[0] = rtp->nodes;
+				rtp->nodes = node;
+				rtp->count++;
+			} else {
+				kmem_cache_free(radix_tree_node_cachep, node);
+			}
+		}
 	}
+
 	ret = 0;
 out:
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_preload);
 
+/*
+ * Load up an auxiliary cache with sufficient objects to ensure a number of
+ * items may be added to the radix tree
+ */
+int radix_tree_preload_task(unsigned int __nocast gfp_mask,
+			    int nitems)
+{
+	struct radix_tree_preload *rtp = &current->radix_preload;
+	struct radix_tree_node *node;
+
+	nitems *= RADIX_TREE_MAX_PATH;
+
+	while (rtp->count < nitems) {
+		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+		if (node == NULL)
+			goto nomem;
+
+		node->slots[0] = rtp->nodes;
+		rtp->nodes = node;
+		rtp->count++;
+	}
+	return 0;
+
+nomem:
+	radix_tree_preload_drain_task();
+	return -ENOMEM;
+}
+
+EXPORT_SYMBOL(radix_tree_preload_task);
+
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
 	__set_bit(offset, node->tags[tag]);
@@ -834,6 +893,28 @@ static __init void radix_tree_init_maxin
 		height_to_maxindex[i] = __maxindex(i);
 }
 
+/*
+ * drain a preload cache back to the slab from whence the nodes came
+ */
+static void radix_tree_preload_drain(struct radix_tree_preload *rtp)
+{
+	while (rtp->nodes) {
+		struct radix_tree_node *node = rtp->nodes;
+		rtp->nodes = node->slots[0];
+		rtp->count--;
+		kmem_cache_free(radix_tree_node_cachep, node);
+	}
+
+	BUG_ON(rtp->count != 0);
+}
+
+void radix_tree_preload_drain_task(void)
+{
+	radix_tree_preload_drain(&current->radix_preload);
+}
+
+EXPORT_SYMBOL(radix_tree_preload_drain_task);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int radix_tree_callback(struct notifier_block *nfb,
                             unsigned long action,
@@ -843,15 +924,8 @@ static int radix_tree_callback(struct no
        struct radix_tree_preload *rtp;
 
        /* Free per-cpu pool of perloaded nodes */
-       if (action == CPU_DEAD) {
-               rtp = &per_cpu(radix_tree_preloads, cpu);
-               while (rtp->nr) {
-                       kmem_cache_free(radix_tree_node_cachep,
-                                       rtp->nodes[rtp->nr-1]);
-                       rtp->nodes[rtp->nr-1] = NULL;
-                       rtp->nr--;
-               }
-       }
+       if (action == CPU_DEAD)
+               radix_tree_preload_drain(&per_cpu(radix_tree_preloads, cpu));
        return NOTIFY_OK;
 }
 #endif /* CONFIG_HOTPLUG_CPU */
