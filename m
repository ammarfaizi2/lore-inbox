Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWBNRzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWBNRzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWBNRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:55:51 -0500
Received: from verein.lst.de ([213.95.11.210]:15053 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422716AbWBNRzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:55:50 -0500
Date: Tue, 14 Feb 2006 18:55:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: shaggy@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: use kthread_ API
Message-ID: <20060214175545.GA19225@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/jfs/jfs_logmgr.c
===================================================================
--- linux-2.6.orig/fs/jfs/jfs_logmgr.c	2005-12-27 18:30:32.000000000 +0100
+++ linux-2.6/fs/jfs/jfs_logmgr.c	2006-02-14 16:24:18.000000000 +0100
@@ -64,6 +64,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include <linux/buffer_head.h>		/* for sync_blockdev() */
 #include <linux/bio.h>
 #include <linux/suspend.h>
@@ -81,7 +82,6 @@
  */
 static struct lbuf *log_redrive_list;
 static DEFINE_SPINLOCK(log_redrive_lock);
-DECLARE_WAIT_QUEUE_HEAD(jfs_IO_thread_wait);
 
 
 /*
@@ -1980,7 +1980,7 @@
 	log_redrive_list = bp;
 	spin_unlock_irqrestore(&log_redrive_lock, flags);
 
-	wake_up(&jfs_IO_thread_wait);
+	wake_up_process(jfsIOthread);
 }
 
 
@@ -2347,13 +2347,7 @@
 {
 	struct lbuf *bp;
 
-	daemonize("jfsIO");
-
-	complete(&jfsIOwait);
-
 	do {
-		DECLARE_WAITQUEUE(wq, current);
-
 		spin_lock_irq(&log_redrive_lock);
 		while ((bp = log_redrive_list) != 0) {
 			log_redrive_list = bp->l_redrive_next;
@@ -2362,21 +2356,19 @@
 			lbmStartIO(bp);
 			spin_lock_irq(&log_redrive_lock);
 		}
+		spin_unlock_irq(&log_redrive_lock);
+
 		if (freezing(current)) {
-			spin_unlock_irq(&log_redrive_lock);
 			refrigerator();
 		} else {
-			add_wait_queue(&jfs_IO_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
-			spin_unlock_irq(&log_redrive_lock);
 			schedule();
 			current->state = TASK_RUNNING;
-			remove_wait_queue(&jfs_IO_thread_wait, &wq);
 		}
-	} while (!jfs_stop_threads);
+	} while (!kthread_should_stop());
 
 	jfs_info("jfsIOWait being killed!");
-	complete_and_exit(&jfsIOwait, 0);
+	return 0;
 }
 
 /*
Index: linux-2.6/fs/jfs/jfs_superblock.h
===================================================================
--- linux-2.6.orig/fs/jfs/jfs_superblock.h	2005-12-27 18:30:32.000000000 +0100
+++ linux-2.6/fs/jfs/jfs_superblock.h	2006-02-14 16:24:18.000000000 +0100
@@ -113,12 +113,9 @@
 extern int jfs_mount_rw(struct super_block *, int);
 extern int jfs_umount(struct super_block *);
 extern int jfs_umount_rw(struct super_block *);
-
-extern int jfs_stop_threads;
-extern struct completion jfsIOwait;
-extern wait_queue_head_t jfs_IO_thread_wait;
-extern wait_queue_head_t jfs_commit_thread_wait;
-extern wait_queue_head_t jfs_sync_thread_wait;
 extern int jfs_extendfs(struct super_block *, s64, int);
 
+extern struct task_struct *jfsIOthread;
+extern struct task_struct *jfsSyncThread;
+
 #endif /*_H_JFS_SUPERBLOCK */
Index: linux-2.6/fs/jfs/jfs_txnmgr.c
===================================================================
--- linux-2.6.orig/fs/jfs/jfs_txnmgr.c	2006-01-10 13:46:05.000000000 +0100
+++ linux-2.6/fs/jfs/jfs_txnmgr.c	2006-02-14 16:24:18.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/kthread.h>
 #include "jfs_incore.h"
 #include "jfs_inode.h"
 #include "jfs_filsys.h"
@@ -121,8 +122,7 @@
 #define LAZY_LOCK(flags)	spin_lock_irqsave(&TxAnchor.LazyLock, flags)
 #define LAZY_UNLOCK(flags) spin_unlock_irqrestore(&TxAnchor.LazyLock, flags)
 
-DECLARE_WAIT_QUEUE_HEAD(jfs_sync_thread_wait);
-DECLARE_WAIT_QUEUE_HEAD(jfs_commit_thread_wait);
+static DECLARE_WAIT_QUEUE_HEAD(jfs_commit_thread_wait);
 static int jfs_commit_thread_waking;
 
 /*
@@ -207,7 +207,7 @@
 	if ((++TxAnchor.tlocksInUse > TxLockHWM) && (jfs_tlocks_low == 0)) {
 		jfs_info("txLockAlloc tlocks low");
 		jfs_tlocks_low = 1;
-		wake_up(&jfs_sync_thread_wait);
+		wake_up_process(jfsSyncThread);
 	}
 
 	return lid;
@@ -2743,10 +2743,6 @@
 	unsigned long flags;
 	struct jfs_sb_info *sbi;
 
-	daemonize("jfsCommit");
-
-	complete(&jfsIOwait);
-
 	do {
 		LAZY_LOCK(flags);
 		jfs_commit_thread_waking = 0;	/* OK to wake another thread */
@@ -2806,13 +2802,13 @@
 			current->state = TASK_RUNNING;
 			remove_wait_queue(&jfs_commit_thread_wait, &wq);
 		}
-	} while (!jfs_stop_threads);
+	} while (!kthread_should_stop());
 
 	if (!list_empty(&TxAnchor.unlock_queue))
 		jfs_err("jfs_lazycommit being killed w/pending transactions!");
 	else
 		jfs_info("jfs_lazycommit being killed\n");
-	complete_and_exit(&jfsIOwait, 0);
+	return 0;
 }
 
 void txLazyUnlock(struct tblock * tblk)
@@ -2932,10 +2928,6 @@
 	int rc;
 	tid_t tid;
 
-	daemonize("jfsSync");
-
-	complete(&jfsIOwait);
-
 	do {
 		/*
 		 * write each inode on the anonymous inode list
@@ -2996,19 +2988,15 @@
 			TXN_UNLOCK();
 			refrigerator();
 		} else {
-			DECLARE_WAITQUEUE(wq, current);
-
-			add_wait_queue(&jfs_sync_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
 			TXN_UNLOCK();
 			schedule();
 			current->state = TASK_RUNNING;
-			remove_wait_queue(&jfs_sync_thread_wait, &wq);
 		}
-	} while (!jfs_stop_threads);
+	} while (!kthread_should_stop());
 
 	jfs_info("jfs_sync being killed");
-	complete_and_exit(&jfsIOwait, 0);
+	return 0;
 }
 
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_JFS_DEBUG)
Index: linux-2.6/fs/jfs/super.c
===================================================================
--- linux-2.6.orig/fs/jfs/super.c	2006-01-10 13:46:05.000000000 +0100
+++ linux-2.6/fs/jfs/super.c	2006-02-14 16:24:18.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/vfs.h>
 #include <linux/mount.h>
 #include <linux/moduleparam.h>
+#include <linux/kthread.h>
 #include <linux/posix_acl.h>
 #include <asm/uaccess.h>
 #include <linux/seq_file.h>
@@ -54,11 +55,9 @@
 module_param(commit_threads, int, 0);
 MODULE_PARM_DESC(commit_threads, "Number of commit threads");
 
-int jfs_stop_threads;
-static pid_t jfsIOthread;
-static pid_t jfsCommitThread[MAX_COMMIT_THREADS];
-static pid_t jfsSyncThread;
-DECLARE_COMPLETION(jfsIOwait);
+static struct task_struct *jfsCommitThread[MAX_COMMIT_THREADS];
+struct task_struct *jfsIOthread;
+struct task_struct *jfsSyncThread;
 
 #ifdef CONFIG_JFS_DEBUG
 int jfsloglevel = JFS_LOGLEVEL_WARN;
@@ -661,12 +660,12 @@
 	/*
 	 * I/O completion thread (endio)
 	 */
-	jfsIOthread = kernel_thread(jfsIOWait, NULL, CLONE_KERNEL);
-	if (jfsIOthread < 0) {
-		jfs_err("init_jfs_fs: fork failed w/rc = %d", jfsIOthread);
+	jfsIOthread = kthread_run(jfsIOWait, NULL, "jfsIO");
+	if (IS_ERR(jfsIOthread)) {
+		rc = PTR_ERR(jfsIOthread);
+		jfs_err("init_jfs_fs: fork failed w/rc = %d", rc);
 		goto end_txmngr;
 	}
-	wait_for_completion(&jfsIOwait);	/* Wait until thread starts */
 
 	if (commit_threads < 1)
 		commit_threads = num_online_cpus();
@@ -674,24 +673,21 @@
 		commit_threads = MAX_COMMIT_THREADS;
 
 	for (i = 0; i < commit_threads; i++) {
-		jfsCommitThread[i] = kernel_thread(jfs_lazycommit, NULL,
-						   CLONE_KERNEL);
-		if (jfsCommitThread[i] < 0) {
-			jfs_err("init_jfs_fs: fork failed w/rc = %d",
-				jfsCommitThread[i]);
+		jfsCommitThread[i] = kthread_run(jfs_lazycommit, NULL, "jfsCommit");
+		if (IS_ERR(jfsCommitThread[i])) {
+			rc = PTR_ERR(jfsCommitThread[i]);
+			jfs_err("init_jfs_fs: fork failed w/rc = %d", rc);
 			commit_threads = i;
 			goto kill_committask;
 		}
-		/* Wait until thread starts */
-		wait_for_completion(&jfsIOwait);
 	}
 
-	jfsSyncThread = kernel_thread(jfs_sync, NULL, CLONE_KERNEL);
-	if (jfsSyncThread < 0) {
-		jfs_err("init_jfs_fs: fork failed w/rc = %d", jfsSyncThread);
+	jfsSyncThread = kthread_run(jfs_sync, NULL, "jfsSync");
+	if (IS_ERR(jfsSyncThread)) {
+		rc = PTR_ERR(jfsSyncThread);
+		jfs_err("init_jfs_fs: fork failed w/rc = %d", rc);
 		goto kill_committask;
 	}
-	wait_for_completion(&jfsIOwait);	/* Wait until thread starts */
 
 #ifdef PROC_FS_JFS
 	jfs_proc_init();
@@ -700,13 +696,9 @@
 	return register_filesystem(&jfs_fs_type);
 
 kill_committask:
-	jfs_stop_threads = 1;
-	wake_up_all(&jfs_commit_thread_wait);
 	for (i = 0; i < commit_threads; i++)
-		wait_for_completion(&jfsIOwait);
-
-	wake_up(&jfs_IO_thread_wait);
-	wait_for_completion(&jfsIOwait);	/* Wait for thread exit */
+		kthread_stop(jfsCommitThread[i]);
+	kthread_stop(jfsIOthread);
 end_txmngr:
 	txExit();
 free_metapage:
@@ -722,16 +714,13 @@
 
 	jfs_info("exit_jfs_fs called");
 
-	jfs_stop_threads = 1;
 	txExit();
 	metapage_exit();
-	wake_up(&jfs_IO_thread_wait);
-	wait_for_completion(&jfsIOwait);	/* Wait until IO thread exits */
-	wake_up_all(&jfs_commit_thread_wait);
+
+	kthread_stop(jfsIOthread);
 	for (i = 0; i < commit_threads; i++)
-		wait_for_completion(&jfsIOwait);
-	wake_up(&jfs_sync_thread_wait);
-	wait_for_completion(&jfsIOwait);	/* Wait until Sync thread exits */
+		kthread_stop(jfsCommitThread[i]);
+	kthread_stop(jfsSyncThread);
 #ifdef PROC_FS_JFS
 	jfs_proc_clean();
 #endif
