Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbRGFL6b>; Fri, 6 Jul 2001 07:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266450AbRGFL6Q>; Fri, 6 Jul 2001 07:58:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2657 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266438AbRGFL5w>; Fri, 6 Jul 2001 07:57:52 -0400
Date: Fri, 6 Jul 2001 13:57:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Ville Nummela <ville.nummela@mail.necsom.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
Message-ID: <20010706135755.G2425@athlon.random>
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com> <3B45760D.6F99149C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B45760D.6F99149C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jul 06, 2001 at 04:25:49AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 04:25:49AM -0400, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > The only thing that appears fishy is that if the tasklet constantly
> > reschedules itself, it will never leave the loop AFAICS.  This affects
> > tasklet_hi_action as well as tasklet_action.
> 
> As I hacked around to fix this, I noticed Andrea's ksoftirq patch
> already fixed this.  So, I decided to look over his patch instead.
> 
> 
> Quoted from 00_ksoftirqd-7:
> > +#ifdef CONFIG_SMP
> > +       movl processor(%ebx),%eax
> > +       shll $CONFIG_X86_L1_CACHE_SHIFT,%eax
> > +       testl $0, SYMBOL_NAME(irq_stat)(,%eax)  # softirq_pending
> > +#else
> > +       testl $0, SYMBOL_NAME(irq_stat)         # softirq_pending
> > +#endif
> > +       jne   handle_softirq
> 
> Did you get this from Alpha? :)  This is very similar to a
> micro-optimization I put in for UP machines on Alpha.

Not sure where I got it, I think I wrote it myself while adapting to the
removal of the mask field.

> > diff -urN 2.4.6pre5/include/asm-i386/softirq.h softirq/include/asm-i386/softirq.h
> > --- 2.4.6pre5/include/asm-i386/softirq.h        Thu Jun 21 08:03:52 2001
> > +++ softirq/include/asm-i386/softirq.h  Thu Jun 21 15:58:06 2001
> > @@ -28,6 +26,7 @@
> >  do {                                                                   \
> >         unsigned int *ptr = &local_bh_count(smp_processor_id());        \
> >                                                                         \
> > +       barrier();                                                      \
> >         if (!--*ptr)                                                    \
> >                 __asm__ __volatile__ (                                  \
> >                         "cmpl $0, -8(%0);"                              \
> 
> If you don't mind, why is barrier() needed here?  The __volatile__
> doesn't take care of that?

The asm volatile is _after_ the --*ptr, while a barrier() must be _before_
the --*ptr, that's why an explicit barrier is needed there too.

That is a bug in mainline and that's the fix.

> > diff -urN 2.4.6pre5/kernel/softirq.c softirq/kernel/softirq.c
> > --- 2.4.6pre5/kernel/softirq.c  Thu Jun 21 08:03:57 2001
> > +++ softirq/kernel/softirq.c    Thu Jun 21 15:58:06 2001
> > @@ -51,17 +51,20 @@
> >  {
> >         int cpu = smp_processor_id();
> >         __u32 pending;
> > +       long flags;
> > +       __u32 mask;
> > 
> >         if (in_interrupt())
> >                 return;
> > 
> > -       local_irq_disable();
> > +       local_irq_save(flags);
> > 
> >         pending = softirq_pending(cpu);
> > 
> >         if (pending) {
> >                 struct softirq_action *h;
> > 
> > +               mask = ~pending;
> >                 local_bh_disable();
> >  restart:
> >                 /* Reset the pending bitmask before enabling irqs */
> > @@ -81,12 +84,26 @@
> >                 local_irq_disable();
> > 
> >                 pending = softirq_pending(cpu);
> > -               if (pending)
> > +               if (pending & mask) {
> > +                       mask &= ~pending;
> >                         goto restart;
> > +               }
> 
> Cool, I was wondering why the old code did not do pending&mask...

It didn't do it intentionally, just to infinite loop and live lock under
flood.

Also worthwhle to note that the unconditional local_irq_enable and lack
of save_flags in do_softirq is completly broken in mainline, it can
stack overflow. My patch fixes that. That's one of the most important
bits in my patch.

> > @@ -112,8 +129,7 @@
> >          * If nobody is running it then add it to this CPU's
> >          * tasklet queue.
> >          */
> > -       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
> > -                                               tasklet_trylock(t)) {
> > +       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> >                 t->next = tasklet_vec[cpu].list;
> >                 tasklet_vec[cpu].list = t;
> >                 __cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
> > @@ -130,8 +146,7 @@
> >         cpu = smp_processor_id();
> >         local_irq_save(flags);
> > 
> > -       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
> > -                                               tasklet_trylock(t)) {
> > +       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> >                 t->next = tasklet_hi_vec[cpu].list;
> >                 tasklet_hi_vec[cpu].list = t;
> >                 __cpu_raise_softirq(cpu, HI_SOFTIRQ);
> 
> Why does tasklet_trylock go away?

because the logic is different, that's perfectly ok. In short when irq
are enabled and the TASKLET_STATE_SCHED bit is set, then the tasklet is
also queued. That's the old cleaner and not buggy logic implemented by
Alexey originally, it fixes the missed tasklet event in the other case
mentioned in the other email. It is also more efficient.

> It seems like this removes the supported capability for a tasklet to
> reschedule itself, which would occur when test_and_set_bit succeeds but
> tasklet_trylock fails, in the code above.

No, the mainline code does the trylock only because for mainline it is not
enough to know TASKLET_STATE_SCHED is not set with irq disabled to
ensure we need to queue the tasklet in the list.

> > @@ -148,37 +163,29 @@
> >         local_irq_disable();
> >         list = tasklet_vec[cpu].list;
> >         tasklet_vec[cpu].list = NULL;
> > +       local_irq_enable();
> > 
> >         while (list) {
> >                 struct tasklet_struct *t = list;
> > 
> >                 list = list->next;
> > 
> > -               /*
> > -                * A tasklet is only added to the queue while it's
> > -                * locked, so no other CPU can have this tasklet
> > -                * pending:
> > -                */
> >                 if (!tasklet_trylock(t))
> >                         BUG();
> > -repeat:
> > -               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> > -                       BUG();
> >                 if (!atomic_read(&t->count)) {
> > -                       local_irq_enable();
> > +                       clear_bit(TASKLET_STATE_SCHED, &t->state);
> >                         t->func(t->data);
> > -                       local_irq_disable();
> > -                       /*
> > -                        * One more run if the tasklet got reactivated:
> > -                        */
> > -                       if (test_bit(TASKLET_STATE_SCHED, &t->state))
> > -                               goto repeat;
> > +                       tasklet_unlock(t);
> > +                       continue;
> 
> Here is the key problem area, the reason for this entire patch.

Not the reason for the entire patch, other loops are also in do_softirq
and many other bugs of mainline... but yes this is one of the reason.

> Andrea your fix appears -almost- correct, but it missed a key point: 
> re-running the tasklet in tasklet_action is i/dcache friendly.

I don't think it makes sense to run the same tasklet in loop more than
once. It is more likley it has to do some work ASAP but not immediatly.

> I suggest preserving the original intent of the code (as I interpret
> from the comment), by re-running the tasklet function -once-, if it
> rescheduled itself.
> 
> Comments?

That would be possible, instead of running it only once, we could run
twice and then break the loop to avoid the lockups, but I don't think it
is necessary. But if somebody can raise any real world case where we
need it I can change my mind about it. In all the real world case I can
think of we need the tasklet run very soon, but not immediatly.

Also for example when the cpu is idle ksoftirqd will make sure to keep
banging on the tasklet in loop, it is a not so tight loop inside the
tasklet code, it is a loop caming from do_softirq, but I think that's
not that far away to make a relevant i/dcache difference so I think
current way is just fine and much cleaner and faster for the fast path
than having a magic number of times to run a tasklet before breaking the
loop.

> >                 }
> >                 tasklet_unlock(t);
> > -               if (test_bit(TASKLET_STATE_SCHED, &t->state))
> > -                       tasklet_schedule(t);
> > +
> > +               local_irq_disable();
> > +               t->next = tasklet_vec[cpu].list;
> > +               tasklet_vec[cpu].list = t;
> > +               __cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
> > +               local_irq_enable();
> 
> please create __tasklet_schedule and __tasklet_hi_schedule instead of
> duplicating code here, between local_irq_disable and local_irq_enable.

well there is not that huge code duplication, I was using 2.4.5 code and
it'd better be inline anyways so removing any runtime difference, but I
will be certainly ok if somebody wants to clean it up.

> > -       local_irq_enable();
> >  }
> > 
> > 
> > @@ -193,6 +200,7 @@
> >         local_irq_disable();
> >         list = tasklet_hi_vec[cpu].list;
> >         tasklet_hi_vec[cpu].list = NULL;
> > +       local_irq_enable();
> > 
> >         while (list) {
> >                 struct tasklet_struct *t = list;
> > @@ -201,21 +209,20 @@
> > 
> >                 if (!tasklet_trylock(t))
> >                         BUG();
> > -repeat:
> > -               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> > -                       BUG();
> >                 if (!atomic_read(&t->count)) {
> > -                       local_irq_enable();
> > +                       clear_bit(TASKLET_STATE_SCHED, &t->state);
> >                         t->func(t->data);
> > -                       local_irq_disable();
> > -                       if (test_bit(TASKLET_STATE_SCHED, &t->state))
> > -                               goto repeat;
> > +                       tasklet_unlock(t);
> > +                       continue;
> >                 }
> >                 tasklet_unlock(t);
> > -               if (test_bit(TASKLET_STATE_SCHED, &t->state))
> > -                       tasklet_hi_schedule(t);
> > +
> > +               local_irq_disable();
> > +               t->next = tasklet_hi_vec[cpu].list;
> > +               tasklet_hi_vec[cpu].list = t;
> > +               __cpu_raise_softirq(cpu, HI_SOFTIRQ);
> > +               local_irq_enable();
> 
> this should be __tasklet_hi_schedule call, not inlined duplicate code

same as above.

> 
> 
> > +static int ksoftirqd(void * __bind_cpu)
> > +{
> > +       int bind_cpu = *(int *) __bind_cpu;
> > +       int cpu = cpu_logical_map(bind_cpu);
> > +
> > +       daemonize();
> > +       current->nice = 19;
> > +       sigfillset(&current->blocked);
> > +
> > +       /* Migrate to the right CPU */
> > +       current->cpus_allowed = 1UL << cpu;
> > +       while (smp_processor_id() != cpu)
> > +               schedule();
> > +
> > +       sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
> > +
> > +       __set_current_state(TASK_INTERRUPTIBLE);
> > +       mb();
> > +
> > +       ksoftirqd_task(cpu) = current;
> > +
> > +       for (;;) {
> > +               if (!softirq_pending(cpu))
> > +                       schedule();
> > +
> > +               __set_current_state(TASK_RUNNING);
> > +
> > +               while (softirq_pending(cpu)) {
> > +                       do_softirq();
> > +                       if (current->need_resched)
> > +                               schedule();
> > +               }
> > +
> > +               __set_current_state(TASK_INTERRUPTIBLE);
> > +       }
> > +}
> 
> should there perhaps be a
> 	current->policy |= SCHED_YIELD
> in here, or does setting current->nice make that unnecessary?

when current->need_resched is set we need to schedule, that's a
completly different issue of when we want to release the cpu, when we
want to release the cpu intentionally we use sched_yield instead. the
renice make sure need_resched is set more frequently so we don't spent
too long cpu time there if there's some userspace work to do.

> So basically Andrea's ksoftirq patch indeed appears to fix the infinite
> loop, but IMHO it needs a tiny bit of work...

The tiny bit of work is the cleanup of the tasklet queueing code, that
is duplicated a few times and that has to be left inline, so it is
extremely low prio for me, if nobody sends me a patch I will clean it up
eventually.

Many thanks for auditing the patch, this was a very valuable feedback.

Andrea
