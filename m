Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVEYNy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVEYNy3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVEYNy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:54:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50897 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262345AbVEYNyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:54:17 -0400
Date: Wed, 25 May 2005 15:51:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050525135130.GA27088@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525052400.46bccf26.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > --- linux/arch/x86_64/kernel/process.c.orig
> > +++ linux/arch/x86_64/kernel/process.c
> > @@ -162,6 +162,8 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
> >   */
> >  void cpu_idle (void)
> >  {
> > +	set_tsk_need_resched(current);
> > +
> >  	/* endless idle loop with no priority at all */
> >  	while (1) {
> >  		while (!need_resched()) {
> 
> ia64 needed this treatment also to fix a hang during boot.  u o me 3 hrs.
> 
> Are all the other architectures busted as well?

oh damn, they are indeed, because they need to hit schedule() at least 
once.

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
+	 * at least one to get things moving:
+	 */
+	schedule();
+
 	cpu_idle();
 } 
 
