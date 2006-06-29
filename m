Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWF2Ari@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWF2Ari (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWF2Ari
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:47:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9378 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932102AbWF2Arh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:47:37 -0400
Date: Wed, 28 Jun 2006 17:47:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, marcelo@kvack.org,
       paulmck@us.ibm.com, nickpiggin@yahoo.com.au, tytso@mit.edu, dgc@sgi.com,
       ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
In-Reply-To: <20060628174329.20adbc2a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060628174329.20adbc2a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Andrew Morton wrote:

> > 2. A destructor was provided during kmem_cache_create().
> >    If SLAB_DTOR_FREE is passed in the flags of the destructor
> >    then a best effort attempt will be made to free that object.
> > 
> 
> It would be better to make the higher-level code register callbacks for
> this sort of thing.  That code knows how to determine if an object is
> freeable, can manage aging info, etc.

The destructor is such a callback.

> > For slab we check all the objects in the slab. If all object have
> > a refcount of one then we free all the objects and return the pages of the
> > object to the page allocator.
> 
> That seems like quite a drawback.  A single refcount=2 object on the page
> means that nothing gets freed from that page at all.  It'd be easy
> (especially with dcache) to do tons of work without achieving anything.

We will always reclaim a few object from each page. See the patch.

Single refcount=2 objects could also be detected and we could try to free 
them.

> a) compact dentries by copying them around or, perhaps,

Since we free some dentries in each block they will be effectively be 
moved because they get reallocated in a current slab block.

> b) make dentry reclaim be guided by the dcache tree: do a bottom-up
>    reclaim, or a top-down reclaim when we hit a directory, etc.  Something
>    which understands the graph rather than the plain global LRU.

The callback can make that determination and could trigger these events.
The callback notifies the higher layers that it would be advantageous to 
free this element. The higher layers can then analyze the situation and 
either free or give up.

