Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318486AbSGZUp7>; Fri, 26 Jul 2002 16:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318489AbSGZUp6>; Fri, 26 Jul 2002 16:45:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318486AbSGZUpn>;
	Fri, 26 Jul 2002 16:45:43 -0400
Message-ID: <3D41B536.83FA57EA@zip.com.au>
Date: Fri, 26 Jul 2002 13:46:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT read and holes in 2.5.26
References: <3D3B6D57.BB5C0F38@zip.com.au> <1027714959.1728.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> ...
> >
> > I'd be interested in seeing just how expensive that O_DIRECT
> > I/O is, and whether we need to get down and implement
> > many-block get_block() interface.  Any numbers/profiles
> > available?
> >
> 
> I will try and generate some numbers once I emerge from under a
> mountain of email - I cannot use the Linus approach to email
> backlogs ;-)

Don't bother.  I reworked it all.

generic_direct_IO() no longer uses get_block().  It uses get_blocks(),
which allows the fs to map up to 4gigs of disk in a single hit.

For example:

static int
blkdev_get_blocks(struct inode *inode, sector_t iblock, sector_t max_blocks,
                struct buffer_head *bh, int create)
{
        if ((iblock + max_blocks) >= max_block(inode->i_bdev))
                return -EIO;

        bh->b_bdev = inode->i_bdev;
        bh->b_blocknr = iblock;
        bh->b_size = max_blocks << inode->i_blkbits;
        set_buffer_mapped(bh);
        return 0;
}

The idea is, xfs_get_blocks() will be able to map as many blocks
as it can at `iblock', up to `max_blocks', and will return the
number of blocks which it managed to map at ->b_size.   Pretty
simple extension.

It means that for O_DIRECT IO to blockdevs and for access to the raw
device, we can perform 512-byte aligned IO, laying out maximum-sized
BIOs all the way with just a single call to ->get_blocks().  Can't
beat that.

get_blocks() won't live for long, I suspect.  Either I kill all the
get_block() instances and convert them to the get_blocks() API,
or we do something totally different which doesn't use buffer_heads.

The core question is: should the mapping callback be able to return
a list of blocks, or just a (start, length) extent.   I'd really rather
just make it an extent - otherwise there's a ton of sticky rework to
be done.

The messy part is with writes, where you've gone and instantiated
a lot of blocks into the file and then something goes wrong, and
we need to take those blocks back, or zero them out.  I'm taking
the latter approach in fs/direct_io.c.  That bit hasn't been
tested yet, but everything else seems to work nicely.  I taught
fsx-linux about O_DIRECT and it is happy.

Current patch is at

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.28/dio-raw.patch

Remaining work here is to redo readv/writev against O_DIRECT
files and the raw driver so that we only wait on IO after
everything has been submitted, rather than after each segment.

hmm.  Australia seems to be offline.  Here's the patch:

 drivers/char/raw.c |  108 +++++++++-----------
 fs/block_dev.c     |   28 ++++-
 fs/direct-io.c     |  277 ++++++++++++++++++++++++++++++++++++++++++-----------
 fs/ext2/inode.c    |   15 ++
 fs/jfs/inode.c     |   15 ++
 include/linux/fs.h |    8 +
 6 files changed, 329 insertions(+), 122 deletions(-)

--- 2.5.28/fs/direct-io.c~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/fs/direct-io.c	Fri Jul 26 02:06:46 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/wait.h>
@@ -40,12 +41,15 @@ struct dio {
 	struct inode *inode;
 	int rw;
 	sector_t block_in_file;		/* changes */
+	unsigned blocks_available;	/* At block_in_file.  changes */
 	sector_t final_block_in_request;/* doesn't change */
 	unsigned first_block_in_page;	/* doesn't change */
 	int boundary;			/* prev block is at a boundary */
 	int reap_counter;		/* rate limit reaping */
-	get_block_t *get_block;
+	get_blocks_t *get_blocks;
 	sector_t last_block_in_bio;
+	sector_t next_block_in_bio;	/* changes */
+	struct buffer_head map_bh;
 
 	/* Page fetching state */
 	int curr_page;			/* changes */
@@ -56,6 +60,7 @@ struct dio {
 	struct page *pages[DIO_PAGES];
 	unsigned head;
 	unsigned tail;
+	int page_errors;
 
 	/* BIO completion state */
 	atomic_t bio_count;
@@ -93,6 +98,21 @@ static int dio_refill_pages(struct dio *
 		NULL);				/* vmas */
 	up_read(&current->mm->mmap_sem);
 
+	if (ret < 0 && dio->blocks_available && (dio->rw == WRITE)) {
+		/*
+		 * A memory fault, but the filesystem has some outstanding
+		 * mapped blocks.  We need to use those blocks up to avoid
+		 * leaking stale data in the file.
+		 */
+		if (dio->page_errors == 0)
+			dio->page_errors = ret;
+		dio->pages[0] = ZERO_PAGE(dio->cur_user_address);
+		dio->head = 0;
+		dio->tail = 1;
+		ret = 0;
+		goto out;
+	}
+
 	if (ret >= 0) {
 		dio->curr_user_address += ret * PAGE_SIZE;
 		dio->curr_page += ret;
@@ -100,6 +120,7 @@ static int dio_refill_pages(struct dio *
 		dio->tail = ret;
 		ret = 0;
 	}
+out:
 	return ret;	
 }
 
@@ -115,11 +136,8 @@ static struct page *dio_get_page(struct 
 		int ret;
 
 		ret = dio_refill_pages(dio);
-		if (ret) {
-			printk("%s: dio_refill_pages returns %d\n",
-				__FUNCTION__, ret);
+		if (ret)
 			return ERR_PTR(ret);
-		}
 		BUG_ON(dio_pages_present(dio) == 0);
 	}
 	return dio->pages[dio->head++];
@@ -140,8 +158,9 @@ static void dio_bio_end_io(struct bio *b
 	spin_lock_irqsave(&dio->bio_list_lock, flags);
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
+	if (dio->waiter)
+		wake_up_process(dio->waiter);
 	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-	wake_up_process(dio->waiter);
 }
 
 static int
@@ -179,6 +198,7 @@ static void dio_bio_submit(struct dio *d
 
 	dio->bio = NULL;
 	dio->bvec = NULL;
+	dio->boundary = 0;
 }
 
 /*
@@ -202,10 +222,12 @@ static struct bio *dio_await_one(struct 
 	while (dio->bio_list == NULL) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (dio->bio_list == NULL) {
+			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
 			blk_run_queues();
 			schedule();
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
+			dio->waiter = NULL;
 		}
 		set_current_state(TASK_RUNNING);
 	}
@@ -268,15 +290,12 @@ static int dio_bio_reap(struct dio *dio)
 		while (dio->bio_list) {
 			unsigned long flags;
 			struct bio *bio;
-			int ret2;
 
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
 			bio = dio->bio_list;
 			dio->bio_list = bio->bi_private;
 			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-			ret2 = dio_bio_complete(dio, bio);
-			if (ret == 0)
-				ret = ret2;
+			ret = dio_bio_complete(dio, bio);
 		}
 		dio->reap_counter = 0;
 	}
@@ -284,7 +303,138 @@ static int dio_bio_reap(struct dio *dio)
 }
 
 /*
+ * Call into the fs to map some more disk blocks.  We record the current number
+ * of available blocks at dio->blocks_available.  These are in units of the
+ * fs blocksize, (1 << inode->i_blkbits).
+ *
+ * The fs is allowed to map lots of blocks at once.  If it wants to do that,
+ * it uses the passed inode-relative block number as the file offset, as usual.
+ *
+ * In bh->b_blocknr it will find the number of i_blkbits-sized blocks which
+ * direct_io has remaining to do.  The fs should not map more than this number
+ * of blocks.
+ *
+ * If the fs has mapped a lot of blocks, it should populate bh->b_size to
+ * indicate how much contiguous disk space has been made available at
+ * bh->b_blocknr.
+ *
+ * If *any* of the mapped blocks are new, then the fs must set buffer_new().
+ * This isn't very efficient...
+ *
+ * If there is a hole in the filesystem then the fs must return a single
+ * block, with !buffer_mapped().  This code doesn't understand multiblock
+ * holes (but it could..).  The fs must return the holes one-at-a-time.
+ */
+static int get_more_blocks(struct dio *dio)
+{
+	int ret;
+	struct buffer_head *map_bh = &dio->map_bh;
+	unsigned blkbits;
+
+	if (dio->blocks_available)
+		return 0;
+
+	/*
+	 * If there was a memory error and we've overwritten all the
+	 * mapped blocks then we can now return that memory error
+	 */
+	if (dio->page_errors) {
+		ret = dio->page_errors;
+		goto out;
+	}
+
+	map_bh->b_state = 0;
+	map_bh->b_size = 0;
+	BUG_ON(dio->block_in_file >= dio->final_block_in_request);
+	ret = (*dio->get_blocks)(dio->inode, dio->block_in_file,
+			dio->final_block_in_request - dio->block_in_file,
+			map_bh, dio->rw == WRITE);
+	if (ret)
+		goto out;
+
+	blkbits = dio->inode->i_blkbits;
+	if (buffer_mapped(map_bh)) {
+		BUG_ON(map_bh->b_size == 0);
+		BUG_ON((map_bh->b_size & ((1 << blkbits) - 1)) != 0);
+
+		dio->blocks_available = map_bh->b_size >> blkbits;
+
+		/* blockdevs do not set buffer_new */
+		if (buffer_new(map_bh)) {
+			sector_t block = map_bh->b_blocknr;
+			unsigned i;
+
+			for (i = 0; i < dio->blocks_available; i++)
+				unmap_underlying_metadata(map_bh->b_bdev,
+							block++);
+		}
+	} else {
+		BUG_ON(dio->rw != READ);
+		if (dio->bio)
+			dio_bio_submit(dio);
+	}
+	dio->next_block_in_bio = map_bh->b_blocknr;
+out:
+	return ret;
+}
+
+/*
+ * Check to see if we can continue to grow the BIO. If not, then send it.
+ */
+static void dio_prep_bio(struct dio *dio)
+{
+	if (dio->bio) {
+		int send = 0;
+
+		if (dio->bio->bi_idx == dio->bio->bi_vcnt) {
+			printk("1");
+			send = 1;
+		}
+		if (dio->boundary) {
+			printk("2");
+			send = 1;
+		}
+		if (dio->last_block_in_bio != dio->next_block_in_bio - 1) {
+			printk("3");
+			send = 1;
+		}
+		if (send)
+			dio_bio_submit(dio);
+	}
+}
+
+/*
+ * There is no bio.  Make one now.
+ */
+static int dio_new_bio(struct dio *dio)
+{
+	sector_t sector;
+	int ret;
+
+	ret = dio_bio_reap(dio);
+	if (ret)
+		goto out;;
+	sector = dio->next_block_in_bio << (dio->inode->i_blkbits - 9);
+	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector,
+				DIO_BIO_MAX_SIZE / PAGE_SIZE);
+	dio->boundary = 0;
+out:
+	return ret;
+}
+
+/*
  * Walk the user pages, and the file, mapping blocks to disk and emitting BIOs.
+ *
+ * Direct IO against a blockdev is different from a file.  Because we can
+ * happily perform page-sized but 512-byte aligned IOs.  It is important that
+ * blockdev IO be able to have fine alignment and large sizes.
+ *
+ * So what we do is to permit the ->get_blocks function to populate bh.b_size
+ * with the size of IO which is permitted at this offset and this i_blkbits.
+ *
+ * For best results, the blockdev should be set up with 512-byte i_blkbits and
+ * it should set b_size to PAGE_SIZE or more inside ->get_block.  This gives
+ * fine alignment but still allows this function to work in PAGE_SIZE units.
  */
 int do_direct_IO(struct dio *dio)
 {
@@ -309,46 +459,35 @@ int do_direct_IO(struct dio *dio)
 		}
 
 		new_page = 1;
-		for ( ; block_in_page < blocks_per_page; block_in_page++) {
-			struct buffer_head map_bh;
+		while (block_in_page < blocks_per_page) {
 			struct bio *bio;
+			unsigned this_chunk_bytes;	/* # of bytes mapped */
+			unsigned this_chunk_blocks;	/* # of blocks */
+			unsigned u;
 
-			map_bh.b_state = 0;
-			ret = (*dio->get_block)(inode, dio->block_in_file,
-						&map_bh, dio->rw == WRITE);
-			if (ret) {
-				printk("%s: get_block returns %d\n",
-					__FUNCTION__, ret);
-				goto fail_release;
-			}
-			/* blockdevs do not set buffer_new */
-			if (buffer_new(&map_bh))
-				unmap_underlying_metadata(map_bh.b_bdev,
-							map_bh.b_blocknr);
-			if (!buffer_mapped(&map_bh)) {
-				ret = -EINVAL;		/* A hole */
+			ret = get_more_blocks(dio);
+			if (ret)
 				goto fail_release;
+
+			/* Handle holes */
+			if (!buffer_mapped(&dio->map_bh)) {
+				char *kaddr = kmap_atomic(page, KM_USER0);
+				memset(kaddr + (block_in_page << blkbits),
+						0, blocksize);
+				flush_dcache_page(page);
+				kunmap_atomic(kaddr, KM_USER0);
+				dio->block_in_file++;
+				dio->next_block_in_bio++;
+				block_in_page++;
+				goto next_block;
 			}
-			if (dio->bio) {
-				if (dio->bio->bi_idx == dio->bio->bi_vcnt ||
-						dio->boundary ||
-						dio->last_block_in_bio !=
-							map_bh.b_blocknr - 1) {
-					dio_bio_submit(dio);
-					dio->boundary = 0;
-				}
-			}
+
+			dio_prep_bio(dio);
 			if (dio->bio == NULL) {
-				ret = dio_bio_reap(dio);
-				if (ret)
-					goto fail_release;
-				ret = dio_bio_alloc(dio, map_bh.b_bdev,
-					map_bh.b_blocknr << (blkbits - 9),
-					DIO_BIO_MAX_SIZE / PAGE_SIZE);
+				ret = dio_new_bio(dio);
 				if (ret)
 					goto fail_release;
 				new_page = 1;
-				dio->boundary = 0;
 			}
 
 			bio = dio->bio;
@@ -357,17 +496,34 @@ int do_direct_IO(struct dio *dio)
 				page_cache_get(page);
 				dio->bvec->bv_page = page;
 				dio->bvec->bv_len = 0;
-				dio->bvec->bv_offset = block_in_page*blocksize;
+				dio->bvec->bv_offset = block_in_page << blkbits;
 				bio->bi_idx++;
+				new_page = 0;
 			}
-			new_page = 0;
-			dio->bvec->bv_len += blocksize;
-			bio->bi_size += blocksize;
-			dio->last_block_in_bio = map_bh.b_blocknr;
-			dio->boundary = buffer_boundary(&map_bh);
 
-			dio->block_in_file++;
-			if (dio->block_in_file >= dio->final_block_in_request)
+			/* Work out how much disk we can add to this page */
+			this_chunk_blocks = dio->blocks_available;
+			u = (PAGE_SIZE - dio->bvec->bv_len) >> blkbits;
+			if (this_chunk_blocks > u)
+				this_chunk_blocks = u;
+			u = dio->final_block_in_request - dio->block_in_file;
+			if (this_chunk_blocks > u)
+				this_chunk_blocks = u;
+			this_chunk_bytes = this_chunk_blocks << blkbits;
+			BUG_ON(this_chunk_bytes == 0);
+
+			dio->bvec->bv_len += this_chunk_bytes;
+			bio->bi_size += this_chunk_bytes;
+			dio->next_block_in_bio += this_chunk_blocks;
+			dio->last_block_in_bio = dio->next_block_in_bio - 1;
+			dio->boundary = buffer_boundary(&dio->map_bh);
+			dio->block_in_file += this_chunk_blocks;
+			block_in_page += this_chunk_blocks;
+			dio->blocks_available -= this_chunk_blocks;
+next_block:
+			if (dio->block_in_file > dio->final_block_in_request)
+				BUG();
+			if (dio->block_in_file == dio->final_block_in_request)
 				break;
 		}
 		block_in_page = 0;
@@ -376,6 +532,7 @@ int do_direct_IO(struct dio *dio)
 	ret = 0;
 	goto out;
 fail_release:
+	printk("%s: returning error %d\n", __FUNCTION__, ret);
 	page_cache_release(page);
 out:
 	return ret;
@@ -383,7 +540,7 @@ out:
 
 int
 generic_direct_IO(int rw, struct inode *inode, char *buf, loff_t offset,
-			size_t count, get_block_t get_block)
+			size_t count, get_blocks_t get_blocks)
 {
 	const unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
 	const unsigned long user_addr = (unsigned long)buf;
@@ -404,6 +561,7 @@ generic_direct_IO(int rw, struct inode *
 	dio.inode = inode;
 	dio.rw = rw;
 	dio.block_in_file = offset >> inode->i_blkbits;
+	dio.blocks_available = 0;
 	dio.final_block_in_request = (offset + count) >> inode->i_blkbits;
 
 	/* Index into the first page of the first block */
@@ -411,8 +569,9 @@ generic_direct_IO(int rw, struct inode *
 						>> inode->i_blkbits;
 	dio.boundary = 0;
 	dio.reap_counter = 0;
-	dio.get_block = get_block;
+	dio.get_blocks = get_blocks;
 	dio.last_block_in_bio = -1;
+	dio.next_block_in_bio = -1;
 
 	/* Page fetching state */
 	dio.curr_page = 0;
@@ -428,12 +587,13 @@ generic_direct_IO(int rw, struct inode *
 	/* Page queue */
 	dio.head = 0;
 	dio.tail = 0;
+	dio.page_errors = 0;
 
 	/* BIO completion state */
 	atomic_set(&dio.bio_count, 0);
 	spin_lock_init(&dio.bio_list_lock);
 	dio.bio_list = NULL;
-	dio.waiter = current;
+	dio.waiter = NULL;
 
 	ret = do_direct_IO(&dio);
 
@@ -445,8 +605,19 @@ generic_direct_IO(int rw, struct inode *
 	if (ret == 0)
 		ret = ret2;
 	if (ret == 0)
+		ret = dio.page_errors;
+	if (ret == 0)
 		ret = count - ((dio.final_block_in_request -
 				dio.block_in_file) << inode->i_blkbits);
+	if (dio.blocks_available != 0) {
+		printk("%s: blocks_available is %u, rw=%d\n",
+				__FUNCTION__, dio.blocks_available, rw);
+		printk("offset=%Ld(%Ld), count=%u(%u)\n",
+			offset, offset >> inode->i_blkbits,
+			count, count >> inode->i_blkbits);
+	}
+	if (ret != count)
+		printk("%s: returning %d, not %d\n", __FUNCTION__, ret, count);
 out:
 	return ret;
 }
--- 2.5.28/fs/block_dev.c~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/fs/block_dev.c	Thu Jul 25 23:25:30 2002
@@ -24,14 +24,14 @@
 
 #include <asm/uaccess.h>
 
-static unsigned long max_block(struct block_device *bdev)
+static sector_t max_block(struct block_device *bdev)
 {
-	unsigned int retval = ~0U;
+	sector_t retval = ~0U;
 	loff_t sz = bdev->bd_inode->i_size;
 
 	if (sz) {
-		unsigned int size = block_size(bdev);
-		unsigned int sizebits = blksize_bits(size);
+		sector_t size = block_size(bdev);
+		unsigned sizebits = blksize_bits(size);
 		retval = (sz >> sizebits);
 	}
 	return retval;
@@ -88,7 +88,9 @@ int sb_min_blocksize(struct super_block 
 	return sb_set_blocksize(sb, size);
 }
 
-static int blkdev_get_block(struct inode * inode, sector_t iblock, struct buffer_head * bh, int create)
+static int
+blkdev_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh, int create)
 {
 	if (iblock >= max_block(inode->i_bdev))
 		return -EIO;
@@ -100,11 +102,25 @@ static int blkdev_get_block(struct inode
 }
 
 static int
+blkdev_get_blocks(struct inode *inode, sector_t iblock, sector_t max_blocks,
+		struct buffer_head *bh, int create)
+{
+	if ((iblock + max_blocks) >= max_block(inode->i_bdev))
+		return -EIO;
+
+	bh->b_bdev = inode->i_bdev;
+	bh->b_blocknr = iblock;
+	bh->b_size = max_blocks << inode->i_blkbits;
+	set_buffer_mapped(bh);
+	return 0;
+}
+
+static int
 blkdev_direct_IO(int rw, struct inode *inode, char *buf,
 			loff_t offset, size_t count)
 {
 	return generic_direct_IO(rw, inode, buf, offset,
-				count, blkdev_get_block);
+				count, blkdev_get_blocks);
 }
 
 static int blkdev_writepage(struct page * page)
--- 2.5.28/drivers/char/raw.c~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/drivers/char/raw.c	Thu Jul 25 23:25:30 2002
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
+#include <linux/blkpg.h>
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
@@ -21,7 +22,7 @@
 
 typedef struct raw_device_data_s {
 	struct block_device *binding;
-	int inuse, sector_size, sector_bits;
+	int inuse;
 	struct semaphore mutex;
 } raw_device_data_t;
 
@@ -72,8 +73,6 @@ int raw_open(struct inode *inode, struct
 	int minor;
 	struct block_device * bdev;
 	int err;
-	int sector_size;
-	int sector_bits;
 
 	minor = minor(inode->i_rdev);
 	
@@ -89,8 +88,7 @@ int raw_open(struct inode *inode, struct
 	down(&raw_devices[minor].mutex);
 	/*
 	 * No, it is a normal raw device.  All we need to do on open is
-	 * to check that the device is bound, and force the underlying
-	 * block device to a sector-size blocksize. 
+	 * to check that the device is bound.
 	 */
 
 	bdev = raw_devices[minor].binding;
@@ -100,23 +98,8 @@ int raw_open(struct inode *inode, struct
 
 	atomic_inc(&bdev->bd_count);
 	err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
-	if (err)
-		goto out;
-	
-	/*
-	 * Don't change the blocksize if we already have users using
-	 * this device 
-	 */
-
-	if (raw_devices[minor].inuse++)
-		goto out;
-
-	sector_size = bdev_hardsect_size(bdev);
-	raw_devices[minor].sector_size = sector_size;
-	for (sector_bits = 0; !(sector_size & 1); )
-		sector_size>>=1, sector_bits++;
-	raw_devices[minor].sector_bits = sector_bits;
-
+	if (!err)
+		raw_devices[minor].inuse++;
  out:
 	up(&raw_devices[minor].mutex);
 	
@@ -141,22 +124,31 @@ int raw_release(struct inode *inode, str
 
 /* Forward ioctls to the underlying block device. */ 
 int raw_ioctl(struct inode *inode, 
-		  struct file *flip,
+		  struct file *filp,
 		  unsigned int command, 
 		  unsigned long arg)
 {
-	int minor = minor(inode->i_rdev), err; 
+	int minor = minor(inode->i_rdev);
+	int err; 
 	struct block_device *b; 
+
+	err = -ENODEV;
 	if (minor < 1 && minor > 255)
-		return -ENODEV;
+		goto out;
 
 	b = raw_devices[minor].binding;
-	err = -EINVAL; 
-	if (b && b->bd_inode && b->bd_op && b->bd_op->ioctl) { 
-		err = b->bd_op->ioctl(b->bd_inode, NULL, command, arg); 
-	} 
+	err = -EINVAL;
+	if (b == NULL)
+		goto out;
+	if (command == BLKBSZGET || command == BLKBSZSET) {
+		err = blk_ioctl(b, command, arg);
+	} else {
+		if (b->bd_inode && b->bd_op && b->bd_op->ioctl)
+			err = b->bd_op->ioctl(b->bd_inode, NULL, command, arg); 
+	}
+out:
 	return err;
-} 
+}
 
 /*
  * Deal with ioctls against the raw-device control interface, to bind
@@ -164,12 +156,12 @@ int raw_ioctl(struct inode *inode, 
  */
 
 int raw_ctl_ioctl(struct inode *inode, 
-		  struct file *flip,
+		  struct file *filp,
 		  unsigned int command, 
 		  unsigned long arg)
 {
 	struct raw_config_request rq;
-	int err = 0;
+	int err;
 	int minor;
 	
 	switch (command) {
@@ -178,26 +170,23 @@ int raw_ctl_ioctl(struct inode *inode, 
 
 		/* First, find out which raw minor we want */
 
-		if (copy_from_user(&rq, (void *) arg, sizeof(rq))) {
-			err = -EFAULT;
-			break;
-		}
+		err = -EFAULT;
+		if (copy_from_user(&rq, (void *) arg, sizeof(rq)))
+			goto out;
 		
 		minor = rq.raw_minor;
-		if (minor <= 0 || minor > MINORMASK) {
-			err = -EINVAL;
-			break;
-		}
+		err = -EINVAL;
+		if (minor <= 0 || minor > MINORMASK)
+			goto out;
 
 		if (command == RAW_SETBIND) {
 			/*
 			 * This is like making block devices, so demand the
 			 * same capability
 			 */
-			if (!capable(CAP_SYS_ADMIN)) {
-				err = -EPERM;
-				break;
-			}
+			err = -EPERM;
+			if (!capable(CAP_SYS_ADMIN))
+				goto out;
 
 			/* 
 			 * For now, we don't need to check that the underlying
@@ -206,24 +195,23 @@ int raw_ctl_ioctl(struct inode *inode, 
 			 * major/minor numbers make sense. 
 			 */
 
-			if ((rq.block_major == 0 && 
-			     rq.block_minor != 0) ||
-			    rq.block_major > MAX_BLKDEV ||
-			    rq.block_minor > MINORMASK) {
-				err = -EINVAL;
-				break;
-			}
+			err = -EINVAL;
+			if ((rq.block_major == 0 && rq.block_minor != 0) ||
+					rq.block_major > MAX_BLKDEV ||
+					rq.block_minor > MINORMASK)
+				goto out;
 			
 			down(&raw_devices[minor].mutex);
+			err = -EBUSY;
 			if (raw_devices[minor].inuse) {
 				up(&raw_devices[minor].mutex);
-				err = -EBUSY;
-				break;
+				goto out;
 			}
 			if (raw_devices[minor].binding)
 				bdput(raw_devices[minor].binding);
 			raw_devices[minor].binding = 
-				bdget(kdev_t_to_nr(mk_kdev(rq.block_major, rq.block_minor)));
+				bdget(kdev_t_to_nr(mk_kdev(rq.block_major,
+							rq.block_minor)));
 			up(&raw_devices[minor].mutex);
 		} else {
 			struct block_device *bdev;
@@ -237,16 +225,18 @@ int raw_ctl_ioctl(struct inode *inode, 
 			} else {
 				rq.block_major = rq.block_minor = 0;
 			}
-			err = copy_to_user((void *) arg, &rq, sizeof(rq));
-			if (err)
-				err = -EFAULT;
+			err = -EFAULT;
+			if (copy_to_user((void *) arg, &rq, sizeof(rq)))
+				goto out;
 		}
+		err = 0;
 		break;
 		
 	default:
 		err = -EINVAL;
+		break;
 	}
-	
+out:
 	return err;
 }
 
@@ -257,7 +247,7 @@ ssize_t raw_read(struct file *filp, char
 
 ssize_t	raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
 {
-	return rw_raw_dev(WRITE, filp, (char *) buf, size, offp);
+	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
 }
 
 ssize_t
--- 2.5.28/include/linux/fs.h~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/include/linux/fs.h	Thu Jul 25 23:25:30 2002
@@ -210,7 +210,11 @@ extern void mnt_init(unsigned long);
 extern void files_init(unsigned long);
 
 struct buffer_head;
-typedef int (get_block_t)(struct inode*,sector_t,struct buffer_head*,int);
+typedef int (get_block_t)(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
+typedef int (get_blocks_t)(struct inode *inode, sector_t iblock,
+			sector_t max_blocks,
+			struct buffer_head *bh_result, int create);
 
 #include <linux/pipe_fs_i.h>
 /* #include <linux/umsdos_fs_i.h> */
@@ -1233,7 +1237,7 @@ extern void do_generic_file_read(struct 
 ssize_t generic_file_direct_IO(int rw, struct inode *inode, char *buf,
 				loff_t offset, size_t count);
 int generic_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count, get_block_t *get_block);
+			loff_t offset, size_t count, get_blocks_t *get_blocks);
 
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
--- 2.5.28/fs/ext2/inode.c~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/fs/ext2/inode.c	Thu Jul 25 23:25:30 2002
@@ -607,10 +607,23 @@ static int ext2_bmap(struct address_spac
 }
 
 static int
+ext2_get_blocks(struct inode *inode, sector_t iblock, sector_t max_blocks,
+			struct buffer_head *bh_result, int create)
+{
+	int ret;
+
+	ret = ext2_get_block(inode, iblock, bh_result, create);
+	if (ret == 0)
+		bh_result->b_size = (1 << inode->i_blkbits);
+	return ret;
+}
+
+static int
 ext2_direct_IO(int rw, struct inode *inode, char *buf,
 			loff_t offset, size_t count)
 {
-	return generic_direct_IO(rw, inode, buf, offset, count, ext2_get_block);
+	return generic_direct_IO(rw, inode, buf,
+				offset, count, ext2_get_blocks);
 }
 
 static int
--- 2.5.28/fs/jfs/inode.c~dio-raw	Thu Jul 25 23:25:30 2002
+++ 2.5.28-akpm/fs/jfs/inode.c	Thu Jul 25 23:25:30 2002
@@ -293,10 +293,23 @@ static int jfs_bmap(struct address_space
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
+static int
+jfs_get_blocks(struct inode *inode, sector_t iblock, sector_t max_blocks,
+			struct buffer_head *bh_result, int create)
+{
+	int ret;
+
+	ret = jfs_get_block(inode, iblock, bh_result, create);
+	if (ret == 0)
+		bh_result->b_size = (1 << inode->i_blkbits);
+	return ret;
+}
+
 static int jfs_direct_IO(int rw, struct inode *inode, char *buf,
 			loff_t offset, size_t count)
 {
-	return generic_direct_IO(rw, inode, buf, offset, count, jfs_get_block);
+	return generic_direct_IO(rw, inode, buf,
+				offset, count, jfs_get_blocks);
 }
 
 struct address_space_operations jfs_aops = {

.
