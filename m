Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285810AbRLHEfd>; Fri, 7 Dec 2001 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285812AbRLHEfY>; Fri, 7 Dec 2001 23:35:24 -0500
Received: from [202.96.44.20] ([202.96.44.20]:18147 "HELO smtp.263.net")
	by vger.kernel.org with SMTP id <S285810AbRLHEfN>;
	Fri, 7 Dec 2001 23:35:13 -0500
From: root <r6144@263.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15377.39251.359055.873680@localhost.localdomain>
Date: Sat, 8 Dec 2001 12:38:43 +0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make highly niced processes run only when idle
X-Mailer: VM 6.96 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a process with nice values >= 20 (according to
setpriority(2)) completely stop when there are other runnable
processes with smaller nice values.
Try run something with `nice -n 30' (which `setpriority' to 20)

NOTE: This Patch Should Not Be Used On Production Machine Unless
You Know What You Are Doing.

Only tested on a uniprocessor PentiumII.

I don't know whether this breaks the standard, but it should
break no programs.

Applies to 2.4.16.

Note: this patch file is hand-modified from rcsdiff output.

========= cut here ==========

diff -Nur linux-2.4.16/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.16/kernel/sched.c	2001/11/23 09:15:55
+++ linux/kernel/sched.c	2001/11/23 09:42:46
@@ -19,6 +19,12 @@
  * current-task
  */
 
+/*
+  private patch by WQC: we use nice values 20 and beyond for `idle priority' processes,
+  so that they take absolutely no process time when there are higher priority processes
+  running.
+*/
+
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -68,7 +74,8 @@
 #define TICK_SCALE(x)	((x) << 2)
 #endif
 
-#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)
+#define NICE_TO_TICKS(nice)\
+	(((nice) < 20) ? (TICK_SCALE(20-(nice))+1) : (TICK_SCALE(1)+1))
 
 
 /*
@@ -150,7 +157,8 @@
 	 * runnable process, but before the idle thread.
 	 * Also, dont trigger a counter recalculation.
 	 */
-	weight = -1;
+	/* If it yields, it ranks below the nicest processes */
+	weight = -999;
 	if (p->policy & SCHED_YIELD)
 		goto out;
 
@@ -166,9 +174,18 @@
 		 * over..
 		 */
 		weight = p->counter;
+		/* If this is included, the oh-so-large addition below
+		   will not work
+
 		if (!weight)
 			goto out;
-			
+		   However, to be consistent, we should give such a process a disadvantage.
+		*/
+		if (! weight) {
+		  if (p->nice < 20) weight = 800;
+		  else if (p->nice < 27) weight = (27 - p->nice) * 100;
+		  goto out;
+		}			
 #ifdef CONFIG_SMP
 		/* Give a largish advantage to the same processor...   */
 		/* (this is equivalent to penalizing other processors) */
@@ -179,7 +196,12 @@
 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
 			weight += 1;
-		weight += 20 - p->nice;
+		if (p->nice < 20)
+		  weight += 800 + 20 - p->nice;
+		else if (p->nice < 27)
+		  /* For super-nice ones, they are scheduled if no one else wants the CPU */
+		  weight += (27 - p->nice) * 100;
+                if (weight > 999) weight = 999;
 		goto out;
 	}
 
@@ -537,7 +559,7 @@
 	struct task_struct *prev, *next, *p;
 	struct list_head *tmp;
 	int this_cpu, c;
-
+	int need_recalc;
 
 	spin_lock_prefetch(&runqueue_lock);
 
@@ -590,17 +612,20 @@
 	 */
 	next = idle_task(this_cpu);
 	c = -1000;
+	need_recalc = 0;
 	list_for_each(tmp, &runqueue_head) {
 		p = list_entry(tmp, struct task_struct, run_list);
 		if (can_schedule(p, this_cpu)) {
 			int weight = goodness(p, this_cpu, prev->active_mm);
-			if (weight > c)
+			if (weight > c) {
 				c = weight, next = p;
+				need_recalc = (p->counter == 0);
+			}
 		}
 	}
 
 	/* Do we need to re-calculate counters? */
-	if (unlikely(!c)) {
+	if (unlikely(need_recalc)) {
 		struct task_struct *p;
 
 		spin_unlock_irq(&runqueue_lock);
@@ -857,17 +882,17 @@
 	if (increment < 0) {
 		if (!capable(CAP_SYS_NICE))
 			return -EPERM;
-		if (increment < -40)
-			increment = -40;
+		if (increment < -50)
+			increment = -50;
 	}
-	if (increment > 40)
-		increment = 40;
+	if (increment > 50)
+		increment = 50;
 
 	newprio = current->nice + increment;
 	if (newprio < -20)
 		newprio = -20;
-	if (newprio > 19)
-		newprio = 19;
+	if (newprio > 29)
+		newprio = 29;
 	current->nice = newprio;
 	return 0;
 }
diff -Nur linux-2.4.16/kernel/sys.c linux/kernel/sys.c
--- linux-2.4.16/kernel/sys.c	2001/11/17 11:42:42
+++ linux/kernel/sys.c	2001/11/17 11:44:50
@@ -206,8 +206,8 @@
 	error = -ESRCH;
 	if (niceval < -20)
 		niceval = -20;
-	if (niceval > 19)
-		niceval = 19;
+	if (niceval > 29)
+		niceval = 29;
 
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
@@ -249,7 +249,7 @@
 		long niceval;
 		if (!proc_sel(p, which, who))
 			continue;
-		niceval = 20 - p->nice;
+		niceval = 30 - p->nice;
 		if (niceval > retval)
 			retval = niceval;
 	}

