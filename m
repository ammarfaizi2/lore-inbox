Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274097AbRI0X3D>; Thu, 27 Sep 2001 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274100AbRI0X2x>; Thu, 27 Sep 2001 19:28:53 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:57873 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S274097AbRI0X2s>;
	Thu, 27 Sep 2001 19:28:48 -0400
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-Id: <E15mkaf-0000ms-00@mail.tv-sign.ru>
From: Oleg Nesterov <oleg@tv-sign.ru>
Date: Fri, 28 Sep 2001 03:29:13 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am trying to understand the basics of softirq handling.

It seems to me that ksoftirqd()'s loop can be cleanuped a bit
with following (untested) patch on top of 2.4.10-softirq-A7.

It also removes	the 'mask' variable in do_softirq().

	Oleg

--- 2.4.10-softirq-A7/kernel/softirq.c.orig	Thu Sep 27 22:31:06 2001
+++ 2.4.10-softirq-A7/kernel/softirq.c	Thu Sep 27 22:54:37 2001
@@ -85,7 +85,7 @@
 {
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	int cpu = smp_processor_id();
-	__u32 pending, mask;
+	__u32 pending;
 	long flags;
 
 	if (in_interrupt())
@@ -98,7 +98,6 @@
 	if (pending) {
 		struct softirq_action *h;
 
-		mask = ~pending;
 		local_bh_disable();
 restart:
 		/* Reset the pending bitmask before enabling irqs */
@@ -381,26 +380,22 @@
 #endif
 
 	current->nice = 19;
-	schedule();
-	__set_current_state(TASK_INTERRUPTIBLE);
 	ksoftirqd_task(cpu) = current;
 
 	for (;;) {
-back:
+		schedule();
+		__set_current_state(TASK_INTERRUPTIBLE);
+
 		do {
 			do_softirq();
 			if (current->need_resched)
 				goto preempt;
 		} while (softirq_pending(cpu));
-		schedule();
-		__set_current_state(TASK_INTERRUPTIBLE);
-	}
 
+		continue;
 preempt:
-	__set_current_state(TASK_RUNNING);
-	schedule();
-	__set_current_state(TASK_INTERRUPTIBLE);
-	goto back;
+		__set_current_state(TASK_RUNNING);
+	}
 }
 
 static __init int spawn_ksoftirqd(void)
