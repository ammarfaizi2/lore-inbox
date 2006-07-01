Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWGAPEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWGAPEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWGAO5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:35 -0400
Received: from www.osadl.org ([213.239.205.134]:32420 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751533AbWGAO5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:04 -0400
Message-Id: <20060701145224.601140000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:33 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, geert@linux-m68k.org
Subject: [RFC][patch 12/44] M68K: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-m68k.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/m68k/amiga/amiints.c    |    2 +-
 arch/m68k/amiga/cia.c        |    2 +-
 arch/m68k/kernel/ints.c      |    2 +-
 include/asm-m68k/floppy.h    |    4 ++--
 include/asm-m68k/irq.h       |    4 ++--
 include/asm-m68k/signal.h    |    2 --
 include/asm-m68k/sun3xflop.h |    3 ++-
 7 files changed, 9 insertions(+), 10 deletions(-)

Index: linux-2.6.git/include/asm-m68k/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68k/floppy.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68k/floppy.h	2006-07-01 16:51:34.000000000 +0200
@@ -88,8 +88,8 @@ static __inline__ void fd_outb(unsigned 
 static int fd_request_irq(void)
 {
 	if(MACH_IS_Q40)
-		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-						   "floppy", floppy_hardint);
+		return request_irq(FLOPPY_IRQ, floppy_hardint,
+				   IRQF_DISABLED, "floppy", floppy_hardint);
 	else if(MACH_IS_SUN3X)
 		return sun3xflop_request_irq();
 	return -ENXIO;
Index: linux-2.6.git/include/asm-m68k/irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68k/irq.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68k/irq.h	2006-07-01 16:51:34.000000000 +0200
@@ -67,8 +67,8 @@ struct pt_regs;
 
 /*
  * various flags for request_irq() - the Amiga now uses the standard
- * mechanism like all other architectures - SA_INTERRUPT and SA_SHIRQ
- * are your friends.
+ * mechanism like all other architectures - IRQF_DISABLED and 
+ * IRQF_SHARED are your friends.
  */
 #ifndef MACH_AMIGA_ONLY
 #define IRQ_FLG_LOCK	(0x0001)	/* handler is not replaceable	*/
Index: linux-2.6.git/include/asm-m68k/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68k/signal.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68k/signal.h	2006-07-01 16:51:34.000000000 +0200
@@ -74,7 +74,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -94,7 +93,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 /*
  * sigaltstack controls
Index: linux-2.6.git/include/asm-m68k/sun3xflop.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68k/sun3xflop.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68k/sun3xflop.h	2006-07-01 16:51:34.000000000 +0200
@@ -208,7 +208,8 @@ static int sun3xflop_request_irq(void)
 
 	if(!once) {
 		once = 1;
-		error = request_irq(FLOPPY_IRQ, sun3xflop_hardint, SA_INTERRUPT, "floppy", NULL);
+		error = request_irq(FLOPPY_IRQ, sun3xflop_hardint,
+				    IRQF_DISABLED, "floppy", NULL);
 		return ((error == 0) ? 0 : -1);
 	} else return 0;
 }
Index: linux-2.6.git/arch/m68k/amiga/amiints.c
===================================================================
--- linux-2.6.git.orig/arch/m68k/amiga/amiints.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/m68k/amiga/amiints.c	2006-07-01 16:51:34.000000000 +0200
@@ -22,7 +22,7 @@
  *
  * 07/08/99: rewamp of the interrupt handling - we now have two types of
  *           interrupts, normal and fast handlers, fast handlers being
- *           marked with SA_INTERRUPT and runs with all other interrupts
+ *           marked with IRQF_DISABLED and runs with all other interrupts
  *           disabled. Normal interrupts disable their own source but
  *           run with all other interrupt sources enabled.
  *           PORTS and EXTER interrupts are always shared even if the
Index: linux-2.6.git/arch/m68k/amiga/cia.c
===================================================================
--- linux-2.6.git.orig/arch/m68k/amiga/cia.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/m68k/amiga/cia.c	2006-07-01 16:51:34.000000000 +0200
@@ -176,5 +176,5 @@ void __init cia_init_IRQ(struct ciabase 
 	/* override auto int and install CIA handler */
 	m68k_setup_irq_controller(&auto_irq_controller, base->handler_irq, 1);
 	m68k_irq_startup(base->handler_irq);
-	request_irq(base->handler_irq, cia_handler, SA_SHIRQ, base->name, base);
+	request_irq(base->handler_irq, cia_handler, IRQF_SHARED, base->name, base);
 }
Index: linux-2.6.git/arch/m68k/kernel/ints.c
===================================================================
--- linux-2.6.git.orig/arch/m68k/kernel/ints.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/m68k/kernel/ints.c	2006-07-01 16:51:34.000000000 +0200
@@ -192,7 +192,7 @@ int setup_irq(unsigned int irq, struct i
 	prev = irq_list + irq;
 	if (*prev) {
 		/* Can't share interrupts unless both agree to */
-		if (!((*prev)->flags & node->flags & SA_SHIRQ)) {
+		if (!((*prev)->flags & node->flags & IRQF_SHARED)) {
 			spin_unlock_irqrestore(&contr->lock, flags);
 			return -EBUSY;
 		}

--

