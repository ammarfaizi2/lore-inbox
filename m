Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUECSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUECSfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUECSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:35:32 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:17299
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263827AbUECSfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:35:11 -0400
Message-ID: <409690CA.2020103@redhat.com>
Date: Mon, 03 May 2004 11:34:50 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: NUMA API
References: <1QAMU-4gf-15@gated-at.bofh.it> <m3n04t9qwd.fsf@averell.firstfloor.org>
In-Reply-To: <m3n04t9qwd.fsf@averell.firstfloor.org>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> You mean numa_no_nodes et.al. ? 
> 
> This is essentially static data that never changes (like in6addr_any).
> numa_all_nodes could maybe in future change with node hotplug support,
> but even then it will be a global property.

And you don't see a problem with this?  You are hardcoding variables of
a certain size and layout.  This is against every good design principal.

There are other problems like not using a protected namespace.


> Everything else is thread local.

This, too, is not adequate.  It requires working on the 1-on-1 model.
Using user-level contexts (setcontext etc) is made very hard and
expensive.  There is not one state to change.  Using any of the code (or
functionality using the state) in signal handlers, possibly recursive,
will throw things in disorder.

There is no reason to not make the state explicit.


> I believe it is good enough for current machines, at least 
> until there is enough experience to really figure out what
> node discovery is needed..

That's the point.  We cannot start using an inadequate API now since one
will _never_ be able to get rid of it again.  We have accumulated
several examples of this in the past years.

The API design should be general enough to work for all the
architectures which are currently envisioned and must be extensible to
be extendable for future architectures.  Your API does not allow to
write adequate code even on some/many of today's architectures.



> I have seen some proposals
> for complex graph based descriptions, but so far I have seen
> nothing that could really take advantage of something so fancy.

I am proposing no graph-based descriptions.  And this is something where
you miss the point.  This is only the lowest level interface.  It
prorvides enough functionality to describe the machine architecture.  If
some fancy alternative representations are needed this is something for
a higher-level interface.

What must be avoided at all costs is programs peeking into /sys and
/proc to determine the topology.  First of all, this makes programs
architecture and even machine-specific.  Second, the /sys and /proc
format will change over time.  All these access must be hidden and the
NUMA library is just the place for that.

Saying

> If it should be really needed it can be added later.

just means we will get programs today which hardcode today's existing
and most probably inadequate representation of the topology in /sys and
/proc.


>>~ no inclusion of SMT/multicore in the cpu hierarchy
> 
> 
> Not sure why you would care about that.

These are two sides of the same coin.  Today we already have problems
with programs running on machines with SMT processors.  How can those
use pthread_setaffinity() to create theoptimal number of threads and
place them accordingly?  It requires magic /proc parsing for each and
every architecture.  The problem is exactly the same as with NUMA and
the interface extensions to cover MC/SMT as well are minimal.


> Well, I spent a lot of time talking to various users; and IMHO
> it matches the needs of a lot of them. I did not add all the features
> everybody wanted, but that was simply not possible and still comming
> up with a reasonable design.

And this means it should not be done?


> The per process state is needed for numactl though.
> 
> I kept the support for this visible in libnuma to make it easier to convert
> old code to this (just wrap some code with a policy) For designed from 
> scratch programs it is probably better to use the allocation functions
> with mbind directly.

The NUMA library interface should not be cluttered because of
considerations of legacy apps which need to be converted.  These are
separate issues, the design of the API must not be influenced by this.
The problem always has been that in such cases the correct interfaces
are not being used but instead the "easier to use" legacy interfaces are
used.


>>Also, the concept of hard/soft sets for CPUs is useful.  Likewise
>>"spilling" over to other memory nodes.  Usually using NUMA means hinting
>>the desired configuration to the system.  It'll be used whenever
>>possible.  If it is not possible (for instance, if a given processor is
>>not available) it is mostly no good idea to completely fail the
> 
> 
> Agreed. That is why prefered and bind are different policies
> and you can switch between them in libnuma. 

That is inadequate.  Any process/thread state like this increases the
program cost since it means that the program at all times must remember
the current state and switch if necessary.  Combine this with 3rd party
libraries using the functionality as well and you'll get explicit
switching before *every* memory allocation because one cannot assume
anything about the state.  Even if the NUMA library keeps track of the
state internally, there is always the possibility that more than one
instance of the library is used at any one time (e.g., statically linked
into a DSO).

I repeast myself: global or thread-local states are bad.  Always have
been, always will be.


-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
