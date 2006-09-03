Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752089AbWICGRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbWICGRu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 02:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWICGRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 02:17:50 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:48598 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1752089AbWICGRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 02:17:49 -0400
Message-Id: <20060903071628.11C9112204B@ns2.osuosl.org>
Date: Sun,  3 Sep 2006 00:16:28 -0700 (PDT)
From: philips@ifup.org
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From philips@plankton.ifup.org Sun Sep  3 01:04:22 2006
Message-Id: <20060903060421.987291681@plankton.ifup.org>
References: <20060903060409.267605367@plankton.ifup.org>
User-Agent: quilt/0.45-1
Date: Sun, 03 Sep 2006 01:04:10 -0500
From: Brandon Philips <brandon@ifup.org>
To: linux-kernel@vger.kernel.org
Cc: "Brandon D. Philips" <brandon@ifup.org>
Subject: [patch] Export CPU Scheduler Tunables via DebugFS
Content-Disposition: inline; filename=debugfs-tunable-cpu-scheduler.patch

This patch exports the CPU scheduler tunables via DebugFS.

philips@plankton:~$ ls /debug/cpu-scheduler/
child_penalty  interactive_delta  min_timeslice       prio_bonus_ratio
def_timeslice  max_bonus          on_runqueue_weight  starvation_limit
exit_weight    max_sleep_avg      parent_penalty

It is similiar to the patches by Robert Love and Ingo Molnar that were
available for the 2.5 series: http://kerneltrap.org/node/525/1938

The goal remains the same: offer a simple way for _developers_ to tune and
debug the scheduler.

Perhaps someone could even automate the testing of different values[1] under
different workloads[2].

[1] http://meikon.homeip.net/extras/papers/linux-2.5-scheduler-analysis.pdf
[2] http://test.kernel.org/autotest/QuickStart

Signed-off-by: Brandon D. Philips <brandon@ifup.org>
---
 kernel/sched.c    |  115 ++++++++++++++++++++++++++++++++++++++++++++++++------
 lib/Kconfig.debug |    8 +++
 2 files changed, 112 insertions(+), 11 deletions(-)

Index: linux-rc/kernel/sched.c
===================================================================
--- linux-rc.orig/kernel/sched.c
+++ linux-rc/kernel/sched.c
@@ -52,6 +52,7 @@
 #include <linux/acct.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/debugfs.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -87,17 +88,60 @@
  * default timeslice is 100 msecs, maximum timeslice is 800 msecs.
  * Timeslices get refilled after they expire.
  */
-#define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
-#define DEF_TIMESLICE		(100 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		  3
-#define PRIO_BONUS_RATIO	 25
-#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
+#define DEFAULT_MIN_TIMESLICE           max(5 * HZ / 1000, 1)
+#define DEFAULT_DEF_TIMESLICE           (100 * HZ / 1000)
+#define DEFAULT_ON_RUNQUEUE_WEIGHT       30
+#define DEFAULT_CHILD_PENALTY            95
+#define DEFAULT_PARENT_PENALTY          100
+#define DEFAULT_EXIT_WEIGHT               3
+#define DEFAULT_PRIO_BONUS_RATIO         25
+#define DEFAULT_MAX_BONUS               (MAX_USER_PRIO * DEFAULT_PRIO_BONUS_RATIO / 100)
+#define DEFAULT_INTERACTIVE_DELTA         2
+#define DEFAULT_MAX_SLEEP_AVG           (DEFAULT_DEF_TIMESLICE * DEFAULT_MAX_BONUS)
+#define DEFAULT_STARVATION_LIMIT        (DEFAULT_MAX_SLEEP_AVG)
+#define DEFAULT_NS_MAX_SLEEP_AVG        (JIFFIES_TO_NS(DEFAULT_MAX_SLEEP_AVG))
+
+/*
+ * Simply use the static definitions if we are not exporting tunables via
+ * DebugFS for runtime tuning.
+ */
+#ifndef CONFIG_DEBUGFS_SCHED
+#define MIN_TIMESLICE		DEFAULT_MIN_TIMESLICE
+#define DEF_TIMESLICE		DEFAULT_DEF_TIMESLICE
+#define ON_RUNQUEUE_WEIGHT	DEFAULT_ON_RUNQUEUE_WEIGHT
+#define CHILD_PENALTY		DEFAULT_CHILD_PENALTY
+#define PARENT_PENALTY		DEFAULT_PARENT_PENALTY
+#define EXIT_WEIGHT		DEFAULT_EXIT_WEIGHT
+#define PRIO_BONUS_RATIO	DEFAULT_PRIO_BONUS_RATIO
+#define MAX_BONUS		DEFAULT_MAX_BONUS
+#define INTERACTIVE_DELTA	DEFAULT_INTERACTIVE_DELTA
+#define MAX_SLEEP_AVG		DEFAULT_MAX_SLEEP_AVG
+#define STARVATION_LIMIT	DEFAULT_STARVATION_LIMIT
+#else
+int min_timeslice;
+#define MIN_TIMESLICE		(min_timeslice)
+int def_timeslice;
+#define DEF_TIMESLICE		(def_timeslice)
+int on_runqueue_weight;
+#define ON_RUNQUEUE_WEIGHT	(on_runqueue_weight)
+int child_penalty;
+#define CHILD_PENALTY		(child_penalty)
+int parent_penalty;
+#define PARENT_PENALTY		(parent_penalty)
+int exit_weight;
+#define EXIT_WEIGHT		(exit_weight)
+int prio_bonus_ratio;
+#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
+int max_bonus;
+#define MAX_BONUS		(max_bonus)
+int interactive_delta;
+#define INTERACTIVE_DELTA	(interactive_delta)
+int max_sleep_avg;
+#define MAX_SLEEP_AVG		(max_sleep_avg)
+int starvation_limit;
+#define STARVATION_LIMIT	(starvation_limit)
+#endif
+
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 
 /*
@@ -6725,10 +6769,59 @@ int in_sched_functions(unsigned long add
 		&& addr < (unsigned long)__sched_text_end);
 }
 
+#ifdef CONFIG_DEBUGFS_SCHED
+
+#define debugfs_sched_create(name, parent) \
+debugfs_create_u32(#name, 0644, parent, &name)
+
+int __init init_debugfs(void)
+{
+	struct dentry * root;
+
+	if ((root = debugfs_create_dir("cpu-scheduler", NULL)) == NULL)
+		goto err_root;
+
+	debugfs_sched_create(min_timeslice, root);
+	debugfs_sched_create(def_timeslice, root);
+	debugfs_sched_create(on_runqueue_weight, root);
+	debugfs_sched_create(child_penalty, root);
+	debugfs_sched_create(parent_penalty, root);
+	debugfs_sched_create(exit_weight, root);
+	debugfs_sched_create(prio_bonus_ratio, root);
+	debugfs_sched_create(max_bonus, root);
+	debugfs_sched_create(interactive_delta , root);
+	debugfs_sched_create(max_sleep_avg, root);
+	debugfs_sched_create(starvation_limit, root);
+
+err_root:
+	return 0;
+}
+postcore_initcall(init_debugfs);
+
+void __init init_tunables(void)
+{
+	min_timeslice =		DEFAULT_MIN_TIMESLICE;
+	def_timeslice = 	DEFAULT_DEF_TIMESLICE;
+	on_runqueue_weight =	DEFAULT_ON_RUNQUEUE_WEIGHT;
+	child_penalty =		DEFAULT_CHILD_PENALTY;
+	parent_penalty = 	DEFAULT_PARENT_PENALTY;
+	exit_weight =		DEFAULT_EXIT_WEIGHT;
+	prio_bonus_ratio =	DEFAULT_PRIO_BONUS_RATIO;
+	max_bonus = 		DEFAULT_MAX_BONUS;
+	interactive_delta = 	DEFAULT_INTERACTIVE_DELTA;
+	max_sleep_avg =		DEFAULT_MAX_SLEEP_AVG;
+	starvation_limit =	DEFAULT_STARVATION_LIMIT;
+}
+#endif
+
 void __init sched_init(void)
 {
 	int i, j, k;
 
+#ifdef CONFIG_DEBUGFS_SCHED
+	init_tunables();
+#endif
+
 	for_each_possible_cpu(i) {
 		struct prio_array *array;
 		struct rq *rq;
Index: linux-rc/lib/Kconfig.debug
===================================================================
--- linux-rc.orig/lib/Kconfig.debug
+++ linux-rc/lib/Kconfig.debug
@@ -93,6 +93,14 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config DEBUGFS_SCHED
+	bool "Export CPU Scheduler Tunables"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
+	  If you say Y here, CPU Scheduler tuning knobs will be available via
+	  debugfs in /debug/cpu-scheduler/.  Note: No sanity checking is done
+	  on the values.
+
 config DEBUG_SLAB
 	bool "Debug slab memory allocations"
 	depends on DEBUG_KERNEL && SLAB

--



-- 
VGER BF report: U 0.528966
