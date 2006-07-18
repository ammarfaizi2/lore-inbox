Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWGRJYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWGRJYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWGRJVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25731 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932137AbWGRJVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:16 -0400
Message-Id: <20060718091951.968462000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:14 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 14/33] subarch support for controlling interrupt delivery
Content-Disposition: inline; filename=i386-interrupt-control
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the code that controls interrupt delivery, and add a separate
subarch implementation for Xen that manipulates a shared-memory event
delivery mask.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/mach-xen/Makefile                   |    2 
 arch/i386/mach-xen/interrupt.c                |   67 +++++++++++++++++++++++++
 include/asm-i386/irqflags.h                   |   61 +---------------------
 include/asm-i386/mach-default/mach_irqflags.h |   64 +++++++++++++++++++++++
 include/asm-i386/mach-default/mach_system.h   |    4 +
 include/asm-i386/mach-xen/mach_irqflags.h     |   29 ++++++++++
 include/asm-i386/mach-xen/mach_system.h       |    5 +
 7 files changed, 174 insertions(+), 58 deletions(-)


diff -r 092b7e56c85d arch/i386/mach-xen/Makefile
--- a/arch/i386/mach-xen/Makefile	Thu Jul 13 14:42:42 2006 -0700
+++ b/arch/i386/mach-xen/Makefile	Thu Jul 13 14:42:42 2006 -0700
@@ -4,6 +4,6 @@
 
 extra-y				:= head.o
 
-obj-y				:= setup.o setup-xen.o memory.o
+obj-y				:= setup.o setup-xen.o memory.o interrupt.o
 
 setup-y				:= ../mach-default/setup.o
diff -r 092b7e56c85d include/asm-i386/irqflags.h
--- a/include/asm-i386/irqflags.h	Thu Jul 13 14:42:42 2006 -0700
+++ b/include/asm-i386/irqflags.h	Thu Jul 13 14:42:42 2006 -0700
@@ -10,66 +10,12 @@
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
+#include <mach_irqflags.h>
+
 #ifndef __ASSEMBLY__
-
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
-
-static inline int raw_irqs_disabled_flags(unsigned long flags)
-{
-	return !(flags & (1 << 9));
-}
 
 static inline int raw_irqs_disabled(void)
 {
@@ -93,7 +39,7 @@ static inline unsigned long __raw_local_
 #define raw_local_irq_save(flags) \
 		do { (flags) = __raw_local_irq_save(); } while (0)
 
-#endif /* __ASSEMBLY__ */
+#endif	/* __ASSEMBLY__ */
 
 /*
  * Do the CPU's IRQ-state tracing from assembly code. We call a
@@ -124,4 +70,5 @@ static inline unsigned long __raw_local_
 # define TRACE_IRQS_OFF
 #endif
 
+
 #endif
diff -r 092b7e56c85d arch/i386/mach-xen/interrupt.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/mach-xen/interrupt.c	Thu Jul 13 16:00:43 2006 -0700
@@ -0,0 +1,67 @@
+#include <linux/preempt.h>
+#include <linux/module.h>
+
+#include <asm/hypervisor.h>
+#include <mach_irqflags.h>
+
+
+/*
+ * The use of 'barrier' in the following reflects their use as local-lock
+ * operations. Reentrancy must be prevented (e.g., __cli()) /before/ following
+ * critical operations are executed. All critical operations must complete
+ * /before/ reentrancy is permitted (e.g., __sti()).
+ */
+unsigned long __raw_local_save_flags(void)
+{
+	struct vcpu_info *_vcpu;
+	unsigned long flags;
+
+	preempt_disable();
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];
+	flags = _vcpu->evtchn_upcall_mask;
+	preempt_enable();
+
+	return flags;
+}
+EXPORT_SYMBOL(__raw_local_save_flags);
+
+void raw_local_irq_restore(unsigned long flags)
+{
+	struct vcpu_info *_vcpu;
+
+	preempt_disable();
+
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];
+	if ((_vcpu->evtchn_upcall_mask = flags) == 0) {
+		barrier(); /* unmask then check (avoid races) */
+		if (unlikely(_vcpu->evtchn_upcall_pending))
+			force_evtchn_callback();
+		preempt_enable();
+	} else
+		preempt_enable_no_resched();
+}
+EXPORT_SYMBOL(raw_local_irq_restore);
+
+void raw_local_irq_disable(void)
+{
+	struct vcpu_info *_vcpu;
+	preempt_disable();
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];
+	_vcpu->evtchn_upcall_mask = 1;
+	preempt_enable_no_resched();
+}
+EXPORT_SYMBOL(raw_local_irq_disable);
+
+void raw_local_irq_enable(void)
+{
+	struct vcpu_info *_vcpu;
+
+	preempt_disable();
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];
+	_vcpu->evtchn_upcall_mask = 0;
+	barrier(); /* unmask then check (avoid races) */
+	if (unlikely(_vcpu->evtchn_upcall_pending))
+		force_evtchn_callback();
+	preempt_enable();
+}
+EXPORT_SYMBOL(raw_local_irq_enable);
diff -r 092b7e56c85d include/asm-i386/mach-default/mach_irqflags.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_irqflags.h	Thu Jul 13 14:42:42 2006 -0700
@@ -0,0 +1,64 @@
+#ifndef ASM_MACH_IRQFLAGS_H
+#define ASM_MACH_IRQFLAGS_H
+
+#ifndef __ASSEMBLY__
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
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* ASM_MACH_IRQFLAGS_H */
diff -r 092b7e56c85d include/asm-i386/mach-default/mach_system.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_system.h	Thu Jul 13 15:59:13 2006 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_SYSTEM_H
+#define __ASM_MACH_SYSTEM_H
+
+#endif /* __ASM_MACH_SYSTEM_H */
diff -r 092b7e56c85d include/asm-i386/mach-xen/mach_irqflags.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_irqflags.h	Thu Jul 13 14:42:42 2006 -0700
@@ -0,0 +1,29 @@
+#ifndef ASM_MACH_IRQFLAGS_H
+#define ASM_MACH_IRQFLAGS_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_SMP
+#define __vcpu_id smp_processor_id()
+#else
+#define __vcpu_id 0
+#endif
+
+/* interrupt control.. */
+
+unsigned long __raw_local_save_flags(void);
+void raw_local_irq_restore(unsigned long flags);
+void raw_local_irq_disable(void);
+void raw_local_irq_enable(void);
+
+#define raw_safe_halt()		do { } while(0)
+#define halt()			do { } while(0)
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return flags != 0;
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* ASM_MACH_IRQFLAGS_H */
diff -r 092b7e56c85d include/asm-i386/mach-xen/mach_system.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_system.h	Thu Jul 13 15:59:13 2006 -0700
@@ -0,0 +1,5 @@
+#ifndef __ASM_MACH_SYSTEM_H
+#define __ASM_MACH_SYSTEM_H
+
+
+#endif /* __ASM_MACH_SYSTEM_H */

--
