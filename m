Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSGLUKw>; Fri, 12 Jul 2002 16:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318010AbSGLUKv>; Fri, 12 Jul 2002 16:10:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1543 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318008AbSGLUK0>;
	Fri, 12 Jul 2002 16:10:26 -0400
Message-ID: <3D2F37E6.1D6B9EE@zip.com.au>
Date: Fri, 12 Jul 2002 13:11:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alec Smith <alec@shadowstar.net>
CC: Mark Hahn <hahn@physics.mcmaster.ca>, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
References: <Pine.LNX.4.33.0207121337500.8654-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.44.0207121503030.9318-100000@bugs.home.shadowstar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alec Smith wrote:
> 
> ...
> kernel BUG at transaction.c:611!

Are you using data=journal there?

This is a sync with the current ext3 dev tree.  SHuld fix
it up.


--- ext3-linus_tree/fs/buffer.c	Wed Jun  5 00:18:36 2002
+++ ext3-1_0-branch/fs/buffer.c	Mon May 13 00:01:14 2002
@@ -1746,9 +1746,14 @@
 	}
 
 	/* Stage 3: start the IO */
-	for (i = 0; i < nr; i++)
-		submit_bh(READ, arr[i]);
-
+	for (i = 0; i < nr; i++) {
+		struct buffer_head * bh = arr[i];
+		if (buffer_uptodate(bh))
+			end_buffer_io_async(bh, 1);
+		else
+			submit_bh(READ, bh);
+	}
+	
 	return 0;
 }
 
--- ext3-linus_tree/fs/ext3/file.c	Wed Jun  5 00:18:36 2002
+++ ext3-1_0-branch/fs/ext3/file.c	Wed Jun  5 00:17:25 2002
@@ -61,19 +61,52 @@
 static ssize_t
 ext3_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
+	int ret, err;
 	struct inode *inode = file->f_dentry->d_inode;
 
-	/*
-	 * Nasty: if the file is subject to synchronous writes then we need
-	 * to force generic_osync_inode() to call ext3_write_inode().
-	 * We do that by marking the inode dirty.  This adds much more
-	 * computational expense than we need, but we're going to sync
-	 * anyway.
-	 */
-	if (IS_SYNC(inode) || (file->f_flags & O_SYNC))
-		mark_inode_dirty(inode);
+	ret = generic_file_write(file, buf, count, ppos);
 
-	return generic_file_write(file, buf, count, ppos);
+	/* Skip file flushing code if there was an error, or if nothing
+	   was written. */
+	if (ret <= 0)
+		return ret;
+	
+	/* If the inode is IS_SYNC, or is O_SYNC and we are doing
+           data-journaling, then we need to make sure that we force the
+           transaction to disk to keep all metadata uptodate
+           synchronously. */
+
+	if (file->f_flags & O_SYNC) {
+		/* If we are non-data-journaled, then the dirty data has
+                   already been flushed to backing store by
+                   generic_osync_inode, and the inode has been flushed
+                   too if there have been any modifications other than
+                   mere timestamp updates.
+		   
+		   Open question --- do we care about flushing
+		   timestamps too if the inode is IS_SYNC? */
+		if (!ext3_should_journal_data(inode))
+			return ret;
+
+		goto force_commit;
+	}
+
+	/* So we know that there has been no forced data flush.  If the
+           inode is marked IS_SYNC, we need to force one ourselves. */
+	if (!IS_SYNC(inode))
+		return ret;
+	
+	/* Open question #2 --- should we force data to disk here too?
+           If we don't, the only impact is that data=writeback
+           filesystems won't flush data to disk automatically on
+           IS_SYNC, only metadata (but historically, that is what ext2
+           has done.) */
+	
+force_commit:
+	err = ext3_force_commit(inode->i_sb);
+	if (err) 
+		return err;
+	return ret;
 }
 
 struct file_operations ext3_file_operations = {
--- ext3-linus_tree/fs/ext3/fsync.c	Wed Jun  5 00:18:36 2002
+++ ext3-1_0-branch/fs/ext3/fsync.c	Mon May 13 00:01:14 2002
@@ -62,7 +62,12 @@
 	 * we'll end up waiting on them in commit.
 	 */
 	ret = fsync_inode_buffers(inode);
-	ret |= fsync_inode_data_buffers(inode);
+
+	/* In writeback node, we need to force out data buffers too.  In
+	 * the other modes, ext3_force_commit takes care of forcing out
+	 * just the right data blocks. */
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
+		ret |= fsync_inode_data_buffers(inode);
 
 	ext3_force_commit(inode->i_sb);
 
--- ext3-linus_tree/fs/ext3/ialloc.c	Wed Jun  5 00:18:36 2002
+++ ext3-1_0-branch/fs/ext3/ialloc.c	Mon May 13 00:01:14 2002
@@ -392,7 +392,7 @@
 
 	err = -ENOSPC;
 	if (!gdp)
-		goto fail;
+		goto out;
 
 	err = -EIO;
 	bitmap_nr = load_inode_bitmap (sb, i);
@@ -523,9 +523,10 @@
 	return inode;
 
 fail:
+	ext3_std_error(sb, err);
+out:
 	unlock_super(sb);
 	iput(inode);
-	ext3_std_error(sb, err);
 	return ERR_PTR(err);
 }
 
--- ext3-linus_tree/fs/ext3/inode.c	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/fs/ext3/inode.c	Wed Jun  5 00:17:25 2002
@@ -412,6 +412,7 @@
 	return NULL;
 
 changed:
+	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
 failure:
@@ -948,11 +949,13 @@
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
@@ -970,7 +973,7 @@
 				*partial = 1;
 			continue;
 		}
-		err = (*fn)(handle, bh);
+		err = (*fn)(handle, inode, bh);
 		if (!ret)
 			ret = err;
 	}
@@ -1003,7 +1006,7 @@
  * write.  
  */
 
-static int do_journal_get_write_access(handle_t *handle, 
+static int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				       struct buffer_head *bh)
 {
 	return ext3_journal_get_write_access(handle, bh);
@@ -1029,7 +1032,7 @@
 		goto prepare_write_failed;
 
 	if (ext3_should_journal_data(inode)) {
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, inode, page->buffers,
 				from, to, NULL, do_journal_get_write_access);
 		if (ret) {
 			/*
@@ -1050,24 +1053,32 @@
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
@@ -1102,7 +1113,7 @@
 		int partial = 0;
 		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
-		ret = walk_page_buffers(handle, page->buffers,
+		ret = walk_page_buffers(handle, inode, page->buffers,
 			from, to, &partial, commit_write_fn);
 		if (!partial)
 			SetPageUptodate(page);
@@ -1112,7 +1123,7 @@
 		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
 	} else {
 		if (ext3_should_order_data(inode)) {
-			ret = walk_page_buffers(handle, page->buffers,
+			ret = walk_page_buffers(handle, inode, page->buffers,
 				from, to, NULL, journal_dirty_sync_data);
 		}
 		/* Be careful here if generic_commit_write becomes a
@@ -1194,7 +1205,8 @@
 	return generic_block_bmap(mapping,block,ext3_get_block);
 }
 
-static int bget_one(handle_t *handle, struct buffer_head *bh)
+static int bget_one(handle_t *handle, struct inode *inode, 
+		    struct buffer_head *bh)
 {
 	atomic_inc(&bh->b_count);
 	return 0;
@@ -1293,7 +1305,7 @@
 			create_empty_buffers(page,
 				inode->i_dev, inode->i_sb->s_blocksize);
 		page_buffers = page->buffers;
-		walk_page_buffers(handle, page_buffers, 0,
+		walk_page_buffers(handle, inode, page_buffers, 0,
 				PAGE_CACHE_SIZE, NULL, bget_one);
 	}
 
@@ -1311,7 +1323,7 @@
 
 	/* And attach them to the current transaction */
 	if (order_data) {
-		err = walk_page_buffers(handle, page_buffers,
+		err = walk_page_buffers(handle, inode, page_buffers,
 			0, PAGE_CACHE_SIZE, NULL, journal_dirty_async_data);
 		if (!ret)
 			ret = err;
--- ext3-linus_tree/fs/ext3/namei.c	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/fs/ext3/namei.c	Wed Jun  5 00:17:25 2002
@@ -354,8 +354,8 @@
 			 */
 			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 			dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
-			ext3_mark_inode_dirty(handle, dir);
 			dir->i_version = ++event;
+			ext3_mark_inode_dirty(handle, dir);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 			ext3_journal_dirty_metadata(handle, bh);
 			brelse(bh);
@@ -464,8 +464,8 @@
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
 		inode->i_mapping->a_ops = &ext3_aops;
-		ext3_mark_inode_dirty(handle, inode);
 		err = ext3_add_nondir(handle, dentry, inode);
+		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -489,8 +489,8 @@
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
-		ext3_mark_inode_dirty(handle, inode);
 		err = ext3_add_nondir(handle, dentry, inode);
+		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -933,8 +933,8 @@
 		inode->i_size = l-1;
 	}
 	inode->u.ext3_i.i_disksize = inode->i_size;
-	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_nondir(handle, dentry, inode);
+	ext3_mark_inode_dirty(handle, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -970,8 +970,8 @@
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
 
-	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_nondir(handle, dentry, inode);
+	ext3_mark_inode_dirty(handle, inode);
 	ext3_journal_stop(handle, dir);
 	return err;
 }
--- ext3-linus_tree/fs/ext3/super.c	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/fs/ext3/super.c	Mon May 13 00:01:15 2002
@@ -1589,8 +1589,10 @@
 		journal_t *journal = EXT3_SB(sb)->s_journal;
 
 		/* Now we set up the journal barrier. */
+		unlock_super(sb);
 		journal_lock_updates(journal);
 		journal_flush(journal);
+		lock_super(sb);
 
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		EXT3_CLEAR_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
--- ext3-linus_tree/fs/jbd/journal.c	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/fs/jbd/journal.c	Mon May 13 00:01:15 2002
@@ -1488,6 +1488,49 @@
 	unlock_journal(journal);
 }
 
+
+/*
+ * Report any unexpected dirty buffers which turn up.  Normally those
+ * indicate an error, but they can occur if the user is running (say)
+ * tune2fs to modify the live filesystem, so we need the option of
+ * continuing as gracefully as possible.  #
+ *
+ * The caller should already hold the journal lock and
+ * journal_datalist_lock spinlock: most callers will need those anyway
+ * in order to probe the buffer's journaling state safely.
+ */
+void __jbd_unexpected_dirty_buffer(char *function, int line, 
+				 struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+	int jlist;
+	
+	if (buffer_dirty(bh)) {
+		printk ("%sUnexpected dirty buffer encountered at "
+			"%s:%d (%s blocknr %lu)\n",
+			KERN_WARNING, function, line,
+			kdevname(bh->b_dev), bh->b_blocknr);
+#ifdef JBD_PARANOID_WRITES
+		J_ASSERT (!buffer_dirty(bh));
+#endif	
+		
+		/* If this buffer is one which might reasonably be dirty
+		 * --- ie. data, or not part of this journal --- then
+		 * we're OK to leave it alone, but otherwise we need to
+		 * move the dirty bit to the journal's own internal
+		 * JBDDirty bit. */
+		jlist = jh->b_jlist;
+		
+		if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+		    jlist == BJ_Shadow || jlist == BJ_Forget) {
+			if (atomic_set_buffer_clean(jh2bh(jh))) {
+				set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
+			}
+		}
+	}
+}
+
+
 int journal_blocks_per_page(struct inode *inode)
 {
 	return 1 << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
--- ext3-linus_tree/fs/jbd/transaction.c	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/fs/jbd/transaction.c	Wed Jun  5 00:17:26 2002
@@ -539,76 +539,67 @@
 static int
 do_get_write_access(handle_t *handle, struct journal_head *jh, int force_copy) 
 {
+	struct buffer_head *bh;
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	int error;
 	char *frozen_buffer = NULL;
 	int need_copy = 0;
-
+	int locked;
+	
 	jbd_debug(5, "buffer_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
+	bh = jh2bh(jh);
+
 	/* @@@ Need to check for errors here at some point. */
 
 	/*
-	 * AKPM: neither bdflush nor kupdate run with the BKL.   There's
-	 * nothing we can do to prevent them from starting writeout of a
-	 * BUF_DIRTY buffer at any time.  And checkpointing buffers are on
-	 * BUF_DIRTY.  So.  We no longer assert that the buffer is unlocked.
-	 *
-	 * However.  It is very wrong for us to allow ext3 to start directly
-	 * altering the ->b_data of buffers which may at that very time be
-	 * undergoing writeout to the client filesystem.  This can leave
-	 * the filesystem in an inconsistent, transient state if we crash.
-	 * So what we do is to steal the buffer if it is in checkpoint
-	 * mode and dirty.  The journal lock will keep out checkpoint-mode
-	 * state transitions within journal_remove_checkpoint() and the buffer
-	 * is locked to keep bdflush/kupdate/whoever away from it as well.
-	 *
 	 * AKPM: we have replaced all the lock_journal_bh_wait() stuff with a
 	 * simple lock_journal().  This code here will care for locked buffers.
 	 */
-	/*
-	 * The buffer_locked() || buffer_dirty() tests here are simply an
-	 * optimisation tweak.  If anyone else in the system decides to
-	 * lock this buffer later on, we'll blow up.  There doesn't seem
-	 * to be a good reason why they should do this.
-	 */
-	if (jh->b_cp_transaction &&
-	    (buffer_locked(jh2bh(jh)) || buffer_dirty(jh2bh(jh)))) {
+	locked = test_and_set_bit(BH_Lock, &bh->b_state);
+	if (locked) {
+		/* We can't reliably test the buffer state if we found
+		 * it already locked, so just wait for the lock and
+		 * retry. */
 		unlock_journal(journal);
-		lock_buffer(jh2bh(jh));
-		spin_lock(&journal_datalist_lock);
-		if (jh->b_cp_transaction && buffer_dirty(jh2bh(jh))) {
-			/* OK, we need to steal it */
-			JBUFFER_TRACE(jh, "stealing from checkpoint mode");
-			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
-			J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
-
-			J_ASSERT(handle->h_buffer_credits > 0);
-			handle->h_buffer_credits--;
-
-			/* This will clear BH_Dirty and set BH_JBDDirty. */
-			JBUFFER_TRACE(jh, "file as BJ_Reserved");
-			__journal_file_buffer(jh, transaction, BJ_Reserved);
-
-			/* And pull it off BUF_DIRTY, onto BUF_CLEAN */
-			refile_buffer(jh2bh(jh));
+		__wait_on_buffer(bh);
+		lock_journal(journal);
+		goto repeat;
+	}
+	
+	/* We now hold the buffer lock so it is safe to query the buffer
+	 * state.  Is the buffer dirty? 
+	 * 
+	 * If so, there are two possibilities.  The buffer may be
+	 * non-journaled, and undergoing a quite legitimate writeback.
+	 * Otherwise, it is journaled, and we don't expect dirty buffers
+	 * in that state (the buffers should be marked JBD_Dirty
+	 * instead.)  So either the IO is being done under our own
+	 * control and this is a bug, or it's a third party IO such as
+	 * dump(8) (which may leave the buffer scheduled for read ---
+	 * ie. locked but not dirty) or tune2fs (which may actually have
+	 * the buffer dirtied, ugh.)  */
 
-			/*
-			 * The buffer is now hidden from bdflush.   It is
-			 * metadata against the current transaction.
-			 */
-			JBUFFER_TRACE(jh, "steal from cp mode is complete");
+	if (buffer_dirty(bh)) {
+		spin_lock(&journal_datalist_lock);
+		/* First question: is this buffer already part of the
+		 * current transaction or the existing committing
+		 * transaction? */
+		if (jh->b_transaction) {
+			J_ASSERT_JH(jh, jh->b_transaction == transaction || 
+				    jh->b_transaction == journal->j_committing_transaction);
+			if (jh->b_next_transaction)
+				J_ASSERT_JH(jh, jh->b_next_transaction == transaction);
+			JBUFFER_TRACE(jh, "Unexpected dirty buffer");
+			jbd_unexpected_dirty_buffer(jh);
 		}
 		spin_unlock(&journal_datalist_lock);
-		unlock_buffer(jh2bh(jh));
-		lock_journal(journal);
-		goto repeat;
 	}
 
-	J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));
+	unlock_buffer(bh);
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) 
@@ -1912,8 +1903,29 @@
 	unlock_journal(journal);
 
 	if (!offset) {
-		if (!may_free || !try_to_free_buffers(page, 0))
+		if (!may_free || !try_to_free_buffers(page, 0)) {
+			if (!offset) {
+				/* We are still using the page, but only
+                                   because a transaction is pinning the
+                                   page.  Once it commits, we want to
+                                   encourage the page to be reaped as
+                                   quickly as possible. */
+				ClearPageReferenced(page);
+
+#if 0
+				/* Ugh, this is not exactly portable
+				   between VMs: we need a modular
+				   solution for this some day.. */
+				if (PageActive(page)) {
+					spin_lock(&pagemap_lru_lock);
+					del_page_from_active_list(page);
+					add_page_to_inactive_list(page);
+					spin_unlock(&pagemap_lru_lock);
+				}
+#endif
+			}
 			return 0;
+		}
 		J_ASSERT(page->buffers == NULL);
 	}
 	return 1;
@@ -1926,6 +1938,7 @@
 			transaction_t *transaction, int jlist)
 {
 	struct journal_head **list = 0;
+	int was_dirty = 0;
 
 	assert_spin_locked(&journal_datalist_lock);
 	
@@ -1936,13 +1949,24 @@
 	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_transaction == 0);
 
-	if (jh->b_transaction) {
-		if (jh->b_jlist == jlist)
-			return;
+	if (jh->b_transaction && jh->b_jlist == jlist)
+		return;
+	
+	/* The following list of buffer states needs to be consistent
+	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
+	 * state. */
+
+	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+	    jlist == BJ_Shadow || jlist == BJ_Forget) {
+		if (atomic_set_buffer_clean(jh2bh(jh)) ||
+		    test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state))
+			was_dirty = 1;
+	}
+
+	if (jh->b_transaction)
 		__journal_unfile_buffer(jh);
-	} else {
+	else
 		jh->b_transaction = transaction;
-	}
 
 	switch (jlist) {
 	case BJ_None:
@@ -1979,12 +2003,8 @@
 	__blist_add_buffer(list, jh);
 	jh->b_jlist = jlist;
 
-	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
-	    jlist == BJ_Shadow || jlist == BJ_Forget) {
-		if (atomic_set_buffer_clean(jh2bh(jh))) {
-			set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
-		}
-	}
+	if (was_dirty)
+		set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
 }
 
 void journal_file_buffer(struct journal_head *jh,
--- ext3-linus_tree/include/linux/ext3_fs.h	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/include/linux/ext3_fs.h	Wed Jun  5 00:17:27 2002
@@ -36,8 +36,8 @@
 /*
  * The second extended file system version
  */
-#define EXT3FS_DATE		"10 Jan 2002"
-#define EXT3FS_VERSION		"2.4-0.9.17"
+#define EXT3FS_DATE		"14 May 2002"
+#define EXT3FS_VERSION		"2.4-0.9.18"
 
 /*
  * Debug code
--- ext3-linus_tree/include/linux/jbd.h	Wed Jun  5 00:18:37 2002
+++ ext3-1_0-branch/include/linux/jbd.h	Mon May 13 00:01:15 2002
@@ -32,6 +32,14 @@
 
 #define journal_oom_retry 1
 
+/*
+ * Define JBD_PARANOID_WRITES to cause a kernel BUG() check if ext3
+ * finds a buffer unexpectedly dirty.  This is useful for debugging, but
+ * can cause spurious kernel panics if there are applications such as
+ * tune2fs modifying our buffer_heads behind our backs.
+ */
+#undef JBD_PARANOID_WRITES
+
 #ifdef CONFIG_JBD_DEBUG
 /*
  * Define JBD_EXPENSIVE_CHECKING to enable more expensive internal
@@ -730,6 +738,10 @@
 	schedule();						      \
 } while (1)
 
+extern void __jbd_unexpected_dirty_buffer(char *, int, struct journal_head *);
+#define jbd_unexpected_dirty_buffer(jh) \
+	__jbd_unexpected_dirty_buffer(__FUNCTION__, __LINE__, (jh))
+	
 /*
  * is_journal_abort
  *
