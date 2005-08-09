Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVHINFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVHINFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVHINFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:05:33 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:12771 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S932517AbVHINFc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:05:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.4.31 O_DIRECT support for ext3
Date: Tue, 9 Aug 2005 18:35:29 +0530
Message-ID: <7352E281DE2FDC4E8F29EC48AAE1668C0910CF@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.31 O_DIRECT support for ext3
Thread-Index: AcWc4sx69TtsoMsmTFeXYa3aRD+7tQ==
From: <manoj.sharma@wipro.com>
To: <sct@redhat.com>, <akpm@zip.com.au>, <adilger@clusterfs.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Aug 2005 13:05:29.0449 (UTC) FILETIME=[045AB590:01C59CE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is back-port of O_DIRECT support for ext3 from 2.6 to 2.4.31
kernel.

Any suggestions/comments ?


Thanks,
Manoj


--- linux-2.4-latest/fs/ext3/inode.c	2005-08-08 11:46:52.000000000
+0530
+++ linux-2.4.31/fs/ext3/inode.c	2005-08-09 14:59:16.000000000
+0530
@@ -31,6 +31,7 @@
 #include <linux/highuid.h>
 #include <linux/quotaops.h>
 #include <linux/module.h>
+#include <linux/iobuf.h>
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the
start
@@ -1388,6 +1389,68 @@
 }
 
 
+#define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
+
+static int ext3_direct_IO(int rw, struct inode * inode, struct kiobuf *
iobuf, unsigned long blocknr, int blocksize)
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
+	ret = generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
ext3_get_block);
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
+			 	* here due to non-zero-length I/O, so
there's
+			 	* no way of reporting error returns from
+			 	* ext3_mark_inode_dirty() to userspace.
So
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
 	readpage:	ext3_readpage,		/* BKL not held.  Don't
need */
 	writepage:	ext3_writepage,		/* BKL not held.  We
take it */
@@ -1397,6 +1460,7 @@
 	bmap:		ext3_bmap,		/* BKL held */
 	flushpage:	ext3_flushpage,		/* BKL not held.  Don't
need */
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't
need */
+	direct_IO:	ext3_direct_IO,
 };
 
 /*
