Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBWBPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBWBPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWBWBPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:15:23 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:39364 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750871AbWBWBPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:15:22 -0500
Message-ID: <43FD0CA8.6060701@bigpond.net.au>
Date: Thu, 23 Feb 2006 12:15:20 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       npiggin@suse.de, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       John Hawkes <hawkes@sgi.com>
Subject: [PATCH] sched: smpnice -- apply review suggestions
Content-Type: multipart/mixed;
 boundary="------------040901080103000604080103"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 23 Feb 2006 01:15:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040901080103000604080103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch applies the suggestions made by Con Kolivas for improving the 
smpnice code.

The non cosmetic part of the patch addresses the fact the mapping from 
nice values to task load weights for negative nice values does not match 
the implied CPU allocations in the function task_timeslice().  As 
suggested by Con the mapping function now uses the time slice 
information directly (via a slightly modified interface).

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040901080103000604080103
Content-Type: text/plain;
 name="smpnice-apply-review-comments"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-apply-review-comments"

Index: MM-2.6.X/include/linux/sched.h
===================================================================
--- MM-2.6.X.orig/include/linux/sched.h	2006-02-23 11:23:42.000000000 +1100
+++ MM-2.6.X/include/linux/sched.h	2006-02-23 12:02:16.000000000 +1100
@@ -699,13 +699,13 @@ struct task_struct {
 
 	int lock_depth;		/* BKL lock depth */
 
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#ifdef CONFIG_SMP
+#ifdef __ARCH_WANT_UNLOCKED_CTXSW
 	int oncpu;
 #endif
-	int prio, static_prio;
-#ifdef CONFIG_SMP
 	int load_weight;	/* for load balancing purposes */
 #endif
+	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
 
Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-23 11:23:42.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-23 11:55:37.000000000 +1100
@@ -170,13 +170,19 @@
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
 
-static unsigned int task_timeslice(task_t *p)
+static unsigned int static_prio_timeslice(int static_prio)
 {
-	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+	if (static_prio < NICE_TO_PRIO(0))
+		return SCALE_PRIO(DEF_TIMESLICE*4, static_prio);
 	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+		return SCALE_PRIO(DEF_TIMESLICE, static_prio);
 }
+
+static inline unsigned int task_timeslice(task_t *p)
+{
+	return static_prio_timeslice(p->static_prio);
+}
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -676,21 +682,23 @@ static int effective_prio(task_t *p)
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
  * of tasks with abnormal "nice" values across CPUs the contribution that
  * each task makes to its run queue's load is weighted according to its
- * scheduling class and "nice" value.
+ * scheduling class and "nice" value.  For SCHED_NORMAL tasks this is just a
+ * scaled version of the new time slice allocation that they receive on time
+ * slice expiry etc.
  */
 
 /*
- * Priority weight for load balancing ranges from 1/20 (nice==19) to 459/20 (RT
- * priority of 100).
+ * Assume: static_prio_timeslice(NICE_TO_PRIO(0)) == DEF_TIMESLICE
+ * If static_prio_timeslice() is ever changed to break this assumption then
+ * this code will need modification
  */
-#define NICE_TO_LOAD_PRIO(nice) \
-	((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
+#define TIME_SLICE_NICE_ZERO DEF_TIMESLICE
 #define LOAD_WEIGHT(lp) \
-	(((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
-#define NICE_TO_LOAD_WEIGHT(nice)	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))
-#define PRIO_TO_LOAD_WEIGHT(prio)	NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
+	(((lp) * SCHED_LOAD_SCALE) / TIME_SLICE_NICE_ZERO)
+#define PRIO_TO_LOAD_WEIGHT(prio) \
+	LOAD_WEIGHT(static_prio_timeslice(prio))
 #define RTPRIO_TO_LOAD_WEIGHT(rp) \
-	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
+	(PRIO_TO_LOAD_WEIGHT(MAX_RT_PRIO) + LOAD_WEIGHT(rp))
 
 static inline void set_load_weight(task_t *p)
 {

--------------040901080103000604080103--
