Return-Path: <linux-kernel-owner+w=401wt.eu-S1754843AbXABNwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbXABNwS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbXABNwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:52:18 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41470 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbXABNwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:52:17 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 08:52:16 EST
Date: Tue, 2 Jan 2007 15:47:06 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: [PATCH] slab: cache alloc cleanups
Message-ID: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrew, I have been unable to find a NUMA-capable tester for this patch, 
 so can we please put this in to -mm for some exposure?]

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch cleans up __cache_alloc and __cache_alloc_node functions.  We no
longer need to do NUMA_BUILD tricks and the UMA allocation path is much
simpler. Note: we now do alternate_node_alloc() for kmem_cache_alloc_node as
well.

Cc: Andy Whitcroft <apw@shadowen.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  165 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 84 insertions(+), 81 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -3197,35 +3197,6 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
-static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
-						gfp_t flags, void *caller)
-{
-	unsigned long save_flags;
-	void *objp = NULL;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-
-	local_irq_save(save_flags);
-
-	if (unlikely(NUMA_BUILD &&
-			current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY)))
-		objp = alternate_node_alloc(cachep, flags);
-
-	if (!objp)
-		objp = ____cache_alloc(cachep, flags);
-	/*
-	 * We may just have run out of memory on the local node.
-	 * ____cache_alloc_node() knows how to locate memory on other nodes
-	 */
- 	if (NUMA_BUILD && !objp)
- 		objp = ____cache_alloc_node(cachep, flags, numa_node_id());
-	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					    caller);
-	prefetchw(objp);
-	return objp;
-}
-
 #ifdef CONFIG_NUMA
 /*
  * Try allocating on another node if PF_SPREAD_SLAB|PF_MEMPOLICY.
@@ -3383,7 +3354,90 @@ must_grow:
 done:
 	return obj;
 }
-#endif
+
+/**
+ * __do_cache_alloc_node - Allocate an object on the specified node
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ * @nodeid: node number of the target node.
+ *
+ * Fallback to other node is possible if __GFP_THISNODE is not set.
+ */
+static __always_inline void *
+__do_cache_alloc_node(struct kmem_cache *cache, gfp_t flags, int nodeid)
+{
+	void *obj;
+
+	if (nodeid == -1 || nodeid == numa_node_id()) {
+		if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
+			obj = alternate_node_alloc(cache, flags);
+			if (obj)
+				goto out;
+		}
+
+		/*
+		 * Use the locally cached objects if possible. However,
+		 * ____cache_alloc does not allow fallback to other nodes.
+		 * It may fail while we still have objects on other nodes
+		 * available.
+		 */
+		obj = ____cache_alloc(cache, flags);
+		if (obj)
+			goto out;
+
+		/* Fall back to other nodes. */
+		obj = ____cache_alloc_node(cache, flags, numa_node_id());
+	} else {
+		if (likely(cache->nodelists[nodeid]))
+			obj = ____cache_alloc_node(cache, flags, nodeid);
+		else {
+			/* Node is not bootstrapped yet. */
+			if (!(flags & __GFP_THISNODE))
+				obj = fallback_alloc(cache, flags);
+			else
+				obj = NULL;
+		}
+	}
+  out:
+	return obj;
+}
+
+#else
+
+static __always_inline void *
+__do_cache_alloc_node(struct kmem_cache *cache, gfp_t flags, int nodeid)
+{
+	/*
+	 * For UMA, we always allocate from the local cache.
+	 */
+	return ____cache_alloc(cache, flags);
+}
+#endif /* CONFIG_NUMA */
+
+static __always_inline void *
+__cache_alloc_node(struct kmem_cache *cache, gfp_t flags, int nodeid,
+		   void *caller)
+{
+	unsigned long save_flags;
+	void *obj;
+
+	cache_alloc_debugcheck_before(cache, flags);
+	local_irq_save(save_flags);
+	obj = __do_cache_alloc_node(cache, flags, nodeid);
+	local_irq_restore(save_flags);
+	obj = cache_alloc_debugcheck_after(cache, flags, obj, caller);
+	return obj;
+}
+
+static __always_inline void *
+__cache_alloc(struct kmem_cache *cache, gfp_t flags, void *caller)
+{
+	void *obj;
+
+	obj = __cache_alloc_node(cache, flags, -1, caller);
+	prefetchw(obj);
+	return obj;
+}
 
 /*
  * Caller needs to acquire correct kmem_list's list_lock
@@ -3582,57 +3636,6 @@ out:
 }
 
 #ifdef CONFIG_NUMA
-/**
- * kmem_cache_alloc_node - Allocate an object on the specified node
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- * @nodeid: node number of the target node.
- * @caller: return address of caller, used for debug information
- *
- * Identical to kmem_cache_alloc but it will allocate memory on the given
- * node, which can improve the performance for cpu bound structures.
- *
- * Fallback to other node is possible if __GFP_THISNODE is not set.
- */
-static __always_inline void *
-__cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
-		int nodeid, void *caller)
-{
-	unsigned long save_flags;
-	void *ptr = NULL;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-
-	if (unlikely(nodeid == -1))
-		nodeid = numa_node_id();
-
-	if (likely(cachep->nodelists[nodeid])) {
-		if (nodeid == numa_node_id()) {
-			/*
-			 * Use the locally cached objects if possible.
-			 * However ____cache_alloc does not allow fallback
-			 * to other nodes. It may fail while we still have
-			 * objects on other nodes available.
-			 */
-			ptr = ____cache_alloc(cachep, flags);
-		}
-		if (!ptr) {
-			/* ___cache_alloc_node can fall back to other nodes */
-			ptr = ____cache_alloc_node(cachep, flags, nodeid);
-		}
-	} else {
-		/* Node not bootstrapped yet */
-		if (!(flags & __GFP_THISNODE))
-			ptr = fallback_alloc(cachep, flags);
-	}
-
-	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
-
-	return ptr;
-}
-
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	return __cache_alloc_node(cachep, flags, nodeid,
