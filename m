Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVE0I6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVE0I6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVE0I6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:58:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5512 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262383AbVE0I6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:58:23 -0400
Date: Fri, 27 May 2005 10:57:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve SMP reschedule and idle routines
Message-ID: <20050527085726.GA20512@elte.hu>
References: <4296CA7A.4050806@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296CA7A.4050806@cyberone.com.au>
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


* Nick Piggin <piggin@cyberone.com.au> wrote:

> OK, done a bit of work on all other architectures, and diffed to the
> latest -mm. Any chance you can put it in -mm, Andrew?
> 
> Also, while I was there, I thought I'd add the set_need_resched() 
> thing to all the other architectures. I couldn't be bothered doing 2 
> patches, sorry.

the need_resched changes are not needed meanwhile - we can do the first 
schedule() in rest_init() just fine. (See my earlier patch below.) So 
please keep the need_resched thing out of your patch.

----
The patch below should address this problem for all architectures, by 
doing an explicit schedule() in the init code before calling into 
cpu_idle(). It's a replacement for the following patch:

 sched-remove-set_tsk_need_resched-from-init_idle.patch

	Ingo

--

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
 
