Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVE0JhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVE0JhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVE0JhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:37:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48008 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262408AbVE0J2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:28:01 -0400
Date: Fri, 27 May 2005 11:20:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve SMP reschedule and idle routines
Message-ID: <20050527092024.GA27567@elte.hu>
References: <4296CA7A.4050806@cyberone.com.au> <20050527085726.GA20512@elte.hu> <4296E45B.1080509@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296E45B.1080509@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >the need_resched changes are not needed meanwhile - we can do the first 
> >schedule() in rest_init() just fine. (See my earlier patch below.) So 
> >please keep the need_resched thing out of your patch.
> >
> 
> OK that's better. Sorry I didn't see your patch earlier.
> 
> I'll redo this patch. Coming up...

Andrew: please drop the following two patches:

 sched-remove-set_tsk_need_resched-from-init_idle-v2.patch
 sched-remove-set_tsk_need_resched-from-init_idle-v2-ia64-fix.patch

and add the one below. The only followup patch 
(sched-voluntary-kernel-preemption.patch) should still apply cleanly.  
Nick's upcoming patch can then come afterwards.

----

This patch tweaks idle thread setup semantics a bit: instead of setting
NEED_RESCHED in init_idle(), we do an explicit schedule() before
calling into cpu_idle().

This patch, while having no negative side-effects, enables wider use of 
cond_resched()s.  (which might happen in the stock kernel too, but it's 
particulary important for voluntary-preempt)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -4163,6 +4163,14 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+/**
+ * init_idle - set up an idle thread for a given CPU
+ * @idle: task in question
+ * @cpu: cpu the idle task belongs to
+ *
+ * NOTE: this function does not set the idle thread's NEED_RESCHED
+ * flag, to make booting more robust.
+ */
 void __devinit init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
@@ -4180,7 +4188,6 @@ void __devinit init_idle(task_t *idle, i
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	idle->oncpu = 1;
 #endif
-	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
--- linux/init/main.c.orig
+++ linux/init/main.c
@@ -383,6 +383,13 @@ static void noinline rest_init(void)
 	numa_default_policy();
 	unlock_kernel();
 	preempt_enable_no_resched();
+
+	/*
+	 * The boot idle thread must execute schedule()
+	 * at least once to get things moving:
+	 */
+	schedule();
+
 	cpu_idle();
 } 
 

