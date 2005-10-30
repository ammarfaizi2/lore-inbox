Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVJ3SeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVJ3SeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJ3SeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:34:11 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40363 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932200AbVJ3SeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:34:09 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Message-Id: <20051030183359.22266.52500.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 1/7] Fragmentation Avoidance V19: 001_antidefrag_flags
Date: Sun, 30 Oct 2005 18:34:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two flags __GFP_EASYRCLM and __GFP_KERNRCLM that are used
to trap the type of allocation the caller is made. Allocations using
the __GFP_EASYRCLM flag are expected to be easily reclaimed by syncing
with backing storage (be it a file or swap) or cleaning the buffers and
discarding. Allocations using the __GFP_KERNRCLM flag belong to slab caches
that can be shrunk by the kernel.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/buffer.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/buffer.c
--- linux-2.6.14-rc5-mm1-clean/fs/buffer.c	2005-10-30 13:19:59.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/buffer.c	2005-10-30 13:34:50.000000000 +0000
@@ -1119,7 +1119,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS|__GFP_EASYRCLM);
 	if (!page)
 		return NULL;
 
@@ -3058,7 +3059,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+						   gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/compat.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/compat.c
--- linux-2.6.14-rc5-mm1-clean/fs/compat.c	2005-10-30 13:19:59.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/compat.c	2005-10-30 13:34:50.000000000 +0000
@@ -1363,7 +1363,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_EASYRCLM);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/dcache.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/dcache.c
--- linux-2.6.14-rc5-mm1-clean/fs/dcache.c	2005-10-30 13:19:59.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/dcache.c	2005-10-30 13:34:50.000000000 +0000
@@ -878,7 +878,7 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL|__GFP_KERNRCLM);
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/exec.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/exec.c
--- linux-2.6.14-rc5-mm1-clean/fs/exec.c	2005-10-30 13:19:59.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/exec.c	2005-10-30 13:34:50.000000000 +0000
@@ -237,7 +237,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER|__GFP_EASYRCLM);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/ext2/super.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ext2/super.c
--- linux-2.6.14-rc5-mm1-clean/fs/ext2/super.c	2005-10-20 07:23:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ext2/super.c	2005-10-30 13:34:50.000000000 +0000
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/ext3/super.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ext3/super.c
--- linux-2.6.14-rc5-mm1-clean/fs/ext3/super.c	2005-10-30 13:20:00.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ext3/super.c	2005-10-30 13:34:50.000000000 +0000
@@ -444,7 +444,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/inode.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/inode.c
--- linux-2.6.14-rc5-mm1-clean/fs/inode.c	2005-10-20 07:23:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/inode.c	2005-10-30 13:34:50.000000000 +0000
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGHUSER|__GFP_EASYRCLM);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/fs/ntfs/inode.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ntfs/inode.c
--- linux-2.6.14-rc5-mm1-clean/fs/ntfs/inode.c	2005-10-30 13:20:01.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/fs/ntfs/inode.c	2005-10-30 13:34:50.000000000 +0000
@@ -318,7 +318,7 @@ struct inode *ntfs_alloc_big_inode(struc
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -343,7 +343,7 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS|__GFP_KERNRCLM);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/include/asm-i386/page.h linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/asm-i386/page.h
--- linux-2.6.14-rc5-mm1-clean/include/asm-i386/page.h	2005-10-20 07:23:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/asm-i386/page.h	2005-10-30 13:34:50.000000000 +0000
@@ -36,7 +36,8 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) \
+	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | __GFP_EASYRCLM, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/include/linux/gfp.h linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/gfp.h
--- linux-2.6.14-rc5-mm1-clean/include/linux/gfp.h	2005-10-30 13:20:05.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/gfp.h	2005-10-30 13:34:50.000000000 +0000
@@ -50,14 +50,27 @@ struct vm_area_struct;
 #define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
 #define __GFP_VALID	0x80000000u /* valid GFP flags */
 
-#define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
+/*
+ * Allocation type modifiers, these are required to be adjacent
+ * __GFP_EASYRCLM: Easily reclaimed pages like userspace or buffer pages
+ * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
+ * Both bits off: Kernel non-reclaimable or very hard to reclaim
+ * __GFP_EASYRCLM and __GFP_KERNRCLM should not be specified at the same time
+ * RCLM_SHIFT (defined elsewhere) depends on the location of these bits
+ */
+#define __GFP_EASYRCLM   0x80000u  /* User and other easily reclaimed pages */
+#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */
+#define __GFP_RCLM_BITS  (__GFP_EASYRCLM|__GFP_KERNRCLM)
+
+#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL| \
+			__GFP_EASYRCLM|__GFP_KERNRCLM)
 
 #define GFP_ATOMIC	(__GFP_VALID | __GFP_HIGH)
 #define GFP_NOIO	(__GFP_VALID | __GFP_WAIT)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/include/linux/highmem.h linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/highmem.h
--- linux-2.6.14-rc5-mm1-clean/include/linux/highmem.h	2005-10-20 07:23:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/highmem.h	2005-10-30 13:34:50.000000000 +0000
@@ -47,7 +47,8 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/mm/memory.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/memory.c
--- linux-2.6.14-rc5-mm1-clean/mm/memory.c	2005-10-30 13:20:06.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/memory.c	2005-10-30 13:34:50.000000000 +0000
@@ -1295,7 +1295,8 @@ static int do_wp_page(struct mm_struct *
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, address);
 		if (!new_page)
 			goto oom;
 		copy_user_highpage(new_page, old_page, address);
@@ -1858,7 +1859,8 @@ retry:
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		page = alloc_page_vma(GFP_HIGHUSER|__GFP_EASYRCLM,
+							vma, address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/mm/shmem.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/shmem.c
--- linux-2.6.14-rc5-mm1-clean/mm/shmem.c	2005-10-30 13:20:06.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/shmem.c	2005-10-30 13:34:50.000000000 +0000
@@ -906,7 +906,7 @@ shmem_alloc_page(unsigned long gfp, stru
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
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-clean/mm/swap_state.c linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/swap_state.c
--- linux-2.6.14-rc5-mm1-clean/mm/swap_state.c	2005-10-30 13:20:06.000000000 +0000
+++ linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/swap_state.c	2005-10-30 13:34:50.000000000 +0000
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
