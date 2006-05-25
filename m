Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWEYMuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWEYMuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWEYMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:50:23 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51407 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965150AbWEYMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:50:22 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][13/24]ext3 enlarge file size
Message-Id: <20060525215014sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:50:14 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [13/24] extend file size(ext3)
          - If the flag is set to super block, i_blocks of disk inode
            (ext3_inode) is filesystem-block unit, and i_blocks of VFS
            inode is sector unit.

          - If the flag is set to super block, max file size is set to
            (FS blocksize) * (2^32 -1).

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/inode.c linux-2.6.17-rc4.tmp/fs/ext3/inode.c
--- linux-2.6.17-rc4/fs/ext3/inode.c	2006-05-25 16:33:29.706776397 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/inode.c	2006-05-25 16:34:09.854236842 +0900
@@ -2630,8 +2630,13 @@ void ext3_read_inode(struct inode * inod
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size
 					 * (for stat), not the fs block
 					 * size */  
-	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	if (ei->i_flags & EXT3_HUGE_FILE_FL) {
+		inode->i_blocks = (blkcnt_t)le32_to_cpu(raw_inode->i_blocks)
+			<< (inode->i_blkbits - EXT3_SECTOR_BITS);
+	} else {
+		inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	} 
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	ei->i_frag_no = raw_inode->i_frag;
@@ -2726,6 +2731,7 @@ static int ext3_do_update_inode(handle_t
 	struct ext3_inode *raw_inode = ext3_raw_inode(iloc);
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct buffer_head *bh = iloc->bh;
+	struct super_block *sb = inode->i_sb;
 	int err = 0, rc, block;
 
 	/* For fields not not tracking in the in-memory inode,
@@ -2763,9 +2769,30 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
-	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
-	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+
+	if (inode->i_blocks <= ~0U) {
+		raw_inode->i_flags &= ~EXT3_HUGE_FILE_FL;
+		raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	} else {
+		err = ext3_journal_get_write_access(handle,
+				EXT3_SB(sb)->s_sbh);
+		if (err)
+			goto out_brelse;
+		ext3_update_dynamic_rev(sb);
+		EXT3_SET_RO_COMPAT_FEATURE(sb,
+				EXT3_FEATURE_RO_COMPAT_HUGE_FILE);
+		sb->s_dirt = 1;
+		handle->h_sync = 1;
+		err = ext3_journal_dirty_metadata(handle,
+				EXT3_SB(sb)->s_sbh);
+		printk("ext3_do_update_inode: Now the file size is "
+		       "more than 2TB on device (%s)!!\n", sb->s_id);
+		raw_inode->i_flags |= EXT3_HUGE_FILE_FL;
+		raw_inode->i_blocks = cpu_to_le32((inode->i_blocks)
+		 	>> (inode->i_blkbits - EXT3_SECTOR_BITS));			
+	}
+	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 #ifdef EXT3_FRAGMENTS
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/super.c linux-2.6.17-rc4.tmp/fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c	2006-05-25 16:34:05.950916578 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/super.c	2006-05-25 16:34:09.856189967 +0900
@@ -1297,14 +1297,21 @@ static void ext3_orphan_cleanup (struct 
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
+	if (sizeof(blkcnt_t) < sizeof(u64)) {
+		upper_limit = 0x1ff7fffd000LL;
+	}
+	/* With CONFIG_LSF on, file size is limited to blocksize*(4G-1) */
+	else { 
+		upper_limit = (1LL << (bits + 32)) - (1LL << bits);
+	}
 
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
@@ -1465,7 +1472,7 @@ static int ext3_fill_super (struct super
 
 	if (blocksize > PAGE_SIZE) {
 		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
-		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
+		       "blocksize %u larger than PAGE_SIZE %lu on %s\n",
 		       blocksize, PAGE_SIZE, sb->s_id);
 		goto failed_mount;
 	}
@@ -1508,7 +1515,7 @@ static int ext3_fill_super (struct super
 		}
 	}
 
-	sb->s_maxbytes = ext3_max_size(sb->s_blocksize_bits);
+	sb->s_maxbytes = ext3_max_size(sb->s_blocksize_bits, sb);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT3_GOOD_OLD_INODE_SIZE;
@@ -1699,6 +1706,18 @@ static int ext3_fill_super (struct super
 	 */
 
 	root = iget(sb, EXT3_ROOT_INO);
+
+	if (EXT3_HAS_RO_COMPAT_FEATURE(sb,
+	    EXT3_FEATURE_RO_COMPAT_HUGE_FILE)) {
+		if (sizeof(root->i_blocks) < sizeof(u64)) {
+			if (!(sb->s_flags & MS_RDONLY)) {
+				printk(KERN_ERR "EXT3-fs: %s: Having huge file with "
+						"LSF off, you must mount filesystem "
+						"read-only.\n", sb->s_id);
+				goto failed_mount;
+			}
+		}
+	}
 	sb->s_root = d_alloc_root(root);
 	if (!sb->s_root) {
 		printk(KERN_ERR "EXT3-fs: get root inode failed\n");
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:34:05.951893140 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:34:09.857166530 +0900
@@ -99,6 +99,7 @@ struct statfs;
 #else
 # define EXT3_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT3_SECTOR_BITS        9       /* log2(SECTOR_SIZE) */
 #ifdef __KERNEL__
 #define	EXT3_ADDR_PER_BLOCK_BITS(s)	(EXT3_SB(s)->s_addr_per_block_bits)
 #define EXT3_INODE_SIZE(s)		(EXT3_SB(s)->s_inode_size)
@@ -187,6 +188,7 @@ struct ext3_group_desc
 #define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT3_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT3_HUGE_FILE_FL		0x00040000 /* Set to each huge file */
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
 #define EXT3_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
@@ -558,6 +560,7 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT3_FEATURE_RO_COMPAT_HUGE_FILE	0x0008
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -573,8 +576,8 @@ static inline struct ext3_inode_info *EX
 					 EXT3_FEATURE_INCOMPAT_HUGE_FS)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
-
+					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR| \
+					 EXT3_FEATURE_RO_COMPAT_HUGE_FILE)
 /*
  * Default values for user and/or group using reserved blocks
  */



