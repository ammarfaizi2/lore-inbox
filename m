Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbUDFLZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbUDFLZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:25:44 -0400
Received: from p8077-ipadfx21hodogaya.kanagawa.ocn.ne.jp ([219.160.161.77]:5506
	"HELO achurch.org") by vger.kernel.org with SMTP id S263765AbUDFLZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:25:39 -0400
From: achurch@achurch.org (Andrew Church)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2fs sb= mount option fix (kernel 2.4.25)
Date: Tue, 06 Apr 2004 20:21:08 JST
X-Mailer: MMail v5.17
Message-ID: <407293b0.24174@achurch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     The following patch fixes a bug in the processing of the sb=
(alternate superblock) mount option for ext2: for devices with 1024-byte
blocks, the value from the option is never actually used.  This patch is
for kernel 2.4.25.  2.6.5 also has an issue with sb=, and I'll send a patch
for that separately.

  --Andrew Church
    achurch@achurch.org
    http://achurch.org/

---------------------------------------------------------------------------

--- linux-2.4.25-orig/fs/ext2/super.c	Wed Feb 18 22:36:31 2004
+++ fs/ext2/super.c	Mon Apr  5 09:23:19 2004
@@ -427,7 +427,7 @@
 	unsigned short resuid = EXT2_DEF_RESUID;
 	unsigned short resgid = EXT2_DEF_RESGID;
 	unsigned long block;
-	unsigned long logic_sb_block = 1;
+	unsigned long logic_sb_block;
 	unsigned long offset = 0;
 	kdev_t dev = sb->s_dev;
 	int blocksize = BLOCK_SIZE;
@@ -465,6 +465,8 @@
 	if (blocksize != BLOCK_SIZE) {
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
 		offset = (sb_block*BLOCK_SIZE) % blocksize;
+	} else {
+		logic_sb_block = sb_block;
 	}
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
