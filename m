Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSAZHSD>; Sat, 26 Jan 2002 02:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSAZHRy>; Sat, 26 Jan 2002 02:17:54 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:5000 "EHLO Bluesong.NET")
	by vger.kernel.org with ESMTP id <S289025AbSAZHRj>;
	Sat, 26 Jan 2002 02:17:39 -0500
Message-Id: <200201260722.g0Q7M4C20336@Bluesong.NET>
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Ingo Molnar <mingo@elte.hu>, jfv@us.ibm.com
Subject: [PATCH]: O(1) 2.5.3-pre5  J7 Tuneable Parameters
Date: Fri, 25 Jan 2002 23:22:04 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, jstultz@us.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_S4BJI152QL86QCWUHAXD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_S4BJI152QL86QCWUHAXD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This is the 2.5.3-pre 5 version of the O(1) J7 runtime parameters patch. It 
should be applied over Ingo's J7 patch. With it, his compile time options
are brought out into /proc/sys/sched for runtime manipulation.

The perfomance hit by doing this is nearly in the noise, so it provides a 
handy means of perfomance analysis and tuning for both the developer
as well as a performance conscious sysadmin type.

In anything like this, use with care.

Cheers,

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)


--------------Boundary-00=_S4BJI152QL86QCWUHAXD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="schedtune-2.5.3-J7"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="schedtune-2.5.3-J7"

diff -Naur linux/include/linux/sched.h linux.jfv/include/linux/sched.h
--- linux/include/linux/sched.h	Fri Jan 25 17:20:12 2002
+++ linux.jfv/include/linux/sched.h	Fri Jan 25 16:59:40 2002
@@ -422,17 +422,35 @@
  *
  * These are the 'tuning knobs' of the scheduler:
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_FORK_PENALTY	95
-#define PARENT_FORK_PENALTY	100
-#define EXIT_WEIGHT		3
-#define PRIO_INTERACTIVE_RATIO	20
-#define PRIO_CPU_HOG_RATIO	60
-#define PRIO_BONUS_RATIO	70
-#define INTERACTIVE_DELTA	3
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
+#define DEFAULT_MIN_TIMESLICE           ( 10 * HZ / 1000)
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
+
 
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
diff -Naur linux/include/linux/sysctl.h linux.jfv/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Mon Jan 14 13:27:06 2002
+++ linux.jfv/include/linux/sysctl.h	Fri Jan 25 17:02:43 2002
@@ -63,7 +63,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11
 };
 
 /* CTL_BUS names: */
@@ -72,6 +73,22 @@
 	BUS_ISA=1		/* ISA */
 };
 
+/* CTL_SCHED names: */
+enum
+{
+	MAX_SLICE=1,    /* Timeslice scaling */
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
--- linux/kernel/sched.c	Fri Jan 25 17:20:12 2002
+++ linux.jfv/kernel/sched.c	Fri Jan 25 16:52:03 2002
@@ -22,6 +22,22 @@
 
 #define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
 
+/*
+**      Tuneable scheduler parameters,
+**      brought out in /proc/sys/sched
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
--- linux/kernel/sysctl.c	Sat Dec 29 17:30:07 2001
+++ linux.jfv/kernel/sysctl.c	Fri Jan 25 17:09:14 2002
@@ -51,6 +51,9 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
+extern int child_fork_penalty, parent_fork_penalty, prio_interactive_ratio;
+extern int prio_cpu_hog_ratio, prio_bonus_ratio, interactive_delta;
+extern int exit_weight, max_sleep_avg, starvation_limit;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -110,6 +113,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -154,6 +158,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+        {CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -275,6 +280,32 @@
 	{0}
 };
 
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

--------------Boundary-00=_S4BJI152QL86QCWUHAXD--
