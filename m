Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbUKEBLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbUKEBLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUKEBJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:09:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6021 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262533AbUKEBDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:03:52 -0500
Date: Fri, 5 Nov 2004 02:03:42 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't divide by zero on bad ext2 fs
Message-ID: <20041105010340.GA8148@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Experimented a bit more with mounting a bad ext2 filesystem.
An immediate crash was caused by zero EXT2_BLOCKS_PER_GROUP(sb).
The patch below (relative to 2.6.9) adds a few checks to make sure
that things we divide by are not zero.

Andries

diff -uprN -X /linux/dontdiff a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	2004-10-30 21:44:02.000000000 +0200
+++ b/fs/ext2/super.c	2004-11-05 01:48:32.000000000 +0100
@@ -595,12 +595,9 @@ static int ext2_fill_super(struct super_
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	sb->s_flags |= MS_ONE_SECOND;
-	if (sb->s_magic != EXT2_SUPER_MAGIC) {
-		if (!silent)
-			printk ("VFS: Can't find ext2 filesystem on dev %s.\n",
-				sb->s_id);
-		goto failed_mount;
-	}
+
+	if (sb->s_magic != EXT2_SUPER_MAGIC)
+		goto cantfind_ext2;
 
 	/* Set defaults before we parse the mount options */
 	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
@@ -655,7 +652,9 @@ static int ext2_fill_super(struct super_
 		       sb->s_id, le32_to_cpu(features));
 		goto failed_mount;
 	}
+
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
+
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
 		brelse(bh);
@@ -697,35 +696,36 @@ static int ext2_fill_super(struct super_
 			goto failed_mount;
 		}
 	}
+
 	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
 				   le32_to_cpu(es->s_log_frag_size);
-	if (sbi->s_frag_size)
-		sbi->s_frags_per_block = sb->s_blocksize /
-						  sbi->s_frag_size;
-	else
-		sb->s_magic = 0;
+	if (sbi->s_frag_size == 0)
+		goto cantfind_ext2;
+	sbi->s_frags_per_block = sb->s_blocksize / sbi->s_frag_size;
+
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
 	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-	sbi->s_inodes_per_block = sb->s_blocksize /
-					   EXT2_INODE_SIZE(sb);
+
+	if (EXT2_INODE_SIZE(sb) == 0)
+		goto cantfind_ext2;
+	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
+	if (sbi->s_inodes_per_block == 0)
+		goto cantfind_ext2;
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /
-				        sbi->s_inodes_per_block;
+					sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = sb->s_blocksize /
-					 sizeof (struct ext2_group_desc);
+					sizeof (struct ext2_group_desc);
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
-	if (sb->s_magic != EXT2_SUPER_MAGIC) {
-		if (!silent)
-			printk ("VFS: Can't find an ext2 filesystem on dev "
-				"%s.\n",
-				sb->s_id);
-		goto failed_mount;
-	}
+
+	if (sb->s_magic != EXT2_SUPER_MAGIC)
+		goto cantfind_ext2;
+
 	if (sb->s_blocksize != bh->b_size) {
 		if (!silent)
 			printk ("VFS: Unsupported blocksize on dev "
@@ -755,6 +755,8 @@ static int ext2_fill_super(struct super_
 		goto failed_mount;
 	}
 
+	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
+		goto cantfind_ext2;
 	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
@@ -824,13 +826,19 @@ static int ext2_fill_super(struct super_
 	percpu_counter_mod(&sbi->s_dirs_counter,
 				ext2_count_dirs(sb));
 	return 0;
+
+cantfind_ext2:
+	if (!silent)
+		printk("VFS: Can't find an ext2 filesystem on dev %s.\n",
+		       sb->s_id);
+	goto failed_mount;
+
 failed_mount2:
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 failed_mount_group_desc:
 	kfree(sbi->s_group_desc);
-	if (sbi->s_debts)
-		kfree(sbi->s_debts);
+	kfree(sbi->s_debts);
 failed_mount:
 	brelse(bh);
 failed_sbi:
