Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966146AbWKNQJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146AbWKNQJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966140AbWKNQJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:30 -0500
Received: from mx1.suse.de ([195.135.220.2]:11919 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933449AbWKNQJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:00 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [8/9] x86_64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled
Message-Id: <20061114160858.EB43E13C98@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The vgetcpu per CPU initialization previously relied on CPU hotplug
events for all CPUs to initialize the per CPU state. That only
worked only on kernels with CONFIG_HOTPLUG_CPU enabled.  On the
others some CPUs didn't get their state initialized properly
and vgetcpu wouldn't work.

Change the initialization sequence to instead run in a normal
initcall (which runs after the normal CPU bootup) and initialize
all running CPUs there. Later hotplug CPUs are still handled
with an hotplug notifier. 

This actually simplifies the code somewhat.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/smp.c      |    3 --
 arch/x86_64/kernel/time.c     |   11 ----------
 arch/x86_64/kernel/vsyscall.c |   45 +++++++++++++++++++++++-------------------
 include/asm-x86_64/vsyscall.h |    2 -
 4 files changed, 26 insertions(+), 35 deletions(-)

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -27,6 +27,9 @@
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
 #include <linux/getcpu.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/notifier.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -243,32 +246,17 @@ static ctl_table kernel_root_table2[] = 
 
 #endif
 
-static void __cpuinit write_rdtscp_cb(void *info)
-{
-	write_rdtscp_aux((unsigned long)info);
-}
-
-void __cpuinit vsyscall_set_cpu(int cpu)
+/* Assume __initcall executes before all user space. Hopefully kmod
+   doesn't violate that. We'll find out if it does. */
+static void __cpuinit vsyscall_set_cpu(int cpu)
 {
 	unsigned long *d;
 	unsigned long node = 0;
 #ifdef CONFIG_NUMA
 	node = cpu_to_node[cpu];
 #endif
-	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
-		void *info = (void *)((node << 12) | cpu);
-		/* Can happen on preemptive kernel */
-		if (get_cpu() == cpu)
-			write_rdtscp_cb(info);
-#ifdef CONFIG_SMP
-		else {
-			/* the notifier is unfortunately not executed on the
-			   target CPU */
-			smp_call_function_single(cpu,write_rdtscp_cb,info,0,1);
-		}
-#endif
-		put_cpu();
-	}
+	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP))
+		write_rdtscp_aux((node << 12) | cpu);
 
 	/* Store cpu number in limit so that it can be loaded quickly
 	   in user space in vgetcpu.
@@ -280,6 +268,21 @@ void __cpuinit vsyscall_set_cpu(int cpu)
 	*d |= (node >> 4) << 48;
 }
 
+static void __cpuinit cpu_vsyscall_init(void *arg)
+{
+	/* preemption should be already off */
+	vsyscall_set_cpu(raw_smp_processor_id());
+}
+
+static int __cpuinit
+cpu_vsyscall_notifier(struct notifier_block *n, unsigned long action, void *arg)
+{
+	long cpu = (long)arg;
+	if (action == CPU_ONLINE)
+		smp_call_function_single(cpu, cpu_vsyscall_init, NULL, 0, 1);
+	return NOTIFY_DONE;
+}
+
 static void __init map_vsyscall(void)
 {
 	extern char __vsyscall_0;
@@ -299,6 +302,8 @@ static int __init vsyscall_init(void)
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
+	on_each_cpu(cpu_vsyscall_init, NULL, 0, 1);
+	hotcpu_notifier(cpu_vsyscall_notifier, 0);
 	return 0;
 }
 
Index: linux/include/asm-x86_64/vsyscall.h
===================================================================
--- linux.orig/include/asm-x86_64/vsyscall.h
+++ linux/include/asm-x86_64/vsyscall.h
@@ -59,8 +59,6 @@ extern seqlock_t xtime_lock;
 
 extern int sysctl_vsyscall;
 
-extern void vsyscall_set_cpu(int cpu);
-
 #define ARCH_HAVE_XTIME_LOCK 1
 
 #endif /* __KERNEL__ */
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -876,15 +876,6 @@ static struct irqaction irq0 = {
 	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
-static int __cpuinit
-time_cpu_notifier(struct notifier_block *nb, unsigned long action, void *hcpu)
-{
-	unsigned cpu = (unsigned long) hcpu;
-	if (action == CPU_ONLINE)
-		vsyscall_set_cpu(cpu);
-	return NOTIFY_DONE;
-}
-
 void __init time_init(void)
 {
 	if (nohpet)
@@ -925,8 +916,6 @@ void __init time_init(void)
 	vxtime.last_tsc = get_cycles_sync();
 	set_cyc2ns_scale(cpu_khz);
 	setup_irq(0, &irq0);
-	hotcpu_notifier(time_cpu_notifier, 0);
-	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
 
 #ifndef CONFIG_SMP
 	time_init_gtod();
Index: linux/arch/x86_64/kernel/smp.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smp.c
+++ linux/arch/x86_64/kernel/smp.c
@@ -376,9 +376,8 @@ int smp_call_function_single (int cpu, v
 	/* prevent preemption and reschedule on another processor */
 	int me = get_cpu();
 	if (cpu == me) {
-		WARN_ON(1);
 		put_cpu();
-		return -EBUSY;
+		return 0;
 	}
 	spin_lock_bh(&call_lock);
 	__smp_call_function_single(cpu, func, info, nonatomic, wait);
