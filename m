Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSJQXzR>; Thu, 17 Oct 2002 19:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262456AbSJQXzR>; Thu, 17 Oct 2002 19:55:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64664 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262445AbSJQXzG>; Thu, 17 Oct 2002 19:55:06 -0400
Date: Fri, 18 Oct 2002 01:01:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 8/9 loopable tmpfs
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180059220.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added shmem_readpage and shmem_prepare_write so tmpfs files can be used
by the loop driver (together with simple_commit_write).  shmem_getpage
extended to accept file page passed in, which may have to be copied
over from swap page.

Use bdget and sb_set_blocksize so loop can see our preferred blocksize
PAGE_CACHE_SIZE.  Use copy_highpage, removed from highmem.h in 2.4.17:
restore it but with kmap_atomics.  Restore (a simple) copy_page to
asm-sparc64/page.h, which alone of all arches discarded it.

--- tmpfs7/Documentation/filesystems/tmpfs.txt	Wed Mar 20 13:04:25 2002
+++ tmpfs8/Documentation/filesystems/tmpfs.txt	Thu Oct 17 22:01:59 2002
@@ -47,10 +47,9 @@
    shared memory)
 
 3) Some people (including me) find it very convenient to mount it
-   e.g. on /tmp and /var/tmp and have a big swap partition. But be
-   aware: loop mounts of tmpfs files do not work due to the internal
-   design. So mkinitrd shipped by most distributions will fail with a
-   tmpfs /tmp.
+   e.g. on /tmp and /var/tmp and have a big swap partition. And now
+   loop mounts of tmpfs files do work, so mkinitrd shipped by most
+   distributions should succeed with a tmpfs /tmp.
 
 4) And probably a lot more I do not know about :-)
 
@@ -90,13 +89,9 @@
    size=50% the tmpfs instance should be able to grow to 50 percent of
    RAM + swap. So the instance should adapt automatically if you add
    or remove swap space.
-2) loop mounts: This is difficult since loop.c relies on the readpage
-   operation. This operation gets a page from the caller to be filled
-   with the content of the file at that position. But tmpfs always has
-   the page and thus cannot copy the content to the given page. So it
-   cannot provide this operation. The VM had to be changed seriously
-   to achieve this.
-3) Show the number of tmpfs RAM pages. (As shared?)
+2) Show the number of tmpfs RAM pages. (As shared?)
 
 Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
+Updated:
+   Hugh Dickins <hugh@veritas.com>, 17 Oct 2002
--- tmpfs7/include/asm-sparc64/page.h	Mon Oct  7 20:37:47 2002
+++ tmpfs8/include/asm-sparc64/page.h	Thu Oct 17 22:01:59 2002
@@ -39,6 +39,7 @@
 #define clear_page(X)	_clear_page((void *)(X))
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
+#define copy_page(X,Y)	__memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
 extern void copy_user_page(void *to, void *from, unsigned long vaddr, struct page *topage);
 
 /* GROSS, defining this makes gcc pass these types as aggregates,
--- tmpfs7/include/linux/highmem.h	Mon Sep 16 05:51:51 2002
+++ tmpfs8/include/linux/highmem.h	Thu Oct 17 22:01:59 2002
@@ -73,4 +73,15 @@
 	kunmap_atomic(vto, KM_USER1);
 }
 
+static inline void copy_highpage(struct page *to, struct page *from)
+{
+	char *vfrom, *vto;
+
+	vfrom = kmap_atomic(from, KM_USER0);
+	vto = kmap_atomic(to, KM_USER1);
+	copy_page(vto, vfrom);
+	kunmap_atomic(vfrom, KM_USER0);
+	kunmap_atomic(vto, KM_USER1);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
--- tmpfs7/mm/shmem.c	Thu Oct 17 22:01:49 2002
+++ tmpfs8/mm/shmem.c	Thu Oct 17 22:01:59 2002
@@ -735,39 +735,48 @@
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
-	struct page *page;
+	struct page *filepage = *pagep;
+	struct page *swappage;
 	swp_entry_t *entry;
 	swp_entry_t swap;
-	int error = 0;
+	int error;
 
 	if (idx >= SHMEM_MAX_INDEX)
 		return -EFBIG;
+	/*
+	 * Normally, filepage is NULL on entry, and either found
+	 * uptodate immediately, or allocated and zeroed, or read
+	 * in under swappage, which is then assigned to filepage.
+	 * But shmem_readpage and shmem_prepare_write pass in a locked
+	 * filepage, which may be found not uptodate by other callers
+	 * too, and may need to be copied from the swappage read in.
+	 */
 repeat:
-	page = find_lock_page(mapping, idx);
-	if (page) {
-		unlock_page(page);
-		*pagep = page;
-		return 0;
-	}
+	if (!filepage)
+		filepage = find_lock_page(mapping, idx);
+	if (filepage && PageUptodate(filepage))
+		goto done;
+	error = 0;
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
 	entry = shmem_swp_alloc(info, idx, sgp);
 	if (IS_ERR(entry)) {
 		spin_unlock(&info->lock);
-		return PTR_ERR(entry);
+		error = PTR_ERR(entry);
+		goto failed;
 	}
 	swap = *entry;
 
 	if (swap.val) {
 		/* Look it up and read it in.. */
-		page = lookup_swap_cache(swap);
-		if (!page) {
+		swappage = lookup_swap_cache(swap);
+		if (!swappage) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			swapin_readahead(swap);
-			page = read_swap_cache_async(swap);
-			if (!page) {
+			swappage = read_swap_cache_async(swap);
+			if (!swappage) {
 				spin_lock(&info->lock);
 				entry = shmem_swp_alloc(info, idx, sgp);
 				if (IS_ERR(entry))
@@ -779,110 +788,152 @@
 				}
 				spin_unlock(&info->lock);
 				if (error)
-					return error;
+					goto failed;
 				goto repeat;
 			}
-			wait_on_page_locked(page);
-			page_cache_release(page);
+			wait_on_page_locked(swappage);
+			page_cache_release(swappage);
 			goto repeat;
 		}
 
 		/* We have to do this with page locked to prevent races */
-		if (TestSetPageLocked(page)) {
+		if (TestSetPageLocked(swappage)) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
-			wait_on_page_locked(page);
-			page_cache_release(page);
+			wait_on_page_locked(swappage);
+			page_cache_release(swappage);
 			goto repeat;
 		}
-		if (PageWriteback(page)) {
+		if (PageWriteback(swappage)) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
-			wait_on_page_writeback(page);
-			unlock_page(page);
-			page_cache_release(page);
+			wait_on_page_writeback(swappage);
+			unlock_page(swappage);
+			page_cache_release(swappage);
 			goto repeat;
 		}
-
-		error = PageUptodate(page)?
-			move_from_swap_cache(page, idx, mapping): -EIO;
-		if (error) {
+		if (!PageUptodate(swappage)) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
-			unlock_page(page);
-			page_cache_release(page);
-			return error;
+			unlock_page(swappage);
+			page_cache_release(swappage);
+			error = -EIO;
+			goto failed;
 		}
 
-		shmem_swp_set(info, entry, 0);
-		shmem_swp_unmap(entry);
-		spin_unlock(&info->lock);
-		swap_free(swap);
-	} else if (sgp == SGP_READ) {
+		if (filepage) {
+			shmem_swp_set(info, entry, 0);
+			shmem_swp_unmap(entry);
+			delete_from_swap_cache(swappage);
+			spin_unlock(&info->lock);
+			flush_page_to_ram(swappage);
+			copy_highpage(filepage, swappage);
+			unlock_page(swappage);
+			page_cache_release(swappage);
+			flush_dcache_page(filepage);
+			SetPageUptodate(filepage);
+			set_page_dirty(filepage);
+			swap_free(swap);
+		} else if (!(error = move_from_swap_cache(
+				swappage, idx, mapping))) {
+			shmem_swp_set(info, entry, 0);
+			shmem_swp_unmap(entry);
+			spin_unlock(&info->lock);
+			filepage = swappage;
+			swap_free(swap);
+		} else {
+			shmem_swp_unmap(entry);
+			spin_unlock(&info->lock);
+			unlock_page(swappage);
+			page_cache_release(swappage);
+			if (error != -EEXIST)
+				goto failed;
+			goto repeat;
+		}
+	} else if (sgp == SGP_READ && !filepage) {
 		shmem_swp_unmap(entry);
-		page = find_get_page(mapping, idx);
-		if (page && TestSetPageLocked(page)) {
+		filepage = find_get_page(mapping, idx);
+		if (filepage &&
+		    (!PageUptodate(filepage) || TestSetPageLocked(filepage))) {
 			spin_unlock(&info->lock);
-			wait_on_page_locked(page);
-			page_cache_release(page);
+			wait_on_page_locked(filepage);
+			page_cache_release(filepage);
+			filepage = NULL;
 			goto repeat;
 		}
 		spin_unlock(&info->lock);
 	} else {
 		shmem_swp_unmap(entry);
-		spin_unlock(&info->lock);
 		sbinfo = SHMEM_SB(inode->i_sb);
 		spin_lock(&sbinfo->stat_lock);
 		if (sbinfo->free_blocks == 0) {
 			spin_unlock(&sbinfo->stat_lock);
-			return -ENOSPC;
+			spin_unlock(&info->lock);
+			error = -ENOSPC;
+			goto failed;
 		}
 		sbinfo->free_blocks--;
 		inode->i_blocks += BLOCKS_PER_PAGE;
 		spin_unlock(&sbinfo->stat_lock);
 
-		page = page_cache_alloc(mapping);
-		if (!page) {
-			shmem_free_block(inode);
-			return -ENOMEM;
-		}
-
-		spin_lock(&info->lock);
-		entry = shmem_swp_alloc(info, idx, sgp);
-		if (IS_ERR(entry))
-			error = PTR_ERR(entry);
-		else {
-			swap = *entry;
-			shmem_swp_unmap(entry);
-		}
-		if (error || swap.val ||
-		    add_to_page_cache_lru(page, mapping, idx) < 0) {
+		if (!filepage) {
 			spin_unlock(&info->lock);
-			page_cache_release(page);
-			shmem_free_block(inode);
-			if (error)
-				return error;
-			goto repeat;
+			filepage = page_cache_alloc(mapping);
+			if (!filepage) {
+				shmem_free_block(inode);
+				error = -ENOMEM;
+				goto failed;
+			}
+
+			spin_lock(&info->lock);
+			entry = shmem_swp_alloc(info, idx, sgp);
+			if (IS_ERR(entry))
+				error = PTR_ERR(entry);
+			else {
+				swap = *entry;
+				shmem_swp_unmap(entry);
+			}
+			if (error || swap.val ||
+			    (error = add_to_page_cache_lru(
+					filepage, mapping, idx))) {
+				spin_unlock(&info->lock);
+				page_cache_release(filepage);
+				shmem_free_block(inode);
+				filepage = NULL;
+				if (error != -EEXIST)
+					goto failed;
+				goto repeat;
+			}
 		}
+
 		info->alloced++;
 		spin_unlock(&info->lock);
-		clear_highpage(page);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
+		clear_highpage(filepage);
+		flush_dcache_page(filepage);
+		SetPageUptodate(filepage);
+	}
+done:
+	if (!*pagep) {
+		if (filepage) {
+			unlock_page(filepage);
+			*pagep = filepage;
+		} else
+			*pagep = ZERO_PAGE(0);
 	}
-
-	if (page) {
-		unlock_page(page);
-		*pagep = page;
-	} else
-		*pagep = ZERO_PAGE(0);
 	return 0;
+
+failed:
+	if (*pagep != filepage) {
+		unlock_page(filepage);
+		page_cache_release(filepage);
+	}
+	return error;
 }
 
 struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long idx;
 	int error;
 
@@ -1007,13 +1058,33 @@
 static struct inode_operations shmem_symlink_inode_operations;
 static struct inode_operations shmem_symlink_inline_operations;
 
+/*
+ * tmpfs itself makes no use of generic_file_read, generic_file_mmap
+ * or generic_file_write; but shmem_readpage, shmem_prepare_write and
+ * simple_commit_write let a tmpfs file be used below the loop driver.
+ */
+static int
+shmem_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	int error = shmem_getpage(inode, page->index, &page, SGP_CACHE);
+	unlock_page(page);
+	return error;
+}
+
+static int
+shmem_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	return shmem_getpage(inode, page->index, &page, SGP_WRITE);
+}
+
 static ssize_t
 shmem_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
-	struct page	*page;
 	unsigned long	written;
 	long		status;
 	int		err;
@@ -1110,6 +1181,7 @@
 	}
 
 	while (count) {
+		struct page *page = NULL;
 		unsigned long bytes, index, offset;
 		char *kaddr;
 		int left;
@@ -1188,7 +1260,7 @@
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	for (;;) {
-		struct page *page;
+		struct page *page = NULL;
 		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
@@ -1416,7 +1488,7 @@
 	int error;
 	int len;
 	struct inode *inode;
-	struct page *page;
+	struct page *page = NULL;
 	char *kaddr;
 	struct shmem_inode_info *info;
 
@@ -1474,7 +1546,7 @@
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
-	struct page *page;
+	struct page *page = NULL;
 	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
 	if (res)
 		return res;
@@ -1486,7 +1558,7 @@
 
 static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct page *page;
+	struct page *page = NULL;
 	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
 	if (res)
 		return res;
@@ -1592,7 +1664,7 @@
 	gid_t gid = current->fsgid;
 	struct shmem_sb_info *sbinfo;
 	struct sysinfo si;
-	int err;
+	int err = -ENOMEM;
 
 	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
 	if (!sbinfo)
@@ -1622,28 +1694,29 @@
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
-	sb->s_blocksize = PAGE_CACHE_SIZE;
-	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_bdev = bdget(sb->s_dev);
+	if (!sb->s_bdev)
+		goto failed;
+	if (!sb_set_blocksize(sb, PAGE_CACHE_SIZE))
+		BUG();
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
-	if (!inode) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
+	if (!inode)
+		goto failed_bdput;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
 	root = d_alloc_root(inode);
-	if (!root) {
-		err = -ENOMEM;
+	if (!root)
 		goto failed_iput;
-	}
 	sb->s_root = root;
 	return 0;
 
 failed_iput:
 	iput(inode);
+failed_bdput:
+	bdput(sb->s_bdev);
+	sb->s_bdev = NULL;
 failed:
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
@@ -1652,6 +1725,8 @@
 
 static void shmem_put_super(struct super_block *sb)
 {
+	bdput(sb->s_bdev);
+	sb->s_bdev = NULL;
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
 }
@@ -1704,6 +1779,11 @@
 	.writepages	= shmem_writepages,
 	.vm_writeback	= shmem_vm_writeback,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
+#ifdef CONFIG_TMPFS
+	.readpage	= shmem_readpage,
+	.prepare_write	= shmem_prepare_write,
+	.commit_write	= simple_commit_write,
+#endif
 };
 
 static struct file_operations shmem_file_operations = {

