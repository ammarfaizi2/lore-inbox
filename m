Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbQLMNwE>; Wed, 13 Dec 2000 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131390AbQLMNvy>; Wed, 13 Dec 2000 08:51:54 -0500
Received: from [200.230.208.16] ([200.230.208.16]:4107 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S131363AbQLMNve>;
	Wed, 13 Dec 2000 08:51:34 -0500
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible patch for reiserfs-3.6.22 against 2.4.0-test12
Date: Wed, 13 Dec 2000 11:14:30 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
In-Reply-To: <873dftywn6.fsf@cartman.azz.net>
In-Reply-To: <873dftywn6.fsf@cartman.azz.net>
MIME-Version: 1.0
Message-Id: <00121311262200.00911@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hiya.
> 
> The latest reiserfs patch on ftp.namesys.com causes compilation errors
> against test12 due to the task queue changes. Does this look correct?
> 

Please, somebody can test this patch

-- BOF --
diff -ur linux-bk/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux-bk/fs/reiserfs/journal.c	Tue Dec 12 14:38:22 2000
+++ linux/fs/reiserfs/journal.c	Tue Dec 12 17:41:19 2000
@@ -77,7 +77,9 @@
 
 /* wait on this if you need to be sure you task queue entries have been run */
 static DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_done) ;
-DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ;
+
+/*DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ; */
+task_queue *reiserfs_commit_thread_tq = NULL;
 
 #define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit structs at 4k */
 
@@ -1762,7 +1764,7 @@
   ct->p_s_sb = p_s_sb ;
   ct->jindex = jindex ;
   ct->task_done = NULL ;
-  ct->task.next = NULL ;
+  INIT_LIST_HEAD(&ct->task.list);
   ct->task.sync = 0 ;
   ct->task.routine = (void *)(void *)reiserfs_journal_commit_task_func ; 
   ct->self = ct ;
@@ -1777,7 +1779,7 @@
   ct = kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_BUFFER) ;
   if (ct) {
     setup_commit_task_arg(ct, p_s_sb, jindex) ;
-    queue_task(&(ct->task), &reiserfs_commit_thread_tq);
+    queue_task(&(ct->task), reiserfs_commit_thread_tq);
     wake_up(&reiserfs_commit_thread_wait) ;
   } else {
 #ifdef CONFIG_REISERFS_CHECK
@@ -1813,13 +1814,13 @@
   lock_kernel() ;
   while(1) {
 
-    while(reiserfs_commit_thread_tq) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
+    while(reiserfs_commit_thread_tq) { 
+	run_task_queue(reiserfs_commit_thread_tq) ;
     }
 
     /* if there aren't any more filesystems left, break */
     if (reiserfs_mounted_fs_count <= 0) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
+      run_task_queue(reiserfs_commit_thread_tq) ;
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
diff -ur linux-bk/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux-bk/include/linux/reiserfs_fs.h	Tue Dec 12 14:39:34 2000
+++ linux/include/linux/reiserfs_fs.h	Tue Dec 12 17:31:09 2000
@@ -1565,8 +1565,8 @@
   int do_not_lock ; 
 } ;
 
-extern task_queue reiserfs_commit_thread_tq ;
-extern task_queue reiserfs_end_io_tq ;
+extern task_queue *reiserfs_commit_thread_tq ;
+extern task_queue *reiserfs_end_io_tq ;
 extern wait_queue_head_t reiserfs_commit_thread_wait ;
 
 /* biggest tunable defines are right here */
-- EOF --

cya;

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
