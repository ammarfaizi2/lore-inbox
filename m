Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbUDFNnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUDFNm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:42:57 -0400
Received: from ns.suse.de ([195.135.220.2]:34208 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263822AbUDFNko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:40:44 -0400
Date: Tue, 6 Apr 2004 15:37:47 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 6/ Add shared memory support
Message-Id: <20040406153747.4d8a5e68.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to tmpfs and hugetlbfs to support NUMA API. Shared memory 
is a bit of a special case for NUMA policy. Normally policy is associated
to VMAs or to processes, but for a shared memory segment you really 
want to share the policy. The core NUMA API has code for that,
this patch adds the necessary changes to tmpfs and hugetlbfs.

First it changes the custom swapping code in tmpfs to follow the policy
set via VMAs.

It is also useful to have a "backing store" of policy that saves
the policy even when nobody has the shared memory segment mapped. This
allows command line tools to pre configure policy, which is then 
later used by programs.

Note that hugetlbfs needs more changes - it is also required to switch
it to lazy allocation, otherwise the prefault prevents mbind() from 
working.

diff -u linux-2.6.5-numa/fs/hugetlbfs/inode.c-o linux-2.6.5-numa/fs/hugetlbfs/inode.c
--- linux-2.6.5-numa/fs/hugetlbfs/inode.c-o	2004-04-06 13:12:17.000000000 +0200
+++ linux-2.6.5-numa/fs/hugetlbfs/inode.c	2004-04-06 13:36:12.000000000 +0200
@@ -375,6 +375,7 @@
 
 	inode = new_inode(sb);
 	if (inode) {
+		struct hugetlbfs_inode_info *info;
 		inode->i_mode = mode;
 		inode->i_uid = uid;
 		inode->i_gid = gid;
@@ -383,6 +384,8 @@
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		info = HUGETLBFS_I(inode);
+		mpol_shared_policy_init(&info->policy);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -510,6 +513,32 @@
 	}
 }
 
+static kmem_cache_t *hugetlbfs_inode_cachep;
+
+static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
+{
+	struct hugetlbfs_inode_info *p = kmem_cache_alloc(hugetlbfs_inode_cachep,
+							  SLAB_KERNEL);
+	if (!p)
+		return NULL;
+	return &p->vfs_inode;
+}
+
+static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct hugetlbfs_inode_info *ei = (struct hugetlbfs_inode_info *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&ei->vfs_inode);
+}
+
+static void hugetlbfs_destroy_inode(struct inode *inode)
+{
+	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);  
+	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
+}
+
 static struct address_space_operations hugetlbfs_aops = {
 	.readpage	= hugetlbfs_readpage,
 	.prepare_write	= hugetlbfs_prepare_write,
@@ -541,6 +570,8 @@
 };
 
 static struct super_operations hugetlbfs_ops = {
+	.alloc_inode    = hugetlbfs_alloc_inode,
+	.destroy_inode  = hugetlbfs_destroy_inode,
 	.statfs		= hugetlbfs_statfs,
 	.drop_inode	= hugetlbfs_drop_inode,
 	.put_super	= hugetlbfs_put_super,
@@ -755,9 +786,16 @@
 	int error;
 	struct vfsmount *vfsmount;
 
+	hugetlbfs_inode_cachep = kmem_cache_create("hugetlbfs_inode_cache",
+				     sizeof(struct hugetlbfs_inode_info),
+				     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				     init_once, NULL);
+	if (hugetlbfs_inode_cachep == NULL)
+		return -ENOMEM;
+
 	error = register_filesystem(&hugetlbfs_fs_type);
 	if (error)
-		return error;
+		goto out;
 
 	vfsmount = kern_mount(&hugetlbfs_fs_type);
 
@@ -767,11 +805,16 @@
 	}
 
 	error = PTR_ERR(vfsmount);
+
+ out:
+	if (error)
+		kmem_cache_destroy(hugetlbfs_inode_cachep);		
 	return error;
 }
 
 static void __exit exit_hugetlbfs_fs(void)
 {
+	kmem_cache_destroy(hugetlbfs_inode_cachep);
 	unregister_filesystem(&hugetlbfs_fs_type);
 }
 
diff -u linux-2.6.5-numa/include/linux/mm.h-o linux-2.6.5-numa/include/linux/mm.h
--- linux-2.6.5-numa/include/linux/mm.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux-2.6.5-numa/include/linux/mm.h	2004-04-06 13:36:12.000000000 +0200
@@ -435,6 +445,8 @@
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
 			unsigned long address, int *type);
+int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
+struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
diff -u linux-2.6.5-numa/include/linux/shmem_fs.h-o linux-2.6.5-numa/include/linux/shmem_fs.h
--- linux-2.6.5-numa/include/linux/shmem_fs.h-o	2004-03-21 21:11:55.000000000 +0100
+++ linux-2.6.5-numa/include/linux/shmem_fs.h	2004-04-06 13:36:12.000000000 +0200
@@ -2,6 +2,7 @@
 #define __SHMEM_FS_H
 
 #include <linux/swap.h>
+#include <linux/mempolicy.h>
 
 /* inode in-kernel data */
 
@@ -15,6 +16,7 @@
 	unsigned long		alloced;    /* data pages allocated to file */
 	unsigned long		swapped;    /* subtotal assigned to swap */
 	unsigned long		flags;
+	struct shared_policy     policy;
 	struct list_head	list;
 	struct inode		vfs_inode;
 };
diff -u linux-2.6.5-numa/ipc/shm.c-o linux-2.6.5-numa/ipc/shm.c
--- linux-2.6.5-numa/ipc/shm.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/ipc/shm.c	2004-04-06 13:36:12.000000000 +0200
@@ -163,6 +163,8 @@
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.nopage	= shmem_nopage,
+	.set_policy = shmem_set_policy,
+	.get_policy = shmem_get_policy,
 };
 
 static int newseg (key_t key, int shmflg, size_t size)
diff -u linux-2.6.5-numa/mm/shmem.c-o linux-2.6.5-numa/mm/shmem.c
--- linux-2.6.5-numa/mm/shmem.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/shmem.c	2004-04-06 13:36:12.000000000 +0200
@@ -8,6 +8,7 @@
  *		 2002 Red Hat Inc.
  * Copyright (C) 2002-2003 Hugh Dickins.
  * Copyright (C) 2002-2003 VERITAS Software Corporation.
+ * Copyright (C) 2004 Andi Kleen, SuSE Labs
  *
  * This file is released under the GPL.
  */
@@ -37,8 +38,10 @@
 #include <linux/vfs.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/swapops.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
+#include <asm/pgtable.h>
 
 /* This magic number is used in glibc for posix shared memory */
 #define TMPFS_MAGIC	0x01021994
@@ -758,6 +761,72 @@
 	return WRITEPAGE_ACTIVATE;	/* Return with the page locked */
 }
 
+#ifdef CONFIG_NUMA
+static struct page *shmem_swapin_async(struct shared_policy *p,
+				       swp_entry_t entry, unsigned long idx)
+{
+	struct page *page;
+	struct vm_area_struct pvma; 
+	/* Create a pseudo vma that just contains the policy */
+	memset(&pvma, 0, sizeof(struct vm_area_struct));
+	pvma.vm_end = PAGE_SIZE;
+	pvma.vm_pgoff = idx;
+	pvma.vm_policy = mpol_shared_policy_lookup(p, idx); 
+	page = read_swap_cache_async(entry, &pvma, 0);
+	mpol_free(pvma.vm_policy);
+	return page; 
+} 
+
+struct page *shmem_swapin(struct shmem_inode_info *info, swp_entry_t entry, 
+			  unsigned long idx)
+{
+	struct shared_policy *p = &info->policy;
+	int i, num;
+	struct page *page;
+	unsigned long offset;
+
+	num = valid_swaphandles(entry, &offset);
+	for (i = 0; i < num; offset++, i++) {
+		page = shmem_swapin_async(p, swp_entry(swp_type(entry), offset), idx);
+		if (!page)
+			break;
+		page_cache_release(page);
+	}
+	lru_add_drain();	/* Push any new pages onto the LRU now */
+	return shmem_swapin_async(p, entry, idx); 
+}
+
+static struct page *
+shmem_alloc_page(unsigned long gfp, struct shmem_inode_info *info, 
+		 unsigned long idx)
+{
+	struct vm_area_struct pvma;
+	struct page *page;
+
+	memset(&pvma, 0, sizeof(struct vm_area_struct)); 
+	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx); 
+	pvma.vm_pgoff = idx;
+	pvma.vm_end = PAGE_SIZE;
+	page = alloc_page_vma(gfp, &pvma, 0); 
+	mpol_free(pvma.vm_policy);
+	return page; 
+} 
+#else
+static inline struct page *
+shmem_swapin(struct shmem_inode_info *info,swp_entry_t entry,unsigned long idx)
+{ 
+	swapin_readahead(entry, 0, NULL);
+	return read_swap_cache_async(entry, NULL, 0);
+} 
+
+static inline struct page *
+shmem_alloc_page(unsigned long gfp,struct shmem_inode_info *info,
+				 unsigned long idx)
+{
+	return alloc_page(gfp);  
+}
+#endif
+
 /*
  * shmem_getpage - either get the page from swap or allocate a new one
  *
@@ -815,8 +884,7 @@
 			if (majmin == VM_FAULT_MINOR && type)
 				inc_page_state(pgmajfault);
 			majmin = VM_FAULT_MAJOR;
-			swapin_readahead(swap);
-			swappage = read_swap_cache_async(swap);
+			swappage = shmem_swapin(info, swap, idx); 
 			if (!swappage) {
 				spin_lock(&info->lock);
 				entry = shmem_swp_alloc(info, idx, sgp);
@@ -921,7 +989,9 @@
 
 		if (!filepage) {
 			spin_unlock(&info->lock);
-			filepage = page_cache_alloc(mapping);
+			filepage = shmem_alloc_page(mapping_gfp_mask(mapping), 
+						    info,
+						    idx); 
 			if (!filepage) {
 				shmem_free_block(inode);
 				error = -ENOMEM;
@@ -1046,6 +1116,19 @@
 	return 0;
 }
 
+int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
+{
+	struct inode *i = vma->vm_file->f_dentry->d_inode;
+	return mpol_set_shared_policy(&SHMEM_I(i)->policy, vma, new);
+}
+
+struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct inode *i = vma->vm_file->f_dentry->d_inode;
+	unsigned long idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	return mpol_shared_policy_lookup(&SHMEM_I(i)->policy, idx);	
+} 
+
 void shmem_lock(struct file *file, int lock)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -1094,6 +1177,7 @@
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
+		mpol_shared_policy_init(&info->policy);
 		info->flags = VM_ACCOUNT;
 		switch (mode & S_IFMT) {
 		default:
@@ -1789,6 +1873,7 @@
 
 static void shmem_destroy_inode(struct inode *inode)
 {
+	mpol_free_shared_policy(&SHMEM_I(inode)->policy);  
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
@@ -1873,6 +1958,8 @@
 static struct vm_operations_struct shmem_vm_ops = {
 	.nopage		= shmem_nopage,
 	.populate	= shmem_populate,
+	.set_policy     = shmem_set_policy,
+	.get_policy     = shmem_get_policy,
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
diff -u linux-2.6.5-numa/include/linux/hugetlb.h-o linux-2.6.5-numa/include/linux/hugetlb.h
--- linux-2.6.5-numa/include/linux/hugetlb.h-o	2004-04-06 13:12:21.000000000 +0200
+++ linux-2.6.5-numa/include/linux/hugetlb.h	2004-04-06 13:36:12.000000000 +0200
@@ -3,6 +3,8 @@
 
 #ifdef CONFIG_HUGETLB_PAGE
 
+#include <linux/mempolicy.h>
+
 struct ctl_table;
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
@@ -103,6 +105,17 @@
 	spinlock_t	stat_lock;
 };
 
+
+struct hugetlbfs_inode_info { 
+	struct shared_policy policy;
+	struct inode vfs_inode;
+}; 
+
+static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
+{
+	return container_of(inode, struct hugetlbfs_inode_info, vfs_inode);
+}
+
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
diff -u linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c-o linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c-o	2004-04-06 13:11:59.000000000 +0200
+++ linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c	2004-04-06 13:36:12.000000000 +0200
@@ -547,6 +640,13 @@
 	return NULL;
 }
 
+static int hugetlb_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	return mpol_set_shared_policy(&HUGETLBFS_I(inode)->policy, vma, new);
+}
+
 struct vm_operations_struct hugetlb_vm_ops = {
 	.nopage = hugetlb_nopage,
+	.set_policy = hugetlb_set_policy,	
 };
