Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIZMPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTIZMNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:13:55 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:6163 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262066AbTIZMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:13:46 -0400
Date: Fri, 26 Sep 2003 14:14:09 +0200
Message-Id: <200309261214.h8QCE9Uq005018@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 118] Q40/Q60 interrupts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40/Q60 updates (from Richard Zidlicky):
  - Must handle keyboard interrupts even before they are registered
  - Kill some warnings

--- linux-2.4.23-pre5/arch/m68k/q40/q40ints.c	Tue Aug 26 12:22:41 2003
+++ linux-m68k-2.4.23-pre5/arch/m68k/q40/q40ints.c	Mon Sep  1 13:33:21 2003
@@ -124,7 +124,6 @@
 	  case 11: 	      
 	    printk("warning IRQ 10 and 11 not distinguishable\n");
 	    irq=10;
-	  default:
 	  }
 
 	if (irq<Q40_IRQ_SAMPLE)
@@ -171,7 +170,6 @@
 	    printk("%s: ISA IRQ %d from %x invalid\n", __FUNCTION__, irq, (unsigned)dev_id);
 	    return;
 	  case 11: irq=10;
-	  default:
 	  }
 	
 	if (irq<Q40_IRQ_SAMPLE)
@@ -196,7 +194,9 @@
 
 void q40_process_int (int level, struct pt_regs *fp)
 {
-  printk("unexpected interrupt %x\n",level);
+  printk("unexpected interrupt vec=%x, pc=%lx, d0=%lx, d0_orig=%lx, d1=%lx, d2=%lx\n",
+          level, fp->pc, fp->d0, fp->orig_d0, fp->d1, fp->d2);
+  printk("\tIIRQ_REG = %x, EIRQ_REG = %x\n",master_inb(IIRQ_REG),master_inb(EIRQ_REG));
 }
 
 /* 
@@ -313,7 +313,6 @@
   unsigned mir, mer;
   int irq,i;
 
- repeat:
   mir=master_inb(IIRQ_REG);
   if (mir&Q40_IRQ_FRAME_MASK) {
 	  irq_tab[Q40_IRQ_FRAME].count++;
@@ -373,7 +372,6 @@
 				  /*printk("reenabling irq %d\n",irq); */
 #endif
 			  }
-// used to do 'goto repeat;' her, this delayed bh processing too long
 			  return;
 		  }
 	  }
@@ -382,6 +380,7 @@
   } 
  iirq:
   mir=master_inb(IIRQ_REG);
+  /* should test whether keyboard irq is really enabled, doing it in defhand */
   if (mir&Q40_IRQ_KEYB_MASK) {
 	  irq_tab[Q40_IRQ_KEYBOARD].count++;
 	  irq_tab[Q40_IRQ_KEYBOARD].handler(Q40_IRQ_KEYBOARD,irq_tab[Q40_IRQ_KEYBOARD].dev_id,fp);
@@ -408,7 +407,9 @@
 
 static void q40_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
-	printk ("Unknown q40 interrupt 0x%02x\n", irq);
+        if (irq!=Q40_IRQ_KEYBOARD)
+	     printk ("Unknown q40 interrupt %d\n", irq);
+	else master_outb(-1,KEYBOARD_UNLOCK_REG);
 }
 static void sys_default_handler(int lev, void *dev_id, struct pt_regs *regs)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
