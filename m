Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131981AbQL0DHS>; Tue, 26 Dec 2000 22:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQL0DHJ>; Tue, 26 Dec 2000 22:07:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33076 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131981AbQL0DHF>; Tue, 26 Dec 2000 22:07:05 -0500
Date: Wed, 27 Dec 2000 03:34:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
Message-ID: <20001227033459.A29610@athlon.random>
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>; from andrewm@uow.edu.au on Wed, Dec 27, 2000 at 11:29:06AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 11:29:06AM +1100, Andrew Morton wrote:
> - Got rid of all the debugging ifdefs - these have been folded into
>   wait.h

Why? Such debugging code is just disabled so it doesn't get compiled in, but if
somebody wants he can enable it changing the #define in the sources to catch
missing initialization of the waitqueue. I disagree in removing it.

> - Removed all the USE_RW_WAIT_QUEUE_SPINLOCK code and just used
>   spinlocks.
> 
>   The read_lock option was pretty questionable anyway.  It hasn't had
>   the widespread testing and, umm, the kernel is using wq_write_lock
>   *everywhere* anyway, so enabling USE_RW_WAIT_QUEUE_SPINLOCK wouldn't
>   change anything, except for using a more expensive spinlock!
> 
>   So it's gone.

It's true that wake_up_process doesn't scale, but O(N) scans of the waitqueue
could be imposed by the smp-irq-wakeup logic if there's no CPU affine task
registered, so it makes sense at least in theory. Of course right now it can
only hurt because as you say wake_up is using the write_lock too. But I'd
prefer not to drop it since it become safe (no wake-one missed event) once we
fix all the wake-one races checking the wake_up_process retval, so I'd suggest
to use the wq_read_lock in browse of the waitqueue instead of removing
wq_*_lock.

> - Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
>   be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
>   are a few examples in __wake_up_common().
> 
>   People shouldn't go wild with this, because gcc's dead code
>   elimination isn't perfect.  But it's nice for little things.

I think the main issue is that SMP_KERNEL isn't complete and I'm not sure if it
really helps readability to increase the ways to write smp-compile-time code.
For example in your example you probably get complains about unitialized
variables in the UP compile, then I think it's nicer not to rely on gcc for the
reasons you said. The fact the thing is little is not much relevant if gcc gets
it wrong (however I believe gcc will get it right) because the little thing
could be in a fast path like in the example usage in wake_up().

> - This patch's _use_ of SMP_KERNEL in __wake_up_common is fairly
>   significant.  There was quite a lot of code in that function which
>   was an unnecessary burden for UP systems.  All gone now.

The same could be achived with the usual #ifdef CONFIG_SMP of course ;).

> - I have finally had enough of printk() deadlocking or going
>   infinitely mutually recursive on me so printk()'s wake_up(log_wait)
>   call has been moved into a tq_timer callback.

That's only overhead for mainstream kernel. Nobody is allowed to call printk
from wake_up(). For debugging wake_up() the above hack is fine of course (but
that is stuff for a debugging tree not for the mainstream one). Or at least
it should be put inside an #ifdef DEBUG or something like that.

> - SLEEP_ON_VAR, SLEEP_ON_HEAD and SLEEP_ON_TAIL have been changed.  I
>   see no valid reason why these functions were, effectively, doing
>   this:
> 
> 	spin_lock_irqsave(lock, flags);
> 	spin_unlock(lock);
> 	schedule();
> 	spin_lock(lock);
> 	spin_unlock_irqrestore(lock, flags);
> 
>   What's the point in saving the interrupt status in `flags'? If the

Because old drivers could be doing ugly stuff like this:

	cli()
	for (;;) {
		if (!resource_available)
			sleep_on(&wait_for_resource)
		else
			break
	}
	...
	sti()

If you don't save and restore flags the second sleep_on could be entered with
irq enabled and the wakeup from irq could happen before registering in the
waitqueue causing a lost wakeup.

Maybe none driver is doing the above, but I think there's no point to
microoptimize sleep_on by breaking horrible [but currently safe] usages like
the above one at runtime, because if the driver cares about performance it
wasn't using sleep_on since the first place ;). The right way to optimize the
code is to remove sleep_on_*, that wouldn't risk to break stuff silenty at
runtime. I believe it's a 2.5.x item (I really don't recommend to drop sleep_on
right now for 2.4.x).

The patch is mostly ok IMHO, but I'd prefer if you could you rework it so that
it only fixes the race by checking the wake_up_process* retval plus the UP
cleanups in wake_up using the legacy #ifdef CONFIG_SMP way.

Thanks!

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
