Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWEaBww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWEaBww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWEaBww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:52:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:52104 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751528AbWEaBww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:52:52 -0400
Subject: genirq vs. fastack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 11:52:40 +1000
Message-Id: <1149040361.766.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Ingo !

There is one bit in genirq that I don't get (and doesn't work for me),
it's the "fastack" handler. It does:

out:
	if (!(desc->status & IRQ_DISABLED))
		desc->chip->ack(irq);
	else
		desc->chip->mask(irq);

Which doesn't at all match the needs of things like XICS or MPIC and
thus I wonder if it does also make sense for controllers for which you
intend it. It should just be:

	desc->chip->end(irq);

Basically, those controllers will have 1) already acke'd the interrupt
by the time you get the vector (the act of getting the vector does the
ack), 2) will use a processor priority mecanism to handle non-reentrency
of an interrupt thus mask/unmask is completely orthogonal to handling of
interrupts and thus there is no need to do anything about mask/unmask in
the handler, 3) all we need is to do an "EOI" (end of interrupt) at the
end of the handling, which is what is done logically in the end()
handler.

Thus this proposed patch:

Index: linux-work/kernel/irq/chip.c
===================================================================
--- linux-work.orig/kernel/irq/chip.c	2006-05-31 11:26:45.000000000 +1000
+++ linux-work/kernel/irq/chip.c	2006-05-31 11:48:19.000000000 +1000
@@ -325,10 +325,7 @@ handle_fastack_irq(unsigned int irq, str
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 out:
-	if (!(desc->status & IRQ_DISABLED))
-		desc->chip->ack(irq);
-	else
-		desc->chip->mask(irq);
+	desc->chip->end(irq);
 
 	spin_unlock(&desc->lock);
 }


