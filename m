Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWF2TWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWF2TWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWF2TWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:22:15 -0400
Received: from [141.84.69.5] ([141.84.69.5]:31504 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932296AbWF2TVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:21:42 -0400
Date: Thu, 29 Jun 2006 21:20:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] mm/: possible cleanups
Message-ID: <20060629192047.GV19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global functions static:
  - slab.c: kmem_find_general_cachep
  - swap.c: __page_cache_release
  - vmalloc.c: __vmalloc_node
- remove the following unused EXPORT_SYMBOL's:
  - bootmem.c: max_pfn
  - memory.c: vmtruncate_range
  - mmzone.c: first_online_pgdat
  - mmzone.c: next_online_pgdat
  - mmzone.c: next_zone
  - util.c: strndup_user

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/mm.h      |    2 --
 include/linux/slab.h    |    2 --
 include/linux/vmalloc.h |    2 --
 mm/bootmem.c            |    4 ----
 mm/memory.c             |    1 -
 mm/mmzone.c             |    4 ----
 mm/slab.c               |    3 +--
 mm/swap.c               |   39 +++++++++++++++++++--------------------
 mm/util.c               |    1 -
 mm/vmalloc.c            |    9 +++++----
 10 files changed, 25 insertions(+), 42 deletions(-)

--- linux-2.6.17-rc1-mm1-full/mm/bootmem.c.old	2006-04-07 10:55:20.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/bootmem.c	2006-04-07 10:56:37.000000000 +0200
@@ -29,10 +29,6 @@
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 
-EXPORT_SYMBOL(max_pfn);		/* This is exported so
-				 * dma_get_required_mask(), which uses
-				 * it, can be an inline function */
-
 static LIST_HEAD(bdata_list);
 #ifdef CONFIG_CRASH_DUMP
 /*
--- linux-2.6.17-rc1-mm1-full/mm/memory.c.old	2006-04-07 13:57:09.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/memory.c	2006-04-07 13:58:19.000000000 +0200
@@ -1802,7 +1802,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(vmtruncate_range);
 
 /* 
  * Primitive swap readahead code. We simply read an aligned block of
--- linux-2.6.17-rc1-mm1-full/mm/mmzone.c.old	2006-04-07 14:06:37.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/mmzone.c	2006-04-07 14:09:48.000000000 +0200
@@ -15,8 +15,6 @@
 	return NODE_DATA(first_online_node);
 }
 
-EXPORT_SYMBOL(first_online_pgdat);
-
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
 	int nid = next_online_node(pgdat->node_id);
@@ -25,7 +23,6 @@
 		return NULL;
 	return NODE_DATA(nid);
 }
-EXPORT_SYMBOL(next_online_pgdat);
 
 
 /*
@@ -46,5 +43,4 @@
 	}
 	return zone;
 }
-EXPORT_SYMBOL(next_zone);
 
--- linux-2.6.17-rc1-mm1-full/include/linux/slab.h.old	2006-04-07 14:11:18.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/include/linux/slab.h	2006-04-07 14:11:35.000000000 +0200
@@ -68,7 +68,6 @@
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 extern const char *kmem_cache_name(kmem_cache_t *);
-extern kmem_cache_t *kmem_find_general_cachep(size_t size, gfp_t gfpflags);
 
 /* Size description struct for general caches. */
 struct cache_sizes {
@@ -176,7 +175,6 @@
 /* SLOB allocator routines */
 
 void kmem_cache_init(void);
-struct kmem_cache *kmem_find_general_cachep(size_t, gfp_t gfpflags);
 struct kmem_cache *kmem_cache_create(const char *c, size_t, size_t,
 	unsigned long,
 	void (*)(void *, struct kmem_cache *, unsigned long),
--- linux-2.6.17-rc1-mm1-full/mm/slab.c.old	2006-04-07 14:11:43.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/slab.c	2006-04-07 14:11:52.000000000 +0200
@@ -742,11 +742,10 @@
 	return csizep->cs_cachep;
 }
 
-struct kmem_cache *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
+static struct kmem_cache *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
 {
 	return __find_general_cachep(size, gfpflags);
 }
-EXPORT_SYMBOL(kmem_find_general_cachep);
 
 static size_t slab_mgmt_size(size_t nr_objs, size_t align)
 {
--- linux-2.6.17-rc1-mm1-full/include/linux/mm.h.old	2006-04-07 14:14:12.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/include/linux/mm.h	2006-04-07 14:14:17.000000000 +0200
@@ -320,8 +320,6 @@
 	return atomic_inc_not_zero(&page->_count);
 }
 
-extern void FASTCALL(__page_cache_release(struct page *));
-
 static inline int page_count(struct page *page)
 {
 	if (unlikely(PageCompound(page)))
--- linux-2.6.17-rc1-mm1-full/mm/swap.c.old	2006-04-07 14:14:27.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/swap.c	2006-04-07 14:15:29.000000000 +0200
@@ -35,6 +35,25 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
+/*
+ * This path almost never happens for VM activity - pages are normally
+ * freed via pagevecs.  But it gets used by networking.
+ */
+static void fastcall __page_cache_release(struct page *page)
+{
+	if (PageLRU(page)) {
+		unsigned long flags;
+		struct zone *zone = page_zone(page);
+
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		VM_BUG_ON(!PageLRU(page));
+		__ClearPageLRU(page);
+		del_page_from_lru(zone, page);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
+	free_hot_page(page);
+}
+
 static void put_compound_page(struct page *page)
 {
 	page = (struct page *)page_private(page);
@@ -204,26 +223,6 @@
 #endif
 
 /*
- * This path almost never happens for VM activity - pages are normally
- * freed via pagevecs.  But it gets used by networking.
- */
-void fastcall __page_cache_release(struct page *page)
-{
-	if (PageLRU(page)) {
-		unsigned long flags;
-		struct zone *zone = page_zone(page);
-
-		spin_lock_irqsave(&zone->lru_lock, flags);
-		VM_BUG_ON(!PageLRU(page));
-		__ClearPageLRU(page);
-		del_page_from_lru(zone, page);
-		spin_unlock_irqrestore(&zone->lru_lock, flags);
-	}
-	free_hot_page(page);
-}
-EXPORT_SYMBOL(__page_cache_release);
-
-/*
  * Batched page_cache_release().  Decrement the reference count on all the
  * passed pages.  If it fell to zero then remove the page from the LRU and
  * free it.
--- linux-2.6.17-rc1-mm1-full/mm/util.c.old	2006-04-07 14:16:14.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/util.c	2006-04-07 14:16:22.000000000 +0200
@@ -73,4 +73,3 @@
 
 	return p;
 }
-EXPORT_SYMBOL(strndup_user);
--- linux-2.6.17-rc1-mm1-full/include/linux/vmalloc.h.old	2006-04-07 14:16:49.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/include/linux/vmalloc.h	2006-04-07 14:17:29.000000000 +0200
@@ -38,8 +38,6 @@
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
 extern void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask,
 				pgprot_t prot);
-extern void *__vmalloc_node(unsigned long size, gfp_t gfp_mask,
-				pgprot_t prot, int node);
 extern void vfree(void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
--- linux-2.6.17-rc1-mm1-full/mm/vmalloc.c.old	2006-04-07 14:17:43.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/vmalloc.c	2006-04-07 14:18:26.000000000 +0200
@@ -24,6 +24,9 @@
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
+static void *__vmalloc_node(unsigned long size, gfp_t gfp_mask, pgprot_t prot,
+			    int node);
+
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
 {
 	pte_t *pte;
@@ -462,8 +465,8 @@
  *	allocator with @gfp_mask flags.  Map them into contiguous
  *	kernel virtual space, using a pagetable protection of @prot.
  */
-void *__vmalloc_node(unsigned long size, gfp_t gfp_mask, pgprot_t prot,
-			int node)
+static void *__vmalloc_node(unsigned long size, gfp_t gfp_mask, pgprot_t prot,
+			    int node)
 {
 	struct vm_struct *area;
 
@@ -477,7 +480,6 @@
 
 	return __vmalloc_area_node(area, gfp_mask, prot, node);
 }
-EXPORT_SYMBOL(__vmalloc_node);
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
 {

