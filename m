Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbRE0R5f>; Sun, 27 May 2001 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262847AbRE0R5Y>; Sun, 27 May 2001 13:57:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15138 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262846AbRE0R5Q>; Sun, 27 May 2001 13:57:16 -0400
Date: Sun, 27 May 2001 19:56:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <20010527195619.K676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> <20010527190700.H676@athlon.random> <15121.13986.987230.445825@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15121.13986.987230.445825@pizda.ninka.net>; from davem@redhat.com on Sun, May 27, 2001 at 10:17:22AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 10:17:22AM -0700, David S. Miller wrote:
> I still fail to understand, won't the C code in do_IRQ() handle
> this case as well?  What is so special about returning from an
> interrupt to the idle task on x86?  And what about that special'ness
> makes the code at the end of do_IRQ() magically not run?

Nothing special of course, I don't like making it special infact,
everything is fine and nothing changes unless the underlined check
(part of the softirq patch) doesn't trigger:

	if (active) {
		struct softirq_action *h;

restart:
		/* Reset active bitmask before enabling irqs */
		softirq_active(cpu) &= ~active;

		local_irq_enable();

		h = softirq_vec;
		mask &= ~active;

		do {
			if (active & 1)
				h->action(h);
			h++;
			active >>= 1;
		} while (active);

		local_irq_disable();

		active = softirq_active(cpu);
		if ((active &= mask) != 0)
			goto retry;
	}
	if (softirq_active(cpu) & softirq_mask(cpu)) {
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I mean everything is fine until the same softirq is marked active again
under do_softirq, in such case neither the do_softirq in do_IRQ will
run it (because we are in the critical section and we hold the per-cpu
locks), nor we will run it again ourself from the underlying do_softirq
to avoid live locking into do_softirq.

When the check triggers the ksoftirq patch just wakeup the kernel daemon
so the softirq flood will be balanced by the scheduler, possibly it
could keep running all the time if the machine is idle, like if we would
not mask &= ~active in the do_softirq, but without risks of live locks
because the scheduler will be fair.

	if (softirq_active(cpu) & softirq_mask(cpu)) {
		/*
		 * we cannot loop indefinitely here to avoid userspace starvation,
		 * but we also don't want to introduce a worst case 1/HZ latency
		 * to the pending events, so lets the scheduler to balance
		 * the irq load for us.
		 */
		struct task_struct * tsk = ksoftirqd_task(cpu);
		if (tsk && tsk->state != TASK_RUNNING)
			wake_up_process(tsk);
	}

> Andrea, I think you are talking about a deeper and different problem.

That is the exactly same problem pointed about by Ingo with the idle
task as far I can tell.

If the machine is idle waiting the next interrupt before running the
softirq is even worse because we definitely waste cpu, it's not only a
latency issue in that case, but the problematic is the same if the
machine is loaded and we don't run the softirq again because it was
marked active under us.

Andrea
