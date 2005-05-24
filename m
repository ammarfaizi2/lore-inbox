Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVEXMQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVEXMQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVEXMQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:16:31 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59628 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262014AbVEXMP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:15:57 -0400
Date: Tue, 24 May 2005 14:15:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050524121541.GA17049@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch (ontop of the current -mm scheduler patchset, in particular 
ontop of Nick's idle-thread optimization patches) tweaks cpu_idle() 
semantics a bit: it changes the idle loops (that do preemption) to call 
the first schedule() without checking for need_resched().

the advantage is that as a result we dont have to set the idle thread's 
NEED_RESCHED flag in init_idle(), which in turn makes cond_resched() 
even more of an invariant: it can be called even from init code without 
it having any effect. A cond resched in the init codepath hangs 
otherwise.

this patch, while having no negative side-effects, enables wider use of
cond_resched()s. (which might happen in the stock kernel too, but it's
particulary important for voluntary-preempt)

(note that for now this patch only covers architectures that use 
kernel/Kconfig.preempt, but all other architectures will work just fine 
too.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/process.c   |    2 +-
 arch/ppc64/kernel/idle.c     |   11 +++++------
 arch/x86_64/kernel/process.c |    3 +--
 kernel/sched.c               |   12 +++++++++++-
 4 files changed, 18 insertions(+), 10 deletions(-)

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -4163,6 +4163,17 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+/**
+ * init_idle - set up an idle thread for a given CPU
+ * @idle: task in question
+ * @cpu: cpu the idle task belongs to
+ *
+ * NOTE: this function does not set the idle thread's NEED_RESCHED
+ * flag, to make booting more robust. Architecture-level cpu_idle()
+ * functions should structure their idle loop to call the first
+ * schedule() unconditionally, and to check for need_resched() only
+ * afterwards.
+ */
 void __devinit init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
@@ -4180,7 +4191,6 @@ void __devinit init_idle(task_t *idle, i
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	idle->oncpu = 1;
 #endif
-	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
--- linux/arch/x86_64/kernel/process.c.orig
+++ linux/arch/x86_64/kernel/process.c
@@ -164,6 +164,7 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		schedule();
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -176,8 +177,6 @@ void cpu_idle (void)
 				idle = default_idle;
 			idle();
 		}
-
-		schedule();
 	}
 }
 
--- linux/arch/ppc64/kernel/idle.c.orig
+++ linux/arch/ppc64/kernel/idle.c
@@ -86,6 +86,7 @@ static int iSeries_idle(void)
 	lpaca = get_paca();
 
 	while (1) {
+		schedule();
 		if (lpaca->lppaca.shared_proc) {
 			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
 				process_iSeries_events();
@@ -110,8 +111,6 @@ static int iSeries_idle(void)
 				set_need_resched();
 			}
 		}
-
-		schedule();
 	}
 
 	return 0;
@@ -125,6 +124,10 @@ static int default_idle(void)
 	unsigned int cpu = smp_processor_id();
 
 	while (1) {
+		schedule();
+		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
+			cpu_die();
+
 		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
 
 		if (!oldval) {
@@ -145,10 +148,6 @@ static int default_idle(void)
 		} else {
 			set_need_resched();
 		}
-
-		schedule();
-		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-			cpu_die();
 	}
 
 	return 0;
--- linux/arch/i386/kernel/process.c.orig
+++ linux/arch/i386/kernel/process.c
@@ -181,6 +181,7 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		schedule();
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -199,7 +200,6 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
-		schedule();
 	}
 }
 
