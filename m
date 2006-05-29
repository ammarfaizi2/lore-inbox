Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWE2VY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWE2VY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWE2VYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:23480 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751334AbWE2VYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:20 -0400
Date: Mon, 29 May 2006 23:24:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 19/61] lock validator: irqtrace: cleanup: include/asm-i386/irqflags.h
Message-ID: <20060529212437.GS3155@elte.hu>
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

clean up the x86 irqflags.h file:

 - macro => inline function transformation
 - simplifications
 - style fixes

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-i386/irqflags.h |   95 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 12 deletions(-)

Index: linux/include/asm-i386/irqflags.h
===================================================================
--- linux.orig/include/asm-i386/irqflags.h
+++ linux/include/asm-i386/irqflags.h
@@ -5,24 +5,95 @@
  *
  * This file gets included from lowlevel asm headers too, to provide
  * wrapped versions of the local_irq_*() APIs, based on the
- * raw_local_irq_*() macros from the lowlevel headers.
+ * raw_local_irq_*() functions from the lowlevel headers.
  */
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
-#define raw_local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define raw_local_irq_restore(x) do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define raw_local_irq_disable()	__asm__ __volatile__("cli": : :"memory")
-#define raw_local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
-/* used in the idle loop; sti takes one instruction cycle to complete */
-#define raw_safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
-/* used when interrupts are already enabled or to shutdown the processor */
-#define halt()			__asm__ __volatile__("hlt": : :"memory")
+#ifndef __ASSEMBLY__
 
-#define raw_irqs_disabled_flags(flags)	(!((flags) & (1<<9)))
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
+#define raw_local_save_flags(flags) \
+		do { (flags) = __raw_local_save_flags(); } while (0)
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
 
-/* For spinlocks etc */
-#define raw_local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
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
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	return raw_irqs_disabled_flags(flags);
+}
+
+/*
+ * For spinlocks, etc:
+ */
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
+#endif /* __ASSEMBLY__ */
 
 /*
  * Do the CPU's IRQ-state tracing from assembly code. We call a
