Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312513AbSDJHCi>; Wed, 10 Apr 2002 03:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312515AbSDJHCh>; Wed, 10 Apr 2002 03:02:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312513AbSDJHCc>;
	Wed, 10 Apr 2002 03:02:32 -0400
Message-ID: <3CB3E386.797E5C01@zip.com.au>
Date: Wed, 10 Apr 2002 00:02:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] replace kupdate and bdflush with pdflush
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty simple.

- use a timer to kick off a pdflush thread every five seconds
  to run the kupdate code. 

- wakeup_bdflush() kicks off a pdflush thread to run the current
  bdflush function.

There's some loss of functionality here - the ability to tune
the writeback periods.  The numbers are hardwired at present.
But the intent is that buffer-based writeback disappears
altogether.  New mechanisms for tuning the writeback will
need to be introduced.


Patch against 2.5.8-pre3+ratcache+readahead+pageprivate+pdflush+pdflush_inodes


--- 2.5.8-pre3/fs/buffer.c~dallocbase-50-pdflush_buffers	Tue Apr  9 22:42:56 2002
+++ 2.5.8-pre3-akpm/fs/buffer.c	Tue Apr  9 22:42:56 2002
@@ -46,7 +46,6 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
-#include <linux/completion.h>
 #include <linux/compiler.h>
 
 #include <asm/uaccess.h>
@@ -2603,21 +2602,6 @@ void __init buffer_init(unsigned long me
 
 }
 
-
-/* ====================== bdflush support =================== */
-
-/* This is a simple kernel daemon, whose job it is to provide a dynamic
- * response to dirty buffers.  Once this process is activated, we write back
- * a limited number of buffers to the disks and then go back to sleep again.
- */
-
-DECLARE_WAIT_QUEUE_HEAD(bdflush_wait);
-
-void wakeup_bdflush(void)
-{
-	wake_up_interruptible(&bdflush_wait);
-}
-
 /* 
  * Here we attempt to write back old buffers.  We also try to flush inodes 
  * and supers as well, since this function is essentially "update", and 
@@ -2626,7 +2610,7 @@ void wakeup_bdflush(void)
  * and superblocks so that we could write back only the old ones as well
  */
 
-static int sync_old_buffers(void)
+static void sync_old_buffers(unsigned long dummy)
 {
 	lock_kernel();
 	sync_unlocked_inodes();
@@ -2642,10 +2626,9 @@ static int sync_old_buffers(void)
 			break;
 		if (write_some_buffers(NULL))
 			continue;
-		return 0;
+		return;
 	}
 	spin_unlock(&lru_list_lock);
-	return 0;
 }
 
 int block_sync_page(struct page *page)
@@ -2707,112 +2690,45 @@ asmlinkage long sys_bdflush(int func, lo
 	return 0;
 }
 
-/*
- * This is the actual bdflush daemon itself. It used to be started from
- * the syscall above, but now we launch it ourselves internally with
- * kernel_thread(...)  directly after the first thread in init/main.c
- */
-int bdflush(void *startup)
+static void bdflush(unsigned long pexclude)
 {
-	struct task_struct *tsk = current;
-
-	/*
-	 *	We have a bare-bones task_struct, and really should fill
-	 *	in a few more things so "top" and /proc/2/{exe,root,cwd}
-	 *	display semi-sane things. Not real crucial though...  
-	 */
-
-	tsk->session = 1;
-	tsk->pgrp = 1;
-	strcpy(tsk->comm, "bdflush");
-
-	/* avoid getting signals */
-	spin_lock_irq(&tsk->sigmask_lock);
-	flush_signals(tsk);
-	sigfillset(&tsk->blocked);
-	recalc_sigpending();
-	spin_unlock_irq(&tsk->sigmask_lock);
-
-	complete((struct completion *)startup);
-
-	for (;;) {
-		CHECK_EMERGENCY_SYNC
-
+	while (balance_dirty_state() >= 0) {
 		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NULL) || balance_dirty_state() < 0) {
-			wait_for_some_buffers(NULL);
-			interruptible_sleep_on(&bdflush_wait);
-		}
+		if (write_some_buffers(NULL) == 0)
+			break;
 	}
+	clear_bit(0, (unsigned long *)pexclude);
 }
 
-/*
- * This is the kernel update daemon. It was used to live in userspace
- * but since it's need to run safely we want it unkillable by mistake.
- * You don't need to change your userspace configuration since
- * the userspace `update` will do_exit(0) at the first sys_bdflush().
- */
-int kupdate(void *startup)
+void wakeup_bdflush(void)
 {
-	struct task_struct * tsk = current;
-	int interval;
-
-	tsk->session = 1;
-	tsk->pgrp = 1;
-	strcpy(tsk->comm, "kupdated");
-
-	/* sigstop and sigcont will stop and wakeup kupdate */
-	spin_lock_irq(&tsk->sigmask_lock);
-	sigfillset(&tsk->blocked);
-	siginitsetinv(&current->blocked, sigmask(SIGCONT) | sigmask(SIGSTOP));
-	recalc_sigpending();
-	spin_unlock_irq(&tsk->sigmask_lock);
+	static unsigned long exclude;
 
-	complete((struct completion *)startup);
-
-	for (;;) {
-		wait_for_some_buffers(NULL);
-
-		/* update interval */
-		interval = bdf_prm.b_un.interval;
-		if (interval) {
-			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(interval);
-		} else {
-		stop_kupdate:
-			tsk->state = TASK_STOPPED;
-			schedule(); /* wait for SIGCONT */
-		}
-		/* check for sigstop */
-		if (signal_pending(tsk)) {
-			int stopped = 0;
-			spin_lock_irq(&tsk->sigmask_lock);
-			if (sigismember(&tsk->pending.signal, SIGSTOP)) {
-				sigdelset(&tsk->pending.signal, SIGSTOP);
-				stopped = 1;
-			}
-			recalc_sigpending();
-			spin_unlock_irq(&tsk->sigmask_lock);
-			if (stopped)
-				goto stop_kupdate;
-		}
-#ifdef DEBUG
-		printk(KERN_DEBUG "kupdate() activated...\n");
-#endif
-		sync_old_buffers();
+	if (!test_and_set_bit(0, &exclude)) {
+		if (pdflush_operation(bdflush, (unsigned long)&exclude))
+			clear_bit(0, &exclude);
 	}
 }
 
-static int __init bdflush_init(void)
+/*
+ * kupdate
+ */
+static struct timer_list kupdate_timer;
+static void kupdate_handler(unsigned long dummy)
 {
-	static struct completion startup __initdata = COMPLETION_INITIALIZER(startup);
+	pdflush_operation(sync_old_buffers, 0);
+	mod_timer(&kupdate_timer, jiffies + bdf_prm.b_un.interval);
+}
 
-	kernel_thread(bdflush, &startup, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
-	wait_for_completion(&startup);
-	kernel_thread(kupdate, &startup, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
-	wait_for_completion(&startup);
+static int __init kupdate_init(void)
+{
+	init_timer(&kupdate_timer);
+	kupdate_timer.expires = jiffies + bdf_prm.b_un.interval;
+	kupdate_timer.data = 0;
+	kupdate_timer.function = kupdate_handler;
+	add_timer(&kupdate_timer);
 	return 0;
 }
 
-module_init(bdflush_init)
+module_init(kupdate_init)
 
-
