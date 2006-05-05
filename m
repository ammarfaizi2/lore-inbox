Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWEERfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWEERfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWEERfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:35:13 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:38020 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751674AbWEERfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:35:08 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173506.9030.49923.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 1/8] Add __GFP_EASYRCLM flag and update callers
Date: Fri,  5 May 2006 18:35:06 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This creates a zone modifier __GFP_EASYRCLM and a set of GFP flags called
GFP_RCLMUSER. The only difference between GFP_HIGHUSER and GFP_RCLMUSER is the
zone that is used. Callers appropriate to use the ZONE_EASYRCLM are changed.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/fs/compat.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/compat.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/fs/compat.c	2006-05-03 09:41:32.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/compat.c	2006-05-03 09:45:54.000000000 +0100
@@ -1437,7 +1437,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_RCLMUSER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/fs/exec.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/exec.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/fs/exec.c	2006-05-03 09:41:32.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/exec.c	2006-05-03 09:45:54.000000000 +0100
@@ -238,7 +238,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_RCLMUSER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/fs/inode.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/inode.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/fs/inode.c	2006-05-03 09:41:32.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/inode.c	2006-05-05 17:34:36.000000000 +0100
@@ -147,7 +147,18 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
+#ifndef CONFIG_IA64
+		mapping_set_gfp_mask(mapping, GFP_RCLMUSER);
+#else
+		/*
+		 * This is obviously a rubbish check to be making. On ia64,
+		 * the machine crashes before the console inits. If someone
+		 * has an ia64 that they can see the screen of, please get rid
+		 * of this #define, boot the machine and send mel@csn.ul.ie a
+		 * report on what breaks during boot please
+		 */
 		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+#endif
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/include/asm-i386/page.h linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/asm-i386/page.h
--- linux-2.6.17-rc3-mm1-zonesizing-v9/include/asm-i386/page.h	2006-05-03 09:41:32.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/asm-i386/page.h	2006-05-03 09:45:54.000000000 +0100
@@ -36,7 +36,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_RCLMUSER | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/include/linux/gfp.h linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/gfp.h
--- linux-2.6.17-rc3-mm1-zonesizing-v9/include/linux/gfp.h	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/gfp.h	2006-05-03 09:45:54.000000000 +0100
@@ -21,6 +21,7 @@ struct vm_area_struct;
 #else
 #define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
 #endif
+#define __GFP_EASYRCLM  ((__force gfp_t)0x08u)
 
 /*
  * Action modifiers - doesn't change the zoning
@@ -67,6 +68,8 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_RCLMUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
+			__GFP_EASYRCLM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/include/linux/highmem.h linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/highmem.h
--- linux-2.6.17-rc3-mm1-zonesizing-v9/include/linux/highmem.h	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/highmem.h	2006-05-03 09:45:54.000000000 +0100
@@ -59,7 +59,7 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_RCLMUSER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/mm/memory.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/memory.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/mm/memory.c	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/memory.c	2006-05-03 09:45:54.000000000 +0100
@@ -1495,7 +1495,7 @@ gotten:
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_RCLMUSER, vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2091,7 +2091,7 @@ retry:
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		page = alloc_page_vma(GFP_RCLMUSER, vma, address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/mm/shmem.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/shmem.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/mm/shmem.c	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/shmem.c	2006-05-03 09:45:54.000000000 +0100
@@ -968,6 +968,8 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
+	if (gfp & __GFP_HIGHMEM)
+		gfp = (gfp & ~__GFP_HIGHMEM) | __GFP_EASYRCLM;
 	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
@@ -988,6 +990,8 @@ shmem_swapin(struct shmem_inode_info *in
 static inline struct page *
 shmem_alloc_page(gfp_t gfp,struct shmem_inode_info *info, unsigned long idx)
 {
+	if (gfp & __GFP_HIGHMEM)
+		gfp = (gfp & ~__GFP_HIGHMEM) | __GFP_EASYRCLM;
 	return alloc_page(gfp | __GFP_ZERO);
 }
 #endif
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-v9/mm/swap_state.c linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/swap_state.c
--- linux-2.6.17-rc3-mm1-zonesizing-v9/mm/swap_state.c	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/swap_state.c	2006-05-03 09:45:54.000000000 +0100
@@ -343,7 +343,7 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_RCLMUSER, vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
