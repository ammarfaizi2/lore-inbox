Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWEIIyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWEIIyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWEIIyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:54:21 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58755 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751539AbWEIItU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:20 -0400
Message-Id: <20060509085154.095325000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
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
 include/asm-i386/mach-default/mach_system.h |   24 ++++++
 include/asm-i386/mach-xen/mach_system.h     |  103 ++++++++++++++++++++++++++++
 include/asm-i386/system.h                   |   20 -----
 3 files changed, 128 insertions(+), 19 deletions(-)

--- linus-2.6.orig/include/asm-i386/system.h
+++ linus-2.6/include/asm-i386/system.h
@@ -490,25 +490,7 @@ static inline unsigned long long __cmpxc
 
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
-/* interrupt control.. */
-#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
-
-#define irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
-	!(flags & (1<<9));		\
-})
-
-/* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#include <mach_system.h>
 
 /*
  * disable hlt during certain critical i/o operations
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_system.h
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_SYSTEM_H
+#define __ASM_MACH_SYSTEM_H
+
+/* interrupt control.. */
+#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+/* used in the idle loop; sti takes one instruction cycle to complete */
+#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+/* used when interrupts are already enabled or to shutdown the processor */
+#define halt()			__asm__ __volatile__("hlt": : :"memory")
+
+#define irqs_disabled()			\
+({					\
+	unsigned long flags;		\
+	local_save_flags(flags);	\
+	!(flags & (1<<9));		\
+})
+
+/* For spinlocks etc */
+#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+#endif /* __ASM_MACH_SYSTEM_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_system.h
@@ -0,0 +1,103 @@
+#ifndef __ASM_MACH_SYSTEM_H
+#define __ASM_MACH_SYSTEM_H
+
+#ifdef __KERNEL__
+
+#include <asm/hypervisor.h>
+
+#ifdef CONFIG_SMP
+#define __vcpu_id smp_processor_id()
+#else
+#define __vcpu_id 0
+#endif
+
+/* interrupt control.. */
+
+/*
+ * The use of 'barrier' in the following reflects their use as local-lock
+ * operations. Reentrancy must be prevented (e.g., __cli()) /before/ following
+ * critical operations are executed. All critical operations must complete
+ * /before/ reentrancy is permitted (e.g., __sti()). Alpha architecture also
+ * includes these barriers, for example.
+ */
+
+#define __cli()								\
+do {									\
+	struct vcpu_info *_vcpu;					\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	_vcpu->evtchn_upcall_mask = 1;					\
+	preempt_enable_no_resched();					\
+	barrier();							\
+} while (0)
+
+#define __sti()								\
+do {									\
+	struct vcpu_info *_vcpu;					\
+	barrier();							\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	_vcpu->evtchn_upcall_mask = 0;					\
+	barrier(); /* unmask then check (avoid races) */		\
+	if (unlikely(_vcpu->evtchn_upcall_pending))			\
+		force_evtchn_callback();				\
+	preempt_enable();						\
+} while (0)
+
+#define __save_flags(x)							\
+do {									\
+	struct vcpu_info *_vcpu;					\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	(x) = _vcpu->evtchn_upcall_mask;				\
+	preempt_enable();						\
+} while (0)
+
+#define __restore_flags(x)						\
+do {									\
+	struct vcpu_info *_vcpu;					\
+	barrier();							\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	if ((_vcpu->evtchn_upcall_mask = (x)) == 0) {			\
+		barrier(); /* unmask then check (avoid races) */	\
+		if (unlikely(_vcpu->evtchn_upcall_pending))		\
+			force_evtchn_callback();			\
+		preempt_enable();					\
+	} else								\
+		preempt_enable_no_resched();				\
+} while (0)
+
+#define safe_halt()		((void)0)
+#define halt()			((void)0)
+
+#define __save_and_cli(x)						\
+do {									\
+	struct vcpu_info *_vcpu;					\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	(x) = _vcpu->evtchn_upcall_mask;				\
+	_vcpu->evtchn_upcall_mask = 1;					\
+	preempt_enable_no_resched();					\
+	barrier();							\
+} while (0)
+
+#define local_irq_save(x)	__save_and_cli(x)
+#define local_irq_restore(x)	__restore_flags(x)
+#define local_save_flags(x)	__save_flags(x)
+#define local_irq_disable()	__cli()
+#define local_irq_enable()	__sti()
+
+/* Cannot use preempt_enable() here as we would recurse in preempt_sched(). */
+#define irqs_disabled()							\
+({	int ___x;							\
+	struct vcpu_info *_vcpu;					\
+	preempt_disable();						\
+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
+	___x = (_vcpu->evtchn_upcall_mask != 0);			\
+	preempt_enable_no_resched();					\
+	___x; })
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_MACH_SYSTEM_H */

--
