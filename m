Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283430AbRLDUeO>; Tue, 4 Dec 2001 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283432AbRLDUdH>; Tue, 4 Dec 2001 15:33:07 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55543 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283459AbRLDUb2>; Tue, 4 Dec 2001 15:31:28 -0500
Message-ID: <3C0D3283.4DA4DD2B@mvista.com>
Date: Tue, 04 Dec 2001 12:30:59 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> CONFIG_DEBUG_SPINLOCK only adds spinlock tests for SMP builds. The
> attached patch adds runtime checks for uniprocessor builds.
> 
> Tested on i386/UP, but it should work on all platforms. It contains
> runtime checks for:
> 
> - missing initialization
> - recursive lock
> - double unlock
> - incorrect use of spin_is_locked() or spin_trylock() [both function
> do not work as expected on uniprocessor builds]
> The next step are checks for spinlock ordering mismatches.

What do you consider an order mismatch?  I would like to see this:

spin_lockirq

spin_unlock

restore_irq

go away.  I.e. xx_lockirq should be paired with xx_unlockirq.  If
exceptions are needed, we should provide macros that explicitly do this
such as:

spin_unlock_leaveirq_off

or some such.

Of course, all this is predicated on using the lock macros in a
different way than intended.  For example, preemption currently counts
up on spin_lock and disable irq, counting the spin_lockirq twice.  In
fact, it need only count it once, if the locks are properly paired.  It
might also be nice to have a set of lock routines that make explicit the
assumptions made.  For example:

read_lock_irq_assumed_off  or
read_lockirq_assumed_on  (used instead of saveirq based on the
assumption)

These locks could then have optional debug code that tested the
assumption.

If we got all of this clean enough, we would know when we were locking
with irq off and the preemption patch, for example, would not need to
count the spinlock at all, but just the irq.  (Oh, and since the irq
inhibits preemption all by itself, we don't need to count it either.)
> 
> Which other runtime checks are possible?
> Tests for correct _irq usage are not possible, several drivers use
> disable_irq().

Run time checks for xxx_irq when irq is already off seem reasonable. 
The implication is that the xxx_unlockirq will then turn it on, which
most likely is an error.  Also, see above about rolling assumptions in
to the macro name.
> 
> --
>         Manfred
> 

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
