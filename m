Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUFRPM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUFRPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUFRPM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:12:26 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:3069 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S265218AbUFRPLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:11:23 -0400
Date: Fri, 18 Jun 2004 10:12:06 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add wait_event_interruptible_exclusive() macro
Message-ID: <40D30646.mailxA8X155I80@aqua.americas.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: dcn@sgi.com (Dean Nelson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines a macro that does exactly what wait_event_interruptible()
does except that it adds the current task to the wait queue as an exclusive
task (i.e., sets the WQ_FLAG_EXCLUSIVE flag) rather than as a non-exclusive
task as wait_event_interruptible() does.

This allows one to do a wake_up_nr() to wake up a specific number of tasks.
I'm in the process of submitting a patch to linux-ia64 that requires this
capability. (Its subject line is "[PATCH 3/4] SGI Altix cross partition
functionality".)


Index: linux/include/linux/wait.h
===================================================================
--- linux.orig/include/linux/wait.h
+++ linux/include/linux/wait.h
@@ -200,7 +200,36 @@
 		__wait_event_interruptible_timeout(wq, condition, __ret); \
 	__ret;								\
 })
-	
+
+#define __wait_event_interruptible_exclusive(wq, condition, ret)	\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue_exclusive(&wq, &__wait);				\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			schedule();					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible_exclusive(wq, condition)		\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible_exclusive(wq, condition, __ret);\
+	__ret;								\
+})
+
 /*
  * Must be called with the spinlock in the wait_queue_head_t held.
  */
