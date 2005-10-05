Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVJEOp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVJEOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVJEOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:45:59 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:54926 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932636AbVJEOp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:45:58 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144552.11796.52857.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 1/7] Fragmentation Avoidance V16: 001_antidefrag_flags
Date: Wed,  5 Oct 2005 15:45:52 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two flags __GFP_USER and __GFP_KERNRCLM that are used to trap
the type of allocation the caller is made. Allocations using the __GFP_USER
flag are expected to be easily reclaimed by syncing with backing storage (be
it a file or swap) or cleaning the buffers and discarding. Allocations using
the __GFP_KERNRCLM flag belong to slab caches that can be shrunk by the kernel.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/buffer.c linux-2.6.14-rc3-001_antidefrag_flags/fs/buffer.c
--- linux-2.6.14-rc3-clean/fs/buffer.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/buffer.c	2005-10-05 12:13:19.000000000 +0100
@@ -1119,7 +1119,12 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	/*
+	 * Mark as __GFP_USER because from a fragmentation avoidance and
+	 * reclamation point of view this memory behaves like user memory.
+	 */
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS | __GFP_USER);
 	if (!page)
 		return NULL;
 
@@ -3047,7 +3052,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(unsigned int __nocast gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+						   gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/compat.c linux-2.6.14-rc3-001_antidefrag_flags/fs/compat.c
--- linux-2.6.14-rc3-clean/fs/compat.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/compat.c	2005-10-05 12:13:19.000000000 +0100
@@ -1352,7 +1352,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_USER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/dcache.c linux-2.6.14-rc3-001_antidefrag_flags/fs/dcache.c
--- linux-2.6.14-rc3-clean/fs/dcache.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/dcache.c	2005-10-05 12:13:19.000000000 +0100
@@ -714,7 +714,7 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL|__GFP_KERNRCLM);
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/exec.c linux-2.6.14-rc3-001_antidefrag_flags/fs/exec.c
--- linux-2.6.14-rc3-clean/fs/exec.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/exec.c	2005-10-05 12:13:19.000000000 +0100
@@ -237,7 +237,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_USER);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/ext2/super.c linux-2.6.14-rc3-001_antidefrag_flags/fs/ext2/super.c
--- linux-2.6.14-rc3-clean/fs/ext2/super.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/ext2/super.c	2005-10-05 12:13:19.000000000 +0100
@@ -141,7 +141,8 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep,
+						SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/ext3/super.c linux-2.6.14-rc3-001_antidefrag_flags/fs/ext3/super.c
--- linux-2.6.14-rc3-clean/fs/ext3/super.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/ext3/super.c	2005-10-05 12:13:19.000000000 +0100
@@ -441,7 +441,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/inode.c linux-2.6.14-rc3-001_antidefrag_flags/fs/inode.c
--- linux-2.6.14-rc3-clean/fs/inode.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/inode.c	2005-10-05 12:13:19.000000000 +0100
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGHUSER|__GFP_USER);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/fs/ntfs/inode.c linux-2.6.14-rc3-001_antidefrag_flags/fs/ntfs/inode.c
--- linux-2.6.14-rc3-clean/fs/ntfs/inode.c	2005-10-04 22:58:33.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/fs/ntfs/inode.c	2005-10-05 12:13:19.000000000 +0100
@@ -317,7 +317,7 @@ struct inode *ntfs_alloc_big_inode(struc
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -342,7 +342,7 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/include/asm-i386/page.h linux-2.6.14-rc3-001_antidefrag_flags/include/asm-i386/page.h
--- linux-2.6.14-rc3-clean/include/asm-i386/page.h	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/include/asm-i386/page.h	2005-10-05 12:13:19.000000000 +0100
@@ -36,7 +36,7 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | __GFP_USER, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/include/linux/gfp.h linux-2.6.14-rc3-001_antidefrag_flags/include/linux/gfp.h
--- linux-2.6.14-rc3-clean/include/linux/gfp.h	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/include/linux/gfp.h	2005-10-05 12:13:19.000000000 +0100
@@ -42,14 +42,20 @@ struct vm_area_struct;
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
 #define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
 
-#define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
+/* Allocation type modifiers, group together if possible */
+#define __GFP_USER       0x80000u  /* User and other easily reclaimed pages */
+#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */
+#define __GFP_RCLM_BITS  (__GFP_USER|__GFP_KERNRCLM)
+
+#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL | \
+			__GFP_USER | __GFP_KERNRCLM)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/include/linux/highmem.h linux-2.6.14-rc3-001_antidefrag_flags/include/linux/highmem.h
--- linux-2.6.14-rc3-clean/include/linux/highmem.h	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/include/linux/highmem.h	2005-10-05 12:13:19.000000000 +0100
@@ -47,7 +47,7 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_HIGHUSER|__GFP_USER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/mm/memory.c linux-2.6.14-rc3-001_antidefrag_flags/mm/memory.c
--- linux-2.6.14-rc3-clean/mm/memory.c	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/mm/memory.c	2005-10-05 12:13:19.000000000 +0100
@@ -1296,7 +1296,8 @@ static int do_wp_page(struct mm_struct *
 		if (!new_page)
 			goto no_new_page;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_USER,
+							vma, address);
 		if (!new_page)
 			goto no_new_page;
 		copy_user_highpage(new_page, old_page, address);
@@ -1871,7 +1872,7 @@ retry:
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		page = alloc_page_vma(GFP_HIGHUSER | __GFP_USER, vma, address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/mm/shmem.c linux-2.6.14-rc3-001_antidefrag_flags/mm/shmem.c
--- linux-2.6.14-rc3-clean/mm/shmem.c	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/mm/shmem.c	2005-10-05 12:13:19.000000000 +0100
@@ -908,7 +908,7 @@ shmem_alloc_page(unsigned long gfp, stru
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
+	page = alloc_page_vma(gfp | __GFP_ZERO | __GFP_USER, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -924,7 +924,7 @@ static inline struct page *
 shmem_alloc_page(unsigned int __nocast gfp,struct shmem_inode_info *info,
 				 unsigned long idx)
 {
-	return alloc_page(gfp | __GFP_ZERO);
+	return alloc_page(gfp | __GFP_ZERO | __GFP_USER);
 }
 #endif
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-clean/mm/swap_state.c linux-2.6.14-rc3-001_antidefrag_flags/mm/swap_state.c
--- linux-2.6.14-rc3-clean/mm/swap_state.c	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-001_antidefrag_flags/mm/swap_state.c	2005-10-05 12:13:19.000000000 +0100
@@ -335,7 +335,8 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_HIGHUSER | __GFP_USER,
+							vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
