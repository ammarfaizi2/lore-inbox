Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWGGLxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWGGLxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWGGLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:53:49 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:34464 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932133AbWGGLxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:53:48 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, johann.lombardi@bull.net
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][PATCH 2/2] ext2: enlarge blocksize and fix rec_lenoverflow
Message-Id: <20060707205334sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 7 Jul 2006 20:53:34 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [2/2]  ext2: fix rec_len overflow
          - prevent rec_len from overflow with 64KB blocksize

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -Nupr -X linux-2.6.17-git13-Mingming/Documentation/dontdiff linux-2.6.17-git13-Mingming/fs/ext2/dir.c linux-2.6.17-git13-Mingming-reclen/fs/ext2/dir.c
--- linux-2.6.17-git13-Mingming/fs/ext2/dir.c	2006-07-07 17:24:11.000000000 +0900
+++ linux-2.6.17-git13-Mingming-reclen/fs/ext2/dir.c	2006-07-07 17:03:42.000000000 +0900
@@ -459,14 +459,23 @@ int ext2_add_link (struct dentry *dentry
 		kaddr = page_address(page);
 		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
+		if (chunk_size < EXT2_DIR_MAX_REC_LEN) 
+			kaddr += PAGE_CACHE_SIZE - reclen;
+		else 
+			kaddr += EXT2_DIR_MAX_REC_LEN - reclen;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
 				name_len = 0;
-				rec_len = chunk_size;
-				de->rec_len = cpu_to_le16(chunk_size);
 				de->inode = 0;
+				if (chunk_size  < EXT2_DIR_MAX_REC_LEN) {
+					rec_len = chunk_size;
+					de->rec_len = cpu_to_le16(chunk_size);
+				} else {
+					rec_len = EXT2_DIR_MAX_REC_LEN;
+					de->rec_len = 
+					cpu_to_le16(EXT2_DIR_MAX_REC_LEN);
+				}
 				goto got_it;
 			}
 			if (de->rec_len == 0) {
diff -Nupr -X linux-2.6.17-git13-Mingming/Documentation/dontdiff linux-2.6.17-git13-Mingming/include/linux/ext2_fs.h linux-2.6.17-git13-Mingming-reclen/include/linux/ext2_fs.h
--- linux-2.6.17-git13-Mingming/include/linux/ext2_fs.h	2006-07-07 17:24:12.000000000 +0900
+++ linux-2.6.17-git13-Mingming-reclen/include/linux/ext2_fs.h	2006-07-07 14:43:34.000000000 +0900
@@ -90,8 +90,8 @@ static inline struct ext2_sb_info *EXT2_
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
-#define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT2_MAX_BLOCK_SIZE		65536
+#define EXT2_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else
@@ -553,5 +553,6 @@ enum {
 #define EXT2_DIR_ROUND 			(EXT2_DIR_PAD - 1)
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
+#define EXT2_DIR_MAX_REC_LEN		65532
 
 #endif	/* _LINUX_EXT2_FS_H */


Cheers sho
