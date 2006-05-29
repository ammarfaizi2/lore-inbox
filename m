Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWE2VmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWE2VmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWE2VYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26040 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751338AbWE2VY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:28 -0400
Date: Mon, 29 May 2006 23:24:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 20/61] lock validator: irqtrace: cleanup: include/asm-x86_64/irqflags.h
Message-ID: <20060529212444.GT3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

clean up the x86-64 irqflags.h file:

 - macro => inline function transformation
 - simplifications
 - style fixes

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/lib/thunk.S       |    5 +
 include/asm-x86_64/irqflags.h |  159 ++++++++++++++++++++++++++++++++----------
 2 files changed, 128 insertions(+), 36 deletions(-)

Index: linux/arch/x86_64/lib/thunk.S
===================================================================
--- linux.orig/arch/x86_64/lib/thunk.S
+++ linux/arch/x86_64/lib/thunk.S
@@ -47,6 +47,11 @@
 	thunk_retrax __down_failed_interruptible,__down_interruptible
 	thunk_retrax __down_failed_trylock,__down_trylock
 	thunk __up_wakeup,__up
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	thunk trace_hardirqs_on_thunk,trace_hardirqs_on
+	thunk trace_hardirqs_off_thunk,trace_hardirqs_off
+#endif
 	
 	/* SAVE_ARGS below is used only for the .cfi directives it contains. */
 	CFI_STARTPROC
Index: linux/include/asm-x86_64/irqflags.h
===================================================================
--- linux.orig/include/asm-x86_64/irqflags.h
+++ linux/include/asm-x86_64/irqflags.h
@@ -5,50 +5,137 @@
  *
  * This file gets included from lowlevel asm headers too, to provide
  * wrapped versions of the local_irq_*() APIs, based on the
- * raw_local_irq_*() macros from the lowlevel headers.
+ * raw_local_irq_*() functions from the lowlevel headers.
  */
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
-/* interrupt control.. */
-#define raw_local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
-#define raw_local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
+#ifndef __ASSEMBLY__
+/*
+ * Interrupt control:
+ */
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long flags;
+
+	__asm__ __volatile__(
+		"# __raw_save_flags\n\t"
+		"pushfq ; popq %q0"
+		: "=g" (flags)
+		: /* no input */
+		: "memory"
+	);
+
+	return flags;
+}
+
+#define raw_local_save_flags(flags) \
+		do { (flags) = __raw_local_save_flags(); } while (0)
+
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	__asm__ __volatile__(
+		"pushq %0 ; popfq"
+		: /* no output */
+		:"g" (flags)
+		:"memory", "cc"
+	);
+}
 
 #ifdef CONFIG_X86_VSMP
-/* Interrupt control for VSMP  architecture */
-#define raw_local_irq_disable()	do { unsigned long flags; raw_local_save_flags(flags); raw_local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
-#define raw_local_irq_enable()	do { unsigned long flags; raw_local_save_flags(flags); raw_local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
-
-#define raw_irqs_disabled_flags(flags)	\
-({						\
-	(flags & (1<<18)) || !(flags & (1<<9));	\
-})
-
-/* For spinlocks etc */
-#define raw_local_irq_save(x)	do { raw_local_save_flags(x); raw_local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
-#else  /* CONFIG_X86_VSMP */
-#define raw_local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define raw_local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-
-#define raw_irqs_disabled_flags(flags)	\
-({						\
-	!(flags & (1<<9));			\
-})
 
-/* For spinlocks etc */
-#define raw_local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# raw_local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+/*
+ * Interrupt control for the VSMP architecture:
+ */
+
+static inline void raw_local_irq_disable(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	raw_local_irq_restore((flags & ~(1 << 9)) | (1 << 18));
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	raw_local_irq_restore((flags | (1 << 9)) & ~(1 << 18));
+}
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1<<9)) || (flags & (1 << 18));
+}
+
+#else /* CONFIG_X86_VSMP */
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
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+
 #endif
 
-#define raw_irqs_disabled()			\
-({						\
-	unsigned long flags;			\
-	raw_local_save_flags(flags);		\
-	raw_irqs_disabled_flags(flags);		\
-})
-
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define raw_safe_halt()	__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
+/*
+ * For spinlocks, etc.:
+ */
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
+#define raw_local_irq_save(flags) \
+		do { (flags) = __raw_local_irq_save(); } while (0)
+
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	return raw_irqs_disabled_flags(flags);
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
+#else /* __ASSEMBLY__: */
+# ifdef CONFIG_TRACE_IRQFLAGS
+#  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk
+#  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk
+# else
+#  define TRACE_IRQS_ON
+#  define TRACE_IRQS_OFF
+# endif
+#endif
 
 #endif
