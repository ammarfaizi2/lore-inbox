Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161831AbWJDREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161831AbWJDREv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161849AbWJDREu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:04:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161831AbWJDREt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:04:49 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, zach.brown@oracle.com
Subject: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 04 Oct 2006 13:04:42 -0400
Message-ID: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that Oracle creates sparse files when doing table creates, and
then populates those files using O_DIRECT I/O.  That means that every I/O to
the sparse file falls back to buffered I/O.  Currently, such a sequential
O_DIRECT write to a sparse file will end up populating the page cache.  The
problem is that we don't invalidate the page cache pages used to perform
the buffered fallback.  After talking this over with Zach, we agreed that
there should be a call to truncate_inode_pages_range after the buffered I/O
fallback.

Attached is a patch which addresses the problem in my testing.  I wrote a
simple test program that creates a sparse file and issues sequential DIO
writes to it.  Before the patch, the page cache would grow as the file was
written.  With the patch, the page cache does not grow.

Comments welcome.

Cheers,

Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.18.i686/mm/filemap.c.orig	2006-10-02 12:59:25.000000000 -0400
+++ linux-2.6.18.i686/mm/filemap.c	2006-10-04 12:54:51.000000000 -0400
@@ -2350,7 +2350,7 @@ __generic_file_aio_write_nolock(struct k
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
-	const struct address_space * mapping = file->f_mapping;
+	struct address_space * mapping = file->f_mapping;
 	size_t ocount;		/* original count */
 	size_t count;		/* after file limit checks */
 	struct inode 	*inode = mapping->host;
@@ -2417,6 +2417,15 @@ __generic_file_aio_write_nolock(struct k
 
 	written = generic_file_buffered_write(iocb, iov, nr_segs,
 			pos, ppos, count, written);
+
+	/*
+	 *  When falling through to buffered I/O, we need to ensure that the
+	 *  page cache pages are written to disk and invalidated to preserve
+	 *  the expected O_DIRECT semantics.
+	 */
+	if (unlikely(file->f_flags & O_DIRECT))
+		truncate_inode_pages_range(mapping, pos, pos + count - 1);
+
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
