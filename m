Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVKUBOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKUBOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVKUBOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:14:47 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:37311 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932162AbVKUBOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:14:23 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/5] Centralise NO_IRQ definition
Message-Id: <E1Ee0G0-0004CN-Az@localhost.localdomain>
Date: Sun, 20 Nov 2005 20:14:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of NO_IRQ from asm directories to <linux/hardirq.h>.
All existing definitions were already -1.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 include/asm-arm/irq.h     |    8 --------
 include/asm-arm26/irq.h   |    8 --------
 include/asm-frv/irq.h     |    3 ---
 include/asm-parisc/irq.h  |    2 --
 include/asm-powerpc/irq.h |    3 ---
 include/linux/hardirq.h   |    8 ++++++++
 6 files changed, 8 insertions(+), 24 deletions(-)

applies-to: c2fd3b28a74be2ae6274c85c7a9538c7bf1dd949
604c0538936822cbb1c0958f0f835cbbaf723530
diff --git a/include/asm-arm/irq.h b/include/asm-arm/irq.h
index 59975ee..0545e36 100644
--- a/include/asm-arm/irq.h
+++ b/include/asm-arm/irq.h
@@ -11,14 +11,6 @@
 #define NR_IRQS	128
 #endif
 
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 extern void disable_irq_nosync(unsigned int);
diff --git a/include/asm-arm26/irq.h b/include/asm-arm26/irq.h
index 06bd5a5..7957d4e 100644
--- a/include/asm-arm26/irq.h
+++ b/include/asm-arm26/irq.h
@@ -14,14 +14,6 @@
 #endif
 
 
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 #define disable_irq_nosync(i) disable_irq(i)
diff --git a/include/asm-frv/irq.h b/include/asm-frv/irq.h
index 2c16d8d..fbc5bd7 100644
--- a/include/asm-frv/irq.h
+++ b/include/asm-frv/irq.h
@@ -20,9 +20,6 @@
  * drivers
  */
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ				(-1)
-
 #define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
 #define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
 #define NR_IRQ_GROUPS			4
diff --git a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
index b0a30e2..26ab3be 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -11,8 +11,6 @@
 #include <linux/cpumask.h>
 #include <asm/types.h>
 
-#define NO_IRQ		(-1)
-
 #ifdef CONFIG_GSC
 #define GSC_IRQ_BASE	16
 #define GSC_IRQ_MAX	63
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 8eb7e85..1b41206 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -15,9 +15,6 @@
 #include <asm/types.h>
 #include <asm/atomic.h>
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ			(-1)
-
 /*
  * These constants are used for passing information about interrupt
  * signal polarity and level/edge sensing to the low-level PIC chip
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 71d2b8a..9ee4946 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -87,6 +87,14 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+/*
+ * This value means "Device has no interrupt".  For most pieces of code,
+ * any value above NR_IRQS would do, but -1 is traditional.  The PCI
+ * subsystem currently uses 0, but that's a legal IRQ number on some
+ * architectures.
+ */
+#define NO_IRQ			((unsigned int)(-1))
+
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
---
0.99.8.GIT
