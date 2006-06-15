Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWFOHMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWFOHMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWFOHMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:12:47 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57237 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750936AbWFOHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:12:47 -0400
Subject: [RFC/PATCH 2/2] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: christoph@lameter.com, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Date: Thu, 15 Jun 2006 10:12:45 +0300
Message-Id: <1150355565.4633.8.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch consolidates the UMA and NUMA memory allocation paths in the
slab allocator. This is accomplished by making the UMA-path look like
we are on NUMA but always allocating from the current node.

There is a slight increase in NUMA kernel text size with this patch:

   text    data     bss     dec     hex filename
  17019    2520      20   19559    4c67 mm/slab.o (before)
  17034    2520      20   19574    4c76 mm/slab.o (after)

However, bloatometer says it's even less:

  add/remove: 0/0 grow/shrink: 1/1 up/down: 4/-1 (3)
  function                                     old     new   delta
  kmem_cache_alloc_node                        161     165      +4
  kmem_cache_create                           1512    1511      -1

UMA text size is unchanged.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 mm/slab.c |   52 +++++++++++++++++++++-------------------------------
 1 files changed, 21 insertions(+), 31 deletions(-)

3b92d48f346b46b3a050f4195497c96f5eb6bb59
diff --git a/mm/slab.c b/mm/slab.c
index 579cff3..83a3394 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2855,8 +2855,8 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static __always_inline void *__cache_alloc_cpucache(struct kmem_cache *cachep,
-						    gfp_t flags)
+static __always_inline void *cache_alloc_cpucache(struct kmem_cache *cachep,
+						  gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
@@ -2959,14 +2959,19 @@ done:
 	return obj;
 }
 
-static inline void *cache_alloc_cpucache(struct kmem_cache *cache, gfp_t flags)
+static inline void *__cache_alloc(struct kmem_cache *cache, gfp_t flags,
+				  int nodeid)
 {
+	if (nodeid != -1 && nodeid != numa_node_id() &&
+	    cache->nodelists[nodeid])
+		return __cache_alloc_node(cache, flags, nodeid);
+
 	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
 		void *objp = alternate_node_alloc(cache, flags);
 		if (objp != NULL)
 			return objp;
 	}
-	return __cache_alloc_cpucache(cache, flags);
+	return cache_alloc_cpucache(cache, flags);
 }
 
 #else
@@ -2975,15 +2980,17 @@ static inline void *cache_alloc_cpucache
  * On UMA, we always allocate directly drom the per-CPU cache.
  */
 
-static inline void *cache_alloc_cpucache(struct kmem_cache *cache, gfp_t flags)
+static __always_inline void *__cache_alloc(struct kmem_cache *cache,
+					   gfp_t flags, int nodeid)
 {
-	return __cache_alloc_cpucache(cache, flags);
+	return cache_alloc_cpucache(cache, flags);
 }
 
 #endif
 
-static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
-						gfp_t flags, void *caller)
+static __always_inline void *cache_alloc(struct kmem_cache *cachep,
+					 gfp_t flags, int nodeid,
+					 void *caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -2991,10 +2998,9 @@ static __always_inline void *__cache_all
 	cache_alloc_debugcheck_before(cachep, flags);
 
 	local_irq_save(save_flags);
-	objp = cache_alloc_cpucache(cachep, flags);
+	objp = __cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					    caller);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
 	return objp;
 }
@@ -3158,7 +3164,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc(cachep, flags, -1, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3172,7 +3178,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  */
 void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
 {
-	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+	void *ret = cache_alloc(cache, flags, -1, __builtin_return_address(0));
 	if (ret)
 		memset(ret, 0, obj_size(cache));
 	return ret;
@@ -3236,23 +3242,7 @@ out:
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
-		ptr = cache_alloc_cpucache(cachep, flags);
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
 
@@ -3303,7 +3293,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc(cachep, flags, -1, caller);
 }
 
 
-- 
1.1.3


