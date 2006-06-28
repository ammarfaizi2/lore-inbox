Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423293AbWF1L4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423293AbWF1L4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423294AbWF1L4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:56:00 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:178 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1423293AbWF1Lz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:55:59 -0400
To: cmm@us.ibm.com, johann.lombardi@bull.net, adilger@clusterfs.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] ext2: fix rec_len overflow
Message-Id: <20060628205551sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 28 Jun 2006 20:55:51 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch limits ext2_dir_entry_2->rec_len to 65532 to prevent from
overflow with 64KB blocksize.


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc6/Documentation/dontdiff linux-2.6.17-rc6/fs/ext2/dir.c linux-2.6.17-rc6.tmp/fs/ext2/dir.c
--- linux-2.6.17-rc6/fs/ext2/dir.c	2006-06-27 09:05:11.000000000 +0900
+++ linux-2.6.17-rc6.tmp/fs/ext2/dir.c	2006-06-27 09:05:35.000000000 +0900
@@ -461,13 +461,21 @@ int ext2_add_link (struct dentry *dentry
 		kaddr = page_address(page);
 		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
+		if (chunk_size < EXT2_RECLEN_MAX  )
+			kaddr += PAGE_CACHE_SIZE - reclen;
+		else
+			kaddr += EXT2_RECLEN_MAX - reclen;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
 				name_len = 0;
-				rec_len = chunk_size;
-				de->rec_len = cpu_to_le16(chunk_size);
+				if (chunk_size < EXT2_RECLEN_MAX) {
+					rec_len = chunk_size;
+					de->rec_len = cpu_to_le16(chunk_size);
+				} else {
+					rec_len = EXT2_RECLEN_MAX;
+					de->rec_len = cpu_to_le16(EXT2_RECLEN_MAX);
+				}
 				de->inode = 0;
 				goto got_it;
 			}
diff -upNr -X linux-2.6.17-rc6/Documentation/dontdiff linux-2.6.17-rc6/include/linux/ext2_fs.h linux-2.6.17-rc6.tmp/include/linux/ext2_fs.h
--- linux-2.6.17-rc6/include/linux/ext2_fs.h	2006-06-27 09:05:15.000000000 +0900
+++ linux-2.6.17-rc6.tmp/include/linux/ext2_fs.h	2006-06-27 08:49:16.000000000 +0900
@@ -87,11 +87,16 @@ static inline struct ext2_sb_info *EXT2_
 #define EXT2_LINK_MAX		32000
 
 /*
+ * Maximal size of directory entry record length
+ */
+#define EXT2_RECLEN_MAX		65532
+
+/*
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
-#define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT2_MAX_BLOCK_SIZE		65636
+#define EXT2_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else


Cheers, sho


