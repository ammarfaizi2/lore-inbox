Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbSJBKeZ>; Wed, 2 Oct 2002 06:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbSJBKeZ>; Wed, 2 Oct 2002 06:34:25 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:56504 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263035AbSJBKeR>;
	Wed, 2 Oct 2002 06:34:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alessandro Amici <alexamici@tiscali.it>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37+ i386 arch split broke external module builds
Date: Wed, 2 Oct 2002 12:39:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: James.Bottomley@HansenPartnership.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021002103932.C35A21EA74@alan.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

in order to access the kernel interfaces, modules that live outside the
kernel sources were used to only need:
CFLAG += -I$(TOPDIR)/include

with the i386 arch split merged into 2.5.37 this is not working any more
because: 
#include <linux/interrupt.h>
indirectly includes a file found in one of the arch/i386/mach-* directories
based on the value of CONFIG_VISWS.
at present something along the following code snippet is required by
_any_ external module accessing the interrupt interface:

include $(TOPDIR)/.config

ifdef CONFIG_VISWS
MACHINE	:= mach-visws
else
MACHINE	:= mach-generic
endif

CFLAGS += -I$(TOPDIR)/arch/i386/$(MACHINE)

this is very inconvenient for external module maintainers because:
 - the external build system need to handle CONFIG_VISWS explicitely
 - the kernel-headers packages distributed by vendors (that do not include
      the arch/ direcory) are not sufficient for building external module.

the following patch against 2.5.40 moves the irq_vector.h files inside
include/asm-i386/mach-* and update the two includers to explicitely
choose the right one.

this is not intended to be the cleanest apploach, but it works :)

comments are welcome,
alessandro


diff -urN linux-2.5.40/arch/i386/kernel/entry.S linux-2.5/arch/i386/kernel/entry.S
--- linux-2.5.40/arch/i386/kernel/entry.S	2002-09-22 06:25:00.000000000 +0200
+++ linux-2.5/arch/i386/kernel/entry.S	2002-10-02 10:33:58.000000000 +0200
@@ -47,7 +47,11 @@
 #include <asm/errno.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
-#include "irq_vectors.h"
+#ifdef CONFIG_VISWS
+#include <asm/mach-visws/irq_vectors.h>
+#else
+#include <asm/mach-generic/irq_vectors.h>
+#endif
 
 EBX		= 0x00
 ECX		= 0x04
diff -urN linux-2.5.40/arch/i386/mach-generic/irq_vectors.h linux-2.5/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.40/arch/i386/mach-generic/irq_vectors.h	2002-09-22 06:25:00.000000000 +0200
+++ linux-2.5/arch/i386/mach-generic/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,85 +0,0 @@
-/*
- * This file should contain #defines for all of the interrupt vector
- * numbers used by this architecture.
- *
- * In addition, there are some standard defines:
- *
- *	FIRST_EXTERNAL_VECTOR:
- *		The first free place for external interrupts
- *
- *	SYSCALL_VECTOR:
- *		The IRQ vector a syscall makes the user to kernel transition
- *		under.
- *
- *	TIMER_IRQ:
- *		The IRQ number the timer interrupt comes in at.
- *
- *	NR_IRQS:
- *		The total number of interrupt vectors (including all the
- *		architecture specific interrupts) needed.
- *
- */			
-#ifndef _ASM_IRQ_VECTORS_H
-#define _ASM_IRQ_VECTORS_H
-
-/*
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
- *
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
- */
-#define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
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
-
-#endif /* _ASM_IRQ_VECTORS_H */
diff -urN linux-2.5.40/arch/i386/mach-visws/irq_vectors.h linux-2.5/arch/i386/mach-visws/irq_vectors.h
--- linux-2.5.40/arch/i386/mach-visws/irq_vectors.h	2002-09-22 06:25:00.000000000 +0200
+++ linux-2.5/arch/i386/mach-visws/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,64 +0,0 @@
-#ifndef _ASM_IRQ_VECTORS_H
-#define _ASM_IRQ_VECTORS_H
-
-/*
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
- *
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
- */
-#define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
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
-
-#endif /* _ASM_IRQ_VECTORS_H */
diff -urN linux-2.5.40/include/asm-i386/irq.h linux-2.5/include/asm-i386/irq.h
--- linux-2.5.40/include/asm-i386/irq.h	2002-09-22 06:25:09.000000000 +0200
+++ linux-2.5/include/asm-i386/irq.h	2002-10-02 09:52:16.000000000 +0200
@@ -12,8 +12,11 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
-/* include comes from machine specific directory */
-#include "irq_vectors.h"
+#ifdef CONFIG_VISWS
+#include <asm/mach-visws/irq_vectors.h>
+#else
+#include <asm/mach-generic/irq_vectors.h>
+#endif
 
 static __inline__ int irq_cannonicalize(int irq)
 {
diff -urN linux-2.5.40/include/asm-i386/mach-generic/irq_vectors.h linux-2.5/include/asm-i386/mach-generic/irq_vectors.h
--- linux-2.5.40/include/asm-i386/mach-generic/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/include/asm-i386/mach-generic/irq_vectors.h	2002-09-22 06:25:00.000000000 +0200
@@ -0,0 +1,85 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
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
diff -urN linux-2.5.40/include/asm-i386/mach-visws/irq_vectors.h linux-2.5/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.40/include/asm-i386/mach-visws/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/include/asm-i386/mach-visws/irq_vectors.h	2002-09-22 06:25:00.000000000 +0200
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

