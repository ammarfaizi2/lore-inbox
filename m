Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVECS6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVECS6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVECS6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:58:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34809 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261590AbVECS6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:58:05 -0400
Date: Tue, 3 May 2005 11:58:01 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Kernel-Janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] add schedule_timeout_msecs() interface
Message-ID: <20050503185801.GB3372@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.12-rc3-mm2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new interface, paralleling schedule_timeout(), but accepting
instead a relative millisecond value. This is part of my overall effort
to incorporate human-time units in the soft-timer subsystem.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

 include/linux/sched.h |    2 +
 kernel/timer.c        |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

--- 2.6.12-rc3/kernel/timer.c	2005-04-29 11:03:06.000000000 -0700
+++ 2.6.12-rc3-dev/kernel/timer.c	2005-05-03 11:52:43.000000000 -0700
@@ -1129,6 +1129,64 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+/**
+ * schedule_timeout_msecs - sleep until timeout
+ * @timeout: timeout value in milliseconds
+ *
+ * Make the current task sleep until @timeout milliseconds have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout milliseconds are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time in
+ * milliseconds will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_MSECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_MSECS.
+ *
+ * In all cases the return value is guaranteed to be non-negative.
+ */
+fastcall unsigned int __sched schedule_timeout_msecs(unsigned int timeout)
+{
+	struct timer_list timer;
+	unsigned long expires;
+
+	if (timeout == MAX_SCHEDULE_TIMEOUT_MSECS) {
+		schedule();
+		goto out;
+	}
+
+	expires = jiffies + msecs_to_jiffies(timeout);
+
+	init_timer(&timer);
+	timer.expires = expires;
+	timer.data = (unsigned long)current;
+	timer.function = process_timeout;
+
+	add_timer(&timer);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+
+	if (jiffies > expires)
+		timeout = 0;
+	else
+		timeout = jiffies_to_msecs(expires - jiffies);
+
+out:
+	return timeout;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
--- 2.6.12-rc3/include/linux/sched.h	2005-04-29 11:03:06.000000000 -0700
+++ 2.6.12-rc3-dev/include/linux/sched.h	2005-05-03 11:30:25.000000000 -0700
@@ -182,7 +182,9 @@ extern void scheduler_tick(void);
 extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern unsigned int FASTCALL(schedule_timeout_msecs(unsigned int timeout));
 asmlinkage void schedule(void);
 
 struct namespace;
