Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWF2RVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWF2RVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWF2RVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:21:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62667 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751077AbWF2RVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:21:23 -0400
Date: Thu, 29 Jun 2006 10:20:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, marcelo@kvack.org,
       paulmck@us.ibm.com, nickpiggin@yahoo.com.au, tytso@mit.edu, dgc@sgi.com,
       ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
In-Reply-To: <20060628200942.6eea8ae5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com>
 <20060628200942.6eea8ae5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Andrew Morton wrote:

> > > It would be better to make the higher-level code register callbacks for
> > > this sort of thing.  That code knows how to determine if an object is
> > > freeable, can manage aging info, etc.
> > 
> > The destructor is such a callback.
> 
> I was, of course, referring to the unpleasant requirement that the object
> layout start with an atomic_t.

Is that such a problem? It reduces the amount of indirect function calls 
needed.

> > Since we free some dentries in each block they will be effectively be 
> > moved because they get reallocated in a current slab block.
> 
> By performing a disk read.  That is not compaction - it is eviction.

Right. If we could directly migrate objects then it would be faster. Think 
about this as swap migration. Later we can get more sophisticated.

> > The callback can make that determination and could trigger these events.
> > The callback notifies the higher layers that it would be advantageous to 
> > free this element. The higher layers can then analyze the situation and 
> > either free or give up.
> 
> How do you propose handling the locking?  dcache is passed a bare pointer
> and no locks are held, but it is guaranteed that the object won't be freed
> while it's playing with it?

The reference counter can be used to insure that the object is not freed.

> If so, take dcache_lock and then validate the object's current state in
> some manner?

Right. I am not clear on how exactly to do that. These actions would need 
to be particular to an object type. I just dealt with the slab 
side of things and I think this is the bare minimum to get us started 
along this road.

Got an enhanced version of it here but this is all not ready for prime 
time and needs some more thought. Maybe we can talk about it in Ottawa.

