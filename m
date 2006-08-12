Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHLAFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHLAFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHLAFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:05:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22715 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932432AbWHLAFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:05:12 -0400
Subject: [PATCH 2/2] ext3 and jbd cleanup: replace brelse() to put_bh
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060811161655.0ad11259.akpm@osdl.org>
References: <1155172827.3161.80.camel@localhost.localdomain>
	 <20060809233940.50162afb.akpm@osdl.org> <20060810171755.GA19238@thunk.org>
	 <20060810110047.af273a55.akpm@osdl.org>
	 <1155334389.3765.18.camel@dyn9047017069.beaverton.ibm.com>
	 <20060811161655.0ad11259.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 11 Aug 2006 17:05:08 -0700
Message-Id: <1155341108.20600.8.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Aug 09, 2006 at 11:39:40PM -0700, Andrew Morton wrote:
> > > - replace all brelse() calls with put_bh().  Because brelse() is
> > >   old-fashioned, has a weird name and neelessly permits a NULL
arg.
> > > 
> > >   In fact it would be beter to convert JBD and ext3 to put_bh
before
> > >   copying it all over.


Here is the patch.

Signed-Off-By: Mingming Cao<cmm@us.ibm.com>
---

 linux-2.6.18-rc4-ming/fs/ext3/balloc.c     |   18 +++++-----
 linux-2.6.18-rc4-ming/fs/ext3/ialloc.c     |   14 ++++----
 linux-2.6.18-rc4-ming/fs/ext3/inode.c      |   24 +++++++-------
 linux-2.6.18-rc4-ming/fs/ext3/namei.c      |   48 ++++++++++++++---------------
 linux-2.6.18-rc4-ming/fs/ext3/resize.c     |   34 ++++++++++----------
 linux-2.6.18-rc4-ming/fs/ext3/super.c      |   20 ++++++------
 linux-2.6.18-rc4-ming/fs/ext3/xattr.c      |   18 +++++-----
 linux-2.6.18-rc4-ming/fs/jbd/checkpoint.c  |   12 +++----
 linux-2.6.18-rc4-ming/fs/jbd/commit.c      |   10 +++---
 linux-2.6.18-rc4-ming/fs/jbd/journal.c     |   14 ++++----
 linux-2.6.18-rc4-ming/fs/jbd/recovery.c    |   30 +++++++++---------
 linux-2.6.18-rc4-ming/fs/jbd/revoke.c      |    6 +--
 linux-2.6.18-rc4-ming/fs/jbd/transaction.c |   14 ++++----
 13 files changed, 131 insertions(+), 131 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_replace_brelse_to_put_bh fs/ext3/balloc.c
--- linux-2.6.18-rc4/fs/ext3/balloc.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:19.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/balloc.c	2006-08-11 16:01:06.549638409 -0700
@@ -351,7 +351,7 @@ do_more:
 		overflow = bit + count - EXT3_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
 	}
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	bitmap_bh = read_block_bitmap(sb, block_group);
 	if (!bitmap_bh)
 		goto error_return;
@@ -407,7 +407,7 @@ do_more:
 					BUFFER_TRACE(debug_bh,
 						"No commited data in bitmap");
 				BUFFER_TRACE2(debug_bh, bitmap_bh, "bitmap");
-				__brelse(debug_bh);
+				put_bh(debug_bh);
 			}
 		}
 		jbd_lock_bh_state(bitmap_bh);
@@ -485,7 +485,7 @@ do_more:
 	}
 	sb->s_dirt = 1;
 error_return:
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	ext3_std_error(sb, err);
 	return;
 }
@@ -1324,7 +1324,7 @@ retry:
 		if (free_blocks <= (windowsz/2))
 			continue;
 
-		brelse(bitmap_bh);
+		put_bh(bitmap_bh);
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
@@ -1389,7 +1389,7 @@ allocated:
 		if (debug_bh) {
 			BUFFER_TRACE(debug_bh, "state when allocated");
 			BUFFER_TRACE2(debug_bh, bitmap_bh, "bitmap state");
-			brelse(debug_bh);
+			put_bh(debug_bh);
 		}
 	}
 	jbd_lock_bh_state(bitmap_bh);
@@ -1442,7 +1442,7 @@ allocated:
 		goto out;
 
 	*errp = 0;
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	DQUOT_FREE_BLOCK(inode, *count-num);
 	*count = num;
 	return ret_block;
@@ -1459,7 +1459,7 @@ out:
 	 */
 	if (!performed_allocation)
 		DQUOT_FREE_BLOCK(inode, *count);
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	return 0;
 }
 
@@ -1494,7 +1494,7 @@ ext3_fsblk_t ext3_count_free_blocks(stru
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		brelse(bitmap_bh);
+		put_bh(bitmap_bh);
 		bitmap_bh = read_block_bitmap(sb, i);
 		if (bitmap_bh == NULL)
 			continue;
@@ -1504,7 +1504,7 @@ ext3_fsblk_t ext3_count_free_blocks(stru
 			i, le16_to_cpu(gdp->bg_free_blocks_count), x);
 		bitmap_count += x;
 	}
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	printk("ext3_count_free_blocks: stored = "E3FSBLK
 		", computed = "E3FSBLK", "E3FSBLK"\n",
 	       le32_to_cpu(es->s_free_blocks_count),
diff -puN fs/ext3/ialloc.c~ext3_replace_brelse_to_put_bh fs/ext3/ialloc.c
--- linux-2.6.18-rc4/fs/ext3/ialloc.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:19.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/ialloc.c	2006-08-11 16:01:06.655626188 -0700
@@ -185,7 +185,7 @@ void ext3_free_inode (handle_t *handle, 
 		fatal = err;
 	sb->s_dirt = 1;
 error_return:
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	ext3_std_error(sb, fatal);
 }
 
@@ -468,7 +468,7 @@ struct inode *ext3_new_inode(handle_t *h
 		if (!gdp)
 			goto fail;
 
-		brelse(bitmap_bh);
+		put_bh(bitmap_bh);
 		bitmap_bh = read_inode_bitmap(sb, group);
 		if (!bitmap_bh)
 			goto fail;
@@ -625,7 +625,7 @@ out:
 	iput(inode);
 	ret = ERR_PTR(err);
 really_out:
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	return ret;
 
 fail_free_drop:
@@ -636,7 +636,7 @@ fail_drop:
 	inode->i_flags |= S_NOQUOTA;
 	inode->i_nlink = 0;
 	iput(inode);
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	return ERR_PTR(err);
 }
 
@@ -692,7 +692,7 @@ struct inode *ext3_orphan_get(struct sup
 		inode = NULL;
 	}
 out:
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	return inode;
 }
 
@@ -715,7 +715,7 @@ unsigned long ext3_count_free_inodes (st
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		brelse(bitmap_bh);
+		put_bh(bitmap_bh);
 		bitmap_bh = read_inode_bitmap(sb, i);
 		if (!bitmap_bh)
 			continue;
@@ -725,7 +725,7 @@ unsigned long ext3_count_free_inodes (st
 			i, le16_to_cpu(gdp->bg_free_inodes_count), x);
 		bitmap_count += x;
 	}
-	brelse(bitmap_bh);
+	put_bh(bitmap_bh);
 	printk("ext3_count_free_inodes: stored = %u, computed = %lu, %lu\n",
 		le32_to_cpu(es->s_free_inodes_count), desc_count, bitmap_count);
 	return desc_count;
diff -puN fs/ext3/inode.c~ext3_replace_brelse_to_put_bh fs/ext3/inode.c
--- linux-2.6.18-rc4/fs/ext3/inode.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:19.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/inode.c	2006-08-11 16:01:06.748615465 -0700
@@ -378,7 +378,7 @@ static Indirect *ext3_get_branch(struct 
 	return NULL;
 
 changed:
-	brelse(bh);
+	put_bh(bh);
 	*err = -EAGAIN;
 	goto no_block;
 failure:
@@ -624,7 +624,7 @@ static int ext3_alloc_branch(handle_t *h
 		err = ext3_journal_get_create_access(handle, bh);
 		if (err) {
 			unlock_buffer(bh);
-			brelse(bh);
+			put_bh(bh);
 			goto failed;
 		}
 
@@ -863,7 +863,7 @@ int ext3_get_blocks_handle(handle_t *han
 	 */
 	if (err == -EAGAIN || !verify_chain(chain, partial)) {
 		while (partial > chain) {
-			brelse(partial->bh);
+			put_bh(partial->bh);
 			partial--;
 		}
 		partial = ext3_get_branch(inode, depth, offsets, chain, &err);
@@ -933,7 +933,7 @@ got_it:
 cleanup:
 	while (partial > chain) {
 		BUFFER_TRACE(partial->bh, "call brelse");
-		brelse(partial->bh);
+		put_bh(partial->bh);
 		partial--;
 	}
 	BUFFER_TRACE(bh_result, "returned");
@@ -1051,7 +1051,7 @@ struct buffer_head *ext3_getblk(handle_t
 		}
 		if (fatal) {
 			*errp = fatal;
-			brelse(bh);
+			put_bh(bh);
 			bh = NULL;
 		}
 		return bh;
@@ -1943,7 +1943,7 @@ static Indirect *ext3_find_shared(struct
 	/* Writer: end */
 
 	while(partial > p) {
-		brelse(partial->bh);
+		put_bh(partial->bh);
 		partial--;
 	}
 no_top:
@@ -2133,7 +2133,7 @@ static void ext3_free_branches(handle_t 
 			 * That's easy if it's exclusively part of this
 			 * transaction.  But if it's part of the committing
 			 * transaction then journal_forget() will simply
-			 * brelse() it.  That means that if the underlying
+			 * put_bh() it.  That means that if the underlying
 			 * block is reallocated in ext3_get_block(),
 			 * unmap_underlying_metadata() will find this block
 			 * and will try to get rid of it.  damn, damn.
@@ -2510,7 +2510,7 @@ static int __ext3_get_inode_loc(struct i
 			 * of one, so skip it.
 			 */
 			if (!buffer_uptodate(bitmap_bh)) {
-				brelse(bitmap_bh);
+				put_bh(bitmap_bh);
 				goto make_io;
 			}
 			for (i = start; i < start + inodes_per_buffer; i++) {
@@ -2519,7 +2519,7 @@ static int __ext3_get_inode_loc(struct i
 				if (ext3_test_bit(i, bitmap_bh->b_data))
 					break;
 			}
-			brelse(bitmap_bh);
+			put_bh(bitmap_bh);
 			if (i == start + inodes_per_buffer) {
 				/* all other inodes are free, so skip I/O */
 				memset(bh->b_data, 0, bh->b_size);
@@ -2544,7 +2544,7 @@ make_io:
 					"unable to read inode block - "
 					"inode=%lu, block="E3FSBLK,
 					inode->i_ino, block);
-			brelse(bh);
+			put_bh(bh);
 			return -EIO;
 		}
 	}
@@ -3056,7 +3056,7 @@ ext3_reserve_inode_write(handle_t *handl
 			BUFFER_TRACE(iloc->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle, iloc->bh);
 			if (err) {
-				brelse(iloc->bh);
+				put_bh(iloc->bh);
 				iloc->bh = NULL;
 			}
 		}
@@ -3156,7 +3156,7 @@ static int ext3_pin_inode(handle_t *hand
 			if (!err)
 				err = ext3_journal_dirty_metadata(handle,
 								  iloc.bh);
-			brelse(iloc.bh);
+			put_bh(iloc.bh);
 		}
 	}
 	ext3_std_error(inode->i_sb, err);
diff -puN fs/ext3/namei.c~ext3_replace_brelse_to_put_bh fs/ext3/namei.c
--- linux-2.6.18-rc4/fs/ext3/namei.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:19.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/namei.c	2006-08-11 16:01:06.838605088 -0700
@@ -349,7 +349,7 @@ dx_probe(struct dentry *dentry, struct i
 		ext3_warning(dir->i_sb, __FUNCTION__,
 			     "Unrecognised inode hash code %d",
 			     root->info.hash_version);
-		brelse(bh);
+		put_bh(bh);
 		*err = ERR_BAD_DX_DIR;
 		goto fail;
 	}
@@ -363,7 +363,7 @@ dx_probe(struct dentry *dentry, struct i
 		ext3_warning(dir->i_sb, __FUNCTION__,
 			     "Unimplemented inode hash flags: %#06x",
 			     root->info.unused_flags);
-		brelse(bh);
+		put_bh(bh);
 		*err = ERR_BAD_DX_DIR;
 		goto fail;
 	}
@@ -372,7 +372,7 @@ dx_probe(struct dentry *dentry, struct i
 		ext3_warning(dir->i_sb, __FUNCTION__,
 			     "Unimplemented inode hash depth: %#06x",
 			     root->info.indirect_levels);
-		brelse(bh);
+		put_bh(bh);
 		*err = ERR_BAD_DX_DIR;
 		goto fail;
 	}
@@ -428,7 +428,7 @@ dx_probe(struct dentry *dentry, struct i
 	}
 fail2:
 	while (frame >= frame_in) {
-		brelse(frame->bh);
+		put_bh(frame->bh);
 		frame--;
 	}
 fail:
@@ -441,8 +441,8 @@ static void dx_release (struct dx_frame 
 		return;
 
 	if (((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels)
-		brelse(frames[1].bh);
-	brelse(frames[0].bh);
+		put_bh(frames[1].bh);
+	put_bh(frames[0].bh);
 }
 
 /*
@@ -560,12 +560,12 @@ static int htree_dirblock_to_tree(struct
 			continue;
 		if ((err = ext3_htree_store_dirent(dir_file,
 				   hinfo->hash, hinfo->minor_hash, de)) != 0) {
-			brelse(bh);
+			put_bh(bh);
 			return err;
 		}
 		count++;
 	}
-	brelse(bh);
+	put_bh(bh);
 	return count;
 }
 
@@ -802,7 +802,7 @@ static inline int search_dirblock(struct
  * entry - you'll have to do that yourself if you want to.
  *
  * The returned buffer_head has ->b_count elevated.  The caller is expected
- * to brelse() it when appropriate.
+ * to put_bh() it when appropriate.
  */
 static struct buffer_head * ext3_find_entry (struct dentry *dentry,
 					struct ext3_dir_entry_2 ** res_dir)
@@ -880,7 +880,7 @@ restart:
 			/* read error, skip block & hope for the best */
 			ext3_error(sb, __FUNCTION__, "reading directory #%lu "
 				   "offset %lu", dir->i_ino, block);
-			brelse(bh);
+			put_bh(bh);
 			goto next;
 		}
 		i = search_dirblock(bh, dir, dentry,
@@ -890,7 +890,7 @@ restart:
 			ret = bh;
 			goto cleanup_and_exit;
 		} else {
-			brelse(bh);
+			put_bh(bh);
 			if (i < 0)
 				goto cleanup_and_exit;
 		}
@@ -1032,7 +1032,7 @@ struct dentry *ext3_get_parent(struct de
 	if (!bh)
 		return ERR_PTR(-ENOENT);
 	ino = le32_to_cpu(de->inode);
-	brelse(bh);
+	put_bh(bh);
 
 	if (!ext3_valid_inum(child->d_inode->i_sb, ino)) {
 		ext3_error(child->d_inode->i_sb, "ext3_get_parent",
@@ -1128,7 +1128,7 @@ static struct ext3_dir_entry_2 *do_split
 
 	bh2 = ext3_append (handle, dir, &newblock, error);
 	if (!(bh2)) {
-		brelse(*bh);
+		put_bh(*bh);
 		*bh = NULL;
 		goto errout;
 	}
@@ -1137,8 +1137,8 @@ static struct ext3_dir_entry_2 *do_split
 	err = ext3_journal_get_write_access(handle, *bh);
 	if (err) {
 	journal_error:
-		brelse(*bh);
-		brelse(bh2);
+		put_bh(*bh);
+		put_bh(bh2);
 		*bh = NULL;
 		ext3_std_error(dir->i_sb, err);
 		goto errout;
@@ -1242,7 +1242,7 @@ static int add_dirent_to_buf(handle_t *h
 	err = ext3_journal_get_write_access(handle, bh);
 	if (err) {
 		ext3_std_error(dir->i_sb, err);
-		brelse(bh);
+		put_bh(bh);
 		return err;
 	}
 
@@ -1282,7 +1282,7 @@ static int add_dirent_to_buf(handle_t *h
 	err = ext3_journal_dirty_metadata(handle, bh);
 	if (err)
 		ext3_std_error(dir->i_sb, err);
-	brelse(bh);
+	put_bh(bh);
 	return 0;
 }
 
@@ -1315,14 +1315,14 @@ static int make_indexed_dir(handle_t *ha
 	retval = ext3_journal_get_write_access(handle, bh);
 	if (retval) {
 		ext3_std_error(dir->i_sb, retval);
-		brelse(bh);
+		put_bh(bh);
 		return retval;
 	}
 	root = (struct dx_root *) bh->b_data;
 
 	bh2 = ext3_append (handle, dir, &block, &retval);
 	if (!(bh2)) {
-		brelse(bh);
+		put_bh(bh);
 		return retval;
 	}
 	EXT3_I(dir)->i_flags |= EXT3_INDEX_FL;
@@ -1420,7 +1420,7 @@ static int ext3_add_entry (handle_t *han
 		    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_DIR_INDEX))
 			return make_indexed_dir(handle, dentry, inode, bh);
 #endif
-		brelse(bh);
+		put_bh(bh);
 	}
 	bh = ext3_append(handle, dir, &block, &retval);
 	if (!bh)
@@ -1562,7 +1562,7 @@ journal_error:
 	ext3_std_error(dir->i_sb, err);
 cleanup:
 	if (bh)
-		brelse(bh);
+		put_bh(bh);
 	dx_release(frames);
 	return err;
 }
@@ -1999,7 +1999,7 @@ out:
 	return err;
 
 out_brelse:
-	brelse(iloc.bh);
+	put_bh(iloc.bh);
 	goto out_err;
 }
 
@@ -2285,7 +2285,7 @@ static int ext3_rename (struct inode * o
 		new_dir->i_version++;
 		BUFFER_TRACE(new_bh, "call ext3_journal_dirty_metadata");
 		ext3_journal_dirty_metadata(handle, new_bh);
-		brelse(new_bh);
+		put_bh(new_bh);
 		new_bh = NULL;
 	}
 
@@ -2315,7 +2315,7 @@ static int ext3_rename (struct inode * o
 		if (old_bh2) {
 			retval = ext3_delete_entry(handle, old_dir,
 						   old_de2, old_bh2);
-			brelse(old_bh2);
+			put_bh(old_bh2);
 		}
 	}
 	if (retval) {
diff -puN fs/ext3/resize.c~ext3_replace_brelse_to_put_bh fs/ext3/resize.c
--- linux-2.6.18-rc4/fs/ext3/resize.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:19.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/resize.c	2006-08-11 16:01:06.877600591 -0700
@@ -109,7 +109,7 @@ static int verify_group_input(struct sup
 			     input->inode_table, itend - 1, start, metaend - 1);
 	else
 		err = 0;
-	brelse(bh);
+	put_bh(bh);
 
 	return err;
 }
@@ -124,7 +124,7 @@ static struct buffer_head *bclean(handle
 	if (!bh)
 		return ERR_PTR(-EIO);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
-		brelse(bh);
+		put_bh(bh);
 		bh = ERR_PTR(err);
 	} else {
 		lock_buffer(bh);
@@ -211,7 +211,7 @@ static int setup_new_group_blocks(struct
 			goto exit_bh;
 		}
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
-			brelse(gdb);
+			put_bh(gdb);
 			goto exit_bh;
 		}
 		lock_buffer(bh);
@@ -220,7 +220,7 @@ static int setup_new_group_blocks(struct
 		unlock_buffer(bh);
 		ext3_journal_dirty_metadata(handle, gdb);
 		ext3_set_bit(bit, bh->b_data);
-		brelse(gdb);
+		put_bh(gdb);
 	}
 
 	/* Zero out all of the reserved backup group descriptor table blocks */
@@ -236,7 +236,7 @@ static int setup_new_group_blocks(struct
 		}
 		ext3_journal_dirty_metadata(handle, gdb);
 		ext3_set_bit(bit, bh->b_data);
-		brelse(gdb);
+		put_bh(gdb);
 	}
 	ext3_debug("mark block bitmap %#04x (+%ld)\n", input->block_bitmap,
 		   input->block_bitmap - start);
@@ -256,13 +256,13 @@ static int setup_new_group_blocks(struct
 			goto exit_bh;
 		}
 		ext3_journal_dirty_metadata(handle, it);
-		brelse(it);
+		put_bh(it);
 		ext3_set_bit(bit, bh->b_data);
 	}
 	mark_bitmap_end(input->blocks_count, EXT3_BLOCKS_PER_GROUP(sb),
 			bh->b_data);
 	ext3_journal_dirty_metadata(handle, bh);
-	brelse(bh);
+	put_bh(bh);
 
 	/* Mark unused entries in inode bitmap used */
 	ext3_debug("clear inode bitmap %#04x (+%ld)\n",
@@ -276,7 +276,7 @@ static int setup_new_group_blocks(struct
 			bh->b_data);
 	ext3_journal_dirty_metadata(handle, bh);
 exit_bh:
-	brelse(bh);
+	put_bh(bh);
 
 exit_journal:
 	unlock_super(sb);
@@ -459,7 +459,7 @@ static int add_new_gdb(handle_t *handle,
 	 */
 	data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)] = 0;
 	ext3_journal_dirty_metadata(handle, dind);
-	brelse(dind);
+	put_bh(dind);
 	inode->i_blocks -= (gdbackups + 1) * sb->s_blocksize >> 9;
 	ext3_mark_iloc_dirty(handle, inode, &iloc);
 	memset((*primary)->b_data, 0, sb->s_blocksize);
@@ -481,7 +481,7 @@ static int add_new_gdb(handle_t *handle,
 
 exit_inode:
 	//ext3_journal_release_buffer(handle, iloc.bh);
-	brelse(iloc.bh);
+	put_bh(iloc.bh);
 exit_dindj:
 	//ext3_journal_release_buffer(handle, dind);
 exit_primary:
@@ -489,9 +489,9 @@ exit_primary:
 exit_sbh:
 	//ext3_journal_release_buffer(handle, *primary);
 exit_dind:
-	brelse(dind);
+	put_bh(dind);
 exit_bh:
-	brelse(*primary);
+	put_bh(*primary);
 
 	ext3_debug("leaving with error %d\n", err);
 	return err;
@@ -555,7 +555,7 @@ static int reserve_backup_gdb(handle_t *
 			goto exit_bh;
 		}
 		if ((gdbackups = verify_reserved_gdb(sb, primary[res])) < 0) {
-			brelse(primary[res]);
+			put_bh(primary[res]);
 			err = gdbackups;
 			goto exit_bh;
 		}
@@ -598,8 +598,8 @@ static int reserve_backup_gdb(handle_t *
 
 exit_bh:
 	while (--res >= 0)
-		brelse(primary[res]);
-	brelse(dind);
+		put_bh(primary[res]);
+	put_bh(dind);
 
 exit_free:
 	kfree(primary);
@@ -668,7 +668,7 @@ static void update_backups(struct super_
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		ext3_journal_dirty_metadata(handle, bh);
-		brelse(bh);
+		put_bh(bh);
 	}
 	if ((err2 = ext3_journal_stop(handle)) && !err)
 		err = err2;
@@ -974,7 +974,7 @@ int ext3_group_extend(struct super_block
 			     "can't read last block, resize aborted");
 		return -ENOSPC;
 	}
-	brelse(bh);
+	put_bh(bh);
 
 	/* We will update the superblock, one block bitmap, and
 	 * one group descriptor via ext3_free_blocks().
diff -puN fs/ext3/super.c~ext3_replace_brelse_to_put_bh fs/ext3/super.c
--- linux-2.6.18-rc4/fs/ext3/super.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:20.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/super.c	2006-08-11 16:01:06.953591829 -0700
@@ -400,12 +400,12 @@ static void ext3_put_super (struct super
 	}
 
 	for (i = 0; i < sbi->s_gdb_count; i++)
-		brelse(sbi->s_group_desc[i]);
+		put_bh(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
-	brelse(sbi->s_sbh);
+	put_bh(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
 		kfree(sbi->s_qf_names[i]);
@@ -1759,7 +1759,7 @@ failed_mount3:
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sbi->s_group_desc[i]);
+		put_bh(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 failed_mount:
 #ifdef CONFIG_QUOTA
@@ -1767,7 +1767,7 @@ failed_mount:
 		kfree(sbi->s_qf_names[i]);
 #endif
 	ext3_blkdev_remove(sbi);
-	brelse(bh);
+	put_bh(bh);
 out_fail:
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -1885,19 +1885,19 @@ static journal_t *ext3_get_dev_journal(s
 	      EXT3_FEATURE_INCOMPAT_JOURNAL_DEV)) {
 		printk(KERN_ERR "EXT3-fs: external journal has "
 					"bad superblock\n");
-		brelse(bh);
+		put_bh(bh);
 		goto out_bdev;
 	}
 
 	if (memcmp(EXT3_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
 		printk(KERN_ERR "EXT3-fs: journal UUID does not match\n");
-		brelse(bh);
+		put_bh(bh);
 		goto out_bdev;
 	}
 
 	len = le32_to_cpu(es->s_blocks_count);
 	start = sb_block + 1;
-	brelse(bh);	/* we're done with the superblock */
+	put_bh(bh);	/* we're done with the superblock */
 
 	journal = journal_init_dev(bdev, sb->s_bdev,
 					start, len, blocksize);
@@ -2590,7 +2590,7 @@ static ssize_t ext3_quota_read(struct su
 			memset(data, 0, tocopy);
 		else
 			memcpy(data, bh->b_data+offset, tocopy);
-		brelse(bh);
+		put_bh(bh);
 		offset = 0;
 		toread -= tocopy;
 		data += tocopy;
@@ -2624,7 +2624,7 @@ static ssize_t ext3_quota_write(struct s
 		if (journal_quota) {
 			err = ext3_journal_get_write_access(handle, bh);
 			if (err) {
-				brelse(bh);
+				put_bh(bh);
 				goto out;
 			}
 		}
@@ -2639,7 +2639,7 @@ static ssize_t ext3_quota_write(struct s
 			err = ext3_journal_dirty_data(handle, bh);
 			mark_buffer_dirty(bh);
 		}
-		brelse(bh);
+		put_bh(bh);
 		if (err)
 			goto out;
 		offset = 0;
diff -puN fs/ext3/xattr.c~ext3_replace_brelse_to_put_bh fs/ext3/xattr.c
--- linux-2.6.18-rc4/fs/ext3/xattr.c~ext3_replace_brelse_to_put_bh	2006-08-10 23:04:20.000000000 -0700
+++ linux-2.6.18-rc4-ming/fs/ext3/xattr.c	2006-08-11 16:01:07.007585602 -0700
@@ -256,7 +256,7 @@ bad_block:	ext3_error(inode->i_sb, __FUN
 	error = size;
 
 cleanup:
-	brelse(bh);
+	put_bh(bh);
 	return error;
 }
 
@@ -299,7 +299,7 @@ ext3_xattr_ibody_get(struct inode *inode
 	error = size;
 
 cleanup:
-	brelse(iloc.bh);
+	put_bh(iloc.bh);
 	return error;
 }
 
@@ -384,7 +384,7 @@ ext3_xattr_block_list(struct inode *inod
 	error = ext3_xattr_list_entries(inode, BFIRST(bh), buffer, buffer_size);
 
 cleanup:
-	brelse(bh);
+	put_bh(bh);
 
 	return error;
 }
@@ -413,7 +413,7 @@ ext3_xattr_ibody_list(struct inode *inod
 					buffer, buffer_size);
 
 cleanup:
-	brelse(iloc.bh);
+	put_bh(iloc.bh);
 	return error;
 }
 
@@ -836,7 +836,7 @@ getblk_failed:
 cleanup:
 	if (ce)
 		mb_cache_entry_release(ce);
-	brelse(new_bh);
+	put_bh(new_bh);
 	if (!(bs->bh && s->base == bs->bh->b_data))
 		kfree(s->base);
 
@@ -1019,8 +1019,8 @@ ext3_xattr_set_handle(handle_t *handle, 
 	}
 
 cleanup:
-	brelse(is.iloc.bh);
-	brelse(bs.bh);
+	put_bh(is.iloc.bh);
+	put_bh(bs.bh);
 	up_write(&EXT3_I(inode)->xattr_sem);
 	return error;
 }
@@ -1092,7 +1092,7 @@ ext3_xattr_delete_inode(handle_t *handle
 	EXT3_I(inode)->i_file_acl = 0;
 
 cleanup:
-	brelse(bh);
+	put_bh(bh);
 }
 
 /*
@@ -1223,7 +1223,7 @@ again:
 			*pce = ce;
 			return bh;
 		}
-		brelse(bh);
+		put_bh(bh);
 		ce = mb_cache_entry_find_next(ce, 0, inode->i_sb->s_bdev, hash);
 	}
 	return NULL;
diff -puN fs/jbd/checkpoint.c~ext3_replace_brelse_to_put_bh fs/jbd/checkpoint.c
--- linux-2.6.18-rc4/fs/jbd/checkpoint.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.637008493 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/checkpoint.c	2006-08-11 16:01:07.150569115 -0700
@@ -99,7 +99,7 @@ static int __try_to_free_cp_buf(struct j
 		jbd_unlock_bh_state(bh);
 		journal_remove_journal_head(bh);
 		BUFFER_TRACE(bh, "release");
-		__brelse(bh);
+		put_bh(bh);
 	} else {
 		jbd_unlock_bh_state(bh);
 	}
@@ -189,7 +189,7 @@ restart:
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
+			put_bh(bh);
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 		}
@@ -200,7 +200,7 @@ restart:
 		released = __journal_remove_checkpoint(jh);
 		jbd_unlock_bh_state(bh);
 		journal_remove_journal_head(bh);
-		__brelse(bh);
+		put_bh(bh);
 	}
 }
 
@@ -216,7 +216,7 @@ __flush_batch(journal_t *journal, struct
 		struct buffer_head *bh = bhs[i];
 		clear_buffer_jwrite(bh);
 		BUFFER_TRACE(bh, "brelse");
-		__brelse(bh);
+		put_bh(bh);
 	}
 	*batch_count = 0;
 }
@@ -243,7 +243,7 @@ static int __process_buffer(journal_t *j
 		wait_on_buffer(bh);
 		/* the journal_head may have gone by now */
 		BUFFER_TRACE(bh, "brelse");
-		__brelse(bh);
+		put_bh(bh);
 		ret = 1;
 	} else if (jh->b_transaction != NULL) {
 		transaction_t *t = jh->b_transaction;
@@ -261,7 +261,7 @@ static int __process_buffer(journal_t *j
 		spin_unlock(&journal->j_list_lock);
 		jbd_unlock_bh_state(bh);
 		journal_remove_journal_head(bh);
-		__brelse(bh);
+		put_bh(bh);
 		ret = 1;
 	} else {
 		/*
diff -puN fs/jbd/commit.c~ext3_replace_brelse_to_put_bh fs/jbd/commit.c
--- linux-2.6.18-rc4/fs/jbd/commit.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.701001113 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/commit.c	2006-08-11 16:01:07.183565310 -0700
@@ -68,14 +68,14 @@ static void release_buffer_page(struct b
 		goto nope;
 
 	page_cache_get(page);
-	__brelse(bh);
+	put_bh(bh);
 	try_to_free_buffers(page);
 	unlock_page(page);
 	page_cache_release(page);
 	return;
 
 nope:
-	__brelse(bh);
+	put_bh(bh);
 }
 
 /*
@@ -642,7 +642,7 @@ wait_for_iobuf:
 		 */
 		BUFFER_TRACE(bh, "dumping temporary bh");
 		journal_put_journal_head(jh);
-		__brelse(bh);
+		put_bh(bh);
 		J_ASSERT_BH(bh, atomic_read(&bh->b_count) == 0);
 		free_buffer_head(bh);
 
@@ -663,7 +663,7 @@ wait_for_iobuf:
 		   IO to complete */
 		wake_up_bit(&bh->b_state, BH_Unshadow);
 		JBUFFER_TRACE(jh, "brelse shadowed buffer");
-		__brelse(bh);
+		put_bh(bh);
 	}
 
 	J_ASSERT (commit_transaction->t_shadow_list == NULL);
@@ -691,7 +691,7 @@ wait_for_iobuf:
 		clear_buffer_jwrite(bh);
 		journal_unfile_buffer(journal, jh);
 		journal_put_journal_head(jh);
-		__brelse(bh);		/* One for getblk */
+		put_bh(bh);		/* One for getblk */
 		/* AKPM: bforget here */
 	}
 
diff -puN fs/jbd/journal.c~ext3_replace_brelse_to_put_bh fs/jbd/journal.c
--- linux-2.6.18-rc4/fs/jbd/journal.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.763993849 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/journal.c	2006-08-11 16:01:07.241558622 -0700
@@ -805,7 +805,7 @@ journal_t * journal_init_inode (struct i
 static void journal_fail_superblock (journal_t *journal)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
-	brelse(bh);
+	put_bh(bh);
 	journal->j_sb_buffer = NULL;
 }
 
@@ -890,7 +890,7 @@ int journal_create(journal_t *journal)
 		BUFFER_TRACE(bh, "marking uptodate");
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
-		__brelse(bh);
+		put_bh(bh);
 	}
 
 	sync_blockdev(journal->j_dev);
@@ -1146,7 +1146,7 @@ void journal_destroy(journal_t *journal)
 	journal->j_tail_sequence = ++journal->j_transaction_sequence;
 	if (journal->j_sb_buffer) {
 		journal_update_superblock(journal, 1);
-		brelse(journal->j_sb_buffer);
+		put_bh(journal->j_sb_buffer);
 	}
 
 	if (journal->j_inode)
@@ -1810,7 +1810,7 @@ static void __journal_remove_journal_hea
 			bh->b_private = NULL;
 			jh->b_bh = NULL;	/* debug, really */
 			clear_buffer_jbd(bh);
-			__brelse(bh);
+			put_bh(bh);
 			journal_free_journal_head(jh);
 		} else {
 			BUFFER_TRACE(bh, "journal_head was locked");
@@ -1827,8 +1827,8 @@ static void __journal_remove_journal_hea
  * We in fact take an additional increment on ->b_count as a convenience,
  * because the caller usually wants to do additional things with the bh
  * after calling here.
- * The caller of journal_remove_journal_head() *must* run __brelse(bh) at some
- * time.  Once the caller has run __brelse(), the buffer is eligible for
+ * The caller of journal_remove_journal_head() *must* run put_bh(bh) at some
+ * time.  Once the caller has run put_bh(), the buffer is eligible for
  * reaping by try_to_free_buffers().
  */
 void journal_remove_journal_head(struct buffer_head *bh)
@@ -1851,7 +1851,7 @@ void journal_put_journal_head(struct jou
 	--jh->b_jcount;
 	if (!jh->b_jcount && !jh->b_transaction) {
 		__journal_remove_journal_head(bh);
-		__brelse(bh);
+		put_bh(bh);
 	}
 	jbd_unlock_bh_journal_head(bh);
 }
diff -puN fs/jbd/recovery.c~ext3_replace_brelse_to_put_bh fs/jbd/recovery.c
--- linux-2.6.18-rc4/fs/jbd/recovery.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.823986931 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/recovery.c	2006-08-11 16:01:07.266555740 -0700
@@ -108,7 +108,7 @@ static int do_readahead(journal_t *journ
 				nbufs = 0;
 			}
 		} else
-			brelse(bh);
+			put_bh(bh);
 	}
 
 	if (nbufs)
@@ -165,7 +165,7 @@ static int jread(struct buffer_head **bh
 	if (!buffer_uptodate(bh)) {
 		printk (KERN_ERR "JBD: Failed to read block at offset %u\n",
 			offset);
-		brelse(bh);
+		put_bh(bh);
 		return -EIO;
 	}
 
@@ -388,7 +388,7 @@ static int do_one_pass(journal_t *journa
 		tmp = (journal_header_t *)bh->b_data;
 
 		if (tmp->h_magic != cpu_to_be32(JFS_MAGIC_NUMBER)) {
-			brelse(bh);
+			put_bh(bh);
 			break;
 		}
 
@@ -398,7 +398,7 @@ static int do_one_pass(journal_t *journa
 			  blocktype, sequence);
 
 		if (sequence != next_commit_ID) {
-			brelse(bh);
+			put_bh(bh);
 			break;
 		}
 
@@ -415,7 +415,7 @@ static int do_one_pass(journal_t *journa
 				next_log_block +=
 					count_tags(bh, journal->j_blocksize);
 				wrap(journal, next_log_block);
-				brelse(bh);
+				put_bh(bh);
 				continue;
 			}
 
@@ -454,7 +454,7 @@ static int do_one_pass(journal_t *journa
 					if (journal_test_revoke
 					    (journal, blocknr,
 					     next_commit_ID)) {
-						brelse(obh);
+						put_bh(obh);
 						++info->nr_revoke_hits;
 						goto skip_write;
 					}
@@ -469,8 +469,8 @@ static int do_one_pass(journal_t *journa
 						       "JBD: Out of memory "
 						       "during recovery.\n");
 						err = -ENOMEM;
-						brelse(bh);
-						brelse(obh);
+						put_bh(bh);
+						put_bh(obh);
 						goto failed;
 					}
 
@@ -489,8 +489,8 @@ static int do_one_pass(journal_t *journa
 					++info->nr_replays;
 					/* ll_rw_block(WRITE, 1, &nbh); */
 					unlock_buffer(nbh);
-					brelse(obh);
-					brelse(nbh);
+					put_bh(obh);
+					put_bh(nbh);
 				}
 
 			skip_write:
@@ -502,14 +502,14 @@ static int do_one_pass(journal_t *journa
 					break;
 			}
 
-			brelse(bh);
+			put_bh(bh);
 			continue;
 
 		case JFS_COMMIT_BLOCK:
 			/* Found an expected commit block: not much to
 			 * do other than move on to the next sequence
 			 * number. */
-			brelse(bh);
+			put_bh(bh);
 			next_commit_ID++;
 			continue;
 
@@ -517,13 +517,13 @@ static int do_one_pass(journal_t *journa
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {
-				brelse(bh);
+				put_bh(bh);
 				continue;
 			}
 
 			err = scan_revoke_records(journal, bh,
 						  next_commit_ID, info);
-			brelse(bh);
+			put_bh(bh);
 			if (err)
 				goto failed;
 			continue;
@@ -531,7 +531,7 @@ static int do_one_pass(journal_t *journa
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
-			brelse(bh);
+			put_bh(bh);
 			goto done;
 		}
 	}
diff -puN fs/jbd/revoke.c~ext3_replace_brelse_to_put_bh fs/jbd/revoke.c
--- linux-2.6.18-rc4/fs/jbd/revoke.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.883980012 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/revoke.c	2006-08-11 16:01:07.292552742 -0700
@@ -380,7 +380,7 @@ int journal_revoke(handle_t *handle, uns
 		if (!J_EXPECT_BH(bh, !buffer_revoked(bh),
 				 "inconsistent data on disk")) {
 			if (!bh_in)
-				brelse(bh);
+				put_bh(bh);
 			return -EIO;
 		}
 		set_buffer_revoked(bh);
@@ -390,7 +390,7 @@ int journal_revoke(handle_t *handle, uns
 			journal_forget(handle, bh_in);
 		} else {
 			BUFFER_TRACE(bh, "call brelse");
-			__brelse(bh);
+			put_bh(bh);
 		}
 	}
 
@@ -468,7 +468,7 @@ int journal_cancel_revoke(handle_t *hand
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
-			__brelse(bh2);
+			put_bh(bh2);
 		}
 	}
 	return did_revoke;
diff -puN fs/jbd/transaction.c~ext3_replace_brelse_to_put_bh fs/jbd/transaction.c
--- linux-2.6.18-rc4/fs/jbd/transaction.c~ext3_replace_brelse_to_put_bh	2006-08-11 16:00:02.948972518 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd/transaction.c	2006-08-11 16:01:07.356545363 -0700
@@ -1068,7 +1068,7 @@ no_journal:
 	jbd_unlock_bh_state(bh);
 	if (need_brelse) {
 		BUFFER_TRACE(bh, "brelse");
-		__brelse(bh);
+		put_bh(bh);
 	}
 	JBUFFER_TRACE(jh, "exit");
 	journal_put_journal_head(jh);
@@ -1254,7 +1254,7 @@ int journal_forget (handle_t *handle, st
 		} else {
 			__journal_unfile_buffer(jh);
 			journal_remove_journal_head(bh);
-			__brelse(bh);
+			put_bh(bh);
 			if (!buffer_jbd(bh)) {
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
@@ -1281,7 +1281,7 @@ int journal_forget (handle_t *handle, st
 not_jbd:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
-	__brelse(bh);
+	put_bh(bh);
 drop:
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
@@ -1577,7 +1577,7 @@ __journal_try_to_free_buffer(journal_t *
 			JBUFFER_TRACE(jh, "release data");
 			__journal_unfile_buffer(jh);
 			journal_remove_journal_head(bh);
-			__brelse(bh);
+			put_bh(bh);
 		}
 	} else if (jh->b_cp_transaction != 0 && jh->b_transaction == 0) {
 		/* written-back checkpointed metadata buffer */
@@ -1585,7 +1585,7 @@ __journal_try_to_free_buffer(journal_t *
 			JBUFFER_TRACE(jh, "remove from checkpoint list");
 			__journal_remove_checkpoint(jh);
 			journal_remove_journal_head(bh);
-			__brelse(bh);
+			put_bh(bh);
 		}
 	}
 	spin_unlock(&journal->j_list_lock);
@@ -1690,7 +1690,7 @@ static int __dispose_buffer(struct journ
 	} else {
 		JBUFFER_TRACE(jh, "on running transaction");
 		journal_remove_journal_head(bh);
-		__brelse(bh);
+		put_bh(bh);
 	}
 	return may_free;
 }
@@ -2075,5 +2075,5 @@ void journal_refile_buffer(journal_t *jo
 	journal_remove_journal_head(bh);
 
 	spin_unlock(&journal->j_list_lock);
-	__brelse(bh);
+	put_bh(bh);
 }

_


