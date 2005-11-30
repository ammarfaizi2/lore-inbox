Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVK3Vhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVK3Vhw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVK3Vhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:37:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61118 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750896AbVK3Vhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:37:51 -0500
Date: Wed, 30 Nov 2005 13:37:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alok Kataria <alokk@calsoftinc.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: [RFC] Use compound pages for higher order slab allocations.
Message-ID: <Pine.LNX.4.62.0511301334450.20244@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has the ability to manage larger order pages as compound pages.
However, the slab allocator does not take advantage of these capabilities.
For each page of a higher order allocation a special state is kept
and updated.

This patch allows the slab allocator to use compound pages and only keep
state in the first page struct for a higher order allocation.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc3/mm/slab.c
===================================================================
--- linux-2.6.15-rc3.orig/mm/slab.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3/mm/slab.c	2005-11-30 13:20:29.000000000 -0800
@@ -565,6 +565,16 @@ static void **dbg_userword(kmem_cache_t 
 #define	BREAK_GFP_ORDER_LO	0
 static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
 
+static inline struct page *virt_to_compound_page(const void *addr)
+{
+	struct page * page = virt_to_page(addr);
+
+	if (PageCompound(page))
+        	page = (struct page *)page_private(page);
+
+	return page;
+}
+
 /* Functions for storing/retrieving the cachep and or slab from the
  * global 'mem_map'. These are used to find the slab an obj belongs to.
  * With kfree(), these are used to find the cache which an obj belongs to.
@@ -584,11 +594,17 @@ static inline void page_set_slab(struct 
 	page->lru.prev = (struct list_head *)slab;
 }
 
-static inline struct slab *page_get_slab(struct page *page)
+static inline struct slab *page_get_slab(const struct page *page)
 {
 	return (struct slab *)page->lru.prev;
 }
 
+static inline struct slab *get_slab(const void *objp)
+{
+	return page_get_slab(virt_to_compound_page(objp));
+}
+
+
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
@@ -1214,15 +1230,14 @@ static void *kmem_getpages(kmem_cache_t 
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(i, &slab_reclaim_pages);
 	add_page_state(nr_slab, i);
-	while (i--) {
-		SetPageSlab(page);
-		page++;
-	}
+	SetPageSlab(page);
 	return addr;
 }
 
 /*
  * Interface to system's page release.
+ *
+ * addr is the starting address of the slab page
  */
 static void kmem_freepages(kmem_cache_t *cachep, void *addr)
 {
@@ -1230,11 +1245,8 @@ static void kmem_freepages(kmem_cache_t 
 	struct page *page = virt_to_page(addr);
 	const unsigned long nr_freed = i;
 
-	while (i--) {
-		if (!TestClearPageSlab(page))
-			BUG();
-		page++;
-	}
+	if (!TestClearPageSlab(page))
+		BUG();
 	sub_page_state(nr_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
@@ -1379,7 +1391,7 @@ static void check_poison_obj(kmem_cache_
 		/* Print some data about the neighboring objects, if they
 		 * exist:
 		 */
-		struct slab *slabp = page_get_slab(virt_to_page(objp));
+		struct slab *slabp = get_slab(objp);
 		int objnr;
 
 		objnr = (objp-slabp->s_mem)/cachep->objsize;
@@ -1753,9 +1765,11 @@ next:
 	cachep->colour = left_over/cachep->colour_off;
 	cachep->slab_size = slab_size;
 	cachep->flags = flags;
-	cachep->gfpflags = 0;
+
+	cachep->gfpflags = cachep->gfporder ? __GFP_COMP : 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
+
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
 
@@ -2142,17 +2156,11 @@ static void kmem_flagcheck(kmem_cache_t 
 
 static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
 {
-	int i;
 	struct page *page;
 
-	/* Nasty!!!!!! I hope this is OK. */
-	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
-	do {
-		page_set_cache(page, cachep);
-		page_set_slab(page, slabp);
-		page++;
-	} while (--i);
+	page_set_cache(page, cachep);
+	page_set_slab(page, slabp);
 }
 
 /*
@@ -2262,7 +2270,7 @@ static void kfree_debugcheck(const void 
 			(unsigned long)objp);	
 		BUG();	
 	}
-	page = virt_to_page(objp);
+	page = virt_to_compound_page(objp);
 	if (!PageSlab(page)) {
 		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n", (unsigned long)objp);
 		BUG();
@@ -2278,7 +2286,7 @@ static void *cache_free_debugcheck(kmem_
 
 	objp -= obj_dbghead(cachep);
 	kfree_debugcheck(objp);
-	page = virt_to_page(objp);
+	page = virt_to_compound_page(objp);
 
 	if (page_get_cache(page) != cachep) {
 		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
@@ -2639,7 +2647,7 @@ static void free_block(kmem_cache_t *cac
 		struct slab *slabp;
 		unsigned int objnr;
 
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = get_slab(objp);
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
@@ -2755,7 +2763,7 @@ static inline void __cache_free(kmem_cac
 #ifdef CONFIG_NUMA
 	{
 		struct slab *slabp;
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = get_slab(objp);
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
@@ -2838,7 +2846,7 @@ int fastcall kmem_ptr_validate(kmem_cach
 		goto out;
 	if (unlikely(!kern_addr_valid(addr + size - 1)))
 		goto out;
-	page = virt_to_page(ptr);
+	page = virt_to_compound_page(ptr);
 	if (unlikely(!PageSlab(page)))
 		goto out;
 	if (unlikely(page_get_cache(page) != cachep))
@@ -3037,7 +3045,7 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
-	c = page_get_cache(virt_to_page(objp));
+	c = page_get_cache(virt_to_compound_page(objp));
 	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }
@@ -3607,7 +3615,7 @@ unsigned int ksize(const void *objp)
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_reallen(page_get_cache(virt_to_page(objp)));
+	return obj_reallen(page_get_cache(virt_to_compound_page(objp)));
 }
 
 
