Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135550AbRALWqy>; Fri, 12 Jan 2001 17:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135609AbRALWqo>; Fri, 12 Jan 2001 17:46:44 -0500
Received: from nrg.org ([216.101.165.106]:43280 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S135550AbRALWqg>;
	Fri, 12 Jan 2001 17:46:36 -0500
Date: Fri, 12 Jan 2001 14:46:29 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andrew Morton <andrewm@uow.edu.au>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A5F0706.6A8A8141@uow.edu.au>
Message-ID: <Pine.LNX.4.05.10101121432270.8988-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Andrew Morton wrote:
> Nigel Gamble wrote:
> > Spinlocks should not be held for lots of time.  This adversely affects
> > SMP scalability as well as latency.  That's why MontaVista's kernel
> > preemption patch uses sleeping mutex locks instead of spinlocks for the
> > long held locks.
> 
> Nigel,
> 
> what worries me about this is the Apache-flock-serialisation saga.
> 
> Back in -test8, kumon@fujitsu demonstrated that changing this:
> 
> 	lock_kernel()
> 	down(sem)
> 	<stuff>
> 	up(sem)
> 	unlock_kernel()
> 
> into this:
> 
> 	down(sem)
> 	<stuff>
> 	up(sem)
> 
> had the effect of *decreasing* Apache's maximum connection rate
> on an 8-way from ~5,000 connections/sec to ~2,000 conn/sec.
> 
> That's downright scary.
> 
> Obviously, <stuff> was very quick, and the CPUs were passing through
> this section at a great rate.

Yes, this demonstrates that spinlocks are preferable to sleep locks for
short sections.  However, it looks to me like the implementation of up()
may be partly to blame.  It looks to me as if it tends to prefer to
context switch to the woken up process, instead of continuing to run the
current process.  Surrounding the semaphore with the BKL has the effect
of enforcing the latter behavior, because the semaphore itself will
never have any waiters.

> How can we be sure that converting spinlocks to semaphores
> won't do the same thing?  Perhaps for workloads which we
> aren't testing?
> 
> So this needs to be done with caution.
> 
> As davem points out, now we know where the problems are
> occurring, a good next step is to redesign some of those
> parts of the VM and buffercache.  I don't think this will
> be too hard, but they have to *want* to change :)

Yes, wherever the code can be redesigned to avoid long held locks, that
would definitely be my preferred solution.  I think everyone would be
happy if we could end up with a maintainable solution using only
spinlocks that are held for no longer than a couple of hundred
microseconds.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
