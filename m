Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSDXMru>; Wed, 24 Apr 2002 08:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDXMrt>; Wed, 24 Apr 2002 08:47:49 -0400
Received: from zero.tech9.net ([209.61.188.187]:18698 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311919AbSDXMrs>;
	Wed, 24 Apr 2002 08:47:48 -0400
Subject: [PATCH] sched define cleanup, separate max priorities
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 24 Apr 2002 08:47:48 -0400
Message-Id: <1019652469.1470.292.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch is a resync against 2.5.10 of Ingo's revision of my
previous patch.

This patch replaces occurences of the magic numbers representing the
maximum priority and maximum RT priority with the (already defined and
used) MAX_PRIO and MAX_RT_PRIO.  It also introduces a new
MAX_USER_RT_PRIO define which allows the maximum user-space RT priority
to be set separate from the ultimate maximum RT priority.  This allows
kernel threads to be given priorities higher than any user-space task. 
Finally, this patch cleans up and adds some comments.

Specifically:

	- replace magic numbers by MAX_RT_PRIO and MAX_PRIO
	  defines as appropriate (me, mingo)
	- separate maximum user RT priority from ultimate
	  RT priority with MAX_USER_RT_PRIO (mingo)
	- comment changes and cleanup (me)

Enjoy,

	Robert Love

diff -urN linux-2.5.10/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.10/kernel/sched.c	Wed Apr 24 03:15:13 2002
+++ linux/kernel/sched.c	Wed Apr 24 08:39:16 2002
@@ -28,8 +28,13 @@
  * priority range is allocated to RT tasks, the 100-139
  * range is for SCHED_OTHER tasks. Priority values are
  * inverted: lower p->prio value means higher priority.
+ * 
+ * MAX_USER_RT_PRIO allows the actual maximum RT priority
+ * to be separate from the value exported to user-space.
+ * NOTE: MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 #define MAX_RT_PRIO		100
+#define MAX_USER_RT_PRIO	100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 /*
@@ -1071,7 +1076,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - 100;
+	return p->prio - MAX_USER_RT_PRIO;
 }
 
 int task_nice(task_t *p)
@@ -1137,7 +1142,7 @@
 	 * priority for SCHED_OTHER is 0.
 	 */
 	retval = -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > 99)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
 	if ((policy == SCHED_OTHER) != (lp.sched_priority == 0))
 		goto out_unlock;
@@ -1157,7 +1162,7 @@
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	if (policy != SCHED_OTHER)
-		p->prio = 99 - p->rt_priority;
+		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 	if (array)
@@ -1237,7 +1242,7 @@
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
@@ -1289,7 +1294,7 @@
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
@@ -1371,7 +1376,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = 99;
+		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_OTHER:
 		ret = 0;
@@ -1511,6 +1516,12 @@
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
@@ -1526,6 +1537,12 @@
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
@@ -1675,7 +1692,7 @@
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = cpu_logical_map((int) (long) bind_cpu);
-	struct sched_param param = { sched_priority: 99 };
+	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
 	runqueue_t *rq;
 	int ret;
 

