Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUGIICm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUGIICm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 04:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUGIICl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 04:02:41 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:37772 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S264540AbUGIICJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 04:02:09 -0400
Subject: [PATCH] Pushing ext3 file size limits beyond 2TB
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 9 Jul 2004 13:30:27 +0530
Content-Transfer-Encoding: 7BIT
Message-ID: <33BC33A9E76474479B76AD0DE8A169728DB2@exch-ntd.nec.noida.hcltech.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Pushing ext3 file size limits beyond 2TB
Thread-Index: AcRliswcVsYmgcTQQ2qQHotDcD+sYg==
From: "Goldwyn Rodrigues" <Goldwynr@noida.hcltech.com>
To: "Linux-Ia64 \(E-mail\)" <linux-ia64@vger.kernel.org>,
       "Linux-Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
Cc: "Andreas Dilger \(E-mail\)" <adilger@clusterfs.com>,
       "Jan-Benedict Glaw \(E-mail\)" <jbglaw@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is to push file-size limit beyond 2TB. This is done by using 
some unused fields, namely i_frag and i_fsize, of the ext3_inode to 
store higher order bits of the i_blocks.

i_blocks in all references have been changed to data type sector_t in order 
to accomodate 64 bits.

Changes to previous patch posted (This patch is complete in itself):
1. Read-only compatibility flag of many blocks is now independent of 
   file size compatibility flag.
2. Changed the help of the Kconfig file to demonstrate the same.

Kernel Version Used: 2.6.7

Thanks Andreas for your comments and help.

Regards,

-- 
Goldwyn :o)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
System Software CoE @ HCLT-Noida
http://www.hcltechnologies.com
Ph. : +91-120-2510701/702 Ext : 3155
FAX : +91-120-2510713
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


diff -rup linux-2.6.7.orig/fs/ext3/inode.c linux-2.6.7/fs/ext3/inode.c
--- linux-2.6.7.orig/fs/ext3/inode.c	2004-07-01 11:40:30.000000000 +0530
+++ linux-2.6.7/fs/ext3/inode.c	2004-07-09 09:54:28.000000000 +0530
@@ -353,7 +353,7 @@ static inline int verify_chain(Indirect 
  */
 
 static int ext3_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			sector_t i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -905,7 +905,7 @@ ext3_direct_io_get_blocks(struct inode *
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext3_getblk(handle_t *handle, struct inode * inode,
-				long block, int create, int * errp)
+				sector_t block, int create, int * errp)
 {
 	struct buffer_head dummy;
 	int fatal = 0, err;
@@ -955,10 +955,10 @@ struct buffer_head *ext3_getblk(handle_t
 }
 
 struct buffer_head *ext3_bread(handle_t *handle, struct inode * inode,
-			       int block, int create, int *err)
+			       sector_t block, int create, int *err)
 {
 	struct buffer_head * bh;
-	int prev_blocks;
+	sector_t prev_blocks;
 
 	prev_blocks = inode->i_blocks;
 
@@ -2136,7 +2136,7 @@ void ext3_truncate(struct inode * inode)
 	Indirect *partial;
 	int nr = 0;
 	int n;
-	long last_block;
+	sector_t last_block;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	struct page *page;
 
@@ -2526,6 +2526,11 @@ void ext3_read_inode(struct inode * inod
 					 * (for stat), not the fs block
 					 * size */  
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+#ifdef CONFIG_EXT3_MANY_BLOCKS_SUPPORT
+	inode->i_blocks |= ((__u64)le32_to_cpu(raw_inode->i_blocks_high)) << 32;
+	inode->i_blocks |= ((__u64)le32_to_cpu(raw_inode->i_blocks_high1)) << 40;
+#endif
+
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
@@ -2638,6 +2643,10 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+#ifdef CONFIG_EXT3_MANY_BLOCKS_SUPPORT
+	raw_inode->i_blocks_high = (__u8)cpu_to_le32(inode->i_blocks >> 32);
+	raw_inode->i_blocks_high1 = (__u8)cpu_to_le32(inode->i_blocks >> 40);
+#endif
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 #ifdef EXT3_FRAGMENTS
@@ -2673,6 +2682,29 @@ static int ext3_do_update_inode(handle_t
 						EXT3_SB(sb)->s_sbh);
 			}
 		}
+		if (inode->i_blocks > 0xffffffffULL) {
+			struct super_block *sb = inode->i_sb;
+			if (!EXT3_HAS_RO_COMPAT_FEATURE(sb,
+					EXT3_FEATURE_RO_COMPAT_MANY_BLOCKS) ||
+				EXT3_SB(sb)->s_es->s_rev_level ==
+					cpu_to_le32(EXT3_GOOD_OLD_REV)) {
+				/* If this is the first file
+				 * with many blocks created,
+				 * flag the super block
+				 */
+				err = ext3_journal_get_write_access(handle,
+						EXT3_SB(sb)->s_sbh);
+				if (err)
+					goto out_brelse;
+				ext3_update_dynamic_rev(sb);
+				EXT3_SET_RO_COMPAT_FEATURE(sb,
+					EXT3_FEATURE_RO_COMPAT_MANY_BLOCKS);
+				sb->s_dirt = 1;
+				handle->h_sync = 1;
+				err = ext3_journal_dirty_metadata(handle,
+						EXT3_SB(sb)->s_sbh);
+			}
+		}
 	}
 	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
diff -rup linux-2.6.7.orig/fs/ext3/super.c linux-2.6.7/fs/ext3/super.c
--- linux-2.6.7.orig/fs/ext3/super.c	2004-07-01 11:40:30.000000000 +0530
+++ linux-2.6.7/fs/ext3/super.c	2004-07-09 09:49:24.000000000 +0530
@@ -1172,8 +1172,11 @@ static loff_t ext3_max_size(int bits)
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
 	res <<= bits;
-	if (res > (512LL << 32) - (1 << bits))
-		res = (512LL << 32) - (1 << bits);
+#if !defined(CONFIG_EXT3_MANY_BLOCKS_SUPPORT)
+        if (res > (512LL << 32) - (1 << bits))
+                res = (512LL << 32) - (1 << bits);
+#endif
+
 	return res;
 }
 
diff -rup linux-2.6.7.orig/fs/Kconfig linux-2.6.7/fs/Kconfig
--- linux-2.6.7.orig/fs/Kconfig	2004-07-01 11:40:29.000000000 +0530
+++ linux-2.6.7/fs/Kconfig	2004-07-09 09:49:24.000000000 +0530
@@ -114,6 +114,26 @@ config EXT3_FS
 	  of your root partition (the one containing the directory /) cannot
 	  be compiled as a module, and so this may be dangerous.
 
+config EXT3_MANY_BLOCKS_SUPPORT
+	bool "Many Blocks Support (EXPERIMENTAL)"
+	depends on EXT3_FS && LBD
+	default n
+	help
+	  Ext3 filesystem currently has a limit of 2TB on i386. This 
+	  limitation comes from the fact that i_blocks in the on-disk
+	  inode can hold only 32-bit unsigned integers. 
+
+	  This experimental release extends this limit by using the 
+	  some unused/ unreserved fields in the inode. This feature 
+	  is compatible with existing EXT3 filesystem. However, if 
+	  you make files greater than the earlier imposed limits, 
+	  you would have to mount the partitions as read-only in 
+	  earlier kernels.
+
+	  If unsure say N.
+		
+
 config EXT3_FS_XATTR
 	bool "Ext3 extended attributes"
 	depends on EXT3_FS
diff -rup linux-2.6.7.orig/include/linux/ext3_fs.h linux-2.6.7/include/linux/ext3_fs.h
--- linux-2.6.7.orig/include/linux/ext3_fs.h	2004-07-01 11:26:55.000000000 +0530
+++ linux-2.6.7/include/linux/ext3_fs.h	2004-07-09 09:49:24.000000000 +0530
@@ -296,6 +296,11 @@ struct ext3_inode {
 
 #endif /* defined(__KERNEL__) || defined(__linux__) */
 
+#ifdef CONFIG_EXT3_MANY_BLOCKS_SUPPORT
+#define i_blocks_high		i_frag
+#define i_blocks_high1		i_fsize
+#endif
+
 /*
  * File system states
  */
@@ -505,6 +510,7 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT3_FEATURE_RO_COMPAT_MANY_BLOCKS	0x0008
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -518,6 +524,7 @@ static inline struct ext3_inode_info *EX
 					 EXT3_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
+					 EXT3_FEATURE_RO_COMPAT_MANY_BLOCKS| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
 
 /*
@@ -718,8 +725,8 @@ extern unsigned long ext3_count_free (st
 
 /* inode.c */
 extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
-extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, sector_t, int, int *);
+extern struct buffer_head * ext3_bread (handle_t *, struct inode *, sector_t, int, int *);
 
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
diff -rup linux-2.6.7.orig/include/linux/fs.h linux-2.6.7/include/linux/fs.h
--- linux-2.6.7.orig/include/linux/fs.h	2004-07-01 11:40:45.000000000 +0530
+++ linux-2.6.7/include/linux/fs.h	2004-07-09 09:49:24.000000000 +0530
@@ -426,7 +426,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	unsigned long		i_blocks;
+	sector_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;

