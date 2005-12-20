Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVLTTph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVLTTph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVLTTph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:45:37 -0500
Received: from waste.org ([64.81.244.121]:8112 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751033AbVLTTpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:45:36 -0500
Date: Tue, 20 Dec 2005 13:43:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051220194350.GH3356@waste.org>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135106124.13138.339.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 02:15:24PM -0500, Steven Rostedt wrote:
> On Tue, 2005-12-20 at 12:19 -0600, Matt Mackall wrote:
> > On Tue, Dec 20, 2005 at 10:44:20AM -0500, Steven Rostedt wrote:
> > > (Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)
> > > 
> > > OK Ingo, here it is.
> > > 
> > > The old SLOB did the old K&R memory allocations.
> > > 
> > > It had a global link list "slobfree".  When it needed memory it would
> > > search this list linearly to find the first spot that fit and then
> > > return it.  It was broken up into SLOB_UNITS which was the number of
> > > bytes to hold slob_t.
> > > 
> > > Since the sizes of the allocations would greatly fluctuate, the chances
> > > for fragmentation was very high.  This would also cause the looking for
> > > free locations to increase, since the number of free blocks would also
> > > increase due to the fragmentation.
> > 
> > On the target systems for the original SLOB design, we have less than
> > 16MB of memory, so the linked list walking is pretty well bounded.
> 
> I bet after a while of running, your performance will still suffer due
> to fragmentation.  The more fragmented it is, the more space you lose
> and the more steps you need to walk.
> 
> Remember, because of the small stack, kmalloc and kfree are used an
> awful lot.  And if you slow those down, you will start to take a big hit
> in performance.

True, with the exception that the improved packing may be the
difference between fitting the working set in memory and
thrashing/OOMing for some applications. Not running at all =
infinitely bad performance.

And the fragmentation is really not all that bad. Remember, Linux and
other legacy systems used similar allocators for ages.
 
> Ingo can answer this better himself, but I have a feeling he jumped to
> your SLOB system just because of the simplicity.

And only a config switch away..

> > This I like a lot. I'd like to see a size/performance measurement of
> > this by itself. I suspect it's an unambiguous win in both categories.
> 
> Actually the performance gain was disappointingly small.  As it was a
> separate patch and I though it would gain a lot.  But if IIRC, it only
> increased the speed by a second or two (of the 1 minute 27 seconds).
> That's why I spent so much time in the next approach.

Still, if it's a size win, it definitely makes sense to merge.
Removing the big block list lock is also a good thing and might make a
bigger difference on SMP.
 
> > > The next patch was the big improvement, with the largest changes.  I
> > > took advantage of how the kmem_cache usage that SLAB also takes
> > > advantage of.  I created a memory pool like the global one, but for
> > > every cache with a size less then PAGE_SIZE >> 1.
> > 
> > Hmm. By every size, I assume you mean powers of two. Which negates
> > some of the fine-grained allocation savings that current SLOB provides.
> 
> Yeah its the same as what the slabs use.  But I would like to take
> measurements of a running system between the two approaches.  After a
> day of heavy network traffic, see what the fragmentation is like and how
> much is wasted.  This would require me finishing my cache_chain work,
> and adding something similar to your SLOB.
> 
> But the powers of two is only for the kmalloc, which this is a know
> behavior of the current system.  So it <should> only be used for things
> that would alloc and free within a quick time (like for things you would
> like to put on a stack but cant), or the size is close to (less than or
> equal) a power of two.  Otherwise a kmem_cache is made which is the size
> of expected object (off by UNIT_SIZE).

There are a fair number of long-lived kmalloc objects. You might try
playing with the kmalloc accounting patch in -tiny to see what's out
there.

http://www.selenic.com/repo/tiny?f=bbcd48f1d9c1;file=kmalloc-accounting.patch;style=raw

> Oh, this reminds me, I probably still need to add a shrink cache
> algorithm.  Which would be very hard to do in the current SLOB.

Hmmm? It already has one.

> > For what it's worth, I think we really ought to consider a generalized
> > allocator approach like Sun's VMEM, with various removable pieces.
> 
> Interesting, I don't know how Sun's VMEM works.  Do you have links to
> some documentation?

http://citeseer.ist.psu.edu/bonwick01magazines.html

> That looks like quite an undertaking, but may be well worth it.  I think
> Linux's memory management is starting to show it's age.  It's been
> through a few transformations, and maybe it's time to go through
> another.  The work being done by the NUMA folks, should be taking into
> account, and maybe we can come up with a way that can make things easier
> and less complex without losing performance.

Fortunately, it can be done completely piecemeal. 

> BTW, the NUMA code in the slabs was the main killer for the RT
> conversion.

I think the VMEM scheme avoids that problem to some degree, but I
might be wrong.

-- 
Mathematics is the supreme nostalgia of our time.
