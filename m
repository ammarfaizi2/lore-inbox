Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWCRNCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWCRNCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCRNCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:02:08 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:45461 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751694AbWCRNCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:02:06 -0500
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ext2/3: Extends the max file size(ext3 in kernel)
Message-Id: <20060318220158sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 18 Mar 2006 22:01:58 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modification to entend the max filesize for ext3.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/fs/ext3/inode.c linux-2.6.16-rc6-
mm1-bigfile/fs/ext3/inode.c
--- linux-2.6.16-rc6-mm1.org/fs/ext3/inode.c	2006-03-16 21:19:01.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/fs/ext3/inode.c	2006-03-16 21:27:30.000000000 +0900
@@ -2578,6 +2578,7 @@ void ext3_read_inode(struct inode * inod
 	struct ext3_inode *raw_inode;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct buffer_head *bh;
+	struct super_block *sb = inode->i_sb;
 	int block;
 
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
@@ -2627,7 +2628,13 @@ void ext3_read_inode(struct inode * inod
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size
 					 * (for stat), not the fs block
 					 * size */  
-	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
+		EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
+			<< (inode->i_blkbits - EXT3_SECTOR_BITS);
+	} else {
+		inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	} 
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
@@ -2723,6 +2730,7 @@ static int ext3_do_update_inode(handle_t
 	struct ext3_inode *raw_inode = ext3_raw_inode(iloc);
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct buffer_head *bh = iloc->bh;
+	struct super_block *sb = inode->i_sb;
 	int err = 0, rc, block;
 
 	/* For fields not not tracking in the in-memory inode,
@@ -2760,7 +2768,13 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
-	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
+	EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		raw_inode->i_blocks = cpu_to_le32((inode->i_blocks)
+			>> (inode->i_blkbits - EXT3_SECTOR_BITS));
+	} else {
+		raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	}
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 #ifdef EXT3_FRAGMENTS
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/fs/ext3/super.c linux-2.6.16-rc6-
mm1-bigfile/fs/ext3/super.c
--- linux-2.6.16-rc6-mm1.org/fs/ext3/super.c	2006-03-16 21:19:01.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/fs/ext3/super.c	2006-03-16 21:27:30.000000000 +0900
@@ -1300,14 +1300,20 @@ static void ext3_orphan_cleanup (struct 
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
  * We need to be 1 filesystem block less than the 2^32 sector limit.
  */
-static loff_t ext3_max_size(int bits)
+static loff_t ext3_max_size(int bits, struct super_block *sb)
 {
 	loff_t res = EXT3_NDIR_BLOCKS;
 	/* This constant is calculated to be the largest file size for a
 	 * dense, 4k-blocksize file such that the total number of
 	 * sectors in the file, including data and all indirect blocks,
 	 * does not exceed 2^32. */
-	const loff_t upper_limit = 0x1ff7fffd000LL;
+	loff_t upper_limit;
+	if(EXT3_HAS_INCOMPAT_FEATURE(sb, 
+	   EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		upper_limit = (1LL << (bits + 31)) - 1;
+	} else {
+		upper_limit = 0x1ff7fffd000LL;
+	}
 
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
@@ -1504,7 +1510,7 @@ static int ext3_fill_super (struct super
 		}
 	}
 
-	sb->s_maxbytes = ext3_max_size(sb->s_blocksize_bits);
+	sb->s_maxbytes = ext3_max_size(sb->s_blocksize_bits, sb);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT3_GOOD_OLD_INODE_SIZE;
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/include/linux/ext3_fs.h linux-2.6
.16-rc6-mm1-bigfile/include/linux/ext3_fs.h
--- linux-2.6.16-rc6-mm1.org/include/linux/ext3_fs.h	2006-03-16 21:19:10.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/include/linux/ext3_fs.h	2006-03-16 21:27:30.000000000 +0900
@@ -98,6 +98,7 @@ struct statfs;
 #else
 # define EXT3_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT3_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */ 
 #ifdef __KERNEL__
 #define	EXT3_ADDR_PER_BLOCK_BITS(s)	(EXT3_SB(s)->s_addr_per_block_bits)
 #define EXT3_INODE_SIZE(s)		(EXT3_SB(s)->s_inode_size)
@@ -563,11 +564,13 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
+#define EXT3_FEATURE_INCOMPAT_LARGE_BLOCK	0x0080 
 
 #define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER| \
-					 EXT3_FEATURE_INCOMPAT_META_BG)
+					 EXT3_FEATURE_INCOMPAT_META_BG| \
+					 EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)

