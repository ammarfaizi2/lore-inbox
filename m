Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272504AbTGZOlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272506AbTGZOe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:57 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:16690 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S272507AbTGZOcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:35 -0400
Date: Sat, 26 Jul 2003 16:51:43 +0200
Message-Id: <200307261451.h6QEphkx002340@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: A few missing updates to the new irq API:
  - Q40/Q60 keyboard
  - Q40/Q60 floppy
  - Sun-3x floppy

--- linux-2.6.x/drivers/input/serio/q40kbd.c	Sun Feb 16 12:16:24 2003
+++ linux-m68k-2.6.x/drivers/input/serio/q40kbd.c	Sun Jun  8 13:30:46 2003
@@ -66,12 +66,14 @@
 	.close	= q40kbd_close,
 };
 
-static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t q40kbd_interrupt(int irq, void *dev_id,
+				    struct pt_regs *regs)
 {
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
 		serio_interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0, regs);
 
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
+	return IRQ_HANDLED;
 }
 
 static int __init q40kbd_init(void)
--- linux-2.6.x/include/asm-m68k/floppy.h	Sun Jun  8 10:15:21 2003
+++ linux-m68k-2.6.x/include/asm-m68k/floppy.h	Sun Jun  8 13:28:44 2003
@@ -17,7 +17,8 @@
 
 #include <linux/vmalloc.h>
 
-asmlinkage void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs);
+asmlinkage irqreturn_t floppy_hardint(int irq, void *dev_id,
+				      struct pt_regs *regs);
 
 /* constants... */
 
@@ -183,7 +184,8 @@
 
 /* this is the only truly Q40 specific function */
 
-asmlinkage void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
+asmlinkage irqreturn_t floppy_hardint(int irq, void *dev_id,
+				      struct pt_regs *regs)
 {
 	register unsigned char st;
 
@@ -197,7 +199,7 @@
 #endif
 	if(!doing_pdma) {
 		floppy_interrupt(irq, dev_id, regs);
-		return;
+		return IRQ_HANDLED;
 	}
 
 #ifdef TRACE_FLPY_INT
@@ -232,7 +234,7 @@
 	calls++;
 #endif
 	if(st == 0x20)
-		return;
+		return IRQ_HANDLED;
 	if(!(st & 0x20)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
@@ -245,12 +247,13 @@
 #endif
 		doing_pdma = 0;
 		floppy_interrupt(irq, dev_id, regs);
-		return;
+		return IRQ_HANDLED;
 	}
 #ifdef TRACE_FLPY_INT
 	if(!virtual_dma_count)
 		dma_wait++;
 #endif
+	return IRQ_HANDLED;
 }
 
 #define EXTRA_FLOPPY_PARAMS
--- linux-2.6.x/include/asm-m68k/sun3xflop.h	Sun Apr  7 10:56:27 2002
+++ linux-m68k-2.6.x/include/asm-m68k/sun3xflop.h	Sun Jun  8 13:27:25 2003
@@ -113,7 +113,8 @@
 }
 
 
-asmlinkage void sun3xflop_hardint(int irq, void *dev_id, struct pt_regs * regs)
+asmlinkage irqreturn_t sun3xflop_hardint(int irq, void *dev_id,
+					 struct pt_regs * regs)
 {
 	register unsigned char st;
 
@@ -127,7 +128,7 @@
 #endif
 	if(!doing_pdma) {
 		floppy_interrupt(irq, dev_id, regs);
-		return;
+		return IRQ_HANDLED;
 	}
 
 //	printk("doing pdma\n");// st %x\n", sun_fdc->status_82072);
@@ -151,7 +152,7 @@
 			if((st & 0x80) == 0) {
 				virtual_dma_count = lcount;
 				virtual_dma_addr = lptr;
-				return;
+				return IRQ_HANDLED;
 			}
 
 			if((st & 0x20) == 0)
@@ -176,7 +177,7 @@
 #endif
 //	printk("st=%02x\n", st);
 	if(st == 0x20)
-		return;
+		return IRQ_HANDLED;
 	if(!(st & 0x20)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
@@ -191,7 +192,7 @@
 #endif
 
 		floppy_interrupt(irq, dev_id, regs);
-		return;
+		return IRQ_HANDLED;
 	}
 
 	
@@ -199,6 +200,7 @@
 	if(!virtual_dma_count)
 		dma_wait++;
 #endif
+	return IRQ_HANDLED;
 }
 
 static int sun3xflop_request_irq(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
