Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTBCL0s>; Mon, 3 Feb 2003 06:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbTBCL0r>; Mon, 3 Feb 2003 06:26:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2155
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265786AbTBCL0I>; Mon, 3 Feb 2003 06:26:08 -0500
Date: Mon, 3 Feb 2003 06:34:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/6] CPU Hotplug core
Message-ID: <Pine.LNX.4.44.0302030403280.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/base/cpu.c             |    2 
 include/asm-generic/topology.h |    2 
 include/linux/brlock.h         |    1 
 include/linux/cpu.h            |    4 
 include/linux/mmzone.h         |    1 
 include/linux/sched.h          |    3 
 include/linux/smp.h            |   15 +--
 kernel/cpu.c                   |  205 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcupdate.c              |   12 ++
 kernel/sched.c                 |  190 ++++++++++++++++++++++++++++++--------
 kernel/softirq.c               |   70 ++++++++++++--
 kernel/timer.c                 |   14 ++
 kernel/workqueue.c             |  137 ++++++++++++++++++++-------
 13 files changed, 554 insertions(+), 102 deletions(-)

Index: linux-2.5.59-lch2/include/linux/brlock.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/brlock.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/brlock.h	17 Jan 2003 11:15:51 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/brlock.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -34,6 +34,7 @@
 /* Register bigreader lock indices here. */
 enum brlock_indices {
 	BR_NETPROTO_LOCK,
+	BR_CPU_LOCK,
 	__BR_END
 };
 
Index: linux-2.5.59-lch2/include/linux/cpu.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/cpu.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/cpu.h	17 Jan 2003 11:15:50 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/cpu.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -1,3 +1,5 @@
+#ifndef _LINUX_CPU_H
+#define _LINUX_CPU_H
 /*
  * include/linux/cpu.h - generic cpu definition
  *
@@ -16,8 +18,6 @@
  * - drivers/base/intf.c 
  * - Documentation/driver-model/interface.txt
  */
-#ifndef _LINUX_CPU_H_
-#define _LINUX_CPU_H_
 
 #include <linux/device.h>
 #include <linux/node.h>
Index: linux-2.5.59-lch2/include/linux/mmzone.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/mmzone.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/mmzone.h	17 Jan 2003 11:15:49 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/mmzone.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -188,6 +188,7 @@
 	int node_id;
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
+	struct task_struct *kswapd;
 } pg_data_t;
 
 extern int numnodes;
Index: linux-2.5.59-lch2/include/linux/sched.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/sched.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/sched.h	17 Jan 2003 11:15:50 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/sched.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -455,11 +455,14 @@
 #define node_nr_running_init() {}
 #endif
 
+/* Move tasks off this (offline) CPU onto another. */
+extern void migrate_all_tasks(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
+extern void wake_idle_cpu(unsigned int cpu);
 
 void yield(void);
 
Index: linux-2.5.59-lch2/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/smp.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/smp.h	17 Jan 2003 11:15:51 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/smp.h	20 Jan 2003 13:48:28 -0000	1.1.1.1.2.1
@@ -105,20 +105,15 @@
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
-struct notifier_block;
-
-/* Need to know about CPUs going up/down? */
-static inline int register_cpu_notifier(struct notifier_block *nb)
-{
-	return 0;
-}
-static inline void unregister_cpu_notifier(struct notifier_block *nb)
-{
-}
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
+
+/* Need to know about CPUs going up/down? */
+struct notifier_block;
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
 
 #endif /* __LINUX_SMP_H */
Index: linux-2.5.59-lch2/include/asm-generic/topology.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/asm-generic/topology.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/asm-generic/topology.h	17 Jan 2003 11:15:53 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/asm-generic/topology.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -42,7 +42,7 @@
 #define __node_to_first_cpu(node)	(0)
 #endif
 #ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(node)	(cpu_online_map)
+#define __node_to_cpu_mask(node)	(~0UL)
 #endif
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)
Index: linux-2.5.59-lch2/kernel/cpu.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpu.c
--- linux-2.5.59-lch2/kernel/cpu.c	17 Jan 2003 11:16:40 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/cpu.c	3 Feb 2003 09:33:13 -0000
@@ -1,5 +1,5 @@
 /* CPU control.
- * (C) 2001 Rusty Russell
+ * (C) 2001, 2002 Rusty Russell
  * This code is licenced under the GPL.
  */
 #include <linux/proc_fs.h>
@@ -8,11 +8,16 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/kmod.h>		/* for hotplug_path */
+#include <linux/brlock.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
+#ifdef CONFIG_SMP
 static struct notifier_block *cpu_chain = NULL;
 
 /* Need to know about CPUs going up/down? */
@@ -26,7 +31,149 @@
 	notifier_chain_unregister(&cpu_chain,nb);
 }
 
-int __devinit cpu_up(unsigned int cpu)
+#ifdef CONFIG_HOTPLUG
+/* Notify userspace when a cpu event occurs, by running '/sbin/hotplug
+ * cpu' with certain environment variables set.  */
+static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
+{
+	char *argv[3], *envp[5], cpu_str[12], action_str[32];
+	int i;
+
+	sprintf(cpu_str, "CPU=%d", cpu);
+	sprintf(action_str, "ACTION=%s", action);
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "cpu";
+	argv[i] = NULL;
+
+	i = 0;
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp [i++] = cpu_str;
+	envp [i++] = action_str;
+	envp [i] = NULL;
+
+	return call_usermodehelper(argv [0], argv, envp);
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int ret;
+
+	if ((ret = down_interruptible(&cpucontrol)) != 0) 
+		return ret;
+
+	if (!cpu_online(cpu)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (num_online_cpus() == 1) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Schedule ourselves on the dying CPU. */
+	set_cpus_allowed(current, 1UL << cpu);
+
+	/* Disable CPU. */
+	ret = __cpu_disable();
+	if (ret != 0) {
+		printk("CPU disable failed: %i\n", ret);
+		goto out;
+	}
+	BUG_ON(cpu_online(cpu));
+
+	/* Move other tasks off to other CPUs (simple since they are
+           not running now). */
+	migrate_all_tasks();
+
+	/* Move off dying CPU, which will revert to idle process. */
+	set_cpus_allowed(current, ~(1UL << cpu));
+
+	/* CPU has been disabled: tell everyone */
+	notifier_call_chain(&cpu_chain, CPU_OFFLINE, (void *)(long)cpu);
+
+	/* Die, CPU, die!. */
+	__cpu_die(cpu);
+
+	/* CPU is completely dead: tell everyone */
+	notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu);
+
+	printk("Done DEAD notifier.\n");
+	cpu_run_sbin_hotplug(cpu, "remove");
+	up(&cpucontrol);
+
+	/* Debugging, mainly for kernel threads which didn't clean up. */
+	{
+		struct task_struct *p;
+
+		write_lock_irq(&tasklist_lock);
+		for_each_process(p) {
+			if (p->thread_info->cpu == cpu
+			    && !(p->state & TASK_ZOMBIE))
+				printk("Left %s\n", p->comm);
+		}
+		write_unlock_irq(&tasklist_lock);
+	}
+	printk("Done cpu down: %i.\n", ret);
+	return ret;
+
+ out:
+	up(&cpucontrol);
+	return ret;
+}
+
+static ssize_t show_online(struct device *dev, char *buf)
+{
+	struct cpu *cpu = container_of(container_of(dev,struct sys_device,dev),
+				       struct cpu, sysdev);
+
+	return sprintf(buf, "%u\n", !!cpu_online(cpu->sysdev.id));
+}
+
+static ssize_t store_online(struct device *dev, const char *buf, size_t count)
+{
+	struct cpu *cpu = container_of(container_of(dev,struct sys_device,dev),
+				       struct cpu, sysdev);
+	ssize_t ret;
+
+	printk("cpu%d sending cpu%d %s\n", smp_processor_id(), cpu->sysdev.id,
+		(buf[0] == '1') ? "ONLINE" : "OFFLINE");
+
+	switch (buf[0]) {
+	case '0':
+		ret = cpu_down(cpu->sysdev.id);
+		break;
+	case '1':
+		ret = cpu_up(cpu->sysdev.id);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret > 0)
+		ret = count;
+	return ret;
+}
+
+static DEVICE_ATTR(online, 0600, show_online, store_online);
+
+#else /* !CONFIG_HOTPLUG */
+int cpu_down(unsigned int cpu)
+{
+       return -ENOSYS;
+}
+
+static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
+{
+	return 0;
+}
+#endif
+
+int cpu_up(unsigned int cpu)
 {
 	int ret;
 	void *hcpu = (void *)(long)cpu;
@@ -64,3 +211,57 @@
 	up(&cpucontrol);
 	return ret;
 }
+#else /* ... !CONFIG_SMP */
+/* Need to know about CPUs going up/down? */
+int register_cpu_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+void unregister_cpu_notifier(struct notifier_block *nb)
+{
+}
+int __devinit cpu_up(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+int cpu_down(unsigned int cpu)
+{
+       return -ENOSYS;
+}
+#endif /* CONFIG_SMP */
+
+extern struct device_class cpu_devclass;
+static struct device_driver cpu_driver = {
+	.name		= "cpu",
+	.bus		= &system_bus_type,
+	.devclass	= &cpu_devclass,
+};
+
+DEFINE_PER_CPU(struct cpu, cpu_devices) = {
+	.sysdev = { .name = "cpu",
+		    .dev = { .driver = &cpu_driver, },
+	},
+};
+
+static int __init register_cpus(void)
+{
+	unsigned int i;
+
+	driver_register(&cpu_driver);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		per_cpu(cpu_devices, i).sysdev.id = i;
+		sys_device_register(&per_cpu(cpu_devices, i).sysdev);
+#ifdef CONFIG_HOTPLUG
+		device_create_file(&per_cpu(cpu_devices, i).sysdev.dev,
+				   &dev_attr_online);
+#endif
+	}
+	return 0;
+}
+
+__initcall(register_cpus);
+
+EXPORT_SYMBOL_GPL(register_cpu_notifier);
+EXPORT_SYMBOL_GPL(unregister_cpu_notifier);
Index: linux-2.5.59-lch2/kernel/rcupdate.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/rcupdate.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rcupdate.c
--- linux-2.5.59-lch2/kernel/rcupdate.c	17 Jan 2003 11:16:39 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/rcupdate.c	3 Feb 2003 11:02:13 -0000
@@ -207,6 +207,14 @@
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
 }
 
+static void rcu_offline_cpu(int cpu)
+{
+        tasklet_kill(&RCU_tasklet(cpu));
+        list_del_init(&RCU_curlist(cpu));
+        list_del_init(&RCU_nxtlist(cpu));
+        memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
+}
+
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -215,7 +223,9 @@
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
 		break;
-	/* Space reserved for CPU_OFFLINE :) */
+	case CPU_DEAD:
+                rcu_offline_cpu(cpu);
+                break;
 	default:
 		break;
 	}
Index: linux-2.5.59-lch2/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/sched.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/kernel/sched.c	17 Jan 2003 11:16:40 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/sched.c	20 Jan 2003 13:48:28 -0000	1.1.1.1.2.1
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <linux/cpu.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -417,6 +418,13 @@
 	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
+
+/* Wake up a CPU from idle */
+void wake_idle_cpu(unsigned int cpu)
+{
+	resched_task(cpu_rq(cpu)->idle);
+}
+
 #endif
 
 /*
@@ -465,7 +473,8 @@
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			(p->cpus_allowed & (1UL << smp_processor_id())) &&
+			 cpu_online(smp_processor_id()))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -930,6 +939,11 @@
 	struct list_head *head, *curr;
 	task_t *tmp;
 
+	/* CPU going down is a special case: we don't pull more tasks
+	   onboard */
+	if (unlikely(!cpu_online(this_cpu)))
+		goto out;
+
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
 					cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
@@ -1778,15 +1792,21 @@
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	/* Stop CPUs going up and down. */
+	if (down_interruptible(&cpucontrol) != 0)
+		return -EINTR;
+
+	if (!(new_mask & cpu_online_map)) {
+		up(&cpucontrol);
 		return -EINVAL;
+	}
 
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
+		up(&cpucontrol);
 		return -ESRCH;
 	}
 
@@ -1807,6 +1827,7 @@
 	set_cpus_allowed(p, new_mask);
 
 out_unlock:
+	up(&cpucontrol);
 	put_task_struct(p);
 	return retval;
 }
@@ -1837,7 +1858,7 @@
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	mask = p->cpus_allowed;
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -2191,11 +2212,8 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
-#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (!(new_mask & cpu_online_map))
 		BUG();
-#endif
 
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
@@ -2226,6 +2244,102 @@
 	wait_for_completion(&req.done);
 }
 
+/* Move (not current) task off this cpu, onto dest cpu.  Reference to
+   task must be held. */
+static void move_task_away(struct task_struct *p, unsigned int dest_cpu)
+{
+	runqueue_t *rq_dest;
+	unsigned long flags;
+
+	rq_dest = cpu_rq(dest_cpu);
+
+	if (task_cpu(p) != smp_processor_id())
+		return; /* Already moved */
+
+	local_irq_save(flags);
+	double_rq_lock(this_rq(), rq_dest);
+	if (task_cpu(p) != smp_processor_id())
+		goto out; /* Already moved */
+
+	set_task_cpu(p, dest_cpu);
+	if (p->array) {
+		deactivate_task(p, this_rq());
+		activate_task(p, rq_dest);
+		if (p->prio < rq_dest->curr->prio)
+			resched_task(rq_dest->curr);
+	}
+ out:
+	double_rq_unlock(this_rq(), rq_dest);
+	local_irq_restore(flags);
+}
+
+#ifdef CONFIG_HOTPLUG
+/* Slow but sure.  We don't fight against load_balance, new people
+   setting affinity, or try_to_wake_up's fast path pulling things in,
+   as cpu_online() no longer true. */
+static int move_all_tasks(unsigned int kill_it)
+{
+	unsigned int num_signalled = 0;
+	unsigned int dest_cpu;
+	struct task_struct *g, *t;
+	unsigned long cpus_allowed;
+
+ again:
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		if (t == current)
+			continue;
+
+		/* Kernel threads which are bound to specific
+		   processors need to look after themselves
+		   with their own callbacks */
+		if (t->mm == NULL && t->cpus_allowed != ~0UL)
+			continue;
+
+		if (task_cpu(t) == smp_processor_id()) {
+			get_task_struct(t);
+			goto move_one;
+		}
+	} while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+	return num_signalled;
+
+ move_one:
+	read_unlock(&tasklist_lock);
+	cpus_allowed = t->cpus_allowed & ~(1UL << smp_processor_id());
+	dest_cpu = any_online_cpu(cpus_allowed);
+	if (dest_cpu < 0) {
+		num_signalled++;
+		if (!kill_it) {
+			/* FIXME: New signal needed? --RR */
+			force_sig(SIGPWR, t);
+			goto again;
+		}
+		/* Kill it (it can die on any CPU). */
+		t->cpus_allowed = ~(1 << smp_processor_id());
+		dest_cpu = any_online_cpu(t->cpus_allowed);
+		force_sig(SIGKILL, t);
+	}
+	move_task_away(t, dest_cpu);
+	put_task_struct(t);
+	goto again;
+}
+
+/* Move non-kernel-thread tasks off this (offline) CPU, except us. */
+void migrate_all_tasks(void)
+{
+	if (move_all_tasks(0)) {
+		/* Wait for processes to react to signal */
+		schedule_timeout(30*HZ);
+		move_all_tasks(1);
+	}
+}
+#endif /* CONFIG_HOTPLUG */
+
+/* This is the CPU to stop, and who to wake about it */
+static int migration_stop = -1;
+static struct completion migration_stopped;
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
@@ -2254,13 +2368,10 @@
 
 	sprintf(current->comm, "migration/%d", smp_processor_id());
 
-	for (;;) {
-		runqueue_t *rq_src, *rq_dest;
+	while (migration_stop != cpu) {
 		struct list_head *head;
-		int cpu_src, cpu_dest;
 		migration_req_t *req;
 		unsigned long flags;
-		task_t *p;
 
 		spin_lock_irqsave(&rq->lock, flags);
 		head = &rq->migration_queue;
@@ -2273,37 +2384,37 @@
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
 		spin_unlock_irqrestore(&rq->lock, flags);
-
-		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
-		rq_dest = cpu_rq(cpu_dest);
-repeat:
-		cpu_src = task_cpu(p);
-		rq_src = cpu_rq(cpu_src);
-
-		local_irq_save(flags);
-		double_rq_lock(rq_src, rq_dest);
-		if (task_cpu(p) != cpu_src) {
-			double_rq_unlock(rq_src, rq_dest);
-			local_irq_restore(flags);
-			goto repeat;
-		}
-		if (rq_src == rq) {
-			set_task_cpu(p, cpu_dest);
-			if (p->array) {
-				deactivate_task(p, rq_src);
-				activate_task(p, rq_dest);
-				if (p->prio < rq_dest->curr->prio)
-					resched_task(rq_dest->curr);
-			}
-		}
-		double_rq_unlock(rq_src, rq_dest);
-		local_irq_restore(flags);
+		move_task_away(req->task,
+			any_online_cpu(req->task->cpus_allowed));
 
 		complete(&req->done);
 	}
+	set_current_state(TASK_RUNNING);
+	printk("Migration thread for %u exiting\n", cpu);
+	rq->migration_thread = NULL;
+	complete(&migration_stopped);
+
+	return 0;
 }
 
+ /* No locking required: CPU notifiers are serialized */
+static void stop_migration_thread(unsigned int cpu)
+{
+	/* We want to wake it, but it may exit first. */
+	struct task_struct *migthread = cpu_rq(cpu)->migration_thread;
+
+	get_task_struct(migthread);
+	init_completion(&migration_stopped);
+	/* They must not access completion until it's initialized. */
+	wmb();
+	migration_stop = cpu;
+	wake_up_process(cpu_rq(cpu)->migration_thread);
+	wait_for_completion(&migration_stopped);
+	put_task_struct(migthread);
+	migration_stop = -1;
+}
+
+
 /*
  * migration_call - callback that gets triggered when a CPU is added.
  * Here we can start up the necessary migration thread for the new CPU.
@@ -2319,6 +2430,9 @@
 		kernel_thread(migration_thread, hcpu, CLONE_KERNEL);
 		while (!cpu_rq((long)hcpu)->migration_thread)
 			yield();
+		break;
+	case CPU_OFFLINE:
+		stop_migration_thread((long)hcpu);
 		break;
 	}
 	return NOTIFY_OK;
Index: linux-2.5.59-lch2/kernel/softirq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/softirq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 softirq.c
--- linux-2.5.59-lch2/kernel/softirq.c	17 Jan 2003 11:16:40 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/softirq.c	3 Feb 2003 11:03:59 -0000
@@ -296,10 +296,18 @@
 	register_cpu_notifier(&tasklet_nb);
 }
 
+/* This is the CPU to stop, and who to wake about it */
+static int ksoftirq_stop = -1;
+static struct task_struct *ksoftirq_killer = NULL;
+
 static int ksoftirqd(void * __bind_cpu)
 {
 	int cpu = (int) (long) __bind_cpu;
 
+	if (ksoftirqd_task(cpu))
+		BUG();
+
+	sprintf(current->comm, "ksoftirqd/%d", cpu);
 	daemonize();
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
@@ -310,14 +318,13 @@
 	if (smp_processor_id() != cpu)
 		BUG();
 
-	sprintf(current->comm, "ksoftirqd/%d", cpu);
-
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
 	ksoftirqd_task(cpu) = current;
 
-	for (;;) {
+	while (ksoftirq_stop != cpu) {
+		rmb();
 		if (!softirq_pending(cpu))
 			schedule();
 
@@ -330,24 +337,73 @@
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
+	set_current_state(TASK_RUNNING);
+
+	printk("ksoftirqd for %i dying\n", cpu);
+	ksoftirqd_task(cpu) = NULL;
+	wmb();
+	wake_up_process(ksoftirq_killer);
+
+	return 0;
 }
 
 static int __devinit cpu_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
 {
-	int hotcpu = (unsigned long)hcpu;
+	unsigned int hotcpu = (unsigned long)hcpu;
+	int ret = NOTIFY_OK;
 
-	if (action == CPU_ONLINE) {
+	switch (action) {
+	case CPU_ONLINE:
 		if (kernel_thread(ksoftirqd, hcpu, CLONE_KERNEL) < 0) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
-			return NOTIFY_BAD;
+			ret = NOTIFY_BAD;
+			break;
 		}
 
 		while (!ksoftirqd_task(hotcpu))
 			yield();
+ 		break;
+
+	case CPU_OFFLINE: {
+		struct task_struct *kd_task;
+
+		/* Kill ksoftirqd: get ref in case it exits before we
+		   wake it */
+		ksoftirq_killer = current;
+		kd_task = ksoftirqd_task(hotcpu);
+		get_task_struct(kd_task);
+		set_current_state(TASK_INTERRUPTIBLE);
+		ksoftirq_stop = hotcpu;
+		wake_up_process(kd_task);
+		while (ksoftirqd_task(hotcpu)) {
+			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
+		}
+		set_current_state(TASK_RUNNING);
+		put_task_struct(kd_task);
+		ksoftirq_stop = -1;
+		break;
  	}
-	return NOTIFY_OK;
+	case CPU_DEAD: {
+		struct tasklet_struct *i, *next;
+
+		/* Move pending softirqs from dead CPU to us. */
+		local_irq_disable();
+		for (i = per_cpu(tasklet_vec, hotcpu).list; i; i = next) {
+			next = i->next;
+			__tasklet_schedule(i);
+		}
+		for (i = per_cpu(tasklet_hi_vec, hotcpu).list; i; i = next) {
+			next = i->next;
+			__tasklet_hi_schedule(i);
+		}
+		local_irq_enable();
+		break;
+	}
+	}
+	return ret;
 }
 
 static struct notifier_block __devinitdata cpu_nfb = {
Index: linux-2.5.59-lch2/kernel/timer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/timer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 timer.c
--- linux-2.5.59-lch2/kernel/timer.c	17 Jan 2003 11:16:40 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/timer.c	3 Feb 2003 11:04:56 -0000
@@ -169,10 +169,14 @@
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
-	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+	tvec_base_t *base;
   	unsigned long flags;
   
   	BUG_ON(timer_pending(timer) || !timer->function);
+	if (cpu_online(cpu))
+		base = &per_cpu(tvec_bases, cpu);
+	else
+		base = &per_cpu(tvec_bases, smp_processor_id());
 
 	check_timer(timer);
 
@@ -1166,7 +1170,7 @@
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 }
-	
+
 static int __devinit timer_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -1175,13 +1179,17 @@
 	case CPU_UP_PREPARE:
 		init_timers_cpu(cpu);
 		break;
+	/* wait for pending timers?
+	case CPU_OFFLINE:
+		break;
+	*/
 	default:
 		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata timers_nb = {
+static struct notifier_block timers_nb = {
 	.notifier_call	= timer_cpu_notify,
 };
 
Index: linux-2.5.59-lch2/kernel/workqueue.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/workqueue.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/kernel/workqueue.c	17 Jan 2003 11:16:40 -0000	1.1.1.1
+++ linux-2.5.59-lch2/kernel/workqueue.c	20 Jan 2003 13:48:28 -0000	1.1.1.1.2.1
@@ -25,6 +25,8 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 /*
  * The per-CPU workqueue:
@@ -50,8 +52,13 @@
  */
 struct workqueue_struct {
 	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
+	const char *name;
+	struct list_head list;
 };
 
+/* All the workqueues on the system: protected by cpucontrol mutex. */
+static LIST_HEAD(workqueues);
+
 /*
  * Queue work on a workqueue. Return non-zero if it was successfully
  * added.
@@ -161,7 +168,6 @@
 typedef struct startup_s {
 	struct cpu_workqueue_struct *cwq;
 	struct completion done;
-	const char *name;
 } startup_t;
 
 static int worker_thread(void *__startup)
@@ -173,7 +179,7 @@
 	struct k_sigaction sa;
 
 	daemonize();
-	sprintf(current->comm, "%s/%d", startup->name, cpu);
+	sprintf(current->comm, "%s/%d", cwq->wq->name, cpu);
 	current->flags |= PF_IOTHREAD;
 	cwq->thread = current;
 
@@ -264,44 +270,52 @@
 	}
 }
 
-struct workqueue_struct *create_workqueue(const char *name)
+static int create_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
-	int ret, cpu, destroy = 0;
-	struct cpu_workqueue_struct *cwq;
 	startup_t startup;
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	int ret;
+
+	spin_lock_init(&cwq->lock);
+	cwq->wq = wq;
+	cwq->thread = NULL;
+	atomic_set(&cwq->nr_queued, 0);
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+
+	init_completion(&startup.done);
+	startup.cwq = cwq;
+	ret = kernel_thread(worker_thread, &startup, CLONE_FS | CLONE_FILES);
+	if (ret >= 0) {
+		wait_for_completion(&startup.done);
+		BUG_ON(!cwq->thread);
+	}
+	return ret;
+}
+
+struct workqueue_struct *create_workqueue(const char *name)
+{
+	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
 
 	BUG_ON(strlen(name) > 10);
-	startup.name = name;
 
 	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
+	wq->name = name;
 
+	down(&cpucontrol);
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		cwq = wq->cpu_wq + cpu;
-
-		spin_lock_init(&cwq->lock);
-		cwq->wq = wq;
-		cwq->thread = NULL;
-		atomic_set(&cwq->nr_queued, 0);
-		INIT_LIST_HEAD(&cwq->worklist);
-		init_waitqueue_head(&cwq->more_work);
-		init_waitqueue_head(&cwq->work_done);
-
-		init_completion(&startup.done);
-		startup.cwq = cwq;
-		ret = kernel_thread(worker_thread, &startup,
-						CLONE_FS | CLONE_FILES);
-		if (ret < 0)
+		if (create_workqueue_thread(wq, cpu) < 0)
 			destroy = 1;
-		else {
-			wait_for_completion(&startup.done);
-			BUG_ON(!cwq->thread);
-		}
 	}
+
+	list_add(&wq->list, &workqueues);
+
 	/*
 	 * Was there any error during startup? If yes then clean up:
 	 */
@@ -309,32 +323,78 @@
 		destroy_workqueue(wq);
 		wq = NULL;
 	}
+
+	up(&cpucontrol);
 	return wq;
 }
 
-void destroy_workqueue(struct workqueue_struct *wq)
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
 	struct cpu_workqueue_struct *cwq;
+
+	cwq = wq->cpu_wq + cpu;
+	if (cwq->thread) {
+		/* Initiate an exit and wait for it: */
+		init_completion(&cwq->exit);
+		wmb();
+		cwq->thread = NULL;
+		wmb();
+		wake_up(&cwq->more_work);
+
+		wait_for_completion(&cwq->exit);
+		printk("Workqueue thread %s for cpu %i exited\n",
+		       wq->name, cpu);
+	} else
+		printk("NO workqueue thread %s for cpu %i\n",
+		       wq->name, cpu);
+}
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
 	int cpu;
 
 	flush_workqueue(wq);
 
+	down(&cpucontrol);
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		cwq = wq->cpu_wq + cpu;
-		if (!cwq->thread)
-			continue;
-		/*
-		 * Initiate an exit and wait for it:
-		 */
-		init_completion(&cwq->exit);
-		cwq->thread = NULL;
-		wake_up(&cwq->more_work);
-
-		wait_for_completion(&cwq->exit);
+		cleanup_workqueue_thread(wq, cpu);
 	}
+	list_del(&wq->list);
 	kfree(wq);
+	up(&cpucontrol);
+}
+
+/* We're holding the cpucontrol mutex here */
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	unsigned int hotcpu = (unsigned long)hcpu;
+	struct workqueue_struct *wq;
+
+	switch (action) {
+	case CPU_ONLINE:
+		/* Start a new workqueue thread for it. */
+		list_for_each_entry(wq, &workqueues, list) {
+			if (create_workqueue_thread(wq, hotcpu) < 0) {
+				/* FIXME: Start workqueue at CPU_COMING_UP */
+				printk("workqueue for %i failed\n", hotcpu);
+				return NOTIFY_BAD;
+			}
+		}
+		return NOTIFY_OK;
+
+	case CPU_OFFLINE:
+		list_for_each_entry(wq, &workqueues, list) {
+			printk("Cleaning up workqueue for %s\n", wq->name);
+			cleanup_workqueue_thread(wq, hotcpu);
+		}
+		return NOTIFY_OK;
+	};
+
+	return NOTIFY_OK;
 }
 
 static struct workqueue_struct *keventd_wq;
@@ -371,8 +431,11 @@
 	return 0;
 }
 
+static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
+
 void init_workqueues(void)
 {
+	register_cpu_notifier(&cpu_nfb);
 	keventd_wq = create_workqueue("events");
 	BUG_ON(!keventd_wq);
 }
Index: linux-2.5.59-lch2/drivers/base/cpu.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/drivers/base/cpu.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/drivers/base/cpu.c	17 Jan 2003 11:15:18 -0000	1.1.1.1
+++ linux-2.5.59-lch2/drivers/base/cpu.c	20 Jan 2003 13:48:26 -0000	1.1.1.1.2.1
@@ -14,11 +14,11 @@
 {
 	return 0;
 }
+
 struct device_class cpu_devclass = {
 	.name		= "cpu",
 	.add_device	= cpu_add_device,
 };
-
 
 struct device_driver cpu_driver = {
 	.name		= "cpu",


