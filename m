Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUEMSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUEMSee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUEMSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:33:27 -0400
Received: from village.ehouse.ru ([193.111.92.18]:1552 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264392AbUEMScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:32:11 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs (1/5): LBD support
Date: Thu, 13 May 2004 22:32:09 +0400
User-Agent: KMail/1.6.1
Cc: Will Dyson <will_dyson@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132232.09816.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LBD patch merged long time ago, so it is safe to pass u64 block
numbers to sb_bread() when sector_t is large enough.

===== fs/befs/linuxvfs.c 1.17 vs edited =====
--- 1.17/fs/befs/linuxvfs.c	Thu Mar  4 18:03:10 2004
+++ edited/fs/befs/linuxvfs.c	Thu May 13 21:23:04 2004
@@ -856,6 +856,13 @@
 	if (befs_check_sb(sb) != BEFS_OK)
 		goto unaquire_priv_sbp;
 
+	if( befs_sb->num_blocks > ~((sector_t)0) ) {
+		befs_error(sb, "blocks count: %Lu "
+			"is larger than the host can use",
+			befs_sb->num_blocks);
+		goto unaquire_priv_sbp;
+	}
+
 	/*
 	 * set up enough so that it can read an inode
 	 * Fill in kernel superblock fields from private sb
===== fs/befs/befs.h 1.1 vs edited =====
--- 1.1/fs/befs/befs.h	Tue Oct 22 18:39:38 2002
+++ edited/fs/befs/befs.h	Thu May 13 21:22:53 2004
@@ -14,10 +14,7 @@
 #define BEFS_VERSION "0.9.3"
 
 
-/* Sector_t makes this sillyness obsolete */
 typedef u64 befs_blocknr_t;
-typedef u32 vfs_blocknr_t;
-
 /*
  * BeFS in memory structures
  */
===== fs/befs/io.c 1.1 vs edited =====
--- 1.1/fs/befs/io.c	Tue Oct 22 18:39:38 2002
+++ edited/fs/befs/io.c	Thu May 13 21:22:53 2004
@@ -28,7 +28,6 @@
 {
 	struct buffer_head *bh = NULL;
 	befs_blocknr_t block = 0;
-	vfs_blocknr_t vfs_block = 0;
 	befs_sb_info *befs_sb = BEFS_SB(sb);
 
 	befs_debug(sb, "---> Enter befs_read_iaddr() "
@@ -42,17 +41,10 @@
 	}
 
 	block = iaddr2blockno(sb, &iaddr);
-	vfs_block = (vfs_blocknr_t) block;
-
-	if (vfs_block != block) {
-		befs_error(sb, "Error converting to host blocknr_t. %Lu "
-			   "is larger than the host can use", block);
-		goto error;
-	}
 
 	befs_debug(sb, "befs_read_iaddr: offset = %lu", block);
 
-	bh = sb_bread(sb, vfs_block);
+	bh = sb_bread(sb, block);
 
 	if (bh == NULL) {
 		befs_error(sb, "Failed to read block %lu", block);
@@ -71,20 +63,13 @@
 befs_bread(struct super_block *sb, befs_blocknr_t block)
 {
 	struct buffer_head *bh = NULL;
-	vfs_blocknr_t vfs_block = (vfs_blocknr_t) block;
 
 	befs_debug(sb, "---> Enter befs_read() %Lu", block);
 
-	if (vfs_block != block) {
-		befs_error(sb, "Error converting to host blocknr_t. %Lu "
-			   "is larger than the host can use", block);
-		goto error;
-	}
-
-	bh = sb_bread(sb, vfs_block);
+	bh = sb_bread(sb, block);
 
 	if (bh == NULL) {
-		befs_error(sb, "Failed to read block %lu", vfs_block);
+		befs_error(sb, "Failed to read block %lu", block);
 		goto error;
 	}
 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

