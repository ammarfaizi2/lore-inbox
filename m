Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbRFKFft>; Mon, 11 Jun 2001 01:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFKFfo>; Mon, 11 Jun 2001 01:35:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263421AbRFKFf0>;
	Mon, 11 Jun 2001 01:35:26 -0400
Date: Mon, 11 Jun 2001 01:35:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (5/10)
In-Reply-To: <Pine.GSO.4.21.0106110134230.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110135010.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-put_super/fs/dquot.c S6-pre2-dquot/fs/dquot.c
--- S6-pre2-put_super/fs/dquot.c	Thu May 24 18:26:44 2001
+++ S6-pre2-dquot/fs/dquot.c	Sun Jun 10 18:46:54 2001
@@ -325,7 +325,7 @@
         memset(&dquot->dq_dqb, 0, sizeof(struct dqblk));
 }
 
-void invalidate_dquots(kdev_t dev, short type)
+static void invalidate_dquots(kdev_t dev, short type)
 {
 	struct dquot *dquot, *next;
 	int need_restart;
@@ -1388,7 +1388,7 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(kdev_t, short);
+extern void remove_dquot_ref(struct super_block *, short);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
@@ -1413,7 +1413,7 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb->s_dev, cnt);
+		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb->s_dev, cnt);
 
 		/* Wait for any pending IO - remove me as soon as invalidate is more polite */
diff -urN S6-pre2-put_super/fs/inode.c S6-pre2-dquot/fs/inode.c
--- S6-pre2-put_super/fs/inode.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-dquot/fs/inode.c	Sun Jun 10 18:43:02 2001
@@ -1164,14 +1164,13 @@
 void put_dquot_list(struct list_head *);
 int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
 
-void remove_dquot_ref(kdev_t dev, short type)
+void remove_dquot_ref(struct super_block *sb, short type)
 {
-	struct super_block *sb = get_super(dev);
 	struct inode *inode;
 	struct list_head *act_head;
 	LIST_HEAD(tofree_head);
 
-	if (!sb || !sb->dq_op)
+	if (!sb->dq_op)
 		return;	/* nothing to do */
 
 	/* We have to be protected against other CPUs */
diff -urN S6-pre2-put_super/include/linux/quotaops.h S6-pre2-dquot/include/linux/quotaops.h
--- S6-pre2-put_super/include/linux/quotaops.h	Sun Jun 10 13:15:27 2001
+++ S6-pre2-dquot/include/linux/quotaops.h	Sun Jun 10 18:46:33 2001
@@ -21,7 +21,6 @@
  */
 extern void dquot_initialize(struct inode *inode, short type);
 extern void dquot_drop(struct inode *inode);
-extern void invalidate_dquots(kdev_t dev, short type);
 extern int  quota_off(struct super_block *sb, short type);
 extern int  sync_dquots(kdev_t dev, short type);
 


