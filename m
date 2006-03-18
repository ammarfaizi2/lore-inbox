Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWCRNBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWCRNBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWCRNBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:01:40 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:33941 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751552AbWCRNBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:01:39 -0500
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ext2/3: Extends the max file size(ext2 in kernel)
Message-Id: <20060318220130sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 18 Mar 2006 22:01:30 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a disk size tends to be larger, some desktop PCs have a disk
storages which have the capacity to supply more than multi-TB recently.
But now ext2/3 can't support more than 2TB file in 4K-blocksize.  
And then I think the file size of ext2/3 also should be extended.

The unit of ext2/ext3_inode.i_blocks is sector(512B) and the variable
size is 4bytes, so it limits the max file size to 2TB.  
I found that i_blocks is always counted with rounding up to the file
system block size and does not have fractions.  So we can change the
unit of ext2/ext3_inode.i_blocks from sector to block size.
This change extends the maximum file size as below.

                             Original    Extended
ext3(Max block size=4KB)      1.998TB     4.003TB
ext2(Max block size=64KB)     1.998TB       128TB
- The max block size is different between ext2 and ext3.

And it does not reclaim other entry in ext2/ext3_inode such as i_frag
and i_faddr.

This modification depends on the following patches in mm-tree.
- 2tb-files-st_blocks-is-invalid-when-calling-stat64.patch
- 2tb-files-add-blkcnt_t.patch
- 2tb-files-add-blkcnt_t-fixes.patch

This patch set is composed of four parts as below.

[1/4] ext2(linux 2.6.16-rc6-mm1)
  - Add new compatible flag "EXT2_FEATURE_INCOMPAT_LARGE_BLOCK".
    It indicates that the file size is extended.

  - If the flag is set in the super block, ext2_inode.i_blocks is
    translated into the number of sectors and set to i_blocks of VFS
    inode.  And, if not, ext2_inode.i_blocks is passed to i_blocks
    of VFS inode as it is.

  - If the flag is set, the limit of the max file size defined in
    ext2_max_size() is set to block size * 2G-1(2^31-1).

[2/4] ext3(linux 2.6.16-rc6-mm1)
  - The same modifications as ext2.

[3/4] changing the unit of ext2/ext3_inode.i_blocks (e2fsprogs-1.38)
  - Add new feature "large_block" to -O option in mke2fs.
  - If the flag which specifies the extended filesystem is set, 
    all commands manages ext2/3_inode.i_blocks as the number of
    filesystem blocks.

[4/4] Fix the max file size limit (e2fsprogs-1.38)
  - Change the format string(%d) for i_blocks to %u.
  - If the flag is set, the max file blocks which used by e2fsck is
    set to 2G-1(2^31-1).

Any feedback and comments are welcome.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/fs/ext2/inode.c linux-2.6.16-rc6-
mm1-bigfile/fs/ext2/inode.c
--- linux-2.6.16-rc6-mm1.org/fs/ext2/inode.c	2006-03-16 21:19:00.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/fs/ext2/inode.c	2006-03-16 21:27:29.000000000 +0900
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
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/fs/ext2/super.c linux-2.6.16-rc6-
mm1-bigfile/fs/ext2/super.c
--- linux-2.6.16-rc6-mm1.org/fs/ext2/super.c	2006-03-16 21:19:00.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/fs/ext2/super.c	2006-03-16 21:27:30.000000000 +0900
@@ -558,14 +558,20 @@ static int ext2_check_descriptors (struc
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
+		upper_limit = (1LL << (bits + 31)) - 1;
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
diff -uprN -X linux-2.6.16-rc6-mm1.org/Documentation/dontdiff linux-2.6.16-rc6-mm1.org/include/linux/ext2_fs.h linux-2.6
.16-rc6-mm1-bigfile/include/linux/ext2_fs.h
--- linux-2.6.16-rc6-mm1.org/include/linux/ext2_fs.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-mm1-bigfile/include/linux/ext2_fs.h	2006-03-16 21:27:30.000000000 +0900
@@ -103,6 +103,7 @@ static inline struct ext2_sb_info *EXT2_
 #else
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT2_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */ 
 #ifdef __KERNEL__
 #define	EXT2_ADDR_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_addr_per_block_bits)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
@@ -471,11 +472,13 @@ struct ext2_super_block {
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
+#define EXT2_FEATURE_INCOMPAT_LARGE_BLOCK	0x0080
 #define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT2_FEATURE_INCOMPAT_META_BG)
+					 EXT2_FEATURE_INCOMPAT_META_BG| \
+					 EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)

