Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312676AbSC0GPd>; Wed, 27 Mar 2002 01:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312976AbSC0GPZ>; Wed, 27 Mar 2002 01:15:25 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:35999 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312676AbSC0GPQ>; Wed, 27 Mar 2002 01:15:16 -0500
Date: Wed, 27 Mar 2002 08:04:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.LNX.4.44.0203270751400.22305-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203270803150.22597-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Zwane Mwaikambo wrote:

> Hi Dave,
> 	This patch enables thermal monitoring on P4/Xeon and also installs 
> an interrupt handler to take notification of thermal state transitions. 
> Its currently untested, so input would be appreciated.
> 
> Thanks,
> 	Zwane
> 
> 

argh...

diff -ur linux-2.5-dj-orig/arch/i386/kernel/apic.c linux-2.5.5-dj/arch/i386/kernel/apic.c
--- linux-2.5-dj-orig/arch/i386/kernel/apic.c	Sat Mar 23 21:10:58 2002
+++ linux-2.5.5-dj/arch/i386/kernel/apic.c	Sat Mar 23 20:43:18 2002
@@ -449,6 +449,7 @@
 	unsigned int apic_lvterr;
 	unsigned int apic_tmict;
 	unsigned int apic_tdcr;
+	unsigned int apic_thmr;
 } apic_pm_state;
 
 static void apic_pm_suspend(void *data)
@@ -470,6 +471,7 @@
 	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
+	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
 	__save_flags(flags);
 	__cli();
 	disable_local_APIC();
@@ -498,6 +500,7 @@
 	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
 	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
 	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
+	apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
 	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
 	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
 	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
diff -ur linux-2.5-dj-orig/arch/i386/kernel/bluesmoke.c linux-2.5.5-dj/arch/i386/kernel/bluesmoke.c
--- linux-2.5-dj-orig/arch/i386/kernel/bluesmoke.c	Sat Mar 23 21:10:58 2002
+++ linux-2.5.5-dj/arch/i386/kernel/bluesmoke.c	Tue Mar 26 22:52:59 2002
@@ -8,6 +8,8 @@
 #include <asm/processor.h> 
 #include <asm/system.h>
 #include <asm/msr.h>
+#include <asm/apic.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_X86_MCE
 
@@ -16,6 +18,86 @@
 static int banks;
 
 /*
+ *	P4/Xeon Thermal transition interrupt handler
+ */
+
+static void intel_thermal_interrupt(struct pt_regs *regs, long error_code)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
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
+#endif
+}
+
+static void unexpected_thermal_interrupt(struct pt_regs * regs, long error_code)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
+}
+
+/*
+ *	Thermal interrupt handler for this CPU setup
+ */
+
+void (*thermal_monitor)(struct pt_regs *, long error_code) = unexpected_thermal_interrupt;
+
+
+/* P4/Xeon Thermal regulation detect and init */
+
+static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	u32 l, h;
+	unsigned int cpu = smp_processor_id();
+
+	/* Thermal monitoring */
+	if (!test_bit(X86_FEATURE_ACPI, &c->x86_capability))
+		return;	/* -ENODEV */
+	
+	/* Clock modulation */
+	if (!test_bit(X86_FEATURE_ACC, &c->x86_capability))
+		return;	/* -ENODEV */
+
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	/* first check if its enabled already, in which case there might
+	 * be some SMM goo which handles it, so we can't even put a handler
+	 * since it might be delivered via SMI already -zwanem.
+	 */
+	if (l & (1<<3)) {
+		printk(KERN_DEBUG "CPU#%d: Thermal monitoring already enabled\n", cpu);
+		return;	/* -EBUSY */
+	}
+	
+	wrmsr(MSR_IA32_MISC_ENABLE, l | (1<<3), h);
+	printk(KERN_INFO "CPU#%d: Thermal monitoring enabled\n", cpu);
+	
+	/* The temperature transition interrupt handler setup */
+	l = THERMAL_APIC_VECTOR;		/* our delivery vector */
+	l |= (APIC_DM_FIXED | APIC_LVT_MASKED);	/* we'll mask till we're ready */
+	apic_write_around(APIC_LVTTHMR, l);
+
+	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
+	wrmsr(MSR_IA32_THERM_INTERRUPT, l | 0x3 , h);
+
+	/* ok we're good to go... */
+	thermal_monitor = intel_thermal_interrupt;
+	l = apic_read(APIC_LVTTHMR);
+	apic_write_around(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
+	return;
+#endif
+}
+
+/*
  *	Machine Check Handler For PII/PIII
  */
 
@@ -236,6 +318,9 @@
 	}
 	set_in_cr4(X86_CR4_MCE);
 	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+	
+	intel_init_thermal(c);
+
 	done=1;
 }
 
@@ -317,5 +402,6 @@
 
 #else
 asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
+void thermal_monitor(struct pt_regs * regs, long error_code) {}
 void __init mcheck_init(struct cpuinfo_x86 *c) {}
 #endif
diff -ur linux-2.5-dj-orig/arch/i386/kernel/traps.c linux-2.5.5-dj/arch/i386/kernel/traps.c
--- linux-2.5-dj-orig/arch/i386/kernel/traps.c	Sat Mar 23 21:10:58 2002
+++ linux-2.5.5-dj/arch/i386/kernel/traps.c	Tue Mar 26 22:57:03 2002
@@ -88,7 +88,7 @@
 asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
-
+asmlinkage void thermal_monitor(void);
 int kstack_depth_to_print = 24;
 
 
@@ -995,8 +995,10 @@
 	set_trap_gate(17,&alignment_check);
 	set_trap_gate(18,&machine_check);
 	set_trap_gate(19,&simd_coprocessor_error);
-
+	
 	set_system_gate(SYSCALL_VECTOR,&system_call);
+	set_intr_gate(THERMAL_APIC_VECTOR, &thermal_monitor);
+
 
 	/*
 	 * default LDT is a single-entry callgate to lcall7 for iBCS
diff -ur linux-2.5-dj-orig/include/asm-i386/apicdef.h linux-2.5.5-dj/include/asm-i386/apicdef.h
--- linux-2.5-dj-orig/include/asm-i386/apicdef.h	Sun Aug 12 20:13:59 2001
+++ linux-2.5.5-dj/include/asm-i386/apicdef.h	Sat Mar 23 22:35:06 2002
@@ -71,6 +71,7 @@
 #define			GET_APIC_DEST_FIELD(x)	(((x)>>24)&0xFF)
 #define			SET_APIC_DEST_FIELD(x)	((x)<<24)
 #define		APIC_LVTT	0x320
+#define		APIC_LVTTHMR	0x330
 #define		APIC_LVTPC	0x340
 #define		APIC_LVT0	0x350
 #define			APIC_LVT_TIMER_BASE_MASK	(0x3<<18)
@@ -280,7 +281,16 @@
 		u32 __reserved_4[3];
 	} lvt_timer;
 
-/*330*/	struct { u32 __reserved[4]; } __reserved_15;
+/*330*/	struct { /* LVT - Thermal Sensor */
+		u32  vector		:  8,
+			delivery_mode	:  3,
+			__reserved_1	:  1,
+			delivery_status	:  1,
+			__reserved_2	:  3,
+			mask		:  1,
+			__reserved_3	: 15;
+		u32 __reserved_4[3];
+	} lvt_thermal;
 
 /*340*/	struct { /* LVT - Performance Counter */
 		u32   vector		:  8,
diff -ur linux-2.5-dj-orig/include/asm-i386/hw_irq.h linux-2.5.5-dj/include/asm-i386/hw_irq.h
--- linux-2.5-dj-orig/include/asm-i386/hw_irq.h	Sat Mar 23 21:09:51 2002
+++ linux-2.5.5-dj/include/asm-i386/hw_irq.h	Tue Mar 26 23:19:56 2002
@@ -56,6 +56,7 @@
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
+#define THERMAL_APIC_VECTOR	0x32	/* Thermal monitor local vector */
 #define FIRST_SYSTEM_VECTOR	0xef
 
 extern int irq_vector[NR_IRQS];
diff -ur linux-2.5-dj-orig/include/asm-i386/msr.h linux-2.5.5-dj/include/asm-i386/msr.h
--- linux-2.5-dj-orig/include/asm-i386/msr.h	Sat Mar 23 21:11:06 2002
+++ linux-2.5.5-dj/include/asm-i386/msr.h	Sat Mar 23 18:35:47 2002
@@ -60,6 +60,11 @@
 #define MSR_P6_EVNTSEL0		0x186
 #define MSR_P6_EVNTSEL1		0x187
 
+#define MSR_IA32_THERM_CONTROL		0x19a
+#define MSR_IA32_THERM_INTERRUPT	0x19b
+#define MSR_IA32_THERM_STATUS		0x19c
+#define MSR_IA32_MISC_ENABLE		0x1a0
+
 #define MSR_IA32_DEBUGCTLMSR		0x1d9
 #define MSR_IA32_LASTBRANCHFROMIP	0x1db
 #define MSR_IA32_LASTBRANCHTOIP		0x1dc

-- 
http://function.linuxpower.ca
		

