Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDHJWb (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDHJUx (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:20:53 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:22658 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261288AbTDHJUX (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:20:23 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  On the v850/nb85e, acknowledge interrupts immediately after handling them
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030408092740.5AA2E370F@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  8 Apr 2003 18:27:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, it was done automatically by the `reti' isntruction upon
returning from the kernel, but that doesn't do the correct thing in
various cases, for instance if there's a context switch, or a softirq.

diff -ruN -X../cludes linux-2.5.67-moo.orig/arch/v850/kernel/nb85e_intc.c linux-2.5.67-moo/arch/v850/kernel/nb85e_intc.c
--- linux-2.5.67-moo.orig/arch/v850/kernel/nb85e_intc.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.67-moo/arch/v850/kernel/nb85e_intc.c	2003-04-08 14:03:02.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/nb85e_intc.c -- NB85E cpu core interrupt controller (INTC)
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -26,6 +26,42 @@
 	return 0;
 }
 
+static void nb85e_intc_end_irq (unsigned irq)
+{
+	unsigned long psw, temp;
+
+	/* Clear the highest-level bit in the In-service priority register
+	   (ISPR), to allow this interrupt (or another of the same or
+	   lesser priority) to happen again.
+
+	   The `reti' instruction normally does this automatically when the
+	   PSW bits EP and NP are zero, but we can't always rely on reti
+	   being used consistently to return after an interrupt (another
+	   process can be scheduled, for instance, which can delay the
+	   associated reti for a long time, or this process may be being
+	   single-stepped, which uses the `dbret' instruction to return
+	   from the kernel).
+
+	   We also set the PSW EP bit, which prevents reti from also
+	   trying to modify the ISPR itself.  */
+
+	/* Get PSW and disable interrupts.  */
+	asm volatile ("stsr psw, %0; di" : "=r" (psw));
+	/* We don't want to do anything for NMIs (they don't use the ISPR).  */
+	if (! (psw & 0xC0)) {
+		/* Transition to `trap' state, so that an eventual real
+		   reti instruction won't modify the ISPR.  */
+		psw |= 0x40;
+		/* Fake an interrupt return, which automatically clears the
+		   appropriate bit in the ISPR.  */
+		asm volatile ("mov hilo(1f), %0;"
+			      "ldsr %0, eipc; ldsr %1, eipsw;"
+			      "reti;"
+			      "1:"
+			      : "=&r" (temp) : "r" (psw));
+	}
+}
+
 /* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
    INITS (which is terminated by an entry with the name field == 0).  */
 void __init nb85e_intc_init_irq_types (struct nb85e_intc_irq_init *inits,
@@ -43,7 +79,7 @@
 		hwit->enable   = nb85e_intc_enable_irq;
 		hwit->disable  = nb85e_intc_disable_irq;
 		hwit->ack      = irq_nop;
-		hwit->end      = irq_nop;
+		hwit->end      = nb85e_intc_end_irq;
 		
 		/* Initialize kernel IRQ infrastructure for this interrupt.  */
 		init_irq_handlers(init->base, init->num, init->interval, hwit);
diff -ruN -X../cludes linux-2.5.67-moo.orig/include/asm-v850/nb85e_intc.h linux-2.5.67-moo/include/asm-v850/nb85e_intc.h
--- linux-2.5.67-moo.orig/include/asm-v850/nb85e_intc.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.67-moo/include/asm-v850/nb85e_intc.h	2003-04-08 14:03:02.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/nb85e_intc.h -- NB85E cpu core interrupt controller (INTC)
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -26,7 +26,7 @@
    address.  */
 #define NB85E_INTC_IC_BASE_ADDR	  0xFFFFF110
 #define NB85E_INTC_IC_ADDR(irq)	  (NB85E_INTC_IC_BASE_ADDR + ((irq) << 1))
-#define NB85E_INTC_IC(irq)	  (*(char *)NB85E_INTC_IC_ADDR(irq))
+#define NB85E_INTC_IC(irq)	  (*(volatile u8 *)NB85E_INTC_IC_ADDR(irq))
 /* Encode priority PR for storing in an interrupt control register.  */
 #define NB85E_INTC_IC_PR(pr)	  (pr)
 /* Interrupt disable bit in an interrupt control register.  */
@@ -36,6 +36,13 @@
 #define NB85E_INTC_IC_IF_BIT	  7
 #define NB85E_INTC_IC_IF	  (1 << NB85E_INTC_IC_IF_BIT)
 
+/* The ISPR (In-service priority register) contains one bit for each interrupt
+   priority level, which is set to one when that level is currently being
+   serviced (and thus blocking any interrupts of equal or lesser level).  */
+#define NB85E_INTC_ISPR_ADDR	  0xFFFFF1FA
+#define NB85E_INTC_ISPR		  (*(volatile u8 *)NB85E_INTC_ISPR_ADDR)
+
+
 #ifndef __ASSEMBLY__
 
 /* Enable interrupt handling for interrupt IRQ.  */
