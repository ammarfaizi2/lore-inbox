Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWJKSiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWJKSiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWJKSiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:38:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWJKSh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:37:59 -0400
Date: Wed, 11 Oct 2006 11:37:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: jmoyer@redhat.com
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061011113720.463e331c.akpm@osdl.org>
In-Reply-To: <m3odsi4x3a.fsf@redhat.com>
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
	<20061006131148.9c6b88ab.akpm@osdl.org>
	<m3odsi4x3a.fsf@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 12:48:57 -0400
jmoyer@redhat.com wrote:

> ==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Andrew Morton <akpm@osdl.org> adds:
> 
> akpm> Patch is below.  The end result looks like:
> 
> 
> akpm> 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
> akpm> 	if (unlikely(file->f_flags & O_DIRECT)) {
> akpm> 		loff_t endbyte;
> akpm> 		ssize_t written_buffered;
> 
> akpm> 		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
> akpm> 							ppos, count, ocount);
> akpm> 		if (written < 0 || written == count)
> akpm> 			goto out;
> akpm> 		/*
> akpm> 		 * direct-io write to a hole: fall through to buffered I/O
> akpm> 		 * for completing the rest of the request.
> akpm> 		 */
> akpm> 		pos += written;
> akpm> 		count -= written;
> akpm> 		written_buffered = generic_file_buffered_write(iocb, iov,
> akpm> 						nr_segs, pos, ppos, count,
> akpm> 						written);
> 
> akpm> 		/*
> akpm> 		 * We need to ensure that the page cache pages are written to
> akpm> 		 * disk and invalidated to preserve the expected O_DIRECT
> akpm> 		 * semantics.
> akpm> 		 */
> akpm> 		endbyte = pos + written_buffered - 1;
> 
> We probably want to handle the case where generic_file_buffered_write
> returns an error or nothing written.

If generic_file_buffered_write() returned an error, we want to save that
error code somewhere.

If generic_file_buffered_write() didn't actually write anything then that's
pretty weird, but the following code should handle that correctly and do
the right thing.  So perhaps that case is so rare it isn't worth the
test-n-branch to optimise for it?


> akpm> 		err = do_sync_file_range(file, pos, endbyte,
> akpm> 					 SYNC_FILE_RANGE_WAIT_BEFORE|
> akpm> 					 SYNC_FILE_RANGE_WRITE|
> akpm> 					 SYNC_FILE_RANGE_WAIT_AFTER);
> akpm> 		if (err == 0) {
> akpm> 			written += written_buffered;
> akpm> 			invalidate_mapping_pages(mapping,
> akpm> 						 pos >> PAGE_CACHE_SHIFT,
> akpm> 						 endbyte >> PAGE_CACHE_SHIFT);
> 
> generic_file_buffered_write takes written as an argument, and returns that
> amount plus whatever it managed to write.

How weird.

>  As such, you don't want to add
> written_buffered to written.  Instead, you want written = written_buffered.
> The endbyte calculation has to be altered in kind.

OK.

> Incremental, locally tested patch attached.  Comments are welcome as
> always.  Once there is consensus, I'll send this off for testing with
> Oracle again.


So I'd propose:

diff -puN mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fix mm/filemap.c
--- a/mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fix
+++ a/mm/filemap.c
@@ -2291,19 +2291,30 @@ __generic_file_aio_write_nolock(struct k
 		written_buffered = generic_file_buffered_write(iocb, iov,
 						nr_segs, pos, ppos, count,
 						written);
+		/*
+		 * If generic_file_buffered_write() retuned a synchronous error
+		 * then we want to return the number of bytes which were
+		 * direct-written, or the error code if that was zero.  Note
+		 * that this differs from normal direct-io semantics, which
+		 * will return -EFOO even if some bytes were written.
+		 */
+		if (written_buffered < 0) {
+			err = written_buffered;
+			goto out;
+		}
 
 		/*
 		 * We need to ensure that the page cache pages are written to
 		 * disk and invalidated to preserve the expected O_DIRECT
 		 * semantics.
 		 */
-		endbyte = pos + written_buffered - 1;
+		endbyte = pos + written_buffered - written - 1;
 		err = do_sync_file_range(file, pos, endbyte,
 					 SYNC_FILE_RANGE_WAIT_BEFORE|
 					 SYNC_FILE_RANGE_WRITE|
 					 SYNC_FILE_RANGE_WAIT_AFTER);
 		if (err == 0) {
-			written += written_buffered;
+			written = written_buffered;
 			invalidate_mapping_pages(mapping,
 						 pos >> PAGE_CACHE_SHIFT,
 						 endbyte >> PAGE_CACHE_SHIFT);
_

