Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTLTUJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 15:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTLTUJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 15:09:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:38368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbTLTUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 15:09:17 -0500
Date: Sat, 20 Dec 2003 12:07:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
In-Reply-To: <20031220192238.GA30970@elte.hu>
Message-ID: <Pine.LNX.4.58.0312201140320.29271@home.osdl.org>
References: <3FE46885.2030905@cyberone.com.au> <20031220192238.GA30970@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Dec 2003, Ingo Molnar wrote:
> 
> i'd prefer the much simpler patch below. This also keeps the kernel
> preemption logic isolated instead of mixing it into the normal path.

That patch still gets several cases wrong: we don't update any counters at
all for the case where we were TASK_INTERRUPTIBLE and we got made
TASK_RUNNING because of having a signal pending.

Also, we shouldn't update the context switch counter just because we 
entered the scheduler. If we don't actually end up switching to anything 
else, it shouldn't count as a context switch.

So how about something like this?

Totally untested. Comments?

		Linus

---
===== kernel/sched.c 1.225 vs edited =====
--- 1.225/kernel/sched.c	Mon Dec  1 16:00:00 2003
+++ edited/kernel/sched.c	Sat Dec 20 12:05:56 2003
@@ -1470,6 +1470,7 @@
  */
 asmlinkage void schedule(void)
 {
+	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
@@ -1516,22 +1517,16 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
-		goto pick_next_task;
-
-	switch (prev->state) {
-	case TASK_INTERRUPTIBLE:
-		if (unlikely(signal_pending(prev))) {
+	switch_count = &prev->nivcsw;
+	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
+		switch_count = &prev->nvcsw;
+		if ((prev->state & TASK_INTERRUPTIBLE) && unlikely(signal_pending(prev))) {
 			prev->state = TASK_RUNNING;
-			break;
+		} else {
+			deactivate_task(prev, rq);
 		}
-	default:
-		deactivate_task(prev, rq);
-		prev->nvcsw++;
-		break;
-	case TASK_RUNNING:
-		prev->nivcsw++;
 	}
+
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
@@ -1588,6 +1583,7 @@
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
+		++*switch_count;
 
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
