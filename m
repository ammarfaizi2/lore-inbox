Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266479AbRGCIPj>; Tue, 3 Jul 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbRGCIPa>; Tue, 3 Jul 2001 04:15:30 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:50841 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S266477AbRGCIPO>; Tue, 3 Jul 2001 04:15:14 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs fixes against 2.4.6-pre(2)
Organisation: SAP LinuxLab
Date: 03 Jul 2001 10:14:33 +0200
Message-ID: <m3g0ce2zva.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the second part of my patches.

Writing out of a mapping of a tmpfs file into the same file can
deadlock. This is running in the -ac series since some while.

Please apply
		Christoph

diff -uNr 6-pre8-fix1/include/linux/shmem_fs.h 6-pre8-fix2/include/linux/shmem_fs.h
--- 6-pre8-fix1/include/linux/shmem_fs.h	Sun Apr 29 20:33:00 2001
+++ 6-pre8-fix2/include/linux/shmem_fs.h	Tue Jul  3 09:28:13 2001
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	struct semaphore sem;
 	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
diff -uNr 6-pre8-fix1/mm/shmem.c 6-pre8-fix2/mm/shmem.c
--- 6-pre8-fix1/mm/shmem.c	Tue Jul  3 08:55:20 2001
+++ 6-pre8-fix2/mm/shmem.c	Tue Jul  3 10:09:26 2001
@@ -162,6 +162,7 @@
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
+	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -205,6 +206,7 @@
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
+	up(&info->sem);
 }
 
 static void shmem_delete_inode(struct inode * inode)
@@ -289,15 +291,12 @@
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
@@ -402,6 +401,7 @@
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
 {
+	struct shmem_inode_info *info;
 	struct address_space * mapping = inode->i_mapping;
 	int error;
 
@@ -416,27 +416,28 @@
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
@@ -509,6 +510,7 @@
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
 {
 	struct inode * inode;
+	struct shmem_inode_info *info;
 
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (!sb->u.shmem_sb.free_inodes) {
@@ -528,7 +530,9 @@
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
@@ -558,6 +562,7 @@
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode; 
+	struct shmem_inode_info *info;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	struct page	*page;
@@ -633,7 +638,11 @@
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
@@ -644,7 +653,6 @@
 		}
 
 		kaddr = kmap(page);
-// can this do a truncated write? cr
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		kunmap(page);
 		if (status)
@@ -941,7 +949,7 @@
 		
 	inode = dentry->d_inode;
 	down(&inode->i_sem);
-	page = shmem_getpage_locked(inode, 0);
+	page = shmem_getpage_locked(&inode->u.shmem_i, inode, 0);
 	if (IS_ERR(page))
 		goto fail;
 	kaddr = kmap(page);

