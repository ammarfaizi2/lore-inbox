Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318331AbSHEHko>; Mon, 5 Aug 2002 03:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSHEHko>; Mon, 5 Aug 2002 03:40:44 -0400
Received: from reload.namesys.com ([212.16.7.75]:65173 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S318331AbSHEHkm>; Mon, 5 Aug 2002 03:40:42 -0400
Date: Mon, 5 Aug 2002 11:44:17 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Andreas Gruenbacher <agruen@suse.de>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       "tomlins @ cam. org lkml" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
Message-ID: <20020805074417.GA28911@reload.namesys.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Andreas Gruenbacher <agruen@suse.de>, Alan Cox <alan@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	"tomlins @ cam. org lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208041202390.10314-100000@home.transmeta.com> <3D4D7DAF.8080309@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4D7DAF.8080309@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 11:17:03PM +0400, Hans Reiser wrote:
> Linus Torvalds wrote:
> 
> >On Sun, 4 Aug 2002, Rik van Riel wrote:
> > 
> >
> >>>In particular, it is useless for the sub-caches to try to maintain their
> >>>own LRU lists and their own accessed bits. But that doesn't mean that
> >>>they can _act_ as if they updated their own accessed bits, while really
> >>>just telling the page-based thing that that page is active.
> >>>     
> >>>
> >>I'm not sure I agree with this.  For eg. the dcache you will want
> >>to reclaim the less used entries on a page even if there are a few
> >>very intensely used entries on that page.
> >>   
> >>
> >
> >True in theory, but I doubt you will see it very much in practice. 
> >
> >Most of the time when you want to free dentries, it is because you have a 
> >_ton_ of them. 
> >
> >The fact that some will look cold even if they aren't should not matter 
> >that much statistically.
> >
> >Yah, it's a guess. We can test it.
> >
> >		Linus
> >
> >
> >
> > 
> >
> Josh tested it.  He posted on it.  I'll have him find his original post 
> and repost tomorrow, but summarized in brief, the current dcache 
> shrinking/management approach was quite inefficient.  Each active dcache 
> entry kept a whole lot of dead ones around.

It seems the rmap+slab-LRU patches work to address this problem, but even with
those patches applied Ed Tomlinson's test shows a ~50% utilization of dcache
slab pages under memory pressure.  My original test on 2.4.18 showed a ~25%
utilization under memory pressure, so the slab-LRU patches definetly show an
improvement.  In practice and theory, we see that the slab caches are
inefficient at using memory under pressure, so probably there is more work to
be done.  Ed's posted results:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=01041309360100.32757%40oscar

Here is the text of the message that Hans refers to:

http://groups.google.com/groups?q=g:thl2323088796d&dq=&hl=en&lr=&ie=UTF-8&selm=20020128091338.D6578%40helen.CS.Berkeley.EDU

--

When memory pressure becomes high, the Linux kswapd begins calling
shrink_caches() from try_to_free_pages() with an integer priority from
6 (the default, lowest priority) to 1 (high priority).  Looking
specifically at the dcache, this results in a calls to
shrink_dcache_memory() that attempt to free a fraction (1/priority) of
the inactive dcache entries.  This ultimately leads to prune_dcache()
scanning the dcache in least-recently-used order attempting to call
kmem_cache_free() on some number of dcache entries.

Dcache entries are allocated from the kmem_slab_cache, which manages
objects in page-size "slabs", but the kmem_slab_cache cannot free a
page until every object in a slab becomes unused.  The problem is that
freeing dcache entries in LRU-order is effectively freeing entries
from randomly-selected slabs, and therefore applying shrink_caches()
pressure to the dcache has an undesired result.  In the attempt to
reduce its size, the dcache must free objects from random slabs in 
order to actually release full pages.  The result is that under high
memory pressure the dcache utilization drops dramatically.  The
prune_dcache() mechanism doesn't just reduce the page utilization as
desired, it reduces the intra-page utilization, which is bad.

In order to measure this effect (via /proc/slabinfo) I first populated
a large dcache and then ran a memory-hog to force swapping to occur.
The dcache utilization drops to between 20-35%.  For example, before
running the memory-hog my dcache reports:

dentry_cache       10170  10170    128  339  339    1 :  252  126

(i.e., 10170 active dentry objects, 10170 available dentry objects @
128 bytes each, 339 pages with at least one object, and 339 allocated
pages, an approximately 1.4MB dcache)

While running the memory-hog program to initiate swapping, the dcache
stands at:

dentry_cache         693   3150    128  105  105    1 :  252  126

Meaning, the randomly-applied cache pressure was successful at freeing
234 (= 339-105) pages, leaving a 430KB dcache, but at the same time it
reduced the cache utilization to 22%, meaning that although it was
able to free nearly 1MB of space, 335KB are now wasted as a result of
the high memory-pressure condition.

So, it would seem that the dcache and kmem_slab_cache memory allocator
could benefit from a way to shrink the dcache in a less random way.
Any thoughts?

