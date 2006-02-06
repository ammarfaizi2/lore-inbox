Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWBFHmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBFHmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBFHmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:42:37 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47754 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750728AbWBFHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:42:37 -0500
Date: Mon, 6 Feb 2006 09:42:26 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com, steiner@sgi.com,
       dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
In-Reply-To: <Pine.LNX.4.58.0602060912100.20153@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0602060937160.21215@sbz-30.cs.Helsinki.FI>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154953.35a0f63f.akpm@osdl.org> <20060204174252.9390ddc6.pj@sgi.com>
 <20060204175411.19ff4ffb.akpm@osdl.org> <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
 <20060204210653.7bb355a2.akpm@osdl.org> <20060204220800.049521df.pj@sgi.com>
 <20060204221524.1607401e.akpm@osdl.org> <20060205215152.27800776.pj@sgi.com>
 <Pine.LNX.4.58.0602060912100.20153@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Pekka J Enberg wrote:
> For slab, I found that the following two patches reduce text size most 
> (for i386 NUMAQ config) while keeping UMA path the same. I don't have 
> actual NUMA-capable hardware so I have no way to benchmark them. Both 
> patches move code out-of-line and thus introduce new function calls which 
> might affect performance negatively.
> 
> http://www.cs.helsinki.fi/u/penberg/linux/penberg-2.6/penberg-01-slab/slab-alloc-path-cleanup.patch

Actually, the above patch isn't probably any good as it moves 
cache_alloc_cpucache() out-of-line which should be the common case for 
NUMA too (it's hurting kmem_cache_alloc and kmalloc). The following should 
be better.

Subject: slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch consolidates the UMA and NUMA memory allocation paths in the
slab allocator. This is accomplished by making the UMA-path look like
we are on NUMA but always allocating from the current node.

NUMA text size:

   text    data     bss     dec     hex filename
  16227    2640      24   18891    49cb mm/slab.o (before)
  16196    2640      24   18860    49ac mm/slab.o (after)

UMA text size stays the same.

Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -829,8 +829,6 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
-static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
-
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
@@ -2715,20 +2713,12 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static __always_inline void *cache_alloc_cpucache(struct kmem_cache *cachep,
+						  gfp_t flags)
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
@@ -2742,23 +2732,6 @@ static inline void *____cache_alloc(stru
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
@@ -2821,8 +2794,58 @@ static void *__cache_alloc_node(struct k
       done:
 	return obj;
 }
+
+static void *__cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
+{
+
+	if (nodeid != numa_node_id() && cachep->nodelists[nodeid])
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
+	return NULL;
+}
+
 #endif
 
+static __always_inline void *cache_alloc(struct kmem_cache *cachep,
+					 gfp_t flags, int nodeid,
+					 void *caller)
+{
+	unsigned long save_flags;
+	void *objp;
+
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
+
+	if (likely(nodeid == -1))
+		objp = cache_alloc_cpucache(cachep, flags);
+	else
+		objp = __cache_alloc(cachep, flags, nodeid);
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
@@ -2984,7 +3007,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc(cachep, flags, -1, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3045,23 +3068,7 @@ int fastcall kmem_ptr_validate(struct km
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
 
@@ -3111,7 +3118,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc(cachep, flags, -1, caller);
 }
 
 #ifndef CONFIG_DEBUG_SLAB
