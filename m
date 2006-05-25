Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWEYMtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWEYMtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWEYMtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:49:12 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:31182 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965150AbWEYMtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:49:10 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][12/24]ext3 enlarge blocksize
Message-Id: <20060525214902sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:49:02 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [12/24] enlarge block size(ext3)
          - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
            which indicates that the filesystem is extended.

          - Allow block size till pagesize in ext3.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/super.c linux-2.6.17-rc4.tmp/fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c	2006-05-25 16:33:29.710682647 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/super.c	2006-05-25 16:33:52.245838621 +0900
@@ -1463,11 +1463,17 @@ static int ext3_fill_super (struct super
 	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
 
+	if (blocksize > PAGE_SIZE) {
+		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
+		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
+		       blocksize, PAGE_SIZE, sb->s_id);
+		goto failed_mount;
+	}
+
 	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
-	    blocksize > EXT3_MAX_BLOCK_SIZE) {
-		printk(KERN_ERR 
-		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
-		       blocksize, sb->s_id);
+	    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {
+		printk(KERN_ERR "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
+				 blocksize, sb->s_id);
 		goto failed_mount;
 	}
 
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext2_fs.h linux-2.6.17-rc4.tmp/include/linux/ext2_fs.h
--- linux-2.6.17-rc4/include/linux/ext2_fs.h	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext2_fs.h	2006-05-25 16:33:52.246815183 +0900
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
+#define EXT2_FEATURE_INCOMPAT_HUGE_FS		0x0080
 #define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT2_FEATURE_INCOMPAT_META_BG)
+					 EXT2_FEATURE_INCOMPAT_META_BG| \
+					 EXT2_FEATURE_INCOMPAT_HUGE_FS)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:33:29.711659209 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:33:52.247791746 +0900
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
+#define EXT3_FEATURE_INCOMPAT_HUGE_FS		0x0080
 
 #define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER| \
-					 EXT3_FEATURE_INCOMPAT_META_BG)
+					 EXT3_FEATURE_INCOMPAT_META_BG| \
+					 EXT3_FEATURE_INCOMPAT_HUGE_FS)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)



