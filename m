Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFOKrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFOKrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:47:31 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:63497 "EHLO
	sparc1.karlsbakk.net") by vger.kernel.org with ESMTP
	id S262127AbTFOKr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:47:27 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Date: Sun, 15 Jun 2003 13:01:06 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] O_DIRECT for ext3 (2.4.21)
Message-ID: <20030615110106.GA8404@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I've been waiting for the official O_DIRECT on ext3 for some time now, so I
thought perhaps it's time to get it into 2.4.22 or so. The patch I've used, is
the one below (for 2.4.21):

Please apply

roy


diff -urN linux/fs/ext3/inode.c prontux-1.1.0/fs/ext3/inode.c
--- linux/fs/ext3/inode.c	Sun Jun 15 12:55:34 2003
+++ prontux-1.1.0/fs/ext3/inode.c	Sun Jun 15 12:53:15 2003
@@ -27,6 +27,7 @@
 #include <linux/ext3_jbd.h>
 #include <linux/jbd.h>
 #include <linux/locks.h>
+#include <linux/iobuf.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/quotaops.h>
@@ -732,9 +733,9 @@
  * The BKL may not be held on entry here.  Be sure to take it early.
  */
 
-static int ext3_get_block_handle(handle_t *handle, struct inode *inode, 
-				 long iblock,
-				 struct buffer_head *bh_result, int create)
+static int
+ext3_get_block_handle(handle_t *handle, struct inode *inode, long iblock,
+		struct buffer_head *bh_result, int create, int extend_disksize)
 {
 	int err = -EIO;
 	int offsets[4];
@@ -814,16 +815,18 @@
 	if (err)
 		goto cleanup;
 
-	new_size = inode->i_size;
-	/*
-	 * This is not racy against ext3_truncate's modification of i_disksize
-	 * because VM/VFS ensures that the file cannot be extended while
-	 * truncate is in progress.  It is racy between multiple parallel
-	 * instances of get_block, but we have the BKL.
-	 */
-	if (new_size > inode->u.ext3_i.i_disksize)
-		inode->u.ext3_i.i_disksize = new_size;
-
+	if (extend_disksize) {
+		/*
+		 * This is not racy against ext3_truncate's modification of 
+		 * i_disksize because VM/VFS ensures that the file cannot be 
+		 * extended while truncate is in progress.  It is racy between 
+		 * multiple parallel instances of get_block, but we have BKL. 
+		 */
+		struct ext3_inode_info *ei = EXT3_I(inode);
+		new_size = inode->i_size;
+		if (new_size > ei->i_disksize)
+			ei->i_disksize = new_size;
+	}
 	bh_result->b_state |= (1UL << BH_New);
 	goto got_it;
 
@@ -850,10 +853,41 @@
 		handle = ext3_journal_current_handle();
 		J_ASSERT(handle != 0);
 	}
-	ret = ext3_get_block_handle(handle, inode, iblock, bh_result, create);
+	ret = ext3_get_block_handle(handle, inode, iblock,
+				bh_result, create, 1);
 	return ret;
 }
 
+#define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
+
+static int
+ext3_direct_io_get_block(struct inode *inode, long iblock,
+		struct buffer_head *bh_result, int create)
+{
+	handle_t *handle = journal_current_handle();
+	int ret = 0;
+
+	lock_kernel();
+	if (handle && handle->h_buffer_credits <= EXT3_RESERVE_TRANS_BLOCKS) {
+		/*
+		 * Getting low on buffer credits...
+		 */
+		if (!ext3_journal_extend(handle, DIO_CREDITS)) {
+			/*
+			 * Couldn't extend the transaction.  Start a new one
+			 */
+			ret = ext3_journal_restart(handle, DIO_CREDITS);
+		}
+	}
+	if (ret == 0)
+		ret = ext3_get_block_handle(handle, inode, iblock,
+					bh_result, create, 0);
+	if (ret == 0)
+		bh_result->b_size = (1 << inode->i_blkbits);
+	unlock_kernel();
+ 	return ret;
+ }
+
 /*
  * `handle' can be NULL if create is zero
  */
@@ -868,7 +902,7 @@
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
 	buffer_trace_init(&dummy.b_history);
-	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create);
+	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create, 1);
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
@@ -1374,6 +1408,67 @@
 	return journal_try_to_free_buffers(journal, page, wait);
 }
 
+static int
+ext3_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
+		unsigned long blocknr, int blocksize)
+{
+	struct ext3_inode_info *ei = EXT3_I(inode);
+	handle_t *handle = NULL;
+	int ret;
+	int orphan = 0;
+	loff_t offset = blocknr << inode->i_blkbits;	/* ugh */
+	ssize_t count = iobuf->length;			/* ditto */
+
+	if (rw == WRITE) {
+		loff_t final_size = offset + count;
+
+		lock_kernel();
+		handle = ext3_journal_start(inode, DIO_CREDITS);
+		unlock_kernel();
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+		if (final_size > inode->i_size) {
+			lock_kernel();
+			ret = ext3_orphan_add(handle, inode);
+			unlock_kernel();
+			if (ret)
+				goto out_stop;
+			orphan = 1;
+			ei->i_disksize = inode->i_size;
+		}
+	}
+
+	ret = generic_direct_IO(rw, inode, iobuf, blocknr,
+				blocksize, ext3_direct_io_get_block);
+
+out_stop:
+	if (handle) {
+		int err;
+
+		lock_kernel();
+		if (orphan) 
+			ext3_orphan_del(handle, inode);
+		if (orphan && ret > 0) {
+			loff_t end = offset + ret;
+			if (end > inode->i_size) {
+				ei->i_disksize = end;
+				inode->i_size = end;
+				err = ext3_mark_inode_dirty(handle, inode);
+				if (!ret) 
+					ret = err;
+			}
+		}
+		err = ext3_journal_stop(handle, inode);
+		if (ret == 0)
+			ret = err;
+		unlock_kernel();
+	}
+out:
+	return ret;
+
+}
 
 struct address_space_operations ext3_aops = {
 	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
@@ -1384,6 +1479,7 @@
 	bmap:		ext3_bmap,		/* BKL held */
 	flushpage:	ext3_flushpage,		/* BKL not held.  Don't need */
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
+	direct_IO:	ext3_direct_IO,		/* BKL not held.  Don't need */
 };
 
 /*
