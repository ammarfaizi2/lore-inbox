Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUFYNET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUFYNET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUFYNET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:04:19 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:52300 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266196AbUFYNEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:04:07 -0400
Subject: [PATCH] Breaking ext2 file size limit of 2TB
Reply-To: goldwyn_r@myrealbox.com
From: "Goldwyn Rodrigues" <goldwyn_r@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jun 2004 18:34:06 +0530
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1088168646.d642871cgoldwyn_r@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have made a patch to enable file creation greater than 2TB. I tested it using sparse files and it works good.

Working:
The file size limit of the ext3 filesystem is limited to 2TB because of i_blocks, a variable which stores the number of 512 blocks in the inode. i_blocks is a 32 which limits the number it can hold. The patch makes use of l_i_reserved1 field to keep the higher order bits of i_blocks.

This has been developed and tested on kernel version 2.6.5 using sparse files.

Advantages: 
1. Patch is compatible with the existing filesystem and does not need re-formatting of the device.

Disadvantages: 

1. The patch uses l_i_reserved1 field to keep higher order 32-bits of i_blocks. This means the patch cannot be used with HURD filesystems, because it is occupied with a translator field.
2. Changes in fs.h, which is not really required.

I have also developed a patch to take the limits till 8TB, but there are lot of changes in that, including the memory copy of the inode structure. Moreover, it breaks with usual filesystems utils like fsck.

Feedback welcome.

Thanks,

-- 
Goldwyn :o)


diff -Nru linux-2.6.5-orig/fs/ext3/inode.c linux-2.6.5-4TB/fs/ext3/inode.c
--- linux-2.6.5-orig/fs/ext3/inode.c	2004-04-04 09:07:36.000000000 +0530
+++ linux-2.6.5-4TB/fs/ext3/inode.c	2004-06-23 12:30:41.000000000 +0530
@@ -355,7 +355,7 @@
  */
 
 static int ext3_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			sector_t i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -906,7 +906,7 @@
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext3_getblk(handle_t *handle, struct inode * inode,
-				long block, int create, int * errp)
+				sector_t block, int create, int * errp)
 {
 	struct buffer_head dummy;
 	int fatal = 0, err;
@@ -956,10 +956,10 @@
 }
 
 struct buffer_head *ext3_bread(handle_t *handle, struct inode * inode,
-			       int block, int create, int *err)
+			       sector_t block, int create, int *err)
 {
 	struct buffer_head * bh;
-	int prev_blocks;
+	sector_t prev_blocks;
 
 	prev_blocks = inode->i_blocks;
 
@@ -2126,7 +2126,7 @@
 	Indirect *partial;
 	int nr = 0;
 	int n;
-	long last_block;
+	sector_t last_block;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	struct page *page;
 
@@ -2516,6 +2516,8 @@
 					 * (for stat), not the fs block
 					 * size */  
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
+	inode->i_blocks |= ((__u64)le32_to_cpu(raw_inode->i_blocks_high)) << 32;
+
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
@@ -2542,6 +2544,7 @@
 	 */
 	for (block = 0; block < EXT3_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
+	
 	INIT_LIST_HEAD(&ei->i_orphan);
 
 	if (S_ISREG(inode->i_mode)) {
@@ -2628,6 +2631,9 @@
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	raw_inode->i_blocks_high = cpu_to_le32(inode->i_blocks >> 32);
+
+
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 #ifdef EXT3_FRAGMENTS
diff -Nru linux-2.6.5-orig/fs/ext3/super.c linux-2.6.5-4TB/fs/ext3/super.c
--- linux-2.6.5-orig/fs/ext3/super.c	2004-04-04 09:08:14.000000000 +0530
+++ linux-2.6.5-4TB/fs/ext3/super.c	2004-06-23 12:32:01.000000000 +0530
@@ -1003,9 +1003,9 @@
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
-	res <<= bits;
-	if (res > (512LL << 32) - (1 << bits))
-		res = (512LL << 32) - (1 << bits);
+	/* Since another block is added, we add the same number again */
+	res += 1LL << (3*(bits-2));
+	res <<=bits;
 	return res;
 }
 
diff -Nru linux-2.6.5-orig/fs/Kconfig linux-2.6.5-4TB/fs/Kconfig
--- linux-2.6.5-orig/fs/Kconfig	2004-04-04 09:07:23.000000000 +0530
+++ linux-2.6.5-4TB/fs/Kconfig	2004-06-23 12:19:00.000000000 +0530
@@ -114,6 +114,21 @@
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
diff -Nru linux-2.6.5-orig/include/linux/ext3_fs.h linux-2.6.5-4TB/include/linux/ext3_fs.h
--- linux-2.6.5-orig/include/linux/ext3_fs.h	2004-04-04 09:07:23.000000000 +0530
+++ linux-2.6.5-4TB/include/linux/ext3_fs.h	2004-06-23 12:35:26.000000000 +0530
@@ -278,6 +278,10 @@
 #define i_gid_high	osd2.linux2.l_i_gid_high
 #define i_reserved2	osd2.linux2.l_i_reserved2
 
+#ifdef CONFIG_EXT3_LARGE_FILE_SUPPORT
+#define i_blocks_high		osd1.linux1.l_i_reserved1
+#endif
+
 #elif defined(__GNU__)
 
 #define i_translator	osd1.hurd1.h_i_translator
@@ -718,8 +722,8 @@
 
 /* inode.c */
 extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
-extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, sector_t, int, int *);
+extern struct buffer_head * ext3_bread (handle_t *, struct inode *, sector_t, int, int *);
 
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
diff -Nru linux-2.6.5-orig/include/linux/fs.h linux-2.6.5-4TB/include/linux/fs.h
--- linux-2.6.5-orig/include/linux/fs.h	2004-04-04 09:06:52.000000000 +0530
+++ linux-2.6.5-4TB/include/linux/fs.h	2004-06-23 12:18:43.000000000 +0530
@@ -393,7 +393,11 @@
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
+#if !defined(CONFIG_EXT3_LARGE_FILE_SUPPORT) || defined(CONFIG_64BIT)
 	unsigned long		i_blocks;
+#else
+	unsigned long long	i_blocks;
+#endif /* CONFIG_EXT3_LARGE_FILE_SUPPORT */
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;


