Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbREOIha>; Tue, 15 May 2001 04:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbREOIhW>; Tue, 15 May 2001 04:37:22 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6795 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262680AbREOIhF>; Tue, 15 May 2001 04:37:05 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Assorted tmpfs fixes
Organisation: SAP LinuxLab
Message-ID: <m3k83j83aw.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
Date: 15 May 2001 10:32:25 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Alan,

would you mind to apply the accumulated tmpfs fixes to the -ac series?

Here the short descriptions:

2-SHMEM_I: 
        Encapsulate all accesses to the private info structure with
        macro. This was suggested by Al to later get rid of the
        union in the inode struct. This is pretty straightforward
        search and replace.
3-inline_symlink: 
        For symlinks smaller than the private keep the
        symlink directly there. This saves 4k per normal
        symlink. This is a new feature which is quite simple.
4-accounting: 
        This patch introduces accounting for in memory
        tmpfs pages and modifies meminfo to subtract these pages from
        the cached pages since they are not really cached. This makes
        tuning memory requirement much easier and confuses less people.
5-accounting_shared:
        Export the tmpfs memory count into the /shared/ field of
        meminfo. This change does reuse the now unused field to get
        some sensible data to the user. It is somewhat questionable
        since it changes the semantics of the field against pre
        2.4. But many people expect exactly this number here
6-accounting_uml:
        The previous patch for uml
7-triple2:
        redo the swap entry handling to do triple indirect
        blocks. This is needed for s390x which has 4k page size and 64
        bit. This limits tmpfs files and shm segments to ~1GB without
        the patch.

I would really like to get this tested first in -ac before feeding
this to Linus.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-2-SHMEM_I

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
Content-Disposition: attachment; filename=patch-3-inline_symlink

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

--=-=-=
Content-Disposition: attachment; filename=patch-4-accounting

diff -uNr 2.4.4-mSsu/fs/proc/proc_misc.c 2.4.4-mSsua/fs/proc/proc_misc.c
--- 2.4.4-mSsu/fs/proc/proc_misc.c	Sun Apr 29 20:32:52 2001
+++ 2.4.4-mSsua/fs/proc/proc_misc.c	Mon May  7 13:38:53 2001
@@ -140,6 +140,17 @@
 {
 	struct sysinfo i;
 	int len;
+	unsigned int cached, shmem;
+
+	/*
+	 * There may be some inconsistency because shmem_nrpages
+	 * update is delayed to page_cache_size
+	 * We make sure the cached value does not get below zero 
+	 */
+	cached = atomic_read(&page_cache_size);
+	shmem  = atomic_read(&shmem_nrpages);
+	if (shmem < cached)
+		cached -= shmem;
 
 /*
  * display in kilobytes.
@@ -153,8 +164,8 @@
                 "Swap: %8lu %8lu %8lu\n",
                 B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
                 B(i.sharedram), B(i.bufferram),
-                B(atomic_read(&page_cache_size)), B(i.totalswap),
-                B(i.totalswap-i.freeswap), B(i.freeswap));
+		B(cached), B(i.totalswap),
+		B(i.totalswap-i.freeswap), B(i.freeswap));
         /*
          * Tagged format, for easy grepping and expansion.
          * The above will go away eventually, once the tools
@@ -180,7 +191,7 @@
                 K(i.freeram),
                 K(i.sharedram),
                 K(i.bufferram),
-                K(atomic_read(&page_cache_size)),
+		K(cached),
 		K(nr_active_pages),
 		K(nr_inactive_dirty_pages),
 		K(nr_inactive_clean_pages()),
diff -uNr 2.4.4-mSsu/include/linux/shmem_fs.h 2.4.4-mSsua/include/linux/shmem_fs.h
--- 2.4.4-mSsu/include/linux/shmem_fs.h	Wed May  2 18:36:05 2001
+++ 2.4.4-mSsua/include/linux/shmem_fs.h	Mon May  7 12:52:00 2001
@@ -17,6 +17,8 @@
 	unsigned long val;
 } swp_entry_t;
 
+extern atomic_t shmem_nrpages;
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	struct semaphore 	sem;
diff -uNr 2.4.4-mSsu/mm/mmap.c 2.4.4-mSsua/mm/mmap.c
--- 2.4.4-mSsu/mm/mmap.c	Sun Apr 29 20:33:01 2001
+++ 2.4.4-mSsua/mm/mmap.c	Mon May  7 13:42:03 2001
@@ -55,13 +55,24 @@
 	 */
 
 	long free;
-	
+	unsigned long cached, shmem;
+
+	/*
+	 * There may be some inconsistency because shmem_nrpages
+	 * update is delayed to the page_cache_size
+	 * We make sure the cached value does not get below zero 
+	 */
+	cached = atomic_read(&page_cache_size);
+	shmem  = atomic_read(&shmem_nrpages);
+	if (cached > shmem)
+		cached -= shmem;
+
         /* Sometimes we want to use more memory than we have. */
 	if (sysctl_overcommit_memory)
 	    return 1;
 
 	free = atomic_read(&buffermem_pages);
-	free += atomic_read(&page_cache_size);
+	free += cached;
 	free += nr_free_pages();
 	free += nr_swap_pages;
 
diff -uNr 2.4.4-mSsu/mm/shmem.c 2.4.4-mSsua/mm/shmem.c
--- 2.4.4-mSsu/mm/shmem.c	Fri May  4 21:37:34 2001
+++ 2.4.4-mSsua/mm/shmem.c	Mon May  7 11:13:27 2001
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
@@ -45,6 +46,7 @@
 
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
+atomic_t shmem_nrpages = ATOMIC_INIT(0);
 
 #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
 
@@ -52,6 +54,7 @@
  * shmem_recalc_inode - recalculate the size of an inode
  *
  * @inode: inode to recalc
+ * @swap:  additional swap pages freed externally
  *
  * We have to calculate the free blocks since the mm can drop pages
  * behind our back
@@ -62,12 +65,14 @@
  *
  * So the mm freed 
  * inodes->i_blocks/BLOCKS_PER_PAGE - 
- *			(inode->i_mapping->nrpages + info->swapped)
+ * 			(inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
+ *
+ * The swap parameter is a performance hack for truncate.
  */
 
-static void shmem_recalc_inode(struct inode * inode)
+static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
 {
 	unsigned long freed;
 
@@ -79,6 +84,7 @@
 		spin_lock (&info->stat_lock);
 		info->free_blocks += freed;
 		spin_unlock (&info->stat_lock);
+		atomic_sub(freed-swap, &shmem_nrpages);
 	}
 }
 
@@ -195,7 +201,7 @@
 out:
 	info->max_index = index;
 	info->swapped -= freed;
-	shmem_recalc_inode(inode);
+	shmem_recalc_inode(inode, freed);
 	spin_unlock (&info->lock);
 	up(&info->sem);
 }
@@ -250,14 +256,15 @@
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host);
+	shmem_recalc_inode(page->mapping->host, 0);
 	error = -EAGAIN;
 	if (entry->val)
 		BUG();
 
 	*entry = swap;
 	error = 0;
-	/* Remove the from the page cache */
+	/* Remove the page from the page cache */
+	atomic_dec(&shmem_nrpages);
 	lru_cache_del(page);
 	remove_inode_page(page);
 
@@ -376,6 +383,7 @@
 	}
 
 	/* We have the page */
+	atomic_inc(&shmem_nrpages);
 	SetPageUptodate(page);
 	if (info->locked)
 		page_cache_get(page);
@@ -1275,6 +1283,7 @@
 	return 0;
 found:
 	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
+	atomic_inc(&shmem_nrpages);
 	set_page_dirty(page);
 	SetPageUptodate(page);
 	UnlockPage(page);

--=-=-=
Content-Disposition: attachment; filename=patch-5-accounting_shared

diff -uNr 2.4.4-mSsu/arch/alpha/mm/init.c c/arch/alpha/mm/init.c
--- 2.4.4-mSsu/arch/alpha/mm/init.c	Sun Apr 29 20:31:56 2001
+++ c/arch/alpha/mm/init.c	Sun May  6 21:47:25 2001
@@ -402,7 +402,7 @@
 si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/arm/mm/init.c c/arch/arm/mm/init.c
--- 2.4.4-mSsu/arch/arm/mm/init.c	Sun Apr 29 20:31:56 2001
+++ c/arch/arm/mm/init.c	Sun May  6 21:47:01 2001
@@ -647,7 +647,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram  = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram   = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/cris/mm/init.c c/arch/cris/mm/init.c
--- 2.4.4-mSsu/arch/cris/mm/init.c	Sun Apr 29 20:31:57 2001
+++ c/arch/cris/mm/init.c	Sun May  6 21:47:03 2001
@@ -503,7 +503,7 @@
 
 	i = max_mapnr;
 	val->totalram = 0;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	while (i-- > 0)  {
diff -uNr 2.4.4-mSsu/arch/i386/mm/init.c c/arch/i386/mm/init.c
--- 2.4.4-mSsu/arch/i386/mm/init.c	Sun Apr 29 20:32:08 2001
+++ c/arch/i386/mm/init.c	Sun May  6 20:24:21 2001
@@ -570,7 +570,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/ia64/mm/init.c c/arch/ia64/mm/init.c
--- 2.4.4-mSsu/arch/ia64/mm/init.c	Sun Apr 29 20:32:11 2001
+++ c/arch/ia64/mm/init.c	Sun May  6 21:47:05 2001
@@ -151,7 +151,7 @@
 si_meminfo (struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/m68k/mm/init.c c/arch/m68k/mm/init.c
--- 2.4.4-mSsu/arch/m68k/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/m68k/mm/init.c	Sun May  6 21:47:45 2001
@@ -217,7 +217,7 @@
 
     i = max_mapnr;
     val->totalram = totalram_pages;
-    val->sharedram = 0;
+    val->sharedram = atomic_read(&shmem_nrpages);
     val->freeram = nr_free_pages();
     val->bufferram = atomic_read(&buffermem_pages);
     while (i-- > 0) {
diff -uNr 2.4.4-mSsu/arch/mips/mm/init.c c/arch/mips/mm/init.c
--- 2.4.4-mSsu/arch/mips/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/mips/mm/init.c	Sun May  6 21:47:01 2001
@@ -343,7 +343,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/mips64/mm/init.c c/arch/mips64/mm/init.c
--- 2.4.4-mSsu/arch/mips64/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/mips64/mm/init.c	Sun May  6 21:47:04 2001
@@ -411,7 +411,7 @@
 si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/parisc/mm/init.c c/arch/parisc/mm/init.c
--- 2.4.4-mSsu/arch/parisc/mm/init.c	Sun Dec 17 12:53:55 2000
+++ c/arch/parisc/mm/init.c	Sun May  6 21:47:02 2001
@@ -458,7 +458,7 @@
 
 	i = max_mapnr;
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 #if 0
diff -uNr 2.4.4-mSsu/arch/ppc/mm/init.c c/arch/ppc/mm/init.c
--- 2.4.4-mSsu/arch/ppc/mm/init.c	Wed Apr 11 12:36:13 2001
+++ c/arch/ppc/mm/init.c	Sun May  6 21:47:05 2001
@@ -336,7 +336,7 @@
 
 	i = max_mapnr;
 	val->totalram = 0;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	while (i-- > 0)  {
diff -uNr 2.4.4-mSsu/arch/s390/mm/init.c c/arch/s390/mm/init.c
--- 2.4.4-mSsu/arch/s390/mm/init.c	Sun Apr 29 20:32:21 2001
+++ c/arch/s390/mm/init.c	Sun May  6 21:47:03 2001
@@ -271,7 +271,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/s390x/mm/init.c c/arch/s390x/mm/init.c
--- 2.4.4-mSsu/arch/s390x/mm/init.c	Sun Apr 29 20:32:22 2001
+++ c/arch/s390x/mm/init.c	Sun May  6 21:47:18 2001
@@ -284,7 +284,7 @@
 void si_meminfo(struct sysinfo *val)
 {
         val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/sh/mm/init.c c/arch/sh/mm/init.c
--- 2.4.4-mSsu/arch/sh/mm/init.c	Sun Apr 29 20:32:23 2001
+++ c/arch/sh/mm/init.c	Sun May  6 21:47:26 2001
@@ -215,7 +215,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/sparc/mm/init.c c/arch/sparc/mm/init.c
--- 2.4.4-mSsu/arch/sparc/mm/init.c	Sun Apr 29 20:32:23 2001
+++ c/arch/sparc/mm/init.c	Sun May  6 21:47:04 2001
@@ -534,7 +534,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/sparc64/mm/init.c c/arch/sparc64/mm/init.c
--- 2.4.4-mSsu/arch/sparc64/mm/init.c	Sun Apr 29 20:32:25 2001
+++ c/arch/sparc64/mm/init.c	Sun May  6 21:47:02 2001
@@ -1512,7 +1512,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = num_physpages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 

--=-=-=
Content-Disposition: attachment; filename=patch-6-accounting_uml

diff -uNr c/arch/um/kernel/mem.c u4ac9/arch/um/kernel/mem.c
--- c/arch/um/kernel/mem.c	Mon May 14 09:35:57 2001
+++ u4ac9/arch/um/kernel/mem.c	Mon May 14 09:43:35 2001
@@ -77,7 +77,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;

--=-=-=
Content-Disposition: attachment; filename=patch-7-triple2

diff -uNr 4-mSsas/include/linux/shmem_fs.h 4-mSsasb/include/linux/shmem_fs.h
--- 4-mSsas/include/linux/shmem_fs.h	Mon May 14 08:49:42 2001
+++ 4-mSsasb/include/linux/shmem_fs.h	Mon May 14 09:05:39 2001
@@ -22,9 +22,9 @@
 struct shmem_inode_info {
 	spinlock_t		lock;
 	struct semaphore 	sem;
-	unsigned long		max_index;
+	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	swp_entry_t           **i_indirect; /* doubly indirect blocks */
+	void		      **i_indirect; /* indirect blocks */
 	unsigned long		swapped;
 	int			locked;     /* into memory */
 	struct list_head	list;
diff -uNr 4-mSsas/mm/shmem.c 4-mSsasb/mm/shmem.c
--- 4-mSsas/mm/shmem.c	Mon May 14 08:49:42 2001
+++ 4-mSsasb/mm/shmem.c	Tue May 15 09:12:00 2001
@@ -34,7 +34,6 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
-#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -65,7 +64,7 @@
  *
  * So the mm freed 
  * inodes->i_blocks/BLOCKS_PER_PAGE - 
- * 			(inode->i_mapping->nrpages + info->swapped)
+ *			(inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
  *
@@ -88,9 +87,53 @@
 	}
 }
 
-static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
+/*
+ * shmem_swp_entry - find the swap vector position in the info structure
+ *
+ * @info:  info structure for the inode
+ * @index: index of the page to find
+ * @page:  optional page to add to the structure. Has to be preset to
+ *         all zeros
+ *
+ * If there is no space allocated yet it will return -ENOMEM when
+ * page == 0 else it will use the page for the needed block.
+ *
+ * returns -EFBIG if the index is too big.
+ *
+ *
+ * The swap vector is organized the following way:
+ *
+ * There are SHMEM_NR_DIRECT entries directly stored in the
+ * shmem_inode_info structure. So small files do not need an addional
+ * allocation.
+ *
+ * For pages with index > SHMEM_NR_DIRECT there is the pointer
+ * i_indirect which points to a page which holds in the first half
+ * doubly indirect blocks, in the second half triple indirect blocks:
+ *
+ * For an artificial ENTRIES_PER_PAGE = 4 this would lead to the
+ * following layout (for SHMEM_NR_DIRECT == 16):
+ *
+ * i_indirect -> dir --> 16-19
+ * 	      |	     +-> 20-23
+ * 	      |
+ * 	      +-->dir2 --> 24-27
+ * 	      |	       +-> 28-31
+ * 	      |	       +-> 32-35
+ * 	      |	       +-> 36-39
+ * 	      |
+ * 	      +-->dir3 --> 40-43
+ * 	       	       +-> 44-47
+ * 	      	       +-> 48-51
+ * 	      	       +-> 52-55
+ */
+
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2*(ENTRIES_PER_PAGE+1))
+
+static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index, unsigned long page) 
 {
 	unsigned long offset;
+	void **dir;
 
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
@@ -99,23 +142,66 @@
 	offset = index % ENTRIES_PER_PAGE;
 	index /= ENTRIES_PER_PAGE;
 
-	if (index >= ENTRIES_PER_PAGE)
-		return ERR_PTR(-EFBIG);
-
 	if (!info->i_indirect) {
-		info->i_indirect = (swp_entry_t **) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect)
+		info->i_indirect = (void *) page;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dir = info->i_indirect + index;
+	if (index >= ENTRIES_PER_PAGE/2) {
+		index -= ENTRIES_PER_PAGE/2;
+		dir = info->i_indirect + ENTRIES_PER_PAGE/2 
+			+ index/ENTRIES_PER_PAGE;
+		index %= ENTRIES_PER_PAGE;
+
+		if(!*dir) {
+			*dir = (void *) page;
+			/* We return since we will need another page
+                           in the next step */
 			return ERR_PTR(-ENOMEM);
+		}
+		dir = ((void **)*dir) + index;
 	}
-	if(!(info->i_indirect[index])) {
-		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect[index])
+	if (!*dir) {
+		if (!page)
 			return ERR_PTR(-ENOMEM);
+		*dir = (void *)page;
 	}
-	
-	return info->i_indirect[index]+offset;
+	return ((swp_entry_t *)*dir) + offset;
 }
 
+/*
+ * shmem_alloc_entry - get the position of the swap entry for the
+ *                     page. If it does not exist allocate the entry
+ *
+ * @info:	info structure for the inode
+ * @index:	index of the page to find
+ */
+static inline swp_entry_t * shmem_alloc_entry (struct shmem_inode_info *info, unsigned long index)
+{
+	unsigned long page = 0;
+	swp_entry_t * res;
+
+	if (index >= SHMEM_MAX_BLOCKS)
+		return ERR_PTR(-EFBIG);
+
+	if (info->next_index <= index)
+		info->next_index = index + 1;
+
+	while ((res = shmem_swp_entry(info,index,page)) == ERR_PTR(-ENOMEM)) {
+		page = get_zeroed_page(GFP_USER);
+		if (!page)
+			break;
+	}
+	return res;
+}
+
+/*
+ * shmem_free_swp - free some swap entries in a directory
+ *
+ * @dir:   pointer to the directory
+ * @count: number of entries to scan
+ */
 static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
 {
 	swp_entry_t *ptr, entry;
@@ -135,71 +221,112 @@
 }
 
 /*
- * shmem_truncate_part - free a bunch of swap entries
+ * shmem_truncate_direct - free the swap entries of a whole doubly
+ *                         indirect block
  *
- * @dir:	pointer to swp_entries 
- * @size:	number of entries in dir
- * @start:	offset to start from
- * @freed:	counter for freed pages
+ * @dir:	pointer to the pointer to the block
+ * @start:	offset to start from (in pages)
+ * @len:	how many pages are stored in this block
  *
- * It frees the swap entries from dir+start til dir+size
- *
- * returns 0 if it truncated something, else (offset-size)
+ * Returns the number of freed swap entries.
  */
 
-static unsigned long 
-shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
-		     unsigned long start, unsigned long *freed) {
-	if (start > size)
-		return start - size;
-	if (dir)
-		*freed += shmem_free_swp (dir+start, size-start);
+static inline unsigned long 
+shmem_truncate_direct(swp_entry_t *** dir, unsigned long start, unsigned long len) {
+	swp_entry_t **last, **ptr;
+	unsigned long off, freed = 0;
+ 
+	if (!*dir)
+		return 0;
+
+	last = *dir + (len + ENTRIES_PER_PAGE-1) / ENTRIES_PER_PAGE;
+	off = start % ENTRIES_PER_PAGE;
+
+	for (ptr = *dir + start/ENTRIES_PER_PAGE; ptr < last; ptr++) {
+		if (!*ptr) {
+			off = 0;
+			continue;
+		}
+
+		if (!off) {
+			freed += shmem_free_swp(*ptr, ENTRIES_PER_PAGE);
+			free_page ((unsigned long) *ptr);
+			*ptr = 0;
+		} else {
+			freed += shmem_free_swp(*ptr+off,ENTRIES_PER_PAGE-off);
+			off = 0;
+		}
+	}
 	
-	return 0;
+	if (!start) {
+		free_page((unsigned long) *dir);
+		*dir = 0;
+	}
+	return freed;
+}
+
+/*
+ * shmem_truncate_indirect - truncate an inode
+ *
+ * @info:  the info structure of the inode
+ * @index: the index to truncate
+ *
+ * This function locates the last doubly indirect block and calls
+ * then shmem_truncate_direct to do the real work
+ */
+static inline unsigned long
+shmem_truncate_indirect(struct shmem_inode_info *info, unsigned long index)
+{
+	swp_entry_t ***base;
+	unsigned long baseidx, len, start;
+	unsigned long max = info->next_index-1;
+
+	if (max < SHMEM_NR_DIRECT) {
+		info->next_index = index;
+		return shmem_free_swp(info->i_direct + index,
+				      SHMEM_NR_DIRECT - index);
+	}
+
+	if (max < ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2 + SHMEM_NR_DIRECT) {
+		max -= SHMEM_NR_DIRECT;
+		base = (swp_entry_t ***) &info->i_indirect;
+		baseidx = SHMEM_NR_DIRECT;
+		len = max+1;
+	} else {
+		max -= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
+		if (max >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2)
+			BUG();
+
+		baseidx = max & ~(ENTRIES_PER_PAGE*ENTRIES_PER_PAGE-1);
+		base = (swp_entry_t ***) info->i_indirect + ENTRIES_PER_PAGE/2 + baseidx/ENTRIES_PER_PAGE/ENTRIES_PER_PAGE ;
+		len = max - baseidx + 1;
+		baseidx += ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
+	}
+
+	if (index > baseidx) {
+		info->next_index = index;
+		start = index - baseidx;
+	} else {
+		info->next_index = baseidx;
+		start = 0;
+	}
+	return shmem_truncate_direct(base, start, len);
 }
 
 static void shmem_truncate (struct inode * inode)
 {
-	int clear_base;
-	unsigned long index, start;
+	unsigned long index;
 	unsigned long freed = 0;
-	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (index > info->max_index)
-		goto out;
 
-	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
-
-	if (!(base = info->i_indirect))
-		goto out;
+	while (index < info->next_index) 
+		freed += shmem_truncate_indirect(info, index);
 
-	clear_base = 1;
-	last = base + ((info->max_index - SHMEM_NR_DIRECT + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE);
-	for (ptr = base; ptr < last; ptr++) {
-		if (!start) {
-			if (!*ptr)
-				continue;
-			freed += shmem_free_swp (*ptr, ENTRIES_PER_PAGE);
-			free_page ((unsigned long) *ptr);
-			*ptr = 0;
-			continue;
-		}
-		clear_base = 0;
-		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, &freed);
-	}
-
-	if (clear_base) {
-		free_page ((unsigned long)base);
-		info->i_indirect = 0;
-	}
-
-out:
-	info->max_index = index;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode, freed);
 	spin_unlock (&info->lock);
@@ -253,7 +380,7 @@
 		goto out;
 
 	spin_lock(&info->lock);
-	entry = shmem_swp_entry(info, page->index);
+	entry = shmem_swp_entry(info, page->index, 0);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
 	shmem_recalc_inode(page->mapping->host, 0);
@@ -302,13 +429,13 @@
 	if (page)
 		return page;
 
-	entry = shmem_swp_entry (info, idx);
+	entry = shmem_alloc_entry (info, idx);
 	if (IS_ERR(entry))
 		return (void *)entry;
 
 	spin_lock (&info->lock);
 	
-	/* The shmem_swp_entry() call may have blocked, and
+	/* The shmem_alloc_entry() call may have blocked, and
 	 * shmem_writepage may have been moving a page between the page
 	 * cache and swap cache.  We need to recheck the page cache
 	 * under the protection of the info->lock spinlock. */
@@ -671,9 +798,6 @@
 			buf += bytes;
 			if (pos > inode->i_size) 
 				inode->i_size = pos;
-			if (info->max_index <= index)
-				info->max_index = index+1;
-
 		}
 unlock:
 		/* Mark it unlocked again and drop the page.. */
@@ -1127,7 +1251,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1259,26 +1383,25 @@
 
 static int shmem_unuse_inode (struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
-	swp_entry_t **base, **ptr;
+	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
 	
 	idx = 0;
 	spin_lock (&info->lock);
-	if ((offset = shmem_clear_swp (entry,info->i_direct, SHMEM_NR_DIRECT)) >= 0)
+	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
+	if (offset >= 0)
 		goto found;
 
-	idx = SHMEM_NR_DIRECT;
-	if (!(base = info->i_indirect))
-		goto out;
-
-	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
-		if (*ptr &&
-		    (offset = shmem_clear_swp (entry, *ptr, ENTRIES_PER_PAGE)) >= 0)
+	for (idx = SHMEM_NR_DIRECT; idx < info->next_index; 
+	     idx += ENTRIES_PER_PAGE) {
+		ptr = shmem_swp_entry(info, idx, 0);
+		if (IS_ERR(ptr))
+			continue;
+		offset = shmem_clear_swp (entry, ptr, ENTRIES_PER_PAGE);
+		if (offset >= 0)
 			goto found;
-		idx += ENTRIES_PER_PAGE;
 	}
-out:
 	spin_unlock (&info->lock);
 	return 0;
 found:

--=-=-=--

