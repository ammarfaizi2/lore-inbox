Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRANAjd>; Sat, 13 Jan 2001 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbRANAjW>; Sat, 13 Jan 2001 19:39:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46029 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129805AbRANAjK>;
	Sat, 13 Jan 2001 19:39:10 -0500
Message-ID: <3A60ED83.1B70410A@mvista.com>
Date: Sat, 13 Jan 2001 16:06:27 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Roger Larsson <roger.larsson@norran.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latency: allowing resheduling while holding spin_locks
In-Reply-To: <Pine.LNX.4.05.10101131335380.10740-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Sat, 13 Jan 2001, Roger Larsson wrote:
> > A rethinking of the rescheduling strategy...
> 
> Actually, I think you have more-or-less described how successful
> preemptible kernels have already been developed, given that your
> "sleeping spin locks" are really just sleeping mutexes (or binary
> semaphores).
> 
> 1.  Short critical regions are protected by spin_lock_irq().  The maximum
> value of "short" is therefore bounded by the maximum time we are happy
> to disable (local) interrupts - ideally ~100us.
> 
> 2.  Longer regions are protected by sleeping mutexes.
> 
> 3.  Algorithms are rearchitected until all of the highly contended locks
> are of type 1, and only low contention locks are of type 2.
> 
> This approach has the advantage that we don't need to use a no-preempt
> count, and test it on exit from every spinlock to see if a preempting
> interrupt that has caused a need_resched has occurred, since we won't
> see the interrupt until it's safe to do the preemptive resched.

I agree that this was true in days of yore.  But these days the irq
instructions introduce serialization points and, me thinks, may be much
more time consuming than the "++, --, if (false)" that a preemption
count implemtation introduces.  Could some one with a knowledge of the
hardware comment on this?

I am not suggesting that the "++, --, if (false)" is faster than an
interrupt, but that it is faster than cli, sti.  Of course we are
assuming that there is <stuff> between the cli and the sti as there is
between the ++ and the -- if (false).

George

> 
> Nigel Gamble                                    nigel@nrg.org
> Mountain View, CA, USA.                         http://www.nrg.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
