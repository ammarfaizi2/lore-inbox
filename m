Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbVKCMTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVKCMTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 07:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVKCMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 07:19:35 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:22658 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964915AbVKCMTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 07:19:35 -0500
Date: Thu, 3 Nov 2005 12:19:24 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 - Summary
In-Reply-To: <43698080.3040800@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511031034150.26959@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org>  <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au>  <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost> 
 <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost>
 <43680D8C.5080500@yahoo.com.au> <Pine.LNX.4.58.0511021231440.5235@skynet>
 <43698080.3040800@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Nick Piggin wrote:

> Mel Gorman wrote:
>
> >
> > Ok. To me, the rest of the thread are beating around the same points and
> > no one is giving ground. The points are made so lets summarise. Apologies
> > if anything is missing.
> >
>
> Thanks for attempting a summary of a difficult topic. I have a couple
> of suggestions.
>
> > Who cares
> > =========
> >   Physical hotplug remove: Vendors of the hardware that support this -
> >      Fujitsu, HP (I think), IBM etc
> >
> >   Virtualization hotplug remove: Sellers of virtualization software, some
> >      hardware like any IBM machine that lists LPAR in it's list of
> >      features.  Probably software solutions like Xen are also affected
> >      if they want to be able to grow and shrink the virtual machines on
> >      demand
> >
>
> Ingo said that Xen is fine with per page granular freeing - this covers
> embedded, desktop and small server users of VMs into the future I'd say.
>

Ok, hard to argue with that.

> >   High order allocations: Ultimately, hugepage users. Today, that is a
> >      feature only big server users like Oracle care about. In the
> >      future I reckon applications will be able to use them for things
> >      like backing the heap by huge pages. Other users like GigE,
> >      loopback devices with large MTUs, some filesystem like CIFS are
> >      all interested although they are also been told use use smaller
> >      pages.
> >
>
> I think that saying its now OK to use higher order allocations is wrong
> because as I said even with your patches they are going to run into
> problems.
>

Ok, I have not denied that they will run into problems. I have asserted
that, with more work built upon these patches, we can grant large pages
with a good degree of reliability. Subsystems should still use small
orders whenever possible and at the very least, large orders should be
short-lived.

For userspace users, I would like to move towards better availibility of
huge page without requiring boot-time tunables which are required today.
Do we agree that this would be useful at least for a few different users?

HugeTLB user 1: Todays users of hugetlbfs like big databases etc
HugeTLB user 2: HPC jobs that run with sparse data sets
HugeTLB user 3: Desktop applications that use large amounts of address space.

I got a mail from a user of category 2. He said I can quote his email, but
he didn't say I could quote his name which is inconvenient but I'm sure he
has good reasons.

To him, low fragmentation is "critical, at least in HPC environments".
Here is the core of his issue;

--- excerpt ---
Take the scenario that you have a large machine that is
used by multiple users, and the usage is regulated by a batch
scheduler. Loadleveler on ibm's for example. PBS on many
others. Both appear to be available in linux environments.

In the case of my codes, I find that having large pages is
extremely beneficial to my run times. As in factors of several,
modulo things that I've coded in by hand to try and avoid the
issues. I don't think my code is in any way unusual in this
magnitude of improvement.
--- excerpt ---

ok, so we have two potential solutions, anti-defrag and zones. We don't
need to rehash the pro's and cons. With zones, we just say "just reclaim
the easy reclaim zone, alloc your pages and away we go".

Now, his problem is that the server is not restarted between job times and
jobs takes days and weeks to complete. The system administrators will not
restart the machine so getting it to a prestine state is a difficulty. The
state he gets the system in is the state he works with and with
fragmentation, he doesn't get large pages unless he is lucky enough to be
the first user of the machine

With the zone approach, we would just be saying "tune it". Here is what he
says about that

--- excerpt ---
I specifically *don't* want things that I have to beg sysadmins to
tune correctly. They won't get it right because there is no `right'
that is right for everyone. They won't want to change it and it
won't work besides. Been there, done that. My experience is that
with linux so far, and some other non-linux machines too, they
always turn all the page stuff off because it breaks the machine.
--- excerpt ---

This is an example of a real user that "tune the size of your zone
correctly" is just not good enough. He makes a novel suggestion on how
anti-defrag + hotplug could be used.

--- excerpt ---
In the context of hotplug stuff and fragmentation avoidance,
this sort of reset would be implemented by performing the
the first step in the hot unplug, to migrate everything off
of that memory, including whatever kernel pages that exist
there, but not the second step. Just leave that memory plugged
in and reset the memory to a sane initial state. Essentially
this would be some sort of pseudo hotunplug followed by a pseudo
hotplug of that memory.
--- excerpt ---

I'm pretty sure this is not what hotplug was aimed at but it would get him
what he wants, large pages to echo BigNumber > nr_hugepages at the least.
It also needs hotplug remove to be working for some banks and regions of
memory although not the 100% case.

Ok, this is one example of a user for scientific workloads that "tune the
size of the zone" just is not good enough. The admins won't do it for him
because it'll just break for the next scheduled job.

> Actually I think one reason your patches may perform so well is because
> there aren't actually a lot of higher order allocations in the kernel.
>
> I think that probably leaves us realistically with demand hugepages,
> hot unplug memory, and IBM lpars?
>


>
> > Pros/Cons of Solutions
> > ======================
> >
> > Anti-defrag Pros
> >   o Aim9 shows no significant regressions (.37% on page_test). On some
> >     tests, it shows performance gains (> 5% on fork_test)
> >   o Stress tests show that it manages to keep fragmentation down to a far
> >     lower level even without teaching kswapd how to linear reclaim
>
> This sounds like a kind of funny test to me if nobody is actually
> using higher order allocations.
>

No one uses them because they always fail. This is a chicken and egg
problem.

> When a higher order allocation is attempted, either you will satisfy
> it from the kernel region, in which case the vanilla kernel would
> have done the same. Or you satisfy it from an easy-reclaim contiguous
> region, in which case it is no longer an easy-reclaim contiguous
> region.
>

Right, but right now, we say "don't use high order allocations ever". With
work, we'll be saying "ok, use high order allocations but they should be
short lived or you won't be allocating them for long"

> >   o Stress tests with a linear reclaim experimental patch shows that it
> >     can successfully find large contiguous chunks of memory
> >   o It is known to help hotplug on PPC64
> >   o No tunables. The approach tries to manage itself as much as possible
>
> But it has more dreaded heuristics :P
>

Yeah, but if it gets them wrong, the system chugs along anyway, just
fragmented like it is today. If the zone-based approach gets it wrong, the
system goes down the tubes.

At very worst, the patches give a kernel allocator that is as good as
todays. At very worst, the zone-based approach makes an unusable system.
The performance of the patches is another story. I've been posting aim9
figures based on my test machine. I'm trying to kick an ancient PowerPC
43P Model 150 machine into working.  This machine is a different
architecture and ancient (I found it on the way to a skip) so should give
different figures.

> >   o It exists, heavily tested, and synced against the latest -mm1
> >   o Can be compiled away be redefining the RCLM_* macros and the
> >     __GFP_*RCLM flags
> >
> > Anti-defrag Cons
> >   o More complexity within the page allocator
> >   o Adds a new layer onto the allocator that effectively creates subzones
> >   o Adding a new concept that maintainers have to work with
> >   o Depending on the workload, it fragments anyway
> >
> > New Zone Pros
> >   o Zones are a well known and understood concept
> >   o For people that do not care about hotplug, they can easily get rid of it
> >   o Provides reliable areas of contiguous groups that can be freed for
> >     HugeTLB pages going to userspace
> >   o Uses existing zone infrastructure for balancing
> >
> > New Zone Cons
> >   o Zones historically have introduced balancing problems
> >   o Been tried for hotplug and dropped because of being awkward to work with
> >   o It only helps hotplug and potentially HugeTLB pages for userspace
> >   o Tunable required. If you get it wrong, the system suffers a lot
>
> Pro: it keeps IBM mainframe and pseries sysadmins in a job ;) Let
> them get it right.
>

Unless you work in a place where they sysadmins will tell you to go away
such as the HPC user above. I'm not a sysadmin, but I'm pretty sure they
have better things to do than twiddle a tunable all day.

> >   o Needs to be planned for and developed
> >
>
> Yasunori Goto had patches around from last year. Not sure what sort
> of shape they're in now but I'd think most of the hard work is done.
>

But Yasunori (thanks for sending the links ) himself says when he posted.

--- excerpt ---
Another one was a bit similar than Mel-san's one.
One of motivation of this patch was to create orthogonal relationship
between Removable and DMA/Normal/Highmem. I thought it is desirable.
Because, ppc64 can treat that all of memory is same (DMA) zone.
I thought that new zone spoiled its good feature.
--- excerpt ---

He thought that the new zone removed the ability of some architectures to
treat all memory the same. My patches give some of the benefits of using
another zone while still preserving an architectures ability to
treat all memory the same.

> > Scenarios
> > =========
> >
> > Lets outline some situations then or workloads that can occur
> >
> > 1. Heavy job running that consumes 75% of physical memory. Like a kernel
> >    build
> >
> >   Anti-defrag: It will not fragment as it will never have to fallback.High
> >      order allocations will be possible in the remaining 25%.
> >   Zone-based: After been tuned to a kernel build load, it will not
> >      fragment. Get the tuning wrong, performance suffers or workload
> >      fails. High order allocations will be possible in the remaining 25%.
> >
>
> You don't need to continually tune things for each and every possible
> workload under the sun. It is like how we currently drive 16GB highmem
> systems quite nicely under most workloads with 1GB of normal memory.
> Make that an 8:1 ratio if you're worried.
>
> [snip]
>
> >
> > I've tried to be as objective as possible with the summary.
> >
> > > From the points above though, I think that anti-defrag gets us a lot of
> > the way, with the complexity isolated in one place. It's downside is that
> > it can still break down and future work is needed to stop it degrading
> > (kswapd cleaning UserRclm areas and page migration when we get really
> > stuck). Zone-based is more reliable but only addresses a limited
> > situation, principally hotplug and it does not even go 100% of the way for
> > hotplug.
>
> To me it seems like it solves the hotplug, lpar hotplug, and hugepages
> problems which seem to be the main ones.
>
> > It also depends on a tunable which is not cool and it is static.
>
> I think it is very cool because it means the tiny minority of Linux
> users who want this can do so without impacting the rest of the code
> or users. This is how Linux has been traditionally run and I still
> have a tiny bit of faith left :)
>

The impact of the code and users will depend on benchmarks. I've posted
benchmarks that show there are either very small regressions or else there
are performance gains. As I write this, some of the aim9 benchmarks
completed on the PowerPC.

This is a comparison between 2.6.14-rc5-mm1 and
2.6.14-rc5-mm1-mbuddy-v19-defragDisabledViaConfig

 1 creat-clo      73500.00   72504.58    -995.42 -1.35% File Creations and Closes/second
 2 page_test      30806.13   31076.49     270.36  0.88% System Allocations & Pages/second
 3 brk_test      335299.02  341926.35    6627.33  1.98% System Memory Allocations/second
 4 jmp_test     1641733.33 1644566.67    2833.34  0.17% Non-local gotos/second
 5 signal_test   100883.19   98900.18   -1983.01 -1.97% Signal Traps/second
 6 exec_test        116.53     118.44       1.91  1.64% Program Loads/second
 7 fork_test        751.70     746.84      -4.86 -0.65% Task Creations/second
 8 link_test      30217.11   30463.82     246.71  0.82% Link/Unlink Pairs/second

Performance gains on page_test, brk_test and exec_test. Even with
variances between tests, we are looking at "more or less the same", not
regressions. No user impact there.

This is a comparison between 2.6.14-rc5-mm1 and
2.6.14-rc5-mm1-mbuddy-v19-withantidefrag

 1 creat-clo      73500.00   71188.14   -2311.86 -3.15% File Creations and Closes/second
 2 page_test      30806.13   31060.96     254.83  0.83% System Allocations & Pages/second
 3 brk_test      335299.02  344361.15    9062.13  2.70% System Memory Allocations/second
 4 jmp_test     1641733.33 1627228.80  -14504.53 -0.88% Non-local gotos/second
 5 signal_test   100883.19  100233.33    -649.86 -0.64% Signal Traps/second
 6 exec_test        116.53     117.63       1.10  0.94% Program Loads/second
 7 fork_test        751.70     763.73      12.03  1.60% Task Creations/second
 8 link_test      30217.11   30322.10     104.99  0.35% Link/Unlink Pairs/second

Performance gains on page_test, brk_test, exec_test and fork_test. Not bad
going for complex overhead. create-clo took a beating, but what workload
opens and closes files at that rate?

This is an old, small machine. If I hotplug this, I'll be lucky if it ever
turns on again. The aim9 benchmarks on two machines show that there is
similar and, in some cases better, performance with these patches. If a
workload does suffer badly, an additional patch has been supplied that
disables anti-defrag. A run in -mm will tell us if this is the general
case for machines or are my two test boxes running on magic beans.

So, the small number of users that want this, get this. The rest of the
users who just run the code, should not notice or care. This brings us
back to the main stickler, code complexity. I think that the code has been
very well isolated from the code allocator code and people looking at the
allocator could avoid it if they really wanted while stilling knowing what
the buddy allocator was doing.

> > If we make the zones growable+shrinkable, we run into all the same
> > problems that anti-defrag has today.
> >
>
> But we don't have the extra zones layer that anti defrag has today.
>

So, we just have an extra layer on the side that has to be configured. All
of the problems with all of the configuration.

> And anti defrag needs limits if it is to be reliable anyway.
>

I'm confident given time that I can make this manage itself with a very
good degree of reliability.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
