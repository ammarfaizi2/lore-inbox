Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUITU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUITU5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUITU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:57:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:46799 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267323AbUITU5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:57:02 -0400
Date: Mon, 20 Sep 2004 22:55:09 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
Message-ID: <20040920205509.GF4242@wotan.suse.de>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 12:00:33PM -0700, Ray Bryant wrote:
> Background
> ----------
> 
> Last month, Jesse Barnes proposed a patch to do round robin
> allocation of page cache pages on NUMA machines.  This got shot down
> for a number of reasons (see
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109235420329360&w=2
> and the related thread), but it seemed to me that one of the most
> significant issues was that this was a workload dependent optimization.
> That is, for an Altix running an HPC workload, it was a good thing,
> but for web servers or file servers it was not such a good idea.
> 
> So the idea of this patch is the following:  it creates a new memory
> policy structure (default_pagecache_policy) that is used to control
> how storage for page cache pages is allocated.  So, for a large Altix
> running HPC workloads, we can specify a policy that does round robin
> allocations, and for other workloads you can specify the default policy
> (which results in page cache pages being allocated locally).
> 
> The default_pagecache_policy is overrideable on a per process basis, so
> that if your application prefers to allocate page cache pages locally,
> it can.

I'm not sure this really makes sense. Do you have some clear use 
case where having so much flexibility is needed? 

I would prefer to have a global setting somewhere for the page
cache (sysctl or sysfs or what you prefer) and some special handling for 
text pages. 

This would keep the per thread bloat low. 

Also I must say I got a patch submitted to do policy per
file from Steve Longerbeam. 

It so far only supports this for ELF executables, but
it has most of the infrastructure to do individual policy
per file. Maybe it would be better to go into this direction,
only thing missing is a nice way to declare policy for 
arbitary files. Even in this case a global default would be useful.

I haven't done anything with this patch yet due to missing time 
and there were a few small issues to resolve, but i hope it 
can be eventually integrated.

[Steve, perhaps you can repost the patch to lse-tech for more
wider review?]


> MPOL_ROUNDROBIN.  We need this because there is no handy offset to use
> when you get a call to allocate a page cache page in "page_cache_alloc()",
> so MPOL_INTERLEAVE doesn't do what we need.

Well, you just have to change the callers to pass it in. I think
computing the interleaving on a offset and perhaps another file
identifier is better than having the global counter.

> (It also appears to me that there is no mechanism to set the default
> policies, but perhaps its there and I am just missing it.)

No sure what default policies you mean? 

> (3)  alloc_pages_current() is now an inline, but there is no easy way
> to do that totally correclty with the current include file order (that I
> could figure out at least...)  The problem is that alloc_pages_current()
> wants to use the define constant POLICY_PAGE, but that is defined yet.
> We know it is zero, so we just use zero.  A comment in mempolicy.h
> suggests not to change the value of this constant to something other
> than zero, and references the file gfp.h.

I'm pretty sure the code I wrote didn't have a "POLICY_PAGE" ;-)
Not sure where you got it from, but you could ask whoever 
wrote that comment in your patch

> 
> (4)  I've not thought a bit about locking issues related to changing a
> mempolicy whilst the system is actually running. 

You need some kind of lock. Normally mempolicies are either
protected by being thread local or by the mmsem together
with the atomic reference count.
This only applies to modifications, for reading they are completely
stateless and don't need any locking.

Your new RR policy will break this though. It works for process
policy, but for VMA policy it will either require a lock per 
policy or some other complicated locking. Not nice.

I think doing it stateless is much better because it will scale
much better and should IMHO also have better behaviour longer term.
I went over several design iterations with this and think the 
current lockless design is very preferable.

> (5)  It seems there may be a potential conflict between the page cache
> mempolicy and a mmap mempolicy (do those exist?).  Here's the concern:

They exist for tmpfs/shmfs/hugetlbfs pages.

With Steve's page cache patch it can exist for all pages.

Normally NUMA API resolves this by prefering the more specific
policy (VMA over process) or sharing policies (for shmfs) 

Haven't read your patch in details yet, sorry, just design comments.

-Andi
