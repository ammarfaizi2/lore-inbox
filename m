Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWF2Akd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWF2Akd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWF2Akd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:40:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932095AbWF2Akc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:40:32 -0400
Date: Wed, 28 Jun 2006 17:43:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, marcelo@kvack.org,
       paulmck@us.ibm.com, nickpiggin@yahoo.com.au, clameter@sgi.com,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
Message-Id: <20060628174329.20adbc2a.akpm@osdl.org>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> We currently have a set of problem with slab reclaim:
> 
> 1. On a NUMA system there are excessive cross node accesses.
>    Locks are taken remotely which leads to a significant slowdown
>    if concurrent reclaim is performeed on the dcache/icache from
>    a number of nodes.
> 
> 2. We need to free an excessive number of elements from the LRU
>    in order to reclaim enough pages from the slab.
> 
> 3. After reclaim we have a large number of sparsely used slab
>    objects.
> 
> The fundamental problem in the current reclaim approaches with the
> icache/dcache is that the reclaim is LRU and object based. Multiple
> objects can share the same slab. So removing one object from a slab
> just removes some cache information that may have been useful later
> but may not give us what we want: More free pages.
> 
> I propose that we replace the LRU based object management by using
> the slab oriented lists in the slab allocator itself for reclaim.
> 
> The slab allocator already has references to all pages used by the
> dcache and icache. It has awareness of which objects are located
> in a certain slab and therefore would be able to free specific
> objects that would make pages freeable if the slab knew
> their state.
> 
> In order to allow the slab allocator to know about an objects
> state we add another flag SLAB_RECLAIM. SLAB_RECLAIM means that
> the following is true of a slab:
> 
> 1. The object contains a reference counter of atomic_t as the
>    first element that follows the following conventions:
> 
>    Counter = 0	-> Object is being freed or is free.
>    Counter = 1  -> Object is not used and contains cache information.
>    		   The object may be freed.
> 
>    Counter > 1	-> Object is in use and cannot be freed.
> 
> 2. A destructor was provided during kmem_cache_create().
>    If SLAB_DTOR_FREE is passed in the flags of the destructor
>    then a best effort attempt will be made to free that object.
> 

It would be better to make the higher-level code register callbacks for
this sort of thing.  That code knows how to determine if an object is
freeable, can manage aging info, etc.

> Memory can then be reclaimed from a slab by calling
> 
> kmem_cache_reclaim(kmem_cache_t *cachep, unsigned long page)
> 
> kmem_cache_reclaim returns an error code or the number of pages reclaimed.
> 
> 
> The reclaim works by walking through the lists of full and partially
> allocated slabs. We begin at the end of thet fully allocated slabs because
> these slabs have been around for a long time (This basically preserves the LRU
> lists to some extend).
> 
> For slab we check all the objects in the slab. If all object have
> a refcount of one then we free all the objects and return the pages of the
> object to the page allocator.

That seems like quite a drawback.  A single refcount=2 object on the page
means that nothing gets freed from that page at all.  It'd be easy
(especially with dcache) to do tons of work without achieving anything.

So it might be better to drop the freeable objects from the page even if
the page has non-freeable objects.  If only because this might make
directory dentries on _other_ pages reclaimable.

But that won't really help much, because the basic problem remains
unsolved: internal fragmentation.

The proposed approach doesn't really solve internal fragmentation.  To do
that we'd need to either:

a) compact dentries by copying them around or, perhaps,

b) make dentry reclaim be guided by the dcache tree: do a bottom-up
   reclaim, or a top-down reclaim when we hit a directory, etc.  Something
   which understands the graph rather than the plain global LRU.



I expect this patchset's approach will help, but I also expect there will
be pathological dcache internal fragmentation patterns (whch can occur
fairly easily) in which it won't help much at all.

