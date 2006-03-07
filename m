Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWCGOMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWCGOMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 09:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWCGOMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 09:12:31 -0500
Received: from colin.muc.de ([193.149.48.1]:18450 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750724AbWCGOMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 09:12:30 -0500
Date: 7 Mar 2006 15:12:24 +0100
Date: Tue, 7 Mar 2006 15:12:24 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "lgeek@frontiernet.net" <lgeek@frontiernet.net>,
       linux-kernel@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       mingo@elte.hu
Subject: Re: [PATCH] IRQ: prevent enabling of previously disabled interrupt
Message-ID: <20060307141224.GA10643@muc.de>
References: <20060306212209.qav38uffwhkwsg00@webmail04.roc.ny.frontiernet.net> <20060307035545.49b129c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307035545.49b129c9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the best person to review this is Ingo.

Full quote:

On Tue, Mar 07, 2006 at 03:55:45AM -0800, Andrew Morton wrote:
> "lgeek@frontiernet.net" <lgeek@frontiernet.net> wrote:
> >
> > Hi,
> >    This fix prevents re-disabling and enabling of a previously disabled 
> > interrupt in 2.6.16-rc5.  On an SMP system with irq balancing enabled; 
> > If an interrupt is disabled from within its own interrupt context with 
> > disable_irq_nosync and is also earmarked for processor migration, the 
> > interrupt is blindly moved to the other processor and enabled without 
> > regard for its current "enabled" state.  If there is an interrupt  
> > pending, it will unexpectedly invoke the irq handler on the new irq 
> > owning processor (even though the irq was previously disabled)
> > 
> >    The more intuitive fix would be to invoke disable_irq_nosync and 
> > enable_irq, but since we already have the desc->lock from __do_IRQ, we 
> > cannot call them directly.  Instead we can use the same logic to 
> > disable and enable found in disable_irq_nosync and enable_irq, with 
> > regards to the desc->depth.
> > 
> >    This now prevents a disabled interrupt from being re-disabled, and 
> > more importantly prevents a disabled interrupt from being incorrectly 
> > enabled on a different processor.
> > 
> > Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
> > 
> > --- 2.6.16-rc5/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -155,9 +155,13 @@
> > 	 * Being paranoid i guess!
> > 	 */
> > 	if (unlikely(!cpus_empty(tmp))) {
> > -		desc->handler->disable(irq);
> > +		if (likely(!desc->depth++))
> > +			desc->handler->disable(irq);
> > +
> > 		desc->handler->set_affinity(irq,tmp);
> > -		desc->handler->enable(irq);
> > +
> > +		if (likely(!--desc->depth))
> > +			desc->handler->enable(irq);
> > 	}
> > 	cpus_clear(pending_irq_cpumask[irq]);
> > }
> 
> But desc->lock isn't held here.  We need that for the update to ->depth (at
> least).
> 
> And we can't take it here because one of the two ->end callers in __do_IRQ
> already holds that lock.  Possibly we should require that ->end callers
> hold the lock, but that would incur considerable cost for cpu-local
> interrupts.
> 
> So we'd need to require that ->end gets called outside the lock for
> non-CPU-local interrupts.  I'm not sure what the implications of that would
> be - the ->end handlers don't need to be threaded at present and perhaps we
> could put hardware into a bad state?
> 
> Or we add a new ->local_end, just for the CPU-local IRQs.

