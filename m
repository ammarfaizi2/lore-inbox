Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGKMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGKMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWGKMoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:44:08 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:9446 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751257AbWGKMn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:58 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 3/7] AVR32: Add support for irq-flags state tracing
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:18 +0200
Message-Id: <11526218021811-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11526218024091-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com> <11526218024091-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the irq-flags manipulation to asm/irqflags.h, add the required
raw_ prefix and define TRACE_IRQFLAGS_SUPPORT.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Kconfig.debug     |    4 ++
 include/asm-avr32/irqflags.h |   68 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-avr32/system.h   |   32 +-------------------
 3 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/arch/avr32/Kconfig.debug b/arch/avr32/Kconfig.debug
index 1b84e20..64ace00 100644
--- a/arch/avr32/Kconfig.debug
+++ b/arch/avr32/Kconfig.debug
@@ -1,5 +1,9 @@
 menu "Kernel hacking"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config KPROBES
diff --git a/include/asm-avr32/irqflags.h b/include/asm-avr32/irqflags.h
new file mode 100644
index 0000000..93570da
--- /dev/null
+++ b/include/asm-avr32/irqflags.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2004-2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_AVR32_IRQFLAGS_H
+#define __ASM_AVR32_IRQFLAGS_H
+
+#include <asm/sysreg.h>
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	return sysreg_read(SR);
+}
+
+#define raw_local_save_flags(x)					\
+	do { (x) = __raw_local_save_flags(); } while (0)
+
+/*
+ * This will restore ALL status register flags, not only the interrupt
+ * mask flag.
+ *
+ * The empty asm statement informs the compiler of this fact while
+ * also serving as a barrier.
+ */
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	sysreg_write(SR, flags);
+	asm volatile("" : : : "memory", "cc");
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	asm volatile("ssrf %0" : : "n"(SYSREG_GM_OFFSET) : "memory");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	asm volatile("csrf %0" : : "n"(SYSREG_GM_OFFSET) : "memory");
+}
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & SYSREG_BIT(GM)) != 0;
+}
+
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	return raw_irqs_disabled_flags(flags);
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
+#define raw_local_irq_save(flags)				\
+	do { (flags) = __raw_local_irq_save(); } while (0)
+
+#endif /* __ASM_AVR32_IRQFLAGS_H */
diff --git a/include/asm-avr32/system.h b/include/asm-avr32/system.h
index 583e098..d0c5a1b 100644
--- a/include/asm-avr32/system.h
+++ b/include/asm-avr32/system.h
@@ -69,37 +69,7 @@ # define smp_wmb()		barrier()
 # define smp_read_barrier_depends() do { } while(0)
 #endif
 
-/* Interrupt Control */
-
-#define local_irq_enable()					\
-	asm volatile("csrf %0" : : "n"(SR_GM_BIT) : "memory")
-#define local_irq_disable()					\
-	asm volatile ("ssrf %0" : : "n"(SR_GM_BIT) : "memory")
-#define local_save_flags(x) ((x) = sysreg_read(SR))
-#define irqs_disabled()				\
-	({					\
-		unsigned long flags;		\
-		local_save_flags(flags);	\
-		((flags & SR_GM) != 0);		\
-	})
-
-/*
- * This will restore ALL status register flags, not only the interrupt
- * mask flag.
- *
- * The empty asm statement informs the compiler of this fact (it also
- * serves as a barrier).
- */
-#define local_irq_restore(x)				\
-	do {						\
-		sysreg_write(SR, (x));			\
-		asm volatile("" : : : "memory", "cc");	\
-	} while(0)
-#define local_irq_save(flags)			\
-	do {					\
-		local_save_flags(flags);	\
-		local_irq_disable();		\
-	} while(0)
+#include <linux/irqflags.h>
 
 extern void __xchg_called_with_bad_pointer(void);
 
-- 
1.4.0

