Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVJIFfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVJIFfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJIFfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 01:35:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47583 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932218AbVJIFfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 01:35:19 -0400
Date: Sun, 9 Oct 2005 06:35:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC] gfp flags annotations - part 3 (simple parts of mm/*)
Message-ID: <20051009053516.GH7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	A bunch of unsigned int -> gfp_t in mm/*.  All tricky parts
(zone handling) are left as-is - we'll deal with them later.  This
is just the missing annotations.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN bitwise/include/linux/mm.h mm/include/linux/mm.h
--- bitwise/include/linux/mm.h	2005-09-22 14:50:53.000000000 -0400
+++ mm/include/linux/mm.h	2005-10-09 01:20:58.000000000 -0400
@@ -747,7 +747,7 @@
  * The callback will be passed nr_to_scan == 0 when the VM is querying the
  * cache size, so a fastpath for that case is appropriate.
  */
-typedef int (*shrinker_t)(int nr_to_scan, unsigned int gfp_mask);
+typedef int (*shrinker_t)(int nr_to_scan, gfp_t gfp_mask);
 
 /*
  * Add an aging callback.  The int is the number of 'seeks' it takes
diff -urN bitwise/include/linux/pagemap.h mm/include/linux/pagemap.h
--- bitwise/include/linux/pagemap.h	2005-10-08 21:04:47.000000000 -0400
+++ mm/include/linux/pagemap.h	2005-10-09 01:20:58.000000000 -0400
@@ -69,7 +69,7 @@
 extern struct page * find_trylock_page(struct address_space *mapping,
 				unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
-				unsigned long index, unsigned int gfp_mask);
+				unsigned long index, gfp_t gfp_mask);
 unsigned find_get_pages(struct address_space *mapping, pgoff_t start,
 			unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
@@ -92,9 +92,9 @@
 		struct list_head *pages, filler_t *filler, void *data);
 
 int add_to_page_cache(struct page *page, struct address_space *mapping,
-				unsigned long index, int gfp_mask);
+				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				unsigned long index, int gfp_mask);
+				unsigned long index, gfp_t gfp_mask);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
diff -urN bitwise/include/linux/slab.h mm/include/linux/slab.h
--- bitwise/include/linux/slab.h	2005-10-08 21:04:47.000000000 -0400
+++ mm/include/linux/slab.h	2005-10-09 01:21:04.000000000 -0400
@@ -121,7 +121,7 @@
 extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
 extern void *kmalloc_node(size_t size, gfp_t flags, int node);
 #else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int node)
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int node)
 {
 	return kmem_cache_alloc(cachep, flags);
 }
diff -urN bitwise/include/linux/swap.h mm/include/linux/swap.h
--- bitwise/include/linux/swap.h	2005-10-08 21:04:47.000000000 -0400
+++ mm/include/linux/swap.h	2005-10-09 01:20:58.000000000 -0400
@@ -171,8 +171,8 @@
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern int try_to_free_pages(struct zone **, unsigned int);
-extern int zone_reclaim(struct zone *, unsigned int, unsigned int);
+extern int try_to_free_pages(struct zone **, gfp_t);
+extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
diff -urN bitwise/mm/filemap.c mm/mm/filemap.c
--- bitwise/mm/filemap.c	2005-09-22 14:50:54.000000000 -0400
+++ mm/mm/filemap.c	2005-10-09 01:20:58.000000000 -0400
@@ -377,7 +377,7 @@
  * This function does not add the page to the LRU.  The caller must do that.
  */
 int add_to_page_cache(struct page *page, struct address_space *mapping,
-		pgoff_t offset, int gfp_mask)
+		pgoff_t offset, gfp_t gfp_mask)
 {
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
@@ -401,7 +401,7 @@
 EXPORT_SYMBOL(add_to_page_cache);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, int gfp_mask)
+				pgoff_t offset, gfp_t gfp_mask)
 {
 	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
 	if (ret == 0)
@@ -591,7 +591,7 @@
  * memory exhaustion.
  */
 struct page *find_or_create_page(struct address_space *mapping,
-		unsigned long index, unsigned int gfp_mask)
+		unsigned long index, gfp_t gfp_mask)
 {
 	struct page *page, *cached_page = NULL;
 	int err;
@@ -683,7 +683,7 @@
 grab_cache_page_nowait(struct address_space *mapping, unsigned long index)
 {
 	struct page *page = find_get_page(mapping, index);
-	unsigned int gfp_mask;
+	gfp_t gfp_mask;
 
 	if (page) {
 		if (!TestSetPageLocked(page))
diff -urN bitwise/mm/mempool.c mm/mm/mempool.c
--- bitwise/mm/mempool.c	2005-10-08 21:04:47.000000000 -0400
+++ mm/mm/mempool.c	2005-10-09 01:20:58.000000000 -0400
@@ -205,7 +205,7 @@
 	void *element;
 	unsigned long flags;
 	wait_queue_t wait;
-	unsigned int gfp_temp;
+	gfp_t gfp_temp;
 
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 
diff -urN bitwise/mm/shmem.c mm/mm/shmem.c
--- bitwise/mm/shmem.c	2005-10-08 21:04:47.000000000 -0400
+++ mm/mm/shmem.c	2005-10-09 01:20:58.000000000 -0400
@@ -85,7 +85,7 @@
 static int shmem_getpage(struct inode *inode, unsigned long idx,
 			 struct page **pagep, enum sgp_type sgp, int *type);
 
-static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
+static inline struct page *shmem_dir_alloc(gfp_t gfp_mask)
 {
 	/*
 	 * The above definition of ENTRIES_PER_PAGE, and the use of
@@ -898,7 +898,7 @@
 }
 
 static struct page *
-shmem_alloc_page(unsigned long gfp, struct shmem_inode_info *info,
+shmem_alloc_page(gfp_t gfp, struct shmem_inode_info *info,
 		 unsigned long idx)
 {
 	struct vm_area_struct pvma;
diff -urN bitwise/mm/slab.c mm/mm/slab.c
--- bitwise/mm/slab.c	2005-10-08 21:04:47.000000000 -0400
+++ mm/mm/slab.c	2005-10-09 01:20:58.000000000 -0400
@@ -386,7 +386,7 @@
 	unsigned int		gfporder;
 
 	/* force GFP flags, e.g. GFP_DMA */
-	unsigned int		gfpflags;
+	gfp_t			gfpflags;
 
 	size_t			colour;		/* cache colouring range */
 	unsigned int		colour_off;	/* colour offset */
@@ -2117,7 +2117,7 @@
 	slabp->free = 0;
 }
 
-static void kmem_flagcheck(kmem_cache_t *cachep, unsigned int flags)
+static void kmem_flagcheck(kmem_cache_t *cachep, gfp_t flags)
 {
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
@@ -2152,7 +2152,7 @@
 	struct slab	*slabp;
 	void		*objp;
 	size_t		 offset;
-	unsigned int	 local_flags;
+	gfp_t	 	 local_flags;
 	unsigned long	 ctor_flags;
 	struct kmem_list3 *l3;
 
@@ -2546,7 +2546,7 @@
 /*
  * A interface to enable slab creation on nodeid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
 {
 	struct list_head *entry;
  	struct slab *slabp;
diff -urN bitwise/mm/vmscan.c mm/mm/vmscan.c
--- bitwise/mm/vmscan.c	2005-09-22 14:50:54.000000000 -0400
+++ mm/mm/vmscan.c	2005-10-09 01:20:58.000000000 -0400
@@ -70,7 +70,7 @@
 	unsigned int priority;
 
 	/* This context's GFP mask */
-	unsigned int gfp_mask;
+	gfp_t gfp_mask;
 
 	int may_writepage;
 
@@ -186,7 +186,7 @@
  *
  * Returns the number of slab objects which we shrunk.
  */
-static int shrink_slab(unsigned long scanned, unsigned int gfp_mask,
+static int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
 			unsigned long lru_pages)
 {
 	struct shrinker *shrinker;
@@ -921,7 +921,7 @@
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-int try_to_free_pages(struct zone **zones, unsigned int gfp_mask)
+int try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
 {
 	int priority;
 	int ret = 0;
@@ -1333,7 +1333,7 @@
 /*
  * Try to free up some pages from this zone through reclaim.
  */
-int zone_reclaim(struct zone *zone, unsigned int gfp_mask, unsigned int order)
+int zone_reclaim(struct zone *zone, gfp_t gfp_mask, unsigned int order)
 {
 	struct scan_control sc;
 	int nr_pages = 1 << order;
