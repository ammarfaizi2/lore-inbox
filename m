Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWARNGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWARNGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWARNGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:06:37 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:34032 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932522AbWARNGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:06:36 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <ext2-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext3: Extends blocksize up to pagesize
Date: Wed, 18 Jan 2006 22:06:26 +0900
Message-ID: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a disk tends to get large, a disk storage has had a capacity to
supply multi-TB.  But now, ext3 can't support more than 8TB filesystem
when blocksize is 4KB.  That's why I think ext3 needs to be
more than 8TB.

Therefore I think filesystem size can increase on architectures
which has more than 4KB pagesize by extending blocksize to pagesize on
ext3.  For example, the following is in case of ia64.  (Blocksize have
already been supported up to pagesize on ext2. Why is the max blocksize
restricted to 4KB on ext3?)

Max filesystem size on ia64:
Original                                   :4096(blocksize) * 2^31 =  8TB
After modification [pagesize=16KB(default)]:16384(blocksize) * 2^31 = 32TB
After modification [pagesize=64KB(max)]    :65536(blocksize) * 2^31 = 128TB

The followings are the contents of modification.
- ext3_fill_super
  In checking blocksize on mount, allow blocksize up to pagesize.

- ext3_readdir
  Currently read-ahead 16 sectors when reading a directory, but not
  if blocksize is more than 8KB.  Then I modified to read-ahead
  one fs-block if blocksize is more than 8KB.

Any feedback and comments are welcome.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
---

diff -uprN -X linux-2.6.16-rc1.org/Documentation/dontdiff linux-2.6.16-rc1.org/fs/ext3/dir.c linux-2.6.16-rc1-bigblk/fs/ext3/dir.c
--- linux-2.6.16-rc1.org/fs/ext3/dir.c	2006-01-18 08:10:26.000000000 +0900
+++ linux-2.6.16-rc1-bigblk/fs/ext3/dir.c	2006-01-18 08:12:05.000000000 +0900
@@ -142,7 +142,13 @@ static int ext3_readdir(struct file * fi
 		 * Do the readahead
 		 */
 		if (!offset) {
-			for (i = 16 >> (EXT3_BLOCK_SIZE_BITS(sb) - 9), num = 0;
+			int readcnt;
+			if (sb->s_blocksize > 8192) {
+				readcnt = sb->s_blocksize >> EXT3_SECTOR_BITS;
+			} else {
+				readcnt = 16;
+			}
+			for (i = readcnt >> (EXT3_BLOCK_SIZE_BITS(sb) - 9), num = 0;
 			     i > 0; i--) {
 				tmp = ext3_getblk (NULL, inode, ++blk, 0, &err);
 				if (tmp && !buffer_uptodate(tmp) &&
diff -uprN -X linux-2.6.16-rc1.org/Documentation/dontdiff linux-2.6.16-rc1.org/fs/ext3/super.c
linux-2.6.16-rc1-bigblk/fs/ext3/super.c
--- linux-2.6.16-rc1.org/fs/ext3/super.c	2006-01-18 08:10:26.000000000 +0900
+++ linux-2.6.16-rc1-bigblk/fs/ext3/super.c	2006-01-18 08:12:05.000000000 +0900
@@ -1461,6 +1461,7 @@ static int ext3_fill_super (struct super
 	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);

 	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
+	    blocksize > PAGE_SIZE ||
 	    blocksize > EXT3_MAX_BLOCK_SIZE) {
 		printk(KERN_ERR
 		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
diff -uprN -X linux-2.6.16-rc1.org/Documentation/dontdiff linux-2.6.16-rc1.org/include/linux/ext2_fs.h
linux-2.6.16-rc1-bigblk/include/linux/ext2_fs.h
--- linux-2.6.16-rc1.org/include/linux/ext2_fs.h	2006-01-18 08:10:56.000000000 +0900
+++ linux-2.6.16-rc1-bigblk/include/linux/ext2_fs.h	2006-01-18 08:12:05.000000000 +0900
@@ -90,7 +90,7 @@ static inline struct ext2_sb_info *EXT2_
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
+#define	EXT2_MAX_BLOCK_SIZE		65536
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
diff -uprN -X linux-2.6.16-rc1.org/Documentation/dontdiff linux-2.6.16-rc1.org/include/linux/ext3_fs.h
linux-2.6.16-rc1-bigblk/include/linux/ext3_fs.h
--- linux-2.6.16-rc1.org/include/linux/ext3_fs.h	2006-01-18 08:10:53.000000000 +0900
+++ linux-2.6.16-rc1-bigblk/include/linux/ext3_fs.h	2006-01-18 20:13:36.309026768 +0900
@@ -84,7 +84,7 @@ struct statfs;
  * Macro-instructions used to manage several block sizes
  */
 #define EXT3_MIN_BLOCK_SIZE		1024
-#define	EXT3_MAX_BLOCK_SIZE		4096
+#define	EXT3_MAX_BLOCK_SIZE		65536
 #define EXT3_MIN_BLOCK_LOG_SIZE		  10
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)
@@ -97,6 +97,7 @@ struct statfs;
 #else
 # define EXT3_BLOCK_SIZE_BITS(s)	((s)->s_log_block_size + 10)
 #endif
+#define EXT3_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */
 #ifdef __KERNEL__
 #define	EXT3_ADDR_PER_BLOCK_BITS(s)	(EXT3_SB(s)->s_addr_per_block_bits)
 #define EXT3_INODE_SIZE(s)		(EXT3_SB(s)->s_inode_size)


