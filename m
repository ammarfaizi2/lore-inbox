Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAMV4j>; Sat, 13 Jan 2001 16:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAMV43>; Sat, 13 Jan 2001 16:56:29 -0500
Received: from nrg.org ([216.101.165.106]:41282 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129523AbRAMV4X>;
	Sat, 13 Jan 2001 16:56:23 -0500
Date: Sat, 13 Jan 2001 13:56:18 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Roger Larsson <roger.larsson@norran.net>
cc: george anzinger <george@mvista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latency: allowing resheduling while holding spin_locks
In-Reply-To: <01011315231600.01469@dox>
Message-ID: <Pine.LNX.4.05.10101131335380.10740-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Roger Larsson wrote:
> A rethinking of the rescheduling strategy...

Actually, I think you have more-or-less described how successful
preemptible kernels have already been developed, given that your
"sleeping spin locks" are really just sleeping mutexes (or binary
semaphores).

1.  Short critical regions are protected by spin_lock_irq().  The maximum
value of "short" is therefore bounded by the maximum time we are happy
to disable (local) interrupts - ideally ~100us.

2.  Longer regions are protected by sleeping mutexes.

3.  Algorithms are rearchitected until all of the highly contended locks
are of type 1, and only low contention locks are of type 2.

This approach has the advantage that we don't need to use a no-preempt
count, and test it on exit from every spinlock to see if a preempting
interrupt that has caused a need_resched has occurred, since we won't
see the interrupt until it's safe to do the preemptive resched.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
