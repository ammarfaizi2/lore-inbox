Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWDKRHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWDKRHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDKRHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:07:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4231 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751024AbWDKRHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:07:25 -0400
Date: Tue, 11 Apr 2006 19:07:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
Message-ID: <20060411170721.GA1893@elf.ucw.cz>
References: <17463.14285.31029.943738@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17463.14285.31029.943738@cse.unsw.edu.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  This is my first real introduction to the IRQ handling code in Linux,
>  so please forgive any little errors.  I'm fairly sure the big picture
>  is right, partly because the patch helps so much.
> 
>  To explain what I think is happening, let me start with a very simple
>  case.  A number of PCI devices (this one included) have a number of
>  events which can trigger an interrupt.  The events which are current
>  are presented as bits in a register, and are ORed together (and
>  possibly masked by another register) to make the IRQ line.
>  When 1's are written to any bits in this register, it acknowledges
>  the event and clears the bit.
>  A typical code fragment is 
>    events = read_register(INTERRUPTS);
>    write_register(INTERRUPTS, events);
>    ... handle each 1 bits in events ....
> 
>  This would normally clear all pending events and cause the interrupt
>  line to go low (or at least to not be asserted).
> 
>  However there is room for a race here.  If an event occurs between
>  the read and the write, then this will NOT de-assert the IRQ line.
>  It will remain asserted throughout.
> 
>  Now if the IRQ is handled as an edge-triggered line (which I believe
>  they are in Linux), then losing this race will mean that we don't see
>  any more interrupts on this line.

I believe that

a) any shared interrupts should be level-triggered. It is not okay to
share edge-triggered interrupt

b) your patch does not fix that issue. It only makes race window
smaller.

>  	if (!(action->flags & SA_INTERRUPT))
>  		local_irq_enable();
>  
>  	do {
>  		ret = action->handler(irq, action->dev_id, regs);
> -		if (ret == IRQ_HANDLED)
> +		if (ret == IRQ_HANDLED) {
>  			status |= action->flags;
> +			repeat = 1;
> +		}
>  		retval |= ret;
>  		action = action->next;
> +		if (!action &&
> +		    repeat &&
> +		    safeirq &&
> +		    (actionlist->flags & SA_SHIRQ)) {
> +			/* at least one handler on the list did something,
> +			 * and the interrupt is sharable, so give
> +			 * every handler another chance, incase a new event
> +			 * came in and is holding the irq line asserted.
> +			 */
> +			action = actionlist;
> +			repeat = 0;
> +		}
>  	} while (action);

I think it is still racy. What if another interrupt comes here?

>  	if (status & SA_SAMPLE_RANDOM)

								Pavel
-- 
Thanks for all the (sleeping) penguins.
