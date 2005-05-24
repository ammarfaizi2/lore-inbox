Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVEXPzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVEXPzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVEXPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:46:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7879 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262119AbVEXPmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:42:45 -0400
Date: Tue, 24 May 2005 17:42:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050524154230.GA17814@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524152759.GA15411@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > > we could do it in the other direction just as much - i only touched 
> > > 3 architectures. Up to Andrew i guess.
> > 
> > How about just setting need_resched at the start of the cpu_idle 
> > function instead? Rather than changing the structure of the idle loops 
> > themselves. That would suit me best.
> 
> that's fine with me too.

updated patch below.

--

this patch (ontop of the current -mm scheduler patchset) tweaks 
cpu_idle() semantics a bit: it changes the idle loops (that do 
preemption) to call the first schedule() unconditionally.

the advantage is that as a result we dont have to set the idle thread's 
NEED_RESCHED flag in init_idle(), which in turn makes cond_resched() 
even more of an invariant: it can be called even from init code without 
it having any effect. A cond resched in the init codepath hangs 
otherwise.

this patch, while having no negative side-effects, enables wider use of 
cond_resched()s. (which might happen in the stock kernel too, but it's 
particulary important for voluntary-preempt) (note that for now this 
patch only covers architectures that use kernel/Kconfig.preempt, but all 
other architectures will work just fine too.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/process.c   |    2 ++
 arch/ppc64/kernel/idle.c     |    1 +
 arch/x86_64/kernel/process.c |    2 ++
 kernel/sched.c               |   10 +++++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -4163,6 +4163,15 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+/**
+ * init_idle - set up an idle thread for a given CPU
+ * @idle: task in question
+ * @cpu: cpu the idle task belongs to
+ *
+ * NOTE: this function does not set the idle thread's NEED_RESCHED
+ * flag, to make booting more robust. Architecture-level cpu_idle()
+ * functions should set it explicitly, before entering their idle-loop.
+ */
 void __devinit init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
@@ -4180,7 +4189,6 @@ void __devinit init_idle(task_t *idle, i
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	idle->oncpu = 1;
 #endif
-	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
--- linux/arch/x86_64/kernel/process.c.orig
+++ linux/arch/x86_64/kernel/process.c
@@ -162,6 +162,8 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void cpu_idle (void)
 {
+	set_tsk_need_resched(current);
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
--- linux/arch/ppc64/kernel/idle.c.orig
+++ linux/arch/ppc64/kernel/idle.c
@@ -305,6 +305,7 @@ static int native_idle(void)
 
 void cpu_idle(void)
 {
+	set_tsk_need_resched(current);
 	idle_loop();
 }
 
--- linux/arch/i386/kernel/process.c.orig
+++ linux/arch/i386/kernel/process.c
@@ -179,6 +179,8 @@ void cpu_idle(void)
 {
 	int cpu = _smp_processor_id();
 
+	set_tsk_need_resched(current);
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
