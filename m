Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWELGJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWELGJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWELGI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18631 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750966AbWELGI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:08:27 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:08:09 +1000
Message-Id: <1060512060809.8099@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to use bmap to file blocks.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If md is asked to store a bitmap in a file, it tries to hold onto the
page cache pages for that file, manipulate them directly, and call a
cocktail of operations to write the file out.  I don't believe this is
a supportable approach.

This patch changes the approach to use the same approach as swap files.
i.e. bmap is used to enumerate all the block address of parts of the file
and we write directly to those blocks of the device.

swapfile only uses parts of the file that provide a full pages at
contiguous addresses.  We don't have that luxury so we have to cope
with pages that are non-contiguous in storage.  To handle this 
we attach buffers to each page, and store the addresses in those buffers.

With this approach the pagecache may contain data which is inconsistent with 
what is on disk.  To alleviate the problems this can cause, md invalidates
the pagecache when releasing the file.  If the file is to be examined
while the array is active (a non-critical but occasionally useful function),
O_DIRECT io must be used.  And new version of mdadm will have support for this.

This approach simplifies a lot of code:
 - we no longer need to keep a list of pages which we need to wait for,
   as the b_endio function can keep track of how many outstanding
   writes there are.  This saves a mempool.
 - -EAGAIN returns from write_page are no longer possible (not sure if
    they ever were actually).



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c         |  283 ++++++++++++++++++++----------------------
 ./include/linux/raid/bitmap.h |    7 -
 2 files changed, 139 insertions(+), 151 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 16:00:03.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 16:01:06.000000000 +1000
@@ -67,7 +67,6 @@ static inline char * bmname(struct bitma
 	return bitmap->mddev ? mdname(bitmap->mddev) : "mdX";
 }
 
-#define WRITE_POOL_SIZE 256
 
 /*
  * just a placeholder - calls kmalloc for bitmap pages
@@ -279,75 +278,137 @@ static int write_sb_page(mddev_t *mddev,
  */
 static int write_page(struct bitmap *bitmap, struct page *page, int wait)
 {
-	int ret = -ENOMEM;
+	struct buffer_head *bh;
 
 	if (bitmap->file == NULL)
 		return write_sb_page(bitmap->mddev, bitmap->offset, page, wait);
 
-	flush_dcache_page(page); /* make sure visible to anyone reading the file */
+	bh = page_buffers(page);
 
-	if (wait)
-		lock_page(page);
-	else {
-		if (TestSetPageLocked(page))
-			return -EAGAIN; /* already locked */
-		if (PageWriteback(page)) {
-			unlock_page(page);
-			return -EAGAIN;
-		}
+	while (bh && bh->b_blocknr) {
+		atomic_inc(&bitmap->pending_writes);
+		set_buffer_locked(bh);
+		set_buffer_mapped(bh);
+		submit_bh(WRITE, bh);
+		bh = bh->b_this_page;
+	}
+
+	if (wait) {
+		wait_event(bitmap->write_wait,
+			   atomic_read(&bitmap->pending_writes)==0);
+		return (bitmap->flags & BITMAP_WRITE_ERROR) ? -EIO : 0;
 	}
+	return 0;
+}
+
+static void end_bitmap_write(struct buffer_head *bh, int uptodate)
+{
+	struct bitmap *bitmap = bh->b_private;
+	unsigned long flags;
 
-	ret = page->mapping->a_ops->prepare_write(bitmap->file, page, 0, PAGE_SIZE);
-	if (!ret)
-		ret = page->mapping->a_ops->commit_write(bitmap->file, page, 0,
-			PAGE_SIZE);
-	if (ret) {
-		unlock_page(page);
-		return ret;
+	if (!uptodate) {
+		spin_lock_irqsave(&bitmap->lock, flags);
+		bitmap->flags |= BITMAP_WRITE_ERROR;
+		spin_unlock_irqrestore(&bitmap->lock, flags);
 	}
+	if (atomic_dec_and_test(&bitmap->pending_writes))
+		wake_up(&bitmap->write_wait);
+}
 
-	set_page_dirty(page); /* force it to be written out */
+/* copied from buffer.c */
+static void
+__clear_page_buffers(struct page *page)
+{
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	page_cache_release(page);
+}
+static void free_buffers(struct page *page)
+{
+	struct buffer_head *bh = page_buffers(page);
 
-	if (!wait) {
-		/* add to list to be waited for */
-		struct page_list *item = mempool_alloc(bitmap->write_pool, GFP_NOIO);
-		item->page = page;
-		spin_lock(&bitmap->write_lock);
-		list_add(&item->list, &bitmap->complete_pages);
-		spin_unlock(&bitmap->write_lock);
+	while (bh) {
+		struct buffer_head *next = bh->b_this_page;
+		free_buffer_head(bh);
+		bh = next;
 	}
-	return write_one_page(page, wait);
+	__clear_page_buffers(page);
+	put_page(page);
 }
 
-/* read a page from a file, pinning it into cache, and return bytes_read */
+/* read a page from a file.
+ * We both read the page, and attach buffers to the page to record the
+ * address of each block (using bmap).  These addresses will be used
+ * to write the block later, completely bypassing the filesystem.
+ * This usage is similar to how swap files are handled, and allows us
+ * to write to a file with no concerns of memory allocation failing.
+ */
 static struct page *read_page(struct file *file, unsigned long index,
-					unsigned long *bytes_read)
+			      struct bitmap *bitmap,
+			      unsigned long count)
 {
-	struct inode *inode = file->f_mapping->host;
 	struct page *page = NULL;
-	loff_t isize = i_size_read(inode);
-	unsigned long end_index = isize >> PAGE_SHIFT;
+	struct inode *inode = file->f_dentry->d_inode;
+	loff_t pos = index << PAGE_SHIFT;
+	int ret;
+	struct buffer_head *bh;
+	sector_t block;
+	mm_segment_t oldfs;
 
 	PRINTK("read bitmap file (%dB @ %Lu)\n", (int)PAGE_SIZE,
 			(unsigned long long)index << PAGE_SHIFT);
 
-	page = read_cache_page(inode->i_mapping, index,
-			(filler_t *)inode->i_mapping->a_ops->readpage, file);
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		page = ERR_PTR(-ENOMEM);
 	if (IS_ERR(page))
 		goto out;
-	wait_on_page_locked(page);
-	if (!PageUptodate(page) || PageError(page)) {
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = vfs_read(file, (char __user*) page_address(page), count, &pos);
+	set_fs(oldfs);
+
+	if (ret >= 0 && ret != count)
+		ret = -EIO;
+	if (ret < 0) {
 		put_page(page);
-		page = ERR_PTR(-EIO);
+		page = ERR_PTR(ret);
 		goto out;
 	}
+	bh = alloc_page_buffers(page, 1<<inode->i_blkbits, 0);
+	if (!bh) {
+		put_page(page);
+		page = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	attach_page_buffers(page, bh);
+	block = index << (PAGE_SHIFT - inode->i_blkbits);
+	while (bh) {
+		if (count == 0)
+			bh->b_blocknr = 0;
+		else {
+			bh->b_blocknr = bmap(inode, block);
+			if (bh->b_blocknr == 0) {
+				/* Cannot use this file! */
+				free_buffers(page);
+				page = ERR_PTR(-EINVAL);
+				goto out;
+			}
+			bh->b_bdev = inode->i_sb->s_bdev;
+			if (count < (1<<inode->i_blkbits))
+				count = 0;
+			else
+				count -= (1<<inode->i_blkbits);
 
-	if (index > end_index) /* we have read beyond EOF */
-		*bytes_read = 0;
-	else if (index == end_index) /* possible short read */
-		*bytes_read = isize & ~PAGE_MASK;
-	else
-		*bytes_read = PAGE_SIZE; /* got a full page */
+			bh->b_end_io = end_bitmap_write;
+			bh->b_private = bitmap;
+		}
+		block++;
+		bh = bh->b_this_page;
+	}
+
+	page->index = index;
 out:
 	if (IS_ERR(page))
 		printk(KERN_ALERT "md: bitmap read error: (%dB @ %Lu): %ld\n",
@@ -418,16 +479,14 @@ static int bitmap_read_sb(struct bitmap 
 	char *reason = NULL;
 	bitmap_super_t *sb;
 	unsigned long chunksize, daemon_sleep, write_behind;
-	unsigned long bytes_read;
 	unsigned long long events;
 	int err = -EINVAL;
 
 	/* page 0 is the superblock, read it... */
 	if (bitmap->file)
-		bitmap->sb_page = read_page(bitmap->file, 0, &bytes_read);
+		bitmap->sb_page = read_page(bitmap->file, 0, bitmap, PAGE_SIZE);
 	else {
 		bitmap->sb_page = read_sb_page(bitmap->mddev, bitmap->offset, 0);
-		bytes_read = PAGE_SIZE;
 	}
 	if (IS_ERR(bitmap->sb_page)) {
 		err = PTR_ERR(bitmap->sb_page);
@@ -437,13 +496,6 @@ static int bitmap_read_sb(struct bitmap 
 
 	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
 
-	if (bytes_read < sizeof(*sb)) { /* short read */
-		printk(KERN_INFO "%s: bitmap file superblock truncated\n",
-			bmname(bitmap));
-		err = -ENOSPC;
-		goto out;
-	}
-
 	chunksize = le32_to_cpu(sb->chunksize);
 	daemon_sleep = le32_to_cpu(sb->daemon_sleep);
 	write_behind = le32_to_cpu(sb->write_behind);
@@ -589,37 +641,12 @@ static void bitmap_file_unmap(struct bit
 
 	while (pages--)
 		if (map[pages]->index != 0) /* 0 is sb_page, release it below */
-			put_page(map[pages]);
+			free_buffers(map[pages]);
 	kfree(map);
 	kfree(attr);
 
-	safe_put_page(sb_page);
-}
-
-/* dequeue the next item in a page list -- don't call from irq context */
-static struct page_list *dequeue_page(struct bitmap *bitmap)
-{
-	struct page_list *item = NULL;
-	struct list_head *head = &bitmap->complete_pages;
-
-	spin_lock(&bitmap->write_lock);
-	if (list_empty(head))
-		goto out;
-	item = list_entry(head->prev, struct page_list, list);
-	list_del(head->prev);
-out:
-	spin_unlock(&bitmap->write_lock);
-	return item;
-}
-
-static void drain_write_queues(struct bitmap *bitmap)
-{
-	struct page_list *item;
-
-	while ((item = dequeue_page(bitmap))) {
-		/* don't bother to wait */
-		mempool_free(item, bitmap->write_pool);
-	}
+	if (sb_page)
+		free_buffers(sb_page);
 }
 
 static void bitmap_file_put(struct bitmap *bitmap)
@@ -632,12 +659,16 @@ static void bitmap_file_put(struct bitma
 	bitmap->file = NULL;
 	spin_unlock_irqrestore(&bitmap->lock, flags);
 
-	drain_write_queues(bitmap);
-
+	if (file)
+		wait_event(bitmap->write_wait,
+			   atomic_read(&bitmap->pending_writes)==0);
 	bitmap_file_unmap(bitmap);
 
-	if (file)
+	if (file) {
+		struct inode *inode = file->f_dentry->d_inode;
+		invalidate_inode_pages(inode->i_mapping);
 		fput(file);
+	}
 }
 
 
@@ -728,8 +759,6 @@ static void bitmap_file_set_bit(struct b
 
 }
 
-static void bitmap_writeback(struct bitmap *bitmap);
-
 /* this gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
  * sync the dirty pages of the bitmap file to disk */
@@ -761,24 +790,18 @@ int bitmap_unplug(struct bitmap *bitmap)
 			wait = 1;
 		spin_unlock_irqrestore(&bitmap->lock, flags);
 
-		if (dirty | need_write) {
+		if (dirty | need_write)
 			err = write_page(bitmap, page, 0);
-			if (err == -EAGAIN) {
-				if (dirty)
-					err = write_page(bitmap, page, 1);
-				else
-					err = 0;
-			}
-			if (err)
-				return 1;
-		}
 	}
 	if (wait) { /* if any writes were performed, we need to wait on them */
 		if (bitmap->file)
-			bitmap_writeback(bitmap);
+			wait_event(bitmap->write_wait,
+				   atomic_read(&bitmap->pending_writes)==0);
 		else
 			md_super_wait(bitmap->mddev);
 	}
+	if (bitmap->flags & BITMAP_WRITE_ERROR)
+		bitmap_file_kick(bitmap);
 	return 0;
 }
 
@@ -800,7 +823,7 @@ static int bitmap_init_from_disk(struct 
 	struct page *page = NULL, *oldpage = NULL;
 	unsigned long num_pages, bit_cnt = 0;
 	struct file *file;
-	unsigned long bytes, offset, dummy;
+	unsigned long bytes, offset;
 	int outofdate;
 	int ret = -ENOSPC;
 	void *paddr;
@@ -853,7 +876,12 @@ static int bitmap_init_from_disk(struct 
 		index = file_page_index(i);
 		bit = file_page_offset(i);
 		if (index != oldindex) { /* this is a new page, read it in */
+			int count;
 			/* unmap the old page, we're done with it */
+			if (index == num_pages-1)
+				count = bytes - index * PAGE_SIZE;
+			else
+				count = PAGE_SIZE;
 			if (index == 0) {
 				/*
 				 * if we're here then the superblock page
@@ -863,7 +891,7 @@ static int bitmap_init_from_disk(struct 
 				page = bitmap->sb_page;
 				offset = sizeof(bitmap_super_t);
 			} else if (file) {
-				page = read_page(file, index, &dummy);
+				page = read_page(file, index, bitmap, count);
 				offset = 0;
 			} else {
 				page = read_sb_page(bitmap->mddev, bitmap->offset, index);
@@ -999,9 +1027,6 @@ int bitmap_daemon_work(struct bitmap *bi
 				spin_unlock_irqrestore(&bitmap->lock, flags);
 				if (need_write) {
 					switch (write_page(bitmap, page, 0)) {
-					case -EAGAIN:
-						set_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
-						break;
 					case 0:
 						break;
 					default:
@@ -1017,10 +1042,6 @@ int bitmap_daemon_work(struct bitmap *bi
 					clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 					spin_unlock_irqrestore(&bitmap->lock, flags);
 					err = write_page(bitmap, lastpage, 0);
-					if (err == -EAGAIN) {
-						err = 0;
-						set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
-					}
 				} else {
 					set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 					spin_unlock_irqrestore(&bitmap->lock, flags);
@@ -1070,10 +1091,6 @@ int bitmap_daemon_work(struct bitmap *bi
 			clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 			spin_unlock_irqrestore(&bitmap->lock, flags);
 			err = write_page(bitmap, lastpage, 0);
-			if (err == -EAGAIN) {
-				set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
-				err = 0;
-			}
 		} else {
 			set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 			spin_unlock_irqrestore(&bitmap->lock, flags);
@@ -1083,32 +1100,6 @@ int bitmap_daemon_work(struct bitmap *bi
 	return err;
 }
 
-static void bitmap_writeback(struct bitmap *bitmap)
-{
-	struct page *page;
-	struct page_list *item;
-	int err = 0;
-
-	PRINTK("%s: bitmap writeback daemon woke up...\n", bmname(bitmap));
-	/* wait on bitmap page writebacks */
-	while ((item = dequeue_page(bitmap))) {
-		page = item->page;
-		mempool_free(item, bitmap->write_pool);
-		PRINTK("wait on page writeback: %p\n", page);
-		wait_on_page_writeback(page);
-		PRINTK("finished page writeback: %p\n", page);
-
-		err = PageError(page);
-		if (err) {
-			printk(KERN_WARNING "%s: bitmap file writeback "
-			       "failed (page %lu): %d\n",
-			       bmname(bitmap), page->index, err);
-			bitmap_file_kick(bitmap);
-			break;
-		}
-	}
-}
-
 static bitmap_counter_t *bitmap_get_counter(struct bitmap *bitmap,
 					    sector_t offset, int *blocks,
 					    int create)
@@ -1377,8 +1368,6 @@ static void bitmap_free(struct bitmap *b
 
 	/* free all allocated memory */
 
-	mempool_destroy(bitmap->write_pool);
-
 	if (bp) /* deallocate the page memory */
 		for (k = 0; k < pages; k++)
 			if (bp[k].map && !bp[k].hijacked)
@@ -1428,17 +1417,13 @@ int bitmap_create(mddev_t *mddev)
 	spin_lock_init(&bitmap->lock);
 	bitmap->mddev = mddev;
 
-	spin_lock_init(&bitmap->write_lock);
-	INIT_LIST_HEAD(&bitmap->complete_pages);
-	bitmap->write_pool = mempool_create_kmalloc_pool(WRITE_POOL_SIZE,
-						sizeof(struct page_list));
-	err = -ENOMEM;
-	if (!bitmap->write_pool)
-		goto error;
-
 	bitmap->file = file;
 	bitmap->offset = mddev->bitmap_offset;
 	if (file) get_file(file);
+
+	/* Ensure we read fresh data */
+	invalidate_inode_pages(file->f_dentry->d_inode->i_mapping);
+
 	/* read superblock from bitmap file (this sets bitmap->chunksize) */
 	err = bitmap_read_sb(bitmap);
 	if (err)
@@ -1461,6 +1446,9 @@ int bitmap_create(mddev_t *mddev)
 
 	bitmap->syncchunk = ~0UL;
 
+	atomic_set(&bitmap->pending_writes, 0);
+	init_waitqueue_head(&bitmap->write_wait);
+
 #ifdef INJECT_FATAL_FAULT_1
 	bitmap->bp = NULL;
 #else
@@ -1503,4 +1491,3 @@ EXPORT_SYMBOL(bitmap_start_sync);
 EXPORT_SYMBOL(bitmap_end_sync);
 EXPORT_SYMBOL(bitmap_unplug);
 EXPORT_SYMBOL(bitmap_close_sync);
-EXPORT_SYMBOL(bitmap_daemon_work);

diff ./include/linux/raid/bitmap.h~current~ ./include/linux/raid/bitmap.h
--- ./include/linux/raid/bitmap.h~current~	2006-05-12 15:55:37.000000000 +1000
+++ ./include/linux/raid/bitmap.h	2006-05-12 16:01:06.000000000 +1000
@@ -140,6 +140,7 @@ typedef __u16 bitmap_counter_t;
 enum bitmap_state {
 	BITMAP_ACTIVE = 0x001, /* the bitmap is in use */
 	BITMAP_STALE  = 0x002,  /* the bitmap file is out of date or had -EIO */
+	BITMAP_WRITE_ERROR = 0x004, /* A write error has occurred */
 	BITMAP_HOSTENDIAN = 0x8000,
 };
 
@@ -244,9 +245,9 @@ struct bitmap {
 	unsigned long daemon_lastrun; /* jiffies of last run */
 	unsigned long daemon_sleep; /* how many seconds between updates? */
 
-	spinlock_t write_lock;
-	struct list_head complete_pages;
-	mempool_t *write_pool;
+	atomic_t pending_writes; /* pending writes to the bitmap file */
+	wait_queue_head_t write_wait;
+
 };
 
 /* the bitmap API */
