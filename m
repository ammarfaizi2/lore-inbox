Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRLDE10>; Mon, 3 Dec 2001 23:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLDE1I>; Mon, 3 Dec 2001 23:27:08 -0500
Received: from quark.didntduck.org ([216.43.55.190]:11786 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S280434AbRLDE1F>; Mon, 3 Dec 2001 23:27:05 -0500
Message-ID: <3C0C4FB6.CAFC40D0@didntduck.org>
Date: Mon, 03 Dec 2001 23:23:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre5-bg1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 interrupt entry cleanup
Content-Type: multipart/mixed;
 boundary="------------CEC75A7877D2F10FC760C781"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CEC75A7877D2F10FC760C781
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch cleans up the creation of the interrupt entry asm stubs,
moving them to their proper place in entry.S.  Note that the old code
put the stubs in the .data section instead on the .text section.

-- 

						Brian Gerst
--------------CEC75A7877D2F10FC760C781
Content-Type: text/plain; charset=us-ascii;
 name="diff-intentry"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-intentry"

diff -urN linux-2.5.1-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.1-pre2/arch/i386/kernel/entry.S	Fri Nov  2 20:18:49 2001
+++ linux/arch/i386/kernel/entry.S	Thu Nov 29 01:00:17 2001
@@ -45,6 +45,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/hw_irq.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -132,6 +133,9 @@
 	movl $-8192, reg; \
 	andl %esp, reg
 
+/*
+ * Call gate entry points
+ */
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
@@ -185,6 +189,8 @@
 	jmp	ret_from_sys_call
 
 /*
+ * System call entry point (int $0x80)
+ *
  * Return to user mode is not as complex as all this looks,
  * but we want the default path for a system call return to
  * go as quickly as possible which is why some of this is
@@ -244,8 +250,15 @@
 	movl $-ENOSYS,EAX(%esp)
 	jmp ret_from_sys_call
 
+/*
+ * Interrupt entry points.  orig_eax is used to
+ * specify which vector was called.
+ */
 	ALIGN
-ENTRY(ret_from_intr)
+common_interrupt:
+	SAVE_ALL
+	call SYMBOL_NAME(do_IRQ)
+ret_from_intr:
 	GET_CURRENT(%ebx)
 ret_from_exception:
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
@@ -254,11 +267,74 @@
 	jne ret_from_sys_call
 	jmp restore_all
 
+/*
+ * Build the entries and pointer table with some assembler black magic.
+ */
+.data
+ENTRY(interrupt)
+.previous
+
+irq_vector=0
+ENTRY(irq_entries_start)
+.rept NR_IRQS
+	ALIGN
+1:      pushl $irq_vector-256
+	jmp common_interrupt
+.data
+	.long 1b
+.previous
+	irq_vector=irq_vector+1
+.endr
+
+#define BUILD_SMP_INTERRUPT(name, nr)	\
+ENTRY(name)				\
+	pushl $nr-256;			\
+	SAVE_ALL			\
+	call SYMBOL_NAME(smp_/**/name);	\
+	jmp ret_from_intr;
+
+#define BUILD_SMP_TIMER_INTERRUPT(name, nr) \
+ENTRY(name)				\
+	pushl $nr-256;			\
+	SAVE_ALL			\
+	movl %esp,%eax;			\
+	pushl %eax;			\
+	call SYMBOL_NAME(smp_/**/name);	\
+	addl $4,%esp;			\
+	jmp ret_from_intr;
+
+/*
+ * The following vectors are part of the Linux architecture, there
+ * is no hardware IRQ pin equivalent for them, they are triggered
+ * through the ICC by us (IPIs)
+ */
+#ifdef CONFIG_SMP
+BUILD_SMP_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
+BUILD_SMP_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
+BUILD_SMP_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#endif
+
+/*
+ * every pentium local APIC has two 'local interrupts', with a
+ * soft-definable vector attached to both interrupts, one of
+ * which is a timer interrupt, the other one is error counter
+ * overflow. Linux uses the local APIC timer interrupt to get
+ * a much simpler SMP time architecture:
+ */
+#ifdef CONFIG_X86_LOCAL_APIC
+BUILD_SMP_TIMER_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_SMP_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
+BUILD_SMP_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+#endif
+
 	ALIGN
 reschedule:
 	call SYMBOL_NAME(schedule)    # test
 	jmp ret_from_sys_call
 
+/*
+ * Trap and fault entry points
+ */
 ENTRY(divide_error)
 	pushl $0		# no error code
 	pushl $ SYMBOL_NAME(do_divide_error)
diff -urN linux-2.5.1-pre2/arch/i386/kernel/i8259.c linux/arch/i386/kernel/i8259.c
--- linux-2.5.1-pre2/arch/i386/kernel/i8259.c	Tue Sep 18 02:03:09 2001
+++ linux/arch/i386/kernel/i8259.c	Thu Nov 29 00:59:58 2001
@@ -25,102 +25,6 @@
 #include <linux/irq.h>
 
 /*
- * Common place to define all x86 IRQ vectors
- *
- * This builds up the IRQ handler stubs using some ugly macros in irq.h
- *
- * These macros create the low-level assembly IRQ routines that save
- * register context and call do_IRQ(). do_IRQ() then does all the
- * operations that are needed to keep the AT (or SMP IOAPIC)
- * interrupt-controller happy.
- */
-
-BUILD_COMMON_IRQ()
-
-#define BI(x,y) \
-	BUILD_IRQ(x##y)
-
-#define BUILD_16_IRQS(x) \
-	BI(x,0) BI(x,1) BI(x,2) BI(x,3) \
-	BI(x,4) BI(x,5) BI(x,6) BI(x,7) \
-	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
-	BI(x,c) BI(x,d) BI(x,e) BI(x,f)
-
-/*
- * ISA PIC or low IO-APIC triggered (INTA-cycle or APIC) interrupts:
- * (these are usually mapped to vectors 0x20-0x2f)
- */
-BUILD_16_IRQS(0x0)
-
-#ifdef CONFIG_X86_IO_APIC
-/*
- * The IO-APIC gives us many more interrupt sources. Most of these 
- * are unused but an SMP system is supposed to have enough memory ...
- * sometimes (mostly wrt. hw bugs) we get corrupted vectors all
- * across the spectrum, so we really want to be prepared to get all
- * of these. Plus, more powerful systems might have more than 64
- * IO-APIC registers.
- *
- * (these are usually mapped into the 0x30-0xff vector range)
- */
-		   BUILD_16_IRQS(0x1) BUILD_16_IRQS(0x2) BUILD_16_IRQS(0x3)
-BUILD_16_IRQS(0x4) BUILD_16_IRQS(0x5) BUILD_16_IRQS(0x6) BUILD_16_IRQS(0x7)
-BUILD_16_IRQS(0x8) BUILD_16_IRQS(0x9) BUILD_16_IRQS(0xa) BUILD_16_IRQS(0xb)
-BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
-#endif
-
-#undef BUILD_16_IRQS
-#undef BI
-
-
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
-#ifdef CONFIG_SMP
-BUILD_SMP_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-BUILD_SMP_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
-BUILD_SMP_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
-#endif
-
-/*
- * every pentium local APIC has two 'local interrupts', with a
- * soft-definable vector attached to both interrupts, one of
- * which is a timer interrupt, the other one is error counter
- * overflow. Linux uses the local APIC timer interrupt to get
- * a much simpler SMP time architecture:
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-BUILD_SMP_TIMER_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
-BUILD_SMP_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_SMP_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
-#endif
-
-#define IRQ(x,y) \
-	IRQ##x##y##_interrupt
-
-#define IRQLIST_16(x) \
-	IRQ(x,0), IRQ(x,1), IRQ(x,2), IRQ(x,3), \
-	IRQ(x,4), IRQ(x,5), IRQ(x,6), IRQ(x,7), \
-	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
-	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
-
-void (*interrupt[NR_IRQS])(void) = {
-	IRQLIST_16(0x0),
-
-#ifdef CONFIG_X86_IO_APIC
-			 IRQLIST_16(0x1), IRQLIST_16(0x2), IRQLIST_16(0x3),
-	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
-	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
-	IRQLIST_16(0xc), IRQLIST_16(0xd)
-#endif
-};
-
-#undef IRQ
-#undef IRQLIST_16
-
-/*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
  * present in the majority of PC/AT boxes.
  * plus some generic x86 specific things if generic specifics makes
diff -urN linux-2.5.1-pre2/arch/i386/kernel/io_apic.c linux/arch/i386/kernel/io_apic.c
--- linux-2.5.1-pre2/arch/i386/kernel/io_apic.c	Tue Nov 13 20:28:41 2001
+++ linux/arch/i386/kernel/io_apic.c	Thu Nov 29 01:00:07 2001
@@ -577,7 +577,6 @@
 	return current_vector;
 }
 
-extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
diff -urN linux-2.5.1-pre2/include/asm-i386/hw_irq.h linux/include/asm-i386/hw_irq.h
--- linux-2.5.1-pre2/include/asm-i386/hw_irq.h	Sun Nov 25 09:10:27 2001
+++ linux/include/asm-i386/hw_irq.h	Thu Nov 29 01:00:33 2001
@@ -13,7 +13,6 @@
  */
 
 #include <linux/config.h>
-#include <asm/atomic.h>
 #include <asm/irq.h>
 
 /*
@@ -58,9 +57,8 @@
 #define FIRST_DEVICE_VECTOR	0x31
 #define FIRST_SYSTEM_VECTOR	0xef
 
-extern int irq_vector[NR_IRQS];
-#define IO_APIC_VECTOR(irq)	irq_vector[irq]
-
+#ifndef __ASSEMBLY__
+#include <asm/atomic.h>
 /*
  * Various low-level irq details needed by irq.c, process.c,
  * time.c, io_apic.c and smp.c
@@ -68,6 +66,23 @@
  * Interrupt entry/exit code at both C and assembly level
  */
 
+extern int irq_vector[NR_IRQS];
+#define IO_APIC_VECTOR(irq)	irq_vector[irq]
+
+extern void (*interrupt[NR_IRQS])(void);
+
+#ifdef CONFIG_SMP
+extern asmlinkage void reschedule_interrupt(void);
+extern asmlinkage void invalidate_interrupt(void);
+extern asmlinkage void call_function_interrupt(void);
+#endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
+extern asmlinkage void apic_timer_interrupt(void);
+extern asmlinkage void error_interrupt(void);
+extern asmlinkage void spurious_interrupt(void);
+#endif
+
 extern void mask_irq(unsigned int irq);
 extern void unmask_irq(unsigned int irq);
 extern void disable_8259A_irq(unsigned int irq);
@@ -92,94 +107,6 @@
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
-#define __STR(x) #x
-#define STR(x) __STR(x)
-
-#define SAVE_ALL \
-	"cld\n\t" \
-	"pushl %es\n\t" \
-	"pushl %ds\n\t" \
-	"pushl %eax\n\t" \
-	"pushl %ebp\n\t" \
-	"pushl %edi\n\t" \
-	"pushl %esi\n\t" \
-	"pushl %edx\n\t" \
-	"pushl %ecx\n\t" \
-	"pushl %ebx\n\t" \
-	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
-	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
-
-#define IRQ_NAME2(nr) nr##_interrupt(void)
-#define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
-
-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
-
-/*
- *	SMP has a few special interrupts for IPI messages
- */
-
-	/* there is a second layer of macro just to get the symbolic
-	   name for the vector evaluated. This change is for RTLinux */
-#define BUILD_SMP_INTERRUPT(x,v) XBUILD_SMP_INTERRUPT(x,v)
-#define XBUILD_SMP_INTERRUPT(x,v)\
-asmlinkage void x(void); \
-asmlinkage void call_##x(void); \
-__asm__( \
-"\n"__ALIGN_STR"\n" \
-SYMBOL_NAME_STR(x) ":\n\t" \
-	"pushl $"#v"-256\n\t" \
-	SAVE_ALL \
-	SYMBOL_NAME_STR(call_##x)":\n\t" \
-	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
-	"jmp ret_from_intr\n");
-
-#define BUILD_SMP_TIMER_INTERRUPT(x,v) XBUILD_SMP_TIMER_INTERRUPT(x,v)
-#define XBUILD_SMP_TIMER_INTERRUPT(x,v) \
-asmlinkage void x(struct pt_regs * regs); \
-asmlinkage void call_##x(void); \
-__asm__( \
-"\n"__ALIGN_STR"\n" \
-SYMBOL_NAME_STR(x) ":\n\t" \
-	"pushl $"#v"-256\n\t" \
-	SAVE_ALL \
-	"movl %esp,%eax\n\t" \
-	"pushl %eax\n\t" \
-	SYMBOL_NAME_STR(call_##x)":\n\t" \
-	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
-	"addl $4,%esp\n\t" \
-	"jmp ret_from_intr\n");
-
-#define BUILD_COMMON_IRQ() \
-asmlinkage void call_do_IRQ(void); \
-__asm__( \
-	"\n" __ALIGN_STR"\n" \
-	"common_interrupt:\n\t" \
-	SAVE_ALL \
-	SYMBOL_NAME_STR(call_do_IRQ)":\n\t" \
-	"call " SYMBOL_NAME_STR(do_IRQ) "\n\t" \
-	"jmp ret_from_intr\n");
-
-/* 
- * subtle. orig_eax is used by the signal code to distinct between
- * system calls and interrupted 'random user-space'. Thus we have
- * to put a negative value into orig_eax here. (the problem is that
- * both system calls and IRQs want to have small integer numbers in
- * orig_eax, and the syscall code has won the optimization conflict ;)
- *
- * Subtle as a pigs ear.  VY
- */
-
-#define BUILD_IRQ(nr) \
-asmlinkage void IRQ_NAME(nr); \
-__asm__( \
-"\n"__ALIGN_STR"\n" \
-SYMBOL_NAME_STR(IRQ) #nr "_interrupt:\n\t" \
-	"pushl $"#nr"-256\n\t" \
-	"jmp common_interrupt");
-
 extern unsigned long prof_cpu_mask;
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
@@ -221,5 +148,7 @@
 #else
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 #endif
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_HW_IRQ_H */
diff -urN linux-2.5.1-pre2/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux-2.5.1-pre2/include/asm-i386/irq.h	Sun Nov 25 08:23:10 2001
+++ linux/include/asm-i386/irq.h	Thu Nov 29 00:07:05 2001
@@ -23,7 +23,13 @@
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
  * the usable vector space is 0x20-0xff (224 vectors)
  */
+#ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#ifndef __ASSEMBLY__
 
 static __inline__ int irq_cannonicalize(int irq)
 {
@@ -33,6 +39,8 @@
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
+
+#endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */

--------------CEC75A7877D2F10FC760C781--

