Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135691AbREFN5f>; Sun, 6 May 2001 09:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135694AbREFN51>; Sun, 6 May 2001 09:57:27 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:4284 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135691AbREFN5N>; Sun, 6 May 2001 09:57:13 -0400
From: Christoph Rohland <cr@sap.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Albert Cranford <ac9410@bellsouth.net>
Subject: [Resend] Collection of tmpfs patches
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
	<m3n196v2un.fsf@linux.local> <m3vgnjy8to.fsf@linux.local>
	<3AF405FC.11D37FEB@bellsouth.net>
Organisation: SAP LinuxLab
In-Reply-To: <3AF405FC.11D37FEB@bellsouth.net>
Message-ID: <m3pudmq4hf.fsf_-_@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: 06 May 2001 15:58:22 +0200
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

There is some confusion about my latest tmpfs fixes. There were three
patches which are cummulative against 2.4.4:

1) deadlock fix for write out of mmap regions. (AFAIK this is
   integrated in the -ac kernels)
2) encapsulate access to shmem_inode_info
3) Do inline symlinks

I attach all these patches to this mail in the case that somebody
missed one.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-mmap_write_sem2
Content-Description: deadlock fix

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

--=-=-=
Content-Disposition: attachment; filename=patch-SHMEM_I
Content-Description: encapsulate access to shmem_inode_info

diff -uNr 2.4.4-mmap_write/include/linux/shmem_fs.h 2.4.4-mmap_write-SHMEM_I/include/linux/shmem_fs.h
--- 2.4.4-mmap_write/include/linux/shmem_fs.h	Tue May  1 20:02:00 2001
+++ 2.4.4-mmap_write-SHMEM_I/include/linux/shmem_fs.h	Tue May  1 20:06:10 2001
@@ -18,14 +18,15 @@
 } swp_entry_t;
 
 struct shmem_inode_info {
-	spinlock_t	lock;
-	struct semaphore sem;
-	unsigned long	max_index;
-	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	swp_entry_t   **i_indirect; /* doubly indirect blocks */
-	unsigned long	swapped;
-	int		locked;     /* into memory */
+	spinlock_t		lock;
+	struct semaphore 	sem;
+	unsigned long		max_index;
+	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
+	swp_entry_t           **i_indirect; /* doubly indirect blocks */
+	unsigned long		swapped;
+	int			locked;     /* into memory */
 	struct list_head	list;
+	struct inode	       *inode;
 };
 
 struct shmem_sb_info {
@@ -35,5 +36,7 @@
 	unsigned long free_inodes;  /* How many are left for allocation */
 	spinlock_t    stat_lock;
 };
+
+#define SHMEM_I(inode)  (&inode->u.shmem_i)
 
 #endif
diff -uNr 2.4.4-mmap_write/ipc/shm.c 2.4.4-mmap_write-SHMEM_I/ipc/shm.c
--- 2.4.4-mmap_write/ipc/shm.c	Wed Apr 11 12:36:47 2001
+++ 2.4.4-mmap_write-SHMEM_I/ipc/shm.c	Tue May  1 20:06:10 2001
@@ -348,6 +348,7 @@
 
 static void shm_get_stat (unsigned long *rss, unsigned long *swp) 
 {
+	struct shmem_inode_info *info;
 	int i;
 
 	*rss = 0;
@@ -361,10 +362,11 @@
 		if(shp == NULL)
 			continue;
 		inode = shp->shm_file->f_dentry->d_inode;
-		spin_lock (&inode->u.shmem_i.lock);
+		info = SHMEM_I(inode);
+		spin_lock (&info->lock);
 		*rss += inode->i_mapping->nrpages;
-		*swp += inode->u.shmem_i.swapped;
-		spin_unlock (&inode->u.shmem_i.lock);
+		*swp += info->swapped;
+		spin_unlock (&info->lock);
 	}
 }
 
diff -uNr 2.4.4-mmap_write/mm/shmem.c 2.4.4-mmap_write-SHMEM_I/mm/shmem.c
--- 2.4.4-mmap_write/mm/shmem.c	Tue May  1 20:02:00 2001
+++ 2.4.4-mmap_write-SHMEM_I/mm/shmem.c	Wed May  2 16:46:00 2001
@@ -73,7 +73,7 @@
 	unsigned long freed;
 
 	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
+		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
 	if (freed){
 		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
 		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
@@ -159,7 +159,7 @@
 	unsigned long index, start;
 	unsigned long freed = 0;
 	swp_entry_t **base, **ptr, **last;
-	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -206,7 +206,7 @@
 	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
 
 	spin_lock (&shmem_ilock);
-	list_del (&inode->u.shmem_i.list);
+	list_del (&SHMEM_I(inode)->list);
 	spin_unlock (&shmem_ilock);
 	inode->i_size = 0;
 	shmem_truncate (inode);
@@ -239,7 +239,7 @@
 		goto out;
 	
 	inode = page->mapping->host;
-	info = &inode->u.shmem_i;
+	info = SHMEM_I(inode);
 	swap = __get_swap_page(2);
 	error = -ENOMEM;
 	if (!swap.val)
@@ -407,7 +407,7 @@
 		page_cache_release(*ptr);
 	}
 
-	info = &inode->u.shmem_i;
+	info = SHMEM_I(inode);
 	down (&info->sem);
 	/* retest we may have slept */  	
 
@@ -415,7 +415,7 @@
 	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
 		goto failed;
 
-	*ptr = shmem_getpage_locked(&inode->u.shmem_i, inode, idx);
+	*ptr = shmem_getpage_locked(info, inode, idx);
 	if (IS_ERR (*ptr))
 		goto failed;
 
@@ -462,7 +462,7 @@
 void shmem_lock(struct file * file, int lock)
 {
 	struct inode * inode = file->f_dentry->d_inode;
-	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct shmem_inode_info * info = SHMEM_I(inode);
 	struct page * page;
 	unsigned long idx, size;
 
@@ -521,7 +521,8 @@
 		inode->i_rdev = to_kdev_t(dev);
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		info = &inode->u.shmem_i;
+		info = SHMEM_I(inode);
+		info->inode = inode;
 		spin_lock_init (&info->lock);
 		sema_init (&info->sem, 1);
 		switch (mode & S_IFMT) {
@@ -542,7 +543,7 @@
 			break;
 		}
 		spin_lock (&shmem_ilock);
-		list_add (&inode->u.shmem_i.list, &shmem_inodes);
+		list_add (&SHMEM_I(inode)->list, &shmem_inodes);
 		spin_unlock (&shmem_ilock);
 	}
 	return inode;
@@ -629,7 +630,7 @@
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		info = &inode->u.shmem_i;
+		info = SHMEM_I(inode);
 		down (&info->sem);
 		page = shmem_getpage_locked(info, inode, index);
 		up (&info->sem);
@@ -658,8 +659,8 @@
 			buf += bytes;
 			if (pos > inode->i_size) 
 				inode->i_size = pos;
-			if (inode->u.shmem_i.max_index <= index)
-				inode->u.shmem_i.max_index = index+1;
+			if (info->max_index <= index)
+				info->max_index = index+1;
 
 		}
 unlock:
@@ -940,7 +941,7 @@
 		
 	inode = dentry->d_inode;
 	down(&inode->i_sem);
-	page = shmem_getpage_locked(&inode->u.shmem_i, inode, 0);
+	page = shmem_getpage_locked(SHMEM_I(inode), inode, 0);
 	if (IS_ERR(page))
 		goto fail;
 	kaddr = kmap(page);
@@ -1220,12 +1221,11 @@
 	return -1;
 }
 
-static int shmem_unuse_inode (struct inode *inode, swp_entry_t entry, struct page *page)
+static int shmem_unuse_inode (struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
 	swp_entry_t **base, **ptr;
 	unsigned long idx;
 	int offset;
-	struct shmem_inode_info *info = &inode->u.shmem_i;
 	
 	idx = 0;
 	spin_lock (&info->lock);
@@ -1246,7 +1246,7 @@
 	spin_unlock (&info->lock);
 	return 0;
 found:
-	add_to_page_cache(page, inode->i_mapping, offset + idx);
+	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
 	set_page_dirty(page);
 	SetPageUptodate(page);
 	UnlockPage(page);
@@ -1261,13 +1261,13 @@
 void shmem_unuse(swp_entry_t entry, struct page *page)
 {
 	struct list_head *p;
-	struct inode * inode;
+	struct shmem_inode_info * info;
 
 	spin_lock (&shmem_ilock);
 	list_for_each(p, &shmem_inodes) {
-		inode = list_entry(p, struct inode, u.shmem_i.list);
+		info = list_entry(p, struct shmem_inode_info, list);
 
-		if (shmem_unuse_inode(inode, entry, page))
+		if (shmem_unuse_inode(info, entry, page))
 			break;
 	}
 	spin_unlock (&shmem_ilock);

--=-=-=
Content-Disposition: attachment; filename=patch-inline_symlink
Content-Description: inline symlinks

diff -uNr 2.4.4-mmap_write-SHMEM_I/mm/shmem.c 2.4.4-mmap_write-SHMEM_I-symlink/mm/shmem.c
--- 2.4.4-mmap_write-SHMEM_I/mm/shmem.c	Fri May  4 21:32:22 2001
+++ 2.4.4-mmap_write-SHMEM_I-symlink/mm/shmem.c	Fri May  4 21:37:34 2001
@@ -41,7 +41,6 @@
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
-static struct inode_operations shmem_symlink_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 LIST_HEAD (shmem_inodes);
@@ -205,11 +204,13 @@
 {
 	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
 
-	spin_lock (&shmem_ilock);
-	list_del (&SHMEM_I(inode)->list);
-	spin_unlock (&shmem_ilock);
 	inode->i_size = 0;
-	shmem_truncate (inode);
+	if (inode->i_op->truncate == shmem_truncate){ 
+		spin_lock (&shmem_ilock);
+		list_del (&SHMEM_I(inode)->list);
+		spin_unlock (&shmem_ilock);
+		shmem_truncate(inode);
+	}
 	spin_lock (&info->stat_lock);
 	info->free_inodes++;
 	spin_unlock (&info->stat_lock);
@@ -532,6 +533,9 @@
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
+			spin_lock (&shmem_ilock);
+			list_add (&SHMEM_I(inode)->list, &shmem_inodes);
+			spin_unlock (&shmem_ilock);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -539,17 +543,17 @@
 			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
-			inode->i_op = &shmem_symlink_inode_operations;
 			break;
 		}
-		spin_lock (&shmem_ilock);
-		list_add (&SHMEM_I(inode)->list, &shmem_inodes);
-		spin_unlock (&shmem_ilock);
 	}
 	return inode;
 }
 
 #ifdef CONFIG_TMPFS
+
+static struct inode_operations shmem_symlink_inode_operations;
+static struct inode_operations shmem_symlink_inline_operations;
+
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
@@ -930,33 +934,54 @@
 	struct inode *inode;
 	struct page *page;
 	char *kaddr;
+	struct shmem_inode_info * info;
 
 	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
 	if (error)
 		return error;
 
-	len = strlen(symname);
+	len = strlen(symname) + 1;
 	if (len > PAGE_SIZE)
 		return -ENAMETOOLONG;
-		
+
 	inode = dentry->d_inode;
-	down(&inode->i_sem);
-	page = shmem_getpage_locked(SHMEM_I(inode), inode, 0);
-	if (IS_ERR(page))
-		goto fail;
-	kaddr = kmap(page);
-	memcpy(kaddr, symname, len);
-	kunmap(page);
+	info = SHMEM_I(inode);
 	inode->i_size = len;
-	SetPageDirty(page);
-	UnlockPage(page);
-	page_cache_release(page);
-	up(&inode->i_sem);
+	if (len <= sizeof(struct shmem_inode_info)) {
+		/* do it inline */
+		memcpy(info, symname, len);
+		inode->i_op = &shmem_symlink_inline_operations;
+	} else {
+		spin_lock (&shmem_ilock);
+		list_add (&info->list, &shmem_inodes);
+		spin_unlock (&shmem_ilock);
+		down(&inode->i_sem);
+		page = shmem_getpage_locked(info, inode, 0);
+		if (IS_ERR(page)) {
+			up(&inode->i_sem);
+			return PTR_ERR(page);
+		}
+		kaddr = kmap(page);
+		memcpy(kaddr, symname, len);
+		kunmap(page);
+		SetPageDirty(page);
+		UnlockPage(page);
+		page_cache_release(page);
+		up(&inode->i_sem);
+		inode->i_op = &shmem_symlink_inode_operations;
+	}
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	return 0;
-fail:
-	up(&inode->i_sem);
-	return PTR_ERR(page);
+}
+
+static int shmem_readlink_inline(struct dentry *dentry, char *buffer, int buflen)
+{
+	return vfs_readlink(dentry,buffer,buflen, (const char *)SHMEM_I(dentry->d_inode));
+}
+
+static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
+{
+	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode));
 }
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
@@ -986,6 +1011,17 @@
 	return res;
 }
 
+static struct inode_operations shmem_symlink_inline_operations = {
+	readlink:	shmem_readlink_inline,
+	follow_link:	shmem_follow_link_inline,
+};
+
+static struct inode_operations shmem_symlink_inode_operations = {
+	truncate:	shmem_truncate,
+	readlink:	shmem_readlink,
+	follow_link:	shmem_follow_link,
+};
+
 static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
 {
 	char *this_char, *value;
@@ -1118,14 +1154,6 @@
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
-};
-
-static struct inode_operations shmem_symlink_inode_operations = {
-	truncate:	shmem_truncate,
-#ifdef CONFIG_TMPFS
-	readlink:	shmem_readlink,
-	follow_link:	shmem_follow_link,
-#endif
 };
 
 static struct file_operations shmem_dir_operations = {

--=-=-=--

