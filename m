Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWHVKAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWHVKAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWHVKAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:00:09 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47008 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751108AbWHVKAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:00:07 -0400
Date: Tue, 22 Aug 2006 11:59:46 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200608220959.k7M9xkn19293@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: fix for minix crash
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting a (corrupt) minix filesystem with zero s_zmap_blocks
gives a spectacular crash on my 2.6.17.8 system, no doubt
because minix/inode.c does an unconditional
	minix_set_bit(0,sbi->s_zmap[0]->b_data);
Here a fix (against 2.6.17.8).

Andries

diff -uprN -X /linux/dontdiff a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	2006-08-07 16:01:12.000000000 +0200
+++ b/fs/minix/inode.c	2006-08-22 11:15:53.000000000 +0200
@@ -204,6 +204,8 @@ static int minix_fill_super(struct super
 	/*
 	 * Allocate the buffer map to keep the superblock small.
 	 */
+	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
+		goto out_illegal_sb;
 	i = (sbi->s_imap_blocks + sbi->s_zmap_blocks) * sizeof(bh);
 	map = kmalloc(i, GFP_KERNEL);
 	if (!map)
@@ -276,6 +278,11 @@ out_no_map:
 		printk("MINIX-fs: can't allocate map\n");
 	goto out_release;
 
+out_illegal_sb:
+	if (!silent)
+		printk("MINIX-fs: bad superblock\n");
+	goto out_release;
+
 out_no_fs:
 	if (!silent)
 		printk("VFS: Can't find a Minix or Minix V2 filesystem "
