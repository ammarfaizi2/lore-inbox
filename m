Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWGCSKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWGCSKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGCSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:10:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5357 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932071AbWGCSKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:10:33 -0400
Date: Mon, 3 Jul 2006 11:10:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Marcelo Tosatti <marcelo@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, paulmck@us.ibm.com, nickpiggin@yahoo.com.au,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
In-Reply-To: <20060703004444.GA7688@dmt>
Message-ID: <Pine.LNX.4.64.0607031058400.26397@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com>
 <20060628200942.6eea8ae5.akpm@osdl.org> <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
 <20060703004444.GA7688@dmt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006, Marcelo Tosatti wrote:

> > > I was, of course, referring to the unpleasant requirement that the object
> > > layout start with an atomic_t.
> > 
> > Is that such a problem? It reduces the amount of indirect function calls 
> > needed.
> 
> Need to benchmark I guess.

I think is pretty obvious. With atomic refcounters you can simply scan
a slab for unused objects without any callbacks. Needing a callback for 
every single object is a waste of resources and will limit reclaim 
efficiency. You would have to do 120 callbacks on some slabs just to 
figure out that it is worth trying to free objects in that 
particular slab block.
 
> I agree with Andrew, an atomic counter to indicate usage of the objects
> is too simplistic (other than being unpleasant).

Cannot see a valid reason so far to draw that conclusion. With the right 
convention the atomic refcounter can be used as an indicator that the 
object is being freed (refcnt = 0), not in use (refcnt = 1) or in active 
use (refcnt=2). The easy and efficient access to this kind of knowledge 
about an object is essential for reclaim.

> > > How do you propose handling the locking?  dcache is passed a bare pointer
> > > and no locks are held, but it is guaranteed that the object won't be freed
> > > while it's playing with it?
> > 
> > The reference counter can be used to insure that the object is not freed.
> 
> Locking is pretty tricky...

Not at all. You do an atomic_inc_if_not_zero from the destructor and then 
either will hold the object to good or you were unable to increment the 
refcount and therefore you can give up and return because the object 
is already being freed.

The tricky locking part comes later when the destructor has to establish 
the locks to get all links to the object released.

> What it does is to create a small set callbacks to invoke higher-level
> code:
> 
> +struct slab_reclaim_ops {
> +	int (*objp_is_freeable)(void *objp);
> +	int (*objp_release)(void *objp);
> +	int (*objp_lock)(void *objp);
> +	int (*objp_unlock)(void *objp);
> +};
> 
> Which are used by generic SLAB code to check for, and release, fully
> freeable pages (you've seen it before, from last year). It contains a
> dcache implementation.

Ok. I will have a look at that. But these callbacks are too heavy for my 
taste. A refcounter could avoid all of that.

> You really need cache specific information, such as the tree nature of
> dentry references.

Only the cache knows that. The cache provides a destructo. In that 
destructor the tree nature of the dentries can be considered. The 
destructor knows about the tree nature of the slab and that can navigate 
through the dependency structures that the object may be a part of.

> Christoph, I'm afraid that not using the LRU information can be harmful
> to certain workloads... 

It can be very beneficial too since removing the LRU will avoid locking in 
certain situations and it will shrink the objects. We already have lists 
of all the objects in the slab. The LRU is redundant in some way.

Of course there is the challenge of preserving the LRU like behavior using 
the slab lists. But I think it may be sufficiently approximated by the 
LRU ness of the used slab list and the push back to the partial lists 
whenever we touch a slab during reclaim (we free some objects so the slab 
has to move).
