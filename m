Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWF2U37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWF2U37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWF2U37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:29:59 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:14789 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932419AbWF2U36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:29:58 -0400
Date: Thu, 29 Jun 2006 22:29:57 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: mingo@redhat.com
Subject: i8259.c dummy I/O operation?
Message-ID: <20060629202956.GA2718@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just wanted to direct attention to further somewhat wasteful aspects
in kernel code ;)

Since this extra inb() is in IRQ handler hotpath (called at least a
couple hundred times per second without dynticks patch),
it hurts quite obviously, potentially with several hundred CPU cycles
per I/O due to slow PIC access (haven't actually profiled it, though).

This dummy op can be found in i8259.c of i386/, x86_64/ and mips/.

There seem to be no adverse effects on three systems that I tested it on:
- P4 HT
- P3/700
- Athlon on VIA chipset

Comments?
Further testing on various chipsets by more people would also be useful,
I think...
(however testing might be dangerous, of course, since it's a quite invasive
change and might even corrupt data or so!)

Thanks,

Andreas Mohr

P.S.: the outb() change is just a minor comment correction...


diff -urN linux-2.6.17-mm4.orig/arch/i386/kernel/i8259.c linux-2.6.17-mm4.my/arch/i386/kernel/i8259.c
--- linux-2.6.17-mm4.orig/arch/i386/kernel/i8259.c	2006-06-29 11:57:11.000000000 +0200
+++ linux-2.6.17-mm4.my/arch/i386/kernel/i8259.c	2006-06-29 21:17:33.000000000 +0200
@@ -191,13 +191,13 @@
 	cached_irq_mask |= irqmask;
 
 handle_real_irq:
+	/* we used to first do a dummy inb() on PIC_SLAVE_IMR/PIC_MASTER_IMR
+	   here, but this doesn't seem to actually be necessary... */
 	if (irq & 8) {
-		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
 		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
 	} else {
-		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
@@ -272,7 +272,7 @@
 	 * out of.
 	 */
 	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
-	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
 	return 0;
 }
 
