Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGZE0s>; Fri, 26 Jul 2002 00:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGZE0s>; Fri, 26 Jul 2002 00:26:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60333 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316768AbSGZE0f>;
	Fri, 26 Jul 2002 00:26:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU boot (retransmit).
Date: Fri, 26 Jul 2002 14:27:46 +1000
Message-Id: <20020726043057.BDF2948C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per Linus' earlier request, redoes the boot sequence to move
towards hotplug (see details).

Only i386 and PPC converted: boot code changes best left to arch
maintainers.

Thanks,
Rusty.

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

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/include/linux/notifier.h linux-2.5.27.1170.updated/include/linux/notifier.h
--- linux-2.5.27.1170/include/linux/notifier.h	Wed Jul 17 10:25:53 2002
+++ linux-2.5.27.1170.updated/include/linux/notifier.h	Tue Jul 23 00:22:41 2002
@@ -60,5 +60,7 @@ extern int notifier_call_chain(struct no
 
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
+#define CPU_ONLINE	0x0002 /* CPU (unsigned)v coming up */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/include/linux/sched.h linux-2.5.27.1170.updated/include/linux/sched.h
--- linux-2.5.27.1170/include/linux/sched.h	Sun Jul 21 17:43:10 2002
+++ linux-2.5.27.1170.updated/include/linux/sched.h	Tue Jul 23 00:22:41 2002
@@ -150,7 +150,6 @@ extern void update_process_times(int use
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
-extern void migration_init(void);
 extern unsigned long cache_decay_ticks;
 
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/include/linux/smp.h linux-2.5.27.1170.updated/include/linux/smp.h
--- linux-2.5.27.1170/include/linux/smp.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.27.1170.updated/include/linux/smp.h	Tue Jul 23 00:22:41 2002
@@ -32,19 +32,19 @@ extern void FASTCALL(smp_send_reschedule
 
 
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
@@ -71,6 +71,13 @@ extern volatile int smp_msg_id;
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
@@ -92,6 +99,10 @@ static inline void smp_send_reschedule_a
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
+
+/* Need to know about CPUs going up/down? */
+#define register_cpu_notifier(nb) 0
+#define unregister_cpu_notifier(nb) do { } while(0)
 
 #endif /* !SMP */
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/init/main.c linux-2.5.27.1170.updated/init/main.c
--- linux-2.5.27.1170/init/main.c	Sun Jul 21 17:43:10 2002
+++ linux-2.5.27.1170.updated/init/main.c	Tue Jul 23 00:22:41 2002
@@ -95,6 +95,35 @@ int rows, cols;
 
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
 
@@ -275,6 +304,7 @@ static void __init smp_init(void)
 #endif
 
 static inline void setup_per_cpu_areas(void) { }
+static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
 #else
 
@@ -305,11 +335,27 @@ static void __init setup_per_cpu_areas(v
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
@@ -405,14 +451,12 @@ asmlinkage void __init start_kernel(void
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
@@ -444,12 +488,6 @@ static void __init do_initcalls(void)
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
@@ -493,7 +531,10 @@ static int init(void * unused)
 	static char * argv_sh[] = { "sh", NULL, };
 
 	lock_kernel();
+	/* Sets up cpus_possible() */
+	smp_prepare_cpus(max_cpus);
 	do_basic_setup();
+	smp_init();
 
 	prepare_namespace();
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/kernel/Makefile linux-2.5.27.1170.updated/kernel/Makefile
--- linux-2.5.27.1170/kernel/Makefile	Mon Jun 10 16:03:56 2002
+++ linux-2.5.27.1170.updated/kernel/Makefile	Tue Jul 23 00:22:41 2002
@@ -17,6 +17,7 @@ obj-y     = sched.o dma.o fork.o exec_do
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/kernel/cpu.c linux-2.5.27.1170.updated/kernel/cpu.c
--- linux-2.5.27.1170/kernel/cpu.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5.27.1170.updated/kernel/cpu.c	Tue Jul 23 00:22:41 2002
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
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/kernel/sched.c linux-2.5.27.1170.updated/kernel/sched.c
--- linux-2.5.27.1170/kernel/sched.c	Sun Jul 21 17:43:10 2002
+++ linux-2.5.27.1170.updated/kernel/sched.c	Tue Jul 23 00:23:12 2002
@@ -27,6 +27,8 @@
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
+#include <linux/notifier.h>
+#include <linux/delay.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1787,9 +1789,11 @@ void set_cpus_allowed(task_t *p, unsigne
 	migration_req_t req;
 	runqueue_t *rq;
 
+#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
+#endif
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
@@ -1822,8 +1826,6 @@ out:
 	preempt_enable();
 }
 
-static __initdata int master_migration_thread;
-
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
@@ -1835,15 +1837,7 @@ static int migration_thread(void * bind_
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
 
@@ -1900,27 +1894,31 @@ repeat:
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
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27.1170/kernel/softirq.c linux-2.5.27.1170.updated/kernel/softirq.c
--- linux-2.5.27.1170/kernel/softirq.c	Wed Jul 17 10:25:53 2002
+++ linux-2.5.27.1170.updated/kernel/softirq.c	Tue Jul 23 00:22:41 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/tqueue.h>
 #include <linux/percpu.h>
+#include <linux/notifier.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -397,20 +398,32 @@ static int ksoftirqd(void * __bind_cpu)
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
 
Name: Hot-plug CPU Boot Rewrite for i386
Author: Rusty Russell
Status: Tested 2.5.25, dual SMP
Depends: Hotcpu/hotcpu-boot.patch.gz

D: This modifies the i386 boot sequence to "plug in" CPUs one at a
D: time.  This is the minimal change to make it work (the CPUs are
D: brought up as normal during the "smp_prepare_cpus()" probe phase).

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/apic.c working-2.5.25-hotcpu/arch/i386/kernel/apic.c
--- linux-2.5.25/arch/i386/kernel/apic.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/apic.c	Mon Jul 15 18:23:12 2002
@@ -798,9 +798,9 @@
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-void setup_APIC_timer(void * data)
+static void setup_APIC_timer(unsigned int clocks)
 {
-	unsigned int clocks = (unsigned int) data, slice, t0, t1;
+	unsigned int slice, t0, t1;
 	unsigned long flags;
 	int delta;
 
@@ -926,7 +926,7 @@
 
 int dont_use_local_apic_timer __initdata = 0;
 
-void __init setup_APIC_clocks (void)
+void __init setup_boot_APIC_clock(void)
 {
 	/* Disabled by DMI scan or kernel option? */
 	if (dont_use_local_apic_timer)
@@ -941,12 +941,16 @@
 	/*
 	 * Now set up the timer for real.
 	 */
-	setup_APIC_timer((void *)calibration_result);
+	setup_APIC_timer(calibration_result);
 
 	__sti();
+}
 
-	/* and update all other cpus */
-	smp_call_function(setup_APIC_timer, (void *)calibration_result, 1, 1);
+void __init setup_secondary_APIC_clock(void)
+{
+	__cli(); /* FIXME: Do we need this? --RR */
+	setup_APIC_timer(calibration_result);
+	__sti();
 }
 
 void __init disable_APIC_timer(void)
@@ -1178,7 +1182,7 @@
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
-	setup_APIC_clocks();
+	setup_boot_APIC_clock();
 
 	return 0;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/apm.c working-2.5.25-hotcpu/arch/i386/kernel/apm.c
--- linux-2.5.25/arch/i386/kernel/apm.c	Sun Jul  7 02:12:17 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/apm.c	Mon Jul 15 14:42:18 2002
@@ -1587,7 +1587,7 @@
 
 	p = buf;
 
-	if ((num_online_cpus() == 1) &&
+	if ((num_possible_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1718,7 +1718,7 @@
 		}
 	}
 
-	if (debug && (num_online_cpus() == 1)) {
+	if (debug && (num_possible_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1762,7 +1762,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (num_online_cpus() == 1) {
+	if (num_possible_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1905,9 +1905,7 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	/* FIXME: When boot code changes, this will need to be
-           deactivated when/if a CPU comes up --RR */
-	if ((num_online_cpus() > 1) && !power_off) {
+	if ((num_possible_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1961,9 +1959,7 @@
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	/* FIXME: When boot code changes, this will need to be
-           deactivated when/if a CPU comes up --RR */
-	if (num_online_cpus() > 1) {
+	if (num_possible_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/mtrr.c working-2.5.25-hotcpu/arch/i386/kernel/mtrr.c
--- linux-2.5.25/arch/i386/kernel/mtrr.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/mtrr.c	Mon Jul 15 14:42:42 2002
@@ -1055,7 +1055,7 @@
     wait_barrier_cache_disable = TRUE;
     wait_barrier_execute = TRUE;
     wait_barrier_cache_enable = TRUE;
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     /*  Start the ball rolling on other CPUs  */
     if (smp_call_function (ipi_handler, &data, 1, 0) != 0)
 	panic ("mtrr: timed out waiting for other CPUs\n");
@@ -1064,14 +1064,14 @@
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     wait_barrier_cache_disable = FALSE;
     set_mtrr_cache_disable (&ctxt);
 
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, num_online_cpus() - 1);
+    atomic_set (&undone_count, num_booting_cpus() - 1);
     wait_barrier_execute = FALSE;
     (*set_mtrr_up) (reg, base, size, type, FALSE);
     /*  Now wait for other CPUs to complete the function  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/nmi.c working-2.5.25-hotcpu/arch/i386/kernel/nmi.c
--- linux-2.5.25/arch/i386/kernel/nmi.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/nmi.c	Mon Jul 15 15:30:34 2002
@@ -81,6 +81,8 @@
 	sti();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
+	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
+           as they come up. */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/i386/kernel/smpboot.c working-2.5.25-hotcpu/arch/i386/kernel/smpboot.c
--- linux-2.5.25/arch/i386/kernel/smpboot.c	Fri Jun 21 09:41:52 2002
+++ working-2.5.25-hotcpu/arch/i386/kernel/smpboot.c	Mon Jul 15 17:44:05 2002
@@ -31,7 +31,7 @@
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
  *		Martin J. Bligh	: 	Added support for multi-quad systems
  *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
- */
+*		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. */
 
 #include <linux/config.h>
 #include <linux/init.h>
@@ -53,9 +53,6 @@
 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
 
-/* Setup configured maximum number of CPUs to activate */
-static int __initdata max_cpus = NR_CPUS;
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
@@ -64,7 +61,8 @@
 unsigned long cpu_online_map;
 
 static volatile unsigned long cpu_callin_map;
-static volatile unsigned long cpu_callout_map;
+volatile unsigned long cpu_callout_map;
+static unsigned long smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
@@ -73,33 +71,6 @@
 int smp_threads_ready;
 
 /*
- * Setup routine for controlling SMP activation
- *
- * Command-line option of "nosmp" or "maxcpus=0" will disable SMP
- * activation entirely (the MPS table probe still happens, though).
- *
- * Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
- * greater than 0, limits the maximum number of CPUs activated in
- * SMP mode to <NUM>.
- */
-
-static int __init nosmp(char *str)
-{
-	max_cpus = 0;
-	return 1;
-}
-
-__setup("nosmp", nosmp);
-
-static int __init maxcpus(char *str)
-{
-	get_option(&str, &max_cpus);
-	return 1;
-}
-
-__setup("maxcpus=", maxcpus);
-
-/*
  * Trampoline 80x86 program as an array.
  */
 
@@ -139,7 +110,7 @@
  * a given CPU
  */
 
-void __init smp_store_cpu_info(int id)
+static void __init smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -193,29 +164,6 @@
 }
 
 /*
- * Architecture specific routine called by the kernel just before init is
- * fired off. This allows the BP to have everything in order [we hope].
- * At the end of this all the APs will hit the system scheduling and off
- * we go. Each AP will load the system gdt's and jump through the kernel
- * init into idle(). At this point the scheduler will one day take over
- * and give them jobs to do. smp_callin is a standard routine
- * we use to track CPUs as they power up.
- */
-
-static atomic_t smp_commenced = ATOMIC_INIT(0);
-
-void __init smp_commence(void)
-{
-	/*
-	 * Lets the callins below out of their loop.
-	 */
-	Dprintk("Setting commenced=1, go go go\n");
-
-	wmb();
-	atomic_set(&smp_commenced,1);
-}
-
-/*
  * TSC synchronization.
  *
  * We first check wether all CPUs have their TSC's synchronized,
@@ -268,7 +216,7 @@
 	unsigned long one_usec;
 	int buggy = 0;
 
-	printk("checking TSC synchronization across CPUs: ");
+	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
 	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
 
@@ -289,7 +237,7 @@
 		/*
 		 * all APs synchronize but they loop on '== num_cpus'
 		 */
-		while (atomic_read(&tsc_count_start) != num_online_cpus()-1)
+		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1)
 			mb();
 		atomic_set(&tsc_count_stop, 0);
 		wmb();
@@ -308,7 +256,7 @@
 		/*
 		 * Wait for all APs to leave the synchronization point:
 		 */
-		while (atomic_read(&tsc_count_stop) != num_online_cpus()-1)
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1)
 			mb();
 		atomic_set(&tsc_count_start, 0);
 		wmb();
@@ -317,16 +265,16 @@
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i)) {
+		if (test_bit(i, &cpu_callout_map)) {
 			t0 = tsc_values[i];
 			sum += t0;
 		}
 	}
-	avg = div64(sum, num_online_cpus());
+	avg = div64(sum, num_booting_cpus());
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!test_bit(i, &cpu_callout_map))
 			continue;
 		delta = tsc_values[i] - avg;
 		if (delta < 0)
@@ -359,7 +307,7 @@
 	int i;
 
 	/*
-	 * num_online_cpus is not necessarily known at the time
+	 * Not every cpu is online at the time
 	 * this gets called, so we first wait for the BP to
 	 * finish SMP initialization:
 	 */
@@ -367,7 +315,7 @@
 
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_online_cpus())
+		while (atomic_read(&tsc_count_start) != num_booting_cpus())
 			mb();
 
 		rdtscll(tsc_values[smp_processor_id()]);
@@ -375,7 +323,7 @@
 			write_tsc(0, 0);
 
 		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_online_cpus()) mb();
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
 	}
 }
 #undef NR_LOOPS
@@ -403,7 +351,7 @@
 	 */
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
-	if (test_and_set_bit(cpuid, &cpu_online_map)) {
+	if (test_bit(cpuid, &cpu_callin_map)) {
 		printk("huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
@@ -501,15 +449,17 @@
 	 */
 	cpu_init();
 	smp_callin();
-	while (!atomic_read(&smp_commenced))
+	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
+	setup_secondary_APIC_clock();
 	enable_APIC_timer();
 	/*
 	 * low-memory mappings have been cleared, flush them from
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-
+	set_bit(smp_processor_id(), &cpu_online_map);
+	wmb();
 	return cpu_idle();
 }
 
@@ -943,7 +893,6 @@
 		unmap_cpu_to_boot_apicid(cpu, apicid);
 		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
-		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
 		cpucount--;
 	}
 
@@ -1015,7 +964,7 @@
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
-void __init smp_boot_cpus(void)
+static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
 
@@ -1057,6 +1006,7 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
+	set_bit(0, &cpu_callout_map);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
@@ -1073,11 +1023,11 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
+		phys_cpu_present_map = 1;
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
-		goto smp_done;
+		return;
 	}
 
 	/*
@@ -1102,8 +1052,8 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
-		goto smp_done;
+		phys_cpu_present_map = 1;
+		return;
 	}
 
 	verify_local_APIC();
@@ -1117,8 +1067,8 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
-		goto smp_done;
+		phys_cpu_present_map = 1;
+		return;
 	}
 
 	connect_bsp_APIC();
@@ -1190,7 +1140,7 @@
 	} else {
 		unsigned long bogosum = 0;
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_online_map & (1<<cpu))
+			if (cpu_callout_map & (1<<cpu))
 				bogosum += cpu_data[cpu].loops_per_jiffy;
 		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 			cpucount+1,
@@ -1213,10 +1163,10 @@
 		
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			if (!cpu_online(cpu)) continue;
+			if (!test_bit(cpu, &cpu_callout_map)) continue;
 
 			for (i = 0; i < NR_CPUS; i++) {
-				if (i == cpu || !cpu_online(i))
+				if (i == cpu || !test_bit(i, &cpu_callout_map))
 					continue;
 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
 					cpu_sibling_map[cpu] = i;
@@ -1240,17 +1190,40 @@
 		setup_IO_APIC();
 #endif
 
-	/*
-	 * Set up all local APIC timers in the system:
-	 */
-	setup_APIC_clocks();
+	setup_boot_APIC_clock();
 
 	/*
 	 * Synchronize the TSC with the AP
 	 */
 	if (cpu_has_tsc && cpucount)
 		synchronize_tsc_bp();
+}
 
-smp_done:
+/* These are wrappers to interface to the new boot process.  Someone
+   who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	smp_boot_cpus(max_cpus);
+}
+
+int __devinit __cpu_up(unsigned int cpu)
+{
+	/* This only works at boot for x86.  See "rewrite" above. */
+	if (test_bit(cpu, &smp_commenced_mask))
+		return -ENOSYS;
+
+	/* In case one didn't come up */
+	if (!test_bit(cpu, &cpu_callin_map))
+		return -EIO;
+
+	/* Unleash the CPU! */
+	set_bit(cpu, &smp_commenced_mask);
+	while (!test_bit(cpu, &cpu_online_map))
+		mb();
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
 	zap_low_mappings();
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-i386/apic.h working-2.5.25-hotcpu/include/asm-i386/apic.h
--- linux-2.5.25/include/asm-i386/apic.h	Mon Apr 15 11:47:44 2002
+++ working-2.5.25-hotcpu/include/asm-i386/apic.h	Mon Jul 15 18:22:21 2002
@@ -76,7 +76,8 @@
 extern void setup_local_APIC (void);
 extern void init_apic_mappings (void);
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
-extern void setup_APIC_clocks (void);
+extern void setup_boot_APIC_clock (void);
+extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-i386/smp.h working-2.5.25-hotcpu/include/asm-i386/smp.h
--- linux-2.5.25/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.25-hotcpu/include/asm-i386/smp.h	Mon Jul 15 14:46:12 2002
@@ -79,19 +79,13 @@
 extern volatile int logical_apicid_to_cpu[MAX_APICID];
 
 /*
- * General functions that each host system must provide.
- */
- 
-extern void smp_boot_cpus(void);
-extern void smp_store_cpu_info(int id);		/* Store per CPU info (like the initial udelay numbers */
-
-/*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
+#define cpu_possible(cpu) (phys_cpu_present_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
@@ -117,6 +111,13 @@
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
+}
+
+extern volatile unsigned long cpu_callout_map;
+/* We don't mark CPUs online until __cpu_up(), so we need another measure */
+static inline int num_booting_cpus(void)
+{
+	return hweight32(cpu_callout_map);
 }
 
 #endif /* !__ASSEMBLY__ */

Name: Hot-plug CPU Boot Rewrite for PPC
Author: Rusty Russell
Status: Tested on 2.5.15/PPC
Depends: Hotcpu/hotcpu-boot.patch.gz

D: This modifies the PPC boot sequence to "plug in" CPUs one at a
D: time.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/open_pic.c working-ppc-2.5-hotcpu/arch/ppc/kernel/open_pic.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/open_pic.c	Thu May 23 18:23:50 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/kernel/open_pic.c	Mon May 27 15:03:53 2002
@@ -603,7 +603,7 @@
  *   -- Cort
  */
 
-void __init do_openpic_setup_cpu(void)
+void __devinit do_openpic_setup_cpu(void)
 {
  	int i;
 	u32 msk = 1 << smp_hw_index[smp_processor_id()];
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/smp.c working-ppc-2.5-hotcpu/arch/ppc/kernel/smp.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/smp.c	Thu May 23 18:23:00 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/kernel/smp.c	Wed May 29 14:05:44 2002
@@ -48,15 +48,17 @@
 atomic_t ipi_recv;
 atomic_t ipi_sent;
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-unsigned int prof_multiplier[NR_CPUS];
-unsigned int prof_counter[NR_CPUS];
-unsigned long cache_decay_ticks;
-static int max_cpus __initdata = NR_CPUS;
-unsigned long cpu_online_map;
+unsigned int prof_multiplier[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
+unsigned int prof_counter[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
+unsigned long cache_decay_ticks = HZ/100;
+unsigned long cpu_online_map = 1UL;
+unsigned long cpu_possible_map = 1UL;
 int smp_hw_index[NR_CPUS];
-static struct smp_ops_t *smp_ops;
 struct thread_info *secondary_ti;
 
+/* SMP operations for this machine */
+static struct smp_ops_t *smp_ops;
+
 /* all cpu mappings are 1-1 -- Cort */
 volatile unsigned long cpu_callin_map[NR_CPUS];
 
@@ -70,10 +72,6 @@
 static int __smp_call_function(void (*func) (void *info), void *info,
 			       int wait, int target);
 
-#ifdef CONFIG_PPC_ISERIES
-extern void smp_iSeries_space_timers( unsigned nr );
-#endif
-
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  * 
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
@@ -291,6 +289,7 @@
 		atomic_inc(&call_data->finished);
 }
 
+#if 0 /* Old boot code. */
 void __init smp_boot_cpus(void)
 {
 	int i, cpu_nr;
@@ -558,3 +552,156 @@
 }
 
 __setup("maxcpus=", maxcpus);
+#else /* New boot code */
+/* FIXME: Do this properly for all archs --RR */
+static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int timebase_upper = 0, timebase_lower = 0;
+
+void __devinit
+smp_generic_give_timebase(void)
+{
+	spin_lock(&timebase_lock);
+	do {
+		timebase_upper = get_tbu();
+		timebase_lower = get_tbl();
+	} while (timebase_upper != get_tbu());
+	spin_unlock(&timebase_lock);
+
+	while (timebase_upper || timebase_lower)
+		rmb();
+}
+
+void __devinit
+smp_generic_take_timebase(void)
+{
+	int done = 0;
+
+	while (!done) {
+		spin_lock(&timebase_lock);
+		if (timebase_upper || timebase_lower) {
+			set_tb(timebase_upper, timebase_lower);
+			timebase_upper = 0;
+			timebase_lower = 0;
+			done = 1;
+		}
+		spin_unlock(&timebase_lock);
+	}
+}
+
+static void __devinit smp_store_cpu_info(int id)
+{
+        struct cpuinfo_PPC *c = &cpu_data[id];
+
+	/* assume bogomips are same for everything */
+        c->loops_per_jiffy = loops_per_jiffy;
+        c->pvr = mfspr(PVR);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	int num_cpus;
+
+	/* Fixup boot cpu */
+        smp_store_cpu_info(smp_processor_id());
+	cpu_callin_map[smp_processor_id()] = 1;
+
+	smp_ops = ppc_md.smp_ops;
+	if (smp_ops == NULL) {
+		printk("SMP not supported on this machine.\n");
+		return;
+	}
+
+	/* Probe platform for CPUs: always linear. */
+	num_cpus = smp_ops->probe();
+	cpu_possible_map = (1 << num_cpus)-1;
+
+	if (smp_ops->space_timers)
+		smp_ops->space_timers(num_cpus);
+}
+
+int __init setup_profiling_timer(unsigned int multiplier)
+{
+	return 0;
+}
+
+/* Processor coming up starts here */
+int __devinit start_secondary(void *unused)
+{
+	int cpu;
+
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
+
+	cpu = smp_processor_id();
+        smp_store_cpu_info(cpu);
+	set_dec(tb_ticks_per_jiffy);
+	cpu_callin_map[cpu] = 1;
+
+	printk("CPU %i done callin...\n", cpu);
+	smp_ops->setup_cpu(cpu);
+	printk("CPU %i done setup...\n", cpu);
+	smp_ops->take_timebase();
+	printk("CPU %i done timebase take...\n", cpu);
+
+	return cpu_idle(NULL);
+}
+
+int __cpu_up(unsigned int cpu)
+{
+	struct pt_regs regs;
+	struct task_struct *p;
+	char buf[32];
+	int c;
+
+	/* create a process for the processor */
+	/* only regs.msr is actually used, and 0 is OK for it */
+	memset(&regs, 0, sizeof(struct pt_regs));
+	p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+	if (IS_ERR(p))
+		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
+
+	init_idle(p, cpu);
+	unhash_process(p);
+
+	secondary_ti = p->thread_info;
+	p->thread_info->cpu = cpu;
+
+	/*
+	 * There was a cache flush loop here to flush the cache
+	 * to memory for the first 8MB of RAM.  The cache flush
+	 * has been pushed into the kick_cpu function for those
+	 * platforms that need it.
+	 */
+
+	/* wake up cpu */
+	smp_ops->kick_cpu(cpu);
+		
+	/*
+	 * wait to see if the cpu made a callin (is actually up).
+	 * use this value that I found through experimentation.
+	 * -- Cort
+	 */
+	for (c = 1000; c && !cpu_callin_map[cpu]; c--)
+		udelay(100);
+
+	if (!cpu_callin_map[cpu]) {
+		sprintf(buf, "didn't find cpu %u", cpu);
+		if (ppc_md.progress) ppc_md.progress(buf, 0x360+cpu);
+		printk("Processor %u is stuck.\n", cpu);
+		return -ENOENT;
+	}
+
+	sprintf(buf, "found cpu %u", cpu);
+	if (ppc_md.progress) ppc_md.progress(buf, 0x350+cpu);
+	printk("Processor %d found.\n", cpu);
+
+	smp_ops->give_timebase();
+	set_bit(cpu, &cpu_online_map);
+	return 0;
+}
+
+void smp_cpus_done(unsigned int max_cpus)
+{
+	smp_ops->setup_cpu(0);
+}
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/chrp_smp.c working-ppc-2.5-hotcpu/arch/ppc/platforms/chrp_smp.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/chrp_smp.c	Thu May 23 16:04:30 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/chrp_smp.c	Wed May 29 14:05:25 2002
@@ -50,59 +50,61 @@
 	return smp_chrp_cpu_nr;
 }
 
-static void __init
+static void __devinit
 smp_chrp_kick_cpu(int nr)
 {
 	*(unsigned long *)KERNELBASE = nr;
 	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
 }
 
-static void __init
+static void __devinit
 smp_chrp_setup_cpu(int cpu_nr)
 {
-	static atomic_t ready = ATOMIC_INIT(1);
-	static volatile int frozen = 0;
-
-	/* FIXME: Hotplug cpu breaks all this --RR */
-	if (cpu_nr == 0) {
-		/* wait for all the others */
-		while (atomic_read(&ready) < num_online_cpus())
-			barrier();
-		atomic_set(&ready, 1);
-		/* freeze the timebase */
-		call_rtas("freeze-time-base", 0, 1, NULL);
-		mb();
-		frozen = 1;
-		/* XXX assumes this is not a 601 */
-		set_tb(0, 0);
-		last_jiffy_stamp(0) = 0;
-		while (atomic_read(&ready) < num_online_cpus())
-			barrier();
-		/* thaw the timebase again */
-		call_rtas("thaw-time-base", 0, 1, NULL);
-		mb();
-		frozen = 0;
-		smp_tb_synchronized = 1;
-	} else {
-		atomic_inc(&ready);
-		while (!frozen)
-			barrier();
-		set_tb(0, 0);
-		last_jiffy_stamp(0) = 0;
-		mb();
-		atomic_inc(&ready);
-		while (frozen)
-			barrier();
-	}
-
 	if (OpenPIC_Addr)
 		do_openpic_setup_cpu();
 }
 
+static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int timebase_upper = 0, timebase_lower = 0;
+
+void __devinit
+smp_chrp_give_timebase(void)
+{
+	spin_lock(&timebase_lock);
+	call_rtas("freeze-time-base", 0, 1, NULL);
+	timebase_upper = get_tbu();
+	timebase_lower = get_tbl();
+	spin_unlock(&timebase_lock);
+
+	while (timebase_upper || timebase_lower)
+		rmb();
+	call_rtas("thaw-time-base", 0, 1, NULL);
+}
+
+void __devinit
+smp_chrp_take_timebase(void)
+{
+	int done = 0;
+
+	while (!done) {
+		spin_lock(&timebase_lock);
+		if (timebase_upper || timebase_lower) {
+			set_tb(timebase_upper, timebase_lower);
+			timebase_upper = 0;
+			timebase_lower = 0;
+			done = 1;
+		}
+		spin_unlock(&timebase_lock);
+	}
+	printk("CPU %i taken timebase\n", smp_processor_id());
+}
+
 /* CHRP with openpic */
 struct smp_ops_t chrp_smp_ops __chrpdata = {
-	smp_openpic_message_pass,
-	smp_chrp_probe,
-	smp_chrp_kick_cpu,
-	smp_chrp_setup_cpu,
+	.message_pass = smp_openpic_message_pass,
+	.probe = smp_chrp_probe,
+	.kick_cpu = smp_chrp_kick_cpu,
+	.setup_cpu = smp_chrp_setup_cpu,
+	.give_timebase = smp_chrp_give_timebase,
+	.take_timebase = smp_chrp_take_timebase,
 };
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/gemini_setup.c working-ppc-2.5-hotcpu/arch/ppc/platforms/gemini_setup.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/gemini_setup.c	Sun Feb 10 22:41:25 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/gemini_setup.c	Mon May 27 15:05:50 2002
@@ -527,6 +527,8 @@
 	smp_gemini_probe,
 	smp_gemini_kick_cpu,
 	smp_gemini_setup_cpu,
+	.give_timebase = smp_generic_give_timebase,
+	.take_timebase = smp_generic_take_timebase,
 };
 #endif /* CONFIG_SMP */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/iSeries_smp.c working-ppc-2.5-hotcpu/arch/ppc/platforms/iSeries_smp.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/iSeries_smp.c	Thu May 23 16:05:09 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/iSeries_smp.c	Mon May 27 15:23:12 2002
@@ -117,7 +117,7 @@
 	set_dec( xPaca[nr].default_decr );
 }
 
-void smp_iSeries_space_timers( unsigned nr )
+static void smp_iSeries_space_timers(unsigned nr)
 {
 	unsigned offset,i;
 	
@@ -131,6 +131,9 @@
    smp_iSeries_message_pass,
    smp_iSeries_probe,
    smp_iSeries_kick_cpu,
-   smp_iSeries_setup_cpu
+   smp_iSeries_setup_cpu,
+   smp_iSeries_space_timers,
+   .give_timebase = smp_generic_give_timebase,
+   .take_timebase = smp_generic_take_timebase,
 };
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pmac_smp.c working-ppc-2.5-hotcpu/arch/ppc/platforms/pmac_smp.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pmac_smp.c	Thu May 23 16:06:11 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/pmac_smp.c	Mon May 27 15:23:12 2002
@@ -612,6 +612,8 @@
 	smp_psurge_probe,
 	smp_psurge_kick_cpu,
 	smp_psurge_setup_cpu,
+	.give_timebase = smp_generic_give_timebase,
+	.take_timebase = smp_generic_take_timebase,
 };
 
 /* Core99 Macs (dual G4s) */
@@ -620,4 +622,6 @@
 	smp_core99_probe,
 	smp_core99_kick_cpu,
 	smp_core99_setup_cpu,
+	.give_timebase = smp_generic_give_timebase,
+	.take_timebase = smp_generic_take_timebase,
 };
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pplus_setup.c working-ppc-2.5-hotcpu/arch/ppc/platforms/pplus_setup.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pplus_setup.c	Mon May 13 08:54:21 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/pplus_setup.c	Mon May 27 15:23:11 2002
@@ -318,6 +318,8 @@
 	smp_pplus_probe,
 	smp_pplus_kick_cpu,
 	smp_pplus_setup_cpu,
+	.give_timebase = smp_generic_give_timebase,
+	.take_timebase = smp_generic_take_timebase,
 };
 #endif /* CONFIG_SMP */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/prep_setup.c working-ppc-2.5-hotcpu/arch/ppc/platforms/prep_setup.c
--- working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/prep_setup.c	Mon May 13 08:54:21 2002
+++ working-ppc-2.5-hotcpu/arch/ppc/platforms/prep_setup.c	Mon May 27 16:36:25 2002
@@ -765,6 +765,8 @@
 	smp_prep_probe,
 	smp_prep_kick_cpu,
 	smp_prep_setup_cpu,
+	.give_timebase = smp_generic_give_timebase,
+	.take_timebase = smp_generic_take_timebase,
 };
 #endif /* CONFIG_SMP */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/include/asm-ppc/machdep.h working-ppc-2.5-hotcpu/include/asm-ppc/machdep.h
--- working-ppc-2.5-pre-hotcpu/include/asm-ppc/machdep.h	Tue May 28 11:12:45 2002
+++ working-ppc-2.5-hotcpu/include/asm-ppc/machdep.h	Tue May 28 16:47:06 2002
@@ -6,6 +6,7 @@
 #define _PPC_MACHDEP_H
 
 #include <linux/config.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_APUS
 #include <asm-m68k/machdep.h>
@@ -135,7 +136,14 @@
 	int   (*probe)(void);
 	void  (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
+	void  (*space_timers)(int nr);
+	void  (*take_timebase)(void);
+	void  (*give_timebase)(void);
 };
+
+/* Poor default implementations */
+extern void __devinit smp_generic_give_timebase(void);
+extern void __devinit smp_generic_take_timebase(void);
 #endif /* CONFIG_SMP */
 
 #endif /* _PPC_MACHDEP_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-pre-hotcpu/include/asm-ppc/smp.h working-ppc-2.5-hotcpu/include/asm-ppc/smp.h
--- working-ppc-2.5-pre-hotcpu/include/asm-ppc/smp.h	Thu May 23 18:03:18 2002
+++ working-ppc-2.5-hotcpu/include/asm-ppc/smp.h	Tue May 28 16:47:01 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_SMP
 
@@ -31,11 +32,11 @@
 
 extern struct cpuinfo_PPC cpu_data[];
 extern unsigned long cpu_online_map;
+extern unsigned long cpu_possible_map;
 extern unsigned long smp_proc_in_lock[];
 extern volatile unsigned long cpu_callin_map[];
 extern int smp_tb_synchronized;
 
-extern void smp_store_cpu_info(int id);
 extern void smp_send_tlb_invalidate(int);
 extern void smp_send_xmon_break(int cpu);
 struct pt_regs;
@@ -48,6 +49,7 @@
 #define smp_processor_id() (current_thread_info()->cpu)
 
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+#define cpu_possible(cpu) (cpu_possible_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
 {
@@ -61,6 +63,8 @@
 
 	return -1;
 }
+
+extern int __cpu_up(unsigned int cpu);
 
 extern int smp_hw_index[];
 #define hard_smp_processor_id() (smp_hw_index[smp_processor_id()])

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
