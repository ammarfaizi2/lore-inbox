Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbTBQTZw>; Mon, 17 Feb 2003 14:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTBQTZv>; Mon, 17 Feb 2003 14:25:51 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:32027 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267394AbTBQTZd>; Mon, 17 Feb 2003 14:25:33 -0500
Date: Mon, 17 Feb 2003 13:34:34 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200302171934.h1HJYYK05117@shaggy.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.61] jfs breakage in 2.5.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a trap in JFS when under a heavy load.

It's been submitted to Linus as a bk pull.

Thanks to Dave Jones for reporting the problem.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1059  -> 1.1060 
#	 fs/jfs/jfs_logmgr.h	1.10    -> 1.11   
#	 fs/jfs/jfs_logmgr.c	1.44    -> 1.45   
#	 fs/jfs/jfs_umount.c	1.9     -> 1.10   
#	 fs/jfs/jfs_txnmgr.c	1.38    -> 1.39   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/17	shaggy@shaggy.austin.ibm.com	1.1060
# JFS: Fix jfs_sync_fs
# 
# jfs_sync_fs was implemented using the same code as the unmount code to flush
# the journal and wait for the journal to quiesce.  Since jfs_sync_fs may be
# called while the volume is under heavy use, we can end up waiting
# indefinately.  Code in jfs_flush_journal meant to detect a hang at unmount
# time may be triggered in this case causing a trap.  This patch changes
# jfs_sync_fs to only wait until the most recent transaction has been
# committed to disk, rather than waiting until the commit queue is empty.
# --------------------------------------------
#
diff -Nru a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
--- a/fs/jfs/jfs_logmgr.c	Mon Feb 17 13:26:16 2003
+++ b/fs/jfs/jfs_logmgr.c	Mon Feb 17 13:26:16 2003
@@ -97,7 +97,7 @@
 #define LOGGC_LOCK_INIT(log)	spin_lock_init(&(log)->gclock)
 #define LOGGC_LOCK(log)		spin_lock_irq(&(log)->gclock)
 #define LOGGC_UNLOCK(log)	spin_unlock_irq(&(log)->gclock)
-#define LOGGC_WAKEUP(tblk)	wake_up(&(tblk)->gcwait)
+#define LOGGC_WAKEUP(tblk)	wake_up_all(&(tblk)->gcwait)
 
 /*
  *	log sync serialization (per log)
@@ -511,7 +511,6 @@
 			tblk->bp = log->bp;
 			tblk->pn = log->page;
 			tblk->eor = log->eor;
-			init_waitqueue_head(&tblk->gcwait);
 
 			/* enqueue transaction to commit queue */
 			tblk->cqnext = NULL;
@@ -831,6 +830,12 @@
 		tblk->flag &= ~tblkGC_QUEUE;
 		tblk->cqnext = 0;
 
+		if (tblk == log->flush_tblk) {
+			/* we can stop flushing the log now */
+			clear_bit(log_FLUSH, &log->flag);
+			log->flush_tblk = NULL;
+		}
+
 		jfs_info("lmPostGC: tblk = 0x%p, flag = 0x%x", tblk,
 			 tblk->flag);
 
@@ -843,10 +848,10 @@
 			/* state transition: COMMIT -> COMMITTED */
 			tblk->flag |= tblkGC_COMMITTED;
 
-			if (tblk->flag & tblkGC_READY) {
+			if (tblk->flag & tblkGC_READY)
 				log->gcrtc--;
-				LOGGC_WAKEUP(tblk);
-			}
+
+			LOGGC_WAKEUP(tblk);
 		}
 
 		/* was page full before pageout ?
@@ -892,6 +897,7 @@
 	else {
 		log->cflag &= ~logGC_PAGEOUT;
 		clear_bit(log_FLUSH, &log->flag);
+		WARN_ON(log->flush_tblk);
 	}
 
 	//LOGGC_UNLOCK(log);
@@ -1307,7 +1313,8 @@
 
 	INIT_LIST_HEAD(&log->synclist);
 
-	log->cqueue.head = log->cqueue.tail = 0;
+	log->cqueue.head = log->cqueue.tail = NULL;
+	log->flush_tblk = NULL;
 
 	log->count = 0;
 
@@ -1395,38 +1402,78 @@
  *
  * FUNCTION:	initiate write of any outstanding transactions to the journal
  *		and optionally wait until they are all written to disk
+ *
+ *		wait == 0  flush until latest txn is committed, don't wait
+ *		wait == 1  flush until latest txn is committed, wait
+ *		wait > 1   flush until all txn's are complete, wait
  */
 void jfs_flush_journal(struct jfs_log *log, int wait)
 {
 	int i;
+	struct tblock *target;
 
 	jfs_info("jfs_flush_journal: log:0x%p wait=%d", log, wait);
 
-	/*
-	 * This ensures that we will keep writing to the journal as long
-	 * as there are unwritten commit records
-	 */
-	set_bit(log_FLUSH, &log->flag);
-
-	/*
-	 * Initiate I/O on outstanding transactions
-	 */
 	LOGGC_LOCK(log);
-	if (log->cqueue.head && !(log->cflag & logGC_PAGEOUT)) {
-		log->cflag |= logGC_PAGEOUT;
-		lmGCwrite(log, 0);
+
+	target = log->cqueue.head;
+
+	if (target) {
+		/*
+		 * This ensures that we will keep writing to the journal as long
+		 * as there are unwritten commit records
+		 */
+
+		if (test_bit(log_FLUSH, &log->flag)) {
+			/*
+			 * We're already flushing.
+			 * if flush_tblk is NULL, we are flushing everything,
+			 * so leave it that way.  Otherwise, update it to the
+			 * latest transaction
+			 */
+			if (log->flush_tblk)
+				log->flush_tblk = target;
+		} else {
+			/* Only flush until latest transaction is committed */
+			log->flush_tblk = target;
+			set_bit(log_FLUSH, &log->flag);
+
+			/*
+			 * Initiate I/O on outstanding transactions
+			 */
+			if (!(log->cflag & logGC_PAGEOUT)) {
+				log->cflag |= logGC_PAGEOUT;
+				lmGCwrite(log, 0);
+			}
+		}
+	}
+	if ((wait > 1) || test_bit(log_SYNCBARRIER, &log->flag)) {
+		/* Flush until all activity complete */
+		set_bit(log_FLUSH, &log->flag);
+		log->flush_tblk = NULL;
+	}
+
+	if (wait && target && !(target->flag & tblkGC_COMMITTED)) {
+		DECLARE_WAITQUEUE(__wait, current);
+
+		add_wait_queue(&target->gcwait, &__wait);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		LOGGC_UNLOCK(log);
+		schedule();
+		current->state = TASK_RUNNING;
+		LOGGC_LOCK(log);
+		remove_wait_queue(&target->gcwait, &__wait);
 	}
 	LOGGC_UNLOCK(log);
 
-	if (!wait)
+	if (wait < 2)
 		return;
 
+	/*
+	 * If there was recent activity, we may need to wait
+	 * for the lazycommit thread to catch up
+	 */
 	if (log->cqueue.head || !list_empty(&log->synclist)) {
-		/*
-		 * If there was very recent activity, we may need to wait
-		 * for the lazycommit thread to catch up
-		 */
-
 		for (i = 0; i < 800; i++) {	/* Too much? */
 			current->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(HZ / 4);
@@ -1437,7 +1484,6 @@
 	}
 	assert(log->cqueue.head == NULL);
 	assert(list_empty(&log->synclist));
-
 	clear_bit(log_FLUSH, &log->flag);
 }
 
@@ -1467,7 +1513,7 @@
 
 	jfs_info("lmLogShutdown: log:0x%p", log);
 
-	jfs_flush_journal(log, 1);
+	jfs_flush_journal(log, 2);
 
 	/*
 	 * We need to make sure all of the "written" metapages
diff -Nru a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
--- a/fs/jfs/jfs_logmgr.h	Mon Feb 17 13:26:16 2003
+++ b/fs/jfs/jfs_logmgr.h	Mon Feb 17 13:26:16 2003
@@ -403,6 +403,7 @@
 		struct tblock *head;
 		struct tblock *tail;
 	} cqueue;
+	struct tblock *flush_tblk; /* tblk we're waiting on for flush */
 	int gcrtc;		/* 4: GC_READY transaction count */
 	struct tblock *gclrt;	/* 4: latest GC_READY transaction */
 	spinlock_t gclock;	/* 4: group commit lock */
diff -Nru a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
--- a/fs/jfs/jfs_txnmgr.c	Mon Feb 17 13:26:16 2003
+++ b/fs/jfs/jfs_txnmgr.c	Mon Feb 17 13:26:16 2003
@@ -2741,8 +2741,7 @@
 	if (tblk->flag & tblkGC_READY)
 		log->gcrtc--;
 
-	if (tblk->flag & tblkGC_READY)
-		wake_up(&tblk->gcwait);	// LOGGC_WAKEUP
+	wake_up_all(&tblk->gcwait);	// LOGGC_WAKEUP
 
 	/*
 	 * Can't release log->gclock until we've tested tblk->flag
diff -Nru a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
--- a/fs/jfs/jfs_umount.c	Mon Feb 17 13:26:16 2003
+++ b/fs/jfs/jfs_umount.c	Mon Feb 17 13:26:16 2003
@@ -69,7 +69,7 @@
 		/*
 		 * Wait for outstanding transactions to be written to log: 
 		 */
-		jfs_flush_journal(log, 1);
+		jfs_flush_journal(log, 2);
 
 	/*
 	 * close fileset inode allocation map (aka fileset inode)
@@ -149,7 +149,7 @@
 	 *
 	 * remove file system from log active file system list.
 	 */
-	jfs_flush_journal(log, 1);
+	jfs_flush_journal(log, 2);
 
 	/*
 	 * Make sure all metadata makes it to disk
