Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTELJzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTELJq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:46:59 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:19022 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262036AbTELJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:08 -0400
Date: Mon, 12 May 2003 11:54:40 +0200
Message-Id: <200305120954.h4C9seet001015@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [11/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Sun-3: Update to the new irq API (from Roman Zippel and me) [11/20]

--- linux-2.5.69/arch/m68k/sun3/config.c	Wed Mar  5 10:06:39 2003
+++ linux-m68k-2.5.69/arch/m68k/sun3/config.c	Tue May  6 13:50:50 2003
@@ -37,7 +37,7 @@
 
 extern unsigned long sun3_gettimeoffset(void);
 extern int show_sun3_interrupts (struct seq_file *, void *);
-extern void sun3_sched_init(void (*handler)(int, void *, struct pt_regs *));
+extern void sun3_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern void sun3_get_model (char* model);
 extern void idprom_init (void);
 extern int sun3_hwclk(int set, struct rtc_time *t);
@@ -174,7 +174,7 @@
 	sun3_bootmem_alloc(memory_start, memory_end);
 }
 
-void __init sun3_sched_init(void (*timer_routine)(int, void *, struct pt_regs *))
+void __init sun3_sched_init(irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
 	sun3_disable_interrupts();
         intersil_clock->cmd_reg=(INTERSIL_RUN|INTERSIL_INT_DISABLE|INTERSIL_24H_MODE);
--- linux-2.5.69/arch/m68k/sun3/sun3ints.c	Tue Nov  5 10:09:42 2002
+++ linux-m68k-2.5.69/arch/m68k/sun3/sun3ints.c	Fri May  9 10:21:30 2003
@@ -18,7 +18,7 @@
 #include <linux/seq_file.h>
 
 extern void sun3_leds (unsigned char);
-static void sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp);
 
 void sun3_disable_interrupts(void)
 {
@@ -64,15 +64,16 @@
 	*sun3_intreg |=  (1<<irq);
 }
 
-static void sun3_int7(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t sun3_int7(int irq, void *dev_id, struct pt_regs *fp)
 {
 	sun3_do_irq(irq,fp);
 	if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 2000)) 
 		sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%16000)
 			  /2000]);
+	return IRQ_HANDLED;
 }
 
-static void sun3_int5(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t sun3_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
         kstat_cpu(0).irqs[SYS_IRQS + irq]++;
 #ifdef CONFIG_SUN3
@@ -87,11 +88,12 @@
         if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 20))
                 sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%160)
                 /20]);
+	return IRQ_HANDLED;
 }
 
 /* handle requested ints, excepting 5 and 7, which always do the same
    thing */
-void (*sun3_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
+irqreturn_t (*sun3_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
 	sun3_inthandle, sun3_inthandle, sun3_inthandle, sun3_inthandle,
 	sun3_inthandle, sun3_int5, sun3_inthandle, sun3_int7
 };
@@ -99,10 +101,10 @@
 static const char *dev_names[SYS_IRQS] = { NULL, NULL, NULL, NULL, 
 				     NULL, "timer", NULL, "int7 handler" };
 static void *dev_ids[SYS_IRQS];
-static void (*sun3_inthandler[SYS_IRQS])(int, void *, struct pt_regs *) = {
+static irqreturn_t (*sun3_inthandler[SYS_IRQS])(int, void *, struct pt_regs *) = {
 	NULL, NULL, NULL, NULL, NULL, sun3_int5, NULL, sun3_int7
 };
-static void (*sun3_vechandler[SUN3_INT_VECS])(int, void *, struct pt_regs *);
+static irqreturn_t (*sun3_vechandler[SUN3_INT_VECS])(int, void *, struct pt_regs *);
 static void *vec_ids[SUN3_INT_VECS];
 static const char *vec_names[SUN3_INT_VECS];
 static int vec_ints[SUN3_INT_VECS];
@@ -124,7 +126,7 @@
 	return 0;
 }
 
-static void sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp)
 {
 	if(sun3_inthandler[irq] == NULL)
 		panic ("bad interrupt %d received (id %p)\n",irq, dev_id);
@@ -133,11 +135,13 @@
         *sun3_intreg &= ~(1<<irq);
 
 	sun3_inthandler[irq](irq, dev_ids[irq], fp);
+	return IRQ_HANDLED;
 }
 
-static void sun3_vec255(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t sun3_vec255(int irq, void *dev_id, struct pt_regs *fp)
 {
 //	intersil_clear();
+	return IRQ_HANDLED;
 }
 
 void sun3_init_IRQ(void)
@@ -159,7 +163,7 @@
 	sun3_vechandler[191] = sun3_vec255;
 }
                                 
-int sun3_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+int sun3_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
                       unsigned long flags, const char *devname, void *dev_id)
 {
 
@@ -228,7 +232,7 @@
 	}		
 }
 
-void sun3_process_int(int irq, struct pt_regs *regs)
+irqreturn_t sun3_process_int(int irq, struct pt_regs *regs)
 {
 
 	if((irq >= 64) && (irq <= 255)) {
@@ -239,8 +243,7 @@
 			panic ("bad interrupt vector %d received\n",irq);
 
 		vec_ints[vec]++;
-		sun3_vechandler[vec](irq, vec_ids[vec], regs);
-		return;
+		return sun3_vechandler[vec](irq, vec_ids[vec], regs);
 	} else {
 		panic("sun3_process_int: unable to handle interrupt vector %d\n",
 		      irq);
--- linux-2.5.69/include/asm-m68k/sun3ints.h	Tue Nov  5 10:10:13 2002
+++ linux-m68k-2.5.69/include/asm-m68k/sun3ints.h	Fri May  9 10:21:35 2003
@@ -26,17 +26,17 @@
 void sun3_enable_irq(unsigned int irq);
 void sun3_disable_irq(unsigned int irq);
 int sun3_request_irq(unsigned int irq,
-                     void (*handler)(int, void *, struct pt_regs *),
+                     irqreturn_t (*handler)(int, void *, struct pt_regs *),
                      unsigned long flags, const char *devname, void *dev_id
 		    );
 extern void sun3_init_IRQ (void);
-extern void (*sun3_default_handler[]) (int, void *, struct pt_regs *);
-extern void (*sun3_inthandler[]) (int, void *, struct pt_regs *);
+extern irqreturn_t (*sun3_default_handler[]) (int, void *, struct pt_regs *);
+extern irqreturn_t (*sun3_inthandler[]) (int, void *, struct pt_regs *);
 extern void sun3_free_irq (unsigned int irq, void *dev_id);
 extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
 extern int show_sun3_interrupts(struct seq_file *, void *);
-extern void sun3_process_int(int, struct pt_regs *);
+extern irqreturn_t sun3_process_int(int, struct pt_regs *);
 extern volatile unsigned char* sun3_intreg;
 
 /* master list of VME vectors -- don't fuck with this */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
