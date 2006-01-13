Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWAMHcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWAMHcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWAMHcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:32:08 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:4736 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030280AbWAMHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:32:06 -0500
Date: Fri, 13 Jan 2006 09:31:59 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs: remove kmalloc wrapper
Message-ID: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes kmalloc() wrapper from fs/reiserfs/. Please note that 
a reiserfs /proc entry format is changed because kmalloc statistics is 
removed.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/reiserfs/dir.c              |   16 ++-----
 fs/reiserfs/fix_node.c         |   50 +-----------------------
 fs/reiserfs/journal.c          |   84 +++++++++++++----------------------------
 fs/reiserfs/namei.c            |   16 +++----
 fs/reiserfs/procfs.c           |    3 -
 fs/reiserfs/super.c            |    6 --
 fs/reiserfs/xattr.c            |   11 +----
 include/linux/reiserfs_fs.h    |   16 -------
 include/linux/reiserfs_fs_sb.h |    1 
 9 files changed, 49 insertions(+), 154 deletions(-)

Index: 2.6/fs/reiserfs/dir.c
===================================================================
--- 2.6.orig/fs/reiserfs/dir.c
+++ 2.6/fs/reiserfs/dir.c
@@ -150,18 +150,15 @@ static int reiserfs_readdir(struct file 
 				if (d_reclen <= 32) {
 					local_buf = small_buf;
 				} else {
-					local_buf =
-					    reiserfs_kmalloc(d_reclen, GFP_NOFS,
-							     inode->i_sb);
+					local_buf = kmalloc(d_reclen,
+							    GFP_NOFS);
 					if (!local_buf) {
 						pathrelse(&path_to_entry);
 						ret = -ENOMEM;
 						goto out;
 					}
 					if (item_moved(&tmp_ih, &path_to_entry)) {
-						reiserfs_kfree(local_buf,
-							       d_reclen,
-							       inode->i_sb);
+						kfree(local_buf);
 						goto research;
 					}
 				}
@@ -174,15 +171,12 @@ static int reiserfs_readdir(struct file 
 				    (dirent, local_buf, d_reclen, d_off, d_ino,
 				     DT_UNKNOWN) < 0) {
 					if (local_buf != small_buf) {
-						reiserfs_kfree(local_buf,
-							       d_reclen,
-							       inode->i_sb);
+						kfree(local_buf);
 					}
 					goto end;
 				}
 				if (local_buf != small_buf) {
-					reiserfs_kfree(local_buf, d_reclen,
-						       inode->i_sb);
+					kfree(local_buf);
 				}
 				// next entry should be looked for with such offset
 				next_pos = deh_offset(deh) + 1;
Index: 2.6/fs/reiserfs/fix_node.c
===================================================================
--- 2.6.orig/fs/reiserfs/fix_node.c
+++ 2.6/fs/reiserfs/fix_node.c
@@ -2021,38 +2021,6 @@ static int get_neighbors(struct tree_bal
 	return CARRY_ON;
 }
 
-#ifdef CONFIG_REISERFS_CHECK
-void *reiserfs_kmalloc(size_t size, gfp_t flags, struct super_block *s)
-{
-	void *vp;
-	static size_t malloced;
-
-	vp = kmalloc(size, flags);
-	if (vp) {
-		REISERFS_SB(s)->s_kmallocs += size;
-		if (REISERFS_SB(s)->s_kmallocs > malloced + 200000) {
-			reiserfs_warning(s,
-					 "vs-8301: reiserfs_kmalloc: allocated memory %d",
-					 REISERFS_SB(s)->s_kmallocs);
-			malloced = REISERFS_SB(s)->s_kmallocs;
-		}
-	}
-	return vp;
-}
-
-void reiserfs_kfree(const void *vp, size_t size, struct super_block *s)
-{
-	kfree(vp);
-
-	REISERFS_SB(s)->s_kmallocs -= size;
-	if (REISERFS_SB(s)->s_kmallocs < 0)
-		reiserfs_warning(s,
-				 "vs-8302: reiserfs_kfree: allocated memory %d",
-				 REISERFS_SB(s)->s_kmallocs);
-
-}
-#endif
-
 static int get_virtual_node_size(struct super_block *sb, struct buffer_head *bh)
 {
 	int max_num_of_items;
@@ -2086,7 +2054,7 @@ static int get_mem_for_virtual_node(stru
 		/* we have to allocate more memory for virtual node */
 		if (tb->vn_buf) {
 			/* free memory allocated before */
-			reiserfs_kfree(tb->vn_buf, tb->vn_buf_size, tb->tb_sb);
+			kfree(tb->vn_buf);
 			/* this is not needed if kfree is atomic */
 			check_fs = 1;
 		}
@@ -2095,24 +2063,15 @@ static int get_mem_for_virtual_node(stru
 		tb->vn_buf_size = size;
 
 		/* get memory for virtual item */
-		buf =
-		    reiserfs_kmalloc(size, GFP_ATOMIC | __GFP_NOWARN,
-				     tb->tb_sb);
+		buf = kmalloc(size, GFP_ATOMIC | __GFP_NOWARN);
 		if (!buf) {
 			/* getting memory with GFP_KERNEL priority may involve
 			   balancing now (due to indirect_to_direct conversion on
 			   dcache shrinking). So, release path and collected
 			   resources here */
 			free_buffers_in_tb(tb);
-			buf = reiserfs_kmalloc(size, GFP_NOFS, tb->tb_sb);
+			buf = kmalloc(size, GFP_NOFS);
 			if (!buf) {
-#ifdef CONFIG_REISERFS_CHECK
-				reiserfs_warning(tb->tb_sb,
-						 "vs-8345: get_mem_for_virtual_node: "
-						 "kmalloc failed. reiserfs kmalloced %d bytes",
-						 REISERFS_SB(tb->tb_sb)->
-						 s_kmallocs);
-#endif
 				tb->vn_buf_size = 0;
 			}
 			tb->vn_buf = buf;
@@ -2619,7 +2578,6 @@ void unfix_nodes(struct tree_balance *tb
 		}
 	}
 
-	if (tb->vn_buf)
-		reiserfs_kfree(tb->vn_buf, tb->vn_buf_size, tb->tb_sb);
+	kfree(tb->vn_buf);
 
 }
Index: 2.6/fs/reiserfs/journal.c
===================================================================
--- 2.6.orig/fs/reiserfs/journal.c
+++ 2.6/fs/reiserfs/journal.c
@@ -152,18 +152,16 @@ static struct reiserfs_bitmap_node *allo
 	struct reiserfs_bitmap_node *bn;
 	static int id;
 
-	bn = reiserfs_kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS,
-			      p_s_sb);
+	bn = kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS);
 	if (!bn) {
 		return NULL;
 	}
-	bn->data = reiserfs_kmalloc(p_s_sb->s_blocksize, GFP_NOFS, p_s_sb);
+	bn->data = kzalloc(p_s_sb->s_blocksize, GFP_NOFS);
 	if (!bn->data) {
-		reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb);
+		kfree(bn);
 		return NULL;
 	}
 	bn->id = id++;
-	memset(bn->data, 0, p_s_sb->s_blocksize);
 	INIT_LIST_HEAD(&bn->list);
 	return bn;
 }
@@ -197,8 +195,8 @@ static inline void free_bitmap_node(stru
 	struct reiserfs_journal *journal = SB_JOURNAL(p_s_sb);
 	journal->j_used_bitmap_nodes--;
 	if (journal->j_free_bitmap_nodes > REISERFS_MAX_BITMAP_NODES) {
-		reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb);
-		reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb);
+		kfree(bn->data);
+		kfree(bn);
 	} else {
 		list_add(&bn->list, &journal->j_bitmap_nodes);
 		journal->j_free_bitmap_nodes++;
@@ -276,8 +274,8 @@ static int free_bitmap_nodes(struct supe
 	while (next != &journal->j_bitmap_nodes) {
 		bn = list_entry(next, struct reiserfs_bitmap_node, list);
 		list_del(next);
-		reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb);
-		reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb);
+		kfree(bn->data);
+		kfree(bn);
 		next = journal->j_bitmap_nodes.next;
 		journal->j_free_bitmap_nodes--;
 	}
@@ -581,7 +579,7 @@ static inline void put_journal_list(stru
 			       jl->j_trans_id, jl->j_refcount);
 	}
 	if (--jl->j_refcount == 0)
-		reiserfs_kfree(jl, sizeof(struct reiserfs_journal_list), s);
+		kfree(jl);
 }
 
 /*
@@ -1818,8 +1816,7 @@ void remove_journal_hash(struct super_bl
 static void free_journal_ram(struct super_block *p_s_sb)
 {
 	struct reiserfs_journal *journal = SB_JOURNAL(p_s_sb);
-	reiserfs_kfree(journal->j_current_jl,
-		       sizeof(struct reiserfs_journal_list), p_s_sb);
+	kfree(journal->j_current_jl);
 	journal->j_num_lists--;
 
 	vfree(journal->j_cnode_free_orig);
@@ -2093,21 +2090,15 @@ static int journal_read_transaction(stru
 	}
 	trans_id = get_desc_trans_id(desc);
 	/* now we know we've got a good transaction, and it was inside the valid time ranges */
-	log_blocks =
-	    reiserfs_kmalloc(get_desc_trans_len(desc) *
-			     sizeof(struct buffer_head *), GFP_NOFS, p_s_sb);
-	real_blocks =
-	    reiserfs_kmalloc(get_desc_trans_len(desc) *
-			     sizeof(struct buffer_head *), GFP_NOFS, p_s_sb);
+	log_blocks = kmalloc(get_desc_trans_len(desc) *
+			     sizeof(struct buffer_head *), GFP_NOFS);
+	real_blocks = kmalloc(get_desc_trans_len(desc) *
+			      sizeof(struct buffer_head *), GFP_NOFS);
 	if (!log_blocks || !real_blocks) {
 		brelse(c_bh);
 		brelse(d_bh);
-		reiserfs_kfree(log_blocks,
-			       get_desc_trans_len(desc) *
-			       sizeof(struct buffer_head *), p_s_sb);
-		reiserfs_kfree(real_blocks,
-			       get_desc_trans_len(desc) *
-			       sizeof(struct buffer_head *), p_s_sb);
+		kfree(log_blocks);
+		kfree(real_blocks);
 		reiserfs_warning(p_s_sb,
 				 "journal-1169: kmalloc failed, unable to mount FS");
 		return -1;
@@ -2145,12 +2136,8 @@ static int journal_read_transaction(stru
 			brelse_array(real_blocks, i);
 			brelse(c_bh);
 			brelse(d_bh);
-			reiserfs_kfree(log_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
-			reiserfs_kfree(real_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
+			kfree(log_blocks);
+			kfree(real_blocks);
 			return -1;
 		}
 	}
@@ -2166,12 +2153,8 @@ static int journal_read_transaction(stru
 			brelse_array(real_blocks, get_desc_trans_len(desc));
 			brelse(c_bh);
 			brelse(d_bh);
-			reiserfs_kfree(log_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
-			reiserfs_kfree(real_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
+			kfree(log_blocks);
+			kfree(real_blocks);
 			return -1;
 		}
 		memcpy(real_blocks[i]->b_data, log_blocks[i]->b_data,
@@ -2193,12 +2176,8 @@ static int journal_read_transaction(stru
 				     get_desc_trans_len(desc) - i);
 			brelse(c_bh);
 			brelse(d_bh);
-			reiserfs_kfree(log_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
-			reiserfs_kfree(real_blocks,
-				       get_desc_trans_len(desc) *
-				       sizeof(struct buffer_head *), p_s_sb);
+			kfree(log_blocks);
+			kfree(real_blocks);
 			return -1;
 		}
 		brelse(real_blocks[i]);
@@ -2217,12 +2196,8 @@ static int journal_read_transaction(stru
 	journal->j_trans_id = trans_id + 1;
 	brelse(c_bh);
 	brelse(d_bh);
-	reiserfs_kfree(log_blocks,
-		       le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *),
-		       p_s_sb);
-	reiserfs_kfree(real_blocks,
-		       le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *),
-		       p_s_sb);
+	kfree(log_blocks);
+	kfree(real_blocks);
 	return 0;
 }
 
@@ -2472,13 +2447,11 @@ static struct reiserfs_journal_list *all
 {
 	struct reiserfs_journal_list *jl;
       retry:
-	jl = reiserfs_kmalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS,
-			      s);
+	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
 	if (!jl) {
 		yield();
 		goto retry;
 	}
-	memset(jl, 0, sizeof(*jl));
 	INIT_LIST_HEAD(&jl->j_list);
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
@@ -3042,14 +3015,12 @@ struct reiserfs_transaction_handle *reis
 		}
 		return th;
 	}
-	th = reiserfs_kmalloc(sizeof(struct reiserfs_transaction_handle),
-			      GFP_NOFS, s);
+	th = kmalloc(sizeof(struct reiserfs_transaction_handle), GFP_NOFS);
 	if (!th)
 		return NULL;
 	ret = journal_begin(th, s, nblocks);
 	if (ret) {
-		reiserfs_kfree(th, sizeof(struct reiserfs_transaction_handle),
-			       s);
+		kfree(th);
 		return NULL;
 	}
 
@@ -3067,8 +3038,7 @@ int reiserfs_end_persistent_transaction(
 		ret = -EIO;
 	if (th->t_refcount == 0) {
 		SB_JOURNAL(s)->j_persistent_trans--;
-		reiserfs_kfree(th, sizeof(struct reiserfs_transaction_handle),
-			       s);
+		kfree(th);
 	}
 	return ret;
 }
Index: 2.6/fs/reiserfs/namei.c
===================================================================
--- 2.6.orig/fs/reiserfs/namei.c
+++ 2.6/fs/reiserfs/namei.c
@@ -460,7 +460,7 @@ static int reiserfs_add_entry(struct rei
 	/* get memory for composing the entry */
 	buflen = DEH_SIZE + ROUND_UP(namelen);
 	if (buflen > sizeof(small_buf)) {
-		buffer = reiserfs_kmalloc(buflen, GFP_NOFS, dir->i_sb);
+		buffer = kmalloc(buflen, GFP_NOFS);
 		if (buffer == 0)
 			return -ENOMEM;
 	} else
@@ -494,7 +494,7 @@ static int reiserfs_add_entry(struct rei
 	retval = reiserfs_find_entry(dir, name, namelen, &path, &de);
 	if (retval != NAME_NOT_FOUND) {
 		if (buffer != small_buf)
-			reiserfs_kfree(buffer, buflen, dir->i_sb);
+			kfree(buffer);
 		pathrelse(&path);
 
 		if (retval == IO_ERROR) {
@@ -519,7 +519,7 @@ static int reiserfs_add_entry(struct rei
 		reiserfs_warning(dir->i_sb,
 				 "reiserfs_add_entry: Congratulations! we have got hash function screwed up");
 		if (buffer != small_buf)
-			reiserfs_kfree(buffer, buflen, dir->i_sb);
+			kfree(buffer);
 		pathrelse(&path);
 		return -EBUSY;
 	}
@@ -539,7 +539,7 @@ static int reiserfs_add_entry(struct rei
 					 &entry_key);
 
 			if (buffer != small_buf)
-				reiserfs_kfree(buffer, buflen, dir->i_sb);
+				kfree(buffer);
 			pathrelse(&path);
 			return -EBUSY;
 		}
@@ -550,7 +550,7 @@ static int reiserfs_add_entry(struct rei
 	    reiserfs_paste_into_item(th, &path, &entry_key, dir, buffer,
 				     paste_size);
 	if (buffer != small_buf)
-		reiserfs_kfree(buffer, buflen, dir->i_sb);
+		kfree(buffer);
 	if (retval) {
 		reiserfs_check_path(&path);
 		return retval;
@@ -1069,7 +1069,7 @@ static int reiserfs_symlink(struct inode
 		goto out_failed;
 	}
 
-	name = reiserfs_kmalloc(item_len, GFP_NOFS, parent_dir->i_sb);
+	name = kmalloc(item_len, GFP_NOFS);
 	if (!name) {
 		drop_new_inode(inode);
 		retval = -ENOMEM;
@@ -1083,14 +1083,14 @@ static int reiserfs_symlink(struct inode
 	retval = journal_begin(&th, parent_dir->i_sb, jbegin_count);
 	if (retval) {
 		drop_new_inode(inode);
-		reiserfs_kfree(name, item_len, parent_dir->i_sb);
+		kfree(name);
 		goto out_failed;
 	}
 
 	retval =
 	    reiserfs_new_inode(&th, parent_dir, mode, name, strlen(symname),
 			       dentry, inode);
-	reiserfs_kfree(name, item_len, parent_dir->i_sb);
+	kfree(name);
 	if (retval) {		/* reiserfs_new_inode iputs for us */
 		goto out_failed;
 	}
Index: 2.6/fs/reiserfs/xattr.c
===================================================================
--- 2.6.orig/fs/reiserfs/xattr.c
+++ 2.6/fs/reiserfs/xattr.c
@@ -367,15 +367,13 @@ static int __xattr_readdir(struct file *
 		if (d_reclen <= 32) {
 			local_buf = small_buf;
 		} else {
-			local_buf =
-			    reiserfs_kmalloc(d_reclen, GFP_NOFS, inode->i_sb);
+			local_buf = kmalloc(d_reclen, GFP_NOFS);
 			if (!local_buf) {
 				pathrelse(&path_to_entry);
 				return -ENOMEM;
 			}
 			if (item_moved(&tmp_ih, &path_to_entry)) {
-				reiserfs_kfree(local_buf, d_reclen,
-					       inode->i_sb);
+				kfree(local_buf);
 
 				/* sigh, must retry.  Do this same offset again */
 				next_pos = d_off;
@@ -398,13 +396,12 @@ static int __xattr_readdir(struct file *
 		if (filldir(dirent, local_buf, d_reclen, d_off, d_ino,
 			    DT_UNKNOWN) < 0) {
 			if (local_buf != small_buf) {
-				reiserfs_kfree(local_buf, d_reclen,
-					       inode->i_sb);
+				kfree(local_buf);
 			}
 			goto end;
 		}
 		if (local_buf != small_buf) {
-			reiserfs_kfree(local_buf, d_reclen, inode->i_sb);
+			kfree(local_buf);
 		}
 	}			/* while */
 
Index: 2.6/include/linux/reiserfs_fs.h
===================================================================
--- 2.6.orig/include/linux/reiserfs_fs.h
+++ 2.6/include/linux/reiserfs_fs.h
@@ -1971,22 +1971,6 @@ extern struct file_operations reiserfs_f
 extern struct address_space_operations reiserfs_address_space_operations;
 
 /* fix_nodes.c */
-#ifdef CONFIG_REISERFS_CHECK
-void *reiserfs_kmalloc(size_t size, gfp_t flags, struct super_block *s);
-void reiserfs_kfree(const void *vp, size_t size, struct super_block *s);
-#else
-static inline void *reiserfs_kmalloc(size_t size, int flags,
-				     struct super_block *s)
-{
-	return kmalloc(size, flags);
-}
-
-static inline void reiserfs_kfree(const void *vp, size_t size,
-				  struct super_block *s)
-{
-	kfree(vp);
-}
-#endif
 
 int fix_nodes(int n_op_mode, struct tree_balance *p_s_tb,
 	      struct item_head *p_s_ins_ih, const void *);
Index: 2.6/fs/reiserfs/procfs.c
===================================================================
--- 2.6.orig/fs/reiserfs/procfs.c
+++ 2.6/fs/reiserfs/procfs.c
@@ -88,7 +88,6 @@ static int show_super(struct seq_file *m
 	seq_printf(m, "state: \t%s\n"
 		   "mount options: \t%s%s%s%s%s%s%s%s%s%s%s\n"
 		   "gen. counter: \t%i\n"
-		   "s_kmallocs: \t%i\n"
 		   "s_disk_reads: \t%i\n"
 		   "s_disk_writes: \t%i\n"
 		   "s_fix_nodes: \t%i\n"
@@ -128,7 +127,7 @@ static int show_super(struct seq_file *m
 		   "SMALL_TAILS " : "NO_TAILS ",
 		   replay_only(sb) ? "REPLAY_ONLY " : "",
 		   convert_reiserfs(sb) ? "CONV " : "",
-		   atomic_read(&r->s_generation_counter), SF(s_kmallocs),
+		   atomic_read(&r->s_generation_counter),
 		   SF(s_disk_reads), SF(s_disk_writes), SF(s_fix_nodes),
 		   SF(s_do_balance), SF(s_unneeded_left_neighbor),
 		   SF(s_good_search_by_key_reada), SF(s_bmaps),
Index: 2.6/fs/reiserfs/super.c
===================================================================
--- 2.6.orig/fs/reiserfs/super.c
+++ 2.6/fs/reiserfs/super.c
@@ -472,12 +472,6 @@ static void reiserfs_put_super(struct su
 
 	print_statistics(s);
 
-	if (REISERFS_SB(s)->s_kmallocs != 0) {
-		reiserfs_warning(s,
-				 "vs-2004: reiserfs_put_super: allocated memory left %d",
-				 REISERFS_SB(s)->s_kmallocs);
-	}
-
 	if (REISERFS_SB(s)->reserved_blocks != 0) {
 		reiserfs_warning(s,
 				 "green-2005: reiserfs_put_super: reserved blocks left %d",
Index: 2.6/include/linux/reiserfs_fs_sb.h
===================================================================
--- 2.6.orig/include/linux/reiserfs_fs_sb.h
+++ 2.6/include/linux/reiserfs_fs_sb.h
@@ -382,7 +382,6 @@ struct reiserfs_sb_info {
 					   on-disk FS format */
 
 	/* session statistics */
-	int s_kmallocs;
 	int s_disk_reads;
 	int s_disk_writes;
 	int s_fix_nodes;
