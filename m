Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWIGTEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWIGTEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIGTEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:04:05 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:41696 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751201AbWIGTEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:04:04 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060907190402.6166.61056.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 1/8] Add __GFP_EASYRCLM flag and update callers
Date: Thu,  7 Sep 2006 20:04:02 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a flag __GFP_EASYRCLM.  Allocations using the __GFP_EASYRCLM
flag are expected to be easily reclaimed by syncing with backing storage (be
it a file or swap) or cleaning the buffers and discarding.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 fs/block_dev.c          |    3 ++-
 fs/buffer.c             |    3 ++-
 fs/compat.c             |    3 ++-
 fs/exec.c               |    3 ++-
 fs/inode.c              |    3 ++-
 include/asm-i386/page.h |    4 +++-
 include/linux/gfp.h     |   12 +++++++++++-
 include/linux/highmem.h |    4 +++-
 mm/memory.c             |    8 ++++++--
 mm/swap_state.c         |    4 +++-
 10 files changed, 36 insertions(+), 11 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/fs/block_dev.c linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/block_dev.c
--- linux-2.6.18-rc5-mm1-clean/fs/block_dev.c	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/block_dev.c	2006-09-04 18:36:09.000000000 +0100
@@ -380,7 +380,8 @@ struct block_device *bdget(dev_t dev)
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
 		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+		mapping_set_gfp_mask(&inode->i_data,
+				set_rclmflags(GFP_USER, __GFP_EASYRCLM));
 		inode->i_data.backing_dev_info = &default_backing_dev_info;
 		spin_lock(&bdev_lock);
 		list_add(&bdev->bd_list, &all_bdevs);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/fs/buffer.c linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/buffer.c
--- linux-2.6.18-rc5-mm1-clean/fs/buffer.c	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/buffer.c	2006-09-04 18:36:09.000000000 +0100
@@ -986,7 +986,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   set_rclmflags(GFP_NOFS, __GFP_EASYRCLM));
 	if (!page)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/fs/compat.c linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/compat.c
--- linux-2.6.18-rc5-mm1-clean/fs/compat.c	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/compat.c	2006-09-04 18:36:09.000000000 +0100
@@ -1419,7 +1419,8 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(set_rclmflags(GFP_HIGHUSER,
+							__GFP_EASYRCLM));
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/fs/exec.c linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/exec.c
--- linux-2.6.18-rc5-mm1-clean/fs/exec.c	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/exec.c	2006-09-04 18:36:09.000000000 +0100
@@ -238,7 +238,8 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(set_rclmflags(GFP_HIGHUSER,
+							__GFP_EASYRCLM));
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/fs/inode.c linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/inode.c
--- linux-2.6.18-rc5-mm1-clean/fs/inode.c	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/fs/inode.c	2006-09-04 18:36:09.000000000 +0100
@@ -145,7 +145,8 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping,
+				set_rclmflags(GFP_HIGHUSER, __GFP_EASYRCLM));
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/include/asm-i386/page.h linux-2.6.18-rc5-mm1-001_antifrag_flags/include/asm-i386/page.h
--- linux-2.6.18-rc5-mm1-clean/include/asm-i386/page.h	2006-08-28 04:41:48.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/include/asm-i386/page.h	2006-09-04 18:36:09.000000000 +0100
@@ -35,7 +35,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(set_rclmflags(GFP_HIGHUSER|__GFP_ZERO, __GFP_EASYRCLM),\
+								vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/include/linux/gfp.h linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/gfp.h
--- linux-2.6.18-rc5-mm1-clean/include/linux/gfp.h	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/gfp.h	2006-09-04 18:36:09.000000000 +0100
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
+#define __GFP_EASYRCLM	((__force gfp_t)0x80000u) /* Easily reclaimed page */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,11 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
+			__GFP_EASYRCLM)
+
+/* This mask makes up all the RCLM-related flags */
+#define GFP_RECLAIM_MASK (__GFP_EASYRCLM)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -93,6 +98,11 @@ static inline enum zone_type gfp_zone(gf
 	return ZONE_NORMAL;
 }
 
+static inline gfp_t set_rclmflags(gfp_t gfp, gfp_t reclaim_flags)
+{
+	return (gfp & ~(GFP_RECLAIM_MASK)) | reclaim_flags;
+}
+
 /*
  * There is only one page-allocator function, and two main namespaces to
  * it. The alloc_page*() variants return 'struct page *' and as such
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/include/linux/highmem.h linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/highmem.h
--- linux-2.6.18-rc5-mm1-clean/include/linux/highmem.h	2006-09-04 18:34:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/highmem.h	2006-09-04 18:36:09.000000000 +0100
@@ -61,7 +61,9 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(
+				set_rclmflags(GFP_HIGHUSER, __GFP_EASYRCLM),
+				vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/mm/memory.c linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/memory.c
--- linux-2.6.18-rc5-mm1-clean/mm/memory.c	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/memory.c	2006-09-04 18:36:09.000000000 +0100
@@ -1562,7 +1562,9 @@ gotten:
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(
+				set_rclmflags(GFP_HIGHUSER, __GFP_EASYRCLM),
+				vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2177,7 +2179,9 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
-			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			page = alloc_page_vma(
+				set_rclmflags(GFP_HIGHUSER, __GFP_EASYRCLM),
+				vma, address);
 			if (!page)
 				goto oom;
 			copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-clean/mm/swap_state.c linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/swap_state.c
--- linux-2.6.18-rc5-mm1-clean/mm/swap_state.c	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/swap_state.c	2006-09-04 18:36:09.000000000 +0100
@@ -343,7 +343,9 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(
+				set_rclmflags(GFP_HIGHUSER, __GFP_EASYRCLM),
+				vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
