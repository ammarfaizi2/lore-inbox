Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130583AbQLIJRO>; Sat, 9 Dec 2000 04:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbQLIJRE>; Sat, 9 Dec 2000 04:17:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130583AbQLIJQv>; Sat, 9 Dec 2000 04:16:51 -0500
Date: Sat, 9 Dec 2000 00:45:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012082343370.27010-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Dec 2000, Alexander Viro wrote:
> On Fri, 8 Dec 2000, Linus Torvalds wrote:
> 
> > Looking more at this issue, I suspect that the easiest pretty solution
> > that everybody can probably agree is reasonable is to either pass down the
> > end-of-io callback to ll_rw_block as you suggested, or, preferably by just
> > forcing the _caller_ to do the buffer locking, and just do the b_end_io
> > stuff inside the buffer lock and get rid of all the races that way
> > instead (and make ll_rw_block() verify that the buffers it is passed are
> > always locked).
> 
> Hmm... I've looked through the ll_rw_block() callers and yes, it seems
> to be doable.

Looking at this, there's a _lot_ of them.

I've taken a test-approach that is fairly simple:

 - get rid of the old "ll_rw_block()", because it was inherently racey wrt
   bh->b_end_io, I think we all agree that changing bh->b_end_io without
   holding any locks at all is fairly dangerous.

 - instead, a simple "submit_bh()" thing, that takes only one locked
   buffer head at a time, and queues it for IO. The usage would basically
   be

		lock_buffer(bh);
		bh->b_end_io = completion_callback;
		submit_bh(READ|WRITE, bh);

   which is a pretty clean and simple interface that has no obvious
   races - submit_bh() will set bh->b_end_io to the completion callback.

 - BUT BUT BUT: Because of tons of old users of ll_rw_block(), we
   introduce a totally new ll_rw_block() that has the same old interface,
   but basically does

	void ll_rw_block(int op, int nr, struct buffer_head **array)
	{
		int i;

		for (i = 0; i < nr; i++) {
			struct buffer_head * bh = array[i];
			lock_buffer(bh);
			bh->b_end_io = end_buffer_io_sync;
			submit_bh(op, bh);
		}
	}

   Again, the above avoids the race (we never touch b_end_io except with
   the buffer lock held), and allows all old uses of "ll_rw_block()"
   _except_ the ones that wanted to do the fancy async callbacks.

The advantage? All the regular old code that isn't fancy (ie the low-level
filesystems, bread(), breada() etc) will get a working ll_rw_block() with
the semantics they want, and we can pretty much prove that they can never
get an async handler even by mistake.

And the (few) clever routines in fs/buffer.c that currently use
ll_rw_block() with async handlers can just be converted to use the
submit_bh() interface.

This is a preliminary patch that I have not compiled and probably breaks,
but you get the idea. I'm going to sleep, to survive another night with
three small kids.

If somebody wants to run with this, please try it out, but realize that
it's a work-in-progress. And realize that bugs in this area tend to
corrupt filesystems very quickly indeed. I would strongly advice against
trying this patch out without really grokking what it does and feeling
confident that it actually works.

NOTE NOTE NOTE! I've tried to keep the patch small and simple. I've tried
to make all the changes truly straightforward and obvious. I want this bug
squashed, and I don't want to see it again. But I _still_ think this is a
dangerous patch until somebody like Al has given it a green light. Caveat
Emptor.

		Linus

-----
diff -u --recursive t12p7/linux/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- t12p7/linux/drivers/block/ll_rw_blk.c	Thu Dec  7 15:56:25 2000
+++ linux/drivers/block/ll_rw_blk.c	Sat Dec  9 00:40:35 2000
@@ -885,6 +885,36 @@
 	while (q->make_request_fn(q, rw, bh));
 }
 
+
+/*
+ * Submit a buffer head for IO.
+ */
+void submit_bh(int rw, struct buffer_head * bh)
+{
+	if (!test_bit(BH_Lock, &bh->b_state))
+		BUG();
+
+	set_bit(BH_Req, &bh->b_state);
+
+	/*
+	 * First step, 'identity mapping' - RAID or LVM might
+	 * further remap this.
+	 */
+	bh->b_rdev = bh->b_dev;
+	bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
+
+	generic_make_request(rw, bh);
+}
+
+/*
+ * Default IO end handler, used by "ll_rw_block()".
+ */
+static void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+{
+	mark_buffer_uptodate(bh, uptodate);
+	unlock_buffer(bh);
+}
+
 /* This function can be used to request a number of buffers from a block
    device. Currently the only restriction is that all buffers must belong to
    the same device */
@@ -931,7 +961,8 @@
 		if (test_and_set_bit(BH_Lock, &bh->b_state))
 			continue;
 
-		set_bit(BH_Req, &bh->b_state);
+		/* We have the buffer lock */
+		bh->b_end_io = end_buffer_io_sync;
 
 		switch(rw) {
 		case WRITE:
@@ -954,17 +985,9 @@
 	end_io:
 			bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
 			continue;
-			
 		}
 
-		/*
-		 * First step, 'identity mapping' - RAID or LVM might
-		 * further remap this.
-		 */
-		bh->b_rdev = bh->b_dev;
-		bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
-
-		generic_make_request(rw, bh);
+		submit_bh(rw, bh);
 	}
 	return;
 
@@ -972,7 +995,6 @@
 	for (i = 0; i < nr; i++)
 		buffer_IO_error(bhs[i]);
 }
-
 
 #ifdef CONFIG_STRAM_SWAP
 extern int stram_device_init (void);
diff -u --recursive t12p7/linux/fs/buffer.c linux/fs/buffer.c
--- t12p7/linux/fs/buffer.c	Thu Dec  7 15:56:26 2000
+++ linux/fs/buffer.c	Sat Dec  9 00:38:20 2000
@@ -758,12 +758,6 @@
 	bh->b_private = private;
 }
 
-static void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
-{
-	mark_buffer_uptodate(bh, uptodate);
-	unlock_buffer(bh);
-}
-
 static void end_buffer_io_bad(struct buffer_head *bh, int uptodate)
 {
 	mark_buffer_uptodate(bh, uptodate);
@@ -1001,7 +995,7 @@
 	 * and it is clean.
 	 */
 	if (bh) {
-		init_buffer(bh, end_buffer_io_sync, NULL);
+		init_buffer(bh, end_buffer_io_bad, NULL);
 		bh->b_dev = dev;
 		bh->b_blocknr = block;
 		bh->b_state = 1 << BH_Mapped;
@@ -1210,7 +1204,6 @@
 
 	if (buffer_uptodate(bh))
 		return(bh);   
-	else ll_rw_block(READ, 1, &bh);
 
 	blocks = (filesize - pos) >> (9+index);
 
@@ -1225,12 +1218,11 @@
 			brelse(bh);
 			break;
 		}
-		else bhlist[j++] = bh;
+		bhlist[j++] = bh;
 	}
 
 	/* Request the read for these buffers, and then release them. */
-	if (j>1)  
-		ll_rw_block(READA, (j-1), bhlist+1); 
+	ll_rw_block(READ, j, bhlist);
 	for(i=1; i<j; i++)
 		brelse(bhlist[i]);
 
@@ -1439,7 +1431,7 @@
 		block = *(b++);
 
 		tail = bh;
-		init_buffer(bh, end_buffer_io_async, NULL);
+		init_buffer(bh, end_buffer_io_bad, NULL);
 		bh->b_dev = dev;
 		bh->b_blocknr = block;
 
@@ -1586,8 +1578,6 @@
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
-	struct buffer_head *arr[MAX_BUF_PER_PAGE];
-	int nr = 0;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1600,6 +1590,8 @@
 
 	bh = head;
 	i = 0;
+
+	/* Stage 1: make sure we have all the buffers mapped! */
 	do {
 		/*
 		 * If the buffer isn't up-to-date, we can't be sure
@@ -1616,28 +1608,32 @@
 			if (buffer_new(bh))
 				unmap_underlying_metadata(bh);
 		}
-		set_bit(BH_Uptodate, &bh->b_state);
-		set_bit(BH_Dirty, &bh->b_state);
+		bh = bh->b_this_page;
+		block++;
+	} while (bh != head);
+
+	/* Stage 2: lock the buffers, mark them dirty */
+	do {
+		lock_buffer(bh);
 		bh->b_end_io = end_buffer_io_async;
 		atomic_inc(&bh->b_count);
-		arr[nr++] = bh;
+		set_bit(BH_Uptodate, &bh->b_state);
+		set_bit(BH_Dirty, &bh->b_state);
 		bh = bh->b_this_page;
-		block++;
 	} while (bh != head);
 
-	if (nr) {
-		ll_rw_block(WRITE, nr, arr);
-	} else {
-		UnlockPage(page);
-	}
+	/* Stage 3: submit the IO */
+	do {
+		submit_bh(WRITE, bh);
+		bh = bh->b_this_page;		
+	} while (bh != head);
+
+	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
 	return 0;
+
 out:
-	if (nr) {
-		ll_rw_block(WRITE, nr, arr);
-	} else {
-		UnlockPage(page);
-	}
+	UnlockPage(page);
 	ClearPageUptodate(page);
 	return err;
 }
@@ -1669,7 +1665,6 @@
 			continue;
 		if (block_start >= to)
 			break;
-		bh->b_end_io = end_buffer_io_sync;
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
 			if (err)
@@ -1766,7 +1761,6 @@
 	unsigned long iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, blocks;
-	char *kaddr = NULL;
 	int nr, i;
 
 	if (!PageLocked(page))
@@ -1793,35 +1787,40 @@
 					continue;
 			}
 			if (!buffer_mapped(bh)) {
-				if (!kaddr)
-					kaddr = kmap(page);
-				memset(kaddr + i*blocksize, 0, blocksize);
+				memset(kmap(page) + i*blocksize, 0, blocksize);
 				flush_dcache_page(page);
+				kunmap(page);
 				set_bit(BH_Uptodate, &bh->b_state);
 				continue;
 			}
 		}
 
-		init_buffer(bh, end_buffer_io_async, NULL);
-		atomic_inc(&bh->b_count);
 		arr[nr] = bh;
 		nr++;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
-	if (nr) {
-		if (Page_Uptodate(page))
-			BUG();
-		ll_rw_block(READ, nr, arr);
-	} else {
+	if (!nr) {
 		/*
 		 * all buffers are uptodate - we can set the page
 		 * uptodate as well.
 		 */
 		SetPageUptodate(page);
 		UnlockPage(page);
+		return 0;
 	}
-	if (kaddr)
-		kunmap(page);
+
+	/* Stage two: lock the buffers */
+	for (i = 0; i < nr; i++) {
+		struct buffer_head * bh = arr[i];
+		lock_buffer(bh);
+		bh->b_end_io = end_buffer_io_async;
+		atomic_inc(&bh->b_count);
+	}
+
+	/* Stage 3: start the IO */
+	for (i = 0; i < nr; i++)
+		submit_bh(READ, arr[i]);
+
 	return 0;
 }
 
@@ -1989,7 +1988,6 @@
 	if (Page_Uptodate(page))
 		set_bit(BH_Uptodate, &bh->b_state);
 
-	bh->b_end_io = end_buffer_io_sync;
 	if (!buffer_uptodate(bh)) {
 		err = -EIO;
 		ll_rw_block(READ, 1, &bh);
@@ -2263,67 +2261,31 @@
  */
 int brw_page(int rw, struct page *page, kdev_t dev, int b[], int size)
 {
-	struct buffer_head *head, *bh, *arr[MAX_BUF_PER_PAGE];
-	int nr, fresh /* temporary debugging flag */, block;
+	struct buffer_head *head, *bh;
 
 	if (!PageLocked(page))
 		panic("brw_page: page not locked for I/O");
-//	ClearPageError(page);
-	/*
-	 * We pretty much rely on the page lock for this, because
-	 * create_page_buffers() might sleep.
-	 */
-	fresh = 0;
-	if (!page->buffers) {
-		create_page_buffers(rw, page, dev, b, size);
-		fresh = 1;
-	}
+
 	if (!page->buffers)
+		create_page_buffers(rw, page, dev, b, size);
+
+	head = bh = page->buffers;
+	if (!head)
 		BUG();
 
-	head = page->buffers;
-	bh = head;
-	nr = 0;
+	/* Stage 1: lock all the buffers */
 	do {
-		block = *(b++);
+		lock_buffer(bh);
+		bh->b_end_io = end_buffer_io_async;
+		atomic_inc(&bh->b_count);
+		bh = bh->b_this_page;
+	} while (bh != head);
 
-		if (fresh && (atomic_read(&bh->b_count) != 0))
-			BUG();
-		if (rw == READ) {
-			if (!fresh)
-				BUG();
-			if (!buffer_uptodate(bh)) {
-				arr[nr++] = bh;
-				atomic_inc(&bh->b_count);
-			}
-		} else { /* WRITE */
-			if (!bh->b_blocknr) {
-				if (!block)
-					BUG();
-				bh->b_blocknr = block;
-			} else {
-				if (!block)
-					BUG();
-			}
-			set_bit(BH_Uptodate, &bh->b_state);
-			set_bit(BH_Dirty, &bh->b_state);
-			arr[nr++] = bh;
-			atomic_inc(&bh->b_count);
-		}
+	/* Stage 2: start the IO */
+	do {
+		submit_bh(rw, bh);
 		bh = bh->b_this_page;
 	} while (bh != head);
-	if ((rw == READ) && nr) {
-		if (Page_Uptodate(page))
-			BUG();
-		ll_rw_block(rw, nr, arr);
-	} else {
-		if (!nr && rw == READ) {
-			SetPageUptodate(page);
-			UnlockPage(page);
-		}
-		if (nr && (rw == WRITE))
-			ll_rw_block(rw, nr, arr);
-	}
 	return 0;
 }
 
diff -u --recursive t12p7/linux/include/linux/fs.h linux/include/linux/fs.h
--- t12p7/linux/include/linux/fs.h	Thu Dec  7 15:56:26 2000
+++ linux/include/linux/fs.h	Sat Dec  9 00:27:41 2000
@@ -1193,6 +1193,7 @@
 extern struct buffer_head * get_hash_table(kdev_t, int, int);
 extern struct buffer_head * getblk(kdev_t, int, int);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
+extern void submit_bh(int, struct buffer_head *);
 extern int is_read_only(kdev_t);
 extern void __brelse(struct buffer_head *);
 static inline void brelse(struct buffer_head *buf)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
