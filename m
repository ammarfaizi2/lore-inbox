Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbTC1KDi>; Fri, 28 Mar 2003 05:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbTC1KDi>; Fri, 28 Mar 2003 05:03:38 -0500
Received: from holomorphy.com ([66.224.33.161]:54958 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262857AbTC1KDg>;
	Fri, 28 Mar 2003 05:03:36 -0500
Date: Fri, 28 Mar 2003 02:14:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030328101433.GQ1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <Pine.LNX.4.50.0303280243080.2884-100000@montezuma.mastecende.com> <20030328075730.GP30140@holomorphy.com> <Pine.LNX.4.50.0303280303190.2884-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303280303190.2884-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, William Lee Irwin III wrote:
>> Sure. On NUMA-Q mem_map[] is not allocated using bootmem except for
>> node 0. Various other bootmem allocations are also proportional to
>> memory as measured in units of PAGE_SIZE, but not all.
>> So all we're seeing here is node 0's mem_map[] with "miscellaneous"
>> bootmem allocations thrown in, whether reduced or increased.
>> This is not very reflective of what's going on as the majority of mem_map[]
>> is allocated through a custom reservation mechanism as opposed to bootmem.

On Fri, Mar 28, 2003 at 03:05:42AM -0500, Zwane Mwaikambo wrote:
> Thanks, nice work btw, although the core guts of this stuff is somewhat of 
> a mystery to some of us ;)

The code is still very much of prototype quality, so I'm actually being
somewhat deliberately obscure so those who aren't specifically
interested in hacking or very early testing don't accidentally burn
themselves or otherwise get the impression of a patchkit gone horribly
wrong. And even worse than that, so no one reviews the code before I've
cleaned it up.

The concept is really very simple, although the consequences are far
reaching. The kernel ties together its basic unit of allocation and
accounting, the PAGE_SIZE area and its associated struct page, together
with the notion of a pagetable entry and the size of the area mapped by
a pagetable entry (also called PAGE_SIZE in mainline, made into a
distinct notion of MMUPAGE_SIZE by the patch).

Page clustering is named for the view of the arrangement that a set of
hardware pages is a "cluster" represented by the software accounting
unit. In truth it's closer to symmetry apart from the constraint that
the software unit must be larger than the hardware unit. The net result
of it is that you go around figuring out which of the two units various
bits of code really meant, and for pagetable walks and so on the code
must be taught that it's referring to only a piece of a software page,
or to hand callers the piece they need when they need them.

The fact it resolves the horror of mem_map[] overrunning kernel
virtualspace on i386 PAE is really an obscure coincidence. AIUI Hugh's
2.4.x patch was actually intended to enable larger filesystem block
sizes, and the BSD implementation for the VAX was simply meant to deal
with the fact that even 16B for every 512B hardware page is too large a
fraction of physical memory (not virtual) for page-granularity
accounting to be memory-efficient. For BSD's purposes a relatively
small constant factor sufficed; for i386 a much larger one is required
for workload feasibility as virtualspace approaches the precise
fraction of physical memory that the coremap would otherwise consume.

Various other odd goodnesses are supposed to come of it, for instance,
prefaulting benefits as a side effect of trying to utilize the entire
software page in fault handlers, and io throughput benefits from
increased physical contiguity. My codebase is not prepared for
performance analysis yet, as the fragmentation issues are only
partially resolved. The real point of the posting is to show that this
thing actually makes 64GB work and, of course, to get first the post
on 64GB i386 PAE. =)

With this in hand, we can say "Yes, this solves the problem without
turning critical userspace apps into doorstops by stealing address
space from them" and I can resume coding up the final stretch of
functionality and move on to cleanups and maintenance of the patch
until the devel cycle comes to the point where it's ready for a merge.
I'd not be surprised if some vendor and/or distro interest is provoked,
and I'll do my best to help them along (if desired) once the patch is in
good enough shape wrt. functionality and clean enough to deliver to them.


-- wli
