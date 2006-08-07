Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWHGEn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWHGEn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 00:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWHGEn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 00:43:59 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:37595 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751012AbWHGEn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 00:43:58 -0400
Subject: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Zachary Amsden <zach@vmware.com>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 14:43:54 +1000
Message-Id: <1154925835.21647.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andrew, please sit these in the -mm tree for cooking)

Create a paravirt.h header for (almost) all the critical operations
which need to be replaced with hypervisor calls.

For the moment, this simply includes no_paravirt.h, where all the
native implementations now live.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -49,6 +49,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/dwarf2.h>
+#include <asm/paravirt.h>
 #include "irq_vectors.h"
 
 #define nr_syscalls ((syscall_table_size)/4)
@@ -75,13 +76,6 @@ DF_MASK		= 0x00000400
 DF_MASK		= 0x00000400 
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
-
-/* These are replaces for paravirtualization */
-#define DISABLE_INTERRUPTS		cli
-#define ENABLE_INTERRUPTS		sti
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define INTERRUPT_RETURN		iret
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
 
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
===================================================================
--- a/include/asm-i386/irqflags.h
+++ b/include/asm-i386/irqflags.h
@@ -9,62 +9,12 @@
  */
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
+#include <asm/paravirt.h>
 
 #ifndef __ASSEMBLY__
 
-static inline unsigned long __raw_local_save_flags(void)
-{
-	unsigned long flags;
-
-	__asm__ __volatile__(
-		"pushfl ; popl %0"
-		: "=g" (flags)
-		: /* no input */
-	);
-
-	return flags;
-}
-
 #define raw_local_save_flags(flags) \
 		do { (flags) = __raw_local_save_flags(); } while (0)
-
-static inline void raw_local_irq_restore(unsigned long flags)
-{
-	__asm__ __volatile__(
-		"pushl %0 ; popfl"
-		: /* no output */
-		:"g" (flags)
-		:"memory", "cc"
-	);
-}
-
-static inline void raw_local_irq_disable(void)
-{
-	__asm__ __volatile__("cli" : : : "memory");
-}
-
-static inline void raw_local_irq_enable(void)
-{
-	__asm__ __volatile__("sti" : : : "memory");
-}
-
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static inline void raw_safe_halt(void)
-{
-	__asm__ __volatile__("sti; hlt" : : : "memory");
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static inline void halt(void)
-{
-	__asm__ __volatile__("hlt": : :"memory");
-}
 
 static inline int raw_irqs_disabled_flags(unsigned long flags)
 {
@@ -76,18 +26,6 @@ static inline int raw_irqs_disabled(void
 	unsigned long flags = __raw_local_save_flags();
 
 	return raw_irqs_disabled_flags(flags);
-}
-
-/*
- * For spinlocks, etc:
- */
-static inline unsigned long __raw_local_irq_save(void)
-{
-	unsigned long flags = __raw_local_save_flags();
-
-	raw_local_irq_disable();
-
-	return flags;
 }
 
 #define raw_local_irq_save(flags) \
===================================================================
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -20,6 +20,7 @@
 #include <linux/threads.h>
 #include <asm/percpu.h>
 #include <linux/cpumask.h>
+#include <asm/paravirt.h>
 
 /* flag for disabling the tsc */
 extern int tsc_disable;
@@ -143,18 +144,6 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
-
 /*
  * Generic CPUID function
  * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
@@ -281,13 +270,6 @@ static inline void clear_in_cr4 (unsigne
 	outb((reg), 0x22); \
 	outb((data), 0x23); \
 } while (0)
-
-/* Stop speculative execution */
-static inline void sync_core(void)
-{
-	int tmp;
-	asm volatile("cpuid" : "=a" (tmp) : "0" (1) : "ebx","ecx","edx","memory");
-}
 
 static inline void __monitor(const void *eax, unsigned long ecx,
 		unsigned long edx)
@@ -508,33 +490,6 @@ static inline void load_esp0(struct tss_
 	regs->esp = new_esp;					\
 } while (0)
 
-/*
- * These special macros can be used to get or set a debugging register
- */
-#define get_debugreg(var, register)				\
-		__asm__("movl %%db" #register ", %0"		\
-			:"=r" (var))
-#define set_debugreg(value, register)			\
-		__asm__("movl %0,%%db" #register		\
-			: /* no output */			\
-			:"r" (value))
-
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static inline void set_iopl_mask(unsigned mask)
-{
-	unsigned int reg;
-	__asm__ __volatile__ ("pushfl;"
-			      "popl %0;"
-			      "andl %1, %0;"
-			      "orl %2, %0;"
-			      "pushl %0;"
-			      "popfl"
-				: "=&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
-}
-
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
===================================================================
--- a/include/asm-i386/segment.h
+++ b/include/asm-i386/segment.h
@@ -121,5 +121,4 @@
 /* Bottom three bits of xcs give the ring privilege level */
 #define SEGMENT_RPL_MASK 0x3
 
-#define get_kernel_rpl()  0
 #endif
===================================================================
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -5,6 +5,7 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 #include <linux/compiler.h>
+#include <asm/paravirt.h>
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
@@ -16,9 +17,6 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
-
-#define CLI_STRING	"cli"
-#define STI_STRING	"sti"
 
 #define __raw_spin_is_locked(x) \
 		(*(volatile signed char *)(&(x)->slock) <= 0)
===================================================================
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -5,6 +5,7 @@
 #include <asm/segment.h>
 #include <asm/cpufeature.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
+#include <asm/paravirt.h>
 
 #ifdef __KERNEL__
 
@@ -82,67 +83,10 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
-#define read_cr0() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr0,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr0(x) \
-	__asm__ __volatile__("movl %0,%%cr0": :"r" (x))
-
-#define read_cr2() ({ \
-	unsigned int __dummy; \
-	__asm__ __volatile__( \
-		"movl %%cr2,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr2(x) \
-	__asm__ __volatile__("movl %0,%%cr2": :"r" (x))
-
-#define read_cr3() ({ \
-	unsigned int __dummy; \
-	__asm__ ( \
-		"movl %%cr3,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define write_cr3(x) \
-	__asm__ __volatile__("movl %0,%%cr3": :"r" (x))
-
-#define read_cr4() ({ \
-	unsigned int __dummy; \
-	__asm__( \
-		"movl %%cr4,%0\n\t" \
-		:"=r" (__dummy)); \
-	__dummy; \
-})
-#define read_cr4_safe() ({			      \
-	unsigned int __dummy;			      \
-	/* This could fault if %cr4 does not exist */ \
-	__asm__("1: movl %%cr4, %0		\n"   \
-		"2:				\n"   \
-		".section __ex_table,\"a\"	\n"   \
-		".long 1b,2b			\n"   \
-		".previous			\n"   \
-		: "=r" (__dummy): "0" (0));	      \
-	__dummy;				      \
-})
-#define write_cr4(x) \
-	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
-
-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
+/* Set 'TS' bit */
 #define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
-
-#define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory")
 
 static inline unsigned long get_limit(unsigned long segment)
 {
===================================================================
--- /dev/null
+++ b/include/asm-i386/no_paravirt.h
@@ -0,0 +1,189 @@
+#ifndef __ASM_NO_PARAVIRT_H
+#define __ASM_NO_PARAVIRT_H
+/* This is the native implementation of the paravirtualized
+ * instruction wrappers. */
+
+#ifndef __ASSEMBLY__
+/* The non-paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well: see processor.h. */
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, register)				\
+		__asm__("movl %%db" #register ", %0"		\
+			:"=r" (var))
+#define set_debugreg(value, register)			\
+		__asm__("movl %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static inline void set_iopl_mask(unsigned mask)
+{
+	unsigned int reg;
+	__asm__ __volatile__ ("pushfl;"
+			      "popl %0;"
+			      "andl %1, %0;"
+			      "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=&r" (reg)
+				: "i" (~0x3000 /*X86_EFLAGS_IOPL*/), "r" (mask));
+}
+
+/* Stop speculative execution */
+static inline void sync_core(void)
+{
+	unsigned int eax = 1, ebx, ecx, edx;
+	__cpuid(&eax, &ebx, &ecx, &edx);
+}
+
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
+#define read_cr0() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr0,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr0(x) \
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
+
+#define read_cr2() ({ \
+	unsigned int __dummy; \
+	__asm__ __volatile__( \
+		"movl %%cr2,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr2(x) \
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (x));
+
+#define read_cr3() ({ \
+	unsigned int __dummy; \
+	__asm__ ( \
+		"movl %%cr3,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr3(x) \
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (x));
+
+#define read_cr4() ({ \
+	unsigned int __dummy; \
+	__asm__( \
+		"movl %%cr4,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+
+#define read_cr4_safe() ({			      \
+	unsigned int __dummy;			      \
+	/* This could fault if %cr4 does not exist */ \
+	__asm__("1: movl %%cr4, %0		\n"   \
+		"2:				\n"   \
+		".section __ex_table,\"a\"	\n"   \
+		".long 1b,2b			\n"   \
+		".previous			\n"   \
+		: "=r" (__dummy): "0" (0));	      \
+	__dummy;				      \
+})
+
+#define write_cr4(x) \
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long flags;
+
+	__asm__ __volatile__(
+		"pushfl ; popl %0"
+		: "=g" (flags)
+		: /* no input */
+	);
+
+	return flags;
+}
+
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	__asm__ __volatile__(
+		"pushl %0 ; popfl"
+		: /* no output */
+		:"g" (flags)
+		:"memory", "cc"
+	);
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__("cli" : : : "memory");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	raw_local_irq_disable();
+
+	return flags;
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__("sti" : : : "memory");
+}
+
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static inline void raw_safe_halt(void)
+{
+	__asm__ __volatile__("sti; hlt" : : : "memory");
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static inline void halt(void)
+{
+	__asm__ __volatile__("hlt": : :"memory");
+}
+
+static inline void wbinvd(void)
+{
+	__asm__ __volatile__("wbinvd": : :"memory");
+}
+
+#define get_kernel_rpl()  0
+
+#define CLI_STRING	"cli"
+#define STI_STRING	"sti"
+
+#else  /* ... __ASSEMBLY__ */
+#define INTERRUPT_RETURN		iret
+#define DISABLE_INTERRUPTS		cli
+#define ENABLE_INTERRUPTS		sti
+#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
+#define GET_CR0_INTO_EAX		mov %cr0, %eax
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_NO_PARAVIRT_H */
===================================================================
--- /dev/null
+++ b/include/asm-i386/paravirt.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_PARAVIRT_H
+#define __ASM_PARAVIRT_H
+/* Various instructions on x86 need to be replaced for
+ * para-virtualization: those hooks are defined here. */
+#include <asm/no_paravirt.h>
+
+#endif	/* __ASM_PARAVIRT_H */

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

