Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUGGDui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUGGDui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 23:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUGGDui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 23:50:38 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:44702 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S264880AbUGGDt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 23:49:59 -0400
Subject: [PATCH] Pushing file size limits to 4TB on ext3
Date: Wed, 7 Jul 2004 09:18:39 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <33BC33A9E76474479B76AD0DE8A169728DAF@exch-ntd.nec.noida.hcltech.com>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Pushing file size limits to 4TB on ext3
Thread-Index: AcRj1UngJFoBnVcNQa2uVq4/UHEtwQ==
From: "Goldwyn Rodrigues" <Goldwynr@noida.hcltech.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Cc: <adilger@clusterfs.com>, <jbglaw@liug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is to break the 2TB limit of the file size limit.

Though developed on i386, This patch may be benefeciary for ia64 systems as well.

Current Limit: 
The current limit of the file size is 2TB. this is from the fact that i_blocks, which holds the number of 512-byte blocks, is __u32. This is checked by ext3_max_size().

New Limits after Patch:
I have used a reserved field l_i_reserved1 of struct ext3_inode to store higher order 32 bits. Though this will not matter for Linux filesystems, this field maps to h_i_translator, which is used in HURD. 


Working of Patch:
Currently the file size limit is imposed by the number of 512-byte blocks maintained in the inode. The variable i_blocks is currently a 32 bit unsigned integer field. This limits the number of blocks it can store to 2^32-1, which keeps the file size limit below 2TB.

In order to use more number of blocks. I have used a reserved field, namely l_i_reserved1 to keep the higher order bits.

An RO_COMPAT flag has been added in order to protect the filesystem/file being corrupted (read as truncated) by previous versions of ext3 filesystems.

There is a change in fs.h in the inode structure which I think should be incorporated, regardless of this patch. The change suggests conversion of the data type i_blocks from long to sector_t.

The patch is applicable for Kernel version 2.6.7

Limitation of Patch:
Cannot be used with HURD since l_i_reserved maps to h_i_translator for HURD.

Andreas suggested fields which deal with fragments could be used as they are not used by anyone. However, I did not get any response from anyone on whether those fields are being used. I did find the reference in the code, which ahs been used only for reading and writing inodes to disk. However, in order to change it to another 32-bit variable, #define i_blocks_high could be "redefined".

Moreover, file operations on huge files would be expensive because of the triple indirect addressing. eg, unlink() would take time.

Work Under progress (RFC):
Alex is worrking on adding extents to ext3 filesystems. I am going through Alex's extents code on ext3, which uses a faster method of accessing files, and is not limited to the inode structures addressing. Probably this can be merged used in the same patch of using extents.

As I mentioned before, I have also developed a patch to make 8TB files. I have done this by adding another triple indirect field. But accessing such a file would be expensive because of heavy triple indirection. Comments on this would be appreciated.


Thanks,

-- 
Goldwyn :o)


diff -Nrup linux-2.6.7/fs/ext3/inode.c linux-2.6.7-4TB/fs/ext3/inode.c
--- linux-2.6.7/fs/ext3/inode.c	2004-07-01 11:40:30.000000000 +0530
+++ linux-2.6.7-4TB/fs/ext3/inode.c	2004-07-02 18:19:36.000000000 +0530
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
 
@@ -2526,6 +2526,10 @@ void ext3_read_inode(struct inode * inod
 					 * (for stat), not the fs block
 					 * size */  
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+#ifdef CONFIG_EXT3_4TB_FILE_SUPPORT
+	inode->i_blocks |= ((__u64)le32_to_cpu(raw_inode->i_blocks_high)) << 32;
+#endif
+
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
@@ -2552,6 +2556,7 @@ void ext3_read_inode(struct inode * inod
 	 */
 	for (block = 0; block < EXT3_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
+	
 	INIT_LIST_HEAD(&ei->i_orphan);
 
 	if (S_ISREG(inode->i_mode)) {
@@ -2638,6 +2643,11 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+#ifdef EXT3_4TB_FILE_SUPPORT
+	raw_inode->i_blocks_high = cpu_to_le32(inode->i_blocks >> 32);
+#endif
+
+
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 #ifdef EXT3_FRAGMENTS
@@ -2651,7 +2661,29 @@ static int ext3_do_update_inode(handle_t
 	} else {
 		raw_inode->i_size_high =
 			cpu_to_le32(ei->i_disksize >> 32);
-		if (ei->i_disksize > 0x7fffffffULL) {
+		
+		if (ei->i_disksize > 0x1ffffffffffULL) {
+			struct super_block *sb = inode->i_sb;
+			if (!EXT3_HAS_RO_COMPAT_FEATURE(sb, EXT3_FEATURE_RO_COMPAT_4TB_FILE) || EXT3_SB(sb)->s_es->s_rev_level == cpu_to_le32(EXT3_GOOD_OLD_REV)) {
+				/* If this is the first large file
+				 * created, add a flag to the superblock.
+				 */
+				err = ext3_journal_get_write_access(handle,
+						EXT3_SB(sb)->s_sbh);
+				if (err)
+					goto out_brelse;
+				ext3_update_dynamic_rev(sb);
+				
+				if (!EXT3_HAS_RO_COMPAT_FEATURE(sb, 
+							EXT3_FEATURE_RO_COMPAT_LARGE_FILE))
+					EXT3_SET_RO_COMPAT_FEATURE(sb, 
+							EXT3_FEATURE_RO_COMPAT_LARGE_FILE);				
+				EXT3_SET_RO_COMPAT_FEATURE(sb, EXT3_FEATURE_RO_COMPAT_4TB_FILE);
+				sb->s_dirt = 1;
+				handle->h_sync = 1;
+				err = ext3_journal_dirty_metadata(handle,EXT3_SB(sb)->s_sbh);
+			} 
+		} else if (ei->i_disksize > 0x7fffffffULL) {
 			struct super_block *sb = inode->i_sb;
 			if (!EXT3_HAS_RO_COMPAT_FEATURE(sb,
 					EXT3_FEATURE_RO_COMPAT_LARGE_FILE) ||
diff -Nrup linux-2.6.7/fs/ext3/super.c linux-2.6.7-4TB/fs/ext3/super.c
--- linux-2.6.7/fs/ext3/super.c	2004-07-01 11:40:30.000000000 +0530
+++ linux-2.6.7-4TB/fs/ext3/super.c	2004-07-04 16:27:10.258452128 +0530
@@ -1172,8 +1172,8 @@ static loff_t ext3_max_size(int bits)
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
 	res <<= bits;
-	if (res > (512LL << 32) - (1 << bits))
-		res = (512LL << 32) - (1 << bits);
+        if (res > (1024LL << 32) - (1 << bits))
+                res = (1024LL << 32) - (1 << bits);
 	return res;
 }
 
diff -Nrup linux-2.6.7/fs/Kconfig linux-2.6.7-4TB/fs/Kconfig
--- linux-2.6.7/fs/Kconfig	2004-07-01 11:40:29.000000000 +0530
+++ linux-2.6.7-4TB/fs/Kconfig	2004-07-02 18:19:36.000000000 +0530
@@ -114,6 +114,21 @@ config EXT3_FS
 	  of your root partition (the one containing the directory /) cannot
 	  be compiled as a module, and so this may be dangerous.
 
+config EXT3_LARGE_FILE_SUPPORT
+	bool "Large File (>2TB) Support (EXPERIMENTAL)"
+	depends on EXT3_FS
+	depends on LBD
+	default n
+	help
+	  Ext3 filesystem currently has a limit of 2TB. This experimental
+	  release extends this limit to 8TB by using the reserved fields
+	  in the inode. Thus, this feature can be used under Linux only.
+	  This feature is compatible with existing EXT3 filesystem.
+
+	  If unsure say N.
+		
+
+
 config EXT3_FS_XATTR
 	bool "Ext3 extended attributes"
 	depends on EXT3_FS
diff -Nrup linux-2.6.7/include/linux/ext3_fs.h linux-2.6.7-4TB/include/linux/ext3_fs.h
--- linux-2.6.7/include/linux/ext3_fs.h	2004-07-01 11:26:55.000000000 +0530
+++ linux-2.6.7-4TB/include/linux/ext3_fs.h	2004-07-02 18:19:36.000000000 +0530
@@ -278,6 +278,10 @@ struct ext3_inode {
 #define i_gid_high	osd2.linux2.l_i_gid_high
 #define i_reserved2	osd2.linux2.l_i_reserved2
 
+#ifdef CONFIG_EXT3_4TB_FILE_SUPPORT
+#define i_blocks_high		osd1.linux1.l_i_reserved1
+#endif
+
 #elif defined(__GNU__)
 
 #define i_translator	osd1.hurd1.h_i_translator
@@ -505,6 +509,7 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT3_FEATURE_RO_COMPAT_4TB_FILE		0x0008
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -518,6 +523,7 @@ static inline struct ext3_inode_info *EX
 					 EXT3_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
+					 EXT3_FEATURE_RO_COMPAT_4TB_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
 
 /*
@@ -718,8 +724,8 @@ extern unsigned long ext3_count_free (st
 
 /* inode.c */
 extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
-extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, sector_t, int, int *);
+extern struct buffer_head * ext3_bread (handle_t *, struct inode *, sector_t, int, int *);
 
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
diff -Nrup linux-2.6.7/include/linux/fs.h linux-2.6.7-4TB/include/linux/fs.h
--- linux-2.6.7/include/linux/fs.h	2004-07-01 11:40:45.000000000 +0530
+++ linux-2.6.7-4TB/include/linux/fs.h	2004-07-02 18:19:36.000000000 +0530
@@ -426,7 +426,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	unsigned long		i_blocks;
+	sector_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;




