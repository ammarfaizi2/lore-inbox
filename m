Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbTFSSDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbTFSSDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:03:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265879AbTFSSCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:02:41 -0400
Subject: PATCH 2.5.72 2/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Content-Type: multipart/mixed; boundary="=-IX04R6xIwpYLpgBCcWZP"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Jun 2003 11:17:00 -0700
Message-Id: <1056046620.17353.19.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IX04R6xIwpYLpgBCcWZP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds i_seqcnt to the inode structure and then uses i_size_read()
and i_size_write() to provide atomic access to i_size.  This is a port
of Andrea Arcangeli's i_size atomic access patch from 2.4.  This only
uses the generic reader/writer consistent mechanism.

re-diff against 2.5.72.

This patch has been tested on 1 proc, 2 proc, 4 proc and 8 proc
machines.

This patch is available for download from OSDL's patch lifecycle 
manager (PLM):

http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1940

Daniel McNeil <daniel@osdl.org>



--=-IX04R6xIwpYLpgBCcWZP
Content-Disposition: attachment; filename=patch.2.5.72-isize.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.2.5.72-isize.2; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/drivers/block/loop.c l=
inux-2.5.72-isize/drivers/block/loop.c
--- linux-2.5.72/drivers/block/loop.c	2003-06-16 21:20:05.000000000 -0700
+++ linux-2.5.72-isize/drivers/block/loop.c	2003-06-17 17:07:49.130734182 -=
0700
@@ -146,7 +146,7 @@ struct loop_func_table *xfer_funcs[MAX_L
=20
 static int figure_loop_size(struct loop_device *lo)
 {
-	loff_t size =3D lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->=
i_size;
+	loff_t size =3D i_size_read(lo->lo_backing_file->f_dentry->d_inode->i_map=
ping->host);
 	sector_t x;
 	/*
 	 * Unfortunately, if we want to do I/O on the device,
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/attr.c linux-2.5.72=
-isize/fs/attr.c
--- linux-2.5.72/fs/attr.c	2003-06-16 21:19:41.000000000 -0700
+++ linux-2.5.72-isize/fs/attr.c	2003-06-17 17:24:16.817360469 -0700
@@ -68,7 +68,7 @@ int inode_setattr(struct inode * inode,=20
 	int error =3D 0;
=20
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size !=3D inode->i_size) {
+		if (attr->ia_size !=3D i_size_read(inode)) {
 			error =3D vmtruncate(inode, attr->ia_size);
 			if (error || (ia_valid =3D=3D ATTR_SIZE))
 				goto out;
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/binfmt_aout.c linux=
-2.5.72-isize/fs/binfmt_aout.c
--- linux-2.5.72/fs/binfmt_aout.c	2003-06-16 21:19:42.000000000 -0700
+++ linux-2.5.72-isize/fs/binfmt_aout.c	2003-06-17 17:07:49.140734047 -0700
@@ -269,7 +269,7 @@ static int load_aout_binary(struct linux
 	if ((N_MAGIC(ex) !=3D ZMAGIC && N_MAGIC(ex) !=3D OMAGIC &&
 	     N_MAGIC(ex) !=3D QMAGIC && N_MAGIC(ex) !=3D NMAGIC) ||
 	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    bprm->file->f_dentry->d_inode->i_size < ex.a_text+ex.a_data+N_SYMSIZE=
(ex)+N_TXTOFF(ex)) {
+	    i_size_read(bprm->file->f_dentry->d_inode) < ex.a_text+ex.a_data+N_SY=
MSIZE(ex)+N_TXTOFF(ex)) {
 		return -ENOEXEC;
 	}
=20
@@ -454,7 +454,7 @@ static int load_aout_library(struct file
 	/* We come in here for the regular a.out style of shared libraries */
 	if ((N_MAGIC(ex) !=3D ZMAGIC && N_MAGIC(ex) !=3D QMAGIC) || N_TRSIZE(ex) =
||
 	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) =3D=3D ZMAGIC) |=
|
-	    inode->i_size < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) =
{
 		goto out;
 	}
=20
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/block_dev.c linux-2=
.5.72-isize/fs/block_dev.c
--- linux-2.5.72/fs/block_dev.c	2003-06-16 21:20:28.000000000 -0700
+++ linux-2.5.72-isize/fs/block_dev.c	2003-06-17 17:07:49.140734047 -0700
@@ -29,7 +29,7 @@
 static sector_t max_block(struct block_device *bdev)
 {
 	sector_t retval =3D ~((sector_t)0);
-	loff_t sz =3D bdev->bd_inode->i_size;
+	loff_t sz =3D i_size_read(bdev->bd_inode);
=20
 	if (sz) {
 		unsigned int size =3D block_size(bdev);
@@ -156,7 +156,7 @@ static int blkdev_commit_write(struct fi
 static loff_t block_llseek(struct file *file, loff_t offset, int origin)
 {
 	/* ewww */
-	loff_t size =3D file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
+	loff_t size =3D i_size_read(file->f_dentry->d_inode->i_bdev->bd_inode);
 	loff_t retval;
=20
 	lock_kernel();
@@ -485,7 +485,7 @@ int check_disk_change(struct block_devic
 static void bd_set_size(struct block_device *bdev, loff_t size)
 {
 	unsigned bsize =3D bdev_hardsect_size(bdev);
-	bdev->bd_inode->i_size =3D size;
+	i_size_write(bdev->bd_inode, size);
 	while (bsize < PAGE_CACHE_SIZE) {
 		if (size & bsize)
 			break;
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/buffer.c linux-2.5.=
72-isize/fs/buffer.c
--- linux-2.5.72/fs/buffer.c	2003-06-16 21:20:05.000000000 -0700
+++ linux-2.5.72-isize/fs/buffer.c	2003-06-17 17:07:49.140734047 -0700
@@ -1707,7 +1707,7 @@ static int __block_write_full_page(struc
=20
 	BUG_ON(!PageLocked(page));
=20
-	last_block =3D (inode->i_size - 1) >> inode->i_blkbits;
+	last_block =3D (i_size_read(inode) - 1) >> inode->i_blkbits;
=20
 	if (!page_has_buffers(page)) {
 		if (!PageUptodate(page))
@@ -2043,7 +2043,7 @@ int block_read_full_page(struct page *pa
 	head =3D page_buffers(page);
=20
 	iblock =3D (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits)=
;
-	lblock =3D (inode->i_size+blocksize-1) >> inode->i_blkbits;
+	lblock =3D (i_size_read(inode)+blocksize-1) >> inode->i_blkbits;
 	bh =3D head;
 	nr =3D 0;
 	i =3D 0;
@@ -2268,8 +2268,12 @@ int generic_commit_write(struct file *fi
 	struct inode *inode =3D page->mapping->host;
 	loff_t pos =3D ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	__block_commit_write(inode,page,from,to);
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold i_sem.
+	 */
 	if (pos > inode->i_size) {
-		inode->i_size =3D pos;
+		i_size_write(inode, pos);
 		mark_inode_dirty(inode);
 	}
 	return 0;
@@ -2421,7 +2425,7 @@ int nobh_commit_write(struct file *file,
=20
 	set_page_dirty(page);
 	if (pos > inode->i_size) {
-		inode->i_size =3D pos;
+		i_size_write(inode, pos);
 		mark_inode_dirty(inode);
 	}
 	return 0;
@@ -2551,7 +2555,8 @@ int block_write_full_page(struct page *p
 			struct writeback_control *wbc)
 {
 	struct inode * const inode =3D page->mapping->host;
-	const unsigned long end_index =3D inode->i_size >> PAGE_CACHE_SHIFT;
+	loff_t i_size =3D i_size_read(inode);
+	const unsigned long end_index =3D i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
 	void *kaddr;
=20
@@ -2560,7 +2565,7 @@ int block_write_full_page(struct page *p
 		return __block_write_full_page(inode, page, get_block, wbc);
=20
 	/* Is the page fully outside i_size? (truncate in progress) */
-	offset =3D inode->i_size & (PAGE_CACHE_SIZE-1);
+	offset =3D i_size & (PAGE_CACHE_SIZE-1);
 	if (page->index >=3D end_index+1 || !offset) {
 		/*
 		 * The page may have dirty, unmapped buffers.  For example,
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/ext3/inode.c linux-=
2.5.72-isize/fs/ext3/inode.c
--- linux-2.5.72/fs/ext3/inode.c	2003-06-16 21:20:07.000000000 -0700
+++ linux-2.5.72-isize/fs/ext3/inode.c	2003-06-17 17:07:49.150733912 -0700
@@ -1163,7 +1163,7 @@ static int ext3_commit_write(struct file
 		if (!partial)
 			SetPageUptodate(page);
 		if (pos > inode->i_size)
-			inode->i_size =3D pos;
+			i_size_write(inode, pos);
 		EXT3_I(inode)->i_state |=3D EXT3_STATE_JDATA;
 		if (inode->i_size > EXT3_I(inode)->i_disksize) {
 			EXT3_I(inode)->i_disksize =3D inode->i_size;
@@ -1495,7 +1495,7 @@ out_stop:
 			loff_t end =3D offset + ret;
 			if (end > inode->i_size) {
 				ei->i_disksize =3D end;
-				inode->i_size =3D end;
+				i_size_write(inode, end);
 				err =3D ext3_mark_inode_dirty(handle, inode);
 				if (!ret)=20
 					ret =3D err;
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/inode.c linux-2.5.7=
2-isize/fs/inode.c
--- linux-2.5.72/fs/inode.c	2003-06-16 21:20:27.000000000 -0700
+++ linux-2.5.72-isize/fs/inode.c	2003-06-17 17:07:49.150733912 -0700
@@ -189,6 +189,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
+	i_size_ordered_init(inode);
 }
=20
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long fla=
gs)
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/ioctl.c linux-2.5.7=
2-isize/fs/ioctl.c
--- linux-2.5.72/fs/ioctl.c	2003-06-16 21:19:42.000000000 -0700
+++ linux-2.5.72-isize/fs/ioctl.c	2003-06-17 17:07:49.150733912 -0700
@@ -40,7 +40,7 @@ static int file_ioctl(struct file *filp,
 				return -EBADF;
 			return put_user(inode->i_sb->s_blocksize, (int *) arg);
 		case FIONREAD:
-			return put_user(inode->i_size - filp->f_pos, (int *) arg);
+			return put_user(i_size_read(inode) - filp->f_pos, (int *) arg);
 	}
 	if (filp->f_op && filp->f_op->ioctl)
 		return filp->f_op->ioctl(inode, filp, cmd, arg);
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/libfs.c linux-2.5.7=
2-isize/fs/libfs.c
--- linux-2.5.72/fs/libfs.c	2003-06-16 21:19:39.000000000 -0700
+++ linux-2.5.72-isize/fs/libfs.c	2003-06-17 17:07:49.150733912 -0700
@@ -328,8 +328,12 @@ int simple_commit_write(struct file *fil
 	struct inode *inode =3D page->mapping->host;
 	loff_t pos =3D ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
=20
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold the i_sem.
+	 */
 	if (pos > inode->i_size)
-		inode->i_size =3D pos;
+		i_size_write(inode, pos);
 	set_page_dirty(page);
 	return 0;
 }
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/locks.c linux-2.5.7=
2-isize/fs/locks.c
--- linux-2.5.72/fs/locks.c	2003-06-16 21:20:23.000000000 -0700
+++ linux-2.5.72-isize/fs/locks.c	2003-06-17 17:07:49.150733912 -0700
@@ -285,7 +285,7 @@ static int flock_to_posix_lock(struct fi
 		start =3D filp->f_pos;
 		break;
 	case 2: /*SEEK_END*/
-		start =3D filp->f_dentry->d_inode->i_size;
+		start =3D i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
@@ -335,7 +335,7 @@ static int flock64_to_posix_lock(struct=20
 		start =3D filp->f_pos;
 		break;
 	case 2: /*SEEK_END*/
-		start =3D filp->f_dentry->d_inode->i_size;
+		start =3D i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/mpage.c linux-2.5.7=
2-isize/fs/mpage.c
--- linux-2.5.72/fs/mpage.c	2003-06-16 21:19:44.000000000 -0700
+++ linux-2.5.72-isize/fs/mpage.c	2003-06-17 17:07:49.160733777 -0700
@@ -227,7 +227,7 @@ do_mpage_readpage(struct bio *bio, struc
 		goto confused;
=20
 	block_in_file =3D page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block =3D (inode->i_size + blocksize - 1) >> blkbits;
+	last_block =3D (i_size_read(inode) + blocksize - 1) >> blkbits;
=20
 	bh.b_page =3D page;
 	for (page_block =3D 0; page_block < blocks_per_page;
@@ -459,7 +459,7 @@ mpage_writepage(struct bio *bio, struct=20
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file =3D page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block =3D (inode->i_size - 1) >> blkbits;
+	last_block =3D (i_size_read(inode) - 1) >> blkbits;
 	map_bh.b_page =3D page;
 	for (page_block =3D 0; page_block < blocks_per_page; ) {
=20
@@ -489,9 +489,9 @@ mpage_writepage(struct bio *bio, struct=20
=20
 	first_unmapped =3D page_block;
=20
-	end_index =3D inode->i_size >> PAGE_CACHE_SHIFT;
+	end_index =3D i_size_read(inode) >> PAGE_CACHE_SHIFT;
 	if (page->index >=3D end_index) {
-		unsigned offset =3D inode->i_size & (PAGE_CACHE_SIZE - 1);
+		unsigned offset =3D i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
 		char *kaddr;
=20
 		if (page->index > end_index || !offset)
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/open.c linux-2.5.72=
-isize/fs/open.c
--- linux-2.5.72/fs/open.c	2003-06-16 21:19:40.000000000 -0700
+++ linux-2.5.72-isize/fs/open.c	2003-06-17 17:07:49.160733777 -0700
@@ -908,7 +908,7 @@ asmlinkage long sys_vhangup(void)
  */
 int generic_file_open(struct inode * inode, struct file * filp)
 {
-	if (!(filp->f_flags & O_LARGEFILE) && inode->i_size > MAX_NON_LFS)
+	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
 	return 0;
 }
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/quota_v1.c linux-2.=
5.72-isize/fs/quota_v1.c
--- linux-2.5.72/fs/quota_v1.c	2003-06-16 21:20:19.000000000 -0700
+++ linux-2.5.72-isize/fs/quota_v1.c	2003-06-17 17:07:49.160733777 -0700
@@ -132,12 +132,14 @@ static int v1_check_quota_file(struct su
 	mm_segment_t fs;
 	ssize_t size;
 	loff_t offset =3D 0;
+	loff_t isize;
 	static const uint quota_magics[] =3D V2_INITQMAGICS;
=20
-	if (!inode->i_size)
+	isize =3D i_size_read(inode);
+	if (!isize)
 		return 0;
-	blocks =3D inode->i_size >> BLOCK_SIZE_BITS;
-	off =3D inode->i_size & (BLOCK_SIZE - 1);
+	blocks =3D isize >> BLOCK_SIZE_BITS;
+	off =3D isize & (BLOCK_SIZE - 1);
 	if ((blocks % sizeof(struct v1_disk_dqblk) * BLOCK_SIZE + off) % sizeof(s=
truct v1_disk_dqblk))
 		return 0;
 	/* Doublecheck whether we didn't get file with new format - with old quot=
actl() this could happen */
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/fs/stat.c linux-2.5.72=
-isize/fs/stat.c
--- linux-2.5.72/fs/stat.c	2003-06-16 21:19:42.000000000 -0700
+++ linux-2.5.72-isize/fs/stat.c	2003-06-17 17:07:49.160733777 -0700
@@ -28,7 +28,7 @@ void generic_fillattr(struct inode *inod
 	stat->atime =3D inode->i_atime;
 	stat->mtime =3D inode->i_mtime;
 	stat->ctime =3D inode->i_ctime;
-	stat->size =3D inode->i_size;
+	stat->size =3D i_size_read(inode);
 	stat->blocks =3D inode->i_blocks;
 	stat->blksize =3D inode->i_blksize;
 }
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/include/linux/fs.h lin=
ux-2.5.72-isize/include/linux/fs.h
--- linux-2.5.72/include/linux/fs.h	2003-06-16 21:19:46.000000000 -0700
+++ linux-2.5.72-isize/include/linux/fs.h	2003-06-17 17:07:49.180733507 -07=
00
@@ -349,6 +349,17 @@ struct block_device {
 	struct gendisk *	bd_disk;
 };
=20
+/*
+ * Use sequence counter to get consistent i_size on 32-bit processors.
+ */
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
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
@@ -399,8 +410,60 @@ struct inode {
 	union {
 		void		*generic_ip;
 	} u;
+#ifdef __NEED_I_SIZE_ORDERED
+	seqcnt_t		i_size_seqcnt;
+#endif
 };
=20
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
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
+	loff_t i_size;
+	unsigned int seq;
+
+	do {
+		seq =3D read_seqcntbegin(&inode->i_size_seqcnt);
+		i_size =3D inode->i_size;
+	} while (read_seqcntretry(&inode->i_size_seqcnt, seq));
+	return i_size;
+#elif BITS_PER_LONG=3D=3D32 && defined(CONFIG_PREEMPT)
+	loff_t i_size;
+
+	preempt_disable();
+	i_size =3D inode->i_size;
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
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
+	write_seqcntbegin(&inode->i_size_seqcnt);
+	inode->i_size =3D i_size;
+	write_seqcntend(&inode->i_size_seqcnt);
+#elif BITS_PER_LONG=3D=3D32 && defined(CONFIG_PREEMPT)
+	preempt_disable();
+	inode->i_size =3D i_size;
+	preempt_enable();
+#else
+	inode->i_size =3D i_size;
+#endif
+}
+
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/ipc/shm.c linux-2.5.72=
-isize/ipc/shm.c
--- linux-2.5.72/ipc/shm.c	2003-06-16 21:20:01.000000000 -0700
+++ linux-2.5.72-isize/ipc/shm.c	2003-06-17 17:07:49.180733507 -0700
@@ -703,7 +703,7 @@ long sys_shmat(int shmid, char __user *s
 	}
 	=09
 	file =3D shp->shm_file;
-	size =3D file->f_dentry->d_inode->i_size;
+	size =3D i_size_read(file->f_dentry->d_inode);
 	shp->shm_nattch++;
 	shm_unlock(shp);
=20
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/filemap.c linux-2.5=
.72-isize/mm/filemap.c
--- linux-2.5.72/mm/filemap.c	2003-06-16 21:19:49.000000000 -0700
+++ linux-2.5.72-isize/mm/filemap.c	2003-06-17 17:07:49.180733507 -0700
@@ -555,14 +555,15 @@ void do_generic_mapping_read(struct addr
 	for (;;) {
 		struct page *page;
 		unsigned long end_index, nr, ret;
+		loff_t isize =3D i_size_read(inode);
=20
-		end_index =3D inode->i_size >> PAGE_CACHE_SHIFT;
+		end_index =3D isize >> PAGE_CACHE_SHIFT;
 		=09
 		if (index > end_index)
 			break;
 		nr =3D PAGE_CACHE_SIZE;
 		if (index =3D=3D end_index) {
-			nr =3D inode->i_size & ~PAGE_CACHE_MASK;
+			nr =3D isize & ~PAGE_CACHE_MASK;
 			if (nr <=3D offset)
 				break;
 		}
@@ -763,7 +764,7 @@ __generic_file_aio_read(struct kiocb *io
 		retval =3D 0;
 		if (!count)
 			goto out; /* skip atime */
-		size =3D inode->i_size;
+		size =3D i_size_read(inode);
 		if (pos < size) {
 			retval =3D generic_file_direct_IO(READ, iocb,
 						iov, pos, nr_segs);
@@ -952,7 +953,7 @@ retry_all:
 	 * An external ptracer can access pages that normally aren't
 	 * accessible..
 	 */
-	size =3D (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	size =3D (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if ((pgoff >=3D size) && (area->vm_mm =3D=3D current->mm))
 		return NULL;
=20
@@ -1219,7 +1220,7 @@ static int filemap_populate(struct vm_ar
 					pgoff, len >> PAGE_CACHE_SHIFT);
=20
 repeat:
-	size =3D (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	size =3D (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
 		return -EINVAL;
=20
@@ -1530,7 +1531,7 @@ inline int generic_write_checks(struct i
 	if (!isblk) {
 		/* FIXME: this is for backwards compatibility with 2.4 */
 		if (file->f_flags & O_APPEND)
-                        *pos =3D inode->i_size;
+                        *pos =3D i_size_read(inode);
=20
 		if (limit !=3D RLIM_INFINITY) {
 			if (*pos >=3D limit) {
@@ -1576,15 +1577,17 @@ inline int generic_write_checks(struct i
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count =3D inode->i_sb->s_maxbytes - *pos;
 	} else {
+		loff_t isize;
 		if (bdev_read_only(inode->i_bdev))
 			return -EPERM;
-		if (*pos >=3D inode->i_size) {
-			if (*count || *pos > inode->i_size)
+		isize =3D i_size_read(inode);
+		if (*pos >=3D isize) {
+			if (*count || *pos > isize)
 				return -ENOSPC;
 		}
=20
-		if (*pos + *count > inode->i_size)
-			*count =3D inode->i_size - *pos;
+		if (*pos + *count > isize)
+			*count =3D isize - *pos;
 	}
 	return 0;
 }
@@ -1671,8 +1674,8 @@ generic_file_aio_write_nolock(struct kio
 					iov, pos, nr_segs);
 		if (written > 0) {
 			loff_t end =3D pos + written;
-			if (end > inode->i_size && !isblk) {
-				inode->i_size =3D end;
+			if (end > i_size_read(inode) && !isblk) {
+				i_size_write(inode,  end);
 				mark_inode_dirty(inode);
 			}
 			*ppos =3D end;
@@ -1716,14 +1719,15 @@ generic_file_aio_write_nolock(struct kio
=20
 		status =3D a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
+			loff_t isize =3D i_size_read(inode);
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
 		if (likely(nr_segs =3D=3D 1))
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/memory.c linux-2.5.=
72-isize/mm/memory.c
--- linux-2.5.72/mm/memory.c	2003-06-16 21:20:00.000000000 -0700
+++ linux-2.5.72-isize/mm/memory.c	2003-06-17 17:07:49.180733507 -0700
@@ -1109,7 +1109,7 @@ int vmtruncate(struct inode * inode, lof
=20
 	if (inode->i_size < offset)
 		goto do_expand;
-	inode->i_size =3D offset;
+	i_size_write(inode, offset);
 	pgoff =3D (offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	down(&mapping->i_shared_sem);
 	if (unlikely(!list_empty(&mapping->i_mmap)))
@@ -1126,7 +1126,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out;
-	inode->i_size =3D offset;
+	i_size_write(inode, offset);
=20
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate)
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/nommu.c linux-2.5.7=
2-isize/mm/nommu.c
--- linux-2.5.72/mm/nommu.c	2003-06-16 21:20:21.000000000 -0700
+++ linux-2.5.72-isize/mm/nommu.c	2003-06-17 17:07:49.190733372 -0700
@@ -48,7 +48,7 @@ int vmtruncate(struct inode *inode, loff
=20
 	if (inode->i_size < offset)
 		goto do_expand;
-	inode->i_size =3D offset;
+	i_size_write(inode, offset);
=20
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
@@ -59,7 +59,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out;
-	inode->i_size =3D offset;
+	i_size_write(inode, offset);
=20
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate) {
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/readahead.c linux-2=
.5.72-isize/mm/readahead.c
--- linux-2.5.72/mm/readahead.c	2003-06-16 21:19:40.000000000 -0700
+++ linux-2.5.72-isize/mm/readahead.c	2003-06-17 17:07:49.190733372 -0700
@@ -208,11 +208,12 @@ __do_page_cache_readahead(struct address
 	LIST_HEAD(page_pool);
 	int page_idx;
 	int ret =3D 0;
+	loff_t isize =3D i_size_read(inode);
=20
-	if (inode->i_size =3D=3D 0)
+	if (isize =3D=3D 0)
 		goto out;
=20
- 	end_index =3D ((inode->i_size - 1) >> PAGE_CACHE_SHIFT);
+ 	end_index =3D ((isize - 1) >> PAGE_CACHE_SHIFT);
=20
 	/*
 	 * Preallocate as many pages as we will need.
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/shmem.c linux-2.5.7=
2-isize/mm/shmem.c
--- linux-2.5.72/mm/shmem.c	2003-06-16 21:20:00.000000000 -0700
+++ linux-2.5.72-isize/mm/shmem.c	2003-06-17 17:07:49.190733372 -0700
@@ -298,7 +298,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 	static const swp_entry_t unswapped =3D {0};
=20
 	if (sgp !=3D SGP_WRITE &&
-	    ((loff_t) index << PAGE_CACHE_SHIFT) >=3D inode->i_size)
+	    ((loff_t) index << PAGE_CACHE_SHIFT) >=3D i_size_read(inode))
 		return ERR_PTR(-EINVAL);
=20
 	while (!(entry =3D shmem_swp_entry(info, index, &page))) {
@@ -331,7 +331,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 			return ERR_PTR(-ENOMEM);
 		}
 		if (sgp !=3D SGP_WRITE &&
-		    ((loff_t) index << PAGE_CACHE_SHIFT) >=3D inode->i_size) {
+		    ((loff_t) index << PAGE_CACHE_SHIFT) >=3D i_size_read(inode)) {
 			entry =3D ERR_PTR(-EINVAL);
 			break;
 		}
diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/mm/swapfile.c linux-2.=
5.72-isize/mm/swapfile.c
--- linux-2.5.72/mm/swapfile.c	2003-06-16 21:19:42.000000000 -0700
+++ linux-2.5.72-isize/mm/swapfile.c	2003-06-17 17:07:49.190733372 -0700
@@ -922,7 +922,7 @@ static int setup_swap_extents(struct swa
 	 */
 	probe_block =3D 0;
 	page_no =3D 0;
-	last_block =3D inode->i_size >> blkbits;
+	last_block =3D i_size_read(inode) >> blkbits;
 	while ((probe_block + blocks_per_page) <=3D last_block &&
 			page_no < sis->max) {
 		unsigned block_in_page;
@@ -1308,7 +1308,7 @@ asmlinkage long sys_swapon(const char __
 		goto bad_swap;
 	}
=20
-	swapfilesize =3D mapping->host->i_size >> PAGE_SHIFT;
+	swapfilesize =3D i_size_read(mapping->host) >> PAGE_SHIFT;
=20
 	/*
 	 * Read the swap header.

--=-IX04R6xIwpYLpgBCcWZP--

