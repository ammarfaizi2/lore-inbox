Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEGl7>; Fri, 5 Jan 2001 01:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbRAEGlt>; Fri, 5 Jan 2001 01:41:49 -0500
Received: from patan.Sun.COM ([192.18.98.43]:30878 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S129183AbRAEGll>;
	Fri, 5 Jan 2001 01:41:41 -0500
Message-ID: <3A556D9F.934AEAFD@sun.com>
Date: Thu, 04 Jan 2001 22:45:51 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <3A5437A1.F540D794@sun.com> <01010423104900.01080@dox> <3A555BA3.A0B65A81@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> Roger Larsson wrote:
> >
>
> > This part can probably be put in a proper non inline function.
> > Cache issues...
> > +                /*
> > +                * At that point a scheduling is healthy iff:
> > +                * - a scheduling request is pending.
> > +                * - the task is in running state.
> > +                * - this is not an interrupt context.
> > +                * - local interrupts are enabled.
> > +                */
> > +                if (current->need_resched == 1     &&
> > +                   current->state == TASK_RUNNING &&
> > +                   !in_interrupt()                &&
> > +                   local_irq_are_enabled())
> > +                {
> > +                        schedule();
> > +                }
> >
> Actually the MontaVista Patch cleverly removes the tests for
> in_interrupt() and local_irq_are_enabled() AND the state ==
> TASK_RUNNING.  In actual fact these states can be considered way points
> on the system status vector.  For example the interrupts off state
> implies all the rest, the in_interrupt() implies not preemptable and
> finally, not preemptable is one station away from fully preemptable.
>
> TASK_RUNNING is easily solved by makeing schedule() aware that it is
> being called for preemption.  See the MontaVista patch for details.
>

Humm, I'm just curious,
Regarding in_interrupt(). How do you deal with soft interrupts?
Guys calling cpu_bh_disable() or even incrementing the count on
their own. I don't know if this acceptable but definitely can be done,
I prefer to rely on fact than on API.
Regarding local_irq_enabled(). How do you handle the code that
call local_irq_disable(), then spin_lock(), spin_unlock() and only
re-enable the interruptions ? In this case, you preempt code that
is supposed to run interruptions disabled.
Finally, regarding the test on the task state, there may be a cache issue
but calling schedule() has also some overhead.

Ludo.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
