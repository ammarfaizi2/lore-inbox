Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTELJqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTELJqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:46:15 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:55874 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262030AbTELJpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:06 -0400
Date: Mon, 12 May 2003 11:54:38 +0200
Message-Id: <200305120954.h4C9scwD000997@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [8/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k MVME147: Update to the new irq API (from Roman Zippel and me) [8/20]

--- linux-2.5.69/arch/m68k/mvme147/147ints.c	Sun Dec  9 15:15:24 2001
+++ linux-m68k-2.5.69/arch/m68k/mvme147/147ints.c	Fri May  9 10:21:30 2003
@@ -21,14 +21,14 @@
 #include <asm/irq.h>
 #include <asm/traps.h>
 
-static void mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp);
 
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
 
 int mvme147_request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
                 unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq > 255) {
@@ -102,14 +102,15 @@
 	irq_tab[irq].devname = NULL;
 }
 
-void mvme147_process_int (unsigned long vec, struct pt_regs *fp)
+irqreturn_t mvme147_process_int (unsigned long vec, struct pt_regs *fp)
 {
-	if (vec > 255)
+	if (vec > 255) {
 		printk ("mvme147_process_int: Illegal vector %ld\n", vec);
-	else
-	{
+		return IRQ_NONE;
+	} else {
 		irq_tab[vec].count++;
 		irq_tab[vec].handler(vec, irq_tab[vec].dev_id, fp);
+		return IRQ_HANDLED;
 	}
 }
 
@@ -127,9 +128,10 @@
 }
 
 
-static void mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
 	printk ("Unknown interrupt 0x%02x\n", irq);
+	return IRQ_NONE;
 }
 
 void mvme147_enable_irq (unsigned int irq)
--- linux-2.5.69/arch/m68k/mvme147/config.c	Thu Jan  2 12:53:57 2003
+++ linux-m68k-2.5.69/arch/m68k/mvme147/config.c	Fri May  9 10:21:30 2003
@@ -36,7 +36,7 @@
 #include <asm/mvme147hw.h>
 
 
-extern void mvme147_process_int (int level, struct pt_regs *regs);
+extern irqreturn_t mvme147_process_int (int level, struct pt_regs *regs);
 extern void mvme147_init_IRQ (void);
 extern void mvme147_free_irq (unsigned int, void *);
 extern int  show_mvme147_interrupts (struct seq_file *, void *);
@@ -44,8 +44,8 @@
 extern void mvme147_disable_irq (unsigned int);
 static void mvme147_get_model(char *model);
 static int  mvme147_get_hardware_list(char *buffer);
-extern int mvme147_request_irq (unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
-extern void mvme147_sched_init(void (*handler)(int, void *, struct pt_regs *));
+extern int mvme147_request_irq (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
+extern void mvme147_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long mvme147_gettimeoffset (void);
 extern int mvme147_hwclk (int, struct rtc_time *);
 extern int mvme147_set_clock_mmss (unsigned long);
@@ -58,7 +58,7 @@
 /* Save tick handler routine pointer, will point to do_timer() in
  * kernel/sched.c, called via mvme147_process_int() */
 
-void (*tick_handler)(int, void *, struct pt_regs *);
+irqreturn_t (*tick_handler)(int, void *, struct pt_regs *);
 
 
 int mvme147_parse_bootinfo(const struct bi_record *bi)
@@ -118,15 +118,15 @@
 
 /* Using pcc tick timer 1 */
 
-static void mvme147_timer_int (int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t mvme147_timer_int (int irq, void *dev_id, struct pt_regs *fp)
 {
 	m147_pcc->t1_int_cntrl = PCC_TIMER_INT_CLR;  
 	m147_pcc->t1_int_cntrl = PCC_INT_ENAB|PCC_LEVEL_TIMER1;   
-	tick_handler(irq, dev_id, fp);
+	return tick_handler(irq, dev_id, fp);
 }
 
 
-void mvme147_sched_init (void (*timer_routine)(int, void *, struct pt_regs *))
+void mvme147_sched_init (irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
 	tick_handler = timer_routine;
 	request_irq (PCC_IRQ_TIMER1, mvme147_timer_int, 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
