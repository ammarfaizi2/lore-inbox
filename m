Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWJ2Cpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWJ2Cpi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWJ2Cpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:45:38 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64680 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964947AbWJ2Cp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:45:26 -0400
Message-Id: <20061029024603.317829000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 1/7] header and stubs for paravirtualizing critical operations
Content-Disposition: inline; filename=paravirt.h-addition.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a paravirt.h header for all the critical operations which need
to be replaced with hypervisor calls, and include that instead of
defining native operations, when CONFIG_PARAVIRT.

This patch does the dumbest possible replacement of paravirtualized
instructions: calls through a "paravirt_ops" structure.  Currently
these are function implementations of native hardware: hypervisors
will override the ops structure with their own variants.

All the pv-ops functions are declared "fastcall" so that a specific
register-based ABI is used, to make inlining assember easier.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/Kconfig                          |   11 
 arch/i386/boot/compressed/misc.c           |    1 
 arch/i386/kernel/Makefile                  |    1 
 arch/i386/kernel/asm-offsets.c             |   10 
 arch/i386/kernel/entry.S                   |   34 +-
 arch/i386/kernel/i8259.c                   |    2 
 arch/i386/kernel/paravirt.c                |  410 +++++++++++++++++++++++++++++
 arch/i386/kernel/setup.c                   |    2 
 arch/i386/kernel/smpboot.c                 |    5 
 arch/i386/kernel/time.c                    |   15 -
 drivers/net/de600.c                        |    1 
 include/asm-i386/delay.h                   |    8 
 include/asm-i386/desc.h                    |    4 
 include/asm-i386/io.h                      |   10 
 include/asm-i386/irq.h                     |   10 
 include/asm-i386/irqflags.h                |   42 +-
 include/asm-i386/mach-default/setup_arch.h |    2 
 include/asm-i386/msr.h                     |    5 
 include/asm-i386/paravirt.h                |  291 ++++++++++++++++++++
 include/asm-i386/processor.h               |   15 -
 include/asm-i386/segment.h                 |    2 
 include/asm-i386/setup.h                   |    8 
 include/asm-i386/spinlock.h                |    4 
 include/asm-i386/system.h                  |   16 -
 include/asm-i386/time.h                    |   41 ++
 25 files changed, 902 insertions(+), 48 deletions(-)

--- linux-2.6-pv.orig/arch/i386/Kconfig
+++ linux-2.6-pv/arch/i386/Kconfig
@@ -197,6 +197,17 @@ config X86_ES7000
 
 endchoice
 
+config PARAVIRT
+	bool "Paravirtualization support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Paravirtualization is a way of running multiple instances of
+	  Linux on the same machine, under a hypervisor.  This option
+	  changes the kernel so it can modify itself when it is run
+	  under a hypervisor, improving performance significantly.
+	  However, when run without a hypervisor the kernel is
+	  theoretically slower.  If in doubt, say N.
+
 config ACPI_SRAT
 	bool
 	default y
--- linux-2.6-pv.orig/arch/i386/boot/compressed/misc.c
+++ linux-2.6-pv/arch/i386/boot/compressed/misc.c
@@ -9,6 +9,7 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#undef CONFIG_PARAVIRT
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/screen_info.h>
--- linux-2.6-pv.orig/arch/i386/kernel/Makefile
+++ linux-2.6-pv/arch/i386/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
 EXTRA_AFLAGS   := -traditional
 
--- linux-2.6-pv.orig/arch/i386/kernel/asm-offsets.c
+++ linux-2.6-pv/arch/i386/kernel/asm-offsets.c
@@ -101,4 +101,14 @@ void foo(void)
 	BLANK();
  	OFFSET(PDA_cpu, i386_pda, cpu_number);
 	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
+
+#ifdef CONFIG_PARAVIRT
+	BLANK();
+	OFFSET(PARAVIRT_enabled, paravirt_ops, paravirt_enabled);
+	OFFSET(PARAVIRT_irq_disable, paravirt_ops, irq_disable);
+	OFFSET(PARAVIRT_irq_enable, paravirt_ops, irq_enable);
+	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
+	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
+	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+#endif
 }
--- linux-2.6-pv.orig/arch/i386/kernel/entry.S
+++ linux-2.6-pv/arch/i386/kernel/entry.S
@@ -62,13 +62,6 @@ DF_MASK		= 0x00000400 
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
-/* These are replaces for paravirtualization */
-#define DISABLE_INTERRUPTS		cli
-#define ENABLE_INTERRUPTS		sti
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define INTERRUPT_RETURN		iret
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
-
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
 #else
@@ -416,6 +409,20 @@ ldt_ss:
 	jnz restore_nocheck
 	testl $0x00400000, %eax		# returning to 32bit stack?
 	jnz restore_nocheck		# allright, normal return
+
+#ifdef CONFIG_PARAVIRT
+	/* 
+	 * The kernel can't run on a non-flat stack if paravirt mode
+	 * is active.  Rather than try to fixup the high bits of
+	 * ESP, bypass this code entirely.  This may break DOSemu
+	 * and/or Wine support in a paravirt VM, although the option
+	 * is still available to implement the setting of the high
+	 * 16-bits in the INTERRUPT_RETURN paravirt-op.
+	 */
+	cmpl $0, paravirt_ops+PARAVIRT_enabled
+	jne restore_nocheck
+#endif
+	
 	/* If returning to userspace with 16bit stack,
 	 * try to fix the higher word of ESP, as the CPU
 	 * won't restore it.
@@ -831,6 +838,19 @@ nmi_espfix_stack:
 .previous
 KPROBE_END(nmi)
 
+#ifdef CONFIG_PARAVIRT
+ENTRY(native_iret)
+1:	iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
+ENTRY(native_irq_enable_sysexit)
+	sti
+	sysexit
+#endif
+
 KPROBE_ENTRY(int3)
 	RING0_INT_FRAME
 	pushl $-1			# mark this as an int
--- linux-2.6-pv.orig/arch/i386/kernel/i8259.c
+++ linux-2.6-pv/arch/i386/kernel/i8259.c
@@ -392,7 +392,7 @@ void __init init_ISA_irqs (void)
 	}
 }
 
-void __init init_IRQ(void)
+void __init native_init_IRQ(void)
 {
 	int i;
 
--- linux-2.6-pv.orig/arch/i386/kernel/setup.c
+++ linux-2.6-pv/arch/i386/kernel/setup.c
@@ -1404,7 +1404,7 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 	else {
 		printk(KERN_INFO "BIOS-provided physical RAM map:\n");
-		print_memory_map(machine_specific_memory_setup());
+		print_memory_map(memory_setup());
 	}
 
 	copy_edd();
--- linux-2.6-pv.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6-pv/arch/i386/kernel/smpboot.c
@@ -33,6 +33,11 @@
  *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
 *		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. */
 
+
+/* SMP boot always wants to use real time delay to allow sufficient time for
+ * the APs to come online */
+#define USE_REAL_TIME_DELAY
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
--- linux-2.6-pv.orig/arch/i386/kernel/time.c
+++ linux-2.6-pv/arch/i386/kernel/time.c
@@ -56,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/time.h>
 
 #include "mach_time.h"
 
@@ -116,10 +117,7 @@ static int set_rtc_mmss(unsigned long no
 	/* gets recalled with irq locally disabled */
 	/* XXX - does irqsave resolve this? -johnstul */
 	spin_lock_irqsave(&rtc_lock, flags);
-	if (efi_enabled)
-		retval = efi_set_rtc_mmss(nowtime);
-	else
-		retval = mach_set_rtc_mmss(nowtime);
+	retval = set_wallclock(nowtime);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return retval;
@@ -211,10 +209,7 @@ unsigned long read_persistent_clock(void
 
 	spin_lock_irqsave(&rtc_lock, flags);
 
-	if (efi_enabled)
-		retval = efi_get_time();
-	else
-		retval = mach_get_cmos_time();
+	retval = get_wallclock();
 
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
@@ -280,7 +275,7 @@ static void __init hpet_time_init(void)
 		printk("Using HPET for base-timer\n");
 	}
 
-	time_init_hook();
+	do_time_init();
 }
 #endif
 
@@ -296,5 +291,5 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	time_init_hook();
+	do_time_init();
 }
--- linux-2.6-pv.orig/drivers/net/de600.c
+++ linux-2.6-pv/drivers/net/de600.c
@@ -43,7 +43,6 @@ static const char version[] = "de600.c: 
  * modify the following "#define": (see <asm/io.h> for more info)
 #define REALLY_SLOW_IO
  */
-#define SLOW_IO_BY_JUMPING /* Looks "better" than dummy write to port 0x80 :-) */
 
 /* use 0 for production, 1 for verification, >2 for debug */
 #ifdef DE600_DEBUG
--- linux-2.6-pv.orig/include/asm-i386/delay.h
+++ linux-2.6-pv/include/asm-i386/delay.h
@@ -15,6 +15,13 @@ extern void __ndelay(unsigned long nsecs
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
+#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
+#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+	
+#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+
+#else /* !PARAVIRT || USE_REAL_TIME_DELAY */
+
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
@@ -22,6 +29,7 @@ extern void __delay(unsigned long loops)
 #define ndelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
 	__ndelay(n))
+#endif
 
 void use_tsc_delay(void);
 
--- linux-2.6-pv.orig/include/asm-i386/desc.h
+++ linux-2.6-pv/include/asm-i386/desc.h
@@ -55,6 +55,9 @@ static inline void pack_gate(u32 *low, u
 #define DESCTYPE_DPL3	0x60	/* DPL-3 */
 #define DESCTYPE_S	0x10	/* !system */
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 
 #define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
@@ -104,6 +107,7 @@ static inline void set_ldt(void *addr, u
 		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
 	}
 }
+#endif /* CONFIG_PARAVIRT */
 
 static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
 {
--- linux-2.6-pv.orig/include/asm-i386/io.h
+++ linux-2.6-pv/include/asm-i386/io.h
@@ -256,11 +256,11 @@ static inline void flush_write_buffers(v
 
 #endif /* __KERNEL__ */
 
-#ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
-#else
+#if defined(CONFIG_PARAVIRT)
+#include <asm/paravirt.h>
+#else 
+
 #define __SLOW_DOWN_IO "outb %%al,$0x80;"
-#endif
 
 static inline void slow_down_io(void) {
 	__asm__ __volatile__(
@@ -271,6 +271,8 @@ static inline void slow_down_io(void) {
 		: : );
 }
 
+#endif
+
 #ifdef CONFIG_X86_NUMAQ
 extern void *xquad_portio;    /* Where the IO area was mapped */
 #define XQUAD_PORT_ADDR(port, quad) (xquad_portio + (XQUAD_PORTIO_QUAD*quad) + port)
--- linux-2.6-pv.orig/include/asm-i386/irq.h
+++ linux-2.6-pv/include/asm-i386/irq.h
@@ -41,4 +41,14 @@ extern int irqbalance_disable(char *str)
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+void __init native_init_IRQ(void);
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+static inline void init_IRQ(void)
+{
+	native_init_IRQ();
+}
+#endif /* CONFIG_PARAVIRT */
+
 #endif /* _ASM_IRQ_H */
--- linux-2.6-pv.orig/include/asm-i386/irqflags.h
+++ linux-2.6-pv/include/asm-i386/irqflags.h
@@ -10,6 +10,9 @@
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #ifndef __ASSEMBLY__
 
 static inline unsigned long __raw_local_save_flags(void)
@@ -25,9 +28,6 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 
-#define raw_local_save_flags(flags) \
-		do { (flags) = __raw_local_save_flags(); } while (0)
-
 static inline void raw_local_irq_restore(unsigned long flags)
 {
 	__asm__ __volatile__(
@@ -66,18 +66,6 @@ static inline void halt(void)
 	__asm__ __volatile__("hlt": : :"memory");
 }
 
-static inline int raw_irqs_disabled_flags(unsigned long flags)
-{
-	return !(flags & (1 << 9));
-}
-
-static inline int raw_irqs_disabled(void)
-{
-	unsigned long flags = __raw_local_save_flags();
-
-	return raw_irqs_disabled_flags(flags);
-}
-
 /*
  * For spinlocks, etc:
  */
@@ -90,9 +78,33 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 
+#else
+#define DISABLE_INTERRUPTS		cli
+#define ENABLE_INTERRUPTS		sti
+#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
+#define INTERRUPT_RETURN		iret
+#define GET_CR0_INTO_EAX		movl %cr0, %eax
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef __ASSEMBLY__
+#define raw_local_save_flags(flags) \
+		do { (flags) = __raw_local_save_flags(); } while (0)
+
 #define raw_local_irq_save(flags) \
 		do { (flags) = __raw_local_irq_save(); } while (0)
 
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	return raw_irqs_disabled_flags(flags);
+}
 #endif /* __ASSEMBLY__ */
 
 /*
--- linux-2.6-pv.orig/include/asm-i386/mach-default/setup_arch.h
+++ linux-2.6-pv/include/asm-i386/mach-default/setup_arch.h
@@ -2,4 +2,6 @@
 
 /* no action for generic */
 
+#ifndef ARCH_SETUP
 #define ARCH_SETUP
+#endif
--- linux-2.6-pv.orig/include/asm-i386/msr.h
+++ linux-2.6-pv/include/asm-i386/msr.h
@@ -1,6 +1,10 @@
 #ifndef __ASM_MSR_H
 #define __ASM_MSR_H
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -77,6 +81,7 @@ static inline void wrmsrl (unsigned long
      __asm__ __volatile__("rdpmc" \
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
+#endif	/* !CONFIG_PARAVIRT */
 
 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
--- linux-2.6-pv.orig/include/asm-i386/processor.h
+++ linux-2.6-pv/include/asm-i386/processor.h
@@ -146,8 +146,8 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
+static inline fastcall void native_cpuid(unsigned int *eax, unsigned int *ebx,
+					 unsigned int *ecx, unsigned int *edx)
 {
 	/* ecx is often an input as well as an output. */
 	__asm__("cpuid"
@@ -548,6 +548,12 @@ static inline void rep_nop(void)
 
 #define cpu_relax()	rep_nop()
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define paravirt_enabled() 0
+#define __cpuid native_cpuid
+
 static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
 {
 	tss->esp0 = thread->esp0;
@@ -570,10 +576,13 @@ static inline void load_esp0(struct tss_
 			: /* no output */			\
 			:"r" (value))
 
+#define set_iopl_mask native_set_iopl_mask
+#endif /* CONFIG_PARAVIRT */
+
 /*
  * Set IOPL bits in EFLAGS from given mask
  */
-static inline void set_iopl_mask(unsigned mask)
+static fastcall inline void native_set_iopl_mask(unsigned mask)
 {
 	unsigned int reg;
 	__asm__ __volatile__ ("pushfl;"
--- linux-2.6-pv.orig/include/asm-i386/segment.h
+++ linux-2.6-pv/include/asm-i386/segment.h
@@ -131,5 +131,7 @@
 #define SEGMENT_LDT		0x4
 #define SEGMENT_GDT		0x0
 
+#ifndef CONFIG_PARAVIRT
 #define get_kernel_rpl()  0
 #endif
+#endif
--- linux-2.6-pv.orig/include/asm-i386/setup.h
+++ linux-2.6-pv/include/asm-i386/setup.h
@@ -70,6 +70,14 @@ extern unsigned char boot_params[PARAM_S
 struct e820entry;
 
 char * __init machine_specific_memory_setup(void);
+#ifndef CONFIG_PARAVIRT
+static inline char *memory_setup(void)
+{
+	return machine_specific_memory_setup();
+}
+#else
+#include <asm/paravirt.h>
+#endif
 
 int __init copy_e820_map(struct e820entry * biosmap, int nr_map);
 int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map);
--- linux-2.6-pv.orig/include/asm-i386/spinlock.h
+++ linux-2.6-pv/include/asm-i386/spinlock.h
@@ -7,8 +7,12 @@
 #include <asm/processor.h>
 #include <linux/compiler.h>
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
+#endif /* CONFIG_PARAVIRT */
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
--- linux-2.6-pv.orig/include/asm-i386/system.h
+++ linux-2.6-pv/include/asm-i386/system.h
@@ -88,6 +88,9 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define read_cr0() ({ \
 	unsigned int __dummy; \
 	__asm__ __volatile__( \
@@ -139,17 +142,18 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define write_cr4(x) \
 	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
 
-/*
- * Clear and set 'TS' bit respectively
- */
+#define wbinvd() \
+	__asm__ __volatile__ ("wbinvd": : :"memory")
+
+/* Clear the 'TS' bit */
 #define clts() __asm__ __volatile__ ("clts")
+#endif/* CONFIG_PARAVIRT */
+
+/* Set the 'TS' bit */
 #define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
 
-#define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory")
-
 static inline unsigned long get_limit(unsigned long segment)
 {
 	unsigned long __limit;
--- /dev/null
+++ linux-2.6-pv/arch/i386/kernel/paravirt.c
@@ -0,0 +1,410 @@
+/*  Paravirtualization interfaces
+    Copyright (C) 2006 Rusty Russell IBM Corporation
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+*/
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/efi.h>
+#include <linux/bcd.h>
+
+#include <asm/bug.h>
+#include <asm/paravirt.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/arch_hooks.h>
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/delay.h>
+
+/* nop stub */
+static void native_nop(void)
+{
+}
+
+static void __init default_banner(void)
+{
+	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
+	       paravirt_ops.name);
+}
+
+static fastcall unsigned long native_get_debugreg(int regno)
+{
+	unsigned long val = 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		asm("movl %%db0, %0" :"=r" (val)); break;
+	case 1:
+		asm("movl %%db1, %0" :"=r" (val)); break;
+	case 2:
+		asm("movl %%db2, %0" :"=r" (val)); break;
+	case 3:
+		asm("movl %%db3, %0" :"=r" (val)); break;
+	case 6:
+		asm("movl %%db6, %0" :"=r" (val)); break;
+	case 7:
+		asm("movl %%db7, %0" :"=r" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static fastcall void native_set_debugreg(int regno, unsigned long value)
+{
+	switch (regno) {
+	case 0:
+		asm("movl %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		asm("movl %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		asm("movl %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		asm("movl %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		asm("movl %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		asm("movl %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static fastcall void native_clts(void)
+{
+	asm volatile ("clts");
+}
+
+static fastcall unsigned long native_read_cr0(void)
+{
+	unsigned long val;
+	asm volatile("movl %%cr0,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static fastcall void native_write_cr0(unsigned long val)
+{
+	asm volatile("movl %0,%%cr0": :"r" (val));
+}
+
+static fastcall unsigned long native_read_cr2(void)
+{
+	unsigned long val;
+	asm volatile("movl %%cr2,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static fastcall void native_write_cr2(unsigned long val)
+{
+	asm volatile("movl %0,%%cr2": :"r" (val));
+}
+
+static fastcall unsigned long native_read_cr3(void)
+{
+	unsigned long val;
+	asm volatile("movl %%cr3,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static fastcall void native_write_cr3(unsigned long val)
+{
+	asm volatile("movl %0,%%cr3": :"r" (val));
+}
+
+static fastcall unsigned long native_read_cr4(void)
+{
+	unsigned long val;
+	asm volatile("movl %%cr4,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static fastcall unsigned long native_read_cr4_safe(void)
+{
+	unsigned long val;
+	/* This could fault if %cr4 does not exist */
+	asm("1: movl %%cr4, %0		\n"
+		"2:				\n"
+		".section __ex_table,\"a\"	\n"
+		".long 1b,2b			\n"
+		".previous			\n"
+		: "=r" (val): "0" (0));
+	return val;
+}
+
+static fastcall void native_write_cr4(unsigned long val)
+{
+	asm volatile("movl %0,%%cr4": :"r" (val));
+}
+
+static fastcall unsigned long native_save_fl(void)
+{
+	unsigned long f;
+	asm volatile("pushfl ; popl %0":"=g" (f): /* no input */);
+	return f;
+}
+
+static fastcall void native_restore_fl(unsigned long f)
+{
+	asm volatile("pushl %0 ; popfl": /* no output */
+			     :"g" (f)
+			     :"memory", "cc");
+}
+
+static fastcall void native_irq_disable(void)
+{
+	asm volatile("cli": : :"memory");
+}
+
+static fastcall void native_irq_enable(void)
+{
+	asm volatile("sti": : :"memory");
+}
+
+static fastcall void native_safe_halt(void)
+{
+	asm volatile("sti; hlt": : :"memory");
+}
+
+static fastcall void native_halt(void)
+{
+	asm volatile("hlt": : :"memory");
+}
+
+static fastcall void native_wbinvd(void)
+{
+	asm volatile("wbinvd": : :"memory");
+}
+
+static fastcall unsigned long long native_read_msr(unsigned int msr, int *err)
+{
+	unsigned long long val;
+
+	asm volatile("2: rdmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %3,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 4\n\t"
+		     "   .long 	2b,3b\n\t"
+		     ".previous"
+		     : "=r" (*err), "=A" (val)
+		     : "c" (msr), "i" (-EFAULT));
+
+	return val;
+}
+
+static fastcall int native_write_msr(unsigned int msr, unsigned long long val)
+{
+	int err;
+	asm volatile("2: wrmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %4,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 4\n\t"
+		     "   .long 	2b,3b\n\t"
+		     ".previous"
+		     : "=a" (err)
+		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val>>32)),
+		       "i" (-EFAULT));
+	return err;
+}
+
+static fastcall unsigned long long native_read_tsc(void)
+{
+	unsigned long long val;
+	asm volatile("rdtsc" : "=A" (val));
+	return val;
+}
+
+static fastcall unsigned long long native_read_pmc(void)
+{
+	unsigned long long val;
+	asm volatile("rdpmc" : "=A" (val));
+	return val;
+}
+
+static fastcall void native_load_tr_desc(void)
+{
+	asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
+}
+
+static fastcall void native_set_ldt(const void *addr, unsigned int entries)
+{
+	if (likely(entries == 0))
+		__asm__ __volatile__("lldt %w0"::"q" (0));
+	else {
+		unsigned cpu = smp_processor_id();
+		__u32 a, b;
+
+		pack_descriptor(&a, &b, (unsigned long)addr,
+				entries * sizeof(struct desc_struct) - 1,
+				DESCTYPE_LDT, 0);
+		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
+		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
+	} 
+}
+
+static fastcall void native_load_gdt(const struct Xgt_desc_struct *dtr)
+{
+	asm volatile("lgdt %0"::"m" (*dtr));
+}
+
+static fastcall void native_load_idt(const struct Xgt_desc_struct *dtr)
+{
+	asm volatile("lidt %0"::"m" (*dtr));
+}
+
+static fastcall void native_store_gdt(struct Xgt_desc_struct *dtr)
+{
+	asm ("sgdt %0":"=m" (*dtr));
+}
+
+static fastcall void native_store_idt(struct Xgt_desc_struct *dtr)
+{
+	asm ("sidt %0":"=m" (*dtr));
+}
+
+static fastcall unsigned long native_store_tr(void)
+{
+	unsigned long tr;
+	asm ("str %0":"=r" (tr));
+	return tr;
+}
+
+static fastcall void native_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+static inline void native_write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
+{
+	u32 *lp = (u32 *)((char *)dt + entry*8);
+	lp[0] = entry_low;
+	lp[1] = entry_high;
+}
+
+static fastcall void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static fastcall void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static fastcall void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static fastcall void native_load_esp0(struct tss_struct *tss,
+				      struct thread_struct *thread)
+{
+	tss->esp0 = thread->esp0;
+
+	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
+	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
+		tss->ss1 = thread->sysenter_cs;
+		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	}
+}
+
+static fastcall void native_io_delay(void)
+{
+	asm volatile("outb %al,$0x80");
+}
+
+/* These are in entry.S */
+extern fastcall void native_iret(void);
+extern fastcall void native_irq_enable_sysexit(void);
+
+static int __init print_banner(void)
+{
+	paravirt_ops.banner();
+	return 0;
+}
+core_initcall(print_banner);
+ 
+struct paravirt_ops paravirt_ops = {
+	.name = "bare hardware",
+	.paravirt_enabled = 0,
+	.kernel_rpl = 0,
+
+	.banner = default_banner,
+	.arch_setup = native_nop,
+	.memory_setup = machine_specific_memory_setup,
+	.get_wallclock = native_get_wallclock,
+	.set_wallclock = native_set_wallclock,
+	.time_init = time_init_hook,
+	.init_IRQ = native_init_IRQ,
+
+	.cpuid = native_cpuid,
+	.get_debugreg = native_get_debugreg,
+	.set_debugreg = native_set_debugreg,
+	.clts = native_clts,
+	.read_cr0 = native_read_cr0,
+	.write_cr0 = native_write_cr0,
+	.read_cr2 = native_read_cr2,
+	.write_cr2 = native_write_cr2,
+	.read_cr3 = native_read_cr3,
+	.write_cr3 = native_write_cr3,
+	.read_cr4 = native_read_cr4,
+	.read_cr4_safe = native_read_cr4_safe,
+	.write_cr4 = native_write_cr4,
+	.save_fl = native_save_fl,
+	.restore_fl = native_restore_fl,
+	.irq_disable = native_irq_disable,
+	.irq_enable = native_irq_enable,
+	.safe_halt = native_safe_halt,
+	.halt = native_halt,
+	.wbinvd = native_wbinvd,
+	.read_msr = native_read_msr,
+	.write_msr = native_write_msr,
+	.read_tsc = native_read_tsc,
+	.read_pmc = native_read_pmc,
+	.load_tr_desc = native_load_tr_desc,
+	.set_ldt = native_set_ldt,
+	.load_gdt = native_load_gdt,
+	.load_idt = native_load_idt,
+	.store_gdt = native_store_gdt,
+	.store_idt = native_store_idt,
+	.store_tr = native_store_tr,
+	.load_tls = native_load_tls,
+	.write_ldt_entry = native_write_ldt_entry,
+	.write_gdt_entry = native_write_gdt_entry,
+	.write_idt_entry = native_write_idt_entry,
+	.load_esp0 = native_load_esp0,
+
+	.set_iopl_mask = native_set_iopl_mask,
+	.io_delay = native_io_delay,
+	.const_udelay = __const_udelay,
+
+	.irq_enable_sysexit = native_irq_enable_sysexit,
+	.iret = native_iret,
+};
+EXPORT_SYMBOL(paravirt_ops);
--- /dev/null
+++ linux-2.6-pv/include/asm-i386/paravirt.h
@@ -0,0 +1,291 @@
+#ifndef __ASM_PARAVIRT_H
+#define __ASM_PARAVIRT_H
+/* Various instructions on x86 need to be replaced for
+ * para-virtualization: those hooks are defined here. */
+#include <linux/linkage.h>
+
+#ifdef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+struct thread_struct;
+struct Xgt_desc_struct;
+struct tss_struct;
+struct paravirt_ops
+{
+	unsigned int kernel_rpl;
+ 	int paravirt_enabled;
+	const char *name;
+
+	void (*arch_setup)(void);
+	char *(*memory_setup)(void);
+	void (*init_IRQ)(void);
+
+	void (*banner)(void);
+
+	unsigned long (*get_wallclock)(void);
+	int (*set_wallclock)(unsigned long);
+	void (*time_init)(void);
+
+	/* All the function pointers here are declared as "fastcall"
+	   so that we get a specific register-based calling
+	   convention.  This makes it easier to implement inline
+	   assembler replacements. */
+
+	void (fastcall *cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	unsigned long (fastcall *get_debugreg)(int regno);
+	void (fastcall *set_debugreg)(int regno, unsigned long value);
+
+	void (fastcall *clts)(void);
+
+	unsigned long (fastcall *read_cr0)(void);
+	void (fastcall *write_cr0)(unsigned long);
+
+	unsigned long (fastcall *read_cr2)(void);
+	void (fastcall *write_cr2)(unsigned long);
+
+	unsigned long (fastcall *read_cr3)(void);
+	void (fastcall *write_cr3)(unsigned long);
+
+	unsigned long (fastcall *read_cr4_safe)(void);
+	unsigned long (fastcall *read_cr4)(void);
+	void (fastcall *write_cr4)(unsigned long);
+
+	unsigned long (fastcall *save_fl)(void);
+	void (fastcall *restore_fl)(unsigned long);
+	void (fastcall *irq_disable)(void);
+	void (fastcall *irq_enable)(void);
+	void (fastcall *safe_halt)(void);
+	void (fastcall *halt)(void);
+	void (fastcall *wbinvd)(void);
+
+	/* err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+	u64 (fastcall *read_msr)(unsigned int msr, int *err);
+	int (fastcall *write_msr)(unsigned int msr, u64 val);
+
+	u64 (fastcall *read_tsc)(void);
+	u64 (fastcall *read_pmc)(void);
+
+	void (fastcall *load_tr_desc)(void);
+	void (fastcall *load_gdt)(const struct Xgt_desc_struct *);
+	void (fastcall *load_idt)(const struct Xgt_desc_struct *);
+	void (fastcall *store_gdt)(struct Xgt_desc_struct *);
+	void (fastcall *store_idt)(struct Xgt_desc_struct *);
+	void (fastcall *set_ldt)(const void *desc, unsigned entries);
+	unsigned long (fastcall *store_tr)(void);
+	void (fastcall *load_tls)(struct thread_struct *t, unsigned int cpu);
+	void (fastcall *write_ldt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (fastcall *write_gdt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (fastcall *write_idt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (fastcall *load_esp0)(struct tss_struct *tss,
+				   struct thread_struct *thread);
+
+	void (fastcall *set_iopl_mask)(unsigned mask);
+
+	void (fastcall *io_delay)(void);
+	void (*const_udelay)(unsigned long loops);
+
+	/* These two are jmp to, not actually called. */
+	void (fastcall *irq_enable_sysexit)(void);
+	void (fastcall *iret)(void);
+};
+
+extern struct paravirt_ops paravirt_ops;
+
+#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
+
+static inline void init_IRQ(void)
+{
+	paravirt_ops.init_IRQ();
+}
+
+static inline void load_esp0(struct tss_struct *tss,
+			     struct thread_struct *thread)
+{
+	paravirt_ops.load_esp0(tss, thread);
+}
+
+#define ARCH_SETUP			paravirt_ops.arch_setup();
+static inline char *memory_setup(void)
+{
+	return paravirt_ops.memory_setup();
+}
+
+static inline unsigned long get_wallclock(void)
+{
+	return paravirt_ops.get_wallclock();
+}
+
+static inline int set_wallclock(unsigned long nowtime)
+{
+	return paravirt_ops.set_wallclock(nowtime);
+}
+
+static inline void do_time_init(void)
+{
+	return paravirt_ops.time_init();
+}
+
+/* The paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
+#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
+
+#define clts() paravirt_ops.clts()
+
+#define read_cr0() paravirt_ops.read_cr0()
+#define write_cr0(x) paravirt_ops.write_cr0(x)
+
+#define read_cr2() paravirt_ops.read_cr2()
+#define write_cr2(x) paravirt_ops.write_cr2(x)
+
+#define read_cr3() paravirt_ops.read_cr3()
+#define write_cr3(x) paravirt_ops.write_cr3(x)
+
+#define read_cr4() paravirt_ops.read_cr4()
+#define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
+#define write_cr4(x) paravirt_ops.write_cr4(x)
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	return paravirt_ops.save_fl();
+}
+
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	return paravirt_ops.restore_fl(flags);
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	paravirt_ops.irq_disable();
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	paravirt_ops.irq_enable();
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long flags = paravirt_ops.save_fl();
+
+	paravirt_ops.irq_disable();
+
+	return flags;
+}
+
+static inline void raw_safe_halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+
+static inline void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+#define wbinvd() paravirt_ops.wbinvd()
+
+#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+
+#define rdmsr(msr,val1,val2) do {				\
+	int _err;						\
+	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	val1 = (u32)_l;						\
+	val2 = _l >> 32;					\
+} while(0)
+
+#define wrmsr(msr,val1,val2) do {				\
+	u64 _l = ((u64)(val2) << 32) | (val1);			\
+	paravirt_ops.write_msr((msr), _l);			\
+} while(0)
+
+#define rdmsrl(msr,val) do {					\
+	int _err;						\
+	val = paravirt_ops.read_msr((msr),&_err);		\
+} while(0)
+
+#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+#define wrmsr_safe(msr,a,b) ({					\
+	u64 _l = ((u64)(b) << 32) | (a);			\
+	paravirt_ops.write_msr((msr),_l);			\
+})
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({					\
+	int _err;						\
+	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	(*a) = (u32)_l;						\
+	(*b) = _l >> 32;					\
+	_err; })
+
+#define rdtsc(low,high) do {					\
+	u64 _l = paravirt_ops.read_tsc();			\
+	low = (u32)_l;						\
+	high = _l >> 32;					\
+} while(0)
+
+#define rdtscl(low) do {					\
+	u64 _l = paravirt_ops.read_tsc();			\
+	low = (int)_l;						\
+} while(0)
+
+#define rdtscll(val) (val = paravirt_ops.read_tsc())
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) do {				\
+	u64 _l = paravirt_ops.read_pmc();			\
+	low = (u32)_l;						\
+	high = _l >> 32;					\
+} while(0)
+
+#define load_TR_desc() (paravirt_ops.load_tr_desc())
+#define load_gdt(dtr) (paravirt_ops.load_gdt(dtr))
+#define load_idt(dtr) (paravirt_ops.load_idt(dtr))
+#define set_ldt(addr, entries) (paravirt_ops.set_ldt((addr), (entries)))
+#define store_gdt(dtr) (paravirt_ops.store_gdt(dtr))
+#define store_idt(dtr) (paravirt_ops.store_idt(dtr))
+#define store_tr(tr) ((tr) = paravirt_ops.store_tr())
+#define load_TLS(t,cpu) (paravirt_ops.load_tls((t),(cpu)))
+#define write_ldt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_ldt_entry((dt), (entry), (low), (high)))
+#define write_gdt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_gdt_entry((dt), (entry), (low), (high)))
+#define write_idt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
+#define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
+  
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void) {
+	paravirt_ops.io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+#endif
+}
+
+#define CLI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax"
+#define STI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax"
+#else  /* __ASSEMBLY__ */
+
+#define INTERRUPT_RETURN	jmp *%cs:paravirt_ops+PARAVIRT_iret
+#define DISABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax
+#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *%cs:paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
+#define ENABLE_INTERRUPTS_SYSEXIT	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit
+#define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+#endif	/* __ASM_PARAVIRT_H */
--- /dev/null
+++ linux-2.6-pv/include/asm-i386/time.h
@@ -0,0 +1,41 @@
+#ifndef _ASMi386_TIME_H
+#define _ASMi386_TIME_H
+
+#include <linux/efi.h>
+#include "mach_time.h"
+
+static inline unsigned long native_get_wallclock(void)
+{
+	unsigned long retval;
+
+	if (efi_enabled)
+		retval = efi_get_time();
+	else
+		retval = mach_get_cmos_time();
+
+	return retval;
+}
+
+static inline int native_set_wallclock(unsigned long nowtime)
+{
+	int retval;
+
+	if (efi_enabled)
+		retval = efi_set_rtc_mmss(nowtime);
+	else
+		retval = mach_set_rtc_mmss(nowtime);
+
+	return retval;
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else /* !CONFIG_PARAVIRT */
+
+#define get_wallclock() native_get_wallclock()
+#define set_wallclock(x) native_set_wallclock(x)
+#define do_time_init() time_init_hook()
+
+#endif /* CONFIG_PARAVIRT */
+
+#endif

--
