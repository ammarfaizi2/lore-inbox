Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWEYM5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWEYM5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWEYM5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:57:41 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:37846 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965157AbWEYM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:57:40 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][21/24]ext2resize fix how to calculate an offset
Message-Id: <20060525215732sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:57:31 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [21/24] fix the bug that an offset of an inode table is erroneously
          calculated
          - Running ext2resize results in failure due to an erroneous
            offset of an inode table, then I fix how to calculate it.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -Nurp ext2resize-1.1.19/src/ext2_block_relocator.c ../a/ext2resize-1.1.19/src/ext2_block_relocator.c
--- ext2resize-1.1.19/src/ext2_block_relocator.c	2004-09-30 22:05:55.000000000 +0800
+++ ../a/ext2resize-1.1.19/src/ext2_block_relocator.c	2006-03-24 12:07:41.000000000 +0800
@@ -496,6 +496,10 @@ static int ext2_block_relocator_grab_blo
 			int raid_bb, raid_ib;
 			int itend = state->newallocoffset;
 
+			if (!ext2_bg_has_super(fs, group))
+				itend = fs->gd[group].bg_inode_table
+					 +fs->inodeblocks - start;
+
 			bpg = fs->sb.s_blocks_per_group;
 			if (start + bpg > fs->newblocks)
 				bpg = fs->newblocks - start;
diff -Nurp ext2resize-1.1.19/src/ext2.h ../a/ext2resize-1.1.19/src/ext2.h
--- ext2resize-1.1.19/src/ext2.h	2006-03-24 12:09:37.000000000 +0800
+++ ../a/ext2resize-1.1.19/src/ext2.h	2006-03-24 12:05:00.000000000 +0800
@@ -262,7 +262,7 @@ static int __inline__ ext2_is_data_block
 	group = blk / fs->sb.s_blocks_per_group;
 	blk %= fs->sb.s_blocks_per_group;
 
-	if (ext2_bg_has_super(fs, group) && blk <= fs->gdblocks)
+	if (ext2_bg_has_super(fs, group) && blk <= fs->gdblocks + fs->resgdblocks)
 		return 0;
 
 	if (block == fs->gd[group].bg_block_bitmap ||
diff -Nurp ext2resize-1.1.19/src/ext2_meta.c ../a/ext2resize-1.1.19/src/ext2_meta.c
--- ext2resize-1.1.19/src/ext2_meta.c	2004-09-30 22:01:41.000000000 +0800
+++ ../a/ext2resize-1.1.19/src/ext2_meta.c	2006-03-24 12:05:00.000000000 +0800
@@ -109,6 +109,12 @@ int ext2_metadata_push(struct ext2_fs *f
 		int has_sb;
 		int diff;
 
+		has_sb = ext2_bg_has_super(fs, group);
+		if(!has_sb)
+			new_itoffset = 2;
+		else
+			new_itoffset = fs->newgdblocks +3;
+
 		diff = start + new_itoffset - fs->gd[group].bg_inode_table;
 		old_itend =fs->gd[group].bg_inode_table +fs->inodeblocks -start;
 		new_itend = new_itoffset + fs->inodeblocks;
@@ -116,8 +122,6 @@ int ext2_metadata_push(struct ext2_fs *f
 		if (start + bpg > fs->sb.s_blocks_count)
 			bpg = fs->sb.s_blocks_count - start;
 
-		has_sb = ext2_bg_has_super(fs, group);
-
 		bb = fs->gd[group].bg_block_bitmap - start;
 		ib = fs->gd[group].bg_inode_bitmap - start;
 		if (fs->stride) {
@@ -187,7 +191,7 @@ int ext2_metadata_push(struct ext2_fs *f
 			       group + 1, fs->numgroups);
 	}
 
-	fs->itoffset = new_itoffset;
+	fs->itoffset = fs->newgdblocks + 3;
 
 	if (fs->flags & FL_VERBOSE)
 		printf("\n");
diff -Nurp ext2resize-1.1.19/src/ext2_resize.c ../a/ext2resize-1.1.19/src/ext2_resize.c
--- ext2resize-1.1.19/src/ext2_resize.c	2006-03-24 12:09:37.000000000 +0800
+++ ../a/ext2resize-1.1.19/src/ext2_resize.c	2006-03-24 12:05:00.000000000 +0800
@@ -157,7 +157,7 @@ static int ext2_add_group(struct ext2_fs
 	return 1;
 }
 
-static int ext2_del_group(struct ext2_fs *fs)
+static int ext2_del_group(struct ext2_fs *fs, int old_gdblocks)
 {
 	blk_t admin;
 	int   group = fs->numgroups - 1;
@@ -170,7 +170,7 @@ static int ext2_del_group(struct ext2_fs
 
 	has_sb = ext2_bg_has_super(fs, group);
 
-	admin = fs->inodeblocks + (has_sb ? fs->gdblocks + 3 : 2);
+	admin = fs->inodeblocks + (has_sb ? old_gdblocks + 3 : 2);
 
 	bpg = fs->sb.s_blocks_count - fs->sb.s_first_data_block -
 		group * fs->sb.s_blocks_per_group;
@@ -407,6 +407,8 @@ static int ext2_grow_fs(struct ext2_fs *
 
 static int ext2_shrink_fs(struct ext2_fs *fs)
 {
+	int old_gdblocks;
+
 	if (fs->flags & FL_DEBUG)
 		printf("%s\n", __FUNCTION__);
 
@@ -435,6 +437,8 @@ static int ext2_shrink_fs(struct ext2_fs
 	if (!ext2_block_relocate(fs))
 		return 0;
 
+	old_gdblocks = fs->gdblocks;
+
 	while (fs->sb.s_blocks_count > fs->newblocks) {
 		blk_t sizelast = (fs->sb.s_blocks_count -
 				  fs->sb.s_first_data_block) -
@@ -445,7 +449,7 @@ static int ext2_shrink_fs(struct ext2_fs
 					       fs->sb.s_blocks_count))
 				return 0;
 		} else {
-			if (!ext2_del_group(fs))
+			if (!ext2_del_group(fs, old_gdblocks))
 				return 0;
 		}
 	}


