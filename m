Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314439AbSDWCXP>; Mon, 22 Apr 2002 22:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315010AbSDWCXP>; Mon, 22 Apr 2002 22:23:15 -0400
Received: from zero.tech9.net ([209.61.188.187]:54797 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314439AbSDWCXM>;
	Mon, 22 Apr 2002 22:23:12 -0400
Subject: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 22:23:18 -0400
Message-Id: <1019528599.1469.59.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch replaces occurrences of the magic numbers representing
maximum priority / maximum RT priority with the (already defined and
used) MAX_PRIO and MAX_RT_PRIO defines.  The patch also contains some
comment additions/changes (particularly to address the double_rq_lock
ambiguity).  Very simple.

This is the invariant cleanup portion of another patch I am working on:
compile-time configurable maximum RT priorities.  But whether you buy
that or not, this is a sane cleanup.

Patch is against 2.5.9, super-duper-please apply.  Thank you,

	Robert Love

diff -urN linux-2.5.9/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.9/kernel/sched.c	Mon Apr 22 18:28:20 2002
+++ linux/kernel/sched.c	Mon Apr 22 22:12:26 2002
@@ -24,17 +24,18 @@
 #include <linux/kernel_stat.h>
 
 /*
- * Priority of a process goes from 0 to 139. The 0-99
- * priority range is allocated to RT tasks, the 100-139
- * range is for SCHED_OTHER tasks. Priority values are
- * inverted: lower p->prio value means higher priority.
+ * Priority of a process goes from 0 to MAX_PRIO-1.  The
+ * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
+ * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
+ * Priority values are inverted: lower p->prio value means higher
+ * priority.
  */
 #define MAX_RT_PRIO		100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ 100 ... 139 (MAX_PRIO-1) ],
+ * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
  */
 #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
@@ -1071,7 +1072,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - 100;
+	return p->prio - MAX_RT_PRIO;
 }
 
 int task_nice(task_t *p)
@@ -1131,13 +1132,13 @@
 				policy != SCHED_OTHER)
 			goto out_unlock;
 	}
-	
+
 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..99, valid
-	 * priority for SCHED_OTHER is 0.
+	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..MAX_RT_PRIO-1,
+	 * valid priority for SCHED_OTHER is 0.
 	 */
 	retval = -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > 99)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_RT_PRIO - 1)
 		goto out_unlock;
 	if ((policy == SCHED_OTHER) != (lp.sched_priority == 0))
 		goto out_unlock;
@@ -1157,7 +1158,7 @@
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	if (policy != SCHED_OTHER)
-		p->prio = 99 - p->rt_priority;
+		p->prio = (MAX_RT_PRIO - 1) - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 	if (array)
@@ -1237,7 +1238,7 @@
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
@@ -1289,7 +1290,7 @@
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
@@ -1371,7 +1372,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = 99;
+		ret = MAX_RT_PRIO - 1;
 		break;
 	case SCHED_OTHER:
 		ret = 0;
@@ -1511,6 +1512,12 @@
 	read_unlock(&tasklist_lock);
 }
 
+/*
+ * double_rq_lock - safely lock two runqueues
+ *
+ * Note this does not disable interrupts like task_rq_lock,
+ * you need to do so manually before calling.
+ */
 static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	if (rq1 == rq2)
@@ -1526,6 +1533,12 @@
 	}
 }
 
+/*
+ * double_rq_unlock - safely unlock two runqueues
+ *
+ * Note this does not restore interrupts like task_rq_unlock,
+ * you need to do so manually after calling.
+ */
 static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	spin_unlock(&rq1->lock);
@@ -1675,7 +1688,7 @@
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = cpu_logical_map((int) (long) bind_cpu);
-	struct sched_param param = { sched_priority: 99 };
+	struct sched_param param = { sched_priority: MAX_RT_PRIO - 1 };
 	runqueue_t *rq;
 	int ret;
 


