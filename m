Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQL0WDD>; Wed, 27 Dec 2000 17:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQL0WCx>; Wed, 27 Dec 2000 17:02:53 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:33811 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129732AbQL0WCi>; Wed, 27 Dec 2000 17:02:38 -0500
Message-ID: <3A4A5FA1.DE13B803@mvista.com>
Date: Wed, 27 Dec 2000 13:31:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> It's been quiet around here lately...
> 
> This is a rework of the 2.4 wakeup code based on the discussions Andrea
> and I had last week.  There were two basic problems:
> 
> - If two tasks are on a waitqueue in exclusive mode and one gets
>   woken, it will put itself back into TASK_[UN]INTERRUPTIBLE state for a
>   few instructions and can soak up another wakeup which should have
>   gone to the other task.
> 
> - If a task is on two waitqueues and two CPUs simultaneously run a
>   wakeup, one on each waitqueue, they can both try to wake the same
>   task which may be a lost wakeup, depending upon how the waitqueue
>   users are coded.
> 
> The first problem is the most serious.  The second is kinda baroque...
> 
> The approach taken by this patch is the one which Andrea is proposing
> for 2.2: if a task was already on the runqueue, continue scanning for
> another exclusive task to wake up.
> 
> It ended up getting complicated because of the "find a process affine
> to this CPU" thing.  Plus I did go slightly berzerk, but I believe the
> result is pretty good.
> 
> - wake_up_process() now returns a success value if it managed to move
>   something to the runqueue.
> 
>   Tidied up the code here a bit as well.
> 
>   wake_up_process_synchronous() is no more.
> 
> - Got rid of all the debugging ifdefs - these have been folded into
>   wait.h
> 
> - Removed all the USE_RW_WAIT_QUEUE_SPINLOCK code and just used
>   spinlocks.
> 
>   The read_lock option was pretty questionable anyway.  It hasn't had
>   the widespread testing and, umm, the kernel is using wq_write_lock
>   *everywhere* anyway, so enabling USE_RW_WAIT_QUEUE_SPINLOCK wouldn't
>   change anything, except for using a more expensive spinlock!
> 
>   So it's gone.
> 
> - Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
>   be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
>   are a few examples in __wake_up_common().
> 
>   People shouldn't go wild with this, because gcc's dead code
>   elimination isn't perfect.  But it's nice for little things.
> 
> - This patch's _use_ of SMP_KERNEL in __wake_up_common is fairly
>   significant.  There was quite a lot of code in that function which
>   was an unnecessary burden for UP systems.  All gone now.
> 
> - This patch shrinks sched.o by 100 bytes (SMP) and 300 bytes (UP).
>   Note that try_to_wake_up() is now only expanded in a single place
>   in __wake_up_common().  It has a large footprint.
> 
> - I have finally had enough of printk() deadlocking or going
>   infinitely mutually recursive on me so printk()'s wake_up(log_wait)
>   call has been moved into a tq_timer callback.
> 
> - SLEEP_ON_VAR, SLEEP_ON_HEAD and SLEEP_ON_TAIL have been changed.  I
>   see no valid reason why these functions were, effectively, doing
>   this:
> 
>         spin_lock_irqsave(lock, flags);
>         spin_unlock(lock);
>         schedule();
>         spin_lock(lock);
>         spin_unlock_irqrestore(lock, flags);
> 
>   What's the point in saving the interrupt status in `flags'? If the
>   caller _wants_ interrupt status preserved then the caller is buggy,
>   because schedule() enables interrupts.  2.2 does the same thing.
> 
>   So this has been changed to:
> 
>         spin_lock_irq(lock);
>         spin_unlock(lock);
>         schedule();
>         spin_lock(lock);
>         spin_unlock_irq(lock);
> 
>   Or did I miss something?
> 

Um, well, here is a consideration.  For preemption work it is desirable
to not burden the xxx_lock_irq(y) code with preemption locks, as the irq
effectively does this for far less cost.  The problem is code like this
that does not pair the xxx_lock_irq(y) with a xxx_unlock_irq(y).  The
worst offenders are bits of code that do something like:

spin_lock_irq(y);
  :
sti();
  :
spin_unlock(y);

(Yes, this does happen!)

I suspect that most of this has good reason behind it, but for the
preemptive effort it would be nice to introduce a set of macros like:

xxxx_unlock_noirq()  which would acknowledge that the lock used irq but
the unlock is not.  And for the above case:

xxx_lock_noirq()  which would acknowledge that the irq "lock" is already
held.

Oh, and my reading of sched.c seems to indicate that interrupts are on
at schedule() return (or at least, related to the task being switch out
and not the new task) so the final spin_unlock_irq(lock) above should
not be changing the interrupt state.  (This argument is lost in the
driver issue that Andrea points out, of course.)

Or did I miss something?

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
