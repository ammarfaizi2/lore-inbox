Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262571AbSJBTdS>; Wed, 2 Oct 2002 15:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbSJBTdS>; Wed, 2 Oct 2002 15:33:18 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:49088 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262571AbSJBTdR>; Wed, 2 Oct 2002 15:33:17 -0400
Date: Wed, 2 Oct 2002 14:38:43 -0500
From: David Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200210021938.g92Jchd6002935@kleikamp.austin.ibm.com>
To: torvalds@transmeta.com
Subject: [PATCH] JFS and CONFIG_PREEMPT
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes a problem when JFS is used with CONFIG_PREEMPT enabled.
There was a timing window that apparently didn't hurt us on SMP, but is
very easily hit with CONFIG_PREEMPT.

This patch can be pulled from bk://jfs.bkbits.net/linux-2.5

--------------------------------------------------------------
ChangeSet@1.663.4.1, 2002-10-02 13:25:44-05:00, shaggy@kleikamp.austin.ibm.com
  JFS: Releasing LOGGC_LOCK too early
  
  In txLazyCommit, we are releasing log->gclock (LOGGC_LOCK) before
  checking tblk->flag for tblkGC_LAZY.  For the case that tblkGC_LAZY
  is not set, the user thread may release the tblk, and it may be
  reused and the tblkGC_LAZY bit set again, between the time we release
  the spinlock until we check the flag.  This is a lot to happen in an
  SMP environment, but when CONFIG_PREEMPT is set, it is very easy to
  see the problem.
  
  The fix is to hold the spinlock until after we've checked the flag.
  
  (Yes, I know the symbol names are ugly.)

 fs/jfs/jfs_txnmgr.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
--------------------------------------------------------------

diff -Nru a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
--- a/fs/jfs/jfs_txnmgr.c	Wed Oct  2 14:33:43 2002
+++ b/fs/jfs/jfs_txnmgr.c	Wed Oct  2 14:33:43 2002
@@ -2746,13 +2746,16 @@
 	if (tblk->flag & tblkGC_READY)
 		wake_up(&tblk->gcwait);	// LOGGC_WAKEUP
 
-	spin_unlock_irq(&log->gclock);	// LOGGC_UNLOCK
-
+	/*
+	 * Can't release log->gclock until we've tested tblk->flag
+	 */
 	if (tblk->flag & tblkGC_LAZY) {
+		spin_unlock_irq(&log->gclock);	// LOGGC_UNLOCK
 		txUnlock(tblk);
 		tblk->flag &= ~tblkGC_LAZY;
 		txEnd(tblk - TxBlock);	/* Convert back to tid */
-	}
+	} else
+		spin_unlock_irq(&log->gclock);	// LOGGC_UNLOCK
 
 	jFYI(1, ("txLazyCommit: done: tblk = 0x%p\n", tblk));
 }
