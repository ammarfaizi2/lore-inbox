Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265979AbRF1PDs>; Thu, 28 Jun 2001 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265986AbRF1PDi>; Thu, 28 Jun 2001 11:03:38 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:57349
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265979AbRF1PDf>; Thu, 28 Jun 2001 11:03:35 -0400
Date: Thu, 28 Jun 2001 11:02:53 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] reiserfs_write_inode calls during memory pressure
Message-ID: <44970000.993740573@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ one more time ]

Hi guys,

This patch makes reiserfs_write_inode skip the commit when it is called 
during memory pressure with sync == 1.  In this case, reiserfs already has 
the inode logged, and triggering an immediate commit might force kswapd
to wait on the log, which can lead to deadlock.

More details can be found in the VM deadlock thread on both of these
lists.

It has passed minimal testing on my machine, I'll start more (yura, please 
do the same).

-chris

diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Jun 28 10:56:04 2001
+++ b/fs/reiserfs/inode.c	Thu Jun 28 10:56:04 2001
@@ -1284,7 +1284,12 @@
 	                  inode->i_ino) ;
         return ;
     }
-    if (do_sync) {
+    /* memory pressure can sometimes initiate write_inode calls with sync == 1,
+    ** these cases are just when the system needs ram, not when the 
+    ** inode needs to reach disk for safety, and they can safely be
+    ** ignored because the altered inode has already been logged.
+    */
+    if (do_sync && !(current->flags & PF_MEMALLOC)) {
 	lock_kernel() ;
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
 	reiserfs_update_sd (&th, inode);




