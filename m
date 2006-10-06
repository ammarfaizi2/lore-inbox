Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWJFUMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWJFUMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWJFUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:12:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932570AbWJFUMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:12:18 -0400
Date: Fri, 6 Oct 2006 13:11:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061006131148.9c6b88ab.akpm@osdl.org>
In-Reply-To: <x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org>
	<4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org>
	<45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
	<20061004165504.c1dd3dd3.akpm@osdl.org>
	<x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 15:31:43 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> akpm> I'd propose that we do this via
> 
> akpm> 	generic_file_buffered_write(...);
> akpm> 	do_sync_file_range(..., SYNC_FILE_RANGE_WAIT_BEFORE|
> akpm> 			SYNC_FILE_RANGE_WRITE|
> akpm> 			SYNC_FILE_RANGE_WAIT_AFTER)
> 
> akpm> 	invalidate_mapping_pages(...);
> 
> OK, patch attached.

I mangled your patch rather a lot.

- coding style (multiple declarations and multiple assignments)

- `endbyte' should be loff_t, not pgoff_t.

- sync the region (pos, pos+written), not (pos, pos+count).

- attempt to return the correct value from __generic_file_aio_write_nolock
  in all circumstances.

- Avoid testing the O_DIRECT flag twice - just call
  generic_file_buffered_write() from two sites.  Simpler and cleaner that way.


Patch is below.  The end result looks like:


	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
	if (unlikely(file->f_flags & O_DIRECT)) {
		loff_t endbyte;
		ssize_t written_buffered;

		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
							ppos, count, ocount);
		if (written < 0 || written == count)
			goto out;
		/*
		 * direct-io write to a hole: fall through to buffered I/O
		 * for completing the rest of the request.
		 */
		pos += written;
		count -= written;
		written_buffered = generic_file_buffered_write(iocb, iov,
						nr_segs, pos, ppos, count,
						written);

		/*
		 * We need to ensure that the page cache pages are written to
		 * disk and invalidated to preserve the expected O_DIRECT
		 * semantics.
		 */
		endbyte = pos + written_buffered - 1;
		err = do_sync_file_range(file, pos, endbyte,
					 SYNC_FILE_RANGE_WAIT_BEFORE|
					 SYNC_FILE_RANGE_WRITE|
					 SYNC_FILE_RANGE_WAIT_AFTER);
		if (err == 0) {
			written += written_buffered;
			invalidate_mapping_pages(mapping,
						 pos >> PAGE_CACHE_SHIFT,
						 endbyte >> PAGE_CACHE_SHIFT);
		} else {
			/*
			 * We don't know how much we wrote, so just return
			 * the number of bytes which were direct-written
			 */
		}
	} else {
		written = generic_file_buffered_write(iocb, iov, nr_segs,
				pos, ppos, count, written);
	}
out:
	current->backing_dev_info = NULL;
	return written ? written : err;
}


Which I think is closer to correct, but boy it needs a lot of reviewing and
testing.



diff -puN mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fixes mm/filemap.c
--- a/mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fixes
+++ a/mm/filemap.c
@@ -2228,7 +2228,7 @@ __generic_file_aio_write_nolock(struct k
 	struct inode 	*inode = mapping->host;
 	unsigned long	seg;
 	loff_t		pos;
-	ssize_t		written, written_direct;
+	ssize_t		written;
 	ssize_t		err;
 
 	ocount = 0;
@@ -2258,7 +2258,7 @@ __generic_file_aio_write_nolock(struct k
 
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = mapping->backing_dev_info;
-	written = written_direct = 0;
+	written = 0;
 
 	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
 	if (err)
@@ -2275,8 +2275,11 @@ __generic_file_aio_write_nolock(struct k
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
-		written = generic_file_direct_write(iocb, iov,
-				&nr_segs, pos, ppos, count, ocount);
+		loff_t endbyte;
+		ssize_t written_buffered;
+
+		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
+							ppos, count, ocount);
 		if (written < 0 || written == count)
 			goto out;
 		/*
@@ -2285,31 +2288,34 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		pos += written;
 		count -= written;
+		written_buffered = generic_file_buffered_write(iocb, iov,
+						nr_segs, pos, ppos, count,
+						written);
 
-		written_direct = written;
-	}
-
-	written = generic_file_buffered_write(iocb, iov, nr_segs,
-			pos, ppos, count, written);
-
-	/*
-	 *  When falling through to buffered I/O, we need to ensure that the
-	 *  page cache pages are written to disk and invalidated to preserve
-	 *  the expected O_DIRECT semantics.
-	 */
-	if (unlikely(file->f_flags & O_DIRECT)) {
-		pgoff_t endbyte = pos + count - 1;
-
+		/*
+		 * We need to ensure that the page cache pages are written to
+		 * disk and invalidated to preserve the expected O_DIRECT
+		 * semantics.
+		 */
+		endbyte = pos + written_buffered - 1;
 		err = do_sync_file_range(file, pos, endbyte,
 					 SYNC_FILE_RANGE_WAIT_BEFORE|
 					 SYNC_FILE_RANGE_WRITE|
 					 SYNC_FILE_RANGE_WAIT_AFTER);
-		if (err == 0)
+		if (err == 0) {
+			written += written_buffered;
 			invalidate_mapping_pages(mapping,
 						 pos >> PAGE_CACHE_SHIFT,
 						 endbyte >> PAGE_CACHE_SHIFT);
-		else
-			written = written_direct;
+		} else {
+			/*
+			 * We don't know how much we wrote, so just return
+			 * the number of bytes which were direct-written
+			 */
+		}
+	} else {
+		written = generic_file_buffered_write(iocb, iov, nr_segs,
+				pos, ppos, count, written);
 	}
 out:
 	current->backing_dev_info = NULL;
_

