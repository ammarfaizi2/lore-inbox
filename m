Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTELJqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTELJqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:46:23 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:31566 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262032AbTELJpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:07 -0400
Date: Mon, 12 May 2003 11:54:38 +0200
Message-Id: <200305120954.h4C9sciG001003@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [9/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k MVME16x: Update to the new irq API (from Roman Zippel and me) [9/20]

--- linux-2.5.69/arch/m68k/mvme16x/16xints.c	Sun Dec  9 15:15:24 2001
+++ linux-m68k-2.5.69/arch/m68k/mvme16x/16xints.c	Fri May  9 10:21:30 2003
@@ -20,14 +20,14 @@
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 
-static void mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp);
 
 /*
  * This should ideally be 4 elements only, for speed.
  */
 
 static struct {
-	void		(*handler)(int, void *, struct pt_regs *);
+	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
@@ -60,7 +60,7 @@
 }
 
 int mvme16x_request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
                 unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq < 64 || irq > 255) {
@@ -104,14 +104,15 @@
 	irq_tab[irq-64].devname = NULL;
 }
 
-void mvme16x_process_int (unsigned long vec, struct pt_regs *fp)
+irqreturn_t mvme16x_process_int (unsigned long vec, struct pt_regs *fp)
 {
-	if (vec < 64 || vec > 255)
+	if (vec < 64 || vec > 255) {
 		printk ("mvme16x_process_int: Illegal vector %ld", vec);
-	else
-	{
+		return IRQ_NONE;
+	} else {
 		irq_tab[vec-64].count++;
 		irq_tab[vec-64].handler(vec, irq_tab[vec-64].dev_id, fp);
+		return IRQ_HANDLED;
 	}
 }
 
@@ -129,9 +130,10 @@
 }
 
 
-static void mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
 	printk ("Unknown interrupt 0x%02x\n", irq);
+	return IRQ_NONE;
 }
 
 
--- linux-2.5.69/arch/m68k/mvme16x/config.c	Thu Jan  2 12:53:57 2003
+++ linux-m68k-2.5.69/arch/m68k/mvme16x/config.c	Fri May  9 10:21:30 2003
@@ -40,7 +40,7 @@
 
 static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
 
-extern void mvme16x_process_int (int level, struct pt_regs *regs);
+extern irqreturn_t mvme16x_process_int (int level, struct pt_regs *regs);
 extern void mvme16x_init_IRQ (void);
 extern void mvme16x_free_irq (unsigned int, void *);
 extern int show_mvme16x_interrupts (struct seq_file *, void *);
@@ -48,8 +48,8 @@
 extern void mvme16x_disable_irq (unsigned int);
 static void mvme16x_get_model(char *model);
 static int  mvme16x_get_hardware_list(char *buffer);
-extern int  mvme16x_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
-extern void mvme16x_sched_init(void (*handler)(int, void *, struct pt_regs *));
+extern int  mvme16x_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
+extern void mvme16x_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long mvme16x_gettimeoffset (void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
 extern int mvme16x_set_clock_mmss (unsigned long);
@@ -61,7 +61,7 @@
 /* Save tick handler routine pointer, will point to do_timer() in
  * kernel/sched.c, called via mvme16x_process_int() */
 
-static void (*tick_handler)(int, void *, struct pt_regs *);
+static irqreturn_t (*tick_handler)(int, void *, struct pt_regs *);
 
 
 unsigned short mvme16x_config;
@@ -193,7 +193,7 @@
     }
 }
 
-static void mvme16x_abort_int (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t mvme16x_abort_int (int irq, void *dev_id, struct pt_regs *fp)
 {
 	p_bdid p = &mvme_bdid;
 	unsigned long *new = (unsigned long *)vectors;
@@ -218,15 +218,16 @@
 		*(new+0x5e) = *(old+0x5e);	/* ABORT switch */
 	else
 		*(new+0x6e) = *(old+0x6e);	/* ABORT switch */
+	return IRQ_HANDLED;
 }
 
-static void mvme16x_timer_int (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t mvme16x_timer_int (int irq, void *dev_id, struct pt_regs *fp)
 {
     *(volatile unsigned char *)0xfff4201b |= 8;
-    tick_handler(irq, dev_id, fp);
+    return tick_handler(irq, dev_id, fp);
 }
 
-void mvme16x_sched_init (void (*timer_routine)(int, void *, struct pt_regs *))
+void mvme16x_sched_init (irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
     p_bdid p = &mvme_bdid;
     int irq;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
