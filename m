Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUITWmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUITWmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUITWmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:42:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:19892 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265795AbUITWmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:42:10 -0400
Date: Tue, 21 Sep 2004 00:37:42 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
Message-ID: <20040920223742.GA7899@wotan.suse.de>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F560E.7060207@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F560E.7060207@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 05:13:34PM -0500, Ray Bryant wrote:
> system wide memory allocation policy issue.  It seems cleaner to me to keep 
> that all within the scope of the NUMA API rather than hiding details of it 
> here and there in /proc.  And we need the full generality of the NUMA API, 
> to, for example:

True for cpuset you will need it.

> >Well, you just have to change the callers to pass it in. I think
> >computing the interleaving on a offset and perhaps another file
> >identifier is better than having the global counter.
> >
> 
> In our case that means changing each and every call to page_cache_alloc()
> to include an appropriate offset.  This is a change that richochets through 
> the machine independent code and makes this harder to contain in the NUMA
> subsystem.

I count two callers of page_cache_alloc in 2.6.9rc2 (filemap.c and
XFS pagebuf). Hardly seems like a big issue to change them both. 
Of course getting the offset there might be tricky, but should be 
doable.

> 
> Is there a performance problem with the global counter?  We've been using 

There might be. You will need a global lock. 

> exactly that kind of implementation for our current Altix systems and it 
> seems to work fine.  If you use some kind of offset and interleave as you 
> suggest, how will you make sure that page cache allocations are evenly 
> balanced across the nodes in a system, or the nodes in a cpuset?  Wouldn't 
> it make more sense to spread them out dynamically based on actual usage?
> 
> For example, let suppose (just to be devious) that on a 2-node system you 
> decided (poorly, admittedly) to use the bottom bit of the offset to chose 
> the node.  And suppose that the user only touches the even numbered offsets 
> in the file.  You'll clobber node 0 with all of the page cache pages, right?
> 
> Of course, that is a poor decision.  But, any type of static allocation 
> like that based on offset is going to suffer from a similar type of worst 
> case
> behavior.  If you allocate the page cache page on the next node in sequence,
> then we will smooth out page cache allocation based on actual usage 
> patterns.

Your counter can have the same worst case behaviour, just 
different.  You only have to add freeing into the picture.
Or when you consider getting more memory bandwidth from the interleaving
(I know this is not your primary goal with this) then a sufficient
access pattern could lead to rather uninterleaved allocation 
in the file.

Any allocation algorithm will have such a worst case, so I'm not
too worried. Given ia hash function is not too bad it should
be bearable.

The nice advantage of the static offset is that it makes benchmarks
actually repeatable and is completely lockless

> >
> >
> >No sure what default policies you mean? 
> >
> 
> Since there is (with this patch) a separate (default) policy to control 
> allocation of page cache pages, there now has to be a way to set that 
> policy.
> Since the default_policy for regular page allocation can't be changed (it 
> is, after all also the policy for allocating pages at interrupt time) there 
> was no need for that API in the past.  Now, however, we need a way to set 
> the system default page cache allocation policy, since some system 
> administrators will want that to be MPOL_LOCAL and some will want that to 
> be MPOL_INTERLEAVE or potentially MPOL_ROUNDROBIN depending on the workload 
> that the system is running.

I think I'm still a bit confused by your terminology.
I thought the page cache policy was per process? Now you
are talking about another global unrelated policy?

With the per process policy the only way to change the policy
for the whole system is to change it in init and restart everything.
With a global policy you could change it on the fly, but 
it probably wouldn't make too much sense without a restart
because there would be already too much cache with the wrong
policy.

Anyways, I guess you could just add a high flag bit to the 
mode argument of set_mempolicy. Something like

set_mempolicy(MPOL_PAGECACHE | MPOL_INTERLEAVE, nodemask, len)

That would work for setting the page cache policy of the current
process. 


-Andi

