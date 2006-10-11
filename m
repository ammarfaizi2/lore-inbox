Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWJKQrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWJKQrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWJKQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161129AbWJKQrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:47:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org> <4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org> <45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
	<20061004165504.c1dd3dd3.akpm@osdl.org>
	<x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
	<20061006131148.9c6b88ab.akpm@osdl.org>
From: jmoyer@redhat.com
Date: Wed, 11 Oct 2006 12:48:57 -0400
Message-ID: <m3odsi4x3a.fsf@redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Andrew Morton <akpm@osdl.org> adds:

akpm> Patch is below.  The end result looks like:


akpm> 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
akpm> 	if (unlikely(file->f_flags & O_DIRECT)) {
akpm> 		loff_t endbyte;
akpm> 		ssize_t written_buffered;

akpm> 		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
akpm> 							ppos, count, ocount);
akpm> 		if (written < 0 || written == count)
akpm> 			goto out;
akpm> 		/*
akpm> 		 * direct-io write to a hole: fall through to buffered I/O
akpm> 		 * for completing the rest of the request.
akpm> 		 */
akpm> 		pos += written;
akpm> 		count -= written;
akpm> 		written_buffered = generic_file_buffered_write(iocb, iov,
akpm> 						nr_segs, pos, ppos, count,
akpm> 						written);

akpm> 		/*
akpm> 		 * We need to ensure that the page cache pages are written to
akpm> 		 * disk and invalidated to preserve the expected O_DIRECT
akpm> 		 * semantics.
akpm> 		 */
akpm> 		endbyte = pos + written_buffered - 1;

We probably want to handle the case where generic_file_buffered_write
returns an error or nothing written.

akpm> 		err = do_sync_file_range(file, pos, endbyte,
akpm> 					 SYNC_FILE_RANGE_WAIT_BEFORE|
akpm> 					 SYNC_FILE_RANGE_WRITE|
akpm> 					 SYNC_FILE_RANGE_WAIT_AFTER);
akpm> 		if (err == 0) {
akpm> 			written += written_buffered;
akpm> 			invalidate_mapping_pages(mapping,
akpm> 						 pos >> PAGE_CACHE_SHIFT,
akpm> 						 endbyte >> PAGE_CACHE_SHIFT);

generic_file_buffered_write takes written as an argument, and returns that
amount plus whatever it managed to write.  As such, you don't want to add
written_buffered to written.  Instead, you want written = written_buffered.
The endbyte calculation has to be altered in kind.

Incremental, locally tested patch attached.  Comments are welcome as
always.  Once there is consensus, I'll send this off for testing with
Oracle again.

-Jeff

--- linux-2.6.18.i686/mm/filemap.c.orig	2006-10-11 11:58:29.000000000 -0400
+++ linux-2.6.18.i686/mm/filemap.c	2006-10-11 12:31:11.000000000 -0400
@@ -2419,19 +2419,21 @@ __generic_file_aio_write_nolock(struct k
 		written_buffered = generic_file_buffered_write(iocb, iov,
 						nr_segs, pos, ppos, count,
 						written);
+		if (written_buffered < 0 || written_buffered == written)
+			goto out;
 
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
