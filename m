Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276962AbRJHPrq>; Mon, 8 Oct 2001 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276958AbRJHPrg>; Mon, 8 Oct 2001 11:47:36 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:46095 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S276953AbRJHPr1>;
	Mon, 8 Oct 2001 11:47:27 -0400
Date: Mon, 8 Oct 2001 09:42:41 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
Message-ID: <20011008094241.A16396@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1itdqw4hu.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 09:11:57AM -0600, Eric W. Biederman wrote:
> > IF the kernel becomes preemptible it will be so slow, so buggy, and so painful
> > to maintain, that those issues won't matter.
> 
> The preemptible kernel work just takes the current SMP code, and
> allows it to work on a single processor.  You are not interruptted if
> you have a lock held.  This makes the number of cases in the kernel
> simpler, and should improve maintenance as more people will be
> affected by the SMP issues.

i.e. "since we are already committed to making the kernel more complex, slower, and
      harder to maintain, there is no problem ... "
> 
> Right now there is a preemptible kernel patch being maintained
> somewhere.  I haven't had a chance to look recently.  But the recent
> threads on low latency mentioned it.

Try it out. Try running a kernel compile while a POSIX SCHED_FIFO process
is running.

> As for rules.  They are the usual SMP rules.  In earlier version there
> was a requirement or that you used balanced constructs.

I'm sorry, but this is not correct.   SMP is different from low-latency and
has different goals. You certainly can piggyback low-latency of a sort on 
on the finer-grained locking you get from SMP support, but if you optimize
a kernel for SMP support you don't necessarily look at the same lock issues 
as you would if your goal was to reduce latency. E.g. for SMP a design like

	each processor maintains a local cache of resource X. Getting X from
	the local cache takes 100ns and only local locking.

	there is a slow and expensive spin locked central resource for X
	used to replenish local caches. Getting X from the central resource
	takes 1 second.

	Cache success rate is over 99.99%.

With 10000 accesses to X, total time is 1.01 seconds for an average of 100 microseconds and this
is overstating the case, for most processes never see the 1second delay and average 
100ns per access. 

But worst case is 1 second!

If you were to design for low latency, you'd prefer the design

	an elaborate resource control mechanism allows all processors to 
	share X and get X resources within 1 millisecond.

1000 times better latency, 10000 times worse average case. 

You cannot escape a tradeoff by pretending it's not there.

Look we handle this all the time in RTLinux: we have to throw away heartbreakingly
beautiful solutions because worst case numbers are bad. 




	

	
