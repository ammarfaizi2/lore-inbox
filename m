Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVKWT7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVKWT7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVKWT7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:59:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932131AbVKWT7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:59:17 -0500
Date: Wed, 23 Nov 2005 11:55:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: clameter@engr.sgi.com, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
Message-Id: <20051123115545.69087adf.akpm@osdl.org>
In-Reply-To: <1132775194.25086.54.camel@akash.sc.intel.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	<Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	<1132775194.25086.54.camel@akash.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> On Wed, 2005-11-23 at 11:30 -0800, Christoph Lameter wrote:
> > On Tue, 22 Nov 2005, Rohit Seth wrote:
> > 
> > > [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> > > local pcp lists when a higher order allocation request is not able to 
> > > get serviced from global free_list.
> > 
> > Ummm.. One controversial idea: How about removing the complete pcp 
> > subsystem? Last time we disabled pcps we saw that the effect 
> > that it had was within noise ratio on AIM7. The lru lock taken without 
> > pcp is in the local zone and thus rarely contended.
> 
> Oh please stop.
> 
> This per_cpu_pagelist is one great logic that has got added in
> allocator.  Besides providing pages without the need to acquire the zone
> lock, it is one single main reason the coloring effect is drastically
> reduced in 2.6 (over 2.4) based kernels.
> 

hm.  Before it was merged in 2.5.x, the feature was very marginal from a
performance POV in my testing on 4-way.

I was able to demonstrate a large (~60%?) speedup in one microbenckmark
which consisted of four processes writing 16k to a file and truncating it
back to zero again.  That gain came from the cache warmth effect, which is
the other benefit which these cpu-local pages are supposed to provide.

I don't think Martin was able to demonstrate much benefit from the lock
contention reduction on 16-way NUMAQ either.

So I dithered for months and it was a marginal merge, so it's appropriate
to justify the continued presence of the code.

We didn't measure for any coloring effects though.  In fact, I didn't know
that this feature actually provided any benefit in that area.  
