Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbTBMNJe>; Thu, 13 Feb 2003 08:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268035AbTBMNI5>; Thu, 13 Feb 2003 08:08:57 -0500
Received: from services.cam.org ([198.73.180.252]:44535 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S268034AbTBMNIh>;
	Thu, 13 Feb 2003 08:08:37 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Date: Thu, 13 Feb 2003 08:18:29 -0500
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (2-2) governors for 60-bk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302130818.29431.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the modified schedule tunables patch

schedule_tunables-C4

Ed Tomlinson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.963   -> 1.964  
#	     kernel/sysctl.c	1.39    -> 1.40   
#	Documentation/filesystems/proc.txt	1.13    -> 1.14   
#	include/linux/sysctl.h	1.40    -> 1.41   
#	      kernel/sched.c	1.156   -> 1.157  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/25	ed@oscar.et.ca	1.964
# add scheduler tunables including governors and NUMA knobs
# --------------------------------------------
#
diff -Nru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	Sat Jan 25 11:07:17 2003
+++ b/Documentation/filesystems/proc.txt	Sat Jan 25 11:07:17 2003
@@ -37,6 +37,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1662,6 +1663,113 @@
 The /proc/net/ipx_route  table  holds  a list of IPX routes. For each route it
 gives the  destination  network, the router node (or Directly) and the network
 address of the router (or Connected) for internal networks.
+
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
+thread_governor
+---------------
+
+When the number of active threads in a threadgroup exceeds the limit reduce the   
+timeslices of active members by thread_governor / active_threads_in_group.  In
+the NUMA case the limits are per node.  The thread_governor is applied before
+the user_governor.  Units are number of threads times 10.
+
+user_governor
+-------------
+
+When the number of active threads of user exceeds the limit reduce the timeslices
+of the user's active processes by user_governor / active_threads_of_user. In the
+NUMA case the limits are per node.  Units are number of threads times 10.
+
+node_threshold
+--------------
+
+Consider NUMA nodes imbalanced when there is a difference of more than this
+percentage.
 
 ------------------------------------------------------------------------------
 Summary
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Sat Jan 25 11:07:17 2003
+++ b/include/linux/sysctl.h	Sat Jan 25 11:07:17 2003
@@ -66,7 +66,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11,		/* scheduler tunables */
 };
 
 /* CTL_BUS names: */
@@ -157,6 +158,21 @@
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
+	SCHED_THREAD_GOVERNOR=10,	/* govern threadgroups when needed */
+	SCHED_USER_GOVERNOR=11,		/* govern users when needed  */
+	SCHED_NODE_THRESHOLD=12,	/* NUMA imbalance threshold */
+};
 
 /* CTL_NET names: */
 enum
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Jan 25 11:07:17 2003
+++ b/kernel/sched.c	Sat Jan 25 11:07:17 2003
@@ -57,19 +57,35 @@
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
-#define THREAD_GOVERNOR		15	/* allow threads groups 1.5 full timeslices */
-#define USER_GOVERNOR		300	/* allow user 30 full timeslices */
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
-#define NODE_THRESHOLD          125
+
+int min_timeslice = (10 * HZ) / 1000;
+int max_timeslice = (300 * HZ) / 1000;
+int child_penalty = 95;
+int parent_penalty = 100;
+int thread_governor = 15;
+int user_governor = 300;
+int exit_weight = 3;
+int prio_bonus_ratio = 25;
+int interactive_delta = 2;
+int max_sleep_avg = 2 * HZ;
+int starvation_limit = 2 * HZ;
+int node_threshold = 125;
+
+#define MIN_TIMESLICE		(min_timeslice)
+#define MAX_TIMESLICE		(max_timeslice)
+#define CHILD_PENALTY		(child_penalty)
+#define PARENT_PENALTY		(parent_penalty)
+#define THREAD_GOVERNOR		(thread_governor)
+#define USER_GOVERNOR		(user_governor)
+#define EXIT_WEIGHT		(exit_weight)
+#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
+#define INTERACTIVE_DELTA	(interactive_delta)
+#define MAX_SLEEP_AVG		(max_sleep_avg)
+#define STARVATION_LIMIT	(starvation_limit)
+#define NODE_THRESHOLD		(node_threshold)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Sat Jan 25 11:07:17 2003
+++ b/kernel/sysctl.c	Sat Jan 25 11:07:17 2003
@@ -55,6 +55,18 @@
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
+extern int thread_governor;
+extern int user_governor;
+extern int node_threshold;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -112,6 +124,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -156,6 +169,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -358,7 +372,47 @@
 
 static ctl_table dev_table[] = {
 	{0}
-};  
+};
+
+static ctl_table sched_table[] = {
+	{SCHED_MAX_TIMESLICE, "max_timeslice", &max_timeslice,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &one, NULL},
+	{SCHED_MIN_TIMESLICE, "min_timeslice", &min_timeslice,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &one, NULL},
+	{SCHED_CHILD_PENALTY, "child_penalty", &child_penalty,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_PARENT_PENALTY, "parent_penalty", &parent_penalty,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_EXIT_WEIGHT, "exit_weight", &exit_weight,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_PRIO_BONUS_RATIO, "prio_bonus_ratio", &prio_bonus_ratio,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_INTERACTIVE_DELTA, "interactive_delta", &interactive_delta,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_MAX_SLEEP_AVG, "max_sleep_avg", &max_sleep_avg,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &one, NULL},
+	{SCHED_STARVATION_LIMIT, "starvation_limit", &starvation_limit,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_THREAD_GOVERNOR, "thread_governor", &thread_governor,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_USER_GOVERNOR, "user_governor", &user_governor,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_NODE_THRESHOLD, "node_threshold", &node_threshold,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{0}
+};
 
 extern void init_irq_proc (void);
 


