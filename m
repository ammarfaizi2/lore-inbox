Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264967AbRFUN4u>; Thu, 21 Jun 2001 09:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbRFUN4l>; Thu, 21 Jun 2001 09:56:41 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:25321 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S264967AbRFUN42>; Thu, 21 Jun 2001 09:56:28 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs fixes against 2.4.6-pre
Organisation: SAP LinuxLab
Date: 21 Jun 2001 15:54:36 +0200
Message-ID: <m3k826q6oz.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch fixes several tmpfs problems:

1) writing out of a mapping of a tmpfs file into the same file can
   deadlock
2) shmem_remount_fs garbles parameters which are not supplied
3) shmem_file_setup should check the maximum size

Please apply
		Christoph

diff -uNr 6-pre5/include/linux/shmem_fs.h 6-pre5-fix/include/linux/shmem_fs.h
--- 6-pre5/include/linux/shmem_fs.h	Sun Apr 29 20:33:00 2001
+++ 6-pre5-fix/include/linux/shmem_fs.h	Thu Jun 21 15:52:25 2001
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	struct semaphore sem;
 	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
diff -uNr 6-pre5/mm/shmem.c 6-pre5-fix/mm/shmem.c
--- 6-pre5/mm/shmem.c	Tue Jun 12 09:49:28 2001
+++ 6-pre5-fix/mm/shmem.c	Thu Jun 21 15:52:26 2001
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
- *		 2000 Christoph Rohland
+ *		 2000-2001 Christoph Rohland
+ *		 2000-2001 SAP AG
  * 
  * This file is released under the GPL.
  */
@@ -33,7 +34,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
-#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -161,6 +162,7 @@
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
+	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -193,10 +195,14 @@
 	}
 
 out:
-	info->max_index = index;
+	if (index <= SHMEM_MAX_BLOCKS)
+		info->max_index = index;
+	else
+		info->max_index = SHMEM_MAX_BLOCKS + 1;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
+	up(&info->sem);
 }
 
 static void shmem_delete_inode(struct inode * inode)
@@ -281,15 +287,12 @@
  * still need to guard against racing with shm_writepage(), which might
  * be trying to move the page to the swap cache as we run.
  */
-static struct page * shmem_getpage_locked(struct inode * inode, unsigned long idx)
+static struct page * shmem_getpage_locked(struct shmem_inode_info *info, struct inode * inode, unsigned long idx)
 {
 	struct address_space * mapping = inode->i_mapping;
-	struct shmem_inode_info *info;
 	struct page * page;
 	swp_entry_t *entry;
 
-	info = &inode->u.shmem_i;
-
 repeat:
 	page = find_lock_page(mapping, idx);
 	if (page)
@@ -393,6 +396,7 @@
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
 {
+	struct shmem_inode_info *info;
 	struct address_space * mapping = inode->i_mapping;
 	int error;
 
@@ -407,27 +411,28 @@
 		page_cache_release(*ptr);
 	}
 
-	down (&inode->i_sem);
-	/* retest we may have slept */
+	info = &inode->u.shmem_i;
+	down (&info->sem);
+	/* retest we may have slept */  	
+
+	*ptr = ERR_PTR(-EFAULT);
 	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
-		goto sigbus;
-	*ptr = shmem_getpage_locked(inode, idx);
+		goto failed;
+
+	*ptr = shmem_getpage_locked(&inode->u.shmem_i, inode, idx);
 	if (IS_ERR (*ptr))
 		goto failed;
+
 	UnlockPage(*ptr);
-	up (&inode->i_sem);
+	up (&info->sem);
 	return 0;
 failed:
-	up (&inode->i_sem);
+	up (&info->sem);
 	error = PTR_ERR(*ptr);
-	*ptr = NOPAGE_OOM;
-	if (error != -EFBIG)
-		*ptr = NOPAGE_SIGBUS;
-	return error;
-sigbus:
-	up (&inode->i_sem);
 	*ptr = NOPAGE_SIGBUS;
-	return -EFAULT;
+	if (error == -ENOMEM)
+		*ptr = NOPAGE_OOM;
+	return error;
 }
 
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
@@ -500,6 +505,7 @@
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
 {
 	struct inode * inode;
+	struct shmem_inode_info *info;
 
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (!sb->u.shmem_sb.free_inodes) {
@@ -519,7 +525,9 @@
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		spin_lock_init (&inode->u.shmem_i.lock);
+		info = &inode->u.shmem_i;
+		spin_lock_init (&info->lock);
+		sema_init (&info->sem, 1);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -549,6 +557,7 @@
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode; 
+	struct shmem_inode_info *info;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	struct page	*page;
@@ -624,7 +633,11 @@
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		page = shmem_getpage_locked(inode, index);
+		info = &inode->u.shmem_i;
+		down (&info->sem);
+		page = shmem_getpage_locked(info, inode, index);
+		up (&info->sem);
+
 		status = PTR_ERR(page);
 		if (IS_ERR(page))
 			break;
@@ -635,7 +648,6 @@
 		}
 
 		kaddr = kmap(page);
-// can this do a truncated write? cr
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		kunmap(page);
 		if (status)
@@ -932,7 +944,7 @@
 		
 	inode = dentry->d_inode;
 	down(&inode->i_sem);
-	page = shmem_getpage_locked(inode, 0);
+	page = shmem_getpage_locked(&inode->u.shmem_i, inode, 0);
 	if (IS_ERR(page))
 		goto fail;
 	kaddr = kmap(page);
@@ -1027,6 +1039,8 @@
 	unsigned long max_inodes, inodes;
 	struct shmem_sb_info *info = &sb->u.shmem_sb;
 
+	max_blocks = info->max_blocks;
+	max_inodes = info->max_inodes;
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
@@ -1074,7 +1088,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long)SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1282,9 +1296,11 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	error = -ENOMEM;
+	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+		return ERR_PTR(-EINVAL);
+
 	if (!vm_enough_memory((size) >> PAGE_SHIFT))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
 	this.len = strlen(name);
@@ -1292,7 +1308,7 @@
 	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1318,7 +1334,6 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
-out:
 	return ERR_PTR(error);	
 }
 /*

