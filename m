Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWCGNsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCGNsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWCGNsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:48:25 -0500
Received: from [207.250.72.45] ([207.250.72.45]:30888 "EHLO
	xiovader.xiocorp.dom") by vger.kernel.org with ESMTP
	id S1751093AbWCGNsY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:48:24 -0500
From: Bryan Holty <lgeek@frontiernet.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] IRQ: prevent enabling of previously disabled interrupt
Date: Tue, 7 Mar 2006 07:47:44 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       "Luck, Tony" <tony.luck@intel.com>
References: <20060306212209.qav38uffwhkwsg00@webmail04.roc.ny.frontiernet.net> <20060307035545.49b129c9.akpm@osdl.org>
In-Reply-To: <20060307035545.49b129c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603070747.44170.lgeek@frontiernet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 05:55, Andrew Morton wrote:
> "lgeek@frontiernet.net" <lgeek@frontiernet.net> wrote:
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hopefully in the correct thread now. :-)

Another option is to check for the disabled flag explicitly.  The check prior 
to the disable could arguably be removed, but the check prior to the enable 
is necessary.  If the interrupt has been explicitly disabled, as with the 
IRQ_DISABLED flag, then it will take an explicit effort to re-enable it.

--- 2.6.16-rc5/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -155,9 +155,13 @@
 	 * Being paranoid i guess!
 	 */
 	if (unlikely(!cpus_empty(tmp))) {
-		desc->handler->disable(irq);
+		if (likely(!(desc->status & IRQ_DISABLED)))
+			desc->handler->disable(irq);
+
 		desc->handler->set_affinity(irq,tmp);
-		desc->handler->enable(irq);
+
+		if (likely(!(desc->status & IRQ_DISABLED)))
+			desc->handler->enable(irq);
 	}
 	cpus_clear(pending_irq_cpumask[irq]);
 }

--
 Bryan Holty
