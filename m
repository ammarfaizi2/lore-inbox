Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbSJJHE3>; Thu, 10 Oct 2002 03:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJJHE3>; Thu, 10 Oct 2002 03:04:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:49827 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263272AbSJJHEQ>;
	Thu, 10 Oct 2002 03:04:16 -0400
Message-ID: <3DA527BD.93B2A94F@digeo.com>
Date: Thu, 10 Oct 2002 00:09:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: drivers/block/rd.c compile error
References: <15781.7200.98489.515226@nanango.paulus.ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 07:09:50.0282 (UTC) FILETIME=[0616BAA0:01C2702C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
> ...
> What was the change trying to achieve?  What was wrong with
> flush_dcache_page(page)?

It was a 2.4 fix.  The ramdisk driver is indeed flushing
the wrong page.

But it has much bigger problems than that - it's corrupting data
due to truncation, and has been doing that since 2.5.0.

I spent an exorbitant amount of time kicking it a while back,
couldn't work out what's gone wrong.  I have the below patch
which fixes some stuff, but it needs more work.

Your patch should be fine for now.  Anyone who is having
ramdisk problems can probably work around them by mounting
the filesystem with `-o sync' (!).







A bit of a spring clean for the ramdisk driver.

This driver has been sick since very early 2.5.  For example,

	mke2fs /dev/ram0
	mount /dev/ram0 /mnt/ram0
	cd /mnt/ram0
	cvs co dbench
	cd
	umount /dev/ram0
	e2fsck -f /dev/ram0	-> tons of errors.

I don't know why all that happens.  But this patch fixes it.


- Factor out some common code.

- Use kmap_atomic() throughout the driver.

- Clean up some coding in rd_blkdev_pagecache_IO().

- rd_blkdev_pagecache_IO() was doing a flush_dcache_page() in the
  READ case instead of the WRITE case.

- Need to do a flush_dcache_page() against the BIO's page in the READ
  case - it is pagecache and could be mapped.

  (Note that, in general, writable mmapping of blockdevs will almost
  certainly corrupt any currently-mounted filesystem on that blockdev. 
  If the blocksize is less than PAGE_CACHE_SIZE)

- Remove the ramdisk a_ops altogether.  Just use the default blockdev
  a_ops for accessing /dev/ramN.

- Sort out where ramdisk pages get marked dirty: it happens either in
  block_commit_write() (if someone like mkfs is writing to the device
  directly) or in rd_blkdev_pagecache_IO(), where a page was just added
  to the ramdisk's mapping.

- Finally, there's the problem of the grab_cache_page() call in
  rd_blkdev_pagecache_IO().  This can cause quite deep nesting levels:

  writeback
  ->submit_bio
    ->rd_blkdev_pagecache_IO
      ->grab_cache_page
        ->page reclaim (sets PF_MEMALLOC)
          ->writeback
            ->submit_bio
              ->rd_blkdev_pagecache_IO
                ->grab_cache_page
                  ->We're PF_MEMALLOC.  Stop here.

  I haven't seen a stack overrun, and I haven't instrumented this. 
  But the failed page allocation comes back as an I/O error.  The page
  is effectively all-zeroes and the filesystem is corrupted.  This is
  quite easy to hit.



 drivers/block/rd.c |  172 +++++++++++++++++++++++------------------------------
 fs/buffer.c        |   18 +++--
 kernel/ksyms.c     |    1 
 3 files changed, 89 insertions(+), 102 deletions(-)

--- 2.5.41/drivers/block/rd.c~rd-cleanup	Tue Oct  8 13:30:42 2002
+++ 2.5.41-akpm/drivers/block/rd.c	Tue Oct  8 13:30:42 2002
@@ -45,12 +45,14 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <asm/atomic.h>
+#include <linux/highmem.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/backing-dev.h>
+
 #include <asm/uaccess.h>
 
 /*
@@ -73,10 +75,7 @@ unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 #endif
 
-/* Various static variables go here.  Most are used only in the RAM disk code.
- */
-
-static unsigned long rd_length[NUM_RAMDISKS];	/* Size of RAM disks in bytes   */
+static unsigned long rd_length[NUM_RAMDISKS];	/* Size of RAM disks in bytes */
 static struct gendisk *rd_disks[NUM_RAMDISKS];
 static devfs_handle_t devfs_handle;
 static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data */
@@ -87,7 +86,7 @@ static struct block_device *rd_bdev[NUM_
  * architecture-specific setup routine (from the stored boot sector
  * information). 
  */
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
+
 /*
  * It would be very desiderable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
@@ -101,26 +100,17 @@ int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		
  */
 int rd_blocksize = BLOCK_SIZE;			/* blocksize of the RAM disks */
 
+/* Size of the RAM disks */
+int rd_size = (CONFIG_BLK_DEV_RAM_SIZE + (PAGE_CACHE_SIZE >> 10) - 1) &
+			(PAGE_CACHE_MASK >> 10);
+
 /*
  * Copyright (C) 2000 Linus Torvalds.
  *               2000 Transmeta Corp.
  * aops copied from ramfs.
  */
-static int ramdisk_readpage(struct file *file, struct page * page)
-{
-	if (!PageUptodate(page)) {
-		void *kaddr = kmap_atomic(page, KM_USER0);
-
-		memset(kaddr, 0, PAGE_CACHE_SIZE);
-		flush_dcache_page(page);
-		kunmap_atomic(kaddr, KM_USER0);
-		SetPageUptodate(page);
-	}
-	unlock_page(page);
-	return 0;
-}
 
-static int ramdisk_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+static void wipe_page(struct page *page)
 {
 	if (!PageUptodate(page)) {
 		void *kaddr = kmap_atomic(page, KM_USER0);
@@ -130,43 +120,26 @@ static int ramdisk_prepare_write(struct 
 		kunmap_atomic(kaddr, KM_USER0);
 		SetPageUptodate(page);
 	}
-	SetPageDirty(page);
-	return 0;
-}
-
-static int ramdisk_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
-{
-	return 0;
 }
 
-static struct address_space_operations ramdisk_aops = {
-	readpage: ramdisk_readpage,
-	writepage: fail_writepage,
-	prepare_write: ramdisk_prepare_write,
-	commit_write: ramdisk_commit_write,
-};
-
-static int rd_blkdev_pagecache_IO(int rw, struct bio_vec *vec,
-				  sector_t sector, int minor)
+static int
+rd_blkdev_pagecache_IO(int rw, struct bio_vec *vec, sector_t sector, int minor)
 {
-	struct address_space * mapping;
+	struct address_space *mapping;
 	unsigned long index;
 	unsigned int vec_offset;
 	int offset, size, err;
 
 	err = 0;
 	mapping = rd_bdev[minor]->bd_inode->i_mapping;
-
 	index = sector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sector << 9) & ~PAGE_CACHE_MASK;
 	size = vec->bv_len;
 	vec_offset = vec->bv_offset;
 
 	do {
+		struct page *page;
 		int count;
-		struct page * page;
-		char * src, * dst;
-		int unlock = 0;
 
 		count = PAGE_CACHE_SIZE - offset;
 		if (count > size)
@@ -176,53 +149,39 @@ static int rd_blkdev_pagecache_IO(int rw
 		page = find_get_page(mapping, index);
 		if (!page) {
 			page = grab_cache_page(mapping, index);
-			err = -ENOMEM;
-			if (!page)
+			if (!page) {
+				err = -ENOMEM;
 				goto out;
-			err = 0;
-
-			if (!PageUptodate(page)) {
-				void *kaddr = kmap_atomic(page, KM_USER0);
-
-				memset(kaddr, 0, PAGE_CACHE_SIZE);
-				flush_dcache_page(page);
-				kunmap_atomic(kaddr, KM_USER0);
-				SetPageUptodate(page);
 			}
-
-			unlock = 1;
+			wipe_page(page);
+			set_page_dirty(page);
+			unlock_page(page);
 		}
+		if (page != vec->bv_page || vec_offset != offset) {
+			if (rw == READ) {
+				char *src = kmap_atomic(page, KM_USER0);
+				char *dst = kmap_atomic(vec->bv_page, KM_USER1);
+
+				memcpy(dst + vec_offset, src + offset, count);
+				flush_dcache_page(vec->bv_page);
+				kunmap_atomic(src, KM_USER0);
+				kunmap_atomic(dst, KM_USER1);
+			} else {
+				char *src = kmap_atomic(vec->bv_page, KM_USER0);
+				char *dst = kmap_atomic(page, KM_USER1);
 
-		index++;
-
-		if (rw == READ) {
-			src = kmap(page);
-			src += offset;
-			dst = kmap(vec->bv_page) + vec_offset;
-		} else {
-			dst = kmap(page);
-			dst += offset;
-			src = kmap(vec->bv_page) + vec_offset;
+				memcpy(dst + offset, src + vec_offset, count);
+				flush_dcache_page(page);
+				kunmap_atomic(src, KM_USER0);
+				kunmap_atomic(dst, KM_USER1);
+			}
 		}
+		page_cache_release(page);
 		offset = 0;
 		vec_offset += count;
-
-		memcpy(dst, src, count);
-
-		kunmap(page);
-		kunmap(vec->bv_page);
-
-		if (rw == READ) {
-			flush_dcache_page(sbh->b_page);
-		} else {
-			SetPageDirty(page);
-		}
-		if (unlock)
-			unlock_page(page);
-		__free_page(page);
+		index++;
 	} while (size);
-
- out:
+out:
 	return err;
 }
 
@@ -326,7 +285,6 @@ static ssize_t initrd_read(struct file *
 	return count;
 }
 
-
 static int initrd_release(struct inode *inode,struct file *file)
 {
 	extern void free_initrd_mem(unsigned long, unsigned long);
@@ -345,14 +303,19 @@ static int initrd_release(struct inode *
 	return 0;
 }
 
-
 static struct file_operations initrd_fops = {
-	read:		initrd_read,
-	release:	initrd_release,
+	.read		= initrd_read,
+	.release	= initrd_release,
 };
 
 #endif
 
+struct address_space_operations ramdisk_aops;
+
+static struct backing_dev_info rd_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
 
 static int rd_open(struct inode * inode, struct file * filp)
 {
@@ -377,21 +340,23 @@ static int rd_open(struct inode * inode,
 	 * Immunize device against invalidate_buffers() and prune_icache().
 	 */
 	if (rd_bdev[unit] == NULL) {
-		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
-		rd_bdev[unit]->bd_openers++;
-		rd_bdev[unit]->bd_block_size = rd_blocksize;
-		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
-		rd_bdev[unit]->bd_inode->i_size = rd_length[unit];
-		rd_bdev[unit]->bd_queue = &blk_dev[MAJOR_NR].request_queue;
-	}
+		struct block_device *b = bdget(kdev_t_to_nr(inode->i_rdev));
 
+		rd_bdev[unit] = b;
+		b->bd_openers++;
+		b->bd_block_size = rd_blocksize;
+		b->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		b->bd_inode->i_mapping->backing_dev_info = &rd_backing_dev_info;
+		b->bd_inode->i_size = rd_length[unit];
+		b->bd_queue = &blk_dev[MAJOR_NR].request_queue;
+	}
 	return 0;
 }
 
 static struct block_device_operations rd_bd_op = {
-	owner:		THIS_MODULE,
-	open:		rd_open,
-	ioctl:		rd_ioctl,
+	.owner	= THIS_MODULE,
+	.open	= rd_open,
+	.ioctl	= rd_ioctl,
 };
 
 /* Before freeing the module, invalidate all of the protected buffers! */
@@ -417,6 +382,19 @@ static void __exit rd_cleanup (void)
 	unregister_blkdev( MAJOR_NR, "ramdisk" );
 }
 
+/*
+ * If someone writes a ramdisk page with submit_bh(), we have a dirty page
+ * with clean buffers.  try_to_free_buffers() will then propagate the buffer
+ * cleanness up into page-cleaness and the VM will evict the page.
+ *
+ * To stop that happening, the ramdisk address_space has a ->releasepage()
+ * which always fails.
+ */
+static int fail_releasepage(struct page *page, int offset)
+{
+	return 0;
+}
+
 /* This is the registration and initialization section of the RAM disk driver */
 static int __init rd_init (void)
 {
@@ -429,6 +407,9 @@ static int __init rd_init (void)
 		       rd_blocksize);
 		rd_blocksize = BLOCK_SIZE;
 	}
+	ramdisk_aops = def_blk_aops;
+	ramdisk_aops.writepage = fail_writepage;
+	ramdisk_aops.releasepage = fail_releasepage;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	initrd_disk = alloc_disk();
@@ -522,9 +503,8 @@ __setup("ramdisk_blocksize=", ramdisk_bl
 #endif
 
 /* options - modular */
-MODULE_PARM     (rd_size, "1i");
+MODULE_PARM(rd_size, "1i");
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 MODULE_PARM     (rd_blocksize, "i");
 MODULE_PARM_DESC(rd_blocksize, "Blocksize of each RAM disk in bytes.");
-
 MODULE_LICENSE("GPL");
--- 2.5.41/fs/buffer.c~rd-cleanup	Tue Oct  8 13:30:42 2002
+++ 2.5.41-akpm/fs/buffer.c	Tue Oct  8 13:30:42 2002
@@ -389,14 +389,21 @@ __find_get_block_slow(struct block_devic
 	head = page_buffers(page);
 	bh = head;
 	do {
-		if (bh->b_blocknr == block) {
+		if (bh->b_blocknr == block && buffer_mapped(bh)) {
 			ret = bh;
 			get_bh(bh);
 			goto out_unlock;
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	buffer_error();
+	/*
+	 * This path can happen if the page had some unmapped buffers, which
+	 * will have b_blocknr == -1.  When a ramdisk mapping's page was brought
+	 * partially uptodate by mkfs and unmap_underlying_metadata searches
+	 * for blocks in part of the page which wasn't touched by mkfs.
+	 *
+	 * buffer_error();
+	 */
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);
@@ -1457,7 +1464,7 @@ int try_to_release_page(struct page *pag
  * @offset: the index of the truncation point
  *
  * block_invalidatepage() is called when all or part of the page has become
- * invalidatedby a truncate operation.
+ * invalidated by a truncate operation.
  *
  * block_invalidatepage() does not have to release all buffers, but it must
  * ensure that no dirty buffer is left outside @offset and that no I/O
@@ -1611,8 +1618,6 @@ static int __block_write_full_page(struc
 	last_block = (inode->i_size - 1) >> inode->i_blkbits;
 
 	if (!page_has_buffers(page)) {
-		if (S_ISBLK(inode->i_mode))
-			buffer_error();
 		if (!PageUptodate(page))
 			buffer_error();
 		create_empty_buffers(page, 1 << inode->i_blkbits,
@@ -2658,7 +2663,8 @@ void free_buffer_head(struct buffer_head
 }
 EXPORT_SYMBOL(free_buffer_head);
 
-static void init_buffer_head(void *data, kmem_cache_t *cachep, unsigned long flags)
+static void
+init_buffer_head(void *data, kmem_cache_t *cachep, unsigned long flags)
 {
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 			    SLAB_CTOR_CONSTRUCTOR) {
--- 2.5.41/kernel/ksyms.c~rd-cleanup	Tue Oct  8 13:30:42 2002
+++ 2.5.41-akpm/kernel/ksyms.c	Tue Oct  8 13:30:42 2002
@@ -139,6 +139,7 @@ EXPORT_SYMBOL(page_address);
 EXPORT_SYMBOL(get_user_pages);
 
 /* filesystem internal functions */
+EXPORT_SYMBOL_GPL(def_blk_aops);
 EXPORT_SYMBOL(def_blk_fops);
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);

.
