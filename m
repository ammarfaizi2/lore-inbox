Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbREANsQ>; Tue, 1 May 2001 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136522AbREANsG>; Tue, 1 May 2001 09:48:06 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:35240 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135314AbREANrp>; Tue, 1 May 2001 09:47:45 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>, Stephen Tweedie <sct@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MM mailing list <linux-mm@kvack.org>
Subject: [Patch] deadlock on write in tmpfs
Organisation: SAP LinuxLab
Message-ID: <m3hez5ci6p.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 01 May 2001 15:39:47 +0200
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Stephen,

tmpfs deadlocks when writing into a file from a mapping of the same
file. 

The problem is the following:

- shmem_file_write may call shmem_no_page and calls
  shmem_getpage_locked later,
- shmem_no_page calls shmem_getpage_locked
- shmem_getpage_locked may call shmem_writepage on page allocation

- shmem_file_write holds the inode semaphore
- shmem_getpage_locked prevent races against shmem_writepage with the
  shmem spinlock
- shmem_getpage_locked needs serialization against itself and
  shmem_truncate

The last was done with the inode semaphore, which deadlocks with
shmem_write

So I see two choices: 

1) Do not serialise the whole of shmem_getpage_locked but protect
   critical pathes with the spinlock and do retries after sleeps
2) Add another semaphore to serialize shmem_getpage_locked and
   shmem_truncate

I tried some time to get 1) done but the retry logic became way too
complicated. So the attached patch implements 2)

I still think it's ugly to add another semaphore, but it works.

Greetings
		Christoph

diff -uNr 2.4.4/include/linux/shmem_fs.h c/include/linux/shmem_fs.h
--- 2.4.4/include/linux/shmem_fs.h	Sun Apr 29 20:33:00 2001
+++ c/include/linux/shmem_fs.h	Sun Apr 29 22:43:56 2001
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	struct semaphore sem;
 	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
diff -uNr 2.4.4/mm/shmem.c c/mm/shmem.c
--- 2.4.4/mm/shmem.c	Mon Apr 30 09:45:39 2001
+++ c/mm/shmem.c	Tue May  1 15:15:38 2001
@@ -161,6 +161,7 @@
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
+	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -197,6 +198,7 @@
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
+	up(&info->sem);
 }
 
 static void shmem_delete_inode(struct inode * inode)
@@ -281,15 +283,12 @@
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
@@ -393,6 +392,7 @@
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
 {
+	struct shmem_inode_info *info;
 	struct address_space * mapping = inode->i_mapping;
 	int error;
 
@@ -407,27 +407,28 @@
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
@@ -500,6 +501,7 @@
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
 {
 	struct inode * inode;
+	struct shmem_inode_info *info;
 
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (!sb->u.shmem_sb.free_inodes) {
@@ -519,7 +521,9 @@
 		inode->i_rdev = to_kdev_t(dev);
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		spin_lock_init (&inode->u.shmem_i.lock);
+		info = &inode->u.shmem_i;
+		spin_lock_init (&info->lock);
+		sema_init (&info->sem, 1);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -549,6 +553,7 @@
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode; 
+	struct shmem_inode_info *info;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	struct page	*page;
@@ -624,7 +629,11 @@
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
@@ -635,7 +644,6 @@
 		}
 
 		kaddr = kmap(page);
-// can this do a truncated write? cr
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		kunmap(page);
 		if (status)
@@ -932,7 +940,7 @@
 		
 	inode = dentry->d_inode;
 	down(&inode->i_sem);
-	page = shmem_getpage_locked(inode, 0);
+	page = shmem_getpage_locked(&inode->u.shmem_i, inode, 0);
 	if (IS_ERR(page))
 		goto fail;
 	kaddr = kmap(page);

