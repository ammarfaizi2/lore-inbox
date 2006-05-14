Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWENP4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWENP4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWENP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:56:12 -0400
Received: from [63.81.120.158] ([63.81.120.158]:55506 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751467AbWENP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:56:11 -0400
Date: Sun, 14 May 2006 08:56:01 -0700
Message-Id: <200605141556.k4EFu1iR004703@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt 1/2] arm: add irqflags.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the asm-arm/irqflags.h needed by RT .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/include/asm-arm/irqflags.h
===================================================================
--- /dev/null
+++ linux-2.6.16/include/asm-arm/irqflags.h
@@ -0,0 +1,112 @@
+/*
+ * include/asm-arm/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+/*
+ * CPU interrupt mask handling.
+ */
+#if __LINUX_ARM_ARCH__ >= 6
+
+#define raw_local_irq_save(x)					\
+	({							\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_irq_save\n"	\
+	"cpsid	i"						\
+	: "=r" (x) : : "memory", "cc");				\
+	})
+
+#define raw_local_irq_enable()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
+#define raw_local_irq_disable() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
+
+#else
+
+/*
+ * Save the current interrupt enable state & disable IRQs
+ */
+#define raw_local_irq_save(x)					\
+	({							\
+		unsigned long temp;				\
+		(void) (&temp == &x);				\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_irq_save\n"	\
+"	orr	%1, %0, #128\n"					\
+"	msr	cpsr_c, %1"					\
+	: "=r" (x), "=r" (temp)					\
+	:							\
+	: "memory", "cc");					\
+	})
+
+/*
+ * Enable IRQs
+ */
+#define raw_local_irq_enable()				\
+	({							\
+		unsigned long temp;				\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_irq_enable\n"	\
+"	bic	%0, %0, #128\n"					\
+"	msr	cpsr_c, %0"					\
+	: "=r" (temp)						\
+	:							\
+	: "memory", "cc");					\
+	})
+
+/*
+ * Disable IRQs
+ */
+#define raw_local_irq_disable()				\
+	({							\
+		unsigned long temp;				\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_irq_disable\n"	\
+"	orr	%0, %0, #128\n"					\
+"	msr	cpsr_c, %0"					\
+	: "=r" (temp)						\
+	:							\
+	: "memory", "cc");					\
+	})
+
+
+/*
+ * Save the current interrupt enable state.
+ */
+#define raw_local_save_flags(x)				\
+	({							\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_save_flags"	\
+	: "=r" (x) : : "memory", "cc");				\
+	})
+
+/*
+ * restore saved IRQ & FIQ state
+ */
+#define raw_local_irq_restore(x)				\
+	__asm__ __volatile__(					\
+	"msr	cpsr_c, %0		@ local_irq_restore\n"	\
+	:							\
+	: "r" (x)						\
+	: "memory", "cc")
+
+#define raw_irqs_disabled_flags(flags)	\
+({						\
+	(int)(flags & PSR_I_BIT);		\
+})
+
+#define raw_irqs_disabled()			\
+({						\
+	unsigned long flags;			\
+	raw_local_save_flags(flags);		\
+	raw_irqs_disabled_flags(flags);	\
+})
+
+#endif /* __LINUX_ARM_ARCH__ */
+
+#endif /* _ASM_IRQFLAGS_H */ 
Index: linux-2.6.16/include/asm-arm/system.h
===================================================================
--- linux-2.6.16.orig/include/asm-arm/system.h
+++ linux-2.6.16/include/asm-arm/system.h
@@ -182,72 +182,10 @@ static inline void sched_cacheflush(void
 {
 }
 
-/*
- * CPU interrupt mask handling.
- */
 #if __LINUX_ARM_ARCH__ >= 6
-
-#define raw_local_irq_save(x)					\
-	({							\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
-	"cpsid	i"						\
-	: "=r" (x) : : "memory", "cc");				\
-	})
-
-#define raw_local_irq_enable()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
-#define raw_local_irq_disable() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
 #define raw_local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
 #define raw_local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
-
 #else
-
-/*
- * Save the current interrupt enable state & disable IRQs
- */
-#define raw_local_irq_save(x)					\
-	({							\
-		unsigned long temp;				\
-		(void) (&temp == &x);				\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
-"	orr	%1, %0, #128\n"					\
-"	msr	cpsr_c, %1"					\
-	: "=r" (x), "=r" (temp)					\
-	:							\
-	: "memory", "cc");					\
-	})
-
-/*
- * Enable IRQs
- */
-#define raw_local_irq_enable()				\
-	({							\
-		unsigned long temp;				\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_enable\n"	\
-"	bic	%0, %0, #128\n"					\
-"	msr	cpsr_c, %0"					\
-	: "=r" (temp)						\
-	:							\
-	: "memory", "cc");					\
-	})
-
-/*
- * Disable IRQs
- */
-#define raw_local_irq_disable()				\
-	({							\
-		unsigned long temp;				\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_disable\n"	\
-"	orr	%0, %0, #128\n"					\
-"	msr	cpsr_c, %0"					\
-	: "=r" (temp)						\
-	:							\
-	: "memory", "cc");					\
-	})
-
 /*
  * Enable FIQs
  */
@@ -280,38 +218,6 @@ static inline void sched_cacheflush(void
 
 #endif
 
-/*
- * Save the current interrupt enable state.
- */
-#define raw_local_save_flags(x)				\
-	({							\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_save_flags"	\
-	: "=r" (x) : : "memory", "cc");				\
-	})
-
-/*
- * restore saved IRQ & FIQ state
- */
-#define raw_local_irq_restore(x)				\
-	__asm__ __volatile__(					\
-	"msr	cpsr_c, %0		@ local_irq_restore\n"	\
-	:							\
-	: "r" (x)						\
-	: "memory", "cc")
-
-#define raw_irqs_disabled_flags(flags)	\
-({						\
-	(int)(flags & PSR_I_BIT);		\
-})
-
-#define raw_irqs_disabled()			\
-({						\
-	unsigned long flags;			\
-	raw_local_save_flags(flags);		\
-	raw_irqs_disabled_flags(flags);	\
-})
-
 #include <linux/trace_irqflags.h>
 
 #ifdef CONFIG_SMP
