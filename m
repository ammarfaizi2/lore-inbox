Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSBIIaC>; Sat, 9 Feb 2002 03:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSBII3x>; Sat, 9 Feb 2002 03:29:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17412 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288667AbSBII3g>; Sat, 9 Feb 2002 03:29:36 -0500
Date: Sat, 9 Feb 2002 09:30:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, Dipankar Sarma <dipankar@in.ibm.com>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
Message-ID: <20020209093019.S10496@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca> <1013212443.806.196.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013212443.806.196.camel@phantasy>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 06:54:02PM -0500, Robert Love wrote:
> On Fri, 2002-02-08 at 18:51, Mark Hahn wrote:
> 
> > yes, but have you evaluated whether it's noticably better than
> > other forms of locking?  for instance, couldn't your dcache example
> > simply use BR locks?
> 
> Good point.
> 
> One of the things with implicit locking schemes like RCU is that the
> performance hit merely shifts.  Reading the data may no longer have any
> overhead, but the hit is taken elsewhere.  One most be careful in
> benchmarking RCU locking.

We're very aware of that. But for example all current users of the
brlock should be converted to RCU and then we can drop the brlock. While
auditing the brlock Paul also identified that the brlock will starve the
writers (I checked and it's true). The brlock (besides it can be starved
by the readers), it can finish with less latency, but the difference of
a few usec/msec really doesn't matter for the very unlikely writer path.

The rule for RCU is very simple: RCU should be used in places like
ulimit -n, or insmod/rmmod so in places where the writer will never ever
run during a benchmark. (race fixes in rmmod, subscribe/unsubscribe of
network families, etc..). If ulimit -n or insmod, rmmod etc.., invokes
an IPI in SMP and they will reschedule in order to complete nobody can
care about that, while you care to be fast during the benchmark.

So RCU should go in (and brlock can go out) IMHO.

However I'm not really convinced it worth to use RCU for anything that
can run during a benchmark (like the dcache eviction). Maybe it could be
acceptable for the routing cache instead, but even in such case I worry
about malicious overflows of the routing cache that could trigger a
constant amount of call_rcu. Alexey should have a look at that to see if
RCU is feasible there. For example if the max frequency of the call_rcu
is 5 seconds that would be probably fine. btw, we can evict thousand of
old entries in one call_rcu invokation.

So personally I'd stay away from using RCU for anything like
dcache/pagecache and other data that may need be collected at a
significant rate during benchmarks (regardless of the fact that an
ad-hoc benchmark in all those cases can show stellar numbers if the
kernel uses RCU, but another kind of benchmark can show a regression).
Furthmore the IPIs have a different cost for each arch, so on differet
archs call_rcu will have different cost, so we shouldn't definitely make
assumptions that consider call_rcu to run in some usec or a few msec.
call_rcu could be considered something that can take 1 second of CPU
time of all the cpus. If any kind of real production workload cannot be
hurted at all by a 1 second long call_rcu overhead in a certain place of
the kernel, that's most certainly a place where RCU must be used ASAP
(ulimit -n, insmod/rmmod etc..).

About the fixed cost of RCU, my last rcu_poll reduced it to 1 single
non locked asm instruction (at zero cacheline cost) per-schedule.
And of course plus some hundred of bytes of ram for the additional
bytecode :), we usually don't even count that. So at the very least it
should definitely payoff big time for every open syscall fdset rwlocks
etc... and it could improve the brlock users and solve some module
unload race. The rcu_poll patch doesn't waste 8k and grow the tasklist
for kernel threads.  With the kernel threads we wouldn't need to poll
during call_rcu, but it would waste some ram, and since call_rcu must be
assumed to be very slow, I think the current implementation is the
preferred one, it has the lower fixed cost. As said as soon as we are ok
to pay for some resource (mostly ram in this case) to make call_rcu as
fast as possible, because we can notice improvements during certain
workloads thanks to a call_rcu optimization, we fallen into the gray
area of usages of RCU technology, that I think should be avoided.

btw, about the patent issues raised in precedence by Alan, they should
be resolved, IBM kindly sent me a my copy of the paperwork and Linus
should have received one too.  thanks again,

Andrea
