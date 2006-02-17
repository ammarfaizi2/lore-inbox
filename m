Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWBQORU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWBQORU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBQORU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:17:20 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:9694 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751418AbWBQORT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:17:19 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060217141612.7621.58291.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 1/7] Add __GFP_EASYRCLM flag and update callers
Date: Fri, 17 Feb 2006 14:16:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This creates a zone modifier __GFP_EASYRCLM and a set of GFP flags called
GFP_RCLMUSER. The only difference between GFP_HIGHUSER and GFP_RCLMUSER is the
zone that is used. Callers appropriate to use the ZONE_EASYRCLM are changed.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/fs/compat.c linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/compat.c
--- linux-2.6.16-rc3-mm1-clean/fs/compat.c	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/compat.c	2006-02-17 09:41:14.000000000 +0000
@@ -1397,7 +1397,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_RCLMUSER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/fs/exec.c linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/exec.c
--- linux-2.6.16-rc3-mm1-clean/fs/exec.c	2006-02-16 09:50:43.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/exec.c	2006-02-17 09:41:14.000000000 +0000
@@ -238,7 +238,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_RCLMUSER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/fs/inode.c linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/inode.c
--- linux-2.6.16-rc3-mm1-clean/fs/inode.c	2006-02-16 09:50:43.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/fs/inode.c	2006-02-17 09:41:14.000000000 +0000
@@ -147,7 +147,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_RCLMUSER);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/include/asm-i386/page.h linux-2.6.16-rc3-mm1-101_antifrag_flags/include/asm-i386/page.h
--- linux-2.6.16-rc3-mm1-clean/include/asm-i386/page.h	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/include/asm-i386/page.h	2006-02-17 09:41:14.000000000 +0000
@@ -36,7 +36,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_RCLMUSER | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/include/linux/gfp.h linux-2.6.16-rc3-mm1-101_antifrag_flags/include/linux/gfp.h
--- linux-2.6.16-rc3-mm1-clean/include/linux/gfp.h	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/include/linux/gfp.h	2006-02-17 09:41:14.000000000 +0000
@@ -21,6 +21,7 @@ struct vm_area_struct;
 #else
 #define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
 #endif
+#define __GFP_EASYRCLM  ((__force gfp_t)0x08u)
 
 /*
  * Action modifiers - doesn't change the zoning
@@ -65,6 +66,8 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_RCLMUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
+			__GFP_EASYRCLM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/include/linux/highmem.h linux-2.6.16-rc3-mm1-101_antifrag_flags/include/linux/highmem.h
--- linux-2.6.16-rc3-mm1-clean/include/linux/highmem.h	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/include/linux/highmem.h	2006-02-17 09:41:14.000000000 +0000
@@ -47,7 +47,7 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_RCLMUSER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/mm/memory.c linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/memory.c
--- linux-2.6.16-rc3-mm1-clean/mm/memory.c	2006-02-16 09:50:44.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/memory.c	2006-02-17 09:41:14.000000000 +0000
@@ -1480,7 +1480,7 @@ gotten:
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_RCLMUSER, vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2079,7 +2079,7 @@ retry:
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		page = alloc_page_vma(GFP_RCLMUSER, vma, address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/mm/shmem.c linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/shmem.c
--- linux-2.6.16-rc3-mm1-clean/mm/shmem.c	2006-02-16 09:50:44.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/shmem.c	2006-02-17 09:41:14.000000000 +0000
@@ -921,6 +921,8 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
+	if (gfp & __GFP_HIGHMEM)
+		gfp = (gfp & ~__GFP_HIGHMEM) | __GFP_EASYRCLM;
 	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
@@ -936,6 +938,8 @@ shmem_swapin(struct shmem_inode_info *in
 static inline struct page *
 shmem_alloc_page(gfp_t gfp,struct shmem_inode_info *info, unsigned long idx)
 {
+	if (gfp & __GFP_HIGHMEM)
+		gfp = (gfp & ~__GFP_HIGHMEM) | __GFP_EASYRCLM;
 	return alloc_page(gfp | __GFP_ZERO);
 }
 #endif
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-clean/mm/swap_state.c linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/swap_state.c
--- linux-2.6.16-rc3-mm1-clean/mm/swap_state.c	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-101_antifrag_flags/mm/swap_state.c	2006-02-17 09:41:14.000000000 +0000
@@ -334,7 +334,7 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_RCLMUSER, vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
