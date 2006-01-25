Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWAYVhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWAYVhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWAYVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:37:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:29912 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751208AbWAYVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:37:14 -0500
Subject: [patch 9/9] slab - Implement single mempool backing for slab
	allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:40:24 -0800
Message-Id: <1138218024.2092.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Support for using a single mempool as a critical pool for all slab allocations.

This patch completes the actual implementation of this functionality.  What we
do is take the mempool_t pointer, which is now passed into the slab allocator
by all the externally callable functions (thanks to the last patch), and pass
it all the way down through the slab allocator code.  If the slab allocator
needs to allocate memory to satisfy a slab request, which only happens in
kmem_getpages(), it will allocate that memory via the mempool's allocator,
rather than calling alloc_pages_node() directly.  This allows us to use a
single mempool to back ALL slab allocations for a single subsystem, rather than
having to back each & every kmem_cache_alloc/kmalloc allocation that subsystem
makes with it's own mempool.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 slab.c |   60 +++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 21 deletions(-)

Index: linux-2.6.16-rc1+critical_mempools/mm/slab.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/slab.c
+++ linux-2.6.16-rc1+critical_mempools/mm/slab.c
@@ -1209,15 +1209,26 @@ __initcall(cpucache_init);
  * If we requested dmaable memory, we will get it. Even if we
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
+ *
+ * For now, we only support order-0 allocations with mempools.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid,
+			   mempool_t *pool)
 {
 	struct page *page;
 	void *addr;
 	int i;
 
 	flags |= cachep->gfpflags;
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	/*
+	 * If this allocation request isn't backed by a memory pool, or if that
+	 * memory pool's gfporder is not the same as the cache's gfporder, fall
+	 * back to alloc_pages_node().
+	 */
+	if (!pool || cachep->gfporder != (int)pool->pool_data)
+		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	else
+		page = mempool_alloc_node(pool, flags, nodeid);
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -2084,13 +2095,15 @@ EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
 static struct slab *alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
-				   int colour_off, gfp_t local_flags)
+				   int colour_off, gfp_t local_flags,
+				   mempool_t *pool)
 {
 	struct slab *slabp;
 
 	if (OFF_SLAB(cachep)) {
 		/* Slab management obj is off-slab. */
-		slabp = kmem_cache_alloc(cachep->slabp_cache, local_flags);
+		slabp = kmem_cache_alloc_mempool(cachep->slabp_cache,
+						 local_flags, pool);
 		if (!slabp)
 			return NULL;
 	} else {
@@ -2188,7 +2201,8 @@ static void set_slab_attr(kmem_cache_t *
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid,
+		      mempool_t *pool)
 {
 	struct slab *slabp;
 	void *objp;
@@ -2242,11 +2256,11 @@ static int cache_grow(kmem_cache_t *cach
 	/* Get mem for the objs.
 	 * Attempt to allocate a physical page from 'nodeid',
 	 */
-	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
+	if (!(objp = kmem_getpages(cachep, flags, nodeid, pool)))
 		goto failed;
 
 	/* Get slab management. */
-	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
+	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags, pool)))
 		goto opps1;
 
 	slabp->nodeid = nodeid;
@@ -2406,7 +2420,8 @@ static void check_slabp(kmem_cache_t *ca
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
+static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags,
+				mempool_t *pool)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2492,7 +2507,7 @@ static void *cache_alloc_refill(kmem_cac
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		x = cache_grow(cachep, flags, numa_node_id(), pool);
 
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
@@ -2565,7 +2580,8 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags,
+				    mempool_t *pool)
 {
 	void *objp;
 	struct array_cache *ac;
@@ -2578,12 +2594,13 @@ static inline void *____cache_alloc(kmem
 		objp = ac->entry[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
-		objp = cache_alloc_refill(cachep, flags);
+		objp = cache_alloc_refill(cachep, flags, pool);
 	}
 	return objp;
 }
 
-static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags,
+				  mempool_t *pool)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -2591,7 +2608,7 @@ static inline void *__cache_alloc(kmem_c
 	cache_alloc_debugcheck_before(cachep, flags);
 
 	local_irq_save(save_flags);
-	objp = ____cache_alloc(cachep, flags);
+	objp = ____cache_alloc(cachep, flags, pool);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    __builtin_return_address(0));
@@ -2603,7 +2620,8 @@ static inline void *__cache_alloc(kmem_c
 /*
  * A interface to enable slab creation on nodeid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid,
+				mempool_t *pool)
 {
 	struct list_head *entry;
 	struct slab *slabp;
@@ -2659,7 +2677,7 @@ static void *__cache_alloc_node(kmem_cac
 
       must_grow:
 	spin_unlock(&l3->list_lock);
-	x = cache_grow(cachep, flags, nodeid);
+	x = cache_grow(cachep, flags, nodeid, pool);
 
 	if (!x)
 		return NULL;
@@ -2848,7 +2866,7 @@ static inline void __cache_free(kmem_cac
 void *kmem_cache_alloc_mempool(kmem_cache_t *cachep, gfp_t flags,
 			       mempool_t *pool)
 {
-	return __cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags, pool);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_mempool);
 
@@ -2921,22 +2939,22 @@ void *kmem_cache_alloc_node_mempool(kmem
 	void *ptr;
 
 	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
+		return __cache_alloc(cachep, flags, pool);
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
 		printk(KERN_WARNING
 		       "slab: not allocating in inactive node %d for cache %s\n",
 		       nodeid, cachep->name);
-		return __cache_alloc(cachep, flags);
+		return __cache_alloc(cachep, flags, pool);
 	}
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
 	if (nodeid == numa_node_id())
-		ptr = ____cache_alloc(cachep, flags);
+		ptr = ____cache_alloc(cachep, flags, pool);
 	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
+		ptr = __cache_alloc_node(cachep, flags, nodeid, pool);
 	local_irq_restore(save_flags);
 	ptr =
 	    cache_alloc_debugcheck_after(cachep, flags, ptr,
@@ -3004,7 +3022,7 @@ void *__kmalloc(size_t size, gfp_t flags
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags, pool);
 }
 EXPORT_SYMBOL(__kmalloc);
 

--

