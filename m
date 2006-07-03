Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWGCAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWGCAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWGCAwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:52:41 -0400
Received: from hera.kernel.org ([140.211.167.34]:54747 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750865AbWGCAw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:52:26 -0400
Date: Sun, 2 Jul 2006 21:44:44 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, paulmck@us.ibm.com, nickpiggin@yahoo.com.au,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
Message-ID: <20060703004444.GA7688@dmt>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com> <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com> <20060628200942.6eea8ae5.akpm@osdl.org> <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jun 29, 2006 at 10:20:52AM -0700, Christoph Lameter wrote:
> On Wed, 28 Jun 2006, Andrew Morton wrote:
> 
> > > > It would be better to make the higher-level code register callbacks for
> > > > this sort of thing.  That code knows how to determine if an object is
> > > > freeable, can manage aging info, etc.
> > > 
> > > The destructor is such a callback.
> > 
> > I was, of course, referring to the unpleasant requirement that the object
> > layout start with an atomic_t.
> 
> Is that such a problem? It reduces the amount of indirect function calls 
> needed.

Need to benchmark I guess.

In the worst case, you can define a per-slab cache freeing function
which inlines the callbacks.

I agree with Andrew, an atomic counter to indicate usage of the objects
is too simplistic (other than being unpleasant).

> > > Since we free some dentries in each block they will be effectively be 
> > > moved because they get reallocated in a current slab block.
> > 
> > By performing a disk read.  That is not compaction - it is eviction.
> 
> Right. If we could directly migrate objects then it would be faster. Think 
> about this as swap migration. Later we can get more sophisticated.
> 
> > > The callback can make that determination and could trigger these events.
> > > The callback notifies the higher layers that it would be advantageous to 
> > > free this element. The higher layers can then analyze the situation and 
> > > either free or give up.
> > 
> > How do you propose handling the locking?  dcache is passed a bare pointer
> > and no locks are held, but it is guaranteed that the object won't be freed
> > while it's playing with it?
> 
> The reference counter can be used to insure that the object is not freed.

Locking is pretty tricky...

> > If so, take dcache_lock and then validate the object's current state in
> > some manner?
> 
> Right. I am not clear on how exactly to do that. These actions would need 
> to be particular to an object type. I just dealt with the slab 
> side of things and I think this is the bare minimum to get us started 
> along this road.
> 
> Got an enhanced version of it here but this is all not ready for prime 
> time and needs some more thought. Maybe we can talk about it in Ottawa.

Guys, I've tried something similar in the past

http://marc2.theaimsgroup.com/?l=linux-mm&m=112996161416875&w=2

What it does is to create a small set callbacks to invoke higher-level
code:

+struct slab_reclaim_ops {
+	int (*objp_is_freeable)(void *objp);
+	int (*objp_release)(void *objp);
+	int (*objp_lock)(void *objp);
+	int (*objp_unlock)(void *objp);
+};

Which are used by generic SLAB code to check for, and release, fully
freeable pages (you've seen it before, from last year). It contains a
dcache implementation.

You really need cache specific information, such as the tree nature of
dentry references.

Christoph, I'm afraid that not using the LRU information can be harmful
to certain workloads... 

But yeah, the current SLAB reclaim scheme is very dumb, lots of room for
improvement.
