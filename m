Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270130AbUJTM4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270130AbUJTM4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270276AbUJTMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:54:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4509 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270204AbUJTMxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:53:47 -0400
Date: Wed, 20 Oct 2004 14:55:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020125500.GA8693@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041020145019.176826cb@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020145019.176826cb@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> i just wanted to let you know that with U8 i still experience the
> "pauses" i reported on U6, too. I would guess that it's some scheduler
> thing as jackd running SCHED_FIFO and all its clients (at least the
> audio threads running SCHED_FIFO) are not affected by the pauses (i
> don't see any xruns from jackd and audio processing happily goes along
> without audible dropouts).

ok.

> Also it seems that /proc/sys/kernel/trace_enabled == 1 is not the only
> thing being able to trigger the pauses. With U6 i also experienced
> them with trace_enabled == 0. I have to add though that it took quite
> a while for them to kick in (hours) after setting trace_enabled to 0.
> So my conclusion is that trace_enabled == 1 just increases the
> probability of such pauses by several magnitudes (with 1 i get about
> one of these pauses per 2-10 minutes, with 0 it took several hours for
> the first pause to occur and then they stayed less frequent than with
> 1).

i dont think it's caused by trace_enabled - the trace you sent last time
clearly showed erratic behavior. There's one piece of code i suspect in
particular - could you try the patch below ontop of -U8? (i have
compile- and boot- tested it)

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2764,6 +2764,8 @@ need_resched:
 		else
 			deactivate_task(prev, rq);
 	}
+	if (preempt_count() & PREEMPT_ACTIVE)
+		sub_preempt_count(PREEMPT_ACTIVE);
 	if (unlikely(prev->flags & PF_DEAD)) {
 		BUG_ON(prev->state != TASK_RUNNING);
 		prev->state = __TASK_DEAD;
@@ -2940,6 +2942,7 @@ asmlinkage void __sched preempt_schedule
 		return;
 
 need_resched:
+	local_irq_disable();
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
@@ -2950,11 +2953,10 @@ need_resched:
 	saved_lock_depth = task->lock_depth;
 	task->lock_depth = -1;
 #endif
-	schedule();
+	__schedule();
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
 #endif
-	sub_preempt_count(PREEMPT_ACTIVE);
 
 	/* we could miss a preemption opportunity between schedule and now */
 	barrier();
@@ -3002,7 +3004,6 @@ need_resched:
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
 #endif
-	sub_preempt_count(PREEMPT_ACTIVE);
 
 	/* we could miss a preemption opportunity between schedule and now */
 	barrier();
@@ -3842,9 +3843,9 @@ static inline void __cond_resched(void)
 	if (preempt_count() & PREEMPT_ACTIVE)
 		return;
 	do {
+		local_irq_disable();
 		add_preempt_count(PREEMPT_ACTIVE);
-		schedule();
-		sub_preempt_count(PREEMPT_ACTIVE);
+		__schedule();
 	} while (need_resched());
 }
 
