Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVLNPoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVLNPoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVLNPoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:44:15 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:19426 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932622AbVLNPoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:44:14 -0500
Subject: [PATCH -RT] Add softirq waitqueue for CONFIG_PREEMPT_SOFTIRQ (was:
	Re: [ANNOUNCE] 2.6.15-rc5-hrt2 ...)
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134568867.4275.7.camel@tglx.tec.linutronix.de>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1134568080.18921.42.camel@localhost.localdomain>
	 <1134568867.4275.7.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:43:42 -0500
Message-Id: <1134575022.18921.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 15:01 +0100, Thomas Gleixner wrote:
> > 
> > So the fix to this, in the case of preempting the softirq, that we need
> > to introduce some wait queue that will allow processes to wait for the
> > softirq to finish, and then the softirq will wake up all the processes.
> 
> We had the waitqueue in the ktimer based -rt patches and did not add it
> back.

Ingo,

This patch fixes the problem I have.  I've added a waitqueue per all
softirq threads IFF a CONFIG_PREEMPT_SOFTIRQ is set.

When a softirqd is running, it sets a flag saying it is (this can
probably be done better), and then executes what it needs to.  Before
going back to sleep, it clears the flag and wakes up any processes that
might be waiting to be woken up when it is done.

I added the function wait_for_softirq(int softirq) that is a no-op when
CONFIG_PREEMPT_SOFTIRQ is off.  This function will add the process to
the wait queue of the softirq that it is waiting to finish.

I really would like to add priority inheritance to waitqueues, so things
like this can benefit from PI as well.

Take a look, and let me know what you think.

Thanks,

-- Steve

This patch was applied on top of yours.

Index: linux-2.6.15-rc5-rt1/kernel/softirq.c
===================================================================
--- linux-2.6.15-rc5-rt1.orig/kernel/softirq.c	2005-12-14 10:17:47.000000000 -0500
+++ linux-2.6.15-rc5-rt1/kernel/softirq.c	2005-12-14 10:33:31.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/kallsyms.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/wait.h>
 
 #include <asm/irq.h>
 /*
@@ -53,10 +54,38 @@
 	int			nr;
 	unsigned long		cpu;
 	struct task_struct	*tsk;
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+	wait_queue_head_t	wait;
+	int			running;
+#endif
 };
 
 static DEFINE_PER_CPU(struct softirqdata, ksoftirqd[MAX_SOFTIRQ]);
 
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+/*
+ * Preempting the softirq causes cases that would not be a
+ * problem when the softirq is not preempted. That is a
+ * process may have code to spin while waiting for a softirq
+ * to finish on another CPU.  But if it happens that the
+ * process has preempted the softirq, this could cause a
+ * deadlock.
+ */
+void wait_for_softirq(int softirq)
+{
+	struct softirqdata *data = &__get_cpu_var(ksoftirqd[softirq]);
+	if (data->running) {
+		DECLARE_WAITQUEUE(wait, current);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		add_wait_queue(&data->wait, &wait);
+		if (data->running)
+			schedule();
+		remove_wait_queue(&data->wait, &wait);
+		__set_current_state(TASK_RUNNING);
+	}
+}
+#endif
+
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
@@ -460,6 +489,10 @@
 //	set_user_nice(current, -10);
 	current->flags |= PF_NOFREEZE | PF_SOFTIRQ;
 
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+	init_waitqueue_head(&data->wait);
+#endif
+
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -469,6 +502,9 @@
 			schedule();
 			preempt_disable();
 		}
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+		data->running = 1;
+#endif
 		__set_current_state(TASK_RUNNING);
 
 		while (local_softirq_pending() & mask) {
@@ -493,6 +529,10 @@
 			cond_resched();
 			preempt_disable();
 		}
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+		data->running = 0;
+		wake_up(&data->wait);
+#endif
 		preempt_enable();
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
Index: linux-2.6.15-rc5-rt1/include/linux/interrupt.h
===================================================================
--- linux-2.6.15-rc5-rt1.orig/include/linux/interrupt.h	2005-12-12 16:31:25.000000000 -0500
+++ linux-2.6.15-rc5-rt1/include/linux/interrupt.h	2005-12-14 10:29:51.000000000 -0500
@@ -145,6 +145,11 @@
 extern void FASTCALL(raise_softirq(unsigned int nr));
 extern void wakeup_irqd(void);
 
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+extern void wait_for_softirq(int softirq);
+#else
+# define wait_for_softirq(x) do {} while(0)
+#endif
 
 /* Tasklets --- multithreaded analogue of BHs.
 
Index: linux-2.6.15-rc5-rt1/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5-rt1.orig/kernel/hrtimer.c	2005-12-14 10:17:53.000000000 -0500
+++ linux-2.6.15-rc5-rt1/kernel/hrtimer.c	2005-12-14 10:29:07.000000000 -0500
@@ -670,6 +670,7 @@
 
 		if (ret >= 0)
 			return ret;
+		wait_for_softirq(HRTIMER_SOFTIRQ);
 	}
 }
 


