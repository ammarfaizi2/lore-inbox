Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSLQCH3>; Mon, 16 Dec 2002 21:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbSLQCH3>; Mon, 16 Dec 2002 21:07:29 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27146
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264614AbSLQCHT>; Mon, 16 Dec 2002 21:07:19 -0500
Subject: [PATCH] updated scheduler tunables
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: anton@samba.org
Content-Type: text/plain
Organization: 
Message-Id: <1040091321.854.8.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Dec 2002 21:15:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sched-tune patch is now in 2.5-mm, but I have had a couple requests
for a version for stock 2.5.  What is the interest, if any, of seeing
this in 2.5?  The idea was just to facilitate tuning, but the scheduler
could use some exported knobs... Anton mentioned the need to fiddle with
max_timeslice on some workloads.

Anyhow, this patch implements the following tuning knobs for the
scheduler:

        [21:10:18]rml@phantasy:~$ pef /proc/sys/sched/
        child_penalty=95
        exit_weight=3
        interactive_delta=2
        max_sleep_avg=2000
        max_timeslice=300
        min_timeslice=10
        parent_penalty=100
        prio_bonus_ratio=25
        starvation_limit=2000

with documentation in Documentation/filesystems/proc.txt

Patch is against 2.5.52.

	Robert Love

 Documentation/filesystems/proc.txt |   87 +++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h             |   15 +++++-
 kernel/sched.c                     |   57 ++++++++++++------------
 kernel/sysctl.c                    |   35 ++++++++++++++
 4 files changed, 165 insertions(+), 29 deletions(-)


diff -urN linux-2.5.52/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linux-2.5.52/Documentation/filesystems/proc.txt	2002-12-15 21:07:51.000000000 -0500
+++ linux/Documentation/filesystems/proc.txt	2002-12-15 22:51:09.000000000 -0500
@@ -37,6 +37,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1659,6 +1660,92 @@
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
diff -urN linux-2.5.52/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.5.52/include/linux/sysctl.h	2002-12-15 21:08:09.000000000 -0500
+++ linux/include/linux/sysctl.h	2002-12-15 22:51:09.000000000 -0500
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
diff -urN linux-2.5.52/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.52/kernel/sched.c	2002-12-15 21:08:14.000000000 -0500
+++ linux/kernel/sched.c	2002-12-15 22:55:14.000000000 -0500
@@ -57,16 +57,19 @@
  * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
  * maximum timeslice is 300 msecs. Timeslices get refilled after
  * they expire.
+ *
+ * They are configurable via /proc/sys/sched
+ * See Documentation/filesystems/proc.txt for descriptions
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
+int min_timeslice = (10 * HZ) / 1000;
+int max_timeslice = (300 * HZ) / 1000;
+int child_penalty = 95;
+int parent_penalty = 100;
+int exit_weight = 3;
+int prio_bonus_ratio = 25;
+int interactive_delta = 2;
+int max_sleep_avg = 2 * HZ;
+int starvation_limit = 2 * HZ;
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -76,7 +79,7 @@
  *
  * This part scales the interactivity limit depending on niceness.
  *
- * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
+ * We scale it linearly, offset by the interactive_delta delta.
  * Here are a few examples of different nice levels:
  *
  *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
@@ -100,8 +103,8 @@
 	(v1) * (v2_max) / (v1_max)
 
 #define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
+	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*prio_bonus_ratio/100) + \
+		interactive_delta)
 
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
@@ -112,13 +115,13 @@
  *
  * The higher a thread's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
+ * priority thread gets min_timeslice worth of execution time.
  *
  * task_timeslice() is the interface that is used by the scheduler.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+#define BASE_TIMESLICE(p) (min_timeslice + \
+	((max_timeslice - min_timeslice) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
 
 static inline unsigned int task_timeslice(task_t *p)
 {
@@ -244,7 +247,7 @@
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
+ * We scale the actual sleep average [0 .... max_sleep_avg]
  * into the -5 ... 0 ... +5 bonus/penalty range.
  *
  * We use 25% of the full 0...39 priority range so that:
@@ -258,8 +261,8 @@
 {
 	int bonus, prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+	bonus = MAX_USER_PRIO*prio_bonus_ratio*p->sleep_avg/max_sleep_avg/100 -
+			MAX_USER_PRIO*prio_bonus_ratio/100/2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -289,8 +292,8 @@
 		 * boost gets as well.
 		 */
 		p->sleep_avg += sleep_time;
-		if (p->sleep_avg > MAX_SLEEP_AVG)
-			p->sleep_avg = MAX_SLEEP_AVG;
+		if (p->sleep_avg > max_sleep_avg)
+			p->sleep_avg = max_sleep_avg;
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
@@ -460,8 +463,8 @@
 		 * and children as well, to keep max-interactive tasks
 		 * from forking tasks that are max-interactive.
 		 */
-		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+		current->sleep_avg = current->sleep_avg * parent_penalty / 100;
+		p->sleep_avg = p->sleep_avg * child_penalty / 100;
 		p->prio = effective_prio(p);
 	}
 	set_task_cpu(p, smp_processor_id());
@@ -486,8 +489,8 @@
 	local_irq_save(flags);
 	if (p->first_time_slice) {
 		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
+		if (unlikely(p->parent->time_slice > max_timeslice))
+			p->parent->time_slice = max_timeslice;
 	}
 	local_irq_restore(flags);
 	/*
@@ -495,8 +498,8 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
+		p->parent->sleep_avg = (p->parent->sleep_avg * exit_weight +
+			p->sleep_avg) / (exit_weight + 1);
 }
 
 /**
@@ -870,7 +873,7 @@
 #define EXPIRED_STARVING(rq) \
 		((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			starvation_limit * ((rq)->nr_running) + 1))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
diff -urN linux-2.5.52/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.5.52/kernel/sysctl.c	2002-12-15 21:07:44.000000000 -0500
+++ linux/kernel/sysctl.c	2002-12-15 22:51:09.000000000 -0500
@@ -55,6 +55,15 @@
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
@@ -112,6 +121,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -156,6 +166,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -358,7 +369,29 @@
 
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
 



