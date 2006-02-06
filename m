Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWBFRcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBFRcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWBFRcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:32:18 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31134 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932249AbWBFRcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:32:17 -0500
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
	hooks
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com, steiner@sgi.com,
       dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
In-Reply-To: <Pine.LNX.4.58.0602060948560.21447@sbz-30.cs.Helsinki.FI>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	 <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	 <20060204154953.35a0f63f.akpm@osdl.org>
	 <20060204174252.9390ddc6.pj@sgi.com>
	 <20060204175411.19ff4ffb.akpm@osdl.org>
	 <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
	 <20060204210653.7bb355a2.akpm@osdl.org>
	 <20060204220800.049521df.pj@sgi.com>
	 <20060204221524.1607401e.akpm@osdl.org>
	 <20060205215152.27800776.pj@sgi.com>
	 <Pine.LNX.4.58.0602060912100.20153@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.58.0602060937160.21215@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.58.0602060948560.21447@sbz-30.cs.Helsinki.FI>
Date: Mon, 06 Feb 2006 19:32:13 +0200
Message-Id: <1139247134.11803.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Feb 2006, Pekka J Enberg wrote:
> > Actually, the above patch isn't probably any good as it moves 
> > cache_alloc_cpucache() out-of-line which should be the common case for 
> > NUMA too (it's hurting kmem_cache_alloc and kmalloc). The following should 
> > be better.

Paul, as requested, here's one on top of your cpuset changes. This one
preserves kernel text size for both UMA and NUMA so it's code
restructuring only. The optimizations you did in the cpuset patches
already make the NUMA fastpath so small that I wasn't able to improve it
on i386.

			Pekka

Subject: slab: alloc path consolidation
From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch consolidates the UMA and NUMA memory allocation paths in the
slab allocator. This is accomplished by making the UMA-path look like
we are on NUMA but always allocating from the current node. The patch has
no functional changes, only code restructuring.

Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   98 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

Index: 2.6-cpuset/mm/slab.c
===================================================================
--- 2.6-cpuset.orig/mm/slab.c
+++ 2.6-cpuset/mm/slab.c
@@ -830,7 +830,6 @@ static struct array_cache *alloc_arrayca
 
 #ifdef CONFIG_NUMA
 static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
-static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2667,17 +2666,11 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *cache_alloc_cpu_cache(struct kmem_cache *cachep, gfp_t flags)
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
@@ -2691,23 +2684,6 @@ static inline void *____cache_alloc(stru
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
  * Try allocating on another node if PF_MEM_SPREAD or PF_MEMPOLICY.
@@ -2788,8 +2764,58 @@ static void *__cache_alloc_node(struct k
       done:
 	return obj;
 }
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	void *objp;
+
+	if (nodeid == -1 || nodeid == numa_node_id() ||
+	    !cachep->nodelists[nodeid]) {
+		if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY))) {
+			objp = alternate_node_alloc(cachep, flags);
+			if (objp)
+				goto out;
+		}
+		objp = cache_alloc_cpu_cache(cachep, flags);
+	} else
+		objp = __cache_alloc_node(cachep, flags, nodeid);
+  out:
+	return objp;
+}
+
+#else
+
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+					   gfp_t flags, int nodeid)
+{
+	return cache_alloc_cpu_cache(cachep, flags);
+}
+
 #endif
 
+static __always_inline void *cache_alloc(struct kmem_cache *cache,
+					 gfp_t flags, int nodeid, void *caller)
+{
+	unsigned long save_flags;
+	void *obj;
+
+	cache_alloc_debugcheck_before(cache, flags);
+	local_irq_save(save_flags);
+	obj = __cache_alloc(cache, flags, nodeid);
+	local_irq_restore(save_flags);
+	obj = cache_alloc_debugcheck_after(cache, flags, obj, caller);
+	return obj;
+}
+
+static __always_inline void *
+cache_alloc_current(struct kmem_cache *cache, gfp_t flags, void *caller)
+{
+	void *obj = cache_alloc(cache, flags, -1, caller);
+	prefetchw(obj);
+	return obj;
+}
+
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
@@ -2951,7 +2977,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	return cache_alloc_current(cachep, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3012,23 +3038,7 @@ int fastcall kmem_ptr_validate(struct km
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
 
@@ -3078,7 +3088,7 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	return cache_alloc_current(cachep, flags, caller);
 }
 
 #ifndef CONFIG_DEBUG_SLAB


