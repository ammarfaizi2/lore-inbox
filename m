Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSJRRcA>; Fri, 18 Oct 2002 13:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265331AbSJRR1a>; Fri, 18 Oct 2002 13:27:30 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265325AbSJRRF3>; Fri, 18 Oct 2002 13:05:29 -0400
Date: Fri, 18 Oct 2002 19:11:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: george anzinger <george@mvista.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Message-ID: <20021018171139.GM23930@dualathlon.random>
References: <1034915132.1681.144.camel@cog> <20021018111442.GH16501@dualathlon.random> <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net> <3DB03AB5.99A91B6F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB03AB5.99A91B6F@mvista.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 09:45:41AM -0700, george anzinger wrote:
> Stephen Hemminger wrote:
> > 
> > One reason gettimeofday ends up being important is that several
> > databases call it a lot. They use it to build up a transaction id. Under
> > big transaction loads, even the fast linux syscall path ends up being a
> > bottleneck. Also, on NUMA machines the data used for time of day (xtime)
> > ends up being a significant portion of the cache traffic.
> > 
> > It would be great to rework the whole TSC time of day stuff to work with
> > per cpu data and allow unsychronized TSC's like NUMA. The problem is
> > that for fast user level access, there would need to be some way to find
> > out the current CPU and avoid preemption/migration for a short period.
> > It seems like the LDT stuff for per-thread data could provide the
> > current cpu (and maybe current pid) somehow.  And it would be possible
> > to avoid  preemption while in a vsyscall text page, some other Unix
> > variants do this to implement portions of the thread library in kernel
> > provided user text pages.
> > 
> Now there is an idea!  Lock preemption in user space if and

sounds not good to me, you would miss a wakeup and you would delay the
schedule of 1/HZ in the worst (close to the common) case.

My idea of encoding the cpuid in the top 8bit of each 64bit word that
can be read atomically (of course this trivially applies in the now
per-cpu two sequence numbers that defines the critical section for each
cpu) sounds a way superior solution to me to read coherent per-cpu data
enterely locklessy and without preemption locks.

Andrea
