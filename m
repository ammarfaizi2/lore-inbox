Return-Path: <linux-kernel-owner+w=401wt.eu-S1030212AbXADUvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbXADUvH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbXADUvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:51:06 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43520 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030206AbXADUvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:51:05 -0500
Date: Thu, 4 Jan 2007 22:51:03 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701041042020.21800@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0701042249270.10892@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
 <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
 <Pine.LNX.4.64.0701041042020.21800@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, 4 Jan 2007, Christoph Lameter wrote:
> Good idea if you can make it so that it is clean. There is some 
> additional processing in cache_grow() that would have to be taken into 
> account.

Something like this (totally untested) patch?

diff --git a/mm/slab.c b/mm/slab.c
index 0d4e574..48fa397 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1608,8 +1608,19 @@ static void *kmem_getpages(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct page *page;
 	int nr_pages;
+	void *ret;
 	int i;
 
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
@@ -1621,8 +1632,10 @@ static void *kmem_getpages(struct kmem_cache *cachep, gfp_t flags, int nodeid)
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
@@ -1633,7 +1646,12 @@ static void *kmem_getpages(struct kmem_cache *cachep, gfp_t flags, int nodeid)
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
@@ -2714,7 +2732,7 @@ static void slab_map_pages(struct kmem_cache *cache, struct slab *slab,
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(struct kmem_cache *cachep,
+static int __cache_grow(struct kmem_cache *cachep,
 		gfp_t flags, int nodeid, void *objp)
 {
 	struct slab *slabp;
@@ -2754,39 +2772,17 @@ static int cache_grow(struct kmem_cache *cachep,
 
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
 
@@ -2796,12 +2792,28 @@ static int cache_grow(struct kmem_cache *cachep,
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
+	if (flags & __GFP_NO_GROW)
+		return 0;
+
+	/*
+	 * Get mem for the objs.  Attempt to allocate a physical page from
+	 * 'nodeid'.
+	 */
+	objp = kmem_getpages(cachep, flags, nodeid);
+	if (!objp)
+		return 0;
+	
+	ret = __cache_grow(cachep, flags, nodeid, obj);
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
@@ -3288,18 +3300,13 @@ retry:
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
@@ -3370,7 +3377,7 @@ retry:
 
 must_grow:
 	spin_unlock(&l3->list_lock);
-	x = cache_grow(cachep, flags | GFP_THISNODE, nodeid, NULL);
+	x = cache_grow(cachep, flags | GFP_THISNODE, nodeid);
 	if (x)
 		goto retry;
 
