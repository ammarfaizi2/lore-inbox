Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWCQVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWCQVan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWCQVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:30:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:56449 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932069AbWCQVam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:30:42 -0500
Subject: Re: ext3_ordered_writepage() questions
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Jan Kara <jack@suse.cz>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1142615110.3641.8.camel@orbit.scot.redhat.com>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316210424.GD29275@thunk.org>
	 <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
	 <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
	 <20060317005418.GY30801@schatzie.adilger.int>
	 <1142615110.3641.8.camel@orbit.scot.redhat.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 13:32:21 -0800
Message-Id: <1142631141.15257.40.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Now that we got your attention, I am wondering whats your opinion on
this ?

I have a patch which eliminates adding buffers to the journal, if
we are doing just re-write of the disk block. In theory, it should
be fine - but it does change the current behavior for order mode
writes. I guess, current code adds the buffers to the journal, so
any metadata updates to any file in the filesystem happen in the 
journal - guarantees our buffers to be flushed out before that
transaction completes.

My patch *breaks* that guarantee. But provides significant improvement
for re-write case. My micro benchmark shows:

     2.6.16-rc6      2.6.16-rc6+patch
real  0m6.606s        0m3.705s 
user  0m0.124s        0m0.108s
sys   0m6.456s        0m3.600s


In real world, does this ordering guarantee matter ? Waiting for your
advise.

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
+++ linux-2.6.16-rc6/fs/buffer.c	2006-03-16 08:22:37.000000000 -0800
@@ -2029,6 +2029,7 @@ static int __block_commit_write(struct i
 	int partial = 0;
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
+	int fullymapped = 1;
 
 	blocksize = 1 << inode->i_blkbits;
 
@@ -2043,6 +2044,8 @@ static int __block_commit_write(struct i
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
+		if (!buffer_mapped(bh))
+			fullymapped = 0;
 	}
 
 	/*
@@ -2053,6 +2056,9 @@ static int __block_commit_write(struct i
 	 */
 	if (!partial)
 		SetPageUptodate(page);
+
+	if (fullymapped)
+		SetPageMappedToDisk(page);
 	return 0;
 }
 
Index: linux-2.6.16-rc6/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/ext3/inode.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/fs/ext3/inode.c	2006-03-15 13:30:04.000000000 -0800
@@ -999,6 +999,12 @@ static int ext3_prepare_write(struct fil
 	handle_t *handle;
 	int retries = 0;
 
+	/*
+ 	 * If the page is already mapped to disk and we are not
+	 * journalling the data - there is nothing to do.
+	 */
+	if (PageMappedToDisk(page) && !ext3_should_journal_data(inode))
+		return 0;
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
@@ -1059,8 +1065,14 @@ static int ext3_ordered_commit_write(str
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
@@ -1075,9 +1087,11 @@ static int ext3_ordered_commit_write(str
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
 
@@ -1098,9 +1112,11 @@ static int ext3_writeback_commit_write(s
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
 
@@ -1278,6 +1294,14 @@ static int ext3_ordered_writepage(struct
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
@@ -1318,6 +1342,7 @@ static int ext3_ordered_writepage(struct
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;
+out:
 	return ret;
 
 out_fail:
@@ -1337,10 +1362,13 @@ static int ext3_writeback_writepage(stru
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
@@ -1348,9 +1376,11 @@ static int ext3_writeback_writepage(stru
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


