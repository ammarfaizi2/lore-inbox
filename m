Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWDZBua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWDZBua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWDZBua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:50:30 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:13971 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932338AbWDZBu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:50:28 -0400
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][15/21]e2fsprogs add new functions with 64-bit blk64_t
Message-Id: <20060426105016sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 26 Apr 2006 10:50:15 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [15/21] add new functions which manipulate bitmap with 64-bit blk64_t
          - add new functions, which use 64-bit blk64_t and manipulate
            bitmap, leaving existing functions as they are.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39/debugfs/debugfs.c e2fsprogs-1.39.tmp/debugfs/debugfs.c
--- e2fsprogs-1.39/debugfs/debugfs.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/debugfs.c	2006-04-21 11:51:17.000000000 +0900
@@ -708,10 +708,10 @@ void do_freeb(int argc, char *argv[])
 	if (check_fs_read_write(argv[0]))
 		return;
 	while (count-- > 0) {
-		if (!ext2fs_test_block_bitmap(current_fs->block_map,block))
+		if (!ext2fs_test_block_bitmap_64(current_fs->block_map,block))
 			com_err(argv[0], 0, "Warning: block %u already clear",
 				block);
-		ext2fs_unmark_block_bitmap(current_fs->block_map,block);
+		ext2fs_unmark_block_bitmap_64(current_fs->block_map,block);
 		block++;
 	}
 	ext2fs_mark_bb_dirty(current_fs);
@@ -727,10 +727,10 @@ void do_setb(int argc, char *argv[])
 	if (check_fs_read_write(argv[0]))
 		return;
 	while (count-- > 0) {
-		if (ext2fs_test_block_bitmap(current_fs->block_map,block))
+		if (ext2fs_test_block_bitmap_64(current_fs->block_map,block))
 			com_err(argv[0], 0, "Warning: block %u already set",
 				block);
-		ext2fs_mark_block_bitmap(current_fs->block_map,block);
+		ext2fs_mark_block_bitmap_64(current_fs->block_map,block);
 		block++;
 	}
 	ext2fs_mark_bb_dirty(current_fs);
@@ -744,7 +744,7 @@ void do_testb(int argc, char *argv[])
 	if (common_block_args_process(argc, argv, &block, &count))
 		return;
 	while (count-- > 0) {
-		if (ext2fs_test_block_bitmap(current_fs->block_map,block))
+		if (ext2fs_test_block_bitmap_64(current_fs->block_map,block))
 			printf("Block %u marked in use\n", block);
 		else
 			printf("Block %u not in use\n", block);
diff -upNr e2fsprogs-1.39/debugfs/logdump.c e2fsprogs-1.39.tmp/debugfs/logdump.c
--- e2fsprogs-1.39/debugfs/logdump.c	2005-12-11 09:48:13.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/logdump.c	2006-04-21 11:51:17.000000000 +0900
@@ -618,7 +618,7 @@ static void dump_metadata_block(FILE *ou
 		fprintf(out_file, "    (block bitmap for block %u: "
 			"block is %s)\n", 
 			block_to_dump,
-			ext2fs_test_bit(offset, buf) ? "SET" : "CLEAR");
+			ext2fs_test_bit_64(offset, buf) ? "SET" : "CLEAR");
 	}
 	
 	if (fs_blocknr == inode_block_to_dump) {
diff -upNr e2fsprogs-1.39/debugfs/lsdel.c e2fsprogs-1.39.tmp/debugfs/lsdel.c
--- e2fsprogs-1.39/debugfs/lsdel.c	2005-09-25 10:56:38.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/lsdel.c	2006-04-21 11:51:17.000000000 +0900
@@ -62,7 +62,7 @@ static int lsdel_proc(ext2_filsys fs,
 		return BLOCK_ABORT;
 	}
 
-	if (!ext2fs_test_block_bitmap(fs->block_map,*block_nr))
+	if (!ext2fs_test_block_bitmap_64(fs->block_map,*block_nr))
 		lsd->free_blocks++;
 
 	return 0;
diff -upNr e2fsprogs-1.39/debugfs/unused.c e2fsprogs-1.39.tmp/debugfs/unused.c
--- e2fsprogs-1.39/debugfs/unused.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/unused.c	2006-04-21 11:51:17.000000000 +0900
@@ -33,7 +33,7 @@ void do_dump_unused(int argc EXT2FS_ATTR
 
 	for (blk=current_fs->super->s_first_data_block;
 	     blk < current_fs->super->s_blocks_count; blk++) {
-		if (ext2fs_test_block_bitmap(current_fs->block_map,blk))
+		if (ext2fs_test_block_bitmap_64(current_fs->block_map,blk))
 			continue;
 		retval = io_channel_read_blk(current_fs->io, blk, 1, buf);
 		if (retval) {
diff -upNr e2fsprogs-1.39/e2fsck/pass1.c e2fsprogs-1.39.tmp/e2fsck/pass1.c
--- e2fsprogs-1.39/e2fsck/pass1.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass1.c	2006-04-21 11:51:17.000000000 +0900
@@ -1081,7 +1081,7 @@ static _INLINE_ void mark_block_used(e2f
 	
 	clear_problem_context(&pctx);
 	
-	if (ext2fs_fast_test_block_bitmap(ctx->block_found_map, block)) {
+	if (ext2fs_fast_test_block_bitmap_64(ctx->block_found_map, block)) {
 		if (!ctx->block_dup_map) {
 			pctx.errcode = ext2fs_allocate_block_bitmap(ctx->fs,
 			      _("multiply claimed block map"),
@@ -1095,9 +1095,9 @@ static _INLINE_ void mark_block_used(e2f
 				return;
 			}
 		}
-		ext2fs_fast_mark_block_bitmap(ctx->block_dup_map, block);
+		ext2fs_fast_mark_block_bitmap_64(ctx->block_dup_map, block);
 	} else {
-		ext2fs_fast_mark_block_bitmap(ctx->block_found_map, block);
+		ext2fs_fast_mark_block_bitmap_64(ctx->block_found_map, block);
 	}
 }
 
@@ -1210,7 +1210,7 @@ static int check_ext_attr(e2fsck_t ctx, 
 #endif
 
 	/* Have we seen this EA block before? */
-	if (ext2fs_fast_test_block_bitmap(ctx->block_ea_map, blk)) {
+	if (ext2fs_fast_test_block_bitmap_64(ctx->block_ea_map, blk)) {
 		if (ea_refcount_decrement(ctx->refcount, blk, 0) == 0)
 			return 1;
 		/* Ooops, this EA was referenced more than it stated */
@@ -1299,7 +1299,7 @@ static int check_ext_attr(e2fsck_t ctx, 
 	if (count)
 		ea_refcount_store(ctx->refcount, blk, count);
 	mark_block_used(ctx, blk);
-	ext2fs_fast_mark_block_bitmap(ctx->block_ea_map, blk);
+	ext2fs_fast_mark_block_bitmap_64(ctx->block_ea_map, blk);
 	
 	return 1;
 
@@ -1761,13 +1761,13 @@ static int process_bad_block(ext2_filsys
 	}
 
 	if (blockcnt < 0) {
-		if (ext2fs_test_block_bitmap(p->fs_meta_blocks, blk)) {
+		if (ext2fs_test_block_bitmap_64(p->fs_meta_blocks, blk)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BB_FS_BLOCK, pctx)) {
 				*block_nr = 0;
 				return BLOCK_CHANGED;
 			}
-		} else if (ext2fs_test_block_bitmap(ctx->block_found_map, 
+		} else if (ext2fs_test_block_bitmap_64(ctx->block_found_map, 
 						    blk)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BBINODE_BAD_METABLOCK, 
@@ -1791,8 +1791,8 @@ static int process_bad_block(ext2_filsys
 	 * there's an overlap between the filesystem table blocks
 	 * (bitmaps and inode table) and the bad block list.
 	 */
-	if (!ext2fs_test_block_bitmap(ctx->block_found_map, blk)) {
-		ext2fs_mark_block_bitmap(ctx->block_found_map, blk);
+	if (!ext2fs_test_block_bitmap_64(ctx->block_found_map, blk)) {
+		ext2fs_mark_block_bitmap_64(ctx->block_found_map, blk);
 		return 0;
 	}
 	/*
@@ -1927,7 +1927,7 @@ static void new_table_block(e2fsck_t ctx
 	pctx.blk2 = 0;
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
-		ext2fs_mark_block_bitmap(ctx->block_found_map, (*new_block)+i);
+		ext2fs_mark_block_bitmap_64(ctx->block_found_map, (*new_block)+i);
 		if (old_block) {
 			pctx.errcode = io_channel_read_blk(fs->io,
 				   old_block + i, 1, buf);
@@ -2005,7 +2005,7 @@ static void mark_table_blocks(e2fsck_t c
 			for (j = 0, b = fs->group_desc[i].bg_inode_table;
 			     j < fs->inode_blocks_per_group;
 			     j++, b++) {
-				if (ext2fs_test_block_bitmap(ctx->block_found_map,
+				if (ext2fs_test_block_bitmap_64(ctx->block_found_map,
 							     b)) {
 					pctx.blk = b;
 					if (fix_problem(ctx,
@@ -2014,7 +2014,7 @@ static void mark_table_blocks(e2fsck_t c
 						ctx->invalid_bitmaps++;
 					}
 				} else {
-				    ext2fs_mark_block_bitmap(ctx->block_found_map,
+				    ext2fs_mark_block_bitmap_64(ctx->block_found_map,
 							     b);
 			    	}
 			}
@@ -2024,7 +2024,7 @@ static void mark_table_blocks(e2fsck_t c
 		 * Mark block used for the block bitmap 
 		 */
 		if (fs->group_desc[i].bg_block_bitmap) {
-			if (ext2fs_test_block_bitmap(ctx->block_found_map,
+			if (ext2fs_test_block_bitmap_64(ctx->block_found_map,
 				     fs->group_desc[i].bg_block_bitmap)) {
 				pctx.blk = fs->group_desc[i].bg_block_bitmap;
 				if (fix_problem(ctx, PR_1_BB_CONFLICT, &pctx)) {
@@ -2032,7 +2032,7 @@ static void mark_table_blocks(e2fsck_t c
 					ctx->invalid_bitmaps++;
 				}
 			} else {
-			    ext2fs_mark_block_bitmap(ctx->block_found_map,
+			    ext2fs_mark_block_bitmap_64(ctx->block_found_map,
 				     fs->group_desc[i].bg_block_bitmap);
 		    }
 			
@@ -2041,7 +2041,7 @@ static void mark_table_blocks(e2fsck_t c
 		 * Mark block used for the inode bitmap 
 		 */
 		if (fs->group_desc[i].bg_inode_bitmap) {
-			if (ext2fs_test_block_bitmap(ctx->block_found_map,
+			if (ext2fs_test_block_bitmap_64(ctx->block_found_map,
 				     fs->group_desc[i].bg_inode_bitmap)) {
 				pctx.blk = fs->group_desc[i].bg_inode_bitmap;
 				if (fix_problem(ctx, PR_1_IB_CONFLICT, &pctx)) {
@@ -2049,7 +2049,7 @@ static void mark_table_blocks(e2fsck_t c
 					ctx->invalid_bitmaps++;
 				} 
 			} else {
-			    ext2fs_mark_block_bitmap(ctx->block_found_map,
+			    ext2fs_mark_block_bitmap_64(ctx->block_found_map,
 				     fs->group_desc[i].bg_inode_bitmap);
 			}
 		}
diff -upNr e2fsprogs-1.39/e2fsck/pass1b.c e2fsprogs-1.39.tmp/e2fsck/pass1b.c
--- e2fsprogs-1.39/e2fsck/pass1b.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass1b.c	2006-04-21 11:51:17.000000000 +0900
@@ -320,7 +320,7 @@ static int process_pass1b_block(ext2_fil
 	p = (struct process_block_struct *) priv_data;
 	ctx = p->ctx;
 	
-	if (!ext2fs_test_block_bitmap(ctx->block_dup_map, *block_nr))
+	if (!ext2fs_test_block_bitmap_64(ctx->block_dup_map, *block_nr))
 		return 0;
 	
 	/* OK, this is a duplicate block */
@@ -527,7 +527,7 @@ static void decrement_badcount(e2fsck_t 
 	p->num_bad--;
 	if (p->num_bad <= 0 ||
 	    (p->num_bad == 1 && !check_if_fs_block(ctx, block)))
-		ext2fs_unmark_block_bitmap(ctx->block_dup_map, block);
+		ext2fs_unmark_block_bitmap_64(ctx->block_dup_map, block);
 }
 
 static int delete_file_block(ext2_filsys fs,
@@ -548,7 +548,7 @@ static int delete_file_block(ext2_filsys
 	if (HOLE_BLKADDR(*block_nr))
 		return 0;
 
-	if (ext2fs_test_block_bitmap(ctx->block_dup_map, *block_nr)) {
+	if (ext2fs_test_block_bitmap_64(ctx->block_dup_map, *block_nr)) {
 		n = dict_lookup(&blk_dict, INT_TO_VOIDPTR(*block_nr));
 		if (n) {
 			p = (struct dup_block *) dnode_get(n);
@@ -558,7 +558,7 @@ static int delete_file_block(ext2_filsys
 			    _("internal error; can't find dup_blk for %u\n"),
 				*block_nr);
 	} else {
-		ext2fs_unmark_block_bitmap(ctx->block_found_map, *block_nr);
+		ext2fs_unmark_block_bitmap_64(ctx->block_found_map, *block_nr);
 		ext2fs_block_alloc_stats(fs, *block_nr, -1);
 	}
 		
@@ -616,7 +616,7 @@ static void delete_file(e2fsck_t ctx, ex
 		 * of keeping the accounting straight.
 		 */
 		if ((count == 0) ||
-		    ext2fs_test_block_bitmap(ctx->block_dup_map,
+		    ext2fs_test_block_bitmap_64(ctx->block_dup_map,
 					     inode.i_file_acl)) 
 			delete_file_block(fs, &inode.i_file_acl,
 					  BLOCK_COUNT_EXTATTR, 0, 0, &pb);
@@ -650,7 +650,7 @@ static int clone_file_block(ext2_filsys 
 	if (HOLE_BLKADDR(*block_nr))
 		return 0;
 
-	if (ext2fs_test_block_bitmap(ctx->block_dup_map, *block_nr)) {
+	if (ext2fs_test_block_bitmap_64(ctx->block_dup_map, *block_nr)) {
 		n = dict_lookup(&blk_dict, INT_TO_VOIDPTR(*block_nr));
 		if (n) {
 			p = (struct dup_block *) dnode_get(n);
@@ -686,9 +686,9 @@ static int clone_file_block(ext2_filsys 
 			}
 			decrement_badcount(ctx, *block_nr, p);
 			*block_nr = new_block;
-			ext2fs_mark_block_bitmap(ctx->block_found_map,
+			ext2fs_mark_block_bitmap_64(ctx->block_found_map,
 						 new_block);
-			ext2fs_mark_block_bitmap(fs->block_map, new_block);
+			ext2fs_mark_block_bitmap_64(fs->block_map, new_block);
 			return BLOCK_CHANGED;
 		} else
 			com_err("clone_file_block", 0,
diff -upNr e2fsprogs-1.39/e2fsck/pass2.c e2fsprogs-1.39.tmp/e2fsck/pass2.c
--- e2fsprogs-1.39/e2fsck/pass2.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass2.c	2006-04-21 11:51:17.000000000 +0900
@@ -1079,7 +1079,7 @@ static int deallocate_inode_block(ext2_f
 	if ((*block_nr < fs->super->s_first_data_block) ||
 	    (*block_nr >= fs->super->s_blocks_count))
 		return 0;
-	ext2fs_unmark_block_bitmap(ctx->block_found_map, *block_nr);
+	ext2fs_unmark_block_bitmap_64(ctx->block_found_map, *block_nr);
 	ext2fs_block_alloc_stats(fs, *block_nr, -1);
 	return 0;
 }
@@ -1127,7 +1127,7 @@ static void deallocate_inode(e2fsck_t ct
 			return;
 		}
 		if (count == 0) {
-			ext2fs_unmark_block_bitmap(ctx->block_found_map,
+			ext2fs_unmark_block_bitmap_64(ctx->block_found_map,
 						   inode.i_file_acl);
 			ext2fs_block_alloc_stats(fs, inode.i_file_acl, -1);
 		}
@@ -1344,8 +1344,8 @@ static int allocate_dir_block(e2fsck_t c
 		fix_problem(ctx, PR_2_ALLOC_DIRBOCK, pctx);
 		return 1;
 	}
-	ext2fs_mark_block_bitmap(ctx->block_found_map, blk);
-	ext2fs_mark_block_bitmap(fs->block_map, blk);
+	ext2fs_mark_block_bitmap_64(ctx->block_found_map, blk);
+	ext2fs_mark_block_bitmap_64(fs->block_map, blk);
 	ext2fs_mark_bb_dirty(fs);
 
 	/*
diff -upNr e2fsprogs-1.39/e2fsck/pass3.c e2fsprogs-1.39.tmp/e2fsck/pass3.c
--- e2fsprogs-1.39/e2fsck/pass3.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass3.c	2006-04-21 11:51:17.000000000 +0900
@@ -191,8 +191,8 @@ static void check_root(e2fsck_t ctx)
 		ctx->flags |= E2F_FLAG_ABORT;
 		return;
 	}
-	ext2fs_mark_block_bitmap(ctx->block_found_map, blk);
-	ext2fs_mark_block_bitmap(fs->block_map, blk);
+	ext2fs_mark_block_bitmap_64(ctx->block_found_map, blk);
+	ext2fs_mark_block_bitmap_64(fs->block_map, blk);
 	ext2fs_mark_bb_dirty(fs);
 
 	/*
@@ -429,7 +429,7 @@ ext2_ino_t e2fsck_get_lost_and_found(e2f
 		fix_problem(ctx, PR_3_ERR_LPF_NEW_BLOCK, &pctx);
 		return 0;
 	}
-	ext2fs_mark_block_bitmap(ctx->block_found_map, blk);
+	ext2fs_mark_block_bitmap_64(ctx->block_found_map, blk);
 	ext2fs_block_alloc_stats(fs, blk, +1);
 
 	/*
@@ -743,7 +743,7 @@ static int expand_dir_proc(ext2_filsys f
 	}
 	ext2fs_free_mem(&block);
 	*blocknr = new_blk;
-	ext2fs_mark_block_bitmap(ctx->block_found_map, new_blk);
+	ext2fs_mark_block_bitmap_64(ctx->block_found_map, new_blk);
 	ext2fs_block_alloc_stats(fs, new_blk, +1);
 	es->newblocks++;
 	
diff -upNr e2fsprogs-1.39/e2fsck/pass5.c e2fsprogs-1.39.tmp/e2fsck/pass5.c
--- e2fsprogs-1.39/e2fsck/pass5.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass5.c	2006-04-21 11:51:17.000000000 +0900
@@ -163,8 +163,8 @@ redo_counts:
 	for (i = fs->super->s_first_data_block;
 	     i < fs->super->s_blocks_count;
 	     i++) {
-		actual = ext2fs_fast_test_block_bitmap(ctx->block_found_map, i);
-		bitmap = ext2fs_fast_test_block_bitmap(fs->block_map, i);
+		actual = ext2fs_fast_test_block_bitmap_64(ctx->block_found_map, i);
+		bitmap = ext2fs_fast_test_block_bitmap_64(fs->block_map, i);
 		
 		if (actual == bitmap)
 			goto do_counts;
@@ -509,7 +509,7 @@ static void check_block_end(e2fsck_t ctx
 
 	end = fs->block_map->start +
 		(EXT2_BLOCKS_PER_GROUP(fs->super) * (__u64)fs->group_desc_count) - 1;
-	pctx.errcode = ext2fs_fudge_block_bitmap_end(fs->block_map, end,
+	pctx.errcode = ext2fs_fudge_block_bitmap_end_64(fs->block_map, end,
 						     &save_blocks_count);
 	if (pctx.errcode) {
 		pctx.num = 3;
@@ -521,10 +521,10 @@ static void check_block_end(e2fsck_t ctx
 		return;
 	
 	for (i = save_blocks_count + 1; i <= end; i++) {
-		if (!ext2fs_test_block_bitmap(fs->block_map, i)) {
+		if (!ext2fs_test_block_bitmap_64(fs->block_map, i)) {
 			if (fix_problem(ctx, PR_5_BLOCK_BMAP_PADDING, &pctx)) {
 				for (i = save_blocks_count + 1; i <= end; i++)
-					ext2fs_mark_block_bitmap(fs->block_map,
+					ext2fs_mark_block_bitmap_64(fs->block_map,
 								 i);
 				ext2fs_mark_bb_dirty(fs);
 			} else
@@ -533,7 +533,7 @@ static void check_block_end(e2fsck_t ctx
 		}
 	}
 
-	pctx.errcode = ext2fs_fudge_block_bitmap_end(fs->block_map,
+	pctx.errcode = ext2fs_fudge_block_bitmap_end_64(fs->block_map,
 						     save_blocks_count, 0);
 	if (pctx.errcode) {
 		pctx.num = 4;
diff -upNr e2fsprogs-1.39/e2fsck/rehash.c e2fsprogs-1.39.tmp/e2fsck/rehash.c
--- e2fsprogs-1.39/e2fsck/rehash.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/rehash.c	2006-04-21 11:51:17.000000000 +0900
@@ -602,7 +602,7 @@ static int write_dir_block(ext2_filsys f
 	if (blockcnt >= wd->outdir->num) {
 		e2fsck_read_bitmaps(wd->ctx);
 		blk = *block_nr;
-		ext2fs_unmark_block_bitmap(wd->ctx->block_found_map, blk);
+		ext2fs_unmark_block_bitmap_64(wd->ctx->block_found_map, blk);
 		ext2fs_block_alloc_stats(fs, blk, -1);
 		*block_nr = 0;
 		wd->cleared++;
diff -upNr e2fsprogs-1.39/e2fsck/super.c e2fsprogs-1.39.tmp/e2fsck/super.c
--- e2fsprogs-1.39/e2fsck/super.c	2006-03-19 11:33:56.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/super.c	2006-04-21 11:51:17.000000000 +0900
@@ -97,7 +97,7 @@ static int release_inode_block(ext2_fils
 		return BLOCK_ABORT;
 	}
 
-	if (!ext2fs_test_block_bitmap(fs->block_map, blk)) {
+	if (!ext2fs_test_block_bitmap_64(fs->block_map, blk)) {
 		fix_problem(ctx, PR_0_ORPHAN_ALREADY_CLEARED_BLOCK, pctx);
 		goto return_abort;
 	}
diff -upNr e2fsprogs-1.39/lib/ext2fs/alloc.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc.c
--- e2fsprogs-1.39/lib/ext2fs/alloc.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc.c	2006-04-21 11:51:17.000000000 +0900
@@ -88,7 +88,7 @@ errcode_t ext2fs_new_block(ext2_filsys f
 		goal = fs->super->s_first_data_block;
 	i = goal;
 	do {
-		if (!ext2fs_fast_test_block_bitmap(map, i)) {
+		if (!ext2fs_fast_test_block_bitmap_64(map, i)) {
 			*ret = i;
 			return 0;
 		}
@@ -162,7 +162,7 @@ errcode_t ext2fs_get_free_blocks(ext2_fi
 	if (b+num-1 >= fs->super->s_blocks_count)
 		b = fs->super->s_first_data_block;
 	do {
-		if (ext2fs_fast_test_block_bitmap_range(map, b, num)) {
+		if (ext2fs_fast_test_block_bitmap_range_64(map, b, num)) {
 			*ret = b;
 			return 0;
 		}
diff -upNr e2fsprogs-1.39/lib/ext2fs/alloc_sb.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc_sb.c
--- e2fsprogs-1.39/lib/ext2fs/alloc_sb.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc_sb.c	2006-04-21 11:51:17.000000000 +0900
@@ -44,14 +44,14 @@ int ext2fs_reserve_super_and_bgd(ext2_fi
 			fs->desc_blocks + fs->super->s_reserved_gdt_blocks;
 
 	if (super_blk || (group == 0))
-		ext2fs_mark_block_bitmap(bmap, super_blk);
+		ext2fs_mark_block_bitmap_64(bmap, super_blk);
 
 	if (old_desc_blk) {
 		for (j=0; j < old_desc_blocks; j++)
-			ext2fs_mark_block_bitmap(bmap, old_desc_blk + j);
+			ext2fs_mark_block_bitmap_64(bmap, old_desc_blk + j);
 	}
 	if (new_desc_blk)
-		ext2fs_mark_block_bitmap(bmap, new_desc_blk);
+		ext2fs_mark_block_bitmap_64(bmap, new_desc_blk);
 
 	return num_blocks;
 }
diff -upNr e2fsprogs-1.39/lib/ext2fs/alloc_stats.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc_stats.c
--- e2fsprogs-1.39/lib/ext2fs/alloc_stats.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc_stats.c	2006-04-21 11:51:17.000000000 +0900
@@ -42,9 +42,9 @@ void ext2fs_block_alloc_stats(ext2_filsy
 	int	group = ext2fs_group_of_blk(fs, blk);
 
 	if (inuse > 0)
-		ext2fs_mark_block_bitmap(fs->block_map, blk);
+		ext2fs_mark_block_bitmap_64(fs->block_map, blk);
 	else
-		ext2fs_unmark_block_bitmap(fs->block_map, blk);
+		ext2fs_unmark_block_bitmap_64(fs->block_map, blk);
 	fs->group_desc[group].bg_free_blocks_count -= inuse;
 	fs->super->s_free_blocks_count -= inuse;
 	ext2fs_mark_super_dirty(fs);
diff -upNr e2fsprogs-1.39/lib/ext2fs/alloc_tables.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc_tables.c
--- e2fsprogs-1.39/lib/ext2fs/alloc_tables.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc_tables.c	2006-04-21 11:51:17.000000000 +0900
@@ -65,7 +65,7 @@ errcode_t ext2fs_allocate_group_table(ex
 					last_blk, 1, bmap, &new_blk);
 		if (retval)
 			return retval;
-		ext2fs_mark_block_bitmap(bmap, new_blk);
+		ext2fs_mark_block_bitmap_64(bmap, new_blk);
 		fs->group_desc[group].bg_block_bitmap = new_blk;
 	}
 
@@ -77,7 +77,7 @@ errcode_t ext2fs_allocate_group_table(ex
 					last_blk, 1, bmap, &new_blk);
 		if (retval)
 			return retval;
-		ext2fs_mark_block_bitmap(bmap, new_blk);
+		ext2fs_mark_block_bitmap_64(bmap, new_blk);
 		fs->group_desc[group].bg_inode_bitmap = new_blk;
 	}
 
@@ -93,7 +93,7 @@ errcode_t ext2fs_allocate_group_table(ex
 		for (j=0, blk = new_blk;
 		     j < fs->inode_blocks_per_group;
 		     j++, blk++)
-			ext2fs_mark_block_bitmap(bmap, blk);
+			ext2fs_mark_block_bitmap_64(bmap, blk);
 		fs->group_desc[group].bg_inode_table = new_blk;
 	}
 
diff -upNr e2fsprogs-1.39/lib/ext2fs/bb_inode.c e2fsprogs-1.39.tmp/lib/ext2fs/bb_inode.c
--- e2fsprogs-1.39/lib/ext2fs/bb_inode.c	2005-09-25 09:06:42.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bb_inode.c	2006-04-21 11:51:17.000000000 +0900
@@ -235,7 +235,7 @@ static int set_bad_block_proc(ext2_filsy
 	retry:
 		if (rec->ind_blocks_ptr < rec->ind_blocks_size) {
 			blk = rec->ind_blocks[rec->ind_blocks_ptr++];
-			if (ext2fs_test_block_bitmap(fs->block_map, blk))
+			if (ext2fs_test_block_bitmap_64(fs->block_map, blk))
 				goto retry;
 		} else {
 			retval = ext2fs_new_block(fs, 0, 0, &blk);
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitmaps.c e2fsprogs-1.39.tmp/lib/ext2fs/bitmaps.c
--- e2fsprogs-1.39/lib/ext2fs/bitmaps.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitmaps.c	2006-04-21 11:51:17.000000000 +0900
@@ -27,7 +27,7 @@
 #include "ext2_fs.h"
 #include "ext2fs.h"
 
-static errcode_t make_bitmap(__u32 start, __u32 end, __u32 real_end,
+static errcode_t make_bitmap(__u32 start, __u32 end, __u64 real_end,
 			     const char *descr, char *init_map,
 			     ext2fs_generic_bitmap *ret)
 {
@@ -78,6 +78,15 @@ errcode_t ext2fs_allocate_generic_bitmap
 					 const char *descr,
 					 ext2fs_generic_bitmap *ret)
 {
+        return make_bitmap(start, end, real_end, descr, 0, ret);
+}
+
+errcode_t ext2fs_allocate_generic_bitmap_64(__u32 start,
+					 __u32 end,
+					 __u64 real_end,
+					 const char *descr,
+					 ext2fs_generic_bitmap *ret)
+{
 	return make_bitmap(start, end, real_end, descr, 0, ret);
 }
 
@@ -103,7 +112,7 @@ void ext2fs_set_bitmap_padding(ext2fs_ge
 	__u32	i, j;
 
 	for (i=map->end+1, j = i - map->start; i <= map->real_end; i++, j++)
-		ext2fs_set_bit(j, map->bitmap);
+		ext2fs_set_bit_64(j, map->bitmap);
 
 	return;
 }	
@@ -124,7 +133,7 @@ errcode_t ext2fs_allocate_inode_bitmap(e
 	end = fs->super->s_inodes_count;
 	real_end = (EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count);
 
-	retval = ext2fs_allocate_generic_bitmap(start, end, real_end,
+	retval = ext2fs_allocate_generic_bitmap_64(start, end, real_end,
 						descr, &bitmap);
 	if (retval)
 		return retval;
@@ -143,7 +152,8 @@ errcode_t ext2fs_allocate_block_bitmap(e
 {
 	ext2fs_block_bitmap bitmap;
 	errcode_t	retval;
-	__u32		start, end, real_end;
+	__u32		start, end;
+	__u64		real_end;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -151,10 +161,10 @@ errcode_t ext2fs_allocate_block_bitmap(e
 
 	start = fs->super->s_first_data_block;
 	end = fs->super->s_blocks_count-1;
-	real_end = (EXT2_BLOCKS_PER_GROUP(fs->super)  
+	real_end = ((__u64)EXT2_BLOCKS_PER_GROUP(fs->super)  
 		    * fs->group_desc_count)-1 + start;
 	
-	retval = ext2fs_allocate_generic_bitmap(start, end, real_end,
+	retval = ext2fs_allocate_generic_bitmap_64(start, end, real_end,
 						descr, &bitmap);
 	if (retval)
 		return retval;
@@ -183,6 +193,12 @@ errcode_t ext2fs_fudge_inode_bitmap_end(
 errcode_t ext2fs_fudge_block_bitmap_end(ext2fs_block_bitmap bitmap,
 					blk_t end, blk_t *oend)
 {
+	ext2fs_fudge_block_bitmap_end_64(bitmap, end, (blk64_t *)oend);
+}
+
+errcode_t ext2fs_fudge_block_bitmap_end_64(ext2fs_block_bitmap bitmap,
+					blk64_t end, blk64_t *oend)
+{
 	EXT2_CHECK_MAGIC(bitmap, EXT2_ET_MAGIC_BLOCK_BITMAP);
 	
 	if (end > bitmap->real_end)
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.c e2fsprogs-1.39.tmp/lib/ext2fs/bitops.c
--- e2fsprogs-1.39/lib/ext2fs/bitops.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.c	2006-04-21 11:51:17.000000000 +0900
@@ -77,6 +77,17 @@ void ext2fs_warn_bitmap(errcode_t errcod
 #endif
 }
 
+void ext2fs_warn_bitmap_64(errcode_t errcode, blk64_t arg,
+			const char *description)
+{
+#ifndef OMIT_COM_ERR
+	if (description)
+		com_err(0, errcode, "#%llu for %s", arg, description);
+	else
+		com_err(0, errcode, "#%llu", arg);
+#endif
+}
+
 void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
 			    int code, unsigned long arg)
 {
@@ -89,3 +100,15 @@ void ext2fs_warn_bitmap2(ext2fs_generic_
 #endif
 }
 
+void ext2fs_warn_bitmap2_64(ext2fs_generic_bitmap bitmap,
+			    int code, blk64_t arg)
+{
+#ifndef OMIT_COM_ERR
+	if (bitmap->description)
+		com_err(0, bitmap->base_error_code+code,
+			"#%llu for %s", arg, bitmap->description);
+	else
+		com_err(0, bitmap->base_error_code + code, "#%llu", arg);
+#endif
+}
+
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.h e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h
--- e2fsprogs-1.39/lib/ext2fs/bitops.h	2006-03-30 02:51:53.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h	2006-04-21 13:04:17.000000000 +0900
@@ -13,12 +13,16 @@
  * Linus Torvalds.
  */
 
-
 extern int ext2fs_set_bit(unsigned int nr,void * addr);
+extern int ext2fs_set_bit_64(blk64_t nr,void * addr);
 extern int ext2fs_clear_bit(unsigned int nr, void * addr);
+extern int ext2fs_clear_bit_64(blk64_t nr, void * addr);
 extern int ext2fs_test_bit(unsigned int nr, const void * addr);
+extern int ext2fs_test_bit_64(blk64_t nr, const void * addr);
 extern void ext2fs_fast_set_bit(unsigned int nr,void * addr);
+extern void ext2fs_fast_set_bit_64(blk64_t nr,void * addr);
 extern void ext2fs_fast_clear_bit(unsigned int nr, void * addr);
+extern void ext2fs_fast_clear_bit_64(blk64_t nr, void * addr);
 extern __u16 ext2fs_swab16(__u16 val);
 extern __u32 ext2fs_swab32(__u32 val);
 
@@ -54,13 +58,21 @@ extern const char *ext2fs_unmark_string;
 extern const char *ext2fs_test_string;
 extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
 			       const char *description);
+extern void ext2fs_warn_bitmap_64(errcode_t errcode, blk64_t arg,
+			          const char *description);
 extern void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
 				int code, unsigned long arg);
+extern void ext2fs_warn_bitmap2_64(ext2fs_generic_bitmap bitmap,
+				   int code, blk64_t arg);
 
 extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
+extern int ext2fs_mark_block_bitmap_64 (ext2fs_block_bitmap bitmap, blk64_t block);
 extern int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
 				       blk_t block);
+extern int ext2fs_unmark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+				         blk64_t block);
 extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
+extern int ext2fs_test_block_bitmap_64(ext2fs_block_bitmap bitmap, blk64_t block);
 
 extern int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap, ext2_ino_t inode);
 extern int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -69,10 +81,16 @@ extern int ext2fs_test_inode_bitmap(ext2
 
 extern void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
 					  blk_t block);
+extern void ext2fs_fast_mark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					     blk64_t block);
 extern void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
 					    blk_t block);
+extern void ext2fs_fast_unmark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					       blk64_t block);
 extern int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
 					 blk_t block);
+extern int ext2fs_fast_test_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					    blk64_t block);
 
 extern void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 					  ext2_ino_t inode);
@@ -87,23 +105,39 @@ extern ext2_ino_t ext2fs_get_inode_bitma
 
 extern void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					   blk_t block, int num);
+extern void ext2fs_mark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					      blk64_t block, int num);
 extern void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					     blk_t block, int num);
+extern void ext2fs_unmark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					        blk64_t block, int num);
 extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					  blk_t block, int num);
+extern int ext2fs_test_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					     blk64_t block, int num);
 extern void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 						blk_t block, int num);
+extern void ext2fs_fast_mark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+						   blk64_t block, int num);
 extern void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 						  blk_t block, int num);
+extern void ext2fs_fast_unmark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+						     blk64_t block, int num);
 extern int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					       blk_t block, int num);
+extern int ext2fs_fast_test_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					          blk64_t block, int num);
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 
 /* These two routines moved to gen_bitmap.c */
 extern int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
 					 __u32 bitno);
+extern int ext2fs_mark_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					 __u64 bitno);
 extern int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
 					   blk_t bitno);
+extern int ext2fs_unmark_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					   blk64_t bitno);
 /*
  * The inline routines themselves...
  * 
@@ -136,22 +170,32 @@ extern int ext2fs_unmark_generic_bitmap(
  * previous bit value.
  */
 
-_INLINE_ void ext2fs_fast_set_bit(unsigned int nr,void * addr)
+_INLINE_ void ext2fs_fast_set_bit_64(blk64_t nr,void * addr)
 {
-	unsigned char	*ADDR = (unsigned char *) addr;
+	unsigned char   *ADDR = (unsigned char *) addr; 
 
 	ADDR += nr >> 3;
 	*ADDR |= (1 << (nr & 0x07));
 }
 
-_INLINE_ void ext2fs_fast_clear_bit(unsigned int nr, void * addr)
+_INLINE_ void ext2fs_fast_set_bit(unsigned int nr,void * addr)
 {
-	unsigned char	*ADDR = (unsigned char *) addr;
+	ext2fs_fast_set_bit_64(nr, addr);
+}
+
+_INLINE_ void ext2fs_fast_clear_bit_64(blk64_t nr, void * addr)
+{
+	unsigned char   *ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	*ADDR &= ~(1 << (nr & 0x07));
 }
 
+_INLINE_ void ext2fs_fast_clear_bit(unsigned int nr, void * addr)
+{
+	ext2fs_fast_clear_bit_64(nr, addr);
+}
+
 
 #if ((defined __GNUC__) && !defined(_EXT2_USE_C_VERSIONS_) && \
      (defined(__i386__) || defined(__i486__) || defined(__i586__)))
@@ -175,7 +219,8 @@ struct __dummy_h { unsigned long a[100];
 #define EXT2FS_ADDR (*(struct __dummy_h *) addr)
 #define EXT2FS_CONST_ADDR (*(const struct __dummy_h *) addr)	
 
-_INLINE_ int ext2fs_set_bit(unsigned int nr, void * addr)
+
+_INLINE_ int ext2fs_set_bit_64(blk64_t nr, void * addr)
 {
 	int oldbit;
 
@@ -186,7 +231,12 @@ _INLINE_ int ext2fs_set_bit(unsigned int
 	return oldbit;
 }
 
-_INLINE_ int ext2fs_clear_bit(unsigned int nr, void * addr)
+_INLINE_ int ext2fs_set_bit(unsigned int nr, void * addr)
+{
+	ext2fs_set_bit_64(nr, addr);
+}
+
+_INLINE_ int ext2fs_clear_bit_64(blk64_t nr, void * addr)
 {
 	int oldbit;
 
@@ -197,7 +247,12 @@ _INLINE_ int ext2fs_clear_bit(unsigned i
 	return oldbit;
 }
 
-_INLINE_ int ext2fs_test_bit(unsigned int nr, const void * addr)
+_INLINE_ int ext2fs_clear_bit(unsigned int nr, void * addr)
+{
+	ext2fs_clear_bit_64(nr, addr);
+}
+
+_INLINE_ int ext2fs_test_bit_64(blk64_t nr, const void * addr)
 {
 	int oldbit;
 
@@ -208,6 +263,11 @@ _INLINE_ int ext2fs_test_bit(unsigned in
 	return oldbit;
 }
 
+_INLINE_ int ext2fs_test_bit(unsigned int nr, const void * addr)
+{
+	ext2fs_test_bit_64(nr, addr);
+}
+
 #if 0
 _INLINE_ int ext2fs_find_first_bit_set(void * addr, unsigned size)
 {
@@ -295,7 +355,7 @@ _INLINE_ __u16 ext2fs_swab16(__u16 val)
 
 #define _EXT2_HAVE_ASM_BITOPS_
 
-_INLINE_ int ext2fs_set_bit(unsigned int nr,void * addr)
+_INLINE_ int ext2fs_set_bit_64(blk64_t nr,void * addr)
 {
 	char retval;
 
@@ -305,7 +365,12 @@ _INLINE_ int ext2fs_set_bit(unsigned int
 	return retval;
 }
 
-_INLINE_ int ext2fs_clear_bit(unsigned int nr, void * addr)
+_INLINE_ int ext2fs_set_bit(unsigned int nr, void * addr)
+{
+	ext2fs_set_bit_64(nr, addr);
+}
+
+_INLINE_ int ext2fs_clear_bit_64(blk64_t nr, void * addr)
 {
 	char retval;
 
@@ -315,7 +380,12 @@ _INLINE_ int ext2fs_clear_bit(unsigned i
 	return retval;
 }
 
-_INLINE_ int ext2fs_test_bit(unsigned int nr, const void * addr)
+_INLINE_ int ext2fs_clear_bit(unsigned int nr, void * addr)
+{
+	ext2fs_clear_bit_64(nr, addr);
+}
+
+_INLINE_ int ext2fs_test_bit_64(blk64_t nr, const void * addr)
 {
 	char retval;
 
@@ -325,6 +395,11 @@ _INLINE_ int ext2fs_test_bit(unsigned in
 	return retval;
 }
 
+_INLINE_ int ext2fs_test_bit(unsigned int nr, const void * addr)
+{
+	ext2fs_test_bit_64(nr, addr);
+}
+
 #endif /* __mc68000__ */
 
 
@@ -403,6 +478,19 @@ _INLINE_ int ext2fs_test_generic_bitmap(
 	return ext2fs_test_bit(bitno - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ int ext2fs_test_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					blk64_t bitno);
+
+_INLINE_ int ext2fs_test_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					blk64_t bitno)
+{
+	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
+		ext2fs_warn_bitmap2_64(bitmap, EXT2FS_TEST_ERROR, bitno);
+		return 0;
+	}
+	return ext2fs_test_bit_64(bitno - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap,
 				       blk_t block)
 {
@@ -411,6 +499,13 @@ _INLINE_ int ext2fs_mark_block_bitmap(ex
 					  block);
 }
 
+_INLINE_ int ext2fs_mark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+				       blk64_t block)
+{
+	return ext2fs_mark_generic_bitmap_64((ext2fs_generic_bitmap)
+					     bitmap, block);
+}
+
 _INLINE_ int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
 					 blk_t block)
 {
@@ -418,6 +513,13 @@ _INLINE_ int ext2fs_unmark_block_bitmap(
 					    block);
 }
 
+_INLINE_ int ext2fs_unmark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					   blk64_t block)
+{
+	return ext2fs_unmark_generic_bitmap_64((ext2fs_generic_bitmap) bitmap, 
+					    block);
+}
+
 _INLINE_ int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap,
 				       blk_t block)
 {
@@ -425,24 +527,31 @@ _INLINE_ int ext2fs_test_block_bitmap(ex
 					  block);
 }
 
+_INLINE_ int ext2fs_test_block_bitmap_64(ext2fs_block_bitmap bitmap,
+				       blk64_t block)
+{
+	return ext2fs_test_generic_bitmap_64((ext2fs_generic_bitmap) bitmap, 
+					  block);
+}
+
 _INLINE_ int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 				       ext2_ino_t inode)
 {
-	return ext2fs_mark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
+	return ext2fs_mark_generic_bitmap_64((ext2fs_generic_bitmap) bitmap, 
 					  inode);
 }
 
 _INLINE_ int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 					 ext2_ino_t inode)
 {
-	return ext2fs_unmark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
+	return ext2fs_unmark_generic_bitmap_64((ext2fs_generic_bitmap) bitmap, 
 				     inode);
 }
 
 _INLINE_ int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
 				       ext2_ino_t inode)
 {
-	return ext2fs_test_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
+	return ext2fs_test_generic_bitmap_64((ext2fs_generic_bitmap) bitmap, 
 					  inode);
 }
 
@@ -459,6 +568,19 @@ _INLINE_ void ext2fs_fast_mark_block_bit
 	ext2fs_fast_set_bit(block - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ void ext2fs_fast_mark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					    blk64_t block)
+{
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_MARK, block,
+				   bitmap->description);
+		return;
+	}
+#endif	
+	ext2fs_fast_set_bit_64(block - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
 					      blk_t block)
 {
@@ -472,6 +594,19 @@ _INLINE_ void ext2fs_fast_unmark_block_b
 	ext2fs_fast_clear_bit(block - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ void ext2fs_fast_unmark_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					      blk64_t block)
+{
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_UNMARK,
+				   block, bitmap->description);
+		return;
+	}
+#endif
+	ext2fs_fast_clear_bit_64(block - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
 					    blk_t block)
 {
@@ -485,17 +620,30 @@ _INLINE_ int ext2fs_fast_test_block_bitm
 	return ext2fs_test_bit(block - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ int ext2fs_fast_test_block_bitmap_64(ext2fs_block_bitmap bitmap,
+					    blk64_t block)
+{
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_TEST,
+				   block, bitmap->description);
+		return 0;
+	}
+#endif
+	return ext2fs_test_bit_64(block - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 					    ext2_ino_t inode)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
-		ext2fs_warn_bitmap(EXT2_ET_BAD_INODE_MARK,
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_INODE_MARK,
 				   inode, bitmap->description);
 		return;
 	}
 #endif
-	ext2fs_fast_set_bit(inode - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_set_bit_64(inode - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -503,12 +651,12 @@ _INLINE_ void ext2fs_fast_unmark_inode_b
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
-		ext2fs_warn_bitmap(EXT2_ET_BAD_INODE_UNMARK,
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_INODE_UNMARK,
 				   inode, bitmap->description);
 		return;
 	}
 #endif
-	ext2fs_fast_clear_bit(inode - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_clear_bit_64(inode - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -516,12 +664,12 @@ _INLINE_ int ext2fs_fast_test_inode_bitm
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
-		ext2fs_warn_bitmap(EXT2_ET_BAD_INODE_TEST,
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_INODE_TEST,
 				   inode, bitmap->description);
 		return 0;
 	}
 #endif
-	return ext2fs_test_bit(inode - bitmap->start, bitmap->bitmap);
+	return ext2fs_test_bit_64(inode - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ blk_t ext2fs_get_block_bitmap_start(ext2fs_block_bitmap bitmap)
@@ -561,6 +709,23 @@ _INLINE_ int ext2fs_test_block_bitmap_ra
 	return 1;
 }
 
+_INLINE_ int ext2fs_test_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					    blk64_t block, int num)
+{
+	int	i;
+
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_TEST,
+				   block, bitmap->description);
+		return 0;
+	}
+	for (i=0; i < num; i++) {
+		if (ext2fs_fast_test_block_bitmap_64(bitmap, block+i))
+			return 0;
+	}
+	return 1;
+}
+
 _INLINE_ int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 						 blk_t block, int num)
 {
@@ -580,6 +745,25 @@ _INLINE_ int ext2fs_fast_test_block_bitm
 	return 1;
 }
 
+_INLINE_ int ext2fs_fast_test_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+						 blk64_t block, int num)
+{
+	int	i;
+
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_TEST,
+				   block, bitmap->description);
+		return 0;
+	}
+#endif
+	for (i=0; i < num; i++) {
+		if (ext2fs_fast_test_block_bitmap_64(bitmap, block+i))
+			return 0;
+	}
+	return 1;
+}
+
 _INLINE_ void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					     blk_t block, int num)
 {
@@ -594,6 +778,20 @@ _INLINE_ void ext2fs_mark_block_bitmap_r
 		ext2fs_fast_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ void ext2fs_mark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					     blk64_t block, int num)
+{
+	int	i;
+	
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_MARK, block,
+				   bitmap->description);
+		return;
+	}
+	for (i=0; i < num; i++)
+		ext2fs_fast_set_bit_64(block + i - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 						  blk_t block, int num)
 {
@@ -610,6 +808,22 @@ _INLINE_ void ext2fs_fast_mark_block_bit
 		ext2fs_fast_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
+_INLINE_ void ext2fs_fast_mark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+						  blk64_t block, int num)
+{
+	int	i;
+	
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_MARK, block,
+				   bitmap->description);
+		return;
+	}
+#endif	
+	for (i=0; i < num; i++)
+		ext2fs_fast_set_bit_64(block + i - bitmap->start, bitmap->bitmap);
+}
+
 _INLINE_ void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					       blk_t block, int num)
 {
@@ -625,6 +839,21 @@ _INLINE_ void ext2fs_unmark_block_bitmap
 				      bitmap->bitmap);
 }
 
+_INLINE_ void ext2fs_unmark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+					       blk64_t block, int num)
+{
+	int	i;
+	
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap_64(EXT2_ET_BAD_BLOCK_UNMARK, block,
+				   bitmap->description);
+		return;
+	}
+	for (i=0; i < num; i++)
+		ext2fs_fast_clear_bit_64(block + i - bitmap->start, 
+				      bitmap->bitmap);
+}
+
 _INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 						    blk_t block, int num)
 {
@@ -641,6 +870,23 @@ _INLINE_ void ext2fs_fast_unmark_block_b
 		ext2fs_fast_clear_bit(block + i - bitmap->start, 
 				      bitmap->bitmap);
 }
+
+_INLINE_ void ext2fs_fast_unmark_block_bitmap_range_64(ext2fs_block_bitmap bitmap,
+						    blk64_t block, int num)
+{
+	int	i;
+	
+#ifdef EXT2FS_DEBUG_FAST_OPS
+	if ((block < bitmap->start) || (block+num-1 > bitmap->end)) {
+		ext2fs_warn_bitmap64(EXT2_ET_BAD_BLOCK_UNMARK, block,
+				   bitmap->description);
+		return;
+	}
+#endif	
+	for (i=0; i < num; i++)
+		ext2fs_fast_clear_bit_64(block + i - bitmap->start, 
+				      bitmap->bitmap);
+}
 #undef _INLINE_
 #endif
 
diff -upNr e2fsprogs-1.39/lib/ext2fs/ext2fs.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h
--- e2fsprogs-1.39/lib/ext2fs/ext2fs.h	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h	2006-04-21 11:51:17.000000000 +0900
@@ -103,7 +103,7 @@ struct ext2fs_struct_generic_bitmap {
 	errcode_t	magic;
 	ext2_filsys 	fs;
 	__u32		start, end;
-	__u32		real_end;
+	__u64		real_end;
 	char	*	description;
 	char	*	bitmap;
 	errcode_t	base_error_code;
@@ -549,6 +549,11 @@ extern errcode_t ext2fs_allocate_generic
 						__u32 real_end,
 						const char *descr,
 						ext2fs_generic_bitmap *ret);
+extern errcode_t ext2fs_allocate_generic_bitmap_64(__u32 start,
+						__u32 end,
+						__u64 real_end,
+						const char *descr,
+						ext2fs_generic_bitmap *ret);
 extern errcode_t ext2fs_allocate_block_bitmap(ext2_filsys fs,
 					      const char *descr,
 					      ext2fs_block_bitmap *ret);
@@ -559,6 +564,8 @@ extern errcode_t ext2fs_fudge_inode_bitm
 					       ext2_ino_t end, ext2_ino_t *oend);
 extern errcode_t ext2fs_fudge_block_bitmap_end(ext2fs_block_bitmap bitmap,
 					       blk_t end, blk_t *oend);
+extern errcode_t ext2fs_fudge_block_bitmap_end_64(ext2fs_block_bitmap bitmap,
+						  blk64_t end, blk64_t *oend);
 extern void ext2fs_clear_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern void ext2fs_clear_block_bitmap(ext2fs_block_bitmap bitmap);
 extern errcode_t ext2fs_read_bitmaps(ext2_filsys fs);
@@ -917,10 +924,15 @@ extern errcode_t ext2fs_create_resize_in
 extern errcode_t ext2fs_resize_generic_bitmap(__u32 new_end,
 					      __u32 new_real_end,
 					      ext2fs_generic_bitmap bmap);
+extern errcode_t ext2fs_resize_generic_bitmap_64(__u32 new_end,
+					      __u64 new_real_end,
+					      ext2fs_generic_bitmap bmap);
 extern errcode_t ext2fs_resize_inode_bitmap(__u32 new_end, __u32 new_real_end,
 					    ext2fs_inode_bitmap bmap);
 extern errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u32 new_real_end,
 					    ext2fs_block_bitmap bmap);
+extern errcode_t ext2fs_resize_block_bitmap_64(__u32 new_end, __u64 new_real_end,
+					    ext2fs_block_bitmap bmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
 
diff -upNr e2fsprogs-1.39/lib/ext2fs/gen_bitmap.c e2fsprogs-1.39.tmp/lib/ext2fs/gen_bitmap.c
--- e2fsprogs-1.39/lib/ext2fs/gen_bitmap.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/gen_bitmap.c	2006-04-21 11:51:17.000000000 +0900
@@ -34,7 +34,17 @@ int ext2fs_mark_generic_bitmap(ext2fs_ge
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_MARK_ERROR, bitno);
 		return 0;
 	}
-	return ext2fs_set_bit(bitno - bitmap->start, bitmap->bitmap);
+	return ext2fs_set_bit_64(bitno - bitmap->start, bitmap->bitmap);
+}
+
+int ext2fs_mark_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					 __u64 bitno)
+{
+	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
+		ext2fs_warn_bitmap2_64(bitmap, EXT2FS_MARK_ERROR, bitno);
+		return 0;
+	}
+	return ext2fs_set_bit_64(bitno - bitmap->start, bitmap->bitmap);
 }
 
 int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
@@ -44,5 +54,15 @@ int ext2fs_unmark_generic_bitmap(ext2fs_
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_UNMARK_ERROR, bitno);
 		return 0;
 	}
-	return ext2fs_clear_bit(bitno - bitmap->start, bitmap->bitmap);
+	return ext2fs_clear_bit_64(bitno - bitmap->start, bitmap->bitmap);
+}
+
+int ext2fs_unmark_generic_bitmap_64(ext2fs_generic_bitmap bitmap,
+					   blk64_t bitno)
+{
+	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
+		ext2fs_warn_bitmap2_64(bitmap, EXT2FS_UNMARK_ERROR, bitno);
+		return 0;
+	}
+	return ext2fs_clear_bit_64(bitno - bitmap->start, bitmap->bitmap);
 }
diff -upNr e2fsprogs-1.39/lib/ext2fs/rs_bitmap.c e2fsprogs-1.39.tmp/lib/ext2fs/rs_bitmap.c
--- e2fsprogs-1.39/lib/ext2fs/rs_bitmap.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/rs_bitmap.c	2006-04-21 11:51:17.000000000 +0900
@@ -47,7 +47,51 @@ errcode_t ext2fs_resize_generic_bitmap(_
 		if (bitno > new_end)
 			bitno = new_end;
 		for (; bitno > bmap->end; bitno--)
-			ext2fs_clear_bit(bitno - bmap->start, bmap->bitmap);
+			ext2fs_clear_bit_64(bitno - bmap->start, bmap->bitmap);
+	}
+	if (new_real_end == bmap->real_end) {
+		bmap->end = new_end;
+		return 0;
+	}
+	
+	size = ((bmap->real_end - bmap->start) / 8) + 1;
+	new_size = ((new_real_end - bmap->start) / 8) + 1;
+
+	if (size != new_size) {
+		retval = ext2fs_resize_mem(size, new_size, &bmap->bitmap);
+		if (retval)
+			return retval;
+	}
+	if (new_size > size)
+		memset(bmap->bitmap + size, 0, new_size - size);
+
+	bmap->end = new_end;
+	bmap->real_end = new_real_end;
+	return 0;
+}
+
+errcode_t ext2fs_resize_generic_bitmap_64(__u32 new_end, __u64 new_real_end,
+				       ext2fs_generic_bitmap bmap)
+{
+	errcode_t	retval;
+	size_t		size, new_size;
+	__u32		bitno;
+
+	if (!bmap)
+		return EXT2_ET_INVALID_ARGUMENT;
+
+	EXT2_CHECK_MAGIC(bmap, EXT2_ET_MAGIC_GENERIC_BITMAP);
+
+	/*
+	 * If we're expanding the bitmap, make sure all of the new
+	 * parts of the bitmap are zero.
+	 */
+	if (new_end > bmap->end) {
+		bitno = bmap->real_end;
+		if (bitno > new_end)
+			bitno = new_end;
+		for (; bitno > bmap->end; bitno--)
+			ext2fs_clear_bit_64(bitno - bmap->start, bmap->bitmap);
 	}
 	if (new_real_end == bmap->real_end) {
 		bmap->end = new_end;
@@ -81,7 +125,7 @@ errcode_t ext2fs_resize_inode_bitmap(__u
 	EXT2_CHECK_MAGIC(bmap, EXT2_ET_MAGIC_INODE_BITMAP);
 
 	bmap->magic = EXT2_ET_MAGIC_GENERIC_BITMAP;
-	retval = ext2fs_resize_generic_bitmap(new_end, new_real_end,
+	retval = ext2fs_resize_generic_bitmap_64(new_end, new_real_end,
 					      bmap);
 	bmap->magic = EXT2_ET_MAGIC_INODE_BITMAP;
 	return retval;
@@ -89,6 +133,23 @@ errcode_t ext2fs_resize_inode_bitmap(__u
 
 errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u32 new_real_end,
 				     ext2fs_block_bitmap bmap)
+{                       
+	errcode_t	retval;
+
+	if (!bmap)
+		return EXT2_ET_INVALID_ARGUMENT;
+
+	EXT2_CHECK_MAGIC(bmap, EXT2_ET_MAGIC_BLOCK_BITMAP);
+
+	bmap->magic = EXT2_ET_MAGIC_GENERIC_BITMAP;
+	retval = ext2fs_resize_generic_bitmap(new_end, new_real_end,
+					      bmap);
+	bmap->magic = EXT2_ET_MAGIC_BLOCK_BITMAP;
+	return retval;
+}
+
+errcode_t ext2fs_resize_block_bitmap_64(__u32 new_end, __u64 new_real_end,
+				     ext2fs_block_bitmap bmap)
 {
 	errcode_t	retval;
 	
@@ -98,7 +159,7 @@ errcode_t ext2fs_resize_block_bitmap(__u
 	EXT2_CHECK_MAGIC(bmap, EXT2_ET_MAGIC_BLOCK_BITMAP);
 
 	bmap->magic = EXT2_ET_MAGIC_GENERIC_BITMAP;
-	retval = ext2fs_resize_generic_bitmap(new_end, new_real_end,
+	retval = ext2fs_resize_generic_bitmap_64(new_end, new_real_end,
 					      bmap);
 	bmap->magic = EXT2_ET_MAGIC_BLOCK_BITMAP;
 	return retval;
diff -upNr e2fsprogs-1.39/lib/ext2fs/rw_bitmaps.c e2fsprogs-1.39.tmp/lib/ext2fs/rw_bitmaps.c
--- e2fsprogs-1.39/lib/ext2fs/rw_bitmaps.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/rw_bitmaps.c	2006-04-21 11:51:17.000000000 +0900
@@ -124,7 +124,7 @@ errcode_t ext2fs_write_block_bitmap (ext
 				 % EXT2_BLOCKS_PER_GROUP(fs->super));
 			if (nbits)
 				for (j = nbits; j < fs->blocksize * 8; j++)
-					ext2fs_set_bit(j, bitmap_block);
+					ext2fs_set_bit_64(j, bitmap_block);
 		}
 		blk = fs->group_desc[i].bg_block_bitmap;
 		if (blk) {
diff -upNr e2fsprogs-1.39/lib/ext2fs/tst_iscan.c e2fsprogs-1.39.tmp/lib/ext2fs/tst_iscan.c
--- e2fsprogs-1.39/lib/ext2fs/tst_iscan.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/tst_iscan.c	2006-04-21 11:51:17.000000000 +0900
@@ -174,19 +174,19 @@ static void check_map(void)
 	unsigned long	blk;
 
 	for (i=0; test_vec[i]; i++) {
-		if (ext2fs_test_block_bitmap(touched_map, test_vec[i])) {
+		if (ext2fs_test_block_bitmap_64(touched_map, test_vec[i])) {
 			printf("Bad block was touched --- %d\n", test_vec[i]);
 			failed++;
 			first_no_comma = 1;
 		}
-		ext2fs_mark_block_bitmap(touched_map, test_vec[i]);
+		ext2fs_mark_block_bitmap_64(touched_map, test_vec[i]);
 	}
 	for (i = 0; i < test_fs->group_desc_count; i++) {
 		for (j=0, blk = test_fs->group_desc[i].bg_inode_table;
 		     j < test_fs->inode_blocks_per_group;
 		     j++, blk++) {
-			if (!ext2fs_test_block_bitmap(touched_map, blk) &&
-			    !ext2fs_test_block_bitmap(bad_block_map, blk)) {
+			if (!ext2fs_test_block_bitmap_64(touched_map, blk) &&
+			    !ext2fs_test_block_bitmap_64(bad_block_map, blk)) {
 				printf("Missing block --- %lu\n", blk);
 				failed++;
 			}
diff -upNr e2fsprogs-1.39/misc/dumpe2fs.c e2fsprogs-1.39.tmp/misc/dumpe2fs.c
--- e2fsprogs-1.39/misc/dumpe2fs.c	2006-03-30 03:15:29.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/dumpe2fs.c	2006-04-21 11:51:17.000000000 +0900
@@ -42,7 +42,7 @@ extern int optind;
 #include "../version.h"
 #include "nls-enable.h"
 
-#define in_use(m, x)	(ext2fs_test_bit ((x), (m)))
+#define in_use(m, x)	(ext2fs_test_bit_64 ((x), (m)))
 
 const char * program_name = "dumpe2fs";
 char * device_name = NULL;
diff -upNr e2fsprogs-1.39/misc/e2image.c e2fsprogs-1.39.tmp/misc/e2image.c
--- e2fsprogs-1.39/misc/e2image.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/e2image.c	2006-04-21 11:51:17.000000000 +0900
@@ -223,9 +223,9 @@ static int process_dir_block(ext2_filsys
 
 	p = (struct process_block_struct *) priv_data;
 
-	ext2fs_mark_block_bitmap(meta_block_map, *block_nr);
+	ext2fs_mark_block_bitmap_64(meta_block_map, *block_nr);
 	if (scramble_block_map && p->is_dir && blockcnt >= 0) 
-		ext2fs_mark_block_bitmap(scramble_block_map, *block_nr);
+		ext2fs_mark_block_bitmap_64(scramble_block_map, *block_nr);
 	return 0;
 }
 
@@ -237,7 +237,7 @@ static int process_file_block(ext2_filsy
 			      void *priv_data EXT2FS_ATTR((unused)))
 {
 	if (blockcnt < 0) {
-		ext2fs_mark_block_bitmap(meta_block_map, *block_nr);
+		ext2fs_mark_block_bitmap_64(meta_block_map, *block_nr);
 	}
 	return 0;
 }
@@ -251,13 +251,13 @@ static void mark_table_blocks(ext2_filsy
 	/*
 	 * Mark primary superblock
 	 */
-	ext2fs_mark_block_bitmap(meta_block_map, block);
+	ext2fs_mark_block_bitmap_64(meta_block_map, block);
 			
 	/*
 	 * Mark the primary superblock descriptors
 	 */
 	for (j = 0; j < fs->desc_blocks; j++) {
-		ext2fs_mark_block_bitmap(meta_block_map,
+		ext2fs_mark_block_bitmap_64(meta_block_map,
 			 ext2fs_descriptor_block_loc(fs, block, j));
 	}
 
@@ -269,14 +269,14 @@ static void mark_table_blocks(ext2_filsy
 			for (j = 0, b = fs->group_desc[i].bg_inode_table;
 			     j < (unsigned) fs->inode_blocks_per_group;
 			     j++, b++)
-				ext2fs_mark_block_bitmap(meta_block_map, b);
+				ext2fs_mark_block_bitmap_64(meta_block_map, b);
 		}
 			    
 		/*
 		 * Mark block used for the block bitmap 
 		 */
 		if (fs->group_desc[i].bg_block_bitmap) {
-			ext2fs_mark_block_bitmap(meta_block_map,
+			ext2fs_mark_block_bitmap_64(meta_block_map,
 				     fs->group_desc[i].bg_block_bitmap);
 		}
 		
@@ -284,7 +284,7 @@ static void mark_table_blocks(ext2_filsy
 		 * Mark block used for the inode bitmap 
 		 */
 		if (fs->group_desc[i].bg_inode_bitmap) {
-			ext2fs_mark_block_bitmap(meta_block_map,
+			ext2fs_mark_block_bitmap_64(meta_block_map,
 				 fs->group_desc[i].bg_inode_bitmap);
 		}
 		block += fs->super->s_blocks_per_group;
@@ -414,14 +414,14 @@ static void output_meta_data_blocks(ext2
 	memset(zero_buf, 0, fs->blocksize);
 	for (blk = 0; blk < fs->super->s_blocks_count; blk++) {
 		if ((blk >= fs->super->s_first_data_block) &&
-		    ext2fs_test_block_bitmap(meta_block_map, blk)) {
+		    ext2fs_test_block_bitmap_64(meta_block_map, blk)) {
 			retval = io_channel_read_blk(fs->io, blk, 1, buf);
 			if (retval) {
 				com_err(program_name, retval,
 					"error reading block %d", blk);
 			}
 			if (scramble_block_map && 
-			    ext2fs_test_block_bitmap(scramble_block_map, blk))
+			    ext2fs_test_block_bitmap_64(scramble_block_map, blk))
 				scramble_dir_block(fs, blk, buf);
 			if ((fd != 1) && check_zero_block(buf, fs->blocksize))
 				goto sparse_write;
@@ -500,7 +500,7 @@ static void write_raw_image_file(ext2_fi
 		if (!inode.i_links_count)
 			continue;
 		if (inode.i_file_acl) {
-			ext2fs_mark_block_bitmap(meta_block_map,
+			ext2fs_mark_block_bitmap_64(meta_block_map,
 						 inode.i_file_acl);
 		}
 		if (!ext2fs_inode_has_valid_blocks(&inode))
diff -upNr e2fsprogs-1.39/misc/mke2fs.c e2fsprogs-1.39.tmp/misc/mke2fs.c
--- e2fsprogs-1.39/misc/mke2fs.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/mke2fs.c	2006-04-21 11:51:17.000000000 +0900
@@ -277,7 +277,7 @@ _("Warning: the backup superblock/group 
 		exit(1);
 	}
 	while (ext2fs_badblocks_list_iterate(bb_iter, &blk)) 
-		ext2fs_mark_block_bitmap(fs->block_map, blk);
+		ext2fs_mark_block_bitmap_64(fs->block_map, blk);
 	ext2fs_badblocks_list_iterate_end(bb_iter);
 }
 
diff -upNr e2fsprogs-1.39/misc/tune2fs.c e2fsprogs-1.39.tmp/misc/tune2fs.c
--- e2fsprogs-1.39/misc/tune2fs.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/tune2fs.c	2006-04-21 11:51:17.000000000 +0900
@@ -210,7 +210,7 @@ static int release_blocks_proc(ext2_fils
 	int	group;
 
 	block = *blocknr;
-	ext2fs_unmark_block_bitmap(fs->block_map,block);
+	ext2fs_unmark_block_bitmap_64(fs->block_map,block);
 	group = ext2fs_group_of_blk(fs, block);
 	fs->group_desc[group].bg_free_blocks_count++;
 	fs->super->s_free_blocks_count++;
diff -upNr e2fsprogs-1.39/resize/resize2fs.c e2fsprogs-1.39.tmp/resize/resize2fs.c
--- e2fsprogs-1.39/resize/resize2fs.c	2006-04-21 11:51:04.000000000 +0900
+++ e2fsprogs-1.39.tmp/resize/resize2fs.c	2006-04-21 11:51:17.000000000 +0900
@@ -268,7 +268,7 @@ retry:
 	real_end = ((EXT2_BLOCKS_PER_GROUP(fs->super)
 		     * (__u64)fs->group_desc_count)) - 1 +
 			     fs->super->s_first_data_block;
-	retval = ext2fs_resize_block_bitmap(fs->super->s_blocks_count-1,
+	retval = ext2fs_resize_block_bitmap_64(fs->super->s_blocks_count-1,
 					    real_end, fs->block_map);
 
 	if (retval) goto errout;
@@ -381,7 +381,7 @@ retry:
 
 		has_super = ext2fs_bg_has_super(fs, i);
 		if (has_super) {
-			ext2fs_mark_block_bitmap(fs->block_map, group_block);
+			ext2fs_mark_block_bitmap_64(fs->block_map, group_block);
 			adjblocks++;
 		}
 		meta_bg_size = (fs->blocksize /
@@ -392,7 +392,7 @@ retry:
 		    (meta_bg < fs->super->s_first_meta_bg)) {
 			if (has_super) {
 				for (j=0; j < old_desc_blocks; j++)
-					ext2fs_mark_block_bitmap(fs->block_map,
+					ext2fs_mark_block_bitmap_64(fs->block_map,
 							 group_block + 1 + j);
 				adjblocks += old_desc_blocks;
 			}
@@ -402,7 +402,7 @@ retry:
 			if (((i % meta_bg_size) == 0) ||
 			    ((i % meta_bg_size) == 1) ||
 			    ((i % meta_bg_size) == (meta_bg_size-1)))
-				ext2fs_mark_block_bitmap(fs->block_map,
+				ext2fs_mark_block_bitmap_64(fs->block_map,
 						 group_block + has_super);
 		}
 		
@@ -567,18 +567,18 @@ static errcode_t mark_table_blocks(ext2_
 		for (j = 0, b = fs->group_desc[i].bg_inode_table;
 		     j < (unsigned int) fs->inode_blocks_per_group;
 		     j++, b++)
-			ext2fs_mark_block_bitmap(bmap, b);
+			ext2fs_mark_block_bitmap_64(bmap, b);
 			    
 		/*
 		 * Mark block used for the block bitmap 
 		 */
-		ext2fs_mark_block_bitmap(bmap,
+		ext2fs_mark_block_bitmap_64(bmap,
 					 fs->group_desc[i].bg_block_bitmap);
 
 		/*
 		 * Mark block used for the inode bitmap 
 		 */
-		ext2fs_mark_block_bitmap(bmap,
+		ext2fs_mark_block_bitmap_64(bmap,
 					 fs->group_desc[i].bg_inode_bitmap);
 		block += fs->super->s_blocks_per_group;
 	}
@@ -596,8 +596,8 @@ static void mark_fs_metablock(ext2_resiz
 {
 	ext2_filsys 	fs = rfs->new_fs;
 	
-	ext2fs_mark_block_bitmap(rfs->reserve_blocks, blk);
-	ext2fs_mark_block_bitmap(fs->block_map, blk);
+	ext2fs_mark_block_bitmap_64(rfs->reserve_blocks, blk);
+	ext2fs_mark_block_bitmap_64(fs->block_map, blk);
 
 	/*
 	 * Check to see if we overlap with the inode or block bitmap,
@@ -613,9 +613,9 @@ static void mark_fs_metablock(ext2_resiz
 	} else if (IS_INODE_TB(fs, group, blk)) {
 		FS_INODE_TB(fs, group) = 0;
 		rfs->needed_blocks++;
-	} else if (ext2fs_test_block_bitmap(rfs->old_fs->block_map, blk) &&
-		   !ext2fs_test_block_bitmap(meta_bmap, blk)) {
-		ext2fs_mark_block_bitmap(rfs->move_blocks, blk);
+	} else if (ext2fs_test_block_bitmap_64(rfs->old_fs->block_map, blk) &&
+		   !ext2fs_test_block_bitmap_64(meta_bmap, blk)) {
+		ext2fs_mark_block_bitmap_64(rfs->move_blocks, blk);
 		rfs->needed_blocks++;
 	}
 }
@@ -669,12 +669,12 @@ static errcode_t blocks_to_move(ext2_res
 	 */
 	for (blk = fs->super->s_blocks_count;
 	     blk < old_fs->super->s_blocks_count; blk++) {
-		if (ext2fs_test_block_bitmap(old_fs->block_map, blk) &&
-		    !ext2fs_test_block_bitmap(meta_bmap, blk)) {
-			ext2fs_mark_block_bitmap(rfs->move_blocks, blk);
+		if (ext2fs_test_block_bitmap_64(old_fs->block_map, blk) &&
+		    !ext2fs_test_block_bitmap_64(meta_bmap, blk)) {
+			ext2fs_mark_block_bitmap_64(rfs->move_blocks, blk);
 			rfs->needed_blocks++;
 		}
-		ext2fs_mark_block_bitmap(rfs->reserve_blocks, blk);
+		ext2fs_mark_block_bitmap_64(rfs->reserve_blocks, blk);
 	}
 	
 	if (fs->super->s_feature_incompat & EXT2_FEATURE_INCOMPAT_META_BG) {
@@ -707,7 +707,7 @@ static errcode_t blocks_to_move(ext2_res
 			}
 			for (blk = group_blk+1+new_blocks;
 			     blk < group_blk+1+old_blocks; blk++) {
-				ext2fs_unmark_block_bitmap(fs->block_map,
+				ext2fs_unmark_block_bitmap_64(fs->block_map,
 							   blk);
 				rfs->needed_blocks--;
 			}
@@ -756,15 +756,15 @@ static errcode_t blocks_to_move(ext2_res
 		 * aren't to be moved.
 		 */
 		if (fs->group_desc[i].bg_block_bitmap)
-			ext2fs_mark_block_bitmap(rfs->reserve_blocks,
+			ext2fs_mark_block_bitmap_64(rfs->reserve_blocks,
 				 fs->group_desc[i].bg_block_bitmap);
 		if (fs->group_desc[i].bg_inode_bitmap)
-			ext2fs_mark_block_bitmap(rfs->reserve_blocks,
+			ext2fs_mark_block_bitmap_64(rfs->reserve_blocks,
 				 fs->group_desc[i].bg_inode_bitmap);
 		if (fs->group_desc[i].bg_inode_table)
 			for (blk = fs->group_desc[i].bg_inode_table, j=0;
 			     j < fs->inode_blocks_per_group ; j++, blk++)
-				ext2fs_mark_block_bitmap(rfs->reserve_blocks,
+				ext2fs_mark_block_bitmap_64(rfs->reserve_blocks,
 							 blk);
 
 		/*
@@ -781,18 +781,18 @@ static errcode_t blocks_to_move(ext2_res
 		 */
 		if (FS_BLOCK_BM(old_fs, i) !=
 		    (blk = FS_BLOCK_BM(fs, i))) {
-			ext2fs_mark_block_bitmap(fs->block_map, blk);
-			if (ext2fs_test_block_bitmap(old_fs->block_map, blk) &&
-			    !ext2fs_test_block_bitmap(meta_bmap, blk))
-				ext2fs_mark_block_bitmap(rfs->move_blocks,
+			ext2fs_mark_block_bitmap_64(fs->block_map, blk);
+			if (ext2fs_test_block_bitmap_64(old_fs->block_map, blk) &&
+			    !ext2fs_test_block_bitmap_64(meta_bmap, blk))
+				ext2fs_mark_block_bitmap_64(rfs->move_blocks,
 							 blk);
 		}
 		if (FS_INODE_BM(old_fs, i) !=
 		    (blk = FS_INODE_BM(fs, i))) {
-			ext2fs_mark_block_bitmap(fs->block_map, blk);
-			if (ext2fs_test_block_bitmap(old_fs->block_map, blk) &&
-			    !ext2fs_test_block_bitmap(meta_bmap, blk))
-				ext2fs_mark_block_bitmap(rfs->move_blocks,
+			ext2fs_mark_block_bitmap_64(fs->block_map, blk);
+			if (ext2fs_test_block_bitmap_64(old_fs->block_map, blk) &&
+			    !ext2fs_test_block_bitmap_64(meta_bmap, blk))
+				ext2fs_mark_block_bitmap_64(rfs->move_blocks,
 							 blk);
 		}
 
@@ -815,10 +815,10 @@ static errcode_t blocks_to_move(ext2_res
 		 */
 		for (blk = fs->group_desc[i].bg_inode_table, j=0;
 		     j < fs->inode_blocks_per_group ; j++, blk++) {
-			ext2fs_mark_block_bitmap(fs->block_map, blk);
-			if (ext2fs_test_block_bitmap(old_fs->block_map, blk) &&
-			    !ext2fs_test_block_bitmap(meta_bmap, blk))
-				ext2fs_mark_block_bitmap(rfs->move_blocks,
+			ext2fs_mark_block_bitmap_64(fs->block_map, blk);
+			if (ext2fs_test_block_bitmap_64(old_fs->block_map, blk) &&
+			    !ext2fs_test_block_bitmap_64(meta_bmap, blk))
+				ext2fs_mark_block_bitmap_64(rfs->move_blocks,
 							 blk);
 		}
 		
@@ -828,7 +828,7 @@ static errcode_t blocks_to_move(ext2_res
 		 */
 		for (blk = rfs->old_fs->group_desc[i].bg_inode_table, j=0;
 		     j < fs->inode_blocks_per_group ; j++, blk++)
-			ext2fs_mark_block_bitmap(rfs->reserve_blocks, blk);
+			ext2fs_mark_block_bitmap_64(rfs->reserve_blocks, blk);
 		
 	next_group:
 		group_blk += rfs->new_fs->super->s_blocks_per_group;
@@ -889,12 +889,12 @@ static blk_t get_new_block(ext2_resize_t
 			rfs->new_blk = fs->super->s_first_data_block;
 			continue;
 		}
-		if (ext2fs_test_block_bitmap(fs->block_map, rfs->new_blk) ||
-		    ext2fs_test_block_bitmap(rfs->reserve_blocks,
+		if (ext2fs_test_block_bitmap_64(fs->block_map, rfs->new_blk) ||
+		    ext2fs_test_block_bitmap_64(rfs->reserve_blocks,
 					     rfs->new_blk) ||
 		    ((rfs->alloc_state == AVOID_OLD) &&
 		     (rfs->new_blk < rfs->old_fs->super->s_blocks_count) &&
-		     ext2fs_test_block_bitmap(rfs->old_fs->block_map,
+		     ext2fs_test_block_bitmap_64(rfs->old_fs->block_map,
 					      rfs->new_blk))) {
 			rfs->new_blk++;
 			continue;
@@ -938,9 +938,9 @@ static errcode_t block_mover(ext2_resize
 	init_block_alloc(rfs);
 	for (blk = old_fs->super->s_first_data_block;
 	     blk < old_fs->super->s_blocks_count; blk++) {
-		if (!ext2fs_test_block_bitmap(old_fs->block_map, blk))
+		if (!ext2fs_test_block_bitmap_64(old_fs->block_map, blk))
 			continue;
-		if (!ext2fs_test_block_bitmap(rfs->move_blocks, blk))
+		if (!ext2fs_test_block_bitmap_64(rfs->move_blocks, blk))
 			continue;
 		if (ext2fs_badblocks_list_test(badblock_list, blk)) {
 			ext2fs_badblocks_list_del(badblock_list, blk);
@@ -953,7 +953,7 @@ static errcode_t block_mover(ext2_resize
 			retval = ENOSPC;
 			goto errout;
 		}
-		ext2fs_mark_block_bitmap(fs->block_map, new_blk);
+		ext2fs_mark_block_bitmap_64(fs->block_map, new_blk);
 		ext2fs_add_extent_entry(rfs->bmap, blk, new_blk);
 		to_move++;
 	}
@@ -1476,7 +1476,7 @@ static errcode_t move_itables(ext2_resiz
 
 		for (blk = rfs->old_fs->group_desc[i].bg_inode_table, j=0;
 		     j < fs->inode_blocks_per_group ; j++, blk++)
-			ext2fs_unmark_block_bitmap(fs->block_map, blk);
+			ext2fs_unmark_block_bitmap_64(fs->block_map, blk);
 
 		rfs->old_fs->group_desc[i].bg_inode_table = new_blk;
 		ext2fs_mark_super_dirty(rfs->old_fs);
@@ -1569,7 +1569,7 @@ static errcode_t ext2fs_calculate_summar
 	 */
 	for (blk = fs->super->s_first_data_block;
 	     blk < fs->super->s_blocks_count; blk++) {
-		if (!ext2fs_fast_test_block_bitmap(fs->block_map, blk)) {
+		if (!ext2fs_fast_test_block_bitmap_64(fs->block_map, blk)) {
 			group_free++;
 			total_free++;
 		}
