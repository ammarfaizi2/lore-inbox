Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbTEHXUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEHXUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:20:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10632 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262249AbTEHXU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:20:26 -0400
Subject: [PATCH 2.5.69 2/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-lbpDsFpPNW7pCBUrljDO"
Organization: 
Message-Id: <1052436775.2492.41.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 May 2003 16:32:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lbpDsFpPNW7pCBUrljDO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds i_seqcnt to inode structure and then uses i_size_read() and
i_size_write() to provide atomic access to i_size.  This is port
of Andrea Arcangeli i_size atomic access patch from 2.4.  This only
uses the generic reader/writer consistent mechanism.

re-diff against 2.5.69.

This patch is available for download from OSDL's patch lifecycle 
manager (PLM):

http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1835


-- 
Daniel McNeil <daniel@osdl.org>

--=-lbpDsFpPNW7pCBUrljDO
Content-Disposition: attachment; filename=patch-2.5.69-isize.2
Content-Type: text/x-patch; name=patch-2.5.69-isize.2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff linux-2.5.69/drivers/block/loop.c linux-2.5.69-isize/drivers/block/loop.c
--- linux-2.5.69/drivers/block/loop.c	Sun May  4 16:53:32 2003
+++ linux-2.5.69-isize/drivers/block/loop.c	Wed May  7 16:08:46 2003
@@ -153,7 +153,7 @@ struct loop_func_table *xfer_funcs[MAX_L
 
 static int figure_loop_size(struct loop_device *lo)
 {
-	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	loff_t size = i_size_read(lo->lo_backing_file->f_dentry->d_inode->i_mapping->host);
 	sector_t x;
 	/*
 	 * Unfortunately, if we want to do I/O on the device,
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/attr.c linux-2.5.69-isize/fs/attr.c
--- linux-2.5.69/fs/attr.c	Sun May  4 16:53:02 2003
+++ linux-2.5.69-isize/fs/attr.c	Wed May  7 16:08:46 2003
@@ -68,7 +68,7 @@ int inode_setattr(struct inode * inode, 
 	int error = 0;
 
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != inode->i_size)
+		if (attr->ia_size != i_size_read(inode))
 			error = vmtruncate(inode, attr->ia_size);
 		if (error || (ia_valid == ATTR_SIZE))
 			goto out;
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/binfmt_aout.c linux-2.5.69-isize/fs/binfmt_aout.c
--- linux-2.5.69/fs/binfmt_aout.c	Sun May  4 16:53:07 2003
+++ linux-2.5.69-isize/fs/binfmt_aout.c	Wed May  7 16:08:46 2003
@@ -269,7 +269,7 @@ static int load_aout_binary(struct linux
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
 	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
 	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    bprm->file->f_dentry->d_inode->i_size < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(bprm->file->f_dentry->d_inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
 		return -ENOEXEC;
 	}
 
@@ -454,7 +454,7 @@ static int load_aout_library(struct file
 	/* We come in here for the regular a.out style of shared libraries */
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != QMAGIC) || N_TRSIZE(ex) ||
 	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) == ZMAGIC) ||
-	    inode->i_size < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
 		goto out;
 	}
 
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/block_dev.c linux-2.5.69-isize/fs/block_dev.c
--- linux-2.5.69/fs/block_dev.c	Sun May  4 16:53:57 2003
+++ linux-2.5.69-isize/fs/block_dev.c	Wed May  7 16:08:46 2003
@@ -29,7 +29,7 @@
 static sector_t max_block(struct block_device *bdev)
 {
 	sector_t retval = ~((sector_t)0);
-	loff_t sz = bdev->bd_inode->i_size;
+	loff_t sz = i_size_read(bdev->bd_inode);
 
 	if (sz) {
 		unsigned int size = block_size(bdev);
@@ -156,7 +156,7 @@ static int blkdev_commit_write(struct fi
 static loff_t block_llseek(struct file *file, loff_t offset, int origin)
 {
 	/* ewww */
-	loff_t size = file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
+	loff_t size = i_size_read(file->f_dentry->d_inode->i_bdev->bd_inode);
 	loff_t retval;
 
 	lock_kernel();
@@ -485,7 +485,7 @@ int check_disk_change(struct block_devic
 static void bd_set_size(struct block_device *bdev, loff_t size)
 {
 	unsigned bsize = bdev_hardsect_size(bdev);
-	bdev->bd_inode->i_size = size;
+	i_size_write(bdev->bd_inode, size);
 	while (bsize < PAGE_CACHE_SIZE) {
 		if (size & bsize)
 			break;
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/buffer.c linux-2.5.69-isize/fs/buffer.c
--- linux-2.5.69/fs/buffer.c	Sun May  4 16:53:32 2003
+++ linux-2.5.69-isize/fs/buffer.c	Wed May  7 16:08:46 2003
@@ -1697,7 +1697,7 @@ static int __block_write_full_page(struc
 
 	BUG_ON(!PageLocked(page));
 
-	last_block = (inode->i_size - 1) >> inode->i_blkbits;
+	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
 
 	if (!page_has_buffers(page)) {
 		if (!PageUptodate(page))
@@ -2033,7 +2033,7 @@ int block_read_full_page(struct page *pa
 	head = page_buffers(page);
 
 	iblock = (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
-	lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
+	lblock = (i_size_read(inode)+blocksize-1) >> inode->i_blkbits;
 	bh = head;
 	nr = 0;
 	i = 0;
@@ -2258,8 +2258,12 @@ int generic_commit_write(struct file *fi
 	struct inode *inode = page->mapping->host;
 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	__block_commit_write(inode,page,from,to);
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold i_sem.
+	 */
 	if (pos > inode->i_size) {
-		inode->i_size = pos;
+		i_size_write(inode, pos);
 		mark_inode_dirty(inode);
 	}
 	return 0;
@@ -2411,7 +2415,7 @@ int nobh_commit_write(struct file *file,
 
 	set_page_dirty(page);
 	if (pos > inode->i_size) {
-		inode->i_size = pos;
+		i_size_write(inode, pos);
 		mark_inode_dirty(inode);
 	}
 	return 0;
@@ -2541,7 +2545,8 @@ int block_write_full_page(struct page *p
 			struct writeback_control *wbc)
 {
 	struct inode * const inode = page->mapping->host;
-	const unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	loff_t i_size = i_size_read(inode);
+	const unsigned long end_index = i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
 	void *kaddr;
 
@@ -2550,7 +2555,7 @@ int block_write_full_page(struct page *p
 		return __block_write_full_page(inode, page, get_block, wbc);
 
 	/* Is the page fully outside i_size? (truncate in progress) */
-	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
+	offset = i_size & (PAGE_CACHE_SIZE-1);
 	if (page->index >= end_index+1 || !offset) {
 		/*
 		 * The page may have dirty, unmapped buffers.  For example,
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/ext3/inode.c linux-2.5.69-isize/fs/ext3/inode.c
--- linux-2.5.69/fs/ext3/inode.c	Sun May  4 16:53:35 2003
+++ linux-2.5.69-isize/fs/ext3/inode.c	Wed May  7 16:08:46 2003
@@ -1163,7 +1163,7 @@ static int ext3_commit_write(struct file
 		if (!partial)
 			SetPageUptodate(page);
 		if (pos > inode->i_size)
-			inode->i_size = pos;
+			i_size_write(inode, pos);
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
 		if (inode->i_size > EXT3_I(inode)->i_disksize) {
 			EXT3_I(inode)->i_disksize = inode->i_size;
@@ -1488,7 +1488,7 @@ out_stop:
 			loff_t end = offset + ret;
 			if (end > inode->i_size) {
 				ei->i_disksize = end;
-				inode->i_size = end;
+				i_size_write(inode, end);
 				err = ext3_mark_inode_dirty(handle, inode);
 				if (!ret) 
 					ret = err;
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/inode.c linux-2.5.69-isize/fs/inode.c
--- linux-2.5.69/fs/inode.c	Sun May  4 16:53:56 2003
+++ linux-2.5.69-isize/fs/inode.c	Wed May  7 16:08:46 2003
@@ -188,6 +188,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
+	i_size_ordered_init(inode);
 }
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/ioctl.c linux-2.5.69-isize/fs/ioctl.c
--- linux-2.5.69/fs/ioctl.c	Sun May  4 16:53:07 2003
+++ linux-2.5.69-isize/fs/ioctl.c	Wed May  7 16:08:46 2003
@@ -40,7 +40,7 @@ static int file_ioctl(struct file *filp,
 				return -EBADF;
 			return put_user(inode->i_sb->s_blocksize, (int *) arg);
 		case FIONREAD:
-			return put_user(inode->i_size - filp->f_pos, (int *) arg);
+			return put_user(i_size_read(inode) - filp->f_pos, (int *) arg);
 	}
 	if (filp->f_op && filp->f_op->ioctl)
 		return filp->f_op->ioctl(inode, filp, cmd, arg);
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/libfs.c linux-2.5.69-isize/fs/libfs.c
--- linux-2.5.69/fs/libfs.c	Sun May  4 16:52:49 2003
+++ linux-2.5.69-isize/fs/libfs.c	Wed May  7 16:08:46 2003
@@ -330,8 +330,12 @@ int simple_commit_write(struct file *fil
 	struct inode *inode = page->mapping->host;
 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold the i_sem.
+	 */
 	if (pos > inode->i_size)
-		inode->i_size = pos;
+		i_size_write(inode, pos);
 	set_page_dirty(page);
 	return 0;
 }
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/locks.c linux-2.5.69-isize/fs/locks.c
--- linux-2.5.69/fs/locks.c	Sun May  4 16:53:41 2003
+++ linux-2.5.69-isize/fs/locks.c	Wed May  7 16:08:46 2003
@@ -285,7 +285,7 @@ static int flock_to_posix_lock(struct fi
 		start = filp->f_pos;
 		break;
 	case 2: /*SEEK_END*/
-		start = filp->f_dentry->d_inode->i_size;
+		start = i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
@@ -335,7 +335,7 @@ static int flock64_to_posix_lock(struct 
 		start = filp->f_pos;
 		break;
 	case 2: /*SEEK_END*/
-		start = filp->f_dentry->d_inode->i_size;
+		start = i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/mpage.c linux-2.5.69-isize/fs/mpage.c
--- linux-2.5.69/fs/mpage.c	Sun May  4 16:53:08 2003
+++ linux-2.5.69-isize/fs/mpage.c	Wed May  7 16:08:46 2003
@@ -227,7 +227,7 @@ do_mpage_readpage(struct bio *bio, struc
 		goto confused;
 
 	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (inode->i_size + blocksize - 1) >> blkbits;
+	last_block = (i_size_read(inode) + blocksize - 1) >> blkbits;
 
 	bh.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page;
@@ -459,7 +459,7 @@ mpage_writepage(struct bio *bio, struct 
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (inode->i_size - 1) >> blkbits;
+	last_block = (i_size_read(inode) - 1) >> blkbits;
 	map_bh.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
@@ -489,9 +489,9 @@ mpage_writepage(struct bio *bio, struct 
 
 	first_unmapped = page_block;
 
-	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	end_index = i_size_read(inode) >> PAGE_CACHE_SHIFT;
 	if (page->index >= end_index) {
-		unsigned offset = inode->i_size & (PAGE_CACHE_SIZE - 1);
+		unsigned offset = i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
 		char *kaddr;
 
 		if (page->index > end_index || !offset)
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/open.c linux-2.5.69-isize/fs/open.c
--- linux-2.5.69/fs/open.c	Sun May  4 16:53:00 2003
+++ linux-2.5.69-isize/fs/open.c	Wed May  7 16:08:46 2003
@@ -908,7 +908,7 @@ asmlinkage long sys_vhangup(void)
  */
 int generic_file_open(struct inode * inode, struct file * filp)
 {
-	if (!(filp->f_flags & O_LARGEFILE) && inode->i_size > MAX_NON_LFS)
+	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
 	return 0;
 }
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/quota_v1.c linux-2.5.69-isize/fs/quota_v1.c
--- linux-2.5.69/fs/quota_v1.c	Sun May  4 16:53:36 2003
+++ linux-2.5.69-isize/fs/quota_v1.c	Wed May  7 16:08:46 2003
@@ -132,12 +132,14 @@ static int v1_check_quota_file(struct su
 	mm_segment_t fs;
 	ssize_t size;
 	loff_t offset = 0;
+	loff_t isize;
 	static const uint quota_magics[] = V2_INITQMAGICS;
 
-	if (!inode->i_size)
+	isize = i_size_read(inode);
+	if (!isize)
 		return 0;
-	blocks = inode->i_size >> BLOCK_SIZE_BITS;
-	off = inode->i_size & (BLOCK_SIZE - 1);
+	blocks = isize >> BLOCK_SIZE_BITS;
+	off = isize & (BLOCK_SIZE - 1);
 	if ((blocks % sizeof(struct v1_disk_dqblk) * BLOCK_SIZE + off) % sizeof(struct v1_disk_dqblk))
 		return 0;
 	/* Doublecheck whether we didn't get file with new format - with old quotactl() this could happen */
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/fs/stat.c linux-2.5.69-isize/fs/stat.c
--- linux-2.5.69/fs/stat.c	Sun May  4 16:53:03 2003
+++ linux-2.5.69-isize/fs/stat.c	Wed May  7 16:08:46 2003
@@ -28,7 +28,7 @@ void generic_fillattr(struct inode *inod
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
 	stat->ctime = inode->i_ctime;
-	stat->size = inode->i_size;
+	stat->size = i_size_read(inode);
 	stat->blocks = inode->i_blocks;
 	stat->blksize = inode->i_blksize;
 }
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/include/linux/fs.h linux-2.5.69-isize/include/linux/fs.h
--- linux-2.5.69/include/linux/fs.h	Sun May  4 16:53:08 2003
+++ linux-2.5.69-isize/include/linux/fs.h	Wed May  7 16:08:46 2003
@@ -349,6 +349,17 @@ struct block_device {
 	struct gendisk *	bd_disk;
 };
 
+/*
+ * Use sequence counter to get consistent i_size on 32-bit processors.
+ */
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#include <linux/seqlock.h>
+#define __NEED_I_SIZE_ORDERED
+#define i_size_ordered_init(inode) seqcnt_init(&inode->i_size_seqcnt)
+#else
+#define i_size_ordered_init(inode) do { } while (0)
+#endif
+
 struct inode {
 	struct hlist_node	i_hash;
 	struct list_head	i_list;
@@ -397,7 +408,59 @@ struct inode {
 	union {
 		void		*generic_ip;
 	} u;
+#ifdef __NEED_I_SIZE_ORDERED
+	seqcnt_t		i_size_seqcnt;
+#endif
 };
+
+/*
+ * NOTE: in a 32bit arch with a preemptable kernel and
+ * an UP compile the i_size_read/write must be atomic
+ * with respect to the local cpu (unlike with preempt disabled),
+ * but they don't need to be atomic with respect to other cpus like in
+ * true SMP (so they need either to either locally disable irq around
+ * the read or for example on x86 they can be still implemented as a
+ * cmpxchg8b without the need of the lock prefix). For SMP compiles
+ * and 64bit archs it makes no difference if preempt is enabled or not.
+ */
+static inline loff_t i_size_read(struct inode * inode)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	loff_t i_size;
+	unsigned int seq;
+
+	do {
+		seq = read_seqcntbegin(&inode->i_size_seqcnt);
+		i_size = inode->i_size;
+	} while (read_seqcntretry(&inode->i_size_seqcnt, seq));
+	return i_size;
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+	loff_t i_size;
+
+	preempt_disable();
+	i_size = inode->i_size;
+	preempt_enable();
+	return i_size;
+#else
+	return inode->i_size;
+#endif
+}
+
+
+static inline void i_size_write(struct inode * inode, loff_t i_size)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	write_seqcntbegin(&inode->i_size_seqcnt);
+	inode->i_size = i_size;
+	write_seqcntend(&inode->i_size_seqcnt);
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+	preempt_disable();
+	inode->i_size = i_size;
+	preempt_enable();
+#else
+	inode->i_size = i_size;
+#endif
+}
 
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/ipc/shm.c linux-2.5.69-isize/ipc/shm.c
--- linux-2.5.69/ipc/shm.c	Sun May  4 16:53:28 2003
+++ linux-2.5.69-isize/ipc/shm.c	Wed May  7 16:08:46 2003
@@ -699,7 +699,7 @@ asmlinkage long sys_shmat (int shmid, ch
 	}
 		
 	file = shp->shm_file;
-	size = file->f_dentry->d_inode->i_size;
+	size = i_size_read(file->f_dentry->d_inode);
 	shp->shm_nattch++;
 	shm_unlock(shp);
 
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/filemap.c linux-2.5.69-isize/mm/filemap.c
--- linux-2.5.69/mm/filemap.c	Sun May  4 16:53:09 2003
+++ linux-2.5.69-isize/mm/filemap.c	Wed May  7 16:08:46 2003
@@ -557,14 +557,15 @@ void do_generic_mapping_read(struct addr
 	for (;;) {
 		struct page *page;
 		unsigned long end_index, nr, ret;
+		loff_t isize = i_size_read(inode);
 
-		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+		end_index = isize >> PAGE_CACHE_SHIFT;
 			
 		if (index > end_index)
 			break;
 		nr = PAGE_CACHE_SIZE;
 		if (index == end_index) {
-			nr = inode->i_size & ~PAGE_CACHE_MASK;
+			nr = isize & ~PAGE_CACHE_MASK;
 			if (nr <= offset)
 				break;
 		}
@@ -765,7 +766,7 @@ __generic_file_aio_read(struct kiocb *io
 		retval = 0;
 		if (!count)
 			goto out; /* skip atime */
-		size = inode->i_size;
+		size = i_size_read(inode);
 		if (pos < size) {
 			retval = generic_file_direct_IO(READ, iocb,
 						iov, pos, nr_segs);
@@ -954,7 +955,7 @@ retry_all:
 	 * An external ptracer can access pages that normally aren't
 	 * accessible..
 	 */
-	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if ((pgoff >= size) && (area->vm_mm == current->mm))
 		return NULL;
 
@@ -1221,7 +1222,7 @@ static int filemap_populate(struct vm_ar
 					pgoff, len >> PAGE_CACHE_SHIFT);
 
 repeat:
-	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
 		return -EINVAL;
 
@@ -1510,7 +1511,7 @@ inline int generic_write_checks(struct i
 	if (!isblk) {
 		/* FIXME: this is for backwards compatibility with 2.4 */
 		if (file->f_flags & O_APPEND)
-                        *pos = inode->i_size;
+                        *pos = i_size_read(inode);
 
 		if (limit != RLIM_INFINITY) {
 			if (*pos >= limit) {
@@ -1556,15 +1557,17 @@ inline int generic_write_checks(struct i
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count = inode->i_sb->s_maxbytes - *pos;
 	} else {
+		loff_t isize;
 		if (bdev_read_only(inode->i_bdev))
 			return -EPERM;
-		if (*pos >= inode->i_size) {
-			if (*count || *pos > inode->i_size)
+		isize = i_size_read(inode);
+		if (*pos >= isize) {
+			if (*count || *pos > isize)
 				return -ENOSPC;
 		}
 
-		if (*pos + *count > inode->i_size)
-			*count = inode->i_size - *pos;
+		if (*pos + *count > isize)
+			*count = isize - *pos;
 	}
 	return 0;
 }
@@ -1651,8 +1654,8 @@ generic_file_aio_write_nolock(struct kio
 					iov, pos, nr_segs);
 		if (written > 0) {
 			loff_t end = pos + written;
-			if (end > inode->i_size && !isblk) {
-				inode->i_size = end;
+			if (end > i_size_read(inode) && !isblk) {
+				i_size_write(inode,  end);
 				mark_inode_dirty(inode);
 			}
 			*ppos = end;
@@ -1696,14 +1699,15 @@ generic_file_aio_write_nolock(struct kio
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
+			loff_t isize = i_size_read(inode);
 			/*
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
 			 */
 			unlock_page(page);
 			page_cache_release(page);
-			if (pos + bytes > inode->i_size)
-				vmtruncate(inode, inode->i_size);
+			if (pos + bytes > isize)
+				vmtruncate(inode, isize);
 			break;
 		}
 		if (likely(nr_segs == 1))
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/memory.c linux-2.5.69-isize/mm/memory.c
--- linux-2.5.69/mm/memory.c	Sun May  4 16:53:14 2003
+++ linux-2.5.69-isize/mm/memory.c	Wed May  7 16:08:46 2003
@@ -1107,7 +1107,7 @@ int vmtruncate(struct inode * inode, lof
 
 	if (inode->i_size < offset)
 		goto do_expand;
-	inode->i_size = offset;
+	i_size_write(inode, offset);
 	down(&mapping->i_shared_sem);
 	if (list_empty(&mapping->i_mmap) && list_empty(&mapping->i_mmap_shared))
 		goto out_unlock;
@@ -1129,7 +1129,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out;
-	inode->i_size = offset;
+	i_size_write(inode, offset);
 
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate)
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/nommu.c linux-2.5.69-isize/mm/nommu.c
--- linux-2.5.69/mm/nommu.c	Sun May  4 16:53:40 2003
+++ linux-2.5.69-isize/mm/nommu.c	Wed May  7 16:08:46 2003
@@ -46,7 +46,7 @@ int vmtruncate(struct inode *inode, loff
 
 	if (inode->i_size < offset)
 		goto do_expand;
-	inode->i_size = offset;
+	i_size_write(inode, offset);
 
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
@@ -57,7 +57,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out;
-	inode->i_size = offset;
+	i_size_write(inode, offset);
 
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate) {
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/readahead.c linux-2.5.69-isize/mm/readahead.c
--- linux-2.5.69/mm/readahead.c	Sun May  4 16:53:01 2003
+++ linux-2.5.69-isize/mm/readahead.c	Wed May  7 16:08:46 2003
@@ -208,11 +208,12 @@ __do_page_cache_readahead(struct address
 	LIST_HEAD(page_pool);
 	int page_idx;
 	int ret = 0;
+	loff_t isize = i_size_read(inode);
 
-	if (inode->i_size == 0)
+	if (isize == 0)
 		goto out;
 
- 	end_index = ((inode->i_size - 1) >> PAGE_CACHE_SHIFT);
+ 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/shmem.c linux-2.5.69-isize/mm/shmem.c
--- linux-2.5.69/mm/shmem.c	Sun May  4 16:53:13 2003
+++ linux-2.5.69-isize/mm/shmem.c	Wed May  7 16:08:46 2003
@@ -297,7 +297,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 	static const swp_entry_t unswapped = {0};
 
 	if (sgp != SGP_WRITE &&
-	    ((loff_t) index << PAGE_CACHE_SHIFT) >= inode->i_size)
+	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))
 		return ERR_PTR(-EINVAL);
 
 	while (!(entry = shmem_swp_entry(info, index, &page))) {
@@ -330,7 +330,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 			return ERR_PTR(-ENOMEM);
 		}
 		if (sgp != SGP_WRITE &&
-		    ((loff_t) index << PAGE_CACHE_SHIFT) >= inode->i_size) {
+		    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode)) {
 			entry = ERR_PTR(-EINVAL);
 			break;
 		}
diff -rupN -X /home/daniel/dontdiff linux-2.5.69/mm/swapfile.c linux-2.5.69-isize/mm/swapfile.c
--- linux-2.5.69/mm/swapfile.c	Sun May  4 16:53:07 2003
+++ linux-2.5.69-isize/mm/swapfile.c	Wed May  7 16:08:46 2003
@@ -918,7 +918,7 @@ static int setup_swap_extents(struct swa
 	 */
 	probe_block = 0;
 	page_no = 0;
-	last_block = inode->i_size >> blkbits;
+	last_block = i_size_read(inode) >> blkbits;
 	while ((probe_block + blocks_per_page) <= last_block &&
 			page_no < sis->max) {
 		unsigned block_in_page;
@@ -1296,7 +1296,7 @@ asmlinkage long sys_swapon(const char __
 	}
 
 	mapping = swap_file->f_dentry->d_inode->i_mapping;
-	swapfilesize = mapping->host->i_size >> PAGE_SHIFT;
+	swapfilesize = i_size_read(mapping->host) >> PAGE_SHIFT;
 
 	error = -EBUSY;
 	for (i = 0 ; i < nr_swapfiles ; i++) {

--=-lbpDsFpPNW7pCBUrljDO--

