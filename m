Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJ1DBT>; Sun, 27 Oct 2002 22:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJ1DBT>; Sun, 27 Oct 2002 22:01:19 -0500
Received: from dp.samba.org ([66.70.73.150]:37834 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262815AbSJ1DBN>;
	Sun, 27 Oct 2002 22:01:13 -0500
Date: Mon, 28 Oct 2002 14:05:11 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: colpatch@us.ibm.com
Cc: mochel@osdl.org, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       mjbligh@us.ibm.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
Message-Id: <20021028140511.115b3bf8.rusty@rustcorp.com.au>
In-Reply-To: <3DB476A1.3090307@us.ibm.com>
References: <Pine.LNX.4.44.0210211447110.983-100000@cherise.pdx.osdl.net>
	<3DB476A1.3090307@us.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002 14:50:25 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:

> [ patch ]

This clashes with my "move cpu driverfs to generic code" patch.

See below,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Name: Put cpus in driverfs for all architectures
Author: Rusty Russell
Status: Trivial

D: Moves registering of cpus from arch/i386/kernel/cpu/common.c into
D: kernel/cpu.c, makes it use per-cpu variables, and makes
D: kernel/cpu.c compiled even on non-SMP (as the entry must exist even
D: for UP).  This allows some UP stubs to be removed from smp.h into
D: kernel/cpu.c, too.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/arch/i386/kernel/cpu/common.c .21228-linux-2.5.44-mm3.updated/arch/i386/kernel/cpu/common.c
--- .21228-linux-2.5.44-mm3/arch/i386/kernel/cpu/common.c	2002-10-15 15:19:37.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/arch/i386/kernel/cpu/common.c	2002-10-23 19:06:22.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/include/linux/cpu.h .21228-linux-2.5.44-mm3.updated/include/linux/cpu.h
--- .21228-linux-2.5.44-mm3/include/linux/cpu.h	2002-10-15 15:19:44.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/include/linux/cpu.h	2002-10-23 19:06:22.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/include/linux/smp.h .21228-linux-2.5.44-mm3.updated/include/linux/smp.h
--- .21228-linux-2.5.44-mm3/include/linux/smp.h	2002-10-23 19:05:55.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/include/linux/smp.h	2002-10-23 19:07:28.000000000 +1000
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
@@ -101,16 +93,6 @@ static inline void smp_send_reschedule_a
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
 
 #define for_each_possible_cpu(var)		\
@@ -127,4 +109,9 @@ static inline void unregister_cpu_notifi
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
 
+/* Need to know about CPUs going up/down? */
+struct notifier_block;
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
+
 #endif /* __LINUX_SMP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/init/main.c .21228-linux-2.5.44-mm3.updated/init/main.c
--- .21228-linux-2.5.44-mm3/init/main.c	2002-10-23 12:03:15.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/init/main.c	2002-10-23 19:06:22.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/workqueue.h>
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
+#include <linux/cpu.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/kernel/Makefile .21228-linux-2.5.44-mm3.updated/kernel/Makefile
--- .21228-linux-2.5.44-mm3/kernel/Makefile	2002-10-16 15:01:26.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/kernel/Makefile	2002-10-23 19:06:22.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21228-linux-2.5.44-mm3/kernel/cpu.c .21228-linux-2.5.44-mm3.updated/kernel/cpu.c
--- .21228-linux-2.5.44-mm3/kernel/cpu.c	2002-10-23 12:03:15.000000000 +1000
+++ .21228-linux-2.5.44-mm3.updated/kernel/cpu.c	2002-10-23 19:06:22.000000000 +1000
@@ -1,5 +1,5 @@
 /* CPU control.
- * (C) 2001 Rusty Russell
+ * (C) 2001, 2002 Rusty Russell
  * This code is licenced under the GPL.
  */
 #include <linux/proc_fs.h>
@@ -8,11 +8,14 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
+#ifdef CONFIG_SMP
 static struct notifier_block *cpu_chain = NULL;
 
 /* Need to know about CPUs going up/down? */
@@ -64,3 +67,48 @@ out:
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
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		per_cpu(cpu_devices, i).sysdev.id = i;
+		sys_device_register(&per_cpu(cpu_devices, i).sysdev);
+	}
+	return 0;
+}
+
+__initcall(register_cpus);
+
+EXPORT_SYMBOL_GPL(register_cpu_notifier);
+EXPORT_SYMBOL_GPL(unregister_cpu_notifier);
