Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265990AbTGAFig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTGAFif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:38:35 -0400
Received: from dp.samba.org ([66.70.73.150]:11654 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265990AbTGAFho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:37:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, trivial@rustcorp.com.au
Subject: [PATCH] Make runqueues a per-cpu variable
Date: Tue, 01 Jul 2003 15:49:55 +1000
Message-Id: <20030701055206.5262D2C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Makes scheduler use per-cpu variables for the runqueues.

Name: Make Scheduler Use per-cpu 
Author: Rusty Russell
Status: Tested on 2.5.73-bk8

D: Makes scheduler use per-cpu variables for the runqueues.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27023-linux-2.5.73-bk4/kernel/sched.c .27023-linux-2.5.73-bk4.updated/kernel/sched.c
--- .27023-linux-2.5.73-bk4/kernel/sched.c	2003-06-27 12:48:17.000000000 +1000
+++ .27023-linux-2.5.73-bk4.updated/kernel/sched.c	2003-06-27 14:59:00.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/percpu.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -170,12 +171,12 @@ struct runqueue {
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
-} ____cacheline_aligned;
+};
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct runqueue, runqueues);
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
-#define this_rq()		cpu_rq(smp_processor_id())
+#define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
+#define this_rq()		(&__get_cpu_var(runqueues))
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
