Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRGKUwp>; Wed, 11 Jul 2001 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266773AbRGKUwf>; Wed, 11 Jul 2001 16:52:35 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:28407 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266381AbRGKUwX>; Wed, 11 Jul 2001 16:52:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112051.f6BKplqg009583@webber.adilger.int>
Subject: [PATCH] ext2 root dir sanity checking
To: torvalds@transmeta.com
Date: Wed, 11 Jul 2001 14:51:46 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a couple of extra tests for the root inode to avoid mounting
a filesystem with an obviously corrupt root inode.  This patch was prompted
a few months ago when someone was able to mount an ext2 filesystem which had
the inode table wiped out, but the superblock was still intact (they wanted
to see what was on an unused partition, so they tried mounting it).

The patch has been in the -ac kernels for a while now.  It also does a bit
of consolidation of error path cleanup code.

Cheers, Andreas
==========================================================================
diff -ru linux-2.4.6.orig/fs/ext2/super.c linux-2.4.6-aed/fs/ext2/super.c
--- linux-2.4.6.orig/fs/ext2/super.c	Tue May 29 13:13:19 2001
+++ linux-2.4.6-aed/fs/ext2/super.c	Thu Jun 28 15:04:34 2001
@@ -454,12 +469,9 @@
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
-			printk ("VFS: Can't find an ext2 filesystem on dev "
-				"%s.\n", bdevname(dev));
-	failed_mount:
-		if (bh)
-			brelse(bh);
-		return NULL;
+			printk ("VFS: Can't find ext2 filesystem on dev %s.\n",
+				bdevname(dev));
+		goto failed_mount;
 	}
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
@@ -622,11 +617,9 @@
 		}
 	}
 	if (!ext2_check_descriptors (sb)) {
-		for (j = 0; j < db_count; j++)
-			brelse (sb->u.ext2_sb.s_group_desc[j]);
-		kfree(sb->u.ext2_sb.s_group_desc);
-		printk ("EXT2-fs: group descriptors corrupted !\n");
-		goto failed_mount;
+		printk ("EXT2-fs: group descriptors corrupted!\n");
+		db_count = i;
+		goto failed_mount2;
 	}
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
 		sb->u.ext2_sb.s_inode_bitmap_number[i] = 0;
@@ -642,17 +635,25 @@
 	 */
 	sb->s_op = &ext2_sops;
 	sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO));
-	if (!sb->s_root) {
-		for (i = 0; i < db_count; i++)
-			if (sb->u.ext2_sb.s_group_desc[i])
-				brelse (sb->u.ext2_sb.s_group_desc[i]);
-		kfree(sb->u.ext2_sb.s_group_desc);
-		brelse (bh);
-		printk ("EXT2-fs: get root inode failed\n");
-		return NULL;
+	if (!sb->s_root || !S_ISDIR(sb->s_root->d_inode->i_mode) ||
+	    !sb->s_root->d_inode->i_blocks || !sb->s_root->d_inode->i_size) {
+		if (sb->s_root) {
+			dput(sb->s_root);
+			sb->s_root = NULL;
+			printk ("EXT2-fs: corrupt root inode, run e2fsck\n");
+		} else
+			printk ("EXT2-fs: get root inode failed\n");
+		goto failed_mount2;
 	}
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
 	return sb;
+failed_mount2:
+	for (i = 0; i < db_count; i++)
+		brelse(sb->u.ext2_sb.s_group_desc[i]);
+	kfree(sb->u.ext2_sb.s_group_desc);
+failed_mount:
+	brelse(bh);
+	return NULL;
 }
 
 static void ext2_commit_super (struct super_block * sb,
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
