Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTELJpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTELJpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:45:14 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:7250 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262019AbTELJpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:02 -0400
Date: Mon, 12 May 2003 11:54:33 +0200
Message-Id: <200305120954.h4C9sXIw000961@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [2/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Amiga: Update to the new irq API (from Roman Zippel and me) [2/20]

--- linux-2.5.69/arch/m68k/amiga/amiints.c	Tue Nov  5 10:09:40 2002
+++ linux-m68k-2.5.69/arch/m68k/amiga/amiints.c	Tue May  6 13:50:49 2003
@@ -51,7 +51,7 @@
 #include <asm/amipcmcia.h>
 
 extern int cia_request_irq(struct ciabase *base,int irq,
-                           void (*handler)(int, void *, struct pt_regs *),
+                           irqreturn_t (*handler)(int, void *, struct pt_regs *),
                            unsigned long flags, const char *devname, void *dev_id);
 extern void cia_free_irq(struct ciabase *base, unsigned int irq, void *dev_id);
 extern void cia_init_IRQ(struct ciabase *base);
@@ -70,9 +70,10 @@
 
 static short ami_ablecount[AMI_IRQS];
 
-static void ami_badint(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_badint(int irq, void *dev_id, struct pt_regs *fp)
 {
 	num_spurious += 1;
+	return IRQ_NONE;
 }
 
 /*
@@ -183,7 +184,7 @@
  */
 
 int amiga_request_irq(unsigned int irq,
-		      void (*handler)(int, void *, struct pt_regs *),
+		      irqreturn_t (*handler)(int, void *, struct pt_regs *),
                       unsigned long flags, const char *devname, void *dev_id)
 {
 	irq_node_t *node;
@@ -368,7 +369,7 @@
  * The builtin Amiga hardware interrupt handlers.
  */
 
-static void ami_int1(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int1(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -389,9 +390,10 @@
 		custom.intreq = IF_SOFT;
 		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
 	}
+	return IRQ_HANDLED;
 }
 
-static void ami_int3(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int3(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -410,9 +412,10 @@
 	/* if a vertical blank interrupt */
 	if (ints & IF_VERTB)
 		amiga_do_irq_list(IRQ_AMIGA_VERTB, fp);
+	return IRQ_HANDLED;
 }
 
-static void ami_int4(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int4(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -439,9 +442,10 @@
 		custom.intreq = IF_AUD3;
 		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
 	}
+	return IRQ_HANDLED;
 }
 
-static void ami_int5(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -456,14 +460,15 @@
 		custom.intreq = IF_DSKSYN;
 		amiga_do_irq(IRQ_AMIGA_DSKSYN, fp);
 	}
+	return IRQ_HANDLED;
 }
 
-static void ami_int7(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int7(int irq, void *dev_id, struct pt_regs *fp)
 {
 	panic ("level 7 interrupt received\n");
 }
 
-void (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
+irqreturn_t (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
 	ami_badint, ami_int1, ami_badint, ami_int3,
 	ami_int4, ami_int5, ami_badint, ami_int7
 };
--- linux-2.5.69/arch/m68k/amiga/cia.c	Thu Jan  2 12:53:54 2003
+++ linux-m68k-2.5.69/arch/m68k/amiga/cia.c	Tue May  6 13:50:49 2003
@@ -90,7 +90,7 @@
 }
 
 int cia_request_irq(struct ciabase *base, unsigned int irq,
-                    void (*handler)(int, void *, struct pt_regs *),
+                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
                     unsigned long flags, const char *devname, void *dev_id)
 {
 	unsigned char mask;
@@ -120,7 +120,7 @@
 	cia_able_irq(base, 1 << irq);
 }
 
-static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
 	int mach_irq, i;
@@ -138,6 +138,7 @@
 		ints >>= 1;
 	}
 	amiga_do_irq_list(base->server_irq, fp);
+	return IRQ_HANDLED;
 }
 
 void __init cia_init_IRQ(struct ciabase *base)
--- linux-2.5.69/arch/m68k/amiga/config.c	Tue Mar 25 10:06:07 2003
+++ linux-m68k-2.5.69/arch/m68k/amiga/config.c	Tue May  6 13:50:49 2003
@@ -71,12 +71,12 @@
 
 extern char m68k_debug_device[];
 
-static void amiga_sched_init(void (*handler)(int, void *, struct pt_regs *));
+static void amiga_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 /* amiga specific irq functions */
 extern void amiga_init_IRQ (void);
-extern void (*amiga_default_handler[]) (int, void *, struct pt_regs *);
+extern irqreturn_t (*amiga_default_handler[]) (int, void *, struct pt_regs *);
 extern int amiga_request_irq (unsigned int irq,
-			      void (*handler)(int, void *, struct pt_regs *),
+			      irqreturn_t (*handler)(int, void *, struct pt_regs *),
                               unsigned long flags, const char *devname,
 			      void *dev_id);
 extern void amiga_free_irq (unsigned int irq, void *dev_id);
@@ -491,7 +491,7 @@
 
 static unsigned short jiffy_ticks;
 
-static void __init amiga_sched_init(void (*timer_routine)(int, void *,
+static void __init amiga_sched_init(irqreturn_t (*timer_routine)(int, void *,
 							  struct pt_regs *))
 {
 	static struct resource sched_res = {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
