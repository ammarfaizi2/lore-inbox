Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVGNUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVGNUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVGNUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:44:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20364 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262857AbVGNUn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:43:57 -0400
Date: Thu, 14 Jul 2005 13:41:32 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/4] new human-time schedule_timeout() functions
Message-ID: <20050714204132.GG28100@us.ibm.com>
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

Description: Add new human-time schedule_timeout() style functions,
along with the appropriate constants/prototypes.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |    7 ++
 include/linux/time.h  |    4 +
 kernel/timer.c        |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff -urpN 2.6.13-rc3-base/include/linux/sched.h 2.6.13-rc3-dev/include/linux/sched.h
--- 2.6.13-rc3-base/include/linux/sched.h	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-dev/include/linux/sched.h	2005-07-14 12:45:15.000000000 -0700
@@ -182,7 +182,14 @@ extern void scheduler_tick(void);
 extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_NSECS	((u64)(-1))
+#define	MAX_SCHEDULE_TIMEOUT_USECS	ULONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
+
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern u64 FASTCALL(schedule_timeout_nsecs(u64 timeout_nsecs));
+extern unsigned long FASTCALL(schedule_timeout_usecs(unsigned long timeout_usecs));
+extern unsigned int FASTCALL(schedule_timeout_msecs(unsigned int timeout_msecs));
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc3-base/include/linux/time.h 2.6.13-rc3-dev/include/linux/time.h
--- 2.6.13-rc3-base/include/linux/time.h	2005-07-14 12:45:07.000000000 -0700
+++ 2.6.13-rc3-dev/include/linux/time.h	2005-07-14 12:45:15.000000000 -0700
@@ -36,6 +36,10 @@ struct timezone {
 #define NSEC_PER_SEC (1000000000L)
 #endif
 
+#ifndef NSEC_PER_MSEC
+#define NSEC_PER_MSEC (1000000L)
+#endif
+
 #ifndef NSEC_PER_USEC
 #define NSEC_PER_USEC (1000L)
 #endif
diff -urpN 2.6.13-rc3-base/kernel/timer.c 2.6.13-rc3-dev/kernel/timer.c
--- 2.6.13-rc3-base/kernel/timer.c	2005-07-14 12:45:07.000000000 -0700
+++ 2.6.13-rc3-dev/kernel/timer.c	2005-07-14 12:45:15.000000000 -0700
@@ -1271,6 +1271,10 @@ static void process_timeout(unsigned lon
  * value will be %MAX_SCHEDULE_TIMEOUT.
  *
  * In all cases the return value is guaranteed to be non-negative.
+ *
+ * The callers of schedule_timeout() should be aware that the interface
+ * is now deprecated. schedule_timeout_{msecs,usecs,nsecs}() are now the
+ * interfaces for relative timeout requests.
  */
 fastcall signed long __sched schedule_timeout(signed long timeout)
 {
@@ -1326,6 +1330,149 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+/**
+ * schedule_timeout_nsecs - sleep until timeout
+ * @timeout_nsecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_nsecs nsecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_nsecs nsecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in nsecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_NSECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_NSECS.
+ */
+fastcall u64 __sched schedule_timeout_nsecs(u64 timeout_nsecs)
+{
+	struct timer_list timer;
+	u64 expires;
+
+	if (timeout_nsecs == MAX_SCHEDULE_TIMEOUT_NSECS) {
+		schedule();
+		goto out;
+	}
+
+	expires = do_monotonic_clock() + timeout_nsecs;
+
+	init_timer(&timer);
+	timer.data = (unsigned long) current;
+	timer.function = process_timeout;
+
+	set_timer_nsecs(&timer, expires);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+
+	timeout_nsecs = do_monotonic_clock();
+	if (expires < timeout_nsecs)
+		timeout_nsecs = (u64)0UL;
+	else
+		timeout_nsecs = expires - timeout_nsecs;
+out:
+	return timeout_nsecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_nsecs);
+
+/**
+ * schedule_timeout_usecs - sleep until timeout
+ * @timeout_usecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_usecs usecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_usecs usecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in usecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_USECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_USECS.
+ */
+fastcall inline unsigned long __sched schedule_timeout_usecs(unsigned long timeout_usecs)
+{
+	u64 timeout_nsecs;
+
+	if (timeout_usecs == MAX_SCHEDULE_TIMEOUT_USECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_usecs * (u64)NSEC_PER_USEC;
+	/*
+	 * Make sure to round up by subtracting one before division and
+	 * adding one after
+	 */
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, NSEC_PER_USEC);
+	timeout_usecs = (unsigned long)timeout_nsecs + 1UL;
+	return timeout_usecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_usecs);
+
+/**
+ * schedule_timeout_msecs - sleep until timeout
+ * @timeout_msecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_msecs msecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_msecs msecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in msecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_MSECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_MSECS.
+ */
+fastcall inline unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
+{
+	u64 timeout_nsecs;
+
+	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_msecs * (u64)NSEC_PER_MSEC;
+	/*
+	 * Make sure to round up by subtracting one before division and
+	 * adding one after
+	 */
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, NSEC_PER_MSEC);
+	timeout_msecs = (unsigned int)timeout_nsecs + 1;
+	return timeout_msecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
