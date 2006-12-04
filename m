Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937083AbWLDQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937083AbWLDQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937087AbWLDQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:26:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:20470 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937083AbWLDQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:26:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="169957899:sNHT92163477"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "'Zach Brown'" <zach.brown@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] remove redundant iov segment check
Date: Mon, 4 Dec 2006 08:26:36 -0800
Message-ID: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccXwPfDrkYk8cz6S22m9z4cHzJPLw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The access_ok() and negative length check on each iov segment in function
generic_file_aio_read/write are redundant.  They are all already checked
before calling down to these low level generic functions.

Vector I/O (both sync and async) are checked via rw_copy_check_uvector().
For single segment synchronous I/O, the checks are done in various places:
first access_ok() is checked in vfs_read/write, the negative length is
checked in rw_verify_area.  For single segment AIO, access_ok() is done
in aio_setup_iocb, and negative length is checked in io_submit_one.

So it's not possible to call down to generic_file_aio_read/write with invalid
iov segment.  Patch proposed to delete these redundant code.  Also moved
negative length check for single segment AIO into aio_setup_single_vector
to somewhat mirror aio_setup_vectored_rw that they check illegal negative
length. It fits better there too because iocb->aio_nbytes is now double
duty as segment count for vectored AIO, and checking negative length in
the entry point of all AIO isn't very obvious.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.19/fs/aio.c linux-2.6.19.ken/fs/aio.c
--- linux-2.6.19/fs/aio.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.ken/fs/aio.c	2006-12-03 17:16:52.000000000 -0800
@@ -1416,6 +1416,8 @@ static ssize_t aio_setup_single_vector(s
 	kiocb->ki_nr_segs = 1;
 	kiocb->ki_cur_seg = 0;
 	kiocb->ki_nbytes = kiocb->ki_left;
+	if (unlikely((ssize_t) kiocb->ki_nbytes < 0))
+		return -EINVAL;
 	return 0;
 }
 
@@ -1560,8 +1562,7 @@ int fastcall io_submit_one(struct kioctx
 	/* prevent overflows */
 	if (unlikely(
 	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
-	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
-	    ((ssize_t)iocb->aio_nbytes < 0)
+	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes)
 	   )) {
 		pr_debug("EINVAL: io_submit: overflow check\n");
 		return -EINVAL;
diff -Nurp linux-2.6.19/mm/filemap.c linux-2.6.19.ken/mm/filemap.c
--- linux-2.6.19/mm/filemap.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.ken/mm/filemap.c	2006-12-03 17:16:10.000000000 -0800
@@ -1143,29 +1143,9 @@ generic_file_aio_read(struct kiocb *iocb
 	struct file *filp = iocb->ki_filp;
 	ssize_t retval;
 	unsigned long seg;
-	size_t count;
+	size_t count = iocb->ki_left;
 	loff_t *ppos = &iocb->ki_pos;
 
-	count = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
-
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		count += iv->iov_len;
-		if (unlikely((ssize_t)(count|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_WRITE, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		count -= iv->iov_len;	/* This segment is no good */
-		break;
-	}
-
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
 		loff_t size;
@@ -2228,32 +2208,11 @@ __generic_file_aio_write_nolock(struct k
 	size_t ocount;		/* original count */
 	size_t count;		/* after file limit checks */
 	struct inode 	*inode = mapping->host;
-	unsigned long	seg;
 	loff_t		pos;
 	ssize_t		written;
 	ssize_t		err;
 
-	ocount = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
-
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		ocount += iv->iov_len;
-		if (unlikely((ssize_t)(ocount|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_READ, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		ocount -= iv->iov_len;	/* This segment is no good */
-		break;
-	}
-
-	count = ocount;
+	count = ocount = iocb->ki_left;
 	pos = *ppos;
 
 	vfs_check_frozen(inode->i_sb, SB_FREEZE_WRITE);
