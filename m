Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVAEU4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVAEU4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVAEU4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:56:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:588 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262568AbVAEUz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:55:27 -0500
Date: Wed, 5 Jan 2005 20:55:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Steve Longerbeam <stevel@mvista.com>
cc: Ray Bryant <raybry@sgi.com>, Andi Kleen <ak@muc.de>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
In-Reply-To: <41DC34EF.7010507@mvista.com>
Message-ID: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 5 Jan 2005, Steve Longerbeam wrote:
> 
> Note that Andrew had to drop my patch from 2.6.10, because
> the 4-level page tables feature was re-implemented using a
> different interface, which broke my patch. So Andrew asked me
> to re-do the patch for inclusion in 2.6.11. That gives us ~2 months
> to work on integrating the page migration and NUMA mempolicy
> filemap patches.

Something I found odd about your patch was that you had filemap.c
doing NUMA policy one way (via mapping->policy), but left shmem.c
doing NUMA policy another way (via info->policy).  I was preparing
a patch against 2.6.10-rc3-mm1 to clean that up, but got diverted.

Or was I missing a significant distinction?

I seem also to have concluded that destroy_inode ought always to
do the mpol_free_shared_policy itself rather than leaving it to the
filesystem's ->destroy_inode; but offhand can't remember my reasoning
(just to match alloc_inode doing its _init, or a more vital reason?).
Does that make sense to you?

Below is the patch I was working on then (like you I don't have NUMA,
so it was only build tested): would you like to factor it into yours,
or would you prefer me to come along and add it to -mm after yours
has gone in?

I did think your patch would be better split into two (if not more):
the (straightforward) implementation of mapping->policy, and then
the (more complex) page migration business on top of that.

There is more cleanup I'd like to do (or even better, let someone
else do!) in that area: not originating in your patch, but I loathe
the way the vma interface demands construction of a temporary struct
vm_area_struct (pvma) on the stack to get things done - to me that
just indicates the interface is wrong.  The user interface must of
course stay, but should be better handled internally.  Separate job.

(And I still don't know what should be done about NUMA policy versus
swap: it has not been anyone's priority, but swapin_readahead's NUMA
belief that swap is laid out linearly following vmas is quite wrong.
Should page migration be used instead?  Should swap be divided into
per-node extents?  Does swap readahead really serve a useful purpose,
or could we just delete that code?  Should NUMA policy on a file be
determining NUMA policy on private swap copies of that file?  Feel
free to ignore these questions, they're really not on your track;
but I can't glance at that code without wondering, and someone
reading this mail might have better ideas.)

Hugh

--- 2.6.10-rc3-mm1/fs/inode.c	2004-12-14 11:15:38.000000000 +0000
+++ linux/fs/inode.c	2004-12-14 12:02:01.751655096 +0000
@@ -178,12 +178,11 @@ void destroy_inode(struct inode *inode) 
 	if (inode_has_buffers(inode))
 		BUG();
 	security_inode_free(inode);
+	mpol_free_shared_policy(&inode->i_mapping->policy);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
-	else {
-		mpol_free_shared_policy(&inode->i_mapping->policy);
+	else
 		kmem_cache_free(inode_cachep, (inode));
-	}
 }
 EXPORT_SYMBOL(destroy_inode);
 
--- 2.6.10-rc3-mm1/include/linux/mempolicy.h	2004-12-14 11:15:39.000000000 +0000
+++ linux/include/linux/mempolicy.h	2004-12-14 12:02:01.784650080 +0000
@@ -156,6 +156,9 @@ struct page *alloc_page_shared_policy(un
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 
+int generic_file_set_policy(struct vm_area_struct *, struct mempolicy *);
+struct mempolicy *generic_file_get_policy(struct vm_area_struct *, unsigned long);
+
 #else
 
 struct mempolicy {};
--- 2.6.10-rc3-mm1/include/linux/mm.h	2004-12-14 11:15:39.000000000 +0000
+++ linux/include/linux/mm.h	2004-12-14 12:02:01.834642480 +0000
@@ -555,15 +555,10 @@ extern void show_free_areas(void);
 #ifdef CONFIG_SHMEM
 struct page *shmem_nopage(struct vm_area_struct *vma,
 			unsigned long address, int *type);
-int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
-struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
-					unsigned long addr);
 int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #else
 #define shmem_nopage filemap_nopage
 #define shmem_lock(a, b, c) 	({0;})	/* always in memory, no need to lock */
-#define shmem_set_policy(a, b)	(0)
-#define shmem_get_policy(a, b)	(NULL)
 #endif
 struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags);
 
--- 2.6.10-rc3-mm1/include/linux/shmem_fs.h	2004-10-18 22:56:50.000000000 +0100
+++ linux/include/linux/shmem_fs.h	2004-12-14 12:02:01.835642328 +0000
@@ -14,7 +14,6 @@ struct shmem_inode_info {
 	unsigned long		alloced;	/* data pages alloced to file */
 	unsigned long		swapped;	/* subtotal assigned to swap */
 	unsigned long		next_index;	/* highest alloced index + 1 */
-	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct page		*i_indirect;	/* top indirect blocks page */
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* first blocks */
 	struct list_head	swaplist;	/* chain of maybes on swap */
--- 2.6.10-rc3-mm1/ipc/shm.c	2004-12-14 11:15:39.000000000 +0000
+++ linux/ipc/shm.c	2004-12-14 12:02:01.885634728 +0000
@@ -168,8 +168,8 @@ static struct vm_operations_struct shm_v
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.nopage	= shmem_nopage,
 #ifdef CONFIG_NUMA
-	.set_policy = shmem_set_policy,
-	.get_policy = shmem_get_policy,
+	.set_policy = generic_file_set_policy,
+	.get_policy = generic_file_get_policy,
 #endif
 };
 
--- 2.6.10-rc3-mm1/mm/shmem.c	2004-12-14 11:15:40.000000000 +0000
+++ linux/mm/shmem.c	2004-12-14 12:02:01.930627888 +0000
@@ -879,10 +879,10 @@ static struct page *shmem_swapin_async(s
 	return page;
 }
 
-struct page *shmem_swapin(struct shmem_inode_info *info, swp_entry_t entry,
-			  unsigned long idx)
+struct page *shmem_swapin(struct address_space *mapping,
+			swp_entry_t entry, unsigned long idx)
 {
-	struct shared_policy *p = &info->policy;
+	struct shared_policy *p = &mapping->policy;
 	int i, num;
 	struct page *page;
 	unsigned long offset;
@@ -898,27 +898,13 @@ struct page *shmem_swapin(struct shmem_i
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 	return shmem_swapin_async(p, entry, idx);
 }
-
-static struct page *
-shmem_alloc_page(unsigned long gfp, struct shmem_inode_info *info,
-		 unsigned long idx)
-{
-	return alloc_page_shared_policy(gfp, &info->policy, idx);
-}
 #else
-static inline struct page *
-shmem_swapin(struct shmem_inode_info *info,swp_entry_t entry,unsigned long idx)
+static inline struct page *shmem_swapin(struct address_space *mapping,
+			swp_entry_t entry, unsigned long idx)
 {
 	swapin_readahead(entry, 0, NULL);
 	return read_swap_cache_async(entry, NULL, 0);
 }
-
-static inline struct page *
-shmem_alloc_page(unsigned long gfp,struct shmem_inode_info *info,
-				 unsigned long idx)
-{
-	return alloc_page(gfp);
-}
 #endif
 
 /*
@@ -980,7 +966,7 @@ repeat:
 				inc_page_state(pgmajfault);
 				*type = VM_FAULT_MAJOR;
 			}
-			swappage = shmem_swapin(info, swap, idx);
+			swappage = shmem_swapin(mapping, swap, idx);
 			if (!swappage) {
 				spin_lock(&info->lock);
 				entry = shmem_swp_alloc(info, idx, sgp);
@@ -1092,9 +1078,7 @@ repeat:
 
 		if (!filepage) {
 			spin_unlock(&info->lock);
-			filepage = shmem_alloc_page(mapping_gfp_mask(mapping),
-						    info,
-						    idx);
+			filepage = page_cache_alloc(mapping, idx);
 			if (!filepage) {
 				shmem_unacct_blocks(info->flags, 1);
 				shmem_free_blocks(inode, 1);
@@ -1206,24 +1190,6 @@ static int shmem_populate(struct vm_area
 	return 0;
 }
 
-#ifdef CONFIG_NUMA
-int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
-{
-	struct inode *i = vma->vm_file->f_dentry->d_inode;
-	return mpol_set_shared_policy(&SHMEM_I(i)->policy, vma, new);
-}
-
-struct mempolicy *
-shmem_get_policy(struct vm_area_struct *vma, unsigned long addr)
-{
-	struct inode *i = vma->vm_file->f_dentry->d_inode;
-	unsigned long idx;
-
-	idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-	return mpol_shared_policy_lookup(&SHMEM_I(i)->policy, idx);
-}
-#endif
-
 int shmem_lock(struct file *file, int lock, struct user_struct *user)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -1293,7 +1259,6 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
-			mpol_shared_policy_init(&info->policy);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1303,11 +1268,6 @@ shmem_get_inode(struct super_block *sb, 
 			inode->i_fop = &simple_dir_operations;
 			break;
 		case S_IFLNK:
-			/*
-			 * Must not load anything in the rbtree,
-			 * mpol_free_shared_policy will not be called.
-			 */
-			mpol_shared_policy_init(&info->policy);
 			break;
 		}
 	} else if (sbinfo) {
@@ -2026,10 +1986,6 @@ static struct inode *shmem_alloc_inode(s
 
 static void shmem_destroy_inode(struct inode *inode)
 {
-	if ((inode->i_mode & S_IFMT) == S_IFREG) {
-		/* only struct inode is valid if it's an inline symlink */
-		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
-	}
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
@@ -2135,8 +2091,8 @@ static struct vm_operations_struct shmem
 	.nopage		= shmem_nopage,
 	.populate	= shmem_populate,
 #ifdef CONFIG_NUMA
-	.set_policy     = shmem_set_policy,
-	.get_policy     = shmem_get_policy,
+	.set_policy     = generic_file_set_policy,
+	.get_policy     = generic_file_get_policy,
 #endif
 };
 

