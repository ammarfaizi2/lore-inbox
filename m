Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281234AbRLDWIQ>; Tue, 4 Dec 2001 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283545AbRLDWIE>; Tue, 4 Dec 2001 17:08:04 -0500
Received: from nrg.org ([216.101.165.106]:50194 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S283540AbRLDWHx>;
	Tue, 4 Dec 2001 17:07:53 -0500
Date: Tue, 4 Dec 2001 14:06:51 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Robert Love <rml@tech9.net>
cc: george anzinger <george@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <1007499102.1303.24.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0112041321080.595-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Dec 2001, Robert Love wrote:
> On Tue, 2001-12-04 at 15:30, george anzinger wrote:
>
> > spin_lockirq
> >
> > spin_unlock
> >
> > restore_irq
>
> Given this order, couldn't we _always_ not touch the preempt count since
> irq's are off?

Not with the current spinlock usage in the kernel.
spin_lock/spin_unlock are used both nested when interrupts are known to
be disabled (as above) or, more commonly,

	spin_lock_irqsave(a, flags)

	spin_lock(b)

	spin_unlock(b)

	spin_unlock_irqrestore(a, flags)

and when interrupts are enabled:

	spin_lock(c)

	spin_unlock(c)

We don't need to preempt count the former but we do the latter, but
there's no way to tell the difference without a runtime check for
interrupt state.

In IRIX we changed the name of the former, nested versions to:

	spin_lock_irqsave(a, flags)

	nested_spin_lock(b)

	nested_spin_unlock(b)

	spin_unlock_irqrestore(a, flags)

The nested version contained an assertion that interrupts were disabled
in DEBUG kernels.  We wouldn't need to count the nested_spin_lock
versions.


> Further, since I doubt we ever see:
>
> 	spin_lock_irq
> 	restore_irq
> 	spin_unlock

I hope not, since that would be a bug.

> and the common use is:
>
> 	spin_lock_irq
> 	spin_unlock_irq
>
> Isn't it safe to have spin_lock_irq *never* touch the preempt count?

No, because of

> > spin_lockirq
> >
> > spin_unlock
> >
> > restore_irq

(which does occasionally occur in the kernel).  The spin_unlock is going
to decrement the count, so the spin_lock_irqsave must increment it.  If
we had, and used, a nested_spin_unlock, we could then have spin_lock_irq
never touch the preempt count.

[And if we could guarantee that all spinlocks we held for only a few 10s
of microseconds at the most (a big "if"), we could make them all into
spin_lock_irqs and then we wouldn't need the preempt count at all.  This
is how REAL/IX and IRIX implemented kernel preemption.]

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

