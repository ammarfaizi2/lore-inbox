Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131217AbRCGWO6>; Wed, 7 Mar 2001 17:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131218AbRCGWOt>; Wed, 7 Mar 2001 17:14:49 -0500
Received: from [209.102.105.34] ([209.102.105.34]:22789 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131217AbRCGWOp>;
	Wed, 7 Mar 2001 17:14:45 -0500
Date: Wed, 7 Mar 2001 14:13:21 -0800
From: Tim Wright <timw@splhi.com>
To: Jeff Dike <jdike@karaya.com>
Cc: timw@splhi.com, Jonathan Lahr <lahr@sequent.com>,
        Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010307141321.B1254@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Jeff Dike <jdike@karaya.com>, timw@splhi.com,
	Jonathan Lahr <lahr@sequent.com>,
	Anton Blanchard <anton@linuxcare.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010306162818.A1095@kochanski.internal.splhi.com> <200103070312.WAA04661@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103070312.WAA04661@ccure.karaya.com>; from jdike@karaya.com on Tue, Mar 06, 2001 at 10:12:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 10:12:17PM -0500, Jeff Dike wrote:
> timw@splhi.com said:
> > If you're a UP system, it never makes sense to spin in userland, since
> > you'll just burn up a timeslice and prevent the lock holder from
> > running. I haven't looked, but assume that their code only uses
> > spinlocks on SMP. If you're an SMP system, then you shouldn't be using
> > a spinlock unless the critical section is "short", in which case the
> > waiters should simply spin in userland rather than making system calls
> > which is simply overhead.
> 
> This is a problem that UML is going to have when I turn SMP back on.  
> Emulating a multiprocessor box on a UP host with the existing locking 
> primitives is going to result in exactly this problem.
> 

Yes. On a uniprocessor system, a simple fallback is to just use a semaphore
instead of a spinlock, since you can guarantee that there's no point in
scheduling the current task until the holder of the "lock" releases it.
Otherwise, the spin calling sched_yield() each iteration isn't too horrible.

> > Actually, what's really needed here is an efficient form of
> > dynamically marking a process as non-preemptible so that when
> > acquiring a spinlock the process can ensure that it exits the critical
> > section as fast as possible, when it would relinquish its
> > non-preemptible privilege.
> 
> That sounds like a pretty fundamental (and abusable) mechanism.
> 

It would be if it were generally available. The implementation on DYNIX/ptx
requires a privilege (PRIV_SCHED IIRC), to be able to use it. It was added
for a database to prevent preemption during critical sections.

> I had a suggestion from an IBM guy at ALS last year to make UML "spin"-locks 
> actually sleep in the host (this doesn't make them sleep locks in userspace 
> because they don't call schedule), which sounds reasonable.  This gives the 
> lock-holder an opportunity to run immediately.  It's unclear to me what the 
> wake-up mechanism would be, though.
> 

Hmmm.. depends what you mean by sleep i.e sleep(3) vs. making a system call
that sleeps. I would have thought the latter, and use semaphores again.

> Another thought I had was to raise the priority of a thread holding a 
> spinlock.  This would reduce the chance that it would be preempted by a thread 
> that will waste a timeslice spinning on that lock.  I don't know whether this 
> is a good idea either.
> 

That's basically a weaker version of the no-preempt. Not a bad idea, but
less than optimal :-)

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
