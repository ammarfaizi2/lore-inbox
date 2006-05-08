Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWEHFrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWEHFrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWEHFrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932322AbWEHFq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:46:59 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948445:sNHT169566950"
Subject: [PATCH 3/10] explict migrate tasks for cpu removal
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:43 +0800
Message-Id: <1147067143.2760.81.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make cpu_down explictly migrate tasks off dead cpus, this is to fix a dead
lock in bulk cpu hotremoval (An example of the deadlock is one dead cpu is
notifing udev the cpu is dead and khelper thread is on another dead cpu).
Detail info is in the code.

Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/include/linux/sched.h |    1 
 linux-2.6.17-rc3-root/kernel/cpu.c          |    7 ++
 linux-2.6.17-rc3-root/kernel/sched.c        |   67 +++++++++++++++++-----------
 3 files changed, 48 insertions(+), 27 deletions(-)

diff -puN include/linux/sched.h~explict-migrate-tasks include/linux/sched.h
--- linux-2.6.17-rc3/include/linux/sched.h~explict-migrate-tasks	2006-05-07 07:45:14.000000000 +0800
+++ linux-2.6.17-rc3-root/include/linux/sched.h	2006-05-07 07:45:14.000000000 +0800
@@ -997,6 +997,7 @@ extern void sched_exec(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void idle_task_exit(void);
+extern void migrate_tasks_off_dead_cpu(int cpu);
 #else
 static inline void idle_task_exit(void) {}
 #endif
diff -puN kernel/cpu.c~explict-migrate-tasks kernel/cpu.c
--- linux-2.6.17-rc3/kernel/cpu.c~explict-migrate-tasks	2006-05-07 07:45:14.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/cpu.c	2006-05-07 07:45:14.000000000 +0800
@@ -173,7 +173,12 @@ int cpu_down(unsigned int cpu)
 	kthread_bind(p, get_cpu());
 	put_cpu();
 
-	/* CPU is completely dead: tell everyone.  Too late to complain. */
+	/*
+	 * CPU is completely dead: tell everyone.  Too late to complain.
+	 * we explictly call migrate_tasks here, otherwise there is a deadlock,
+	 * one cpu's notifier handler is waiting for tasks in other dead CPUs
+	 */
+	migrate_tasks_off_dead_cpu(cpu);
 	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
 			(void *)(long)cpu) == NOTIFY_BAD)
 		BUG();
diff -puN kernel/sched.c~explict-migrate-tasks kernel/sched.c
--- linux-2.6.17-rc3/kernel/sched.c~explict-migrate-tasks	2006-05-07 07:45:14.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/sched.c	2006-05-07 07:45:14.000000000 +0800
@@ -4739,6 +4739,39 @@ static void migrate_dead_tasks(unsigned 
 		}
 	}
 }
+
+void migrate_tasks_off_dead_cpu(int cpu)
+{
+	struct runqueue *rq;
+	unsigned long flags;
+
+	migrate_live_tasks(cpu);
+	rq = cpu_rq(cpu);
+	kthread_stop(rq->migration_thread);
+	rq->migration_thread = NULL;
+	/* Idle task back to normal (off runqueue, low prio) */
+	rq = task_rq_lock(rq->idle, &flags);
+	deactivate_task(rq->idle, rq);
+	rq->idle->static_prio = MAX_PRIO;
+	__setscheduler(rq->idle, SCHED_NORMAL, 0);
+	migrate_dead_tasks(cpu);
+	task_rq_unlock(rq, &flags);
+	migrate_nr_uninterruptible(rq);
+	BUG_ON(rq->nr_running != 0);
+
+	/* No need to migrate the tasks: it was best-effort if
+	 * they didn't do lock_cpu_hotplug().  Just wake up
+	 * the requestors. */
+	spin_lock_irq(&rq->lock);
+	while (!list_empty(&rq->migration_queue)) {
+		migration_req_t *req;
+		req = list_entry(rq->migration_queue.next,
+				 migration_req_t, list);
+		list_del_init(&req->list);
+		complete(&req->done);
+	}
+	spin_unlock_irq(&rq->lock);
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
@@ -4779,32 +4812,14 @@ static int migration_call(struct notifie
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
 	case CPU_DEAD:
-		migrate_live_tasks(cpu);
-		rq = cpu_rq(cpu);
-		kthread_stop(rq->migration_thread);
-		rq->migration_thread = NULL;
-		/* Idle task back to normal (off runqueue, low prio) */
-		rq = task_rq_lock(rq->idle, &flags);
-		deactivate_task(rq->idle, rq);
-		rq->idle->static_prio = MAX_PRIO;
-		__setscheduler(rq->idle, SCHED_NORMAL, 0);
-		migrate_dead_tasks(cpu);
-		task_rq_unlock(rq, &flags);
-		migrate_nr_uninterruptible(rq);
-		BUG_ON(rq->nr_running != 0);
-
-		/* No need to migrate the tasks: it was best-effort if
-		 * they didn't do lock_cpu_hotplug().  Just wake up
-		 * the requestors. */
-		spin_lock_irq(&rq->lock);
-		while (!list_empty(&rq->migration_queue)) {
-			migration_req_t *req;
-			req = list_entry(rq->migration_queue.next,
-					 migration_req_t, list);
-			list_del_init(&req->list);
-			complete(&req->done);
-		}
-		spin_unlock_irq(&rq->lock);
+		/*
+		 * Shouldn't call migrate_tasks_off_dead_cpu here. We explictly
+		 * migrate tasks off dead cpu in cpu_down, otherwise there is
+		 * a deadlock in bulk cpu removal. When one dead CPU's notifier
+		 * handler is waitting for tasks in other dead CPUs' runqueue
+		 * and in the meantime other dead CPUs' tasks aren't migrated
+		 * to online cpus, the deadlock occurs.
+		 */
 		break;
 #endif
 	}
_

