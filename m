Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVBLV3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVBLV3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVBLV3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:29:23 -0500
Received: from colin2.muc.de ([193.149.48.15]:1034 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261155AbVBLV3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:29:16 -0500
Date: 12 Feb 2005 22:29:14 +0100
Date: Sat, 12 Feb 2005 22:29:14 +0100
From: Andi Kleen <ak@muc.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050212212914.GA51971@muc.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <20050212155426.GA26714@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212155426.GA26714@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 01:54:26PM -0200, Marcelo Tosatti wrote:
> On Sat, Feb 12, 2005 at 12:17:25PM +0100, Andi Kleen wrote:
> > Ray Bryant <raybry@sgi.com> writes:
> > > set of pages associated with a particular process need to be moved.
> > > The kernel interface that we are proposing is the following:
> > >
> > > page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> > 
> > [Only commenting on the interface, haven't read your patches at all]
> > 
> > This is basically mbind() with MPOL_F_STRICT, except that it has a pid 
> > argument. I assume that's for the benefit of your batch scheduler.
> 
> As far as I understand mbind() is used to set policies to given memory 
> regions, not move memory regions?

There is a MPOL_F_STRICT flag. Currently it fails when the memory
is not on the right node(s) and the flag is set, but it could as well move. 

In fact Steve Longerbeam already did a patch to move in this case,
but it hasn't been merged yet for some reasons.


> > mmap in parallel. The only way I can think of to do this would be to
> > check for changes in maps after a full move and loop, but then you risk
> > livelock.
> 
> True. 
> 
> There is no problem, however, if all threads beloging to the process are stopped, 
> as Ray mentions. 
> 
> So, there wont be memory mapping changes happening at the same time. 

Ok. But it's still quite ugly to read /proc/*/maps for this.

> 
> > And you cannot also just specify va_start=0, va_end=~0UL because that
> > would make the node arrays grow infinitely. 
> > 
> > Also is there a good use case why the batch scheduler should only
> > move individual areas in a process around, not the full process?
> 
> Quoting him:
> 
> "In addition to its use by batch schedulers, we also envision that
> this facility could be used by a program to re-arrange the allocation
> of its own pages on various nodes of the NUMA system, most likely
> to optimize performance of the application during different phases
> of its computation."
> 
> Seems doable. 

That is what mbind() already supports, just someone needs to hook up
the page moving code with MPOL_F_STRICT.
 
> Are there any good xamples of optimizations that could be made by 
> moving pages around except for NUMA?

It's all fundamentally a NUMA thing.

There was some talk to define fake nodes as fall back pools
to get low latency multimedia allocation, with that it may be useful
too at some point.

-Andi
