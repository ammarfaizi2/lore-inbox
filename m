Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSLJXUJ>; Tue, 10 Dec 2002 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSLJXUJ>; Tue, 10 Dec 2002 18:20:09 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28433
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265564AbSLJXUG>; Tue, 10 Dec 2002 18:20:06 -0500
Subject: [PATCH] scheduler tunables
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Content-Type: text/plain
Organization: 
Message-Id: <1039562877.922.16.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 18:27:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch implements sysctl/procfs scheduler tunables, knobs which
let one play with all of the important scheduler variables:

        [18:12:54]rml@phantasy:~$ ls /proc/sys/sched/
        child_penalty      max_sleep_avg  parent_penalty
        exit_weight        max_timeslice  prio_bonus_ratio
        interactive_delta  min_timeslice  starvation_limit

Which may help in tuning and debugging the scheduler.

I believe Ingo did something similar to this ages ago, so original
credit for the idea goes to him.

Note the values are not checked and you can probably cause a
divide-by-zero somewhere, but only root can write these.

Patch is against 2.5.51-mm1.  It also applies to 2.5.51 modulo a simple
failed hunk in sysctl.c.

	Robert Love


 include/linux/sysctl.h |   15 ++++++++++++++-
 kernel/sched.c         |   31 ++++++++++++++++++++++---------
 kernel/sysctl.c        |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 11 deletions(-)


diff -urN linux-2.5.51-mm1/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.5.51-mm1/include/linux/sysctl.h	2002-12-10 17:48:10.000000000 -0500
+++ linux/include/linux/sysctl.h	2002-12-10 16:50:41.000000000 -0500
@@ -66,7 +66,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11,		/* scheduler tunables */
 };
 
 /* CTL_BUS names: */
@@ -157,6 +158,18 @@
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 };
 
+/* Tunable scheduler parameters in /proc/sys/sched/ */
+enum {
+	SCHED_MIN_TIMESLICE=1,		/* minimum process timeslice */
+	SCHED_MAX_TIMESLICE=2,		/* maximum process timeslice */
+	SCHED_CHILD_PENALTY=3,		/* penalty on fork to child */
+	SCHED_PARENT_PENALTY=4,		/* penalty on fork to parent */
+	SCHED_EXIT_WEIGHT=5,		/* penalty to parent of CPU hog child */
+	SCHED_PRIO_BONUS_RATIO=6,	/* percent of max prio given as bonus */
+	SCHED_INTERACTIVE_DELTA=7,	/* delta used to scale interactivity */
+	SCHED_MAX_SLEEP_AVG=8,		/* maximum sleep avg attainable */
+	SCHED_STARVATION_LIMIT=9,	/* no re-active if expired is starved */
+};
 
 /* CTL_NET names: */
 enum
diff -urN linux-2.5.51-mm1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.51-mm1/kernel/sched.c	2002-12-10 17:48:10.000000000 -0500
+++ linux/kernel/sched.c	2002-12-10 16:33:34.000000000 -0500
@@ -57,16 +57,29 @@
  * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
  * maximum timeslice is 300 msecs. Timeslices get refilled after
  * they expire.
+ *
+ * They are configurable via /proc/sys/sched
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
+
+int min_timeslice = (10 * HZ) / 1000;
+int max_timeslice = (300 * HZ) / 1000;
+int child_penalty = 95;
+int parent_penalty = 100;
+int exit_weight = 3;
+int prio_bonus_ratio = 25;
+int interactive_delta = 2;
+int max_sleep_avg = 2 * HZ;
+int starvation_limit = 2 * HZ;
+
+#define MIN_TIMESLICE		(min_timeslice)
+#define MAX_TIMESLICE		(max_timeslice)
+#define CHILD_PENALTY		(child_penalty)
+#define PARENT_PENALTY		(parent_penalty)
+#define EXIT_WEIGHT		(exit_weight)
+#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
+#define INTERACTIVE_DELTA	(interactive_delta)
+#define MAX_SLEEP_AVG		(max_sleep_avg)
+#define STARVATION_LIMIT	(starvation_limit)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
diff -urN linux-2.5.51-mm1/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.5.51-mm1/kernel/sysctl.c	2002-12-10 17:48:10.000000000 -0500
+++ linux/kernel/sysctl.c	2002-12-10 17:05:04.000000000 -0500
@@ -54,6 +54,15 @@
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int min_timeslice;
+extern int max_timeslice;
+extern int child_penalty;
+extern int parent_penalty;
+extern int exit_weight;
+extern int prio_bonus_ratio;
+extern int interactive_delta;
+extern int max_sleep_avg;
+extern int starvation_limit;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -111,6 +120,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -155,6 +165,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -357,7 +368,29 @@
 
 static ctl_table dev_table[] = {
 	{0}
-};  
+};
+
+static ctl_table sched_table[] = {
+	{SCHED_MAX_TIMESLICE, "max_timeslice",
+	&max_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_MIN_TIMESLICE, "min_timeslice",
+	&min_timeslice, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_CHILD_PENALTY, "child_penalty",
+	&child_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_PARENT_PENALTY, "parent_penalty",
+	&parent_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_EXIT_WEIGHT, "exit_weight",
+	&exit_weight, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_PRIO_BONUS_RATIO, "prio_bonus_ratio",
+	&prio_bonus_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_INTERACTIVE_DELTA, "interactive_delta",
+	&interactive_delta, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_MAX_SLEEP_AVG, "max_sleep_avg",
+	&max_sleep_avg, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_STARVATION_LIMIT, "starvation_limit",
+	&starvation_limit, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0}
+};
 
 extern void init_irq_proc (void);
 



