Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAPSdC>; Tue, 16 Jan 2001 13:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRAPScm>; Tue, 16 Jan 2001 13:32:42 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:10456 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129805AbRAPSci>; Tue, 16 Jan 2001 13:32:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch2] swapfs fixes against ac9
In-Reply-To: <qwwg0ije5ys.fsf@sap.com>
From: Christoph Rohland <cr@sap.com>
Date: 16 Jan 2001 19:31:05 +0100
In-Reply-To: <qwwg0ije5ys.fsf@sap.com>
Message-ID: <qwwbst7e4d2.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 16 Jan 2001, Christoph Rohland wrote:
> Hi Alan,
> 
> Here comes a patch for swapfs which has all my fixes against
> -ac9. It does the following:
> 
> - Fix IPC_LOCK (also in 2.4.1-pre7) - Do accounting right (Also send
> to Linus) - memparse returns unsigned long long (Also send to Linus)
> - Fix the unresolved symbols w/o CONFIG_SWAPFS - Introduce size
> parameter and let nr_blocks and nr_inodes use memparse - fix some
> size limit/truncate bugs - fix write support on highmem machines -
> set sb_maxbytes in superblock for ac kernel (Alan, wouldn't it be
> better to do this in blocks instead of bytes?)
> 
> No, I did not change the name again yet. I tend to change it to
> "tmpfs". It's not as nice as "vmfs" but the admins will know it. But
> I will wait some more until changing that.

Oh, and again I forgot to compile with CONFIG_SWAPFS=n and shmem_lock
slipped into the wrong area. Here is a new patch...

Greetings
		Christoph

diff -uNr 2.4.0-ac9/arch/i386/kernel/setup.c 2.4.0-ac9-cr/arch/i386/kernel/setup.c
--- 2.4.0-ac9/arch/i386/kernel/setup.c	Mon Jan 15 09:27:13 2001
+++ 2.4.0-ac9-cr/arch/i386/kernel/setup.c	Tue Jan 16 19:06:03 2001
@@ -558,7 +558,7 @@
 				 * blow away any automatically generated
 				 * size
 				 */
-				unsigned long start_at, mem_size;
+				unsigned long long start_at, mem_size;
  
 				if (usermem == 0) {
 					/* first time in: zap the whitelist
diff -uNr 2.4.0-ac9/include/linux/kernel.h 2.4.0-ac9-cr/include/linux/kernel.h
--- 2.4.0-ac9/include/linux/kernel.h	Mon Jan 15 09:27:19 2001
+++ 2.4.0-ac9-cr/include/linux/kernel.h	Tue Jan 16 19:06:03 2001
@@ -62,7 +62,7 @@
 extern int vsprintf(char *buf, const char *, va_list);
 extern int get_option(char **str, int *pint);
 extern char *get_options(char *str, int nints, int *ints);
-extern unsigned long memparse(char *ptr, char **retptr);
+extern unsigned long long memparse(char *ptr, char **retptr);
 
 extern int session_of_pgrp(int pgrp);
 
diff -uNr 2.4.0-ac9/include/linux/mm.h 2.4.0-ac9-cr/include/linux/mm.h
--- 2.4.0-ac9/include/linux/mm.h	Tue Jan 16 14:01:02 2001
+++ 2.4.0-ac9-cr/include/linux/mm.h	Tue Jan 16 19:07:21 2001
@@ -386,6 +386,7 @@
 
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share);
 struct file *shmem_file_setup(char * name, loff_t size);
+extern void shmem_lock(struct file * file, int lock);
 extern int shmem_zero_setup(struct vm_area_struct *);
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
diff -uNr 2.4.0-ac9/ipc/shm.c 2.4.0-ac9-cr/ipc/shm.c
--- 2.4.0-ac9/ipc/shm.c	Mon Jan 15 09:27:19 2001
+++ 2.4.0-ac9-cr/ipc/shm.c	Tue Jan 16 19:06:03 2001
@@ -123,6 +123,7 @@
 {
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
+	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	kfree (shp);
 }
@@ -469,10 +470,10 @@
 		if(err)
 			goto out_unlock;
 		if(cmd==SHM_LOCK) {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 1;
+			shmem_lock(shp->shm_file, 1);
 			shp->shm_flags |= SHM_LOCKED;
 		} else {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 0;
+			shmem_lock(shp->shm_file, 0);
 			shp->shm_flags &= ~SHM_LOCKED;
 		}
 		shm_unlock(shmid);
diff -uNr 2.4.0-ac9/lib/cmdline.c 2.4.0-ac9-cr/lib/cmdline.c
--- 2.4.0-ac9/lib/cmdline.c	Sat Aug 12 04:14:46 2000
+++ 2.4.0-ac9-cr/lib/cmdline.c	Tue Jan 16 19:06:03 2001
@@ -93,9 +93,9 @@
  *	megabyte, or one gigabyte, respectively.
  */
 
-unsigned long memparse (char *ptr, char **retptr)
+unsigned long long memparse (char *ptr, char **retptr)
 {
-	unsigned long ret = simple_strtoul (ptr, retptr, 0);
+	unsigned long long ret = simple_strtoull (ptr, retptr, 0);
 
 	switch (**retptr) {
 	case 'G':
diff -uNr 2.4.0-ac9/mm/shmem.c 2.4.0-ac9-cr/mm/shmem.c
--- 2.4.0-ac9/mm/shmem.c	Mon Jan 15 09:27:19 2001
+++ 2.4.0-ac9-cr/mm/shmem.c	Tue Jan 16 19:10:50 2001
@@ -1,5 +1,5 @@
 /*
- * Resizable simple swap filesystem for Linux.
+ * Resizable virtual memory filesystem for Linux.
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
@@ -9,9 +9,9 @@
  */
 
 /*
- * This shared memory handling is heavily based on the ramfs. It
- * extends the ramfs by the ability to use swap and honor resource
- * limits which makes it a completely usable filesystem.
+ * This virtual memory filesystem is heavily based on the ramfs. It
+ * extends ramfs by the ability to use swap and honor resource limits
+ * which makes it a completely usable filesystem.
  */
 
 #include <linux/module.h>
@@ -45,6 +45,38 @@
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * shmem_recalc_inode - recalculate the size of an inode
+ *
+ * @inode: inode to recalc
+ *
+ * We have to calculate the free blocks since the mm can drop pages
+ * behind our back
+ *
+ * But we know that normally
+ * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
+ *
+ * So the mm freed 
+ * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
+ *
+ * It has to be called with the spinlock held.
+ */
+
+static void shmem_recalc_inode(struct inode * inode)
+{
+	unsigned long freed;
+
+	freed = inode->i_blocks -
+		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
+	if (freed){
+		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
+		inode->i_blocks -= freed;
+		spin_lock (&info->stat_lock);
+		info->free_blocks += freed;
+		spin_unlock (&info->stat_lock);
+	}
+}
+
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
 {
 	unsigned long offset;
@@ -122,7 +154,7 @@
 {
 	int clear_base;
 	unsigned long index, start;
-	unsigned long mmfreed, freed = 0;
+	unsigned long freed = 0;
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
@@ -158,26 +190,9 @@
 
 out:
 	info->max_index = index;
-
-	/*
-	 * We have to calculate the free blocks since we do not know
-	 * how many pages the mm discarded
-	 *
-	 * But we know that normally
-	 * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
-	 *
-	 * So the mm freed 
-	 * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
-	 */
-
-	mmfreed = inode->i_blocks - (inode->i_mapping->nrpages + info->swapped);
 	info->swapped -= freed;
-	inode->i_blocks -= freed + mmfreed;
+	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
-
-	spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
-	inode->i_sb->u.shmem_sb.free_blocks += freed + mmfreed;
-	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
 }
 
 static void shmem_delete_inode(struct inode * inode)
@@ -212,6 +227,7 @@
 		return 1;
 
 	spin_lock(&info->lock);
+	shmem_recalc_inode(page->mapping->host);
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
@@ -238,6 +254,13 @@
 	return error;
 }
 
+/*
+ * shmem_getpage_locked - either get the page from swap or allocate a new one
+ *
+ * If we allocate a new one we do not mark it dirty. That's up to the
+ * vm. If we swap it in we mark it dirty since we also free the swap
+ * entry since a page cannot live in both the swap and page cache
+ */
 static struct page * shmem_getpage_locked(struct inode * inode, unsigned long idx)
 {
 	struct address_space * mapping = inode->i_mapping;
@@ -271,8 +294,8 @@
 		lock_page(page);
 		spin_lock (&info->lock);
 		swap_free(*entry);
-		delete_from_swap_cache_nolock(page);
 		*entry = (swp_entry_t) {0};
+		delete_from_swap_cache_nolock(page);
 		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
 		page->flags = flags | (1 << PG_dirty);
 		add_to_page_cache_locked(page, mapping, idx);
@@ -293,27 +316,22 @@
 		add_to_page_cache (page, mapping, idx);
 	}
 	/* We have the page */
-	SetPageUptodate (page);
+	SetPageUptodate(page);
+	if (info->locked)
+		page_cache_get(page);
 	return page;
 no_space:
 	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
 	return ERR_PTR(-ENOSPC);
 }
 
-/*
- * shmem_getpage - either get the page from swap or allocate a new one
- *
- * If we allocate a new one we do not mark it dirty. That's up to the
- * vm. If we swap it in we mark it dirty since we also free the swap
- * entry since a page cannot live in both the swap and page cache
- */
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
 {
 	struct address_space * mapping = inode->i_mapping;
 	int error;
 
 	*ptr = NOPAGE_SIGBUS;
-	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
+	if (inode->i_size <= (loff_t) idx * PAGE_CACHE_SIZE)
 		return -EFAULT;
 
 	*ptr = __find_get_page(mapping, idx, page_hash(mapping, idx));
@@ -373,6 +391,32 @@
 	return(page);
 }
 
+void shmem_lock(struct file * file, int lock)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct page * page;
+	unsigned long idx, size;
+
+	if (info->locked == lock)
+		return;
+	down(&inode->i_sem);
+	info->locked = lock;
+	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	for (idx = 0; idx < size; idx++) {
+		page = find_lock_page(inode->i_mapping, idx);
+		if (!page)
+			continue;
+		if (!lock) {
+			/* release the extra count and our reference */
+			page_cache_release(page);
+			page_cache_release(page);
+		}
+		UnlockPage(page);
+	}
+	up(&inode->i_sem);
+}
+
 static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
 {
 	struct vm_operations_struct * ops;
@@ -525,6 +569,7 @@
 		kaddr = kmap(page);
 // can this do a truncated write? cr
 		status = copy_from_user(kaddr+offset, buf, bytes);
+		kunmap(page);
 		if (status)
 			goto fail_write;
 
@@ -859,16 +904,24 @@
 	for ( ; this_char; this_char = strtok(NULL,",")) {
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
-		if (!strcmp(this_char,"nr_blocks")) {
+		if (!strcmp(this_char,"size")) {
+			unsigned long long size;
 			if (!value || !*value || !blocks)
 				return 1;
-			*blocks = simple_strtoul(value,&value,0);
+			size = memparse(value,&value);
+			if (*value)
+				return 1;
+			*blocks = size >> PAGE_CACHE_SHIFT;
+		} else if (!strcmp(this_char,"nr_blocks")) {
+			if (!value || !*value || !blocks)
+				return 1;
+			*blocks = memparse(value,&value);
 			if (*value)
 				return 1;
 		} else if (!strcmp(this_char,"nr_inodes")) {
 			if (!value || !*value || !inodes)
 				return 1;
-			*inodes = simple_strtoul(value,&value,0);
+			*inodes = memparse(value,&value);
 			if (*value)
 				return 1;
 		} else if (!strcmp(this_char,"mode")) {
@@ -933,6 +986,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
+	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = SWAPFS_MAGIC;
@@ -968,8 +1022,10 @@
 
 static struct inode_operations shmem_symlink_inode_operations = {
 	truncate:	shmem_truncate,
+#ifdef CONFIG_SWAPFS
 	readlink:	shmem_readlink,
 	follow_link:	shmem_follow_link,
+#endif
 };
 
 static struct file_operations shmem_dir_operations = {
@@ -1018,7 +1074,7 @@
 	struct vfsmount * res;
 
 	if ((error = register_filesystem(&swapfs_fs_type))) {
-		printk (KERN_ERR "Could not register swapfs fs\n");
+		printk (KERN_ERR "Could not register swapfs\n");
 		return error;
 	}
 #ifdef CONFIG_SWAPFS
@@ -1030,7 +1086,7 @@
 #endif
 	res = kern_mount(&swapfs_fs_type);
 	if (IS_ERR (res)) {
-		printk (KERN_ERR "could not kern_mount swapfs fs\n");
+		printk (KERN_ERR "could not kern_mount swapfs\n");
 		unregister_filesystem(&swapfs_fs_type);
 		return PTR_ERR(res);
 	}
@@ -1156,6 +1212,7 @@
 
 	d_instantiate(dentry, inode);
 	dentry->d_inode->i_size = size;
+	shmem_truncate(inode);
 	file->f_vfsmnt = mntget(swapfs_fs_type.kern_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
