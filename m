Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVKJUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVKJUBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKJUBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:01:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18847 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751224AbVKJUBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:01:50 -0500
Subject: [PATCH] slab: convert cache to page mapping macros (try #3)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
In-Reply-To: <1131651926.18971.6.camel@localhost>
References: <1131650375.18971.2.camel@localhost>
	 <1131651926.18971.6.camel@localhost>
Date: Thu, 10 Nov 2005 21:56:28 +0200
Message-Id: <1131652588.24360.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh well, please pass me the brown paper bag... Third attempt and
this time againsta clean tree.

This patch converts object cache <-> page mapping macros to static inline
functions to make the more explicit and readable.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -565,14 +565,29 @@ static void **dbg_userword(kmem_cache_t 
 #define	BREAK_GFP_ORDER_LO	0
 static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
 
-/* Macros for storing/retrieving the cachep and or slab from the
+/* Functions for storing/retrieving the cachep and or slab from the
  * global 'mem_map'. These are used to find the slab an obj belongs to.
  * With kfree(), these are used to find the cache which an obj belongs to.
  */
-#define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
-#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
-#define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
-#define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
+static inline void page_set_cache(struct page *page, struct kmem_cache *cache)
+{
+	page->lru.next = (struct list_head *)cache;
+}
+
+static inline struct kmem_cache *page_get_cache(struct page *page)
+{
+	return (struct kmem_cache *)page->lru.next;
+}
+
+static inline void page_set_slab(struct page *page, struct slab *slab)
+{
+	page->lru.prev = (struct list_head *)slab;
+}
+
+static inline struct slab *page_get_slab(struct page *page)
+{
+	return (struct slab *)page->lru.prev;
+}
 
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
@@ -1368,7 +1383,7 @@ static void check_poison_obj(kmem_cache_
 		/* Print some data about the neighboring objects, if they
 		 * exist:
 		 */
-		struct slab *slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		struct slab *slabp = page_get_slab(virt_to_page(objp));
 		int objnr;
 
 		objnr = (objp-slabp->s_mem)/cachep->objsize;
@@ -2138,8 +2153,8 @@ static void set_slab_attr(kmem_cache_t *
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
 	do {
-		SET_PAGE_CACHE(page, cachep);
-		SET_PAGE_SLAB(page, slabp);
+		page_set_cache(page, cachep);
+		page_set_slab(page, slabp);
 		page++;
 	} while (--i);
 }
@@ -2269,14 +2284,14 @@ static void *cache_free_debugcheck(kmem_
 	kfree_debugcheck(objp);
 	page = virt_to_page(objp);
 
-	if (GET_PAGE_CACHE(page) != cachep) {
+	if (page_get_cache(page) != cachep) {
 		printk(KERN_ERR "mismatch in kmem_cache_free: expected cache %p, got %p\n",
-				GET_PAGE_CACHE(page),cachep);
+				page_get_cache(page),cachep);
 		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
-		printk(KERN_ERR "%p is %s.\n", GET_PAGE_CACHE(page), GET_PAGE_CACHE(page)->name);
+		printk(KERN_ERR "%p is %s.\n", page_get_cache(page), page_get_cache(page)->name);
 		WARN_ON(1);
 	}
-	slabp = GET_PAGE_SLAB(page);
+	slabp = page_get_slab(page);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE || *dbg_redzone2(cachep, objp) != RED_ACTIVE) {
@@ -2628,7 +2643,7 @@ static void free_block(kmem_cache_t *cac
 		struct slab *slabp;
 		unsigned int objnr;
 
-		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		slabp = page_get_slab(virt_to_page(objp));
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
@@ -2744,7 +2759,7 @@ static inline void __cache_free(kmem_cac
 #ifdef CONFIG_NUMA
 	{
 		struct slab *slabp;
-		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		slabp = page_get_slab(virt_to_page(objp));
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
@@ -2830,7 +2845,7 @@ int fastcall kmem_ptr_validate(kmem_cach
 	page = virt_to_page(ptr);
 	if (unlikely(!PageSlab(page)))
 		goto out;
-	if (unlikely(GET_PAGE_CACHE(page) != cachep))
+	if (unlikely(page_get_cache(page) != cachep))
 		goto out;
 	return 1;
 out:
@@ -3026,7 +3041,7 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
-	c = GET_PAGE_CACHE(virt_to_page(objp));
+	c = page_get_cache(virt_to_page(objp));
 	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }
@@ -3596,7 +3611,7 @@ unsigned int ksize(const void *objp)
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_reallen(GET_PAGE_CACHE(virt_to_page(objp)));
+	return obj_reallen(page_get_cache(virt_to_page(objp)));
 }
 
 


