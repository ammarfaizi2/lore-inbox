Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWCUPU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWCUPU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWCUPU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:20:29 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:48820 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751770AbWCUPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:20:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 02:20:10 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <200603090036.49915.kernel@kolivas.org> <1142949690.7807.80.camel@homer> <200603220117.54822.kernel@kolivas.org>
In-Reply-To: <200603220117.54822.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220220.11368.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:17, Con Kolivas wrote:
> I actually believe the same effect can be had by a tiny 
> modification to enable/disable the estimator anyway.

Just for argument's sake it would look something like this.

Cheers,
Con
---
Add sysctl to enable/disable cpu scheduer interactivity estimator

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h  |    1 +
 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   14 +++++++++++---
 kernel/sysctl.c        |    8 ++++++++
 4 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc6-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/include/linux/sched.h	2006-03-19 11:15:27.000000000 +1100
+++ linux-2.6.16-rc6-mm2/include/linux/sched.h	2006-03-22 02:13:55.000000000 +1100
@@ -104,6 +104,7 @@ extern unsigned long nr_uninterruptible(
 extern unsigned long nr_active(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long weighted_cpuload(const int cpu);
+extern int sched_interactive;
 
 #include <linux/time.h>
 #include <linux/param.h>
Index: linux-2.6.16-rc6-mm2/include/linux/sysctl.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/include/linux/sysctl.h	2006-03-19 11:15:27.000000000 +1100
+++ linux-2.6.16-rc6-mm2/include/linux/sysctl.h	2006-03-22 02:14:43.000000000 +1100
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_INTERACTIVE=73,	/* int: enable/disable interactivity estimator */
 };
 
 
Index: linux-2.6.16-rc6-mm2/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/sched.c	2006-03-19 15:41:08.000000000 +1100
+++ linux-2.6.16-rc6-mm2/kernel/sched.c	2006-03-22 02:13:56.000000000 +1100
@@ -128,6 +128,9 @@
  * too hard.
  */
 
+/* Sysctl enable/disable interactive estimator */
+int sched_interactive __read_mostly = 1;
+
 #define CURRENT_BONUS(p) \
 	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
 		MAX_SLEEP_AVG)
@@ -151,7 +154,8 @@
 		INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	((p)->prio <= (p)->static_prio - DELTA(p) && \
+		sched_interactive)
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -662,9 +666,13 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	prio = p->static_prio;
+
+	if (sched_interactive) {
+		bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
-	prio = p->static_prio - bonus;
+		prio -= bonus;
+	}
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
Index: linux-2.6.16-rc6-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/sysctl.c	2006-03-19 11:15:27.000000000 +1100
+++ linux-2.6.16-rc6-mm2/kernel/sysctl.c	2006-03-22 02:15:23.000000000 +1100
@@ -684,6 +684,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SCHED_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+	 	.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
