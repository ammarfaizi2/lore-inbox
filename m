Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTELJqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTELJqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:46:34 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:8285 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262031AbTELJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:08 -0400
Date: Mon, 12 May 2003 11:54:39 +0200
Message-Id: <200305120954.h4C9sdkg001009@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [10/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Q40: Update to the new irq API (from Roman Zippel and me) [10/20]

--- linux-2.5.69/arch/m68k/q40/config.c	Fri Jan 17 12:09:17 2003
+++ linux-m68k-2.5.69/arch/m68k/q40/config.c	Fri May  9 10:21:30 2003
@@ -39,8 +39,8 @@
 
 extern void floppy_setup(char *str, int *ints);
 
-extern void q40_process_int (int level, struct pt_regs *regs);
-extern void (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
+extern irqreturn_t q40_process_int (int level, struct pt_regs *regs);
+extern irqreturn_t (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
 extern void q40_free_irq (unsigned int, void *);
 extern int  show_q40_interrupts (struct seq_file *, void *);
@@ -48,8 +48,8 @@
 extern void q40_disable_irq (unsigned int);
 static void q40_get_model(char *model);
 static int  q40_get_hardware_list(char *buffer);
-extern int  q40_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
-extern void q40_sched_init(void (*handler)(int, void *, struct pt_regs *));
+extern int  q40_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
+extern void q40_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 
 extern unsigned long q40_gettimeoffset (void);
 extern int q40_hwclk (int, struct rtc_time *);
--- linux-2.5.69/arch/m68k/q40/q40ints.c	Tue Mar 25 10:06:09 2003
+++ linux-m68k-2.5.69/arch/m68k/q40/q40ints.c	Fri May  9 10:21:30 2003
@@ -43,19 +43,19 @@
 extern int ints_inited;
 
 
-void q40_irq2_handler (int, void *, struct pt_regs *fp);
+irqreturn_t q40_irq2_handler (int, void *, struct pt_regs *fp);
 
 
-extern void (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);
+extern irqreturn_t (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);
 
-static void q40_defhand (int irq, void *dev_id, struct pt_regs *fp);
-static void sys_default_handler(int lev, void *dev_id, struct pt_regs *regs);
+static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t sys_default_handler(int lev, void *dev_id, struct pt_regs *regs);
 
 
 #define DEVNAME_SIZE 24
 
 static struct q40_irq_node {
-	void		(*handler)(int, void *, struct pt_regs *);
+	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
 	unsigned long	flags;
 	void		*dev_id;
   /*        struct q40_irq_node *next;*/
@@ -106,7 +106,7 @@
 }
 
 int q40_request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
                 unsigned long flags, const char *devname, void *dev_id)
 {
   /*printk("q40_request_irq %d, %s\n",irq,devname);*/
@@ -198,9 +198,10 @@
 }
 
 
-void q40_process_int (int level, struct pt_regs *fp)
+irqreturn_t q40_process_int (int level, struct pt_regs *fp)
 {
   printk("unexpected interrupt %x\n",level);
+  return IRQ_HANDLED;
 }
 
 /* 
@@ -231,9 +232,9 @@
   sound_ticks=ticks<<1;
 }
 
-static void (*q40_timer_routine)(int, void *, struct pt_regs *);
+static irqreturn_t (*q40_timer_routine)(int, void *, struct pt_regs *);
 
-static void q40_timer_int (int irq, void * dev, struct pt_regs * regs)
+static irqreturn_t q40_timer_int (int irq, void * dev, struct pt_regs * regs)
 {
     ql_ticks = ql_ticks ? 0 : 1;
     if (sound_ticks)
@@ -244,12 +245,12 @@
 	*DAC_RIGHT=sval;
       }
 
-    if (ql_ticks) return;
-
-    q40_timer_routine(irq, dev, regs);
+    if (!ql_ticks)
+	q40_timer_routine(irq, dev, regs);
+    return IRQ_HANDLED;
 }
 
-void q40_sched_init (void (*timer_routine)(int, void *, struct pt_regs *))
+void q40_sched_init (irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
     int timer_irq;
 
@@ -312,7 +313,7 @@
 
 
 /* got level 2 interrupt, dispatch to ISA or keyboard/timer IRQs */
-void q40_irq2_handler (int vec, void *devname, struct pt_regs *fp)
+irqreturn_t q40_irq2_handler (int vec, void *devname, struct pt_regs *fp)
 {
   unsigned mir, mer;
   int irq,i;
@@ -378,7 +379,7 @@
 #endif
 			  }
 // used to do 'goto repeat;' her, this delayed bh processing too long
-			  return;
+			  return IRQ_HANDLED;
 		  }
 	  }
 	  if (mer && ccleirq>0 && !aliased_irq) 
@@ -390,6 +391,7 @@
 	  irq_tab[Q40_IRQ_KEYBOARD].count++;
 	  irq_tab[Q40_IRQ_KEYBOARD].handler(Q40_IRQ_KEYBOARD,irq_tab[Q40_IRQ_KEYBOARD].dev_id,fp);
   }
+  return IRQ_HANDLED;
 }
 
 int show_q40_interrupts (struct seq_file *p, void *v)
@@ -409,16 +411,18 @@
 }
 
 
-static void q40_defhand (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
 	printk ("Unknown q40 interrupt 0x%02x\n", irq);
+	return IRQ_NONE;
 }
-static void sys_default_handler(int lev, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sys_default_handler(int lev, void *dev_id, struct pt_regs *regs)
 {
 	printk ("Uninitialised interrupt level %d\n", lev);
+	return IRQ_NONE;
 }
 
- void (*q40_sys_default_handler[SYS_IRQS]) (int, void *, struct pt_regs *) = {
+ irqreturn_t (*q40_sys_default_handler[SYS_IRQS]) (int, void *, struct pt_regs *) = {
 	 sys_default_handler,sys_default_handler,sys_default_handler,sys_default_handler,
 	 sys_default_handler,sys_default_handler,sys_default_handler,sys_default_handler
  };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
