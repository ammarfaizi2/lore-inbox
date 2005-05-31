Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVEaGzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEaGzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVEaGzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:55:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51934 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261231AbVEaGzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:55:24 -0400
Date: Tue, 31 May 2005 08:54:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Machine Freezes while Running Crossover Office
Message-ID: <20050531065456.GA21948@elte.hu>
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
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> Looks if the processes keep on waking up each other and thus eat up 
> all CPU time. (Even more so if Crossover uses RT priority, have to 
> check that.)

another possible effect would be the interactivity code: the Wine 
processes gaining high priority via their scheduling pattern. I've 
attached a patch to make it runtime switchable (see more details below).

> P.S. I can also verify that it is indeed the 64 KB change that breaks 
> Crossover. I changed PIPE_BUFFERS to 1 and could not reproduce the 
> hang.  Increasing it to 8 makes the problem come up again.

very interesting. This should not have any direct effect on scheduling 
correctness - but it might change the patterns and hence the priorities. 
A couple of things to try:

- run the Wine processes with nice +19 priority? (just to check 
  whether it's the interactivity code. After you've made sure they dont 
  have RT priorities.)

- renice -20 the X server process

- run a shell-script with RT priority that captures 'ps aux' every 
  second or so:

  chrt -f -p 1 $$  # switch shell to RT-SCHED_FIFO-prio-1
  rm -f log.txt
  while sleep 1; do
   date
   ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
  done > log.txt

 (chrt comes from the schedutils package) Then send us log.txt and 
 identify the date where the 'hang' occured. (the hang will probably not 
 occur in this measurement script running at RT priority)

- apply the patch below and check whether doing:

   echo 0 > /proc/sys/kernel/interactive

  makes the hang go away.

- if the hang goes away then could you check whether removing the 2 new 
  sched_interactive lines in kernel/sched.c's effective_prio() function 
  (but keeping other portions of the patch applied) hang or not.

	Ingo

--

hack to make the interactivity code runtime-switchable.

From: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -144,8 +144,8 @@
 #define DELTA(p) \
 	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+#define TASK_INTERACTIVE(p) ((sched_interactive) && \
+	((p)->prio <= (p)->static_prio - DELTA(p)))
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -574,6 +574,13 @@ static inline void enqueue_task_head(str
 }
 
 /*
+ * This is a sysctl which allows dynamic priorities to be applied based on
+ * interactive behaviour, and selective interactive reinsertion into the
+ * active array despite timeslice expiration.
+ */
+int sched_interactive = 0;
+
+/*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
@@ -594,6 +601,10 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
+	/* Dynamic priorities are not used with interactive mode off */
+	if (!sched_interactive)
+		return p->static_prio;
+
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
--- linux/kernel/sysctl.c.orig
+++ linux/kernel/sysctl.c
@@ -836,6 +836,14 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
--- linux/include/linux/sysctl.h.orig
+++ linux/include/linux/sysctl.h
@@ -136,6 +136,7 @@ enum
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
+	KERN_INTERACTIVE=69,	/* int: dynamic priorities */
 };
 
 
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -839,6 +839,7 @@ extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
+extern int sched_interactive;
 
 void yield(void);
 
