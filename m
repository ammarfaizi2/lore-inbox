Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292905AbSCIUTA>; Sat, 9 Mar 2002 15:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292907AbSCIUSw>; Sat, 9 Mar 2002 15:18:52 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:34215 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292905AbSCIUSb>; Sat, 9 Mar 2002 15:18:31 -0500
Date: Sat, 09 Mar 2002 12:19:13 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <135154151.1015676353@[10.10.2.3]>
In-Reply-To: <200203092044.43456.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200203092044.43456.Dieter.Nuetzel@hamburg.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [-]
> Planned work next:
> 
> 1. Try John Stultz's mcslocks 
>         (note high max wait vs low max hold currently)
> 2. Try rmap + pagemap_lru_breakup from Arjan
> 3. Try radix tree pagecache.
> 4. Try grafting NUMA-Q page local alloc onto -aa tree
> 5. Try SGI NUMA zone ordering stuff.
> 6. [HARD] Break up ZONE_NORMAL between nodes 
>    (all currently on node 0).
> [-]
> 
> No flamewar intended, but shouldn't you start with 4. and 5.?
> -aa is the way to go for the 2.4.18+ tree. 

The ordering reflects both the difficulty of doing it, and
the expected payoff. For instance, I expect the mcslocks to
be dead easy to install, and give a reasonable payoff.

I tried (2) this morning, deadlocks during boot. I'll look
at fixing it, but it'll move down my list because it's now
harder ;-)

(6) would be a good thing to do - at the moment the page
structs for all nodes sit on node 0. The interconnect has 
caches on it, so this isn't as bad as it sounds. But I 
expect changing the assumption that ZONE_NORMAL == phys < 896Mb  
to cause some pain. 

> -rmap later for 2.5.x.

rmap has the huge advantage that it's much easier to split
up the pagemap_lru_lock per zone, do per node kswapd without
much remote referencing, etc. Remeber this is NUMA with a
remote:local mem latency of 10:1 to 20:1. Non-local access
hurts. If we can fix some of the scaling problems with rmap,
I expect that to be the real way to fix some of the harder
"global stuff is bad" problems.

> Have you tried the OOM case?
> vm_29 and before fixed it for me.
> Throughput is much improved with -aa.

I've not tried OOM really. The problem with porting to the
-aa tree is it changes a whole pile of stuff at once, in the
same area as Pat's discontigmem support stuff. It also changes
the way zone fallbacks for NUMA are done - I had to spend a
day fixing that for the main tree already ... I'd like to try 
some other stuff as well. The -aa tree also seems to be 
incompatible (or rather, not trivially fixable) with the O(1)
scheduler.

> Have you checked latency?
> I found weird behavior of latest O(1)-K3 with latencytest0.42-png and higher 
> latency then with clean 2.4.18.

I'm not sure latency is as high up the list as locking for a
large backend server. At least we're doing *something* at the
time rather than spinning. From my own personal perception,
akpm's low latency stuff is preferable to preempt. I'd be
interested in arguments against this ...

> Do you have some former O(1) versions around? Ingo removed them form his 
> archive.

I have J6 somewhere. Have you isolated which change he made
that caused latency problems?

> Preemption?

see above.
 
> Running 2.4.19-pre2-dn1 :-)

All sounds interesting apart from aic7xxx and ide, which I don't have.

> BTW Anyone out there who have a copy of the mem "test" prog handy?
> I've accidentally removed one of my development folders...
> 
> Would be nice to see some "Hammer" systems from IBM next winter;-)

Not sure whether we're doing Hammer yet or not (IBM is huge,
and I'm in a different division), but I'd love to see a large 
Hammer system too. This is the "old" Sequent hardware, and 
tops out at a 900MHz P3 (I think). I should be able to build 
up to a 64 proc machine w/ 64Gb out of this stuff  (if I can 
scrounge up the parts ;-) )

M.

