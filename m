Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUHRQy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUHRQy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUHRQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:54:56 -0400
Received: from pD9EB1A58.dip.t-dialin.net ([217.235.26.88]:33409 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266825AbUHRQyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 12:54:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <s5hpt5ov47w.wl@alsa2.suse.de>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092831726.5777.160.camel@localhost> <s5hzn4s4lr6.wl@alsa2.suse.de>
	 <1092842775.7682.7.camel@localhost>  <s5hpt5ov47w.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1092848007.7682.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 18:53:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote :

[...]
> Ok, how about this one?  Together with your patch, the irq is turned
> on for handlers without SA_INTERRUPT.
> 
> 
> Takashi
> 
> --- linux/arch/i386/kernel/irq.c	2004-08-18 15:15:18.000000000 +0200
> +++ linux/arch/i386/kernel/irq.c	2004-08-18 17:42:57.454819403 +0200
> @@ -219,15 +219,23 @@ inline void synchronize_irq(unsigned int
>  asmlinkage int handle_IRQ_event(unsigned int irq,
>  		struct pt_regs *regs, struct irqaction *action)
>  {
> -	int status = 1;	/* Force the "do bottom halves" bit */
> -	int retval = 0;
> -
> -	if (!(action->flags & SA_INTERRUPT))
> -		local_irq_enable();
> +	int status;
> +	int ret, retval = 0;
> +	int irq_off = 1;
>  
> +	status = 0;
>  	do {
> -		status |= action->flags;
> -		retval |= action->handler(irq, action->dev_id, regs);
> +		/* Assume that all SA_INTERRUPT handlers are at the head
> +		 * of the irq queue
> +		 */
> +		if (irq_off && ! (action->flags & SA_INTERRUPT)) {
> +			local_irq_enable();
> +			irq_off = 0;
> +		}
> +		ret = action->handler(irq, action->dev_id, regs);
> +		if (ret)
> +			status |= action->flags;
> +		retval |= ret;
>  		action = action->next;
>  	} while (action);
>  	if (status & SA_SAMPLE_RANDOM)
> @@ -955,11 +963,16 @@ int setup_irq(unsigned int irq, struct i
>  			return -EBUSY;
>  		}
>  
> -		/* add new interrupt at end of irq queue */
> -		do {
> -			p = &old->next;
> -			old = *p;
> -		} while (old);
> +		if (new->flags & SA_INTERRUPT)
> +			/* add interrupt at the start of the queue */
> +			new->next = old;
> +		else
> +			/* add new interrupt at end of irq queue */
> +			do {
> +				p = &old->next;
> +				old = *p;
> +			} while (old);
> +
>  		shared = 1;
>  	}
>  

You're right, of course, my mistake. It looks good now.

Thomas


