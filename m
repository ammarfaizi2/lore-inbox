Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbRE0X04>; Sun, 27 May 2001 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbRE0X0q>; Sun, 27 May 2001 19:26:46 -0400
Received: from are.twiddle.net ([64.81.246.98]:16264 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262866AbRE0X0b>;
	Sun, 27 May 2001 19:26:31 -0400
Date: Sun, 27 May 2001 16:26:29 -0700
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com, torvalds@transmeta.com, geoffk@geoffk.org
Subject: 2.4.5 alpha rawhide interrupt fix
Message-ID: <20010527162629.A18891@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com,
	torvalds@transmeta.com, geoffk@geoffk.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PALcode will ack the interrupt in the normal interrupt return path,
but 2.4 re-enables interrupts before that.  This means we re-enable
interrupts without the hardware being acked, which results in nasty
interrupt storms.

Fixed thus.


r~


--- linux/arch/alpha/kernel/sys_rawhide.c.orig	Sun May 27 15:51:03 2001
+++ linux/arch/alpha/kernel/sys_rawhide.c	Sun May 27 15:57:42 2001
@@ -59,10 +59,11 @@ rawhide_enable_irq(unsigned int irq)
 	irq -= 16;
 	hose = irq / 24;
 	irq -= hose * 24;
+	mask = 1 << irq;
 
 	spin_lock(&rawhide_irq_lock);
-	mask = cached_irq_masks[hose] |= 1 << irq;
-	mask |= hose_irq_masks[hose];
+	mask |= cached_irq_masks[hose];
+	cached_irq_masks[hose] = mask;
 	rawhide_update_irq_hw(hose, mask);
 	spin_unlock(&rawhide_irq_lock);
 }
@@ -75,14 +76,37 @@ rawhide_disable_irq(unsigned int irq)
 	irq -= 16;
 	hose = irq / 24;
 	irq -= hose * 24;
+	mask = ~(1 << irq) | hose_irq_masks[hose];
 
 	spin_lock(&rawhide_irq_lock);
-	mask = cached_irq_masks[hose] &= ~(1 << irq);
-	mask |= hose_irq_masks[hose];
+	mask &= cached_irq_masks[hose];
+	cached_irq_masks[hose] = mask;
 	rawhide_update_irq_hw(hose, mask);
 	spin_unlock(&rawhide_irq_lock);
 }
 
+static void
+rawhide_mask_and_ack_irq(unsigned int irq)
+{
+	unsigned int mask, mask1, hose;
+
+	irq -= 16;
+	hose = irq / 24;
+	irq -= hose * 24;
+	mask1 = 1 << irq;
+	mask = ~mask1 | hose_irq_masks[hose];
+
+	spin_lock(&rawhide_irq_lock);
+
+	mask &= cached_irq_masks[hose];
+	cached_irq_masks[hose] = mask;
+	rawhide_update_irq_hw(hose, mask);
+
+	/* Clear the interrupt.  */
+	*(vuip)MCPCIA_INT_REQ(MCPCIA_HOSE2MID(hose)) = mask1;
+
+	spin_unlock(&rawhide_irq_lock);
+}
 
 static unsigned int
 rawhide_startup_irq(unsigned int irq)
@@ -104,7 +128,7 @@ static struct hw_interrupt_type rawhide_
 	shutdown:	rawhide_disable_irq,
 	enable:		rawhide_enable_irq,
 	disable:	rawhide_disable_irq,
-	ack:		rawhide_disable_irq,
+	ack:		rawhide_mask_and_ack_irq,
 	end:		rawhide_end_irq,
 };
 
@@ -145,8 +169,12 @@ rawhide_init_irq(void)
 	mcpcia_init_hoses();
 
 	for (hose = hose_head; hose; hose = hose->next) {
-		int h = hose->index;
-		rawhide_update_irq_hw(h, hose_irq_masks[h]);
+		unsigned int h = hose->index;
+		unsigned int mask = hose_irq_masks[h];
+
+		cached_irq_masks[h] = mask;
+		*(vuip)MCPCIA_INT_MASK0(MCPCIA_HOSE2MID(h)) = mask;
+		*(vuip)MCPCIA_INT_MASK1(MCPCIA_HOSE2MID(h)) = 0;
 	}
 
 	for (i = 16; i < 128; ++i) {
