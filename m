Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268461AbRHAWWa>; Wed, 1 Aug 2001 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268467AbRHAWWU>; Wed, 1 Aug 2001 18:22:20 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61432 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268461AbRHAWWI>; Wed, 1 Aug 2001 18:22:08 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108012221.f71ML0NH007455@webber.adilger.int>
Subject: [PATCH] move sync_supers to end of sync functions
To: torvalds@transmeta.com,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 1 Aug 2001 16:21:00 -0600 (MDT)
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Linus,
the following patch ensures that write_super() or sync_supers() is called
_after_ other filesystem I/O is completed.  The current order means that a
superblock could be dirtied by other filesystem I/O after the superblock
has been "synced".  This has been part of the ext3 patches for a long
time, but should really be done in the stock kernel sources as well.

Cheers, Andreas
========================================================================
diff -ru linux-2.4.7.orig/fs/buffer.c linux-2.4.7-aed/fs/buffer.c
--- linux-2.4.7.orig/fs/buffer.c	Tue Jul 31 15:00:37 2001
+++ linux-2.4.7-aed/fs/buffer.c	Tue Jul 31 16:45:09 2001
@@ -310,11 +312,11 @@
 
 	lock_kernel();
 	sync_inodes_sb(sb);
+	DQUOT_SYNC(dev);
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
 	unlock_super(sb);
-	DQUOT_SYNC(dev);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);
@@ -325,9 +327,9 @@
 	sync_buffers(dev, 0);
 
 	lock_kernel();
-	sync_supers(dev);
 	sync_inodes(dev);
 	DQUOT_SYNC(dev);
+	sync_supers(dev);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);
@@ -2608,8 +2693,8 @@
 static int sync_old_buffers(void)
 {
 	lock_kernel();
-	sync_supers(0);
 	sync_unlocked_inodes();
+	sync_supers(0);
 	unlock_kernel();
 
 	flush_dirty_buffers(1);
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

