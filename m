Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSI2UQ4>; Sun, 29 Sep 2002 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSI2UQZ>; Sun, 29 Sep 2002 16:16:25 -0400
Received: from fungus.teststation.com ([212.32.186.211]:38671 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S261766AbSI2UPe>; Sun, 29 Sep 2002 16:15:34 -0400
Date: Sun, 29 Sep 2002 22:19:59 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] wait_event_interruptible_timeout (1/3)
Message-ID: <Pine.LNX.4.44.0209292103140.19464-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


smbfs wants a wait_event_interruptible_timeout to be able to replace
interruptible_sleep_on_timeout.

Please apply.

/Urban


diff -urN -X exclude linux-2.5.39-orig/include/linux/sched.h linux-2.5.39-smbfs/include/linux/sched.h
--- linux-2.5.39-orig/include/linux/sched.h	Sun Sep 29 09:32:32 2002
+++ linux-2.5.39-smbfs/include/linux/sched.h	Sun Sep 29 18:51:21 2002
@@ -720,6 +720,45 @@
 	current->state = TASK_RUNNING;					\
 	remove_wait_queue(&wq, &__wait);				\
 } while (0)
+
+#define wait_event_interruptible(wq, condition)				\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible(wq, condition, __ret);	\
+	__ret;								\
+})
+
+#define __wait_event_interruptible_timeout(wq, condition, ret)		\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			ret = schedule_timeout(ret);			\
+			if (!ret)					\
+				break;					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_interruptible_timeout(wq, condition, __ret); \
+	__ret;								\
+})
 	
 /*
  * Must be called with the spinlock in the wait_queue_head_t held.
@@ -740,14 +779,6 @@
 	__remove_wait_queue(q,  wait);
 }
 
-#define wait_event_interruptible(wq, condition)				\
-({									\
-	int __ret = 0;							\
-	if (!(condition))						\
-		__wait_event_interruptible(wq, condition, __ret);	\
-	__ret;								\
-})
-
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
 

