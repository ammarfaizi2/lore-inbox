Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUINJRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUINJRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269229AbUINJPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:15:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64949 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269227AbUINJOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:14:32 -0400
Date: Tue, 14 Sep 2004 11:15:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] preempt-cleanup.patch, 2.6.9-rc2
Message-ID: <20040914091529.GA21553@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch is ontop of preempt-smp.patch. This is another
generic fallout from the voluntary-preempt patchset: a cleanup of the
cond_resched() infrastructure, in preparation of the latency reduction
patches. The changes:

 - uninline cond_resched() - this makes the footprint smaller,
   especially once the number of cond_resched() points increase.

 - add a 'was rescheduled' return value to cond_resched. This makes it
   symmetric to cond_resched_lock() and later latency reduction patches
   rely on the ability to tell whether there was any preemption.

 - make cond_resched() more robust by using the same mechanism as
   preempt_kernel(): by using PREEMPT_ACTIVE. This preserves the task's
   state - e.g. if the task is in TASK_ZOMBIE but gets preempted via
   cond_resched() just prior scheduling off then this approach preserves
   TASK_ZOMBIE.

 - the patch also adds need_lockbreak() which critical sections can use 
   to detect lock-break requests.

i've tested the patch on x86 SMP and UP.

	Ingo

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-cleanup.patch"


the attached patch is ontop of preempt-smp.patch. This is another
generic fallout from the voluntary-preempt patchset: a cleanup of the
cond_resched() infrastructure, in preparation of the latency reduction
patches. The changes:

 - uninline cond_resched() - this makes the footprint smaller,
   especially once the number of cond_resched() points increase.

 - add a 'was rescheduled' return value to cond_resched. This makes it
   symmetric to cond_resched_lock() and later latency reduction patches
   rely on the ability to tell whether there was any preemption.

 - make cond_resched() more robust by using the same mechanism as
   preempt_kernel(): by using PREEMPT_ACTIVE. This preserves the task's
   state - e.g. if the task is in TASK_ZOMBIE but gets preempted via
   cond_resched() just prior scheduling off then this approach preserves
   TASK_ZOMBIE.

 - the patch also adds need_lockbreak() which critical sections can use
   to detect lock-break requests.

i've tested the patch on x86 SMP and UP.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -951,15 +951,24 @@ static inline int need_resched(void)
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
 
-extern void __cond_resched(void);
-static inline void cond_resched(void)
-{
-	if (need_resched())
-		__cond_resched();
-}
-
+/*
+ * cond_resched() and cond_resched_lock(): latency reduction via
+ * explicit rescheduling in places that are safe. The return
+ * value indicates whether a reschedule was done in fact.
+ */
+extern int cond_resched(void);
 extern int cond_resched_lock(spinlock_t * lock);
 
+/*
+ * Does a critical section need to be broken due to another
+ * task waiting?:
+ */
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+# define need_lockbreak(lock) ((lock)->break_lock)
+#else
+# define need_lockbreak(lock) 0
+#endif
+
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
    callers must hold sighand->siglock.  */
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -3539,13 +3539,25 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-void __sched __cond_resched(void)
+static inline void __cond_resched(void)
 {
-	set_current_state(TASK_RUNNING);
-	schedule();
+	do {
+		preempt_count() += PREEMPT_ACTIVE;
+		schedule();
+		preempt_count() -= PREEMPT_ACTIVE;
+	} while (need_resched());
 }
 
-EXPORT_SYMBOL(__cond_resched);
+int __sched cond_resched(void)
+{
+	if (need_resched()) {
+		__cond_resched();
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched);
 
 /*
  * cond_resched_lock() - if a reschedule is pending, drop the given lock,
@@ -3568,8 +3580,7 @@ int cond_resched_lock(spinlock_t * lock)
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
-		set_current_state(TASK_RUNNING);
-		schedule();
+		__cond_resched();
 		spin_lock(lock);
 		return 1;
 	}

--mP3DRpeJDSE+ciuQ--
