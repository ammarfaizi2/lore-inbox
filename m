Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVCYWRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVCYWRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVCYWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:17:28 -0500
Received: from mail.dif.dk ([193.138.115.101]:61623 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261838AbVCYWNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:13:46 -0500
Date: Fri, 25 Mar 2005 23:15:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of NULL pointer checks we don't need before kfree
 in fs/hpfs/
Message-ID: <Pine.LNX.4.62.0503252313190.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no need to check for NULL before calling kfree().

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/hpfs/dnode.c	2005-03-21 23:12:40.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/hpfs/dnode.c	2005-03-25 22:44:39.000000000 +0100
@@ -244,12 +244,12 @@ static int hpfs_add_to_dnode(struct inod
 	go_up:
 	if (namelen >= 256) {
 		hpfs_error(i->i_sb, "hpfs_add_to_dnode: namelen == %d", namelen);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) {
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
@@ -257,7 +257,7 @@ static int hpfs_add_to_dnode(struct inod
 	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
-			if (nd) kfree(nd);
+			kfree(nd);
 			kfree(nname);
 			return 1;
 		}
@@ -270,7 +270,7 @@ static int hpfs_add_to_dnode(struct inod
 		for_all_poss(i, hpfs_pos_subst, 5, t + 1);
 		hpfs_mark_4buffers_dirty(&qbh);
 		hpfs_brelse4(&qbh);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 0;
 	}
--- linux-2.6.12-rc1-mm3-orig/fs/hpfs/super.c	2005-03-21 23:12:40.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/hpfs/super.c	2005-03-25 22:45:43.000000000 +0100
@@ -75,7 +75,7 @@ void hpfs_error(struct super_block *s, c
 		} else if (s->s_flags & MS_RDONLY) printk("; going on - but anything won't be destroyed because it's read-only\n");
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
-	if (buf) kfree(buf);
+	kfree(buf);
 	hpfs_sb(s)->sb_was_error = 1;
 }
 
@@ -102,8 +102,8 @@ int hpfs_stop_cycles(struct super_block 
 static void hpfs_put_super(struct super_block *s)
 {
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
-	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
-	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
+	kfree(sbi->sb_cp_table);
+	kfree(sbi->sb_bmp_dir);
 	unmark_dirty(s);
 	s->s_fs_info = NULL;
 	kfree(sbi);
@@ -654,8 +654,8 @@ bail3:	brelse(bh1);
 bail2:	brelse(bh0);
 bail1:
 bail0:
-	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
-	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
+	kfree(sbi->sb_bmp_dir);
+	kfree(sbi->sb_cp_table);
 	s->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;


