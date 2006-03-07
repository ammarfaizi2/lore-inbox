Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWCGX4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWCGX4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCGX4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:56:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751659AbWCGX4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:56:35 -0500
Date: Tue, 7 Mar 2006 15:58:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bryan Holty <lgeek@frontiernet.net>
Cc: ak@muc.de, tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ: prevent enabling of previously disabled interrupt
Message-Id: <20060307155843.67d5f491.akpm@osdl.org>
In-Reply-To: <20060307132051.hjv4vs2d8dc0skoo@webmail03.roc.ny.frontiernet.net>
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
	<9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
	<20060307132051.hjv4vs2d8dc0skoo@webmail03.roc.ny.frontiernet.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Holty <lgeek@frontiernet.net> wrote:
>
> On Tuesday 07 March 2006 05:55, Andrew Morton wrote:
> > "lgeek@frontiernet.net" <lgeek@frontiernet.net> wrote:
> >>
> >> Hi,
> >>    This fix prevents re-disabling and enabling of a previously disabled
> >> interrupt in 2.6.16-rc5.  On an SMP system with irq balancing enabled;
> >> If an interrupt is disabled from within its own interrupt context with
> >> disable_irq_nosync and is also earmarked for processor migration, 
> >> the interrupt is blindly moved to the other processor and enabled 
> >> without regard for its current "enabled" state.  If there is an 
> >> interrupt
> >> pending, it will unexpectedly invoke the irq handler on the new irq
> >> owning processor (even though the irq was previously disabled)
> >>
> >>    The more intuitive fix would be to invoke disable_irq_nosync and
> >> enable_irq, but since we already have the desc->lock from __do_IRQ, we
> >> cannot call them directly.  Instead we can use the same logic to
> >> disable and enable found in disable_irq_nosync and enable_irq, with
> >> regards to the desc->depth.
> >>
> >>    This now prevents a disabled interrupt from being re-disabled, 
> >> and more importantly prevents a disabled interrupt from being 
> >> incorrectly enabled on a different processor.
> >>
> >> Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
> >>
> >> --- 2.6.16-rc5/include/linux/irq.h
> >> +++ b/include/linux/irq.h
> >> @@ -155,9 +155,13 @@
> >> 	 * Being paranoid i guess!
> >> 	 */
> >> 	if (unlikely(!cpus_empty(tmp))) {
> >> -		desc->handler->disable(irq);
> >> +		if (likely(!desc->depth++))
> >> +			desc->handler->disable(irq);
> >> +
> >> 		desc->handler->set_affinity(irq,tmp);
> >> -		desc->handler->enable(irq);
> >> +
> >> +		if (likely(!--desc->depth))
> >> +			desc->handler->enable(irq);
> >> 	}
> >> 	cpus_clear(pending_irq_cpumask[irq]);
> >> }
> >
> > But desc->lock isn't held here.  We need that for the update to ->depth (at
> > least).
> >
> > And we can't take it here because one of the two ->end callers in __do_IRQ
> > already holds that lock.  Possibly we should require that ->end callers
> > hold the lock, but that would incur considerable cost for cpu-local
> > interrupts.
> >
> > So we'd need to require that ->end gets called outside the lock for
> > non-CPU-local interrupts.  I'm not sure what the implications of that would
> > be - the ->end handlers don't need to be threaded at present and perhaps we
> > could put hardware into a bad state?
> >
> > Or we add a new ->local_end, just for the CPU-local IRQs.
> 
> ...
>
> Another option is to check for the disabled flag explicitly.  The check prior
> to the disable could arguably be removed, but the check prior to the
> enable is necessary.  If the interrupt has been explicitly disabled, as with
> the IRQ_DISABLED flag, then it will take an explicit effort to re-enable it.
> 
> 
> --- 2.6.16-rc5/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -155,9 +155,13 @@
> 	 * Being paranoid i guess!
> 	 */
> 	if (unlikely(!cpus_empty(tmp))) {
> -		desc->handler->disable(irq);
> +		if (likely(!(desc->status & IRQ_DISABLED)))
> +			desc->handler->disable(irq);
> +
> 		desc->handler->set_affinity(irq,tmp);
> -		desc->handler->enable(irq);
> +
> +		if (likely(!(desc->status & IRQ_DISABLED)))
> +			desc->handler->enable(irq);
> 	}
> 	cpus_clear(pending_irq_cpumask[irq]);
> }

Yes, but we're still racy against (say) disable_irq() and enable_irq().  We
can end up getting the wrong value of desc->status, or we can get
desc->status and irq-enabledness out of sync, or we can end up running
->enable() or ->disable() on two CPUs at the same time.

And I think it's a bug we _already_ have: if one CPU runs disable_irq()
against a different CPU's cpu-local interrupt, both CPUs could end up
talking to the IRQ hardware concurrently.  Probably there's nowhere where
that happens, but the APIs permit it.


I guess what we could do is to add, in move_native_irq():

        if (CHECK_IRQ_PER_CPU(desc->status))
		return;

because there's no reason to consider migrating a cpu-local interrupt. 
Surely that effect is already happening in there by some means, but being
explicit about it won't hurt.

Once we've done that, we know that your patch is safe - the caller holds
the lock and we can stick an assert_spin_locked() in there.

In fact there's a comment in there asserting that the caller always holds
the lock.

Like this?  (Note that I uninlined move_native_irq().  Nearly fell out of
my chair when I saw that thing).


--- 25/kernel/irq/migration.c~irq-prevent-enabling-of-previously-disabled-interrupt	Tue Mar  7 15:54:25 2006
+++ 25-akpm/kernel/irq/migration.c	Tue Mar  7 15:58:19 2006
@@ -18,9 +18,17 @@ void move_native_irq(int irq)
 	cpumask_t tmp;
 	irq_desc_t *desc = irq_descp(irq);
 
-	if (likely (!desc->move_irq))
+	if (likely(!desc->move_irq))
 		return;
 
+	/*
+	 * Paranoia: cpu-local interrupts shouldn't be calling in here anyway.
+	 */
+	if (CHECK_IRQ_PER_CPU(desc->status)) {
+		WARN_ON(1);
+		return;
+	}
+
 	desc->move_irq = 0;
 
 	if (likely(cpus_empty(pending_irq_cpumask[irq])))
@@ -29,7 +37,8 @@ void move_native_irq(int irq)
 	if (!desc->handler->set_affinity)
 		return;
 
-	/* note - we hold the desc->lock */
+	assert_spin_locked(&desc->lock);
+
 	cpus_and(tmp, pending_irq_cpumask[irq], cpu_online_map);
 
 	/*
@@ -42,9 +51,13 @@ void move_native_irq(int irq)
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
_

