Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318006AbSGRESq>; Thu, 18 Jul 2002 00:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGRESq>; Thu, 18 Jul 2002 00:18:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:6322 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318006AbSGRESm>;
	Thu, 18 Jul 2002 00:18:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Hotplug CPU Boot Change 1/2
Date: Thu, 18 Jul 2002 14:20:52 +1000
Message-Id: <20020718042221.D0C78447B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Breaks everything.  But is cool.

Name: Hot-plug CPU Boot Changes
Author: Rusty Russell
Status: Tested on 2.5.25, x86 SMP

D: This patch alters the boot sequence to "plug in" each CPU, one at a
D: time.  You need the patch for each architecture, as well.  The
D: interface used to be "smp_boot_cpus()", "smp_commence()", and each
D: arch implemented the "maxcpus" boot arg itself.  With this patch,
D: it is:
D:   smp_prepare_cpus(maxcpus): probe for cpus and set up cpu_possible(cpu).
D:   __cpu_up(cpu): called *after* initcalls, for each cpu where
D:      cpu_possible(cpu) is true.
D:   smp_cpus_done(maxcpus): called after every cpu has been brought up

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/notifier.h working-2.5.25-hotcpu/include/linux/notifier.h
--- linux-2.5.25/include/linux/notifier.h	Mon Jun 24 00:55:28 2002
+++ working-2.5.25-hotcpu/include/linux/notifier.h	Mon Jul 15 12:44:55 2002
@@ -58,5 +58,7 @@
 #define SYS_HALT	0x0002	/* Notify of system halt */
 #define SYS_POWER_OFF	0x0003	/* Notify of system power off */
 
+#define CPU_ONLINE	0x0002 /* CPU (unsigned)v coming up */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/sched.h working-2.5.25-hotcpu/include/linux/sched.h
--- linux-2.5.25/include/linux/sched.h	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-hotcpu/include/linux/sched.h	Mon Jul 15 12:44:55 2002
@@ -150,7 +150,6 @@
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
-extern void migration_init(void);
 extern unsigned long cache_decay_ticks;
 
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/smp.h working-2.5.25-hotcpu/include/linux/smp.h
--- linux-2.5.25/include/linux/smp.h	Fri Jun 21 09:41:55 2002
+++ working-2.5.25-hotcpu/include/linux/smp.h	Mon Jul 15 14:45:56 2002
@@ -32,19 +32,19 @@
 
 
 /*
- * Boot processor call to load the other CPU's
+ * Prepare machine for booting other CPUs.
  */
-extern void smp_boot_cpus(void);
+extern void smp_prepare_cpus(unsigned int max_cpus);
 
 /*
- * Processor call in. Must hold processors until ..
+ * Bring a CPU up
  */
-extern void smp_callin(void);
+extern int __cpu_up(unsigned int cpunum);
 
 /*
- * Multiprocessors may now schedule
+ * Final polishing of CPUs
  */
-extern void smp_commence(void);
+extern void smp_cpus_done(unsigned int max_cpus);
 
 /*
  * Call a function on all other processors
@@ -71,6 +71,13 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
+struct notifier_block;
+
+/* Need to know about CPUs going up/down? */
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
+
+int cpu_up(unsigned int cpu);
 #else /* !SMP */
 
 /*
@@ -92,6 +99,10 @@
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
+
+/* Need to know about CPUs going up/down? */
+#define register_cpu_notifier(nb) 0
+#define unregister_cpu_notifier(nb) do { } while(0)
 
 #endif /* !SMP */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/init/main.c working-2.5.25-hotcpu/init/main.c
--- linux-2.5.25/init/main.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.25-hotcpu/init/main.c	Mon Jul 15 12:44:55 2002
@@ -93,6 +93,35 @@
 
 char *execute_command;
 
+/* Setup configured maximum number of CPUs to activate */
+static unsigned int max_cpus = UINT_MAX;
+
+/*
+ * Setup routine for controlling SMP activation
+ *
+ * Command-line option of "nosmp" or "maxcpus=0" will disable SMP
+ * activation entirely (the MPS table probe still happens, though).
+ *
+ * Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
+ * greater than 0, limits the maximum number of CPUs activated in
+ * SMP mode to <NUM>.
+ */
+static int __init nosmp(char *str)
+{
+	max_cpus = 0;
+	return 1;
+}
+
+__setup("nosmp", nosmp);
+
+static int __init maxcpus(char *str)
+{
+	get_option(&str, &max_cpus);
+	return 1;
+}
+
+__setup("maxcpus=", maxcpus);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
@@ -273,6 +302,7 @@
 #endif
 
 static inline void setup_per_cpu_areas(void) { }
+static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
 #else
 
@@ -303,11 +333,27 @@
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
+	unsigned int i;
+
+	/* FIXME: This should be done in userspace --RR */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (num_online_cpus() >= max_cpus)
+			break;
+		if (cpu_possible(i) && !cpu_online(i)) {
+			printk("Bringing up %i\n", i);
+			cpu_up(i);
+		}
+	}
+
+	/* Any cleanup work */
+	printk("CPUS done %u\n", max_cpus);
+	smp_cpus_done(max_cpus);
+#if 0
 	/* Get other processors into their bootup holding patterns. */
-	smp_boot_cpus();
 
 	smp_threads_ready=1;
 	smp_commence();
+#endif
 }
 
 #endif
@@ -402,14 +448,12 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
-	init_idle(current, smp_processor_id());
-
 	/* 
 	 *	We count on the initial thread going ok 
 	 *	Like idlers init is an unlocked kernel thread, which will
 	 *	make syscalls (and thus be locked).
 	 */
-	smp_init();
+	init_idle(current, smp_processor_id());
 
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
@@ -441,12 +485,6 @@
 static void __init do_basic_setup(void)
 {
 	/*
-	 * Let the per-CPU migration threads start up:
-	 */
-#if CONFIG_SMP
-	migration_init();
-#endif
-	/*
 	 * Tell the world that we're going to be the grim
 	 * reaper of innocent orphaned children.
 	 *
@@ -490,7 +528,10 @@
 	static char * argv_sh[] = { "sh", NULL, };
 
 	lock_kernel();
+	/* Sets up cpus_possible() */
+	smp_prepare_cpus(max_cpus);
 	do_basic_setup();
+	smp_init();
 
 	prepare_namespace();
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/Makefile working-2.5.25-hotcpu/kernel/Makefile
--- linux-2.5.25/kernel/Makefile	Mon Jun 10 16:03:56 2002
+++ working-2.5.25-hotcpu/kernel/Makefile	Mon Jul 15 12:44:55 2002
@@ -17,6 +17,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/cpu.c working-2.5.25-hotcpu/kernel/cpu.c
--- linux-2.5.25/kernel/cpu.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.25-hotcpu/kernel/cpu.c	Mon Jul 15 14:34:49 2002
@@ -0,0 +1,54 @@
+/* CPU control.
+ * (C) 2001 Rusty Russell
+ * This code is licenced under the GPL.
+ */
+#include <linux/proc_fs.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/sched.h>
+#include <linux/unistd.h>
+#include <asm/semaphore.h>
+
+/* This protects CPUs going up and down... */
+DECLARE_MUTEX(cpucontrol);
+
+static struct notifier_block *cpu_chain = NULL;
+
+/* Need to know about CPUs going up/down? */
+int register_cpu_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_register(&cpu_chain, nb);
+}
+
+void unregister_cpu_notifier(struct notifier_block *nb)
+{
+	notifier_chain_unregister(&cpu_chain,nb);
+}
+
+int __devinit cpu_up(unsigned int cpu)
+{
+	int ret;
+
+	if ((ret = down_interruptible(&cpucontrol)) != 0) 
+		return ret;
+
+	if (cpu_online(cpu)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Arch-specific enabling code. */
+	ret = __cpu_up(cpu);
+	if (ret != 0) goto out;
+	if (!cpu_online(cpu))
+		BUG();
+
+	/* Now call notifier in preparation. */
+	printk("CPU %u IS NOW UP!\n", cpu);
+	notifier_call_chain(&cpu_chain, CPU_ONLINE, (void *)cpu);
+
+ out:
+	up(&cpucontrol);
+	return ret;
+}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/sched.c working-2.5.25-hotcpu/kernel/sched.c
--- linux-2.5.25/kernel/sched.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-hotcpu/kernel/sched.c	Mon Jul 15 12:44:55 2002
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+#include <linux/delay.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1752,9 +1756,11 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
+#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
+#endif
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
@@ -1787,8 +1793,6 @@
 	preempt_enable();
 }
 
-static __initdata int master_migration_thread;
-
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
@@ -1800,15 +1804,7 @@
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	/*
-	 * The first migration thread is started on the boot CPU, it
-	 * migrates the other migration threads to their destination CPUs.
-	 */
-	if (cpu != master_migration_thread) {
-		while (!cpu_rq(master_migration_thread)->migration_thread)
-			yield();
-		set_cpus_allowed(current, 1UL << cpu);
-	}
+	set_cpus_allowed(current, 1UL << cpu);
 	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
@@ -1865,27 +1861,31 @@
 	}
 }
 
-void __init migration_init(void)
+static int migration_call(struct notifier_block *nfb,
+			  unsigned long action,
+			  void *hcpu)
 {
-	int cpu;
-
-	master_migration_thread = smp_processor_id();
-	current->cpus_allowed = 1UL << master_migration_thread;
-	
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		if (kernel_thread(migration_thread, (void *) (long) cpu,
-				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
-			BUG();
+	switch (action) {
+	case CPU_ONLINE:
+		printk("Starting migration thread for cpu %li\n",
+		       (long)hcpu);
+		kernel_thread(migration_thread, hcpu,
+			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+		break;
 	}
-	current->cpus_allowed = -1L;
+	return NOTIFY_OK;
+}
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		while (!cpu_rq(cpu)->migration_thread)
-			schedule_timeout(2);
-	}
+static struct notifier_block migration_notifier = { &migration_call, NULL, 0 };
+
+int __init migration_init(void)
+{
+	/* Start one for boot CPU. */
+	migration_call(&migration_notifier, CPU_ONLINE,
+		       (void *)smp_processor_id());
+	register_cpu_notifier(&migration_notifier);
+	return 0;
 }
+
+__initcall(migration_init);
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/softirq.c working-2.5.25-hotcpu/kernel/softirq.c
--- linux-2.5.25/kernel/softirq.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-hotcpu/kernel/softirq.c	Mon Jul 15 12:44:55 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/tqueue.h>
 #include <linux/percpu.h>
+#include <linux/notifier.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -397,20 +398,32 @@
 	}
 }
 
-static __init int spawn_ksoftirqd(void)
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
 {
-	int cpu;
+	int hotcpu = (unsigned long)hcpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		if (kernel_thread(ksoftirqd, (void *) (long) cpu,
-				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
-			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
-		else
-			while (!ksoftirqd_task(cpu))
-				yield();
-	}
+	if (action == CPU_ONLINE) {
+		if (kernel_thread(ksoftirqd, hcpu,
+				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0) {
+			printk("ksoftirqd for %i failed\n", hotcpu);
+			return NOTIFY_BAD;
+		}
+
+		while (!ksoftirqd_task(hotcpu))
+			yield();
+		return NOTIFY_OK;
+ 	}
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
+
+static __init int spawn_ksoftirqd(void)
+{
+	cpu_callback(&cpu_nfb, CPU_ONLINE, (void *)smp_processor_id());
+	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
