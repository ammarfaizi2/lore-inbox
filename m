Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318879AbSH1PoT>; Wed, 28 Aug 2002 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318884AbSH1Pmn>; Wed, 28 Aug 2002 11:42:43 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:4739 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318879AbSH1PlK>; Wed, 28 Aug 2002 11:41:10 -0400
Date: Wed, 28 Aug 2002 16:45:20 +0100
Message-Id: <200208281545.g7SFjKE14338@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 5/8] 2.4.20-pre4/ext3: Fix O_SYNC for non-data-journaled modes.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3 has its own code which marks buffers dirty, in addition to the setting
done by the core generic_commit_write code.  However, the core code does

                        if (!atomic_set_buffer_dirty(bh)) {
                                __mark_dirty(bh);
                                buffer_insert_inode_queue(bh, inode);

so if ext3 marks the buffer dirty itself, the core fails to put it on the
per-inode list of dirty buffers.  Hence, fsync_inode_buffers() misses it.

The fix is to let ext3 put the buffer on the inode queue manually when
walking the page's buffer lists in its page write code.

--- linux-ext3-2.4merge/fs/ext3/inode.c.=K0006=.orig	Tue Aug 27 23:19:57 2002
+++ linux-ext3-2.4merge/fs/ext3/inode.c	Tue Aug 27 23:19:57 2002
@@ -949,11 +949,13 @@
 }
 
 static int walk_page_buffers(	handle_t *handle,
+				struct inode *inode,
 				struct buffer_head *head,
 				unsigned from,
 				unsigned to,
 				int *partial,
 				int (*fn)(	handle_t *handle,
+						struct inode *inode,
 						struct buffer_head *bh))
 {
 	struct buffer_head *bh;
@@ -971,7 +973,7 @@
 				*partial = 1;
 			continue;
 		}
-		err = (*fn)(handle, bh);
+		err = (*fn)(handle, inode, bh);
 		if (!ret)
 			ret = err;
 	}
@@ -1004,7 +1006,7 @@
  * write.  
  */
 
-static int do_journal_get_write_access(handle_t *handle, 
+static int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				       struct buffer_head *bh)
 {
 	return ext3_journal_get_write_access(handle, bh);
@@ -1030,7 +1032,7 @@
 		goto prepare_write_failed;
 
 	if (ext3_should_journal_data(inode)) {
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, inode, page->buffers,
 				from, to, NULL, do_journal_get_write_access);
 		if (ret) {
 			/*
@@ -1051,24 +1053,32 @@
 	return ret;
 }
 
-static int journal_dirty_sync_data(handle_t *handle, struct buffer_head *bh)
+static int journal_dirty_sync_data(handle_t *handle, struct inode *inode,
+				   struct buffer_head *bh)
 {
-	return ext3_journal_dirty_data(handle, bh, 0);
+	int ret = ext3_journal_dirty_data(handle, bh, 0);
+	if (bh->b_inode != inode)
+		buffer_insert_inode_data_queue(bh, inode);
+	return ret;
 }
 
 /*
  * For ext3_writepage().  We also brelse() the buffer to account for
  * the bget() which ext3_writepage() performs.
  */
-static int journal_dirty_async_data(handle_t *handle, struct buffer_head *bh)
+static int journal_dirty_async_data(handle_t *handle, struct inode *inode, 
+				    struct buffer_head *bh)
 {
 	int ret = ext3_journal_dirty_data(handle, bh, 1);
+	if (bh->b_inode != inode)
+		buffer_insert_inode_data_queue(bh, inode);
 	__brelse(bh);
 	return ret;
 }
 
 /* For commit_write() in data=journal mode */
-static int commit_write_fn(handle_t *handle, struct buffer_head *bh)
+static int commit_write_fn(handle_t *handle, struct inode *inode, 
+			   struct buffer_head *bh)
 {
 	set_bit(BH_Uptodate, &bh->b_state);
 	return ext3_journal_dirty_metadata(handle, bh);
@@ -1103,7 +1113,7 @@
 		int partial = 0;
 		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, inode, page->buffers,
 			from, to, &partial, commit_write_fn);
 		if (!partial)
 			SetPageUptodate(page);
@@ -1113,7 +1123,7 @@
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
 	} else {
 		if (ext3_should_order_data(inode)) {
-			ret = walk_page_buffers(handle, page->buffers,
+			ret = walk_page_buffers(handle, inode, page->buffers,
 				from, to, NULL, journal_dirty_sync_data);
 		}
 		/* Be careful here if generic_commit_write becomes a
@@ -1195,7 +1205,8 @@
 	return generic_block_bmap(mapping,block,ext3_get_block);
 }
 
-static int bget_one(handle_t *handle, struct buffer_head *bh)
+static int bget_one(handle_t *handle, struct inode *inode, 
+		    struct buffer_head *bh)
 {
 	atomic_inc(&bh->b_count);
 	return 0;
@@ -1294,7 +1305,7 @@
 			create_empty_buffers(page,
 				inode->i_dev, inode->i_sb->s_blocksize);
 		page_buffers = page->buffers;
-		walk_page_buffers(handle, page_buffers, 0,
+		walk_page_buffers(handle, inode, page_buffers, 0,
 				PAGE_CACHE_SIZE, NULL, bget_one);
 	}
 
@@ -1312,7 +1323,7 @@
 
 	/* And attach them to the current transaction */
 	if (order_data) {
-		err = walk_page_buffers(handle, page_buffers,
+		err = walk_page_buffers(handle, inode, page_buffers,
 			0, PAGE_CACHE_SIZE, NULL, journal_dirty_async_data);
 		if (!ret)
 			ret = err;
