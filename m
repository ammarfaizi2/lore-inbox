Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSJZMiA>; Sat, 26 Oct 2002 08:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSJZMhS>; Sat, 26 Oct 2002 08:37:18 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7585 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262126AbSJZMec>;
	Sat, 26 Oct 2002 08:34:32 -0400
Date: Sat, 26 Oct 2002 13:42:28 +0100
Message-Id: <200210261242.g9QCgS18030292@noodles.internal>
To: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Cc: alan@redhat.com
Subject: [PATCH] x86 machine check architecture cleanup.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Splits up into seperate files per implementation, and
moved to the arch/i386/kernel/cpu/mcheck/ directory.

Feedback of this from users of various Pentiums,
Athlon/Durons and IDT Winchips would be useful.
It seems to survive minimal testing here on my P4.

With the cpu/ dir starting to fill up, I'm wondering if
it should be moved out of kernel/ up one dir to
arch/i386/cpu. Any comments ?

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/config.in linux-2.5/arch/i386/config.in
--- bk-linus/arch/i386/config.in	2002-10-20 20:21:18.000000000 -0100
+++ linux-2.5/arch/i386/config.in	2002-10-25 18:02:30.000000000 -0100
@@ -188,8 +193,12 @@ else
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
-dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
-dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
+dep_bool '  Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
+if [ "$CONFIG_SMP" = "y" ]; then
+    dep_bool '  Check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE
+else
+    dep_bool '  Check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
+fi
 
 bool 'CPU Frequency scaling' CONFIG_CPU_FREQ
 if [ "$CONFIG_CPU_FREQ" = "y" ]; then
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/Makefile linux-2.5/arch/i386/kernel/Makefile
--- bk-linus/arch/i386/kernel/Makefile	2002-10-20 20:21:20.000000000 -0100
+++ linux-2.5/arch/i386/kernel/Makefile	2002-10-25 18:02:30.000000000 -0100
@@ -8,9 +8,8 @@ export-objs     := mca.o i386_ksyms.o ti
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/bluesmoke.c linux-2.5/arch/i386/kernel/bluesmoke.c
--- bk-linus/arch/i386/kernel/bluesmoke.c	2002-10-20 20:21:20.000000000 -0100
+++ linux-2.5/arch/i386/kernel/bluesmoke.c	1969-12-31 23:00:00.000000000 -0100
@@ -1,504 +0,0 @@
-/*
- * arch/i386/kernel/bluesmoke.c - x86 Machine Check Exception Reporting
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/smp.h>
-#include <linux/config.h>
-#include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-
-#include <asm/processor.h> 
-#include <asm/system.h>
-#include <asm/msr.h>
-#include <asm/apic.h>
-#include <asm/pgtable.h>
-#include <asm/tlbflush.h>
-#include <asm/hardirq.h>
-
-#ifdef CONFIG_X86_MCE
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
-static int mce_disabled __initdata = 0;
-
-static int mce_num_extended_msrs = 0;
-static int banks;
-
-
-#ifdef CONFIG_X86_MCE_P4THERMAL
-/*
- *	P4/Xeon Thermal transition interrupt handler
- */
-
-static void intel_thermal_interrupt(struct pt_regs *regs)
-{
-	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-
-	ack_APIC_irq();
-
-	rdmsr(MSR_IA32_THERM_STATUS, l, h);
-	if (l & 1) {
-		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
-	} else {
-		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
-	}
-}
-
-static void unexpected_thermal_interrupt(struct pt_regs *regs)
-{	
-	printk(KERN_ERR "CPU#%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
-}
-
-/*
- *	Thermal interrupt handler for this CPU setup
- */
-
-static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
-
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
-{
-	irq_enter();
-	vendor_thermal_interrupt(&regs);
-	irq_exit();
-}
-
-/* P4/Xeon Thermal regulation detect and init */
-
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
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-	h = apic_read(APIC_LVTTHMR);
-	if ((l & (1<<3)) && (h & APIC_DM_SMI)) {
-		printk(KERN_DEBUG "CPU#%d: Thermal monitoring handled by SMI\n", cpu);
-		return; /* -EBUSY */
-	}
-
-	/* check whether a vector already exists, temporarily masked? */	
-	if (h & APIC_VECTOR_MASK) {
-		printk(KERN_DEBUG "CPU#%d: Thermal LVT vector (%#x) already installed\n",
-			cpu, (h & APIC_VECTOR_MASK));
-		return; /* -EBUSY */
-	}
-
-	/* The temperature transition interrupt handler setup */
-	h = THERMAL_APIC_VECTOR;		/* our delivery vector */
-	h |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
-	apic_write_around(APIC_LVTTHMR, h);
-
-	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
-	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x03 , h);
-
-	/* ok we're good to go... */
-	vendor_thermal_interrupt = intel_thermal_interrupt;
-	
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-	wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
-	
-	l = apic_read(APIC_LVTTHMR);
-	apic_write_around(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-	printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
-	return;
-}
-#endif /* CONFIG_X86_MCE_P4THERMAL */
-
-
-/* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
-
-static int inline intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
-{
-	u32 h;
-
-	if (mce_num_extended_msrs == 0)
-		goto done;
-
-	rdmsr(MSR_IA32_MCG_EAX, r->eax, h);
-	rdmsr(MSR_IA32_MCG_EBX, r->ebx, h);
-	rdmsr(MSR_IA32_MCG_ECX, r->ecx, h);
-	rdmsr(MSR_IA32_MCG_EDX, r->edx, h);
-	rdmsr(MSR_IA32_MCG_ESI, r->esi, h);
-	rdmsr(MSR_IA32_MCG_EDI, r->edi, h);
-	rdmsr(MSR_IA32_MCG_EBP, r->ebp, h);
-	rdmsr(MSR_IA32_MCG_ESP, r->esp, h);
-	rdmsr(MSR_IA32_MCG_EFLAGS, r->eflags, h);
-	rdmsr(MSR_IA32_MCG_EIP, r->eip, h);
-
-	/* can we rely on kmalloc to do a dynamic
-	 * allocation for the reserved registers?
-	 */
-done:
-	return mce_num_extended_msrs;
-}
-
-/*
- *	Machine Check Handler For PII/PIII
- */
-
-static void intel_machine_check(struct pt_regs * regs, long error_code)
-{
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-	struct intel_mce_extended_msrs dbg;
-
-	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if(mcgstl&(1<<0))	/* Recoverable ? */
-		recover=0;
-
-	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
-
-	if (intel_get_extended_msrs(&dbg)) {
-		printk(KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
-			smp_processor_id(), dbg.eip, dbg.eflags);
-		printk(KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",
-			dbg.eax, dbg.ebx, dbg.ecx, dbg.edx);
-		printk(KERN_DEBUG "\tesi: %08x edi: %08x ebp: %08x esp: %08x\n",
-			dbg.esi, dbg.edi, dbg.ebp, dbg.esp);
-	}
-
-	for (i=0;i<banks;i++) {
-		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
-		if(high&(1<<31)) {
-			if(high&(1<<29))
-				recover|=1;
-			if(high&(1<<25))
-				recover|=2;
-			printk(KERN_EMERG "Bank %d: %08x%08x", i, high, low);
-			high&=~(1<<31);
-			if(high&(1<<27)) {
-				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk("[%08x%08x]", ahigh, alow);
-			}
-			if(high&(1<<26)) {
-				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk(" at %08x%08x", ahigh, alow);
-			}
-			printk("\n");
-			/* Clear it */
-			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-			/* Serialize */
-			wmb();
-		}
-	}
-
-	if(recover&2)
-		panic("CPU context corrupt");
-	if(recover&1)
-		panic("Unable to continue");
-	printk(KERN_EMERG "Attempting to continue.\n");
-	mcgstl&=~(1<<2);
-	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
-}
-
-/*
- *	Machine check handler for Pentium class Intel
- */
-
-static void pentium_machine_check(struct pt_regs * regs, long error_code)
-{
-	u32 loaddr, hi, lotype;
-	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
-	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
-	printk(KERN_EMERG "CPU#%d: Machine Check Exception:  0x%8X (type 0x%8X).\n", smp_processor_id(), loaddr, lotype);
-	if(lotype&(1<<5))
-		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU on fire ?).\n", smp_processor_id());
-}
-
-/*
- *	Machine check handler for WinChip C6
- */
-
-static void winchip_machine_check(struct pt_regs * regs, long error_code)
-{
-	printk(KERN_EMERG "CPU#%d: Machine Check Exception.\n", smp_processor_id());
-}
-
-/*
- *	Handle unconfigured int18 (should never happen)
- */
-
-static void unexpected_machine_check(struct pt_regs * regs, long error_code)
-{	
-	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
-}
-
-/*
- *	Call the installed machine check handler for this CPU setup.
- */
-
-static void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
-
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
-{
-	machine_check_vector(regs, error_code);
-}
-
-
-#ifdef CONFIG_X86_MCE_NONFATAL
-static struct timer_list mce_timer;
-static int timerset = 0;
-
-#define MCE_RATE	15*HZ	/* timer rate is 15s */
-
-static void mce_checkregs (void *info)
-{
-	u32 low, high;
-	int i;
-
-	preempt_disable(); 
-	for (i=0; i<banks; i++) {
-		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
-
-		if ((low | high) != 0) {
-			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occured on CPU %d.\n", smp_processor_id());
-			printk (KERN_EMERG "Bank %d: %08x%08x\n", i, high, low);
-
-			/* Scrub the error so we don't pick it up in MCE_RATE seconds time. */
-			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-
-			/* Serialize */
-			wmb();
-		}
-	}
-	preempt_enable();
-}
-
-static void do_mce_timer(void *data)
-{ 
-	smp_call_function (mce_checkregs, NULL, 1, 1);
-} 
-
-static DECLARE_WORK(mce_work, do_mce_timer, NULL);
-
-static void mce_timerfunc (unsigned long data)
-{
-#ifdef CONFIG_SMP
-	if (num_online_cpus() > 1) 
-		schedule_work(&mce_work); 
-#else
-	mce_checkregs(NULL);
-#endif
-	mce_timer.expires = jiffies + MCE_RATE;
-	add_timer (&mce_timer);
-}	
-#endif
-
-
-/*
- *	Set up machine check reporting for processors with Intel style MCE
- */
-
-static void __init intel_mcheck_init(struct cpuinfo_x86 *c)
-{
-	u32 l, h;
-	int i;
-	static int done;
-	
-	/*
-	 *	Check for MCE support
-	 */
-
-	if( !cpu_has(c, X86_FEATURE_MCE) )
-		return;	
-
-	/*
-	 *	Pentium machine check
-	 */
-
-	if(c->x86 == 5)
-	{
-		/* Default P5 to off as its often misconnected */
-		if(mce_disabled != -1)
-			return;
-		machine_check_vector = pentium_machine_check;
-		wmb();
-		/* Read registers before enabling */
-		rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
-		rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
-		if(done==0)
-			printk(KERN_INFO "Intel old style machine check architecture supported.\n");
- 		/* Enable MCE */
-		set_in_cr4(X86_CR4_MCE);
-		printk(KERN_INFO "Intel old style machine check reporting enabled on CPU#%d.\n", smp_processor_id());
-		return;
-	}
-
-
-	/*
-	 *	Check for PPro style MCA
-	 */
- 		
-	if( !cpu_has(c, X86_FEATURE_MCA) )
-		return;
-
-	/* Ok machine check is available */
-
-	machine_check_vector = intel_machine_check;
-	wmb();
-
-	if(done==0)
-		printk(KERN_INFO "Intel machine check architecture supported.\n");
-	rdmsr(MSR_IA32_MCG_CAP, l, h);
-	if(l&(1<<8))	/* Control register present ? */
-		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
-	banks = l&0xff;
-
-	/* Don't enable bank 0 on intel P6 cores, it goes bang quickly. */
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6) {
-		for(i=1; i<banks; i++)
-			wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-	} else {
-		for(i=0; i<banks; i++)
-			wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
-	}
-
-	for(i=0; i<banks; i++)
-		wrmsr(MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-
-	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
-
-	/*
-	 *	Check for P4/Xeon specific MCE extensions
-	 */
-
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 15) {
-		/* Check for P4/Xeon extended MCE MSRs */
-		rdmsr(MSR_IA32_MCG_CAP, l, h);
-		if (l & (1<<9))	{/* MCG_EXT_P */
-			mce_num_extended_msrs = (l >> 16) & 0xff;
-			printk(KERN_INFO "CPU#%d: Intel P4/Xeon Extended MCE MSRs (%d) available\n",
-				smp_processor_id(), mce_num_extended_msrs);
-		}
-		
-#ifdef CONFIG_X86_MCE_P4THERMAL
-		/* Check for P4/Xeon Thermal monitor */
-		intel_init_thermal(c);
-#endif
-	}
-
-	done=1;
-}
-
-/*
- *	Set up machine check reporting on the Winchip C6 series
- */
-
-static void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
-{
-	u32 lo, hi;
-	/* Not supported on C3 */
-	if(c->x86 != 5)
-		return;
-	/* Winchip C6 */
-	machine_check_vector = winchip_machine_check;
-	wmb();
-	rdmsr(MSR_IDT_FCR1, lo, hi);
-	lo|= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
-	lo&= ~(1<<4);	/* Enable MCE */
-	wrmsr(MSR_IDT_FCR1, lo, hi);
-	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Winchip machine check reporting enabled on CPU#%d.\n", smp_processor_id());
-}
-
-
-/*
- *	This has to be run for each processor
- */
-
-void __init mcheck_init(struct cpuinfo_x86 *c)
-{
-
-	if(mce_disabled==1)
-		return;
-
-	switch(c->x86_vendor)
-	{
-		case X86_VENDOR_AMD:
-			/* AMD K7 machine check is Intel like */
-			if(c->x86 == 6 || c->x86 == 15) {
-				intel_mcheck_init(c);
-#ifdef CONFIG_X86_MCE_NONFATAL
-				if (timerset == 0) {
-					/* Set the timer to check for non-fatal
-					   errors every MCE_RATE seconds */
-					init_timer (&mce_timer);
-					mce_timer.expires = jiffies + MCE_RATE;
-					mce_timer.data = 0;
-					mce_timer.function = &mce_timerfunc;
-					add_timer (&mce_timer);
-					timerset = 1;
-					printk(KERN_INFO "Machine check exception polling timer started.\n");
-				}
-#endif
-			}
-			break;
-
-		case X86_VENDOR_INTEL:
-			intel_mcheck_init(c);
-			break;
-
-		case X86_VENDOR_CENTAUR:
-			winchip_mcheck_init(c);
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
-
-#else
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs) {}
-void __init mcheck_init(struct cpuinfo_x86 *c) {}
-#endif
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/Makefile linux-2.5/arch/i386/kernel/cpu/Makefile
--- bk-linus/arch/i386/kernel/cpu/Makefile	2002-10-20 20:21:24.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/Makefile	2002-10-25 18:02:31.000000000 -0100
@@ -13,7 +13,10 @@ obj-y	+=	rise.o
 obj-y	+=	nexgen.o
 obj-y	+=	umc.o
 
+obj-y	+=	mcheck/
+
 obj-$(CONFIG_MTRR)	+= 	mtrr/
 obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
 
+
 include $(TOPDIR)/Rules.make
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/Makefile linux-2.5/arch/i386/kernel/cpu/mcheck/Makefile
--- bk-linus/arch/i386/kernel/cpu/mcheck/Makefile	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/Makefile	2002-10-25 18:02:31.000000000 -0100
@@ -0,0 +1,4 @@
+obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o
+
+include $(TOPDIR)/Rules.make
+
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/k7.c linux-2.5/arch/i386/kernel/cpu/mcheck/k7.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/k7.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/k7.c	2002-10-25 18:02:31.000000000 -0100
@@ -0,0 +1,159 @@
+/*
+ * Athlon specific Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/config.h>
+#include <linux/irq.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/msr.h>
+
+#include "mce.h"
+
+static int banks;
+
+/* Machine Check Handler For AMD Athlon/Duron */
+static void k7_machine_check(struct pt_regs * regs, long error_code)
+{
+	int recover=1;
+	u32 alow, ahigh, high, low;
+	u32 mcgstl, mcgsth;
+	int i;
+
+	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
+	if(mcgstl&(1<<0))	/* Recoverable ? */
+		recover=0;
+
+	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
+
+	for (i=0;i<banks;i++) {
+		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
+		if(high&(1<<31)) {
+			if(high&(1<<29))
+				recover|=1;
+			if(high&(1<<25))
+				recover|=2;
+			printk(KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			high&=~(1<<31);
+			if(high&(1<<27)) {
+				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
+				printk("[%08x%08x]", ahigh, alow);
+			}
+			if(high&(1<<26)) {
+				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
+				printk(" at %08x%08x", ahigh, alow);
+			}
+			printk("\n");
+			/* Clear it */
+			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
+			/* Serialize */
+			wmb();
+		}
+	}
+
+	if(recover&2)
+		panic("CPU context corrupt");
+	if(recover&1)
+		panic("Unable to continue");
+	printk(KERN_EMERG "Attempting to continue.\n");
+	mcgstl&=~(1<<2);
+	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+}
+
+
+#ifdef CONFIG_X86_MCE_NONFATAL
+static struct timer_list mce_timer;
+static int timerset = 0;
+
+#define MCE_RATE	15*HZ	/* timer rate is 15s */
+
+static void mce_checkregs (void *info)
+{
+	u32 low, high;
+	int i;
+
+	preempt_disable(); 
+	for (i=0; i<banks; i++) {
+		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
+
+		if ((low | high) != 0) {
+			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occured on CPU %d.\n", smp_processor_id());
+			printk (KERN_EMERG "Bank %d: %08x%08x\n", i, high, low);
+
+			/* Scrub the error so we don't pick it up in MCE_RATE seconds time. */
+			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
+
+			/* Serialize */
+			wmb();
+		}
+	}
+	preempt_enable();
+}
+
+static void do_mce_timer(void *data)
+{ 
+	smp_call_function (mce_checkregs, NULL, 1, 1);
+} 
+
+static DECLARE_WORK(mce_work, do_mce_timer, NULL);
+
+static void mce_timerfunc (unsigned long data)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) 
+		schedule_work(&mce_work); 
+#else
+	mce_checkregs(NULL);
+#endif	/* SMP */
+	mce_timer.expires = jiffies + MCE_RATE;
+	add_timer (&mce_timer);
+}	
+#endif	/* NON_FATAL */
+
+
+/* AMD K7 machine check is Intel like */
+void __init amd_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	int i;
+
+	machine_check_vector = k7_machine_check;
+	wmb();
+
+	printk(KERN_INFO "Intel machine check architecture supported.\n");
+	rdmsr(MSR_IA32_MCG_CAP, l, h);
+	if(l&(1<<8))	/* Control register present ? */
+		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
+	banks = l&0xff;
+
+	for(i=0; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+
+	for(i=0; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+
+#ifdef CONFIG_X86_MCE_NONFATAL
+	if (timerset == 0) {
+		/* Set the timer to check for non-fatal
+		   errors every MCE_RATE seconds */
+		init_timer (&mce_timer);
+		mce_timer.expires = jiffies + MCE_RATE;
+		mce_timer.data = 0;
+		mce_timer.function = &mce_timerfunc;
+		add_timer (&mce_timer);
+		timerset = 1;
+		printk(KERN_INFO "Machine check exception polling timer started.\n");
+	}
+#endif
+}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/mce.c linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/mce.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,84 @@
+/*
+ * mce.c - x86 Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/thread_info.h>
+
+#include "mce.h"
+
+#ifdef CONFIG_X86_MCE
+
+int mce_disabled __initdata = 0;
+
+/* Handle unconfigured int18 (should never happen) */
+static void unexpected_machine_check(struct pt_regs * regs, long error_code)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
+}
+
+/* Call the installed machine check handler for this CPU setup. */
+void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
+
+asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
+/* This has to be run for each processor */
+void __init mcheck_init(struct cpuinfo_x86 *c)
+{
+	if(mce_disabled==1)
+		return;
+
+	switch(c->x86_vendor) {
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
+
+#else
+asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
+asmlinkage void smp_thermal_interrupt(struct pt_regs regs) {}
+void __init mcheck_init(struct cpuinfo_x86 *c) {}
+#endif
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/mce.h linux-2.5/arch/i386/kernel/cpu/mcheck/mce.h
--- bk-linus/arch/i386/kernel/cpu/mcheck/mce.h	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/mce.h	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,12 @@
+#include <linux/init.h>
+
+void amd_mcheck_init(struct cpuinfo_x86 *c);
+void intel_p4_mcheck_init(struct cpuinfo_x86 *c);
+void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
+void intel_p6_mcheck_init(struct cpuinfo_x86 *c);
+void winchip_mcheck_init(struct cpuinfo_x86 *c);
+
+/* Call the installed machine check handler for this CPU setup. */
+extern void (*machine_check_vector)(struct pt_regs *, long error_code);
+
+extern int mce_disabled __initdata;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/p4.c linux-2.5/arch/i386/kernel/cpu/mcheck/p4.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/p4.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/p4.c	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,244 @@
+/*
+ * P4 specific Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+
+#include "mce.h"
+
+/* as supported by the P4/Xeon family */
+struct intel_mce_extended_msrs {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u32 esi;
+	u32 edi;
+	u32 ebp;
+	u32 esp;
+	u32 eflags;
+	u32 eip;
+	/* u32 *reserved[]; */
+};
+
+static int mce_num_extended_msrs = 0;
+static int banks;
+
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+static void unexpected_thermal_interrupt(struct pt_regs *regs)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
+}
+
+/* P4/Xeon Thermal transition interrupt handler */
+static void intel_thermal_interrupt(struct pt_regs *regs)
+{
+	u32 l, h;
+	unsigned int cpu = smp_processor_id();
+
+	ack_APIC_irq();
+
+	rdmsr(MSR_IA32_THERM_STATUS, l, h);
+	if (l & 1) {
+		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
+		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
+	} else {
+		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
+	}
+}
+
+/* Thermal interrupt handler for this CPU setup */
+static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
+
+asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
+{
+	irq_enter();
+	vendor_thermal_interrupt(&regs);
+	irq_exit();
+}
+
+/* P4/Xeon Thermal regulation detect and init */
+static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	unsigned int cpu = smp_processor_id();
+
+	/* Thermal monitoring */
+	if (!cpu_has(c, X86_FEATURE_ACPI))
+		return;	/* -ENODEV */
+
+	/* Clock modulation */
+	if (!cpu_has(c, X86_FEATURE_ACC))
+		return;	/* -ENODEV */
+
+	/* first check if its enabled already, in which case there might
+	 * be some SMM goo which handles it, so we can't even put a handler
+	 * since it might be delivered via SMI already -zwanem.
+	 */
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	h = apic_read(APIC_LVTTHMR);
+	if ((l & (1<<3)) && (h & APIC_DM_SMI)) {
+		printk(KERN_DEBUG "CPU#%d: Thermal monitoring handled by SMI\n", cpu);
+		return; /* -EBUSY */
+	}
+
+	/* check whether a vector already exists, temporarily masked? */	
+	if (h & APIC_VECTOR_MASK) {
+		printk(KERN_DEBUG "CPU#%d: Thermal LVT vector (%#x) already installed\n",
+			cpu, (h & APIC_VECTOR_MASK));
+		return; /* -EBUSY */
+	}
+
+	/* The temperature transition interrupt handler setup */
+	h = THERMAL_APIC_VECTOR;		/* our delivery vector */
+	h |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
+	apic_write_around(APIC_LVTTHMR, h);
+
+	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
+	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x03 , h);
+
+	/* ok we're good to go... */
+	vendor_thermal_interrupt = intel_thermal_interrupt;
+	
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
+	
+	l = apic_read(APIC_LVTTHMR);
+	apic_write_around(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+	printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
+	return;
+}
+#endif /* CONFIG_X86_MCE_P4THERMAL */
+
+
+/* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
+static int inline intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
+{
+	u32 h;
+
+	if (mce_num_extended_msrs == 0)
+		goto done;
+
+	rdmsr(MSR_IA32_MCG_EAX, r->eax, h);
+	rdmsr(MSR_IA32_MCG_EBX, r->ebx, h);
+	rdmsr(MSR_IA32_MCG_ECX, r->ecx, h);
+	rdmsr(MSR_IA32_MCG_EDX, r->edx, h);
+	rdmsr(MSR_IA32_MCG_ESI, r->esi, h);
+	rdmsr(MSR_IA32_MCG_EDI, r->edi, h);
+	rdmsr(MSR_IA32_MCG_EBP, r->ebp, h);
+	rdmsr(MSR_IA32_MCG_ESP, r->esp, h);
+	rdmsr(MSR_IA32_MCG_EFLAGS, r->eflags, h);
+	rdmsr(MSR_IA32_MCG_EIP, r->eip, h);
+
+	/* can we rely on kmalloc to do a dynamic
+	 * allocation for the reserved registers?
+	 */
+done:
+	return mce_num_extended_msrs;
+}
+
+static void intel_machine_check(struct pt_regs * regs, long error_code)
+{
+	int recover=1;
+	u32 alow, ahigh, high, low;
+	u32 mcgstl, mcgsth;
+	int i;
+	struct intel_mce_extended_msrs dbg;
+
+	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
+	if(mcgstl&(1<<0))	/* Recoverable ? */
+		recover=0;
+
+	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
+
+	if (intel_get_extended_msrs(&dbg)) {
+		printk(KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
+			smp_processor_id(), dbg.eip, dbg.eflags);
+		printk(KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",
+			dbg.eax, dbg.ebx, dbg.ecx, dbg.edx);
+		printk(KERN_DEBUG "\tesi: %08x edi: %08x ebp: %08x esp: %08x\n",
+			dbg.esi, dbg.edi, dbg.ebp, dbg.esp);
+	}
+
+	for (i=0;i<banks;i++) {
+		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
+		if(high&(1<<31)) {
+			if(high&(1<<29))
+				recover|=1;
+			if(high&(1<<25))
+				recover|=2;
+			printk(KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			high&=~(1<<31);
+			if(high&(1<<27)) {
+				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
+				printk("[%08x%08x]", ahigh, alow);
+			}
+			if(high&(1<<26)) {
+				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
+				printk(" at %08x%08x", ahigh, alow);
+			}
+			printk("\n");
+			/* Clear it */
+			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
+			/* Serialize */
+			wmb();
+		}
+	}
+
+	if(recover&2)
+		panic("CPU context corrupt");
+	if(recover&1)
+		panic("Unable to continue");
+	printk(KERN_EMERG "Attempting to continue.\n");
+	mcgstl&=~(1<<2);
+	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+}
+
+void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	int i;
+	
+	machine_check_vector = intel_machine_check;
+	wmb();
+
+	printk(KERN_INFO "Intel machine check architecture supported.\n");
+	rdmsr(MSR_IA32_MCG_CAP, l, h);
+	if(l&(1<<8))	/* Control register present ? */
+		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
+	banks = l&0xff;
+
+	for(i=1; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+
+	for(i=0; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+
+	/* Check for P4/Xeon extended MCE MSRs */
+	rdmsr(MSR_IA32_MCG_CAP, l, h);
+	if (l & (1<<9))	{/* MCG_EXT_P */
+		mce_num_extended_msrs = (l >> 16) & 0xff;
+		printk(KERN_INFO "CPU#%d: Intel P4/Xeon Extended MCE MSRs (%d) available\n",
+			smp_processor_id(), mce_num_extended_msrs);
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+		/* Check for P4/Xeon Thermal monitor */
+		intel_init_thermal(c);
+#endif
+	}
+}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/p5.c linux-2.5/arch/i386/kernel/cpu/mcheck/p5.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/p5.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/p5.c	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,52 @@
+/*
+ * P5 specific Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/msr.h>
+
+#include "mce.h"
+
+/* Machine check handler for Pentium class Intel */
+static void pentium_machine_check(struct pt_regs * regs, long error_code)
+{
+	u32 loaddr, hi, lotype;
+	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
+	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
+	printk(KERN_EMERG "CPU#%d: Machine Check Exception:  0x%8X (type 0x%8X).\n", smp_processor_id(), loaddr, lotype);
+	if(lotype&(1<<5))
+		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU on fire ?).\n", smp_processor_id());
+}
+
+/* Set up machine check reporting for processors with Intel style MCE */
+void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	
+	/*Check for MCE support */
+	if( !cpu_has(c, X86_FEATURE_MCE) )
+		return;	
+
+	/* Default P5 to off as its often misconnected */
+	if(mce_disabled != -1)
+		return;
+	machine_check_vector = pentium_machine_check;
+	wmb();
+
+	/* Read registers before enabling */
+	rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
+	rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
+	printk(KERN_INFO "Intel old style machine check architecture supported.\n");
+
+ 	/* Enable MCE */
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Intel old style machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/p6.c linux-2.5/arch/i386/kernel/cpu/mcheck/p6.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/p6.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/p6.c	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,101 @@
+/*
+ * P6 specific Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/msr.h>
+
+#include "mce.h"
+
+static int banks;
+
+/* Machine Check Handler For PII/PIII */
+static void intel_machine_check(struct pt_regs * regs, long error_code)
+{
+	int recover=1;
+	u32 alow, ahigh, high, low;
+	u32 mcgstl, mcgsth;
+	int i;
+
+	rdmsr(MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
+	if(mcgstl&(1<<0))	/* Recoverable ? */
+		recover=0;
+
+	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
+
+	for (i=0;i<banks;i++) {
+		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
+		if(high&(1<<31)) {
+			if(high&(1<<29))
+				recover|=1;
+			if(high&(1<<25))
+				recover|=2;
+			printk(KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			high&=~(1<<31);
+			if(high&(1<<27)) {
+				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
+				printk("[%08x%08x]", ahigh, alow);
+			}
+			if(high&(1<<26)) {
+				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
+				printk(" at %08x%08x", ahigh, alow);
+			}
+			printk("\n");
+			/* Clear it */
+			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
+			/* Serialize */
+			wmb();
+		}
+	}
+
+	if(recover&2)
+		panic("CPU context corrupt");
+	if(recover&1)
+		panic("Unable to continue");
+	printk(KERN_EMERG "Attempting to continue.\n");
+	mcgstl&=~(1<<2);
+	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+}
+
+/* Set up machine check reporting for processors with Intel style MCE */
+void __init intel_p6_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 l, h;
+	int i;
+	
+	/* Check for MCE support */
+	if( !cpu_has(c, X86_FEATURE_MCE) )
+		return;	
+
+	/* Check for PPro style MCA */
+ 	if( !cpu_has(c, X86_FEATURE_MCA) )
+		return;
+
+	/* Ok machine check is available */
+	machine_check_vector = intel_machine_check;
+	wmb();
+
+	printk(KERN_INFO "Intel machine check architecture supported.\n");
+	rdmsr(MSR_IA32_MCG_CAP, l, h);
+	if(l&(1<<8))	/* Control register present ? */
+		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
+	banks = l&0xff;
+
+	/* Don't enable bank 0 on intel P6 cores, it goes bang quickly. */
+	for(i=1; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+
+	for(i=0; i<banks; i++)
+		wrmsr(MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
+
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/winchip.c linux-2.5/arch/i386/kernel/cpu/mcheck/winchip.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/winchip.c	1969-12-31 23:00:00.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/winchip.c	2002-10-25 18:02:32.000000000 -0100
@@ -0,0 +1,35 @@
+/*
+ * IDT Winchip specific Machine Check Exception Reporting
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/processor.h> 
+#include <asm/system.h>
+#include <asm/msr.h>
+
+#include "mce.h"
+
+/* Machine check handler for WinChip C6 */
+static void winchip_machine_check(struct pt_regs * regs, long error_code)
+{
+	printk(KERN_EMERG "CPU0: Machine Check Exception.\n");
+}
+
+/* Set up machine check reporting on the Winchip C6 series */
+void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 lo, hi;
+	machine_check_vector = winchip_machine_check;
+	wmb();
+	rdmsr(MSR_IDT_FCR1, lo, hi);
+	lo|= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
+	lo&= ~(1<<4);	/* Enable MCE */
+	wrmsr(MSR_IDT_FCR1, lo, hi);
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Winchip machine check reporting enabled on CPU#0.\n");
+}
