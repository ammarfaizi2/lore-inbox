Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315195AbSDWJ5n>; Tue, 23 Apr 2002 05:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315196AbSDWJ5m>; Tue, 23 Apr 2002 05:57:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46753 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315195AbSDWJ5k>;
	Tue, 23 Apr 2002 05:57:40 -0400
Date: Tue, 23 Apr 2002 09:53:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
In-Reply-To: <1019528599.1469.59.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204230948150.10873-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Apr 2002, Robert Love wrote:

> Attached patch replaces occurrences of the magic numbers representing
> maximum priority / maximum RT priority with the (already defined and
> used) MAX_PRIO and MAX_RT_PRIO defines.  The patch also contains some
> comment additions/changes (particularly to address the double_rq_lock
> ambiguity).  Very simple.

i agree that this area needs cleaning up, but i dont agree with all
aspects of your patch. I intentionally left the user-space API side
separate, MAX_RT can in fact be higher than 100 (without changing the
user-space API), the only rule is that it must not be smaller. We in fact
had such a situation once.  It's a perfectly valid goal to have 'super
high prio' kernel-space threads in the future that have in fact some
priority that cannot be reached by user-space threads.

so i've re-done a variation of your patch, which defines USER_MAX_RT_PRIO,
so the user-space API can still stay separate from the kernel-internal
representation.

i've also done some other changes:

>  /*
> - * Priority of a process goes from 0 to 139. The 0-99
> - * priority range is allocated to RT tasks, the 100-139
> - * range is for SCHED_OTHER tasks. Priority values are
> - * inverted: lower p->prio value means higher priority.
> + * Priority of a process goes from 0 to MAX_PRIO-1.  The
> + * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
> + * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
> + * Priority values are inverted: lower p->prio value means higher
> + * priority.

this i dont agree with either. The point of comments is easy
understanding, so i intentionally kept the 'hard' constants and i'm
updating them constantly - it's much easier to understand how things
happen if it does not happen via a define. The code itself i agree should
stay abstract, but the comments should stay as humanly readable as
possible.

(the set|get_affinity comment fixes i kept, plus the runqueue
double-lock/unlock comments as well, see the attached patch.)

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.544   -> 1.545  
#	      kernel/sched.c	1.71    -> 1.72   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/23	mingo@elte.hu	1.545
# - introduce MAX_USER_RT_PRIO
# - comment fixes from rml
# --------------------------------------------
#
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Apr 23 09:47:59 2002
+++ b/kernel/sched.c	Tue Apr 23 09:47:59 2002
@@ -28,8 +28,11 @@
  * priority range is allocated to RT tasks, the 100-139
  * range is for SCHED_OTHER tasks. Priority values are
  * inverted: lower p->prio value means higher priority.
+ * 
+ * NOTE: MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 #define MAX_RT_PRIO		100
+#define MAX_USER_RT_PRIO	100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 /*
@@ -1071,7 +1074,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - 100;
+	return p->prio - MAX_USER_RT_PRIO;
 }
 
 int task_nice(task_t *p)
@@ -1137,7 +1140,7 @@
 	 * priority for SCHED_OTHER is 0.
 	 */
 	retval = -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > 99)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
 	if ((policy == SCHED_OTHER) != (lp.sched_priority == 0))
 		goto out_unlock;
@@ -1157,7 +1160,7 @@
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	if (policy != SCHED_OTHER)
-		p->prio = 99 - p->rt_priority;
+		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 	if (array)
@@ -1237,7 +1240,7 @@
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
@@ -1289,7 +1292,7 @@
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process
- * @len: length of the bitmask pointed to by user_mask_ptr
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
  */
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
@@ -1371,7 +1374,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = 99;
+		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_OTHER:
 		ret = 0;
@@ -1511,6 +1514,12 @@
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
@@ -1526,6 +1535,12 @@
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
@@ -1675,7 +1690,7 @@
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = cpu_logical_map((int) (long) bind_cpu);
-	struct sched_param param = { sched_priority: 99 };
+	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
 	runqueue_t *rq;
 	int ret;
 

