Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWBDQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWBDQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWBDQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:26:12 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63426 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932500AbWBDQ0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:26:11 -0500
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, manfred@colorfullife.com,
       pj@sgi.com
In-Reply-To: <Pine.LNX.4.62.0602040709210.31909@graphe.net>
References: <1139060024.8707.5.camel@localhost>
	 <Pine.LNX.4.62.0602040709210.31909@graphe.net>
Date: Sat, 04 Feb 2006 18:26:09 +0200
Message-Id: <1139070369.21489.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Pekka Enberg wrote:
> > I don't have access to NUMA machine and would appreciate if someone
> > could give this patch a spin and let me know I didn't break anything.

On Sat, 2006-02-04 at 07:11 -0800, Christoph Lameter wrote:
> No time to do a full review (off to traffic school... sigh), I did not 
> see anything by just glancing over it but the patch will conflict with 
> Paul Jacksons patchset to implement memory spreading.

Here's the same patch rediffed on top of the cpuset changes.

			Pekka

Subject: slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch consolidates the UMA and NUMA memory allocation paths in the
slab allocator. This is accomplished by making the UMA-path look like
we are on NUMA but always allocating from the current node.

Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  132 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 67 insertions(+), 65 deletions(-)

Index: 2.6-cpuset/mm/slab.c
===================================================================
--- 2.6-cpuset.orig/mm/slab.c
+++ 2.6-cpuset/mm/slab.c
@@ -829,8 +829,6 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
-static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
-static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2667,17 +2665,12 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *cache_alloc_cpucache(struct kmem_cache *cachep,
+					 gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
-#ifdef CONFIG_NUMA
-	if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY)))
-		if ((objp = alternate_node_alloc(cachep, flags)) != NULL)
-			return objp;
-#endif
-
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
@@ -2691,44 +2684,8 @@ static inline void *____cache_alloc(stru
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
- * Try allocating on another node if PF_MEM_SPREAD or PF_MEMPOLICY.
- */
-static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
-{
-	int nid_alloc, nid_here;
-
-	if (in_interrupt())
-		return NULL;
-	nid_alloc = nid_here = numa_node_id();
-	if (cpuset_mem_spread_check() && (cachep->flags & SLAB_MEM_SPREAD))
-		nid_alloc = cpuset_mem_spread_node();
-	else if (current->mempolicy)
-		nid_alloc = slab_node(current->mempolicy);
-	if (nid_alloc != nid_here)
-		return __cache_alloc_node(cachep, flags, nid_alloc);
-	return NULL;
-}
-
-/*
  * A interface to enable slab creation on nodeid
  */
 static void *__cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
@@ -2788,8 +2745,69 @@ static void *__cache_alloc_node(struct k
       done:
 	return obj;
 }
+
+/*
+ * Try allocating on another node if PF_MEM_SPREAD or PF_MEMPOLICY.
+ */
+static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
+{
+	int nid_alloc, nid_here;
+
+	if (in_interrupt())
+		return NULL;
+	nid_alloc = nid_here = numa_node_id();
+	if (cpuset_mem_spread_check() && (cachep->flags & SLAB_MEM_SPREAD))
+		nid_alloc = cpuset_mem_spread_node();
+	else if (current->mempolicy)
+		nid_alloc = slab_node(current->mempolicy);
+	if (nid_alloc != nid_here)
+		return __cache_alloc_node(cachep, flags, nid_alloc);
+	return NULL;
+}
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY))) {
+		void *obj = alternate_node_alloc(cachep, flags);
+		if (obj)
+			return obj;
+	}
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
@@ -2951,7 +2969,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc(cachep, flags, -1, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3012,23 +3030,7 @@ int fastcall kmem_ptr_validate(struct km
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
 
@@ -3039,7 +3041,7 @@ void *kmalloc_node(size_t size, gfp_t fl
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	return cache_alloc(cachep, flags, node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmalloc_node);
 #endif
@@ -3078,7 +3080,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc(cachep, flags, -1, caller);
 }
 
 #ifndef CONFIG_DEBUG_SLAB


