Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEILl>; Fri, 5 Jan 2001 03:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbRAEILg>; Fri, 5 Jan 2001 03:11:36 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:29459 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129387AbRAEIL0>; Fri, 5 Jan 2001 03:11:26 -0500
Message-ID: <3A55818F.7C36BECC@mvista.com>
Date: Fri, 05 Jan 2001 00:10:56 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ludovic fernandez <ludovic.fernandez@sun.com>
CC: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <3A5437A1.F540D794@sun.com> <01010423104900.01080@dox> <3A555BA3.A0B65A81@mvista.com> <3A556D9F.934AEAFD@sun.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ludovic fernandez wrote:
> 
> george anzinger wrote:
> 
> > Roger Larsson wrote:
> > >
> >
> > > This part can probably be put in a proper non inline function.
> > > Cache issues...
> > > +                /*
> > > +                * At that point a scheduling is healthy iff:
> > > +                * - a scheduling request is pending.
> > > +                * - the task is in running state.
> > > +                * - this is not an interrupt context.
> > > +                * - local interrupts are enabled.
> > > +                */
> > > +                if (current->need_resched == 1     &&
> > > +                   current->state == TASK_RUNNING &&
> > > +                   !in_interrupt()                &&
> > > +                   local_irq_are_enabled())
> > > +                {
> > > +                        schedule();
> > > +                }
> > >
> > Actually the MontaVista Patch cleverly removes the tests for
> > in_interrupt() and local_irq_are_enabled() AND the state ==
> > TASK_RUNNING.  In actual fact these states can be considered way points
> > on the system status vector.  For example the interrupts off state
> > implies all the rest, the in_interrupt() implies not preemptable and
> > finally, not preemptable is one station away from fully preemptable.
> >
> > TASK_RUNNING is easily solved by makeing schedule() aware that it is
> > being called for preemption.  See the MontaVista patch for details.
> >
> 
> Humm, I'm just curious,
> Regarding in_interrupt(). How do you deal with soft interrupts?
> Guys calling cpu_bh_disable() or even incrementing the count on
> their own.
 
#define cpu_bh_disable(cpu)	do { ctx_sw_off(); local_bh_count(cpu)++;
barrier(); } while (0)
#define cpu_bh_enable(cpu)	do { barrier();
local_bh_count(cpu)--;ctx_sw_on(); } while (0)

I don't know if this acceptable but definitely can be done,
> I prefer to rely on fact than on API.

Yes, of course anything CAN be done, but then they would be SOL with the
movement of the flag location (as was done on the way from 2.3 to
2.4.0).  If we encounter such problems, we just fix them.

> Regarding local_irq_enabled(). How do you handle the code that
> call local_irq_disable(), then spin_lock(), spin_unlock() and only
> re-enable the interruptions ? 

Good question, as this is exactly what spin_lock_irq()/spin_unlock_irq()
do.  In this case it is not a problem as the intent was the same anyway,
but we can fix the code to handle this.  If you read the patch, you will
find that we call preempt_schedule() which calls schedule().  We could
easily put a test of the interrupt off state here and reject the
preemption.  The real issue here is how to catch the preemption when
local_irq_enable() is called.  If the system has an interrupt dedicated
to scheduling we could use this, however, while this is available in SMP
systems it is usually not available in UP systems.

On the other hand I have not seen any code do this.  I have, however,
seen code that:
    spin_lock_irq()
      :
    local_irq_enable()
      :
    spin_unlock()

We would rather not mess with the preemption count while irq is disabled
but this sort of code messes up the pairing we need to make this work.

> In this case, you preempt code that
> is supposed to run interruptions disabled.
> Finally, regarding the test on the task state, there may be a cache issue
> but calling schedule() has also some overhead.
> 
I am not sure what you are getting at here.  The task state will be
looked at by schedule() in short order in any case so a cache miss is
not the issue.  We don't look at the state but on the way to schedule()
(in preempt_schedule()) we add a flag to the state to indicate that it
is a preemption call.  schedule() is then changed to treat this task as
running, regardless of the state.

George

> Ludo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
