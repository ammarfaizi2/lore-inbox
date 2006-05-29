Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWE2Vcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWE2Vcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWE2V0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55009 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751369AbWE2V03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:29 -0400
Date: Mon, 29 May 2006 23:26:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 46/61] lock validator: special locking: slab
Message-ID: <20060529212649.GT3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

fix initialize-locks-via-memcpy assumptions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 mm/slab.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 11 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -1026,7 +1026,8 @@ static void drain_alien_cache(struct kme
 	}
 }
 
-static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
+static inline int cache_free_alien(struct kmem_cache *cachep, void *objp,
+				   int nesting)
 {
 	struct slab *slabp = virt_to_slab(objp);
 	int nodeid = slabp->nodeid;
@@ -1044,7 +1045,7 @@ static inline int cache_free_alien(struc
 	STATS_INC_NODEFREES(cachep);
 	if (l3->alien && l3->alien[nodeid]) {
 		alien = l3->alien[nodeid];
-		spin_lock(&alien->lock);
+		spin_lock_nested(&alien->lock, nesting);
 		if (unlikely(alien->avail == alien->limit)) {
 			STATS_INC_ACOVERFLOW(cachep);
 			__drain_alien_cache(cachep, alien, nodeid);
@@ -1073,7 +1074,8 @@ static inline void free_alien_cache(stru
 {
 }
 
-static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
+static inline int cache_free_alien(struct kmem_cache *cachep, void *objp,
+				   int nesting)
 {
 	return 0;
 }
@@ -1278,6 +1280,11 @@ static void init_list(struct kmem_cache 
 
 	local_irq_disable();
 	memcpy(ptr, list, sizeof(struct kmem_list3));
+	/*
+	 * Do not assume that spinlocks can be initialized via memcpy:
+	 */
+	spin_lock_init(&ptr->list_lock);
+
 	MAKE_ALL_LISTS(cachep, ptr, nodeid);
 	cachep->nodelists[nodeid] = ptr;
 	local_irq_enable();
@@ -1408,7 +1415,7 @@ void __init kmem_cache_init(void)
 	}
 	/* 4) Replace the bootstrap head arrays */
 	{
-		void *ptr;
+		struct array_cache *ptr;
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
@@ -1416,6 +1423,11 @@ void __init kmem_cache_init(void)
 		BUG_ON(cpu_cache_get(&cache_cache) != &initarray_cache.cache);
 		memcpy(ptr, cpu_cache_get(&cache_cache),
 		       sizeof(struct arraycache_init));
+		/*
+		 * Do not assume that spinlocks can be initialized via memcpy:
+		 */
+		spin_lock_init(&ptr->lock);
+
 		cache_cache.array[smp_processor_id()] = ptr;
 		local_irq_enable();
 
@@ -1426,6 +1438,11 @@ void __init kmem_cache_init(void)
 		       != &initarray_generic.cache);
 		memcpy(ptr, cpu_cache_get(malloc_sizes[INDEX_AC].cs_cachep),
 		       sizeof(struct arraycache_init));
+		/*
+		 * Do not assume that spinlocks can be initialized via memcpy:
+		 */
+		spin_lock_init(&ptr->lock);
+
 		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
 		    ptr;
 		local_irq_enable();
@@ -1753,6 +1770,8 @@ static void slab_destroy_objs(struct kme
 }
 #endif
 
+static void __cache_free(struct kmem_cache *cachep, void *objp, int nesting);
+
 /**
  * slab_destroy - destroy and release all objects in a slab
  * @cachep: cache pointer being destroyed
@@ -1776,8 +1795,17 @@ static void slab_destroy(struct kmem_cac
 		call_rcu(&slab_rcu->head, kmem_rcu_free);
 	} else {
 		kmem_freepages(cachep, addr);
-		if (OFF_SLAB(cachep))
-			kmem_cache_free(cachep->slabp_cache, slabp);
+		if (OFF_SLAB(cachep)) {
+			unsigned long flags;
+
+			/*
+		 	 * lockdep: we may nest inside an already held
+			 * ac->lock, so pass in a nesting flag:
+			 */
+			local_irq_save(flags);
+			__cache_free(cachep->slabp_cache, slabp, 1);
+			local_irq_restore(flags);
+		}
 	}
 }
 
@@ -3062,7 +3090,16 @@ static void free_block(struct kmem_cache
 		if (slabp->inuse == 0) {
 			if (l3->free_objects > l3->free_limit) {
 				l3->free_objects -= cachep->num;
+				/*
+				 * It is safe to drop the lock. The slab is
+				 * no longer linked to the cache. cachep
+				 * cannot disappear - we are using it and
+				 * all destruction of caches must be
+				 * serialized properly by the user.
+				 */
+				spin_unlock(&l3->list_lock);
 				slab_destroy(cachep, slabp);
+				spin_lock(&l3->list_lock);
 			} else {
 				list_add(&slabp->list, &l3->slabs_free);
 			}
@@ -3088,7 +3125,7 @@ static void cache_flusharray(struct kmem
 #endif
 	check_irq_off();
 	l3 = cachep->nodelists[node];
-	spin_lock(&l3->list_lock);
+	spin_lock_nested(&l3->list_lock, SINGLE_DEPTH_NESTING);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		int max = shared_array->limit - shared_array->avail;
@@ -3131,14 +3168,14 @@ free_done:
  * Release an obj back to its cache. If the obj has a constructed state, it must
  * be in this state _before_ it is released.  Called with disabled ints.
  */
-static inline void __cache_free(struct kmem_cache *cachep, void *objp)
+static void __cache_free(struct kmem_cache *cachep, void *objp, int nesting)
 {
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
-	if (cache_free_alien(cachep, objp))
+	if (cache_free_alien(cachep, objp, nesting))
 		return;
 
 	if (likely(ac->avail < ac->limit)) {
@@ -3393,7 +3430,7 @@ void kmem_cache_free(struct kmem_cache *
 	BUG_ON(virt_to_cache(objp) != cachep);
 
 	local_irq_save(flags);
-	__cache_free(cachep, objp);
+	__cache_free(cachep, objp, 0);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kmem_cache_free);
@@ -3418,7 +3455,7 @@ void kfree(const void *objp)
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
 	debug_check_no_locks_freed(objp, obj_size(c));
-	__cache_free(c, (void *)objp);
+	__cache_free(c, (void *)objp, 0);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kfree);
