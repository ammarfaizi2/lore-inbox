Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSI2NxW>; Sun, 29 Sep 2002 09:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSI2NxW>; Sun, 29 Sep 2002 09:53:22 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:23267 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262480AbSI2NxO>; Sun, 29 Sep 2002 09:53:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Manfred Spraul <manfred@colorfullife.com>, lse-tech@lists.sourceforge.net
Subject: Re: [PATH] slab cleanup
Date: Sun, 29 Sep 2002 09:56:51 -0400
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, akpm@digeo.com,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <3D96F559.2070502@colorfullife.com>
In-Reply-To: <3D96F559.2070502@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209290956.51619.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 29, 2002 08:43 am, Manfred Spraul wrote:
> I think we should make some cleanups before adding NUMA:

Exactly my thoughts.

> a) make the per-cpu arrays unconditional, even on UP.
> 	The arrays provides LIFO ordering, which should improve
> 	cache hit rates. The disadvantage is probably a higher
> 	internal fragmentation [not measured], but memory is cheap,
> 	and cache hit are important.
> 	In addition, this makes it possible to perform some cleanups.
> 	No more kmem_cache_alloc_one, for example.

This sounds like a very good idea.

> b) use arrays for all caches, even with large objects.
> 	E.g. right now, the 16 kB loopback socket buffers
> 	are not handled per-cpu.

Agree here also

> Nitin, in your NUMA patch, you return each "wrong-node" object
> immediately, without batching them together. Have you considered
> batching? It could reduce the number of spinlock operations dramatically.
>
> There is one additional problem without an obvious solution:
> kmem_cache_reap() is too inefficient. Before 2.5.39, it served 2 purposes:
>
> 1) return freeable slabs back to gfp.
>
> 	<2.5.39 scans through the caches in every try_to_free_pages.
> 	That scan is terribly inefficient, and akpm noticed lots of
> 	idle reschedules on the cache_chain_sem
>
> 	2.5.39 limits the freeable slabs list to one entry, and doesn't
> 	scan at all. On the one hand, this locks up one slab in each
> 	cache [in the worst case, a order=5 allocation]. For very
> 	bursty, slightly fragmented caches, it could lead to
> 	more kmem_cache_grow().
>
> 	My patch scans every 2 seconds, and return 80% of the pages.

I would rather eliminate the need for scanning and drop the cachep freelists.  Scanning
every two seconds, from a vm perspective, is probably not a good idea.  We want the
free pages to reach the vm asap - two seconds can be a long time, alternatly it can
be much to fast...  This fails to tie freeing slab memory to vm pressure.

If we need to, I would rather add intelligence to the object deletion path, insuring we 
keep enough slabps around to handle brustly use patterns.  The simpliest way to do 
this would be to add a field to cachep and use this to ensure this number of slabps 
are kept for the cache.  We could default this to zero and set if only for known 'important' 
caches.  It would be beter to make this self tuning though - need to be careful with
the hotpaths in this case.

> 2) regularly flush the per-cpu arrays
> 	<2.5.39 does that in every try_to_free_pages.
>
> 	My patch does that evey 2 seconds, on a random cpu.

Yes this needs to be done - missed this in slabasap...

> 	2.5.39 does that never. It probably reduces cpucache trashing
> 	[alloc batch of 120 objects, return one object, release
> 	batch of 119 objects due to th next try_to_free_pages]
> 	The problem is that without flushing, the cpuarrays can
> 	lock up lots of pages.[in the worst case, several thousand
> 	for each cpu].
>
> The attached patch is WIP:
> * boots on UP
> * partially boots with bochs [cpu simulator], until bochs locks up.
> * contains comments, where I'd add modifications for NUMA.
>
> What do you think?
> For NUMA, is it possible to figure out efficiently into which node a
> pointer points? That would happen in every kmem_cache_free().
>
> Could someone test that it works on real SMP?
>
> What the best replacement for kmem_cache_reap()? 2.5.39 contains
> obviously the simplest approach, but I'm not sure if it's the best.

It does allow quite a bit of code to be make redundent and seems to 
work OK in mm and there have not been complaints in linus (excepting the
kmem_cache_destroy bug).  It also can be extended to handle bursty 
caches that are usually near empty - if benchmarks show its required.

Now to see exactly how you implemented things.

Ed
