Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVCPWzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVCPWzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVCPWzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:55:31 -0500
Received: from mail.dif.dk ([193.138.115.101]:28544 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262844AbVCPWyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:54:43 -0500
Date: Wed, 16 Mar 2005 23:56:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Eric Youngdale <eric@andante.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/2] isofs: kfree handles NULL pointers fine (inode.c)
Message-ID: <Pine.LNX.4.62.0503162354210.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() has no trouble being handed a NULL pointer, so checking for one
before calling it is redundant. This patch removes the redundant checks in
fs/isofs/inode.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/fs/isofs/inode.c linux-2.6.11-mm4/fs/isofs/inode.c
--- linux-2.6.11-mm4-orig/fs/isofs/inode.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.11-mm4/fs/isofs/inode.c	2005-03-16 23:46:35.000000000 +0100
@@ -863,8 +863,7 @@ root_found:
 	if (opt.check == 'r') table++;
 	s->s_root->d_op = &isofs_dentry_ops[table];
 
-	if (opt.iocharset)
-		kfree(opt.iocharset);
+	kfree(opt.iocharset);
 
 	return 0;
 
@@ -903,8 +902,7 @@ out_unknown_format:
 out_freebh:
 	brelse(bh);
 out_freesbi:
-	if (opt.iocharset)
-		kfree(opt.iocharset);
+	kfree(opt.iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return -EINVAL;
@@ -1163,8 +1161,7 @@ static int isofs_read_level3_size(struct
 			goto out_toomany;
 	} while(more_entries);
 out:
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	if (bh)
 		brelse(bh);
 	return 0;
@@ -1176,8 +1173,7 @@ out_nomem:
 
 out_noread:
 	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	return -EIO;
 
 out_toomany:
@@ -1346,8 +1342,7 @@ static void isofs_read_inode(struct inod
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 
  out:
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	if (bh)
 		brelse(bh);
 	return;


