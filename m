Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTELJqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbTELJpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:45 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:45897 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262028AbTELJpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:05 -0400
Date: Mon, 12 May 2003 11:54:37 +0200
Message-Id: <200305120954.h4C9sb83000985@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [6/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k HP9000/300: Update to the new irq API (from Roman Zippel and me) [6/20]

--- linux-2.5.69/arch/m68k/hp300/config.c	Sat Oct 12 19:20:00 2002
+++ linux-m68k-2.5.69/arch/m68k/hp300/config.c	Tue May  6 13:50:49 2003
@@ -23,7 +23,7 @@
 #include "time.h"
 
 extern void hp300_reset(void);
-extern void (*hp300_default_handler[])(int, void *, struct pt_regs *);
+extern irqreturn_t (*hp300_default_handler[])(int, void *, struct pt_regs *);
 extern int show_hp300_interrupts(struct seq_file *, void *);
 
 #ifdef CONFIG_HEARTBEAT
--- linux-2.5.69/arch/m68k/hp300/ints.c	Thu Jul 25 12:53:33 2002
+++ linux-m68k-2.5.69/arch/m68k/hp300/ints.c	Tue May  6 13:50:49 2003
@@ -42,7 +42,7 @@
 static spinlock_t irqlist_lock;
 
 /* This handler receives all interrupts, dispatching them to the registered handlers */
-static void hp300_int_handler(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t hp300_int_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
         irq_node_t *t;
         /* We just give every handler on the chain an opportunity to handle
@@ -54,9 +54,10 @@
          * etc, in here. Note that currently we can't tell whether or not
          * a handler handles the interrupt, though. 
          */
+	return IRQ_HANDLED;
 }
 
-void (*hp300_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
+irqreturn_t (*hp300_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
 	hp300_int_handler, hp300_int_handler, hp300_int_handler, hp300_int_handler,
 	hp300_int_handler, hp300_int_handler, hp300_int_handler, NULL
 };
@@ -70,7 +71,7 @@
  * matters (eg the dreaded FIFOless UART...)
  */
 int hp300_request_irq(unsigned int irq,
-                      void (*handler) (int, void *, struct pt_regs *),
+                      irqreturn_t (*handler) (int, void *, struct pt_regs *),
                       unsigned long flags, const char *devname, void *dev_id)
 {
         irq_node_t *t, *n = new_irq_node();
--- linux-2.5.69/arch/m68k/hp300/ints.h	Wed Sep  2 18:39:18 1998
+++ linux-m68k-2.5.69/arch/m68k/hp300/ints.h	Tue May  6 13:50:49 2003
@@ -2,7 +2,7 @@
 extern void (*hp300_handlers[8])(int, void *, struct pt_regs *);
 extern void hp300_free_irq(unsigned int irq, void *dev_id);
 extern int hp300_request_irq(unsigned int irq,
-		void (*handler) (int, void *, struct pt_regs *),
+		irqreturn_t (*handler) (int, void *, struct pt_regs *),
 		unsigned long flags, const char *devname, void *dev_id);
 
 /* number of interrupts, includes 0 (what's that?) */
--- linux-2.5.69/arch/m68k/hp300/time.c	Tue Nov  5 10:09:41 2002
+++ linux-m68k-2.5.69/arch/m68k/hp300/time.c	Tue May  6 13:50:49 2003
@@ -36,13 +36,13 @@
 
 #define INTVAL ((10000 / 4) - 1)
 
-static void hp300_tick(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t hp300_tick(int irq, void *dev_id, struct pt_regs *regs)
 {
   unsigned long tmp;
-  void (*vector)(int, void *, struct pt_regs *) = dev_id;
+  irqreturn_t (*vector)(int, void *, struct pt_regs *) = dev_id;
   in_8(CLOCKBASE + CLKSR);
   asm volatile ("movpw %1@(5),%0" : "=d" (tmp) : "a" (CLOCKBASE));
-  vector(irq, NULL, regs);
+  return vector(irq, NULL, regs);
 }
 
 unsigned long hp300_gettimeoffset(void)
@@ -61,7 +61,7 @@
   return (USECS_PER_JIFFY * ticks) / INTVAL;
 }
 
-void __init hp300_sched_init(void (*vector)(int, void *, struct pt_regs *))
+void __init hp300_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *))
 {
   out_8(CLOCKBASE + CLKCR2, 0x1);		/* select CR1 */
   out_8(CLOCKBASE + CLKCR1, 0x1);		/* reset */
--- linux-2.5.69/arch/m68k/hp300/time.h	Sat Jun 13 22:14:31 1998
+++ linux-m68k-2.5.69/arch/m68k/hp300/time.h	Tue May  6 13:50:49 2003
@@ -1,4 +1,4 @@
-extern void hp300_sched_init(void (*vector)(int, void *, struct pt_regs *));
+extern void hp300_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *));
 extern unsigned long hp300_gettimeoffset (void);
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
