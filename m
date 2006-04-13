Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWDMHNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWDMHNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWDMHNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:13:08 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:16773 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964817AbWDMHNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:13:06 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Message-Id: <20060413161227sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:12:27 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [15/21] change the type of variables which manipulate bitmap
          - Change the type of 4byte variables manipulating bitmap
            from signed to unsigned.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39/e2fsck/pass5.c e2fsprogs-1.39.tmp/e2fsck/pass5.c
--- e2fsprogs-1.39/e2fsck/pass5.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass5.c	2006-04-12 13:27:56.000000000 +0900
@@ -502,13 +502,13 @@ static void check_inode_end(e2fsck_t ctx
 static void check_block_end(e2fsck_t ctx)
 {
 	ext2_filsys fs = ctx->fs;
-	blk_t	end, save_blocks_count, i;
+	blk64_t	end, save_blocks_count, i;
 	struct problem_context	pctx;
 
 	clear_problem_context(&pctx);
 
 	end = fs->block_map->start +
-		(EXT2_BLOCKS_PER_GROUP(fs->super) * fs->group_desc_count) - 1;
+		(EXT2_BLOCKS_PER_GROUP(fs->super) * (__u64)fs->group_desc_count) - 1;
 	pctx.errcode = ext2fs_fudge_block_bitmap_end(fs->block_map, end,
 						     &save_blocks_count);
 	if (pctx.errcode) {
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitmaps.c e2fsprogs-1.39.tmp/lib/ext2fs/bitmaps.c
--- e2fsprogs-1.39/lib/ext2fs/bitmaps.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitmaps.c	2006-04-12 13:27:56.000000000 +0900
@@ -27,7 +27,7 @@
 #include "ext2_fs.h"
 #include "ext2fs.h"
 
-static errcode_t make_bitmap(__u32 start, __u32 end, __u32 real_end,
+static errcode_t make_bitmap(__u32 start, __u32 end, __u64 real_end,
 			     const char *descr, char *init_map,
 			     ext2fs_generic_bitmap *ret)
 {
@@ -74,7 +74,7 @@ static errcode_t make_bitmap(__u32 start
 
 errcode_t ext2fs_allocate_generic_bitmap(__u32 start,
 					 __u32 end,
-					 __u32 real_end,
+					 __u64 real_end,
 					 const char *descr,
 					 ext2fs_generic_bitmap *ret)
 {
@@ -143,7 +143,8 @@ errcode_t ext2fs_allocate_block_bitmap(e
 {
 	ext2fs_block_bitmap bitmap;
 	errcode_t	retval;
-	__u32		start, end, real_end;
+	__u32           start, end;
+	__u64           real_end;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -151,7 +152,7 @@ errcode_t ext2fs_allocate_block_bitmap(e
 
 	start = fs->super->s_first_data_block;
 	end = fs->super->s_blocks_count-1;
-	real_end = (EXT2_BLOCKS_PER_GROUP(fs->super)  
+	real_end = ((__u64)EXT2_BLOCKS_PER_GROUP(fs->super)  
 		    * fs->group_desc_count)-1 + start;
 	
 	retval = ext2fs_allocate_generic_bitmap(start, end, real_end,
@@ -181,7 +182,7 @@ errcode_t ext2fs_fudge_inode_bitmap_end(
 }
 
 errcode_t ext2fs_fudge_block_bitmap_end(ext2fs_block_bitmap bitmap,
-					blk_t end, blk_t *oend)
+					blk64_t end, blk64_t *oend)
 {
 	EXT2_CHECK_MAGIC(bitmap, EXT2_ET_MAGIC_BLOCK_BITMAP);
 	
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.c e2fsprogs-1.39.tmp/lib/ext2fs/bitops.c
--- e2fsprogs-1.39/lib/ext2fs/bitops.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.c	2006-04-12 13:27:56.000000000 +0900
@@ -66,26 +66,26 @@ int ext2fs_test_bit(unsigned int nr, con
 
 #endif	/* !_EXT2_HAVE_ASM_BITOPS_ */
 
-void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
+void ext2fs_warn_bitmap(errcode_t errcode, unsigned long long arg,
 			const char *description)
 {
 #ifndef OMIT_COM_ERR
 	if (description)
-		com_err(0, errcode, "#%lu for %s", arg, description);
+		com_err(0, errcode, "#%llu for %s", arg, description);
 	else
-		com_err(0, errcode, "#%lu", arg);
+		com_err(0, errcode, "#%llu", arg);
 #endif
 }
 
 void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
-			    int code, unsigned long arg)
+			    int code, unsigned long long arg)
 {
 #ifndef OMIT_COM_ERR
 	if (bitmap->description)
 		com_err(0, bitmap->base_error_code+code,
-			"#%lu for %s", arg, bitmap->description);
+			"#%llu for %s", arg, bitmap->description);
 	else
-		com_err(0, bitmap->base_error_code + code, "#%lu", arg);
+		com_err(0, bitmap->base_error_code + code, "#%llu", arg);
 #endif
 }
 
diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.h e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h
--- e2fsprogs-1.39/lib/ext2fs/bitops.h	2006-03-30 02:51:53.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h	2006-04-12 13:28:14.000000000 +0900
@@ -52,15 +52,15 @@ extern const char *ext2fs_inode_string;
 extern const char *ext2fs_mark_string;
 extern const char *ext2fs_unmark_string;
 extern const char *ext2fs_test_string;
-extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
+extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long long arg,
 			       const char *description);
 extern void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
-				int code, unsigned long arg);
+				int code, unsigned long long arg);
 
-extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
+extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk64_t block);
 extern int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block);
-extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
+					blk64_t block);
+extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk64_t block);
 
 extern int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap, ext2_ino_t inode);
 extern int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -68,11 +68,11 @@ extern int ext2fs_unmark_inode_bitmap(ex
 extern int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap, ext2_ino_t inode);
 
 extern void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-					  blk_t block);
+					  blk64_t block);
 extern void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block);
+					    blk64_t block);
 extern int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
-					 blk_t block);
+					 blk64_t block);
 
 extern void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 					  ext2_ino_t inode);
@@ -86,24 +86,24 @@ extern blk_t ext2fs_get_block_bitmap_end
 extern ext2_ino_t ext2fs_get_inode_bitmap_end(ext2fs_inode_bitmap bitmap);
 
 extern void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					   blk_t block, int num);
+					   blk64_t block, int num);
 extern void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					     blk_t block, int num);
+					     blk64_t block, int num);
 extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					  blk_t block, int num);
+					  blk64_t block, int num);
 extern void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						blk_t block, int num);
+						blk64_t block, int num);
 extern void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						  blk_t block, int num);
+						  blk64_t block, int num);
 extern int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					       blk_t block, int num);
+					       blk64_t block, int num);
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 
 /* These two routines moved to gen_bitmap.c */
 extern int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					 __u32 bitno);
+					 __u64 bitno);
 extern int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					   blk_t bitno);
+					   blk64_t bitno);
 /*
  * The inline routines themselves...
  * 
@@ -391,10 +391,10 @@ _INLINE_ int ext2fs_find_next_bit_set (v
 #endif	
 
 _INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					blk_t bitno);
+					blk64_t bitno);
 
 _INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					blk_t bitno)
+					blk64_t bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_TEST_ERROR, bitno);
@@ -404,7 +404,7 @@ _INLINE_ int ext2fs_test_generic_bitmap(
 }
 
 _INLINE_ int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block)
+				       blk64_t block)
 {
 	return ext2fs_mark_generic_bitmap((ext2fs_generic_bitmap)
 				       bitmap,
@@ -412,14 +412,14 @@ _INLINE_ int ext2fs_mark_block_bitmap(ex
 }
 
 _INLINE_ int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					 blk_t block)
+					 blk64_t block)
 {
 	return ext2fs_unmark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					    block);
 }
 
 _INLINE_ int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block)
+				       blk64_t block)
 {
 	return ext2fs_test_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					  block);
@@ -447,7 +447,7 @@ _INLINE_ int ext2fs_test_inode_bitmap(ex
 }
 
 _INLINE_ void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block)
+					    blk64_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -460,7 +460,7 @@ _INLINE_ void ext2fs_fast_mark_block_bit
 }
 
 _INLINE_ void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					      blk_t block)
+					      blk64_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -473,7 +473,7 @@ _INLINE_ void ext2fs_fast_unmark_block_b
 }
 
 _INLINE_ int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block)
+					    blk64_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -545,7 +545,7 @@ _INLINE_ ext2_ino_t ext2fs_get_inode_bit
 }
 
 _INLINE_ int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					    blk_t block, int num)
+					    blk64_t block, int num)
 {
 	int	i;
 
@@ -562,7 +562,7 @@ _INLINE_ int ext2fs_test_block_bitmap_ra
 }
 
 _INLINE_ int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						 blk_t block, int num)
+						 blk64_t block, int num)
 {
 	int	i;
 
@@ -581,7 +581,7 @@ _INLINE_ int ext2fs_fast_test_block_bitm
 }
 
 _INLINE_ void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					     blk_t block, int num)
+					     blk64_t block, int num)
 {
 	int	i;
 	
@@ -595,7 +595,7 @@ _INLINE_ void ext2fs_mark_block_bitmap_r
 }
 
 _INLINE_ void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						  blk_t block, int num)
+						  blk64_t block, int num)
 {
 	int	i;
 	
@@ -611,7 +611,7 @@ _INLINE_ void ext2fs_fast_mark_block_bit
 }
 
 _INLINE_ void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					       blk_t block, int num)
+					       blk64_t block, int num)
 {
 	int	i;
 	
@@ -626,7 +626,7 @@ _INLINE_ void ext2fs_unmark_block_bitmap
 }
 
 _INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						    blk_t block, int num)
+						    blk64_t block, int num)
 {
 	int	i;
 	
diff -upNr e2fsprogs-1.39/lib/ext2fs/ext2fs.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h
--- e2fsprogs-1.39/lib/ext2fs/ext2fs.h	2006-03-19 08:58:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h	2006-04-12 13:27:56.000000000 +0900
@@ -102,7 +102,7 @@ struct ext2fs_struct_generic_bitmap {
 	errcode_t	magic;
 	ext2_filsys 	fs;
 	__u32		start, end;
-	__u32		real_end;
+	__u64		real_end;
 	char	*	description;
 	char	*	bitmap;
 	errcode_t	base_error_code;
@@ -545,7 +545,7 @@ extern errcode_t ext2fs_read_inode_bitma
 extern errcode_t ext2fs_read_block_bitmap(ext2_filsys fs);
 extern errcode_t ext2fs_allocate_generic_bitmap(__u32 start,
 						__u32 end,
-						__u32 real_end,
+						__u64 real_end,
 						const char *descr,
 						ext2fs_generic_bitmap *ret);
 extern errcode_t ext2fs_allocate_block_bitmap(ext2_filsys fs,
@@ -557,7 +557,7 @@ extern errcode_t ext2fs_allocate_inode_b
 extern errcode_t ext2fs_fudge_inode_bitmap_end(ext2fs_inode_bitmap bitmap,
 					       ext2_ino_t end, ext2_ino_t *oend);
 extern errcode_t ext2fs_fudge_block_bitmap_end(ext2fs_block_bitmap bitmap,
-					       blk_t end, blk_t *oend);
+					       blk64_t end, blk64_t *oend);
 extern void ext2fs_clear_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern void ext2fs_clear_block_bitmap(ext2fs_block_bitmap bitmap);
 extern errcode_t ext2fs_read_bitmaps(ext2_filsys fs);
@@ -914,11 +914,11 @@ extern errcode_t ext2fs_create_resize_in
 
 /* rs_bitmap.c */
 extern errcode_t ext2fs_resize_generic_bitmap(__u32 new_end,
-					      __u32 new_real_end,
+					      __u64 new_real_end,
 					      ext2fs_generic_bitmap bmap);
 extern errcode_t ext2fs_resize_inode_bitmap(__u32 new_end, __u32 new_real_end,
 					    ext2fs_inode_bitmap bmap);
-extern errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u32 new_real_end,
+extern errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u64 new_real_end,
 					    ext2fs_block_bitmap bmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
diff -upNr e2fsprogs-1.39/lib/ext2fs/gen_bitmap.c e2fsprogs-1.39.tmp/lib/ext2fs/gen_bitmap.c
--- e2fsprogs-1.39/lib/ext2fs/gen_bitmap.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/gen_bitmap.c	2006-04-12 13:27:56.000000000 +0900
@@ -28,7 +28,7 @@
 #include "ext2fs.h"
 
 int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					 __u32 bitno)
+					 __u64 bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_MARK_ERROR, bitno);
@@ -38,7 +38,7 @@ int ext2fs_mark_generic_bitmap(ext2fs_ge
 }
 
 int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					   blk_t bitno)
+					   blk64_t bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_UNMARK_ERROR, bitno);
diff -upNr e2fsprogs-1.39/lib/ext2fs/rs_bitmap.c e2fsprogs-1.39.tmp/lib/ext2fs/rs_bitmap.c
--- e2fsprogs-1.39/lib/ext2fs/rs_bitmap.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/rs_bitmap.c	2006-04-12 13:27:56.000000000 +0900
@@ -26,7 +26,7 @@
 #include "ext2_fs.h"
 #include "ext2fs.h"
 
-errcode_t ext2fs_resize_generic_bitmap(__u32 new_end, __u32 new_real_end,
+errcode_t ext2fs_resize_generic_bitmap(__u32 new_end, __u64 new_real_end,
 				       ext2fs_generic_bitmap bmap)
 {
 	errcode_t	retval;
@@ -87,7 +87,7 @@ errcode_t ext2fs_resize_inode_bitmap(__u
 	return retval;
 }
 
-errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u32 new_real_end,
+errcode_t ext2fs_resize_block_bitmap(__u32 new_end, __u64 new_real_end,
 				     ext2fs_block_bitmap bmap)
 {
 	errcode_t	retval;
diff -upNr e2fsprogs-1.39/resize/resize2fs.c e2fsprogs-1.39.tmp/resize/resize2fs.c
--- e2fsprogs-1.39/resize/resize2fs.c	2006-04-12 13:27:51.000000000 +0900
+++ e2fsprogs-1.39.tmp/resize/resize2fs.c	2006-04-12 13:27:56.000000000 +0900
@@ -181,7 +181,7 @@ errcode_t adjust_fs_info(ext2_filsys fs,
 	int		overhead = 0;
 	int		rem;
 	blk_t		blk, group_block;
-	ext2_ino_t	real_end;
+	blk64_t		real_end;
 	int		adj, old_numblocks, numblocks, adjblocks;
 	unsigned long	i, j, old_desc_blocks, max_group;
 	unsigned int	meta_bg, meta_bg_size;
@@ -266,7 +266,7 @@ retry:
 	if (retval) goto errout;
 	
 	real_end = ((EXT2_BLOCKS_PER_GROUP(fs->super)
-		     * fs->group_desc_count)) - 1 +
+		     * (__u64)fs->group_desc_count)) - 1 +
 			     fs->super->s_first_data_block;
 	retval = ext2fs_resize_block_bitmap(fs->super->s_blocks_count-1,
 					    real_end, fs->block_map);

