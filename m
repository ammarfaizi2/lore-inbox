Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVBPV6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVBPV6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVBPV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:58:38 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:6861 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262100AbVBPV4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:56:18 -0500
Date: Wed, 16 Feb 2005 21:56:15 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: nathans@sgi.com, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache
 pages.
In-Reply-To: <20050206124236.264f0cd4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0502162139390.6035@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
 <20050202143422.41c29202.akpm@osdl.org> <1107427057.9010.18.camel@imp.csi.cam.ac.uk>
 <20050203024755.1792b6c0.akpm@osdl.org> <Pine.LNX.4.60.0502061932270.21938@hermes-1.csi.cam.ac.uk>
 <20050206124236.264f0cd4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, 6 Feb 2005, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Thu, 3 Feb 2005, Andrew Morton wrote:
> > > I did a patch which switched loop to use the file_operations.read/write
> > > about a year ago.  Forget what happened to it.  It always seemed the right
> > > thing to do..
> > 
> > How did you implement the write?
> 
> It was Urban, actually.  Memory fails me.
> 
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=102133217310200&w=2
> 
> It won't work properly for crypto transformations - iirc we decided it
> would need to perform a copy.

That is the conclusion I came to as well.  I whipped up a patch today that 
implements fallback to file_operations->write in the case that 
aops->{prepare,commit}_write are not present on the backing filesystem.

The fallback happens in two different ways:

- For normal loop devices, i.e. ones which do not do transformation on the 
data but simply pass it along, we simply call fops->write.  This should be 
pretty much just as fast as using aops->{prepare,commit}_write directly.

- For all other loop devices (e.g. xor and cryptoloop), i.e. all the ones 
which may be doing transformations on the data, we allocate and map a page 
(once for each bio), then for each bio vec we copy the bio vec page data 
to our mapped page, apply the loop transformation, and use fops->write to 
write out the transformed data from our page.  Once all bio vecs from the 
bio are done, we unmap and free the page.

This approach is the absolute minimum of overhead I could come up with and 
for performance hungry people, as you can see I left the address space 
operations method in place for filesystems which implement 
aops->{prepare,commit}_write.

I have tested this patch with normal loop devices using 
aops->{prepare,commit}_write on the backing filesystem, with normal loop 
devices using the fops->write code path and with cryptoloop devices using 
the deouble buffering + fops->write code path.

It all seemed to work fine for me.

Andrew, please consider this patch for your -mm tree and please apply it 
to mainline when/as you see fit.  Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- loop-write.diff ---

loop: Implement fallback to file operations->write in the loop driver for 
      backing filesystems which do not implement address space 
      operations->{prepare,commit}_write.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

drivers/block/loop.c |  159 ++++++++++++++++++++++++++++++++++++++++++---------
include/linux/loop.h |    5 +
2 files changed, 136 insertions(+), 28 deletions(-)

--- linus-2.6/include/linux/loop.h	2005-02-16 11:04:41.439418700 +0000
+++ linux-2.6/include/linux/loop.h	2005-02-16 11:08:07.535781915 +0000
@@ -71,7 +71,10 @@ struct loop_device {
 /*
  * Loop flags
  */
-#define LO_FLAGS_READ_ONLY	1
+enum {
+	LO_FLAGS_READ_ONLY	= 1,
+	LO_FLAGS_USE_AOPS	= 2,
+};
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <asm/types.h>		/* for __u64 */
--- linus-2.6/drivers/block/loop.c	2005-02-16 10:44:02.994427343 +0000
+++ linux-2.6/drivers/block/loop.c	2005-02-16 21:08:25.235894884 +0000
@@ -39,6 +39,11 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * Support for falling back on the write file operation when the address space
+ * operations prepare_write and/or commit_write are not available on the
+ * backing filesystem.
+ * Anton Altaparmakov, 16 Feb 2005
+ *
  * Still To Fix:
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
@@ -67,6 +72,8 @@
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <linux/completion.h>
+#include <linux/highmem.h>
+#include <linux/gfp.h>
 
 #include <asm/uaccess.h>
 
@@ -127,7 +134,7 @@ static int transfer_xor(struct loop_devi
 
 static int xor_init(struct loop_device *lo, const struct loop_info64 *info)
 {
-	if (info->lo_encrypt_key_size <= 0)
+	if (unlikely(info->lo_encrypt_key_size <= 0))
 		return -EINVAL;
 	return 0;
 }
@@ -173,7 +180,7 @@ figure_loop_size(struct loop_device *lo)
 	loff_t size = get_loop_size(lo, lo->lo_backing_file);
 	sector_t x = (sector_t)size;
 
-	if ((loff_t)x != size)
+	if (unlikely((loff_t)x != size))
 		return -EFBIG;
 
 	set_capacity(disks[lo->lo_number], x);
@@ -186,23 +193,27 @@ lo_do_transfer(struct loop_device *lo, i
 	       struct page *lpage, unsigned loffs,
 	       int size, sector_t rblock)
 {
-	if (!lo->transfer)
+	if (unlikely(!lo->transfer))
 		return 0;
 
 	return lo->transfer(lo, cmd, rpage, roffs, lpage, loffs, size, rblock);
 }
 
-static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
+/**
+ * do_lo_send_aops - helper for writing data to a loop device
+ *
+ * This is the fast version for backing filesystems which implement the address
+ * space operations prepare_write and commit_write.
+ */
+static int do_lo_send_aops(struct loop_device *lo, struct bio_vec *bvec,
+		int bsize, loff_t pos, struct page *page)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
 	struct address_space *mapping = file->f_mapping;
 	struct address_space_operations *aops = mapping->a_ops;
-	struct page *page;
 	pgoff_t index;
-	unsigned size, offset, bv_offs;
-	int len;
-	int ret = 0;
+	unsigned offset, bv_offs;
+	int len, ret = 0;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
@@ -211,23 +222,22 @@ do_lo_send(struct loop_device *lo, struc
 	len = bvec->bv_len;
 	while (len > 0) {
 		sector_t IV;
+		unsigned size;
 		int transfer_result;
 
 		IV = ((sector_t)index << (PAGE_CACHE_SHIFT - 9))+(offset >> 9);
-
 		size = PAGE_CACHE_SIZE - offset;
 		if (size > len)
 			size = len;
-
 		page = grab_cache_page(mapping, index);
-		if (!page)
+		if (unlikely(!page))
 			goto fail;
-		if (aops->prepare_write(file, page, offset, offset+size))
+		if (unlikely(aops->prepare_write(file, page, offset,
+				offset + size)))
 			goto unlock;
 		transfer_result = lo_do_transfer(lo, WRITE, page, offset,
-						 bvec->bv_page, bv_offs,
-						 size, IV);
-		if (transfer_result) {
+				bvec->bv_page, bv_offs, size, IV);
+		if (unlikely(transfer_result)) {
 			char *kaddr;
 
 			/*
@@ -241,9 +251,10 @@ do_lo_send(struct loop_device *lo, struc
 			kunmap_atomic(kaddr, KM_USER0);
 		}
 		flush_dcache_page(page);
-		if (aops->commit_write(file, page, offset, offset+size))
+		if (unlikely(aops->commit_write(file, page, offset,
+				offset + size)))
 			goto unlock;
-		if (transfer_result)
+		if (unlikely(transfer_result))
 			goto unlock;
 		bv_offs += size;
 		len -= size;
@@ -253,32 +264,125 @@ do_lo_send(struct loop_device *lo, struc
 		unlock_page(page);
 		page_cache_release(page);
 	}
-	up(&mapping->host->i_sem);
 out:
+	up(&mapping->host->i_sem);
 	return ret;
-
 unlock:
 	unlock_page(page);
 	page_cache_release(page);
 fail:
-	up(&mapping->host->i_sem);
 	ret = -1;
 	goto out;
 }
 
-static int
-lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+/**
+ * __do_lo_send_write - helper for writing data to a loop device
+ *
+ * This helper just factors out common code between do_lo_send_direct_write()
+ * and do_lo_send_write().
+ */
+static inline int __do_lo_send_write(struct file *file,
+		u8 __user *buf, const int len, loff_t pos)
 {
+	ssize_t bw;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(get_ds());
+	bw = file->f_op->write(file, buf, len, &pos);
+	set_fs(old_fs);
+	if (likely(bw == len))
+		return 0;
+	printk(KERN_ERR "loop: Write error at byte offset %llu, length %i.\n",
+			(unsigned long long)pos, len);
+	if (bw >= 0)
+		bw = -EIO;
+	return bw;
+}
+
+/**
+ * do_lo_send_direct_write - helper for writing data to a loop device
+ *
+ * This is the fast, non-transforming version for backing filesystems which do
+ * not implement the address space operations prepare_write and commit_write.
+ * It uses the write file operation which should be present on all writeable
+ * filesystems.
+ */
+static int do_lo_send_direct_write(struct loop_device *lo,
+		struct bio_vec *bvec, int bsize, loff_t pos, struct page *page)
+{
+	ssize_t bw = __do_lo_send_write(lo->lo_backing_file,
+			(u8 __user *)kmap(bvec->bv_page) + bvec->bv_offset,
+			bvec->bv_len, pos);
+	kunmap(bvec->bv_page);
+	cond_resched();
+	return bw;
+}
+
+/**
+ * do_lo_send_write - helper for writing data to a loop device
+ *
+ * This is the slow, transforming version for filesystems which do not
+ * implement the address space operations prepare_write and commit_write.  It
+ * uses the write file operation which should be present on all writeable
+ * filesystems.
+ *
+ * Using fops->write is slower than using aops->{prepare,commit}_write in the
+ * transforming case because we need to double buffer the data as we cannot do
+ * the transformations in place as we do not have direct access to the
+ * destination pages of the backing file.
+ */
+static int do_lo_send_write(struct loop_device *lo, struct bio_vec *bvec,
+		int bsize, loff_t pos, struct page *page)
+{
+	int ret = lo_do_transfer(lo, WRITE, page, 0, bvec->bv_page,
+			bvec->bv_offset, bvec->bv_len, pos >> 9);
+	if (likely(!ret))
+		return __do_lo_send_write(lo->lo_backing_file,
+				(u8 __user *)page_address(page), bvec->bv_len,
+				pos);
+	printk(KERN_ERR "loop: Transfer error at byte offset %llu, "
+			"length %i.\n", (unsigned long long)pos, bvec->bv_len);
+	if (ret > 0)
+		ret = -EIO;
+	return ret;
+}
+
+static int lo_send(struct loop_device *lo, struct bio *bio, int bsize,
+		loff_t pos)
+{
+	int (*do_lo_send)(struct loop_device *, struct bio_vec *, int, loff_t,
+			struct page *page);
 	struct bio_vec *bvec;
+	struct page *page = NULL;
 	int i, ret = 0;
 
+	do_lo_send = do_lo_send_aops;
+	if (!(lo->lo_flags & LO_FLAGS_USE_AOPS)) {
+		do_lo_send = do_lo_send_direct_write;
+		if (lo->transfer != transfer_none) {
+			page = alloc_page(GFP_NOIO | __GFP_HIGHMEM);
+			if (unlikely(!page))
+				goto fail;
+			kmap(page);
+			do_lo_send = do_lo_send_write;
+		}
+	}
 	bio_for_each_segment(bvec, bio, i) {
-		ret = do_lo_send(lo, bvec, bsize, pos);
+		ret = do_lo_send(lo, bvec, bsize, pos, page);
 		if (ret < 0)
 			break;
 		pos += bvec->bv_len;
 	}
+	if (page) {
+		kunmap(page);
+		__free_page(page);
+	}
+out:
 	return ret;
+fail:
+	printk(KERN_ERR "loop: Failed to allocate temporary page for write.\n");
+	ret = -ENOMEM;
+	goto out;
 }
 
 struct lo_read_data {
@@ -584,7 +688,7 @@ static int loop_change_fd(struct loop_de
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
-	if (lo->lo_flags != LO_FLAGS_READ_ONLY)
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		goto out;
 
 	error = -EBADF;
@@ -683,8 +787,9 @@ static int loop_set_fd(struct loop_devic
 		 */
 		if (!file->f_op->sendfile)
 			goto out_putf;
-
-		if (!aops->prepare_write || !aops->commit_write)
+		if (aops->prepare_write && aops->commit_write)
+			lo_flags |= LO_FLAGS_USE_AOPS;
+		if (!(lo_flags & LO_FLAGS_USE_AOPS) && !file->f_op->write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 
 		lo_blocksize = inode->i_blksize;
