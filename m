Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319488AbSIMB4j>; Thu, 12 Sep 2002 21:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319484AbSIMB4j>; Thu, 12 Sep 2002 21:56:39 -0400
Received: from dp.samba.org ([66.70.73.150]:18640 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319488AbSIMBxh>;
	Thu, 12 Sep 2002 21:53:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>, mingo@redhat.com,
       Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>, torvalds@transmeta.com
Subject: [PATCH] Hot unplug CPU 4/4
Date: Fri, 13 Sep 2002 11:56:08 +1000
Message-Id: <20020913015827.66A5D2C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Patrick, I put the cpus as root/sys/cpus/0000/xxx, is that OK? ]

[ Ingo, scheduler changes in two places (online checks before pulling
  tasks), plus the extraction of common code from migration thread ]

[ Kimio, I added the CPU_DEAD notifier ]

Name: Hotplug CPU Remove Generic Code
Author: Rusty Russell
Status: Experimental
Depends: Hotcpu/set-cpus-can-fail.patch.gz
Depends: Misc/daemonize-reparent.patch.2.5.33.gz

D: This adds the generic infrastructure to allow removing of CPUs
D: in a running kernel.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/arch/i386/kernel/smpboot.c .7234-linux-2.5.34.updated/arch/i386/kernel/smpboot.c
--- .7234-linux-2.5.34/arch/i386/kernel/smpboot.c	2002-09-13 11:46:29.000000000 +1000
+++ .7234-linux-2.5.34.updated/arch/i386/kernel/smpboot.c	2002-09-13 11:47:04.000000000 +1000
@@ -1220,6 +1220,17 @@ int __devinit __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+int __cpu_disable(void)
+{
+	return -ENOSYS;
+}
+
+/* Since we fail __cpu_disable, this is never called. */
+void __cpu_die(unsigned int cpu)
+{
+	BUG();
+}
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/arch/ppc/kernel/smp.c .7234-linux-2.5.34.updated/arch/ppc/kernel/smp.c
--- .7234-linux-2.5.34/arch/ppc/kernel/smp.c	2002-09-13 11:46:29.000000000 +1000
+++ .7234-linux-2.5.34.updated/arch/ppc/kernel/smp.c	2002-09-13 11:47:04.000000000 +1000
@@ -438,6 +438,17 @@ int __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+int __cpu_disable(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+
+/* Since we fail __cpu_disable, this is never called. */
+void __cpu_die(unsigned int cpu)
+{
+	BUG();
+}
+
 void smp_cpus_done(unsigned int max_cpus)
 {
 	smp_ops->setup_cpu(0);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/include/asm-i386/smp.h .7234-linux-2.5.34.updated/include/asm-i386/smp.h
--- .7234-linux-2.5.34/include/asm-i386/smp.h	2002-09-13 11:46:28.000000000 +1000
+++ .7234-linux-2.5.34.updated/include/asm-i386/smp.h	2002-09-13 11:47:04.000000000 +1000
@@ -123,6 +123,9 @@ static inline int num_booting_cpus(void)
 	return hweight32(cpu_callout_map);
 }
 
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/include/asm-ppc/smp.h .7234-linux-2.5.34.updated/include/asm-ppc/smp.h
--- .7234-linux-2.5.34/include/asm-ppc/smp.h	2002-09-13 11:46:28.000000000 +1000
+++ .7234-linux-2.5.34.updated/include/asm-ppc/smp.h	2002-09-13 11:47:04.000000000 +1000
@@ -68,6 +68,8 @@ static inline int any_online_cpu(const u
 }
 
 extern int __cpu_up(unsigned int cpu);
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 
 extern int smp_hw_index[];
 #define hard_smp_processor_id() (smp_hw_index[smp_processor_id()])
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/include/linux/notifier.h .7234-linux-2.5.34.updated/include/linux/notifier.h
--- .7234-linux-2.5.34/include/linux/notifier.h	2002-07-27 15:24:39.000000000 +1000
+++ .7234-linux-2.5.34.updated/include/linux/notifier.h	2002-09-13 11:47:04.000000000 +1000
@@ -60,7 +60,9 @@ extern int notifier_call_chain(struct no
 
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
+#define CPU_OFFLINE	0x0001 /* CPU (unsigned)v going down */
 #define CPU_ONLINE	0x0002 /* CPU (unsigned)v coming up */
+#define CPU_DEAD	0x0003 /* CPU (unsigned)v dead */
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/include/linux/sched.h .7234-linux-2.5.34.updated/include/linux/sched.h
--- .7234-linux-2.5.34/include/linux/sched.h	2002-09-13 11:46:29.000000000 +1000
+++ .7234-linux-2.5.34.updated/include/linux/sched.h	2002-09-13 11:47:04.000000000 +1000
@@ -431,6 +431,9 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #if CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, const unsigned long new_mask[]);
+#ifdef CONFIG_HOTPLUG
+extern void migrate_all_tasks(void);
+#endif
 #else
 static inline int set_cpus_allowed(struct task_struct *p,
 				   const unsigned long *new_mask)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/include/linux/smp.h .7234-linux-2.5.34.updated/include/linux/smp.h
--- .7234-linux-2.5.34/include/linux/smp.h	2002-09-13 11:46:28.000000000 +1000
+++ .7234-linux-2.5.34.updated/include/linux/smp.h	2002-09-13 11:47:04.000000000 +1000
@@ -78,6 +78,7 @@ extern int register_cpu_notifier(struct 
 extern void unregister_cpu_notifier(struct notifier_block *nb);
 
 int cpu_up(unsigned int cpu);
+int cpu_down(unsigned int cpu);
 #else /* !SMP */
 
 /*
@@ -106,6 +107,10 @@ static inline int register_cpu_notifier(
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+
+/* Bring a CPU down/up */
+static inline int cpu_down(unsigned int cpu) { return -EBUSY; }
+static inline int cpu_up(unsigned int cpu) { return -ENOSYS; }
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/kernel/cpu.c .7234-linux-2.5.34.updated/kernel/cpu.c
--- .7234-linux-2.5.34/kernel/cpu.c	2002-08-28 09:29:53.000000000 +1000
+++ .7234-linux-2.5.34.updated/kernel/cpu.c	2002-09-13 11:47:04.000000000 +1000
@@ -8,13 +8,220 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/kmod.h>		/* for hotplug_path */
+#include <linux/brlock.h>
+#include <linux/device.h>
 #include <asm/semaphore.h>
+#include <asm/uaccess.h>
 
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain = NULL;
 
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
+	DECLARE_BITMAP(mask, NR_CPUS) = CPU_MASK_ALL;
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
+	migrate_to_cpu(cpu);
+
+	preempt_disable();
+
+	/* Disable CPU. */
+	ret = __cpu_disable();
+	if (ret != 0) {
+		printk("CPU disable failed: %i\n", ret);
+		goto preempt_out;
+	}
+	BUG_ON(cpu_online(cpu));
+
+	/* Move other tasks off to other CPUs (simple since they are
+           not running now). */
+	migrate_all_tasks();
+
+	/* Move off dying CPU, which will revert to idle process. */
+	__clear_bit(cpu, mask);
+	set_cpus_allowed(current, mask);
+	preempt_enable();
+
+	/* CPU has been disabled: tell everyone */
+	notifier_call_chain(&cpu_chain, CPU_OFFLINE, (void *)(long)cpu);
+
+	/* Die, CPU, die!. */
+	__cpu_die(cpu);
+
+	/* CPU has is completely dead: tell everyone */
+	notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu);
+
+	printk("Running CPU hotplug remove for cpu %u\n", cpu);
+	cpu_run_sbin_hotplug(cpu, "remove");
+	printk("Done sbin hotplug\n"); 
+	up(&cpucontrol);
+	printk("Done with cpucontrol\n"); 
+	{
+		struct task_struct *p;
+
+		write_lock_irq(&tasklist_lock);
+		for_each_task(p) {
+			if (p->thread_info->cpu == cpu)
+				printk("Left %p: %s\n", p, p->comm);
+		}
+		write_unlock_irq(&tasklist_lock);
+	}
+	return ret;
+
+ preempt_out:
+	preempt_enable();
+ out:
+	up(&cpucontrol);
+	return ret;
+}
+
+struct cpu_device
+{
+	struct device dev;
+	unsigned int cpu;
+};
+
+static ssize_t show_online(struct device *dev,
+			   char *buf,
+			   size_t count,
+			   loff_t off)
+{
+	char out[3];
+	struct cpu_device *cpudev = container_of(dev, struct cpu_device, dev);
+
+	sprintf(out, "%i\n", !!cpu_online(cpudev->cpu));
+	if (off >= strlen(out)) return 0;
+	if (off + count > strlen(out)) count = strlen(out) - off;
+	memcpy(buf, out+off, count);
+	return (ssize_t)count;
+}
+
+static ssize_t store_online(struct device *dev,
+			    const char *buf,
+			    size_t count,
+			    loff_t off)
+{
+	struct cpu_device *cpudev = container_of(dev, struct cpu_device, dev);
+	ssize_t ret;
+
+	if (off != 0)
+		return -EINVAL;
+	switch (buf[0]) {
+	case '0':
+		ret = cpu_down(cpudev->cpu);
+		break;
+	case '1':
+		ret = cpu_up(cpudev->cpu);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret == 0)
+		ret = count;
+	return ret;
+}
+
+static void __init create_entries(struct device *parent)
+{
+	struct device_attribute *online;
+
+	online = kmalloc(sizeof(*online), GFP_KERNEL);
+	online->attr.name = "online";
+	online->attr.mode = 0600;
+	online->show = show_online;
+	online->store = store_online;
+	device_create_file(parent, online);
+}
+
+struct device cpu_dev = {
+	.name = "cpus",
+	.bus_id = "cpus"
+};
+
+static int __init create_per_cpu_entries(void)
+{
+	unsigned int i;
+
+	register_sys_device(&cpu_dev);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			struct cpu_device *cpudir;
+			cpudir = kmalloc(sizeof(*cpudir), GFP_KERNEL);
+			memset(cpudir, 0, sizeof(*cpudir));
+
+			sprintf(cpudir->dev.name, "%i", i);
+			sprintf(cpudir->dev.bus_id, "%04x", i);
+			cpudir->dev.parent = &cpu_dev;
+			cpudir->cpu = i;
+
+			device_register(&cpudir->dev);
+			create_entries(&cpudir->dev);
+		}
+	}
+	return 0;
+}
+
+__initcall(create_per_cpu_entries);
+
+#else /* !CONFIG_HOTPLUG */
+
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
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
 {
@@ -48,7 +255,11 @@ int __devinit cpu_up(unsigned int cpu)
 	printk("CPU %u IS NOW UP!\n", cpu);
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, (void *)(long)cpu);
 
+#if 0 /* FIXME: Don't do this during boot. --RR */
+	cpu_run_sbin_hotplug(cpu, "add");
+#endif
  out:
 	up(&cpucontrol);
 	return ret;
 }
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/kernel/sched.c .7234-linux-2.5.34.updated/kernel/sched.c
--- .7234-linux-2.5.34/kernel/sched.c	2002-09-13 11:46:29.000000000 +1000
+++ .7234-linux-2.5.34.updated/kernel/sched.c	2002-09-13 11:47:04.000000000 +1000
@@ -412,11 +412,13 @@ repeat_lock_task:
 	if (!p->array) {
 		/*
 		 * Fast-migrate the task if it's not running or runnable
-		 * currently. Do not violate hard affinity.
+		 * currently. Do not violate hard affinity. Do not pull 
+		 * onto offline CPU.
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(test_bit(smp_processor_id(), p->cpus_allowed)))) {
+			(test_bit(smp_processor_id(), p->cpus_allowed)) &&
+			cpu_online(smp_processor_id()))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -744,6 +746,11 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
+	/* CPU going down is a special case: we don't pull more tasks
+	   onboard */
+	if (unlikely(!cpu_online(this_cpu)))
+		goto out;
+
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
 	if (!busiest)
 		goto out;
@@ -1968,6 +1975,105 @@ int set_cpus_allowed(task_t *p, const un
 	return ret;
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
+	struct task_struct *p;
+	DECLARE_BITMAP(cpus_allowed, NR_CPUS);
+
+ again:
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (p == current)
+			continue;
+
+		/* Kernel threads which are bound to specific
+		   processors need to look after themselves
+		   with their own callbacks */
+		if (p->mm == NULL
+		    && find_first_zero_bit(p->cpus_allowed,NR_CPUS) != NR_CPUS)
+			continue;
+
+		if (task_cpu(p) != smp_processor_id())
+			continue;
+
+		get_task_struct(p);
+		break;
+	}
+	read_unlock(&tasklist_lock);
+
+	/* Did we reach the end? */
+	if (p == &init_task)
+		return num_signalled;
+
+	memcpy(cpus_allowed, p->cpus_allowed, sizeof(cpus_allowed));
+	clear_bit(smp_processor_id(), cpus_allowed);
+	dest_cpu = any_online_cpu(cpus_allowed);
+	if (dest_cpu == NR_CPUS) {
+		num_signalled++;
+		if (!kill_it) {
+			/* FIXME: New signal needed? --RR */
+			force_sig(SIGPWR, p);
+			goto again;
+		}
+		/* Kill it (it can die on any CPU). */
+		memset(p->cpus_allowed, 0xFF, sizeof(p->cpus_allowed));
+		clear_bit(smp_processor_id(), p->cpus_allowed);
+		dest_cpu = any_online_cpu(p->cpus_allowed);
+		force_sig(SIGKILL, p);
+	}
+	move_task_away(p, dest_cpu);
+	goto again;
+}
+
+/* Move non-kernel-thread tasks off this (offline) CPU, except us. */
+void migrate_all_tasks(void)
+{
+	preempt_disable();
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
@@ -2000,10 +2106,8 @@ static int migration_thread(void * data)
 
 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
 
-	for (;;) {
-		runqueue_t *rq_src, *rq_dest;
+	while (migration_stop != cpu) {
 		struct list_head *head;
-		int cpu_src, cpu_dest;
 		migration_req_t *req;
 		unsigned long flags;
 		task_t *p;
@@ -2021,31 +2125,33 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = any_online_cpu(p->cpus_allowed);
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
-			}
-		}
-		double_rq_unlock(rq_src, rq_dest);
-		local_irq_restore(flags);
-
+ 		move_task_away(p, any_online_cpu(p->cpus_allowed));
 		complete(&req->done);
 	}
+	current->state = TASK_RUNNING;
+
+	printk("Migration thread for %u exiting\n", cpu);
+	rq->migration_thread = NULL;
+	complete(&migration_stopped);
+
+	return 0;
+}
+
+/* No locking required: CPU notifiers are serialized */
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
 }
 
 /*
@@ -2065,6 +2171,9 @@ static int migration_call(struct notifie
 		while (!cpu_rq((long)hcpu)->migration_thread)
 			yield();
 		break;
+	case CPU_OFFLINE:
+		stop_migration_thread((long)hcpu);
+		break;
 	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/kernel/softirq.c .7234-linux-2.5.34.updated/kernel/softirq.c
--- .7234-linux-2.5.34/kernel/softirq.c	2002-09-13 11:46:28.000000000 +1000
+++ .7234-linux-2.5.34.updated/kernel/softirq.c	2002-09-13 11:47:04.000000000 +1000
@@ -352,11 +352,20 @@ void __run_task_queue(task_queue *list)
 	}
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
+	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
 	daemonize();
+	reparent_to_init();
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
@@ -372,7 +381,8 @@ static int ksoftirqd(void * __bind_cpu)
 
 	ksoftirqd_task(cpu) = current;
 
-	for (;;) {
+	while (ksoftirq_stop != cpu) {
+		rmb();
 		if (!softirq_pending(cpu))
 			schedule();
 
@@ -385,25 +395,98 @@ static int ksoftirqd(void * __bind_cpu)
 
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
+	unsigned int i, hotcpu = (unsigned long)hcpu;
 
 	if (action == CPU_ONLINE) {
 		if (kernel_thread(ksoftirqd, hcpu,
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0) {
-			printk("ksoftirqd for %i failed\n", hotcpu);
+			printk("ksoftirqd for %u failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
 
 		while (!ksoftirqd_task(hotcpu))
 			yield();
 		return NOTIFY_OK;
- 	}
+	}
+
+	if (action == CPU_OFFLINE) {
+		struct task_struct *kd_task;
+
+		printk("Killing ksoftirqd for %u\n", hotcpu);
+		/* Kill ksoftirqd: get ref in case it exits before we
+                   wake it */
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
+		return NOTIFY_OK;
+	}
+
+	if (action == CPU_DEAD) {
+		__u32 pending;
+		struct tasklet_struct *list, *t;
+		unsigned int cpu = get_cpu();
+
+		printk("Moving ksoftirqs for %u\n", hotcpu);
+
+		/* move pending softirqs */
+		local_irq_disable();
+
+		pending = softirq_pending(hotcpu);
+		softirq_pending(hotcpu) = 0;
+
+		for (i=0; i<32; i++)
+			if (pending & (1<<i))
+				__cpu_raise_softirq(cpu, i);
+		list = per_cpu(tasklet_vec, hotcpu).list;
+		if (list != NULL) {
+			t = list;
+			while (list->next != NULL)
+				list = list->next;
+			list->next = __get_cpu_var(tasklet_vec).list;
+			__get_cpu_var(tasklet_vec).list = t;
+			per_cpu(tasklet_vec, hotcpu).list = NULL;
+		}
+	
+		list = per_cpu(tasklet_hi_vec, hotcpu).list;
+		if (list != NULL) {
+			t = list;
+			while (list->next != NULL)
+				list = list->next;
+			list->next = __get_cpu_var(tasklet_hi_vec).list;
+			__get_cpu_var(tasklet_hi_vec).list = t;
+			per_cpu(tasklet_hi_vec, hotcpu).list = NULL;
+		}
+		local_irq_enable();
+		put_cpu();
+
+		return NOTIFY_OK;
+	}
+
+	/* We fear change! */
 	return NOTIFY_BAD;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7234-linux-2.5.34/net/core/dev.c .7234-linux-2.5.34.updated/net/core/dev.c
--- .7234-linux-2.5.34/net/core/dev.c	2002-09-01 12:23:08.000000000 +1000
+++ .7234-linux-2.5.34.updated/net/core/dev.c	2002-09-13 11:47:04.000000000 +1000
@@ -105,6 +105,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/smp.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -2864,3 +2865,67 @@ static int net_run_sbin_hotplug(struct n
 	return call_usermodehelper(argv [0], argv, envp);
 }
 #endif
+
+static int dev_cpu_callback(struct notifier_block *nfb, unsigned long action, void * ocpu)
+{
+        struct sk_buff *list_sk, *sk_head;
+        struct net_device *list_net, *net_head;
+        struct softnet_data *queue;
+        struct sk_buff *skb;
+        unsigned int  cpu = smp_processor_id();
+	unsigned long oldcpu = (unsigned long) ocpu;
+	unsigned long flags;
+
+	if (action != CPU_OFFLINE)
+		return 0;
+
+	local_irq_save(flags);
+
+        /* Move completion queue */
+
+        list_sk = softnet_data[oldcpu].completion_queue;
+        if (list_sk != NULL) {
+                sk_head = list_sk;
+                while (list_sk->next != NULL)
+                        list_sk = list_sk->next;
+                list_sk->next = softnet_data[cpu].completion_queue;
+                softnet_data[cpu].completion_queue = sk_head;
+                softnet_data[oldcpu].completion_queue = NULL;
+        }
+
+        /* Move output_queue */
+
+        list_net = softnet_data[oldcpu].output_queue;
+        if (list_net != NULL) {
+                net_head = list_net;
+                while (list_net->next != NULL)
+                        list_net = list_net->next_sched;
+                list_net->next_sched = softnet_data[cpu].output_queue;
+                softnet_data[cpu].output_queue = net_head;
+                softnet_data[oldcpu].output_queue = NULL;
+        }
+
+	local_irq_restore(flags);
+        
+        /* Move input_pkt_queue */
+
+	queue = &softnet_data[oldcpu];
+        for (;;) {
+                skb = __skb_dequeue(&queue->input_pkt_queue);
+                if (skb == NULL)
+                        break;
+                netif_rx(skb);
+        }
+
+        return 0;
+}
+
+static struct notifier_block cpu_callback_nfb = {&dev_cpu_callback, NULL, 0 };
+
+static int __init dev_cpu_callback_init(void)
+{
+        register_cpu_notifier(&cpu_callback_nfb);
+        return 0;
+}
+
+__initcall(dev_cpu_callback_init);
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
