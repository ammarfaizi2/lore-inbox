Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKHUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKHUAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKHUAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:00:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:44242 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261207AbUKHT7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:59:43 -0500
Date: Mon, 8 Nov 2004 20:59:35 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't divide by 0 when trying to mount ext3
Message-ID: <20041108195934.GA29981@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not surprisingly, the ext3 code crashes in the same way
the ext2 code does when dividing by zero.

diff -uprN -X /linux/dontdiff a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	2004-10-30 21:44:02.000000000 +0200
+++ b/fs/ext3/super.c	2004-11-08 20:55:30.000000000 +0100
@@ -1259,13 +1259,8 @@ static int ext3_fill_super (struct super
 	es = (struct ext3_super_block *) (((char *)bh->b_data) + offset);
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
-	if (sb->s_magic != EXT3_SUPER_MAGIC) {
-		if (!silent)
-			printk(KERN_ERR 
-			       "VFS: Can't find ext3 filesystem on dev %s.\n",
-			       sb->s_id);
-		goto failed_mount;
-	}
+	if (sb->s_magic != EXT3_SUPER_MAGIC)
+		goto cantfind_ext3;
 
 	/* Set defaults before we parse the mount options */
 	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
@@ -1397,8 +1392,13 @@ static int ext3_fill_super (struct super
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
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
@@ -1427,6 +1427,8 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
+	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
+		goto cantfind_ext3;
 	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 			       le32_to_cpu(es->s_first_data_block) +
 			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
@@ -1579,6 +1581,12 @@ static int ext3_fill_super (struct super
 
 	return 0;
 
+cantfind_ext3:
+	if (!silent)
+		printk(KERN_ERR "VFS: Can't find ext3 filesystem on dev %s.\n",
+		       sb->s_id);
+	goto failed_mount;
+
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
@@ -1588,10 +1596,8 @@ failed_mount2:
 	kfree(sbi->s_group_desc);
 failed_mount:
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < MAXQUOTAS; i++) {
-		if (sbi->s_qf_names[i])
-			kfree(sbi->s_qf_names[i]);
-	}
+	for (i = 0; i < MAXQUOTAS; i++)
+		kfree(sbi->s_qf_names[i]);
 #endif
 	ext3_blkdev_remove(sbi);
 	brelse(bh);
