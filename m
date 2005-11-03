Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVKCOwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVKCOwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVKCOwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:52:23 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:54980 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030248AbVKCOwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:52:21 -0500
Date: Thu, 3 Nov 2005 07:52:21 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103145221.GZ23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103144926.GV23749@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move the definition of NO_IRQ from asm directories to <linux/hardirq.h>.
Individual architectures can still override it if they want to, but all
existing definitions were -1.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 include/asm-arm/irq.h     |    8 --------
 include/asm-arm26/irq.h   |    8 --------
 include/asm-frv/irq.h     |    3 ---
 include/asm-parisc/irq.h  |    2 --
 include/asm-powerpc/irq.h |    3 ---
 include/linux/hardirq.h   |   10 ++++++++++
 6 files changed, 10 insertions(+), 24 deletions(-)

applies-to: 378fab44adde8e150b890a6a45ca755d5910bbe7
8b323aaed3682ec4890966757fb407a46356fb05
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
index f876bdf..037ef9f 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -10,8 +10,6 @@
 #include <linux/config.h>
 #include <asm/types.h>
 
-#define NO_IRQ		(-1)
-
 #ifdef CONFIG_GSC
 #define GSC_IRQ_BASE	16
 #define GSC_IRQ_MAX	63
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index c7c3f91..b5720cf 100644
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
index 5912874..a8b3f8e 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -87,6 +87,16 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+/*
+ * This value means "Device has no interrupt".  For most pieces of code,
+ * any value above NR_IRQS would do, but -1 is traditional.  The PCI
+ * subsystem currently uses 0, but that's a legal IRQ number on some
+ * architectures.
+ */
+#ifndef NO_IRQ
+#define NO_IRQ			((unsigned int)(-1))
+#endif
+
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
---
0.99.8.GIT
