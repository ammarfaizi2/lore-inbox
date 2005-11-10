Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVKJBph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVKJBph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKJBph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:45:37 -0500
Received: from silver.veritas.com ([143.127.12.111]:49703 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751385AbVKJBpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:45:36 -0500
Date: Thu, 10 Nov 2005 01:44:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] mm: revert page_private
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100143220.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:45:31.0545 (UTC) FILETIME=[6F535890:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page_private macro serves no purpose while spinlock_t is overlaid
in struct page: a purpose may be found for it later on, but until then
revert the abstraction, restoring various files to their previous state.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Note: the mm/vmscan.c mod gives an easily resolved reject on 2.6.14-git.

 arch/frv/mm/pgalloc.c       |    4 ++--
 arch/i386/mm/pgtable.c      |    8 ++++----
 fs/afs/file.c               |    4 ++--
 fs/buffer.c                 |    2 +-
 fs/jfs/jfs_metapage.c       |   12 ++++++------
 fs/xfs/linux-2.6/xfs_buf.c  |    7 +++----
 include/linux/buffer_head.h |    6 +++---
 include/linux/mm.h          |    9 +++------
 kernel/kexec.c              |    4 ++--
 mm/filemap.c                |    2 +-
 mm/page_alloc.c             |   16 ++++++++--------
 mm/page_io.c                |    6 ++----
 mm/rmap.c                   |    2 +-
 mm/shmem.c                  |   22 ++++++++++++----------
 mm/swap.c                   |    2 +-
 mm/swap_state.c             |    8 ++++----
 mm/swapfile.c               |   12 ++++++------
 mm/vmscan.c                 |    2 +-
 18 files changed, 62 insertions(+), 66 deletions(-)

--- mm01/arch/frv/mm/pgalloc.c	2005-11-07 07:39:00.000000000 +0000
+++ mm02/arch/frv/mm/pgalloc.c	2005-11-09 14:38:02.000000000 +0000
@@ -87,14 +87,14 @@ static inline void pgd_list_add(pgd_t *p
 	if (pgd_list)
 		pgd_list->private = (unsigned long) &page->index;
 	pgd_list = page;
-	set_page_private(page, (unsigned long)&pgd_list);
+	page->private = (unsigned long) &pgd_list;
 }
 
 static inline void pgd_list_del(pgd_t *pgd)
 {
 	struct page *next, **pprev, *page = virt_to_page(pgd);
 	next = (struct page *) page->index;
-	pprev = (struct page **)page_private(page);
+	pprev = (struct page **) page->private;
 	*pprev = next;
 	if (next)
 		next->private = (unsigned long) pprev;
--- mm01/arch/i386/mm/pgtable.c	2005-11-07 07:39:01.000000000 +0000
+++ mm02/arch/i386/mm/pgtable.c	2005-11-09 14:38:03.000000000 +0000
@@ -191,19 +191,19 @@ static inline void pgd_list_add(pgd_t *p
 	struct page *page = virt_to_page(pgd);
 	page->index = (unsigned long)pgd_list;
 	if (pgd_list)
-		set_page_private(pgd_list, (unsigned long)&page->index);
+		pgd_list->private = (unsigned long)&page->index;
 	pgd_list = page;
-	set_page_private(page, (unsigned long)&pgd_list);
+	page->private = (unsigned long)&pgd_list;
 }
 
 static inline void pgd_list_del(pgd_t *pgd)
 {
 	struct page *next, **pprev, *page = virt_to_page(pgd);
 	next = (struct page *)page->index;
-	pprev = (struct page **)page_private(page);
+	pprev = (struct page **)page->private;
 	*pprev = next;
 	if (next)
-		set_page_private(next, (unsigned long)pprev);
+		next->private = (unsigned long)pprev;
 }
 
 void pgd_ctor(void *pgd, kmem_cache_t *cache, unsigned long unused)
--- mm01/fs/afs/file.c	2005-11-07 07:39:42.000000000 +0000
+++ mm02/fs/afs/file.c	2005-11-09 14:38:03.000000000 +0000
@@ -261,8 +261,8 @@ static int afs_file_releasepage(struct p
 		cachefs_uncache_page(vnode->cache, page);
 #endif
 
-		pageio = (struct cachefs_page *) page_private(page);
-		set_page_private(page, 0);
+		pageio = (struct cachefs_page *) page->private;
+		page->private = 0;
 		ClearPagePrivate(page);
 
 		kfree(pageio);
--- mm01/fs/buffer.c	2005-11-07 07:39:43.000000000 +0000
+++ mm02/fs/buffer.c	2005-11-09 14:38:03.000000000 +0000
@@ -96,7 +96,7 @@ static void
 __clear_page_buffers(struct page *page)
 {
 	ClearPagePrivate(page);
-	set_page_private(page, 0);
+	page->private = 0;
 	page_cache_release(page);
 }
 
--- mm01/fs/jfs/jfs_metapage.c	2005-11-07 07:39:44.000000000 +0000
+++ mm02/fs/jfs/jfs_metapage.c	2005-11-09 14:38:03.000000000 +0000
@@ -86,7 +86,7 @@ struct meta_anchor {
 	atomic_t io_count;
 	struct metapage *mp[MPS_PER_PAGE];
 };
-#define mp_anchor(page) ((struct meta_anchor *)page_private(page))
+#define mp_anchor(page) ((struct meta_anchor *)page->private)
 
 static inline struct metapage *page_to_mp(struct page *page, uint offset)
 {
@@ -108,7 +108,7 @@ static inline int insert_metapage(struct
 		if (!a)
 			return -ENOMEM;
 		memset(a, 0, sizeof(struct meta_anchor));
-		set_page_private(page, (unsigned long)a);
+		page->private = (unsigned long)a;
 		SetPagePrivate(page);
 		kmap(page);
 	}
@@ -136,7 +136,7 @@ static inline void remove_metapage(struc
 	a->mp[index] = NULL;
 	if (--a->mp_count == 0) {
 		kfree(a);
-		set_page_private(page, 0);
+		page->private = 0;
 		ClearPagePrivate(page);
 		kunmap(page);
 	}
@@ -156,13 +156,13 @@ static inline void dec_io(struct page *p
 #else
 static inline struct metapage *page_to_mp(struct page *page, uint offset)
 {
-	return PagePrivate(page) ? (struct metapage *)page_private(page) : NULL;
+	return PagePrivate(page) ? (struct metapage *)page->private : NULL;
 }
 
 static inline int insert_metapage(struct page *page, struct metapage *mp)
 {
 	if (mp) {
-		set_page_private(page, (unsigned long)mp);
+		page->private = (unsigned long)mp;
 		SetPagePrivate(page);
 		kmap(page);
 	}
@@ -171,7 +171,7 @@ static inline int insert_metapage(struct
 
 static inline void remove_metapage(struct page *page, struct metapage *mp)
 {
-	set_page_private(page, 0);
+	page->private = 0;
 	ClearPagePrivate(page);
 	kunmap(page);
 }
--- mm01/fs/xfs/linux-2.6/xfs_buf.c	2005-11-07 07:39:47.000000000 +0000
+++ mm02/fs/xfs/linux-2.6/xfs_buf.c	2005-11-09 14:38:03.000000000 +0000
@@ -141,9 +141,8 @@ set_page_region(
 	size_t		offset,
 	size_t		length)
 {
-	set_page_private(page,
-		page_private(page) | page_region_mask(offset, length));
-	if (page_private(page) == ~0UL)
+	page->private |= page_region_mask(offset, length);
+	if (page->private == ~0UL)
 		SetPageUptodate(page);
 }
 
@@ -155,7 +154,7 @@ test_page_region(
 {
 	unsigned long	mask = page_region_mask(offset, length);
 
-	return (mask && (page_private(page) & mask) == mask);
+	return (mask && (page->private & mask) == mask);
 }
 
 /*
--- mm01/include/linux/buffer_head.h	2005-11-07 07:39:56.000000000 +0000
+++ mm02/include/linux/buffer_head.h	2005-11-09 14:38:03.000000000 +0000
@@ -126,8 +126,8 @@ BUFFER_FNS(Eopnotsupp, eopnotsupp)
 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)					\
 	({							\
-		BUG_ON(!PagePrivate(page));			\
-		((struct buffer_head *)page_private(page));	\
+		BUG_ON(!PagePrivate(page));		\
+		((struct buffer_head *)(page)->private);	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
 
@@ -220,7 +220,7 @@ static inline void attach_page_buffers(s
 {
 	page_cache_get(page);
 	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)head);
+	page->private = (unsigned long)head;
 }
 
 static inline void get_bh(struct buffer_head *bh)
--- mm01/include/linux/mm.h	2005-11-09 14:37:47.000000000 +0000
+++ mm02/include/linux/mm.h	2005-11-09 14:38:03.000000000 +0000
@@ -269,9 +269,6 @@ struct page {
 #endif
 };
 
-#define page_private(page)		((page)->private)
-#define set_page_private(page, v)	((page)->private = (v))
-
 /*
  * FIXME: take this include out, include page-flags.h in
  * files which need it (119 of them)
@@ -326,14 +323,14 @@ extern void FASTCALL(__page_cache_releas
 static inline int page_count(struct page *page)
 {
 	if (PageCompound(page))
-		page = (struct page *)page_private(page);
+		page = (struct page *)page->private;
 	return atomic_read(&page->_count) + 1;
 }
 
 static inline void get_page(struct page *page)
 {
 	if (unlikely(PageCompound(page)))
-		page = (struct page *)page_private(page);
+		page = (struct page *)page->private;
 	atomic_inc(&page->_count);
 }
 
@@ -599,7 +596,7 @@ static inline int PageAnon(struct page *
 static inline pgoff_t page_index(struct page *page)
 {
 	if (unlikely(PageSwapCache(page)))
-		return page_private(page);
+		return page->private;
 	return page->index;
 }
 
--- mm01/kernel/kexec.c	2005-11-07 07:39:59.000000000 +0000
+++ mm02/kernel/kexec.c	2005-11-09 14:38:03.000000000 +0000
@@ -334,7 +334,7 @@ static struct page *kimage_alloc_pages(g
 	if (pages) {
 		unsigned int count, i;
 		pages->mapping = NULL;
-		set_page_private(pages, order);
+		pages->private = order;
 		count = 1 << order;
 		for (i = 0; i < count; i++)
 			SetPageReserved(pages + i);
@@ -347,7 +347,7 @@ static void kimage_free_pages(struct pag
 {
 	unsigned int order, count, i;
 
-	order = page_private(page);
+	order = page->private;
 	count = 1 << order;
 	for (i = 0; i < count; i++)
 		ClearPageReserved(page + i);
--- mm01/mm/filemap.c	2005-11-07 07:39:59.000000000 +0000
+++ mm02/mm/filemap.c	2005-11-09 14:38:03.000000000 +0000
@@ -154,7 +154,7 @@ static int sync_page(void *word)
 	 * in the ->sync_page() methods make essential use of the
 	 * page_mapping(), merely passing the page down to the backing
 	 * device's unplug functions when it's non-NULL, which in turn
-	 * ignore it for all cases but swap, where only page_private(page) is
+	 * ignore it for all cases but swap, where only page->private is
 	 * of interest. When page_mapping() does go NULL, the entire
 	 * call stack gracefully ignores the page and returns.
 	 * -- wli
--- mm01/mm/page_alloc.c	2005-11-07 07:39:59.000000000 +0000
+++ mm02/mm/page_alloc.c	2005-11-09 14:38:03.000000000 +0000
@@ -180,7 +180,7 @@ static void prep_compound_page(struct pa
 		struct page *p = page + i;
 
 		SetPageCompound(p);
-		set_page_private(p, (unsigned long)page);
+		p->private = (unsigned long)page;
 	}
 }
 
@@ -200,7 +200,7 @@ static void destroy_compound_page(struct
 
 		if (!PageCompound(p))
 			bad_page(__FUNCTION__, page);
-		if (page_private(p) != (unsigned long)page)
+		if (p->private != (unsigned long)page)
 			bad_page(__FUNCTION__, page);
 		ClearPageCompound(p);
 	}
@@ -213,18 +213,18 @@ static void destroy_compound_page(struct
  * So, we don't need atomic page->flags operations here.
  */
 static inline unsigned long page_order(struct page *page) {
-	return page_private(page);
+	return page->private;
 }
 
 static inline void set_page_order(struct page *page, int order) {
-	set_page_private(page, order);
+	page->private = order;
 	__SetPagePrivate(page);
 }
 
 static inline void rmv_page_order(struct page *page)
 {
 	__ClearPagePrivate(page);
-	set_page_private(page, 0);
+	page->private = 0;
 }
 
 /*
@@ -264,7 +264,7 @@ __find_combined_index(unsigned long page
  * (a) the buddy is free &&
  * (b) the buddy is on the buddy system &&
  * (c) a page and its buddy have the same order.
- * for recording page's order, we use page_private(page) and PG_private.
+ * for recording page's order, we use page->private and PG_private.
  *
  */
 static inline int page_is_buddy(struct page *page, int order)
@@ -290,7 +290,7 @@ static inline int page_is_buddy(struct p
  * parts of the VM system.
  * At each level, we keep a list of pages, which are heads of continuous
  * free pages of length of (1 << order) and marked with PG_Private.Page's
- * order is recorded in page_private(page) field.
+ * order is recorded in page->private field.
  * So when we are allocating or freeing one, we can derive the state of the
  * other.  That is, if we allocate a small block, and both were   
  * free, the remainder of the region must be split into blocks.   
@@ -489,7 +489,7 @@ static void prep_new_page(struct page *p
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
-	set_page_private(page, 0);
+	page->private = 0;
 	set_page_refs(page, order);
 	kernel_map_pages(page, 1 << order, 1);
 }
--- mm01/mm/page_io.c	2005-11-07 07:39:59.000000000 +0000
+++ mm02/mm/page_io.c	2005-11-09 14:38:03.000000000 +0000
@@ -91,8 +91,7 @@ int swap_writepage(struct page *page, st
 		unlock_page(page);
 		goto out;
 	}
-	bio = get_swap_bio(GFP_NOIO, page_private(page), page,
-				end_swap_bio_write);
+	bio = get_swap_bio(GFP_NOIO, page->private, page, end_swap_bio_write);
 	if (bio == NULL) {
 		set_page_dirty(page);
 		unlock_page(page);
@@ -116,8 +115,7 @@ int swap_readpage(struct file *file, str
 
 	BUG_ON(!PageLocked(page));
 	ClearPageUptodate(page);
-	bio = get_swap_bio(GFP_KERNEL, page_private(page), page,
-				end_swap_bio_read);
+	bio = get_swap_bio(GFP_KERNEL, page->private, page, end_swap_bio_read);
 	if (bio == NULL) {
 		unlock_page(page);
 		ret = -ENOMEM;
--- mm01/mm/rmap.c	2005-11-07 07:40:00.000000000 +0000
+++ mm02/mm/rmap.c	2005-11-09 14:38:03.000000000 +0000
@@ -550,7 +550,7 @@ static int try_to_unmap_one(struct page 
 	update_hiwater_rss(mm);
 
 	if (PageAnon(page)) {
-		swp_entry_t entry = { .val = page_private(page) };
+		swp_entry_t entry = { .val = page->private };
 		/*
 		 * Store the swap location in the pte.
 		 * See handle_pte_fault() ...
--- mm01/mm/shmem.c	2005-11-07 07:40:00.000000000 +0000
+++ mm02/mm/shmem.c	2005-11-09 14:38:03.000000000 +0000
@@ -71,6 +71,9 @@
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
+/* Keep swapped page count in private field of indirect struct page */
+#define nr_swapped		private
+
 /* Flag allocation requirements to shmem_getpage and shmem_swp_alloc */
 enum sgp_type {
 	SGP_QUICK,	/* don't try more than file page cache lookup */
@@ -321,10 +324,8 @@ static void shmem_swp_set(struct shmem_i
 
 	entry->val = value;
 	info->swapped += incdec;
-	if ((unsigned long)(entry - info->i_direct) >= SHMEM_NR_DIRECT) {
-		struct page *page = kmap_atomic_to_page(entry);
-		set_page_private(page, page_private(page) + incdec);
-	}
+	if ((unsigned long)(entry - info->i_direct) >= SHMEM_NR_DIRECT)
+		kmap_atomic_to_page(entry)->nr_swapped += incdec;
 }
 
 /*
@@ -367,8 +368,9 @@ static swp_entry_t *shmem_swp_alloc(stru
 
 		spin_unlock(&info->lock);
 		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
-		if (page)
-			set_page_private(page, 0);
+		if (page) {
+			page->nr_swapped = 0;
+		}
 		spin_lock(&info->lock);
 
 		if (!page) {
@@ -559,7 +561,7 @@ static void shmem_truncate(struct inode 
 			diroff = 0;
 		}
 		subdir = dir[diroff];
-		if (subdir && page_private(subdir)) {
+		if (subdir && subdir->nr_swapped) {
 			size = limit - idx;
 			if (size > ENTRIES_PER_PAGE)
 				size = ENTRIES_PER_PAGE;
@@ -570,10 +572,10 @@ static void shmem_truncate(struct inode 
 			nr_swaps_freed += freed;
 			if (offset)
 				spin_lock(&info->lock);
-			set_page_private(subdir, page_private(subdir) - freed);
+			subdir->nr_swapped -= freed;
 			if (offset)
 				spin_unlock(&info->lock);
-			BUG_ON(page_private(subdir) > offset);
+			BUG_ON(subdir->nr_swapped > offset);
 		}
 		if (offset)
 			offset = 0;
@@ -741,7 +743,7 @@ static int shmem_unuse_inode(struct shme
 			dir = shmem_dir_map(subdir);
 		}
 		subdir = *dir;
-		if (subdir && page_private(subdir)) {
+		if (subdir && subdir->nr_swapped) {
 			ptr = shmem_swp_map(subdir);
 			size = limit - idx;
 			if (size > ENTRIES_PER_PAGE)
--- mm01/mm/swap.c	2005-11-07 07:40:00.000000000 +0000
+++ mm02/mm/swap.c	2005-11-09 14:38:03.000000000 +0000
@@ -39,7 +39,7 @@ int page_cluster;
 void put_page(struct page *page)
 {
 	if (unlikely(PageCompound(page))) {
-		page = (struct page *)page_private(page);
+		page = (struct page *)page->private;
 		if (put_page_testzero(page)) {
 			void (*dtor)(struct page *page);
 
--- mm01/mm/swap_state.c	2005-11-07 07:40:00.000000000 +0000
+++ mm02/mm/swap_state.c	2005-11-09 14:38:03.000000000 +0000
@@ -83,7 +83,7 @@ static int __add_to_swap_cache(struct pa
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
-			set_page_private(page, entry.val);
+			page->private = entry.val;
 			total_swapcache_pages++;
 			pagecache_acct(1);
 		}
@@ -127,8 +127,8 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(PageWriteback(page));
 	BUG_ON(PagePrivate(page));
 
-	radix_tree_delete(&swapper_space.page_tree, page_private(page));
-	set_page_private(page, 0);
+	radix_tree_delete(&swapper_space.page_tree, page->private);
+	page->private = 0;
 	ClearPageSwapCache(page);
 	total_swapcache_pages--;
 	pagecache_acct(-1);
@@ -201,7 +201,7 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	entry.val = page_private(page);
+	entry.val = page->private;
 
 	write_lock_irq(&swapper_space.tree_lock);
 	__delete_from_swap_cache(page);
--- mm01/mm/swapfile.c	2005-11-07 07:40:00.000000000 +0000
+++ mm02/mm/swapfile.c	2005-11-09 14:38:03.000000000 +0000
@@ -59,7 +59,7 @@ void swap_unplug_io_fn(struct backing_de
 	swp_entry_t entry;
 
 	down_read(&swap_unplug_sem);
-	entry.val = page_private(page);
+	entry.val = page->private;
 	if (PageSwapCache(page)) {
 		struct block_device *bdev = swap_info[swp_type(entry)].bdev;
 		struct backing_dev_info *bdi;
@@ -67,8 +67,8 @@ void swap_unplug_io_fn(struct backing_de
 		/*
 		 * If the page is removed from swapcache from under us (with a
 		 * racy try_to_unuse/swapoff) we need an additional reference
-		 * count to avoid reading garbage from page_private(page) above.
-		 * If the WARN_ON triggers during a swapoff it maybe the race
+		 * count to avoid reading garbage from page->private above. If
+		 * the WARN_ON triggers during a swapoff it maybe the race
 		 * condition and it's harmless. However if it triggers without
 		 * swapoff it signals a problem.
 		 */
@@ -292,7 +292,7 @@ static inline int page_swapcount(struct 
 	struct swap_info_struct *p;
 	swp_entry_t entry;
 
-	entry.val = page_private(page);
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (p) {
 		/* Subtract the 1 for the swap cache itself */
@@ -337,7 +337,7 @@ int remove_exclusive_swap_page(struct pa
 	if (page_count(page) != 2) /* 2: us + cache */
 		return 0;
 
-	entry.val = page_private(page);
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (!p)
 		return 0;
@@ -1040,7 +1040,7 @@ int page_queue_congested(struct page *pa
 	BUG_ON(!PageLocked(page));	/* It pins the swap_info_struct */
 
 	if (PageSwapCache(page)) {
-		swp_entry_t entry = { .val = page_private(page) };
+		swp_entry_t entry = { .val = page->private };
 		struct swap_info_struct *sis;
 
 		sis = get_swap_info_struct(swp_type(entry));
--- mm01/mm/vmscan.c	2005-11-07 07:40:01.000000000 +0000
+++ mm02/mm/vmscan.c	2005-11-09 14:38:03.000000000 +0000
@@ -387,7 +387,7 @@ static inline int remove_mapping(struct 
 		goto cannot_free;
 
 	if (PageSwapCache(page)) {
-		swp_entry_t swap = { .val = page_private(page) };
+		swp_entry_t swap = { .val = page->private };
 		add_to_swapped_list(swap.val);
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
