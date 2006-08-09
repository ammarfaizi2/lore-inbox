Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWHICrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWHICrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWHICrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:47:52 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:7460 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030438AbWHICrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:47:51 -0400
Message-Id: <20060809024637.231688000@mvista.com>
User-Agent: quilt/0.45-1
Date: Tue, 08 Aug 2006 19:46:37 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] lower migration thread/stop machine prio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should give some space at the top to allow things to schedule
above everything in a default system. I think this takes better
advantage of all the priorities we have. 

This moves the stop_machine and migration threads to SCHED_FIFO 
prio 80.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/sched.h        |    3 +++
 include/linux/stop_machine.h |    3 +++
 kernel/sched.c               |    3 +--
 kernel/stop_machine.c        |    2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.17/include/linux/sched.h
===================================================================
--- linux-2.6.17.orig/include/linux/sched.h
+++ linux-2.6.17/include/linux/sched.h
@@ -510,6 +510,9 @@ struct signal_struct {
 #define has_rt_policy(p) \
 	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
 
+/* Must be high prio: stop_machine expects to yield to it. */
+#define MIGRATION_THREAD_PRIO (MAX_RT_PRIO-20)
+
 /*
  * Some day this will be a full-fledged user tracking system..
  */
Index: linux-2.6.17/include/linux/stop_machine.h
===================================================================
--- linux-2.6.17.orig/include/linux/stop_machine.h
+++ linux-2.6.17/include/linux/stop_machine.h
@@ -8,6 +8,9 @@
 #include <asm/system.h>
 
 #if defined(CONFIG_STOP_MACHINE) && defined(CONFIG_SMP)
+
+#define STOP_MACHINE_PRIO (MAX_RT_PRIO-20)
+
 /**
  * stop_machine_run: freeze the machine on all CPUs and run this function
  * @fn: the function to run
Index: linux-2.6.17/kernel/sched.c
===================================================================
--- linux-2.6.17.orig/kernel/sched.c
+++ linux-2.6.17/kernel/sched.c
@@ -5289,9 +5289,8 @@ migration_call(struct notifier_block *nf
 			return NOTIFY_BAD;
 		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
-		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
-		__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
+		__setscheduler(p, SCHED_FIFO, MIGRATION_THREAD_PRIO);
 		task_rq_unlock(rq, &flags);
 		cpu_rq(cpu)->migration_thread = p;
 		break;
Index: linux-2.6.17/kernel/stop_machine.c
===================================================================
--- linux-2.6.17.orig/kernel/stop_machine.c
+++ linux-2.6.17/kernel/stop_machine.c
@@ -86,7 +86,7 @@ static void stopmachine_set_state(enum s
 static int stop_machine(void)
 {
 	int i, ret = 0;
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	struct sched_param param = { .sched_priority = STOP_MACHINE_PRIO };
 
 	/* One high-prio thread per cpu.  We'll do this one. */
 	sched_setscheduler(current, SCHED_FIFO, &param);
--
