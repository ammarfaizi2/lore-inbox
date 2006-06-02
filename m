Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWFBIe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWFBIe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWFBIe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:34:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50860 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751328AbWFBIe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:34:27 -0400
Date: Fri, 2 Jun 2006 10:34:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm2] genirq: handle_fasteoi_irq(): do not ->mask()
Message-ID: <20060602083450.GB17417@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: genirq: handle_fasteoi_irq(): do not ->mask()
From: Ingo Molnar <mingo@elte.hu>

Ben noticed an inefficiency in the handle_fasteoi_irq() flow
handler: it does a spurious ->mask() call. (That call is not
needed - if something did a disable_irq() then it would have
masked the irq itself.)

i tested the fix on all affected fasteoi platforms: x86 and x86_64,
on both UP and SMP.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -324,8 +324,6 @@ handle_fasteoi_irq(unsigned int irq, str
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 out:
-	if (unlikely(desc->status & IRQ_DISABLED))
-		desc->chip->mask(irq);
 	desc->chip->eoi(irq);
 
 	spin_unlock(&desc->lock);
