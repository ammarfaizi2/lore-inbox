Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTKKO5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTKKO5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:57:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43948 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263533AbTKKO5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:57:02 -0500
Date: Tue, 11 Nov 2003 20:32:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-aio@kvack.org
Subject: Re: 2.6.0-test9-mm2 - AIO tests still gets slab corruption
Message-ID: <20031111150229.GA4345@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031104225544.0773904f.akpm@osdl.org> <1068505605.2042.11.camel@ibm-c.pdx.osdl.net> <20031110154232.55eb9b10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110154232.55eb9b10.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 03:42:32PM -0800, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Andrew,
> > 
> > test9-mm2 is still getting slab corruption with AIO:
> 
> Why?
> 
> > Maximal retry count.  Bytes done 0
> > Slab corruption: start=dc70f91c, expend=dc70f9eb, problemat=dc70f91c
> > Last user: [<c0192fa3>](__aio_put_req+0xbf/0x200)
> > Data: 00 01 10 00 00 02 20 00 *********6C ******************************A5
> > Next: 71 F0 2C .A3 2F 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `kiocb': object was modified after freeing
> > 
> > With suparna's retry-based-aio-dio patch, there are no kernel messages
> > and the tests do not see any uninitialized data.
> > 
> > Any reason not to add suparna's patch to -mm to fix these problems?
> 
> It relies on infrastructure which is not present in Linus's kernel.  We
> should only be interested in fixing mainline 2.6.x.
> 
> Furthermore I'd like to see the direct-vs-buffered locking fixes fully
> implemented against Linus's tree, not -mm.  They're almost there, but are
> not quite complete.  Running off and making it dependent on the retry
> infrastructure is not really helpful.
> 

It was just easier to do this in a non-kludgy way, if we used the
retry infrastructure. Here's why:

For fixing some of the cases, we run into a situation when we've 
already submitted some of the I/O as AIO (with AIO callbacks set up)
by the time we realise that we actually need to wait for that to 
complete synchronously before falling back to buffered i/o (otherwise
we can corrupt file data). 

With the retry model it is only the actual wait that occurs 
differently for AIO and Sync I/O, not the submission. So we 
can simply switch to be synchronous at the latter stage.

Having done that, though, I was actually working on trying 
to find a way to do this that could hold for the mainline as well
(i.e. without using retry infrastructure). The attached patch has 
some special casing tweaks that might do the job; it 
modifies the AIO-DIO callback to wakeup the caller synchronously 
instead of issuing an aio_complete in such situations. 

However the existing aio-dio tests do not seem to exercise some 
of those code paths, so I haven't had a chance to verify 
if it really works for that case (i.e. A single AIO-DIO request 
overwriting an allocated region followed by a hole).

The patch should apply to 2.6.0-test9-mm2.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--- pure-mm/fs/direct-io.c	2003-10-30 14:22:51.000000000 +0530
+++ linux-2.6.0-test9-mm2/fs/direct-io.c	2003-10-31 17:09:35.000000000 +0530
@@ -209,7 +209,7 @@
  */
 static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
 {
-	if (dio->end_io)
+	if (dio->end_io && dio->result)
 		dio->end_io(dio->inode, offset, bytes, dio->map_bh.b_private);
 	if (dio->needs_locking)
 		up_read(&dio->inode->i_alloc_sem);
@@ -225,8 +225,14 @@
 		if (dio->is_async) {
 			dio_complete(dio, dio->block_in_file << dio->blkbits,
 					dio->result);
-			aio_complete(dio->iocb, dio->result, 0);
-			kfree(dio);
+			/* Complete AIO later if falling back to buffered i/o */
+			if (dio->result != -ENOTBLK) {
+				aio_complete(dio->iocb, dio->result, 0);
+				kfree(dio);
+			} else {
+				if (dio->waiter)
+					wake_up_process(dio->waiter);
+			}
 		}
 	}
 }
@@ -877,8 +883,6 @@
 	int ret2;
 	size_t bytes;
 
-	dio->is_async = !is_sync_kiocb(iocb);
-
 	dio->bio = NULL;
 	dio->inode = inode;
 	dio->rw = rw;
@@ -969,10 +973,11 @@
 		dio_bio_submit(dio);
 
 	/*
-	 * All new block allocations have been performed.  We can let i_sem
-	 * go now.
+	 * All block lookups have been performed. For READ requests
+	 * we can let i_sem go now that its achieved its purpose
+	 * of protecting us from looking up uninitialized blocks.
 	 */
-	if (dio->needs_locking)
+	if ((rw == READ) && dio->needs_locking)
 		up(&dio->inode->i_sem);
 
 	/*
@@ -982,8 +987,30 @@
 	if (dio->is_async) {
 		if (ret == 0)
 			ret = dio->result;	/* Bytes written */
+		if (ret == -ENOTBLK) {
+			/*
+			 * The request will be reissued via buffered I/O
+			 * when we return; Any I/O already issued
+			 * effectively becomes redundant.
+			 */
+			dio->result = ret;
+			dio->waiter = current;
+		}
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_queues();
+		if (ret == -ENOTBLK) {
+			/*
+			 * Wait for already issued I/O to drain out and
+			 * release its references to user-space pages
+			 * before returning to fallback on buffered I/O
+			 */
+			while (atomic_read(&dio->bio_count)) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				io_schedule();
+			}
+			set_current_state(TASK_RUNNING);
+			dio->waiter = NULL;
+		}
 	} else {
 		finished_one_bio(dio);
 		ret2 = dio_await_completion(dio);
@@ -1003,6 +1029,9 @@
 				ret = i_size - offset;
 		}
 		dio_complete(dio, offset, ret);
+		/* We could have also come here on an AIO file extend */
+		if (!is_sync_kiocb(iocb) && (ret != -ENOTBLK))
+			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}
 	return ret;
@@ -1029,6 +1058,7 @@
 	unsigned bdev_blkbits = 0;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
+	loff_t end = offset;
 	struct dio *dio;
 	int needs_locking;
 
@@ -1047,6 +1077,7 @@
 	for (seg = 0; seg < nr_segs; seg++) {
 		addr = (unsigned long)iov[seg].iov_base;
 		size = iov[seg].iov_len;
+		end += size;
 		if ((addr & blocksize_mask) || (size & blocksize_mask))  {
 			if (bdev)
 				 blkbits = bdev_blkbits;
@@ -1081,11 +1112,17 @@
 		down_read(&inode->i_alloc_sem);
 	}
 	dio->needs_locking = needs_locking;
+	/*
+	 * For file extending writes updating i_size before data
+	 * writeouts complete can expose uninitialized blocks. So
+	 * even for AIO, we need to wait for i/o to complete before
+	 * returning in this case.
+	 */
+	dio->is_async = !is_sync_kiocb(iocb) && !((rw == WRITE) &&
+		(end > i_size_read(inode)));
 
 	retval = direct_io_worker(rw, iocb, inode, iov, offset,
 				nr_segs, blkbits, get_blocks, end_io, dio);
-	if (needs_locking && rw == WRITE)
-		down(&inode->i_sem);
 out:
 	return retval;
 }
