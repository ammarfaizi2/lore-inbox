Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031255AbWKUWup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031255AbWKUWup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031258AbWKUWup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:50:45 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:59302 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031255AbWKUWuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:50:44 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
Date: Tue, 21 Nov 2006 22:50:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a flag __GFP_MOVABLE.  Allocations using the __GFP_MOVABLE
in this patch can either be migrated using the page migration mechanism
or reclaimed by syncing with backing storage (be it a file or swap) and
discarding.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 fs/block_dev.c            |    2 +-
 fs/buffer.c               |    5 +++--
 fs/compat.c               |    2 +-
 fs/exec.c                 |    2 +-
 fs/inode.c                |    2 +-
 include/asm-i386/page.h   |    3 ++-
 include/asm-ia64/page.h   |    4 +++-
 include/asm-x86_64/page.h |    3 ++-
 include/linux/gfp.h       |    4 +++-
 include/linux/highmem.h   |    3 ++-
 mm/hugetlb.c              |    5 +++--
 mm/memory.c               |    6 ++++--
 mm/swap_state.c           |    3 ++-
 13 files changed, 28 insertions(+), 16 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/block_dev.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/block_dev.c
--- linux-2.6.19-rc5-mm2-clean/fs/block_dev.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/block_dev.c	2006-11-21 10:47:11.000000000 +0000
@@ -380,7 +380,7 @@ struct block_device *bdget(dev_t dev)
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
 		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+		mapping_set_gfp_mask(&inode->i_data, GFP_USER|__GFP_MOVABLE);
 		inode->i_data.backing_dev_info = &default_backing_dev_info;
 		spin_lock(&bdev_lock);
 		list_add(&bdev->bd_list, &all_bdevs);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/buffer.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/buffer.c
--- linux-2.6.19-rc5-mm2-clean/fs/buffer.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/buffer.c	2006-11-21 10:47:11.000000000 +0000
@@ -1048,7 +1048,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS|__GFP_MOVABLE);
 	if (!page)
 		return NULL;
 
@@ -2723,7 +2724,7 @@ int submit_bh(int rw, struct buffer_head
 	 * from here on down, it's all bio -- do the initial mapping,
 	 * submit_bio -> generic_make_request may further map this bio around
 	 */
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(GFP_NOIO|__GFP_MOVABLE, 1);
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/compat.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/compat.c
--- linux-2.6.19-rc5-mm2-clean/fs/compat.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/compat.c	2006-11-21 10:47:11.000000000 +0000
@@ -1419,7 +1419,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_MOVABLE);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/exec.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/exec.c
--- linux-2.6.19-rc5-mm2-clean/fs/exec.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/exec.c	2006-11-21 10:47:11.000000000 +0000
@@ -239,7 +239,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_MOVABLE);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/inode.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/inode.c
--- linux-2.6.19-rc5-mm2-clean/fs/inode.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/inode.c	2006-11-21 10:47:11.000000000 +0000
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGHUSER|__GFP_MOVABLE);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-i386/page.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-i386/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-i386/page.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-i386/page.h	2006-11-21 10:47:11.000000000 +0000
@@ -35,7 +35,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_HIGHUSER|__GFP_ZERO|__GFP_MOVABLE, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-ia64/page.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-ia64/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-ia64/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-ia64/page.h	2006-11-21 10:47:11.000000000 +0000
@@ -89,7 +89,9 @@ do {						\
 
 #define alloc_zeroed_user_highpage(vma, vaddr) \
 ({						\
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr); \
+	struct page *page = alloc_page_vma(	\
+			GFP_HIGHUSER | __GFP_ZERO | __GFP_MOVABLE, \
+			vma, vaddr); 		\
 	if (page)				\
  		flush_dcache_page(page);	\
 	page;					\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-x86_64/page.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-x86_64/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-x86_64/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/asm-x86_64/page.h	2006-11-21 10:47:11.000000000 +0000
@@ -51,7 +51,8 @@ void copy_page(void *, void *);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_HIGHUSER|__GFP_ZERO|__GFP_MOVABLE, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /*
  * These are used to make use of C type-checking..
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/gfp.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/gfp.h	2006-11-21 10:47:11.000000000 +0000
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
+#define __GFP_MOVABLE	((__force gfp_t)0x80000u) /* Page is movable */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
+			__GFP_MOVABLE)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/highmem.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/highmem.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/highmem.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/highmem.h	2006-11-21 10:47:11.000000000 +0000
@@ -65,7 +65,8 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_HIGHUSER|__GFP_MOVABLE,
+								vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/hugetlb.c linux-2.6.19-rc5-mm2-001_clustering_flags/mm/hugetlb.c
--- linux-2.6.19-rc5-mm2-clean/mm/hugetlb.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/mm/hugetlb.c	2006-11-21 10:47:11.000000000 +0000
@@ -103,8 +103,9 @@ static int alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
 	struct page *page;
-	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
-					HUGETLB_PAGE_ORDER);
+	page = alloc_pages_node(nid,
+			GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN|__GFP_MOVABLE,
+			HUGETLB_PAGE_ORDER);
 	nid = next_node(nid, node_online_map);
 	if (nid == MAX_NUMNODES)
 		nid = first_node(node_online_map);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/memory.c linux-2.6.19-rc5-mm2-001_clustering_flags/mm/memory.c
--- linux-2.6.19-rc5-mm2-clean/mm/memory.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/mm/memory.c	2006-11-21 10:47:11.000000000 +0000
@@ -1564,7 +1564,8 @@ gotten:
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_MOVABLE,
+				vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2188,7 +2189,8 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
-			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			page = alloc_page_vma(GFP_HIGHUSER|__GFP_MOVABLE,
+				vma, address);
 			if (!page)
 				goto oom;
 			copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/swap_state.c linux-2.6.19-rc5-mm2-001_clustering_flags/mm/swap_state.c
--- linux-2.6.19-rc5-mm2-clean/mm/swap_state.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/mm/swap_state.c	2006-11-21 10:47:11.000000000 +0000
@@ -343,7 +343,8 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_MOVABLE,
+				vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
