Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVBJRkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVBJRkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVBJRkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:40:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35241 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262173AbVBJRjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:39:52 -0500
Date: Thu, 10 Feb 2005 09:39:48 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: david-b@pacbell.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] add wait_event_*_lock() functions
Message-ID: <20050210173948.GE2364@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, LKML,

It came up on IRC that the wait_cond*() functions from
usb/serial/gadget.c could be useful in other parts of the kernel. Does
the following patch make sense towards this? I did not add corresponding
wait_event_exclusive() macros, as I don't think they would be used, but
that is a simple addition, if it would be desired for completeness.
I would greatly appreciate any input. If the patch (in this form or in a
later one) is acceptable, then we can remove the definitions from
usb/serial/gadget.c.

Description: The following patch attempts to make the wait_cond*()
functions from usb/serial/gadget.c, which are basically the same
as wait_event*() but with locks, globally available via wait.h.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-v/include/linux/wait.h	2004-12-24 13:34:57.000000000 -0800
+++ 2.6.11-rc3/include/linux/wait.h	2005-02-09 11:02:08.000000000 -0800
@@ -176,6 +176,28 @@
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
@@ -199,6 +221,31 @@
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
@@ -225,6 +272,34 @@
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
@@ -253,6 +328,36 @@
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
