Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULAAjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULAAjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbULAAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:35:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261244AbULAA1I
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:27:08 -0500
Date: Tue, 30 Nov 2004 14:29:56 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <AKPM@Osdl.ORG>,
       Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-ID: <20041130162956.GA3047@dmt.cyclades>
References: <16800.47044.75874.56255@gargle.gargle.HOWL> <20041126185833.GA7740@logos.cnet> <41A7CC3D.9030405@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A7CC3D.9030405@yahoo.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 11:37:17AM +1100, Nick Piggin wrote:
> Marcelo Tosatti wrote:
> >On Sun, Nov 21, 2004 at 06:44:04PM +0300, Nikita Danilov wrote:
> >
> >>Batch mark_page_accessed() (a la lru_cache_add() and 
> >>lru_cache_add_active()):
> >>page to be marked accessed is placed into per-cpu pagevec
> >>(page_accessed_pvec). When pagevec is filled up, all pages are processed 
> >>in a
> >>batch.
> >>
> >>This is supposed to decrease contention on zone->lru_lock.
> >
> >
> >Here are the STP 8way results:
> >
> >8way:
> >
> 
> ...
> 
> >kernbench 
> >
> >Decreases performance significantly (on -j4 more notably), probably due to 
> >the additional atomic operations as noted by Andrew:
> >
> >kernel: nikita-b2                               kernel: patch-2.6.10-rc2
> >Host: stp8-002                                  Host: stp8-003
> >
> 
> ...
> 
> >
> >Average Half Load -j 4 Run:                     Average Half Load -j 4 Run:
> >Elapsed Time 274.916                            Elapsed Time 245.026
> >User Time 833.63                                User Time 832.34
> >System Time 73.704                              System Time 73.41
> >Percent CPU 335.8                               Percent CPU 373.6
> >Context Switches 12984.8                        Context Switches 13427.4
> >Sleeps 21459.2                                  Sleeps 21642
> 
> Do you think looks like it may be a CPU scheduling or disk/fs artifact?
> Neither user nor system time are significantly worse, while the vanilla
> kernel is using a lot more of the CPUs' power (ie waiting for IO less,
> or becoming idle less often due to CPU scheduler balancing).

Nick,

I do not think it is a disk/fs artifact.

Because the ordering of LRU pages should be enhanced in respect to locality, 
with the mark_page_accessed batching you group together tasks accessed pages 
and move them at once to the active list. 

You maintain better locality ordering, while decreasing the precision of aging/
temporal locality.

Which should enhance disk writeout performance.

On the other hand, without batching you mix the locality up in LRU - the LRU becomes 
more precise in terms of "LRU aging", but less ordered in terms of sequential 
access pattern.

The disk IO intensive reaim has very significant gain from the batching, its
probably due to the enhanced LRU ordering (what Nikita says).

The slowdown is probably due to the additional atomic_inc by page_cache_get(). 

Is there no way to avoid such page_cache_get there (and in lru_cache_add also)?

> Aside: under-load conditions like this is actually something where the
> CPU scheduler doesn't do brilliantly at currently. I attribute this to
> probably most "performance tests" loading it up as much as possible.
> I am (on and off) looking at improving performance in these conditions,
> and am making some inroads. 


