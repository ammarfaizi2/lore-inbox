Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTELJpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTELJpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:06 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:5149 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262018AbTELJpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:02 -0400
Date: Mon, 12 May 2003 11:54:30 +0200
Message-Id: <200305120954.h4C9sUix000948@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [1/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k core: Update to the new irq API (from Roman Zippel and me) [1/20]

Linus: I sent these to you before in one chunk, but because of the size they
never reached lkml. If you already applied them, please ignore.

--- linux-2.5.69/arch/m68k/kernel/ints.c	Tue Nov  5 10:09:41 2002
+++ linux-m68k-2.5.69/arch/m68k/kernel/ints.c	Tue May  6 13:50:49 2003
@@ -60,14 +60,14 @@
 static void dummy_enable_irq(unsigned int irq);
 static void dummy_disable_irq(unsigned int irq);
 static int dummy_request_irq(unsigned int irq,
-		void (*handler) (int, void *, struct pt_regs *),
+		irqreturn_t (*handler) (int, void *, struct pt_regs *),
 		unsigned long flags, const char *devname, void *dev_id);
 static void dummy_free_irq(unsigned int irq, void *dev_id);
 
 void (*enable_irq) (unsigned int) = dummy_enable_irq;
 void (*disable_irq) (unsigned int) = dummy_disable_irq;
 
-int (*mach_request_irq) (unsigned int, void (*)(int, void *, struct pt_regs *),
+int (*mach_request_irq) (unsigned int, irqreturn_t (*)(int, void *, struct pt_regs *),
                       unsigned long, const char *, void *) = dummy_request_irq;
 void (*mach_free_irq) (unsigned int, void *) = dummy_free_irq;
 
@@ -121,7 +121,7 @@
  * include/asm/irq.h.
  */
 int request_irq(unsigned int irq,
-		void (*handler) (int, void *, struct pt_regs *),
+		irqreturn_t (*handler) (int, void *, struct pt_regs *),
 		unsigned long flags, const char *devname, void *dev_id)
 {
 	return mach_request_irq(irq, handler, flags, devname, dev_id);
@@ -133,7 +133,7 @@
 }
 
 int sys_request_irq(unsigned int irq, 
-                    void (*handler)(int, void *, struct pt_regs *), 
+                    irqreturn_t (*handler)(int, void *, struct pt_regs *), 
                     unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq < IRQ1 || irq > IRQ7) {
@@ -215,7 +215,7 @@
 }
 
 static int dummy_request_irq(unsigned int irq,
-		void (*handler) (int, void *, struct pt_regs *),
+		irqreturn_t (*handler) (int, void *, struct pt_regs *),
 		unsigned long flags, const char *devname, void *dev_id)
 {
 	printk("calling uninitialized request_irq()\n");
--- linux-2.5.69/arch/m68k/kernel/setup.c	Mon May  5 10:30:22 2003
+++ linux-m68k-2.5.69/arch/m68k/kernel/setup.c	Fri May  9 10:21:30 2003
@@ -67,14 +67,14 @@
 
 char m68k_debug_device[6] = "";
 
-void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
+void (*mach_sched_init) (irqreturn_t (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void) __initdata = NULL;
-void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
+irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
 void (*mach_get_model) (char *model) = NULL;
 int (*mach_get_hardware_list) (char *buffer) = NULL;
 int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
-void (*mach_process_int) (int, struct pt_regs *) = NULL;
+irqreturn_t (*mach_process_int) (int, struct pt_regs *) = NULL;
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
 int (*mach_hwclk) (int, struct rtc_time*) = NULL;
--- linux-2.5.69/arch/m68k/kernel/time.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.5.69/arch/m68k/kernel/time.c	Tue May  6 13:50:49 2003
@@ -57,7 +57,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static void timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
+static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
 	do_timer(regs);
 
@@ -87,6 +87,7 @@
 	    }
 	}
 #endif /* CONFIG_HEARTBEAT */
+	return IRQ_HANDLED;
 }
 
 void time_init(void)
--- linux-2.5.69/include/asm-m68k/irq.h	Mon May  5 10:32:45 2003
+++ linux-m68k-2.5.69/include/asm-m68k/irq.h	Tue May  6 13:50:50 2003
@@ -2,6 +2,7 @@
 #define _M68K_IRQ_H_
 
 #include <linux/config.h>
+#include <linux/interrupt.h>
 
 /*
  * # of m68k interrupts
@@ -76,7 +77,7 @@
 struct pt_regs;
 
 extern int sys_request_irq(unsigned int, 
-	void (*)(int, void *, struct pt_regs *), 
+	irqreturn_t (*)(int, void *, struct pt_regs *), 
 	unsigned long, const char *, void *);
 extern void sys_free_irq(unsigned int, void *);
 
@@ -98,7 +99,7 @@
  * interrupt source (if it supports chaining).
  */
 typedef struct irq_node {
-	void		(*handler)(int, void *, struct pt_regs *);
+	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
@@ -109,7 +110,7 @@
  * This structure has only 4 elements for speed reasons
  */
 typedef struct irq_handler {
-	void		(*handler)(int, void *, struct pt_regs *);
+	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
--- linux-2.5.69/include/asm-m68k/machdep.h	Fri Jan 17 12:09:37 2003
+++ linux-m68k-2.5.69/include/asm-m68k/machdep.h	Fri May  9 10:21:35 2003
@@ -2,6 +2,7 @@
 #define _M68K_MACHDEP_H
 
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 struct pt_regs;
 struct mktime;
@@ -9,17 +10,17 @@
 struct rtc_pll_info;
 struct buffer_head;
 
-extern void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *));
+extern void (*mach_sched_init) (irqreturn_t (*handler)(int, void *, struct pt_regs *));
 /* machine dependent irq functions */
 extern void (*mach_init_IRQ) (void);
-extern void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
-extern int (*mach_request_irq) (unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+extern irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
+extern int (*mach_request_irq) (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
                                 unsigned long flags, const char *devname, void *dev_id);
 extern void (*mach_free_irq) (unsigned int irq, void *dev_id);
 extern void (*mach_get_model) (char *model);
 extern int (*mach_get_hardware_list) (char *buffer);
 extern int (*mach_get_irq_list) (struct seq_file *p, void *v);
-extern void (*mach_process_int) (int irq, struct pt_regs *fp);
+extern irqreturn_t (*mach_process_int) (int irq, struct pt_regs *fp);
 /* machine dependent timer functions */
 extern unsigned long (*mach_gettimeoffset)(void);
 extern int (*mach_hwclk)(int, struct rtc_time*);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
