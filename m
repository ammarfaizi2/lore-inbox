Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUIUJPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUIUJPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUIUJPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:15:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:22226 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267538AbUIUJPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:15:01 -0400
Date: Tue, 21 Sep 2004 11:13:54 +0200
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
Message-ID: <20040921091353.GG8058@wotan.suse.de>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F560E.7060207@sgi.com> <20040920223742.GA7899@wotan.suse.de> <414F8424.5080308@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F8424.5080308@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 08:30:12PM -0500, Ray Bryant wrote:
> Andi Kleen wrote:
> >On Mon, Sep 20, 2004 at 05:13:34PM -0500, Ray Bryant wrote:
> >
> >>system wide memory allocation policy issue.  It seems cleaner to me to 
> >>keep that all within the scope of the NUMA API rather than hiding details 
> >>of it here and there in /proc.  And we need the full generality of the 
> >>NUMA API, to, for example:
> >
> >
> >True for cpuset you will need it.
> >
> >
> >>>Well, you just have to change the callers to pass it in. I think
> >>>computing the interleaving on a offset and perhaps another file
> >>>identifier is better than having the global counter.
> >>>
> >>
> >>In our case that means changing each and every call to page_cache_alloc()
> >>to include an appropriate offset.  This is a change that richochets 
> >>through the machine independent code and makes this harder to contain in 
> >>the NUMA
> >>subsystem.
> >
> >
> >I count two callers of page_cache_alloc in 2.6.9rc2 (filemap.c and
> >XFS pagebuf). Hardly seems like a big issue to change them both. 
> >Of course getting the offset there might be tricky, but should be 
> >doable.
> >
> 
> Fair enough.  Another option I was thinking of was hiding a global counter
> in page_cache_alloc itself and using it to provide a value for the offset
> there.

Please don't. Just use an offset and a hash on (dev_t, inode number) 

> >
> >Any allocation algorithm will have such a worst case, so I'm not
> >too worried. Given ia hash function is not too bad it should
> >be bearable.
> >
> >The nice advantage of the static offset is that it makes benchmarks
> >actually repeatable and is completely lockless
> >
> 
> I can see the advantages of that.  But the state of the page cache is still
> something we have to deal with for benchmarks.

Umounting the file systems with the data files usually works pretty
well.

Or longer term if it's a real issue one could write a workload manager
that can actually change policies for existing pages. But I'm not 
sure how such a beast would really work.

> >>be MPOL_INTERLEAVE or potentially MPOL_ROUNDROBIN depending on the 
> >>workload that the system is running.
> >
> >
> >I think I'm still a bit confused by your terminology.
> >I thought the page cache policy was per process? Now you
> >are talking about another global unrelated policy?
> >
> 
> 
> I'm sorry if this is confusing, personal terminology usually gets in the 
> way.
> 
> The idea is that just like for the page allocation policy (your current 
> code), if you wanted, you would have a global, default page cache 

Having both a per process page cache and a global page cache policy
would seem like overkill to me.

And having both doesn't make much sense anyways, because when the 
system admin wants to change the global policy to free memory
on nodes he would still need to worry about conflicting per process policies 
anyways. So as soon as you have process policy you cannot easily
change global anymore.

> allocation policy, probably set at boot time or shortly thereafter, 
> probably before any (or at least most) page cache pages have been 
> allocated.  You could also have a per process policy setting that would 
> override the global policy, for processes that needed it, but I honestly 
> don't have a good case for this except for symmetry with the existing code.

cpusets was the good case for it that you mentioned. 
Or did I misunderstand you?

> >Anyways, I guess you could just add a high flag bit to the 
> >mode argument of set_mempolicy. Something like
> >
> >set_mempolicy(MPOL_PAGECACHE | MPOL_INTERLEAVE, nodemask, len)
> >
> >That would work for setting the page cache policy of the current
> >process. 
> >
> >
> 
> That's an idea.  Not they way I was planning on doing it, but that would
> work.  I was thinking along the lines of:
> 
> set_mempolicy(MPOL_INTERLEAVE, nodemask, len, POLICY_PAGECACHE);
> 
> but either way can be made to work.

That would be set_mempolicy2() essentially because the existing
users don't pass this additional argument. I think passing the flags
in the first argument is more compatible.

-andi
