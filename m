Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKMSi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKMSi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKMSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 13:38:26 -0500
Received: from fsmlabs.com ([168.103.115.128]:11394 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261155AbUKMShC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 13:37:02 -0500
Date: Sat, 13 Nov 2004 11:36:47 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Intel thermal monitor for x86_64
Message-ID: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, Andrew,

Patch adds support for notification of overheating conditions on intel 
x86_64 processors. Tested on EM64T, test booted on AMD64.

Hardware courtesy of Intel Corporation

 arch/x86_64/Kconfig            |    7 ++
 arch/x86_64/kernel/Makefile    |    1
 arch/x86_64/kernel/entry.S     |    5 +
 arch/x86_64/kernel/i8259.c     |    7 ++
 arch/x86_64/kernel/mce.c       |   12 ++++
 arch/x86_64/kernel/mce_intel.c |  116 +++++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/mce.h       |    8 ++
 7 files changed, 155 insertions(+), 1 deletion(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.h
--- linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	11 Nov 2004 17:21:48 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	13 Nov 2004 13:43:39 -0000
@@ -64,4 +64,12 @@ struct mce_log { 
 #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
 #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
 
+#ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_feature_init(struct cpuinfo_x86 *c);
+#else
+static inline void mce_intel_feature_init(struct cpuinfo_x86 *c)
+{
+}
+#endif
+
 #endif
Index: linux-2.6.10-rc1-mm5/arch/x86_64/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.10-rc1-mm5/arch/x86_64/Kconfig	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/Kconfig	13 Nov 2004 12:57:35 -0000
@@ -352,6 +352,13 @@ config X86_MCE
 	   machine check error logs. See
 	   ftp://ftp.x86-64.org/pub/linux/tools/mcelog
 
+config X86_MCE_INTEL
+	bool "Intel MCE features"
+	depends on X86_MCE
+	default y
+	help
+	   Additional support for intel specific MCE features such as
+	   the thermal monitor.
 endmenu
 
 #
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/Makefile	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/Makefile	13 Nov 2004 12:55:31 -0000
@@ -10,6 +10,7 @@ obj-y	:= process.o semaphore.o signal.o 
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o quirks.o
 
 obj-$(CONFIG_X86_MCE)         += mce.o
+obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
 obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_MSR)		+= msr.o
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/entry.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/entry.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 entry.S
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/entry.S	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/entry.S	13 Nov 2004 13:02:11 -0000
@@ -565,6 +565,11 @@ ENTRY(perfctr_interrupt)
 	apicinterrupt LOCAL_PERFCTR_VECTOR,smp_perfctr_interrupt
 #endif
 
+#if defined(CONFIG_X86_MCE_INTEL)
+ENTRY(thermal_interrupt)
+	apicinterrupt THERMAL_APIC_VECTOR,smp_thermal_interrupt
+#endif
+
 /*
  * Exception entry points.
  */ 		
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c	13 Nov 2004 14:21:59 -0000
@@ -491,6 +491,7 @@ void error_interrupt(void);
 void reschedule_interrupt(void);
 void call_function_interrupt(void);
 void invalidate_interrupt(void);
+void thermal_interrupt(void);
 
 static void setup_timer(void)
 {
@@ -543,8 +544,12 @@ void __init init_IRQ(void)
 			break;
 		if (vector != IA32_SYSCALL_VECTOR && vector != KDB_VECTOR) { 
 			set_intr_gate(vector, interrupt[i]);
+		}
 	}
-	}
+
+#ifdef CONFIG_X86_MCE_INTEL
+        set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
+#endif
 
 #ifdef CONFIG_SMP
 	/*
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.c
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c	13 Nov 2004 13:45:04 -0000
@@ -305,6 +305,17 @@ static void __init mce_cpu_quirks(struct
 	}
 }			
 
+static void __init mce_cpu_features(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_feature_init(c);
+		break;
+	default:
+		break;
+	}
+}
+
 /* 
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off. 
@@ -321,6 +332,7 @@ void __init mcheck_init(struct cpuinfo_x
 		return;
 
 	mce_init(NULL);
+	mce_cpu_features(c);
 }
 
 /*
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce_intel.c
===================================================================
RCS file: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce_intel.c
diff -N linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce_intel.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce_intel.c	13 Nov 2004 13:59:31 -0000
@@ -0,0 +1,116 @@
+/*
+ * Intel specific MCE features.
+ * Copyright 2004 Zwane Mwaikambo <zwane@linuxpower.ca>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/processor.h>
+#include <asm/msr.h>
+#include <asm/mce.h>
+#include <asm/hw_irq.h>
+
+static cpumask_t cpu_thermal_status;
+static unsigned long next_thermal_check;
+
+static void intel_thermal_check(unsigned long data)
+{
+	static cpumask_t log;
+	int cpu;
+
+	next_thermal_check = jiffies + HZ * 10;
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cpu_thermal_status)) {
+			if (cpu_isset(cpu, log))
+				continue;
+
+			printk(KERN_EMERG
+			       "CPU%d: Temperature above threshold, cpu clock throttled\n",
+			       cpu);
+			cpu_set(cpu, log);
+		} else if (cpu_isset(cpu, log)) {
+			printk(KERN_INFO
+			       "CPU%d: Temperature/speed normal\n", cpu);
+			cpu_clear(cpu, log);
+		}
+	}
+}
+
+static DECLARE_TASKLET(thermal_tasklet, intel_thermal_check, 0);
+
+asmlinkage void smp_thermal_interrupt(void)
+{
+	u64 status;
+
+	ack_APIC_irq();
+
+	irq_enter();
+	rdmsrl(MSR_IA32_THERM_STATUS, status);
+	if (status & 0x1) {
+		cpu_set(smp_processor_id(), cpu_thermal_status);
+		add_taint(TAINT_MACHINE_CHECK);
+	} else {
+		cpu_clear(smp_processor_id(), cpu_thermal_status);
+	}
+
+	if (time_after(jiffies, next_thermal_check))
+		tasklet_schedule(&thermal_tasklet);
+
+	irq_exit();
+}
+
+static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	int tm2 = 0;
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpu_has(c, X86_FEATURE_ACPI))
+		return;
+
+	if (!cpu_has(c, X86_FEATURE_ACC))
+		return;
+
+	/* first check if TM1 is already enabled by the BIOS, in which
+	 * case there might be some SMM goo which handles it, so we can't even
+	 * put a handler since it might be delivered via SMI already -zwanem.
+	 */
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	h = apic_read(APIC_LVTTHMR);
+	if ((l & (1 << 3)) && (h & APIC_DM_SMI)) {
+		printk(KERN_DEBUG
+		       "CPU%d: Thermal monitoring handled by SMI\n", cpu);
+		return;
+	}
+
+	if (cpu_has(c, X86_FEATURE_TM2) && (l & (1 << 13)))
+		tm2 = 1;
+
+	if (h & APIC_VECTOR_MASK) {
+		printk(KERN_DEBUG
+		       "CPU%d: Thermal LVT vector (%#x) already "
+		       "installed\n", cpu, (h & APIC_VECTOR_MASK));
+		return;
+	}
+
+	h = THERMAL_APIC_VECTOR;
+	h |= (APIC_DM_FIXED | APIC_LVT_MASKED);
+	apic_write_around(APIC_LVTTHMR, h);
+
+	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
+	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x03, h);
+
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	wrmsr(MSR_IA32_MISC_ENABLE, l | (1 << 3), h);
+
+	l = apic_read(APIC_LVTTHMR);
+	apic_write_around(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+	printk(KERN_INFO "CPU%d: Thermal monitoring enabled (%s)\n",
+		cpu, tm2 ? "TM2" : "TM1");
+	return;
+}
+
+void __init mce_intel_feature_init(struct cpuinfo_x86 *c)
+{
+	intel_init_thermal(c);
+}
