Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUHRP2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUHRP2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUHRP2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:28:05 -0400
Received: from pD951734E.dip.t-dialin.net ([217.81.115.78]:31106 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267338AbUHRP1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:27:34 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <s5hzn4s4lr6.wl@alsa2.suse.de>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092831726.5777.160.camel@localhost>  <s5hzn4s4lr6.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1092842775.7682.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 17:26:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote :
> At Wed, 18 Aug 2004 14:22:07 +0200,
> Thomas Charbonnel wrote:
> > 
> > As a side note, and this has already been reported here several times,
> > the SA_INTERRUPT flag set notably by the sound card drivers handlers is
> > not honored on current kernels if the device is not the first one to be
> > registered. A simple fix would be to add SA_INTERRUPT handlers at the
> > beginning instead of the end of the irq queue in setup_irq.
> > 
> > Similarly, when using SA_SAMPLE_RANDOM, all devices on the given irq
> > contribute to the entropy, even those that have a predictable interrupt
> > rate (e.g. sound cards), and/or for which the number of interrupts could
> > outweight the number of interrupts of the original SA_SAMPLE_RANDOM
> > driver. 
> 
> Hmm, something like this?
> 
> 
> Takashi
> 
> --- linux/arch/i386/kernel/irq.c	2004-08-18 15:15:18.272067276 +0200
> +++ linux/arch/i386/kernel/irq.c	2004-08-18 15:26:13.513979698 +0200
> @@ -219,15 +219,22 @@ inline void synchronize_irq(unsigned int
>  asmlinkage int handle_IRQ_event(unsigned int irq,
>  		struct pt_regs *regs, struct irqaction *action)
>  {
> -	int status = 1;	/* Force the "do bottom halves" bit */
> -	int retval = 0;
> -
> -	if (!(action->flags & SA_INTERRUPT))
> +	int status;
> +	int ret, retval = 0;
> +	struct irqaction *ac;
> +
> +	status = 0;
> +	for (ac = action; ac; ac = ac->next)
> +		status |= ac->flags;
> +	if (!(status & SA_INTERRUPT))
>  		local_irq_enable();
>  
> +	status = 0;
>  	do {
> -		status |= action->flags;
> -		retval |= action->handler(irq, action->dev_id, regs);
> +		ret = action->handler(irq, action->dev_id, regs);
> +		if (ret)
> +			status |= action->flags;
> +		retval |= ret;
>  		action = action->next;
>  	} while (action);
>  	if (status & SA_SAMPLE_RANDOM)

I was thinking more of something like this :

--- irq.c.orig  2004-08-16 14:26:34.000000000 +0200
+++ irq.c       2004-08-18 17:23:18.011059064 +0200
@@ -955,11 +955,16 @@
                        return -EBUSY;
                }

-               /* add new interrupt at end of irq queue */
-               do {
-                       p = &old->next;
-                       old = *p;
-               } while (old);
+               if (new->flags & SA_INTERRUPT)
+                       /* add interrupt at the start of the queue */
+                       new->next = old;
+               else
+                       /* add new interrupt at end of irq queue */
+                       do {
+                               p = &old->next;
+                               old = *p;
+                       } while (old);
+
                shared = 1;
        }

Thomas


