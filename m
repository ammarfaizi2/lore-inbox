Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269683AbRHMBfh>; Sun, 12 Aug 2001 21:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269672AbRHMBaW>; Sun, 12 Aug 2001 21:30:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:656 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269655AbRHMB3B>;
	Sun, 12 Aug 2001 21:29:01 -0400
Date: Sun, 12 Aug 2001 21:29:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (9/11)
In-Reply-To: <Pine.GSO.4.21.0108122128400.7092-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108122129000.7092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 9/11

Cleanup: invalidate_dquot() can rely on the fact that struct superblock is
not reused.

diff -urN S9-pre1-kern_mnt/fs/dquot.c S9-pre1-dquot/fs/dquot.c
--- S9-pre1-kern_mnt/fs/dquot.c	Sat Aug 11 14:59:24 2001
+++ S9-pre1-dquot/fs/dquot.c	Sun Aug 12 20:45:51 2001
@@ -325,7 +325,7 @@
         memset(&dquot->dq_dqb, 0, sizeof(struct dqblk));
 }
 
-static void invalidate_dquots(kdev_t dev, short type)
+static void invalidate_dquots(struct super_block *sb, short type)
 {
 	struct dquot *dquot, *next;
 	int need_restart;
@@ -335,12 +335,10 @@
 	need_restart = 0;
 	while ((dquot = next) != NULL) {
 		next = dquot->dq_next;
-		if (dquot->dq_dev != dev)
+		if (dquot->dq_sb != sb)
 			continue;
 		if (dquot->dq_type != type)
 			continue;
-		if (!dquot->dq_sb)	/* Already invalidated entry? */
-			continue;
 		if (dquot->dq_flags & DQ_LOCKED) {
 			__wait_on_dquot(dquot);
 
@@ -349,12 +347,10 @@
 			/*
 			 * Make sure it's still the same dquot.
 			 */
-			if (dquot->dq_dev != dev)
+			if (dquot->dq_sb != sb)
 				continue;
 			if (dquot->dq_type != type)
 				continue;
-			if (!dquot->dq_sb)
-				continue;
 		}
 		/*
 		 *  Because inodes needn't to be the only holders of dquot
@@ -1409,7 +1405,7 @@
 
 		/* Note: these are blocking operations */
 		remove_dquot_ref(sb, cnt);
-		invalidate_dquots(sb->s_dev, cnt);
+		invalidate_dquots(sb, cnt);
 
 		/* Wait for any pending IO - remove me as soon as invalidate is more polite */
 		down(&dqopt->dqio_sem);


