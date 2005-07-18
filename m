Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVGROLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVGROLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGROLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:11:46 -0400
Received: from Quebec-HSE-ppp231061.qc.sympatico.ca ([69.159.205.163]:33519
	"EHLO cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261723AbVGROLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:11:42 -0400
Subject: [PATCH] Convert refrigerator() to try_to_freeze()
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121659148.13493.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Jul 2005 13:59:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch removes the few remaining direct invocations of the
refrigerator in 2.6.13-rc3. In drivers/media/video/msp3400.c, it also
shifts the call to after the remove_wait_queue; this seems to be the
more appropriate place.

Regards,

Nigel

Signed-off by: Nigel Cunningham <nigel@suspend2.net>

 drivers/media/video/msp3400.c |    4 +---
 drivers/net/irda/stir4200.c   |    2 +-
 fs/jbd/journal.c              |    2 +-
 fs/jfs/jfs_logmgr.c           |    2 +-
 fs/jfs/jfs_txnmgr.c           |    4 ++--
 fs/xfs/linux-2.6/xfs_buf.c    |    2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/drivers/media/video/msp3400.c 230-refrigerator-to-try_to_freeze.patch-new/drivers/media/video/msp3400.c
--- 230-refrigerator-to-try_to_freeze.patch-old/drivers/media/video/msp3400.c	2005-07-18 06:36:48.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/drivers/media/video/msp3400.c	2005-07-18 13:54:48.000000000 +1000
@@ -741,11 +741,9 @@ static int msp34xx_sleep(struct msp3400c
 			schedule_timeout(msecs_to_jiffies(timeout));
 		}
 	}
-	if (current->flags & PF_FREEZE) {
-		refrigerator ();
-	}
 
 	remove_wait_queue(&msp->wq, &wait);
+	try_to_freeze();
 	return msp->restart;
 }
 
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/drivers/net/irda/stir4200.c 230-refrigerator-to-try_to_freeze.patch-new/drivers/net/irda/stir4200.c
--- 230-refrigerator-to-try_to_freeze.patch-old/drivers/net/irda/stir4200.c	2005-07-18 06:36:51.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/drivers/net/irda/stir4200.c	2005-07-18 08:20:58.000000000 +1000
@@ -771,7 +771,7 @@ static int stir_transmit_thread(void *ar
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			refrigerator();
+			try_to_freeze();
 
 			if (change_speed(stir, stir->speed))
 				break;
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c
--- 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c	2005-07-18 06:36:59.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c	2005-07-18 13:54:47.000000000 +1000
@@ -175,7 +175,7 @@ loop:
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
 		spin_unlock(&journal->j_state_lock);
-		refrigerator();
+		try_to_freeze();
 		spin_lock(&journal->j_state_lock);
 	} else {
 		/*
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c
--- 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c	2005-07-18 06:36:59.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c	2005-07-18 13:54:47.000000000 +1000
@@ -2361,7 +2361,7 @@ int jfsIOWait(void *arg)
 		}
 		if (freezing(current)) {
 			spin_unlock_irq(&log_redrive_lock);
-			refrigerator();
+			try_to_freeze();
 		} else {
 			add_wait_queue(&jfs_IO_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_txnmgr.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_txnmgr.c
--- 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_txnmgr.c	2005-07-18 06:36:59.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_txnmgr.c	2005-07-18 13:54:47.000000000 +1000
@@ -2790,7 +2790,7 @@ int jfs_lazycommit(void *arg)
 
 		if (freezing(current)) {
 			LAZY_UNLOCK(flags);
-			refrigerator();
+			try_to_freeze();
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
@@ -2989,7 +2989,7 @@ int jfs_sync(void *arg)
 
 		if (freezing(current)) {
 			TXN_UNLOCK();
-			refrigerator();
+			try_to_freeze();
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/xfs/linux-2.6/xfs_buf.c 230-refrigerator-to-try_to_freeze.patch-new/fs/xfs/linux-2.6/xfs_buf.c
--- 230-refrigerator-to-try_to_freeze.patch-old/fs/xfs/linux-2.6/xfs_buf.c	2005-07-18 06:37:01.000000000 +1000
+++ 230-refrigerator-to-try_to_freeze.patch-new/fs/xfs/linux-2.6/xfs_buf.c	2005-07-18 13:54:48.000000000 +1000
@@ -1773,7 +1773,7 @@ xfsbufd(
 	do {
 		if (unlikely(freezing(current))) {
 			xfsbufd_force_sleep = 1;
-			refrigerator();
+			try_to_freeze();
 		} else {
 			xfsbufd_force_sleep = 0;
 		}

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

