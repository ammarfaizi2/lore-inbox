Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWFWRpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWFWRpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWFWRpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:45:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59854 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751829AbWFWRpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:45:32 -0400
Date: Fri, 23 Jun 2006 19:45:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: jbeulich@novell.com
Subject: Subject: [PATCH] reintegrate irqreturn.h into hardirq.h
Message-ID: <Pine.LNX.4.64.0606231943580.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We already have enough mini header files and moving these definitions to
hardirq.h works just fine.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/hardirq.h   |   20 ++++++++++++++++++++
 include/linux/interrupt.h |    1 -
 include/linux/irq.h       |    3 +--
 include/linux/irqreturn.h |   25 -------------------------
 4 files changed, 21 insertions(+), 28 deletions(-)
 delete mode 100644 include/linux/irqreturn.h

d0f1912371a73561d6146f2fcd8600a535f12ad7
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 114ae58..f925867 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -7,6 +7,26 @@ #include <asm/hardirq.h>
 #include <asm/system.h>
 
 /*
+ * For 2.4.x compatibility, 2.4.x can use
+ *
+ *	typedef void irqreturn_t;
+ *	#define IRQ_NONE
+ *	#define IRQ_HANDLED
+ *	#define IRQ_RETVAL(x)
+ *
+ * To mix old-style and new-style irq handler returns.
+ *
+ * IRQ_NONE means we didn't handle it.
+ * IRQ_HANDLED means that we did have a valid interrupt and handled it.
+ * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
+ */
+typedef int irqreturn_t;
+
+#define IRQ_NONE	(0)
+#define IRQ_HANDLED	(1)
+#define IRQ_RETVAL(x)	((x) != 0)
+
+/*
  * We put the hardirq and softirq counter into the preemption
  * counter. The bitmask has the following meaning:
  *
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 70741e1..47ff0d0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -7,7 +7,6 @@ #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/preempt.h>
 #include <linux/cpumask.h>
-#include <linux/irqreturn.h>
 #include <linux/hardirq.h>
 #include <linux/sched.h>
 #include <asm/atomic.h>
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 676e00d..e8a07e7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -17,7 +17,6 @@ #include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
-#include <linux/irqreturn.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -176,7 +175,7 @@ #endif
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
-extern fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 					struct irqaction *action);
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
diff --git a/include/linux/irqreturn.h b/include/linux/irqreturn.h
deleted file mode 100644
index 881883c..0000000
--- a/include/linux/irqreturn.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* irqreturn.h */
-#ifndef _LINUX_IRQRETURN_H
-#define _LINUX_IRQRETURN_H
-
-/*
- * For 2.4.x compatibility, 2.4.x can use
- *
- *	typedef void irqreturn_t;
- *	#define IRQ_NONE
- *	#define IRQ_HANDLED
- *	#define IRQ_RETVAL(x)
- *
- * To mix old-style and new-style irq handler returns.
- *
- * IRQ_NONE means we didn't handle it.
- * IRQ_HANDLED means that we did have a valid interrupt and handled it.
- * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
- */
-typedef int irqreturn_t;
-
-#define IRQ_NONE	(0)
-#define IRQ_HANDLED	(1)
-#define IRQ_RETVAL(x)	((x) != 0)
-
-#endif
-- 
1.3.3

