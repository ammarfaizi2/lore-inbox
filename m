Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWD0WOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWD0WOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWD0WOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:14:54 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:46286 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751817AbWD0WOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:14:53 -0400
Date: Fri, 28 Apr 2006 00:14:52 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: i386 i8259.c simplify i8259A_irq_real()
Message-ID: <20060427221452.GA29019@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I noticed the very "non-nice" asymmetry of i8259A_irq_real(),
so I decided to fix the weirdly aligned branches.
While doing this, I noticed that it could be streamlined much more,
resulting in an astonishing 208 byte object code saving for such a tiny code
fragment! (gcc 3.2.3)

Review appreciated, I believe it's correct but I've only tested it shortly
and it's slowpath anyway.

Patch against 2.6.17-rc2-mm1.

Thanks!

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.17-rc2-mm1.orig/arch/i386/kernel/i8259.c	2006-04-18 11:45:21.000000000 +0200
+++ linux-2.6.17-rc2-mm1/arch/i386/kernel/i8259.c	2006-04-27 23:57:34.000000000 +0200
@@ -145,17 +145,20 @@
 static inline int i8259A_irq_real(unsigned int irq)
 {
 	int value;
-	int irqmask = 1<<irq;
+	int irqmask;
+	int reg;
 
 	if (irq < 8) {
-		outb(0x0B,PIC_MASTER_CMD);	/* ISR register */
-		value = inb(PIC_MASTER_CMD) & irqmask;
-		outb(0x0A,PIC_MASTER_CMD);	/* back to the IRR register */
-		return value;
+		reg = PIC_MASTER_CMD;
+		irqmask = 1 << irq;
+	} else {
+		reg = PIC_SLAVE_CMD;
+		irqmask = 1 << (irq - 8);
 	}
-	outb(0x0B,PIC_SLAVE_CMD);	/* ISR register */
-	value = inb(PIC_SLAVE_CMD) & (irqmask >> 8);
-	outb(0x0A,PIC_SLAVE_CMD);	/* back to the IRR register */
+
+	outb(0x0B, reg);	/* ISR register */
+	value = inb(reg) & irqmask;
+	outb(0x0A, reg);	/* back to the IRR register */
 	return value;
 }
 
