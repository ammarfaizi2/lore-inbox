Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263030AbSJBJaJ>; Wed, 2 Oct 2002 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbSJBJaJ>; Wed, 2 Oct 2002 05:30:09 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:53397 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S263030AbSJBJaG>; Wed, 2 Oct 2002 05:30:06 -0400
Date: Wed, 2 Oct 2002 15:22:31 +0530 (IST)
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: [PATCH, 2.5.40] Add wait_event_timeout & change wait_event_interruptible_timeout
 ret val
Message-ID: <Pine.LNX.4.33.0210021517170.31822-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nice to have wait_event_interruptible_timeout, but it would be
necessary to return -ETIME upon timeout expiration (we need this
behaviour please !!). The following patch makes trivial changes
to __wait_even_interruptible_timeout macro to behave as below:

	if timeout occurs return -ETIME
	if interrupted, return -ERESTARTSYS
	if condition becomes true within specified timeout
	then return the remaining timeout

It also adds wait_event_timeout macro (again, we require it)

Please apply

~Hanu


--- linux-2.5.40/include/linux/sched.h	Wed Oct  2 13:59:47 2002
+++ linux/include/linux/sched.h	Wed Oct  2 14:37:52 2002
@@ -697,6 +697,33 @@
 	__wait_event(wq, condition);					\
 } while (0)

+#define __wait_event_timeout(wq, condition, ret) 			\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		if(ret = schedule_timeout(ret))				\
+			continue;					\
+		ret = -ETIME;						\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_timeout(wq, condition, timeout)			\
+({									\
+ 	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_timeout(wq, condition, __ret);		\
+	__ret;								\
+})
+
 #define __wait_event_interruptible(wq, condition, ret)			\
 do {									\
 	wait_queue_t __wait;						\
@@ -726,7 +753,7 @@
 	__ret;								\
 })

-#define __wait_event_interruptible_timeout(wq, condition, ret)		\
+#define __wait_event_interruptible_timeout(wq, condition, tout, ret)	\
 do {									\
 	wait_queue_t __wait;						\
 	init_waitqueue_entry(&__wait, current);				\
@@ -737,10 +764,10 @@
 		if (condition)						\
 			break;						\
 		if (!signal_pending(current)) {				\
-			ret = schedule_timeout(ret);			\
-			if (!ret)					\
-				break;					\
-			continue;					\
+			if(tout = schedule_timeout(tout))		\
+				continue;				\
+			ret = -ETIME;					\
+			break;						\
 		}							\
 		ret = -ERESTARTSYS;					\
 		break;							\
@@ -751,10 +778,10 @@

 #define wait_event_interruptible_timeout(wq, condition, timeout)	\
 ({									\
-	long __ret = timeout;						\
+	long __tout = timeout, __ret = 0;				\
 	if (!(condition))						\
-		__wait_event_interruptible_timeout(wq, condition, __ret); \
-	__ret;								\
+		__wait_event_interruptible_timeout(wq, condition, __tout, __ret); \
+	(__ret == 0) ? __tout : __ret;					\
 })

 /*

