Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCGA3w>; Tue, 6 Mar 2001 19:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRCGA3m>; Tue, 6 Mar 2001 19:29:42 -0500
Received: from [209.102.105.34] ([209.102.105.34]:44044 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129740AbRCGA3b>;
	Tue, 6 Mar 2001 19:29:31 -0500
Date: Tue, 6 Mar 2001 16:28:18 -0800
From: Tim Wright <timw@splhi.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: Jonathan Lahr <lahr@sequent.com>, Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010306162818.A1095@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Matthew Kirkwood <matthew@hairy.beasts.org>,
	Jonathan Lahr <lahr@sequent.com>,
	Anton Blanchard <anton@linuxcare.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010306144552.G6451@w-lahr.des.sequent.com> <Pine.LNX.4.10.10103062318190.26554-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103062318190.26554-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Tue, Mar 06, 2001 at 11:39:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 11:39:17PM +0000, Matthew Kirkwood wrote:
> On Tue, 6 Mar 2001, Jonathan Lahr wrote:
> 
> [ sorry to reply over another reply, but I don't have
>   the original of this ]
> 
> > > Tridge and I tried out the postgresql benchmark you used here and this
> > > contention is due to a bug in postgres. From a quick strace, we found
> > > the threads do a load of select(0, NULL, NULL, NULL, {0,0}).
> 
> I can shed some light on this (though I'm far from a PG hacker).
> 
> Postgres can use either of two locking methods -- SysV semaphores
> (which it tries to avoid, asusming that they'll be too heavy) or
> userspace spinlocks (via inline assembler on platforms which support
> it).
> 
> In the slow path of a spinlock_acquire they busy wait for a few
> cycles, and then call schedule with a zero timeout assuming that
> it'll basically do the same as a sched_yield() but more portably.
> 

Ugh !
I had a nasty feeling that might be what they were up to. The reason for
the "ugh" is as follows. If you're a UP system, it never makes sense to
spin in userland, since you'll just burn up a timeslice and prevent the
lock holder from running. I haven't looked, but assume that their code only
uses spinlocks on SMP. If you're an SMP system, then you shouldn't be
using a spinlock unless the critical section is "short", in which case the 
waiters should simply spin in userland rather than making system calls which
is simply overhead. If the argument is that the "spinners" take too much
useful time away from other processes, then it sounds like the contention is
too high, or that the critical section is sufficiently long that semaphores
would be a better choice.

Actually, what's really needed here is an efficient form of dynamically
marking a process as non-preemptible so that when acquiring a spinlock the
process can ensure that it exits the critical section as fast as possible,
when it would relinquish its non-preemptible privilege.

Another synchronization method popular with database peeps is "post/wait"
for which SGI have a patch available for Linux. I understand that this is
relatively "light weight" and might be a better choice for PG.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
