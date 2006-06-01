Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWFAKCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWFAKCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWFAKCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:07 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40643 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964902AbWFAKCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:06 -0400
Date: Thu, 1 Jun 2006 12:02:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060601100218.GA30807@elte.hu>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org> <20060531214139.GA8196@devserv.devel.redhat.com> <1149111838.3114.87.camel@laptopd505.fenrus.org> <20060531214729.GA4059@elte.hu> <20060601094643.GA22110@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601094643.GA22110@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@redhat.com> wrote:

> On Wed, May 31, 2006 at 11:47:29PM +0200, Ingo Molnar wrote:
> > couldnt most of these problems be avoided by tracking whether a handler 
> > _ever_ returned a success status? That means that irqpoll could safely 
> > poll handlers for which we know that they somehow arent yet matched up 
> > to any IRQ line?
> 
> But you may get random positive hits from this when a real IRQ for an 
> unrelated device happens to get delivered. We could poll enabled IRQs 
> first then disabled ones ?

hm, you are right. Actions that are registered to the wrong IRQ might 
still appear to 'work' by pure accident, if they also share the IRQ with 
another (correctly routed) action.

the basic problem isnt really the polling method that irqpoll does - it 
is the insensitivity of the IRQ_DISABLED flag: we dont know whether it's 
disabled because the driver wants it, or because it was screaming 
before. Maybe we could (ab-)use irq_desc->depth for that - if that is 0 
but IRQ_DISABLED is set then you may ignore IRQ_DISABLED. Ok?

The patch below implements this logic, ontop of -rc5-mm2. Can you see 
any hole in it? (It built and booted up fine on x86_64 but i dont have 
any misrouted irqs.)

	Ingo

------------------
Subject: fix irqpoll to honor disable_irq()
From: Ingo Molnar <mingo@elte.hu>

irqpoll/irqfixup ignored IRQ_DISABLED but that could cause lockups. So 
listen to desc->depth to correctly honor disable_irq(). Also, when an 
interrupt it screaming, set IRQ_DISABLED but do not touch ->depth.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Index: linux/kernel/irq/spurious.c
===================================================================
--- linux.orig/kernel/irq/spurious.c
+++ linux/kernel/irq/spurious.c
@@ -56,6 +56,15 @@ static int misrouted_irq(int irq, struct
 		local_irq_disable();
 		/* Now clean up the flags */
 		spin_lock(&desc->lock);
+		/*
+		 * NOTE: we only listen to desc->depth here, not to
+		 * IRQ_DISABLED - which might have been set due to
+		 * a screaming interrupt.
+		 */
+		if (desc->depth) {
+			spin_unlock(&desc->lock);
+			continue;
+		}
 		action = desc->action;
 
 		/*
@@ -163,10 +172,12 @@ void note_interrupt(unsigned int irq, st
 		__report_bad_irq(irq, desc, action_ret);
 		/*
 		 * Now kill the IRQ
+		 *
+		 * We keep desc->depth unchanged - so that irqpoll can
+		 * honor driver IRQ-disabling.
 		 */
 		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
 		desc->status |= IRQ_DISABLED;
-		desc->depth = 1;
 		desc->chip->disable(irq);
 	}
 	desc->irqs_unhandled = 0;
