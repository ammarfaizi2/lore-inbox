Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132461AbRALWbL>; Fri, 12 Jan 2001 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135542AbRALWbA>; Fri, 12 Jan 2001 17:31:00 -0500
Received: from nrg.org ([216.101.165.106]:19216 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132461AbRALWao>;
	Fri, 12 Jan 2001 17:30:44 -0500
Date: Fri, 12 Jan 2001 14:30:22 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Tim Wright <timw@splhi.com>
cc: Andrew Morton <andrewm@uow.edu.au>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <20010112071150.A1653@scutter.internal.splhi.com>
Message-ID: <Pine.LNX.4.05.10101121428380.8988-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Tim Wright wrote:

> On Sat, Jan 13, 2001 at 12:30:46AM +1100, Andrew Morton wrote:
> > what worries me about this is the Apache-flock-serialisation saga.
> > 
> > Back in -test8, kumon@fujitsu demonstrated that changing this:
> > 
> > 	lock_kernel()
> > 	down(sem)
> > 	<stuff>
> > 	up(sem)
> > 	unlock_kernel()
> > 
> > into this:
> > 
> > 	down(sem)
> > 	<stuff>
> > 	up(sem)
> > 
> > had the effect of *decreasing* Apache's maximum connection rate
> > on an 8-way from ~5,000 connections/sec to ~2,000 conn/sec.
> > 
> > That's downright scary.
> > 
> > Obviously, <stuff> was very quick, and the CPUs were passing through
> > this section at a great rate.
> > 
> > How can we be sure that converting spinlocks to semaphores
> > won't do the same thing?  Perhaps for workloads which we
> > aren't testing?
> > 
> > So this needs to be done with caution.
> > 
> 
> Hmmm...
> if <stuff> is very quick, and is guaranteed not to sleep, then a semaphore
> is the wrong way to protect it. A spinlock is the correct choice. If it's
> always slow, and can sleep, then a semaphore makes more sense, although if
> it's highly contented, you're going to serialize and throughput will die.
> At that point, you need to redesign :-)
> If it's mostly quick but occasionally needs to sleep, I don't know what the
> correct idiom would be in Linux. DYNIX/ptx has the concept of atomically
> releasing a spinlock and going to sleep on a semaphore, and that would be
> the solution there e.g.
> 
> p_lock(lock);
> retry:
> ...
> if (condition where we need to sleep) {
>     p_sema_v_lock(sema, lock);
>     /* we got woken up */
>     p_lock(lock);
>     goto retry;
> }
> ...
> 
> I'm stating the obvious here, and re-iterating what you said, and that is that
> we need to carefully pick the correct primitive for the job. Unless there's
> something very unusual in the Linux implementation that I've missed, a
> spinlock is a "cheaper" method of protecting a short critical section, and
> should be chosen.
> 
> I know the BKL is a semantically a little unusual (the automatic release on
> sleep stuff), but even so, isn't
> 
>  	lock_kernel()
>  	down(sem)
>  	<stuff>
>  	up(sem)
>  	unlock_kernel()
> 
> actually equivalent to
> 
> 	lock_kernel()
> 	<stuff>
> 	unlock_kernel()
> 
> If so, it's no great surprise that performance dropped given that we replaced
> a spinlock (albeit one guarding somewhat more than the critical section) with
> a semaphore.
> 
> Tim
> 
> --
> Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
> IBM Linux Technology Center, Beaverton, Oregon
> "Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
> 

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
