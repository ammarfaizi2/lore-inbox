Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWDMHIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWDMHIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWDMHIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:08:19 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:47103 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964808AbWDMHIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:08:17 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][10/21]ext3 enlarge blocksize
Message-Id: <20060413160739sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:07:38 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [10/21] enlarge block size(ext3)
          - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
            which indicates that the filesystem is extended.

          - Allow block size till pagesize in ext3.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/fs/ext3/super.c linux-2.6.17-rc1.tmp/fs/ext3/super.c
--- linux-2.6.17-rc1.org/fs/ext3/super.c	2006-04-06 10:59:04.000000000 +0900
+++ linux-2.6.17-rc1.tmp/fs/ext3/super.c	2006-04-06 11:05:39.000000000 +0900
@@ -1463,12 +1463,22 @@ static int ext3_fill_super (struct super
 	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
 
-	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
-	    blocksize > EXT3_MAX_BLOCK_SIZE) {
-		printk(KERN_ERR 
-		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
-		       blocksize, sb->s_id);
-		goto failed_mount;
+	if (EXT3_HAS_INCOMPAT_FEATURE(sb,
+	    EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+		if (blocksize < EXT3_MIN_BLOCK_SIZE ||
+		    blocksize > PAGE_SIZE ||
+		    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {
+			printk(KERN_ERR "EXT3-fs: Unsupported extended filesystem blocksize %d on %s.\n",
+				blocksize, sb->s_id);
+			goto failed_mount;
+		}
+	} else {
+		if (blocksize < EXT3_MIN_BLOCK_SIZE ||
+		    blocksize > EXT3_MAX_BLOCK_SIZE) {
+			printk(KERN_ERR "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
+				blocksize, sb->s_id);
+			goto failed_mount;
+		}
 	}
 
 	hblock = bdev_hardsect_size(sb->s_bdev);
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/include/linux/ext2_fs.h linux-2.6.17-rc1.tmp/include/linux/ext2_fs.h
--- linux-2.6.17-rc1.org/include/linux/ext2_fs.h	2006-04-06 10:59:05.000000000 +0900
+++ linux-2.6.17-rc1.tmp/include/linux/ext2_fs.h	2006-04-06 11:07:13.000000000 +0900
@@ -91,6 +91,7 @@ static inline struct ext2_sb_info *EXT2_
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
+#define        EXT2_EXTENDED_MAX_BLOCK_SIZE    65536
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
@@ -471,11 +472,13 @@ struct ext2_super_block {
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
+#define EXT2_FEATURE_INCOMPAT_LARGE_BLOCK      0x0080
 #define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT2_FEATURE_INCOMPAT_META_BG)
+					 EXT2_FEATURE_INCOMPAT_META_BG| \
+					 EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
diff -upNr -X linux-2.6.17-rc1.org/Documentation/dontdiff linux-2.6.17-rc1.org/include/linux/ext3_fs.h linux-2.6.17-rc1.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc1.org/include/linux/ext3_fs.h	2006-04-06 10:59:05.000000000 +0900
+++ linux-2.6.17-rc1.tmp/include/linux/ext3_fs.h	2006-04-06 11:08:16.000000000 +0900
@@ -86,6 +86,7 @@ struct statfs;
  */
 #define EXT3_MIN_BLOCK_SIZE		1024
 #define	EXT3_MAX_BLOCK_SIZE		4096
+#define        EXT3_EXTENDED_MAX_BLOCK_SIZE    65536
 #define EXT3_MIN_BLOCK_LOG_SIZE		  10
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)
@@ -563,11 +564,13 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
+#define EXT3_FEATURE_INCOMPAT_LARGE_BLOCK      0x0080
 
 #define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER| \
-					 EXT3_FEATURE_INCOMPAT_META_BG)
+					 EXT3_FEATURE_INCOMPAT_META_BG| \
+					 EXT3_FEATURE_INCOMPAT_LARGE_BLOCK)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
