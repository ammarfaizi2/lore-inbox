Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSLKESj>; Tue, 10 Dec 2002 23:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLKESj>; Tue, 10 Dec 2002 23:18:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33797
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266996AbSLKESf>; Tue, 10 Dec 2002 23:18:35 -0500
Subject: Re: [PATCH] scheduler tunables
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
In-Reply-To: <1039562877.922.16.camel@phantasy>
References: <1039562877.922.16.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1039580785.2563.159.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 23:26:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 18:27, Robert Love wrote:

> Attached patch implements sysctl/procfs scheduler tunables, knobs
> which let one play with all of the important scheduler variables:

Updated version at Andrew's prodding, now with documentation in
Documentation/filesystem/proc.txt

Again, this patch implements scheduler tunables in /proc/sys/sched:

        sched.starvation_limit = 2000
        sched.max_sleep_avg = 2000
        sched.interactive_delta = 2
        sched.prio_bonus_ratio = 25
        sched.exit_weight = 3
        sched.parent_penalty = 100
        sched.child_penalty = 95
        sched.min_timeslice = 10
        sched.max_timeslice = 300

Some notes for testers and tuners:

- you can effectively disable the interactivity estimator (both
  bonuses and penalties) by setting prio_bonus_ratio to zero

- some users seem to prefer a lower child_penalty (50 is the
  default in 2.4-aa)

- some workloads may benefit from setting starvation_limit lower
  (maybe 0.5s?) while a few workloads may actually like it
  much higher (4s?)

Enjoy,

	Robert Love


 Documentation/filesystems/proc.txt |   87 +++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h             |   15 +++++-
 kernel/sched.c                     |   31 +++++++++----
 kernel/sysctl.c                    |   35 ++++++++++++++
 4 files changed, 157 insertions(+), 11 deletions(-)


diff -urN linux-2.5.51-mm1/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linux-2.5.51-mm1/Documentation/filesystems/proc.txt	2002-12-10 17:48:09.000000000 -0500
+++ linux/Documentation/filesystems/proc.txt	2002-12-10 23:15:19.000000000 -0500
@@ -37,6 +37,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1663,6 +1664,92 @@
 gives the  destination  network, the router node (or Directly) and the network
 address of the router (or Connected) for internal networks.
 
+2.11 /proc/sys/sched - scheduler tunables
+-----------------------------------------
+
+Useful knobs for tuning the scheduler live in /proc/sys/sched.
+
+child_penalty
+-------------
+
+Percentage of the parent's sleep_avg that children inherit.  sleep_avg is
+a running average of the time a process spends sleeping.  Tasks with high
+sleep_avg values are considered interactive and given a higher dynamic
+priority and a larger timeslice.  You typically want this some value just
+under 100.
+
+exit_weight
+-----------
+
+When a CPU hog task exits, its parent's sleep_avg is reduced by a factor of
+exit_weight against the exiting task's sleep_avg.
+
+interactive_delta
+-----------------
+
+If a task is "interactive" it is reinserted into the active array after it
+has expired its timeslice, instead of being inserted into the expired array.
+How "interactive" a task must be in order to be deemed interactive is a
+function of its nice value.  This interactive limit is scaled linearly by nice
+value and is offset by the interactive_delta.
+
+max_sleep_avg
+-------------
+
+max_sleep_avg is the largest value (in ms) stored for a task's running sleep
+average.  The larger this value, the longer a task needs to sleep to be
+considered interactive (maximum interactive bonus is a function of
+max_sleep_avg).
+
+max_timeslice
+-------------
+
+Maximum timeslice, in milliseconds.  This is the value given to tasks of the
+highest dynamic priority.
+
+min_timeslice
+-------------
+
+Minimum timeslice, in milliseconds.  This is the value given to tasks of the
+lowest dynamic priority.  Every task gets at least this slice of the processor
+per array switch.
+
+parent_penalty
+--------------
+
+Percentage of the parent's sleep_avg that it retains across a fork().
+sleep_avg is a running average of the time a process spends sleeping.  Tasks
+with high sleep_avg values are considered interactive and given a higher
+dynamic priority and a larger timeslice.  Normally, this value is 100 and thus
+task's retain their sleep_avg on fork.  If you want to punish interactive
+tasks for forking, set this below 100.
+
+prio_bonus_ratio
+----------------
+
+Middle percentage of the priority range that tasks can receive as a dynamic
+priority.  The default value of 25% ensures that nice values at the
+extremes are still enforced.  For example, nice +19 interactive tasks will
+never be able to preempt a nice 0 CPU hog.  Setting this higher will increase
+the size of the priority range the tasks can receive as a bonus.  Setting
+this lower will decrease this range, making the interactivity bonus less
+apparent and user nice values more applicable.
+
+starvation_limit
+----------------
+
+Sufficiently interactive tasks are reinserted into the active array when they
+run out of timeslice.  Normally, tasks are inserted into the expired array.
+Reinserting interactive tasks into the active array allows them to remain
+runnable, which is important to interactive performance.  This could starve
+expired tasks, however, since the interactive task could prevent the array
+switch.  To prevent starving the tasks on the expired array for too long. the
+starvation_limit is the longest (in ms) we will let the expired array starve
+at the expense of reinserting interactive tasks back into active.  Higher
+values here give more preferance to running interactive tasks, at the expense
+of expired tasks.  Lower values provide more fair scheduling behavior, at the
+expense of interactivity.  The units are in milliseconds.
+
 ------------------------------------------------------------------------------
 Summary
 ------------------------------------------------------------------------------
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
 




