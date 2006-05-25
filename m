Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWEYNAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWEYNAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWEYNAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:00:00 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:53976 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965160AbWEYM77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:59:59 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][23/24]ext2resize modify variables to exceed 2G
Message-Id: <20060525215951sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:59:49 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [23/24] change the type of variables manipulating a block or an inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr ext2resize-1.1.19/src/ext2.c ext2resize-1.1.19.tmp/src/ext2.c
--- ext2resize-1.1.19/src/ext2.c	2006-05-12 10:13:51.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2.c	2006-05-12 10:14:21.000000000 +0900
@@ -81,10 +81,13 @@ blk_t ext2_find_free_block(struct ext2_f
 
 			offset = i * fs->sb.s_blocks_per_group + fs->sb.s_first_data_block;
 			for (j = fs->itoffset + fs->inodeblocks;
-			     j < fs->sb.s_blocks_per_group; j++)
+			     j < fs->sb.s_blocks_per_group; j++) {
+				if(offset + j >= fs->sb.s_blocks_count)
+					break;
 				if (ext2_is_data_block(fs, offset + j) &&
 				    !ext2_get_block_state(fs, offset + j))
 					return offset + j;
+			}
 
 			fprintf(stderr, "inconsistent group descriptors!\n");
 		}
@@ -541,7 +544,7 @@ void ext2_commit_metadata(struct ext2_fs
 	unsigned char	 sbb[fs->blocksize]; /* backup(s) */
 	__u16		*block_group_p;
 	__u16		*block_group_b;
-	int		 sb_block;
+	blk_t		 sb_block;
 
 	/* See if there is even anything to write... */
 	if (wmeta == EXT2_META_CLEAN)
@@ -615,7 +618,7 @@ static int ext2_determine_itoffset(struc
 {
 	int	group;
 	int	bpg = fs->sb.s_blocks_per_group;
-	blk_t	start, itend;
+	blk64_t	start, itend;
 
 	if (fs->flags & FL_DEBUG)
 		printf("%s\n", __FUNCTION__);
@@ -669,7 +672,7 @@ static int ext2_determine_itoffset(struc
 	for (group = 0, start = fs->sb.s_first_data_block;
 	     group < fs->numgroups;
 	     group++, start += fs->sb.s_blocks_per_group) {
-		blk_t bb;
+		blk64_t bb;
 		blk_t ib;
 		blk_t it;
 		int has_sb;
@@ -680,7 +683,7 @@ static int ext2_determine_itoffset(struc
 		has_sb = ext2_bg_has_super(fs, group);
 
 		if (fs->stride) {
-			blk_t bmap = start + itend +
+			blk64_t bmap = start + itend +
 				(fs->stride * group % (bpg - itend));
 			bb = bmap >= start + bpg ? itend : bmap;
 		} else
@@ -920,7 +923,7 @@ struct ext2_fs *ext2_open(struct ext2_de
 	if (fs->flags & FL_VERBOSE)
 		printf("new filesystem size %d\n", newblocks);
 
-	fs->numgroups = howmany(fs->sb.s_blocks_count -
+	fs->numgroups = howmany((blk64_t)fs->sb.s_blocks_count -
 				fs->sb.s_first_data_block,
 				fs->sb.s_blocks_per_group);
 	fs->gdblocks = howmany(fs->numgroups * sizeof(struct ext2_group_desc),
@@ -955,9 +958,20 @@ struct ext2_fs *ext2_open(struct ext2_de
 	}
 
 	fs->newblocks = newblocks;
-	fs->newgroups = howmany(newblocks - fs->sb.s_first_data_block,
+	fs->newgroups = howmany((blk64_t)newblocks - fs->sb.s_first_data_block,
 				fs->sb.s_blocks_per_group);
 
+	if ( fs->sb.s_blocks_count < newblocks){
+		/* actually we can't process fs over 4G-1 amount of inodes */
+		unsigned long long newinodes;
+ 
+		newinodes = (unsigned long long)fs->newgroups * fs->sb.s_inodes_per_group;
+		if ( newinodes > ~0U ){
+			fprintf(stderr, "inodes_count must be less than 4G!\n");
+			goto error_free_bcache;
+		}
+	}
+
 	/* round up to the next block boundary, since we read full blocks */
 	maxgroups = max(fs->newgroups, fs->numgroups) +
 		fs->blocksize / sizeof(struct ext2_group_desc);
diff -upNr ext2resize-1.1.19/src/ext2_block_relocator.c ext2resize-1.1.19.tmp/src/ext2_block_relocator.c
--- ext2resize-1.1.19/src/ext2_block_relocator.c	2006-05-11 17:24:29.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_block_relocator.c	2006-05-12 10:14:21.000000000 +0900
@@ -307,7 +307,7 @@ static int inode_block_scan(struct ext2_
 	for (i = 0; i < fs->numgroups; i++) {
 		struct ext2_buffer_head *bh;
 		int			 j;
-		int			 offset;
+		ino_t			 offset;
 
 		if (fs->flags & FL_VERBOSE) {
 			printf(" scanning group %i... ", i);
@@ -501,7 +501,7 @@ static int ext2_block_relocator_grab_blo
 					 +fs->inodeblocks - start;
 
 			bpg = fs->sb.s_blocks_per_group;
-			if (start + bpg > fs->newblocks)
+			if ((blk64_t)start + bpg > fs->newblocks)
 				bpg = fs->newblocks - start;
 
 			raid_bb = itend + (fs->stride * group % (bpg - itend));
@@ -798,7 +798,7 @@ static int ext2_block_relocate_shrink(st
 	struct ext2_inode tmp;
 	struct ext2_inode *inode = &tmp;
 	int group;
-	blk_t start;
+	blk64_t start;
 
 	if (fs->flags & FL_DEBUG)
 		printf("%s\n", __FUNCTION__);
diff -upNr ext2resize-1.1.19/src/ext2_inode_relocator.c ext2resize-1.1.19.tmp/src/ext2_inode_relocator.c
--- ext2resize-1.1.19/src/ext2_inode_relocator.c	2004-09-30 23:01:41.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_inode_relocator.c	2006-05-12 10:14:21.000000000 +0900
@@ -244,7 +244,7 @@ static int doscangroup(struct ext2_fs *f
 {
 	struct ext2_buffer_head *bh;
 	int			 i;
-	int			 offset;
+	ino_t			 offset;
 
 	if (fs->flags & FL_VERBOSE)
 		printf(" scanning group %i.... ", group);
@@ -417,7 +417,7 @@ static int ext2_inode_relocator_grab_ino
 		if (fs->gd[i].bg_free_inodes_count) {
 			struct ext2_buffer_head *bh;
 			int j;
-			int offset;
+			ino_t offset;
 
 			bh = ext2_bread(fs, fs->gd[i].bg_inode_bitmap);
 			offset = i * fs->sb.s_inodes_per_group + 1;
@@ -521,7 +521,7 @@ int ext2_inode_relocate(struct ext2_fs *
 	for (i = fs->newgroups; i < fs->numgroups; i++) {
 		struct ext2_buffer_head *bh;
 		int			 j;
-		int			 offset;
+		ino_t			 offset;
 
 		bh = ext2_bread(fs, fs->gd[i].bg_inode_bitmap);
 		offset = i * fs->sb.s_inodes_per_group + 1;
diff -upNr ext2resize-1.1.19/src/ext2_resize.c ext2resize-1.1.19.tmp/src/ext2_resize.c
--- ext2resize-1.1.19/src/ext2_resize.c	2006-05-11 17:24:29.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2_resize.c	2006-05-12 10:14:21.000000000 +0900
@@ -445,7 +445,7 @@ static int ext2_shrink_fs(struct ext2_fs
 				 (fs->numgroups - 1) *fs->sb.s_blocks_per_group;
 
 		if (fs->sb.s_blocks_count - sizelast < fs->newblocks) {
-			if (!ext2_shrink_group(fs, sizelast + fs->newblocks -
+			if (!ext2_shrink_group(fs, (blk64_t)sizelast + fs->newblocks -
 					       fs->sb.s_blocks_count))
 				return 0;
 		} else {
diff -upNr ext2resize-1.1.19/src/ext2online.c ext2resize-1.1.19.tmp/src/ext2online.c
--- ext2resize-1.1.19/src/ext2online.c	2006-05-12 10:13:51.000000000 +0900
+++ ext2resize-1.1.19.tmp/src/ext2online.c	2006-05-12 10:14:21.000000000 +0900
@@ -493,7 +493,7 @@ static blk_t ext2_online_primary(struct 
 		return 0;
 
 	/* Fill last existing group */
-	size = min(fs->numgroups * fs->sb.s_blocks_per_group +
+	size = min((blk64_t)fs->numgroups * fs->sb.s_blocks_per_group +
 			fs->sb.s_first_data_block, fs->newblocks);
 
 	if (size > fs->sb.s_blocks_count && fs->flags & FL_DEBUG)


