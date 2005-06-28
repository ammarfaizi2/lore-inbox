Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVF1OoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVF1OoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVF1Omz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:42:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48809 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261734AbVF1Ok5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:40:57 -0400
Date: Tue, 28 Jun 2005 16:40:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12-git8 Voluntary preempt hangs at boot
Message-ID: <20050628144041.GA713@elte.hu>
References: <20050627161405.60490ec3.thatistosayiseenem@gawab.com> <20050628072718.GA3755@elte.hu> <20050628150959.728ac18a.thatistosayiseenem@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628150959.728ac18a.thatistosayiseenem@gawab.com>
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


* Ash Milsted <thatistosayiseenem@gawab.com> wrote:

> Yes, this solves the problem. Cheers.

thanks! Andrew, Linus, would be nice to commit this one:

--------
Subject: sched-tweak-idle-thread-setup-semantics.patch
From: Ingo Molnar <mingo@elte.hu>

This patch tweaks idle thread setup semantics a bit: instead of setting
NEED_RESCHED in init_idle(), we do an explicit schedule() before calling
into cpu_idle().

This patch, while having no negative side-effects, enables wider use of
cond_resched()s.  (which might happen in the stock kernel too, but it's
particulary important for voluntary-preempt)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 init/main.c    |    7 +++++++
 kernel/sched.c |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff -puN init/main.c~sched-tweak-idle-thread-setup-semantics init/main.c
--- 25/init/main.c~sched-tweak-idle-thread-setup-semantics	2005-06-25 01:17:13.000000000 -0700
+++ 25-akpm/init/main.c	2005-06-25 01:17:13.000000000 -0700
@@ -383,6 +383,13 @@ static void noinline rest_init(void)
 	numa_default_policy();
 	unlock_kernel();
 	preempt_enable_no_resched();
+
+	/*
+	 * The boot idle thread must execute schedule()
+	 * at least one to get things moving:
+	 */
+	schedule();
+
 	cpu_idle();
 } 
 
diff -puN kernel/sched.c~sched-tweak-idle-thread-setup-semantics kernel/sched.c
--- 25/kernel/sched.c~sched-tweak-idle-thread-setup-semantics	2005-06-25 01:17:13.000000000 -0700
+++ 25-akpm/kernel/sched.c	2005-06-25 01:17:13.000000000 -0700
@@ -4178,6 +4178,14 @@ void show_state(void)
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
@@ -4195,7 +4203,6 @@ void __devinit init_idle(task_t *idle, i
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	idle->oncpu = 1;
 #endif
-	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
_
