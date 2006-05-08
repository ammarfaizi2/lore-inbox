Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWEHFsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWEHFsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEHFr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932324AbWEHFrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:07 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948482:sNHT94793132"
Subject: [PATCH 5/10] cpu bulk removal core changes
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:45 +0800
Message-Id: <1147067145.2760.83.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Core changes for cpu bulk removal. Modifies several functions to work with
cpumask_t.

Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---

 linux-2.6.17-rc3-root/kernel/cpu.c |  125 ++++++++++++++++++++++++++++---------
 1 files changed, 97 insertions(+), 28 deletions(-)

diff -puN kernel/cpu.c~cpu-bulk-remove-core kernel/cpu.c
--- linux-2.6.17-rc3/kernel/cpu.c~cpu-bulk-remove-core	2006-05-07 07:45:45.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/cpu.c	2006-05-07 07:45:45.000000000 +0800
@@ -82,29 +82,94 @@ void unregister_cpu_notifier(struct noti
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline void check_for_tasks(int cpu)
+static inline void check_for_tasks(cpumask_t remove_mask)
 {
 	struct task_struct *p;
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu &&
+		if (cpu_isset(task_cpu(p), remove_mask) &&
 		    (!cputime_eq(p->utime, cputime_zero) ||
 		     !cputime_eq(p->stime, cputime_zero)))
 			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
 				(state = %ld, flags = %lx) \n",
-				 p->comm, p->pid, cpu, p->state, p->flags);
+				 p->comm, p->pid, task_cpu(p), p->state, p->flags);
 	}
 	write_unlock_irq(&tasklist_lock);
 }
 
+/* on success, the cpu will be cleared from mask */
+static int bulk_cpu_notify(cpumask_t *mask, unsigned long val)
+{
+	int cpu, err = NOTIFY_DONE;
+
+	for_each_cpu_mask(cpu, *mask) {
+		err = blocking_notifier_call_chain(&cpu_chain, val,
+			(void *)(long)cpu);
+		if (err == NOTIFY_BAD)
+			break;
+		cpu_clear(cpu, *mask);
+	}
+
+	return err;
+}
+
+static int prepare_bulk_cpu_remove(cpumask_t remove_mask)
+{
+	int err, err1 = NOTIFY_DONE;
+	cpumask_t orig_mask, recover_mask;
+	char str[NR_CPUS];
+
+	orig_mask = remove_mask;
+	err = bulk_cpu_notify(&remove_mask, CPU_DOWN_PREPARE);
+
+	if (err == NOTIFY_BAD) {
+		/*
+		 * remove_mask now contains cpus not notified with DOWN_PREPARE
+		 */
+		cpumask_scnprintf(str, NR_CPUS, remove_mask);
+		printk("%s: attempt to take down CPU: %s failed\n",
+				__FUNCTION__, str);
+
+		/*
+		 * recover_mask = orig_mask & ~remove_mask
+		 * this should yeild cpus already notified successfully
+		 */
+		cpus_andnot(recover_mask, orig_mask, remove_mask);
+		if (!cpus_empty(recover_mask))
+			err1 = bulk_cpu_notify(&recover_mask, CPU_DOWN_FAILED);
+
+		if (err1 == NOTIFY_BAD)
+			BUG();
+	}
+	return err;
+}
+
+static void wait_to_leave_idle(cpumask_t mask)
+{
+	int cpu;
+
+	for_each_cpu_mask(cpu, mask) {
+		while (!idle_cpu(cpu))
+			yield();
+	}
+}
+
+static void bulk_migrate_tasks(cpumask_t mask)
+{
+	int cpu;
+	for_each_cpu_mask(cpu, mask)
+		migrate_tasks_off_dead_cpu(cpu);
+}
+
 /* Take this CPU down. */
-static int take_cpu_down(void *unused)
+static int take_cpu_down(void *data)
 {
 	int err;
+	cpumask_t remove_mask = *(cpumask_t *)data;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
-	err = __cpu_disable(cpumask_of_cpu(raw_smp_processor_id()));
+	err = __cpu_disable(remove_mask);
 	if (err < 0)
 		return err;
 
@@ -114,7 +179,7 @@ static int take_cpu_down(void *unused)
 	return 0;
 }
 
-int cpu_down(unsigned int cpu)
+int cpu_down_mask(cpumask_t remove_mask)
 {
 	int err;
 	struct task_struct *p;
@@ -123,51 +188,50 @@ int cpu_down(unsigned int cpu)
 	if ((err = lock_cpu_hotplug_interruptible()) != 0)
 		return err;
 
-	if (num_online_cpus() == 1) {
+	cpus_andnot(tmp, cpu_online_map, remove_mask);
+	if (cpus_empty(tmp)) {
 		err = -EBUSY;
 		goto out;
 	}
 
-	if (!cpu_online(cpu)) {
+	cpus_and(tmp, cpu_online_map, remove_mask);
+	if (!cpus_equal(tmp, remove_mask)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
-						(void *)(long)cpu);
+	err = prepare_bulk_cpu_remove(remove_mask);
 	if (err == NOTIFY_BAD) {
-		printk("%s: attempt to take down CPU %u failed\n",
-				__FUNCTION__, cpu);
 		err = -EINVAL;
 		goto out;
 	}
 
-	/* Ensure that we are not runnable on dying cpu */
+	/* Ensure that we are not runnable on any dying cpu */
 	old_allowed = current->cpus_allowed;
-	tmp = CPU_MASK_ALL;
-	cpu_clear(cpu, tmp);
+	cpus_andnot(tmp, CPU_MASK_ALL, remove_mask);
 	set_cpus_allowed(current, tmp);
 
-	p = __stop_machine_run(take_cpu_down, NULL, cpumask_of_cpu(cpu));
+	p = __stop_machine_run(take_cpu_down, &remove_mask, remove_mask);
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
-		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
-				(void *)(long)cpu) == NOTIFY_BAD)
+		tmp = remove_mask;
+		if (bulk_cpu_notify(&tmp, CPU_DOWN_FAILED) == NOTIFY_BAD)
 			BUG();
 
 		err = PTR_ERR(p);
 		goto out_allowed;
 	}
 
-	if (cpu_online(cpu))
+	/* FIXME: recover some CPUs */
+	cpus_and(tmp, cpu_online_map, remove_mask);
+	if (!cpus_empty(tmp))
 		goto out_thread;
 
-	/* Wait for it to sleep (leaving idle task). */
-	while (!idle_cpu(cpu))
-		yield();
+	/* Wait for them to sleep (leaving idle task). */
+	wait_to_leave_idle(remove_mask);
 
-	/* This actually kills the CPU. */
-	__cpu_die(cpumask_of_cpu(cpu));
+	/* This actually kills the CPUs. */
+	__cpu_die(remove_mask);
 
 	/* Move it here so it can run. */
 	kthread_bind(p, get_cpu());
@@ -178,12 +242,12 @@ int cpu_down(unsigned int cpu)
 	 * we explictly call migrate_tasks here, otherwise there is a deadlock,
 	 * one cpu's notifier handler is waiting for tasks in other dead CPUs
 	 */
-	migrate_tasks_off_dead_cpu(cpu);
-	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
-			(void *)(long)cpu) == NOTIFY_BAD)
+	bulk_migrate_tasks(remove_mask);
+	tmp = remove_mask;
+	if (bulk_cpu_notify(&tmp, CPU_DEAD) == NOTIFY_BAD)
 		BUG();
 
-	check_for_tasks(cpu);
+	check_for_tasks(remove_mask);
 
 out_thread:
 	err = kthread_stop(p);
@@ -193,6 +257,11 @@ out:
 	unlock_cpu_hotplug();
 	return err;
 }
+
+int cpu_down(unsigned int cpu)
+{
+	return cpu_down_mask(cpumask_of_cpu(cpu));
+}
 #endif /*CONFIG_HOTPLUG_CPU*/
 
 int __devinit cpu_up(unsigned int cpu)
_
