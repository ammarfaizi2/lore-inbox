Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTELJqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTELJpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:21 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:61781 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262021AbTELJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:03 -0400
Date: Mon, 12 May 2003 11:54:34 +0200
Message-Id: <200305120954.h4C9sYEm000967@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [3/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Apollo: Update to the new irq API (from Roman Zippel and me) [3/20]

--- linux-2.5.69/arch/m68k/apollo/config.c	Tue Mar 25 10:06:07 2003
+++ linux-m68k-2.5.69/arch/m68k/apollo/config.c	Fri May  9 10:21:29 2003
@@ -26,9 +26,9 @@
 u_long timer_physaddr;
 u_long apollo_model;
 
-extern void dn_sched_init(void (*handler)(int,void *,struct pt_regs *));
+extern void dn_sched_init(irqreturn_t (*handler)(int,void *,struct pt_regs *));
 extern void dn_init_IRQ(void);
-extern int dn_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
+extern int dn_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void dn_free_irq(unsigned int irq, void *dev_id);
 extern void dn_enable_irq(unsigned int);
 extern void dn_disable_irq(unsigned int);
@@ -41,12 +41,12 @@
 extern struct fb_info *dn_fb_init(long *);
 extern void dn_dummy_debug_init(void);
 extern void dn_dummy_video_setup(char *,int *);
-extern void dn_process_int(int irq, struct pt_regs *fp);
+extern irqreturn_t dn_process_int(int irq, struct pt_regs *fp);
 #ifdef CONFIG_HEARTBEAT
 static void dn_heartbeat(int on);
 #endif
-static void dn_timer_int(int irq,void *, struct pt_regs *);
-static void (*sched_timer_handler)(int, void *, struct pt_regs *)=NULL;
+static irqreturn_t dn_timer_int(int irq,void *, struct pt_regs *);
+static irqreturn_t (*sched_timer_handler)(int, void *, struct pt_regs *)=NULL;
 static void dn_get_model(char *model);
 static const char *apollo_models[] = {
 	"DN3000 (Otter)",
@@ -195,7 +195,7 @@
 
 }		
 
-void dn_timer_int(int irq, void *dev_id, struct pt_regs *fp) {
+irqreturn_t dn_timer_int(int irq, void *dev_id, struct pt_regs *fp) {
 
 	volatile unsigned char x;
 
@@ -204,9 +204,10 @@
 	x=*(volatile unsigned char *)(timer+3);
 	x=*(volatile unsigned char *)(timer+5);
 
+	return IRQ_HANDLED;
 }
 
-void dn_sched_init(void (*timer_routine)(int, void *, struct pt_regs *)) {
+void dn_sched_init(irqreturn_t (*timer_routine)(int, void *, struct pt_regs *)) {
 
 	/* program timer 1 */       	
 	*(volatile unsigned char *)(timer+3)=0x01;
--- linux-2.5.69/arch/m68k/apollo/dn_ints.c	Tue Nov  5 10:09:40 2002
+++ linux-m68k-2.5.69/arch/m68k/apollo/dn_ints.c	Fri May  9 10:21:29 2003
@@ -14,19 +14,20 @@
 
 static irq_handler_t dn_irqs[16];
 
-void dn_process_int(int irq, struct pt_regs *fp) {
-
+irqreturn_t dn_process_int(int irq, struct pt_regs *fp)
+{
+  irqreturn_t res = IRQ_NONE;
 
   if(dn_irqs[irq-160].handler) {
-    dn_irqs[irq-160].handler(irq,dn_irqs[irq-160].dev_id,fp);
-  }
-  else {
+    res = dn_irqs[irq-160].handler(irq,dn_irqs[irq-160].dev_id,fp);
+  } else {
     printk("spurious irq %d occurred\n",irq);
   }
 
   *(volatile unsigned char *)(pica)=0x20;
   *(volatile unsigned char *)(picb)=0x20;
 
+  return res;
 }
 
 void dn_init_IRQ(void) {
@@ -42,7 +43,7 @@
   
 }
 
-int dn_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id) {
+int dn_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id) {
 
   if((irq<0) || (irq>15)) {
     printk("Trying to request illegal IRQ\n");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
