Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbRAMKpj>; Sat, 13 Jan 2001 05:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136280AbRAMKp3>; Sat, 13 Jan 2001 05:45:29 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32419 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S136088AbRAMKpM>; Sat, 13 Jan 2001 05:45:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] read/write support for shm fs
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3ae8v211w.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 13 Jan 2001 11:49:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Here is a patch which makes the shm fs a full swappable file system
like Solaris' tmpfs.

Does anybody have a really good fs check tool? Not benchmarking, but
concurrent truncate, read, write, unlink stress test. Would be good to
test it with that. I did my usual POSIX/SYSV shm tests which it
survived quite easily.

The patch is additional to my truncate patch which is included in
2.4.0-ac8.

Greetings
                Christoph


diff -uNr 2.4.0-shm_vm_locked-truncate/include/linux/fs.h 2.4.0-shm_vm_locked-truncate-rw/include/linux/fs.h
--- 2.4.0-shm_vm_locked-truncate/include/linux/fs.h	Fri Jan 12 22:58:58 2001
+++ 2.4.0-shm_vm_locked-truncate-rw/include/linux/fs.h	Sat Jan 13 10:12:32 2001
@@ -1198,6 +1198,7 @@
 	}
 	return inode;
 }
+extern void remove_suid(struct inode *inode);
 
 extern void insert_inode_hash(struct inode *);
 extern void remove_inode_hash(struct inode *);
@@ -1245,6 +1246,7 @@
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
+extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
diff -uNr 2.4.0-shm_vm_locked-truncate/include/linux/mm.h 2.4.0-shm_vm_locked-truncate-rw/include/linux/mm.h
--- 2.4.0-shm_vm_locked-truncate/include/linux/mm.h	Wed Jan 10 21:48:18 2001
+++ 2.4.0-shm_vm_locked-truncate-rw/include/linux/mm.h	Sat Jan 13 10:22:00 2001
@@ -200,8 +200,8 @@
 					smp_mb__before_clear_bit(); \
 					if (!test_and_clear_bit(PG_locked, &(page)->flags)) BUG(); \
 					smp_mb__after_clear_bit(); \
-					if (waitqueue_active(&page->wait)) \
-						wake_up(&page->wait); \
+					if (waitqueue_active(&(page)->wait)) \
+						wake_up(&(page)->wait); \
 				} while (0)
 #define PageError(page)		test_bit(PG_error, &(page)->flags)
 #define SetPageError(page)	set_bit(PG_error, &(page)->flags)
diff -uNr 2.4.0-shm_vm_locked-truncate/mm/filemap.c 2.4.0-shm_vm_locked-truncate-rw/mm/filemap.c
--- 2.4.0-shm_vm_locked-truncate/mm/filemap.c	Fri Jan  5 10:33:50 2001
+++ 2.4.0-shm_vm_locked-truncate-rw/mm/filemap.c	Sat Jan 13 09:52:06 2001
@@ -1212,7 +1212,7 @@
 	UPDATE_ATIME(inode);
 }
 
-static int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	char *kaddr;
 	unsigned long left, count = desc->count;
@@ -2408,7 +2408,7 @@
 	return page;
 }
 
-static inline void remove_suid(struct inode *inode)
+inline void remove_suid(struct inode *inode)
 {
 	unsigned int mode;
 
diff -uNr 2.4.0-shm_vm_locked-truncate/mm/shmem.c 2.4.0-shm_vm_locked-truncate-rw/mm/shmem.c
--- 2.4.0-shm_vm_locked-truncate/mm/shmem.c	Thu Jan 11 08:12:06 2001
+++ 2.4.0-shm_vm_locked-truncate-rw/mm/shmem.c	Sat Jan 13 11:21:32 2001
@@ -10,11 +10,8 @@
 
 /*
  * This shared memory handling is heavily based on the ramfs. It
- * extends the ramfs by the ability to use swap which would makes it a
- * completely usable filesystem.
- *
- * But read and write are not supported (yet)
- *
+ * extends the ramfs by the ability to use swap and honor resource
+ * limits which makes it a completely usable filesystem.
  */
 
 #include <linux/module.h>
@@ -42,8 +39,7 @@
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
-static struct vm_operations_struct shmem_shared_vm_ops;
-static struct vm_operations_struct shmem_private_vm_ops;
+static struct vm_operations_struct shmem_vm_ops;
 
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
@@ -60,17 +56,17 @@
 	index /= ENTRIES_PER_PAGE;
 
 	if (index >= ENTRIES_PER_PAGE)
-		return NULL;
+		return ERR_PTR(-EFBIG);
 
 	if (!info->i_indirect) {
 		info->i_indirect = (swp_entry_t **) get_zeroed_page(GFP_USER);
 		if (!info->i_indirect)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 	}
 	if(!(info->i_indirect[index])) {
 		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
 		if (!info->i_indirect[index])
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 	}
 	
 	return info->i_indirect[index]+offset;
@@ -131,11 +127,8 @@
 
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (index >= info->max_index) {
-		info->max_index = index;
-		spin_unlock (&info->lock);
-		return;
-	}
+	if (index >= info->max_index)
+		goto out;
 
 	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
 
@@ -217,7 +210,7 @@
 
 	spin_lock(&info->lock);
 	entry = shmem_swp_entry(info, page->index);
-	if (!entry)	/* this had been allocted on page allocation */
+	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
 	error = -EAGAIN;
 	if (entry->val) {
@@ -242,41 +235,21 @@
 	return error;
 }
 
-/*
- * shmem_nopage - either get the page from swap or allocate a new one
- *
- * If we allocate a new one we do not mark it dirty. That's up to the
- * vm. If we swap it in we mark it dirty since we also free the swap
- * entry since a page cannot live in both the swap and page cache
- */
-struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
+static struct page * shmem_getpage_locked(struct inode * inode, unsigned long idx)
 {
-	unsigned long size;
-	struct page * page;
-	unsigned int idx;
-	swp_entry_t *entry;
-	struct inode * inode = vma->vm_file->f_dentry->d_inode;
 	struct address_space * mapping = inode->i_mapping;
 	struct shmem_inode_info *info;
+	struct page * page;
+	swp_entry_t *entry;
 
-	idx = (address - vma->vm_start) >> PAGE_SHIFT;
-	idx += vma->vm_pgoff;
-
-	down (&inode->i_sem);
-	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	page = NOPAGE_SIGBUS;
-	if ((idx >= size) && (vma->vm_mm == current->mm))
-		goto out;
-
-	/* retry, we may have slept */
-	page = __find_lock_page(mapping, idx, page_hash (mapping, idx));
+	page = find_lock_page(mapping, idx);;
 	if (page)
-		goto cached_page;
+		return page;
 
 	info = &inode->u.shmem_i;
 	entry = shmem_swp_entry (info, idx);
-	if (!entry)
-		goto oom;
+	if (IS_ERR(entry))
+		return (void *)entry;
 	if (entry->val) {
 		unsigned long flags;
 
@@ -288,13 +261,13 @@
 			page = read_swap_cache(*entry);
 			unlock_kernel();
 			if (!page) 
-				goto oom;
+				return ERR_PTR(-ENOMEM);
 		}
 
 		/* We have to this with page locked to prevent races */
+		lock_page(page);
 		spin_lock (&info->lock);
 		swap_free(*entry);
-		lock_page(page);
 		delete_from_swap_cache_nolock(page);
 		*entry = (swp_entry_t) {0};
 		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
@@ -311,17 +284,75 @@
 		/* Ok, get a new page */
 		page = page_cache_alloc();
 		if (!page)
-			goto oom;
-		clear_user_highpage(page, address);
+			return ERR_PTR(-ENOMEM);
+		clear_highpage(page);
 		inode->i_blocks++;
 		add_to_page_cache (page, mapping, idx);
 	}
 	/* We have the page */
 	SetPageUptodate (page);
+	return page;
+no_space:
+	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+	return ERR_PTR(-ENOSPC);
+}
 
-cached_page:
-	UnlockPage (page);
-	up(&inode->i_sem);
+/*
+ * shmem_getpage - either get the page from swap or allocate a new one
+ *
+ * If we allocate a new one we do not mark it dirty. That's up to the
+ * vm. If we swap it in we mark it dirty since we also free the swap
+ * entry since a page cannot live in both the swap and page cache
+ */
+static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
+{
+	struct address_space * mapping = inode->i_mapping;
+	int error;
+
+	*ptr = NOPAGE_SIGBUS;
+	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
+		return -EFAULT;
+
+	*ptr = __find_get_page(mapping, idx, page_hash(mapping, idx));
+	if (*ptr) {
+		if (Page_Uptodate(*ptr))
+			return 0;
+		page_cache_release(*ptr);
+	}
+
+	down (&inode->i_sem);
+	/* retest we may have slept */
+	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
+		goto sigbus;
+	*ptr = shmem_getpage_locked(inode, idx);
+	if (IS_ERR (*ptr))
+		goto failed;
+	UnlockPage(*ptr);
+	up (&inode->i_sem);
+	return 0;
+failed:
+	up (&inode->i_sem);
+	error = PTR_ERR(*ptr);
+	*ptr = NOPAGE_OOM;
+	if (error != -EFBIG)
+		*ptr = NOPAGE_SIGBUS;
+	return error;
+sigbus:
+	*ptr = NOPAGE_SIGBUS;
+	return -EFAULT;
+}
+
+struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
+{
+	struct page * page;
+	unsigned int idx;
+	struct inode * inode = vma->vm_file->f_dentry->d_inode;
+
+	idx = (address - vma->vm_start) >> PAGE_SHIFT;
+	idx += vma->vm_pgoff;
+
+	if (shmem_getpage(inode, idx, &page))
+		return page;
 
 	if (no_share) {
 		struct page *new_page = page_cache_alloc();
@@ -337,13 +368,6 @@
 
 	flush_page_to_ram (page);
 	return(page);
-no_space:
-	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
-oom:
-	page = NOPAGE_OOM;
-out:
-	up(&inode->i_sem);
-	return page;
 }
 
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
@@ -392,6 +416,216 @@
 	return inode;
 }
 
+static ssize_t
+shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
+{
+	struct inode	*inode = file->f_dentry->d_inode; 
+	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	loff_t		pos;
+	struct page	*page;
+	unsigned long	written;
+	long		status;
+	int		err;
+
+
+	down(&inode->i_sem);
+
+	pos = *ppos;
+	err = -EINVAL;
+	if (pos < 0)
+		goto out;
+
+	err = file->f_error;
+	if (err) {
+		file->f_error = 0;
+		goto out;
+	}
+
+	written = 0;
+
+	if (file->f_flags & O_APPEND)
+		pos = inode->i_size;
+
+	/*
+	 * Check whether we've reached the file size limit.
+	 */
+	err = -EFBIG;
+	if (limit != RLIM_INFINITY) {
+		if (pos >= limit) {
+			send_sig(SIGXFSZ, current, 0);
+			goto out;
+		}
+		if (count > limit - pos) {
+			send_sig(SIGXFSZ, current, 0);
+			count = limit - pos;
+		}
+	}
+
+	status	= 0;
+	if (count) {
+		remove_suid(inode);
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	}
+
+	while (count) {
+		unsigned long bytes, index, offset;
+		char *kaddr;
+		int deactivate = 1;
+
+		/*
+		 * Try to find the page in the cache. If it isn't there,
+		 * allocate a free page.
+		 */
+		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
+		index = pos >> PAGE_CACHE_SHIFT;
+		bytes = PAGE_CACHE_SIZE - offset;
+		if (bytes > count) {
+			bytes = count;
+			deactivate = 0;
+		}
+
+		/*
+		 * Bring in the user page that we will copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 */
+		{ volatile unsigned char dummy;
+			__get_user(dummy, buf);
+			__get_user(dummy, buf+bytes-1);
+		}
+
+		page = shmem_getpage_locked(inode, index);
+		status = PTR_ERR(page);
+		if (IS_ERR(page))
+			break;
+
+		/* We have exclusive IO access to the page.. */
+		if (!PageLocked(page)) {
+			PAGE_BUG(page);
+		}
+
+		kaddr = kmap(page);
+// can this do a truncated write? cr
+		status = copy_from_user(kaddr+offset, buf, bytes);
+		if (status)
+			goto fail_write;
+
+		flush_dcache_page(page);
+		if (bytes > 0) {
+			SetPageDirty(page);
+			written += bytes;
+			count -= bytes;
+			pos += bytes;
+			buf += bytes;
+			if (pos > inode->i_size) 
+				inode->i_size = pos;
+                        if (inode->u.shmem_i.max_index < index)
+                                inode->u.shmem_i.max_index = index;
+
+		}
+unlock:
+		/* Mark it unlocked again and drop the page.. */
+		UnlockPage(page);
+		if (deactivate)
+			deactivate_page(page);
+		page_cache_release(page);
+
+		if (status < 0)
+			break;
+	}
+	*ppos = pos;
+
+	err = written ? written : status;
+out:
+	up(&inode->i_sem);
+	return err;
+fail_write:
+	status = -EFAULT;
+	ClearPageUptodate(page);
+	kunmap(page);
+	goto unlock;
+}
+
+static void do_shmem_file_read(struct file * filp, loff_t *ppos, read_descriptor_t * desc)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long index, offset;
+	int nr = 1;
+
+	index = *ppos >> PAGE_CACHE_SHIFT;
+	offset = *ppos & ~PAGE_CACHE_MASK;
+
+	while (nr && desc->count) {
+		struct page *page;
+		unsigned long end_index, nr;
+
+		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+		if (index > end_index)
+			break;
+		nr = PAGE_CACHE_SIZE;
+		if (index == end_index) {
+			nr = inode->i_size & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				break;
+		}
+
+		nr = nr - offset;
+
+		if ((desc->error = shmem_getpage(inode, index, &page)))
+			break;
+
+		if (mapping->i_mmap_shared != NULL)
+			flush_dcache_page(page);
+
+		/*
+		 * Ok, we have the page, and it's up-to-date, so
+		 * now we can copy it to user space...
+		 *
+		 * The actor routine returns how many bytes were actually used..
+		 * NOTE! This may not be the same as how much of a user buffer
+		 * we filled up (we may be padding etc), so we can only update
+		 * "pos" here (the actor routine has to update the user buffer
+		 * pointers and the remaining count).
+		 */
+		nr = file_read_actor(desc, page, offset, nr);
+		offset += nr;
+		index += offset >> PAGE_CACHE_SHIFT;
+		offset &= ~PAGE_CACHE_MASK;
+	
+		page_cache_release(page);
+	}
+
+	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
+	UPDATE_ATIME(inode);
+}
+
+static ssize_t shmem_file_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
+{
+	ssize_t retval;
+
+	retval = -EFAULT;
+	if (access_ok(VERIFY_WRITE, buf, count)) {
+		retval = 0;
+
+		if (count) {
+			read_descriptor_t desc;
+
+			desc.written = 0;
+			desc.count = count;
+			desc.buf = buf;
+			desc.error = 0;
+			do_shmem_file_read(filp, ppos, &desc);
+
+			retval = desc.written;
+			if (!retval)
+				retval = desc.error;
+		}
+	}
+	return retval;
+}
+
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
 {
 	buf->f_type = SHMEM_MAGIC;
@@ -554,9 +788,7 @@
 	struct vm_operations_struct * ops;
 	struct inode *inode = file->f_dentry->d_inode;
 
-	ops = &shmem_private_vm_ops;
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-		ops = &shmem_shared_vm_ops;
+	ops = &shmem_vm_ops;
 	if (!inode->i_sb || !S_ISREG(inode->i_mode))
 		return -EACCES;
 	UPDATE_ATIME(inode);
@@ -668,7 +900,9 @@
 };
 
 static struct file_operations shmem_file_operations = {
-	mmap:		shmem_mmap
+	mmap:	shmem_mmap,
+	read:	shmem_file_read,
+	write:	shmem_file_write
 };
 
 static struct inode_operations shmem_inode_operations = {
@@ -699,11 +933,7 @@
 	put_inode:	force_delete,	
 };
 
-static struct vm_operations_struct shmem_private_vm_ops = {
-	nopage:	shmem_nopage,
-};
-
-static struct vm_operations_struct shmem_shared_vm_ops = {
+static struct vm_operations_struct shmem_vm_ops = {
 	nopage:	shmem_nopage,
 };
 
@@ -876,6 +1106,6 @@
 	if (vma->vm_file)
 		fput (vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_shared_vm_ops;
+	vma->vm_ops = &shmem_vm_ops;
 	return 0;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
