Return-Path: <linux-kernel-owner+w=401wt.eu-S1161030AbXAEJ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbXAEJ3T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbXAEJ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:29:18 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:50795 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161012AbXAEJ3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:29:12 -0500
Date: Fri, 5 Jan 2007 11:29:10 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: hugh@veritas.com
cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] slab: fix double-free in fallback_alloc
Message-ID: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

Here's an alternative fix for the double-free bug you hit. I have only 
compile-tested this on NUMA so can you please confirm it fixes the problem 
for you? Thanks.

			Pekka

---

From: Pekka Enberg <penberg@cs.helsinki.fi>

Fix a double-free in fallback_alloc that caused pdflush to hit the
BUG_ON(!PageSlab(page)) in kmem_freepages called from fallback_alloc() on
Hugh's box.  Move __GFP_NO_GROW and __GFP_WAIT processing to kmem_getpages()
and introduce a new __cache_grow() variant that expects the memory for a new
slab to always be handed over in the 'objp' parameter.

Cc: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index 0d4e574..2fc604c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1597,6 +1597,14 @@ static int __init cpucache_init(void)
 }
 __initcall(cpucache_init);
 
+static void kmem_flagcheck(struct kmem_cache *cachep, gfp_t flags)
+{
+	if (flags & GFP_DMA)
+		BUG_ON(!(cachep->gfpflags & GFP_DMA));
+	else
+		BUG_ON(cachep->gfpflags & GFP_DMA);
+}
+
 /*
  * Interface to system's page allocator. No need to hold the cache-lock.
  *
@@ -1608,8 +1616,22 @@ static void *kmem_getpages(struct kmem_c
 {
 	struct page *page;
 	int nr_pages;
+	void *ret;
 	int i;
 
+	if (flags & __GFP_NO_GROW)
+		return NULL;
+
+	/*
+	 * The test for missing atomic flag is performed here, rather than
+	 * the more obvious place, simply to reduce the critical path length
+	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
+	 * will eventually be caught here (where it matters).
+	 */
+	kmem_flagcheck(cachep, flags);
+	if (flags & __GFP_WAIT)
+		local_irq_enable();
+
 #ifndef CONFIG_MMU
 	/*
 	 * Nommu uses slab's for process anonymous memory allocations, and thus
@@ -1621,8 +1643,10 @@ #endif
 	flags |= cachep->gfpflags;
 
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
-	if (!page)
-		return NULL;
+	if (!page) {
+		ret = NULL;
+		goto out;
+	}
 
 	nr_pages = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
@@ -1633,7 +1657,12 @@ #endif
 			NR_SLAB_UNRECLAIMABLE, nr_pages);
 	for (i = 0; i < nr_pages; i++)
 		__SetPageSlab(page + i);
-	return page_address(page);
+
+	ret = page_address(page);
+  out:
+	if (flags & __GFP_WAIT)
+		local_irq_disable();
+	return ret;
 }
 
 /*
@@ -2641,14 +2670,6 @@ #endif
 	slabp->free = 0;
 }
 
-static void kmem_flagcheck(struct kmem_cache *cachep, gfp_t flags)
-{
-	if (flags & GFP_DMA)
-		BUG_ON(!(cachep->gfpflags & GFP_DMA));
-	else
-		BUG_ON(cachep->gfpflags & GFP_DMA);
-}
-
 static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slabp,
 				int nodeid)
 {
@@ -2714,7 +2735,7 @@ static void slab_map_pages(struct kmem_c
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(struct kmem_cache *cachep,
+static int __cache_grow(struct kmem_cache *cachep,
 		gfp_t flags, int nodeid, void *objp)
 {
 	struct slab *slabp;
@@ -2754,39 +2775,17 @@ static int cache_grow(struct kmem_cache 
 
 	offset *= cachep->colour_off;
 
-	if (local_flags & __GFP_WAIT)
-		local_irq_enable();
-
-	/*
-	 * The test for missing atomic flag is performed here, rather than
-	 * the more obvious place, simply to reduce the critical path length
-	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
-	 * will eventually be caught here (where it matters).
-	 */
-	kmem_flagcheck(cachep, flags);
-
-	/*
-	 * Get mem for the objs.  Attempt to allocate a physical page from
-	 * 'nodeid'.
-	 */
-	if (!objp)
-		objp = kmem_getpages(cachep, flags, nodeid);
-	if (!objp)
-		goto failed;
-
 	/* Get slab management. */
 	slabp = alloc_slabmgmt(cachep, objp, offset,
 			local_flags & ~GFP_THISNODE, nodeid);
 	if (!slabp)
-		goto opps1;
+		return 0;
 
 	slabp->nodeid = nodeid;
 	slab_map_pages(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
 
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
 	check_irq_off();
 	spin_lock(&l3->list_lock);
 
@@ -2796,12 +2795,25 @@ static int cache_grow(struct kmem_cache 
 	l3->free_objects += cachep->num;
 	spin_unlock(&l3->list_lock);
 	return 1;
-opps1:
-	kmem_freepages(cachep, objp);
-failed:
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
-	return 0;
+}
+
+static int cache_grow(struct kmem_cache *cachep, gfp_t flags, int nodeid)
+{
+	void *objp;
+	int ret;
+
+	/*
+	 * Get mem for the objs.  Attempt to allocate a physical page from
+	 * 'nodeid'.
+	 */
+	objp = kmem_getpages(cachep, flags, nodeid);
+	if (!objp)
+		return 0;
+	
+	ret = __cache_grow(cachep, flags, nodeid, objp);
+	if (!ret)
+		kmem_freepages(cachep, objp);
+	return ret;
 }
 
 #if DEBUG
@@ -3014,7 +3026,7 @@ alloc_done:
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags | GFP_THISNODE, node, NULL);
+		x = cache_grow(cachep, flags | GFP_THISNODE, node);
 
 		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = cpu_cache_get(cachep);
@@ -3264,7 +3276,6 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 	int nid;
-	gfp_t local_flags = (flags & GFP_LEVEL_MASK);
 
 retry:
 	/*
@@ -3288,18 +3299,13 @@ retry:
 		 * We may trigger various forms of reclaim on the allowed
 		 * set and go into memory reserves if necessary.
 		 */
-		if (local_flags & __GFP_WAIT)
-			local_irq_enable();
-		kmem_flagcheck(cache, flags);
 		obj = kmem_getpages(cache, flags, -1);
-		if (local_flags & __GFP_WAIT)
-			local_irq_disable();
 		if (obj) {
 			/*
 			 * Insert into the appropriate per node queues
 			 */
 			nid = page_to_nid(virt_to_page(obj));
-			if (cache_grow(cache, flags, nid, obj)) {
+			if (__cache_grow(cache, flags, nid, obj)) {
 				obj = ____cache_alloc_node(cache,
 					flags | GFP_THISNODE, nid);
 				if (!obj)
@@ -3370,7 +3376,7 @@ retry:
 
 must_grow:
 	spin_unlock(&l3->list_lock);
-	x = cache_grow(cachep, flags | GFP_THISNODE, nodeid, NULL);
+	x = cache_grow(cachep, flags | GFP_THISNODE, nodeid);
 	if (x)
 		goto retry;
 
