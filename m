Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbTAAM6h>; Wed, 1 Jan 2003 07:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAAM6h>; Wed, 1 Jan 2003 07:58:37 -0500
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:28348 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262826AbTAAM6d>; Wed, 1 Jan 2003 07:58:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Date: Wed, 1 Jan 2003 08:02:06 -0500
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
References: <200212301645.50278.tomlins@cam.org> <1041288608.13956.173.camel@irongate.swansea.linux.org.uk> <200212310933.39727.tomlins@cam.org>
In-Reply-To: <200212310933.39727.tomlins@cam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301010802.06332.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the scheduler-tunables patch updated to include USER_PENALTY
and THREAD_PENANTY.  This on top of ptg_B0.

Ed Tomlinson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.977  
#	     kernel/sysctl.c	1.37    -> 1.39   
#	Documentation/filesystems/proc.txt	1.10    -> 1.12   
#	include/linux/sysctl.h	1.38    -> 1.40   
#	      kernel/sched.c	1.146   -> 1.148  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/31	ed@oscar.et.ca	1.976
# scheduler-tunables.patch
# --------------------------------------------
# 02/12/31	ed@oscar.et.ca	1.977
# update schedule tunables for thead and user penalties
# --------------------------------------------
#
diff -Nru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	Tue Dec 31 13:48:26 2002
+++ b/Documentation/filesystems/proc.txt	Tue Dec 31 13:48:26 2002
@@ -37,6 +37,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1658,6 +1659,111 @@
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
+thead_penalty
+-------------
+
+Limit sum of timeslices used by a threadgroup to 100/n timeslices.  This
+is used to prevent heavily thread applications from slowing down the system
+when many threads are active.  For this item theads are defined as processes
+sharing their mm and files.  This implies that if this is set to 33 and six
+processes from a given threadgroup are in runqueues each process will have its
+timeslice reduced by 50%.  Set to zero to disable. 
+
+user_penalty
+------------
+
+Limit the sum of timeslices used by a user to 100/n timeslices.  This prevents
+one user from stealing the cpu by creating many active threads.  For example,
+if this is set to 25 and six processes are in runqueues the timeslice of each
+process will be reduced by 33%.  Set to zero to disable - root is always
+excluded from this logic.
 
 ------------------------------------------------------------------------------
 Summary
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Tue Dec 31 13:48:26 2002
+++ b/include/linux/sysctl.h	Tue Dec 31 13:48:26 2002
@@ -66,7 +66,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11,		/* scheduler tunables */
 };
 
 /* CTL_BUS names: */
@@ -157,6 +158,20 @@
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
+	SCHED_THREAD_PENALTY=10,	/* thread group throttle */
+	SCHED_USER_PENALTY=11,		/* user process throttle */
+};
 
 /* CTL_NET names: */
 enum
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Dec 31 13:48:26 2002
+++ b/kernel/sched.c	Tue Dec 31 13:48:26 2002
@@ -57,18 +57,33 @@
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
-#define THREAD_PENALTY		50	/* allow threads groups 2 full timeslices */
-#define USER_PENALTY		10	/* allow user 10 full timeslices */
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
+int thread_penalty = 50;
+int user_penalty = 10;
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
+#define THREAD_PENALTY		(thread_penalty)
+#define USER_PENALTY		(user_penalty)
+#define EXIT_WEIGHT		(exit_weight)
+#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
+#define INTERACTIVE_DELTA	(interactive_delta)
+#define MAX_SLEEP_AVG		(max_sleep_avg)
+#define STARVATION_LIMIT	(starvation_limit)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Tue Dec 31 13:48:26 2002
+++ b/kernel/sysctl.c	Tue Dec 31 13:48:26 2002
@@ -55,6 +55,17 @@
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
+extern int thread_penalty;
+extern int user_penalty;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -112,6 +123,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -156,6 +168,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -358,7 +371,33 @@
 
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
+	{SCHED_THREAD_PENALTY, "thread_penalty",
+	&thread_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{SCHED_USER_PENALTY, "user_penalty",
+	&user_penalty, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0}
+};
 
 extern void init_irq_proc (void);
 
-----------------
