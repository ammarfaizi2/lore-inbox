Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbSJRRjn>; Fri, 18 Oct 2002 13:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265282AbSJRR1U>; Fri, 18 Oct 2002 13:27:20 -0400
Received: from [195.223.140.120] ([195.223.140.120]:46199 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265279AbSJRQzO>; Fri, 18 Oct 2002 12:55:14 -0400
Date: Fri, 18 Oct 2002 19:01:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Message-ID: <20021018170116.GK23930@dualathlon.random>
References: <1034915132.1681.144.camel@cog> <20021018111442.GH16501@dualathlon.random> <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 09:13:39AM -0700, Stephen Hemminger wrote:
> One reason gettimeofday ends up being important is that several
> databases call it a lot. They use it to build up a transaction id. Under
> big transaction loads, even the fast linux syscall path ends up being a
> bottleneck. Also, on NUMA machines the data used for time of day (xtime)
> ends up being a significant portion of the cache traffic.

Yep. However the main bottleneck is to go inside/outside the kernel, the
xtime is one l1 cacheline readonly that can be trivially shared under
high load. I would be surprised if that was the bottleneck, today you
should see an huge bottleneck in the xtime_lock before you can remotely
see a bottleneck in xtime data itself. (I'm speaking HZ=100 at least,
HZ=1000 would hurt more here)

> It would be great to rework the whole TSC time of day stuff to work with
> per cpu data and allow unsychronized TSC's like NUMA. The problem is
> that for fast user level access, there would need to be some way to find
> out the current CPU and avoid preemption/migration for a short period.
> It seems like the LDT stuff for per-thread data could provide the
> current cpu (and maybe current pid) somehow.  And it would be possible
> to avoid  preemption while in a vsyscall text page, some other Unix
> variants do this to implement portions of the thread library in kernel
> provided user text pages.

actually my idea on 64bit was to use the high 8 bit of each 64bit word to
give you the cpuid, to get out the coherent data, including the sequence
number that are read and written inversely with mb() like now (the
sequence number as well will become per-cpu), so it is definitely doable
without any single problem and in a very performant way, just not as
easy as without the per-cpu info. Even if segmentation per-cpu tricks
would be possible or available (remeber long mode is pure paging, no
segmentation) it would be not worthwhile IMHO, the cpuid encoded
atomically in each 64bit data provided by the vsyscall seems a much
simpler and possibly more performant solution. You set a different
per-cpu data-mapping with different pte settings in each cpu. The
vsyscall bytecode remains the same, aware about this cpuid encoded in
each 64bit word. Doing it in 32bit is ugly (or at least much slower)
since most data is natively at least 32bit, it would need some slow
demultiplexing.

Andrea
