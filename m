Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSJWCfz>; Tue, 22 Oct 2002 22:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSJWCfy>; Tue, 22 Oct 2002 22:35:54 -0400
Received: from dp.samba.org ([66.70.73.150]:12161 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262712AbSJWCft>;
	Tue, 22 Oct 2002 22:35:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move cpu stuff from arch/i386 into generic code
Date: Wed, 23 Oct 2002 12:41:22 +1000
Message-Id: <20021023024159.8A94B2C059@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This means that the cpus will appear in driverfs for *all* archs.
Also changed it to per-cpu data, and makes cpu.o compiled even if
!SMP.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm3-cpu-iterators/arch/i386/kernel/cpu/common.c working-2.5.44-mm3-cpu-driverfs/arch/i386/kernel/cpu/common.c
--- working-2.5.44-mm3-cpu-iterators/arch/i386/kernel/cpu/common.c	2002-10-15 15:19:37.000000000 +1000
+++ working-2.5.44-mm3-cpu-driverfs/arch/i386/kernel/cpu/common.c	2002-10-23 12:39:20.000000000 +1000
@@ -507,37 +507,3 @@ void __init cpu_init (void)
 	current->used_math = 0;
 	stts();
 }
-
-/*
- * Bulk registration of the cpu devices with the system.
- * Some of this stuff could possibly be moved into a shared 
- * location..
- * Also, these devices should be integrated with other CPU data..
- */
-
-static struct cpu cpu_devices[NR_CPUS];
-
-static struct device_driver cpu_driver = {
-	.name		= "cpu",
-	.bus		= &system_bus_type,
-	.devclass	= &cpu_devclass,
-};
-
-static int __init register_cpus(void)
-{
-	int i;
-
-	driver_register(&cpu_driver);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		struct sys_device * sysdev = &cpu_devices[i].sysdev;
-		sysdev->name = "cpu";
-		sysdev->id = i;
-		sysdev->dev.driver = &cpu_driver;
-		if (cpu_possible(i))
-			sys_device_register(sysdev);
-	}
-	return 0;
-}
-
-subsys_initcall(register_cpus);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm3-cpu-iterators/include/linux/cpu.h working-2.5.44-mm3-cpu-driverfs/include/linux/cpu.h
--- working-2.5.44-mm3-cpu-iterators/include/linux/cpu.h	2002-10-15 15:19:44.000000000 +1000
+++ working-2.5.44-mm3-cpu-driverfs/include/linux/cpu.h	2002-10-23 12:39:20.000000000 +1000
@@ -19,6 +19,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/percpu.h>
 
 extern struct device_class cpu_devclass;
 
@@ -26,3 +27,7 @@ struct cpu {
 	struct sys_device sysdev;
 };
 
+DECLARE_PER_CPU(struct cpu, cpu_devices);
+
+/* Bring a CPU up */
+int cpu_up(unsigned int cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm3-cpu-iterators/include/linux/smp.h working-2.5.44-mm3-cpu-driverfs/include/linux/smp.h
--- working-2.5.44-mm3-cpu-iterators/include/linux/smp.h	2002-10-23 12:14:58.000000000 +1000
+++ working-2.5.44-mm3-cpu-driverfs/include/linux/smp.h	2002-10-23 12:39:20.000000000 +1000
@@ -70,14 +70,6 @@ extern volatile int smp_msg_id;
 					 */
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
-
-struct notifier_block;
-
-/* Need to know about CPUs going up/down? */
-extern int register_cpu_notifier(struct notifier_block *nb);
-extern void unregister_cpu_notifier(struct notifier_block *nb);
-
-int cpu_up(unsigned int cpu);
 #else /* !SMP */
 
 /*
@@ -101,20 +93,15 @@ static inline void smp_send_reschedule_a
 #define first_possible_cpu()			0
 #define next_possible_cpu(cpu)			NR_CPUS
 
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
 
+/* Need to know about CPUs going up/down? */
+struct notifier_block;
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
+
 #endif /* __LINUX_SMP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm3-cpu-iterators/kernel/Makefile working-2.5.44-mm3-cpu-driverfs/kernel/Makefile
--- working-2.5.44-mm3-cpu-iterators/kernel/Makefile	2002-10-16 15:01:26.000000000 +1000
+++ working-2.5.44-mm3-cpu-driverfs/kernel/Makefile	2002-10-23 12:39:20.000000000 +1000
@@ -4,16 +4,15 @@
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
 		printk.o platform.o suspend.o dma.o module.o cpufreq.o \
-		profile.o rcupdate.o
+		profile.o rcupdate.o cpu.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o \
-	    rcupdate.o
+	    rcupdate.o cpu.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm3-cpu-iterators/kernel/cpu.c working-2.5.44-mm3-cpu-driverfs/kernel/cpu.c
--- working-2.5.44-mm3-cpu-iterators/kernel/cpu.c	2002-10-23 12:03:15.000000000 +1000
+++ working-2.5.44-mm3-cpu-driverfs/kernel/cpu.c	2002-10-23 12:39:20.000000000 +1000
@@ -1,5 +1,5 @@
 /* CPU control.
- * (C) 2001 Rusty Russell
+ * (C) 2001, 2002 Rusty Russell
  * This code is licenced under the GPL.
  */
 #include <linux/proc_fs.h>
@@ -13,6 +13,7 @@
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
+#ifdef CONFIG_SMP
 static struct notifier_block *cpu_chain = NULL;
 
 /* Need to know about CPUs going up/down? */
@@ -64,3 +65,46 @@ out:
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
+#endif /* CONFIG_SMP */
+
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
+	for (i = first_possible_cpu(); i < NR_CPUS; i = next_possible_cpu(i)) {
+		per_cpu(cpu_devices, i).sysdev.id = i;
+		sys_device_register(&per_cpu(cpu_devices, i));
+	}
+	return 0;
+}
+
+__initcall(register_cpus);
+
+EXPORT_SYMBOL_GPL(register_cpu_notifier);
+EXPORT_SYMBOL_GPL(unregister_cpu_notifier);
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
