Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVBKT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVBKT4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVBKT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:56:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52964 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262323AbVBKTz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:55:57 -0500
Date: Fri, 11 Feb 2005 11:55:53 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Al Borchers <alborchers@steinerpoint.com>
Cc: david-b@pacbell.net, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Message-ID: <20050211195553.GE2372@us.ibm.com>
References: <1108105628.420c599cf3558@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108105628.420c599cf3558@my.visi.com>
X-Operating-System: Linux 2.6.11-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:07:08AM -0600, Al Borchers wrote:
> 
> 
> On Thursday 10 February 2005 9:39 am, Nishanth Aravamudan wrote:
> >> It came up on IRC that the wait_cond*() functions from
> >> usb/serial/gadget.c could be useful in other parts of the kernel. Does
> >> the following patch make sense towards this?
> 
> Sure, if people want to use these.
> 
> I did not push them because they seemed a bit "heavy weight",
> but the construct is useful and general.
> 
> The docs should explain that the purpose is to wait atomically on
> a complex condition, and that the usage pattern is to hold the
> lock when using the wait_event_* functions or when changing any
> variable that might affect the condition and waking up the waiting
> processes.

How does this patch look? I wasn't sure if macros and DocBook-style
comments played well together, and the names of the macros pretty much
explain what they do :)

Description: The following patch attempts to make the wait_cond*()
functions from usb/serial/gadget.c, which are basically the same
as wait_event*() but with locks, globally available via wait.h. Adds a
comment to explain the usage pattern for all of the wait_event*()
macros.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-v/include/linux/wait.h	2004-12-24 13:34:57.000000000 -0800
+++ 2.6.11-rc3/include/linux/wait.h	2005-02-11 11:55:07.000000000 -0800
@@ -156,6 +156,32 @@ wait_queue_head_t *FASTCALL(bit_waitqueu
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 
+/*
+ * The wait_event*() macros wait atomically on @wq for a complex
+ * @condition to become true, thus avoiding the race conditions
+ * associated with the deprecated sleep_on*() family of functions.
+ *
+ * The macros indicate their usage in their name. Unless explicitly
+ * requested to be different, the following defaults are the case:
+ * 	- no lock needs to be grabbed/released;
+ * 	- a timeout is not requested, i.e. only @condition being true
+ * 		will cause the macro to return; and
+ * 	- the sleep will be in TASK_UNINTERRUPTIBLE, i.e. signals will
+ * 		be ignored.
+ * If the macro name contains:
+ * 	lock, then @lock should be held before calling wait_event*().
+ * 		It is released before sleeping and grabbed after
+ * 		waking, saving the current IRQ mask in @flags. This lock
+ * 		should also be held when changing any variables
+ * 		affecting the condition and when waking up the process.
+ * 	timeout, then even if @condition is not true, but @timeout
+ * 		jiffies have passed, the macro will return. The number
+ * 		of jiffies remaining in the delay will be returned
+ * 	interruptible, then signals will cause the macro to return
+ * 		early with a return code of -ERESTARTSYS
+ * 	exclusive, then current is an exclusive process and must be
+ *	 	selectively woken.
+ */
 #define __wait_event(wq, condition) 					\
 do {									\
 	DEFINE_WAIT(__wait);						\
@@ -176,6 +202,28 @@ do {									\
 	__wait_event(wq, condition);					\
 } while (0)
 
+#define __wait_event_lock(wq, condition, lock, flags)			\
+do {									\
+	DEFINE_WAIT(__wait);						\
+									\
+	for (;;) {							\
+		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		spin_unlock_irqrestore(lock, flags);			\
+		schedule();						\
+		spin_lock_irqsave(lock, flags);				\
+	}								\
+	finish_wait(&wq, &__wait);					\
+} while (0)
+
+#define wait_event_lock(wq, condition, lock, flags)			\
+do {									\
+	if (condition)							\
+		break;							\
+	__wait_event_lock(wq, condition, lock, flags);			\
+} while (0)
+
 #define __wait_event_timeout(wq, condition, ret)			\
 do {									\
 	DEFINE_WAIT(__wait);						\
@@ -199,6 +247,31 @@ do {									\
 	__ret;								\
 })
 
+#define __wait_event_timeout_lock(wq, condition, lock, flags, ret)	\
+do {									\
+	DEFINE_WAIT(__wait);						\
+									\
+	for (;;) {							\
+		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		spin_unlock_irqrestore(lock, flags);			\
+		ret = schedule_timeout(ret);				\
+		spin_lock_irqsave(lock, flags);				\
+		if (!ret)						\
+			break;						\
+	}								\
+	finish_wait(&wq, &__wait);					\
+} while (0)
+
+#define wait_event_timeout_lock(wq, condition, lock, flags, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!(condition)) 						\
+		__wait_event_timeout_lock(wq, condition, lock, flags, __ret); \
+	__ret;								\
+})
+
 #define __wait_event_interruptible(wq, condition, ret)			\
 do {									\
 	DEFINE_WAIT(__wait);						\
@@ -225,6 +298,34 @@ do {									\
 	__ret;								\
 })
 
+#define __wait_event_interruptible_lock(wq, condition, lock, flags, ret) \
+do {									\
+	DEFINE_WAIT(__wait);						\
+									\
+	for (;;) {							\
+		prepare_to_wait(&wq, &__wait, TASK_INTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			spin_unlock_irqrestore(lock, flags)		\
+			schedule();					\
+			spin_lock_irqsave(lock, flags)			\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	finish_wait(&wq, &__wait);					\
+} while (0)
+
+#define wait_event_interruptible_lock(wq, condition, lock, flags)	\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible_lock(wq, condition, lock, flags, __ret); \
+	__ret;								\
+})
+
 #define __wait_event_interruptible_timeout(wq, condition, ret)		\
 do {									\
 	DEFINE_WAIT(__wait);						\
@@ -253,6 +354,36 @@ do {									\
 	__ret;								\
 })
 
+#define __wait_event_interruptible_timeout_lock(wq, condition, lock, flags, ret) \
+do {									\
+	DEFINE_WAIT(__wait);						\
+									\
+	for (;;) {							\
+		prepare_to_wait(&wq, &__wait, TASK_INTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			spin_unlock_irqrestore(lock, flags);		\
+			ret = schedule_timeout(ret);			\
+			spin_lock_irqsave(lock, flags);			\
+			if (!ret)					\
+				break;					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	finish_wait(&wq, &__wait);					\
+} while (0)
+
+#define wait_event_interruptible_timeout_lock(wq, condition, lock, flags, timeout) \
+({									\
+	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_interruptible_timeout_lock(wq, condition, lock, flags, __ret); \
+	__ret;								\
+})
+
 #define __wait_event_interruptible_exclusive(wq, condition, ret)	\
 do {									\
 	DEFINE_WAIT(__wait);						\
