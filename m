Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSEEU7t>; Sun, 5 May 2002 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSEEU6x>; Sun, 5 May 2002 16:58:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313559AbSEEU6D>;
	Sun, 5 May 2002 16:58:03 -0400
Message-ID: <3CD59D64.80EDEAE9@zip.com.au>
Date: Sun, 05 May 2002 14:00:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/10] Fix concurrent writepage and readpage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pages under writeback are not locked.  So it is possible (and quite
legal) for a page to be under readpage() while it is still under
writeback.  For a partially uptodate page with blocksize <
PAGE_CACHE_SIZE.

When this happens, the read and write I/O completion handlers get
confused over the shared BH_Async usage and the page ends up not
getting PG_writeback cleared.  Truncate gets stuck in D state.

The patch separates the read and write I/O completion state.

It also shuffles the buffer fields around.  Putting the
commonly-accessed b_state at offset zero shrinks the kernel by a few
hundred bytes because it can be accessed with indirect addressing, not
indirect+indexed.


=====================================

--- 2.5.13/fs/buffer.c~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/fs/buffer.c	Sun May  5 13:32:04 2002
@@ -186,6 +186,12 @@ __clear_page_buffers(struct page *page)
 	page_cache_release(page);
 }
 
+static void buffer_io_error(struct buffer_head *bh)
+{
+	printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
+			bdevname(bh->b_bdev), bh->b_blocknr);
+}
+
 /*
  * Default synchronous end-of-IO handler..  Just mark it up-to-date and
  * unlock the buffer. This is what ll_rw_block uses too.
@@ -193,7 +199,7 @@ __clear_page_buffers(struct page *page)
 void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
 	if (!uptodate)
-		printk("%s: I/O error\n", __FUNCTION__);
+		buffer_io_error(bh);
 	if (uptodate)
 		set_buffer_uptodate(bh);
 	else
@@ -537,7 +543,11 @@ static void free_more_memory(void)
 	yield();
 }
 
-static void end_buffer_io_async(struct buffer_head *bh, int uptodate)
+/*
+ * I/O completion handler for block_read_full_page() and brw_page() - pages
+ * which come unlocked at the end of I/O.
+ */
+static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
@@ -545,16 +555,18 @@ static void end_buffer_io_async(struct b
 	struct page *page;
 	int page_uptodate = 1;
 
+	BUG_ON(!buffer_async_read(bh));
+
 	if (!uptodate)
-		printk("%s: I/O error\n", __FUNCTION__);
+		buffer_io_error(bh);
 
-	if (uptodate)
+	page = bh->b_page;
+	if (uptodate) {
 		set_buffer_uptodate(bh);
-	else
+	} else {
 		clear_buffer_uptodate(bh);
-	page = bh->b_page;
-	if (!uptodate)
 		SetPageError(page);
+	}
 
 	/*
 	 * Be _very_ careful from here on. Bad things can happen if
@@ -562,13 +574,13 @@ static void end_buffer_io_async(struct b
 	 * decide that the page is now completely done.
 	 */
 	spin_lock_irqsave(&page_uptodate_lock, flags);
-	clear_buffer_async(bh);
+	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
 	do {
 		if (!buffer_uptodate(tmp))
 			page_uptodate = 0;
-		if (buffer_async(tmp)) {
+		if (buffer_async_read(tmp)) {
 			if (buffer_locked(tmp))
 				goto still_busy;
 			if (!buffer_mapped(bh))
@@ -584,13 +596,53 @@ static void end_buffer_io_async(struct b
 	 */
 	if (page_uptodate && !PageError(page))
 		SetPageUptodate(page);
-	if (PageWriteback(page)) {
-		/* It was a write */
-		end_page_writeback(page);
+	unlock_page(page);
+	return;
+
+still_busy:
+	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	return;
+}
+
+/*
+ * Completion handler for block_write_full_page() - pages which are unlocked
+ * during I/O, and which have PageWriteback cleared upon I/O completion.
+ */
+static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
+{
+	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long flags;
+	struct buffer_head *tmp;
+	struct page *page;
+
+	BUG_ON(!buffer_async_write(bh));
+
+	if (!uptodate)
+		buffer_io_error(bh);
+
+	page = bh->b_page;
+	if (uptodate) {
+		set_buffer_uptodate(bh);
 	} else {
-		/* read */
-		unlock_page(page);
+		clear_buffer_uptodate(bh);
+		SetPageError(page);
+	}
+
+	spin_lock_irqsave(&page_uptodate_lock, flags);
+	clear_buffer_async_write(bh);
+	unlock_buffer(bh);
+	tmp = bh->b_this_page;
+	while (tmp != bh) {
+		if (buffer_async_write(tmp)) {
+			if (buffer_locked(tmp))
+				goto still_busy;
+			if (!buffer_mapped(bh))
+				BUG();
+		}
+		tmp = tmp->b_this_page;
 	}
+	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	end_page_writeback(page);
 	return;
 
 still_busy:
@@ -599,26 +651,39 @@ still_busy:
 }
 
 /*
- * If a page's buffers are under async writeout (end_buffer_io_async
+ * If a page's buffers are under async readin (end_buffer_async_read
  * completion) then there is a possibility that another thread of
  * control could lock one of the buffers after it has completed
  * but while some of the other buffers have not completed.  This
- * locked buffer would confuse end_buffer_io_async() into not unlocking
- * the page.  So the absence of BH_Async tells end_buffer_io_async()
+ * locked buffer would confuse end_buffer_async_read() into not unlocking
+ * the page.  So the absence of BH_Async_Read tells end_buffer_async_read()
  * that this buffer is not under async I/O.
  *
  * The page comes unlocked when it has no locked buffer_async buffers
  * left.
  *
- * The page lock prevents anyone starting new async I/O against any of
+ * PageLocked prevents anyone starting new async I/O reads any of
  * the buffers.
+ *
+ * PageWriteback is used to prevent simultaneous writeout of the same
+ * page.
+ *
+ * PageLocked prevents anyone from starting writeback of a page which is
+ * under read I/O (PageWriteback is only ever set against a locked page).
  */
-inline void set_buffer_async_io(struct buffer_head *bh)
+inline void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = end_buffer_io_async;
-	set_buffer_async(bh);
+	bh->b_end_io = end_buffer_async_read;
+	set_buffer_async_read(bh);
 }
-EXPORT_SYMBOL(set_buffer_async_io);
+EXPORT_SYMBOL(mark_buffer_async_read);
+
+inline void mark_buffer_async_write(struct buffer_head *bh)
+{
+	bh->b_end_io = end_buffer_async_write;
+	set_buffer_async_write(bh);
+}
+EXPORT_SYMBOL(mark_buffer_async_write);
 
 /*
  * osync is designed to support O_SYNC io.  It waits synchronously for
@@ -1207,10 +1272,13 @@ void create_empty_buffers(struct page *p
 	tail->b_this_page = head;
 
 	spin_lock(&page->mapping->host->i_bufferlist_lock);
-	if (PageDirty(page)) {
+	if (PageUptodate(page) || PageDirty(page)) {
 		bh = head;
 		do {
-			set_buffer_dirty(bh);
+			if (PageDirty(page))
+				set_buffer_dirty(bh);
+			if (PageUptodate(page))
+				set_buffer_uptodate(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
@@ -1308,12 +1376,18 @@ static int __block_write_full_page(struc
 	 */
 	do {
 		if (block > last_block) {
-			clear_buffer_dirty(bh);
-			if (buffer_mapped(bh))
-				buffer_error();
+			/*
+			 * mapped buffers outside i_size will occur, because
+			 * this page can be outside i_size when there is a
+			 * truncate in progress.
+			 *
+			 * if (buffer_mapped(bh))
+			 *	buffer_error();
+			 */
 			/*
 			 * The buffer was zeroed by block_write_full_page()
 			 */
+			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
 			if (buffer_new(bh))
@@ -1338,7 +1412,7 @@ static int __block_write_full_page(struc
 			if (test_clear_buffer_dirty(bh)) {
 				if (!buffer_uptodate(bh))
 					buffer_error();
-				set_buffer_async_io(bh);
+				mark_buffer_async_write(bh);
 			} else {
 				unlock_buffer(bh);
 			}
@@ -1356,7 +1430,7 @@ static int __block_write_full_page(struc
 	 */
 	do {
 		struct buffer_head *next = bh->b_this_page;
-		if (buffer_async(bh)) {
+		if (buffer_async_write(bh)) {
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
@@ -1398,7 +1472,7 @@ recover:
 	do {
 		if (buffer_mapped(bh)) {
 			lock_buffer(bh);
-			set_buffer_async_io(bh);
+			mark_buffer_async_write(bh);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -1410,7 +1484,7 @@ recover:
 	} while (bh != head);
 	do {
 		struct buffer_head *next = bh->b_this_page;
-		if (buffer_mapped(bh)) {
+		if (buffer_async_write(bh)) {
 			set_buffer_uptodate(bh);
 			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
@@ -1631,13 +1705,9 @@ int block_read_full_page(struct page *pa
 
 	/* Stage two: lock the buffers */
 	for (i = 0; i < nr; i++) {
-		struct buffer_head * bh = arr[i];
+		bh = arr[i];
 		lock_buffer(bh);
-		if (buffer_uptodate(bh))
-			buffer_error();
-		if (buffer_dirty(bh))
-			buffer_error();
-		set_buffer_async_io(bh);
+		mark_buffer_async_read(bh);
 	}
 
 	/*
@@ -1646,9 +1716,9 @@ int block_read_full_page(struct page *pa
 	 * the underlying blockdev brought it uptodate (the sct fix).
 	 */
 	for (i = 0; i < nr; i++) {
-		struct buffer_head * bh = arr[i];
+		bh = arr[i];
 		if (buffer_uptodate(bh))
-			end_buffer_io_async(bh, 1);
+			end_buffer_async_read(bh, 1);
 		else
 			submit_bh(READ, bh);
 	}
@@ -2074,9 +2144,15 @@ int brw_page(int rw, struct page *page,
 		bh->b_blocknr = *(b++);
 		bh->b_bdev = bdev;
 		set_buffer_mapped(bh);
-		if (rw == WRITE)
+		if (rw == WRITE) {
 			set_buffer_uptodate(bh);
-		set_buffer_async_io(bh);
+			clear_buffer_dirty(bh);
+		}
+		/*
+		 * Swap pages are locked during writeout, so use
+		 * buffer_async_read in strange ways.
+		 */
+		mark_buffer_async_read(bh);
 		bh = bh->b_this_page;
 	} while (bh != head);
 
--- 2.5.13/drivers/block/ll_rw_blk.c~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/drivers/block/ll_rw_blk.c	Sun May  5 13:32:04 2002
@@ -1598,10 +1598,12 @@ int submit_bh(int rw, struct buffer_head
 	BUG_ON(!bh->b_end_io);
 
 	if ((rw == READ || rw == READA) && buffer_uptodate(bh))
-		printk("%s: read of uptodate buffer\n", __FUNCTION__);
+		buffer_error();
 	if (rw == WRITE && !buffer_uptodate(bh))
-		printk("%s: write of non-uptodate buffer\n", __FUNCTION__);
-		
+		buffer_error();
+	if (rw == READ && buffer_dirty(bh))
+		buffer_error();
+				
 	set_buffer_req(bh);
 
 	/*
--- 2.5.13/fs/jbd/commit.c~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/fs/jbd/commit.c	Sun May  5 13:32:04 2002
@@ -267,7 +267,7 @@ write_out_data_locked:
 sync_datalist_empty:
 	/*
 	 * Wait for all the async writepage data.  As they become unlocked
-	 * in end_buffer_io_async(), the only place where they can be
+	 * in end_buffer_async_write(), the only place where they can be
 	 * reaped is in try_to_free_buffers(), and we're locked against
 	 * that.
 	 */
--- 2.5.13/fs/jbd/transaction.c~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/fs/jbd/transaction.c	Sun May  5 13:32:04 2002
@@ -905,8 +905,8 @@ out:
  * The buffer is placed on the transaction's data list and is marked as
  * belonging to the transaction.
  *
- * If `async' is set then the writebask will be initiated by the caller
- * using submit_bh -> end_buffer_io_async.  We put the buffer onto
+ * If `async' is set then the writebabk will be initiated by the caller
+ * using submit_bh -> end_buffer_async_write.  We put the buffer onto
  * t_async_datalist.
  * 
  * Returns error number or 0 on success.  
@@ -1851,8 +1851,7 @@ static int journal_unmap_buffer(journal_
 	}
 
 zap_buffer:	
-	if (buffer_dirty(bh))
-		clear_buffer_dirty(bh);
+	clear_buffer_dirty(bh);
 	J_ASSERT_BH(bh, !buffer_jdirty(bh));
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
--- 2.5.13/include/linux/buffer_head.h~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/include/linux/buffer_head.h	Sun May  5 13:32:04 2002
@@ -1,24 +1,24 @@
 /*
  * include/linux/buffer_head.h
  *
- * Everything to do with buffer_head.b_state.
+ * Everything to do with buffer_heads.
  */
 
 #ifndef BUFFER_FLAGS_H
 #define BUFFER_FLAGS_H
 
-/* bh state bits */
 enum bh_state_bits {
-	BH_Uptodate,	/* 1 if the buffer contains valid data */
-	BH_Dirty,	/* 1 if the buffer is dirty */
-	BH_Lock,	/* 1 if the buffer is locked */
-	BH_Req,		/* 0 if the buffer has been invalidated */
-
-	BH_Mapped,	/* 1 if the buffer has a disk mapping */
-	BH_New,		/* 1 if the buffer is new and not yet written out */
-	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
-	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Uptodate,	/* Contains valid data */
+	BH_Dirty,	/* Is dirty */
+	BH_Lock,	/* Is locked */
+	BH_Req,		/* Has been submitted for I/O */
+
+	BH_Mapped,	/* Has a disk mapping */
+	BH_New,		/* Disk mapping was newly created by get_block */
+	BH_Async_Read,	/* Is under end_buffer_async_read I/O */
+	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
 
+	BH_JBD,		/* Has an attached ext3 journal_head */
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
@@ -32,28 +32,22 @@ struct buffer_head;
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 
 /*
- * Try to keep the most commonly used fields in single cache lines (16
- * bytes) to improve performance.  This ordering should be
- * particularly beneficial on 32-bit processors.
- * 
- * We use the first 16 bytes for the data which is used in searches
- * over the block hash lists (ie. getblk() and friends).
- * 
- * The second 16 bytes we use for lru buffer scans, as used by
- * sync_buffers() and refill_freelist().  -- sct
+ * Keep related fields in common cachelines.  The most commonly accessed
+ * field (b_state) goes at the start so the compiler does not generate
+ * indexed addressing for it.
  */
 struct buffer_head {
 	/* First cache line: */
-	sector_t b_blocknr;		/* block number */
-	unsigned short b_size;		/* block size */
-	struct block_device *b_bdev;
-
-	atomic_t b_count;		/* users using this block */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
+	atomic_t b_count;		/* users using this block */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
 	struct page *b_page;		/* the page this bh is mapped to */
 
-	char * b_data;			/* pointer to data block */
+	sector_t b_blocknr;		/* block number */
+	unsigned short b_size;		/* block size */
+	char *b_data;			/* pointer to data block */
+
+	struct block_device *b_bdev;
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head     b_inode_buffers; /* list of inode dirty buffers */
@@ -91,6 +85,11 @@ static inline int test_clear_buffer_##na
 	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
 }									\
 
+/*
+ * Emit the buffer bitops functions.   Note that there are also functions
+ * of the form "mark_buffer_foo()".  These are higher-level functions which
+ * do something in addition to setting a b_state bit.
+ */
 BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
@@ -99,15 +98,12 @@ TAS_BUFFER_FNS(Lock, locked)
 BUFFER_FNS(Req, req)
 BUFFER_FNS(Mapped, mapped)
 BUFFER_FNS(New, new)
-BUFFER_FNS(Async, async)
-
-/*
- * Utility macros
- */
+BUFFER_FNS(Async_Read, async_read)
+BUFFER_FNS(Async_Write, async_write)
 
 /*
  * FIXME: this is used only by bh_kmap, which is used only by RAID5.
- * Clean this up with blockdev-in-highmem infrastructure.
+ * Move all that stuff into raid5.c
  */
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
@@ -152,8 +148,8 @@ void end_buffer_io_sync(struct buffer_he
 void buffer_insert_list(spinlock_t *lock,
 			struct buffer_head *, struct list_head *);
 
-/* reiserfs_writepage needs this */
-void set_buffer_async_io(struct buffer_head *bh);
+void mark_buffer_async_read(struct buffer_head *bh);
+void mark_buffer_async_write(struct buffer_head *bh);
 void invalidate_inode_buffers(struct inode *);
 void invalidate_bdev(struct block_device *, int);
 void __invalidate_buffers(kdev_t dev, int);
--- 2.5.13/fs/reiserfs/inode.c~readpage-tweaks	Sun May  5 13:32:04 2002
+++ 2.5.13-akpm/fs/reiserfs/inode.c	Sun May  5 13:32:04 2002
@@ -1916,7 +1916,7 @@ static inline void submit_bh_for_writepa
     for(i = 0 ; i < nr ; i++) {
         bh = bhp[i] ;
 	lock_buffer(bh) ;
-	set_buffer_async_io(bh) ;
+	mark_buffer_async_write(bh) ;
 	/* submit_bh doesn't care if the buffer is dirty, but nobody
 	** later on in the call chain will be cleaning it.  So, we
 	** clean the buffer here, it still gets written either way.

-
