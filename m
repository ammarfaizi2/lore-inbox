Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVESJjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVESJjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 05:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVESJjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 05:39:24 -0400
Received: from fmr15.intel.com ([192.55.52.69]:47300 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262457AbVESJhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 05:37:40 -0400
Subject: [PATCH 1/2] porting lockless mce from x86_64 to i386
From: Guo Racing <racing.guo@intel.com>
Reply-To: racing.guo@intel.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel Corp.
Message-Id: <1116495351.18666.47.camel@guorj.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 May 2005 17:35:51 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lockless MCE(machine check exception) is ported from
x86-64 to i386. This patch is for preparation.
     1. rename mce.c(i386)
     2. delete k7.c, mce.h(i386), non-fatal.c, p4.c and p6.c
     3. move mce.h from include/asm-x86_64 to arch/x86_64/kernel
 
Signed-off-by: Racing Guo <racing.guo@intel.com>
---

 arch/i386/kernel/cpu/mcheck/init.c      |   77 +++++++++
 arch/i386/kernel/cpu/mcheck/k7.c        |   97 -----------
 arch/i386/kernel/cpu/mcheck/mce.c       |   77 ---------
 arch/i386/kernel/cpu/mcheck/mce.h       |   14 -
 arch/i386/kernel/cpu/mcheck/non-fatal.c |   93 ----------
 arch/i386/kernel/cpu/mcheck/p4.c        |  271 --------------------------------
 arch/i386/kernel/cpu/mcheck/p6.c        |  115 -------------
 arch/x86_64/kernel/mce.h                |   80 +++++++++
 include/asm-x86_64/mce.h                |   80 ---------
 9 files changed, 157 insertions(+), 747 deletions(-)

diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/init.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/init.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/init.c	1970-01-01 08:00:00.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/init.c	2005-05-18 16:57:16.000000000 +0800
@@ -0,0 +1,77 @@
+/*
+ * mce.c - x86 Machine Check Exception Reporting
+ * (c) 2002 Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/thread_info.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+
+#include "mce.h"
+
+int mce_disabled __initdata = 0;
+int nr_mce_banks;
+
+EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
+
+/* Handle unconfigured int18 (should never happen) */
+static fastcall void unexpected_machine_check(struct pt_regs * regs, long error_code)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
+}
+
+/* Call the installed machine check handler for this CPU setup. */
+void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
+
+/* This has to be run for each processor */
+void __init mcheck_init(struct cpuinfo_x86 *c)
+{
+	if (mce_disabled==1)
+		return;
+
+	switch (c->x86_vendor) {
+		case X86_VENDOR_AMD:
+			if (c->x86==6 || c->x86==15)
+				amd_mcheck_init(c);
+			break;
+
+		case X86_VENDOR_INTEL:
+			if (c->x86==5)
+				intel_p5_mcheck_init(c);
+			if (c->x86==6)
+				intel_p6_mcheck_init(c);
+			if (c->x86==15)
+				intel_p4_mcheck_init(c);
+			break;
+
+		case X86_VENDOR_CENTAUR:
+			if (c->x86==5)
+				winchip_mcheck_init(c);
+			break;
+
+		default:
+			break;
+	}
+}
+
+static int __init mcheck_disable(char *str)
+{
+	mce_disabled = 1;
+	return 0;
+}
+
+static int __init mcheck_enable(char *str)
+{
+	mce_disabled = -1;
+	return 0;
+}
+
+__setup("nomce", mcheck_disable);
+__setup("mce", mcheck_enable);
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/k7.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/k7.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/k7.c	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/k7.c	1970-01-01 08:00:00.000000000 +0800
@@ -1,97 +0,0 @@
-/*
- * Athlon/Hammer specific Machine Check Exception Reporting
- * (C) Copyright 2002 Dave Jones <davej@codemonkey.org.uk>
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/config.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-#include <asm/msr.h>
-
-#include "mce.h"
-
-/* Machine Check Handler For AMD Athlon/Duron */
-static fastcall void k7_machine_check(struct pt_regs * regs, long error_code)
-{
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
-		recover=0;
-
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
-	for (i=1; i<nr_mce_banks; i++) {
-		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
-		if (high&(1<<31)) {
-			if (high & (1<<29))
-				recover |= 1;
-			if (high & (1<<25))
-				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
-			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
-			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
-			}
-			printk ("\n");
-			/* Clear it */
-			wrmsr (MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-			/* Serialize */
-			wmb();
-			add_taint(TAINT_MACHINE_CHECK);
-		}
-	}
-
-	if (recover&2)
-		panic ("CPU context corrupt");
-	if (recover&1)
-		panic ("Unable to continue");
-	printk (KERN_EMERG "Attempting to continue.\n");
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
-}
-
-
-/* AMD K7 machine check is Intel like */
-void __init amd_mcheck_init(struct cpuinfo_x86 *c)
-{
-	u32 l, h;
-	int i;
-
-	machine_check_vector = k7_machine_check;
-	wmb();
-
-	printk (KERN_INFO "Intel machine check architecture supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	/* Clear status for MC index 0 separately, we don't touch CTL,
-	 * as some Athlons cause spurious MCEs when its enabled. */
-	wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);
-	for (i=1; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-	}
-
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
-		smp_processor_id());
-}
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/mce.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/mce.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/mce.c	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/mce.c	1970-01-01 08:00:00.000000000 +0800
@@ -1,77 +0,0 @@
-/*
- * mce.c - x86 Machine Check Exception Reporting
- * (c) 2002 Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/smp.h>
-#include <linux/thread_info.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-
-#include "mce.h"
-
-int mce_disabled __initdata = 0;
-int nr_mce_banks;
-
-EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
-
-/* Handle unconfigured int18 (should never happen) */
-static fastcall void unexpected_machine_check(struct pt_regs * regs, long error_code)
-{	
-	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
-}
-
-/* Call the installed machine check handler for this CPU setup. */
-void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
-
-/* This has to be run for each processor */
-void __init mcheck_init(struct cpuinfo_x86 *c)
-{
-	if (mce_disabled==1)
-		return;
-
-	switch (c->x86_vendor) {
-		case X86_VENDOR_AMD:
-			if (c->x86==6 || c->x86==15)
-				amd_mcheck_init(c);
-			break;
-
-		case X86_VENDOR_INTEL:
-			if (c->x86==5)
-				intel_p5_mcheck_init(c);
-			if (c->x86==6)
-				intel_p6_mcheck_init(c);
-			if (c->x86==15)
-				intel_p4_mcheck_init(c);
-			break;
-
-		case X86_VENDOR_CENTAUR:
-			if (c->x86==5)
-				winchip_mcheck_init(c);
-			break;
-
-		default:
-			break;
-	}
-}
-
-static int __init mcheck_disable(char *str)
-{
-	mce_disabled = 1;
-	return 0;
-}
-
-static int __init mcheck_enable(char *str)
-{
-	mce_disabled = -1;
-	return 0;
-}
-
-__setup("nomce", mcheck_disable);
-__setup("mce", mcheck_enable);
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/mce.h 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/mce.h
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/mce.h	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/mce.h	1970-01-01 08:00:00.000000000 +0800
@@ -1,14 +0,0 @@
-#include <linux/init.h>
-
-void amd_mcheck_init(struct cpuinfo_x86 *c);
-void intel_p4_mcheck_init(struct cpuinfo_x86 *c);
-void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
-void intel_p6_mcheck_init(struct cpuinfo_x86 *c);
-void winchip_mcheck_init(struct cpuinfo_x86 *c);
-
-/* Call the installed machine check handler for this CPU setup. */
-extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
-
-extern int mce_disabled __initdata;
-extern int nr_mce_banks;
-
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/non-fatal.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/non-fatal.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/non-fatal.c	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/non-fatal.c	1970-01-01 08:00:00.000000000 +0800
@@ -1,93 +0,0 @@
-/*
- * Non Fatal Machine Check Exception Reporting
- *
- * (C) Copyright 2002 Dave Jones. <davej@codemonkey.org.uk>
- *
- * This file contains routines to check for non-fatal MCEs every 15s
- *
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/config.h>
-#include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-#include <linux/module.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-#include <asm/msr.h>
-
-#include "mce.h"
-
-static int firstbank;
-
-#define MCE_RATE	15*HZ	/* timer rate is 15s */
-
-static void mce_checkregs (void *info)
-{
-	u32 low, high;
-	int i;
-
-	for (i=firstbank; i<nr_mce_banks; i++) {
-		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
-
-		if (high & (1<<31)) {
-			printk(KERN_INFO "MCE: The hardware reports a non "
-				"fatal, correctable incident occurred on "
-				"CPU %d.\n",
-				smp_processor_id());
-			printk (KERN_INFO "Bank %d: %08x%08x\n", i, high, low);
-
-			/* Scrub the error so we don't pick it up in MCE_RATE seconds time. */
-			wrmsr (MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-
-			/* Serialize */
-			wmb();
-			add_taint(TAINT_MACHINE_CHECK);
-		}
-	}
-}
-
-static void mce_work_fn(void *data);
-static DECLARE_WORK(mce_work, mce_work_fn, NULL);
-
-static void mce_work_fn(void *data)
-{ 
-	on_each_cpu(mce_checkregs, NULL, 1, 1);
-	schedule_delayed_work(&mce_work, MCE_RATE);
-} 
-
-static int __init init_nonfatal_mce_checker(void)
-{
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	/* Check for MCE support */
-	if (!cpu_has(c, X86_FEATURE_MCE))
-		return -ENODEV;
-
-	/* Check for PPro style MCA */
-	if (!cpu_has(c, X86_FEATURE_MCA))
-		return -ENODEV;
-
-	/* Some Athlons misbehave when we frob bank 0 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-		boot_cpu_data.x86 == 6)
-			firstbank = 1;
-	else
-			firstbank = 0;
-
-	/*
-	 * Check for non-fatal errors every MCE_RATE s
-	 */
-	schedule_delayed_work(&mce_work, MCE_RATE);
-	printk(KERN_INFO "Machine check exception polling timer started.\n");
-	return 0;
-}
-module_init(init_nonfatal_mce_checker);
-
-MODULE_LICENSE("GPL");
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/p4.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p4.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/p4.c	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p4.c	1970-01-01 08:00:00.000000000 +0800
@@ -1,271 +0,0 @@
-/*
- * P4 specific Machine Check Exception Reporting
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/config.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-#include <asm/msr.h>
-#include <asm/apic.h>
-
-#include "mce.h"
-
-/* as supported by the P4/Xeon family */
-struct intel_mce_extended_msrs {
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u32 esi;
-	u32 edi;
-	u32 ebp;
-	u32 esp;
-	u32 eflags;
-	u32 eip;
-	/* u32 *reserved[]; */
-};
-
-static int mce_num_extended_msrs = 0;
-
-
-#ifdef CONFIG_X86_MCE_P4THERMAL
-static void unexpected_thermal_interrupt(struct pt_regs *regs)
-{	
-	printk(KERN_ERR "CPU%d: Unexpected LVT TMR interrupt!\n",
-			smp_processor_id());
-	add_taint(TAINT_MACHINE_CHECK);
-}
-
-/* P4/Xeon Thermal transition interrupt handler */
-static void intel_thermal_interrupt(struct pt_regs *regs)
-{
-	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-	static unsigned long next[NR_CPUS];
-
-	ack_APIC_irq();
-
-	if (time_after(next[cpu], jiffies))
-		return;
-
-	next[cpu] = jiffies + HZ*5;
-	rdmsr(MSR_IA32_THERM_STATUS, l, h);
-	if (l & 0x1) {
-		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
-		add_taint(TAINT_MACHINE_CHECK);
-	} else {
-		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
-	}
-}
-
-/* Thermal interrupt handler for this CPU setup */
-static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
-
-fastcall void smp_thermal_interrupt(struct pt_regs *regs)
-{
-	irq_enter();
-	vendor_thermal_interrupt(regs);
-	irq_exit();
-}
-
-/* P4/Xeon Thermal regulation detect and init */
-static void __init intel_init_thermal(struct cpuinfo_x86 *c)
-{
-	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-
-	/* Thermal monitoring */
-	if (!cpu_has(c, X86_FEATURE_ACPI))
-		return;	/* -ENODEV */
-
-	/* Clock modulation */
-	if (!cpu_has(c, X86_FEATURE_ACC))
-		return;	/* -ENODEV */
-
-	/* first check if its enabled already, in which case there might
-	 * be some SMM goo which handles it, so we can't even put a handler
-	 * since it might be delivered via SMI already -zwanem.
-	 */
-	rdmsr (MSR_IA32_MISC_ENABLE, l, h);
-	h = apic_read(APIC_LVTTHMR);
-	if ((l & (1<<3)) && (h & APIC_DM_SMI)) {
-		printk(KERN_DEBUG "CPU%d: Thermal monitoring handled by SMI\n",
-				cpu);
-		return; /* -EBUSY */
-	}
-
-	/* check whether a vector already exists, temporarily masked? */	
-	if (h & APIC_VECTOR_MASK) {
-		printk(KERN_DEBUG "CPU%d: Thermal LVT vector (%#x) already "
-				"installed\n",
-			cpu, (h & APIC_VECTOR_MASK));
-		return; /* -EBUSY */
-	}
-
-	/* The temperature transition interrupt handler setup */
-	h = THERMAL_APIC_VECTOR;		/* our delivery vector */
-	h |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
-	apic_write_around(APIC_LVTTHMR, h);
-
-	rdmsr (MSR_IA32_THERM_INTERRUPT, l, h);
-	wrmsr (MSR_IA32_THERM_INTERRUPT, l | 0x03 , h);
-
-	/* ok we're good to go... */
-	vendor_thermal_interrupt = intel_thermal_interrupt;
-	
-	rdmsr (MSR_IA32_MISC_ENABLE, l, h);
-	wrmsr (MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-	
-	l = apic_read (APIC_LVTTHMR);
-	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
-	return;
-}
-#endif /* CONFIG_X86_MCE_P4THERMAL */
-
-
-/* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
-static inline int intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
-{
-	u32 h;
-
-	if (mce_num_extended_msrs == 0)
-		goto done;
-
-	rdmsr (MSR_IA32_MCG_EAX, r->eax, h);
-	rdmsr (MSR_IA32_MCG_EBX, r->ebx, h);
-	rdmsr (MSR_IA32_MCG_ECX, r->ecx, h);
-	rdmsr (MSR_IA32_MCG_EDX, r->edx, h);
-	rdmsr (MSR_IA32_MCG_ESI, r->esi, h);
-	rdmsr (MSR_IA32_MCG_EDI, r->edi, h);
-	rdmsr (MSR_IA32_MCG_EBP, r->ebp, h);
-	rdmsr (MSR_IA32_MCG_ESP, r->esp, h);
-	rdmsr (MSR_IA32_MCG_EFLAGS, r->eflags, h);
-	rdmsr (MSR_IA32_MCG_EIP, r->eip, h);
-
-	/* can we rely on kmalloc to do a dynamic
-	 * allocation for the reserved registers?
-	 */
-done:
-	return mce_num_extended_msrs;
-}
-
-static fastcall void intel_machine_check(struct pt_regs * regs, long error_code)
-{
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-	struct intel_mce_extended_msrs dbg;
-
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
-		recover=0;
-
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
-	if (intel_get_extended_msrs(&dbg)) {
-		printk (KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
-			smp_processor_id(), dbg.eip, dbg.eflags);
-		printk (KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",
-			dbg.eax, dbg.ebx, dbg.ecx, dbg.edx);
-		printk (KERN_DEBUG "\tesi: %08x edi: %08x ebp: %08x esp: %08x\n",
-			dbg.esi, dbg.edi, dbg.ebp, dbg.esp);
-	}
-
-	for (i=0; i<nr_mce_banks; i++) {
-		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
-		if (high & (1<<31)) {
-			if (high & (1<<29))
-				recover |= 1;
-			if (high & (1<<25))
-				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
-			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
-			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
-			}
-			printk ("\n");
-		}
-	}
-
-	if (recover & 2)
-		panic ("CPU context corrupt");
-	if (recover & 1)
-		panic ("Unable to continue");
-
-	printk(KERN_EMERG "Attempting to continue.\n");
-	/* 
-	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
-	 * recoverable/continuable.This will allow BIOS to look at the MSRs
-	 * for errors if the OS could not log the error.
-	 */
-	for (i=0; i<nr_mce_banks; i++) {
-		u32 msr;
-		msr = MSR_IA32_MC0_STATUS+i*4;
-		rdmsr (msr, low, high);
-		if (high&(1<<31)) {
-			/* Clear it */
-			wrmsr(msr, 0UL, 0UL);
-			/* Serialize */
-			wmb();
-			add_taint(TAINT_MACHINE_CHECK);
-		}
-	}
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
-}
-
-
-void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
-{
-	u32 l, h;
-	int i;
-	
-	machine_check_vector = intel_machine_check;
-	wmb();
-
-	printk (KERN_INFO "Intel machine check architecture supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	for (i=0; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-	}
-
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
-		smp_processor_id());
-
-	/* Check for P4/Xeon extended MCE MSRs */
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<9))	{/* MCG_EXT_P */
-		mce_num_extended_msrs = (l >> 16) & 0xff;
-		printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended MCE MSRs (%d)"
-				" available\n",
-			smp_processor_id(), mce_num_extended_msrs);
-
-#ifdef CONFIG_X86_MCE_P4THERMAL
-		/* Check for P4/Xeon Thermal monitor */
-		intel_init_thermal(c);
-#endif
-	}
-}
diff -rNu 2.6.11.10/arch/i386/kernel/cpu/mcheck/p6.c 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p6.c
--- 2.6.11.10/arch/i386/kernel/cpu/mcheck/p6.c	2005-05-17 01:50:30.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/i386/kernel/cpu/mcheck/p6.c	1970-01-01 08:00:00.000000000 +0800
@@ -1,115 +0,0 @@
-/*
- * P6 specific Machine Check Exception Reporting
- * (C) Copyright 2002 Alan Cox <alan@redhat.com>
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-#include <asm/msr.h>
-
-#include "mce.h"
-
-/* Machine Check Handler For PII/PIII */
-static fastcall void intel_machine_check(struct pt_regs * regs, long error_code)
-{
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
-		recover=0;
-
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
-	for (i=0; i<nr_mce_banks; i++) {
-		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
-		if (high & (1<<31)) {
-			if (high & (1<<29))
-				recover |= 1;
-			if (high & (1<<25))
-				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
-			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
-			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
-			}
-			printk ("\n");
-		}
-	}
-
-	if (recover & 2)
-		panic ("CPU context corrupt");
-	if (recover & 1)
-		panic ("Unable to continue");
-
-	printk (KERN_EMERG "Attempting to continue.\n");
-	/* 
-	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
-	 * recoverable/continuable.This will allow BIOS to look at the MSRs
-	 * for errors if the OS could not log the error.
-	 */
-	for (i=0; i<nr_mce_banks; i++) {
-		unsigned int msr;
-		msr = MSR_IA32_MC0_STATUS+i*4;
-		rdmsr (msr,low, high);
-		if (high & (1<<31)) {
-			/* Clear it */
-			wrmsr (msr, 0UL, 0UL);
-			/* Serialize */
-			wmb();
-			add_taint(TAINT_MACHINE_CHECK);
-		}
-	}
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
-}
-
-/* Set up machine check reporting for processors with Intel style MCE */
-void __init intel_p6_mcheck_init(struct cpuinfo_x86 *c)
-{
-	u32 l, h;
-	int i;
-	
-	/* Check for MCE support */
-	if (!cpu_has(c, X86_FEATURE_MCE))
-		return;
-
-	/* Check for PPro style MCA */
- 	if (!cpu_has(c, X86_FEATURE_MCA))
-		return;
-
-	/* Ok machine check is available */
-	machine_check_vector = intel_machine_check;
-	wmb();
-
-	printk (KERN_INFO "Intel machine check architecture supported.\n");
-	rdmsr (MSR_IA32_MCG_CAP, l, h);
-	if (l & (1<<8))	/* Control register present ? */
-		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	nr_mce_banks = l & 0xff;
-
-	/* Don't enable bank 0 on intel P6 cores, it goes bang quickly. */
-	for (i=1; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-	}
-
-	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
-		smp_processor_id());
-}
diff -rNu 2.6.11.10/arch/x86_64/kernel/mce.h 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.h
--- 2.6.11.10/arch/x86_64/kernel/mce.h	1970-01-01 08:00:00.000000000 +0800
+++ 2.6.11.10-mce-prep/arch/x86_64/kernel/mce.h	2005-05-18 16:57:39.000000000 +0800
@@ -0,0 +1,80 @@
+#ifndef _ASM_MCE_H
+#define _ASM_MCE_H 1
+
+#include <asm/ioctls.h>
+#include <asm/types.h>
+
+/* 
+ * Machine Check support for x86
+ */
+
+#define MCG_CTL_P        (1UL<<8)   /* MCG_CAP register available */
+
+#define MCG_STATUS_RIPV  (1UL<<0)   /* restart ip valid */
+#define MCG_STATUS_EIPV  (1UL<<1)   /* eip points to correct instruction */
+#define MCG_STATUS_MCIP  (1UL<<2)   /* machine check in progress */
+
+#define MCI_STATUS_VAL   (1UL<<63)  /* valid error */
+#define MCI_STATUS_OVER  (1UL<<62)  /* previous errors lost */
+#define MCI_STATUS_UC    (1UL<<61)  /* uncorrected error */
+#define MCI_STATUS_EN    (1UL<<60)  /* error enabled */
+#define MCI_STATUS_MISCV (1UL<<59)  /* misc error reg. valid */
+#define MCI_STATUS_ADDRV (1UL<<58)  /* addr reg. valid */
+#define MCI_STATUS_PCC   (1UL<<57)  /* processor context corrupt */
+
+/* Fields are zero when not available */
+struct mce {
+	__u64 status;
+	__u64 misc;
+	__u64 addr;
+	__u64 mcgstatus;
+	__u64 rip;	
+	__u64 tsc;	/* cpu time stamp counter */
+	__u64 res1;	/* for future extension */	
+	__u64 res2;	/* dito. */
+	__u8  cs;		/* code segment */
+	__u8  bank;	/* machine check bank */
+	__u8  cpu;	/* cpu that raised the error */
+	__u8  finished;   /* entry is valid */
+	__u32 pad;   
+};
+
+/* 
+ * This structure contains all data related to the MCE log.
+ * Also carries a signature to make it easier to find from external debugging tools.
+ * Each entry is only valid when its finished flag is set.
+ */
+
+#define MCE_LOG_LEN 32
+
+struct mce_log { 
+	char signature[12]; /* "MACHINECHECK" */ 
+	unsigned len;  	    /* = MCE_LOG_LEN */ 
+	unsigned next;
+	unsigned flags;
+	unsigned pad0; 
+	struct mce entry[MCE_LOG_LEN];
+};
+
+#define MCE_OVERFLOW 0		/* bit 0 in flags means overflow */
+
+#define MCE_LOG_SIGNATURE 	"MACHINECHECK"
+
+#define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
+#define MCE_GET_LOG_LEN      _IOR('M', 2, int)
+#define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
+
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
+#endif
diff -rNu 2.6.11.10/include/asm-x86_64/mce.h 2.6.11.10-mce-prep/include/asm-x86_64/mce.h
--- 2.6.11.10/include/asm-x86_64/mce.h	2005-05-17 01:51:39.000000000 +0800
+++ 2.6.11.10-mce-prep/include/asm-x86_64/mce.h	1970-01-01 08:00:00.000000000 +0800
@@ -1,80 +0,0 @@
-#ifndef _ASM_MCE_H
-#define _ASM_MCE_H 1
-
-#include <asm/ioctls.h>
-#include <asm/types.h>
-
-/* 
- * Machine Check support for x86
- */
-
-#define MCG_CTL_P        (1UL<<8)   /* MCG_CAP register available */
-
-#define MCG_STATUS_RIPV  (1UL<<0)   /* restart ip valid */
-#define MCG_STATUS_EIPV  (1UL<<1)   /* eip points to correct instruction */
-#define MCG_STATUS_MCIP  (1UL<<2)   /* machine check in progress */
-
-#define MCI_STATUS_VAL   (1UL<<63)  /* valid error */
-#define MCI_STATUS_OVER  (1UL<<62)  /* previous errors lost */
-#define MCI_STATUS_UC    (1UL<<61)  /* uncorrected error */
-#define MCI_STATUS_EN    (1UL<<60)  /* error enabled */
-#define MCI_STATUS_MISCV (1UL<<59)  /* misc error reg. valid */
-#define MCI_STATUS_ADDRV (1UL<<58)  /* addr reg. valid */
-#define MCI_STATUS_PCC   (1UL<<57)  /* processor context corrupt */
-
-/* Fields are zero when not available */
-struct mce {
-	__u64 status;
-	__u64 misc;
-	__u64 addr;
-	__u64 mcgstatus;
-	__u64 rip;	
-	__u64 tsc;	/* cpu time stamp counter */
-	__u64 res1;	/* for future extension */	
-	__u64 res2;	/* dito. */
-	__u8  cs;		/* code segment */
-	__u8  bank;	/* machine check bank */
-	__u8  cpu;	/* cpu that raised the error */
-	__u8  finished;   /* entry is valid */
-	__u32 pad;   
-};
-
-/* 
- * This structure contains all data related to the MCE log.
- * Also carries a signature to make it easier to find from external debugging tools.
- * Each entry is only valid when its finished flag is set.
- */
-
-#define MCE_LOG_LEN 32
-
-struct mce_log { 
-	char signature[12]; /* "MACHINECHECK" */ 
-	unsigned len;  	    /* = MCE_LOG_LEN */ 
-	unsigned next;
-	unsigned flags;
-	unsigned pad0; 
-	struct mce entry[MCE_LOG_LEN];
-};
-
-#define MCE_OVERFLOW 0		/* bit 0 in flags means overflow */
-
-#define MCE_LOG_SIGNATURE 	"MACHINECHECK"
-
-#define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
-#define MCE_GET_LOG_LEN      _IOR('M', 2, int)
-#define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
-
-/* Software defined banks */
-#define MCE_EXTENDED_BANK	128
-#define MCE_THERMAL_BANK	MCE_EXTENDED_BANK + 0
-
-void mce_log(struct mce *m);
-#ifdef CONFIG_X86_MCE_INTEL
-void mce_intel_feature_init(struct cpuinfo_x86 *c);
-#else
-static inline void mce_intel_feature_init(struct cpuinfo_x86 *c)
-{
-}
-#endif
-
-#endif



