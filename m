Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSIITAN>; Mon, 9 Sep 2002 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318911AbSIITAN>; Mon, 9 Sep 2002 15:00:13 -0400
Received: from [209.173.6.49] ([209.173.6.49]:36996 "EHLO comet.linuxguru.net")
	by vger.kernel.org with ESMTP id <S318899AbSIITAH>;
	Mon, 9 Sep 2002 15:00:07 -0400
Date: Mon, 9 Sep 2002 08:04:52 -0400
To: linux-kernel@vger.kernel.org
Cc: jonathan@buzzard.org.uk
Subject: [Patch] 2.5.34 IRQ Patch
Message-ID: <20020909120451.GA23868@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: James Blackwell <jblack@linuxguru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere around 2.5.31 the method for setting and clearing interrupts
changed:

From-                     To-
save_flags(flags);        local_irq_save(flags);
cli();

restore_flags(flags);     local_irq_restore(flags);


Though bordering on trivial, including toshiba support with stock 2.5.34
fails to compile, which this patch seems to fix. This patch fixes this
issue and has worked reliably for me under 2.5.31, though it is untested on
2.5.32 and 2.5.33 because I didn't manage to get those to work. 

A note to those that are a bit rough on kernel patch newbies.... submitting 
a kernel patch for the very first time is a rather intimidating experience
so please don't chew my head off unless its absolutely necessary. 

See my point? I was so worried that Cristoph Hellwig is going to come to
my house and eat me I forgot to include the patch itself. :)



diff -ur linux-2.5.34/drivers/char/toshiba.c linux-2.5.34.new/drivers/char/toshiba.c
--- linux-2.5.34/drivers/char/toshiba.c	2002-09-09 13:35:16.000000000 -0400
+++ linux-2.5.34.new/drivers/char/toshiba.c	2002-09-09 07:46:23.000000000 -0400
@@ -114,11 +114,10 @@
 	if (tosh_fn!=0) {
 		scan = inb(tosh_fn);
 	} else {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		outb(0x8e, 0xe4);
 		scan = inb(0xe5);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
         return (int) scan;
@@ -141,35 +140,32 @@
 	if (tosh_id==0xfccb) {
 		if (eax==0xfe00) {
 			/* fan status */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xbe, 0xe4);
 			al = inb(0xe5);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = (unsigned int) (al & 0x01);
 		}
 		if ((eax==0xff00) && (ecx==0x0000)) {
 			/* fan off */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xbe, 0xe4);
 			al = inb(0xe5);
 			outb(0xbe, 0xe4);
 			outb (al | 0x01, 0xe5);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = 0x00;
 		}
 		if ((eax==0xff00) && (ecx==0x0001)) {
 			/* fan on */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xbe, 0xe4);
 			al = inb(0xe5);
 			outb(0xbe, 0xe4);
 			outb(al & 0xfe, 0xe5);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = 0x01;
 		}
@@ -180,33 +176,30 @@
 	if (tosh_id==0xfccc) {
 		if (eax==0xfe00) {
 			/* fan status */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xe0, 0xe4);
 			al = inb(0xe5);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = al & 0x01;
 		}
 		if ((eax==0xff00) && (ecx==0x0000)) {
 			/* fan off */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xe0, 0xe4);
 			al = inb(0xe5);
 			outw(0xe0 | ((al & 0xfe) << 8), 0xe4);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = 0x00;
 		}
 		if ((eax==0xff00) && (ecx==0x0001)) {
 			/* fan on */
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			outb(0xe0, 0xe4);
 			al = inb(0xe5);
 			outw(0xe0 | ((al | 0x01) << 8), 0xe4);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			regs->eax = 0x00;
 			regs->ecx = 0x01;
 		}

-- 
GnuPG fingerprint AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400
James Blackwell  --  Director http://www.linuxguru.net
