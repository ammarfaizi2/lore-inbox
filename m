Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVAVUQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVAVUQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVAVUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:16:54 -0500
Received: from [61.135.145.13] ([61.135.145.13]:3351 "EHLO websmtp216.sohu.com")
	by vger.kernel.org with ESMTP id S262732AbVAVUQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:16:43 -0500
Message-ID: <31531613.1106425001426.JavaMail.postfix@mx20.mail.sohu.com>
Date: Sun, 23 Jan 2005 04:16:41 +0800 (CST)
From: <stone_wang@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: [patch to 2.6.10-rc2] ext3_find_goal
Cc: <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 210.21.32.84
X-Priority: 3
X-SHMOBILE: 0
X-Sohu-Antivirus: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We found strange blocks layout in our mail server, after careful study,
we got the reason and tried to fix it.

When loading an inode from buffer/disk(ext2/3_read_inode),then allocating the second block(block==1) of the corresponding file: i_next_alloc_block and i_next_alloc_goal are both zero,and in fact are not valid,
but they(i_next_alloc_block/goal) take effect in the former codes. This causes non-contiguous file.

Below patch add a check,and fixes this.

Stone Wang.
2005.01.23

diff -urN linux-2.6.10-rc2/fs/ext2/inode.c linux-2.6.10-rc2-fixed/fs/ext2/inode.c
--- linux-2.6.10-rc2/fs/ext2/inode.c	2005-01-23 03:01:42.000000000 -0500
+++ linux-2.6.10-rc2-fixed/fs/ext2/inode.c	2005-01-23 02:57:41.000000000 -0500
@@ -354,7 +354,7 @@
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	write_lock(&ei->i_meta_lock);
-	if (block == ei->i_next_alloc_block + 1) {
+	if ((block == ei->i_next_alloc_block + 1)&& ei->i_next_alloc_goal) {
 		ei->i_next_alloc_block++;
 		ei->i_next_alloc_goal++;
 	} 
diff -urN linux-2.6.10-rc2/fs/ext3/inode.c linux-2.6.10-rc2-fixed/fs/ext3/inode.c
--- linux-2.6.10-rc2/fs/ext3/inode.c	2005-01-23 03:01:42.000000000 -0500
+++ linux-2.6.10-rc2-fixed/fs/ext3/inode.c	2005-01-23 02:08:58.000000000 -0500
@@ -464,7 +464,7 @@
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	/* Writer: ->i_next_alloc* */
-	if (block == ei->i_next_alloc_block + 1) {
+	if ((block == ei->i_next_alloc_block + 1)&& ei->i_next_alloc_goal) {
 		ei->i_next_alloc_block++;
 		ei->i_next_alloc_goal++;
 	}

