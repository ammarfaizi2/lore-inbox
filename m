Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUCJBKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 20:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUCJBKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 20:10:34 -0500
Received: from ozlabs.org ([203.10.76.45]:51430 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262542AbUCJBJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 20:09:20 -0500
Subject: [PATCH] Hotplug CPU Infrastructure
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078880897.2482.206.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 12:08:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A fairly big patch from the -mm tree (with a slightly different
scheduler part), but 99% is under CONFIG_HOTPLUG_CPU or similar
noops.

Sorry for the delay, I tested this with and without CONFIG_HOTPLUG_CPU
to make sure I didn't break your tree again.

Name: Hotplug CPUs for Linus with Atomic Takedown of CPUs
Status: Tested on 2.6.4-rc2-bk5
Depends: Hotcpu/bogolock.patch.gz
Depends: Hotcpu/drain_local_pages.patch.gz
Depends: Hotcpu/more-minor-cleanups.patch.gz
Depends: Hotcpu/minor-slab-cleanups.patch.gz
Depends: Hotcpu/bogolock-do_stop-race.patch.gz
Depends: Hotcpu/hotcpu-radix-tree.patch.gz

We take CPUs down atomically: freeze the machine, and then call
__cpu_disable(), which should arrange that this CPU no longer receives
interrupts (by interrupt controller reprogramming etc).  The machine
is released, the dead cpu returns to the idle thread, and it can be
given the coup de grace from another cpu in __cpu_die().

Any code which refers to num_online_cpus(), cpu_online(), or uses
cpu_online_map in any way should do so with preempt disabled, so that
CPUs don't go down.

Kernel threads may be rudely torn off CPUs they were bound to: they
should not rely on smp_processor_id() without checking this hasn't
happened (eg. disable preempt, check cpu still online, do work).

Thanks to Ingo Molnar for the atomicity idea, and everyone else on the
hotplug mailing list for testing, bugfixing and brainsweat.

Changes which are not obvious noops without CONFIG_HOTPLUG_CPU:
 - cpu.c: minor bugfix: grab the cpucontrol sem around notifier registration.

 - sched.c: hold irqs off across move_task_away call in migration thread,
	so CPUs don't go offline.  So move_task_away doesn't need
	local_irq_save.

 - sched.c: migration thread can't assume we're still on CPU: it might
	have gone straight back down.

 - sched.c: make sure migration thread has reached high prio before
	returning from CPU_ONLINE, otherwise stop_machine can't use it.

 - sched.c: no reason to do sched notifier last, remove priority.

 - softirq.c: don't assume cpu hasn't gone straight back down.  Hold
	preempt disabled over do_softirq so cpu doesn't go down, and
	check beforehand so we don't do_softirq() on wrong cpu.

 - softirq.c: remove double assignment

 - workqueue.c: remove BUG_ON() in case cpu goes back down, and hence
	unused cpu var.

 - workqueue.c: Add name and list to workqueue structure.

Changes in detail:
 - drivers/base/cpu.c: Add an "online" attribute.
 
 - drivers/scsi/scsi.c: drain the scsi_done_q into current CPU on CPU_DEAD

 - fs/buffer.c: release buffer heads from bh_lrus on CPU_DEAD

 - linux/cpu.h: Add cpu_down().  Add hotcpu_notifier convenience macro.
   Add cpu_is_offline() for when you know a cpu was (once) online: this
   is a constant if !CONFIG_HOTPLUG_CPU.

 - linux/interrupt.h: Add tasklet_kill_immediate for RCU tasklet takedown
   on dead CPU.
 
 - linux/mmzone.h: keep pointer to kswapd, in case we need to move it.

 - linux/notifier.h: remove CPU_OFFLINE: we just get CPU_DEAD now.
 
 - linux/sched.h: Add migrate_all_tasks() for cpu-down.  Add migrate_to_cpu
   for kernel threads to escape.
 
 - kernel/cpu.c: Take cpucontrol lock around notifiers: notifiers have
   no locking themselves.  Implement cpu_down() and code to call
   sbin_hotplug.
 
 - kernel/rcupdate.c: Comment on why online map use is OK, and move rcu
   batch when cpu dies.
 
 - kernel/sched.c:      
      Take hotplug lock in sys_sched_setaffinity.
      
      Return cpus_allowed masked by cpu_possible_map, not
      cpu_online_map in sys_sched_getaffinity, otherwise tasks can't
      know about whether they can run on currently-offline cpus.
 
      Migration thread can be taken off CPU when CPU goes down: remove
      two uses of smp_processor_id() to make that safe.

      Implement migrate_all_tasks() to push tasks off the dying cpu.
      
      Add callbacks to stop migration thread.

 - kernel/softirq.c:

     Handle case where ksoftirqd is kicked off dead CPU: disable
     preempt to prevent it, then check if cpu already offline.
     Simpler than recoding do_softirq() for this wierd case.

     Implement tasklet_kill_immediate for RCU.
     
     Code to shut down ksoftirqd, and take over dead cpu's tasklets.
 
     Remove double initialization in CPU_UP_PREPARE.

 - kernel/timer.c:
     Code to migrate timers off dead CPU.
 
 - kernel/workqueue.c:
     Keep all workqueue is list, with their name: when cpus come up
     we need to create new threads for each one.

     Lock cpu hotplug in flush_workqueue for simplicity.
 
     create_workqueue_thread doesn't need name arg, now in struct.

     Lock cpu hotplug when creating and destroying workqueues.
 
     cleanup_workqueue_thread needs to block irqs: can now be called
     on live workqueues.

     Implement callbacks to add and delete threads, and take over work.
 
 - mm/page_alloc.c:
    Drain local pages on CPU which is dead.

 - mm/slab.c:
    Free cache blocks and correct stats one CPU is dead.
 
 - mm/swap.c:
    Fix up committed stats and drain lru cache when cpu dead.
 
 - mm/vmscan.c:
    Keep kswapd on cpus within node unless all CPUs go offline, and
    restore when they come back.
    
    Record kswapd tasks for each pgdat upon creation.
 
 - net/core/dev.c:
    Drain skb queues to this cpu when another cpu is dead.
 
 - net/core/flow.c:
    Call __flow_cache_shrink() to shrink cache to zero when CPU dead.


diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/drivers/base/cpu.c working-2.6.4-rc2-bk5-softirq-stop_race/drivers/base/cpu.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/drivers/base/cpu.c	2004-03-05 14:22:41.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/drivers/base/cpu.c	2004-03-10 10:28:16.000000000 +1100
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
+static inline void register_cpu_control(struct cpu *cpu)
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/drivers/scsi/scsi.c working-2.6.4-rc2-bk5-softirq-stop_race/drivers/scsi/scsi.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/drivers/scsi/scsi.c	2004-03-05 14:22:57.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/drivers/scsi/scsi.c	2004-03-10 10:28:16.000000000 +1100
@@ -53,6 +53,8 @@
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <scsi/scsi_host.h>
 #include "scsi.h"
@@ -1130,6 +1132,38 @@ int scsi_device_cancel(struct scsi_devic
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
 
@@ -1164,6 +1198,7 @@ static int __init init_scsi(void)
 
 	devfs_mk_dir("scsi");
 	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
+	register_scsi_cpu();
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
 	return 0;
 
@@ -1191,6 +1226,7 @@ static void __exit exit_scsi(void)
 	devfs_remove("scsi");
 	scsi_exit_procfs();
 	scsi_exit_queue();
+	unregister_scsi_cpu();
 }
 
 subsys_initcall(init_scsi);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/fs/buffer.c working-2.6.4-rc2-bk5-softirq-stop_race/fs/buffer.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/fs/buffer.c	2004-03-10 09:04:28.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/fs/buffer.c	2004-03-10 10:28:16.000000000 +1100
@@ -3024,6 +3024,26 @@ init_buffer_head(void *data, kmem_cache_
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
@@ -3041,6 +3061,7 @@ void __init buffer_init(void)
 	 */
 	nrpages = (nr_free_buffer_pages() * 10) / 100;
 	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
+	hotcpu_notifier(buffer_cpu_notify, 0);
 }
 
 EXPORT_SYMBOL(__bforget);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/cpu.h working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/cpu.h
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/cpu.h	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/cpu.h	2004-03-10 10:28:16.000000000 +1100
@@ -63,6 +63,7 @@ extern struct semaphore cpucontrol;
 	static struct notifier_block fn##_nb = { fn, pri };	\
 	register_cpu_notifier(&fn##_nb);			\
 }
+int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/interrupt.h working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/interrupt.h
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/interrupt.h	2003-09-29 10:26:04.000000000 +1000
+++ working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/interrupt.h	2004-03-10 10:28:16.000000000 +1100
@@ -211,6 +211,7 @@ static inline void tasklet_hi_enable(str
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
+extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/mmzone.h working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/mmzone.h
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/mmzone.h	2004-03-05 14:23:08.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/mmzone.h	2004-03-10 10:28:16.000000000 +1100
@@ -213,6 +213,7 @@ typedef struct pglist_data {
 	int node_id;
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
+	struct task_struct *kswapd;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/notifier.h working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/notifier.h
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/notifier.h	2003-09-21 17:31:11.000000000 +1000
+++ working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/notifier.h	2004-03-10 10:28:16.000000000 +1100
@@ -63,7 +63,6 @@ extern int notifier_call_chain(struct no
 #define CPU_ONLINE	0x0002 /* CPU (unsigned)v is up */
 #define CPU_UP_PREPARE	0x0003 /* CPU (unsigned)v coming up */
 #define CPU_UP_CANCELED	0x0004 /* CPU (unsigned)v NOT coming up */
-#define CPU_OFFLINE	0x0005 /* CPU (unsigned)v offline (still scheduling) */
 #define CPU_DEAD	0x0006 /* CPU (unsigned)v dead */
 
 #endif /* __KERNEL__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/sched.h working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/sched.h
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/include/linux/sched.h	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/include/linux/sched.h	2004-03-10 10:28:16.000000000 +1100
@@ -547,6 +547,10 @@ extern void node_nr_running_init(void);
 #define node_nr_running_init() {}
 #endif
 
+/* Move tasks off this (offline) CPU onto another. */
+extern void migrate_all_tasks(void);
+/* Try to move me here, if possible. */
+void migrate_to_cpu(int dest_cpu);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/cpu.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/cpu.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/cpu.c	2004-02-18 23:54:35.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/cpu.c	2004-03-10 10:28:16.000000000 +1100
@@ -1,14 +1,19 @@
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
+#include <linux/kthread.h>
+#include <linux/stop_machine.h>
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
@@ -19,20 +24,149 @@ static struct notifier_block *cpu_chain;
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
+static inline void check_for_tasks(int cpu, struct task_struct *k)
+{
+	struct task_struct *p;
+
+	write_lock_irq(&tasklist_lock);
+	for_each_process(p) {
+		if (task_cpu(p) == cpu && p != k)
+			printk(KERN_WARNING "Task %s is on cpu %d\n",
+				p->comm, cpu);
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
+/* Take this CPU down. */
+static int take_cpu_down(void *unused)
+{
+	int err;
+
+	/* Take offline: makes arch_cpu_down somewhat easier. */
+	cpu_clear(smp_processor_id(), cpu_online_map);
+
+	/* Ensure this CPU doesn't handle any more interrupts. */
+	err = __cpu_disable();
+	if (err < 0)
+		cpu_set(smp_processor_id(), cpu_online_map);
+	else
+		/* Everyone else gets kicked off. */
+		migrate_all_tasks();
+
+	return err;
 }
 
+int cpu_down(unsigned int cpu)
+{
+	int err;
+	struct task_struct *p;
+
+	if ((err = lock_cpu_hotplug_interruptible()) != 0)
+		return err;
+
+	if (num_online_cpus() == 1) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (!cpu_online(cpu)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	p = __stop_machine_run(take_cpu_down, NULL, cpu);
+	if (IS_ERR(p)) {
+		err = PTR_ERR(p);
+		goto out;
+	}
+
+	if (cpu_online(cpu))
+		goto out_thread;
+
+	check_for_tasks(cpu, p);
+
+	/* Wait for it to sleep (leaving idle task). */
+	while (!idle_cpu(cpu))
+		yield();
+
+	/* This actually kills the CPU. */
+	__cpu_die(cpu);
+
+	/* Move it here so it can run. */
+	kthread_bind(p, smp_processor_id());
+
+	/* CPU is completely dead: tell everyone.  Too late to complain. */
+	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
+	    == NOTIFY_BAD)
+		BUG();
+
+	cpu_run_sbin_hotplug(cpu, "offline");
+
+out_thread:
+	err = kthread_stop(p);
+out:
+	unlock_cpu_hotplug();
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
 	void *hcpu = (void *)(long)cpu;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
+	if ((ret = lock_cpu_hotplug_interruptible()) != 0)
 		return ret;
 
 	if (cpu_online(cpu)) {
@@ -61,6 +195,6 @@ out_notify:
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
-	up(&cpucontrol);
+	unlock_cpu_hotplug();
 	return ret;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/rcupdate.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/rcupdate.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/rcupdate.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/rcupdate.c	2004-03-10 10:28:16.000000000 +1100
@@ -110,6 +110,7 @@ static void rcu_start_batch(long newbatc
 	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
 		return;
 	}
+	/* Can't change, since spin lock held. */
 	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
 }
 
@@ -154,6 +155,60 @@ out_unlock:
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
@@ -214,7 +269,11 @@ static int __devinit rcu_cpu_notify(stru
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/sched.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/sched.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/sched.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/sched.c	2004-03-10 10:31:14.000000000 +1100
@@ -672,8 +672,8 @@ repeat_lock_task:
 			if (unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
 					cpu_isset(smp_processor_id(),
-							p->cpus_allowed))) {
-
+							p->cpus_allowed) &&
+					!cpu_is_offline(smp_processor_id()))) {
 				set_task_cpu(p, smp_processor_id());
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
@@ -1018,6 +1018,7 @@ static void sched_migrate_task(task_t *p
 	unsigned long flags;
 	cpumask_t old_mask, new_mask = cpumask_of_cpu(dest_cpu);
 
+	lock_cpu_hotplug();
 	rq = task_rq_lock(p, &flags);
 	old_mask = p->cpus_allowed;
 	if (!cpu_isset(dest_cpu, old_mask) || !cpu_online(dest_cpu))
@@ -1041,6 +1042,7 @@ static void sched_migrate_task(task_t *p
 	}
 out:
 	task_rq_unlock(rq, &flags);
+	unlock_cpu_hotplug();
 }
 
 /*
@@ -1305,6 +1307,9 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
+	if (cpu_is_offline(this_cpu))
+		goto out;
+
 	busiest = find_busiest_queue(this_rq, this_cpu, idle,
 				     &imbalance, cpumask);
 	if (!busiest)
@@ -2312,11 +2317,13 @@ asmlinkage long sys_sched_setaffinity(pi
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
 
@@ -2337,6 +2344,7 @@ asmlinkage long sys_sched_setaffinity(pi
 
 out_unlock:
 	put_task_struct(p);
+	unlock_cpu_hotplug();
 	return retval;
 }
 
@@ -2731,11 +2739,9 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
 static void move_task_away(struct task_struct *p, int dest_cpu)
 {
 	runqueue_t *rq_dest;
-	unsigned long flags;
 
 	rq_dest = cpu_rq(dest_cpu);
 
-	local_irq_save(flags);
 	double_rq_lock(this_rq(), rq_dest);
 	if (task_cpu(p) != smp_processor_id())
 		goto out; /* Already moved */
@@ -2751,7 +2757,6 @@ static void move_task_away(struct task_s
 
 out:
 	double_rq_unlock(this_rq(), rq_dest);
-	local_irq_restore(flags);
 }
 
 /*
@@ -2767,10 +2772,9 @@ static int migration_thread(void * data)
 	int cpu = (long)data;
 	int ret;
 
-	BUG_ON(smp_processor_id() != cpu);
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
-	rq = this_rq();
+	rq = cpu_rq(cpu);
 	BUG_ON(rq->migration_thread != current);
 
 	while (!kthread_should_stop()) {
@@ -2790,15 +2794,73 @@ static int migration_thread(void * data)
 		}
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irq(&rq->lock);
+		spin_unlock(&rq->lock);
 
 		move_task_away(req->task,
 			       any_online_cpu(req->task->cpus_allowed));
+		local_irq_enable();
 		complete(&req->done);
 	}
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* migrate_all_tasks - function to migrate all the tasks from the
+ * current cpu caller must have already scheduled this to the target
+ * cpu via set_cpus_allowed.  Machine is stopped.  */
+void migrate_all_tasks(void)
+{
+	struct task_struct *tsk, *t;
+	int dest_cpu, src_cpu;
+	unsigned int node;
+
+	/* We're nailed to this CPU. */
+	src_cpu = smp_processor_id();
+
+	/* Not required, but here for neatness. */
+	write_lock(&tasklist_lock);
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
+			cpus_clear(tsk->cpus_allowed);
+			cpus_complement(tsk->cpus_allowed);
+			dest_cpu = any_online_cpu(tsk->cpus_allowed);
+
+			/* Don't tell them about moving exiting tasks
+			   or kernel threads (both mm NULL), since
+			   they never leave kernel. */
+			if (tsk->mm && printk_ratelimit())
+				printk(KERN_INFO "process %d (%s) no "
+				       "longer affine to cpu%d\n",
+				       tsk->pid, tsk->comm, src_cpu);
+		}
+
+		move_task_away(tsk, dest_cpu);
+	} while_each_thread(t, tsk);
+
+	write_unlock(&tasklist_lock);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * migration_call - callback that gets triggered when a CPU is added.
  * Here we can start up the necessary migration thread for the new CPU.
@@ -2820,18 +2882,26 @@ static int migration_call(struct notifie
 	case CPU_ONLINE:
 		/* Strictly unneccessary, as first user will wake it. */
 		wake_up_process(cpu_rq(cpu)->migration_thread);
+		/* Make sure it's hit high prio before we return. */
+		while (!rt_task(cpu_rq(cpu)->migration_thread))
+			yield();
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+		/* Unbind it from offline cpu so it can run.  Fall thru. */
+		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
+	case CPU_DEAD:
+		kthread_stop(cpu_rq(cpu)->migration_thread);
+		cpu_rq(cpu)->migration_thread = NULL;
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
 static struct notifier_block __devinitdata migration_notifier = {
 	.notifier_call = migration_call,
-	.priority = -10,
 };
 
 int __init migration_init(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/softirq.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/softirq.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/softirq.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/softirq.c	2004-03-10 10:28:16.000000000 +1100
@@ -308,13 +308,9 @@ void __init softirq_init(void)
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	int cpu = (int) (long) __bind_cpu;
-
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
 
-	BUG_ON(smp_processor_id() != cpu);
-
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -324,15 +320,85 @@ static int ksoftirqd(void * __bind_cpu)
 		__set_current_state(TASK_RUNNING);
 
 		while (local_softirq_pending()) {
+			/* Preempt disable stops cpu going offline.
+			   If already offline, we'll be on wrong CPU:
+			   don't process */
+			preempt_disable();
+			if (cpu_is_offline((long)__bind_cpu))
+				goto wait_to_die;
 			do_softirq();
+			preempt_enable();
 			cond_resched();
 		}
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
 	return 0;
+
+wait_to_die:
+	preempt_enable();
+	/* Wait for kthread_stop */
+	__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		__set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
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
 }
 
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
@@ -349,13 +415,23 @@ static int __devinit cpu_callback(struct
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
-		per_cpu(ksoftirqd, hotcpu) = p;
 		kthread_bind(p, hotcpu);
   		per_cpu(ksoftirqd, hotcpu) = p;
  		break;
 	case CPU_ONLINE:
 		wake_up_process(per_cpu(ksoftirqd, hotcpu));
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+		/* Unbind so it can run.  Fall thru. */
+		kthread_bind(per_cpu(ksoftirqd, hotcpu), smp_processor_id());
+	case CPU_DEAD:
+		p = per_cpu(ksoftirqd, hotcpu);
+		per_cpu(ksoftirqd, hotcpu) = NULL;
+		kthread_stop(p);
+		takeover_tasklets(hotcpu);
+		break;
+#endif /* CONFIG_HOTPLUG_CPU */
  	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/timer.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/timer.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/timer.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/timer.c	2004-03-10 10:28:16.000000000 +1100
@@ -1223,7 +1223,73 @@ static void __devinit init_timers_cpu(in
 
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
@@ -1232,6 +1298,11 @@ static int __devinit timer_cpu_notify(st
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/workqueue.c working-2.6.4-rc2-bk5-softirq-stop_race/kernel/workqueue.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/kernel/workqueue.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/kernel/workqueue.c	2004-03-10 10:28:16.000000000 +1100
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
@@ -152,7 +168,6 @@ static inline void run_workqueue(struct 
 static int worker_thread(void *__cwq)
 {
 	struct cpu_workqueue_struct *cwq = __cwq;
-	int cpu = cwq - cwq->wq->cpu_wq;
 	DECLARE_WAITQUEUE(wait, current);
 	struct k_sigaction sa;
 	sigset_t blocked;
@@ -160,7 +175,6 @@ static int worker_thread(void *__cwq)
 	current->flags |= PF_IOTHREAD;
 
 	set_user_nice(current, -10);
-	BUG_ON(smp_processor_id() != cpu);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);
@@ -210,6 +224,7 @@ void fastcall flush_workqueue(struct wor
 
 	might_sleep();
 
+	lock_cpu_hotplug();
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		DEFINE_WAIT(wait);
 		long sequence_needed;
@@ -231,11 +246,10 @@ void fastcall flush_workqueue(struct wor
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
@@ -249,7 +263,7 @@ static int create_workqueue_thread(struc
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
 
-	p = kthread_create(worker_thread, cwq, "%s/%d", name, cpu);
+	p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 	cwq->thread = p;
@@ -268,14 +282,19 @@ struct workqueue_struct *create_workqueu
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
@@ -283,16 +302,23 @@ struct workqueue_struct *create_workqueu
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
@@ -301,10 +327,14 @@ void destroy_workqueue(struct workqueue_
 
 	flush_workqueue(wq);
 
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (cpu_online(cpu))
 			cleanup_workqueue_thread(wq, cpu);
 	}
+	del_workqueue(wq);
+	unlock_cpu_hotplug();
 	kfree(wq);
 }
 
@@ -345,8 +375,75 @@ int current_is_keventd(void)
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
+	case CPU_DEAD:
+		list_for_each_entry(wq, &workqueues, list)
+			cleanup_workqueue_thread(wq, hotcpu);
+		list_for_each_entry(wq, &workqueues, list)
+			take_over_work(wq, hotcpu);
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/lib/radix-tree.c working-2.6.4-rc2-bk5-softirq-stop_race/lib/radix-tree.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/lib/radix-tree.c	2003-09-22 10:07:20.000000000 +1000
+++ working-2.6.4-rc2-bk5-softirq-stop_race/lib/radix-tree.c	2004-03-10 10:28:13.000000000 +1100
@@ -24,6 +24,8 @@
 #include <linux/radix-tree.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <linux/gfp.h>
 #include <linux/string.h>
 
@@ -420,6 +422,28 @@ static __init void radix_tree_init_maxin
 		height_to_maxindex[i] = __maxindex(i);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int radix_tree_callback(struct notifier_block *nfb,
+                            unsigned long action,
+                            void *hcpu)
+{
+       int cpu = (long)hcpu;
+       struct radix_tree_preload *rtp;
+
+       /* Free per-cpu pool of perloaded nodes */
+       if (action == CPU_DEAD) {
+               rtp = &per_cpu(radix_tree_preloads, cpu);
+               while (rtp->nr) {
+                       kmem_cache_free(radix_tree_node_cachep,
+                                       rtp->nodes[rtp->nr-1]);
+                       rtp->nodes[rtp->nr-1] = NULL;
+                       rtp->nr--;
+               }
+       }
+       return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 void __init radix_tree_init(void)
 {
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
@@ -428,4 +452,5 @@ void __init radix_tree_init(void)
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
 	radix_tree_init_maxindex();
+	hotcpu_notifier(radix_tree_callback, 0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/page_alloc.c working-2.6.4-rc2-bk5-softirq-stop_race/mm/page_alloc.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/page_alloc.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/mm/page_alloc.c	2004-03-10 10:28:16.000000000 +1100
@@ -1550,9 +1550,29 @@ struct seq_operations vmstat_op = {
 
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
+		local_irq_disable();
+		__drain_pages(cpu);
+		local_irq_enable();
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init page_alloc_init(void)
 {
+	hotcpu_notifier(page_alloc_cpu_notify, 0);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/slab.c working-2.6.4-rc2-bk5-softirq-stop_race/mm/slab.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/slab.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/mm/slab.c	2004-03-10 10:28:16.000000000 +1100
@@ -589,12 +589,19 @@ static void start_cpu_timer(int cpu)
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
@@ -630,18 +637,28 @@ static int __devinit cpuup_callback(stru
 	case CPU_ONLINE:
 		start_cpu_timer(cpu);
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		stop_cpu_timer(cpu);
+		/* fall thru */
 	case CPU_UP_CANCELED:
 		down(&cache_chain_sem);
 
 		list_for_each_entry(cachep, &cache_chain, next) {
 			struct array_cache *nc;
 
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
+#endif
 	}
 	return NOTIFY_OK;
 bad:
@@ -1486,6 +1503,9 @@ int kmem_cache_destroy (kmem_cache_t * c
 		return 1;
 	}
 
+	/* no cpu_online check required here since we clear the percpu
+	 * array on cpu offline and set this to NULL.
+	 */
 	for (i = 0; i < NR_CPUS; i++)
 		kfree(cachep->array[i]);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/swap.c working-2.6.4-rc2-bk5-softirq-stop_race/mm/swap.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/swap.c	2004-03-10 09:04:30.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/mm/swap.c	2004-03-10 10:28:16.000000000 +1100
@@ -27,6 +27,9 @@
 #include <linux/module.h>
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
+#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -381,7 +384,37 @@ void vm_acct_memory(long pages)
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
+	if (pagevec_count(pvec))
+		__pagevec_lru_add(pvec);
+	pvec = &per_cpu(lru_add_active_pvecs, cpu);
+	if (pagevec_count(pvec))
+		__pagevec_lru_add_active(pvec);
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
@@ -420,4 +453,5 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+	hotcpu_notifier(cpu_swap_callback, 0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/vmscan.c working-2.6.4-rc2-bk5-softirq-stop_race/mm/vmscan.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/mm/vmscan.c	2004-02-18 23:54:36.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/mm/vmscan.c	2004-03-10 10:28:16.000000000 +1100
@@ -30,6 +30,8 @@
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
 #include <linux/topology.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -1085,13 +1087,39 @@ int shrink_all_memory(int nr_pages)
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* It's optimal to keep kswapds on the same CPUs as their memory, but
+   not required for correctness.  So if the last cpu in a node goes
+   away, we get changed to run anywhere: as the first one comes back,
+   restore their cpu bindings. */
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	pg_data_t *pgdat;
+	cpumask_t mask;
+
+	if (action == CPU_ONLINE) {
+		for_each_pgdat(pgdat) {
+			mask = node_to_cpumask(pgdat->node_id);
+			if (any_online_cpu(mask) != NR_CPUS)
+				/* One of our CPUs online: restore mask */
+				set_cpus_allowed(pgdat->kswapd, mask);
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/net/core/dev.c working-2.6.4-rc2-bk5-softirq-stop_race/net/core/dev.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/net/core/dev.c	2004-03-05 14:23:11.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/net/core/dev.c	2004-03-10 10:28:16.000000000 +1100
@@ -76,6 +76,7 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <linux/config.h>
+#include <linux/cpu.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -3116,6 +3117,52 @@ int unregister_netdevice(struct net_devi
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
@@ -3180,6 +3227,7 @@ static int __init net_dev_init(void)
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action, NULL);
 
+	hotcpu_notifier(dev_cpu_callback, 0);
 	dst_init();
 	dev_mcast_init();
 	rc = 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.4-rc2-bk5-bogolock-do_stop-race/net/core/flow.c working-2.6.4-rc2-bk5-softirq-stop_race/net/core/flow.c
--- working-2.6.4-rc2-bk5-bogolock-do_stop-race/net/core/flow.c	2004-02-18 23:54:36.000000000 +1100
+++ working-2.6.4-rc2-bk5-softirq-stop_race/net/core/flow.c	2004-03-10 10:28:16.000000000 +1100
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
Anyone who quotes me in their signature is an idiot -- Rusty Russell

