Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTKQFTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 00:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTKQFTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 00:19:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:60553 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261602AbTKQFTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 00:19:50 -0500
Date: Mon, 17 Nov 2003 10:55:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test9-mm3 - AIO test results
Message-ID: <20031117052518.GA11184@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031112233002.436f5d0c.akpm@osdl.org> <1068761038.1805.35.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068761038.1805.35.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 02:03:58PM -0800, Daniel McNeil wrote:
> Andrew,
> 
> I'm testing test9-mm3 on a 2-proc Xeon with a ext3 file system.
> I tested using the test programs aiocp and aiodio_sparse.
> (see http://developer.osdl.org/daniel/AIO/)
> 
> Using aiocp with i/o sizes from 1k to 512k to copy files worked
> without any errors or kernel debug messages.
> 
> With 64k i/o, the aiodio_sparse program complete without any errors.
> There are no kernel error messages, so that is good.
> 
> There are still problems with non power of 2 i/o sizes using AIO and
> O_DIRECT.  It hangs with aio's that do not seem to complete.  The test
> does exit when hitting ^c and there are no kernel messages.  Test output
> below:

Could you check if the following patch fixes the problem for you ?

Regards
Suparna

--------------------------------------------------------------

With this patch, when the DIO code falls back to buffered i/o after
having submitted part of the i/o, then buffered i/o is issued only
for the remaining part of the request (i.e. the part not already 
covered by DIO).

diff -ur pure-mm3/fs/direct-io.c linux-2.6.0-test9-mm3/fs/direct-io.c
--- pure-mm3/fs/direct-io.c	2003-11-14 09:09:06.000000000 +0530
+++ linux-2.6.0-test9-mm3/fs/direct-io.c	2003-11-17 09:00:47.000000000 +0530
@@ -74,6 +74,7 @@
 					   been performed at the start of a
 					   write */
 	int pages_in_io;		/* approximate total IO pages */
+	size_t	size;			/* total request size (doesn't change)*/
 	sector_t block_in_file;		/* Current offset into the underlying
 					   file in dio_block units. */
 	unsigned blocks_available;	/* At block_in_file.  changes */
@@ -226,7 +227,7 @@
 			dio_complete(dio, dio->block_in_file << dio->blkbits,
 					dio->result);
 			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result != -ENOTBLK) {
+			if (dio->result >= dio->size || dio->rw == READ) {
 				aio_complete(dio->iocb, dio->result, 0);
 				kfree(dio);
 			} else {
@@ -889,6 +890,7 @@
 	dio->blkbits = blkbits;
 	dio->blkfactor = inode->i_blkbits - blkbits;
 	dio->start_zero_done = 0;
+	dio->size = 0;
 	dio->block_in_file = offset >> blkbits;
 	dio->blocks_available = 0;
 	dio->cur_page = NULL;
@@ -925,7 +927,7 @@
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
-		bytes = iov[seg].iov_len;
+		dio->size += bytes = iov[seg].iov_len;
 
 		/* Index into the first page of the first block */
 		dio->first_block_in_page = (user_addr & ~PAGE_MASK) >> blkbits;
@@ -956,6 +958,13 @@
 		}
 	} /* end iovec loop */
 
+	if (ret == -ENOTBLK && rw == WRITE) {
+		/*
+		 * The remaining part of the request will be 
+		 * be handled by buffered I/O when we return
+		 */
+		ret = 0;
+	}
 	/*
 	 * There may be some unwritten disk at the end of a part-written
 	 * fs-block-sized block.  Go zero that now.
@@ -986,19 +995,13 @@
 	 */
 	if (dio->is_async) {
 		if (ret == 0)
-			ret = dio->result;	/* Bytes written */
-		if (ret == -ENOTBLK) {
-			/*
-			 * The request will be reissued via buffered I/O
-			 * when we return; Any I/O already issued
-			 * effectively becomes redundant.
-			 */
-			dio->result = ret;
+			ret = dio->result;
+		if (ret > 0 && dio->result < dio->size && rw == WRITE) {
 			dio->waiter = current;
 		}
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_queues();
-		if (ret == -ENOTBLK) {
+		if (dio->waiter) {
 			/*
 			 * Wait for already issued I/O to drain out and
 			 * release its references to user-space pages
@@ -1032,7 +1035,8 @@
 		}
 		dio_complete(dio, offset, ret);
 		/* We could have also come here on an AIO file extend */
-		if (!is_sync_kiocb(iocb) && (ret != -ENOTBLK))
+		if (!is_sync_kiocb(iocb) && !(rw == WRITE && ret >= 0 && 
+			dio->result < dio->size))
 			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}
diff -ur pure-mm3/mm/filemap.c linux-2.6.0-test9-mm3/mm/filemap.c
--- pure-mm3/mm/filemap.c	2003-11-14 09:15:08.000000000 +0530
+++ linux-2.6.0-test9-mm3/mm/filemap.c	2003-11-15 11:11:16.000000000 +0530
@@ -1895,14 +1895,16 @@
 		 */
 		if (written >= 0 && file->f_flags & O_SYNC)
 			status = generic_osync_inode(inode, mapping, OSYNC_METADATA);
-		if (written >= 0 && !is_sync_kiocb(iocb))
+		if (written >= count && !is_sync_kiocb(iocb))
 			written = -EIOCBQUEUED;
-		if (written != -ENOTBLK)
+		if (written < 0 || written >= count)
 			goto out_status;
 		/*
 		 * direct-io write to a hole: fall through to buffered I/O
+		 * for completing the rest of the request.
 		 */
-		written = 0;
+		pos += written;
+		count -= written;
 	}
 
 	buf = iov->iov_base;
