Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSAZHI6>; Sat, 26 Jan 2002 02:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAZHIo>; Sat, 26 Jan 2002 02:08:44 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:3720 "EHLO Bluesong.NET")
	by vger.kernel.org with ESMTP id <S288878AbSAZHIe>;
	Sat, 26 Jan 2002 02:08:34 -0500
Message-Id: <200201260712.g0Q7CwN20290@Bluesong.NET>
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Ingo Molnar <mingo@elte.hu>, jfv@us.ibm.com
Subject: [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
Date: Fri, 25 Jan 2002 23:12:57 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, jstultz@us.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LPAJNXN7H0E9LB5AN7DG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_LPAJNXN7H0E9LB5AN7DG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Ingo,

	This patch synchronizes with J7 and I think makes the changes
you wished. A couple of important points:

		- This patch can be applied to EITHER 2.4.17 OR 2.4.18 pre 7 as
			long as Ingo's J7 patch is applied first.

		- While I agree with you on not wanting these in the mainline kernel,
			I ran Hackbench on one of our new Foster systems with and
			without the tuneable parameters, and while the numbers do
			degrade slightly, its rather suprisingly small. So dont be afraid
			to use this as a system tuning aid.

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)


--------------Boundary-00=_LPAJNXN7H0E9LB5AN7DG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="schedtune-2.4.17-J7"
Content-Transfer-Encoding: 8bit
Content-Description: Tuneable Scheduler Parameters for O(1) J7
Content-Disposition: attachment; filename="schedtune-2.4.17-J7"

diff -Naur linux/include/linux/sched.h linux.jfv/include/linux/sched.h
--- linux/include/linux/sched.h	Fri Jan 25 17:31:12 2002
+++ linux.jfv/include/linux/sched.h	Fri Jan 25 15:27:13 2002
@@ -472,20 +472,37 @@
 #define DEF_USER_NICE		0
 
 /*
- * Default timeslice is 250 msecs, maximum is 500 msecs.
+ * Default timeslice is now HZ, maximum is 300 msecs.
  * Minimum timeslice is 10 msecs.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE           (300 * HZ / 1000)
-#define CHILD_FORK_PENALTY      95
-#define PARENT_FORK_PENALTY     100
-#define EXIT_WEIGHT             3
-#define PRIO_INTERACTIVE_RATIO  20
-#define PRIO_CPU_HOG_RATIO      60
-#define PRIO_BONUS_RATIO        70
-#define INTERACTIVE_DELTA       3
-#define MAX_SLEEP_AVG           (2*HZ)
-#define STARVATION_LIMIT        (2*HZ)
+#define DEFAULT_MIN_TIMESLICE		( 10 * HZ / 1000)
+#define DEFAULT_MAX_TIMESLICE           (300 * HZ / 1000)
+#define DEFAULT_CHILD_FORK_PENALTY      95
+#define DEFAULT_PARENT_FORK_PENALTY     100
+#define DEFAULT_EXIT_WEIGHT             3
+#define DEFAULT_PRIO_INTERACTIVE_RATIO  20
+#define DEFAULT_PRIO_CPU_HOG_RATIO      60
+#define DEFAULT_PRIO_BONUS_RATIO        70
+#define DEFAULT_INTERACTIVE_DELTA       3
+#define DEFAULT_MAX_SLEEP_AVG           (2*HZ)
+#define DEFAULT_STARVATION_LIMIT        (2*HZ)
+
+extern int min_timeslice, max_timeslice, child_fork_penalty;
+extern int parent_fork_penalty, prio_cpu_hog_ratio, prio_bonus_ratio;
+extern int exit_weight, prio_bonus_ratio, interactive_delta;
+extern int max_sleep_avg, starvation_limit;
+
+#define MIN_TIMESLICE           (min_timeslice)
+#define MAX_TIMESLICE           (max_timeslice)
+#define CHILD_FORK_PENALTY      (child_fork_penalty)
+#define PARENT_FORK_PENALTY     (parent_fork_penalty)
+#define PRIO_INTERACTIVE_RATIO  (prio_interactive_ratio)
+#define PRIO_CPU_HOG_RATIO      (prio_cpu_hog_ratio)
+#define PRIO_BONUS_RATIO        (prio_bonus_ratio)
+#define INTERACTIVE_DELTA       (interactive_delta)
+#define EXIT_WEIGHT             (exit_weight)
+#define MAX_SLEEP_AVG           (max_sleep_avg)
+#define STARVATION_LIMIT        (starvation_limit)
 
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
diff -Naur linux/include/linux/sysctl.h linux.jfv/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Mon Nov 26 05:29:17 2001
+++ linux.jfv/include/linux/sysctl.h	Fri Jan 25 15:28:28 2002
@@ -63,7 +63,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11		/* SCHED ctl (tuneable parameters) */
 };
 
 /* CTL_BUS names: */
@@ -72,6 +73,22 @@
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
+	INT_DELTA=8,
+	EWEIGHT=9,
+	MAX_SLEEP=10,
+	STARVE_LIM=11
+};
+
 /* CTL_KERN names: */
 enum
 {
diff -Naur linux/kernel/sched.c linux.jfv/kernel/sched.c
--- linux/kernel/sched.c	Fri Jan 25 17:31:12 2002
+++ linux.jfv/kernel/sched.c	Fri Jan 25 15:22:40 2002
@@ -22,6 +22,22 @@
 
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
+int	exit_weight = DEFAULT_EXIT_WEIGHT;
+int	max_sleep_avg = DEFAULT_MAX_SLEEP_AVG;
+int	starvation_limit = DEFAULT_STARVATION_LIMIT;
+
 typedef struct runqueue runqueue_t;
 
 struct prio_array {
diff -Naur linux/kernel/sysctl.c linux.jfv/kernel/sysctl.c
--- linux/kernel/sysctl.c	Fri Dec 21 09:42:04 2001
+++ linux.jfv/kernel/sysctl.c	Fri Jan 25 17:10:33 2002
@@ -50,7 +50,9 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
-
+extern int child_fork_penalty, parent_fork_penalty,prio_interactive_ratio;
+extern int prio_cpu_hog_ratio, prio_bonus_ratio, interactive_delta;
+extern int exit_weight, max_sleep_avg, starvation_limit;
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -109,6 +111,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -153,6 +156,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+        {CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -278,6 +282,33 @@
 	{0}
 };
 
+
+static ctl_table sched_table[] = {
+	{MAX_SLICE, "MAX_TIMESLICE",
+	&max_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{MIN_SLICE, "MIN_TIMESLICE",
+	&min_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{CHILD_PENALTY, "CHILD_FORK_PENALTY",
+	&child_fork_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{PARENT_PENALTY, "PARENT_FORK_PENALTY",
+	&parent_fork_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{INT_RATIO, "PRIO_INTERACTIVE_RATIO",
+	&prio_interactive_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{HOG_RATIO, "PRIO_CPU_HOG_RATIO",
+	&prio_cpu_hog_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{BONUS_RATIO, "PRIO_BONUS_RATIO",
+	&prio_bonus_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{INT_DELTA, "INTERACTIVE_DELTA",
+	&interactive_delta, sizeof(int), 0644, NULL, &proc_dointvec},
+	{EWEIGHT, "EXIT_WEIGHT",
+	&exit_weight, sizeof(int), 0644, NULL, &proc_dointvec},
+	{MAX_SLEEP, "MAX_SLEEP_AVG",
+	&max_sleep_avg, sizeof(int), 0644, NULL, &proc_dointvec},
+	{STARVE_LIM, "INTERACTIVE_DELTA",
+	&starvation_limit, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0}
+};
+
 static ctl_table proc_table[] = {
 	{0}
 };

--------------Boundary-00=_LPAJNXN7H0E9LB5AN7DG--
