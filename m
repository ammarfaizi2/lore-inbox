Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTI1NMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbTI1NKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:10:33 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:5215 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262540AbTI1NIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:08:45 -0400
Date: Sun, 28 Sep 2003 14:55:18 +0200
Message-Id: <200309281255.h8SCtIX6005474@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 299] Q40/Q60 interrupts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40/Q60: Must handle keyboard interrupts even before they are registered (from
Richard Zidlicky)

--- linux-2.6.0-test6/arch/m68k/q40/q40ints.c	Tue Jul 29 18:18:35 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/q40/q40ints.c	Mon Sep  1 13:50:04 2003
@@ -378,7 +378,7 @@
 				  /*printk("reenabling irq %d\n",irq); */
 #endif
 			  }
-// used to do 'goto repeat;' her, this delayed bh processing too long
+// used to do 'goto repeat;' here, this delayed bh processing too long
 			  return IRQ_HANDLED;
 		  }
 	  }
@@ -387,6 +387,7 @@
   } 
  iirq:
   mir=master_inb(IIRQ_REG);
+  /* should test whether keyboard irq is really enabled, doing it in defhand */
   if (mir&Q40_IRQ_KEYB_MASK) {
 	  irq_tab[Q40_IRQ_KEYBOARD].count++;
 	  irq_tab[Q40_IRQ_KEYBOARD].handler(Q40_IRQ_KEYBOARD,irq_tab[Q40_IRQ_KEYBOARD].dev_id,fp);
@@ -413,7 +414,9 @@
 
 static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp)
 {
-	printk ("Unknown q40 interrupt 0x%02x\n", irq);
+        if (irq!=Q40_IRQ_KEYBOARD)
+	     printk ("Unknown q40 interrupt %d\n", irq);
+	else master_outb(-1,KEYBOARD_UNLOCK_REG);
 	return IRQ_NONE;
 }
 static irqreturn_t sys_default_handler(int lev, void *dev_id, struct pt_regs *regs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
