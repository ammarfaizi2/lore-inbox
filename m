Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbTFXFNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTFXFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:13:50 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:62425 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265694AbTFXFN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:13:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  More irqreturn_t changes for v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030624052716.B44D23728@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 24 Jun 2003 14:27:16 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.73-moo/arch/v850/kernel/gbus_int.c linux-2.5.73-moo-v850-20030624/arch/v850/kernel/gbus_int.c
--- linux-2.5.73-moo/arch/v850/kernel/gbus_int.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.73-moo-v850-20030624/arch/v850/kernel/gbus_int.c	2003-06-24 14:13:19.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/gbus_int.c -- Midas labs GBUS interrupt support
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -99,9 +99,11 @@
 
 /* Handle a shared GINT interrupt by passing to the appropriate GBUS
    interrupt handler.  */
-static void gbus_int_handle_irq (int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t gbus_int_handle_irq (int irq, void *dev_id,
+					struct pt_regs *regs)
 {
 	unsigned w;
+	irqreturn_t rval = IRQ_NONE;
 	unsigned gint = irq - IRQ_GINT (0);
 
 	for (w = 0; w < GBUS_INT_NUM_WORDS; w++) {
@@ -127,6 +129,7 @@
 
 				/* Recursively call handle_irq to handle it. */
 				handle_irq (irq, regs);
+				rval = IRQ_HANDLED;
 			} while (status);
 		}
 	}
@@ -136,6 +139,8 @@
 	   still pending, and so result in another CPU interrupt.  */
 	GBUS_INT_ENABLE (0, gint) &= ~0x1;
 	GBUS_INT_ENABLE (0, gint) |=  0x1;
+
+	return rval;
 }
 
 
diff -ruN -X../cludes linux-2.5.73-moo/arch/v850/kernel/simcons.c linux-2.5.73-moo-v850-20030624/arch/v850/kernel/simcons.c
--- linux-2.5.73-moo/arch/v850/kernel/simcons.c	2003-06-16 14:52:17.000000000 +0900
+++ linux-2.5.73-moo-v850-20030624/arch/v850/kernel/simcons.c	2003-06-24 13:23:27.000000000 +0900
@@ -30,7 +30,7 @@
 	V850_SIM_SYSCALL (write, 1, buf, len);
 }
 
-static int simcons_read (struct console *co, const char *buf, unsigned len)
+static int simcons_read (struct console *co, char *buf, unsigned len)
 {
 	return V850_SIM_SYSCALL (read, 0, buf, len);
 }
diff -ruN -X../cludes linux-2.5.73-moo/arch/v850/kernel/time.c linux-2.5.73-moo-v850-20030624/arch/v850/kernel/time.c
--- linux-2.5.73-moo/arch/v850/kernel/time.c	2003-06-17 14:00:05.000000000 +0900
+++ linux-2.5.73-moo-v850-20030624/arch/v850/kernel/time.c	2003-06-24 13:51:01.000000000 +0900
@@ -51,7 +51,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static void timer_interrupt (int irq, void *dummy, struct pt_regs *regs)
+static irqreturn_t timer_interrupt (int irq, void *dummy, struct pt_regs *regs)
 {
 #if 0
 	/* last time the cmos clock got updated */
@@ -106,6 +106,8 @@
 	}
 #endif /* CONFIG_HEARTBEAT */
 #endif /* 0 */
+
+	return IRQ_HANDLED;
 }
 
 /*
