Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUEWXFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUEWXFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUEWXFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:05:07 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:32398 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263714AbUEWXEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:04:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 May 2004 16:04:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scheduler: IRQs disabled over context switches
In-Reply-To: <20040523203814.C21153@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0405231241450.512@bigblue.dev.mdolabs.com>
References: <20040523174359.A21153@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com>
 <20040523203814.C21153@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Russell King wrote:

> Not quite - look harder.  They use spin_unlock_irq in finish_arch_switch
> rather than prepare_arch_switch.

Hmm, they do indeed. Hmm, if we release the rq lock before the ctx switch, 
"prev" (the real one) will result not running since we already set 
"rq->curr" to "next" (and we do not hold "prev->switch_lock"). So another 
CPU might see "prev" as free-to-pull, while we're still playing with its 
fields. Even in UP, we will have a window of time where "rq->curr" is 
different from "current", with IRQ enabled (time tick). IMO we have two 
problems in releasing the "rq->lock" and enabling IRQs. One is that "prev" 
will result free-to-steal from another CPU (after "rq->curr" is set to 
"next"). The other one is the timer tick, that might screw us up while 
switching. OTOH we cannot enable IRQs while holding the "rq->lock" for 
obvious reasons. Maybe something like below. With preempt, we already have 
the preempt_disable() at the beginning of schedule(), so the timer tick 
will not issue a reschedule on return.



- Davide



Index: kernel/sched.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/kernel/sched.c,v
retrieving revision 1.303
diff -u -r1.303 sched.c
--- a/kernel/sched.c	21 May 2004 20:17:47 -0000	1.303
+++ b/kernel/sched.c	23 May 2004 22:20:29 -0000
@@ -220,6 +220,8 @@
 	prio_array_t *active, *expired, arrays[2];
 	int best_expired_prio;
 	atomic_t nr_iowait;
+	task_t *prev;
+	atomic_t in_ctx_switch;
 
 #ifdef CONFIG_SMP
 	struct sched_domain *sd;
@@ -243,13 +245,20 @@
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define rq_switching(rq)        atomic_read(&rq->in_ctx_switch)
+
 /*
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
-# define prepare_arch_switch(rq, next)	do { } while (0)
-# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define prepare_arch_switch(rq, next)  \
+do {                                    \
+	rq->prev = current;             \
+	atomic_inc(&rq->in_ctx_switch); \
+	spin_unlock_irq(&(rq)->lock);   \
+} while (0)
+# define finish_arch_switch(rq, next)	atomic_dec(&rq->in_ctx_switch)
+# define task_running(rq, p)		((rq)->curr == (p) || (rq_switching(rq) && rq->prev == (p)))
 #endif
 
 /*
@@ -1966,6 +1975,9 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	if (rq_switching(rq))
+		return;
+
 	rq->timestamp_last_tick = sched_clock();
 
 	if (rcu_pending(cpu))
@@ -3915,6 +3927,8 @@
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
 		atomic_set(&rq->nr_iowait, 0);
+		atomic_set(&rq->in_ctx_switch, 0);
+		rq->prev = NULL;
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
