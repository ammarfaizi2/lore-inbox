Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268549AbTGIS3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbTGIS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:29:39 -0400
Received: from smtp3.brturbo.com ([200.199.201.47]:39326 "EHLO
	smtp3.brturbo.com") by vger.kernel.org with ESMTP id S268549AbTGIS33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:29:29 -0400
Subject: Re: [PATCH] Interactivity bits
From: Roberto Orenstein <rstein@brturbo.com>
To: Guillaume Chazarain <gfc@altern.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <WQ98NJGC3OMJH0887GC84IHIE856FA.3f0c5488@monpc>
References: <WQ98NJGC3OMJH0887GC84IHIE856FA.3f0c5488@monpc>
Content-Type: multipart/mixed; boundary="=-Jh+cfA19Tj5b3/lxSJED"
Organization: 
Message-Id: <1057776260.1361.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 15:44:20 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jh+cfA19Tj5b3/lxSJED
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-07-09 at 14:44, Guillaume Chazarain wrote:
> 09/07/03 17:59:10, Roberto Orenstein <rstein@brturbo.com> wrote:
> 
> >Just a suggestion, why instead of changing the code you don't try the
> >attached patch? At least you don't have to recompile just to change a
> >few define's. Against 2.5.73, but applies in 2.5.74. Just the "long
> >sleep_time = jiffies - p->last_run;" isn't there.
> 
> Hi again,
> 
> your patch oops on boot, here is a patch to correct that.
> 
> Guillaume
> 

Oops, thanks. Corrected patch below.
Anyway, I hope it helps.

regards,
Roberto

--=-Jh+cfA19Tj5b3/lxSJED
Content-Disposition: attachment; filename=patch-sched_tuning
Content-Type: text/x-patch; name=patch-sched_tuning; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -X dontdiff -Nru linux-2.5.74/include/linux/sysctl.h linux-2.5.74-test/include/linux/sysctl.h
--- linux-2.5.74/include/linux/sysctl.h	2003-06-27 19:35:11.000000000 -0300
+++ linux-2.5.74-test/include/linux/sysctl.h	2003-07-09 15:11:10.000000000 -0300
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_SCHED_TUNING=58	/* dir: scheduler tuning */
 };
 
 
@@ -193,6 +194,21 @@
 	RANDOM_UUID=6
 };
 
+/* /proc/sys/kernel/sched_tuning */
+enum
+{
+	SCHED_TUNING_MIN_TIMESLICE=1,
+	SCHED_TUNING_MAX_TIMESLICE=2,
+	SCHED_TUNING_BONUS_RATIO=3,
+	SCHED_TUNING_MAX_SLEEP_AVG=4,
+	SCHED_TUNING_STARVATION_LIMIT=5,
+	SCHED_TUNING_CHILD_PENALTY=6,
+	SCHED_TUNING_PARENT_PENALTY=7,
+	SCHED_TUNING_EXIT_WEIGHT=8,
+	SCHED_TUNING_INTERACTIVE_DELTA=9,
+	SCHED_TUNING_NODE_THRESHOLD=10
+};
+
 /* /proc/sys/bus/isa */
 enum
 {
diff -X dontdiff -Nru linux-2.5.74/kernel/sched.c linux-2.5.74-test/kernel/sched.c
--- linux-2.5.74/kernel/sched.c	2003-07-02 23:25:40.000000000 -0300
+++ linux-2.5.74-test/kernel/sched.c	2003-07-09 15:11:10.000000000 -0300
@@ -66,16 +66,28 @@
  * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
-#define NODE_THRESHOLD		125
+int sched_min_timeslice 	= ( 10 * HZ / 1000);
+int sched_max_timeslice 	= (200 * HZ / 1000);
+int sched_prio_bonus_ratio	= 25;
+int sched_max_sleep_avg		= (10*HZ);
+int sched_starvation_limit	= (10*HZ);
+int sched_child_penalty		= 50;
+int sched_parent_penalty	= 100;
+int sched_exit_weight		= 3;
+int sched_interactive_delta 	= 2;
+int sched_node_threshold	= 125;
+
+
+#define MIN_TIMESLICE		sched_min_timeslice
+#define MAX_TIMESLICE		sched_max_timeslice
+#define CHILD_PENALTY		sched_child_penalty
+#define PARENT_PENALTY		sched_parent_penalty
+#define EXIT_WEIGHT		sched_exit_weight
+#define PRIO_BONUS_RATIO	sched_prio_bonus_ratio
+#define INTERACTIVE_DELTA	sched_interactive_delta
+#define MAX_SLEEP_AVG		sched_max_sleep_avg
+#define STARVATION_LIMIT	sched_starvation_limit
+#define NODE_THRESHOLD		sched_node_threshold
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
diff -X dontdiff -Nru linux-2.5.74/kernel/sysctl.c linux-2.5.74-test/kernel/sysctl.c
--- linux-2.5.74/kernel/sysctl.c	2003-06-27 19:38:13.000000000 -0300
+++ linux-2.5.74-test/kernel/sysctl.c	2003-07-09 15:26:22.000000000 -0300
@@ -58,6 +58,17 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
+/* sched.c */
+extern int sched_min_timeslice;
+extern int sched_max_timeslice;
+extern int sched_prio_bonus_ratio;
+extern int sched_max_sleep_avg;
+extern int sched_starvation_limit;
+extern int sched_child_penalty;
+extern int sched_parent_penalty;
+extern int sched_exit_weight;
+extern int sched_interactive_delta;
+extern int sched_node_threshold;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -123,6 +134,7 @@
 static ctl_table debug_table[];
 static ctl_table dev_table[];
 extern ctl_table random_table[];
+static ctl_table sched_tuning_table[];
 
 /* /proc declarations: */
 
@@ -551,6 +563,12 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_SCHED_TUNING,
+		.procname	= "sched_tuning",
+		.mode		= 0555,
+		.child		= sched_tuning_table	
+	},
 	{ .ctl_name = 0 }
 };
 
@@ -775,6 +793,101 @@
 
 static ctl_table dev_table[] = {
 	{ .ctl_name = 0 }
+};
+
+/* sched tuning */
+static ctl_table sched_tuning_table[] = {
+	/* min_timeslice */
+	{
+		.ctl_name 	= SCHED_TUNING_MIN_TIMESLICE,
+		.procname	= "min_timeslice",
+		.mode		= 0644,
+		.data		= &sched_min_timeslice,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,		
+	},
+	/*max_timeslice */
+	{
+		.ctl_name	= SCHED_TUNING_MAX_TIMESLICE,
+		.procname	= "max_timeslice",
+		.mode		= 0644,
+		.data		= &sched_max_timeslice,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,
+	},
+	/* prio_bonus_ratio */
+	{
+		.ctl_name 	= SCHED_TUNING_BONUS_RATIO,
+		.procname	= "prio_bonus_ratio",
+		.mode		= 0644,
+		.data		= &sched_prio_bonus_ratio,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,		
+	},
+	/* max_sleep_avg */
+	{
+		.ctl_name	= SCHED_TUNING_MAX_SLEEP_AVG,
+		.procname	= "max_sleep_avg",
+		.mode		= 0644,
+		.data		= &sched_max_sleep_avg,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,
+	},
+	/* starvation_limit */
+	{
+		.ctl_name 	= SCHED_TUNING_STARVATION_LIMIT,
+		.procname	= "starvation_limit",
+		.mode		= 0644,
+		.data		= &sched_starvation_limit,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,		
+	},
+	/* child_penalty */
+	{
+		.ctl_name 	= SCHED_TUNING_CHILD_PENALTY,
+		.procname	= "child_penalty",
+		.mode		= 0644,
+		.data		= &sched_child_penalty,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,		
+	},
+	/* parent_penalty */
+	{
+		.ctl_name	= SCHED_TUNING_PARENT_PENALTY,
+		.procname	= "parent_penalty",
+		.mode		= 0644,
+		.data		= &sched_parent_penalty,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,
+	},
+	/* exit_weight */
+	{
+		.ctl_name 	= SCHED_TUNING_EXIT_WEIGHT,
+		.procname	= "exit_weight",
+		.mode		= 0644,
+		.data		= &sched_exit_weight,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,		
+	},
+	/* interactive_delta */
+	{
+		.ctl_name	= SCHED_TUNING_INTERACTIVE_DELTA,
+		.procname	= "interactive_delta",
+		.mode		= 0644,
+		.data		= &sched_interactive_delta,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,
+	},
+	/* node_threshold */
+	{
+		.ctl_name	= SCHED_TUNING_NODE_THRESHOLD,
+		.procname	= "node_threshold",
+		.mode		= 0644,
+		.data		= &sched_node_threshold,
+		.maxlen		= sizeof(int),
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };  
 
 extern void init_irq_proc (void);

--=-Jh+cfA19Tj5b3/lxSJED--

