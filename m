Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKIScc>; Thu, 9 Nov 2000 13:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKIScW>; Thu, 9 Nov 2000 13:32:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129091AbQKIScQ>; Thu, 9 Nov 2000 13:32:16 -0500
Date: Thu, 9 Nov 2000 10:31:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Jens Axboe <axboe@suse.de>, MOLNAR Ingo <mingo@chiara.elte.hu>,
        Rik van Riel <H.H.vanRiel@phys.uu.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
In-Reply-To: <Pine.Linu.4.10.10011091452270.747-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10011091005390.1909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As to the real reason for stalls on /proc/<pid>/stat, I bet it has nothing
to do with IO except indirectly (the IO is necessary to trigger the
problem, but the _reason_ for the problem lies elsewhere).

And it has everything to do with the fact that the way Linux semaphores
are implemented, a non-blocking process has a HUGE advantage over a
blocking one. Linux kernel semaphores are extreme unfair in that way.

What happens is that some process is getting a lot of VM faults and gets
its VM semaphore. No contention yet. it holds the semaphore over the
IO, and now another process does a "ps".

The "ps" process goes to sleep on the semaphore. So far so good.

The original process releases the semaphore, which increments the count,
and wakes up the process waiting for it. Note that it _wakes_ it, it does
not give the semaphore to it. Big difference.

The process that got woken up will run eventually. Probably not all that
immediately, because the process that woke it (and held the semaphore)
just slept on a page fault too, so it's not likely to immediately
relinquish the CPU.

The original running process comes back faulting again, finds the
semaphore still unlocked (the "ps" process is awake but has not gotten to
run yet), gets the semaphore, and falls asleep on the IO for the next
page.

The "ps" process actually gets to run now, but it's a bit late. The
semaphore is locked again. 

Repeat until luck breaks the bad circle.

(This schenario, btw, is much harder to trigger on SMP than on UP. And
it's completely separate from the issue of simple disk bandwidth issues
which can obviously cause no end of stalls on anything that needs the
disk, and which can also happen on SMP).

NOTE! If somebody wants to fix this, the fix should be reasonably simple
but needs to be quite exhaustively checked and double-checked. It's just
too easy to break the semaphores by mistake.

The way to make semaphores more fair is to NOT allow a new process to just
come in immediately and steal the semaphore in __down() if there are other
sleepers. This is most easily accomplished by something along the lines of
the following in __down() in arch/i386/kernel/semaphore.c 

	spin_lock_irq(&semaphore_lock);
	sem->sleepers++;
+
+	/*
+	 * Are there other people waiting for this?
+	 * They get to go first.
+	 */
+	if (sleepers > 1)
+		goto inside;
	for (;;) {
                int sleepers = sem->sleepers;

                /*
                 * Add "everybody else" into it. They aren't
                 * playing, because we own the spinlock.
                 */
                if (!atomic_add_negative(sleepers - 1, &sem->count)) {
                        sem->sleepers = 0;
                        break;
                }
                sem->sleepers = 1;      /* us - see -1 above */
+inside:
                spin_unlock_irq(&semaphore_lock);
                schedule();
                tsk->state = TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE;
                spin_lock_irq(&semaphore_lock);
        }
        spin_unlock_irq(&semaphore_lock);

But note that teh above is UNTESTED and also note that from a throughput
(as opposed to latency) standpoint being unfair tends to be nice.

Anybody want to try out something like the above? (And no, I'm not
applying it to my tree yet. It needs about a hundred pairs of eyes to
verify that there isn't some subtle "lost wakeup" race somewhere).

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
