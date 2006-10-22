Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423057AbWJVGtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWJVGtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423107AbWJVGtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:49:22 -0400
Received: from 1wt.eu ([62.212.114.60]:3844 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1423057AbWJVGtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:49:22 -0400
Date: Sun, 22 Oct 2006 08:49:16 +0200
From: Willy Tarreau <w@1wt.eu>
To: sct@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] EXT3: avoid crashing due to divide by zero
Message-ID: <20061022064916.GA745@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I've been having this very old patch in my queue that has been merged
in 2.6 but not in 2.4. As I've been hit at least once by this problem,
I'm about to merge it into 2.4 too, as well as its ext2 equivalent
(equally in 2.6). Do you have any objection ?

Thanks in advance,
Willy

>From 14f44814b9e550272f3bdc8e4abb5a9ead19f40e Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 22 Oct 2006 08:31:02 +0200
Subject: [PATCH] EXT3: avoid crashing by not dividing by zero.

backport a few checks from 2.6 to avoid dividing by zero on invalid
superblocks.
---
 fs/ext3/super.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 33e2f97..6dae3f3 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -979,13 +979,9 @@ #endif
 	es = (struct ext3_super_block *) (((char *)bh->b_data) + offset);
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
-	if (sb->s_magic != EXT3_SUPER_MAGIC) {
-		if (!silent)
-			printk(KERN_ERR 
-			       "VFS: Can't find ext3 filesystem on dev %s.\n",
-			       bdevname(dev));
-		goto failed_mount;
-	}
+	if (sb->s_magic != EXT3_SUPER_MAGIC)
+		goto cantfind_ext3;
+
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV &&
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -1083,8 +1079,13 @@ #endif
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
 	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+	if (EXT3_INODE_SIZE(sb) == 0)
+		goto cantfind_ext3;
 	sbi->s_inodes_per_block = blocksize / EXT3_INODE_SIZE(sb);
-	sbi->s_itb_per_group = sbi->s_inodes_per_group /sbi->s_inodes_per_block;
+	if (sbi->s_inodes_per_block == 0)
+		goto cantfind_ext3;
+	sbi->s_itb_per_group = sbi->s_inodes_per_group /
+					sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = blocksize / sizeof(struct ext3_group_desc);
 	sbi->s_sbh = bh;
 	if (sbi->s_resuid == EXT3_DEF_RESUID)
@@ -1114,6 +1115,8 @@ #endif
 		goto failed_mount;
 	}
 
+	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
+		goto cantfind_ext3;
 	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 			       le32_to_cpu(es->s_first_data_block) +
 			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
@@ -1240,6 +1243,12 @@ #endif
 
 	return sb;
 
+cantfind_ext3:
+	if (!silent)
+		printk(KERN_ERR 
+		       "VFS: Can't find ext3 filesystem on dev %s.\n",
+		       bdevname(dev));
+	goto failed_mount;
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
-- 
1.4.1

