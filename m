Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFAHjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFAHjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVFAHjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:39:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21181 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261304AbVFAHjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:39:08 -0400
Date: Wed, 1 Jun 2005 09:35:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Message-ID: <20050601073544.GA21384@elte.hu>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
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


Pekka, could you check whether the patch below solves your Wine problem 
(without hurting interactivity otherwise)?

	Ingo

----

this patch implements a task state bit (TASK_NONINTERACTIVE), which can 
be used by blocking points to mark the task's wait as "non-interactive".
This does not mean the task will be considered a CPU-hog - the wait will
simply not have an effect on the waiting task's priority - positive or
negative alike. Right now only pipe_wait() will make use of it, because
it's a common source of not-so-interactive waits (kernel compilation
jobs, etc.).

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/pipe.c.orig
+++ linux/fs/pipe.c
@@ -39,7 +39,11 @@ void pipe_wait(struct inode * inode)
 {
 	DEFINE_WAIT(wait);
 
-	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
+	/*
+	 * Pipes are system-local resources, so sleeping on them
+	 * is considered a noninteractive wait:
+	 */
+	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	up(PIPE_SEM(*inode));
 	schedule();
 	finish_wait(PIPE_WAIT(*inode), &wait);
--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -1085,6 +1085,16 @@ out_activate:
 	}
 
 	/*
+	 * Tasks that have marked their sleep as noninteractive get
+	 * woken up without updating their sleep average. (i.e. their
+	 * sleep is handled in a priority-neutral manner, no priority
+	 * boost and no penalty.)
+	 */
+	if (old_state & TASK_NONINTERACTIVE)
+		__activate_task(p, rq);
+	else
+		activate_task(p, rq, cpu == this_cpu);
+	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
 	 * don't trigger a preemption, if the woken up task will run on
@@ -1092,7 +1102,6 @@ out_activate:
 	 * the waker guarantees that the freshly woken up task is going
 	 * to be considered on this CPU.)
 	 */
-	activate_task(p, rq, cpu == this_cpu);
 	if (!sync || cpu != this_cpu) {
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -112,6 +112,7 @@ extern unsigned long nr_iowait(void);
 #define TASK_TRACED		8
 #define EXIT_ZOMBIE		16
 #define EXIT_DEAD		32
+#define TASK_NONINTERACTIVE	64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
