Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbVGNUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbVGNUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVGNUpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:45:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20108 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261721AbVGNUn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:43:57 -0400
Date: Thu, 14 Jul 2005 13:43:33 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/4] convert sys_nanosleep() to use set_timer_nsecs()
Message-ID: <20050714204333.GH28100@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714202629.GD28100@us.ibm.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Description: Add timespec and timeval conversion functions for
nanoseconds. Convert sys_nanosleep() to use schedule_timeout_nsecs().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/time.h |   33 +++++++++++++++++++++++++++++++++
 kernel/timer.c       |   24 ++++++++++++------------
 2 files changed, 45 insertions(+), 12 deletions(-)

diff -urpN 2.6.13-rc3-base/include/linux/time.h 2.6.13-rc3-dev/include/linux/time.h
--- 2.6.13-rc3-base/include/linux/time.h	2005-07-14 12:46:46.000000000 -0700
+++ 2.6.13-rc3-dev/include/linux/time.h	2005-07-14 12:48:25.000000000 -0700
@@ -2,6 +2,7 @@
 #define _LINUX_TIME_H
 
 #include <linux/types.h>
+#include <asm/div64.h>
 
 #ifdef __KERNEL__
 #include <linux/seqlock.h>
@@ -126,6 +127,38 @@ set_normalized_timespec (struct timespec
 	ts->tv_nsec = nsec;
 }
 
+/* Inline helper functions */
+static inline struct timeval nsecs_to_timeval(u64 ns)
+{
+	struct timeval tv;
+	tv.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &tv.tv_usec);
+	tv.tv_usec = (tv.tv_usec + NSEC_PER_USEC/2) / NSEC_PER_USEC;
+	return tv;
+}
+
+static inline struct timespec nsecs_to_timespec(u64 ns)
+{
+	struct timespec ts;
+	ts.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &ts.tv_nsec);
+	return ts;
+}
+
+static inline u64 timespec_to_nsecs(struct timespec* ts)
+{
+	u64 ret;
+	ret = ((u64)ts->tv_sec) * NSEC_PER_SEC;
+	ret += (u64)ts->tv_nsec;
+	return ret;
+}
+
+static inline u64 timeval_to_nsecs(struct timeval* tv)
+{
+	u64 ret;
+	ret = ((u64)tv->tv_sec) * NSEC_PER_SEC;
+	ret += ((u64)tv->tv_usec) * NSEC_PER_USEC;
+	return ret;
+}
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff -urpN 2.6.13-rc3-base/kernel/timer.c 2.6.13-rc3-dev/kernel/timer.c
--- 2.6.13-rc3-base/kernel/timer.c	2005-07-14 12:46:46.000000000 -0700
+++ 2.6.13-rc3-dev/kernel/timer.c	2005-07-14 12:48:25.000000000 -0700
@@ -1481,21 +1481,21 @@ asmlinkage long sys_gettid(void)
 
 static long __sched nanosleep_restart(struct restart_block *restart)
 {
-	unsigned long expire = restart->arg0, now = jiffies;
+	u64 expire = restart->arg0, now = do_monotonic_clock();
 	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
 	long ret;
 
 	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
+	if (now > expire)
 		return 0;
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire - now);
+	set_current_state(TASK_INTERRUPTIBLE);
+	expire = schedule_timeout_nsecs(expire - now);
 
 	ret = 0;
 	if (expire) {
 		struct timespec t;
-		jiffies_to_timespec(expire, &t);
+		t = nsecs_to_timespec(expire);
 
 		ret = -ERESTART_RESTARTBLOCK;
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
@@ -1508,7 +1508,7 @@ static long __sched nanosleep_restart(st
 asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
 {
 	struct timespec t;
-	unsigned long expire;
+	u64 expire;
 	long ret;
 
 	if (copy_from_user(&t, rqtp, sizeof(t)))
@@ -1517,20 +1517,20 @@ asmlinkage long sys_nanosleep(struct tim
 	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	expire = timespec_to_nsecs(&t);
+	set_current_state(TASK_INTERRUPTIBLE);
+	expire = schedule_timeout_nsecs(expire);
 
 	ret = 0;
 	if (expire) {
 		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
+		t = nsecs_to_timespec(expire);
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
 			return -EFAULT;
 
 		restart = &current_thread_info()->restart_block;
 		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
+		restart->arg0 = do_monotonic_clock() + expire;
 		restart->arg1 = (unsigned long) rmtp;
 		ret = -ERESTART_RESTARTBLOCK;
 	}
@@ -1642,7 +1642,7 @@ static void __devinit init_timers_cpu(in
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = jiffies;
+	base->last_timer_time = 0UL;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
