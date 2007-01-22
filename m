Return-Path: <linux-kernel-owner+w=401wt.eu-S1751038AbXAVJM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbXAVJM3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 04:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbXAVJM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 04:12:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58104 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbXAVJM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 04:12:28 -0500
Date: Mon, 22 Jan 2007 10:10:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pieter Palmers <pieterp@joow.be>
Cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394	audio
Message-ID: <20070122091035.GA11821@elte.hu>
References: <1152371924.4736.169.camel@mindpipe> <45B3F7A5.2050708@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B3F7A5.2050708@joow.be>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.3 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pieter Palmers <pieterp@joow.be> wrote:

> Dear all,
> 
> What is the status with respect to this problem? I see that in the 
> current -rt patch the problematic code piece is different. I 
> personally haven't tried to reproduce this myself on a more recent 
> kernel, but I just got a report from one of our users who experienced 
> the same problem with 2.6.19-rt15 and RT preemption (desktop 
> preemption works fine).
> 
> Should the latest -rt patches be fixed with respect to this issue? If 
> so I'll try and test them, otherwise I omit the effort.

it's not fixed yet. Could you try the patch below?

	Ingo

---
 include/linux/interrupt.h |    6 ++----
 kernel/softirq.c          |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

Index: linux/include/linux/interrupt.h
===================================================================
--- linux.orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -328,10 +328,8 @@ static inline void tasklet_unlock(struct
 	clear_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-static inline void tasklet_unlock_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
-}
+extern void tasklet_unlock_wait(struct tasklet_struct *t);
+
 #else
 # define tasklet_trylock(t)		1
 # define tasklet_tryunlock(t)		1
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/percpu.h>
+#include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
@@ -656,6 +657,25 @@ void __init softirq_init(void)
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
 }
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+
+void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		/*
+		 * Hack for now to avoid this busy-loop:
+		 */
+#ifdef CONFIG_PREEMPT_RT
+		msleep(1);
+#else
+		barrier();
+#endif
+	}
+}
+EXPORT_SYMBOL(tasklet_unlock_wait);
+
+#endif
+
 static int ksoftirqd(void * __data)
 {
 	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
