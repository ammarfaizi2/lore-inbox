Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWE3KJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWE3KJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWE3KJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:09:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40069 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932208AbWE3KJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:09:00 -0400
Date: Tue, 30 May 2006 12:09:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator, irqtrace: support non-x86 architectures
Message-ID: <20060530100922.GB31982@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
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

Subject: lock validator, irqtrace: support non-x86 architectures
From: Ingo Molnar <mingo@elte.hu>

add TRACE_IRQFLAGS_SUPPORT method for architectures to signal
whether they have irq-flags tracing infrastructure.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/Kconfig.debug        |    4 ++++
 arch/x86_64/Kconfig.debug      |    4 ++++
 include/linux/trace_irqflags.h |   30 +++++++++++++++---------------
 lib/Kconfig.debug              |    3 +++
 4 files changed, 26 insertions(+), 15 deletions(-)

Index: linux/arch/i386/Kconfig.debug
===================================================================
--- linux.orig/arch/i386/Kconfig.debug
+++ linux/arch/i386/Kconfig.debug
@@ -1,5 +1,9 @@
 menu "Kernel hacking"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
Index: linux/arch/x86_64/Kconfig.debug
===================================================================
--- linux.orig/arch/x86_64/Kconfig.debug
+++ linux/arch/x86_64/Kconfig.debug
@@ -1,5 +1,9 @@
 menu "Kernel hacking"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config DEBUG_RODATA
Index: linux/include/linux/trace_irqflags.h
===================================================================
--- linux.orig/include/linux/trace_irqflags.h
+++ linux/include/linux/trace_irqflags.h
@@ -11,12 +11,6 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
-#include <asm/irqflags.h>
-
-/*
- * The local_irq_*() APIs are equal to the raw_local_irq*()
- * if !TRACE_IRQFLAGS.
- */
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
@@ -31,7 +25,6 @@
 # define trace_softirq_enter()	do { current->softirq_context++; } while (0)
 # define trace_softirq_exit()	do { current->softirq_context--; } while (0)
 # define INIT_TRACE_IRQFLAGS	.softirqs_enabled = 1,
-
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
@@ -48,7 +41,10 @@
 # define INIT_TRACE_IRQFLAGS
 #endif
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+
+#include <asm/irqflags.h>
+
 #define local_irq_enable() \
 	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
 #define local_irq_disable() \
@@ -66,12 +62,16 @@
 			raw_local_irq_restore(flags);		\
 		}						\
 	} while (0)
-#else
-#define raw_local_irq_disable() local_irq_disable()
-#define raw_local_irq_enable() local_irq_enable()
-#define raw_local_irq_save(flags) local_irq_save(flags)
-#define raw_local_irq_restore(flags) local_irq_restore(flags)
-#endif		/* CONFIG_X86 */
+#else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
+/*
+ * The local_irq_*() APIs are equal to the raw_local_irq*()
+ * if !TRACE_IRQFLAGS.
+ */
+# define raw_local_irq_disable()	local_irq_disable()
+# define raw_local_irq_enable()		local_irq_enable()
+# define raw_local_irq_save(flags)	local_irq_save(flags)
+# define raw_local_irq_restore(flags)	local_irq_restore(flags)
+#endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 /*
  * On lockdep we dont want to enable hardirqs in hardirq
@@ -86,7 +86,7 @@
 # define local_irq_enable_in_hardirq()	local_irq_enable()
 #endif
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 #define safe_halt()						\
 	do {							\
 		trace_hardirqs_on();				\
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -123,6 +123,7 @@ config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
 	default y
+	depends on TRACE_IRQFLAGS_SUPPORT
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
@@ -347,6 +348,7 @@ config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on LOCKDEP
 	default y
+	depends on TRACE_IRQFLAGS_SUPPORT
 	help
 	  If you say Y here, the lock dependency engine will do
 	  additional runtime checks to debug itself, at the price
@@ -355,6 +357,7 @@ config DEBUG_LOCKDEP
 config TRACE_IRQFLAGS
 	bool
 	default y
+	depends on TRACE_IRQFLAGS_SUPPORT
 	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING
 
 config DEBUG_SPINLOCK_SLEEP
