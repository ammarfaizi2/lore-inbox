Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUKANB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUKANB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKANB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:01:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46021 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261777AbUKAMua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:50:30 -0500
Date: Mon, 1 Nov 2004 13:51:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101125127.GA13442@elte.hu>
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041101115546.GA2620@elte.hu> <20041101123701.GA4443@elte.hu> <1099312527.3337.5.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1099312527.3337.5.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> I'm doing some tests from my RT environment on 0.6.2. I'm quite sure,
> that interrupts are sporadically disabled for > 200µs. Did you change
> anything relevant to this between 0.6.2 and 0.6.4 ?

hm, i changed the task-exit schedule() to be called with irqs-off and
__schedule() - but that should be fine. I've attached the delta diff -
there's nothing suspicious at first sight. Maybe -V0.6.4 just made some
already existing bug more likely to trigger? I am too seeing rtc_wakeup
weirdnesses that were not present in earlier -V0.6 kernels.

	Ingo

--- linux.old/Makefile	
+++ linux.new/Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 9
-EXTRAVERSION = -mm1-RT-V0.6.2
+EXTRAVERSION = -mm1-RT-V0.6.4
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
--- linux.old/kernel/exit.c	
+++ linux.new/kernel/exit.c	
@@ -840,9 +840,9 @@ asmlinkage NORET_TYPE void do_exit(long 
 #endif
 	check_no_held_locks(tsk);
 	/* PF_DEAD causes final put_task_struct after we schedule. */
-	wmb();
+	local_irq_disable();
 	tsk->flags |= PF_DEAD;
-	schedule();
+	__schedule();
 	BUG();
 	/* Avoid "noreturn function does return".  */
 	for (;;) ;
--- linux.old/kernel/sched.c	
+++ linux.new/kernel/sched.c	
@@ -599,13 +599,11 @@ static inline void enqueue_task_head(str
  *
  * Both properties are important to certain workloads.
  */
-static int effective_prio(task_t *p)
+
+static inline int __effective_prio(task_t *p)
 {
 	int bonus, prio;
 
-	if (rt_task(p))
-		return p->prio;
-
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
@@ -616,6 +614,13 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
+static int effective_prio(task_t *p)
+{
+	if (rt_task(p))
+		return p->prio;
+	return __effective_prio(p);
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
@@ -3540,8 +3545,7 @@ int mutex_getprio(task_t *p)
 	if (p->policy != SCHED_NORMAL)
 		return MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
-//		return effective_prio(p);
-		return p->static_prio;
+		return __effective_prio(p);
 }
 
 /*
@@ -3559,15 +3563,14 @@ void mutex_setprio(task_t *p, int prio)
 
 	rq = task_rq_lock(p, &flags);
 
+	oldprio = p->prio;
 	array = p->array;
 	if (array)
-		deactivate_task(p, rq);
-	oldprio = p->prio;
-
+		dequeue_task(p, array);
 	p->prio = prio;
 
 	if (array) {
-		__activate_task(p, rq);
+		enqueue_task(p, array);
 		/*
 		 * Reschedule if we are currently running on this runqueue and
 		 * our priority decreased, or if we are not currently running on
--- linux.old/kernel/timer.c	
+++ linux.new/kernel/timer.c	
@@ -956,23 +956,25 @@ EXPORT_SYMBOL(xtime_lock);
  */
 static inline void update_times(void)
 {
+	unsigned long ticks = 0;
 	/*
 	 * First test outside the lock for performance reasons:
 	 */
-	if (jiffies - wall_jiffies) {
+	if (jiffies != wall_jiffies) {
 		unsigned long flags;
 
 		write_seqlock_irqsave(&xtime_lock, flags);
-		while (jiffies - wall_jiffies) {
+		while (jiffies != wall_jiffies) {
 			wall_jiffies++;
+			ticks++;
 			update_wall_time(1);
-			calc_load(1);
 			if (seqlock_need_resched(&xtime_lock)) {
 				write_sequnlock_irqrestore(&xtime_lock, flags);
 				cond_resched();
 				write_seqlock_irqsave(&xtime_lock, flags);
 			}
 		}
+		calc_load(ticks);
 		write_sequnlock_irqrestore(&xtime_lock, flags);
 	}
 }
