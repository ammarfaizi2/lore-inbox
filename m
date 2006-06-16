Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFPHVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFPHVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWFPHVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 03:21:34 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18601 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751120AbWFPHVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 03:21:33 -0400
Date: Fri, 16 Jun 2006 16:23:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ashok.raj@intel.com
Subject: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu hot remove happens, tasks on the target cpu will be migrated even if
no available cpus in tsk->cpus_allowed. (See: move_task_off_dead_cpu().)

Usually, it looks ok (I think not good but may be ok.) But forced migration
should be avoided if there is RT task which is designed to run only on
specified cpu.

This patch checks there is no such RT task on the target cpu at CPU_DOWN_PREPARE.
(Hot remove can fail at this point.) If found, cpu hot remove will fail.
By printing messages, I expect system admin will do proper ops.

This is a bit pessimistic. But forecd migration of RT task which is bounded
to the special cpu will cause unpredictable trouble, I think.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 kernel/sched.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)

Index: linux-2.6.17-rc6-mm2/kernel/sched.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sched.c
+++ linux-2.6.17-rc6-mm2/kernel/sched.c
@@ -5006,6 +5006,36 @@ static void migrate_nr_uninterruptible(r
 	local_irq_restore(flags);
 }
 
+/*
+ * Verify there is no RT tasks which is tightly bound to the cpu
+ * which is going to be removed.
+ */
+static int test_migratable_rt_tasks(int cpu)
+{
+	struct task_struct *tsk, *t;
+	int ret = 0;
+
+	read_lock_irq(&tasklist_lock);
+	do_each_thread(t, tsk) {
+		if (tsk == current)
+			continue;
+		if ((task_cpu(tsk) == cpu) &&
+		    rt_task(tsk) &&
+		    cpus_weight(tsk->cpus_allowed) == 1) {
+			ret = 1;
+			goto out;
+		}
+	} while_each_thread(t, tsk);
+out:
+	read_unlock_irq(&tasklist_lock);
+
+	if (ret)
+		printk("cpu hot remove: there are some cpu-bound rt tasks on"
+	        	"cpu%d\n",cpu);
+
+	return ret;
+}
+
 /* Run through task list and migrate tasks from the dead cpu. */
 static void migrate_live_tasks(int src_cpu)
 {
@@ -5257,6 +5287,10 @@ static int migration_call(struct notifie
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
+	case CPU_DOWN_PREPARE:
+		if (test_migratable_rt_tasks(cpu))
+			return NOTIFY_BAD;
+		break;
 	case CPU_DEAD:
 		migrate_live_tasks(cpu);
 		rq = cpu_rq(cpu);

