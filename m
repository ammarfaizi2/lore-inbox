Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTGCPz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTGCPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:55:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:2557 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264590AbTGCPzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:55:45 -0400
Date: Thu, 3 Jul 2003 18:10:05 +0200 (MEST)
Message-Id: <200307031610.h63GA5qo006974@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.5.74] use task_cpu() not ->thread_info->cpu in sched.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes two p->thread_info->cpu occurrences in kernel/sched.c
to use the task_cpu(p) macro instead, which is optimised on UP.
Although one of the occurrences is under #ifdef CONFIG_SMP, it's bad
style to use the raw non-optimisable form in non-arch code. Please apply.

/Mikael

--- linux-2.5.74/kernel/sched.c.~1~	2003-07-03 12:32:46.000000000 +0200
+++ linux-2.5.74/kernel/sched.c	2003-07-03 12:37:30.000000000 +0200
@@ -508,8 +508,8 @@
 		}
 #ifdef CONFIG_SMP
 	       	else
-			if (unlikely(kick) && task_running(rq, p) && (p->thread_info->cpu != smp_processor_id()))
-				smp_send_reschedule(p->thread_info->cpu);
+			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
+				smp_send_reschedule(task_cpu(p));
 #endif
 		p->state = TASK_RUNNING;
 	}
@@ -1332,7 +1332,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
-	RCU_qsctr(prev->thread_info->cpu)++;
+	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
