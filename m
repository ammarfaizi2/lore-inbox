Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGYQEb>; Thu, 25 Jul 2002 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGYQEb>; Thu, 25 Jul 2002 12:04:31 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:31212 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315162AbSGYQE3>;
	Thu, 25 Jul 2002 12:04:29 -0400
Date: Thu, 25 Jul 2002 18:07:43 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207251607.SAA19890@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] fix two unwrapped uses of thread_info->cpu
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.5.28 fixes two explicit accesses to thread_info->cpu
in generic code to use the new UP-optimised macros instead.

/Mikael

diff -ruN linux-2.5.28/fs/proc/array.c linux-2.5.28.up-opt/fs/proc/array.c
--- linux-2.5.28/fs/proc/array.c	Thu Jul 25 01:27:31 2002
+++ linux-2.5.28.up-opt/fs/proc/array.c	Thu Jul 25 01:36:09 2002
@@ -386,7 +386,7 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->thread_info->cpu,
+		task_cpu(task),
 		task->rt_priority,
 		task->policy);
 	if(mm)
diff -ruN linux-2.5.28/kernel/sched.c linux-2.5.28.up-opt/kernel/sched.c
--- linux-2.5.28/kernel/sched.c	Thu Jul 25 01:27:31 2002
+++ linux-2.5.28.up-opt/kernel/sched.c	Thu Jul 25 01:42:20 2002
@@ -357,7 +357,7 @@
  */
 void kick_if_running(task_t * p)
 {
-	if ((task_running(task_rq(p), p)) && (p->thread_info->cpu != smp_processor_id()))
+	if ((task_running(task_rq(p), p)) && (task_cpu(p) != smp_processor_id()))
 		resched_task(p);
 }
 
