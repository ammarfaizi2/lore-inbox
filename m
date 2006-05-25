Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWEYMvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWEYMvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWEYMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:51:07 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:33488 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965151AbWEYMvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:51:05 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][14/24]ext2 enlarge file size
Message-Id: <20060525215057sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:50:57 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [14/24] extend file size(ext2)
          - If the flag is set to super block, i_blocks of disk inode
            (ext3_inode) is filesystem-block unit, and i_blocks of VFS
            inode is sector unit.

          - If the flag is set to super block, max file size is set to
            (FS blocksize) * (2^32 -1).

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/inode.c linux-2.6.17-rc4.tmp/fs/ext2/inode.c
--- linux-2.6.17-rc4/fs/ext2/inode.c	2006-05-25 16:33:48.509510541 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/inode.c	2006-05-25 16:34:32.872791248 +0900
@@ -1095,8 +1095,13 @@ void ext2_read_inode (struct inode * ino
 		goto bad_inode;
 	}
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
-	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	if (ei->i_flags & EXT2_HUGE_FILE_FL) {
+		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
+			<< (inode->i_blkbits - EXT2_SECTOR_BITS);
+	} else {
+		inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	}
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	ei->i_frag_no = raw_inode->i_frag;
 	ei->i_frag_size = raw_inode->i_fsize;
@@ -1215,10 +1220,22 @@ static int ext2_update_inode(struct inod
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
+	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 
-	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	if (inode->i_blocks <= ~0U) {
+		raw_inode->i_flags &= ~EXT2_HUGE_FILE_FL;
+		raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	} else {
+		ext2_update_dynamic_rev(sb);
+		EXT2_SET_RO_COMPAT_FEATURE(sb,
+				EXT2_FEATURE_RO_COMPAT_HUGE_FILE);
+		ext2_write_super(sb);
+		printk("ext2_update_inode: Now the file size is more than 2TB on (%s)!!\n", sb->s_id);
+		raw_inode->i_flags |= EXT2_HUGE_FILE_FL;
+		raw_inode->i_blocks = cpu_to_le32((inode->i_blocks)
+			>> (inode->i_blkbits - EXT2_SECTOR_BITS));
+	}
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/super.c linux-2.6.17-rc4.tmp/fs/ext2/super.c
--- linux-2.6.17-rc4/fs/ext2/super.c	2006-05-25 16:33:48.510487104 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/super.c	2006-05-25 16:34:32.873767810 +0900
@@ -557,14 +557,21 @@ static int ext2_check_descriptors (struc
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
+	if (sizeof(blkcnt_t) < sizeof(u64)) {
+		upper_limit = 0x1ff7fffd000LL;
+	}
+	/* With CONFIG_LSF on, file size is limited to blocksize*(4G-1) */
+	else { 
+		upper_limit = (1LL << (bits + 32)) - (1LL << bits);
+	}
 
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
@@ -748,7 +755,7 @@ static int ext2_fill_super(struct super_
 		}
 	}
 
-	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
+	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits, sb);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
@@ -873,6 +880,19 @@ static int ext2_fill_super(struct super_
 	sb->s_export_op = &ext2_export_ops;
 	sb->s_xattr = ext2_xattr_handlers;
 	root = iget(sb, EXT2_ROOT_INO);
+
+	if (EXT2_HAS_RO_COMPAT_FEATURE(sb,
+	    EXT2_FEATURE_RO_COMPAT_HUGE_FILE)) {
+		if (sizeof(root->i_blocks) < sizeof(u64)) {
+			if (!(sb->s_flags & MS_RDONLY)) {
+				printk(KERN_ERR "EXT2-fs: %s: Having huge file with "
+						"LSF off, you must mount filesystem "
+						"read-only.\n", sb->s_id);
+				goto failed_mount;
+			}
+		}
+	}
+
 	sb->s_root = d_alloc_root(root);
 	if (!sb->s_root) {
 		iput(root);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext2_fs.h linux-2.6.17-rc4.tmp/include/linux/ext2_fs.h
--- linux-2.6.17-rc4/include/linux/ext2_fs.h	2006-05-25 16:34:05.951893140 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext2_fs.h	2006-05-25 16:34:32.874744373 +0900
@@ -104,6 +104,7 @@ static inline struct ext2_sb_info *EXT2_
 #else
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT2_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */
 #ifdef __KERNEL__
 #define	EXT2_ADDR_PER_BLOCK_BITS(s)	(EXT2_SB(s)->s_addr_per_block_bits)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
@@ -193,6 +194,7 @@ struct ext2_group_desc
 #define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT2_HUGE_FILE_FL               0x00040000 /* Set to each huge file */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
 #define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
@@ -465,6 +467,7 @@ struct ext2_super_block {
 #define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT2_FEATURE_RO_COMPAT_HUGE_FILE        0x0008
 #define EXT2_FEATURE_RO_COMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
@@ -481,7 +484,8 @@ struct ext2_super_block {
 					 EXT2_FEATURE_INCOMPAT_HUGE_FS)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
+					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR| \
+					 EXT2_FEATURE_RO_COMPAT_HUGE_FILE)
 #define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
 #define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
 



