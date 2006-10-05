Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWJETbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWJETbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWJETbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:31:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750912AbWJETbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:31:52 -0400
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
From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 05 Oct 2006 15:31:43 -0400
In-Reply-To: <20061004165504.c1dd3dd3.akpm@osdl.org> (Andrew Morton's message of "Wed, 4 Oct 2006 16:55:04 -0700")
Message-ID: <x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Andrew Morton <akpm@osdl.org> adds:

akpm> On Wed, 04 Oct 2006 16:53:53 -0400
akpm> Jeff Moyer <jmoyer@redhat.com> wrote:

>> The man page for open states:
>> 
>> O_DIRECT
>> Try to minimize cache effects of the I/O to and from this file.
>> 
>> I think that invalidating the page cache pages we use when falling back to
>> buffered I/O stays true to the above description.

akpm> What the manpage forgot to mention is "direct-io is synchronous".

akpm> Except it isn't, when we fall back to buffered-IO.  So yup, I think
akpm> we could justify this (sort of) change on those grounds alone:
akpm> preserving the synchronous semantics.

akpm> I'd propose that we do this via

akpm> 	generic_file_buffered_write(...);
akpm> 	do_sync_file_range(..., SYNC_FILE_RANGE_WAIT_BEFORE|
akpm> 			SYNC_FILE_RANGE_WRITE|
akpm> 			SYNC_FILE_RANGE_WAIT_AFTER)

akpm> 	invalidate_mapping_pages(...);

OK, patch attached.  It's a bit awkward that some interfaces take a page
index while others take an offset in bytes.  I tested it with the code I
sent earlier in this thread.  I'll get results from oast and some dbcreate
runs comparing kernels with and without this change and post them when
available (probably in the next day or two).  Feel free to hold off
comitting this until that data is presented.

akpm> There is a slight inefficiency here: generic_file_direct_IO() does
akpm> invalidate_inode_pages2_range(), then we go and instantiate some
akpm> pagecache, then we strip it away again with
akpm> invalidate_mapping_pages().  That first
akpm> invalidate_inode_pages2_range() was somewhat of a waste of cycles.

akpm> But we expect that the next call to generic_file_direct_IO() won't
akpm> actually call invalidate_inode_pages2_range(), because
akpm> mapping->nrpages is usually zero.

akpm> Well, it would have been, back in the days when we were invalidating
akpm> the whole file.  Now are more efficient and we only invalidate the
akpm> specific segment of that file.  So if there's a stray pagecache page
akpm> somewhere at the far end ofthe file, we'll pointlessly call
akpm> invalidate_inode_pages2_range() every time.  Oh well.

I don't think it's worth losing sleep over.  I wonder how many applications
actually mix buffered and unbuffered I/O to the same file.

Cheers,

Jeff

--- linux-2.6.18.i686/mm/filemap.c.orig	2006-10-02 12:59:25.000000000 -0400
+++ linux-2.6.18.i686/mm/filemap.c	2006-10-05 15:06:26.000000000 -0400
@@ -2350,13 +2350,13 @@ __generic_file_aio_write_nolock(struct k
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
-	const struct address_space * mapping = file->f_mapping;
+	struct address_space * mapping = file->f_mapping;
 	size_t ocount;		/* original count */
 	size_t count;		/* after file limit checks */
 	struct inode 	*inode = mapping->host;
 	unsigned long	seg;
 	loff_t		pos;
-	ssize_t		written;
+	ssize_t		written, written_direct;
 	ssize_t		err;
 
 	ocount = 0;
@@ -2386,7 +2386,7 @@ __generic_file_aio_write_nolock(struct k
 
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = mapping->backing_dev_info;
-	written = 0;
+	written = written_direct = 0;
 
 	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
 	if (err)
@@ -2413,10 +2413,32 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		pos += written;
 		count -= written;
+
+		written_direct = written;
 	}
 
 	written = generic_file_buffered_write(iocb, iov, nr_segs,
 			pos, ppos, count, written);
+
+	/*
+	 *  When falling through to buffered I/O, we need to ensure that the
+	 *  page cache pages are written to disk and invalidated to preserve
+	 *  the expected O_DIRECT semantics.
+	 */
+	if (unlikely(file->f_flags & O_DIRECT)) {
+		pgoff_t endbyte = pos + count - 1;
+
+		err = do_sync_file_range(file, pos, endbyte,
+					 SYNC_FILE_RANGE_WAIT_BEFORE|
+					 SYNC_FILE_RANGE_WRITE|
+					 SYNC_FILE_RANGE_WAIT_AFTER);
+		if (err == 0)
+			invalidate_mapping_pages(mapping,
+						 pos >> PAGE_CACHE_SHIFT,
+						 endbyte >> PAGE_CACHE_SHIFT);
+		else
+			written = written_direct;
+	}
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
