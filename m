Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVI0Sia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVI0Sia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVI0Si3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:38:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51394 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965038AbVI0Si2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:38:28 -0400
Message-ID: <433991A0.7000803@austin.ibm.com>
Date: Tue, 27 Sep 2005 13:38:24 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Dave Hansen <haveblue@us.ibm.com>, mrmacman_g4@mac.com, akpm@osdl.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, kravetz@us.ibm.com
Subject: Re: [PATCH 1/9] add defrag flags
References: <4338537E.8070603@austin.ibm.com>	<43385412.5080506@austin.ibm.com>	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>	<1127780648.10315.12.camel@localhost> <20050926224439.056eaf8d.pj@sgi.com>
In-Reply-To: <20050926224439.056eaf8d.pj@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------060707030501090409030209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707030501090409030209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Looks like he made the same mistake in the actual code comments:
> 
> +/* Allocation type modifiers, group together if possible
> + * __GPF_USER: Allocation for user page or a buffer page
> + * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
> + */
> +#define __GFP_USER	0x40000u /* Kernel page that is easily reclaimable */
> +#define __GFP_KERNRCLM	0x80000u /* User is a userspace user */
> 
> I'd guess you meant to write more like the following:
> 
> #define __GFP_USER   0x40000u /* Page for user address space */
> #define __GFP_KERNRCLM 0x80000u /* Kernel page that is easily reclaimable */

Yep.

> 
> And the block comment seems to needlessly repeat the inline comments,
> add a dubious claim, and omit the interesting stuff ...  In other words:
> 
>     Does it actually matter if these two bits are grouped, or not?  I
>     suspect that some of your other code, such as shifting the gfpmask by
>     RCLM_SHIFT bits, _requires_ that these two bits be adjacent.  So the
>     "if possible" in the comment above is misleading.
> 
>     And I suspect that gfp.h should contain the RCLM_SHIFT define, or
>     at least mention in comment that RCLM_SHIFT depends on the position
>     of the above two __GFP_* bits.

I'll add a comment here.

> 
>     And I don't see any mention in the comments in gfp.h that these
>     two bits, in tandem, have an additional meaning - both bits off
>     means, I guess, not reclaimable, well at least not easily.

Yep, adding comment now.

> 
> My HARDWALL patch appears to already be in Linus's kernel, so you
> probably also need to do a global substitute of all instances in
> the kernel of __GFP_HARDWALL, replacing it with __GFP_USER.  Here
> is the list of files I see affected, with a count of the number of
> __GFP_HARDWALL strings in each:
> 
>     include/linux/gfp.h:4
>     kernel/cpuset.c:6
>     mm/page_alloc.c:2
>     mm/vmscan.c:4

We may not be able to use the same flag after all due to our need to mark buffer 
pages as user.

> 
> The comment in the next line looks like it needs to be changed to match
> the code change:
> 
> +#define __GFP_BITS_SHIFT 21	/* Room for 20 __GFP_FOO bits */

Yep.

> 
> On the other hand, why did you change __GFP_BITS_SHIFT?  Isn't 20
> enough - just enough?

Yep.

Fixed patch attached.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------060707030501090409030209
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
+++ 2.6.13-joel2/include/linux/gfp.h	2005-09-27 12:53:13.%N -0500
@@ -41,6 +41,16 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
 
+/* Allocation type modifiers, these are required to be adjacent
+ * __GPF_USER: Allocation for user page or a buffer page
+ * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
+ * Both bits off: Kernel non-reclaimable or very hard to reclaim
+ * RCLM_SHIFT (defined elsewhere) depends on the location of these bits
+ */
+#define __GFP_USER	0x40000u /* User is a userspace user */
+#define __GFP_KERNRCLM	0x80000u /* Kernel page that is easily reclaimable */
+#define __GFP_RCLM_BITS (__GFP_USER|__GFP_KERNRCLM)
+
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
@@ -48,14 +58,15 @@ struct vm_area_struct;
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

--------------060707030501090409030209--
