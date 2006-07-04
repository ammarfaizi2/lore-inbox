Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWGDBrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWGDBrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWGDBrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:47:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59327 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751224AbWGDBrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:47:10 -0400
Date: Mon, 3 Jul 2006 18:46:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Marcelo Tosatti <marcelo@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, paulmck@us.ibm.com, nickpiggin@yahoo.com.au,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
In-Reply-To: <20060703231103.GA5160@dmt>
Message-ID: <Pine.LNX.4.64.0607031837280.10292@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com>
 <20060628200942.6eea8ae5.akpm@osdl.org> <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
 <20060703004444.GA7688@dmt> <Pine.LNX.4.64.0607031058400.26397@schroedinger.engr.sgi.com>
 <20060703231103.GA5160@dmt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006, Marcelo Tosatti wrote:

> > I think is pretty obvious. With atomic refcounters you can simply scan
> > a slab for unused objects without any callbacks. Needing a callback for 
> > every single object is a waste of resources and will limit reclaim 
> > efficiency. You would have to do 120 callbacks on some slabs just to 
> > figure out that it is worth trying to free objects in that 
> > particular slab block.
> 
> Inline the callbacks into a per-cache kmem_cache_reclaim ?

You mean the user writes the check functions? Can you give an example how 
inlining is supposed to work here?

> > Cannot see a valid reason so far to draw that conclusion. With the right 
> > convention the atomic refcounter can be used as an indicator that the 
> > object is being freed (refcnt = 0), not in use (refcnt = 1) or in active 
> > use (refcnt=2). The easy and efficient access to this kind of knowledge 
> > about an object is essential for reclaim.
> 
> But the assumption that "refcnt = 1 implies unused object" is too weak.
> 
> For example, 
> 
> struct dentry {
>         atomic_t d_count;
>         unsigned int d_flags;           /* protected by d_lock */
> 
> d_count can be higher than one _and_ the object freeable. Think of
> workloads operating on a large number of directories.

The scheme that I proposed implies that the refcount handling is changed.
It must be uniform for all object types that use reclaim.

If used for the dcache then dentry handling must be changed so that the 
refcount at the beginnDing of the slab is 1 if the object is reclaimable 
and the higher refcount needs to be an indicator that the object is in 
use. I am not saying that existing use gets us there. Maybe we need to 
call this a reclaim flag instead of a refcount?

> Andrew mentioned:
> 
> "That seems like quite a drawback. A single refcount=2 object on the
> page means that nothing gets freed from that page at all. It'd be easy
> (especially with dcache) to do tons of work without achieving anything."

We can check for a single high count object in a slab and then call
the destructor if we feel that is warranted. The refcount is an 
indicator to the slab of the reclaim status of the object.

> > Ok. I will have a look at that. But these callbacks are too heavy for my 
> > taste. A refcounter could avoid all of that.
> 
> Inline them.

"Inline" seem to be way to say that the user has to provide the function.

> > Of course there is the challenge of preserving the LRU like behavior using 
> > the slab lists. But I think it may be sufficiently approximated by the 
> > LRU ness of the used slab list and the push back to the partial lists 
> > whenever we touch a slab during reclaim (we free some objects so the slab 
> > has to move).
> 
> Well, individual object usage is not reflected at all in the slab lists,
> is it?

Correct. We would have to treat objects in a slab all the same. We could 
just kick out some if we find the slab at the end of the list and see how 
things develop. Pretty bare hacky LRU but it may be better than going 
through huge lists of small objects on a LRU lists.
