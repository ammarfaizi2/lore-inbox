Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTELJqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTELJpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:30 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:52279 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262023AbTELJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:03 -0400
Date: Mon, 12 May 2003 11:54:35 +0200
Message-Id: <200305120954.h4C9sZ7O000973@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [4/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Atari: Update to the new irq API (from Roman Zippel and me) [4/20]

--- linux-2.5.69/arch/m68k/atari/ataints.c	Tue Mar 25 10:06:07 2003
+++ linux-m68k-2.5.69/arch/m68k/atari/ataints.c	Tue May  6 13:50:49 2003
@@ -110,7 +110,7 @@
 typedef void (*asm_irq_handler)(void);
 
 struct irqhandler {
-	void	(*handler)(int, void *, struct pt_regs *);
+	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	void	*dev_id;
 };
 
@@ -404,12 +404,13 @@
 }
 
 
-static void atari_call_irq_list( int irq, void *dev_id, struct pt_regs *fp )
+static irqreturn_t atari_call_irq_list( int irq, void *dev_id, struct pt_regs *fp )
 {
 	irq_node_t *node;
 
 	for (node = (irq_node_t *)dev_id; node; node = node->next)
 		node->handler(irq, node->dev_id, fp);
+	return IRQ_HANDLED;
 }
 
 
@@ -419,7 +420,7 @@
  *                     If the addition was successful, it returns 0.
  */
 
-int atari_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+int atari_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
                       unsigned long flags, const char *devname, void *dev_id)
 {
 	int vector;
--- linux-2.5.69/arch/m68k/atari/config.c	Thu Jan  2 12:53:55 2003
+++ linux-m68k-2.5.69/arch/m68k/atari/config.c	Tue May  6 13:50:49 2003
@@ -60,7 +60,7 @@
 
 /* atari specific irq functions */
 extern void atari_init_IRQ (void);
-extern int atari_request_irq (unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+extern int atari_request_irq (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
                               unsigned long flags, const char *devname, void *dev_id);
 extern void atari_free_irq (unsigned int irq, void *dev_id);
 extern void atari_enable_irq (unsigned int);
@@ -72,7 +72,7 @@
 #endif
 
 /* atari specific timer functions (in time.c) */
-extern void atari_sched_init(void (*)(int, void *, struct pt_regs *));
+extern void atari_sched_init(irqreturn_t (*)(int, void *, struct pt_regs *));
 extern unsigned long atari_gettimeoffset (void);
 extern int atari_mste_hwclk (int, struct rtc_time *);
 extern int atari_tt_hwclk (int, struct rtc_time *);
--- linux-2.5.69/arch/m68k/atari/stdma.c	Thu Jan  2 12:53:55 2003
+++ linux-m68k-2.5.69/arch/m68k/atari/stdma.c	Fri May  9 10:21:30 2003
@@ -43,8 +43,8 @@
 
 static int stdma_locked = 0;			/* the semaphore */
 						/* int func to be called */
-static void (*stdma_isr)(int, void *, struct pt_regs *) = NULL;
-static void	*stdma_isr_data = NULL;		/* data passed to isr */
+static irqreturn_t (*stdma_isr)(int, void *, struct pt_regs *) = NULL;
+static void *stdma_isr_data = NULL;		/* data passed to isr */
 static DECLARE_WAIT_QUEUE_HEAD(stdma_wait);	/* wait queue for ST-DMA */
 
 
@@ -52,7 +52,7 @@
 
 /***************************** Prototypes *****************************/
 
-static void stdma_int (int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t stdma_int (int irq, void *dummy, struct pt_regs *fp);
 
 /************************* End of Prototypes **************************/
 
@@ -74,7 +74,8 @@
  *
  */
 
-void stdma_lock(void (*handler)(int, void *, struct pt_regs *), void *data)
+void stdma_lock(irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		void *data)
 {
 	unsigned long flags;
 
@@ -187,8 +188,9 @@
  *
  */
 
-static void stdma_int(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t stdma_int(int irq, void *dummy, struct pt_regs *fp)
 {
   if (stdma_isr)
       (*stdma_isr)(irq, stdma_isr_data, fp);
+  return IRQ_HANDLED;
 }
--- linux-2.5.69/arch/m68k/atari/time.c	Thu Jan  2 12:53:56 2003
+++ linux-m68k-2.5.69/arch/m68k/atari/time.c	Tue May  6 13:50:49 2003
@@ -20,7 +20,7 @@
 #include <asm/rtc.h>
 
 void __init
-atari_sched_init(void (*timer_routine)(int, void *, struct pt_regs *))
+atari_sched_init(irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
     /* set Timer C data Register */
     mfp.tim_dt_c = INT_TICKS;
--- linux-2.5.69/include/asm-m68k/atari_stdma.h	Wed Sep 25 09:47:41 1996
+++ linux-m68k-2.5.69/include/asm-m68k/atari_stdma.h	Fri May  9 10:21:35 2003
@@ -8,7 +8,8 @@
 
 /***************************** Prototypes *****************************/
 
-void stdma_lock(void (*handler)(int, void *, struct pt_regs *), void *data); 
+void stdma_lock(irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		void *data);
 void stdma_release( void );
 int stdma_others_waiting( void );
 int stdma_islocked( void );
--- linux-2.5.69/include/asm-m68k/ide.h	Sun May 11 12:15:01 2003
+++ linux-m68k-2.5.69/include/asm-m68k/ide.h	Fri May  9 10:21:35 2003
@@ -155,7 +155,8 @@
 	}
 }
 
-static __inline__ void ide_get_lock(void (*handler)(int, void *, struct pt_regs *), void *data)
+static __inline__ void
+ide_get_lock(irqreturn_t (*handler)(int, void *, struct pt_regs *), void *data)
 {
 	if (MACH_IS_ATARI) {
 		if (falconide_intr_lock == 0) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
