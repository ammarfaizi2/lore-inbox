Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUKFXfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUKFXfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUKFXfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:35:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:53148 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261284AbUKFXe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:34:56 -0500
Date: Sun, 7 Nov 2004 00:34:42 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411062334.iA6NYg517315@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] minix_clear_inode fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes two flaws in minix_clear_inode.

The first is that it tests bh which is never initialized.
(&bh is a parameter of minix_V1_raw_inode, but that routine
can fail and return before it has set bh)

The second is that generic_delete_inode() goes BUG()
in case inode->i_state != I_CLEAR. Clearly, it is expected
that inode->i_sb->s_op->delete_inode does a clear_inode()
at some point. But minix_delete_inode() calls minix_free_inode()
and that routine can print an error and return early, before
calling clear_inode().

Andries


diff -uprN -X /linux/dontdiff a/fs/minix/bitmap.c b/fs/minix/bitmap.c
--- a/fs/minix/bitmap.c	2003-12-18 03:59:16.000000000 +0100
+++ b/fs/minix/bitmap.c	2004-11-06 17:40:47.000000000 +0100
@@ -160,7 +160,8 @@ minix_V2_raw_inode(struct super_block *s
 
 static void minix_clear_inode(struct inode *inode)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
+
 	if (INODE_VERSION(inode) == MINIX_V1) {
 		struct minix_inode *raw_inode;
 		raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
@@ -188,24 +189,26 @@ void minix_free_inode(struct inode * ino
 	struct buffer_head * bh;
 	unsigned long ino;
 
-	if (inode->i_ino < 1 || inode->i_ino > sbi->s_ninodes) {
-		printk("free_inode: inode 0 or nonexistent inode\n");
-		return;
-	}
 	ino = inode->i_ino;
+	if (ino < 1 || ino > sbi->s_ninodes) {
+		printk("minix_free_inode: inode 0 or nonexistent inode\n");
+		goto out;
+	}
 	if ((ino >> 13) >= sbi->s_imap_blocks) {
-		printk("free_inode: nonexistent imap in superblock\n");
-		return;
+		printk("minix_free_inode: nonexistent imap in superblock\n");
+		goto out;
 	}
 
+	minix_clear_inode(inode);	/* clear on-disk copy */
+
 	bh = sbi->s_imap[ino >> 13];
-	minix_clear_inode(inode);
-	clear_inode(inode);
 	lock_kernel();
 	if (!minix_test_and_clear_bit(ino & 8191, bh->b_data))
-		printk("free_inode: bit %lu already cleared.\n",ino);
+		printk("minix_free_inode: bit %lu already cleared.\n", ino);
 	unlock_kernel();
 	mark_buffer_dirty(bh);
+ out:
+	clear_inode(inode);		/* clear in-memory copy */
 }
 
 struct inode * minix_new_inode(const struct inode * dir, int * error)
