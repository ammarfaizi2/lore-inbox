Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULAMYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULAMYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 07:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbULAMYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 07:24:04 -0500
Received: from [213.85.13.118] ([213.85.13.118]:1665 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261377AbULAMX7 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 07:23:59 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16813.47036.476553.612418@gargle.gargle.HOWL>
Date: Wed, 1 Dec 2004 15:23:24 +0300
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
In-Reply-To: <20041130173323.0b3ac83d.akpm@osdl.org>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
	<20041126185833.GA7740@logos.cnet>
	<41A7CC3D.9030405@yahoo.com.au>
	<20041130162956.GA3047@dmt.cyclades>
	<20041130173323.0b3ac83d.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
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

cluster-pageout.patch that was sent together with
mark_page_accessed-batching.patch has roughly similar effect: page-out
is done in file order, ignoring local LRU order at end of the inactive
list. It did improve performance in page-out intensive micro-benchmark:

Averaged number of microseconds it takes to dirty 1GB of
16-times-larger-than-RAM ext3 file mmaped in 1GB chunks:

without-patch:   average:    74188417.156250
               deviation:    10538258.613280

   with-patch:   average:    69449001.583333
               deviation:    12621756.615280

 > 
 > Was that particular workload actually performing significant amounts of
 > writeout in vmscan.c?  (We should have direct+kswapd counters for that, but
 > we don't.  /proc/vmstat:pgrotated will give us an idea).
 > 
 > 
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

I don't think that atomic_inc will be particularly
costly. generic_file_{write,read}() call find_get_page() just before
calling mark_page_accessed(), so cache-line with page reference counter
is most likely still exclusive owned by this CPU.

Nikita.
