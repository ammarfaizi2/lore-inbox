Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbUDFLcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:31:24 -0400
Received: from p8077-ipadfx21hodogaya.kanagawa.ocn.ne.jp ([219.160.161.77]:7042
	"HELO achurch.org") by vger.kernel.org with SMTP id S263779AbUDFLao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:30:44 -0400
From: achurch@achurch.org (Andrew Church)
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] ext2fs sb= mount option fix (kernel 2.6.5)
Date: Tue, 06 Apr 2004 20:25:52 JST
X-Mailer: MMail v5.17
Message-ID: <407294e2.24215@achurch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     The following patch fixes a bug in the processing of the sb=
(alternate superblock) mount option for ext2: when changing the device
block size, the given superblock is ignored and the code reverts to using
block 1.  This patch is against kernel 2.6.5.

  --Andrew Church
    achurch@achurch.org
    http://achurch.org/

---------------------------------------------------------------------------

--- fs/ext2/super.c.old	Thu Mar 11 11:55:35 2004
+++ fs/ext2/super.c	Mon Apr  5 09:15:54 2004
@@ -564,8 +564,8 @@
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	struct inode *root;
-	unsigned long block, sb_block = 1;
-	unsigned long logic_sb_block = get_sb_block(&data);
+	unsigned long block, sb_block = get_sb_block(&data);
+	unsigned long logic_sb_block;
 	unsigned long offset = 0;
 	unsigned long def_mount_opts;
 	int blocksize = BLOCK_SIZE;
@@ -598,6 +598,8 @@
 	if (blocksize != BLOCK_SIZE) {
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
 		offset = (sb_block*BLOCK_SIZE) % blocksize;
+	} else {
+		logic_sb_block = sb_block;
 	}
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
