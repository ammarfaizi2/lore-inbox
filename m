Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSKFA7w>; Tue, 5 Nov 2002 19:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKFA7w>; Tue, 5 Nov 2002 19:59:52 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45011 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265249AbSKFA7p>;
	Tue, 5 Nov 2002 19:59:45 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211060103.gA613a321256@eng2.beaverton.ibm.com>
Subject: [PATCH 2/2] 2.5.46 AIO support for raw/O_DIRECT
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org (lkml)
Date: Tue, 5 Nov 2002 17:03:36 -0800 (PST)
Cc: akpm@digeo.com, bcrl@redhat.com, pbadari@us.ibm.com (Badari Pulavarty)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is (part 2/2) 2.5.46 patch to support AIO for raw/O_DIRECT.

This patch adds AIO support for DIO code path. This patch also
has a work around for calling set_page_dirty() from interrupt 
context problem.

Andrew, could you please check to see if I did "set_page_dirty()"
hack (you suggested) correctly (in the right place) ?

Ben, could you pick these patches and push to Linus ?

NOTE: You need part 1/2 to use this patch.

Thanks,
Badari

diff -Naur -X dontdiff linux-2.5.46/fs/direct-io.c linux-2.5.46.aio/fs/direct-io.c
--- linux-2.5.46/fs/direct-io.c	Tue Nov  5 16:01:18 2002
+++ linux-2.5.46.aio/fs/direct-io.c	Tue Nov  5 14:57:36 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
@@ -100,6 +101,11 @@
 	spinlock_t bio_list_lock;	/* protects bio_list */
 	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
+
+	/* AIO related stuff */
+	struct kiocb *iocb;		/* kiocb */
+	int is_async;			/* is IO async ? */
+	int result;			/* IO result */
 };
 
 /*
@@ -176,6 +182,43 @@
 	return dio->pages[dio->head++];
 }
 
+static void dio_bio_count(struct dio *dio)
+{
+	if (atomic_dec_and_test(&dio->bio_count)) {
+		if(dio->is_async) {
+			aio_complete(dio->iocb, dio->result, 0);
+			kfree(dio);
+		}
+	}
+}
+
+static int dio_bio_end_aio(struct bio *bio, unsigned int bytes_done, int error)
+{
+	struct dio *dio = bio->bi_private;
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int page_no;
+
+	if (bio->bi_size)
+		return 1;
+
+	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
+		struct page *page = bvec[page_no].bv_page;
+
+		if (dio->rw == READ) {
+			SetPageDirty(page);
+			SetPageWrongList(page);
+		}
+		page_cache_release(page);
+	}
+	if (!uptodate) 
+		dio->result = -EIO;
+
+	dio_bio_count(dio);
+	bio_put(bio);
+	return 0;
+}
+
 /*
  * The BIO completion handler simply queues the BIO up for the process-context
  * handler.
@@ -212,7 +255,10 @@
 
 	bio->bi_bdev = bdev;
 	bio->bi_sector = first_sector;
-	bio->bi_end_io = dio_bio_end_io;
+	if (dio->is_async)
+		bio->bi_end_io = dio_bio_end_aio;
+	else
+		bio->bi_end_io = dio_bio_end_io;
 
 	dio->bio = bio;
 	return 0;
@@ -745,73 +791,84 @@
 }
 
 static int
-direct_io_worker(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs, unsigned blkbits,
-	get_blocks_t get_blocks)
+direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	unsigned blkbits, get_blocks_t get_blocks)
 {
 	unsigned long user_addr; 
 	int seg, ret2, ret = 0;
-	struct dio dio;
-	size_t bytes, tot_bytes = 0;
+	struct dio local_dio, *dio;
+	size_t bytes;
 
-	dio.bio = NULL;
-	dio.inode = inode;
-	dio.rw = rw;
-	dio.blkbits = blkbits;
-	dio.blkfactor = inode->i_blkbits - blkbits;
-	dio.start_zero_done = 0;
-	dio.block_in_file = offset >> blkbits;
-	dio.blocks_available = 0;
-
-	dio.cur_page = NULL;
-
-	dio.boundary = 0;
-	dio.reap_counter = 0;
-	dio.get_blocks = get_blocks;
-	dio.final_block_in_bio = -1;
-	dio.next_block_for_io = -1;
+	if (is_sync_kiocb(iocb)) {
+		dio = &local_dio;
+		dio->is_async = 0;
+	} else {
+		dio = (struct dio *)kmalloc(sizeof(struct dio), GFP_KERNEL);
+		if (!dio)
+			return -ENOMEM;
+		dio->is_async = 1;
+	}
+	dio->bio = NULL;
+	dio->inode = inode;
+	dio->rw = rw;
+	dio->blkbits = blkbits;
+	dio->blkfactor = inode->i_blkbits - blkbits;
+	dio->start_zero_done = 0;
+	dio->block_in_file = offset >> blkbits;
+	dio->blocks_available = 0;
 
-	dio.page_errors = 0;
+	dio->cur_page = NULL;
+
+	dio->boundary = 0;
+	dio->reap_counter = 0;
+	dio->get_blocks = get_blocks;
+	dio->final_block_in_bio = -1;
+	dio->next_block_for_io = -1;
+
+	dio->page_errors = 0;
+	dio->result = 0;
+	dio->iocb = iocb;
 
 	/* BIO completion state */
-	atomic_set(&dio.bio_count, 0);
-	spin_lock_init(&dio.bio_list_lock);
-	dio.bio_list = NULL;
-	dio.waiter = NULL;
-	dio.pages_in_io = 0;
+	atomic_set(&dio->bio_count, 1);
+	spin_lock_init(&dio->bio_list_lock);
+	dio->bio_list = NULL;
+	dio->waiter = NULL;
+	dio->pages_in_io = 0;
 
 	for (seg = 0; seg < nr_segs; seg++) 
-		dio.pages_in_io += (iov[seg].iov_len >> blkbits) + 2; 
+		dio->pages_in_io += (iov[seg].iov_len >> blkbits) + 2; 
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
 		bytes = iov[seg].iov_len;
 
 		/* Index into the first page of the first block */
-		dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
-		dio.final_block_in_request = dio.block_in_file + (bytes >> blkbits);
+		dio->first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
+		dio->final_block_in_request = dio->block_in_file + (bytes >> blkbits);
 		/* Page fetching state */
-		dio.head = 0;
-		dio.tail = 0;
-		dio.curr_page = 0;
+		dio->head = 0;
+		dio->tail = 0;
+		dio->curr_page = 0;
 
-		dio.total_pages = 0;
+		dio->total_pages = 0;
 		if (user_addr & (PAGE_SIZE-1)) {
-			dio.total_pages++;
+			dio->total_pages++;
 			bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
 		}
-		dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
-		dio.curr_user_address = user_addr;
+		dio->total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+		dio->curr_user_address = user_addr;
 	
-		ret = do_direct_IO(&dio);
+		ret = do_direct_IO(dio);
 
 		if (ret) {
-			dio_cleanup(&dio);
+			dio_cleanup(dio);
 			break;
 		}
 
-		tot_bytes += iov[seg].iov_len - ((dio.final_block_in_request -
-					dio.block_in_file) << blkbits);
+		dio->result += iov[seg].iov_len - ((dio->final_block_in_request -
+					dio->block_in_file) << blkbits);
 
 	} /* end iovec loop */
 
@@ -819,22 +876,32 @@
 	 * There may be some unwritten disk at the end of a part-written
 	 * fs-block-sized block.  Go zero that now.
 	 */
-	dio_zero_block(&dio, 1);
+	dio_zero_block(dio, 1);
 
-	if (dio.cur_page) {
-		ret2 = dio_send_cur_page(&dio);
-		page_cache_release(dio.cur_page);
+	if (dio->cur_page) {
+		ret2 = dio_send_cur_page(dio);
+		page_cache_release(dio->cur_page);
 		if (ret == 0)
 			ret = ret2;
 	}
-	ret2 = dio_await_completion(&dio);
+
+	if (dio->is_async) {
+		dio_bio_count(dio);
+		if (ret == 0)
+			ret = -EIOCBQUEUED;
+		goto out;
+	}
+
+	dio_bio_count(dio);
+	ret2 = dio_await_completion(dio);
 	if (ret == 0)
 		ret = ret2;
 	if (ret == 0)
-		ret = dio.page_errors;
+		ret = dio->page_errors;
 	if (ret == 0)
-		ret = tot_bytes; 
+		ret = dio->result; 
 
+out:
 	return ret;
 }
 
@@ -878,7 +945,7 @@
 		}
 	}
 
-	retval = direct_io_worker(rw, inode, iov, offset, 
+	retval = direct_io_worker(rw, iocb, inode, iov, offset, 
 				nr_segs, blkbits, get_blocks);
 out:
 	return retval;
diff -Naur -X dontdiff linux-2.5.46/include/linux/page-flags.h linux-2.5.46.aio/include/linux/page-flags.h
--- linux-2.5.46/include/linux/page-flags.h	Mon Nov  4 14:30:37 2002
+++ linux-2.5.46.aio/include/linux/page-flags.h	Tue Nov  5 14:56:44 2002
@@ -70,6 +70,7 @@
 #define PG_chainlock		15	/* lock bit for ->pte_chain */
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_wronglist		17	/* page is on wrong list */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -233,6 +234,10 @@
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
+#define SetPageWrongList(page)	set_bit(PG_wronglist, &(page)->flags)
+#define PageWrongList(page)	test_bit(PG_wronglist, &(page)->flags)
+#define ClearPageWrongList(page)	clear_bit(PG_wronglist, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -Naur -X dontdiff linux-2.5.46/mm/vmscan.c linux-2.5.46.aio/mm/vmscan.c
--- linux-2.5.46/mm/vmscan.c	Mon Nov  4 14:30:07 2002
+++ linux-2.5.46.aio/mm/vmscan.c	Tue Nov  5 14:58:56 2002
@@ -378,6 +378,12 @@
 			goto keep_locked;
 		}
 
+		if (PageWrongList(page)) {
+			if (TestClearPageDirty(page))
+				set_page_dirty(page);
+			ClearPageWrongList(page);
+		}
+
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->index };

