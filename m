Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbTELJqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTELJqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:46:07 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:28473 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262029AbTELJpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:06 -0400
Date: Mon, 12 May 2003 11:54:37 +0200
Message-Id: <200305120954.h4C9sbxi000991@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [7/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Macintosh: Update to the new irq API (from Roman Zippel and me) [7/20]

--- linux-2.5.69/arch/m68k/mac/baboon.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.5.69/arch/m68k/mac/baboon.c	Tue May  6 13:50:49 2003
@@ -25,7 +25,7 @@
 int baboon_present,baboon_active;
 volatile struct baboon *baboon;
 
-void baboon_irq(int, void *, struct pt_regs *);
+irqreturn_t baboon_irq(int, void *, struct pt_regs *);
 
 #if 0
 extern int macide_ack_intr(struct ata_channel *);
@@ -64,7 +64,7 @@
  * Baboon interrupt handler. This works a lot like a VIA.
  */
 
-void baboon_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t baboon_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int irq_bit,i;
 	unsigned char events;
@@ -75,7 +75,8 @@
 		(uint) baboon->mb_status,  baboon_active);
 #endif
 
-	if (!(events = baboon->mb_ifr & 0x07)) return;
+	if (!(events = baboon->mb_ifr & 0x07))
+		return IRQ_NONE;
 
 	for (i = 0, irq_bit = 1 ; i < 3 ; i++, irq_bit <<= 1) {
 	        if (events & irq_bit/* & baboon_active*/) {
@@ -90,6 +91,7 @@
 	/* for now we need to smash all interrupts */
 	baboon->mb_ifr &= ~events;
 #endif
+	return IRQ_HANDLED;
 }
 
 void baboon_irq_enable(int irq) {
--- linux-2.5.69/arch/m68k/mac/config.c	Thu Jan  2 12:53:57 2003
+++ linux-m68k-2.5.69/arch/m68k/mac/config.c	Tue May  6 13:50:49 2003
@@ -72,7 +72,7 @@
 extern void iop_preinit(void);
 extern void iop_init(void);
 extern void via_init(void);
-extern void via_init_clock(void (*func)(int, void *, struct pt_regs *));
+extern void via_init_clock(irqreturn_t (*func)(int, void *, struct pt_regs *));
 extern void via_flush_cache(void);
 extern void oss_init(void);
 extern void psc_init(void);
@@ -94,7 +94,7 @@
 	mac_reset();
 }
 
-static void mac_sched_init(void (*vector)(int, void *, struct pt_regs *))
+static void mac_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *))
 {
 	via_init_clock(vector);
 }
@@ -106,9 +106,9 @@
 }
 #endif
 
-extern void mac_default_handler(int, void *, struct pt_regs *);
+extern irqreturn_t mac_default_handler(int, void *, struct pt_regs *);
 
-void (*mac_handlers[8])(int, void *, struct pt_regs *)=
+irqreturn_t (*mac_handlers[8])(int, void *, struct pt_regs *)=
 {
 	mac_default_handler,
 	mac_default_handler,
--- linux-2.5.69/arch/m68k/mac/iop.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.5.69/arch/m68k/mac/iop.c	Tue May  6 13:50:49 2003
@@ -153,7 +153,7 @@
 static struct iop_msg *iop_send_queue[NUM_IOPS][NUM_IOP_CHAN];
 static struct listener iop_listeners[NUM_IOPS][NUM_IOP_CHAN];
 
-void iop_ism_irq(int, void *, struct pt_regs *);
+irqreturn_t iop_ism_irq(int, void *, struct pt_regs *);
 
 extern void oss_irq_enable(int);
 
@@ -585,7 +585,7 @@
  * Handle an ISM IOP interrupt
  */
 
-void iop_ism_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t iop_ism_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	uint iop_num = (uint) dev_id;
 	volatile struct mac_iop *iop = iop_base[iop_num];
@@ -636,7 +636,7 @@
 		printk("\n");
 #endif
 	}
-
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_PROC_FS
--- linux-2.5.69/arch/m68k/mac/macints.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.5.69/arch/m68k/mac/macints.c	Tue May  6 13:50:49 2003
@@ -217,10 +217,9 @@
  * console_loglevel determines NMI handler function
  */
 
-extern void mac_bang(int, void *, struct pt_regs *);
-
-void mac_nmi_handler(int, void *, struct pt_regs *);
-void mac_debug_handler(int, void *, struct pt_regs *);
+extern irqreturn_t mac_bang(int, void *, struct pt_regs *);
+irqreturn_t mac_nmi_handler(int, void *, struct pt_regs *);
+irqreturn_t mac_debug_handler(int, void *, struct pt_regs *);
 
 /* #define DEBUG_MACINTS */
 
@@ -499,7 +498,7 @@
  */
  
 int mac_request_irq(unsigned int irq,
-		    void (*handler)(int, void *, struct pt_regs *),
+		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		    unsigned long flags, const char *devname, void *dev_id)
 {
 	irq_node_t *node;
@@ -647,18 +646,19 @@
 
 static int num_debug[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 
-void mac_debug_handler(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t mac_debug_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	if (num_debug[irq] < 10) {
 		printk("DEBUG: Unexpected IRQ %d\n", irq);
 		num_debug[irq]++;
 	}
+	return IRQ_HANDLED;
 }
 
 static int in_nmi = 0;
 static volatile int nmi_hold = 0;
 
-void mac_nmi_handler(int irq, void *dev_id, struct pt_regs *fp)
+irqreturn_t mac_nmi_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	int i;
 	/* 
@@ -703,6 +703,7 @@
 #endif
 	}
 	in_nmi--;
+	return IRQ_HANDLED;
 }
 
 /*
--- linux-2.5.69/arch/m68k/mac/oss.c	Mon Feb 19 10:36:43 2001
+++ linux-m68k-2.5.69/arch/m68k/mac/oss.c	Tue May  6 13:50:50 2003
@@ -30,11 +30,11 @@
 int oss_present;
 volatile struct mac_oss *oss;
 
-void oss_irq(int, void *, struct pt_regs *);
-void oss_nubus_irq(int, void *, struct pt_regs *);
+irqreturn_t oss_irq(int, void *, struct pt_regs *);
+irqreturn_t oss_nubus_irq(int, void *, struct pt_regs *);
 
-extern void via1_irq(int, void *, struct pt_regs *);
-extern void mac_scc_dispatch(int, void *, struct pt_regs *);
+extern irqreturn_t via1_irq(int, void *, struct pt_regs *);
+extern irqreturn_t mac_scc_dispatch(int, void *, struct pt_regs *);
 
 /*
  * Initialize the OSS
@@ -92,12 +92,13 @@
  * and SCSI; everything else is routed to its own autovector IRQ.
  */
  
-void oss_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t oss_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int events;
 
 	events = oss->irq_pending & (OSS_IP_SOUND|OSS_IP_SCSI);
-	if (!events) return;
+	if (!events)
+		return IRQ_NONE;
 
 #ifdef DEBUG_IRQS	
 	if ((console_loglevel == 10) && !(events & OSS_IP_SCSI)) {
@@ -118,6 +119,7 @@
 	} else {
 		/* FIXME: error check here? */
 	}
+	return IRQ_HANDLED;
 }
 
 /*
@@ -126,12 +128,13 @@
  * Unlike the VIA/RBV this is on its own autovector interrupt level.
  */
 
-void oss_nubus_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t oss_nubus_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int events, irq_bit, i;
 
 	events = oss->irq_pending & OSS_IP_NUBUS;
-	if (!events) return;
+	if (!events)
+		return IRQ_NONE;
 
 #ifdef DEBUG_NUBUS_INT
 	if (console_loglevel > 7) {
@@ -148,6 +151,7 @@
 			oss->irq_level[i] = OSS_IRQLEV_NUBUS;
 		}
 	}
+	return IRQ_HANDLED;
 }
 
 /*
--- linux-2.5.69/arch/m68k/mac/psc.c	Wed Jun  6 13:54:18 2001
+++ linux-m68k-2.5.69/arch/m68k/mac/psc.c	Tue May  6 13:50:50 2003
@@ -30,7 +30,7 @@
 int psc_present;
 volatile __u8 *psc;
 
-void psc_irq(int, void *, struct pt_regs *);
+irqreturn_t psc_irq(int, void *, struct pt_regs *);
 
 /*
  * Debugging dump, used in various places to see what's going on.
@@ -131,7 +131,7 @@
  * PSC interrupt handler. It's a lot like the VIA interrupt handler.
  */
 
-void psc_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t psc_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int pIFR	= pIFRbase + ((int) dev_id);
 	int pIER	= pIERbase + ((int) dev_id);
@@ -147,7 +147,8 @@
 #endif
 
 	events = psc_read_byte(pIFR) & psc_read_byte(pIER) & 0xF;
-	if (!events) return;
+	if (!events)
+		return IRQ_NONE;
 
 	for (i = 0, irq_bit = 1 ; i < 4 ; i++, irq_bit <<= 1) {
 	        if (events & irq_bit) {
@@ -157,6 +158,7 @@
 			psc_write_byte(pIER, irq_bit | 0x80);
 		}
 	}
+	return IRQ_HANDLED;
 }
 
 void psc_irq_enable(int irq) {
--- linux-2.5.69/arch/m68k/mac/via.c	Mon Feb 10 21:58:38 2003
+++ linux-m68k-2.5.69/arch/m68k/mac/via.c	Tue May  6 13:50:50 2003
@@ -65,15 +65,15 @@
 static int  nubus_active = 0;
 
 void via_debug_dump(void);
-void via1_irq(int, void *, struct pt_regs *);
-void via2_irq(int, void *, struct pt_regs *);
-void via_nubus_irq(int, void *, struct pt_regs *);
+irqreturn_t via1_irq(int, void *, struct pt_regs *);
+irqreturn_t via2_irq(int, void *, struct pt_regs *);
+irqreturn_t via_nubus_irq(int, void *, struct pt_regs *);
 void via_irq_enable(int irq);
 void via_irq_disable(int irq);
 void via_irq_clear(int irq);
 
-extern void mac_bang(int, void *, struct pt_regs *);
-extern void mac_scc_dispatch(int, void *, struct pt_regs *);
+extern irqreturn_t mac_bang(int, void *, struct pt_regs *);
+extern irqreturn_t mac_scc_dispatch(int, void *, struct pt_regs *);
 extern int oss_present;
 
 /*
@@ -243,7 +243,7 @@
  * Start the 100 Hz clock
  */
 
-void __init via_init_clock(void (*func)(int, void *, struct pt_regs *))
+void __init via_init_clock(irqreturn_t (*func)(int, void *, struct pt_regs *))
 {	
 	via1[vACR] |= 0x40;
 	via1[vT1LL] = MAC_CLOCK_LOW;
@@ -423,13 +423,14 @@
  * the machspec interrupt number after clearing the interrupt.
  */
 
-void via1_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t via1_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int irq_bit, i;
 	unsigned char events, mask;
 
 	mask = via1[vIER] & 0x7F;
-	if (!(events = via1[vIFR] & mask)) return;
+	if (!(events = via1[vIFR] & mask))
+		return IRQ_NONE;
 
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1)
 		if (events & irq_bit) {
@@ -453,15 +454,17 @@
 		via_irq_enable(IRQ_MAC_NUBUS);
 	}
 #endif
+	return IRQ_HANDLED;
 }
 
-void via2_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t via2_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int irq_bit, i;
 	unsigned char events, mask;
 
 	mask = via2[gIER] & 0x7F;
-	if (!(events = via2[gIFR] & mask)) return;
+	if (!(events = via2[gIFR] & mask))
+		return IRQ_NONE;
 
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1)
 		if (events & irq_bit) {
@@ -470,6 +473,7 @@
 			via2[gIFR] = irq_bit | rbv_clear;
 			via2[gIER] = irq_bit | 0x80;
 		}
+	return IRQ_HANDLED;
 }
 
 /*
@@ -477,12 +481,13 @@
  * VIA2 dispatcher as a fast interrupt handler.
  */
 
-void via_nubus_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t via_nubus_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int irq_bit, i;
 	unsigned char events;
 
-	if (!(events = ~via2[gBufA] & nubus_active)) return;
+	if (!(events = ~via2[gBufA] & nubus_active))
+		return IRQ_NONE;
 
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1) {
 		if (events & irq_bit) {
@@ -491,6 +496,7 @@
 			via_irq_enable(NUBUS_SOURCE_BASE + i);
 		}
 	}
+	return IRQ_HANDLED;
 }
 
 void via_irq_enable(int irq) {
--- linux-2.5.69/include/asm-m68k/macintosh.h	Thu Jan  2 12:55:07 2003
+++ linux-m68k-2.5.69/include/asm-m68k/macintosh.h	Tue May  6 13:50:50 2003
@@ -2,6 +2,7 @@
 #define __ASM_MACINTOSH_H
 
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 /*
  *	Apple Macintoshisms
@@ -10,7 +11,7 @@
 extern void mac_reset(void);
 extern void mac_poweroff(void);
 extern void mac_init_IRQ(void);
-extern int mac_request_irq (unsigned int, void (*)(int, void *, 
+extern int mac_request_irq (unsigned int, irqreturn_t (*)(int, void *, 
 				struct pt_regs *),
 				unsigned long, const char *, void *);
 extern void mac_free_irq(unsigned int, void *);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
