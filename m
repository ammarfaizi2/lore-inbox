Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWF3LdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWF3LdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWF3Lch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:32:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13064 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751233AbWF3LcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:20 -0400
Date: Fri, 30 Jun 2006 13:32:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/: make functions static
Message-ID: <20060630113219.GN19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following needlessly global functions static:
- slab.c: kmem_find_general_cachep()
- swap.c: __page_cache_release()
- vmalloc.c: __vmalloc_node()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/mm.h      |    2 --
 include/linux/slab.h    |    2 --
 include/linux/vmalloc.h |    2 --
 mm/slab.c               |    3 +--
 mm/swap.c               |   39 +++++++++++++++++++--------------------
 mm/vmalloc.c            |    8 +++++---
 6 files changed, 25 insertions(+), 31 deletions(-)

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

