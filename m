Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVGWA1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVGWA1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVGWA1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:27:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33000 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262252AbVGWA1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:27:07 -0400
Date: Fri, 22 Jul 2005 17:27:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723002658.GA4183@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708160824.10d4b606.akpm@osdl.org>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.2005 [16:08:24 -0700], Andrew Morton wrote:
> domen@coderock.org wrote:
> >
> > @@ -655,7 +655,7 @@ i2QueueCommands(int type, i2ChanStrPtr p
> >  			timeout--;   // So negative values == forever
> >  		
> >  		if (!in_interrupt()) {
> 
> I worry about what this driver is trying to do...
> 
> > -			current->state = TASK_INTERRUPTIBLE;
> > +			set_current_state(TASK_INTERRUPTIBLE);
> >  			schedule_timeout(1);	// short nap 
> 
> We do this all over the place.  Adding new schedule_timeout_interruptible()
> and schedule_timeout_uninterruptible() would reduce kernel size and neaten
> things up.

How does something like this look? If this looks ok, I'll send out
bunches of patches to add users of the new interfaces.

Description: Add wrappers for interruptible/uninterruptible
schedule_timeout() callers. Also add millisecond equivalents.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |   11 ++++
 kernel/timer.c        |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff -urpN 2.6.13-rc3/include/linux/sched.h 2.6.13-rc3-new_interfaces/include/linux/sched.h
--- 2.6.13-rc3/include/linux/sched.h	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/include/linux/sched.h	2005-07-22 16:28:47.000000000 -0700
@@ -181,8 +181,17 @@ extern void scheduler_tick(void);
 /* Is this address in the __sched functions? */
 extern int in_sched_functions(unsigned long addr);
 
-#define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern signed long FASTCALL(schedule_timeout_interruptible
+							(signed long timeout));
+extern signed long FASTCALL(schedule_timeout_uninterruptible
+							(signed long timeout));
+extern unsigned int FASTCALL(schedule_timeout_interruptible_msecs
+						(unsigned int timeout_msecs));
+extern unsigned int FASTCALL(schedule_timeout_uninterruptible_msecs
+						(unsigned int timeout_msecs));
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc3/kernel/timer.c 2.6.13-rc3-new_interfaces/kernel/timer.c
--- 2.6.13-rc3/kernel/timer.c	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/kernel/timer.c	2005-07-22 16:31:31.000000000 -0700
@@ -1153,6 +1153,131 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+/**
+ * schedule_timeout_interruptible - sleep until timeout, wait-queue
+ *					 event or signal
+ * @timeout: timeout value in jiffies
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+fastcall signed long __sched schedule_timeout_interruptible(signed long timeout)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+
+EXPORT_SYMBOL(schedule_timeout_interruptible);
+
+/**
+ * schedule_timeout_uninterruptible - sleep until timeout or wait-queue
+ * 					event
+ * @timeout: timeout value in jiffies
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+fastcall signed long __sched schedule_timeout_uninterruptible(signed long timeout)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+
+EXPORT_SYMBOL(schedule_timeout_uninterruptible);
+
+/*
+ * schedule_timeout_msecs - sleep until timeout
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A human-time (but otherwise identical) alternative to
+ * schedule_timeout() The state, therefore, *does* need to be set before
+ * calling this function, but this function should *never* be called
+ * directly. Use the nice wrappers, schedule_{interruptible,
+ * uninterruptible}_timeout_msecs().
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+fastcall inline unsigned int __sched schedule_timeout_msecs
+						(unsigned int timeout_msecs)
+{
+	struct timer_list timer;
+	unsigned long expire_jifs;
+	signed long remaining_jifs;
+
+	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS) {
+		schedule();
+		goto out;
+	}
+
+	/*
+	 * msecs_to_jiffies() is a unit conversion, which truncates
+	 * (rounds down), so we need to add 1.
+	 */
+	expire_jifs = jiffies + msecs_to_jiffies(timeout_msecs) + 1;
+
+	init_timer(&timer);
+	timer.expires = expire_jifs;
+	timer.data = (unsigned long) current;
+	timer.function = process_timeout;
+
+	add_timer(&timer);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+
+	remaining_jifs = expire_jifs - jiffies;
+	/* if we have woken up *before* we have requested */
+	if (remaining_jifs > 0)
+		/*
+		 * don't need to add 1 here, even though there is
+		 * truncation, because we will add 1 if/when the value
+		 * is sent back in
+		 */
+		timeout_msecs = jiffies_to_msecs(remaining_jifs);
+	else
+		timeout_msecs = 0;
+
+ out:
+	return timeout_msecs;
+}
+
+/**
+ * schedule_timeout_msecs_interruptible - sleep until timeout,
+ *						 wait-queue event, or signal
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A nice wrapper for the common
+ * set_current_state()/schedule_timeout_msecs() usage.  The state,
+ * therefore, does *not* need to be set before calling this function.
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+fastcall unsigned int __sched schedule_timeout_msecs_interruptible
+						(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_interruptible);
+
+/**
+ * schedule_timeout_msecs_uninterrutible - sleep until timeout or
+ * 						wait-queue event
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A nice wrapper for the common
+ * set_current_state()/schedule_timeout_msecs() usage.  The state,
+ * therefore, does *not* need to be set before calling this function.
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+fastcall unsigned int __sched schedule_timeout_msecs_uninterruptible
+						(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_uninterruptible);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
