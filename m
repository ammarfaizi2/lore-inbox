Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbULAE6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbULAE6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbULAE6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:58:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48858 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261241AbULAE6H
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:58:07 -0500
Date: Tue, 30 Nov 2004 20:57:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, nikita@clusterfs.com,
       Linux-Kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-ID: <20041130225707.GA2315@dmt.cyclades>
References: <16800.47044.75874.56255@gargle.gargle.HOWL> <20041126185833.GA7740@logos.cnet> <41A7CC3D.9030405@yahoo.com.au> <20041130162956.GA3047@dmt.cyclades> <20041130173323.0b3ac83d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130173323.0b3ac83d.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 05:33:23PM -0800, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Because the ordering of LRU pages should be enhanced in respect to locality, 
> >  with the mark_page_accessed batching you group together tasks accessed pages 
> >  and move them at once to the active list. 
> > 
> >  You maintain better locality ordering, while decreasing the precision of aging/
> >  temporal locality.
> > 
> >  Which should enhance disk writeout performance.
> 
> I'll buy that explanation.  Although I'm a bit sceptical that it is
> measurable.

Its just a theory that makes sense to me, but yes we need to be measure it.

> Was that particular workload actually performing significant amounts of
> writeout in vmscan.c?  (We should have direct+kswapd counters for that, but
> we don't.  /proc/vmstat:pgrotated will give us an idea).

I strongly believe so, its a memory hungry benchmark - I'll collect status later 
on this week or the next.

> >  On the other hand, without batching you mix the locality up in LRU - the LRU becomes 
> >  more precise in terms of "LRU aging", but less ordered in terms of sequential 
> >  access pattern.
> > 
> >  The disk IO intensive reaim has very significant gain from the batching, its
> >  probably due to the enhanced LRU ordering (what Nikita says).
> > 
> >  The slowdown is probably due to the additional atomic_inc by page_cache_get(). 
> > 
> >  Is there no way to avoid such page_cache_get there (and in lru_cache_add also)?
> 
> Not really.  The page is only in the pagevec at that time - if someone does
> a put_page() on it the page will be freed for real, and will then be
> spilled onto the LRU.  Messy. 

We could handle such situation on allocation and during vmscan - maybe its doable.
Just pondering, maybe its indeed too messy to even ponder about.

