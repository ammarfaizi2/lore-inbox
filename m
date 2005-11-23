Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVKWUxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKWUxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVKWUxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:53:24 -0500
Received: from fmr23.intel.com ([143.183.121.15]:41688 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932353AbVKWUxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:53:22 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123115545.69087adf.akpm@osdl.org>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	 <1132775194.25086.54.camel@akash.sc.intel.com>
	 <20051123115545.69087adf.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 13:00:05 -0800
Message-Id: <1132779605.25086.69.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 20:53:06.0938 (UTC) FILETIME=[E7B545A0:01C5F06F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 11:55 -0800, Andrew Morton wrote:
> Rohit Seth <rohit.seth@intel.com> wrote:
> >
> > On Wed, 2005-11-23 at 11:30 -0800, Christoph Lameter wrote:
> > > On Tue, 22 Nov 2005, Rohit Seth wrote:
> > > 
> > > > [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> > > > local pcp lists when a higher order allocation request is not able to 
> > > > get serviced from global free_list.
> > > 
> > > Ummm.. One controversial idea: How about removing the complete pcp 
> > > subsystem? Last time we disabled pcps we saw that the effect 
> > > that it had was within noise ratio on AIM7. The lru lock taken without 
> > > pcp is in the local zone and thus rarely contended.
> > 
> > Oh please stop.
> > 
> > This per_cpu_pagelist is one great logic that has got added in
> > allocator.  Besides providing pages without the need to acquire the zone
> > lock, it is one single main reason the coloring effect is drastically
> > reduced in 2.6 (over 2.4) based kernels.
> > 
> 
> hm.  Before it was merged in 2.5.x, the feature was very marginal from a
> performance POV in my testing on 4-way.
> 

One less lock to worry about in the page allocation should help
somewhere I would assume.

> I was able to demonstrate a large (~60%?) speedup in one microbenckmark
> which consisted of four processes writing 16k to a file and truncating it
> back to zero again.  That gain came from the cache warmth effect, which is
> the other benefit which these cpu-local pages are supposed to provide.
> 

That is right.

> I don't think Martin was able to demonstrate much benefit from the lock
> contention reduction on 16-way NUMAQ either.
> 
> So I dithered for months and it was a marginal merge, so it's appropriate
> to justify the continued presence of the code.
> 

May be the limits on the number of pages hanging on the per_cpu_pagelist
was (or even now is) too small (for them to give any meaningful gain).
May be we should have more physical contiguity in each of these pcps to
give better cache spread.  

> We didn't measure for any coloring effects though.  In fact, I didn't know
> that this feature actually provided any benefit in that area.  

I thought Nick et.al came up with some of the constant values like batch
size to tackle the page coloring issue specifically.  In any case, I
think one of the key difference between 2.4 and 2.6 allocators is the
pcp list.  And even with the minuscule batch and high watermarks this is
helping ordinary benchmarks (by reducing the variation from run to run).

-rohit 

