Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWDMHKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWDMHKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWDMHKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:10:37 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:19842 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964809AbWDMHKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:10:36 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][12/21]ext2 enlarge file size
Message-Id: <20060413160957sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:09:57 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [12/21] enlarge file size(ext2)
          - If the flag is set to super block, i_blocks of disk inode
            (ext3_inode) is filesystem-block unit, and i_blocks of VFS
            inode is sector unit.

          - If the flag is set to super block, max file size is set to
            (FS blocksize) * (2^32 -1).

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/fs/ext2/inode.c linux-2.6.17-rc1.tmp/fs/ext2/inode.c
--- linux-2.6.17-rc1.org/fs/ext2/inode.c	2006-03-29 16:57:11.000000000 +0900
+++ linux-2.6.17-rc1.tmp/fs/ext2/inode.c	2006-03-29 17:00:15.000000000 +0900
@@ -1062,6 +1062,7 @@ void ext2_read_inode (struct inode * ino
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode = ext2_get_inode(inode->i_sb, ino, &bh);
 	int n;
+	struct super_block * sb = inode->i_sb;
 
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	ei->i_acl = EXT2_ACL_NOT_CACHED;
@@ -1095,7 +1096,13 @@ void ext2_read_inode (struct inode * ino
 		goto bad_inode;
 	}
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
-	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	if (EXT2_HAS_INCOMPAT_FEATURE(sb,
+		EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
+			<< (inode->i_blkbits - EXT2_SECTOR_BITS);
+	} else {
+		inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	} 
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	ei->i_frag_no = raw_inode->i_frag;
@@ -1216,7 +1223,13 @@ static int ext2_update_inode(struct inod
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 
-	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	if (EXT2_HAS_INCOMPAT_FEATURE(sb,
+		EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		raw_inode->i_blocks = cpu_to_le32((inode->i_blocks)
+			>> (inode->i_blkbits - EXT2_SECTOR_BITS));
+	} else {
+		raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	}
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
diff -upNr -X linux-2.6.16-mm2.org/Documentation/dontdiff linux-2.6.16-mm2.tmp/fs/ext2/super.c linux-2.6.16-mm2.tmp2/fs/ext2/super.c
--- linux-2.6.16-mm2.tmp/fs/ext2/super.c	2006-03-29 16:57:11.000000000 +0900
+++ linux-2.6.16-mm2.tmp2/fs/ext2/super.c	2006-03-29 17:00:15.000000000 +0900
@@ -557,14 +557,20 @@ static int ext2_check_descriptors (struc
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
  * We need to be 1 filesystem block less than the 2^32 sector limit.
  */
-static loff_t ext2_max_size(int bits)
+static loff_t ext2_max_size(int bits, struct super_block *sb)
 {
 	loff_t res = EXT2_NDIR_BLOCKS;
 	/* This constant is calculated to be the largest file size for a
 	 * dense, 4k-blocksize file such that the total number of
 	 * sectors in the file, including data and all indirect blocks,
 	 * does not exceed 2^32. */
-	const loff_t upper_limit = 0x1ff7fffd000LL;
+	loff_t upper_limit;
+	if (EXT2_HAS_INCOMPAT_FEATURE(sb, 
+	    EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		upper_limit = (1LL << (bits + 32)) - 1;
+	} else {
+		upper_limit = 0x1ff7fffd000LL;
+	}
 
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
@@ -748,7 +754,7 @@ static int ext2_fill_super(struct super_
 		}
 	}
 
-	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
+	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits, sb);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
@@ -873,6 +879,15 @@ static int ext2_fill_super(struct super_
 	sb->s_export_op = &ext2_export_ops;
 	sb->s_xattr = ext2_xattr_handlers;
 	root = iget(sb, EXT2_ROOT_INO);
+	/* To appoint -O large block option, LSF needs to be enabled */
+	if (EXT2_HAS_INCOMPAT_FEATURE(sb,
+	    EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		if (sizeof(root->i_blocks) < sizeof(u64)) {
+			printk(KERN_ERR "EXT2-fs: %s: Unsupported large block option"\
+				"with LSF disabled.\n", sb->s_id);
+				goto failed_mount;
+		}
+	}
 	sb->s_root = d_alloc_root(root);
 	if (!sb->s_root) {
 		iput(root);
diff -upNr -X linux-2.6.16-mm2.org/Documentation/dontdiff linux-2.6.16-mm2.tmp/include/linux/ext2_fs.h linux-2.6.16-mm2.tmp2/include/linux/ext2_fs.h
--- linux-2.6.16-mm2.tmp/include/linux/ext2_fs.h	2006-03-29 16:58:02.000000000 +0900
+++ linux-2.6.16-mm2.tmp2/include/linux/ext2_fs.h	2006-03-29 17:00:15.000000000 +0900
@@ -104,6 +104,7 @@ static inline struct ext2_sb_info *EXT2_
 #else
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT2_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */
 #ifdef __KERNEL__
 #define	EXT2_ADDR_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_addr_per_block_bits)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
