Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSGDXrU>; Thu, 4 Jul 2002 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGDXrR>; Thu, 4 Jul 2002 19:47:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38413 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315182AbSGDXqG>;
	Thu, 4 Jul 2002 19:46:06 -0400
Message-ID: <3D24E035.6C42FC13@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/27] set TASK_RUNNING in yield()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It seems that the yield() macro requires state TASK_RUNNING, but
practically none of the callers remember to do that.

The patch turns yield() into a real function which sets state
TASK_RUNNING before scheduling.



 drivers/net/e100/e100.h |    8 --------
 fs/buffer.c             |    1 -
 include/linux/sched.h   |    3 +--
 kernel/ksyms.c          |    2 +-
 kernel/sched.c          |    6 ++++++
 kernel/softirq.c        |    1 -
 kernel/suspend.c        |    3 +--
 mm/page_alloc.c         |    1 -
 8 files changed, 9 insertions(+), 16 deletions(-)

--- 2.5.24/include/linux/sched.h~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/include/linux/sched.h	Thu Jul  4 16:22:09 2002
@@ -418,8 +418,7 @@ extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int idle_cpu(int cpu);
 
-asmlinkage long sys_sched_yield(void);
-#define yield() sys_sched_yield()
+void yield(void);
 
 /*
  * The default (Linux) execution domain.
--- 2.5.24/kernel/sched.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/kernel/sched.c	Thu Jul  4 16:17:21 2002
@@ -1453,6 +1453,12 @@ void __cond_resched(void)
 	schedule();
 }
 
+void yield(void)
+{
+	set_current_state(TASK_RUNNING);
+	sys_sched_yield();
+}
+
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret = -EINVAL;
--- 2.5.24/kernel/ksyms.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/kernel/ksyms.c	Thu Jul  4 16:17:21 2002
@@ -472,7 +472,7 @@ EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(preempt_schedule);
 #endif
 EXPORT_SYMBOL(schedule_timeout);
-EXPORT_SYMBOL(sys_sched_yield);
+EXPORT_SYMBOL(yield);
 EXPORT_SYMBOL(__cond_resched);
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);
--- 2.5.24/fs/buffer.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/fs/buffer.c	Thu Jul  4 16:22:09 2002
@@ -494,7 +494,6 @@ static void free_more_memory(void)
 	wakeup_bdflush();
 	try_to_free_pages(zone, GFP_NOFS, 0);
 	blk_run_queues();
-	__set_current_state(TASK_RUNNING);
 	yield();
 }
 
--- 2.5.24/kernel/softirq.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/kernel/softirq.c	Thu Jul  4 16:17:21 2002
@@ -262,7 +262,6 @@ void tasklet_kill(struct tasklet_struct 
 		printk("Attempt to kill tasklet from interrupt\n");
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		current->state = TASK_RUNNING;
 		do
 			yield();
 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
--- 2.5.24/kernel/suspend.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/kernel/suspend.c	Thu Jul  4 16:17:21 2002
@@ -237,8 +237,7 @@ int freeze_processes(void)
 			todo++;
 		}
 		read_unlock(&tasklist_lock);
-		sys_sched_yield();
-		schedule();
+		yield();
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			PRINTK( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
--- 2.5.24/mm/page_alloc.c~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/mm/page_alloc.c	Thu Jul  4 16:22:10 2002
@@ -441,7 +441,6 @@ nopage:
 		goto nopage;
 
 	/* Yield for kswapd, and try again */
-	__set_current_state(TASK_RUNNING);
 	yield();
 	goto rebalance;
 }
--- 2.5.24/drivers/net/e100/e100.h~yield-fix	Thu Jul  4 16:17:21 2002
+++ 2.5.24-akpm/drivers/net/e100/e100.h	Thu Jul  4 16:17:21 2002
@@ -1031,14 +1031,6 @@ extern unsigned char e100_selftest(struc
 extern unsigned char e100_get_link_state(struct e100_private *bdp);
 extern unsigned char e100_wait_scb(struct e100_private *bdp);
 
-#ifndef yield
-#define yield()					\
-        do {					\
-                current->policy |= SCHED_YIELD;	\
-                schedule();			\
-        } while (0)                                     
-#endif
-
 extern void e100_deisolate_driver(struct e100_private *bdp,
 				  u8 recover, u8 full_reset);
 extern unsigned char e100_hw_reset_recover(struct e100_private *bdp,

-
