Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCISh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCISh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWCISh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:37:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:26069 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751259AbWCISh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:37:57 -0500
Subject: [RFC PATCH] ext3 writepage() journal avoidance
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, sct@redhat.com, jack@suse.cz
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 10:39:22 -0800
Message-Id: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to speed up ext3 writepage() by avoiding
journaling in non-block allocation cases. Does this
look reasonable ? So far, my testing is fine. What am 
I missing here ?

ext3_ordered_writepage() and ext3_writeback_writepage() starts
a transcation all the time. We need to start a transaction only
if we need to allocate a disk block. For normal writes, disk
block allocation happens in prepare_write(). We can find out
if the disk-block is already mapped, looking at buffers attached
to the page. So, for non-block allocation cases (for non-mapped
writes), we don't need to do all the journal stuff in writepage().

Thanks,
Badari

ext3_ordered_writepage() and ext3_writeback_writepage() starts
a transcation all the time. We need to start a transaction only
if we need to allocate a disk block. For normal writes, disk
block allocation happens in prepare_write(). We can find out
if the disk-block is already mapped, looking at buffers attached
to the page. So, for non-block allocation cases (for non-mapped 
writes), we don't need to do all the journal stuff in writepage().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.16-rc5/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ext3/inode.c	2006-03-09 10:19:41.000000000
-0800
+++ linux-2.6.16-rc5/fs/ext3/inode.c	2006-03-09 10:31:12.000000000 -0800
@@ -1201,6 +1201,11 @@ static int bput_one(handle_t *handle, st
 	return 0;
 }
 
+static int check_bmap(handle_t *handle, struct buffer_head *bh)
+{
+	return !buffer_mapped(bh);
+}
+
 static int journal_dirty_data_fn(handle_t *handle, struct buffer_head
*bh)
 {
 	if (buffer_mapped(bh))
@@ -1268,6 +1273,7 @@ static int ext3_ordered_writepage(struct
 	handle_t *handle = NULL;
 	int ret = 0;
 	int err;
+	int need_trans = 1;
 
 	J_ASSERT(PageLocked(page));
 
@@ -1278,6 +1284,27 @@ static int ext3_ordered_writepage(struct
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
+	if (!page_has_buffers(page)) {
+		create_empty_buffers(page, inode->i_sb->s_blocksize,
+				(1 << BH_Dirty)|(1 << BH_Uptodate));
+	} else {
+		/*
+		 * Check to see if buffers are mapped to disk blocks.
+	 	 * If disk blocks are already there, no reason for
+		 * starting a transaction.
+		 */
+		page_bufs = page_buffers(page);
+		need_trans = walk_page_buffers(handle, page_bufs, 0,
+					PAGE_CACHE_SIZE, NULL, check_bmap);
+	}
+
+	if (need_trans == 0) {
+		/* No need to allocate disk blocks - just do IO */
+		ret = block_write_full_page(page, ext3_get_block, wbc);
+		goto out;
+	}
+
+	/* We may need to allocate blocks - start a transaction etc. */
 	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks
(inode));
 
 	if (IS_ERR(handle)) {
@@ -1285,10 +1312,6 @@ static int ext3_ordered_writepage(struct
 		goto out_fail;
 	}
 
-	if (!page_has_buffers(page)) {
-		create_empty_buffers(page, inode->i_sb->s_blocksize,
-				(1 << BH_Dirty)|(1 << BH_Uptodate));
-	}
 	page_bufs = page_buffers(page);
 	walk_page_buffers(handle, page_bufs, 0,
 			PAGE_CACHE_SIZE, NULL, bget_one);
@@ -1318,6 +1341,7 @@ static int ext3_ordered_writepage(struct
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;
+out:
 	return ret;
 
 out_fail:
@@ -1333,14 +1357,26 @@ static int ext3_writeback_writepage(stru
 	handle_t *handle = NULL;
 	int ret = 0;
 	int err;
+	int need_trans = 1;
 
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
-	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks
(inode));
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_fail;
+	/*
+	 * Check to see if the disk blocking is already available.
+	 * If so, there is no need to start a transaction.
+	 */
+	if (page_has_buffers(page))
+		need_trans = walk_page_buffers(handle, page_buffers(page), 0,
+					PAGE_CACHE_SIZE, NULL, check_bmap);
+
+	if (need_trans) {
+		handle = ext3_journal_start(inode,
+				ext3_writepage_trans_blocks(inode));
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_fail;
+		}
 	}
 
 	if (test_opt(inode->i_sb, NOBH))
@@ -1348,9 +1384,11 @@ static int ext3_writeback_writepage(stru
 	else
 		ret = block_write_full_page(page, ext3_get_block, wbc);
 
-	err = ext3_journal_stop(handle);
-	if (!ret)
-		ret = err;
+	if (need_trans) {
+		err = ext3_journal_stop(handle);
+		if (!ret)
+			ret = err;
+	}
 	return ret;
 
 out_fail:


