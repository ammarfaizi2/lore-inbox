Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSFUHyF>; Fri, 21 Jun 2002 03:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFUHyE>; Fri, 21 Jun 2002 03:54:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316437AbSFUHyC>;
	Fri, 21 Jun 2002 03:54:02 -0400
Message-ID: <3D12DCB4.872269F6@zip.com.au>
Date: Fri, 21 Jun 2002 00:58:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
CC: mgross@unix-os.sc.intel.com, "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Griffiths, Richard A" wrote:
> 
> I should have mentioned the throughput we saw on 4 adapters 6 drives was
> 126KB/s.  The max theoretical bus bandwith is 640MB/s.

I hope that was 128MB/s?

Please try the below patch (againt 2.4.19-pre10).  It halves the lock
contention, and it does that by making the fs twice as efficient, so
that's a bonus.

I wouldn't be surprised if it made no difference.  I'm not seeing
much difference between ext2 and ext3 here.

If you have time, please test ext2 and/or reiserfs and/or ext3
in writeback mode.

And please tell us some more details regarding the performance bottleneck.
I assume that you mean that the IO rate per disk slows as more
disks are added to an adapter?  Or does the total throughput through
the adapter fall as more disks are added?

Thanks.




--- 2.4.19-pre10/fs/ext3/inode.c~ext3-speedup-1	Fri Jun 21 00:28:59 2002
+++ 2.4.19-pre10-akpm/fs/ext3/inode.c	Fri Jun 21 00:28:59 2002
@@ -1016,21 +1016,20 @@ static int ext3_prepare_write(struct fil
 	int ret, needed_blocks = ext3_writepage_trans_blocks(inode);
 	handle_t *handle;
 
-	lock_kernel();
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	unlock_kernel();
 	ret = block_prepare_write(page, from, to, ext3_get_block);
-	lock_kernel();
 	if (ret != 0)
 		goto prepare_write_failed;
 
 	if (ext3_should_journal_data(inode)) {
+		lock_kernel();
 		ret = walk_page_buffers(handle, page->buffers,
 				from, to, NULL, do_journal_get_write_access);
+		unlock_kernel();
 		if (ret) {
 			/*
 			 * We're going to fail this prepare_write(),
@@ -1043,10 +1042,12 @@ static int ext3_prepare_write(struct fil
 		}
 	}
 prepare_write_failed:
-	if (ret)
+	if (ret) {
+		lock_kernel();
 		ext3_journal_stop(handle, inode);
+		unlock_kernel();
+	}
 out:
-	unlock_kernel();
 	return ret;
 }
 
@@ -1094,7 +1095,6 @@ static int ext3_commit_write(struct file
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 
-	lock_kernel();
 	if (ext3_should_journal_data(inode)) {
 		/*
 		 * Here we duplicate the generic_commit_write() functionality
@@ -1102,22 +1102,43 @@ static int ext3_commit_write(struct file
 		int partial = 0;
 		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
+		lock_kernel();
 		ret = walk_page_buffers(handle, page->buffers,
 			from, to, &partial, commit_write_fn);
+		unlock_kernel();
 		if (!partial)
 			SetPageUptodate(page);
 		kunmap(page);
 		if (pos > inode->i_size)
 			inode->i_size = pos;
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
+		if (inode->i_size > inode->u.ext3_i.i_disksize) {
+			inode->u.ext3_i.i_disksize = inode->i_size;
+			lock_kernel();
+			ret2 = ext3_mark_inode_dirty(handle, inode);
+			unlock_kernel();
+			if (!ret) 
+				ret = ret2;
+		}
 	} else {
 		if (ext3_should_order_data(inode)) {
+			lock_kernel();
 			ret = walk_page_buffers(handle, page->buffers,
 				from, to, NULL, journal_dirty_sync_data);
+			unlock_kernel();
 		}
 		/* Be careful here if generic_commit_write becomes a
 		 * required invocation after block_prepare_write. */
 		if (ret == 0) {
+			/*
+			 * generic_commit_write() will run mark_inode_dirty()
+			 * if i_size changes.  So let's piggyback the
+			 * i_disksize mark_inode_dirty into that.
+			 */
+			loff_t new_i_size =
+				((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+			if (new_i_size > EXT3_I(inode)->i_disksize)
+				EXT3_I(inode)->i_disksize = new_i_size;
 			ret = generic_commit_write(file, page, from, to);
 		} else {
 			/*
@@ -1129,12 +1150,7 @@ static int ext3_commit_write(struct file
 			kunmap(page);
 		}
 	}
-	if (inode->i_size > inode->u.ext3_i.i_disksize) {
-		inode->u.ext3_i.i_disksize = inode->i_size;
-		ret2 = ext3_mark_inode_dirty(handle, inode);
-		if (!ret) 
-			ret = ret2;
-	}
+	lock_kernel();
 	ret2 = ext3_journal_stop(handle, inode);
 	unlock_kernel();
 	if (!ret)
@@ -2165,9 +2181,11 @@ bad_inode:
 /*
  * Post the struct inode info into an on-disk inode location in the
  * buffer-cache.  This gobbles the caller's reference to the
- * buffer_head in the inode location struct.  
+ * buffer_head in the inode location struct.
+ *
+ * On entry, the caller *must* have journal write access to the inode's
+ * backing block, at iloc->bh.
  */
-
 static int ext3_do_update_inode(handle_t *handle, 
 				struct inode *inode, 
 				struct ext3_iloc *iloc)
@@ -2176,12 +2194,6 @@ static int ext3_do_update_inode(handle_t
 	struct buffer_head *bh = iloc->bh;
 	int err = 0, rc, block;
 
-	if (handle) {
-		BUFFER_TRACE(bh, "get_write_access");
-		err = ext3_journal_get_write_access(handle, bh);
-		if (err)
-			goto out_brelse;
-	}
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(inode->i_uid));
--- 2.4.19-pre10/mm/filemap.c~ext3-speedup-1	Fri Jun 21 00:28:59 2002
+++ 2.4.19-pre10-akpm/mm/filemap.c	Fri Jun 21 00:28:59 2002
@@ -2924,6 +2924,7 @@ generic_file_write(struct file *file,con
 	long		status = 0;
 	int		err;
 	unsigned	bytes;
+	time_t		time_now;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -3026,8 +3027,12 @@ generic_file_write(struct file *file,con
 		goto out;
 
 	remove_suid(inode);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(inode);
+	time_now = CURRENT_TIME;
+	if (inode->i_ctime != time_now || inode->i_mtime != time_now) {
+		inode->i_ctime = time_now;
+		inode->i_mtime = time_now;
+		mark_inode_dirty_sync(inode);
+	}
 
 	if (file->f_flags & O_DIRECT)
 		goto o_direct;
--- 2.4.19-pre10/fs/jbd/transaction.c~ext3-speedup-1	Fri Jun 21 00:28:59 2002
+++ 2.4.19-pre10-akpm/fs/jbd/transaction.c	Fri Jun 21 00:28:59 2002
@@ -237,7 +237,9 @@ handle_t *journal_start(journal_t *journ
 	handle->h_ref = 1;
 	current->journal_info = handle;
 
+	lock_kernel();
 	err = start_this_handle(journal, handle);
+	unlock_kernel();
 	if (err < 0) {
 		kfree(handle);
 		current->journal_info = NULL;
@@ -1388,8 +1390,10 @@ int journal_stop(handle_t *handle)
 	transaction->t_outstanding_credits -= handle->h_buffer_credits;
 	transaction->t_updates--;
 	if (!transaction->t_updates) {
-		wake_up(&journal->j_wait_updates);
-		if (journal->j_barrier_count)
+		if (waitqueue_active(&journal->j_wait_updates))
+			wake_up(&journal->j_wait_updates);
+		if (journal->j_barrier_count &&
+			waitqueue_active(&journal->j_wait_transaction_locked))
 			wake_up(&journal->j_wait_transaction_locked);
 	}
 

-
