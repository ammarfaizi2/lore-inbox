Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTF1CdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 22:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTF1CdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 22:33:16 -0400
Received: from smtp3.brturbo.com ([200.199.201.47]:62606 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S265037AbTF1CdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 22:33:02 -0400
Subject: Re: [PATCH] O1int for 2.5.73 - sched tuning sysctl
From: Roberto Orenstein <rstein@brturbo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306271826.23690.kernel@kolivas.org>
References: <200306271826.23690.kernel@kolivas.org>
Content-Type: multipart/mixed; boundary="=-gp5B8o4fvGEFBr5dvXhS"
Organization: 
Message-Id: <1056759599.1308.45.camel@dexter.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 21:20:05 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gp5B8o4fvGEFBr5dvXhS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-06-27 at 05:26, Con Kolivas wrote:
> Here is an updated version of the O1int patch designed to improve 
> interactivity.
> 
> This change addresses the difficulty of new tasks in heavy load being 
> recognised as interactive by decreasing the amount of time considered in the 
> interactivity equation, but dropping that decrease exponentially till it gets 
> to the MAX_SLEEP_AVG.
> 
> This should improve the startup time of new apps in heavy load and lessen 
> audio stalls when loads are high _and_ then the audio app is started.
> 
> Please test and comment.
> 
> Con

Well, I've just been following this thread and I choose to make a small
patch against your O1 int to export the scheduler tuning knobs via
sysctl. This patch will create /proc/sys/kernel/sched_tuning and expose
all the knobs, sou you guys don't have to recompile and reboot just to
change, say, max_sleep_avg. Don't know if anybody will find it useful,
but at least it doesn't hurts :-) 
It should apply cleanly against plain 2.5.73, altough I didn't tested.

wrt your patch, I must admit I didn't feel any difference from vanilla
2.5.73, but this feeling isn't much scientific 8). I will do some
serious tests tomorrow if I find any time.

Roberto

--=-gp5B8o4fvGEFBr5dvXhS
Content-Disposition: attachment; filename=patch-sched_tuning
Content-Type: text/x-patch; name=patch-sched_tuning; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Nur -X dontdiff linux-2.5.73-O1int/include/linux/sysctl.h linux-2.5.73-test/include/linux/sysctl.h
--- linux-2.5.73-O1int/include/linux/sysctl.h	2003-06-27 19:35:11.000000000 -0300
+++ linux-2.5.73-test/include/linux/sysctl.h	2003-06-27 20:45:59.000000000 -0300
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
diff -Nur -X dontdiff linux-2.5.73-O1int/kernel/sched.c linux-2.5.73-test/kernel/sched.c
--- linux-2.5.73-O1int/kernel/sched.c	2003-06-27 19:57:56.000000000 -0300
+++ linux-2.5.73-test/kernel/sched.c	2003-06-27 20:45:59.000000000 -0300
@@ -65,16 +65,28 @@
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
diff -Nur -X dontdiff linux-2.5.73-O1int/kernel/sysctl.c linux-2.5.73-test/kernel/sysctl.c
--- linux-2.5.73-O1int/kernel/sysctl.c	2003-06-27 19:38:13.000000000 -0300
+++ linux-2.5.73-test/kernel/sysctl.c	2003-06-27 20:45:59.000000000 -0300
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
 
@@ -775,6 +793,100 @@
 
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
+	}
 };  
 
 extern void init_irq_proc (void);

--=-gp5B8o4fvGEFBr5dvXhS--

