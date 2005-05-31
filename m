Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVEaH21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVEaH21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVEaH21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:28:27 -0400
Received: from fmr17.intel.com ([134.134.136.16]:60116 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261282AbVEaH2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:28:05 -0400
Subject: [PATCH]CPU hotplug breaks wake_up_new_task
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 15:35:09 +0800
Message-Id: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There is a race condition at wake_up_new_task at CPU hotplug case.
Say do_fork
        copy_process (which sets new forked task's current cpu, cpu_allowed)
                <-------- the new forked task's current cpu is offline
        wake_up_new_task
wake_up_new_task will put the forked task into a dead cpu.

Thanks,
Shaohua

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.11-rc5-mm1-root/kernel/sched.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~wake_up_new_task_to_online_cpu kernel/sched.c
--- linux-2.6.11-rc5-mm1/kernel/sched.c~wake_up_new_task_to_online_cpu	2005-05-31 13:39:43.888682784 +0800
+++ linux-2.6.11-rc5-mm1-root/kernel/sched.c	2005-05-31 14:49:58.537958704 +0800
@@ -1412,6 +1412,10 @@ void fastcall sched_fork(task_t *p, int 
 	put_cpu();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int task_select_online_cpu(int dead_cpu, struct task_struct *tsk);
+#endif
+
 /*
  * wake_up_new_task - wake up a newly created task for the first time.
  *
@@ -1426,9 +1430,20 @@ void fastcall wake_up_new_task(task_t * 
 	runqueue_t *rq, *this_rq;
 
 	rq = task_rq_lock(p, &flags);
-	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
+#ifdef CONFIG_HOTPLUG_CPU
+	while (!cpu_online(cpu)) {
+		cpu = task_select_online_cpu(cpu, p);
+		set_task_cpu(p, cpu);
+		task_rq_unlock(rq, &flags);
+		/* CPU hotplug might occur here */
+		rq = task_rq_lock(p, &flags);
+		this_cpu = smp_processor_id();
+		cpu = task_cpu(p);
+	}
+#endif
+	BUG_ON(p->state != TASK_RUNNING);
 
 	/*
 	 * We decrease the sleep average of forking parents
@@ -4457,7 +4472,7 @@ wait_to_die:
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Figure out where task on dead CPU should go, use force if neccessary. */
-static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+static int task_select_online_cpu(int dead_cpu, struct task_struct *tsk)
 {
 	int dest_cpu;
 	cpumask_t mask;
@@ -4486,6 +4501,12 @@ static void move_task_off_dead_cpu(int d
 			       "longer affine to cpu%d\n",
 			       tsk->pid, tsk->comm, dead_cpu);
 	}
+	return dest_cpu;
+}
+
+static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+{
+	int dest_cpu = task_select_online_cpu(dead_cpu, tsk);
 	__migrate_task(tsk, dead_cpu, dest_cpu);
 }
 
_


