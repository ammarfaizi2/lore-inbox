Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283540AbRLDWXn>; Tue, 4 Dec 2001 17:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283566AbRLDWX3>; Tue, 4 Dec 2001 17:23:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:57860 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283567AbRLDWXP>;
	Tue, 4 Dec 2001 17:23:15 -0500
Subject: Re: [PATCH] improve spinlock debugging
From: Robert Love <rml@tech9.net>
To: nigel@nrg.org
Cc: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0112041321080.595-100000@cosmic.nrg.org>
In-Reply-To: <Pine.LNX.4.40.0112041321080.595-100000@cosmic.nrg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 17:23:18 -0500
Message-Id: <1007504598.1307.30.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 17:06, Nigel Gamble wrote:

> > Given this order, couldn't we _always_ not touch the preempt count since
> > irq's are off?
> 
> Not with the current spinlock usage in the kernel.
> spin_lock/spin_unlock are used both nested when interrupts are known to
> be disabled (as above) or, more commonly,
> 
> 	spin_lock_irqsave(a, flags)
> 
> 	spin_lock(b)
> 
> 	spin_unlock(b)
> 
> 	spin_unlock_irqrestore(a, flags)
> 
> and when interrupts are enabled:
> 
> 	spin_lock(c)
> 
> 	spin_unlock(c)

Right, I meant just the spin_lock_irq case, which would be fine except
for the case where:

spin_lock_irq
spin_unlock
restore_irq

to solve this, we need a spin_unlock_irq_on macro that didn't touch the
preemption count.

> We don't need to preempt count the former but we do the latter, but
> there's no way to tell the difference without a runtime check for
> interrupt state.
> 
> In IRIX we changed the name of the former, nested versions to:
> 
> 	spin_lock_irqsave(a, flags)
> 
> 	nested_spin_lock(b)
> 
> 	nested_spin_unlock(b)
> 
> 	spin_unlock_irqrestore(a, flags)
> 
> The nested version contained an assertion that interrupts were disabled
> in DEBUG kernels.  We wouldn't need to count the nested_spin_lock
> versions.

Ah, another optimization wrt preempt count.  This goes further than just
making spin_lock_irqsave not touch the preempt count, in that it also
let's us say (this lock is _always_ nested inside another, we don't need
to touch the preempt count).

It would apply anywhere we grab multiple locks and drop the first one
last.

> > Further, since I doubt we ever see:
> >
> > 	spin_lock_irq
> > 	restore_irq
> > 	spin_unlock
> 
> I hope not, since that would be a bug.
> 
> > and the common use is:
> >
> > 	spin_lock_irq
> > 	spin_unlock_irq
> >
> > Isn't it safe to have spin_lock_irq *never* touch the preempt count?
> 
> No, because of
> 
> > > spin_lockirq
> > >
> > > spin_unlock
> > >
> > > restore_irq
> 
> (which does occasionally occur in the kernel).  The spin_unlock is going
> to decrement the count, so the spin_lock_irqsave must increment it.  If
> we had, and used, a nested_spin_unlock, we could then have spin_lock_irq
> never touch the preempt count.

Right.

> [And if we could guarantee that all spinlocks we held for only a few 10s
> of microseconds at the most (a big "if"), we could make them all into
> spin_lock_irqs and then we wouldn't need the preempt count at all.  This
> is how REAL/IX and IRIX implemented kernel preemption.]

I offered that idea and George convinced me otherwise :)

	Robert Love

