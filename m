Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVDZIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVDZIsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDZIsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:48:13 -0400
Received: from av1.karneval.cz ([81.27.192.107]:44351 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S261397AbVDZIsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:48:06 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Linux 2.6.x VM86 interrupt emulation fixes - the second round
Date: Tue, 26 Apr 2005 10:49:03 +0200
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       Michal Sojka <sojkam1@control.felk.cvut.cz>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> <Pine.LNX.4.58.0412111041440.31040@ppc970.osdl.org> <1102790805.8194.11.camel@localhost.localdomain>
In-Reply-To: <1102790805.8194.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504261049.04139.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch solves VM86 interrupt emulation deadlock on SMP systems.
The VM86 interrupt emulation has been heavily tested and works
well on UP systems after last update, but it seems to deadlock
when we have used it on SMP/HT boxes now.
It seems, that disable_irq() cannot be called from interrupts,
because it waits until disabled interrupt handler finishes
(/kernel/irq/manage.c:synchronize_irq():while(IRQ_INPROGRESS);).
This blocks one CPU after another. Solved by use disable_irq_nosync.
There is the second problem. If IRQ source is fast, it is possible,
that interrupt is sometimes processed and re-enabled by the second
CPU, before it is disabled by the first one, but negative IRQ disable
depths are not allowed. The spinlocking and disabling IRQs over
call to disable_irq_nosync/enable_irq is the only solution found
reliable till now.

Signed-off-by: Michal Sojka <sojkam1@control.felk.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Index: linux-2.6.11.5/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6.11.5.orig/arch/i386/kernel/vm86.c
+++ linux-2.6.11.5/arch/i386/kernel/vm86.c
@@ -732,12 +732,12 @@ static irqreturn_t irq_handler(int intno
 	irqbits |= irq_bit;
 	if (vm86_irqs[intno].sig)
 		send_sig(vm86_irqs[intno].sig, vm86_irqs[intno].tsk, 1);
-	spin_unlock_irqrestore(&irqbits_lock, flags);
 	/*
 	 * IRQ will be re-enabled when user asks for the irq (whether
 	 * polling or as a result of the signal)
 	 */
-	disable_irq(intno);
+	disable_irq_nosync(intno);
+	spin_unlock_irqrestore(&irqbits_lock, flags);
 	return IRQ_HANDLED;
 
 out:
@@ -769,17 +769,20 @@ static inline int get_and_reset_irq(int 
 {
 	int bit;
 	unsigned long flags;
+	int ret = 0;
 	
 	if (invalid_vm86_irq(irqnumber)) return 0;
 	if (vm86_irqs[irqnumber].tsk != current) return 0;
 	spin_lock_irqsave(&irqbits_lock, flags);	
 	bit = irqbits & (1 << irqnumber);
 	irqbits &= ~bit;
+	if (bit) {
+		enable_irq(irqnumber);
+		ret = 1;
+        }
+
 	spin_unlock_irqrestore(&irqbits_lock, flags);	
-	if (!bit)
-		return 0;
-	enable_irq(irqnumber);
-	return 1;
+	return ret;
 }
 
 
