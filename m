Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVHJKwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVHJKwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVHJKwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:52:15 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:58834 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S932543AbVHJKwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:52:14 -0400
Date: Wed, 10 Aug 2005 16:20:24 +0530 (IST)
From: Manoj Sharma <manoj.sharma@wipro.com>
X-X-Sender: manoj.sharma@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.31 O_DIRECT support for ext3
In-Reply-To: <1123593078.3839.25.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0508101608550.1275@localhost.localdomain>
References: <7352E281DE2FDC4E8F29EC48AAE1668C0910CF@blr-m3-msg.wipro.com>
 <1123593078.3839.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Aug 2005 10:48:40.0938 (UTC) FILETIME=[121D14A0:01C59D99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Arjan van de Ven wrote:

> On Tue, 2005-08-09 at 18:35 +0530, manoj.sharma@wipro.com wrote:
> > Hi,
> >
> > This is back-port of O_DIRECT support for ext3 from 2.6 to 2.4.31
> > kernel.
> >
> > Any suggestions/comments ?
>
> why?
>
> personally I think this is way out of scope for a 2.4.x release in this
> phase of 2.4's life.
>
> (also you wrapped your patch)

All other journal file systems in 2.4 have been supporting directIO and
there are multiple threads where people have been asking for it in ext3.
I needed it for one of my applications and sent it since it might be
useful for others as well.

(Resending the patch after getting the wrapping corrected)


Thanks.


--- linux-2.4-latest/fs/ext3/inode.c	2005-08-08 11:46:52.000000000 +0530
+++ linux-2.4.31/fs/ext3/inode.c	2005-08-09 14:59:16.000000000 +0530
@@ -31,6 +31,7 @@
 #include <linux/highuid.h>
 #include <linux/quotaops.h>
 #include <linux/module.h>
+#include <linux/iobuf.h>

 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
@@ -1388,6 +1389,68 @@
 }


+#define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
+
+static int ext3_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+{
+	ssize_t	ret;
+	loff_t	offset, final_size;
+	handle_t	*handle = NULL;
+	int	orphan = 0;
+	struct ext3_inode_info *ei = EXT3_I(inode);
+
+	offset = ((loff_t)blocknr) * blocksize;
+	final_size = offset + iobuf->length;
+
+	if (rw == WRITE) {
+
+		handle = ext3_journal_start(inode, DIO_CREDITS);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+		if (final_size > inode->i_size) {
+			ret = ext3_orphan_add(handle, inode);
+			if (ret)
+				goto out_stop;
+			orphan = 1;
+			ei->i_disksize = inode->i_size;
+		}
+	}
+
+	ret = generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext3_get_block);
+
+	handle = journal_current_handle();
+
+out_stop:
+	if (handle) {
+		int err;
+
+		if (orphan && inode->i_nlink)
+			ext3_orphan_del(handle, inode);
+		if (orphan && ret > 0) {
+			loff_t end = offset + ret;
+			if (end > inode->i_size) {
+				ei->i_disksize = end;
+				inode->i_size = end;
+				/*
+			 	* We're going to return a positive `ret'
+			 	* here due to non-zero-length I/O, so there's
+			 	* no way of reporting error returns from
+			 	* ext3_mark_inode_dirty() to userspace.  So
+			 	* ignore it.
+			 	*/
+				ext3_mark_inode_dirty(handle, inode);
+			}
+		}
+		err = ext3_journal_stop(handle, inode);
+		if (ret == 0)
+			ret = err;
+	}
+out:
+	return ret;
+}
+
 struct address_space_operations ext3_aops = {
 	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
 	writepage:	ext3_writepage,		/* BKL not held.  We take it */
@@ -1397,6 +1460,7 @@
 	bmap:		ext3_bmap,		/* BKL held */
 	flushpage:	ext3_flushpage,		/* BKL not held.  Don't need */
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
+	direct_IO:	ext3_direct_IO,
 };

 /*

