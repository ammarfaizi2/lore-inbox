Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275736AbRJBCcP>; Mon, 1 Oct 2001 22:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275738AbRJBCcF>; Mon, 1 Oct 2001 22:32:05 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:33584 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S275736AbRJBCbn>; Mon, 1 Oct 2001 22:31:43 -0400
Subject: ext3 0.9.10 for Alan's tree
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, sct@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-X24+Onm+VZF76IPc4T0I"
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 01 Oct 2001 22:31:52 -0400
Message-Id: <1001989916.2780.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X24+Onm+VZF76IPc4T0I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Stephen, Andrew:

Alan has said recently that he would merge a newer ext3 soon as the
maintainer sends him such a patch, but no sooner.  That was in response
to a few users asking why ext3 was "outdated" in his tree.

Attached is a patch against 2.4.10-ac3 of ext-0.9.9 + Ted's directory
speedup.  Bringing 0.9.10 inline with Alan will take some VM work, but
this is a start.

I've been using it for some time, and I am sure you have proved it
stable.  Can it be passed on to him?

Thanks,

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

--=-X24+Onm+VZF76IPc4T0I
Content-Type: text/x-patch
Content-Disposition: attachment; filename=patch-rml-2.4.10-ac3-ext3-0.9.9-with-dir-speedup-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.4.10-ac3/fs/ext3/inode.c linux/fs/ext3/inode.c
--- linux-2.4.10-ac3/fs/ext3/inode.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/ext3/inode.c	Sun Sep 30 22:20:01 2001
@@ -49,9 +49,9 @@
  * still needs to be revoked.
  */
 
-static void ext3_forget(handle_t *handle, int is_metadata,
-			struct inode *inode, struct buffer_head *bh,
-			int blocknr)
+static int ext3_forget(handle_t *handle, int is_metadata,
+		       struct inode *inode, struct buffer_head *bh,
+		       int blocknr)
 {
 	int err;
 
@@ -73,7 +73,7 @@
 			BUFFER_TRACE(bh, "call journal_forget");
 			ext3_journal_forget(handle, bh);
 		}
-		return;
+		return 0;
 	}
 
 	/*
@@ -81,11 +81,11 @@
 	 */
 	BUFFER_TRACE(bh, "call ext3_journal_revoke");
 	err = ext3_journal_revoke(handle, blocknr, bh);
-	if (err == -ENOMEM)
+	if (err)
 		ext3_abort(inode->i_sb, __FUNCTION__,
-			   "out of memory during revoke");
-	J_ASSERT (!err);
+			   "error %d when attempting revoke", err);
 	BUFFER_TRACE(bh, "exit");
+	return err;
 }
 
 /* 
@@ -102,11 +102,18 @@
 static handle_t *start_transaction(struct inode *inode) 
 {
 	long needed;
+	handle_t *result;
+	
 	needed = inode->i_blocks;
 	if (needed > EXT3_MAX_TRANS_DATA) 
 		needed = EXT3_MAX_TRANS_DATA;
-
-	return ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS + needed);
+	
+	result = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS + needed);
+	if (!IS_ERR(result))
+		return result;
+	
+	ext3_std_error(inode->i_sb, PTR_ERR(result));
+	return result;
 }
 
 /*
@@ -157,7 +164,7 @@
 void ext3_delete_inode (struct inode * inode)
 {
 	handle_t *handle;
-
+	
 	if (is_bad_inode(inode) ||
 	    inode->i_ino == EXT3_ACL_IDX_INO ||
 	    inode->i_ino == EXT3_ACL_DATA_INO)
@@ -165,9 +172,21 @@
 
 	lock_kernel();
 	handle = start_transaction(inode);
-	/* @@@ AKPM: how to report this?  Mark as bad inode? */
-	if (IS_ERR(handle))
-		goto out;
+	if (IS_ERR(handle)) {
+		/* If we're going to skip the ext3_orphan_del, then at
+		 * least we need to keep the orphan linked list in
+		 * memory intact. */
+		jbd_debug(4, "remove inode %ld from in-core orphan list\n", 
+			  inode->i_ino);
+		
+		list_del(&inode->u.ext3_i.i_orphan);
+		INIT_LIST_HEAD(&inode->u.ext3_i.i_orphan);
+
+		ext3_std_error(inode->i_sb, PTR_ERR(handle));
+		unlock_kernel();
+		goto no_delete;
+	}
+	
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
 	inode->i_size = 0;
@@ -183,10 +202,20 @@
 	 */
 	ext3_orphan_del(handle, inode);
 	inode->u.ext3_i.i_dtime	= CURRENT_TIME;
-	ext3_mark_inode_dirty(handle, inode);
-	ext3_free_inode(handle, inode);
+
+	/* 
+	 * One subtle ordering requirement: if anything has gone wrong
+	 * (transaction abort, IO errors, whatever), then we can still
+	 * do these next steps (the fs will already have been marked as
+	 * having errors), but we can't free the inode if the mark_dirty
+	 * fails.  
+	 */
+	if (ext3_mark_inode_dirty(handle, inode))
+		/* If that failed, just do the required in-core inode clear. */
+		clear_inode(inode);
+	else
+		ext3_free_inode(handle, inode);
 	ext3_journal_stop(handle, inode);
-out:
 	unlock_kernel();
 	return;
 no_delete:
@@ -534,6 +563,7 @@
 			 * parent to disk.  
 			 */
 			bh = getblk(inode->i_dev, parent, blocksize);
+			branch[n].bh = bh;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
 			err = ext3_journal_get_create_access(handle, bh);
@@ -544,7 +574,6 @@
 			}
 
 			memset(bh->b_data, 0, blocksize);
-			branch[n].bh = bh;
 			branch[n].p = (u32*) bh->b_data + offsets[n];
 			*branch[n].p = branch[n].key;
 			BUFFER_TRACE(bh, "marking uptodate");
@@ -555,8 +584,11 @@
 			err = ext3_journal_dirty_metadata(handle, bh);
 			if (err)
 				break;
+			
 			parent = nr;
 		}
+		if (IS_SYNC(inode))
+			handle->h_sync = 1;
 	}
 	if (n == num)
 		return 0;
@@ -564,10 +596,9 @@
 	/* Allocation failed, free what we already allocated */
 	for (i = 1; i < keys; i++) {
 		BUFFER_TRACE(branch[i].bh, "call journal_forget");
-		ext3_forget(handle, 1, inode,
-				branch[i].bh, branch[i].bh->b_blocknr);
+		ext3_journal_forget(handle, branch[i].bh);
 	}
-	for (i = 0; i < n; i++)
+	for (i = 0; i < keys; i++)
 		ext3_free_blocks(handle, inode, le32_to_cpu(branch[i].key), 1);
 	return err;
 }
@@ -604,7 +635,7 @@
 		BUFFER_TRACE(where->bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, where->bh);
 		if (err)
-			return err;
+			goto err_out;
 	}
 	/* Verify that place we are splicing to is still there and vacant */
 
@@ -645,6 +676,8 @@
 		jbd_debug(5, "splicing indirect only\n");
 		BUFFER_TRACE(where->bh, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, where->bh);
+		if (err) 
+			goto err_out;
 	} else {
 		/*
 		 * OK, we spliced it into the inode itself on a direct block.
@@ -660,13 +693,21 @@
 	 * transaction then we explode nastily.  Test this code path.
 	 */
 	jbd_debug(1, "the chain changed: try again\n");
+	err = -EAGAIN;
+	
+err_out:
 	for (i = 1; i < num; i++) {
 		BUFFER_TRACE(where[i].bh, "call journal_forget");
 		ext3_journal_forget(handle, where[i].bh);
 	}
-	for (i = 0; i < num; i++)
-		ext3_free_blocks(handle, inode, le32_to_cpu(where[i].key), 1);
-	return -EAGAIN;
+	/* For the normal collision cleanup case, we free up the blocks.
+	 * On genuine filesystem errors we don't even think about doing
+	 * that. */
+	if (err == -EAGAIN)
+		for (i = 0; i < num; i++)
+			ext3_free_blocks(handle, inode, 
+					 le32_to_cpu(where[i].key), 1);
+	return err;
 }
 
 /*
@@ -693,7 +734,7 @@
 	Indirect chain[4];
 	Indirect *partial;
 	unsigned long goal;
-	int left, res;
+	int left;
 	int depth = ext3_block_to_path(inode, iblock, offsets);
 	loff_t new_size;
 
@@ -751,20 +792,20 @@
 	down_read(&inode->u.ext3_i.truncate_sem);
 	err = ext3_alloc_branch(handle, inode, left, goal,
 					offsets+(partial-chain), partial);
-	if (err) {
-		up_read(&inode->u.ext3_i.truncate_sem);
-		goto cleanup;
-	}
 
 	/* The ext3_splice_branch call will free and forget any buffers
 	 * on the new chain if there is a failure, but that risks using
 	 * up transaction credits, especially for bitmaps where the
 	 * credits cannot be returned.  Can we handle this somehow?  We
 	 * may need to return -EAGAIN upwards in the worst case.  --sct */
-	res = ext3_splice_branch(handle, inode, iblock, chain, partial, left);
+	if (!err)
+		err = ext3_splice_branch(handle, inode, iblock, chain,
+					 partial, left);
 	up_read(&inode->u.ext3_i.truncate_sem);
-	if (res < 0)
+	if (err == -EAGAIN)
 		goto changed;
+	if (err)
+		goto cleanup;
 
 	new_size = inode->i_size;
 	/*
@@ -972,6 +1013,13 @@
  * is elevated.  We'll still have enough credits for the tiny quotafile
  * write.  
  */
+
+static int do_journal_get_write_access(handle_t *handle, 
+				       struct buffer_head *bh)
+{
+	return ext3_journal_get_write_access(handle, bh);
+}
+
 static int ext3_prepare_write(struct file *file, struct page *page,
 			      unsigned from, unsigned to)
 {
@@ -991,7 +1039,7 @@
 
 	if (ext3_should_journal_data(inode))
 		ret = walk_page_buffers(handle, page,
-				from, to, NULL, ext3_journal_get_write_access);
+				from, to, NULL, do_journal_get_write_access);
 prepare_write_failed:
 	if (ret)
 		ext3_journal_stop(handle, inode);
@@ -1078,7 +1126,7 @@
 	}
 	ret2 = ext3_journal_stop(handle, inode);
 	unlock_kernel();
-	if (ret == 0)
+	if (!ret)
 		ret = ret2;
 	return ret;
 }
@@ -1475,7 +1523,9 @@
 	} else {
 		*top = *p->p;
 		/* Nope, don't do this in ext3.  Must leave the tree intact */
-		// *p->p = 0;
+#if 0
+		*p->p = 0;
+#endif
 	}
 	/* Writer: end */
 
@@ -1575,10 +1625,15 @@
 	unsigned long nr;		    /* Current block # */
 	u32 *p;				    /* Pointer into inode/ind
 					       for current block */
+	int err;
 
 	if (this_bh) {				/* For indirect block */
 		BUFFER_TRACE(this_bh, "get_write_access");
-		ext3_journal_get_write_access(handle, this_bh);
+		err = ext3_journal_get_write_access(handle, this_bh);
+		/* Important: if we can't update the indirect pointers
+		 * to the blocks, we can't free them. */
+		if (err)
+			return;
 	}
 
 	for (p = first; p < last; p++) {
@@ -1632,6 +1687,9 @@
 	unsigned long nr;
 	u32 *p;
 
+	if (is_handle_aborted(handle))
+		return;
+	
 	if (depth--) {
 		struct buffer_head *bh;
 		int addr_per_block = EXT3_ADDR_PER_BLOCK(inode->i_sb);
@@ -1662,6 +1720,27 @@
 					   depth);
 
 			/*
+			 * We've probably journalled the indirect block several
+			 * times during the truncate.  But it's no longer
+			 * needed and we now drop it from the transaction via
+			 * journal_revoke().
+			 *
+			 * That's easy if it's exclusively part of this
+			 * transaction.  But if it's part of the committing
+			 * transaction then journal_forget() will simply
+			 * brelse() it.  That means that if the underlying
+			 * block is reallocated in ext3_get_block(),
+			 * unmap_underlying_metadata() will find this block
+			 * and will try to get rid of it.  damn, damn.
+			 *
+			 * If this block has already been committed to the
+			 * journal, a revoke record will be written.  And
+			 * revoke records must be emitted *before* clearing
+			 * this block's bit in the bitmaps.
+			 */
+			ext3_forget(handle, 1, inode, bh, bh->b_blocknr);
+
+			/*
 			 * Everything below this this pointer has been
 			 * released.  Now let this top-of-subtree go.
 			 *
@@ -1677,31 +1756,13 @@
 			 * will merely complain about releasing a free block,
 			 * rather than leaking blocks.
 			 */
+			if (is_handle_aborted(handle))
+				return;
 			if (try_to_extend_transaction(handle, inode)) {
 				ext3_mark_inode_dirty(handle, inode);
 				ext3_journal_test_restart(handle, inode);
 			}
 
-			/*
-			 * We've probably journalled the indirect block several
-			 * times during the truncate.  But it's no longer
-			 * needed and we now drop it from the transaction via
-			 * journal_revoke().
-			 *
-			 * That's easy if it's exclusively part of this
-			 * transaction.  But if it's part of the committing
-			 * transaction then journal_forget() will simply
-			 * brelse() it.  That means that if the underlying
-			 * block is reallocated in ext3_get_block(),
-			 * unmap_underlying_metadata() will find this block
-			 * and will try to get rid of it.  damn, damn.
-			 *
-			 * If this block has already been committed to the
-			 * journal, a revoke record will be written.  And
-			 * revoke records must be emitted *before* clearing
-			 * this block's bit in the bitmaps.
-			 */
-			ext3_forget(handle, 1, inode, bh, bh->b_blocknr);
 #ifndef EXT3_NEW_QUOTAS
 			/* Release the child block now */
 			inode->i_blocks -= inode->i_sb->s_blocksize / 512;
@@ -1714,11 +1775,14 @@
 				 * pointed to by an indirect block: journal it
 				 */
 				BUFFER_TRACE(parent_bh, "get_write_access");
-				ext3_journal_get_write_access(handle,parent_bh);
-				*p = 0;
-				BUFFER_TRACE(parent_bh,
+				if (!ext3_journal_get_write_access(handle,
+								   parent_bh)){
+					*p = 0;
+					BUFFER_TRACE(parent_bh,
 					"call ext3_journal_dirty_metadata");
-				ext3_journal_dirty_metadata(handle, parent_bh);
+					ext3_journal_dirty_metadata(handle, 
+								    parent_bh);
+				}
 			}
 		}
 	} else {
@@ -1794,15 +1858,6 @@
 		goto out_stop;	/* error */
 
 	/*
-	 * The orphan list entry will now protect us from any crash which
-	 * occurs before the truncate completes, so it is now safe to propagate
-	 * the new, shorter inode size (held for now in i_size) into the
-	 * on-disk inode. We do this via i_disksize, which is the value which
-	 * ext3 *really* writes onto the disk inode.
-	 */
-	inode->u.ext3_i.i_disksize = inode->i_size;
-
-	/*
 	 * OK.  This truncate is going to happen.  We add the inode to the
 	 * orphan list, so that if this truncate spans multiple transactions,
 	 * and we crash, we will resume the truncate when the filesystem
@@ -1811,7 +1866,17 @@
 	 * Implication: the file must always be in a sane, consistent
 	 * truncatable state while each transaction commits.
 	 */
-	ext3_orphan_add(handle, inode);
+	if (ext3_orphan_add(handle, inode))
+		goto out_stop;
+
+	/*
+	 * The orphan list entry will now protect us from any crash which
+	 * occurs before the truncate completes, so it is now safe to propagate
+	 * the new, shorter inode size (held for now in i_size) into the
+	 * on-disk inode. We do this via i_disksize, which is the value which
+	 * ext3 *really* writes onto the disk inode.
+	 */
+	inode->u.ext3_i.i_disksize = inode->i_size;
 
 	/*
 	 * From here we block out all ext3_get_block() callers who want to
@@ -2000,18 +2065,17 @@
 	 * the test is that same one that e2fsck uses
 	 * NeilBrown 1999oct15
 	 */
-	/*
-	 * akpm: during orphan recovery, non-zero i_dtime is expected,
-	 * and is not an error.
-	 */
 	if (inode->i_nlink == 0) {
 		if (inode->i_mode == 0 ||
-		    (inode->u.ext3_i.i_dtime &&
-		     !(inode->i_sb->u.ext3_sb.s_mount_state & EXT3_ORPHAN_FS))){
+		    !(inode->i_sb->u.ext3_sb.s_mount_state & EXT3_ORPHAN_FS)) {
 			/* this inode is deleted */
 			brelse (bh);
 			goto bad_inode;
 		}
+		/* The only unlinked inodes we let through here have
+		 * valid i_mode and are being read by the orphan
+		 * recovery code: that's fine, we're about to complete
+		 * the process of deleting those. */
 	}
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size
 					 * (for stat), not the fs block
@@ -2104,11 +2168,13 @@
 {
 	struct ext3_inode *raw_inode = iloc->raw_inode;
 	struct buffer_head *bh = iloc->bh;
-	int err = 0, block;
+	int err = 0, rc, block;
 
 	if (handle) {
 		BUFFER_TRACE(bh, "get_write_access");
-		ext3_journal_get_write_access(handle, bh);
+		err = ext3_journal_get_write_access(handle, bh);
+		if (err)
+			goto out_brelse;
 	}
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
@@ -2172,14 +2238,16 @@
 			       /* If this is the first large file
 				* created, add a flag to the superblock.
 				*/
-				/* @@@ error handling */
-				ext3_journal_get_write_access(handle,
+				err = ext3_journal_get_write_access(handle,
 						sb->u.ext3_sb.s_sbh);
+				if (err)
+					goto out_brelse;
 				ext3_update_dynamic_rev(sb);
 				EXT3_SET_RO_COMPAT_FEATURE(sb,
 					EXT3_FEATURE_RO_COMPAT_LARGE_FILE);
 				sb->s_dirt = 1;
-				ext3_journal_dirty_metadata(handle,
+				handle->h_sync = 1;
+				err = ext3_journal_dirty_metadata(handle,
 						sb->u.ext3_sb.s_sbh);
 			}
 		}
@@ -2192,9 +2260,14 @@
 		raw_inode->i_block[block] = inode->u.ext3_i.i_data[block];
 
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-	ext3_journal_dirty_metadata(handle, bh);
+	rc = ext3_journal_dirty_metadata(handle, bh);
+	if (!err)
+		err = rc;
 	inode->u.ext3_i.i_state &= ~EXT3_STATE_NEW;
+
+out_brelse:
 	brelse (bh);
+	ext3_std_error(inode->i_sb, err);
 	return err;
 }
 
@@ -2274,7 +2347,7 @@
 int ext3_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
-	int error;
+	int error, rc;
 
 	error = inode_change_ok(inode, attr);
 	if (error)
@@ -2284,17 +2357,22 @@
 		handle_t *handle;
 
 		handle = ext3_journal_start(inode, 3);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-		ext3_orphan_add(handle, inode);
+		if (IS_ERR(handle)) {
+			error = PTR_ERR(handle);
+			goto err_out;
+		}
+		
+		error = ext3_orphan_add(handle, inode);
 		inode->u.ext3_i.i_disksize = attr->ia_size;
-		ext3_mark_inode_dirty(handle, inode);
+		rc = ext3_mark_inode_dirty(handle, inode);
+		if (!error)
+			error = rc;
 		ext3_journal_stop(handle, inode);
 	}
-
+	
 	inode_setattr(inode, attr);
-	if (IS_SYNC(inode))
-		ext3_force_commit(inode->i_sb);
+err_out:
+	ext3_std_error(inode->i_sb, error);
 	return 0;
 }
 
@@ -2349,16 +2427,18 @@
 		     struct inode *inode,
 		     struct ext3_iloc *iloc)
 {
+	int err = 0;
+
 	if (handle) {
 		/* the do_update_inode consumes one bh->b_count */
 		atomic_inc(&iloc->bh->b_count);
-		ext3_do_update_inode(handle, inode, iloc); /* @@@ ERROR */
+		err = ext3_do_update_inode(handle, inode, iloc);
 		/* ext3_do_update_inode() does journal_dirty_metadata */
 		brelse(iloc->bh);
 	} else {
 		printk(KERN_EMERG __FUNCTION__ ": called with no handle!\n");
 	}
-	return 0;
+	return err;
 }
 
 /* 
@@ -2372,7 +2452,7 @@
 {
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, iloc); /* @@@ ERROR */
+		err = ext3_get_inode_loc(inode, iloc);
 		if (!err) {
 			BUFFER_TRACE(iloc->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle, iloc->bh);
@@ -2382,8 +2462,7 @@
 			}
 		}
 	}
-	if (err)
-		printk(KERN_EMERG __FUNCTION__ ": failed\n");
+	ext3_std_error(inode->i_sb, err);
 	return err;
 }
 
@@ -2476,10 +2555,12 @@
 			BUFFER_TRACE(iloc.bh, "get_write_access");
 			err = journal_get_write_access(handle, iloc.bh);
 			if (!err)
-				ext3_journal_dirty_metadata(handle, iloc.bh);
+				err = ext3_journal_dirty_metadata(handle, 
+								  iloc.bh);
 			brelse(iloc.bh);
 		}
 	}
+	ext3_std_error(inode->i_sb, err);
 	return err;
 }
 #endif
@@ -2488,6 +2569,7 @@
 {
 	journal_t *journal;
 	handle_t *handle;
+	int err;
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -2500,6 +2582,9 @@
 	 */
 
 	journal = EXT3_JOURNAL(inode);
+	if (is_journal_aborted(journal) || IS_RDONLY(inode))
+		return -EROFS;
+	
 	journal_lock_updates(journal);
 	journal_flush(journal);
 
@@ -2524,11 +2609,12 @@
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	ext3_mark_inode_dirty(handle, inode);
+	err = ext3_mark_inode_dirty(handle, inode);
 	handle->h_sync = 1;
 	ext3_journal_stop(handle, inode);
-
-	return 0;
+	ext3_std_error(inode->i_sb, err);
+	
+	return err;
 }
 
 
diff -urN linux-2.4.10-ac3/fs/ext3/namei.c linux/fs/ext3/namei.c
--- linux-2.4.10-ac3/fs/ext3/namei.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/ext3/namei.c	Sun Sep 30 22:20:26 2001
@@ -55,6 +55,46 @@
 }
 
 /*
+ * Returns 0 if not found, -1 on failure, and 1 on success
+ */
+static int inline search_dirblock(struct buffer_head * bh,
+				  struct inode *dir,
+				  struct dentry *dentry,
+				  unsigned long offset,
+				  struct ext3_dir_entry_2 ** res_dir)
+{
+	struct ext3_dir_entry_2 * de;
+	char * dlimit;
+	int de_len;
+	const char *name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+
+	de = (struct ext3_dir_entry_2 *) bh->b_data;
+	dlimit = bh->b_data + dir->i_sb->s_blocksize;
+	while ((char *) de < dlimit) {
+		/* this code is executed quadratically often */
+		/* do minimal checking `by hand' */
+
+		if ((char *) de + namelen <= dlimit &&
+		    ext3_match (namelen, name, de)) {
+			/* found a match - just to be sure, do a full check */
+			if (!ext3_check_dir_entry("ext3_find_entry",
+						  dir, de, bh, offset))
+				return -1;
+			*res_dir = de;
+			return 1;
+		}
+		/* prevent looping on a bad block */
+		de_len = le16_to_cpu(de->rec_len);
+		if (de_len <= 0)
+			return -1;
+		offset += de_len;
+		de = (struct ext3_dir_entry_2 *) ((char *) de + de_len);
+	}
+	return 0;
+}
+
+/*
  *	ext3_find_entry()
  *
  * finds an entry in the specified directory with the wanted name. It
@@ -70,105 +110,79 @@
 {
 	struct super_block * sb;
 	struct buffer_head * bh_use[NAMEI_RA_SIZE];
-	struct buffer_head * bh_read[NAMEI_RA_SIZE];
-	unsigned long offset;
-	int block, toread, i, err;
+	struct buffer_head * bh, *ret = NULL;
+	unsigned long start, block, b;
+	int ra_ptr = 0, ra_max = 0, num = 0;
+	int nblocks, i, err;
 	struct inode *dir = dentry->d_parent->d_inode;
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
 
 	*res_dir = NULL;
 	sb = dir->i_sb;
 
-	if (namelen > EXT3_NAME_LEN)
-		return NULL;
-
-	memset (bh_use, 0, sizeof (bh_use));
-	toread = 0;
-	for (block = 0; block < NAMEI_RA_SIZE; ++block) {
-		struct buffer_head * bh;
-
-		if ((block << EXT3_BLOCK_SIZE_BITS (sb)) >= dir->i_size)
-			break;
-		bh = ext3_getblk (NULL, dir, block, 0, &err);
-		bh_use[block] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
-	}
-
-	for (block = 0, offset = 0; offset < dir->i_size; block++) {
-		struct buffer_head * bh;
-		struct ext3_dir_entry_2 * de;
-		char * dlimit;
-
-		if ((block % NAMEI_RA_BLOCKS) == 0 && toread) {
-			ll_rw_block (READ, toread, bh_read);
-			toread = 0;
-		}
-		bh = bh_use[block % NAMEI_RA_SIZE];
-		if (!bh) {
-#if 0
-			ext3_error (sb, "ext3_find_entry",
-				"directory #%lu contains a hole at offset %lu",
-				    dir->i_ino, offset);
-#endif
-			offset += sb->s_blocksize;
-			continue;
+	nblocks = dir->i_size >> EXT3_BLOCK_SIZE_BITS(sb);
+	start = dir->u.ext3_i.i_dir_start_lookup;
+	if (start >= nblocks)
+		start = 0;
+	block = start;
+restart:
+	do {
+		/*
+		 * We deal with the read-ahead logic here.
+		 */
+		if (ra_ptr >= ra_max) {
+			ra_ptr = 0;
+			b = block;
+			for (ra_max = 0; ra_max < NAMEI_RA_SIZE; ra_max++) {
+				if (b >= nblocks ||
+				    (num && block == start))
+					break;
+				num++;
+				bh = ext3_getblk(NULL, dir, b++, 0, &err);
+				bh_use[ra_max] = bh;
+				if (bh)
+					ll_rw_block(READ, 1, &bh);
+			}
 		}
-		wait_on_buffer (bh);
+		if ((bh = bh_use[ra_ptr++]) == NULL)
+			goto next;
+		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
-			/*
-			 * read error: all bets are off
-			 */
-			break;
+			/* read error, skip block & hope for the best */
+			brelse(bh);
+			goto next;
 		}
-
-		de = (struct ext3_dir_entry_2 *) bh->b_data;
-		dlimit = bh->b_data + sb->s_blocksize;
-		while ((char *) de < dlimit) {
-			/* this code is executed quadratically often */
-			/* do minimal checking `by hand' */
-			int de_len;
-
-			if ((char *) de + namelen <= dlimit &&
-			    ext3_match (namelen, name, de)) {
-				/* found a match -
-				   just to be sure, do a full check */
-				if (!ext3_check_dir_entry("ext3_find_entry",
-							  dir, de, bh, offset))
-					goto failure;
-				for (i = 0; i < NAMEI_RA_SIZE; ++i) {
-					if (bh_use[i] != bh)
-						brelse (bh_use[i]);
-				}
-				*res_dir = de;
-				return bh;
-			}
-			/* prevent looping on a bad block */
-			de_len = le16_to_cpu(de->rec_len);
-			if (de_len <= 0)
-				goto failure;
-			offset += de_len;
-			de = (struct ext3_dir_entry_2 *)
-				((char *) de + de_len);
+		i = search_dirblock(bh, dir, dentry,
+			    block << EXT3_BLOCK_SIZE_BITS(sb), res_dir);
+		if (i == 1) {
+			dir->u.ext3_i.i_dir_start_lookup = block;
+			ret = bh;
+			goto cleanup_and_exit;
+		} else {
+			brelse(bh);
+			if (i < 0)
+				goto cleanup_and_exit;
 		}
-
-		brelse (bh);
-		if (((block + NAMEI_RA_SIZE) << EXT3_BLOCK_SIZE_BITS (sb)) >=
-		    dir->i_size)
-			bh = NULL;
-		else
-			bh = ext3_getblk (NULL, dir,
-					block + NAMEI_RA_SIZE, 0, &err);
-		bh_use[block % NAMEI_RA_SIZE] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
+	next:
+		if (++block >= nblocks)
+			block = 0;
+	} while (block != start);
+
+	/*
+	 * If the directory has grown while we were searching, then
+	 * search the last part of the directory before giving up.
+	 */
+	block = nblocks;
+	nblocks = dir->i_size >> EXT3_BLOCK_SIZE_BITS(sb);
+	if (block < nblocks) {
+		start = 0;
+		goto restart;
 	}
-
-failure:
-	for (i = 0; i < NAMEI_RA_SIZE; ++i)
-		brelse (bh_use[i]);
-	return NULL;
+		
+cleanup_and_exit:
+	/* Clean up the read-ahead blocks */
+	for (; ra_ptr < ra_max; ra_ptr++)
+		brelse (bh_use[ra_ptr]);
+	return ret;
 }
 
 static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry)
@@ -623,16 +637,15 @@
  * At filesystem recovery time, we walk this list deleting unlinked
  * inodes and truncating linked inodes in ext3_orphan_cleanup().
  */
-void ext3_orphan_add(handle_t *handle, struct inode *inode)
+int ext3_orphan_add(handle_t *handle, struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ext3_iloc iloc;
-
+	int err = 0, rc;
+	
 	lock_super(sb);
-	if (!list_empty(&inode->u.ext3_i.i_orphan)) {
-		unlock_super(sb);
-		return;
-	}
+	if (!list_empty(&inode->u.ext3_i.i_orphan))
+		goto out_unlock;
 
 	/* Orphan handling is only valid for files with data blocks
 	 * being truncated, or files being unlinked. */
@@ -647,39 +660,58 @@
 		S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
-	ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
-	ext3_reserve_inode_write(handle, inode, &iloc);
+	err = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
+	if (err)
+		goto out_unlock;
+	
+	err = ext3_reserve_inode_write(handle, inode, &iloc);
+	if (err)
+		goto out_unlock;
 
 	/* Insert this inode at the head of the on-disk orphan list... */
 	NEXT_ORPHAN(inode) = le32_to_cpu(EXT3_SB(sb)->s_es->s_last_orphan);
 	EXT3_SB(sb)->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
-	ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
-	ext3_mark_iloc_dirty(handle, inode, &iloc);
+	err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
+	rc = ext3_mark_iloc_dirty(handle, inode, &iloc);
+	if (!err)
+		err = rc;
+
+	/* Only add to the head of the in-memory list if all the
+	 * previous operations succeeded.  If the orphan_add is going to
+	 * fail (possibly taking the journal offline), we can't risk
+	 * leaving the inode on the orphan list: stray orphan-list
+	 * entries can cause panics at unmount time.
+	 *
+	 * This is safe: on error we're going to ignore the orphan list
+	 * anyway on the next recovery. */
+	if (!err)
+		list_add(&inode->u.ext3_i.i_orphan, &EXT3_SB(sb)->s_orphan);
 
-	/* ...and the head of the in-memory list. */
-	list_add(&inode->u.ext3_i.i_orphan, &EXT3_SB(sb)->s_orphan);
-
-	unlock_super(sb);
 	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %ld will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
+out_unlock:
+	unlock_super(sb);
+	ext3_std_error(inode->i_sb, err);
+	return err;
 }
 
 /*
  * ext3_orphan_del() removes an unlinked or truncated inode from the list
  * of such inodes stored on disk, because it is finally being cleaned up.
  */
-void ext3_orphan_del(handle_t *handle, struct inode *inode)
+int ext3_orphan_del(handle_t *handle, struct inode *inode)
 {
 	struct list_head *prev;
 	struct ext3_sb_info *sbi;
 	ino_t ino_next; 
 	struct ext3_iloc iloc;
-
+	int err = 0;
+	
 	lock_super(inode->i_sb);
 	if (list_empty(&inode->u.ext3_i.i_orphan)) {
 		unlock_super(inode->i_sb);
-		return;
+		return 0;
 	}
 
 	ino_next = NEXT_ORPHAN(inode);
@@ -691,26 +723,46 @@
 	list_del(&inode->u.ext3_i.i_orphan);
 	INIT_LIST_HEAD(&inode->u.ext3_i.i_orphan);
 
+	err = ext3_reserve_inode_write(handle, inode, &iloc);
+	if (err)
+		goto out_err;
+
 	if (prev == &sbi->s_orphan) {
 		jbd_debug(4, "superblock will point to %ld\n", ino_next);
 		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-		ext3_journal_get_write_access(handle, sbi->s_sbh);
+		err = ext3_journal_get_write_access(handle, sbi->s_sbh);
+		if (err)
+			goto out_brelse;
 		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
-		ext3_journal_dirty_metadata(handle, sbi->s_sbh);
+		err = ext3_journal_dirty_metadata(handle, sbi->s_sbh);
 	} else {
+		struct ext3_iloc iloc2;
 		struct inode *i_prev =
 			list_entry(prev, struct inode, u.ext3_i.i_orphan);
 		
 		jbd_debug(4, "orphan inode %ld will point to %ld\n",
 			  i_prev->i_ino, ino_next);
-		ext3_reserve_inode_write(handle, i_prev, &iloc);
+		err = ext3_reserve_inode_write(handle, i_prev, &iloc2);
+		if (err)
+			goto out_brelse;
 		NEXT_ORPHAN(i_prev) = ino_next;
-		ext3_mark_iloc_dirty(handle, i_prev, &iloc);
+		err = ext3_mark_iloc_dirty(handle, i_prev, &iloc2);
 	}
-	ext3_reserve_inode_write(handle, inode, &iloc);
+	if (err)
+		goto out_brelse;
 	NEXT_ORPHAN(inode) = 0;
-	ext3_mark_iloc_dirty(handle, inode, &iloc);
+	err = ext3_mark_iloc_dirty(handle, inode, &iloc);
+	if (err)
+		goto out_brelse;
+
+out_err: 	
+	ext3_std_error(inode->i_sb, err);
 	unlock_super(inode->i_sb);
+	return err;
+
+out_brelse:
+	brelse(iloc.bh);
+	goto out_err;
 }
 
 static int ext3_rmdir (struct inode * dir, struct dentry *dentry)
diff -urN linux-2.4.10-ac3/fs/ext3/super.c linux/fs/ext3/super.c
--- linux-2.4.10-ac3/fs/ext3/super.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/ext3/super.c	Sun Sep 30 22:20:01 2001
@@ -55,7 +55,8 @@
 static void make_rdonly(kdev_t dev, int *no_write)
 {
 	if (dev) {
-		printk("Turning device %s read-only\n", bdevname(dev));
+		printk(KERN_WARNING "Turning device %s read-only\n", 
+		       bdevname(dev));
 		*no_write = 0xdead0000 + dev;
 	}
 }
@@ -148,14 +149,12 @@
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 
 	EXT3_SB(sb)->s_mount_state |= EXT3_ERROR_FS;
+	es->s_state |= cpu_to_le32(EXT3_ERROR_FS);
 
 	if (sb->s_flags & MS_RDONLY)
 		return;
 
-	if (ext3_error_behaviour(sb) == EXT3_ERRORS_CONTINUE) {
-		es->s_state |= cpu_to_le32(EXT3_ERROR_FS);
-		ext3_commit_super(sb, es, 1);
-	} else {
+	if (ext3_error_behaviour(sb) != EXT3_ERRORS_CONTINUE) {
 		EXT3_SB(sb)->s_mount_opt |= EXT3_MOUNT_ABORT;
 		journal_abort(EXT3_SB(sb)->s_journal, -EIO);
 	}
@@ -165,9 +164,11 @@
 		       bdevname(sb->s_dev));
 
 	if (ext3_error_behaviour(sb) == EXT3_ERRORS_RO) {
-		printk ("Remounting filesystem read-only\n");
+		printk (KERN_CRIT "Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
 	}
+
+	ext3_commit_super(sb, es, 1);
 }
 
 void ext3_error (struct super_block * sb, const char * function,
@@ -185,11 +186,7 @@
 	ext3_handle_error(sb);
 }
 
-/* __ext3_std_error decodes expected errors from journaling functions
- * automatically and invokes the appropriate error response.  */
-
-void __ext3_std_error (struct super_block * sb, const char * function,
-		       int errno)
+const char *ext3_decode_error(struct super_block * sb, int errno)
 {
 	char *errstr = NULL;
 	
@@ -201,7 +198,7 @@
 		errstr = "Out of memory";
 		break;
 	case -EROFS:
-		if (EXT3_SB(sb)->s_journal->j_flags & JFS_ABORT)
+		if (!sb || EXT3_SB(sb)->s_journal->j_flags & JFS_ABORT)
 			errstr = "Journal has aborted";
 		else
 			errstr = "Readonly filesystem";
@@ -210,6 +207,17 @@
 		break;
 	}
 
+	return errstr;
+}
+
+/* __ext3_std_error decodes expected errors from journaling functions
+ * automatically and invokes the appropriate error response.  */
+
+void __ext3_std_error (struct super_block * sb, const char * function,
+		       int errno)
+{
+	const char *errstr = ext3_decode_error(sb, errno);
+
 	if (errstr) {
 		printk (KERN_CRIT "EXT3-fs error (device %s) in %s: %s\n",
 			bdevname(sb->s_dev), function, errstr);
@@ -252,7 +260,7 @@
 	if (sb->s_flags & MS_RDONLY)
 		return;
 	
-	printk ("Remounting filesystem read-only\n");
+	printk (KERN_CRIT "Remounting filesystem read-only\n");
 	sb->u.ext3_sb.s_mount_state |= EXT3_ERROR_FS;
 	sb->s_flags |= MS_RDONLY;
 	sb->u.ext3_sb.s_mount_opt |= EXT3_MOUNT_ABORT;
@@ -482,7 +490,8 @@
 #ifdef CONFIG_EXT3_CHECK
 				set_opt (*mount_options, CHECK);
 #else
-				printk("EXT3 Check option not supported\n");
+				printk(KERN_ERR 
+				       "EXT3 Check option not supported\n");
 #endif
 		}
 		else if (!strcmp (this_char, "debug"))
@@ -506,7 +515,8 @@
 				set_opt (*mount_options, ERRORS_PANIC);
 			}
 			else {
-				printk ("EXT3-fs: Invalid errors option: %s\n",
+				printk (KERN_ERR
+					"EXT3-fs: Invalid errors option: %s\n",
 					value);
 				return 0;
 			}
@@ -558,7 +568,7 @@
                            user to specify an existing inode to be the
                            journal file. */
 			if (is_remount) {
-				printk(KERN_NOTICE "EXT3-fs: cannot specify "
+				printk(KERN_ERR "EXT3-fs: cannot specify "
 				       "journal on remount\n");
 				return 0;
 			}
@@ -584,15 +594,17 @@
 			else if (!strcmp (value, "writeback"))
 				data_opt = EXT3_MOUNT_WRITEBACK_DATA;
 			else {
-				printk ("EXT3-fs: Invalid data option: %s\n",
+				printk (KERN_ERR 
+					"EXT3-fs: Invalid data option: %s\n",
 					value);
 				return 0;
 			}
 			if (is_remount) {
 				if ((*mount_options & EXT3_MOUNT_DATA_FLAGS) !=
 							data_opt) {
-					printk("EXT3-fs: cannot change data "
-						"mode on remount\n");
+					printk(KERN_ERR
+					       "EXT3-fs: cannot change data "
+					       "mode on remount\n");
 					return 0;
 				}
 			} else {
@@ -600,8 +612,9 @@
 				*mount_options |= data_opt;
 			}
 		} else {
-			printk ("EXT3-fs: Unrecognized mount option %s\n",
-					this_char);
+			printk (KERN_ERR 
+				"EXT3-fs: Unrecognized mount option %s\n",
+				this_char);
 			return 0;
 		}
 	}
@@ -615,27 +628,30 @@
 	int res = 0;
 
 	if (le32_to_cpu(es->s_rev_level) > EXT3_MAX_SUPP_REV) {
-		printk ("EXT3-fs warning: revision level too high, "
+		printk (KERN_ERR "EXT3-fs warning: revision level too high, "
 			"forcing read-only mode\n");
 		res = MS_RDONLY;
 	}
 	if (read_only)
 		return res;
 	if (!(sbi->s_mount_state & EXT3_VALID_FS))
-		printk ("EXT3-fs warning: mounting unchecked fs, "
+		printk (KERN_WARNING "EXT3-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
 	else if ((sbi->s_mount_state & EXT3_ERROR_FS))
-		printk ("EXT3-fs warning: mounting fs with errors, "
+		printk (KERN_WARNING
+			"EXT3-fs warning: mounting fs with errors, "
 			"running e2fsck is recommended\n");
 	else if ((__s16) le16_to_cpu(es->s_max_mnt_count) >= 0 &&
 		 le16_to_cpu(es->s_mnt_count) >=
 		 (unsigned short) (__s16) le16_to_cpu(es->s_max_mnt_count))
-		printk ("EXT3-fs warning: maximal mount count reached, "
+		printk (KERN_WARNING
+			"EXT3-fs warning: maximal mount count reached, "
 			"running e2fsck is recommended\n");
 	else if (le32_to_cpu(es->s_checkinterval) &&
 		(le32_to_cpu(es->s_lastcheck) +
 			le32_to_cpu(es->s_checkinterval) <= CURRENT_TIME))
-		printk ("EXT3-fs warning: checktime reached, "
+		printk (KERN_WARNING
+			"EXT3-fs warning: checktime reached, "
 			"running e2fsck is recommended\n");
 #if 0
 		/* @@@ We _will_ want to clear the valid bit if we find
@@ -653,14 +669,15 @@
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
 	ext3_commit_super (sb, es, 1);
 	if (test_opt (sb, DEBUG))
-		printk ("[EXT3 FS %s, %s, bs=%lu, gc=%lu, "
+		printk (KERN_INFO
+			"[EXT3 FS %s, %s, bs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
 			EXT3FS_VERSION, EXT3FS_DATE, sb->s_blocksize,
 			sbi->s_groups_count,
 			EXT3_BLOCKS_PER_GROUP(sb),
 			EXT3_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt);
-	printk("EXT3 FS " EXT3FS_VERSION ", " EXT3FS_DATE " on %s, ",
+	printk(KERN_INFO "EXT3 FS " EXT3FS_VERSION ", " EXT3FS_DATE " on %s, ",
 				bdevname(sb->s_dev));
 	if (EXT3_SB(sb)->s_journal->j_inode == NULL) {
 		printk("external journal on %s\n",
@@ -766,6 +783,15 @@
 		sb->s_flags &= ~MS_RDONLY;
 	}
 
+	if (sb->u.ext3_sb.s_mount_state & EXT3_ERROR_FS) {
+		if (es->s_last_orphan)
+			jbd_debug(1, "Errors on filesystem, "
+				  "clearing orphan list.\n");
+		es->s_last_orphan = 0;
+		jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+		return;
+	}
+
 	while (es->s_last_orphan) {
 		struct inode *inode;
 
@@ -777,7 +803,7 @@
 
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 		if (inode->i_nlink) {
-			printk(__FUNCTION__
+			printk(KERN_DEBUG __FUNCTION__
 				": truncating inode %ld to %Ld bytes\n",
 				inode->i_ino, inode->i_size);
 			jbd_debug(2, "truncating inode %ld to %Ld bytes\n",
@@ -785,7 +811,7 @@
 			ext3_truncate(inode);
 			nr_truncates++;
 		} else {
-			printk(__FUNCTION__
+			printk(KERN_DEBUG __FUNCTION__
 				": deleting unreferenced inode %ld\n",
 				inode->i_ino);
 			jbd_debug(2, "deleting unreferenced inode %ld\n",
@@ -877,7 +903,7 @@
 	}
 
 	if (!(bh = bread (dev, logic_sb_block, blocksize))) {
-		printk ("EXT3-fs: unable to read superblock\n");
+		printk (KERN_ERR "EXT3-fs: unable to read superblock\n");
 		goto out_fail;
 	}
 	/*
@@ -889,7 +915,8 @@
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT3_SUPER_MAGIC) {
 		if (!silent)
-			printk("VFS: Can't find ext3 filesystem on dev %s.\n",
+			printk(KERN_ERR 
+			       "VFS: Can't find ext3 filesystem on dev %s.\n",
 			       bdevname(dev));
 		goto failed_mount;
 	}
@@ -897,7 +924,8 @@
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_INCOMPAT_FEATURE(sb, ~0U)))
-		printk("EXT3-fs warning: feature flags set on rev 0 fs, "
+		printk(KERN_WARNING 
+		       "EXT3-fs warning: feature flags set on rev 0 fs, "
 		       "running e2fsck is recommended\n");
 	/*
 	 * Check feature flags regardless of the revision level, since we
@@ -905,14 +933,14 @@
 	 * so there is a chance incompat flags are set on a rev 0 filesystem.
 	 */
 	if ((i = EXT3_HAS_INCOMPAT_FEATURE(sb, ~EXT3_FEATURE_INCOMPAT_SUPP))) {
-		printk("EXT3-fs: %s: couldn't mount because of "
+		printk(KERN_ERR "EXT3-fs: %s: couldn't mount because of "
 		       "unsupported optional features (%x).\n",
 		       bdevname(dev), i);
 		goto failed_mount;
 	}
 	if (!(sb->s_flags & MS_RDONLY) &&
 	    (i = EXT3_HAS_RO_COMPAT_FEATURE(sb, ~EXT3_FEATURE_RO_COMPAT_SUPP))){
-		printk("EXT3-fs: %s: couldn't mount RDWR because of "
+		printk(KERN_ERR "EXT3-fs: %s: couldn't mount RDWR because of "
 		       "unsupported optional features (%x).\n",
 		       bdevname(dev), i);
 		goto failed_mount;
@@ -922,7 +950,8 @@
 
 	if (sb->s_blocksize < EXT3_MIN_BLOCK_SIZE ||
 	    sb->s_blocksize > EXT3_MAX_BLOCK_SIZE) {
-		printk("EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
+		printk(KERN_ERR 
+		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
 		       blocksize, bdevname(dev));
 		goto failed_mount;
 	}
@@ -948,13 +977,15 @@
 		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
 		bh = bread (dev, logic_sb_block, blocksize);
 		if (!bh) {
-			printk("EXT3-fs: Can't read superblock on 2nd try.\n");
+			printk(KERN_ERR 
+			       "EXT3-fs: Can't read superblock on 2nd try.\n");
 			return NULL;
 		}
 		es = (struct ext3_super_block *)(((char *)bh->b_data) + offset);
 		sbi->s_es = es;
 		if (es->s_magic != le16_to_cpu(EXT3_SUPER_MAGIC)) {
-			printk ("EXT3-fs: Magic mismatch, very weird !\n");
+			printk (KERN_ERR 
+				"EXT3-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
 		}
 	}
@@ -966,7 +997,8 @@
 		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
 		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
 		if (sbi->s_inode_size != EXT3_GOOD_OLD_INODE_SIZE) {
-			printk ("EXT3-fs: unsupported inode size: %d\n",
+			printk (KERN_ERR
+				"EXT3-fs: unsupported inode size: %d\n",
 				sbi->s_inode_size);
 			goto failed_mount;
 		}
@@ -974,7 +1006,8 @@
 	sbi->s_frag_size = EXT3_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
 	if (blocksize != sbi->s_frag_size) {
-		printk("EXT3-fs: fragsize %lu != blocksize %u (unsupported)\n",
+		printk(KERN_ERR
+		       "EXT3-fs: fragsize %lu != blocksize %u (unsupported)\n",
 		       sbi->s_frag_size, blocksize);
 		goto failed_mount;
 	}
@@ -995,17 +1028,20 @@
 	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
 
 	if (sbi->s_blocks_per_group > blocksize * 8) {
-		printk ("EXT3-fs: #blocks per group too big: %lu\n",
+		printk (KERN_ERR
+			"EXT3-fs: #blocks per group too big: %lu\n",
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
 	if (sbi->s_frags_per_group > blocksize * 8) {
-		printk ("EXT3-fs: #fragments per group too big: %lu\n",
+		printk (KERN_ERR
+			"EXT3-fs: #fragments per group too big: %lu\n",
 			sbi->s_frags_per_group);
 		goto failed_mount;
 	}
 	if (sbi->s_inodes_per_group > blocksize * 8) {
-		printk ("EXT3-fs: #inodes per group too big: %lu\n",
+		printk (KERN_ERR
+			"EXT3-fs: #inodes per group too big: %lu\n",
 			sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
@@ -1019,20 +1055,21 @@
 	sbi->s_group_desc = kmalloc(db_count * sizeof (struct buffer_head *),
 				    GFP_KERNEL);
 	if (sbi->s_group_desc == NULL) {
-		printk ("EXT3-fs: not enough memory\n");
+		printk (KERN_ERR "EXT3-fs: not enough memory\n");
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
 		sbi->s_group_desc[i] = bread(dev, logic_sb_block + i + 1,
 					     blocksize);
 		if (!sbi->s_group_desc[i]) {
-			printk ("EXT3-fs: can't read group descriptor %d\n", i);
+			printk (KERN_ERR "EXT3-fs: "
+				"can't read group descriptor %d\n", i);
 			db_count = i;
 			goto failed_mount2;
 		}
 	}
 	if (!ext3_check_descriptors (sb)) {
-		printk ("EXT3-fs: group descriptors corrupted !\n");
+		printk (KERN_ERR "EXT3-fs: group descriptors corrupted !\n");
 		goto failed_mount2;
 	}
 	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++) {
@@ -1112,9 +1149,10 @@
 		if (sb->s_root) {
 			dput(sb->s_root);
 			sb->s_root = NULL;
-			printk("EXT3-fs: corrupt root inode, run e2fsck\n");
+			printk(KERN_ERR
+			       "EXT3-fs: corrupt root inode, run e2fsck\n");
 		} else
-			printk("EXT3-fs: get root inode failed\n");
+			printk(KERN_ERR "EXT3-fs: get root inode failed\n");
 		goto failed_mount3;
 	}
 
@@ -1166,20 +1204,20 @@
 
 	journal_inode = iget(sb, journal_inum);
 	if (!journal_inode) {
-		printk("EXT3-fs: no journal found.\n");
+		printk(KERN_ERR "EXT3-fs: no journal found.\n");
 		return NULL;
 	}
 	if (!journal_inode->i_nlink) {
 		make_bad_inode(journal_inode);
 		iput(journal_inode);
-		printk("EXT3-fs: journal inode is deleted.\n");
+		printk(KERN_ERR "EXT3-fs: journal inode is deleted.\n");
 		return NULL;
 	}
 
 	jbd_debug(2, "Journal inode found at %p: %Ld bytes\n",
 		  journal_inode, journal_inode->i_size);
 	if (is_bad_inode(journal_inode) || !S_ISREG(journal_inode->i_mode)) {
-		printk("EXT3-fs: invalid journal inode.\n");
+		printk(KERN_ERR "EXT3-fs: invalid journal inode.\n");
 		iput(journal_inode);
 		return NULL;
 	}
@@ -1349,7 +1387,7 @@
 	journal_t *journal;
 
 	if (sb->s_flags & MS_RDONLY) {
-		printk("EXT3-fs: readonly filesystem when trying to "
+		printk(KERN_ERR "EXT3-fs: readonly filesystem when trying to "
 				"create journal.\n");
 		return -EROFS;
 	}
@@ -1361,7 +1399,7 @@
 	       journal_inum);
 
 	if (journal_create(journal)) {
-		printk("EXT3-fs: error creating journal.\n");
+		printk(KERN_ERR "EXT3-fs: error creating journal.\n");
 		journal_destroy(journal);
 		return -EIO;
 	}
@@ -1465,24 +1503,32 @@
 }
 
 /*
- * AKPM: In 2.4, sync_super() calls in here with lock_super()
- * held on this filesystem's superblock.  Hence we *cannot*
- * call log_wait_commit(), because then we'd be waiting
- * on another thread which probably wants to do a lock_super().
- * It deadlocks.
+ * Ext3 always journals updates to the superblock itself, so we don't
+ * have to propagate any other updates to the superblock on disk at this
+ * point.  Just start an async writeback to get the buffers on their way
+ * to the disk.
  *
- * Tentatively, we no longer call log_wait_commit() here.
- * We do kick off a commit, so we know that the journal
- * will be committed very soon.
+ * This implicitly triggers the writebehind on sync().
  */
 
+static int do_sync_supers = 0;
+MODULE_PARM(do_sync_supers, "i");
+MODULE_PARM_DESC(do_sync_supers, "Write superblocks synchronously");
+
 void ext3_write_super (struct super_block * sb)
 {
+	tid_t target;
+	
 	if (down_trylock(&sb->s_lock) == 0)
 		BUG();		/* aviro detector */
-	unlock_super(sb);
-	ext3_force_commit(sb);
-	lock_super(sb);
+	sb->s_dirt = 0;
+	target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);
+
+	if (do_sync_supers) {
+		unlock_super(sb);
+		log_wait_commit(EXT3_SB(sb)->s_journal, target);
+		lock_super(sb);
+	}
 }
 
 /*
diff -urN linux-2.4.10-ac3/fs/jbd/checkpoint.c linux/fs/jbd/checkpoint.c
--- linux-2.4.10-ac3/fs/jbd/checkpoint.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/jbd/checkpoint.c	Sun Sep 30 22:20:01 2001
@@ -394,9 +394,6 @@
 	if (journal->j_tail_sequence == first_tid)
 		return 1;
 
-	if (journal->j_flags & JFS_ABORT)
-		return -EROFS;
-	
 	/* OK, update the superblock to recover the freed space.
 	 * Physical blocks come first: have we wrapped beyond the end of
 	 * the log?  */
@@ -412,7 +409,8 @@
 	journal->j_free += freed;
 	journal->j_tail_sequence = first_tid;
 	journal->j_tail = blocknr;
-	journal_update_superblock(journal, 1);
+	if (!(journal->j_flags & JFS_ABORT))
+		journal_update_superblock(journal, 1);
 	return 0;
 }
 
diff -urN linux-2.4.10-ac3/fs/jbd/commit.c linux/fs/jbd/commit.c
--- linux-2.4.10-ac3/fs/jbd/commit.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/jbd/commit.c	Sun Sep 30 22:20:01 2001
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/locks.h>
+#include <linux/smp_lock.h>
 
 extern spinlock_t journal_datalist_lock;
 
@@ -60,7 +61,7 @@
 	 * all outstanding updates to complete.
 	 */
 
-	lock_journal(journal);
+	lock_journal(journal); /* Protect journal->j_running_transaction */
 
 #ifdef COMMIT_STATS
 	spin_lock(&journal_datalist_lock);
@@ -68,6 +69,8 @@
 	spin_unlock(&journal_datalist_lock);
 #endif
 
+	lock_kernel();
+	
 	J_ASSERT (journal->j_running_transaction != NULL);
 	J_ASSERT (journal->j_committing_transaction == NULL);
 
@@ -158,6 +161,8 @@
 
 	commit_transaction->t_log_start = journal->j_head;
 
+	unlock_kernel();
+	
 	jbd_debug (3, "JBD: commit phase 2\n");
 
 	/*
@@ -324,9 +329,15 @@
 		/* If we're in abort mode, we just un-journal the buffer and
 		   release it for background writing. */
 
-		if (is_journal_abort(journal)) {
+		if (is_journal_aborted(journal)) {
 			JBUFFER_TRACE(jh, "journal is aborting: refile");
 			journal_refile_buffer(jh);
+			/* If that was the last one, we need to clean up
+			 * any descriptor buffers which may have been
+			 * already allocated, even if we are now
+			 * aborting. */
+			if (!commit_transaction->t_buffers)
+				goto start_journal_io;
 			continue;
 		}
 
@@ -425,6 +436,7 @@
 
 			tag->t_flags |= htonl(JFS_FLAG_LAST_TAG);
 
+start_journal_io:
 			unlock_journal(journal);
 			for (i=0; i<bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
@@ -489,9 +501,8 @@
 		bh = jh2bh(jh);
 		BUFFER_TRACE(bh, "dumping temporary bh");
 		journal_unlock_journal_head(jh);
-		journal_remove_journal_head(bh);
-		__brelse(bh);	/* For journal_add_journal_head() */
-		__brelse(bh);	/* to zero */
+		__brelse(bh);
+		J_ASSERT_BH(bh, atomic_read(&bh->b_count) == 0);
 		put_unused_buffer_head(bh);
 
 		/* We also have to unlock and free the corresponding
@@ -537,9 +548,7 @@
 		journal_unfile_buffer(jh);
 		jh->b_transaction = NULL;
 		journal_unlock_journal_head(jh);
-		journal_remove_journal_head(bh);
 		__brelse(bh);		/* One for getblk */
-		__brelse(bh);		/* One for journal_add_journal_head */
 		/* AKPM: bforget here */
 	}
 
@@ -550,7 +559,7 @@
 	 * mode we can now just skip the rest of the journal write
 	 * entirely. */
 
-	if (is_journal_abort(journal))
+	if (is_journal_aborted(journal))
 		goto skip_commit;
 
 	descriptor = journal_get_descriptor_buffer(journal);
@@ -572,8 +581,6 @@
 		wait_on_buffer(bh);
 		__brelse(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
-		journal_remove_journal_head(bh);
-		__brelse(bh);		/* One for journal_add_journal_head() */
 	}
 	lock_journal(journal);
 
diff -urN linux-2.4.10-ac3/fs/jbd/journal.c linux/fs/jbd/journal.c
--- linux-2.4.10-ac3/fs/jbd/journal.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/jbd/journal.c	Sun Sep 30 22:20:01 2001
@@ -500,36 +500,56 @@
 }
 
 /*
- * The caller should hold the BKL (doesn't seem very important though).
- * This function must be non-blocking for PF_MEMALLOC tasks
+ * This function must be non-allocating for PF_MEMALLOC tasks
  */
-void log_start_commit (journal_t *journal, transaction_t *transaction)
+tid_t log_start_commit (journal_t *journal, transaction_t *transaction)
 {
+	tid_t target = journal->j_commit_request;
+
+	lock_kernel(); /* Protect journal->j_running_transaction */
+	
+	/*
+	 * A NULL transaction asks us to commit the currently running
+	 * transaction, if there is one.  
+	 */
+	if (transaction)
+		target = transaction->t_tid;
+	else {
+		transaction = journal->j_running_transaction;
+		if (!transaction)
+			goto out;
+		target = transaction->t_tid;
+	}
+		
 	/*
 	 * Are we already doing a recent enough commit?
 	 */
-	if (tid_geq(journal->j_commit_request, transaction->t_tid))
-		return;
+	if (tid_geq(journal->j_commit_request, target))
+		goto out;
 
 	/*
 	 * We want a new commit: OK, mark the request and wakup the
 	 * commit thread.  We do _not_ do the commit ourselves.
 	 */
 
-	journal->j_commit_request = transaction->t_tid;
+	journal->j_commit_request = target;
 	jbd_debug(1, "JBD: requesting commit %d/%d\n",
 		  journal->j_commit_request,
 		  journal->j_commit_sequence);
 	wake_up(&journal->j_wait_commit);
+
+out:
+	unlock_kernel();
+	return target;
 }
 
 /*
  * Wait for a specified commit to complete.
- * The caller must hold the BKL.
  * The caller may not hold the journal lock.
  */
 void log_wait_commit (journal_t *journal, tid_t tid)
 {
+	lock_kernel();
 #ifdef CONFIG_JBD_DEBUG
 	lock_journal(journal);
 	if (!tid_geq(journal->j_commit_request, tid)) {
@@ -545,6 +565,7 @@
 		wake_up(&journal->j_wait_commit);
 		sleep_on(&journal->j_wait_done_commit);
 	}
+	unlock_kernel();
 }
 
 /*
@@ -1166,6 +1187,8 @@
 	transaction_t *transaction = NULL;
 	unsigned long old_tail;
 
+	lock_kernel();
+	
 	/* Force everything buffered to the log... */
 	if (journal->j_running_transaction) {
 		transaction = journal->j_running_transaction;
@@ -1201,6 +1224,8 @@
 	J_ASSERT(journal->j_head == journal->j_tail);
 	J_ASSERT(journal->j_tail_sequence == journal->j_transaction_sequence);
 
+	unlock_kernel();
+	
 	return err;
 }
 
@@ -1627,7 +1652,13 @@
 	spin_lock(&journal_datalist_lock);
 	J_ASSERT_JH(jh, jh->b_jcount > 0);
 	--jh->b_jcount;
-	/* AKPM: could try a remove_journal_head here */
+	if (!jh->b_jcount && !jh->b_transaction) {
+		struct buffer_head *bh;
+		bh = jh2bh(jh);
+		__journal_remove_journal_head(bh);
+		__brelse(bh);
+	}
+	
 	spin_unlock(&journal_datalist_lock);
 }
 
diff -urN linux-2.4.10-ac3/fs/jbd/revoke.c linux/fs/jbd/revoke.c
--- linux-2.4.10-ac3/fs/jbd/revoke.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/jbd/revoke.c	Sun Sep 30 22:20:01 2001
@@ -299,6 +299,29 @@
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
+#ifdef JBD_EXPENSIVE_CHECKING
+	else {
+		struct buffer_head *bh2;
+
+		/* If there is a different buffer_head lying around in
+		 * memory anywhere... */
+		bh2 = get_hash_table(dev, blocknr, journal->j_blocksize);
+		if (bh2) {
+			/* ... and it has RevokeValid status... */
+			if ((bh2 != bh) &&
+			    test_bit(BH_RevokeValid, &bh2->b_state))
+				/* ...then it better be revoked too,
+				 * since it's illegal to create a revoke
+				 * record against a buffer_head which is
+				 * not marked revoked --- that would
+				 * risk missing a subsequent revoke
+				 * cancel. */
+				J_ASSERT_BH(bh2, test_bit(BH_Revoked, &
+							  bh2->b_state));
+			__brelse(bh2);
+		}
+	}
+#endif
 
 	/* We really ought not ever to revoke twice in a row without
            first having the revoke cancelled: it's illegal to free a
@@ -348,27 +371,51 @@
 	journal_t *journal = handle->h_transaction->t_journal;
 	int need_cancel;
 	int did_revoke = 0;	/* akpm: debug */
+	struct buffer_head *bh = jh2bh(jh);
+	
+	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
 
 	/* Is the existing Revoke bit valid?  If so, we trust it, and
 	 * only perform the full cancel if the revoke bit is set.  If
 	 * not, we can't trust the revoke bit, and we need to do the
 	 * full search for a revoke record. */
-	if (test_and_set_bit(BH_RevokeValid, &jh2bh(jh)->b_state))
-		need_cancel = (test_and_clear_bit(BH_Revoked,
-					&jh2bh(jh)->b_state));
+	if (test_and_set_bit(BH_RevokeValid, &bh->b_state))
+		need_cancel = (test_and_clear_bit(BH_Revoked, &bh->b_state));
 	else {
 		need_cancel = 1;
-		clear_bit(BH_Revoked, &jh2bh(jh)->b_state);
+		clear_bit(BH_Revoked, &bh->b_state);
 	}
 
 	if (need_cancel) {
-		record = find_revoke_record(journal, jh2bh(jh)->b_blocknr);
+		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
+			jbd_debug(4, "cancelled existing revoke on "
+				  "blocknr %lu\n", bh->b_blocknr);
 			list_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 			did_revoke = 1;
 		}
 	}
+
+#ifdef JBD_EXPENSIVE_CHECKING
+	/* There better not be one left behind by now! */
+	record = find_revoke_record(journal, bh->b_blocknr);
+	J_ASSERT_JH(jh, record == NULL);
+#endif
+
+	/* Finally, have we just cleared revoke on an unhashed
+	 * buffer_head?  If so, we'd better make sure we clear the
+	 * revoked status on any hashed alias too, otherwise the revoke
+	 * state machine will get very upset later on. */
+	if (need_cancel && !bh->b_pprev) {
+		struct buffer_head *bh2;
+		bh2 = get_hash_table(bh->b_dev, bh->b_blocknr, bh->b_size);
+		if (bh2) {
+			clear_bit(BH_Revoked, &bh2->b_state);
+			__brelse(bh2);
+		}
+	}
+	
 	return did_revoke;
 }
 
@@ -432,7 +479,7 @@
            still need to go round the loop in
            journal_write_revoke_records in order to free all of the
            revoke records: only the IO to the journal is omitted. */
-	if (is_journal_abort(journal))
+	if (is_journal_aborted(journal))
 		return;
 
 	descriptor = *descriptorp;
@@ -480,7 +527,7 @@
 {
 	journal_revoke_header_t *header;
 
-	if (is_journal_abort(journal)) {
+	if (is_journal_aborted(journal)) {
 		JBUFFER_TRACE(descriptor, "brelse");
 		__brelse(jh2bh(descriptor));
 		return;
diff -urN linux-2.4.10-ac3/fs/jbd/transaction.c linux/fs/jbd/transaction.c
--- linux-2.4.10-ac3/fs/jbd/transaction.c	Sun Sep 30 22:07:02 2001
+++ linux/fs/jbd/transaction.c	Sun Sep 30 22:20:01 2001
@@ -99,7 +99,7 @@
 
 	lock_journal(journal);
 
-	if ((journal->j_flags & JFS_ABORT) ||
+	if (is_journal_aborted(journal) ||
 	    (journal->j_errno != 0 && !(journal->j_flags & JFS_ACK_ERR))) {
 		unlock_journal(journal);
 		return -EROFS; 
@@ -262,7 +262,7 @@
 
 	lock_journal(journal);
 
-	if ((journal->j_flags & JFS_ABORT) ||
+	if (is_journal_aborted(journal) ||
 	    (journal->j_errno != 0 && !(journal->j_flags & JFS_ACK_ERR))) {
 		ret = -EROFS;
 		goto fail_unlock;
@@ -324,12 +324,17 @@
 				handle->h_ref,
 				handle->h_ref + 1);
 		J_ASSERT(handle->h_transaction->t_journal == journal);
+		if (is_handle_aborted(handle))
+			return ERR_PTR(-EIO);
 		handle->h_ref++;
 		return handle;
 	} else {
 		jbd_debug(4, "no current transaction\n");
 	}
 	
+	if (is_journal_aborted(journal))
+		return ERR_PTR(-EIO);
+	
 	handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
@@ -363,17 +368,26 @@
  * extend here.
  *
  * Return 0 on success, non-zero on failure.
+ *
+ * return code < 0 implies an error
+ * return code > 0 implies normal transaction-full status.
  */
 
 int journal_extend (handle_t *handle, int nblocks)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
-	int result = 1;
+	int result;
 	int wanted;
 
 	lock_journal (journal);
 
+	result = -EIO;
+	if (is_handle_aborted(handle))
+		goto error_out;
+
+	result = 1;
+	       
 	/* Don't extend a locked-down transaction! */
 	if (handle->h_transaction->t_state != T_RUNNING) {
 		jbd_debug(3, "denied handle %p %d blocks: "
@@ -423,6 +437,11 @@
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	int ret;
+
+	/* If we've had an abort of any type, don't even think about
+	 * actually doing the restart! */
+	if (is_handle_aborted(handle))
+		return 0;
 	
 	/* First unlink the handle from its current transaction, and
 	 * start the commit on that. */
@@ -518,7 +537,7 @@
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
-	int error = 0;
+	int error;
 	char *frozen_buffer = NULL;
 	int need_copy = 0;
 
@@ -553,7 +572,7 @@
 	 * to be a good reason why they should do this.
 	 */
 	if (jh->b_cp_transaction &&
-			(buffer_locked(jh2bh(jh)) || buffer_dirty(jh2bh(jh)))) {
+	    (buffer_locked(jh2bh(jh)) || buffer_dirty(jh2bh(jh)))) {
 		unlock_journal(journal);
 		lock_buffer(jh2bh(jh));
 		spin_lock(&journal_datalist_lock);
@@ -586,6 +605,11 @@
 
 	J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));
 
+	error = -EROFS;
+	if (is_handle_aborted(handle)) 
+		goto out_unlocked;
+	error = 0;
+
 	spin_lock(&journal_datalist_lock);
 
 	/* The buffer is already part of this transaction if
@@ -711,6 +735,7 @@
            on it is no longer valid. */
 	journal_cancel_revoke(handle, jh);
 
+out_unlocked:
 	if (frozen_buffer)
 		kfree(frozen_buffer);
 
@@ -753,9 +778,15 @@
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	struct journal_head *jh = journal_add_journal_head(bh);
-
+	int err;
+	
 	jbd_debug(5, "journal_head %p\n", jh);
 	lock_journal(journal);
+	err = -EROFS;
+	if (is_handle_aborted(handle))
+		goto out;
+	err = 0;
+	
 	JBUFFER_TRACE(jh, "entry");
 	/* The buffer may already belong to this transaction due to
 	 * pre-zeroing in the filesystem's new_block code.  It may also
@@ -796,8 +827,9 @@
 	JBUFFER_TRACE(jh, "cancelling revoke");
 	journal_cancel_revoke(handle, jh);
 	journal_unlock_journal_head(jh);
+out:
 	unlock_journal(journal);
-	return 0;
+	return err;
 }
 
 
@@ -840,9 +872,10 @@
 	 * make sure that obtaining the committed_data is done
 	 * atomically wrt. completion of any outstanding commits. */
 	err = do_get_write_access (handle, jh, 1);
-
+	if (err)
+		goto out;
+	
 	if (!jh->b_committed_data) {
-
 		/* Copy out the current buffer contents into the
 		 * preserved, committed copy. */
 		JBUFFER_TRACE(jh, "generate b_committed data");
@@ -860,10 +893,10 @@
 	}
 
 out:
-	journal_unlock_journal_head(jh);
-	unlock_journal(journal);
 	if (!err)
 		J_ASSERT_JH(jh, jh->b_committed_data);
+	journal_unlock_journal_head(jh);
+	unlock_journal(journal);
 	return err;
 }
 
@@ -894,8 +927,12 @@
 	journal_t *journal = handle->h_transaction->t_journal;
 	int need_brelse = 0;
 	int wanted_jlist = async ? BJ_AsyncData : BJ_SyncData;
-	struct journal_head *jh = journal_add_journal_head(bh);
+	struct journal_head *jh;
 
+	if (is_handle_aborted(handle))
+		return 0;
+	
+	jh = journal_add_journal_head(bh);
 	JBUFFER_TRACE(jh, "entry");
 
 	/*
@@ -1035,12 +1072,12 @@
 	}
 no_journal:
 	spin_unlock(&journal_datalist_lock);
-	journal_unlock_journal_head(jh);
-	JBUFFER_TRACE(jh, "exit");
 	if (need_brelse) {
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
 	}
+	JBUFFER_TRACE(jh, "exit");
+	journal_unlock_journal_head(jh);
 	return 0;
 }
 
@@ -1069,7 +1106,9 @@
 	jbd_debug(5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 	lock_journal(journal);
-
+	if (is_handle_aborted(handle))
+		goto out_unlock;
+	
 	spin_lock(&journal_datalist_lock);
 	set_bit(BH_JBDDirty, &bh->b_state);
 	set_buffer_flushtime(bh);
@@ -1104,6 +1143,7 @@
 done_locked:
 	spin_unlock(&journal_datalist_lock);
 	JBUFFER_TRACE(jh, "exit");
+out_unlock:
 	unlock_journal(journal);
 	return 0;
 }
@@ -1154,6 +1194,9 @@
  * buffer which came off the hashtable.  Check for this.
  *
  * Decrements bh->b_count by one.
+ * 
+ * Allow this call even if the handle has aborted --- it may be part of
+ * the caller's cleanup after an abort.
  */
 
 void journal_forget (handle_t *handle, struct buffer_head *bh)
@@ -1307,22 +1350,28 @@
  * return -EIO if a journal_abort has been executed since the
  * transaction began.
  */
+
 int journal_stop(handle_t *handle)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
-	int old_handle_count;
-
+	int old_handle_count, err;
+	
 	if (!handle)
 		return 0;
 
 	J_ASSERT (transaction->t_updates > 0);
 	J_ASSERT (journal_current_handle() == handle);
 	
+	if (is_handle_aborted(handle))
+		err = -EIO;
+	else
+		err = 0;
+	
 	if (--handle->h_ref > 0) {
 		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
 			  handle->h_ref);
-		return 0;
+		return err;
 	}
 
 	jbd_debug(4, "Handle %p going down\n", handle);
@@ -1364,6 +1413,9 @@
 			transaction->t_outstanding_credits >
 				journal->j_max_transaction_buffers ||
 	    		time_after_eq(jiffies, transaction->t_expires)) {
+		/* Do this even for aborted journals: an abort still
+		 * completes the commit thread, it just doesn't write
+		 * anything to disk. */
 		tid_t tid = transaction->t_tid;
 		
 		jbd_debug(2, "transaction too old, requesting commit for "
@@ -1379,7 +1431,7 @@
 			log_wait_commit(journal, tid);
 	}
 	kfree(handle);
-	return 0;
+	return err;
 }
 
 /*
@@ -1992,9 +2044,30 @@
 	}
 }
 
+/*
+ * For the unlocked version of this call, also make sure that any
+ * hanging journal_head is cleaned up if necessary.
+ *
+ * __journal_refile_buffer is usually called as part of a single locked
+ * operation on a buffer_head, in which the caller is probably going to
+ * be hooking the journal_head onto other lists.  In that case it is up
+ * to the caller to remove the journal_head if necessary.  For the
+ * unlocked journal_refile_buffer call, the caller isn't going to be
+ * doing anything else to the buffer so we need to do the cleanup
+ * ourselves to avoid a jh leak. 
+ *
+ * *** The journal_head may be freed by this call! ***
+ */
 void journal_refile_buffer(struct journal_head *jh)
 {
+	struct buffer_head *bh;
+
 	spin_lock(&journal_datalist_lock);
+	bh = jh2bh(jh);
+
 	__journal_refile_buffer(jh);
+	__journal_remove_journal_head(bh);
+
 	spin_unlock(&journal_datalist_lock);
+	__brelse(bh);
 }
diff -urN linux-2.4.10-ac3/include/linux/ext3_fs.h linux/include/linux/ext3_fs.h
--- linux-2.4.10-ac3/include/linux/ext3_fs.h	Sun Sep 30 22:07:03 2001
+++ linux/include/linux/ext3_fs.h	Sun Sep 30 22:20:01 2001
@@ -36,8 +36,8 @@
 /*
  * The second extended file system version
  */
-#define EXT3FS_DATE		"11 Aug 2001"
-#define EXT3FS_VERSION		"2.4-0.9.6"
+#define EXT3FS_DATE		"5 Sep 2001"
+#define EXT3FS_VERSION		"2.4-0.9.9"
 
 /*
  * Debug code
@@ -661,8 +661,8 @@
 
 /* namei.c */
 extern struct inode_operations ext3_dir_inode_operations;
-extern void ext3_orphan_add(handle_t *, struct inode *);
-extern void ext3_orphan_del(handle_t *, struct inode *);
+extern int ext3_orphan_add(handle_t *, struct inode *);
+extern int ext3_orphan_del(handle_t *, struct inode *);
 
 /* super.c */
 extern void ext3_error (struct super_block *, const char *, const char *, ...)
@@ -692,6 +692,7 @@
 	if ((errno))						\
 		__ext3_std_error((sb), __FUNCTION__, (errno));	\
 } while (0)
+extern const char *ext3_decode_error(struct super_block *sb, int errno);
 
 /*
  * Inodes and files operations
diff -urN linux-2.4.10-ac3/include/linux/ext3_fs_i.h linux/include/linux/ext3_fs_i.h
--- linux-2.4.10-ac3/include/linux/ext3_fs_i.h	Sun Sep 30 22:07:03 2001
+++ linux/include/linux/ext3_fs_i.h	Sun Sep 30 22:20:26 2001
@@ -41,6 +41,7 @@
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
 #endif
+	__u32	i_dir_start_lookup;
 	
 	struct list_head i_orphan;	/* unlinked but open inodes */
 
diff -urN linux-2.4.10-ac3/include/linux/ext3_jbd.h linux/include/linux/ext3_jbd.h
--- linux-2.4.10-ac3/include/linux/ext3_jbd.h	Sun Sep 30 22:07:03 2001
+++ linux/include/linux/ext3_jbd.h	Sun Sep 30 22:20:01 2001
@@ -84,22 +84,57 @@
  * ext2 filesystems, so ext2+ext3 systems only nee one fs.  This work hasn't
  * been done yet.
  */
+
+static inline void ext3_journal_abort_handle(const char *caller, 
+					     const char *err_fn,
+					     struct buffer_head *bh,
+					     handle_t *handle,
+					     int err)
+{
+	const char *errstr = ext3_decode_error(NULL, err);
+	
+	printk(KERN_ERR "%s: aborting transaction", caller);
+	if (errstr)
+		printk(": %s", errstr);
+	else
+		printk(" due to error %d", err);
+	printk(" in %s\n", err_fn);
+
+	if (bh)
+		BUFFER_TRACE(bh, "abort");
+	journal_abort_handle(handle);
+	if (!handle->h_err)
+		handle->h_err = err;
+}
+
 static inline int
-ext3_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
+__ext3_journal_get_undo_access(const char *where,
+			       handle_t *handle, struct buffer_head *bh)
 {
-	return journal_get_undo_access(handle, bh);
+	int err = journal_get_undo_access(handle, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline int
-ext3_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
+__ext3_journal_get_write_access(const char *where,
+				handle_t *handle, struct buffer_head *bh)
 {
-	return journal_get_write_access(handle, bh);
+	int err = journal_get_write_access(handle, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline int
-ext3_journal_dirty_data(handle_t *handle, struct buffer_head *bh, int async)
+__ext3_journal_dirty_data(const char *where,
+			  handle_t *handle, struct buffer_head *bh, int async)
 {
-	return journal_dirty_data(handle, bh, async);
+	int err = journal_dirty_data(handle, bh, async);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline void
@@ -109,24 +144,51 @@
 }
 
 static inline int
-ext3_journal_revoke(handle_t *handle,
-			unsigned long blocknr, struct buffer_head *bh)
+__ext3_journal_revoke(const char *where, handle_t *handle,
+		      unsigned long blocknr, struct buffer_head *bh)
 {
-	return journal_revoke(handle, blocknr, bh);
+	int err = journal_revoke(handle, blocknr, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline int
-ext3_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
+__ext3_journal_get_create_access(const char *where,
+				 handle_t *handle, struct buffer_head *bh)
 {
-	return journal_get_create_access(handle, bh);
+	int err = journal_get_create_access(handle, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline int
-ext3_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
+__ext3_journal_dirty_metadata(const char *where,
+			      handle_t *handle, struct buffer_head *bh)
 {
-	return journal_dirty_metadata(handle, bh);
+	int err = journal_dirty_metadata(handle, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
+
+#define ext3_journal_get_undo_access(handle, bh) \
+	__ext3_journal_get_undo_access(__FUNCTION__, (handle), (bh))
+#define ext3_journal_get_write_access(handle, bh) \
+	__ext3_journal_get_write_access(__FUNCTION__, (handle), (bh))
+#define ext3_journal_dirty_data(handle, bh, async) \
+	__ext3_journal_dirty_data(__FUNCTION__, (handle), (bh), (async))
+#define ext3_journal_revoke(handle, blocknr, bh) \
+	__ext3_journal_revoke(__FUNCTION__, (handle), (blocknr), (bh))
+#define ext3_journal_get_create_access(handle, bh) \
+	__ext3_journal_get_create_access(__FUNCTION__, (handle), (bh))
+#define ext3_journal_dirty_metadata(handle, bh) \
+	__ext3_journal_dirty_metadata(__FUNCTION__, (handle), (bh))
+
+
+
 /* 
  * Wrappers for journal_start/end.
  *
@@ -156,12 +218,21 @@
  * that sync() will call the filesystem's write_super callback if
  * appropriate. 
  */
-static inline int ext3_journal_stop(handle_t *handle, struct inode *inode)
+static inline int __ext3_journal_stop(const char *where,
+				      handle_t *handle, struct inode *inode)
 {
+	int err = handle->h_err;
 	int rc = journal_stop(handle);
+
 	inode->i_sb->s_dirt = 1;
-	return rc;
+	if (!err)
+		err = rc;
+	if (err)
+		__ext3_std_error(inode->i_sb, where, err);
+	return err;
 }
+#define ext3_journal_stop(handle, inode) \
+	__ext3_journal_stop(__FUNCTION__, (handle), (inode))
 
 static inline handle_t *ext3_journal_current_handle(void)
 {
diff -urN linux-2.4.10-ac3/include/linux/jbd.h linux/include/linux/jbd.h
--- linux-2.4.10-ac3/include/linux/jbd.h	Sun Sep 30 22:07:03 2001
+++ linux/include/linux/jbd.h	Sun Sep 30 22:20:01 2001
@@ -33,6 +33,13 @@
 extern int journal_oom_retry;
 
 #ifdef CONFIG_JBD_DEBUG
+/*
+ * Define JBD_EXPENSIVE_CHECKING to enable more expensive internal
+ * consistency checks.  By default we don't do this unless
+ * CONFIG_JBD_DEBUG is on.
+ */
+#define JBD_EXPENSIVE_CHECKING
+
 extern int journal_enable_debug;
 extern int journal_no_write[2];
 
@@ -270,9 +277,14 @@
 	/* Reference count on this handle */
 	int			h_ref;
 
+	/* Field for caller's use to track errors through large fs
+	   operations */
+	int			h_err;
+
 	/* Flags */
 	unsigned int	h_sync:		1;	/* sync-on-close */
 	unsigned int	h_jdata:	1;	/* force data journaling */
+	unsigned int	h_aborted:	1;	/* fatal error on handle */
 };
 
 
@@ -698,7 +710,7 @@
  */
 
 extern int	log_space_left (journal_t *); /* Called with journal locked */
-extern void	log_start_commit (journal_t *, transaction_t *);
+extern tid_t	log_start_commit (journal_t *, transaction_t *);
 extern void	log_wait_commit (journal_t *, tid_t);
 extern int	log_do_checkpoint (journal_t *, int);
 
@@ -728,11 +740,23 @@
  * transactions.  
  */
 
-static inline int is_journal_abort(journal_t *journal)
+static inline int is_journal_aborted(journal_t *journal)
 {
 	return journal->j_flags & JFS_ABORT;
 }
 
+static inline int is_handle_aborted(handle_t *handle)
+{
+	if (handle->h_aborted)
+		return 1;
+	return is_journal_aborted(handle->h_transaction->t_journal);
+}
+
+static inline void journal_abort_handle(handle_t *handle)
+{
+	handle->h_aborted = 1;
+}
+
 /* Not all architectures define BUG() */
 #ifndef BUG
  #define BUG() do { \
diff -urN linux-2.4.10-ac3/mm/filemap.c linux/mm/filemap.c
--- linux-2.4.10-ac3/mm/filemap.c	Sun Sep 30 22:07:02 2001
+++ linux/mm/filemap.c	Sun Sep 30 22:20:01 2001
@@ -199,31 +199,28 @@
 	spin_unlock(&pagecache_lock);
 }
 
-static inline void truncate_partial_page(struct page *page, unsigned partial)
+static int do_flushpage(struct page *page, unsigned long offset)
 {
 	int (*flushpage) (struct page *, unsigned long);
-	
 	flushpage = page->mapping->a_ops->flushpage;
-	if (!flushpage)
-		flushpage = block_flushpage;
-	
- 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
- 	if (page->buffers)
-		flushpage(page, partial);
+	if (flushpage)
+		return (*flushpage)(page, offset);
+	return block_flushpage(page, offset);
+}
+
+static inline void truncate_partial_page(struct page *page, unsigned partial)
+{
+	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
+	if (page->buffers)
+		do_flushpage(page, partial);
 }
 
 static inline void truncate_complete_page(struct page *page)
 {
-	int (*flushpage) (struct page *, unsigned long);
-	
-	flushpage = page->mapping->a_ops->flushpage;
-	if (!flushpage)
-		flushpage = block_flushpage;
-	
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->buffers || flushpage(page, 0))
+	if (!page->buffers || do_flushpage(page, 0))
 		lru_cache_del(page);
- 
+
 	/*
 	 * We remove the page from the page cache _after_ we have
 	 * destroyed all buffer-cache references to it. Otherwise some
@@ -2637,6 +2634,7 @@
 
 	while (count) {
 		unsigned long index, offset;
+		long page_fault;
 		char *kaddr;
 		int deactivate = 1;
 
@@ -2677,14 +2675,11 @@
 		if (status)
 			goto sync_failure;
 		kaddr = page_address(page);
-		status = __copy_from_user(kaddr+offset, buf, bytes);
+		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
-		if (status) {
-			if (mapping->a_ops->abort_write)
-				mapping->a_ops->abort_write(file, page);
-			goto fail_write;
-		}
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
+		if (page_fault)
+			goto fail_write;
 		if (!status)
 			status = bytes;
 
@@ -2728,7 +2723,6 @@
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	kunmap(page);
 	goto unlock;
 sync_failure:
 	UnlockPage(page);

--=-X24+Onm+VZF76IPc4T0I--

