Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSGDXrX>; Thu, 4 Jul 2002 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGDXrC>; Thu, 4 Jul 2002 19:47:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315179AbSGDXqD>;
	Thu, 4 Jul 2002 19:46:03 -0400
Message-ID: <3D24E032.F0793112@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/27] set TASK_RUNNING in cond_resched()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



do_select() does set_current_state(TASK_INTERRUPTIBLE) then calls
__pollwait() which calls __get_free_page() and the cond_resched() which
I added to the pagecache reclaim code never returns.

The patch makes cond_resched() more useful by setting current->state to
TASK_RUNNING before scheduling.




 include/linux/sched.h |    3 ++-
 kernel/ksyms.c        |    1 +
 kernel/sched.c        |    6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- 2.5.24/include/linux/sched.h~cond_resched-fix	Thu Jul  4 16:17:17 2002
+++ 2.5.24-akpm/include/linux/sched.h	Thu Jul  4 16:22:11 2002
@@ -837,10 +837,11 @@ static inline int need_resched(void)
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
 
+extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
 	if (need_resched())
-		schedule();
+		__cond_resched();
 }
 
 /* Reevaluate whether the task has signals pending delivery.
--- 2.5.24/kernel/sched.c~cond_resched-fix	Thu Jul  4 16:17:17 2002
+++ 2.5.24-akpm/kernel/sched.c	Thu Jul  4 16:22:11 2002
@@ -1447,6 +1447,12 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
+void __cond_resched(void)
+{
+	set_current_state(TASK_RUNNING);
+	schedule();
+}
+
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret = -EINVAL;
--- 2.5.24/kernel/ksyms.c~cond_resched-fix	Thu Jul  4 16:17:17 2002
+++ 2.5.24-akpm/kernel/ksyms.c	Thu Jul  4 16:22:11 2002
@@ -473,6 +473,7 @@ EXPORT_SYMBOL(preempt_schedule);
 #endif
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(sys_sched_yield);
+EXPORT_SYMBOL(__cond_resched);
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);
 EXPORT_SYMBOL_GPL(idle_cpu);

-
