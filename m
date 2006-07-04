Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWGDCL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWGDCL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 22:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWGDCL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 22:11:57 -0400
Received: from hera.kernel.org ([140.211.167.34]:41695 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750781AbWGDCL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 22:11:56 -0400
Date: Mon, 3 Jul 2006 23:07:59 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, paulmck@us.ibm.com, nickpiggin@yahoo.com.au,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
Message-ID: <20060704020759.GB9212@dmt>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com> <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com> <20060628200942.6eea8ae5.akpm@osdl.org> <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com> <20060703004444.GA7688@dmt> <Pine.LNX.4.64.0607031058400.26397@schroedinger.engr.sgi.com> <20060703231103.GA5160@dmt> <Pine.LNX.4.64.0607031837280.10292@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607031837280.10292@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 06:46:55PM -0700, Christoph Lameter wrote:
> On Mon, 3 Jul 2006, Marcelo Tosatti wrote:
> 
> > > I think is pretty obvious. With atomic refcounters you can simply scan
> > > a slab for unused objects without any callbacks. Needing a callback for 
> > > every single object is a waste of resources and will limit reclaim 
> > > efficiency. You would have to do 120 callbacks on some slabs just to 
> > > figure out that it is worth trying to free objects in that 
> > > particular slab block.
> > 
> > Inline the callbacks into a per-cache kmem_cache_reclaim ?
> 
> You mean the user writes the check functions? Can you give an example how 
> inlining is supposed to work here?

I meant per-cache kmem_cache_reclaim (user-provided function). "Inline"
is confusing, sorry.

> > > Cannot see a valid reason so far to draw that conclusion. With the right 
> > > convention the atomic refcounter can be used as an indicator that the 
> > > object is being freed (refcnt = 0), not in use (refcnt = 1) or in active 
> > > use (refcnt=2). The easy and efficient access to this kind of knowledge 
> > > about an object is essential for reclaim.
> > 
> > But the assumption that "refcnt = 1 implies unused object" is too weak.
> > 
> > For example, 
> > 
> > struct dentry {
> >         atomic_t d_count;
> >         unsigned int d_flags;           /* protected by d_lock */
> > 
> > d_count can be higher than one _and_ the object freeable. Think of
> > workloads operating on a large number of directories.
> 
> The scheme that I proposed implies that the refcount handling is changed.
> It must be uniform for all object types that use reclaim. 
>
> If used for the dcache then dentry handling must be changed so that the 
> refcount at the beginnDing of the slab is 1 if the object is reclaimable 
> and the higher refcount needs to be an indicator that the object is in 
> use. I am not saying that existing use gets us there. Maybe we need to 
> call this a reclaim flag instead of a refcount?

I think the cache has to decide...

> > Andrew mentioned:
> > 
> > "That seems like quite a drawback. A single refcount=2 object on the
> > page means that nothing gets freed from that page at all. It'd be easy
> > (especially with dcache) to do tons of work without achieving anything."
> 
> We can check for a single high count object in a slab and then call
> the destructor if we feel that is warranted. The refcount is an 
> indicator to the slab of the reclaim status of the object.
> 
> > > Ok. I will have a look at that. But these callbacks are too heavy for my 
> > > taste. A refcounter could avoid all of that.
> > 
> > Inline them.
> 
> "Inline" seem to be way to say that the user has to provide the function.

Yes.

> > > Of course there is the challenge of preserving the LRU like behavior using 
> > > the slab lists. But I think it may be sufficiently approximated by the 
> > > LRU ness of the used slab list and the push back to the partial lists 
> > > whenever we touch a slab during reclaim (we free some objects so the slab 
> > > has to move).
> > 
> > Well, individual object usage is not reflected at all in the slab lists,
> > is it?
> 
> Correct. We would have to treat objects in a slab all the same. We could 
> just kick out some if we find the slab at the end of the list and see how 
> things develop. Pretty bare hacky LRU but it may be better than going 
> through huge lists of small objects on a LRU lists.

Yep... Did you try this?

