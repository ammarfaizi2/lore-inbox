Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312442AbSC3K2u>; Sat, 30 Mar 2002 05:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSC3K2l>; Sat, 30 Mar 2002 05:28:41 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:19923 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312442AbSC3K2g>; Sat, 30 Mar 2002 05:28:36 -0500
Date: Sat, 30 Mar 2002 12:17:10 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Dave Jones <davej@suse.de>,
        Brian Gerst <bgerst@didntduck.org>
Subject: [PATCH] P4/Xeon Thermal LVT support (take 4)
In-Reply-To: <3CA365DF.DB5C1954@didntduck.org>
Message-ID: <Pine.LNX.4.44.0203301212450.18682-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt handler setup has been fixed. Many thanks to Brian, Maciej and 
Dave for reviewing and help.

Dave if you'd rather one against 2.5-dj-current just drop me a 
note.

Cheers,
	Zwane

diff -ur linux-2.5-dj-orig/arch/i386/kernel/apic.c linux-2.5-dj-work/arch/i386/kernel/apic.c
--- linux-2.5-dj-orig/arch/i386/kernel/apic.c	Wed Mar 27 17:52:15 2002
+++ linux-2.5-dj-work/arch/i386/kernel/apic.c	Wed Mar 27 17:56:05 2002
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
Only in linux-2.5-dj-work/arch/i386/kernel: apic.o
diff -ur linux-2.5-dj-orig/arch/i386/kernel/bluesmoke.c linux-2.5-dj-work/arch/i386/kernel/bluesmoke.c
--- linux-2.5-dj-orig/arch/i386/kernel/bluesmoke.c	Wed Mar 27 17:52:15 2002
+++ linux-2.5-dj-work/arch/i386/kernel/bluesmoke.c	Sat Mar 30 11:56:00 2002
@@ -8,6 +8,8 @@
 #include <asm/processor.h> 
 #include <asm/system.h>
 #include <asm/msr.h>
+#include <asm/apic.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_X86_MCE
 
@@ -16,6 +18,99 @@
 static int banks;
 
 /*
+ *	P4/Xeon Thermal transition interrupt handler
+ */
+
+static void intel_thermal_interrupt(struct pt_regs *regs)
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
+static void unexpected_thermal_interrupt(struct pt_regs *regs)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected LVT TMR interrupt!\n", smp_processor_id());
+}
+
+/*
+ *	Thermal interrupt handler for this CPU setup
+ */
+
+static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
+
+asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
+{
+	vendor_thermal_interrupt(&regs);
+}
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
+#if 0
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	/* first check if its enabled already, in which case there might
+	 * be some SMM goo which handles it, so we can't even put a handler
+	 * since it might be delivered via SMI already -zwanem.
+	 */
+
+	if (l & (1<<3)) {
+		printk(KERN_DEBUG "CPU#%d: Thermal monitoring already enabled\n", cpu);
+		return;	/* -EBUSY */
+	}
+#endif
+
+	/* check wether a vector already exists */	
+	l = apic_read(APIC_LVTTHMR);
+	if (l & 0xff) {
+		printk(KERN_DEBUG "CPU#%d: Thermal LVT already handled\n");
+		return; /* -EBUSY */
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
+	vendor_thermal_interrupt = intel_thermal_interrupt;
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
 
@@ -236,6 +331,9 @@
 	}
 	set_in_cr4(X86_CR4_MCE);
 	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+	
+	intel_init_thermal(c);
+
 	done=1;
 }
 
@@ -317,5 +415,6 @@
 
 #else
 asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
+asmlinkage void smp_thermal_interrupt(struct pt_regs regs) {}
 void __init mcheck_init(struct cpuinfo_x86 *c) {}
 #endif
diff -ur linux-2.5-dj-orig/arch/i386/kernel/i8259.c linux-2.5-dj-work/arch/i386/kernel/i8259.c
--- linux-2.5-dj-orig/arch/i386/kernel/i8259.c	Wed Mar 27 17:35:34 2002
+++ linux-2.5-dj-work/arch/i386/kernel/i8259.c	Sat Mar 30 11:56:34 2002
@@ -95,6 +95,7 @@
 BUILD_SMP_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_SMP_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_SMP_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+BUILD_SMP_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
 #endif
 
 #define IRQ(x,y) \
@@ -487,6 +488,9 @@
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+
+	/* thermal monitor LVT interrupt */
+	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 
 	/*
diff -ur linux-2.5-dj-orig/include/asm-i386/apicdef.h linux-2.5-dj-work/include/asm-i386/apicdef.h
--- linux-2.5-dj-orig/include/asm-i386/apicdef.h	Sun Aug 12 20:13:59 2001
+++ linux-2.5-dj-work/include/asm-i386/apicdef.h	Wed Mar 27 17:56:05 2002
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
diff -ur linux-2.5-dj-orig/include/asm-i386/hw_irq.h linux-2.5-dj-work/include/asm-i386/hw_irq.h
--- linux-2.5-dj-orig/include/asm-i386/hw_irq.h	Wed Mar 27 17:35:40 2002
+++ linux-2.5-dj-work/include/asm-i386/hw_irq.h	Thu Mar 28 12:32:16 2002
@@ -43,6 +43,7 @@
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
 
+#define THERMAL_APIC_VECTOR	0xf0
 /*
  * Local APIC timer IRQ vector is on a different priority level,
  * to work around the 'lost local interrupt if more than 2 IRQ
diff -ur linux-2.5-dj-orig/include/asm-i386/msr.h linux-2.5-dj-work/include/asm-i386/msr.h
--- linux-2.5-dj-orig/include/asm-i386/msr.h	Wed Mar 27 17:52:23 2002
+++ linux-2.5-dj-work/include/asm-i386/msr.h	Wed Mar 27 17:56:05 2002
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
		

