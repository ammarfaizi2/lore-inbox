Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVIZUK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVIZUK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIZUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:10:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:49355 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932495AbVIZUKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:10:23 -0400
Message-ID: <43385412.5080506@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:03:30 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 1/9] add defrag flags
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060207000900010809020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207000900010809020004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds 2 new GFP flags to correspond to the 3 allocation types.  The
third state is indicated by neither flag corresponding to the first two states
being set. It then modifies appropriate allocator calls to use these new flags.
The flags are:
__GFP_USER, which corresponds to easily reclaimable pages
__GFP_KERNRCLM, which corresponds to userspace pages

Also note that the __GFP_USER flag should be reusable by the HARDWALL folks as
well.

This patch was originally authored by Mel Gorman, and heavily modified by me.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------060207000900010809020004
Content-Type: text/plain;
 name="1_add_defrag_flags"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1_add_defrag_flags"

Index: 2.6.13-joel2/fs/buffer.c
===================================================================
--- 2.6.13-joel2.orig/fs/buffer.c	2005-09-13 14:54:13.%N -0500
+++ 2.6.13-joel2/fs/buffer.c	2005-09-13 15:02:01.%N -0500
@@ -1119,7 +1119,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS | __GFP_USER);
 	if (!page)
 		return NULL;
 
@@ -3044,7 +3045,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(unsigned int __nocast gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+						   gfp_flags|__GFP_KERNRCLM);
 	if (ret) {
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
Index: 2.6.13-joel2/fs/dcache.c
===================================================================
--- 2.6.13-joel2.orig/fs/dcache.c	2005-09-13 14:54:14.%N -0500
+++ 2.6.13-joel2/fs/dcache.c	2005-09-13 15:02:01.%N -0500
@@ -721,7 +721,7 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL|__GFP_KERNRCLM);
 	if (!dentry)
 		return NULL;
 
Index: 2.6.13-joel2/fs/ext2/super.c
===================================================================
--- 2.6.13-joel2.orig/fs/ext2/super.c	2005-09-13 14:54:14.%N -0500
+++ 2.6.13-joel2/fs/ext2/super.c	2005-09-13 15:02:01.%N -0500
@@ -138,7 +138,8 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep,
+						SLAB_KERNEL|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
Index: 2.6.13-joel2/fs/ext3/super.c
===================================================================
--- 2.6.13-joel2.orig/fs/ext3/super.c	2005-09-13 14:54:14.%N -0500
+++ 2.6.13-joel2/fs/ext3/super.c	2005-09-13 15:02:01.%N -0500
@@ -440,7 +440,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_KERNRCLM);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
Index: 2.6.13-joel2/fs/ntfs/inode.c
===================================================================
--- 2.6.13-joel2.orig/fs/ntfs/inode.c	2005-09-13 14:54:14.%N -0500
+++ 2.6.13-joel2/fs/ntfs/inode.c	2005-09-13 15:05:53.%N -0500
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
Index: 2.6.13-joel2/include/linux/gfp.h
===================================================================
--- 2.6.13-joel2.orig/include/linux/gfp.h	2005-09-13 14:54:17.%N -0500
+++ 2.6.13-joel2/include/linux/gfp.h	2005-09-13 15:02:01.%N -0500
@@ -41,21 +41,30 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
 
-#define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
+/* Allocation type modifiers, group together if possible
+ * __GPF_USER: Allocation for user page or a buffer page
+ * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
+ */
+#define __GFP_USER	0x40000u /* Kernel page that is easily reclaimable */
+#define __GFP_KERNRCLM	0x80000u /* User is a userspace user */
+#define __GFP_RCLM_BITS (__GFP_USER|__GFP_KERNRCLM)
+
+#define __GFP_BITS_SHIFT 21	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM)
+			__GFP_NOMEMALLOC|__GFP_KERNRCLM|__GFP_USER)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_USER)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | \
+			 __GFP_USER)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */

--------------060207000900010809020004--
