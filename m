Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSI3Bad>; Sun, 29 Sep 2002 21:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSI3Bad>; Sun, 29 Sep 2002 21:30:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:44460 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261893AbSI3Baa>;
	Sun, 29 Sep 2002 21:30:30 -0400
Message-ID: <3D97AA72.ED585E24@digeo.com>
Date: Sun, 29 Sep 2002 18:35:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.5.39-mm1
References: <3D976206.B2C6A5B8@digeo.com> <200209292124.12696.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 01:35:47.0865 (UTC) FILETIME=[B3BF1890:01C26821]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> On September 29, 2002 04:26 pm, Andrew Morton wrote:
> > There is a reiserfs compilation problem at present.
> 
> make[2]: Entering directory `/poole/src/39-mm1/fs/reiserfs'
>   gcc -Wp,-MD,./.bitmap.o.d -D__KERNEL__ -I/poole/src/39-mm1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -I/poole/src/39-mm1/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=bitmap   -c -o bitmap.o bitmap.c
> In file included from bitmap.c:8:
> /poole/src/39-mm1/include/linux/reiserfs_fs.h:1635: parse error before `reiserfs_commit_thread_tq'

Ingo sent me the below temp fix.  I let it out because it's
probably better to leave the fs broken until we have a firm,
tested solution.



--- linux/drivers/char/drm/radeon_irq.c.orig	Sun Sep 29 20:55:34 2002
+++ linux/drivers/char/drm/radeon_irq.c	Sun Sep 29 20:56:27 2002
@@ -69,8 +69,7 @@
 
 	atomic_inc(&dev_priv->irq_received);
 #ifdef __linux__
-	queue_task(&dev->tq, &tq_immediate);  
-	mark_bh(IMMEDIATE_BH);  
+	schedule_task(&dev->tq);
 #endif /* __linux__ */
 #ifdef __FreeBSD__
 	taskqueue_enqueue(taskqueue_swi, &dev->task);
--- linux/fs/reiserfs/journal.c.orig	Sun Sep 29 21:03:48 2002
+++ linux/fs/reiserfs/journal.c	Sun Sep 29 21:04:49 2002
@@ -65,13 +65,6 @@
 */
 static int reiserfs_mounted_fs_count = 0 ;
 
-/* wake this up when you add something to the commit thread task queue */
-DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_wait) ;
-
-/* wait on this if you need to be sure you task queue entries have been run */
-static DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_done) ;
-DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ;
-
 #define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit
 				     structs at 4k */
 #define BUFNR 64 /*read ahead */
@@ -1339,12 +1332,9 @@
     do_journal_end(&myth, p_s_sb,1, FLUSH_ALL) ;
   }
 
-  /* we decrement before we wake up, because the commit thread dies off
-  ** when it has been woken up and the count is <= 0
-  */
   reiserfs_mounted_fs_count-- ;
-  wake_up(&reiserfs_commit_thread_wait) ;
-  sleep_on(&reiserfs_commit_thread_done) ;
+  /* wait for all commits to finish */
+  flush_scheduled_tasks();
 
   release_journal_dev( p_s_sb, SB_JOURNAL( p_s_sb ) );
   free_journal_ram(p_s_sb) ;
@@ -1815,6 +1805,10 @@
 static void reiserfs_journal_commit_task_func(struct reiserfs_journal_commit_task *ct) {
 
   struct reiserfs_journal_list *jl ;
+
+  /* FIXMEL: is this needed? */
+  lock_kernel();
+
   jl = SB_JOURNAL_LIST(ct->p_s_sb) + ct->jindex ;
 
   flush_commit_list(ct->p_s_sb, SB_JOURNAL_LIST(ct->p_s_sb) + ct->jindex, 1) ; 
@@ -1824,6 +1818,7 @@
     kupdate_one_transaction(ct->p_s_sb, jl) ;
   }
   reiserfs_kfree(ct->self, sizeof(struct reiserfs_journal_commit_task), ct->p_s_sb) ;
+  unlock_kernel();
 }
 
 static void setup_commit_task_arg(struct reiserfs_journal_commit_task *ct,
@@ -1850,8 +1845,7 @@
   ct = reiserfs_kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS, p_s_sb) ;
   if (ct) {
     setup_commit_task_arg(ct, p_s_sb, jindex) ;
-    queue_task(&(ct->task), &reiserfs_commit_thread_tq);
-    wake_up(&reiserfs_commit_thread_wait) ;
+    schedule_task(&ct->task) ;
   } else {
 #ifdef CONFIG_REISERFS_CHECK
     reiserfs_warning("journal-1540: kmalloc failed, doing sync commit\n") ;
@@ -1860,49 +1854,6 @@
   }
 }
 
-/*
-** this is the commit thread.  It is started with kernel_thread on
-** FS mount, and journal_release() waits for it to exit.
-**
-** It could do a periodic commit, but there is a lot code for that
-** elsewhere right now, and I only wanted to implement this little
-** piece for starters.
-**
-** All we do here is sleep on the j_commit_thread_wait wait queue, and
-** then run the per filesystem commit task queue when we wakeup.
-*/
-static int reiserfs_journal_commit_thread(void *nullp) {
-
-  daemonize() ;
-
-  spin_lock_irq(&current->sigmask_lock);
-  sigfillset(&current->blocked);
-  recalc_sigpending();
-  spin_unlock_irq(&current->sigmask_lock);
-
-  sprintf(current->comm, "kreiserfsd") ;
-  lock_kernel() ;
-  while(1) {
-
-    while(TQ_ACTIVE(reiserfs_commit_thread_tq)) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
-    }
-
-    /* if there aren't any more filesystems left, break */
-    if (reiserfs_mounted_fs_count <= 0) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
-      break ;
-    }
-    wake_up(&reiserfs_commit_thread_done) ;
-    if (current->flags & PF_FREEZE)
-      refrigerator(PF_IOTHREAD);
-    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
-  }
-  unlock_kernel() ;
-  wake_up(&reiserfs_commit_thread_done) ;
-  return 0 ;
-}
-
 static void journal_list_init(struct super_block *p_s_sb) {
   int i ;
   for (i = 0 ; i < JOURNAL_LIST_COUNT ; i++) {
@@ -2175,10 +2126,6 @@
     return 0;
 
   reiserfs_mounted_fs_count++ ;
-  if (reiserfs_mounted_fs_count <= 1) {
-    kernel_thread((void *)(void *)reiserfs_journal_commit_thread, NULL,
-                  CLONE_FS | CLONE_FILES | CLONE_VM) ;
-  }
   return 0 ;
 
 }
--- linux/include/linux/reiserfs_fs.h.orig	Sun Sep 29 20:58:23 2002
+++ linux/include/linux/reiserfs_fs.h	Sun Sep 29 20:58:30 2002
@@ -1632,9 +1632,6 @@
   /* 12 */ struct journal_params jh_journal;
 } ;
 
-extern task_queue reiserfs_commit_thread_tq ;
-extern wait_queue_head_t reiserfs_commit_thread_wait ;
-
 /* biggest tunable defines are right here */
 #define JOURNAL_BLOCK_COUNT 8192 /* number of blocks in the journal */
 #define JOURNAL_TRANS_MAX_DEFAULT 1024   /* biggest possible single transaction, don't change for now (8/3/99) */
