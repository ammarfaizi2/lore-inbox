Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCCMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCCMSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCCLF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:05:57 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:6068 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261568AbVCCKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:17 -0500
Date: Thu, 3 Mar 2005 11:42:04 +0100
Message-Id: <200503031042.j23Ag4FG020724@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 7/16] DocBook: new kernel-doc comments for might_sleep & wait_event_*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: new kernel-doc comments for might_sleep & wait_event_*
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2031  -> 1.2032 
#	include/linux/kernel.h	1.60    -> 1.61   
#	include/linux/wait.h	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2032
# DocBook: new kernel-doc comments for might_sleep & wait_event_*
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Thu Mar  3 11:42:09 2005
+++ b/include/linux/kernel.h	Thu Mar  3 11:42:09 2005
@@ -48,10 +48,20 @@
 
 struct completion;
 
+/**
+ * might_sleep - annotation for functions that can sleep
+ *
+ * this macro will print a stack trace if it is executed in an atomic
+ * context (spinlock, irq-handler, ...).
+ *
+ * This is a useful debugging help to be able to catch problems early and not
+ * be biten later when the calling function happens to sleep when it is not
+ * supposed to.
+ */
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
-void __might_sleep(char *file, int line);
 #define might_sleep() __might_sleep(__FILE__, __LINE__)
 #define might_sleep_if(cond) do { if (unlikely(cond)) might_sleep(); } while (0)
+void __might_sleep(char *file, int line);
 #else
 #define might_sleep() do {} while(0)
 #define might_sleep_if(cond) do {} while (0)
diff -Nru a/include/linux/wait.h b/include/linux/wait.h
--- a/include/linux/wait.h	Thu Mar  3 11:42:09 2005
+++ b/include/linux/wait.h	Thu Mar  3 11:42:09 2005
@@ -169,6 +169,18 @@
 	finish_wait(&wq, &__wait);					\
 } while (0)
 
+/**
+ * wait_event - sleep until a condition gets true
+ * @wq: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ *
+ * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
+ * @condition evaluates to true. The @condition is checked each time
+ * the waitqueue @wq is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ */
 #define wait_event(wq, condition) 					\
 do {									\
 	if (condition)	 						\
@@ -191,6 +203,22 @@
 	finish_wait(&wq, &__wait);					\
 } while (0)
 
+/**
+ * wait_event_timeout - sleep until a condition gets true or a timeout elapses
+ * @wq: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
+ * @condition evaluates to true. The @condition is checked each time
+ * the waitqueue @wq is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function returns 0 if the @timeout elapsed, and the remaining
+ * jiffies if the condition evaluated to true before the timeout elapsed.
+ */
 #define wait_event_timeout(wq, condition, timeout)			\
 ({									\
 	long __ret = timeout;						\
@@ -217,6 +245,21 @@
 	finish_wait(&wq, &__wait);					\
 } while (0)
 
+/**
+ * wait_event_interruptible - sleep until a condition gets true
+ * @wq: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ *
+ * The process is put to sleep (TASK_INTERRUPTIBLE) until the
+ * @condition evaluates to true or a signal is received.
+ * The @condition is checked each time the waitqueue @wq is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function will return -ERESTARTSYS if it was interrupted by a
+ * signal and 0 if @condition evaluated to true.
+ */
 #define wait_event_interruptible(wq, condition)				\
 ({									\
 	int __ret = 0;							\
@@ -245,6 +288,23 @@
 	finish_wait(&wq, &__wait);					\
 } while (0)
 
+/**
+ * wait_event_interruptible_timeout - sleep until a condition gets true or a timeout elapses
+ * @wq: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_INTERRUPTIBLE) until the
+ * @condition evaluates to true or a signal is received.
+ * The @condition is checked each time the waitqueue @wq is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function returns 0 if the @timeout elapsed, -ERESTARTSYS if it
+ * was interrupted by a signal, and the remaining jiffies otherwise
+ * if the condition evaluated to true before the timeout elapsed.
+ */
 #define wait_event_interruptible_timeout(wq, condition, timeout)	\
 ({									\
 	long __ret = timeout;						\
