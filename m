Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWGHSyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWGHSyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWGHSyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:54:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53708 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030216AbWGHSyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:54:10 -0400
Date: Sat, 8 Jul 2006 19:53:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-ID: <20060708185357.GA2517@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <1151908178.24611.39.camel@localhost.localdomain> <20060703065735.GA19780@elte.hu> <20060704115425.GA2313@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704115425.GA2313@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 12:54:25PM +0100, Christoph Hellwig wrote:
> On Mon, Jul 03, 2006 at 08:57:35AM +0200, Ingo Molnar wrote:
> > Christoph has had ideas for cleanups in the irq-header-files area for a 
> > long time. My rough battleplan would be this:
> > 
> > - linux/interrupt.h should remain the highlevel driver API [which can be
> >   used by both physical (genirq or non-genirq) or virtual platforms].
> >   Only this file should be included by drivers.
> 
> Yes.  Note that it's not quite there yet.  Non-genirq architectures currently
> have things like enable_irq/disable_irq in asm/irq.h  We really need to have
> those prototypes only in linux/interrupt.h.  Unfortunately at least m68k and
> sparc had those as macros so they'll need some tweaking first.

Here's the patch I have lying around for a while.  I rediffed it to current
Linus' tree.  It still needs someone to test it on sparc32 and m68knommu
(compile at least).


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/arm26/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/irq.c	2006-07-08 17:44:19.000000000 +0200
+++ linux-2.6/arch/arm26/kernel/irq.c	2006-07-08 20:29:25.000000000 +0200
@@ -86,7 +86,7 @@
  *
  *	This function may be called from IRQ context.
  */
-void disable_irq(unsigned int irq)
+void disable_irq_nosync(unsigned int irq)
 {
 	struct irqdesc *desc = irq_desc + irq;
 	unsigned long flags;
@@ -95,6 +95,12 @@
 		desc->enabled = 0;
 	spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
+EXPORT_SYMBOL(disable_irq_nosync);
+
+void disable_irq(unsigned int irq)
+{
+	return disable_irq_nosync(irq);
+}
 
 /**
  *	enable_irq - enable interrupt handling on an irq
Index: linux-2.6/arch/h8300/kernel/ints.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/ints.c	2006-07-08 17:44:19.000000000 +0200
+++ linux-2.6/arch/h8300/kernel/ints.c	2006-07-08 20:29:25.000000000 +0200
@@ -208,11 +208,17 @@
 		IER_REGS |= 1 << (irq - EXT_IRQ0);
 }
 
-void disable_irq(unsigned int irq)
+void disable_irq_nosync(unsigned int irq)
 {
 	if (irq >= EXT_IRQ0 && irq <= (EXT_IRQ0 + EXT_IRQS))
 		IER_REGS &= ~(1 << (irq - EXT_IRQ0));
 }
+EXPORT_SYMBOL(disable_irq_nosync);
+
+void disable_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+}
 
 asmlinkage void process_int(int irq, struct pt_regs *fp)
 {
Index: linux-2.6/arch/m68knommu/kernel/Makefile
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/Makefile	2006-01-12 16:27:05.000000000 +0100
+++ linux-2.6/arch/m68knommu/kernel/Makefile	2006-07-08 20:29:25.000000000 +0200
@@ -5,7 +5,7 @@
 extra-y := vmlinux.lds
 
 obj-y += dma.o entry.o init_task.o m68k_ksyms.o process.o ptrace.o semaphore.o \
-	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
+	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o irq.o
 
 obj-$(CONFIG_MODULES)	+= module.o
 obj-$(CONFIG_COMEMPCI)	+= comempci.o
Index: linux-2.6/arch/m68knommu/kernel/irq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/m68knommu/kernel/irq.c	2006-07-08 20:29:25.000000000 +0200
@@ -0,0 +1,22 @@
+
+#include <linux/interrupt.h>
+
+/*
+ * Stubs for IRQ handling helpers.
+ * Seems wrong to me that these are no-ops on m68knommu.  --hch
+ */
+
+void disable_irq_nosync(unsigned int irq)
+{
+}
+EXPORT_SYMBOL(disable_irq_nosync);
+
+void disable_irq(unsigned int irq)
+{
+}
+EXPORT_SYMBOL(disable_irq);
+
+void enable_irq(unsigned int irq)
+{
+}
+EXPORT_SYMBOL(enable_irq);
Index: linux-2.6/include/asm-arm26/irq.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/irq.h	2006-07-08 17:44:35.000000000 +0200
+++ linux-2.6/include/asm-arm26/irq.h	2006-07-08 20:29:25.000000000 +0200
@@ -22,12 +22,6 @@
 #define NO_IRQ	((unsigned int)(-1))
 #endif
 
-struct irqaction;
-
-#define disable_irq_nosync(i) disable_irq(i)
-
-extern void disable_irq(unsigned int);
-extern void enable_irq(unsigned int);
 
 #define __IRQT_FALEDGE	(1 << 0)
 #define __IRQT_RISEDGE	(1 << 1)
Index: linux-2.6/include/asm-frv/irq.h
===================================================================
--- linux-2.6.orig/include/asm-frv/irq.h	2006-07-08 17:44:35.000000000 +0200
+++ linux-2.6/include/asm-frv/irq.h	2006-07-08 20:29:25.000000000 +0200
@@ -35,9 +35,4 @@
 	return irq;
 }
 
-extern void disable_irq_nosync(unsigned int irq);
-extern void disable_irq(unsigned int irq);
-extern void enable_irq(unsigned int irq);
-
-
 #endif /* _ASM_IRQ_H_ */
Index: linux-2.6/include/asm-h8300/irq.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/irq.h	2006-07-08 17:44:35.000000000 +0200
+++ linux-2.6/include/asm-h8300/irq.h	2006-07-08 20:29:25.000000000 +0200
@@ -59,8 +59,4 @@
 	return irq;
 }
 
-extern void enable_irq(unsigned int);
-extern void disable_irq(unsigned int);
-#define disable_irq_nosync(x)	disable_irq(x)
-
 #endif /* _H8300_IRQ_H_ */
Index: linux-2.6/include/asm-m68k/irq.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/irq.h	2006-07-08 17:44:35.000000000 +0200
+++ linux-2.6/include/asm-m68k/irq.h	2006-07-08 20:29:42.000000000 +0200
@@ -59,9 +59,6 @@
 #define IRQ_USER	8
 
 extern unsigned int irq_canonicalize(unsigned int irq);
-extern void enable_irq(unsigned int);
-extern void disable_irq(unsigned int);
-#define disable_irq_nosync	disable_irq
 
 struct pt_regs;
 
Index: linux-2.6/include/asm-m68knommu/irq.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/irq.h	2006-07-08 17:44:36.000000000 +0200
+++ linux-2.6/include/asm-m68knommu/irq.h	2006-07-08 20:30:04.000000000 +0200
@@ -80,11 +80,4 @@
 
 #endif /* CONFIG_M68360 */
 
-/*
- * Some drivers want these entry points
- */
-#define enable_irq(x)	do { } while (0)
-#define disable_irq(x)	do { } while (0)
-#define disable_irq_nosync(x)	disable_irq(x)
-
 #endif /* _M68K_IRQ_H_ */
Index: linux-2.6/include/asm-sparc/irq.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/irq.h	2006-07-08 20:27:38.000000000 +0200
+++ linux-2.6/include/asm-sparc/irq.h	2006-07-08 20:29:25.000000000 +0200
@@ -36,10 +36,6 @@
 BTFIXUPDEF_CALL(void, clear_profile_irq, int)
 BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
 
-extern void disable_irq_nosync(unsigned int irq);
-extern void disable_irq(unsigned int irq);
-extern void enable_irq(unsigned int irq);
-
 static inline void disable_pil_irq(unsigned int irq)
 {
 	BTFIXUP_CALL(disable_pil_irq)(irq);
Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h	2006-07-08 17:44:36.000000000 +0200
+++ linux-2.6/include/linux/interrupt.h	2006-07-08 20:32:01.000000000 +0200
@@ -99,11 +99,11 @@
 # define local_irq_enable_in_hardirq()	local_irq_enable()
 #endif
 
-#ifdef CONFIG_GENERIC_HARDIRQS
 extern void disable_irq_nosync(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 
+#ifdef CONFIG_GENERIC_HARDIRQS
 /*
  * Special lockdep variants of irq disabling/enabling.
  * These should be used for locking constructs that
Index: linux-2.6/arch/sparc/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/irq.c	2006-07-08 17:44:21.000000000 +0200
+++ linux-2.6/arch/sparc/kernel/irq.c	2006-07-08 20:27:38.000000000 +0200
@@ -549,6 +549,25 @@
 
 EXPORT_SYMBOL(request_irq);
 
+void disable_irq_nosync(unsigned int irq)
+{
+	BTFIXUP_CALL(disable_irq)(irq);
+}
+EXPORT_SYMBOL(disable_irq_nosync);
+
+void disable_irq(unsigned int irq)
+{
+	BTFIXUP_CALL(disable_irq)(irq);
+}
+EXPORT_SYMBOL(disable_irq);
+
+void enable_irq(unsigned int irq)
+{
+	BTFIXUP_CALL(enable_irq)(irq);
+}
+EXPORT_SYMBOL(enable_irq);
+
+
 /* We really don't need these at all on the Sparc.  We only have
  * stubs here because they are exported to modules.
  */
Index: linux-2.6/include/asm-sparc/irq.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/irq.h	2006-07-08 17:44:36.000000000 +0200
+++ linux-2.6/include/asm-sparc/irq.h	2006-07-08 20:27:38.000000000 +0200
@@ -36,20 +36,6 @@
 BTFIXUPDEF_CALL(void, clear_profile_irq, int)
 BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
 
-static inline void disable_irq_nosync(unsigned int irq)
-{
-	BTFIXUP_CALL(disable_irq)(irq);
-}
-
-static inline void disable_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(disable_irq)(irq);
-}
-
-static inline void enable_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(enable_irq)(irq);
-}
 
 static inline void disable_pil_irq(unsigned int irq)
 {
