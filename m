Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSKGDzb>; Wed, 6 Nov 2002 22:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbSKGDx6>; Wed, 6 Nov 2002 22:53:58 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:44929 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266323AbSKGDwk>;
	Wed, 6 Nov 2002 22:52:40 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 6/6: ext3 inode accounting fix
From: tytso@mit.edu
Message-Id: <E189dp8-0007Gg-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:59:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix and simplify port of Orlov allocator to ext3.

My ext3 port of the Orlov allocator was buggy; the block group 
descriptor counts for free inodes and directories were getting 
doubly decremented / incremented.  This patch fixes this, as well
as simplifying the code.

ialloc.c |   51 +++++++++++----------------------------------------
1 files changed, 11 insertions(+), 40 deletions(-)

diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Wed Nov  6 22:27:06 2002
+++ b/fs/ext3/ialloc.c	Wed Nov  6 22:27:06 2002
@@ -208,7 +208,7 @@
 	int ngroups = EXT3_SB(sb)->s_groups_count;
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
 	struct ext3_group_desc *desc, *best_desc = NULL;
-	struct buffer_head *bh, *best_bh = NULL;
+	struct buffer_head *bh;
 	int group, best_group = -1;
 
 	for (group = 0; group < ngroups; group++) {
@@ -222,16 +222,8 @@
 		     le16_to_cpu(best_desc->bg_free_blocks_count))) {
 			best_group = group;
 			best_desc = desc;
-			best_bh = bh;
 		}
 	}
-	if (!best_desc)
-		return -1;
-	best_desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
-	best_desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
-	mark_buffer_dirty(best_bh);
 	return best_group;
 }
 
@@ -281,8 +273,6 @@
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (parent->i_flags & EXT3_TOPDIR_FL)) {
-		struct ext3_group_desc *best_desc = NULL;
-		struct buffer_head *best_bh = NULL;
 		int best_ndir = inodes_per_group;
 		int best_group = -1;
 
@@ -301,15 +291,9 @@
 				continue;
 			best_group = group;
 			best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
-			best_desc = desc;
-			best_bh = bh;
-		}
-		if (best_group >= 0) {
-			desc = best_desc;
-			bh = best_bh;
-			group = best_group;
-			goto found;
 		}
+		if (best_group >= 0)
+			return best_group;
 		goto fallback;
 	}
 
@@ -341,7 +325,7 @@
 			continue;
 		if (le16_to_cpu(desc->bg_free_blocks_count) < min_blocks)
 			continue;
-		goto found;
+		return group;
 	}
 
 fallback:
@@ -351,19 +335,10 @@
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
 		if (le16_to_cpu(desc->bg_free_inodes_count) >= avefreei)
-			goto found;
+			return group;
 	}
 
 	return -1;
-
-found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
-	sbi->s_dir_count++;
-	mark_buffer_dirty(bh);
-	return group;
 }
 
 static int find_group_other(struct super_block *sb, struct inode *parent)
@@ -380,7 +355,7 @@
 	group = parent_group;
 	desc = ext3_get_group_desc (sb, group, &bh);
 	if (desc && le16_to_cpu(desc->bg_free_inodes_count))
-		goto found;
+		return group;
 
 	/*
 	 * Use a quadratic hash to find a group with a
@@ -392,7 +367,7 @@
 			group -= ngroups;
 		desc = ext3_get_group_desc (sb, group, &bh);
 		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
-			goto found;
+			return group;
 	}
 
 	/*
@@ -404,16 +379,10 @@
 			group = 0;
 		desc = ext3_get_group_desc (sb, group, &bh);
 		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
-			goto found;
+			return group;
 	}
 
 	return -1;
-
-found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	mark_buffer_dirty(bh);
-	return group;
 }
 
 /*
@@ -521,9 +490,11 @@
 	if (err) goto fail;
 	gdp->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
-	if (S_ISDIR(mode))
+	if (S_ISDIR(mode)) {
 		gdp->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
+		EXT3_SB(sb)->s_dir_count++;
+	}
 	BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
