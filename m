Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTBQIN5>; Mon, 17 Feb 2003 03:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTBQIHy>; Mon, 17 Feb 2003 03:07:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:26782
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266939AbTBQIFQ>; Mon, 17 Feb 2003 03:05:16 -0500
Date: Mon, 17 Feb 2003 03:13:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.5][1/5] CPU Hotplug core
Message-ID: <Pine.LNX.4.50.0302170302460.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 include/asm-generic/topology.h |    3 
 include/linux/brlock.h         |    1 
 include/linux/mmzone.h         |    1 
 include/linux/sched.h          |    3 
 include/linux/smp.h            |   24 +----
 kernel/Makefile                |    3 
 kernel/cpu.c                   |  193 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcupdate.c              |   67 ++++++++++++++
 kernel/sched.c                 |  190 ++++++++++++++++++++++++++++++++--------
 kernel/softirq.c               |   70 +++++++++++++-
 kernel/timer.c                 |   39 ++++++++
 kernel/workqueue.c             |  137 +++++++++++++++++++++--------
 12 files changed, 627 insertions(+), 104 deletions(-)

Index: linux-2.5.61-trojan/include/linux/brlock.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/include/linux/brlock.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 brlock.h
--- linux-2.5.61-trojan/include/linux/brlock.h	15 Feb 2003 12:31:59 -0000	1.1.1.1
+++ linux-2.5.61-trojan/include/linux/brlock.h	15 Feb 2003 15:50:17 -0000
@@ -34,6 +34,7 @@
 /* Register bigreader lock indices here. */
 enum brlock_indices {
 	BR_NETPROTO_LOCK,
+	BR_CPU_LOCK,
 	__BR_END
 };
 
Index: linux-2.5.61-trojan/include/linux/mmzone.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/include/linux/mmzone.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mmzone.h
--- linux-2.5.61-trojan/include/linux/mmzone.h	15 Feb 2003 12:31:58 -0000	1.1.1.1
+++ linux-2.5.61-trojan/include/linux/mmzone.h	15 Feb 2003 15:50:17 -0000
@@ -188,6 +188,7 @@
 	int node_id;
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
+	struct task_struct *kswapd;
 } pg_data_t;
 
 extern int numnodes;
Index: linux-2.5.61-trojan/include/linux/sched.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/include/linux/sched.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.h
--- linux-2.5.61-trojan/include/linux/sched.h	15 Feb 2003 12:31:59 -0000	1.1.1.1
+++ linux-2.5.61-trojan/include/linux/sched.h	15 Feb 2003 15:50:17 -0000
@@ -475,11 +475,14 @@
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
 
Index: linux-2.5.61-trojan/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/include/linux/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.61-trojan/include/linux/smp.h	15 Feb 2003 12:31:59 -0000	1.1.1.1
+++ linux-2.5.61-trojan/include/linux/smp.h	17 Feb 2003 06:47:05 -0000
@@ -72,13 +72,6 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-struct notifier_block;
-
-/* Need to know about CPUs going up/down? */
-extern int register_cpu_notifier(struct notifier_block *nb);
-extern void unregister_cpu_notifier(struct notifier_block *nb);
-
-int cpu_up(unsigned int cpu);
 
 /*
  * Mark the boot cpu "online" so that it can call console drivers in
@@ -105,17 +98,16 @@
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
-struct notifier_block;
+#endif /* !SMP */
+
 
 /* Need to know about CPUs going up/down? */
-static inline int register_cpu_notifier(struct notifier_block *nb)
-{
-	return 0;
-}
-static inline void unregister_cpu_notifier(struct notifier_block *nb)
-{
-}
-#endif /* !SMP */
+struct notifier_block;
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
+
+extern int cpu_up(unsigned int cpu);
+extern int cpu_down(unsigned int cpu);
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
 #define put_cpu()		preempt_enable()
Index: linux-2.5.61-trojan/include/asm-generic/topology.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/include/asm-generic/topology.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 topology.h
--- linux-2.5.61-trojan/include/asm-generic/topology.h	15 Feb 2003 12:31:55 -0000	1.1.1.1
+++ linux-2.5.61-trojan/include/asm-generic/topology.h	15 Feb 2003 15:59:58 -0000
@@ -38,8 +38,9 @@
 #ifndef parent_node
 #define parent_node(node)	(0)
 #endif
+/* by definition shouldn't this return the mask of online cpus on that node? -Zwane */
 #ifndef node_to_cpumask
-#define node_to_cpumask(node)	(cpu_online_map)
+#define node_to_cpumask(node)	(~0UL)
 #endif
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
Index: linux-2.5.61-trojan/kernel/Makefile
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- linux-2.5.61-trojan/kernel/Makefile	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/Makefile	17 Feb 2003 06:47:05 -0000
@@ -6,10 +6,9 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o
+	    rcupdate.o intermodule.o extable.o params.o cpu.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
Index: linux-2.5.61-trojan/kernel/cpu.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpu.c
--- linux-2.5.61-trojan/kernel/cpu.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/cpu.c	17 Feb 2003 07:00:25 -0000
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
 
+#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG)
 static struct notifier_block *cpu_chain = NULL;
 
 /* Need to know about CPUs going up/down? */
@@ -26,7 +31,137 @@
 	notifier_chain_unregister(&cpu_chain,nb);
 }
 
-int __devinit cpu_up(unsigned int cpu)
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
+
+int cpu_up(unsigned int cpu)
 {
 	int ret;
 	void *hcpu = (void *)(long)cpu;
@@ -64,3 +199,57 @@
 	up(&cpucontrol);
 	return ret;
 }
+#else /* !CONFIG_HOTPLUG || !CONFIG_SMP */
+int __devinit cpu_up(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+int cpu_down(unsigned int cpu)
+{
+       return -ENOSYS;
+}
+int register_cpu_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+void unregister_cpu_notifier(struct notifier_block *nb)
+{
+}
+#endif /* !CONFIG_HOTPLUG || !CONFIG_SMP */
+
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
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_SMP)
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
Index: linux-2.5.61-trojan/kernel/rcupdate.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/rcupdate.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rcupdate.c
--- linux-2.5.61-trojan/kernel/rcupdate.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/rcupdate.c	16 Feb 2003 19:35:20 -0000
@@ -50,6 +50,15 @@
 	  .maxbatch = 1, .rcu_cpu_mask = 0 };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
+/* slack queue used for offloading callbacks e.g. in the case of a cpu going offline */
+static struct rcu_global_queue_s {
+	spinlock_t lock;
+	struct list_head list;
+} rcu_global_queue = {
+	.lock = SPIN_LOCK_UNLOCKED,
+	.list = { &(rcu_global_queue.list), &(rcu_global_queue.list) }
+};
+
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
@@ -170,6 +179,17 @@
 	}
 
 	local_irq_disable();
+	
+	/* pick up any pending global callbacks. This is rarely used
+	 * so lock contention is fine. Each cpu picks one callback and it's
+	 * ok if we miss one since someone else can pick it up */
+	if (unlikely(!list_empty(&rcu_global_queue.list))) {
+		spin_lock(&rcu_global_queue.lock);
+		if (!list_empty(&rcu_global_queue.list))
+			list_move_tail(&rcu_global_queue.list, &RCU_nxtlist(cpu));
+		spin_unlock(&rcu_global_queue.lock);
+	}
+	
 	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
 		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
 		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
@@ -207,6 +227,49 @@
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
 }
 
+/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
+ * locking requirements, the list it's pulling from has to belong to a cpu
+ * which is dead and hence not processing interrupts.
+ */
+static void rcu_move_batch(struct list_head *list)
+{
+	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcu_global_queue.lock, flags);
+	while (!list_empty(list)) {
+		entry = list->next;
+		list_del(entry);
+		list_add_tail(entry, &rcu_global_queue.list);
+	}
+	spin_unlock_irqrestore(&rcu_global_queue.lock, flags);
+}
+
+static void rcu_offline_cpu(int cpu)
+{
+	/* if the cpu going offline owns the grace period
+	 * we can block indefinitely waiting for it, so flush
+	 * it here
+	 */
+	spin_lock_irq(&rcu_ctrlblk.mutex);
+	if (RCU_batch(cpu) == rcu_ctrlblk.curbatch) {
+		rcu_ctrlblk.curbatch++;
+		rcu_start_batch(rcu_ctrlblk.maxbatch);
+	}
+	spin_unlock_irq(&rcu_ctrlblk.mutex);
+
+	rcu_move_batch(&RCU_curlist(cpu));
+	rcu_move_batch(&RCU_nxtlist(cpu));
+	
+	BUG_ON(!list_empty(&RCU_curlist(cpu)));
+	BUG_ON(!list_empty(&RCU_nxtlist(cpu)));
+
+	tasklet_kill(&RCU_tasklet(cpu));
+        list_del_init(&RCU_curlist(cpu));
+        list_del_init(&RCU_nxtlist(cpu));
+       	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
+}
+
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -215,7 +278,9 @@
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
Index: linux-2.5.61-trojan/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/sched.c	17 Feb 2003 06:47:05 -0000
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
 			 * Fast-migrate the task if it's not running or runnable
 			 * currently. Do not violate hard affinity.
 			 */
-			if (unlikely(sync && !task_running(rq, p) &&
+			if (likely(cpu_online(smp_processor_id())) &&
+				unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
 				(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -939,6 +948,11 @@
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
@@ -1787,15 +1801,21 @@
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
 
@@ -1816,6 +1836,7 @@
 	set_cpus_allowed(p, new_mask);
 
 out_unlock:
+	up(&cpucontrol);
 	put_task_struct(p);
 	return retval;
 }
@@ -1846,7 +1867,7 @@
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	mask = p->cpus_allowed;
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -2200,11 +2221,8 @@
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
@@ -2235,6 +2253,102 @@
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
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_SMP)
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
@@ -2260,13 +2374,10 @@
 	rq = this_rq();
 	rq->migration_thread = current;
 
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
@@ -2279,37 +2390,37 @@
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
@@ -2325,6 +2436,9 @@
 		kernel_thread(migration_thread, hcpu, CLONE_KERNEL);
 		while (!cpu_rq((long)hcpu)->migration_thread)
 			yield();
+		break;
+	case CPU_OFFLINE:
+		stop_migration_thread((long)hcpu);
 		break;
 	}
 	return NOTIFY_OK;
Index: linux-2.5.61-trojan/kernel/softirq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/softirq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 softirq.c
--- linux-2.5.61-trojan/kernel/softirq.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/softirq.c	16 Feb 2003 07:17:50 -0000
@@ -296,10 +296,16 @@
 	register_cpu_notifier(&tasklet_nb);
 }
 
+/* This is the CPU to stop, and who to wake about it */
+static int ksoftirq_stop = -1;
+static struct task_struct *ksoftirq_killer = NULL;
+
 static int ksoftirqd(void * __bind_cpu)
 {
 	int cpu = (int) (long) __bind_cpu;
 
+	BUG_ON (ksoftirqd_task(cpu));
+
 	daemonize("ksoftirqd/%d", cpu);
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
@@ -314,7 +320,9 @@
 
 	ksoftirqd_task(cpu) = current;
 
-	for (;;) {
+	while (ksoftirq_stop != cpu) {
+		rmb();
+
 		if (!softirq_pending(cpu))
 			schedule();
 
@@ -327,24 +335,74 @@
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
+	set_current_state(TASK_RUNNING);
+
+	printk("ksoftirqd for cpu%i dying\n", cpu);
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
+		printk("firing up ksoftirqd for cpu%d\n", hotcpu);
 		if (kernel_thread(ksoftirqd, hcpu, CLONE_KERNEL) < 0) {
-			printk("ksoftirqd for %i failed\n", hotcpu);
-			return NOTIFY_BAD;
+			printk("ksoftirqd for cpu%i failed\n", hotcpu);
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
Index: linux-2.5.61-trojan/kernel/timer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/timer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 timer.c
--- linux-2.5.61-trojan/kernel/timer.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/timer.c	17 Feb 2003 07:12:41 -0000
@@ -172,11 +172,12 @@
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
-	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+	tvec_base_t *base;
   	unsigned long flags;
   
   	BUG_ON(timer_pending(timer) || !timer->function);
 
+	base = &per_cpu(tvec_bases, cpu);
 	check_timer(timer);
 
 	spin_lock_irqsave(&base->lock, flags);
@@ -1175,7 +1176,40 @@
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 }
+
+static void __devinit migrate_timers_from(int cpu)
+{
+	unsigned long flags;
+	tvec_base_t *base;
+	struct list_head *head, *curr;
+
+	BUG_ON(cpu_online(cpu));
+	base = &per_cpu(tvec_bases, cpu);
 	
+	/*
+	 * Cascade timers:
+	 */
+	spin_lock_irqsave(&base->lock, flags);
+	if (!base->tv1.index &&	(cascade(base, &base->tv2) == 1) &&
+		(cascade(base, &base->tv3) == 1) && cascade(base, &base->tv4) == 1)
+		cascade(base, &base->tv5);
+repeat:
+	head = base->tv1.vec + base->tv1.index;
+	curr = head->next;
+	if (curr != head) {
+		timer_t *timer;
+		timer = list_entry(curr, timer_t, entry);
+		/* bypass the optimisation in mod_timer */
+		printk(KERN_DEBUG "migrating timer %p from cpu%d to cpu%d\n",
+			timer, cpu, smp_processor_id());
+		spin_unlock_irqrestore(&base->lock, flags);
+		mod_timer(timer, timer->expires + 1);
+		spin_lock_irqsave(&base->lock, flags);
+		goto repeat;
+	}
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
 static int __devinit timer_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -1183,6 +1217,9 @@
 	switch(action) {
 	case CPU_UP_PREPARE:
 		init_timers_cpu(cpu);
+		break;
+	case CPU_DEAD:
+		migrate_timers_from(cpu);
 		break;
 	default:
 		break;
Index: linux-2.5.61-trojan/kernel/workqueue.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/workqueue.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 workqueue.c
--- linux-2.5.61-trojan/kernel/workqueue.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/workqueue.c	15 Feb 2003 16:47:17 -0000
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
@@ -172,7 +178,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	struct k_sigaction sa;
 
-	daemonize("%s/%d", startup->name, cpu);
+	daemonize("%s/%d", cwq->wq->name, cpu);
 	allow_signal(SIGCHLD);
 	current->flags |= PF_IOTHREAD;
 	cwq->thread = current;
@@ -257,44 +263,52 @@
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
@@ -302,32 +316,78 @@
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
@@ -364,8 +424,11 @@
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
