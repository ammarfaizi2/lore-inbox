Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUITWKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUITWKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUITWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:10:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49889 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267195AbUITWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:09:53 -0400
Message-ID: <414F560E.7060207@sgi.com>
Date: Mon, 20 Sep 2004 17:13:34 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de>
In-Reply-To: <20040920205509.GF4242@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Andi Kleen wrote:
> On Mon, Sep 20, 2004 at 12:00:33PM -0700, Ray Bryant wrote:
> 
>>Background
>>----------
>>
>>Last month, Jesse Barnes proposed a patch to do round robin
>>allocation of page cache pages on NUMA machines.  This got shot down
>>for a number of reasons (see
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109235420329360&w=2
>>and the related thread), but it seemed to me that one of the most
>>significant issues was that this was a workload dependent optimization.
>>That is, for an Altix running an HPC workload, it was a good thing,
>>but for web servers or file servers it was not such a good idea.
>>
>>So the idea of this patch is the following:  it creates a new memory
>>policy structure (default_pagecache_policy) that is used to control
>>how storage for page cache pages is allocated.  So, for a large Altix
>>running HPC workloads, we can specify a policy that does round robin
>>allocations, and for other workloads you can specify the default policy
>>(which results in page cache pages being allocated locally).
>>
>>The default_pagecache_policy is overrideable on a per process basis, so
>>that if your application prefers to allocate page cache pages locally,
>>it can.
> 
> 
> I'm not sure this really makes sense. Do you have some clear use 
> case where having so much flexibility is needed? 
>
> I would prefer to have a global setting somewhere for the page
> cache (sysctl or sysfs or what you prefer) and some special handling for 
> text pages. 
> 
> This would keep the per thread bloat low. 
>

Yeah, we can probably live with that until we come up with a good example.

The thread bloat in the currentpatch is one word per task struct, plus some 
extra checks in alloc_pages_by_policy().  The latter are more worrisome than 
the former.

My only concern about a separate sysctl or sysfs is that this really is a 
system wide memory allocation policy issue.  It seems cleaner to me to keep 
that all within the scope of the NUMA API rather than hiding details of it 
here and there in /proc.  And we need the full generality of the NUMA API, to, 
for example:

(1)  Restrict all page cache page pages to some subset of the nodes in the
      system.  We have memory only nodes, and people woule like page cache
      pages (not text pages!) to be confined to that set of nodes.  So we
      need some kind of nodemask to go along with the page cache allocation
      policy.

(2)  We need to fully support cpusets within all of this.  That means that
      page cache allocation requests coming from a node in the cpuset, should
      only be allocated within that cpuset.  And even then, perhaps we may
      want a subset of the nodes in the cpuset set to be designated as the
      places for page cache  pages to live.

If we do this within the scope of the existing mempolicy code, the cpuset
stuff comes along for free.

> Also I must say I got a patch submitted to do policy per
> file from Steve Longerbeam. 
> 
> It so far only supports this for ELF executables, but
> it has most of the infrastructure to do individual policy
> per file. Maybe it would be better to go into this direction,
> only thing missing is a nice way to declare policy for 
> arbitary files. Even in this case a global default would be useful.
> 

Yes, if there were a global default that we could set that would support
round robin page cache allocation, then that would probably work.

> I haven't done anything with this patch yet due to missing time 
> and there were a few small issues to resolve, but i hope it 
> can be eventually integrated.
> 
> [Steve, perhaps you can repost the patch to lse-tech for more
> wider review?]
> 

Since I've not seen it, its hard to evaluate.  :-)

> 
> 
>>MPOL_ROUNDROBIN.  We need this because there is no handy offset to use
>>when you get a call to allocate a page cache page in "page_cache_alloc()",
>>so MPOL_INTERLEAVE doesn't do what we need.
> 
> 
> Well, you just have to change the callers to pass it in. I think
> computing the interleaving on a offset and perhaps another file
> identifier is better than having the global counter.
>

In our case that means changing each and every call to page_cache_alloc()
to include an appropriate offset.  This is a change that richochets through 
the machine independent code and makes this harder to contain in the NUMA
subsystem.

Is there a performance problem with the global counter?  We've been using 
exactly that kind of implementation for our current Altix systems and it seems 
to work fine.  If you use some kind of offset and interleave as you suggest, 
how will you make sure that page cache allocations are evenly balanced across 
the nodes in a system, or the nodes in a cpuset?  Wouldn't it make more sense 
to spread them out dynamically based on actual usage?

For example, let suppose (just to be devious) that on a 2-node system you 
decided (poorly, admittedly) to use the bottom bit of the offset to chose the 
node.  And suppose that the user only touches the even numbered offsets in the 
file.  You'll clobber node 0 with all of the page cache pages, right?

Of course, that is a poor decision.  But, any type of static allocation like 
that based on offset is going to suffer from a similar type of worst case
behavior.  If you allocate the page cache page on the next node in sequence,
then we will smooth out page cache allocation based on actual usage patterns.
Isn't that a better idea?

> 
>>(It also appears to me that there is no mechanism to set the default
>>policies, but perhaps its there and I am just missing it.)
> 
> 
> No sure what default policies you mean? 
> 

Since there is (with this patch) a separate (default) policy to control 
allocation of page cache pages, there now has to be a way to set that policy.
Since the default_policy for regular page allocation can't be changed (it is, 
after all also the policy for allocating pages at interrupt time) there was no 
need for that API in the past.  Now, however, we need a way to set the system 
default page cache allocation policy, since some system administrators will 
want that to be MPOL_LOCAL and some will want that to be MPOL_INTERLEAVE or 
potentially MPOL_ROUNDROBIN depending on the workload that the system is running.

So we need some way to set the default policy for the page cache.  Somethling 
like this has to be there because without a way to round robin the page cache, 
we have no good way to be able to guarantee that when a user on our big boxen 
ask for local storage, there is a good likelyhood they will get it.

> 
>>(3)  alloc_pages_current() is now an inline, but there is no easy way
>>to do that totally correclty with the current include file order (that I
>>could figure out at least...)  The problem is that alloc_pages_current()
>>wants to use the define constant POLICY_PAGE, but that is defined yet.
>>We know it is zero, so we just use zero.  A comment in mempolicy.h
>>suggests not to change the value of this constant to something other
>>than zero, and references the file gfp.h.
> 
> 
> I'm pretty sure the code I wrote didn't have a "POLICY_PAGE" ;-)
> Not sure where you got it from, but you could ask whoever 
> wrote that comment in your patch
>

You're correct.  POLICY_PAGE is new in this patch, and I wrote that comment.
The note above explans why it is hard to get this #define constant in there.

What is going on is that what you used to refer to as default_policy is now 
default_policy[POLICY_PAGE] (Not the best name, but I couldn't think of a 
better one), the default policy for page cache pages is
default_policy[POLICY_PAGECACHE], etc.  (I'm sure we can think up several
others without too much problem.  BTW, these should probably be named
POLICY_CLASS_PAGE, or MEM_CLASS_PAGE or some such, because we are talking 
about allocating different kinds of storage.)

(One of the things we have in mind is POLICY_SLABCACHE; we also need to smooth 
out allocation of buffer heads (or whatever they are in 2.6.) so that when we
run a copy on a particular node, even though we smooth out the allocation of
page cache pages, we can end up with significanlty more storage use on that
node than other nodes, and that storage never goes away.  This is bad, bad for
the big HPC application that comes along and wants to allocate the same amount
of storage on each of 512 nodes, and it can't on node 37, for some reason.
If allocations on one of those nodes spill, then the entire parallel 
computation will be slowed down [typically, such a job runs as slowly as the
slowest processor]).

> 
>>(4)  I've not thought a bit about locking issues related to changing a
>>mempolicy whilst the system is actually running. 
> 
> 
> You need some kind of lock. Normally mempolicies are either
> protected by being thread local or by the mmsem together
> with the atomic reference count.
> This only applies to modifications, for reading they are completely
> stateless and don't need any locking.
> 
> Your new RR policy will break this though. It works for process
> policy, but for VMA policy it will either require a lock per 
> policy or some other complicated locking. Not nice.
> 

I agree.  We'd have to figure out some way around this.

> I think doing it stateless is much better because it will scale
> much better and should IMHO also have better behaviour longer term.
> I went over several design iterations with this and think the 
> current lockless design is very preferable.
> 

No argument there, I like scalable solutions better too.  :-)
Lets sort out some of the other stuff first and come back to this one later.

> 
>>(5)  It seems there may be a potential conflict between the page cache
>>mempolicy and a mmap mempolicy (do those exist?).  Here's the concern:
> 
> 
> They exist for tmpfs/shmfs/hugetlbfs pages.
> 
> With Steve's page cache patch it can exist for all pages.
> 
> Normally NUMA API resolves this by prefering the more specific
> policy (VMA over process) or sharing policies (for shmfs) 
> 
> Haven't read your patch in details yet, sorry, just design comments.
> 

That's fine.  The top level details need as much discussion as anything.

> -Andi
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
> 


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

