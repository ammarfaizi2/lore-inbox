Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVGWBJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVGWBJB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGWBJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:09:00 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:62849 "EHLO
	DTRAYOWCRO001.pngxnet.com") by vger.kernel.org with ESMTP
	id S261457AbVGWBIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:08:55 -0400
Date: Fri, 22 Jul 2005 18:08:01 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, domen@coderock.org,
       linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [UPDATE PATCH] Add schedule_timeout_{interruptible,uninterruptible}_msecs() interfaces
Message-ID: <20050723010801.GA4366@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122078715.5734.15.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.2005 [20:31:55 -0400], Arjan van de Ven wrote:
> 
> > How does something like this look? If this looks ok, I'll send out
> > bunches of patches to add users of the new interfaces.
> 
> I'd drop the FASTCALL stuff... nowadays with regparm that's automatic
> and the cost of register-vs-stack isn't too big anyway
> 
> 
> Also I'd rather not add the non-msec ones... either you're raw and use
> HZ, or you are "cooked" and use the msec variant.. I dont' see the point
> of adding an "in the middle" one. (Yes this means that several users
> need to be transformed to msecs but... I consider that progress ;)

Thanks for the feedback! Does this look better? I will be more than
happy to convert those users to msecs which should, btw :) I've been
waiting to add this interface so that the ones that couldn't use
msleep{,_interruptible}() because of wait-queues, can also be changed to
use milliseconds.

Hrm, I also noticed I typo'd the externs in sched.h. Fixed in the new
patch.

Description: Add schedule_timeout_msecs() and add wrappers for
interruptible/uninterruptible schedule_timeout_msecs() callers.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |    7 +++
 kernel/timer.c        |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)

diff -urpN 2.6.13-rc3/include/linux/sched.h 2.6.13-rc3-new_interfaces/include/linux/sched.h
--- 2.6.13-rc3/include/linux/sched.h	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/include/linux/sched.h	2005-07-22 18:06:36.000000000 -0700
@@ -181,8 +181,13 @@ extern void scheduler_tick(void);
 /* Is this address in the __sched functions? */
 extern int in_sched_functions(unsigned long addr);
 
-#define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern unsigned int schedule_timeout_msecs_interruptible
+						(unsigned int timeout_msecs);
+extern unsigned int schedule_timeout_msecs_uninterruptible
+						(unsigned int timeout_msecs);
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc3/kernel/timer.c 2.6.13-rc3-new_interfaces/kernel/timer.c
--- 2.6.13-rc3/kernel/timer.c	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/kernel/timer.c	2005-07-22 18:00:46.000000000 -0700
@@ -1153,6 +1153,100 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
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
+inline unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
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
+unsigned int __sched schedule_timeout_msecs_interruptible
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
+unsigned int __sched schedule_timeout_msecs_uninterruptible
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
