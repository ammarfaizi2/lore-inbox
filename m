Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750799AbWFEIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFEIuO (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWFEIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:50:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21988 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750799AbWFEIuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:50:13 -0400
Date: Mon, 5 Jun 2006 10:49:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm3] fix irqpoll some more
Message-ID: <20060605084938.GA31915@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net> <1149497459.23209.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149497459.23209.39.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sul, 2006-06-04 am 23:00 -0700, ysgrifennodd akpm@osdl.org:
> > irqpoll/irqfixup ignored IRQ_DISABLED but that could cause lockups.  So
> > listen to desc->depth to correctly honor disable_irq().  Also, when an
> > interrupt it screaming, set IRQ_DISABLED but do not touch ->depth.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> NAK
> 
> The moment you do this you as good as lose irqpoll support because the 
> IRQ being disabled is unrelated to the IRQ delivery line when dealing 
> with faults of this nature.

hm, agreed. I really sent it more as an RFC. The real fix is to do the 
disable_irq_handler()/enable_irq_handler() thing. [which is also a much 
nicer interface for more advanced MSI concepts]

> There is a saner fix - walk all the IRQs that are not disabled and 
> only if that produces no claim (ie the box is about to die otherwise) 
> then walk the disabled ones. Its a slow path at that point in error 
> recovery so the performance isn't critical.

yeah. How about the patch below? [builds and boots on x86, but no real 
irqpoll testing was done as i dont have such a problem-system.]

	Ingo

---------------
Subject: fix irqpoll some more
From: Ingo Molnar <mingo@elte.hu>

implement Alan's suggestion of irqpoll doing a second pass over
disabled irq lines if we didnt manage to handle the screaming
interrupt.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/spurious.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

Index: linux/kernel/irq/spurious.c
===================================================================
--- linux.orig/kernel/irq/spurious.c
+++ linux/kernel/irq/spurious.c
@@ -18,8 +18,9 @@ static int irqfixup __read_mostly;
  */
 static int misrouted_irq(int irq, struct pt_regs *regs)
 {
-	int i, ok = 0, work = 0;
+	int i, ok = 0, work = 0, first_pass = 1;
 
+repeat:
 	for (i = 1; i < NR_IRQS; i++) {
 		struct irq_desc *desc = irq_desc + i;
 		struct irqaction *action;
@@ -61,7 +62,7 @@ static int misrouted_irq(int irq, struct
 		 * IRQ_DISABLED - which might have been set due to
 		 * a screaming interrupt.
 		 */
-		if (desc->depth) {
+		if (first_pass && desc->depth) {
 			spin_unlock(&desc->lock);
 			continue;
 		}
@@ -90,6 +91,25 @@ static int misrouted_irq(int irq, struct
 			desc->chip->end(i);
 		spin_unlock(&desc->lock);
 	}
+	/*
+	 * HACK:
+	 *
+	 * In the first pass we dont touch handlers that are behind
+	 * a disabled IRQ line. In the second pass (having no other
+	 * choice) we ignore the disabled state of IRQ lines. We've
+	 * got a screaming interrupt, so we have the choice between
+	 * a real lockup happening due to that screaming interrupt,
+	 * against a theoretical locking that becomes possible if we
+	 * ignore a disabled IRQ line.
+	 *
+	 * FIXME: proper disable_irq_handler() API would remove the
+	 * need for this hack.
+	 */
+	if (!ok && first_pass) {
+		first_pass = 0;
+		goto repeat;
+	}
+
 	/* So the caller can adjust the irq error counts */
 	return ok;
 }
