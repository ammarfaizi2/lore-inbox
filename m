Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUKSPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUKSPvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKSPvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:51:53 -0500
Received: from fsmlabs.com ([168.103.115.128]:41406 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261444AbUKSPvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:51:23 -0500
Date: Fri, 19 Nov 2004 08:51:04 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64 (updated)
In-Reply-To: <Pine.LNX.4.61.0411181457260.7988@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0411190844120.7201@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com>
 <20041118163309.GK17532@wotan.suse.de> <Pine.LNX.4.61.0411181053410.4034@musoma.fsmlabs.com>
 <20041118200143.GP17532@wotan.suse.de> <Pine.LNX.4.61.0411181457260.7988@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Andi,

This updated patch adds support for notification of overheating conditions
on intel x86_64 processors and incorporates suggestions from Andi. Tested
on EM64T and test booted on AMD64.

Hardware courtesy of Intel Corporation

Andrew please backout the current patch and apply this one (verified it
applies against -bk), if you'd prefer an incremental let me know.

Thanks.

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

 arch/x86_64/Kconfig            |    7 ++
 arch/x86_64/kernel/Makefile    |    1
 arch/x86_64/kernel/entry.S     |    3 +
 arch/x86_64/kernel/i8259.c     |    2
 arch/x86_64/kernel/mce.c       |   14 +++++
 arch/x86_64/kernel/mce_intel.c |   99 +++++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/traps.c     |    4 +
 include/asm-x86_64/mce.h       |   13 +++++
 8 files changed, 142 insertions(+), 1 deletion(-)

Index: linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.h
--- linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	11 Nov 2004 17:21:48 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	19 Nov 2004 02:28:11 -0000
@@ -64,4 +64,17 @@ struct mce_log { 
 #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
 #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
 
+/* Software defined banks */
+#define MCE_EXTENDED_BANK	128
+#define MCE_THERMAL_BANK	MCE_EXTENDED_BANK + 0
+
+void mce_log(struct mce *m);
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
+++ linux-2.6.10-rc1-mm5/arch/x86_64/Kconfig	18 Nov 2004 13:27:10 -0000
@@ -352,6 +352,13 @@ config X86_MCE
 	   machine check error logs. See
 	   ftp://ftp.x86-64.org/pub/linux/tools/mcelog
 
+config X86_MCE_INTEL
+	bool "Intel MCE features"
+	depends on X86_MCE && X86_LOCAL_APIC
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
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/entry.S	18 Nov 2004 14:02:46 -0000
@@ -538,6 +538,9 @@ retint_kernel:	
 	CFI_ENDPROC
 	.endm
 
+ENTRY(thermal_interrupt)
+	apicinterrupt THERMAL_APIC_VECTOR,smp_thermal_interrupt
+
 #ifdef CONFIG_SMP	
 ENTRY(reschedule_interrupt)
 	apicinterrupt RESCHEDULE_VECTOR,smp_reschedule_interrupt
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/i8259.c	18 Nov 2004 14:09:14 -0000
@@ -491,6 +491,7 @@ void error_interrupt(void);
 void reschedule_interrupt(void);
 void call_function_interrupt(void);
 void invalidate_interrupt(void);
+void thermal_interrupt(void);
 
 static void setup_timer(void)
 {
@@ -565,6 +566,7 @@ void __init init_IRQ(void)
 	/* IPI for generic function call */
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
 #endif	
+	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/* self generated IPI for local APIC timer */
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.c
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce.c	18 Nov 2004 14:18:52 -0000
@@ -43,7 +43,7 @@ struct mce_log mcelog = { 
 	MCE_LOG_LEN,
 }; 
 
-static void mce_log(struct mce *mce)
+void mce_log(struct mce *mce)
 {
 	unsigned next, entry;
 	mce->finished = 0;
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
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/mce_intel.c	19 Nov 2004 02:29:11 -0000
@@ -0,0 +1,99 @@
+/*
+ * Intel specific MCE features.
+ * Copyright 2004 Zwane Mwaikambo <zwane@linuxpower.ca>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <asm/processor.h>
+#include <asm/msr.h>
+#include <asm/mce.h>
+#include <asm/hw_irq.h>
+
+static DEFINE_PER_CPU(unsigned long, next_check);
+
+asmlinkage void smp_thermal_interrupt(void)
+{
+	struct mce m;
+
+	ack_APIC_irq();
+
+	irq_enter();
+	if (time_before(jiffies, __get_cpu_var(next_check)))
+		goto done;
+
+	__get_cpu_var(next_check) = jiffies + HZ*300;
+	memset(&m, 0, sizeof(m));
+	m.cpu = smp_processor_id();
+	m.bank = MCE_THERMAL_BANK;
+	rdtscll(m.tsc);
+	rdmsrl(MSR_IA32_THERM_STATUS, m.status);
+	if (m.status & 0x1) {
+		printk(KERN_EMERG
+			"CPU%d: Temperature above threshold, cpu clock throttled\n", m.cpu);
+		add_taint(TAINT_MACHINE_CHECK);
+	} else {
+		printk(KERN_EMERG "CPU%d: Temperature/speed normal\n", m.cpu);
+	}
+
+	mce_log(&m);
+done:
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
+	 * put a handler since it might be delivered via SMI already.
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
Index: linux-2.6.10-rc1-mm5/arch/x86_64/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/x86_64/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.10-rc1-mm5/arch/x86_64/kernel/traps.c	11 Nov 2004 17:24:12 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/x86_64/kernel/traps.c	18 Nov 2004 14:09:39 -0000
@@ -885,6 +885,10 @@ asmlinkage void do_spurious_interrupt_bu
 {
 }
 
+asmlinkage void __attribute__((weak)) smp_thermal_interrupt(void)
+{
+}
+
 /*
  *  'math_state_restore()' saves the current math information in the
  * old math state array, and gets the new ones from the current task
