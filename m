Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752364AbWCGL5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbWCGL5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCGL5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:57:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752364AbWCGL5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:57:43 -0500
Date: Tue, 7 Mar 2006 03:55:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: "lgeek@frontiernet.net" <lgeek@frontiernet.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] IRQ: prevent enabling of previously disabled interrupt
Message-Id: <20060307035545.49b129c9.akpm@osdl.org>
In-Reply-To: <20060306212209.qav38uffwhkwsg00@webmail04.roc.ny.frontiernet.net>
References: <20060306212209.qav38uffwhkwsg00@webmail04.roc.ny.frontiernet.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"lgeek@frontiernet.net" <lgeek@frontiernet.net> wrote:
>
> Hi,
>    This fix prevents re-disabling and enabling of a previously disabled 
> interrupt in 2.6.16-rc5.  On an SMP system with irq balancing enabled; 
> If an interrupt is disabled from within its own interrupt context with 
> disable_irq_nosync and is also earmarked for processor migration, the 
> interrupt is blindly moved to the other processor and enabled without 
> regard for its current "enabled" state.  If there is an interrupt  
> pending, it will unexpectedly invoke the irq handler on the new irq 
> owning processor (even though the irq was previously disabled)
> 
>    The more intuitive fix would be to invoke disable_irq_nosync and 
> enable_irq, but since we already have the desc->lock from __do_IRQ, we 
> cannot call them directly.  Instead we can use the same logic to 
> disable and enable found in disable_irq_nosync and enable_irq, with 
> regards to the desc->depth.
> 
>    This now prevents a disabled interrupt from being re-disabled, and 
> more importantly prevents a disabled interrupt from being incorrectly 
> enabled on a different processor.
> 
> Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
> 
> --- 2.6.16-rc5/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -155,9 +155,13 @@
> 	 * Being paranoid i guess!
> 	 */
> 	if (unlikely(!cpus_empty(tmp))) {
> -		desc->handler->disable(irq);
> +		if (likely(!desc->depth++))
> +			desc->handler->disable(irq);
> +
> 		desc->handler->set_affinity(irq,tmp);
> -		desc->handler->enable(irq);
> +
> +		if (likely(!--desc->depth))
> +			desc->handler->enable(irq);
> 	}
> 	cpus_clear(pending_irq_cpumask[irq]);
> }

But desc->lock isn't held here.  We need that for the update to ->depth (at
least).

And we can't take it here because one of the two ->end callers in __do_IRQ
already holds that lock.  Possibly we should require that ->end callers
hold the lock, but that would incur considerable cost for cpu-local
interrupts.

So we'd need to require that ->end gets called outside the lock for
non-CPU-local interrupts.  I'm not sure what the implications of that would
be - the ->end handlers don't need to be threaded at present and perhaps we
could put hardware into a bad state?

Or we add a new ->local_end, just for the CPU-local IRQs.
