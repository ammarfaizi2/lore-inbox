Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWI2K4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWI2K4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWI2K4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:56:11 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19380 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932159AbWI2K4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:56:09 -0400
Date: Fri, 29 Sep 2006 13:56:07 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC/PATCH] slab: clean up allocation
Message-ID: <Pine.LNX.4.58.0609291353060.30021@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch cleans up the slab allocation path by making the UMA case look like
NUMA that always allocates from the current node.  In addition, I merged up the
two NUMA allocation paths (kmem_cache_alloc_node and __cache_alloc) into single
function so that we always use alternate_node_alloc() if PF_SPREAD_SLAB or
PF_MEMPOLICY is defined.

Note: increases kernel text on numa by 70 bytes on x86 due to inlining of
the cache_alloc function in multiple call sites.

Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  116 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 50 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -210,6 +210,11 @@ typedef unsigned int kmem_bufctl_t;
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-3)
 
 /*
+ * When allocating from current node.
+ */
+#define SLAB_CURRENT_NODE (-1)
+
+/*
  * struct slab
  *
  * Manages the objs in a slab. Placed either at the beginning of mem allocated
@@ -3041,7 +3046,7 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *cache_alloc_local(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
@@ -3059,35 +3064,6 @@ static inline void *____cache_alloc(stru
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
-	 * __cache_alloc_node() knows how to locate memory on other nodes
-	 */
- 	if (NUMA_BUILD && !objp)
- 		objp = __cache_alloc_node(cachep, flags, numa_node_id());
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
@@ -3198,8 +3174,62 @@ must_grow:
 done:
 	return obj;
 }
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	void *objp = NULL;
+
+	if (nodeid == SLAB_CURRENT_NODE || nodeid == numa_node_id() ||
+			!cachep->nodelists[nodeid]) {
+		if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY)))
+			objp = alternate_node_alloc(cachep, flags);
+
+		if (!objp)
+			objp = cache_alloc_local(cachep, flags);
+		/*
+		 * We may just have run out of memory on the local node.
+		 * __cache_alloc_node() knows how to locate memory on other nodes
+		 */
+	 	if (!objp)
+	 		objp = __cache_alloc_node(cachep, flags, numa_node_id());
+	} else
+		objp = __cache_alloc_node(cachep, flags, nodeid);
+
+	return objp;
+}
+
+#else
+/*
+ *	On UMA, we always allocate from the local node.
+ */
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	return cache_alloc_local(cachep, flags);
+}
 #endif
 
+static __always_inline void *cache_alloc(struct kmem_cache *cachep,
+					 gfp_t flags, int nodeid,
+					 void *caller)
+{
+	unsigned long save_flags;
+	void *objp;
+
+	cache_alloc_debugcheck_before(cachep, flags);
+
+	local_irq_save(save_flags);
+	objp = __cache_alloc(cachep, flags, nodeid);
+	local_irq_restore(save_flags);
+
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
+	prefetchw(objp);
+
+	return objp;
+}
+
+
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
@@ -3333,7 +3363,8 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc(cachep, flags, SLAB_CURRENT_NODE,
+			   __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3347,7 +3378,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  */
 void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
 {
-	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+	void *ret = cache_alloc(cache, flags, SLAB_CURRENT_NODE,
+				__builtin_return_address(0));
 	if (ret)
 		memset(ret, 0, obj_size(cache));
 	return ret;
@@ -3411,23 +3443,7 @@ out:
  */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	unsigned long save_flags;
-	void *ptr;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-
-	if (nodeid == -1 || nodeid == numa_node_id() ||
-			!cachep->nodelists[nodeid])
-		ptr = ____cache_alloc(cachep, flags);
-	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
-	local_irq_restore(save_flags);
-
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
-					   __builtin_return_address(0));
-
-	return ptr;
+	return cache_alloc(cachep, flags, nodeid, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
@@ -3462,7 +3478,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc(cachep, flags, SLAB_CURRENT_NODE, caller);
 }
 
 
