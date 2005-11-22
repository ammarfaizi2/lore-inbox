Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVKVFTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVKVFTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVKVFTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:19:39 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:41920 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932286AbVKVFTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:19:25 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-Id: <E1EeQYc-00055n-Gc@localhost.localdomain>
Date: Tue, 22 Nov 2005 00:19:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a default definition of NO_IRQ to <linux/hardirq.h> and make the
definition in <asm/hardirq.h> uniform across all architectures which
define it.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 include/asm-arm/irq.h     |    5 +----
 include/asm-arm26/irq.h   |    5 +----
 include/asm-frv/irq.h     |    2 +-
 include/asm-parisc/irq.h  |    2 +-
 include/asm-powerpc/irq.h |    2 +-
 include/linux/hardirq.h   |   10 ++++++++++
 6 files changed, 15 insertions(+), 11 deletions(-)

applies-to: 48ad7d3f9b055a9d4c1a1ab1f6dd0a584cfed99c
8a7e8c26051c3abef81eb155c8a721716e24cc26
diff --git a/include/asm-arm/irq.h b/include/asm-arm/irq.h
index 59975ee..4ea980e 100644
--- a/include/asm-arm/irq.h
+++ b/include/asm-arm/irq.h
@@ -12,12 +12,9 @@
 #endif
 
 /*
- * Use this value to indicate lack of interrupt
- * capability
+ * Use this value to indicate lack of interrupt capability
  */
-#ifndef NO_IRQ
 #define NO_IRQ	((unsigned int)(-1))
-#endif
 
 struct irqaction;
 
diff --git a/include/asm-arm26/irq.h b/include/asm-arm26/irq.h
index 06bd5a5..88e8ab7 100644
--- a/include/asm-arm26/irq.h
+++ b/include/asm-arm26/irq.h
@@ -15,12 +15,9 @@
 
 
 /*
- * Use this value to indicate lack of interrupt
- * capability
+ * Use this value to indicate lack of interrupt capability
  */
-#ifndef NO_IRQ
 #define NO_IRQ	((unsigned int)(-1))
-#endif
 
 struct irqaction;
 
diff --git a/include/asm-frv/irq.h b/include/asm-frv/irq.h
index 2c16d8d..018ef9b 100644
--- a/include/asm-frv/irq.h
+++ b/include/asm-frv/irq.h
@@ -21,7 +21,7 @@
  */
 
 /* this number is used when no interrupt has been assigned */
-#define NO_IRQ				(-1)
+#define NO_IRQ				((unsigned int)(-1))
 
 #define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
 #define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
diff --git a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
index b0a30e2..d8de7cf 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -11,7 +11,7 @@
 #include <linux/cpumask.h>
 #include <asm/types.h>
 
-#define NO_IRQ		(-1)
+#define NO_IRQ		((unsigned int)(-1))
 
 #ifdef CONFIG_GSC
 #define GSC_IRQ_BASE	16
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 8eb7e85..61579c0 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -16,7 +16,7 @@
 #include <asm/atomic.h>
 
 /* this number is used when no interrupt has been assigned */
-#define NO_IRQ			(-1)
+#define NO_IRQ			((unsigned int)(-1))
 
 /*
  * These constants are used for passing information about interrupt
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 71d2b8a..510d71b 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/preempt.h>
 #include <linux/smp_lock.h>
 #include <asm/hardirq.h>
+#include <asm/irq.h>
 #include <asm/system.h>
 
 /*
@@ -87,6 +88,15 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+/*
+ * This value means "Device has no interrupt".  The value 0 has
+ * historically been used, but it's a legal interrupt number on some
+ * architectures.  These architectures typically define it to be -1 instead.
+ */
+#ifndef NO_IRQ
+#define NO_IRQ			((unsigned int)0)
+#endif
+
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
---
0.99.8.GIT
