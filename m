Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312734AbSDFUFW>; Sat, 6 Apr 2002 15:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312748AbSDFUFW>; Sat, 6 Apr 2002 15:05:22 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:39378 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312734AbSDFUFS>; Sat, 6 Apr 2002 15:05:18 -0500
Message-ID: <3CAF54AA.1020303@didntduck.org>
Date: Sat, 06 Apr 2002 15:03:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up x86 interrupt entry code
Content-Type: multipart/mixed;
 boundary="------------000900000609020005050902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900000609020005050902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves the generation of the asm interrupt entry stubs from 
i8259.c to entry.S.  This allows it to be done with less code and 
without needing duplicate definitions of SAVE_ALL, GET_CURRENT, etc.

-- 

						Brian Gerst

--------------000900000609020005050902
Content-Type: text/plain;
 name="intentry-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intentry-2"

diff -urN linux-2.5.8-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8-pre2/arch/i386/kernel/entry.S	Sat Apr  6 11:47:52 2002
+++ linux/arch/i386/kernel/entry.S	Sat Apr  6 12:58:37 2002
@@ -47,6 +47,7 @@
 #include <asm/errno.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/irq_vectors.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -94,12 +95,12 @@
 
 #ifdef CONFIG_PREEMPT
 #define preempt_stop cli
-#define init_ret_intr \
-	cli; \
-	decl TI_PRE_COUNT(%ebx);
+#define INC_PRE_COUNT(reg) incl TI_PRE_COUNT(reg);
+#define DEC_PRE_COUNT(reg) decl TI_PRE_COUNT(reg);
 #else
 #define preempt_stop
-#define init_ret_intr
+#define INC_PRE_COUNT(reg)
+#define DEC_PRE_COUNT(reg)
 #define resume_kernel restore_all
 #endif
 
@@ -210,9 +211,9 @@
 
 	# userspace resumption stub bypassing syscall exit tracing
 	ALIGN
-ENTRY(ret_from_intr)
-	GET_THREAD_INFO(%ebx)
-	init_ret_intr
+ret_from_intr:
+	preempt_stop
+	DEC_PRE_COUNT(%ebx)
 ret_from_exception:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
@@ -335,6 +336,67 @@
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
+/*
+ * Build the entry stubs and pointer table with
+ * some assembler magic.
+ */
+.data
+ENTRY(interrupt)
+.text
+
+vector=0
+ENTRY(irq_entries_start)
+.rept NR_IRQS
+	ALIGN
+1:	pushl $vector-256
+	jmp common_interrupt
+.data
+	.long 1b
+.text
+vector=vector+1
+.endr
+
+	ALIGN
+common_interrupt:
+	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+	INC_PRE_COUNT(%ebx)
+	call SYMBOL_NAME(do_IRQ)
+	jmp ret_from_intr
+
+#define BUILD_INTERRUPT(name, nr)	\
+ENTRY(name)				\
+	pushl $nr-256;			\
+	SAVE_ALL			\
+	GET_THREAD_INFO(%ebx);		\
+	INC_PRE_COUNT(%ebx)		\
+	call SYMBOL_NAME(smp_/**/name);	\
+	jmp ret_from_intr;
+
+/*
+ * The following vectors are part of the Linux architecture, there
+ * is no hardware IRQ pin equivalent for them, they are triggered
+ * through the ICC by us (IPIs)
+ */
+#ifdef CONFIG_SMP
+BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
+BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
+BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
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
+BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+#endif
+
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $ SYMBOL_NAME(do_divide_error)
diff -urN linux-2.5.8-pre2/arch/i386/kernel/i8259.c linux/arch/i386/kernel/i8259.c
--- linux-2.5.8-pre2/arch/i386/kernel/i8259.c	Thu Mar  7 21:18:57 2002
+++ linux/arch/i386/kernel/i8259.c	Sat Apr  6 11:48:15 2002
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
-BUILD_SMP_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
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
diff -urN linux-2.5.8-pre2/arch/i386/kernel/io_apic.c linux/arch/i386/kernel/io_apic.c
--- linux-2.5.8-pre2/arch/i386/kernel/io_apic.c	Thu Mar  7 21:18:23 2002
+++ linux/arch/i386/kernel/io_apic.c	Sat Apr  6 11:48:15 2002
@@ -597,7 +597,6 @@
 	return current_vector;
 }
 
-extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
diff -urN linux-2.5.8-pre2/include/asm-i386/hw_irq.h linux/include/asm-i386/hw_irq.h
--- linux-2.5.8-pre2/include/asm-i386/hw_irq.h	Sat Apr  6 11:47:54 2002
+++ linux/include/asm-i386/hw_irq.h	Sat Apr  6 13:06:17 2002
@@ -17,57 +17,28 @@
 #include <asm/irq.h>
 
 /*
- * IDT vectors usable for external interrupt sources start
- * at 0x20:
- */
-#define FIRST_EXTERNAL_VECTOR	0x20
-
-#define SYSCALL_VECTOR		0x80
-
-/*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/*
- * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
- *
- *  some of the following vectors are 'rare', they are merged
- *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
- *  TLB, reschedule and local APIC vectors are performance-critical.
+ * Various low-level irq details needed by irq.c, process.c,
+ * time.c, io_apic.c and smp.c
  *
- *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
- */
-#define SPURIOUS_APIC_VECTOR	0xff
-#define ERROR_APIC_VECTOR	0xfe
-#define INVALIDATE_TLB_VECTOR	0xfd
-#define RESCHEDULE_VECTOR	0xfc
-#define CALL_FUNCTION_VECTOR	0xfb
-
-#define THERMAL_APIC_VECTOR	0xf0
-/*
- * Local APIC timer IRQ vector is on a different priority level,
- * to work around the 'lost local interrupt if more than 2 IRQ
- * sources per level' errata.
- */
-#define LOCAL_TIMER_VECTOR	0xef
-
-/*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
- * levels. (0x80 is the syscall vector)
+ * Interrupt entry/exit code at both C and assembly level
  */
-#define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
 
 extern int irq_vector[NR_IRQS];
 #define IO_APIC_VECTOR(irq)	irq_vector[irq]
 
-/*
- * Various low-level irq details needed by irq.c, process.c,
- * time.c, io_apic.c and smp.c
- *
- * Interrupt entry/exit code at both C and assembly level
- */
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
 
 extern void mask_irq(unsigned int irq);
 extern void unmask_irq(unsigned int irq);
@@ -93,92 +64,6 @@
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
-#define __STR(x) #x
-#define STR(x) __STR(x)
-
-#define GET_THREAD_INFO \
-	"movl $-8192, %ebx\n\t" \
-	"andl %esp, %ebx\n\t"
-
-#ifdef CONFIG_PREEMPT
-#define BUMP_LOCK_COUNT \
-	GET_THREAD_INFO \
-	"incl 16(%ebx)\n\t"
-#else
-#define BUMP_LOCK_COUNT
-#endif
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
-	"movl %edx,%es\n\t" \
-	BUMP_LOCK_COUNT
-
-#define IRQ_NAME2(nr) nr##_interrupt(void)
-#define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
-
-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t" \
-	"movl (%ebx),%ebx\n\t"
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
diff -urN linux-2.5.8-pre2/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux-2.5.8-pre2/include/asm-i386/irq.h	Sat Apr  6 11:47:54 2002
+++ linux/include/asm-i386/irq.h	Sat Apr  6 13:06:17 2002
@@ -12,23 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
-
-#define TIMER_IRQ 0
-
-/*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
- * Right now the APIC is mostly only used for SMP.
- * 256 vectors is an architectural limit. (we can have
- * more than 256 devices theoretically, but they will
- * have to use shared interrupts)
- * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
- */
-#ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
-#else
-#define NR_IRQS 16
-#endif
+#include <asm/irq_vectors.h>
 
 static __inline__ int irq_cannonicalize(int irq)
 {
diff -urN linux-2.5.8-pre2/include/asm-i386/irq_vectors.h linux/include/asm-i386/irq_vectors.h
--- linux-2.5.8-pre2/include/asm-i386/irq_vectors.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-i386/irq_vectors.h	Sat Apr  6 13:06:17 2002
@@ -0,0 +1,64 @@
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#ifdef CONFIG_X86_IO_APIC
+#define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#endif /* _ASM_IRQ_VECTORS_H */

--------------000900000609020005050902--

