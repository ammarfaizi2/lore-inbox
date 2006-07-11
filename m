Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWGKBAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWGKBAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWGKBAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:00:01 -0400
Received: from fmr17.intel.com ([134.134.136.16]:10657 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751395AbWGKBAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:00:00 -0400
Subject: [PATCH] irqtrace-option-off-compile-fix
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org
Content-Type: text/plain
Organization: Intel
Date: Mon, 10 Jul 2006 17:18:40 -0700
Message-Id: <1152577120.7654.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_TRACE_IRQFLAGS_SUPPORT is turned off, the latest kernel has
compile errors.  The patch below fix the problems.

Regards,
Tim Chen


Signed-off-by: Tim Chen <tim.c.chen@intel.com>
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 412e025..2dd865f 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -41,10 +41,10 @@
 # define INIT_TRACE_IRQFLAGS
 #endif
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-
 #include <asm/irqflags.h>
 
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+
 #define local_irq_enable() \
 	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
 #define local_irq_disable() \
@@ -62,24 +62,24 @@
 			raw_local_irq_restore(flags);		\
 		}						\
 	} while (0)
+#define safe_halt()						\
+	do {							\
+		trace_hardirqs_on();				\
+		raw_safe_halt();				\
+	} while (0)
+
 #else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
 /*
  * The local_irq_*() APIs are equal to the raw_local_irq*()
  * if !TRACE_IRQFLAGS.
  */
-# define raw_local_irq_disable()	local_irq_disable()
-# define raw_local_irq_enable()		local_irq_enable()
-# define raw_local_irq_save(flags)	local_irq_save(flags)
-# define raw_local_irq_restore(flags)	local_irq_restore(flags)
+#define local_irq_disable()		raw_local_irq_disable()
+#define local_irq_enable()		raw_local_irq_enable()
+#define local_irq_save(flags)		raw_local_irq_save(flags)
+#define local_irq_restore(flags)	raw_local_irq_restore(flags)
+#define safe_halt()			raw_safe_halt()
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-#define safe_halt()						\
-	do {							\
-		trace_hardirqs_on();				\
-		raw_safe_halt();				\
-	} while (0)
-
 #define local_save_flags(flags)		raw_local_save_flags(flags)
 
 #define irqs_disabled()						\
@@ -91,6 +91,5 @@
 })
 
 #define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
-#endif		/* CONFIG_X86 */
 
 #endif


