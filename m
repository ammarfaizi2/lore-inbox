Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318927AbSG1HYs>; Sun, 28 Jul 2002 03:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318926AbSG1HYo>; Sun, 28 Jul 2002 03:24:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59909 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318927AbSG1HVs>;
	Sun, 28 Jul 2002 03:21:48 -0400
Message-ID: <3D439E47.A227A2B7@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/13] direct IO updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch is a performance and correctness update to the direct-IO
code: O_DIRECT and the raw driver.  It mainly affects IO against
blockdevs.

The direct_io code was returning -EINVAL for a filesystem hole.  Change
it to clear the userspace page instead.

There were a few restrictions and weirdnesses wrt blocksize and
alignments.  The code has been reworked so we now lay out maximum-sized
BIOs at any sector alignment.

Because of this, the raw driver has been altered to set the blockdev's
soft blocksize to the minimum possible at open() time.  Typically, 512
bytes.  There are now no performance disadvantages to using small
blocksizes, and this gives the finest possible alignment.

There is no API here for setting or querying the soft blocksize of the
raw driver (there never was, really), which could conceivably be a
problem.  If it is, we can permit BLKBSZSET and BLKBSZGET against the
fd which /dev/raw/rawN returned, but that would require that
blk_ioctl() be exported to modules again.

This code is wickedly quick.  Here's an oprofile of a single 500MHz
PIII reading from four (old) scsi disks (two aic7xxx controllers) via
the raw driver.  Aggregate throughput is 72 megabytes/second:

c013363c 24       0.0896492   __set_page_dirty_buffers 
c021b8cc 24       0.0896492   ahc_linux_isr           
c012b5dc 25       0.0933846   kmem_cache_free         
c014d894 26       0.09712     dio_bio_complete        
c01cc78c 26       0.09712     number                  
c0123bd4 40       0.149415    follow_page             
c01eed8c 46       0.171828    end_that_request_first  
c01ed410 49       0.183034    blk_recount_segments    
c01ed574 65       0.2428      blk_rq_map_sg           
c014db38 85       0.317508    do_direct_IO            
c021b090 90       0.336185    ahc_linux_run_device_queue 
c010bb78 236      0.881551    timer_interrupt         
c01052d8 25354    94.707      poll_idle               

A testament to the efficiency of the 2.5 block layer.


And against four IDE disks on an HPT374 controller.  Throughput is 120
megabytes/sec:

c01eed8c 80       0.292462    end_that_request_first  
c01fe850 87       0.318052    hpt3xx_intrproc         
c01ed574 123      0.44966     blk_rq_map_sg           
c01f8f10 141      0.515464    ata_select              
c014db38 153      0.559333    do_direct_IO            
c010bb78 235      0.859107    timer_interrupt         
c01f9144 281      1.02727     ata_irq_enable          
c01ff990 290      1.06017     udma_pci_init           
c01fe878 308      1.12598     hpt3xx_maskproc         
c02006f8 379      1.38554     idedisk_do_request      
c02356a0 609      2.22637     pci_conf1_read          
c01ff8dc 611      2.23368     udma_pci_start          
c01ff950 922      3.37062     udma_pci_irq_status     
c01f8fac 1002     3.66308     ata_status              
c01ff26c 1059     3.87146     ata_start_dma           
c01feb70 1141     4.17124     hpt374_udma_stop        
c01f9228 3072     11.2305     ata_out_regfile         
c01052d8 15193    55.5422     poll_idle               

Not so good.


One problem which has been identified with O_DIRECT is the cost of
repeated calls into the mapping's get_block() callback.  Not a big
problem with ext2 but other filesystems have more complex get_block
implementations.

So what I have done is to require that callers of generic_direct_IO()
implement the new `get_blocks()' interface.  This is a small extension
to get_block().  It gets passed another argument which indicates the
maximum number of blocks which should be mapped, and it returns the
number of blocks which it did map in bh_result->b_size.  This allows
the fs to map up to 4G of disk (or of hole) in a single get_block()
invokation.

There are some other caveats and requirements of get_blocks() which are
documented in the comment block over fs/direct_io.c:get_more_blocks().

Possibly, get_blocks() will be the 2.6 kernel's way of doing gang block
mapping.  It certainly allows good speedups.  But it doesn't allow the
fs to return a scatter list of blocks - it only understands linear
chunks of disk.  I think that's really all it _should_ do.

I'll let get_blocks() sit for a while and wait for some feedback.  If
it is sufficient and nobody objects too much, I shall convert all
get_block() instances in the kernel to be get_blocks() instances.  And
I'll teach readahead (at least) to use the get_blocks() extension. 

Delayed allocate writeback could use get_blocks().  As could
block_prepare_write() for blocksize < PAGE_CACHE_SIZE.  There's no
mileage using it in mpage_writepages() because all our filesystems are
syncalloc, and nobody uses MAP_SHARED for much.

It will be tricky to use get_blocks() for writes, because if a ton of
blocks have been mapped into the file and then something goes wrong,
the kernel needs to either remove those blocks from the file or zero
them out.  The direct_io code zeroes them out.

btw, some time ago you mentioned that some drivers and/or hardware may
get upset if there are multiple simultaneous IOs in progress against
the same block.  Well, the raw driver has always allowed that to
happen.  O_DIRECT writes to blockdevs do as well now.


todo:

1) The driver will probably explode if someone runs BLKBSZSET while
   IO is in progress.  Need to use bdclaim() somewhere.

2) readv() and writev() need to become direct_io-aware.  At present
   we're doing stop-and-wait for each segment when performing
   readv/writev against the raw driver and O_DIRECT blockdevs.





 drivers/char/raw.c |  118 ++++++++++-----------
 fs/block_dev.c     |   28 +++--
 fs/direct-io.c     |  292 ++++++++++++++++++++++++++++++++++++++++-------------
 fs/ext2/inode.c    |   15 ++
 fs/jfs/inode.c     |   15 ++
 include/linux/fs.h |    8 +
 6 files changed, 334 insertions(+), 142 deletions(-)

--- 2.5.29/fs/direct-io.c~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/fs/direct-io.c	Sun Jul 28 00:25:53 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/wait.h>
@@ -39,13 +40,17 @@ struct dio {
 	struct bio_vec *bvec;		/* current bvec in that bio */
 	struct inode *inode;
 	int rw;
+	unsigned blkbits;		/* doesn't change */
 	sector_t block_in_file;		/* changes */
+	unsigned blocks_available;	/* At block_in_file.  changes */
 	sector_t final_block_in_request;/* doesn't change */
-	unsigned first_block_in_page;	/* doesn't change */
+	unsigned first_block_in_page;	/* doesn't change, Used only once */
 	int boundary;			/* prev block is at a boundary */
 	int reap_counter;		/* rate limit reaping */
-	get_block_t *get_block;
-	sector_t last_block_in_bio;
+	get_blocks_t *get_blocks;	/* block mapping function */
+	sector_t last_block_in_bio;	/* current final block in bio */
+	sector_t next_block_in_bio;	/* next block to be added to bio */
+	struct buffer_head map_bh;	/* last get_blocks() result */
 
 	/* Page fetching state */
 	int curr_page;			/* changes */
@@ -53,15 +58,16 @@ struct dio {
 	unsigned long curr_user_address;/* changes */
 
 	/* Page queue */
-	struct page *pages[DIO_PAGES];
-	unsigned head;
-	unsigned tail;
+	struct page *pages[DIO_PAGES];	/* page buffer */
+	unsigned head;			/* next page to process */
+	unsigned tail;			/* last valid page + 1 */
+	int page_errors;		/* errno from get_user_pages() */
 
 	/* BIO completion state */
-	atomic_t bio_count;
-	spinlock_t bio_list_lock;
+	atomic_t bio_count;		/* nr bios in flight */
+	spinlock_t bio_list_lock;	/* protects bio_list */
 	struct bio *bio_list;		/* singly linked via bi_private */
-	struct task_struct *waiter;
+	struct task_struct *waiter;	/* waiting task (NULL if none) */
 };
 
 /*
@@ -93,6 +99,21 @@ static int dio_refill_pages(struct dio *
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
@@ -100,6 +121,7 @@ static int dio_refill_pages(struct dio *
 		dio->tail = ret;
 		ret = 0;
 	}
+out:
 	return ret;	
 }
 
@@ -115,11 +137,8 @@ static struct page *dio_get_page(struct 
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
@@ -140,8 +159,9 @@ static void dio_bio_end_io(struct bio *b
 	spin_lock_irqsave(&dio->bio_list_lock, flags);
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
+	if (dio->waiter)
+		wake_up_process(dio->waiter);
 	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-	wake_up_process(dio->waiter);
 }
 
 static int
@@ -179,6 +199,7 @@ static void dio_bio_submit(struct dio *d
 
 	dio->bio = NULL;
 	dio->bvec = NULL;
+	dio->boundary = 0;
 }
 
 /*
@@ -202,10 +223,12 @@ static struct bio *dio_await_one(struct 
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
@@ -268,15 +291,12 @@ static int dio_bio_reap(struct dio *dio)
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
@@ -284,13 +304,129 @@ static int dio_bio_reap(struct dio *dio)
 }
 
 /*
+ * Call into the fs to map some more disk blocks.  We record the current number
+ * of available blocks at dio->blocks_available.  These are in units of the
+ * fs blocksize, (1 << inode->i_blkbits).
+ *
+ * The fs is allowed to map lots of blocks at once.  If it wants to do that,
+ * it uses the passed inode-relative block number as the file offset, as usual.
+ *
+ * get_blocks() is passed the number of i_blkbits-sized blocks which direct_io
+ * has remaining to do.  The fs should not map more than this number of blocks.
+ *
+ * If the fs has mapped a lot of blocks, it should populate bh->b_size to
+ * indicate how much contiguous disk space has been made available at
+ * bh->b_blocknr.
+ *
+ * If *any* of the mapped blocks are new, then the fs must set buffer_new().
+ * This isn't very efficient...
+ *
+ * In the case of filesystem holes: the fs may return an arbitrarily-large
+ * hole by returning an appropriate value in b_size and by clearing
+ * buffer_mapped().  This code _should_ handle that case correctly, but it has
+ * only been tested against single-block holes (b_size == blocksize).
+ */
+static int get_more_blocks(struct dio *dio)
+{
+	int ret;
+	struct buffer_head *map_bh = &dio->map_bh;
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
+	if (buffer_mapped(map_bh)) {
+		BUG_ON(map_bh->b_size == 0);
+		BUG_ON((map_bh->b_size & ((1 << dio->blkbits) - 1)) != 0);
+
+		dio->blocks_available = map_bh->b_size >> dio->blkbits;
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
+	if (dio->bio == NULL)
+		return;
+
+	if (dio->bio->bi_idx == dio->bio->bi_vcnt ||
+			dio->boundary ||
+			dio->last_block_in_bio != dio->next_block_in_bio - 1)
+		dio_bio_submit(dio);
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
+		goto out;
+	sector = dio->next_block_in_bio << (dio->blkbits - 9);
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
+ * it should set b_size to PAGE_SIZE or more inside get_blocks().  This gives
+ * fine alignment but still allows this function to work in PAGE_SIZE units.
  */
 int do_direct_IO(struct dio *dio)
 {
-	struct inode * const inode = dio->inode;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
+	const unsigned blkbits = dio->blkbits;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	struct page *page;
 	unsigned block_in_page;
@@ -309,46 +445,35 @@ int do_direct_IO(struct dio *dio)
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
+			ret = get_more_blocks(dio);
+			if (ret)
 				goto fail_release;
+
+			/* Handle holes */
+			if (!buffer_mapped(&dio->map_bh)) {
+				char *kaddr = kmap_atomic(page, KM_USER0);
+				memset(kaddr + (block_in_page << blkbits),
+						0, 1 << blkbits);
+				flush_dcache_page(page);
+				kunmap_atomic(kaddr, KM_USER0);
+				dio->block_in_file++;
+				dio->next_block_in_bio++;
+				block_in_page++;
+				goto next_block;
 			}
-			/* blockdevs do not set buffer_new */
-			if (buffer_new(&map_bh))
-				unmap_underlying_metadata(map_bh.b_bdev,
-							map_bh.b_blocknr);
-			if (!buffer_mapped(&map_bh)) {
-				ret = -EINVAL;		/* A hole */
-				goto fail_release;
-			}
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
@@ -357,17 +482,34 @@ int do_direct_IO(struct dio *dio)
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
@@ -381,11 +523,16 @@ out:
 	return ret;
 }
 
+/*
+ * The main direct-IO function.  This is a library function for use by
+ * filesystem drivers.
+ */
 int
 generic_direct_IO(int rw, struct inode *inode, char *buf, loff_t offset,
-			size_t count, get_block_t get_block)
+			size_t count, get_blocks_t get_blocks)
 {
-	const unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocksize_mask = (1 << blkbits) - 1;
 	const unsigned long user_addr = (unsigned long)buf;
 	int ret;
 	int ret2;
@@ -403,16 +550,18 @@ generic_direct_IO(int rw, struct inode *
 	dio.bvec = NULL;
 	dio.inode = inode;
 	dio.rw = rw;
-	dio.block_in_file = offset >> inode->i_blkbits;
-	dio.final_block_in_request = (offset + count) >> inode->i_blkbits;
+	dio.blkbits = blkbits;
+	dio.block_in_file = offset >> blkbits;
+	dio.blocks_available = 0;
+	dio.final_block_in_request = (offset + count) >> blkbits;
 
 	/* Index into the first page of the first block */
-	dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1))
-						>> inode->i_blkbits;
+	dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
 	dio.boundary = 0;
 	dio.reap_counter = 0;
-	dio.get_block = get_block;
+	dio.get_blocks = get_blocks;
 	dio.last_block_in_bio = -1;
+	dio.next_block_in_bio = -1;
 
 	/* Page fetching state */
 	dio.curr_page = 0;
@@ -428,12 +577,13 @@ generic_direct_IO(int rw, struct inode *
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
 
@@ -445,8 +595,10 @@ generic_direct_IO(int rw, struct inode *
 	if (ret == 0)
 		ret = ret2;
 	if (ret == 0)
+		ret = dio.page_errors;
+	if (ret == 0)
 		ret = count - ((dio.final_block_in_request -
-				dio.block_in_file) << inode->i_blkbits);
+				dio.block_in_file) << blkbits);
 out:
 	return ret;
 }
--- 2.5.29/fs/block_dev.c~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/fs/block_dev.c	Sun Jul 28 00:22:01 2002
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
+blkdev_get_blocks(struct inode *inode, sector_t iblock,
+		unsigned long max_blocks, struct buffer_head *bh, int create)
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
--- 2.5.29/drivers/char/raw.c~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/drivers/char/raw.c	Sun Jul 28 00:25:53 2002
@@ -17,11 +17,9 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
-#define dprintk(x...) 
-
 typedef struct raw_device_data_s {
 	struct block_device *binding;
-	int inuse, sector_size, sector_bits;
+	int inuse;
 	struct semaphore mutex;
 } raw_device_data_t;
 
@@ -65,15 +63,15 @@ __initcall(raw_init);
 
 /* 
  * Open/close code for raw IO.
+ *
+ * Set the device's soft blocksize to the minimum possible.  This gives the 
+ * finest possible alignment and has no adverse impact on performance.
  */
-
 int raw_open(struct inode *inode, struct file *filp)
 {
 	int minor;
 	struct block_device * bdev;
 	int err;
-	int sector_size;
-	int sector_bits;
 
 	minor = minor(inode->i_rdev);
 	
@@ -87,12 +85,11 @@ int raw_open(struct inode *inode, struct
 	}
 	
 	down(&raw_devices[minor].mutex);
+
 	/*
 	 * No, it is a normal raw device.  All we need to do on open is
-	 * to check that the device is bound, and force the underlying
-	 * block device to a sector-size blocksize. 
+	 * to check that the device is bound.
 	 */
-
 	bdev = raw_devices[minor].binding;
 	err = -ENODEV;
 	if (!bdev)
@@ -100,23 +97,19 @@ int raw_open(struct inode *inode, struct
 
 	atomic_inc(&bdev->bd_count);
 	err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
-	if (err)
-		goto out;
-	
-	/*
-	 * Don't change the blocksize if we already have users using
-	 * this device 
-	 */
+	if (!err) {
+		int minsize = bdev_hardsect_size(bdev);
 
-	if (raw_devices[minor].inuse++)
-		goto out;
-
-	sector_size = bdev_hardsect_size(bdev);
-	raw_devices[minor].sector_size = sector_size;
-	for (sector_bits = 0; !(sector_size & 1); )
-		sector_size>>=1, sector_bits++;
-	raw_devices[minor].sector_bits = sector_bits;
+		if (bdev) {
+			int ret;
 
+			ret = set_blocksize(bdev, minsize);
+			if (ret)
+				printk("%s: set_blocksize() failed: %d\n",
+					__FUNCTION__, ret);
+		}
+		raw_devices[minor].inuse++;
+	}
  out:
 	up(&raw_devices[minor].mutex);
 	
@@ -137,26 +130,29 @@ int raw_release(struct inode *inode, str
 	return 0;
 }
 
-
-
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
+	err = -EINVAL;
+	if (b == NULL)
+		goto out;
+	if (b->bd_inode && b->bd_op && b->bd_op->ioctl)
 		err = b->bd_op->ioctl(b->bd_inode, NULL, command, arg); 
-	} 
+out:
 	return err;
-} 
+}
 
 /*
  * Deal with ioctls against the raw-device control interface, to bind
@@ -164,12 +160,12 @@ int raw_ioctl(struct inode *inode, 
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
@@ -178,26 +174,23 @@ int raw_ctl_ioctl(struct inode *inode, 
 
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
@@ -206,24 +199,23 @@ int raw_ctl_ioctl(struct inode *inode, 
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
@@ -237,16 +229,18 @@ int raw_ctl_ioctl(struct inode *inode, 
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
 
@@ -257,7 +251,7 @@ ssize_t raw_read(struct file *filp, char
 
 ssize_t	raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
 {
-	return rw_raw_dev(WRITE, filp, (char *) buf, size, offp);
+	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
 }
 
 ssize_t
--- 2.5.29/include/linux/fs.h~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/include/linux/fs.h	Sun Jul 28 00:21:47 2002
@@ -211,7 +211,11 @@ extern void mnt_init(unsigned long);
 extern void files_init(unsigned long);
 
 struct buffer_head;
-typedef int (get_block_t)(struct inode*,sector_t,struct buffer_head*,int);
+typedef int (get_block_t)(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
+typedef int (get_blocks_t)(struct inode *inode, sector_t iblock,
+			unsigned long max_blocks,
+			struct buffer_head *bh_result, int create);
 
 #include <linux/pipe_fs_i.h>
 /* #include <linux/umsdos_fs_i.h> */
@@ -1238,7 +1242,7 @@ extern void do_generic_file_read(struct 
 ssize_t generic_file_direct_IO(int rw, struct inode *inode, char *buf,
 				loff_t offset, size_t count);
 int generic_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count, get_block_t *get_block);
+			loff_t offset, size_t count, get_blocks_t *get_blocks);
 
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
--- 2.5.29/fs/ext2/inode.c~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/fs/ext2/inode.c	Sun Jul 28 00:21:47 2002
@@ -607,10 +607,23 @@ static int ext2_bmap(struct address_spac
 }
 
 static int
+ext2_get_blocks(struct inode *inode, sector_t iblock, unsigned long max_blocks,
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
--- 2.5.29/fs/jfs/inode.c~dio-raw	Sun Jul 28 00:21:47 2002
+++ 2.5.29-akpm/fs/jfs/inode.c	Sun Jul 28 00:21:47 2002
@@ -293,10 +293,23 @@ static int jfs_bmap(struct address_space
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
+static int
+jfs_get_blocks(struct inode *inode, sector_t iblock, unsigned long max_blocks,
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
