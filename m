Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWJNT4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWJNT4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWJNT4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:56:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45261 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751844AbWJNT4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:56:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: Improve handling of highmem
Date: Sat, 14 Oct 2006 21:56:04 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610142156.05161.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently swsusp saves the contents of highmem pages by copying them to the
normal zone which is quite inefficient  (eg. it requires two normal pages to be
used for saving one highmem page).  This may be improved by using highmem
for saving the contents of saveable highmem pages.

Namely, during the suspend phase of the suspend-resume cycle we try to
allocate as many free highmem pages as there are saveable highmem pages.
If there are not enough highmem image pages to store the contents of all of
the saveable highmem pages, some of them will be stored in the "normal"
memory.  Next, we allocate as many free "normal" pages as needed to
store the (remaining) image data.  We use a memory bitmap to mark the
allocated free pages (ie. highmem as well as "normal" image pages).

Now, we use another memory bitmap to mark all of the saveable pages (highmem
as well as "normal") and the contents of the saveable pages are copied into the
image pages.  Then, the second bitmap is used to save the pfns corresponding
to the saveable pages and the first one is used to save their data.

During the resume phase the pfns of the pages that were saveable during the
suspend are loaded from the image and used to mark the "unsafe" page frames.
Next, we try to allocate as many free highmem page frames as to load all of
the image data that had been in the highmem before the suspend and we
allocate so many free "normal" page frames that the total number of allocated
free pages (highmem and "normal") is equal to the size of the image.  While
doing this we have to make sure that there will be some extra free "normal"
and "safe" page frames for two lists of PBEs constructed later.

Now, the image data are loaded, if possible, into their "original" page
frames.  The image data that cannot be written into their "original" page
frames are loaded into "safe" page frames and their "original" kernel virtual
addresses, as well as the addresses of the "safe" pages containing their
copies, are stored in one of two lists of PBEs.

One list of PBEs is for the copies of "normal" suspend pages (ie. "normal"
pages that were saveable during the suspend) and it is used in the same
way as previously (ie. by the architecture-dependent parts of swsusp).  The
other list of PBEs is for the copies of highmem suspend pages.  The pages in
this list are restored (in a reversible way) right before the arch-dependent
code is called.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |    9 
 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |  841 ++++++++++++++++++++++++++++++++++++------------
 kernel/power/swap.c     |    2 
 kernel/power/swsusp.c   |   53 +--
 kernel/power/user.c     |    2 
 mm/vmscan.c             |    3 
 7 files changed, 675 insertions(+), 237 deletions(-)

Index: linux-2.6.18-mm3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/snapshot.c
+++ linux-2.6.18-mm3/kernel/power/snapshot.c
@@ -1,15 +1,15 @@
 /*
  * linux/kernel/power/snapshot.c
  *
- * This file provide system snapshot/restore functionality.
+ * This file provides system snapshot/restore functionality for swsusp.
  *
  * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
  *
- * This file is released under the GPLv2, and is based on swsusp.c.
+ * This file is released under the GPLv2.
  *
  */
 
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
@@ -34,137 +34,24 @@
 
 #include "power.h"
 
-/* List of PBEs used for creating and restoring the suspend image */
+/* List of PBEs needed for restoring the pages that were allocated before
+ * the suspend and included in the suspend image, but have also been
+ * allocated by the "resume" kernel, so their contents cannot be written
+ * directly to their "original" page frames.
+ */
 struct pbe *restore_pblist;
 
-static unsigned int nr_copy_pages;
-static unsigned int nr_meta_pages;
+/* Pointer to an auxiliary buffer (1 page) */
 static void *buffer;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-	unsigned int n = 0;
-
-	for_each_zone (zone)
-		if (is_highmem(zone)) {
-			mark_free_pages(zone);
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; zone_pfn++) {
-				struct page *page;
-				unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-				if (!pfn_valid(pfn))
-					continue;
-				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					continue;
-				if (PageNosaveFree(page))
-					continue;
-				n++;
-			}
-		}
-	return n;
-}
-
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
-static struct highmem_page *highmem_copy;
-
-static int save_highmem_zone(struct zone *zone)
-{
-	unsigned long zone_pfn;
-	mark_free_pages(zone);
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		struct highmem_page *save;
-		void *kaddr;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-
-		if (!(pfn%10000))
-			printk(".");
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
-		 */
-		if (PageReserved(page))
-			continue;
-		BUG_ON(PageNosave(page));
-		if (PageNosaveFree(page))
-			continue;
-		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
-		if (!save)
-			return -ENOMEM;
-		save->next = highmem_copy;
-		save->page = page;
-		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
-		if (!save->data) {
-			kfree(save);
-			return -ENOMEM;
-		}
-		kaddr = kmap_atomic(page, KM_USER0);
-		memcpy(save->data, kaddr, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		highmem_copy = save;
-	}
-	return 0;
-}
-
-int save_highmem(void)
-{
-	struct zone *zone;
-	int res = 0;
-
-	pr_debug("swsusp: Saving Highmem");
-	drain_local_pages();
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			res = save_highmem_zone(zone);
-		if (res)
-			return res;
-	}
-	printk("\n");
-	return 0;
-}
-
-int restore_highmem(void)
-{
-	printk("swsusp: Restoring Highmem\n");
-	while (highmem_copy) {
-		struct highmem_page *save = highmem_copy;
-		void *kaddr;
-		highmem_copy = save->next;
-
-		kaddr = kmap_atomic(save->page, KM_USER0);
-		memcpy(kaddr, save->data, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		free_page((long) save->data);
-		kfree(save);
-	}
-	return 0;
-}
-#else
-static inline unsigned int count_highmem_pages(void) {return 0;}
-static inline int save_highmem(void) {return 0;}
-static inline int restore_highmem(void) {return 0;}
-#endif
-
 /**
  *	@safe_needed - on resume, for storing the PBE list and the image,
  *	we can only use memory pages that do not conflict with the pages
- *	used before suspend.
+ *	used before suspend.  The unsafe pages have PageNosaveFree set
+ *	and we count them using unsafe_pages.
  *
- *	The unsafe pages are marked with the PG_nosave_free flag
- *	and we count them using unsafe_pages
+ *	Each allocated image page is marked as PageNosave and PageNosaveFree
+ *	so that swsusp_free() can release it.
  */
 
 #define PG_ANY		0
@@ -174,7 +61,7 @@ static inline int restore_highmem(void) 
 
 static unsigned int allocated_unsafe_pages;
 
-static void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
+static void *get_image_page(gfp_t gfp_mask, int safe_needed)
 {
 	void *res;
 
@@ -195,20 +82,38 @@ static void *alloc_image_page(gfp_t gfp_
 
 unsigned long get_safe_page(gfp_t gfp_mask)
 {
-	return (unsigned long)alloc_image_page(gfp_mask, PG_SAFE);
+	return (unsigned long)get_image_page(gfp_mask, PG_SAFE);
+}
+
+static struct page *alloc_image_page(gfp_t gfp_mask) {
+	struct page *page;
+
+	page = alloc_page(gfp_mask);
+	if (page) {
+		SetPageNosave(page);
+		SetPageNosaveFree(page);
+	}
+	return page;
 }
 
 /**
  *	free_image_page - free page represented by @addr, allocated with
- *	alloc_image_page (page flags set by it must be cleared)
+ *	get_image_page (page flags set by it must be cleared)
  */
 
 static inline void free_image_page(void *addr, int clear_nosave_free)
 {
-	ClearPageNosave(virt_to_page(addr));
+	struct page *page;
+
+	BUG_ON(!virt_addr_valid(addr));
+
+	page = virt_to_page(addr);
+
+	ClearPageNosave(page);
 	if (clear_nosave_free)
-		ClearPageNosaveFree(virt_to_page(addr));
-	free_page((unsigned long)addr);
+		ClearPageNosaveFree(page);
+
+	__free_page(page);
 }
 
 /* struct linked_page is used to build chains of pages */
@@ -269,7 +174,7 @@ static void *chain_alloc(struct chain_al
 	if (LINKED_PAGE_DATA_SIZE - ca->used_space < size) {
 		struct linked_page *lp;
 
-		lp = alloc_image_page(ca->gfp_mask, ca->safe_needed);
+		lp = get_image_page(ca->gfp_mask, ca->safe_needed);
 		if (!lp)
 			return NULL;
 
@@ -447,7 +352,7 @@ memory_bm_create(struct memory_bitmap *b
 	/* Compute the number of zones */
 	nr = 0;
 	for_each_zone (zone)
-		if (populated_zone(zone) && !is_highmem(zone))
+		if (populated_zone(zone))
 			nr++;
 
 	/* Allocate the list of zones bitmap objects */
@@ -462,7 +367,7 @@ memory_bm_create(struct memory_bitmap *b
 	for_each_zone (zone) {
 		unsigned long pfn;
 
-		if (!populated_zone(zone) || is_highmem(zone))
+		if (!populated_zone(zone))
 			continue;
 
 		zone_bm->start_pfn = zone->zone_start_pfn;
@@ -481,7 +386,7 @@ memory_bm_create(struct memory_bitmap *b
 		while (bb) {
 			unsigned long *ptr;
 
-			ptr = alloc_image_page(gfp_mask, safe_needed);
+			ptr = get_image_page(gfp_mask, safe_needed);
 			bb->data = ptr;
 			if (!ptr)
 				goto Free;
@@ -669,10 +574,82 @@ unsigned int snapshot_additional_pages(s
 
 	res = DIV_ROUND_UP(zone->spanned_pages, BM_BITS_PER_BLOCK);
 	res += DIV_ROUND_UP(res * sizeof(struct bm_block), PAGE_SIZE);
-	return res;
+	return 2 * res;
+}
+
+#ifdef CONFIG_HIGHMEM
+/**
+ *	count_free_highmem_pages - compute the total number of free highmem
+ *	pages, system-wide.
+ */
+
+static unsigned int count_free_highmem_pages(void)
+{
+	struct zone *zone;
+	unsigned int cnt = 0;
+
+	for_each_zone (zone)
+		if (populated_zone(zone) && is_highmem(zone))
+			cnt += zone->free_pages;
+
+	return cnt;
 }
 
 /**
+ *	saveable_highmem_page - Determine whether a highmem page should be
+ *	included in the suspend image.
+ *
+ *	We should save the page if it isn't Nosave or NosaveFree, or Reserved,
+ *	and it isn't a part of a free chunk of pages.
+ */
+
+static struct page *saveable_highmem_page(unsigned long pfn)
+{
+	struct page *page;
+
+	if (!pfn_valid(pfn))
+		return NULL;
+
+	page = pfn_to_page(pfn);
+
+	BUG_ON(!PageHighMem(page));
+
+	if (PageNosave(page) || PageReserved(page) || PageNosaveFree(page))
+		return NULL;
+
+	return page;
+}
+
+/**
+ *	count_highmem_pages - compute the total number of saveable highmem
+ *	pages.
+ */
+
+unsigned int count_highmem_pages(void)
+{
+	struct zone *zone;
+	unsigned int n = 0;
+
+	for_each_zone (zone) {
+		unsigned long pfn, max_zone_pfn;
+
+		if (!is_highmem(zone))
+			continue;
+
+		mark_free_pages(zone);
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (saveable_highmem_page(pfn))
+				n++;
+	}
+	return n;
+}
+#else
+static inline void *saveable_highmem_page(unsigned long pfn) { return NULL; }
+static inline unsigned int count_highmem_pages(void) { return 0; }
+#endif /* CONFIG_HIGHMEM */
+
+/**
  *	pfn_is_nosave - check if given pfn is in the 'nosave' section
  */
 
@@ -684,12 +661,12 @@ static inline int pfn_is_nosave(unsigned
 }
 
 /**
- *	saveable - Determine whether a page should be cloned or not.
- *	@pfn:	The page
+ *	saveable - Determine whether a non-highmem page should be included in
+ *	the suspend image.
  *
- *	We save a page if it isn't Nosave, and is not in the range of pages
- *	statically defined as 'unsaveable', and it
- *	isn't a part of a free chunk of pages.
+ *	We should save the page if it isn't Nosave, and is not in the range
+ *	of pages statically defined as 'unsaveable', and it isn't a part of
+ *	a free chunk of pages.
  */
 
 static struct page *saveable_page(unsigned long pfn)
@@ -701,16 +678,22 @@ static struct page *saveable_page(unsign
 
 	page = pfn_to_page(pfn);
 
-	if (PageNosave(page))
+	BUG_ON(PageHighMem(page));
+
+	if (PageNosave(page) || PageNosaveFree(page))
 		return NULL;
+
 	if (PageReserved(page) && pfn_is_nosave(pfn))
 		return NULL;
-	if (PageNosaveFree(page))
-		return NULL;
 
 	return page;
 }
 
+/**
+ *	count_data_pages - compute the total number of saveable non-highmem
+ *	pages.
+ */
+
 unsigned int count_data_pages(void)
 {
 	struct zone *zone;
@@ -720,23 +703,76 @@ unsigned int count_data_pages(void)
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
+
 		mark_free_pages(zone);
 		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
-			n += !!saveable_page(pfn);
+			if(saveable_page(pfn))
+				n++;
 	}
 	return n;
 }
 
-static inline void copy_data_page(long *dst, long *src)
+/* This is needed, because copy_page and memcpy are not usable for copying
+ * task structs.
+ */
+static inline void do_copy_page(long *dst, long *src)
 {
 	int n;
 
-	/* copy_page and memcpy are not usable for copying task structs. */
 	for (n = PAGE_SIZE / sizeof(long); n; n--)
 		*dst++ = *src++;
 }
 
+#ifdef CONFIG_HIGHMEM
+static inline struct page *
+page_is_saveable(struct zone *zone, unsigned long pfn)
+{
+	return is_highmem(zone) ?
+			saveable_highmem_page(pfn) : saveable_page(pfn);
+}
+
+static inline void
+copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+{
+	struct page *s_page, *d_page;
+	void *src, *dst;
+
+	s_page = pfn_to_page(src_pfn);
+	d_page = pfn_to_page(dst_pfn);
+	if (PageHighMem(s_page)) {
+		src = kmap_atomic(s_page, KM_USER0);
+		dst = kmap_atomic(d_page, KM_USER1);
+		do_copy_page(dst, src);
+		kunmap_atomic(src, KM_USER0);
+		kunmap_atomic(dst, KM_USER1);
+	} else {
+		src = page_address(s_page);
+		if (PageHighMem(d_page)) {
+			/* Page pointed to by src may contain some kernel
+			 * data modified by kmap_atomic()
+			 */
+			do_copy_page(buffer, src);
+			dst = kmap_atomic(pfn_to_page(dst_pfn), KM_USER0);
+			memcpy(dst, buffer, PAGE_SIZE);
+			kunmap_atomic(dst, KM_USER0);
+		} else {
+			dst = page_address(d_page);
+			do_copy_page(dst, src);
+		}
+	}
+}
+#else
+#define page_is_saveable(zone, pfn)	saveable_page(pfn)
+
+static inline void
+copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+{
+	do_copy_page(page_address(pfn_to_page(dst_pfn)),
+			page_address(pfn_to_page(src_pfn)));
+}
+#endif /* CONFIG_HIGHMEM */
+
 static void
 copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 {
@@ -746,31 +782,26 @@ copy_data_pages(struct memory_bitmap *co
 	for_each_zone (zone) {
 		unsigned long max_zone_pfn;
 
-		if (is_highmem(zone))
-			continue;
-
 		mark_free_pages(zone);
 		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
-			if (saveable_page(pfn))
+			if (page_is_saveable(zone, pfn))
 				memory_bm_set_bit(orig_bm, pfn);
 	}
 	memory_bm_position_reset(orig_bm);
 	memory_bm_position_reset(copy_bm);
 	do {
 		pfn = memory_bm_next_pfn(orig_bm);
-		if (likely(pfn != BM_END_OF_MAP)) {
-			struct page *page;
-			void *src;
-
-			page = pfn_to_page(pfn);
-			src = page_address(page);
-			page = pfn_to_page(memory_bm_next_pfn(copy_bm));
-			copy_data_page(page_address(page), src);
-		}
+		if (likely(pfn != BM_END_OF_MAP))
+			copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
 	} while (pfn != BM_END_OF_MAP);
 }
 
+/* Total number of image pages */
+static unsigned int nr_copy_pages;
+/* Number of pages needed for saving the original pfns of the image pages */
+static unsigned int nr_meta_pages;
+
 /**
  *	swsusp_free - free pages allocated for the suspend.
  *
@@ -792,7 +823,7 @@ void swsusp_free(void)
 				if (PageNosave(page) && PageNosaveFree(page)) {
 					ClearPageNosave(page);
 					ClearPageNosaveFree(page);
-					free_page((long) page_address(page));
+					__free_page(page);
 				}
 			}
 	}
@@ -802,34 +833,108 @@ void swsusp_free(void)
 	buffer = NULL;
 }
 
+#ifdef CONFIG_HIGHMEM
+/**
+  *	count_pages_for_highmem - compute the number of non-highmem pages
+  *	that will be necessary for creating copies of highmem pages.
+  */
+
+static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
+{
+	unsigned int free_highmem = count_free_highmem_pages();
+
+	if (free_highmem >= nr_highmem)
+		nr_highmem = 0;
+	else
+		nr_highmem -= free_highmem;
+
+	return nr_highmem;
+}
+#else
+static unsigned int
+count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
+#endif /* CONFIG_HIGHMEM */
 
 /**
- *	enough_free_mem - Make sure we enough free memory to snapshot.
- *
- *	Returns TRUE or FALSE after checking the number of available
- *	free pages.
+ *	enough_free_mem - Make sure we have enough free memory for the
+ *	snapshot image.
  */
 
-static int enough_free_mem(unsigned int nr_pages)
+static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 {
 	struct zone *zone;
 	unsigned int free = 0, meta = 0;
 
-	for_each_zone (zone)
-		if (!is_highmem(zone)) {
+	for_each_zone (zone) {
+		meta += snapshot_additional_pages(zone);
+		if (!is_highmem(zone))
 			free += zone->free_pages;
-			meta += snapshot_additional_pages(zone);
-		}
+	}
 
-	pr_debug("swsusp: pages needed: %u + %u + %u, available pages: %u\n",
+	nr_pages += count_pages_for_highmem(nr_highmem);
+	pr_debug("swsusp: Normal pages needed: %u + %u + %u, available pages: %u\n",
 		nr_pages, PAGES_FOR_IO, meta, free);
 
 	return free > nr_pages + PAGES_FOR_IO + meta;
 }
 
+#ifdef CONFIG_HIGHMEM
+/**
+ *	get_highmem_buffer - if there are some highmem pages in the suspend
+ *	image, we may need the buffer to copy them and/or load their data.
+ */
+
+static inline int get_highmem_buffer(int safe_needed)
+{
+	buffer = get_image_page(GFP_ATOMIC | __GFP_COLD, safe_needed);
+	return buffer ? 0 : -ENOMEM;
+}
+
+/**
+ *	alloc_highmem_image_pages - allocate some highmem pages for the image.
+ *	Try to allocate as many pages as needed, but if the number of free
+ *	highmem pages is lesser than that, allocate them all.
+ */
+
+static inline unsigned int
+alloc_highmem_image_pages(struct memory_bitmap *bm, unsigned int nr_highmem)
+{
+	unsigned int to_alloc = count_free_highmem_pages();
+
+	if (to_alloc > nr_highmem)
+		to_alloc = nr_highmem;
+
+	nr_highmem -= to_alloc;
+	while (to_alloc-- > 0) {
+		struct page *page;
+
+		page = alloc_image_page(__GFP_HIGHMEM);
+		memory_bm_set_bit(bm, page_to_pfn(page));
+	}
+	return nr_highmem;
+}
+#else
+static inline int get_highmem_buffer(int safe_needed) { return 0; }
+
+static inline unsigned int
+alloc_highmem_image_pages(struct memory_bitmap *bm, unsigned int n) { return 0; }
+#endif /* CONFIG_HIGHMEM */
+
+/**
+ *	swsusp_alloc - allocate memory for the suspend image
+ *
+ *	We first try to allocate as many highmem pages as there are
+ *	saveable highmem pages in the system.  If that fails, we allocate
+ *	non-highmem pages for the copies of the remaining highmem ones.
+ *
+ *	In this approach it is likely that the copies of highmem pages will
+ *	also be located in the high memory, because of the way in which
+ *	copy_data_pages() works.
+ */
+
 static int
 swsusp_alloc(struct memory_bitmap *orig_bm, struct memory_bitmap *copy_bm,
-		unsigned int nr_pages)
+		unsigned int nr_pages, unsigned int nr_highmem)
 {
 	int error;
 
@@ -841,13 +946,19 @@ swsusp_alloc(struct memory_bitmap *orig_
 	if (error)
 		goto Free;
 
+	if (nr_highmem > 0) {
+		error = get_highmem_buffer(PG_ANY);
+		if (error)
+			goto Free;
+
+		nr_pages += alloc_highmem_image_pages(copy_bm, nr_highmem);
+	}
 	while (nr_pages-- > 0) {
-		struct page *page = alloc_page(GFP_ATOMIC | __GFP_COLD);
+		struct page *page = alloc_image_page(GFP_ATOMIC | __GFP_COLD);
+
 		if (!page)
 			goto Free;
 
-		SetPageNosave(page);
-		SetPageNosaveFree(page);
 		memory_bm_set_bit(copy_bm, page_to_pfn(page));
 	}
 	return 0;
@@ -857,30 +968,39 @@ Free:
 	return -ENOMEM;
 }
 
-/* Memory bitmap used for marking saveable pages */
+/* Memory bitmap used for marking saveable pages (during suspend) or the
+ * suspend image pages (during resume)
+ */
 static struct memory_bitmap orig_bm;
-/* Memory bitmap used for marking allocated pages that will contain the copies
- * of saveable pages
+/* Memory bitmap used on suspend for marking allocated pages that will contain
+ * the copies of saveable pages.  During resume it is initially used for
+ * marking the suspend image pages, but then its set bits are duplicated in
+ * @orig_bm and it is released.  Next, on systems with high memory, it may be
+ * used for marking "safe" highmem pages, but it has to be reinitialized for
+ * this purpose.
  */
 static struct memory_bitmap copy_bm;
 
 asmlinkage int swsusp_save(void)
 {
-	unsigned int nr_pages;
+	unsigned int nr_pages, nr_highmem;
 
-	pr_debug("swsusp: critical section: \n");
+	printk("swsusp: critical section: \n");
 
 	drain_local_pages();
 	nr_pages = count_data_pages();
-	printk("swsusp: Need to copy %u pages\n", nr_pages);
+	nr_highmem = count_highmem_pages();
+	printk("swsusp: Need to copy %u pages\n", nr_pages + nr_highmem);
 
-	if (!enough_free_mem(nr_pages)) {
+	if (!enough_free_mem(nr_pages, nr_highmem)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
 	}
 
-	if (swsusp_alloc(&orig_bm, &copy_bm, nr_pages))
+	if (swsusp_alloc(&orig_bm, &copy_bm, nr_pages, nr_highmem)) {
+		printk(KERN_ERR "swsusp: Memory allocation failed\n");
 		return -ENOMEM;
+	}
 
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
@@ -894,10 +1014,12 @@ asmlinkage int swsusp_save(void)
 	 * touch swap space! Except we must write out our image of course.
 	 */
 
+	nr_pages += nr_highmem;
 	nr_copy_pages = nr_pages;
-	nr_meta_pages = (nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
+
 	return 0;
 }
 
@@ -960,7 +1082,7 @@ int snapshot_read_next(struct snapshot_h
 
 	if (!buffer) {
 		/* This makes the buffer be freed by swsusp_free() */
-		buffer = alloc_image_page(GFP_ATOMIC, PG_ANY);
+		buffer = get_image_page(GFP_ATOMIC, PG_ANY);
 		if (!buffer)
 			return -ENOMEM;
 	}
@@ -975,9 +1097,23 @@ int snapshot_read_next(struct snapshot_h
 			memset(buffer, 0, PAGE_SIZE);
 			pack_pfns(buffer, &orig_bm);
 		} else {
-			unsigned long pfn = memory_bm_next_pfn(&copy_bm);
+			struct page *page;
 
-			handle->buffer = page_address(pfn_to_page(pfn));
+			page = pfn_to_page(memory_bm_next_pfn(&copy_bm));
+			if (PageHighMem(page)) {
+				/* Highmem pages are copied to the buffer,
+				 * because we can't return with a kmapped
+				 * highmem page (we may not be called again).
+				 */
+				void *kaddr;
+
+				kaddr = kmap_atomic(page, KM_USER0);
+				memcpy(buffer, kaddr, PAGE_SIZE);
+				kunmap_atomic(kaddr, KM_USER0);
+				handle->buffer = buffer;
+			} else {
+				handle->buffer = page_address(page);
+			}
 		}
 		handle->prev = handle->cur;
 	}
@@ -1101,6 +1237,218 @@ unpack_orig_pfns(unsigned long *buf, str
 	}
 }
 
+/* List of "safe" pages that may be used to store data loaded from the suspend
+ * image
+ */
+static struct linked_page *safe_pages_list;
+
+#ifdef CONFIG_HIGHMEM
+/* struct highmem_pbe is used for creating the list of highmem pages that
+ * should be restored atomically during the resume from disk, because the page
+ * frames they have occupied before the suspend are in use.
+ */
+struct highmem_pbe {
+	struct page *copy_page;	/* data is here now */
+	struct page *orig_page;	/* data was here before the suspend */
+	struct highmem_pbe *next;
+};
+
+/* List of highmem PBEs needed for restoring the highmem pages that were
+ * allocated before the suspend and included in the suspend image, but have
+ * also been allocated by the "resume" kernel, so their contents cannot be
+ * written directly to their "original" page frames.
+ */
+static struct highmem_pbe *highmem_pblist;
+
+/**
+ *	count_highmem_image_pages - compute the number of highmem pages in the
+ *	suspend image.  The bits in the memory bitmap @bm that correspond to the
+ *	image pages are assumed to be set.
+ */
+
+static unsigned int count_highmem_image_pages(struct memory_bitmap *bm)
+{
+	unsigned long pfn;
+	unsigned int cnt = 0;
+
+	memory_bm_position_reset(bm);
+	pfn = memory_bm_next_pfn(bm);
+	while (pfn != BM_END_OF_MAP) {
+		if (PageHighMem(pfn_to_page(pfn)))
+			cnt++;
+
+		pfn = memory_bm_next_pfn(bm);
+	}
+	return cnt;
+}
+
+/**
+ *	prepare_highmem_image - try to allocate as many highmem pages as
+ *	there are highmem image pages (@nr_highmem_p points to the variable
+ *	containing the number of highmem image pages).  The pages that are
+ *	"safe" (ie. will not be overwritten when the suspend image is
+ *	restored) have the corresponding bits set in @bm (it must be
+ *	unitialized).
+ *
+ *	NOTE: This function should not be called if there are no highmem
+ *	image pages.
+ */
+
+static unsigned int safe_highmem_pages;
+
+static struct memory_bitmap *safe_highmem_bm;
+
+static int
+prepare_highmem_image(struct memory_bitmap *bm, unsigned int *nr_highmem_p)
+{
+	unsigned int to_alloc;
+
+	if (memory_bm_create(bm, GFP_ATOMIC, PG_SAFE))
+		return -ENOMEM;
+
+	if (get_highmem_buffer(PG_SAFE))
+		return -ENOMEM;
+
+	to_alloc = count_free_highmem_pages();
+	if (to_alloc > *nr_highmem_p)
+		to_alloc = *nr_highmem_p;
+	else
+		*nr_highmem_p = to_alloc;
+
+	safe_highmem_pages = 0;
+	while (to_alloc-- > 0) {
+		struct page *page;
+
+		page = alloc_page(__GFP_HIGHMEM);
+		if (!PageNosaveFree(page)) {
+			/* The page is "safe", set its bit the bitmap */
+			memory_bm_set_bit(bm, page_to_pfn(page));
+			safe_highmem_pages++;
+		}
+		/* Mark the page as allocated */
+		SetPageNosave(page);
+		SetPageNosaveFree(page);
+	}
+	memory_bm_position_reset(bm);
+	safe_highmem_bm = bm;
+	return 0;
+}
+
+/**
+ *	get_highmem_page_buffer - for given highmem image page find the buffer
+ *	that suspend_write_next() should set for its caller to write to.
+ *
+ *	If the page is to be saved to its "original" page frame or a copy of
+ *	the page is to be made in the highmem, @buffer is returned.  Otherwise,
+ *	the copy of the page is to be made in normal memory, so the address of
+ *	the copy is returned.
+ *
+ *	If @buffer is returned, the caller of suspend_write_next() will write
+ *	the page's contents to @buffer, so they will have to be copied to the
+ *	right location on the next call to suspend_write_next() and it is done
+ *	with the help of copy_last_highmem_page().  For this purpose, if
+ *	@buffer is returned, @last_highmem page is set to the page to which
+ *	the data will have to be copied from @buffer.
+ */
+
+static struct page *last_highmem_page;
+
+static void *
+get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
+{
+	struct highmem_pbe *pbe;
+	void *kaddr;
+
+	if (PageNosave(page) && PageNosaveFree(page)) {
+		/* We have allocated the "original" page frame and we can
+		 * use it directly to store the loaded page.
+		 */
+		last_highmem_page = page;
+		return buffer;
+	}
+	/* The "original" page frame has not been allocated and we have to
+	 * use a "safe" page frame to store the loaded page.
+	 */
+	pbe = chain_alloc(ca, sizeof(struct highmem_pbe));
+	if (!pbe) {
+		swsusp_free();
+		return NULL;
+	}
+	pbe->orig_page = page;
+	if (safe_highmem_pages > 0) {
+		struct page *tmp;
+
+		/* Copy of the page will be stored in high memory */
+		kaddr = buffer;
+		tmp = pfn_to_page(memory_bm_next_pfn(safe_highmem_bm));
+		safe_highmem_pages--;
+		last_highmem_page = tmp;
+		pbe->copy_page = tmp;
+	} else {
+		/* Copy of the page will be stored in normal memory */
+		kaddr = safe_pages_list;
+		safe_pages_list = safe_pages_list->next;
+		pbe->copy_page = virt_to_page(kaddr);
+	}
+	pbe->next = highmem_pblist;
+	highmem_pblist = pbe;
+	return kaddr;
+}
+
+/**
+ *	copy_last_highmem_page - copy the contents of a highmem image from
+ *	@buffer, where the caller of snapshot_write_next() has place them,
+ *	to the right location represented by @last_highmem_page .
+ */
+
+static void copy_last_highmem_page(void)
+{
+	if (last_highmem_page) {
+		void *dst;
+
+		dst = kmap_atomic(last_highmem_page, KM_USER0);
+		memcpy(dst, buffer, PAGE_SIZE);
+		kunmap_atomic(dst, KM_USER0);
+		last_highmem_page = NULL;
+	}
+}
+
+static inline int last_highmem_page_copied(void)
+{
+	return !last_highmem_page;
+}
+
+static inline void free_highmem_data(void)
+{
+	if (safe_highmem_bm)
+		memory_bm_free(safe_highmem_bm, PG_UNSAFE_CLEAR);
+
+	if (buffer)
+		free_image_page(buffer, PG_UNSAFE_CLEAR);
+}
+#else
+static inline int get_safe_write_buffer(void) { return 0; }
+
+static unsigned int
+count_highmem_image_pages(struct memory_bitmap *bm) { return 0; }
+
+static inline int
+prepare_highmem_image(struct memory_bitmap *bm, unsigned int *nr_highmem_p)
+{
+	return 0;
+}
+
+static inline void *
+get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
+{
+	return NULL;
+}
+
+static inline void copy_last_highmem_page(void) {}
+static inline int last_highmem_page_copied(void) { return 1; }
+static inline void free_highmem_data(void) {}
+#endif /* CONFIG_HIGHMEM */
+
 /**
  *	prepare_image - use the memory bitmap @bm to mark the pages that will
  *	be overwritten in the process of restoring the system memory state
@@ -1110,20 +1458,25 @@ unpack_orig_pfns(unsigned long *buf, str
  *	The idea is to allocate a new memory bitmap first and then allocate
  *	as many pages as needed for the image data, but not to assign these
  *	pages to specific tasks initially.  Instead, we just mark them as
- *	allocated and create a list of "safe" pages that will be used later.
+ *	allocated and create a lists of "safe" pages that will be used
+ *	later.  On systems with high memory a list of "safe" highmem pages is
+ *	also created.
  */
 
 #define PBES_PER_LINKED_PAGE	(LINKED_PAGE_DATA_SIZE / sizeof(struct pbe))
 
-static struct linked_page *safe_pages_list;
-
 static int
 prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
-	unsigned int nr_pages;
+	unsigned int nr_pages, nr_highmem;
 	struct linked_page *sp_list, *lp;
 	int error;
 
+	/* If there is no highmem, the buffer will not be necessary */
+	free_image_page(buffer, PG_UNSAFE_CLEAR);
+	buffer = NULL;
+
+	nr_highmem = count_highmem_image_pages(bm);
 	error = mark_unsafe_pages(bm);
 	if (error)
 		goto Free;
@@ -1134,6 +1487,11 @@ prepare_image(struct memory_bitmap *new_
 
 	duplicate_memory_bitmap(new_bm, bm);
 	memory_bm_free(bm, PG_UNSAFE_KEEP);
+	if (nr_highmem > 0) {
+		error = prepare_highmem_image(bm, &nr_highmem);
+		if (error)
+			goto Free;
+	}
 	/* Reserve some safe pages for potential later use.
 	 *
 	 * NOTE: This way we make sure there will be enough safe pages for the
@@ -1142,10 +1500,10 @@ prepare_image(struct memory_bitmap *new_
 	 */
 	sp_list = NULL;
 	/* nr_copy_pages cannot be lesser than allocated_unsafe_pages */
-	nr_pages = nr_copy_pages - allocated_unsafe_pages;
+	nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
 	nr_pages = DIV_ROUND_UP(nr_pages, PBES_PER_LINKED_PAGE);
 	while (nr_pages > 0) {
-		lp = alloc_image_page(GFP_ATOMIC, PG_SAFE);
+		lp = get_image_page(GFP_ATOMIC, PG_SAFE);
 		if (!lp) {
 			error = -ENOMEM;
 			goto Free;
@@ -1156,7 +1514,7 @@ prepare_image(struct memory_bitmap *new_
 	}
 	/* Preallocate memory for the image */
 	safe_pages_list = NULL;
-	nr_pages = nr_copy_pages - allocated_unsafe_pages;
+	nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
 	while (nr_pages > 0) {
 		lp = (struct linked_page *)get_zeroed_page(GFP_ATOMIC);
 		if (!lp) {
@@ -1196,6 +1554,9 @@ static void *get_buffer(struct memory_bi
 	struct pbe *pbe;
 	struct page *page = pfn_to_page(memory_bm_next_pfn(bm));
 
+	if (PageHighMem(page))
+		return get_highmem_page_buffer(page, ca);
+
 	if (PageNosave(page) && PageNosaveFree(page))
 		/* We have allocated the "original" page frame and we can
 		 * use it directly to store the loaded page.
@@ -1210,12 +1571,12 @@ static void *get_buffer(struct memory_bi
 		swsusp_free();
 		return NULL;
 	}
-	pbe->orig_address = (unsigned long)page_address(page);
-	pbe->address = (unsigned long)safe_pages_list;
+	pbe->orig_address = page_address(page);
+	pbe->address = safe_pages_list;
 	safe_pages_list = safe_pages_list->next;
 	pbe->next = restore_pblist;
 	restore_pblist = pbe;
-	return (void *)pbe->address;
+	return pbe->address;
 }
 
 /**
@@ -1249,14 +1610,16 @@ int snapshot_write_next(struct snapshot_
 	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	if (!buffer) {
-		/* This makes the buffer be freed by swsusp_free() */
-		buffer = alloc_image_page(GFP_ATOMIC, PG_ANY);
+	if (handle->offset == 0) {
+		if (!buffer)
+			/* This makes the buffer be freed by swsusp_free() */
+			buffer = get_image_page(GFP_ATOMIC, PG_ANY);
+
 		if (!buffer)
 			return -ENOMEM;
-	}
-	if (!handle->offset)
+
 		handle->buffer = buffer;
+	}
 	handle->sync_read = 1;
 	if (handle->prev < handle->cur) {
 		if (handle->prev == 0) {
@@ -1284,8 +1647,10 @@ int snapshot_write_next(struct snapshot_
 					return -ENOMEM;
 			}
 		} else {
+			copy_last_highmem_page();
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
+			if (handle->buffer != buffer)
+				handle->sync_read = 0;
 		}
 		handle->prev = handle->cur;
 	}
@@ -1301,15 +1666,73 @@ int snapshot_write_next(struct snapshot_
 	return count;
 }
 
+/**
+ *	snapshot_write_finalize - must be called after the last call to
+ *	snapshot_write_next() in case the last page in the image happens
+ *	to be a highmem page and its contents should be stored in the
+ *	highmem.  Additionally, it releases the memory that will not be
+ *	used any more.
+ */
+
+void snapshot_write_finalize(struct snapshot_handle *handle)
+{
+	copy_last_highmem_page();
+	/* Free only if we have loaded the image entirely */
+	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages) {
+		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
+		free_highmem_data();
+	}
+}
+
 int snapshot_image_loaded(struct snapshot_handle *handle)
 {
-	return !(!nr_copy_pages ||
+	return !(!nr_copy_pages || !last_highmem_page_copied() ||
 			handle->cur <= nr_meta_pages + nr_copy_pages);
 }
 
-void snapshot_free_unused_memory(struct snapshot_handle *handle)
+#ifdef CONFIG_HIGHMEM
+/* Assumes that @buf is ready and points to a "safe" page */
+static inline void
+swap_two_pages_data(struct page *p1, struct page *p2, void *buf)
 {
-	/* Free only if we have loaded the image entirely */
-	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages)
-		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
+	void *kaddr1, *kaddr2;
+
+	kaddr1 = kmap_atomic(p1, KM_USER0);
+	kaddr2 = kmap_atomic(p2, KM_USER1);
+	memcpy(buf, kaddr1, PAGE_SIZE);
+	memcpy(kaddr1, kaddr2, PAGE_SIZE);
+	memcpy(kaddr2, buf, PAGE_SIZE);
+	kunmap_atomic(kaddr1, KM_USER0);
+	kunmap_atomic(kaddr2, KM_USER1);
+}
+
+/**
+ *	restore_highmem - for each highmem page that was allocated before
+ *	the suspend and included in the suspend image, and also has been
+ *	allocated by the "resume" kernel swap its current (ie. "before
+ *	resume") contents with the previous (ie. "before suspend") one.
+ *
+ *	If the resume eventually fails, we can call this function once
+ *	again and restore the "before resume" highmem state.
+ */
+
+int restore_highmem(void)
+{
+	struct highmem_pbe *pbe = highmem_pblist;
+	void *buf;
+
+	if (!pbe)
+		return 0;
+
+	buf = get_image_page(GFP_ATOMIC, PG_SAFE);
+	if (!buf)
+		return -ENOMEM;
+
+	while (pbe) {
+		swap_two_pages_data(pbe->copy_page, pbe->orig_page, buf);
+		pbe = pbe->next;
+	}
+	free_image_page(buf, PG_UNSAFE_CLEAR);
+	return 0;
 }
+#endif /* CONFIG_HIGHMEM */
Index: linux-2.6.18-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/power.h
+++ linux-2.6.18-mm3/kernel/power/power.h
@@ -103,8 +103,8 @@ struct snapshot_handle {
 extern unsigned int snapshot_additional_pages(struct zone *zone);
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
+extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
-extern void snapshot_free_unused_memory(struct snapshot_handle *handle);
 
 /*
  * This structure is used to pass the values needed for the identification
Index: linux-2.6.18-mm3/kernel/power/swap.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/swap.c
+++ linux-2.6.18-mm3/kernel/power/swap.c
@@ -557,7 +557,7 @@ static int load_image(struct swap_map_ha
 		error = err2;
 	if (!error) {
 		printk("\b\b\b\bdone\n");
-		snapshot_free_unused_memory(snapshot);
+		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			error = -ENODATA;
 	}
Index: linux-2.6.18-mm3/kernel/power/user.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/user.c
+++ linux-2.6.18-mm3/kernel/power/user.c
@@ -194,12 +194,12 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
+		snapshot_write_finalize(&data->handle);
 		if (data->mode != O_WRONLY || !data->frozen ||
 		    !snapshot_image_loaded(&data->handle)) {
 			error = -EPERM;
 			break;
 		}
-		snapshot_free_unused_memory(&data->handle);
 		down(&pm_sem);
 		pm_prepare_console();
 		suspend_console();
Index: linux-2.6.18-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/swsusp.c
+++ linux-2.6.18-mm3/kernel/power/swsusp.c
@@ -64,10 +64,8 @@ int in_suspend __nosavedata = 0;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);
-int save_highmem(void);
 int restore_highmem(void);
 #else
-static inline int save_highmem(void) { return 0; }
 static inline int restore_highmem(void) { return 0; }
 static inline unsigned int count_highmem_pages(void) { return 0; }
 #endif
@@ -184,7 +182,7 @@ static inline unsigned long __shrink_mem
 
 int swsusp_shrink_memory(void)
 {
-	long size, tmp;
+	long tmp;
 	struct zone *zone;
 	unsigned long pages = 0;
 	unsigned int i = 0;
@@ -192,15 +190,27 @@ int swsusp_shrink_memory(void)
 
 	printk("Shrinking memory...  ");
 	do {
-		size = 2 * count_highmem_pages();
-		size += size / 50 + count_data_pages() + PAGES_FOR_IO;
+		long size, highmem_size;
+
+		highmem_size = count_highmem_pages();
+		size = count_data_pages() + PAGES_FOR_IO;
 		tmp = size;
 		for_each_zone (zone)
-			if (!is_highmem(zone) && populated_zone(zone)) {
-				tmp -= zone->free_pages;
-				tmp += zone->lowmem_reserve[ZONE_NORMAL];
-				tmp += snapshot_additional_pages(zone);
+			if (populated_zone(zone)) {
+				if (is_highmem(zone)) {
+					highmem_size -= zone->free_pages;
+				} else {
+					tmp -= zone->free_pages;
+					tmp += zone->lowmem_reserve[ZONE_NORMAL];
+					tmp += snapshot_additional_pages(zone);
+				}
 			}
+
+		if (highmem_size < 0)
+			highmem_size = 0;
+
+		size += highmem_size;
+		tmp += highmem_size;
 		if (tmp > 0) {
 			tmp = __shrink_memory(tmp);
 			if (!tmp)
@@ -223,6 +233,7 @@ int swsusp_suspend(void)
 
 	if ((error = arch_prepare_suspend()))
 		return error;
+
 	local_irq_disable();
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* device_power_down() now.
@@ -235,18 +246,11 @@ int swsusp_suspend(void)
 		goto Enable_irqs;
 	}
 
-	if ((error = save_highmem())) {
-		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
-		goto Restore_highmem;
-	}
-
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
-Restore_highmem:
-	restore_highmem();
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
@@ -268,18 +272,23 @@ int swsusp_resume(void)
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
-	error = swsusp_arch_resume();
-	/* Code below is only ever reached in case of failure. Otherwise
-	 * execution continues at place where swsusp_arch_suspend was called
-         */
-	BUG_ON(!error);
+	error = restore_highmem();
+	if (!error) {
+		error = swsusp_arch_resume();
+		/* The code below is only ever reached in case of a failure.
+		 * Otherwise execution continues at place where
+		 * swsusp_arch_suspend() was called
+        	 */
+		BUG_ON(!error);
+		/* This call to restore_highmem() undos the previous one */
+		restore_highmem();
+	}
 	/* The only reason why swsusp_arch_resume() can fail is memory being
 	 * very tight, so we have to free it as soon as we can to avoid
 	 * subsequent failures
 	 */
 	swsusp_free();
 	restore_processor_state();
-	restore_highmem();
 	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
Index: linux-2.6.18-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.18-mm3.orig/mm/vmscan.c
+++ linux-2.6.18-mm3/mm/vmscan.c
@@ -1233,6 +1233,9 @@ out:
 	}
 	if (!all_zones_ok) {
 		cond_resched();
+
+		try_to_freeze();
+
 		goto loop_again;
 	}
 
Index: linux-2.6.18-mm3/include/linux/suspend.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/suspend.h
+++ linux-2.6.18-mm3/include/linux/suspend.h
@@ -9,10 +9,13 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 
-/* page backup entry */
+/* struct pbe is used for creating lists of pages that should be restored
+ * atomically during the resume from disk, because the page frames they have
+ * occupied before the suspend are in use.
+ */
 struct pbe {
-	unsigned long address;		/* address of the copy */
-	unsigned long orig_address;	/* original address of page */
+	void *address;		/* address of the copy */
+	void *orig_address;	/* original address of a page */
 	struct pbe *next;
 };
 
