Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVKOQue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVKOQue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKOQuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:50:03 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:33708 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964926AbVKOQuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:50:00 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Message-Id: <20051115164952.21980.3852.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 1/5] Light Fragmentation Avoidance V20: 001_antidefrag_flags
Date: Tue, 15 Nov 2005 16:49:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a flag __GFP_EASYRCLM.  Allocations using the __GFP_EASYRCLM
flag are expected to be easily reclaimed by syncing with backing storage (be
it a file or swap) or cleaning the buffers and discarding.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/fs/buffer.c linux-2.6.14-mm2-001_antidefrag_flags/fs/buffer.c
--- linux-2.6.14-mm2-clean/fs/buffer.c	2005-11-13 21:22:24.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/fs/buffer.c	2005-11-15 12:40:42.000000000 +0000
@@ -1113,7 +1113,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS|__GFP_EASYRCLM);
 	if (!page)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/fs/compat.c linux-2.6.14-mm2-001_antidefrag_flags/fs/compat.c
--- linux-2.6.14-mm2-clean/fs/compat.c	2005-11-13 21:22:24.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/fs/compat.c	2005-11-15 12:40:42.000000000 +0000
@@ -1345,7 +1345,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_EASYRCLM);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/fs/exec.c linux-2.6.14-mm2-001_antidefrag_flags/fs/exec.c
--- linux-2.6.14-mm2-clean/fs/exec.c	2005-11-13 21:22:24.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/fs/exec.c	2005-11-15 12:40:42.000000000 +0000
@@ -238,7 +238,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_EASYRCLM);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/fs/inode.c linux-2.6.14-mm2-001_antidefrag_flags/fs/inode.c
--- linux-2.6.14-mm2-clean/fs/inode.c	2005-11-13 21:22:24.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/fs/inode.c	2005-11-15 12:40:42.000000000 +0000
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGHUSER|__GFP_EASYRCLM);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/include/asm-i386/page.h linux-2.6.14-mm2-001_antidefrag_flags/include/asm-i386/page.h
--- linux-2.6.14-mm2-clean/include/asm-i386/page.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14-mm2-001_antidefrag_flags/include/asm-i386/page.h	2005-11-15 12:40:42.000000000 +0000
@@ -36,7 +36,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | __GFP_EASYRCLM, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/include/linux/gfp.h linux-2.6.14-mm2-001_antidefrag_flags/include/linux/gfp.h
--- linux-2.6.14-mm2-clean/include/linux/gfp.h	2005-11-13 21:22:26.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/include/linux/gfp.h	2005-11-15 12:40:42.000000000 +0000
@@ -50,6 +50,12 @@ struct vm_area_struct;
 #define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_VALID	((__force gfp_t)0x80000000u) /* valid GFP flags */
 
+/*
+ * Allocation type modifier
+ * __GFP_EASYRCLM: Easily reclaimed pages like userspace or buffer pages
+ */
+#define __GFP_EASYRCLM   0x80000u  /* User and other easily reclaimed pages */
+
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
@@ -57,7 +63,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL| \
+			__GFP_EASYRCLM)
 
 #define GFP_ATOMIC	(__GFP_VALID | __GFP_HIGH)
 #define GFP_NOIO	(__GFP_VALID | __GFP_WAIT)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/include/linux/highmem.h linux-2.6.14-mm2-001_antidefrag_flags/include/linux/highmem.h
--- linux-2.6.14-mm2-clean/include/linux/highmem.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14-mm2-001_antidefrag_flags/include/linux/highmem.h	2005-11-15 12:40:42.000000000 +0000
@@ -47,7 +47,8 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/mm/memory.c linux-2.6.14-mm2-001_antidefrag_flags/mm/memory.c
--- linux-2.6.14-mm2-clean/mm/memory.c	2005-11-13 21:22:26.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/mm/memory.c	2005-11-15 12:40:42.000000000 +0000
@@ -1346,7 +1346,8 @@ static int do_wp_page(struct mm_struct *
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, address);
 		if (!new_page)
 			goto oom;
 		copy_user_highpage(new_page, old_page, address);
@@ -1914,7 +1915,8 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
-			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+								vma, address);
 			if (!page)
 				goto oom;
 			copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/mm/shmem.c linux-2.6.14-mm2-001_antidefrag_flags/mm/shmem.c
--- linux-2.6.14-mm2-clean/mm/shmem.c	2005-11-13 21:22:27.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/mm/shmem.c	2005-11-15 12:40:42.000000000 +0000
@@ -906,7 +906,7 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
+	page = alloc_page_vma(gfp | __GFP_ZERO | __GFP_EASYRCLM, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -921,7 +921,7 @@ shmem_swapin(struct shmem_inode_info *in
 static inline struct page *
 shmem_alloc_page(gfp_t gfp,struct shmem_inode_info *info, unsigned long idx)
 {
-	return alloc_page(gfp | __GFP_ZERO);
+	return alloc_page(gfp | __GFP_ZERO | __GFP_EASYRCLM);
 }
 #endif
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-clean/mm/swap_state.c linux-2.6.14-mm2-001_antidefrag_flags/mm/swap_state.c
--- linux-2.6.14-mm2-clean/mm/swap_state.c	2005-11-13 21:22:27.000000000 +0000
+++ linux-2.6.14-mm2-001_antidefrag_flags/mm/swap_state.c	2005-11-15 12:40:42.000000000 +0000
@@ -341,7 +341,8 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
