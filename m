Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290558AbSAYFPS>; Fri, 25 Jan 2002 00:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290565AbSAYFPC>; Fri, 25 Jan 2002 00:15:02 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:7559 "EHLO Bluesong.NET")
	by vger.kernel.org with ESMTP id <S290558AbSAYFOn>;
	Fri, 25 Jan 2002 00:14:43 -0500
Message-Id: <200201250518.g0P5IrR13332@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Ingo Molnar <mingo@elte.hu>, jfv@us.ibm.com
Subject: [PATCH]: O(1) 2.4.17-J6 tuneable parameters
Date: Thu, 24 Jan 2002 21:18:52 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, jstultz@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Have been watching and testing your changes as they have
evolved. Our group has a customer request for a scheduler that will give
them some tuneable parameters, and your changes have actually had
some parameters change thru the deltas you've made. It seemed like it
might be useful to take them and make them tweakable on a running
system. I am not 100% convinced of the goodness of this, but I wanted
to submit it for your consideration.  The current code performs great btw,
thanks for all your hard work.

Regards,

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)


diff -Naur linux/include/linux/sched.h linux.jfv/include/linux/sched.h
--- linux/include/linux/sched.h	Thu Jan 24 17:33:23 2002
+++ linux.jfv/include/linux/sched.h	Thu Jan 24 17:24:37 2002
@@ -473,18 +473,31 @@
 #define DEF_USER_NICE		0
 
 /*
- * Default timeslice is 250 msecs, maximum is 500 msecs.
+ * Default timeslice is 250 msecs, maximum is 300 msecs.
  * Minimum timeslice is 10 msecs.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_FORK_PENALTY	95
-#define PARENT_FORK_PENALTY	100
-#define PRIO_INTERACTIVE_RATIO	20
-#define PRIO_CPU_HOG_RATIO	60
-#define PRIO_BONUS_RATIO	70
-#define INTERACTIVE_DELTA	3
-
+#define DEFAULT_MIN_TIMESLICE		( 10 * HZ / 1000)
+#define DEFAULT_MAX_TIMESLICE		(300 * HZ / 1000)
+#define DEFAULT_TIMESLICE	(250 * HZ / 1000)
+#define DEFAULT_CHILD_FORK_PENALTY	95
+#define DEFAULT_PARENT_FORK_PENALTY	100
+#define DEFAULT_PRIO_INTERACTIVE_RATIO	20
+#define DEFAULT_PRIO_CPU_HOG_RATIO	60
+#define DEFAULT_PRIO_BONUS_RATIO	70
+#define DEFAULT_INTERACTIVE_DELTA	3
+
+extern int min_timeslice, max_timeslice, child_fork_penalty;
+extern int parent_fork_penalty, prio_cpu_hog_ratio, prio_bonus_ratio;
+extern int prio_bonus_ratio, interactive_delta;
+
+#define MIN_TIMESLICE		(min_timeslice)
+#define MAX_TIMESLICE		(max_timeslice)
+#define CHILD_FORK_PENALTY	(child_fork_penalty)
+#define PARENT_FORK_PENALTY	(parent_fork_penalty)
+#define PRIO_INTERACTIVE_RATIO	(prio_interactive_ratio)
+#define PRIO_CPU_HOG_RATIO	(prio_cpu_hog_ratio)
+#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
+#define INTERACTIVE_DELTA	(interactive_delta)
 
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
@@ -529,7 +542,7 @@
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
-    time_slice:		NICE_TO_TIMESLICE(DEF_USER_NICE),		\
+    time_slice:		DEFAULT_TIMESLICE,				\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
     p_opptr:		&tsk,						\
diff -Naur linux/include/linux/sysctl.h linux.jfv/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Mon Nov 26 05:29:17 2001
+++ linux.jfv/include/linux/sysctl.h	Thu Jan 24 17:24:48 2002
@@ -63,7 +63,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11		/* SCHED ctl (tuneable parameters) */
 };
 
 /* CTL_BUS names: */
@@ -72,6 +73,19 @@
 	BUS_ISA=1		/* ISA */
 };
 
+/* CTL_SCHED names: */
+enum
+{
+	MAX_SLICE=1,	/* Timeslice scaling */
+	MIN_SLICE=2,
+	CHILD_PENALTY=3,
+	PARENT_PENALTY=4,
+	INT_RATIO=5,
+	HOG_RATIO=6,
+	BONUS_RATIO=7,
+	INT_DELTA=8
+};
+
 /* CTL_KERN names: */
 enum
 {
diff -Naur linux/kernel/sched.c linux.jfv/kernel/sched.c
--- linux/kernel/sched.c	Thu Jan 24 17:33:23 2002
+++ linux.jfv/kernel/sched.c	Thu Jan 24 17:09:55 2002
@@ -22,6 +22,19 @@
 
 #define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
 
+/*
+**	Tuneable scheduler parameters,
+**	brought out in /proc/sys/sched
+*/
+int	max_timeslice = DEFAULT_MAX_TIMESLICE;
+int	min_timeslice = DEFAULT_MIN_TIMESLICE;
+int	child_fork_penalty = DEFAULT_CHILD_FORK_PENALTY;
+int	parent_fork_penalty = DEFAULT_PARENT_FORK_PENALTY;
+int	prio_interactive_ratio = DEFAULT_PRIO_INTERACTIVE_RATIO;
+int	prio_cpu_hog_ratio = DEFAULT_PRIO_CPU_HOG_RATIO;
+int	prio_bonus_ratio = DEFAULT_PRIO_BONUS_RATIO;
+int	interactive_delta = DEFAULT_INTERACTIVE_DELTA;
+
 typedef struct runqueue runqueue_t;
 
 struct prio_array {
@@ -295,8 +308,8 @@
 	if (!rt_task(p)) {
 		p->sleep_avg = p->sleep_avg * CHILD_FORK_PENALTY / 100;
 		p->prio = effective_prio(p);
-
-		current->sleep_avg = current->sleep_avg * PARENT_FORK_PENALTY / 100;
+		current->sleep_avg =
+		   current->sleep_avg * PARENT_FORK_PENALTY / 100;
 	}
 	spin_lock_irq(&rq->lock);
 	p->cpu = smp_processor_id();
diff -Naur linux/kernel/sysctl.c linux.jfv/kernel/sysctl.c
--- linux/kernel/sysctl.c	Fri Dec 21 09:42:04 2001
+++ linux.jfv/kernel/sysctl.c	Thu Jan 24 17:09:55 2002
@@ -50,7 +50,8 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
-
+extern int child_fork_penalty, parent_fork_penalty,prio_interactive_ratio;
+extern int prio_cpu_hog_ratio, prio_bonus_ratio, interactive_delta;
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID 
*/
 static int maxolduid = 65535;
 static int minolduid;
@@ -109,6 +110,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -153,6 +155,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+        {CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -278,6 +281,27 @@
 	{0}
 };
 
+
+static ctl_table sched_table[] = {
+	{MAX_SLICE, "max-timeslice",
+	&max_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{MIN_SLICE, "min-timeslice",
+	&min_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{CHILD_PENALTY, "child-fork-penalty",
+	&child_fork_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{PARENT_PENALTY, "parent-fork-penalty",
+	&parent_fork_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{INT_RATIO, "prio-interactive-ratio",
+	&prio_interactive_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{HOG_RATIO, "prio-cpu-hog-ratio",
+	&prio_cpu_hog_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{BONUS_RATIO, "prio-bonus-ratio",
+	&prio_bonus_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{INT_DELTA, "interactive-delta",
+	&interactive_delta, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0}
+};
+
 static ctl_table proc_table[] = {
 	{0}
 };
