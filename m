Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131367AbQL0DXC>; Tue, 26 Dec 2000 22:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbQL0DWn>; Tue, 26 Dec 2000 22:22:43 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:33012 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131208AbQL0DWe>; Tue, 26 Dec 2000 22:22:34 -0500
Message-ID: <3A495A88.D44D19E6@uow.edu.au>
Date: Wed, 27 Dec 2000 13:57:12 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>,
		<3A4937D2.B7FE7C28@uow.edu.au>; from andrewm@uow.edu.au on Wed, Dec 27, 2000 at 11:29:06AM +1100 <20001227033459.A29610@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Dec 27, 2000 at 11:29:06AM +1100, Andrew Morton wrote:
> > - Got rid of all the debugging ifdefs - these have been folded into
> >   wait.h
> 
> Why? Such debugging code is just disabled so it doesn't get compiled in, but if
> somebody wants he can enable it changing the #define in the sources to catch
> missing initialization of the waitqueue. I disagree in removing it.

Oh, it's all still there, but it's now all in the header file:

#ifdef DEBUG
#define foo() printk(stuff)
#else
#define foo()
#endif

> > - Removed all the USE_RW_WAIT_QUEUE_SPINLOCK code and just used
> >   spinlocks.
> >
> >   The read_lock option was pretty questionable anyway.  It hasn't had
> >   the widespread testing and, umm, the kernel is using wq_write_lock
> >   *everywhere* anyway, so enabling USE_RW_WAIT_QUEUE_SPINLOCK wouldn't
> >   change anything, except for using a more expensive spinlock!
> >
> >   So it's gone.
> 
> It's true that wake_up_process doesn't scale, but O(N) scans of the waitqueue
> could be imposed by the smp-irq-wakeup logic if there's no CPU affine task
> registered, so it makes sense at least in theory. Of course right now it can
> only hurt because as you say wake_up is using the write_lock too. But I'd
> prefer not to drop it since it become safe (no wake-one missed event) once we
> fix all the wake-one races checking the wake_up_process retval, so I'd suggest
> to use the wq_read_lock in browse of the waitqueue instead of removing
> wq_*_lock.

OK.

> > - Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
> >   be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
> >   are a few examples in __wake_up_common().
> >
> >   People shouldn't go wild with this, because gcc's dead code
> >   elimination isn't perfect.  But it's nice for little things.
> 
> I think the main issue is that SMP_KERNEL isn't complete and I'm not sure if it
> really helps readability to increase the ways to write smp-compile-time code.
> For example in your example you probably get complains about unitialized
> variables in the UP compile, then I think it's nicer not to rely on gcc for the
> reasons you said. The fact the thing is little is not much relevant if gcc gets
> it wrong (however I believe gcc will get it right) because the little thing
> could be in a fast path like in the example usage in wake_up().

No, gcc doesn't give any warnings about uninitialised vars.  It _could_
give warnings about unused ones, but doesn't.

> > - This patch's _use_ of SMP_KERNEL in __wake_up_common is fairly
> >   significant.  There was quite a lot of code in that function which
> >   was an unnecessary burden for UP systems.  All gone now.
> 
> The same could be achived with the usual #ifdef CONFIG_SMP of course ;).
> 
> > - I have finally had enough of printk() deadlocking or going
> >   infinitely mutually recursive on me so printk()'s wake_up(log_wait)
> >   call has been moved into a tq_timer callback.
> 
> That's only overhead for mainstream kernel. Nobody is allowed to call printk
> from wake_up(). For debugging wake_up() the above hack is fine of course (but
> that is stuff for a debugging tree not for the mainstream one). Or at least
> it should be put inside an #ifdef DEBUG or something like that.

It's not just open-coded printks - it's oopses.  If you take an oops or a
BUG or a panic within wake_up() or _anywhere_ with the runqueue_lock held,
the machine deadlocks and you don't get any diagnostics.  This is bad.

We really do need to get that wake_up() out of printk().  tq_timer may
not be the best way.  Suggestions welcome.

> > - SLEEP_ON_VAR, SLEEP_ON_HEAD and SLEEP_ON_TAIL have been changed.  I
> >   see no valid reason why these functions were, effectively, doing
> >   this:
> >
> >       spin_lock_irqsave(lock, flags);
> >       spin_unlock(lock);
> >       schedule();
> >       spin_lock(lock);
> >       spin_unlock_irqrestore(lock, flags);
> >
> >   What's the point in saving the interrupt status in `flags'? If the
> 
> Because old drivers could be doing ugly stuff like this:
> 
>         cli()
>         for (;;) {
>                 if (!resource_available)
>                         sleep_on(&wait_for_resource)
>                 else
>                         break
>         }
>         ...
>         sti()
> 
> If you don't save and restore flags the second sleep_on could be entered with
> irq enabled and the wakeup from irq could happen before registering in the
> waitqueue causing a lost wakeup.
> 
> Maybe none driver is doing the above, but I think there's no point to
> microoptimize sleep_on by breaking horrible [but currently safe] usages like
> the above one at runtime, because if the driver cares about performance it
> wasn't using sleep_on since the first place ;). The right way to optimize the
> code is to remove sleep_on_*, that wouldn't risk to break stuff silenty at
> runtime. I believe it's a 2.5.x item (I really don't recommend to drop sleep_on
> right now for 2.4.x).

OK, I'll put it back. Thanks.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
