Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUAaOYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAaOYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:24:30 -0500
Received: from dp.samba.org ([66.70.73.150]:13244 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264602AbUAaOTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:19:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com, vatsa@in.ibm.com, mingo@redhat.com
Subject: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
Date: Sun, 01 Feb 2004 01:16:40 +1100
Message-Id: <20040131141937.E58852C082@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The actual CPU patch.  It's big, but almost all under
CONFIG_HOTPLUG_CPU, or macros which have same effect.

Particularly interested in Nick's views here: I tried to catch all the
places where the new scheduler might pull tasks onto an offline cpu.

Name: Hotplug CPU Patch: -mm Version
Author: Almost Everyone on the lhcs List
Status: Experimental
Depends: Hotcpu/use-kthread-simple.patch.gz
Depends: Hotcpu/drain_local_pages.patch.gz
Depends: Hotcpu/kstat-notifier-removal.patch.gz
Depends: Hotcpu/cpucontrol_macros.patch.gz
Depends: Module/module_kthread.patch.gz
Depends: Hotcpu/cpu_prepare.patch.gz
Depends: Hotcpu/zero-initializer-notifier-removal.patch.gz
Depends: Hotcpu/workqueue-cleanup.patch.gz
Depends: Hotcpu/kmod-affinity.patch.gz
Version: -mm

D: This is the arch-indep hotplug cpu code, contributed by Matt
D: Fleming, Zwane Mwaikambo, Dipankar Sarma, Joel Schopp,
D: Vatsa Vaddagiri and me.
D: 
D: Changes are designed to be NOOPs: usually by explicit use of
D: CONFIG_HOTPLUG_CPU
D: 
D: The way CPUs go down is:
D: 1) Userspace writes 0 to sysfs ("online" attrib).
D: 2) The cpucontrol mutex is grabbed.
D: 3) The task moves onto the cpu.
D: 4) cpu_online(cpu) is set to false.
D: 5) Tasks are migrated, cpus_allowed broken if required (not kernel threads)
D: 6) We move back off the cpu.
D: 7) CPU_OFFLINE notifier is called for the cpu (kernel threads clean up).
D: 8) Arch-specific __cpu_die() is called.
D: 9) CPU_DEAD notifier is called (caches drained, etc).
D: 10) hotplug script is run
D: 11) cpucontrol mutex released.
D: 
D: CPUs go up as before, except with CONFIG_HOTPLUG_CPU, they can go
D: up after boot.
D: 
D: Changes are:
D: - drivers/base/cpu.c: Add an "online" attribute.
D: 
D: - drivers/scsi/scsi.c: drain the scsi_done_q into current CPU on CPU_DEAD
D:
D: - fs/buffer.c: release buffer heads from bh_lrus on CPU_DEAD
D:
D: - linux/cpu.h: Add cpu_down().  Add hotcpu_notifier convenience macro.
D:   Add cpu_is_offline() for when you know a cpu was (once) online: this
D:   is a constant if !CONFIG_HOTPLUG_CPU.
D: 
D: - linux/interrupt.h: Add tasklet_kill_immediate for RCU tasklet takedown
D:   on dead CPU.
D: 
D: - linux/mmzip.h: keep pointer to kswapd, in case we need to move it.
D: 
D: - linux/sched.h: Add migrate_all_tasks() for cpu-down.  Add migrate_to_cpu
D:   for kernel threads to escape.  Add wake_idle_cpu() for i386 hotplug code.
D: 
D: - kernel/cpu.c: Take cpucontrol lock around notifiers: notifiers have
D:   no locking themselves.  Implement cpu_down() and code to call
D:   sbin_hotplug.
D: 
D: - kernel/kmod.c: As a bound kernel thread, take care of case where
D:   thread is going down, before keventd() CPU_OFFLINE notifier can
D:   return.
D: 
D: - kernel/kthread.c: Same as kmod.c, take care of race where CPU goes
D:   down and we didn't get migrated.
D: 
D: - kernel/rcupdate.c: Move rcu batch when cpu dies.
D: 
D: - kernel/sched.c: Add wake_idle_cpu() for i386 hotplug.
D:      
D:      Check everywhere to make sure we never move tasks onto an
D:      offline cpu: we'll just be fighting migrate_all_tasks().
D: 
D:      Change sched_migrate_task() to migrate_to_cpu and expose it
D:      for hotplug cpu.
D: 
D:      Take hotplug lock in sys_sched_setaffinity.
D:      
D:      Return cpus_allowed masked by cpu_possible_map, not
D:      cpu_online_map in sys_sched_getaffinity, otherwise tasks can't
D:      know about whether they can run on currently-offline cpus.
D: 
D:      Implement migrate_all_tasks() to push tasks off the dying cpu.
D:      
D:      Add callbacks to stop migration thread.
D: 
D: - kernel/softirq.c:
D:     Handle case where interrupt tries to kick softirqd after it has exited.
D:
D:     Implement tasklet_kill_immediate for RCU.
D:     
D:     Code to shut down ksoftirqd, and take over dead cpu's tasklets.
D: 
D: - kernel/timer.c:
D:     Code to migrate timers off dead CPU.
D: 
D: - kernel/workqueue.c:
D:     Keep all workqueue is list, with their name: when cpus come up
D:     we need to create new threads for each one.
D:
D:     Lock cpu hotplug in flush_workqueue for simplicity.
D: 
D:     create_workqueue_thread doesn't need name arg, now in struct.
D:
D:     Lock cpu hotplug when creating and destroying workqueues.
D: 
D:     cleanup_workqueue_thread needs to block irqs: can now be called
D:     on live workqueues.
D:
D:     Implement callbacks to add and delete threads, and take over work.
D: 
D: - mm/page_alloc.c:
D:    Drain local pages on CPU which is dead.
D:
D: - mm/slab.c:
D:    Move free_block decl, ac_entry and ac_data earlier in file.
D:    
D:    Stop reap timer on as cpu goes offline.
D:
D:    Neaten list_for_each into list_for_each_entry.
D:
D:    Free cache blocks and correct stats one CPU is dead.
D: 
D:    Make reap_timer_fnc terminate if cpu goes offline.
D: 
D: - mm/swap.c:
D:    Fix up committed stats and drain lru cache when cpu dead.
D: 
D: - mm/vmscan.c:
D:    Keep kswapd on cpus within node unless all CPUs go offline, and
D:    restore when they come back.
D:    
D:    Record kswapd tasks for each pgdat upon creation.
D: 
D: - net/core/dev.c:
D:    Drain skb queues to this cpu when another cpu is dead.
D: 
D: - net/core/flow.c:
D:    Call __flow_cache_shrink() to shrink cache to zero when CPU dead.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/drivers/base/cpu.c .22517-linux-2.6.2-rc2-mm2.updated/drivers/base/cpu.c
--- .22517-linux-2.6.2-rc2-mm2/drivers/base/cpu.c	2003-10-26 14:52:48.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/drivers/base/cpu.c	2004-02-01 01:08:03.000000000 +1100
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/topology.h>
+#include <linux/device.h>
 
 
 struct sysdev_class cpu_sysdev_class = {
@@ -14,6 +15,46 @@ struct sysdev_class cpu_sysdev_class = {
 };
 EXPORT_SYMBOL(cpu_sysdev_class);
 
+#ifdef CONFIG_HOTPLUG_CPU
+static ssize_t show_online(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+
+	return sprintf(buf, "%u\n", !!cpu_online(cpu->sysdev.id));
+}
+
+static ssize_t store_online(struct sys_device *dev, const char *buf,
+			    size_t count)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	ssize_t ret;
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
+	if (ret >= 0)
+		ret = count;
+	return ret;
+}
+static SYSDEV_ATTR(online, 0600, show_online, store_online);
+
+static void __init register_cpu_control(struct cpu *cpu)
+{
+	sysdev_create_file(&cpu->sysdev, &attr_online);
+}
+#else /* ... !CONFIG_HOTPLUG_CPU */
+static void __init register_cpu_control(struct cpu *cpu)
+{
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
 /*
  * register_cpu - Setup a driverfs device for a CPU.
@@ -34,6 +75,8 @@ int __init register_cpu(struct cpu *cpu,
 		error = sysfs_create_link(&root->sysdev.kobj,
 					  &cpu->sysdev.kobj,
 					  kobject_name(&cpu->sysdev.kobj));
+	if (!error)
+		register_cpu_control(cpu);
 	return error;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/drivers/scsi/scsi.c .22517-linux-2.6.2-rc2-mm2.updated/drivers/scsi/scsi.c
--- .22517-linux-2.6.2-rc2-mm2/drivers/scsi/scsi.c	2004-01-31 17:28:10.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/drivers/scsi/scsi.c	2004-02-01 01:08:03.000000000 +1100
@@ -53,6 +53,8 @@
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <scsi/scsi_host.h>
 #include "scsi.h"
@@ -1129,6 +1131,38 @@ int scsi_device_cancel(struct scsi_devic
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int scsi_cpu_notify(struct notifier_block *self, 
+			   unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long)hcpu;
+
+	switch(action) {
+	case CPU_DEAD:
+		/* Drain scsi_done_q. */
+		local_irq_disable();
+		list_splice_init(&per_cpu(scsi_done_q, cpu),
+				 &__get_cpu_var(scsi_done_q));
+		raise_softirq_irqoff(SCSI_SOFTIRQ);
+		local_irq_enable();
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata scsi_cpu_nb = {
+	.notifier_call	= scsi_cpu_notify,
+};
+
+#define register_scsi_cpu() register_cpu_notifier(&scsi_cpu_nb)
+#define unregister_scsi_cpu() unregister_cpu_notifier(&scsi_cpu_nb)
+#else
+#define register_scsi_cpu()
+#define unregister_scsi_cpu()
+#endif /* CONFIG_HOTPLUG_CPU */
+
 MODULE_DESCRIPTION("SCSI core");
 MODULE_LICENSE("GPL");
 
@@ -1163,6 +1197,7 @@ static int __init init_scsi(void)
 
 	devfs_mk_dir("scsi");
 	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
+	register_scsi_cpu();
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
 	return 0;
 
@@ -1190,6 +1225,7 @@ static void __exit exit_scsi(void)
 	devfs_remove("scsi");
 	scsi_exit_procfs();
 	scsi_exit_queue();
+	unregister_scsi_cpu();
 }
 
 subsys_initcall(init_scsi);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/fs/buffer.c .22517-linux-2.6.2-rc2-mm2.updated/fs/buffer.c
--- .22517-linux-2.6.2-rc2-mm2/fs/buffer.c	2004-01-31 17:28:12.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/fs/buffer.c	2004-02-01 01:08:03.000000000 +1100
@@ -2991,6 +2991,26 @@ init_buffer_head(void *data, kmem_cache_
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void buffer_exit_cpu(int cpu)
+{
+	int i;
+	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		brelse(b->bhs[i]);
+		b->bhs[i] = NULL;
+	}
+}
+
+static int buffer_cpu_notify(struct notifier_block *self, 
+			      unsigned long action, void *hcpu)
+{
+	if (action == CPU_DEAD)
+		buffer_exit_cpu((unsigned long)hcpu);
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init buffer_init(void)
 {
@@ -3008,6 +3028,7 @@ void __init buffer_init(void)
 	 */
 	nrpages = (nr_free_buffer_pages() * 10) / 100;
 	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
+	hotcpu_notifier(buffer_cpu_notify, 0);
 }
 
 EXPORT_SYMBOL(__bforget);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/include/linux/cpu.h .22517-linux-2.6.2-rc2-mm2.updated/include/linux/cpu.h
--- .22517-linux-2.6.2-rc2-mm2/include/linux/cpu.h	2004-01-31 17:28:19.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/include/linux/cpu.h	2004-02-01 01:08:03.000000000 +1100
@@ -21,6 +21,8 @@
 
 #include <linux/sysdev.h>
 #include <linux/node.h>
+#include <linux/compiler.h>
+#include <linux/cpumask.h>
 #include <asm/semaphore.h>
 
 struct cpu {
@@ -56,9 +58,19 @@ extern struct sysdev_class cpu_sysdev_cl
 extern struct semaphore cpucontrol;
 #define lock_cpu_hotplug()	down(&cpucontrol)
 #define unlock_cpu_hotplug()	up(&cpucontrol)
+int cpu_down(unsigned int cpu);
+#define hotcpu_notifier(fn, pri) {				\
+	static struct notifier_block fn##_nb = { fn, pri };	\
+	register_cpu_notifier(&fn##_nb);			\
+}
+#define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
+#define hotcpu_notifier(fn, pri)
+
+/* CPUs don't go offline once they're online w/o CONFIG_HOTPLUG_CPU */
+#define cpu_is_offline(cpu) 0
 #endif
 
 #endif /* _LINUX_CPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/include/linux/interrupt.h .22517-linux-2.6.2-rc2-mm2.updated/include/linux/interrupt.h
--- .22517-linux-2.6.2-rc2-mm2/include/linux/interrupt.h	2003-09-29 10:26:04.000000000 +1000
+++ .22517-linux-2.6.2-rc2-mm2.updated/include/linux/interrupt.h	2004-02-01 01:08:03.000000000 +1100
@@ -211,6 +211,7 @@ static inline void tasklet_hi_enable(str
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
+extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/include/linux/mmzone.h .22517-linux-2.6.2-rc2-mm2.updated/include/linux/mmzone.h
--- .22517-linux-2.6.2-rc2-mm2/include/linux/mmzone.h	2004-01-31 17:28:19.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/include/linux/mmzone.h	2004-02-01 01:08:03.000000000 +1100
@@ -213,6 +213,7 @@ typedef struct pglist_data {
 	int node_id;
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
+	struct task_struct *kswapd;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/include/linux/sched.h .22517-linux-2.6.2-rc2-mm2.updated/include/linux/sched.h
--- .22517-linux-2.6.2-rc2-mm2/include/linux/sched.h	2004-01-31 17:28:19.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/include/linux/sched.h	2004-02-01 01:08:03.000000000 +1100
@@ -634,6 +634,10 @@ extern void sched_balance_exec(void);
 #define sched_balance_exec()   {}
 #endif
 
+/* Move tasks off this (offline) CPU onto another. */
+extern void migrate_all_tasks(void);
+/* Try to move me here, if possible. */
+void migrate_to_cpu(int dest_cpu);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
@@ -1010,6 +1014,8 @@ static inline void set_task_cpu(struct t
 	p->thread_info->cpu = cpu;
 }
 
+/* Wake up a CPU from idle */
+void wake_idle_cpu(unsigned int cpu);
 #else
 
 static inline unsigned int task_cpu(struct task_struct *p)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/cpu.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/cpu.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/cpu.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/cpu.c	2004-02-01 01:08:03.000000000 +1100
@@ -1,14 +1,17 @@
 /* CPU control.
- * (C) 2001 Rusty Russell
+ * (C) 2001, 2002, 2003, 2004 Rusty Russell
+ *
  * This code is licenced under the GPL.
  */
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/kmod.h>		/* for hotplug_path */
 #include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
@@ -19,14 +22,150 @@ static struct notifier_block *cpu_chain;
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&cpu_chain, nb);
+	int ret;
+
+	if ((ret = down_interruptible(&cpucontrol)) != 0)
+		return ret;
+	ret = notifier_chain_register(&cpu_chain, nb);
+	up(&cpucontrol);
+	return ret;
 }
+EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	notifier_chain_unregister(&cpu_chain,nb);
+	down(&cpucontrol);
+	notifier_chain_unregister(&cpu_chain, nb);
+	up(&cpucontrol);
+}
+EXPORT_SYMBOL(unregister_cpu_notifier);
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline void check_for_tasks(int cpu)
+{
+	struct task_struct *p;
+
+	write_lock_irq(&tasklist_lock);
+	for_each_process(p) {
+		if (task_cpu(p) == cpu)
+			printk(KERN_WARNING "Task %s is on cpu %d, "
+				"not dying\n", p->comm, cpu);
+	}
+	write_unlock_irq(&tasklist_lock);
+}
+
+/* Notify userspace when a cpu event occurs, by running '/sbin/hotplug
+ * cpu' with certain environment variables set.  */
+static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
+{
+	char *argv[3], *envp[5], cpu_str[12], action_str[32];
+	int i;
+
+	sprintf(cpu_str, "CPU=%d", cpu);
+	sprintf(action_str, "ACTION=%s", action);
+	/* FIXME: Add DEVPATH. --RR */
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
+	return call_usermodehelper(argv[0], argv, envp, 0);
+}
+
+static inline int cpu_down_check(unsigned int cpu, cpumask_t mask)
+{
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	cpu_clear(cpu, mask);
+	if (any_online_cpu(mask) == NR_CPUS)
+		return -EBUSY;
+
+	return 0;
 }
 
+static inline int cpu_disable(int cpu)
+{
+	int ret;
+
+	ret = __cpu_disable();
+	if (ret < 0)
+		return ret;
+
+	/* Everyone looking at cpu_online() should be doing so with
+	 * preemption disabled. */
+	synchronize_kernel();
+	BUG_ON(cpu_online(cpu));
+	return 0;
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int err, rc;
+	void *vcpu = (void *)(long)cpu;
+	cpumask_t oldmask, mask;
+
+	if ((err = down_interruptible(&cpucontrol)) != 0) 
+		return err;
+
+	/* There has to be another cpu for this task. */
+	oldmask = current->cpus_allowed;
+	if ((err = cpu_down_check(cpu, oldmask)) != 0)
+		goto out;
+
+	/* Schedule ourselves on the dying CPU. */
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	if ((err = cpu_disable(cpu)) != 0)
+		goto out_allowed;
+
+	/* Move other tasks off to other CPUs (simple since they are
+           not running now). */
+	migrate_all_tasks();
+
+	/* Move off dying CPU, which will revert to idle process. */
+	cpus_clear(mask);
+	cpus_complement(mask);
+	cpu_clear(cpu, mask);
+	set_cpus_allowed(current, mask);
+
+	/* Tell kernel threads to go away: they can't fail here. */
+	rc = notifier_call_chain(&cpu_chain, CPU_OFFLINE, vcpu);
+	BUG_ON(rc == NOTIFY_BAD);
+
+	check_for_tasks(cpu);
+
+	/* This actually kills the CPU. */
+	__cpu_die(cpu);
+
+	/* CPU is completely dead: tell everyone.  Too late to complain. */
+	rc = notifier_call_chain(&cpu_chain, CPU_DEAD, vcpu);
+	BUG_ON(rc == NOTIFY_BAD);
+
+	cpu_run_sbin_hotplug(cpu, "offline");
+
+ out_allowed:
+	set_cpus_allowed(current, oldmask);
+ out:
+	up(&cpucontrol);
+	return err;
+}
+#else
+static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
+{
+	return 0;
+}
+#endif /*CONFIG_HOTPLUG_CPU*/
+
 int __devinit cpu_up(unsigned int cpu)
 {
 	int ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/kmod.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/kmod.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/kmod.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/kmod.c	2004-02-01 01:08:03.000000000 +1100
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -170,6 +171,12 @@ static int ____call_usermodehelper(void 
 
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
+	/* As a kernel thread which was bound to a specific cpu,
+	   migrate_all_tasks wouldn't touch us.  Avoid running child
+	   on dying CPU. */
+	if (cpu_is_offline(smp_processor_id()))
+		migrate_to_cpu(any_online_cpu(CPU_MASK_ALL));
+
 	retval = -EPERM;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/kthread.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/kthread.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/kthread.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/kthread.c	2004-02-01 01:08:03.000000000 +1100
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/unistd.h>
+#include <linux/cpu.h>
 #include <asm/semaphore.h>
 
 struct kthread_create_info
@@ -39,7 +40,7 @@ static int kthread(void *_create)
 	threadfn = create->threadfn;
 	data = create->data;
 
-	/* Block and flush all signals (in case we're not from keventd). */
+	/* Block and flush all signals. */
 	sigfillset(&blocked);
 	sigprocmask(SIG_BLOCK, &blocked, NULL);
 	flush_signals(current);
@@ -47,6 +48,12 @@ static int kthread(void *_create)
 	/* By default we can run anywhere, unlike keventd. */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* As a kernel thread which was bound to a specific cpu,
+	   migrate_all_tasks wouldn't touch us.  Avoid running on
+	   dying CPU. */
+	if (cpu_is_offline(smp_processor_id()))
+		migrate_to_cpu(any_online_cpu(CPU_MASK_ALL));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/rcupdate.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/rcupdate.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/rcupdate.c	2003-10-09 18:03:02.000000000 +1000
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/rcupdate.c	2004-02-01 01:08:03.000000000 +1100
@@ -154,6 +154,60 @@ out_unlock:
 }
 
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
+ * locking requirements, the list it's pulling from has to belong to a cpu
+ * which is dead and hence not processing interrupts.
+ */
+static void rcu_move_batch(struct list_head *list)
+{
+	struct list_head *entry;
+	int cpu = smp_processor_id();
+
+	local_irq_disable();
+	while (!list_empty(list)) {
+		entry = list->next;
+		list_del(entry);
+		list_add_tail(entry, &RCU_nxtlist(cpu));
+	}
+	local_irq_enable();
+}
+
+static void rcu_offline_cpu(int cpu)
+{
+	/* if the cpu going offline owns the grace period
+	 * we can block indefinitely waiting for it, so flush
+	 * it here
+	 */
+	spin_lock_irq(&rcu_ctrlblk.mutex);
+	if (!rcu_ctrlblk.rcu_cpu_mask)
+		goto unlock;
+
+	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
+	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
+		rcu_ctrlblk.curbatch++;
+		/* We may avoid calling start batch if
+		 * we are starting the batch only
+		 * because of the DEAD CPU (the current
+		 * CPU will start a new batch anyway for 
+		 * the callbacks we will move to current CPU).
+		 * However, we will avoid this optimisation
+		 * for now.
+		 */
+		rcu_start_batch(rcu_ctrlblk.maxbatch);
+	}
+unlock:
+	spin_unlock_irq(&rcu_ctrlblk.mutex);
+
+	rcu_move_batch(&RCU_curlist(cpu));
+	rcu_move_batch(&RCU_nxtlist(cpu));
+
+	tasklet_kill_immediate(&RCU_tasklet(cpu), cpu);
+}
+
+#endif
+
 /*
  * This does the RCU processing work from tasklet context. 
  */
@@ -214,7 +268,11 @@ static int __devinit rcu_cpu_notify(stru
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
 		break;
-	/* Space reserved for CPU_OFFLINE :) */
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		rcu_offline_cpu(cpu);
+		break;
+#endif
 	default:
 		break;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/sched.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/sched.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/sched.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/sched.c	2004-02-01 01:08:03.000000000 +1100
@@ -508,6 +508,12 @@ static inline void resched_task(task_t *
 #endif
 }
 
+/* Wake up a CPU from idle */
+void wake_idle_cpu(unsigned int cpu)
+{
+	resched_task(cpu_rq(cpu)->idle);
+}
+
 /**
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
@@ -723,7 +729,8 @@ static int try_to_wake_up(task_t * p, un
 		goto out_activate;
 
 	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)
-				|| task_running(rq, p)))
+		     || task_running(rq, p)
+		     || cpu_is_offline(this_cpu)))
 		goto out_activate;
 
 	/* Passive load balancing */
@@ -1112,25 +1119,21 @@ enum idle_type
 };
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_NUMA
-/*
- * If dest_cpu is allowed for this process, migrate the task to it.
- * This is accomplished by forcing the cpu_allowed mask to only
- * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
- * the cpu_allowed mask is restored.
- */
-static void sched_migrate_task(task_t *p, int dest_cpu)
+
+#if defined(CONFIG_NUMA) || defined(CONFIG_HOTPLUG_CPU)
+/* If dest_cpu is allowed for this process, migrate us to it. */
+void migrate_to_cpu(int dest_cpu)
 {
 	runqueue_t *rq;
 	migration_req_t req;
 	unsigned long flags;
 
-	rq = task_rq_lock(p, &flags);
-	if (!cpu_isset(dest_cpu, p->cpus_allowed))
+	rq = task_rq_lock(current, &flags);
+	if (!cpu_isset(dest_cpu, current->cpus_allowed))
 		goto out;
 
 	/* force the process onto the specified CPU */
-	if (migrate_task(p, dest_cpu, &req)) {
+	if (migrate_task(current, dest_cpu, &req)) {
 		/* Need to wait for migration thread. */
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
@@ -1140,7 +1143,9 @@ static void sched_migrate_task(task_t *p
 out:
 	task_rq_unlock(rq, &flags);
 }
+#endif /* CONFIG_NUMA || CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_NUMA
 /*
  * Find the least loaded CPU.  Slightly favor the current CPU by
  * setting its runqueue length as the minimum to start.
@@ -1185,7 +1190,7 @@ void sched_balance_exec(void)
 	if (domain->flags & SD_FLAG_EXEC) {
 		new_cpu = sched_best_cpu(current, domain);
 		if (new_cpu != this_cpu)
-			sched_migrate_task(current, new_cpu);
+			migrate_task_to_cpu(current, new_cpu);
 	}
 }
 #endif /* CONFIG_NUMA */
@@ -1597,6 +1602,10 @@ static inline void idle_balance(int this
 {
 	struct sched_domain *domain = this_sched_domain();
 
+	/* CPU going down is a special case: we don't pull more tasks here */
+	if (cpu_is_offline(this_cpu))
+		return;
+
 	do {
 		if (unlikely(!domain->groups))
 			/* hasn't been setup yet */
@@ -1701,6 +1710,10 @@ static void rebalance_tick(int this_cpu,
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *domain = this_sched_domain();
 
+	/* CPU going down is a special case: we don't pull more tasks here */
+	if (cpu_is_offline(this_cpu))
+		return;
+
 	/* Run through all this CPU's domains */
 	do {
 		unsigned long interval;
@@ -2623,11 +2636,13 @@ asmlinkage long sys_sched_setaffinity(pi
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
+	lock_cpu_hotplug();
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
+		unlock_cpu_hotplug();
 		return -ESRCH;
 	}
 
@@ -2648,6 +2663,7 @@ asmlinkage long sys_sched_setaffinity(pi
 
 out_unlock:
 	put_task_struct(p);
+	unlock_cpu_hotplug();
 	return retval;
 }
 
@@ -2677,7 +2693,7 @@ asmlinkage long sys_sched_getaffinity(pi
 		goto out_unlock;
 
 	retval = 0;
-	cpus_and(mask, p->cpus_allowed, cpu_online_map);
+	cpus_and(mask, p->cpus_allowed, cpu_possible_map);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -3058,6 +3074,9 @@ static void __migrate_task(struct task_s
 	/* Affinity changed (again). */
 	if (!cpu_isset(dest_cpu, p->cpus_allowed))
 		goto out;
+	/* CPU went down. */
+	if (cpu_is_offline(dest_cpu))
+		goto out;
 
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
@@ -3123,6 +3142,72 @@ static int migration_thread(void * data)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* migrate_all_tasks - function to migrate all the tasks from the
+ * current cpu caller must have already scheduled this to the target
+ * cpu via set_cpus_allowed  */
+void migrate_all_tasks(void)
+{
+	struct task_struct *tsk, *t;
+	int dest_cpu, src_cpu;
+	unsigned int node;
+
+	/* We're nailed to this CPU. */
+	src_cpu = smp_processor_id();
+
+	/* lock out everyone else intentionally */
+	write_lock_irq(&tasklist_lock);
+
+	/* watch out for per node tasks, let's stay on this node */
+	node = cpu_to_node(src_cpu);
+
+	do_each_thread(t, tsk) {
+		cpumask_t mask;
+		if (tsk == current)
+			continue;
+
+		if (task_cpu(tsk) != src_cpu)
+			continue;
+
+		/* Figure out where this task should go (attempting to
+		 * keep it on-node), and check if it can be migrated
+		 * as-is.  NOTE that kernel threads bound to more than
+		 * one online cpu will be migrated. */
+		mask = node_to_cpumask(node);
+		cpus_and(mask, mask, tsk->cpus_allowed);
+		dest_cpu = any_online_cpu(mask);
+		if (dest_cpu == NR_CPUS)
+			dest_cpu = any_online_cpu(tsk->cpus_allowed);
+		if (dest_cpu == NR_CPUS) {
+			/* Kernel threads which are bound to specific
+			 * processors need to look after themselves
+			 * with their own callbacks.  Exiting tasks
+			 * can have mm NULL too. */
+			if (tsk->mm == NULL && !(tsk->flags & PF_EXITING))
+				continue;
+
+			cpus_clear(tsk->cpus_allowed);
+			cpus_complement(tsk->cpus_allowed);
+			dest_cpu = any_online_cpu(tsk->cpus_allowed);
+
+			/* Don't tell them about moving exiting tasks,
+			   since they never leave kernel. */
+			if (!(tsk->flags & PF_EXITING)
+			    && printk_ratelimit())
+				printk(KERN_INFO "process %d (%s) no "
+				       "longer affine to cpu%d\n",
+				       tsk->pid, tsk->comm, src_cpu);
+		}
+
+		get_task_struct(tsk);
+		__migrate_task(tsk, dest_cpu);
+		put_task_struct(tsk);
+	} while_each_thread(t, tsk);
+
+	write_unlock_irq(&tasklist_lock);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * migration_call - callback that gets triggered when a CPU is added.
  * Here we can start up the necessary migration thread for the new CPU.
@@ -3145,14 +3230,26 @@ static int migration_call(struct notifie
 		/* Strictly unneccessary, as first user will wake it. */
 		wake_up_process(cpu_rq(cpu)->migration_thread);
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+		/* Unbind it from offline cpu so it can run.  Fall thru. */
+		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
+	case CPU_OFFLINE:
+		kthread_stop(cpu_rq(cpu)->migration_thread);
+		cpu_rq(cpu)->migration_thread = NULL;
+		break;
+
+	case CPU_DEAD:
+ 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
+ 		break;
+#endif
 	}
 	return NOTIFY_OK;
 }
 
-/*
- * We want this after the other threads, so they can use set_cpus_allowed
- * from their CPU_OFFLINE callback
- */
+/* Want this after the other threads, so they can use set_cpus_allowed
+ * from their CPU_OFFLINE callback, and also so everyone is off
+ * runqueue so we know it's empty. */
 static struct notifier_block __devinitdata migration_notifier = {
 	.notifier_call = migration_call,
 	.priority = -10,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/softirq.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/softirq.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/softirq.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/softirq.c	2004-02-01 01:08:03.000000000 +1100
@@ -104,7 +104,11 @@ restart:
 		local_irq_disable();
 
 		pending = local_softirq_pending();
-		if (pending && --max_restart)
+		/*
+		 * If ksoftirqd is dead transiently during cpu offlining
+		 * continue to process from interrupt context.
+		 */
+		if (pending && (--max_restart || !__get_cpu_var(ksoftirqd)))
 			goto restart;
 		if (pending)
 			wakeup_softirqd();
@@ -344,6 +348,58 @@ static int ksoftirqd(void * __bind_cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* 
+ * tasklet_kill_immediate is called to remove a tasklet which can already be
+ * scheduled for execution on @cpu.
+ *
+ * Unlike tasklet_kill, this function removes the tasklet
+ * _immediately_, even if the tasklet is in TASKLET_STATE_SCHED state.
+ *
+ * When this function is called, @cpu must be in the CPU_DEAD state.
+ */
+void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu)
+{
+	struct tasklet_struct **i;
+
+	BUG_ON(cpu_online(cpu));
+	BUG_ON(test_bit(TASKLET_STATE_RUN, &t->state));
+
+	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+		return;
+
+	/* CPU is dead, so no lock needed. */
+	for (i = &per_cpu(tasklet_vec, cpu).list; *i; i = &(*i)->next) {
+		if (*i == t) {
+			*i = t->next;
+			return;
+		}
+	}
+	BUG();
+}
+
+static void takeover_tasklets(unsigned int cpu)
+{
+	struct tasklet_struct **i;
+
+	/* CPU is dead, so no lock needed. */
+	local_irq_disable();
+
+	/* Find end, append list for that CPU. */
+	for (i = &__get_cpu_var(tasklet_vec).list; *i; i = &(*i)->next);
+	*i = per_cpu(tasklet_vec, cpu).list;
+	per_cpu(tasklet_vec, cpu).list = NULL;
+	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+
+	for (i = &__get_cpu_var(tasklet_hi_vec).list; *i; i = &(*i)->next);
+	*i = per_cpu(tasklet_hi_vec, cpu).list;
+	per_cpu(tasklet_hi_vec, cpu).list = NULL;
+	raise_softirq_irqoff(HI_SOFTIRQ);
+
+	local_irq_enable();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __devinit cpu_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
@@ -367,6 +423,21 @@ static int __devinit cpu_callback(struct
 	case CPU_ONLINE:
 		wake_up_process(per_cpu(ksoftirqd, hotcpu));
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+		/* Unbind so it can run.  Fall thru. */
+		kthread_bind(per_cpu(ksoftirqd, hotcpu), smp_processor_id());
+	case CPU_OFFLINE:
+		p = per_cpu(ksoftirqd, hotcpu);
+		per_cpu(ksoftirqd, hotcpu) = NULL;
+		/* Must set to NULL before interrupt tries to wake it */
+		barrier();
+		kthread_stop(p);
+		break;
+	case CPU_DEAD:
+		takeover_tasklets(hotcpu);
+		break;
+#endif /* CONFIG_HOTPLUG_CPU */
  	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/timer.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/timer.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/timer.c	2004-01-26 16:15:09.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/timer.c	2004-02-01 01:08:03.000000000 +1100
@@ -1223,7 +1223,74 @@ static void __devinit init_timers_cpu(in
 
 	base->timer_jiffies = jiffies;
 }
-	
+
+#ifdef CONFIG_HOTPLUG_CPU
+static int migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
+{
+	struct timer_list *timer;
+
+	while (!list_empty(head)) {
+		timer = list_entry(head->next, struct timer_list, entry);
+		/* We're locking backwards from __mod_timer order here,
+		   beware deadlock. */
+		if (!spin_trylock(&timer->lock))
+			return 0;
+		list_del(&timer->entry);
+		internal_add_timer(new_base, timer);
+		timer->base = new_base;
+		spin_unlock(&timer->lock);
+	}
+	return 1;
+}
+
+static void __devinit migrate_timers(int cpu)
+{
+	tvec_base_t *old_base;
+	tvec_base_t *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = &per_cpu(tvec_bases, cpu);
+	new_base = &get_cpu_var(tvec_bases);
+	printk("migrate_timers: offlined base %p\n", old_base);
+
+	local_irq_disable();
+again:
+	/* Prevent deadlocks via ordering by old_base < new_base. */
+	if (old_base < new_base) {
+		spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
+	} else {
+		spin_lock(&old_base->lock);
+		spin_lock(&new_base->lock);
+	}
+
+	if (old_base->running_timer)
+		BUG();
+	for (i = 0; i < TVR_SIZE; i++)
+		if (!migrate_timer_list(new_base, old_base->tv1.vec + i))
+			goto unlock_again;
+	for (i = 0; i < TVN_SIZE; i++)
+		if (!migrate_timer_list(new_base, old_base->tv2.vec + i)
+		    || !migrate_timer_list(new_base, old_base->tv3.vec + i)
+		    || !migrate_timer_list(new_base, old_base->tv4.vec + i)
+		    || !migrate_timer_list(new_base, old_base->tv5.vec + i))
+			goto unlock_again;
+	spin_unlock(&old_base->lock);
+	spin_unlock(&new_base->lock);
+	local_irq_enable();
+	put_cpu_var(tvec_bases);
+	return;
+
+unlock_again:
+	/* Avoid deadlock with __mod_timer, by backing off. */
+	spin_unlock(&old_base->lock);
+	spin_unlock(&new_base->lock);
+	cpu_relax();
+	goto again;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __devinit timer_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -1232,6 +1299,11 @@ static int __devinit timer_cpu_notify(st
 	case CPU_UP_PREPARE:
 		init_timers_cpu(cpu);
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_timers(cpu);
+		break;
+#endif
 	default:
 		break;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/kernel/workqueue.c .22517-linux-2.6.2-rc2-mm2.updated/kernel/workqueue.c
--- .22517-linux-2.6.2-rc2-mm2/kernel/workqueue.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/kernel/workqueue.c	2004-02-01 01:08:03.000000000 +1100
@@ -22,6 +22,8 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 #include <linux/kthread.h>
 
 /*
@@ -55,8 +57,22 @@ struct cpu_workqueue_struct {
  */
 struct workqueue_struct {
 	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
+	const char *name;
+	struct list_head list;
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* All the workqueues on the system, for hotplug cpu to add/remove
+   threads to each one as cpus come/go.  Protected by cpucontrol
+   sem. */
+static LIST_HEAD(workqueues);
+#define add_workqueue(wq) list_add(&(wq)->list, &workqueues)
+#define del_workqueue(wq) list_del(&(wq)->list)
+#else
+#define add_workqueue(wq)
+#define del_workqueue(wq)
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /* Preempt must be disabled. */
 static void __queue_work(struct cpu_workqueue_struct *cwq,
 			 struct work_struct *work)
@@ -210,6 +226,7 @@ void flush_workqueue(struct workqueue_st
 
 	might_sleep();
 
+	lock_cpu_hotplug();
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		DEFINE_WAIT(wait);
 		long sequence_needed;
@@ -231,11 +248,10 @@ void flush_workqueue(struct workqueue_st
 		finish_wait(&cwq->work_done, &wait);
 		spin_unlock_irq(&cwq->lock);
 	}
+	unlock_cpu_hotplug();
 }
 
-static int create_workqueue_thread(struct workqueue_struct *wq,
-				   const char *name,
-				   int cpu)
+static int create_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -249,7 +265,7 @@ static int create_workqueue_thread(struc
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
 
-	p = kthread_create(worker_thread, cwq, "%s/%d", name, cpu);
+	p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 	cwq->thread = p;
@@ -268,14 +284,19 @@ struct workqueue_struct *create_workqueu
 	if (!wq)
 		return NULL;
 
+	wq->name = name;
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (create_workqueue_thread(wq, name, cpu) < 0)
+		if (create_workqueue_thread(wq, cpu) < 0)
 			destroy = 1;
 		else
 			wake_up_process(wq->cpu_wq[cpu].thread);
 	}
+	add_workqueue(wq);
+
 	/*
 	 * Was there any error during startup? If yes then clean up:
 	 */
@@ -283,16 +304,23 @@ struct workqueue_struct *create_workqueu
 		destroy_workqueue(wq);
 		wq = NULL;
 	}
+	unlock_cpu_hotplug();
 	return wq;
 }
 
 static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
 	struct cpu_workqueue_struct *cwq;
+	unsigned long flags;
+	struct task_struct *p;
 
 	cwq = wq->cpu_wq + cpu;
-	if (cwq->thread)
-		kthread_stop(cwq->thread);
+	spin_lock_irqsave(&cwq->lock, flags);
+	p = cwq->thread;
+	cwq->thread = NULL;
+	spin_unlock_irqrestore(&cwq->lock, flags);
+	if (p)
+		kthread_stop(p);
 }
 
 void destroy_workqueue(struct workqueue_struct *wq)
@@ -301,10 +329,14 @@ void destroy_workqueue(struct workqueue_
 
 	flush_workqueue(wq);
 
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (cpu_online(cpu))
 			cleanup_workqueue_thread(wq, cpu);
 	}
+	list_del(&wq->list);
+	unlock_cpu_hotplug();
 	kfree(wq);
 }
 
@@ -345,8 +377,78 @@ int current_is_keventd(void)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* Take the work from this (downed) CPU. */
+static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
+{
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	LIST_HEAD(list);
+	struct work_struct *work;
+
+	spin_lock_irq(&cwq->lock);
+	printk("Workqueue %s: %i\n", wq->name, list_empty(&cwq->worklist));
+	list_splice_init(&cwq->worklist, &list);
+
+	while (!list_empty(&list)) {
+		printk("Taking work for %s\n", wq->name);
+		work = list_entry(list.next,struct work_struct,entry);
+		list_del(&work->entry);
+		__queue_work(wq->cpu_wq + smp_processor_id(), work);
+	}
+	spin_unlock_irq(&cwq->lock);
+}
+
+/* We're holding the cpucontrol mutex here */
+static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	unsigned int hotcpu = (unsigned long)hcpu;
+	struct workqueue_struct *wq;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		/* Create a new workqueue thread for it. */
+		list_for_each_entry(wq, &workqueues, list) {
+			if (create_workqueue_thread(wq, hotcpu) < 0) {
+				printk("workqueue for %i failed\n", hotcpu);
+				return NOTIFY_BAD;
+			}
+		}
+		break;
+
+	case CPU_ONLINE:
+		/* Kick off worker threads. */
+		list_for_each_entry(wq, &workqueues, list)
+			wake_up_process(wq->cpu_wq[hotcpu].thread);
+		break;
+
+	case CPU_UP_CANCELED:
+		list_for_each_entry(wq, &workqueues, list) {
+			/* Unbind so it can run. */
+			kthread_bind(wq->cpu_wq[hotcpu].thread,
+				     smp_processor_id());
+			cleanup_workqueue_thread(wq, hotcpu);
+		}
+		break;
+
+	case CPU_OFFLINE:
+		list_for_each_entry(wq, &workqueues, list)
+			take_over_work(wq, hotcpu);
+		list_for_each_entry(wq, &workqueues, list)
+			cleanup_workqueue_thread(wq, hotcpu);
+		break;
+	case CPU_DEAD:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+#endif
+
 void init_workqueues(void)
 {
+	hotcpu_notifier(workqueue_cpu_callback, 0);
 	keventd_wq = create_workqueue("events");
 	BUG_ON(!keventd_wq);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/mm/page_alloc.c .22517-linux-2.6.2-rc2-mm2.updated/mm/page_alloc.c
--- .22517-linux-2.6.2-rc2-mm2/mm/page_alloc.c	2004-02-01 01:08:00.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/mm/page_alloc.c	2004-02-01 01:08:03.000000000 +1100
@@ -1538,9 +1538,27 @@ struct seq_operations vmstat_op = {
 
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int page_alloc_cpu_notify(struct notifier_block *self, 
+				 unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long)hcpu;
+	long *count;
+
+	if (action == CPU_DEAD) {
+		/* Drain local pagecache count. */
+		count = &per_cpu(nr_pagecache_local, cpu);
+		atomic_add(*count, &nr_pagecache);
+		*count = 0;
+		drain_local_pages(cpu);
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init page_alloc_init(void)
 {
+	hotcpu_notifier(page_alloc_cpu_notify, 0);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/mm/slab.c .22517-linux-2.6.2-rc2-mm2.updated/mm/slab.c
--- .22517-linux-2.6.2-rc2-mm2/mm/slab.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/mm/slab.c	2004-02-01 01:08:03.000000000 +1100
@@ -521,9 +521,19 @@ enum {
 static DEFINE_PER_CPU(struct timer_list, reap_timers);
 
 static void reap_timer_fnc(unsigned long data);
-
+static void free_block (kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
 
+static inline void ** ac_entry(struct array_cache *ac)
+{
+	return (void**)(ac+1);
+}
+
+static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+{
+	return cachep->array[smp_processor_id()];
+}
+
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void cache_estimate (unsigned long gfporder, size_t size,
 		 int flags, size_t *left_over, unsigned int *num)
@@ -578,27 +588,33 @@ static void start_cpu_timer(int cpu)
 	}
 }
 
-/*
- * Note: if someone calls kmem_cache_alloc() on the new
- * cpu before the cpuup callback had a chance to allocate
- * the head arrays, it will oops.
- * Is CPU_ONLINE early enough?
- */
+#ifdef CONFIG_HOTPLUG_CPU
+static void stop_cpu_timer(int cpu)
+{
+	struct timer_list *rt = &per_cpu(reap_timers, cpu);
+
+	if (rt->function) {
+		del_timer_sync(rt);
+		WARN_ON(timer_pending(rt));
+		rt->function = NULL;
+	}	
+}
+#endif
+
 static int __devinit cpuup_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
 {
 	long cpu = (long)hcpu;
-	struct list_head *p;
+	kmem_cache_t* cachep;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
-		list_for_each(p, &cache_chain) {
+		list_for_each_entry(cachep, &cache_chain, next) {
 			int memsize;
 			struct array_cache *nc;
 
-			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
 			memsize = sizeof(void*)*cachep->limit+sizeof(struct array_cache);
 			nc = kmalloc(memsize, GFP_KERNEL);
 			if (!nc)
@@ -618,22 +634,32 @@ static int __devinit cpuup_callback(stru
 		up(&cache_chain_sem);
 		break;
 	case CPU_ONLINE:
-		if (g_cpucache_up == FULL)
-			start_cpu_timer(cpu);
+		start_cpu_timer(cpu);
 		break;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_OFFLINE:
+		stop_cpu_timer(cpu);
+		break;
+
 	case CPU_UP_CANCELED:
+	case CPU_DEAD:
 		down(&cache_chain_sem);
-
-		list_for_each(p, &cache_chain) {
+		list_for_each_entry(cachep, &cache_chain, next) {
 			struct array_cache *nc;
-			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
 
+			spin_lock_irq(&cachep->spinlock);
+			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
+			cachep->free_limit -= cachep->batchcount;
+			free_block(cachep, ac_entry(nc), nc->avail);
+			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
 		up(&cache_chain_sem);
 		break;
+#endif /* CONFIG_HOTPLUG_CPU */
 	}
 	return NOTIFY_OK;
 bad:
@@ -643,16 +669,6 @@ bad:
 
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
-static inline void ** ac_entry(struct array_cache *ac)
-{
-	return (void**)(ac+1);
-}
-
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
-{
-	return cachep->array[smp_processor_id()];
-}
-
 /* Initialisation.
  * Called after the gfp() functions have been enabled, and before smp_init().
  */
@@ -1378,7 +1394,6 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void free_block (kmem_cache_t* cachep, void** objpp, int len);
 static void drain_array_locked(kmem_cache_t* cachep,
 				struct array_cache *ac, int force);
 
@@ -1499,6 +1514,9 @@ int kmem_cache_destroy (kmem_cache_t * c
 		return 1;
 	}
 
+	/* no cpu_online check required here since we clear the percpu
+	 * array on cpu offline and set this to NULL.
+	 */
 	for (i = 0; i < NR_CPUS; i++)
 		kfree(cachep->array[i]);
 
@@ -2590,7 +2608,8 @@ static void reap_timer_fnc(unsigned long
 	struct timer_list *rt = &__get_cpu_var(reap_timers);
 
 	cache_reap();
-	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
+	if (!cpu_is_offline(cpu))
+		mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
 }
 
 #ifdef CONFIG_PROC_FS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/mm/swap.c .22517-linux-2.6.2-rc2-mm2.updated/mm/swap.c
--- .22517-linux-2.6.2-rc2-mm2/mm/swap.c	2004-01-10 13:59:39.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/mm/swap.c	2004-02-01 01:08:03.000000000 +1100
@@ -27,6 +27,9 @@
 #include <linux/module.h>
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
+#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -381,7 +384,43 @@ void vm_acct_memory(long pages)
 	preempt_enable();
 }
 EXPORT_SYMBOL(vm_acct_memory);
-#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void lru_drain_cache(unsigned int cpu)
+{
+	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+
+	/* CPU is dead, so no locking needed. */
+	if (pagevec_count(pvec)) {
+		printk("pagevec_count for %u is %u\n",
+		       cpu, pagevec_count(pvec));
+		__pagevec_lru_add(pvec);
+	}
+	pvec = &per_cpu(lru_add_active_pvecs, cpu);
+	if (pagevec_count(pvec)) {
+		printk("active pagevec_count for %u is %u\n",
+		       cpu, pagevec_count(pvec));
+		__pagevec_lru_add_active(pvec);
+	}
+}
+
+/* Drop the CPU's cached committed space back into the central pool. */
+static int cpu_swap_callback(struct notifier_block *nfb,
+			     unsigned long action,
+			     void *hcpu)
+{
+	long *committed;
+
+	committed = &per_cpu(committed_space, (long)hcpu);
+	if (action == CPU_DEAD) {
+		atomic_add(*committed, &vm_committed_space);
+		*committed = 0;
+		lru_drain_cache((long)hcpu);
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SMP
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
@@ -420,4 +459,5 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+	hotcpu_notifier(cpu_swap_callback, 0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/mm/vmscan.c .22517-linux-2.6.2-rc2-mm2.updated/mm/vmscan.c
--- .22517-linux-2.6.2-rc2-mm2/mm/vmscan.c	2004-01-31 17:28:20.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/mm/vmscan.c	2004-02-01 01:08:03.000000000 +1100
@@ -30,6 +30,8 @@
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
 #include <linux/topology.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -1105,13 +1107,54 @@ int shrink_all_memory(int nr_pages)
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* It's optimal to keep kswapds on the same CPUs as their memory, but
+   not required for correctness.  So if the last cpu in a node goes
+   away, let them run anywhere, and as the first one comes back,
+   restore their cpu bindings. */
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	pg_data_t *pgdat;
+	unsigned int hotcpu = (unsigned long)hcpu;
+	cpumask_t mask;
+
+	if (action == CPU_OFFLINE) {
+		/* Make sure that kswapd never becomes unschedulable. */
+		for_each_pgdat(pgdat) {
+			mask = node_to_cpumask(pgdat->node_id);
+			if (any_online_cpu(mask) == NR_CPUS) {
+				cpus_complement(mask);
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+
+	if (action == CPU_ONLINE) {
+		for_each_pgdat(pgdat) {
+			mask = node_to_cpumask(pgdat->node_id);
+			cpu_clear(hotcpu, mask);
+			if (any_online_cpu(mask) == NR_CPUS) {
+				cpu_set(hotcpu, mask);
+				/* One of our CPUs came back: restore mask */
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
 	swap_setup();
 	for_each_pgdat(pgdat)
-		kernel_thread(kswapd, pgdat, CLONE_KERNEL);
+		pgdat->kswapd
+		= find_task_by_pid(kernel_thread(kswapd, pgdat, CLONE_KERNEL));
 	total_memory = nr_free_pagecache_pages();
+	hotcpu_notifier(cpu_callback, 0);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/net/core/dev.c .22517-linux-2.6.2-rc2-mm2.updated/net/core/dev.c
--- .22517-linux-2.6.2-rc2-mm2/net/core/dev.c	2004-01-31 17:28:21.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/net/core/dev.c	2004-02-01 01:08:03.000000000 +1100
@@ -105,6 +105,7 @@
 #include <linux/kmod.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/cpu.h>
 #include <linux/netpoll.h>
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -3080,6 +3081,52 @@ int unregister_netdevice(struct net_devi
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int dev_cpu_callback(struct notifier_block *nfb,
+			    unsigned long action,
+			    void *ocpu)
+{
+	struct sk_buff **list_skb;
+	struct net_device **list_net;
+	struct sk_buff *skb;
+	unsigned int cpu, oldcpu = (unsigned long)ocpu;
+	struct softnet_data *sd, *oldsd;
+
+	if (action != CPU_DEAD)
+		return NOTIFY_OK;
+
+	local_irq_disable();
+	cpu = smp_processor_id();
+	sd = &per_cpu(softnet_data, cpu);
+	oldsd = &per_cpu(softnet_data, oldcpu);
+
+	/* Find end of our completion_queue. */
+	list_skb = &sd->completion_queue;
+	while (*list_skb)
+		list_skb = &(*list_skb)->next;
+	/* Append completion queue from offline CPU. */
+	*list_skb = oldsd->completion_queue;
+	oldsd->completion_queue = NULL;
+
+	/* Find end of our output_queue. */
+	list_net = &sd->output_queue;
+	while (*list_net)
+		list_net = &(*list_net)->next_sched;
+	/* Append output queue from offline CPU. */
+	*list_net = oldsd->output_queue;
+	oldsd->output_queue = NULL;
+
+	raise_softirq_irqoff(NET_TX_SOFTIRQ);
+	local_irq_enable();
+
+	/* Process offline CPU's input_pkt_queue */
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue)))
+		netif_rx(skb);
+
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3144,6 +3191,7 @@ static int __init net_dev_init(void)
 #ifdef CONFIG_NET_SCHED
 	pktsched_init();
 #endif
+	hotcpu_notifier(dev_cpu_callback, 0);
 	rc = 0;
 out:
 	return rc;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22517-linux-2.6.2-rc2-mm2/net/core/flow.c .22517-linux-2.6.2-rc2-mm2.updated/net/core/flow.c
--- .22517-linux-2.6.2-rc2-mm2/net/core/flow.c	2004-01-31 17:28:21.000000000 +1100
+++ .22517-linux-2.6.2-rc2-mm2.updated/net/core/flow.c	2004-02-01 01:08:03.000000000 +1100
@@ -326,6 +326,17 @@ static void __devinit flow_cache_cpu_pre
 	tasklet_init(tasklet, flow_cache_flush_tasklet, 0);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int flow_cache_cpu(struct notifier_block *nfb,
+			  unsigned long action,
+			  void *hcpu)
+{
+	if (action == CPU_DEAD)
+		__flow_cache_shrink((unsigned long)hcpu, 0);
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __init flow_cache_init(void)
 {
 	int i;
@@ -350,6 +361,7 @@ static int __init flow_cache_init(void)
 	for_each_cpu(i)
 		flow_cache_cpu_prepare(i);
 
+	hotcpu_notifier(flow_cache_cpu, 0);
 	return 0;
 }
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
