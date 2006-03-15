Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWCOVS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCOVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCOVS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:18:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:6570 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751363AbWCOVS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:18:26 -0500
Subject: [RFC PATCH] Make use of PageMappedToDisk() to improve ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, ext2-devel <Ext2-devel@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 13:20:01 -0800
Message-Id: <1142457602.21442.114.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is my first pass at making use of PageMappedToDisk() to avoid
ext3 prepare_write/commit_write handling + journaling.

I see significant improvements with my micro benchmarks for over-write
(pages again & again) case. Does this look right to you ?

	2.6.16-rc6	2.6.16-rc6+patch
real	0m6.606s	0m3.705s
user	0m0.124s	0m0.108s
sys	0m6.456s	0m3.600s

Thanks,
Badari 

Make use of PageMappedToDisk(page) to find out if we need to
block allocation and skip the calls to it, if not needed.
When we are not doing block allocation, also avoid calls
to journal start and adding buffers to transaction.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc6/fs/buffer.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/buffer.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/fs/buffer.c	2006-03-15 13:05:26.000000000 -0800
@@ -2051,8 +2051,10 @@ static int __block_commit_write(struct i
 	 * the next read(). Here we 'discover' whether the page went
 	 * uptodate as a result of this (potentially partial) write.
 	 */
-	if (!partial)
+	if (!partial) {
 		SetPageUptodate(page);
+		SetPageMappedToDisk(page);
+	}
 	return 0;
 }
 
Index: linux-2.6.16-rc6/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/ext3/inode.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/fs/ext3/inode.c	2006-03-15 13:09:14.000000000 -0800
@@ -999,6 +999,13 @@ static int ext3_prepare_write(struct fil
 	handle_t *handle;
 	int retries = 0;
 
+
+	/*
+ 	 * If the page is already mapped to disk and we are not
+	 * journalling the data - there is nothing to do.
+	 */
+	if (PageMappedToDisk(page) && !ext3_should_journal_data(inode))
+		return 0;
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
@@ -1059,8 +1066,14 @@ static int ext3_ordered_commit_write(str
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 
-	ret = walk_page_buffers(handle, page_buffers(page),
-		from, to, NULL, ext3_journal_dirty_data);
+	/*
+	 * If the page is already mapped to disk, we won't have
+	 * a handle - which means no metadata updates are needed.
+	 * So, no need to add buffers to the transaction.
+	 */
+	if (handle)
+		ret = walk_page_buffers(handle, page_buffers(page),
+			from, to, NULL, ext3_journal_dirty_data);
 
 	if (ret == 0) {
 		/*
@@ -1075,9 +1088,11 @@ static int ext3_ordered_commit_write(str
 			EXT3_I(inode)->i_disksize = new_i_size;
 		ret = generic_commit_write(file, page, from, to);
 	}
-	ret2 = ext3_journal_stop(handle);
-	if (!ret)
-		ret = ret2;
+	if (handle) {
+		ret2 = ext3_journal_stop(handle);
+		if (!ret)
+			ret = ret2;
+	}
 	return ret;
 }
 
@@ -1098,9 +1113,11 @@ static int ext3_writeback_commit_write(s
 	else
 		ret = generic_commit_write(file, page, from, to);
 
-	ret2 = ext3_journal_stop(handle);
-	if (!ret)
-		ret = ret2;
+	if (handle) {
+		ret2 = ext3_journal_stop(handle);
+		if (!ret)
+			ret = ret2;
+	}
 	return ret;
 }
 
@@ -1278,6 +1295,14 @@ static int ext3_ordered_writepage(struct
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
+	/*
+	 * If the page is mapped to disk, just do the IO
+	 */
+	if (PageMappedToDisk(page)) {
+		ret = block_write_full_page(page, ext3_get_block, wbc);
+		goto out;
+	}
+
 	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
 
 	if (IS_ERR(handle)) {
@@ -1318,6 +1343,7 @@ static int ext3_ordered_writepage(struct
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;
+out:
 	return ret;
 
 out_fail:
@@ -1337,10 +1363,13 @@ static int ext3_writeback_writepage(stru
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
-	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_fail;
+	if (!PageMappedToDisk(page)) {
+		handle = ext3_journal_start(inode,
+				ext3_writepage_trans_blocks(inode));
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_fail;
+		}
 	}
 
 	if (test_opt(inode->i_sb, NOBH))
@@ -1348,9 +1377,11 @@ static int ext3_writeback_writepage(stru
 	else
 		ret = block_write_full_page(page, ext3_get_block, wbc);
 
-	err = ext3_journal_stop(handle);
-	if (!ret)
-		ret = err;
+	if (handle) {
+		err = ext3_journal_stop(handle);
+		if (!ret)
+			ret = err;
+	}
 	return ret;
 
 out_fail:


