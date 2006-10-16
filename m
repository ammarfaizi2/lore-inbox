Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWJPVAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWJPVAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWJPVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:00:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161077AbWJPVAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:00:24 -0400
Date: Mon, 16 Oct 2006 13:59:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
Message-Id: <20061016135910.be11a2dc.akpm@osdl.org>
In-Reply-To: <1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com>
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>
	<4533C6A1.40203@oracle.com>
	<1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>
	<4533E7E2.6010506@oracle.com>
	<1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 13:38:19 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> > 
> > So the answer is that -rc1-mm1 doesn't quite have the most recent
> > version of this patch.  Grab the final patch at the end of this post
> > from Andrew:
> > 
> > 	http://lkml.org/lkml/2006/10/11/234
> > 
> > It fixes up a misunderstanding that came from
> > generic_file_buffered_write()'s habit of adding its 'written' input into
> > the amount of bytes it announces having written in its return value.
> > 
> > From mm-commits it looks like -mm2 will have the full patch.
> > 
> 
> Hmm.. with that patch applied, I still have fsx failures.
> This time read() returning -EINVAL. Are there any other fixes
> missing in -mm ?

Probably.  I need to get off butt and prepare rc2-mm1.

The below is the full patch against 2.6.19-rc2.  Please test this version.


From: Jeff Moyer <jmoyer@redhat.com>

When direct-io falls back to buffered write, it will just leave the dirty data
floating about in pagecache, pending regular writeback.

But normal direct-io semantics are that IO is synchronous, and that it leaves
no pagecache behind.

So change the fallback-to-buffered-write code to sync the file region and to
then strip away the pagecache, just as a regular direct-io write would do.

Acked-by: Jeff Moyer <jmoyer@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |   51 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 45 insertions(+), 6 deletions(-)

diff -puN mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write mm/filemap.c
--- a/mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write
+++ a/mm/filemap.c
@@ -2222,7 +2222,7 @@ __generic_file_aio_write_nolock(struct k
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
-	const struct address_space * mapping = file->f_mapping;
+	struct address_space * mapping = file->f_mapping;
 	size_t ocount;		/* original count */
 	size_t count;		/* after file limit checks */
 	struct inode 	*inode = mapping->host;
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
@@ -2285,10 +2288,46 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		pos += written;
 		count -= written;
-	}
+		written_buffered = generic_file_buffered_write(iocb, iov,
+						nr_segs, pos, ppos, count,
+						written);
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
 
-	written = generic_file_buffered_write(iocb, iov, nr_segs,
-			pos, ppos, count, written);
+		/*
+		 * We need to ensure that the page cache pages are written to
+		 * disk and invalidated to preserve the expected O_DIRECT
+		 * semantics.
+		 */
+		endbyte = pos + written_buffered - written - 1;
+		err = do_sync_file_range(file, pos, endbyte,
+					 SYNC_FILE_RANGE_WAIT_BEFORE|
+					 SYNC_FILE_RANGE_WRITE|
+					 SYNC_FILE_RANGE_WAIT_AFTER);
+		if (err == 0) {
+			written = written_buffered;
+			invalidate_mapping_pages(mapping,
+						 pos >> PAGE_CACHE_SHIFT,
+						 endbyte >> PAGE_CACHE_SHIFT);
+		} else {
+			/*
+			 * We don't know how much we wrote, so just return
+			 * the number of bytes which were direct-written
+			 */
+		}
+	} else {
+		written = generic_file_buffered_write(iocb, iov, nr_segs,
+				pos, ppos, count, written);
+	}
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
_

