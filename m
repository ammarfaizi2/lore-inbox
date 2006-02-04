Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWBDNdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWBDNdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWBDNdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:33:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:60094 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932478AbWBDNdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:33:50 -0500
Subject: [RFT/PATCH] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, christoph@lameter.com, manfred@colorfullife.com
Date: Sat, 04 Feb 2006 15:33:43 +0200
Message-Id: <1139060024.8707.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't have access to NUMA machine and would appreciate if someone
could give this patch a spin and let me know I didn't break anything.

			Pekka

Subject: slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch consolidates the UMA and NUMA memory allocation paths in the
slab allocator. This is accomplished by making the UMA-path look like
we are on NUMA but always allocating from the current node.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  104 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -828,8 +828,6 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
-static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
-
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
@@ -2665,20 +2663,12 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *cache_alloc_cpucache(struct kmem_cache *cachep,
+					 gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
-#ifdef CONFIG_NUMA
-	if (unlikely(current->mempolicy && !in_interrupt())) {
-		int nid = slab_node(current->mempolicy);
-
-		if (nid != numa_node_id())
-			return __cache_alloc_node(cachep, flags, nid);
-	}
-#endif
-
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
@@ -2692,23 +2682,6 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
-static __always_inline void *
-__cache_alloc(struct kmem_cache *cachep, gfp_t flags, void *caller)
-{
-	unsigned long save_flags;
-	void *objp;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-
-	local_irq_save(save_flags);
-	objp = ____cache_alloc(cachep, flags);
-	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					    caller);
-	prefetchw(objp);
-	return objp;
-}
-
 #ifdef CONFIG_NUMA
 /*
  * A interface to enable slab creation on nodeid
@@ -2770,8 +2743,57 @@ static void *__cache_alloc_node(struct k
       done:
 	return obj;
 }
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+
+	if (nodeid != -1 && nodeid != numa_node_id() &&
+	    cachep->nodelists[nodeid])
+		return __cache_alloc_node(cachep, flags, nodeid);
+
+	if (unlikely(current->mempolicy && !in_interrupt())) {
+		nodeid = slab_node(current->mempolicy);
+
+		if (nodeid != numa_node_id() && cachep->nodelists[nodeid])
+			return __cache_alloc_node(cachep, flags, nodeid);
+	}
+
+	return cache_alloc_cpucache(cachep, flags);
+}
+
+#else
+
+/*
+ * On UMA, we always allocate directly from the per-CPU cache.
+ */
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	return cache_alloc_cpucache(cachep, flags);
+}
+
 #endif
 
+static __always_inline void * cache_alloc(struct kmem_cache *cachep,
+					  gfp_t flags, int nodeid,
+					  void *caller)
+{
+	unsigned long save_flags;
+	void *objp;
+
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
+
+	objp = __cache_alloc(cachep, flags, nodeid);
+
+	local_irq_restore(save_flags);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
+	prefetchw(objp);
+	return objp;
+}
+
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
@@ -2933,7 +2955,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc(cachep, flags, -1, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -2994,23 +3016,7 @@ int fastcall kmem_ptr_validate(struct km
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
-	    !cachep->nodelists[nodeid])
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
 
@@ -3021,7 +3027,7 @@ void *kmalloc_node(size_t size, gfp_t fl
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	return cache_alloc(cachep, flags, node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmalloc_node);
 #endif
@@ -3060,7 +3066,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc(cachep, flags, -1, caller);
 }
 
 #ifndef CONFIG_DEBUG_SLAB


