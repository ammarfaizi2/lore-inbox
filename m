Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTELJqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTELJpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:39 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:34375 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262025AbTELJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:04 -0400
Date: Mon, 12 May 2003 11:54:36 +0200
Message-Id: <200305120954.h4C9sakT000979@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [5/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k BVME6000: Update to the new irq API (from Roman Zippel and me) [5/20]

--- linux-2.5.69/arch/m68k/bvme6000/bvmeints.c	Sun Dec  9 15:15:24 2001
+++ linux-m68k-2.5.69/arch/m68k/bvme6000/bvmeints.c	Fri May  9 10:21:30 2003
@@ -21,14 +21,14 @@
 #include <asm/irq.h>
 #include <asm/traps.h>
 
-static void bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp);
 
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
 
 int bvme6000_request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
                 unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq > 255) {
@@ -117,14 +117,15 @@
 	irq_tab[irq].devname = NULL;
 }
 
-void bvme6000_process_int (unsigned long vec, struct pt_regs *fp)
+irqreturn_t bvme6000_process_int (unsigned long vec, struct pt_regs *fp)
 {
-	if (vec > 255)
+	if (vec > 255) {
 		printk ("bvme6000_process_int: Illegal vector %ld", vec);
-	else
-	{
+		return IRQ_NONE;
+	} else {
 		irq_tab[vec].count++;
 		irq_tab[vec].handler(vec, irq_tab[vec].dev_id, fp);
+		return IRQ_HANDLED;
 	}
 }
 
@@ -142,9 +143,10 @@
 }
 
 
-static void bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
 	printk ("Unknown interrupt 0x%02x\n", irq);
+	return IRQ_NONE;
 }
 
 void bvme6000_enable_irq (unsigned int irq)
--- linux-2.5.69/arch/m68k/bvme6000/config.c	Thu Jan  2 12:53:56 2003
+++ linux-m68k-2.5.69/arch/m68k/bvme6000/config.c	Fri May  9 10:21:30 2003
@@ -36,7 +36,7 @@
 #include <asm/machdep.h>
 #include <asm/bvme6000hw.h>
 
-extern void bvme6000_process_int (int level, struct pt_regs *regs);
+extern irqreturn_t bvme6000_process_int (int level, struct pt_regs *regs);
 extern void bvme6000_init_IRQ (void);
 extern void bvme6000_free_irq (unsigned int, void *);
 extern int  show_bvme6000_interrupts(struct seq_file *, void *);
@@ -44,8 +44,8 @@
 extern void bvme6000_disable_irq (unsigned int);
 static void bvme6000_get_model(char *model);
 static int  bvme6000_get_hardware_list(char *buffer);
-extern int  bvme6000_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
-extern void bvme6000_sched_init(void (*handler)(int, void *, struct pt_regs *));
+extern int  bvme6000_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
+extern void bvme6000_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long bvme6000_gettimeoffset (void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
 extern int bvme6000_set_clock_mmss (unsigned long);
@@ -59,7 +59,7 @@
 /* Save tick handler routine pointer, will point to do_timer() in
  * kernel/sched.c, called via bvme6000_process_int() */
 
-static void (*tick_handler)(int, void *, struct pt_regs *);
+static irqreturn_t (*tick_handler)(int, void *, struct pt_regs *);
 
 
 int bvme6000_parse_bootinfo(const struct bi_record *bi)
@@ -159,7 +159,7 @@
 }
 
 
-void bvme6000_abort_int (int irq, void *dev_id, struct pt_regs *fp)
+irqreturn_t bvme6000_abort_int (int irq, void *dev_id, struct pt_regs *fp)
 {
         unsigned long *new = (unsigned long *)vectors;
         unsigned long *old = (unsigned long *)0xf8000000;
@@ -172,17 +172,18 @@
         *(new+9) = *(old+9);            /* Trace */
         *(new+47) = *(old+47);          /* Trap #15 */
         *(new+0x1f) = *(old+0x1f);      /* ABORT switch */
+	return IRQ_HANDLED;
 }
 
 
-static void bvme6000_timer_int (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t bvme6000_timer_int (int irq, void *dev_id, struct pt_regs *fp)
 {
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
     unsigned char msr = rtc->msr & 0xc0;
 
     rtc->msr = msr | 0x20;		/* Ack the interrupt */
 
-    tick_handler(irq, dev_id, fp);
+    return tick_handler(irq, dev_id, fp);
 }
 
 /*
@@ -194,7 +195,7 @@
  * so divide by 8 to get the microsecond result.
  */
 
-void bvme6000_sched_init (void (*timer_routine)(int, void *, struct pt_regs *))
+void bvme6000_sched_init (irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
     volatile RtcPtr_t rtc = (RtcPtr_t)BVME_RTC_BASE;
     unsigned char msr = rtc->msr & 0xc0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
