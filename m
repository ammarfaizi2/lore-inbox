Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbTCHSPB>; Sat, 8 Mar 2003 13:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTCHSPB>; Sat, 8 Mar 2003 13:15:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16841 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262130AbTCHSOz>; Sat, 8 Mar 2003 13:14:55 -0500
Date: Sat, 08 Mar 2003 10:25:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] updated scheduler-tunables for 2.5.64-mm2
Message-ID: <400810000.1047147915@[10.10.2.4]>
In-Reply-To: <1047095088.727.5.camel@phantasy.awol.org>
References: <20030307185116.0c53e442.akpm@digeo.com> <1047095088.727.5.camel@phantasy.awol.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool ... do you want to add the other two NUMA parameters as well to
your stack? (the idle and busy rebalance rates). Here's what I had
before with those in.

diff -urpN -X /home/fletch/.diff.exclude 143-schedstat-scripts/Documentation/filesystems/proc.txt 144-sched_tunables/Documentation/filesystems/proc.txt
--- 143-schedstat-scripts/Documentation/filesystems/proc.txt	Thu Feb 13 11:08:01 2003
+++ 144-sched_tunables/Documentation/filesystems/proc.txt	Wed Mar  5 10:22:46 2003
@@ -37,6 +37,7 @@ Table of Contents
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1662,6 +1663,104 @@ IPX.
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
+idle_node_rebalance_ratio
+-------------------------
+
+On NUMA machines, we normally rebalance within nodes, but we also rebalance
+globally every N idle rebalance ticks, where N = idle_node_rebalance_ratio.
+
+busy_node_rebalance_ratio
+-------------------------
+
+On NUMA machines, we normally rebalance within nodes, but we also rebalance
+globally every N busy rebalance ticks, where N = busy_node_rebalance_ratio.
 
 ------------------------------------------------------------------------------
 Summary
diff -urpN -X /home/fletch/.diff.exclude 143-schedstat-scripts/include/linux/sysctl.h 144-sched_tunables/include/linux/sysctl.h
--- 143-schedstat-scripts/include/linux/sysctl.h	Tue Feb 25 23:03:51 2003
+++ 144-sched_tunables/include/linux/sysctl.h	Wed Mar  5 10:22:46 2003
@@ -66,7 +66,8 @@ enum
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SCHED=11,		/* scheduler tunables */
 };
 
 /* CTL_BUS names: */
@@ -157,6 +158,20 @@ enum
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
+	SCHED_IDLE_NODE_REBALANCE_RATIO=10,  /* how often to global balance */
+	SCHED_BUSY_NODE_REBALANCE_RATIO=11,  /* how often to global balance */
+};
 
 /* CTL_NET names: */
 enum
diff -urpN -X /home/fletch/.diff.exclude 143-schedstat-scripts/kernel/sched.c 144-sched_tunables/kernel/sched.c
--- 143-schedstat-scripts/kernel/sched.c	Wed Mar  5 10:22:45 2003
+++ 144-sched_tunables/kernel/sched.c	Wed Mar  5 10:22:46 2003
@@ -63,16 +63,30 @@
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
+#define MIN_TIMESLICE         (min_timeslice)
+#define MAX_TIMESLICE         (max_timeslice)
+#define CHILD_PENALTY         (child_penalty)
+#define PARENT_PENALTY                (parent_penalty)
+#define EXIT_WEIGHT           (exit_weight)
+#define PRIO_BONUS_RATIO      (prio_bonus_ratio)
+#define INTERACTIVE_DELTA     (interactive_delta)
+#define MAX_SLEEP_AVG         (max_sleep_avg)
+#define STARVATION_LIMIT      (starvation_limit)
+
 #define NODE_THRESHOLD          125
 
 /*
@@ -917,6 +931,9 @@ static int find_busiest_node(int this_no
 
 #endif /* CONFIG_NUMA */
 
+int idle_node_rebalance_ratio = 10;
+int busy_node_rebalance_ratio = 100;
+
 #if CONFIG_SMP
 
 /*
@@ -1149,8 +1166,9 @@ out:
  */
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 #define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
-#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 5)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 100)
+
+#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * idle_node_rebalance_ratio)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * busy_node_rebalance_ratio)
 
 #if CONFIG_NUMA
 static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
diff -urpN -X /home/fletch/.diff.exclude 143-schedstat-scripts/kernel/sysctl.c 144-sched_tunables/kernel/sysctl.c
--- 143-schedstat-scripts/kernel/sysctl.c	Mon Dec 16 21:50:51 2002
+++ 144-sched_tunables/kernel/sysctl.c	Wed Mar  5 10:22:46 2003
@@ -55,6 +55,17 @@ extern char core_pattern[];
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
+extern int idle_node_rebalance_ratio;
+extern int busy_node_rebalance_ratio;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -112,6 +123,7 @@ static struct ctl_table_header root_tabl
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -156,6 +168,7 @@ static ctl_table root_table[] = {
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
 	{0}
 };
 
@@ -358,7 +371,46 @@ static ctl_table debug_table[] = {
 
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
+	{SCHED_IDLE_NODE_REBALANCE_RATIO, "idle_node_rebalance_ratio", 
+						&idle_node_rebalance_ratio,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{SCHED_BUSY_NODE_REBALANCE_RATIO, "busy_node_rebalance_ratio", 
+						&busy_node_rebalance_ratio,
+	 sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, NULL},
+	{0}
+};
 
 extern void init_irq_proc (void);
 

