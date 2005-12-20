Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLTUGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLTUGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVLTUGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:06:53 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:5559 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932069AbVLTUGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:06:53 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051220194350.GH3356@waste.org>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
	 <1135106124.13138.339.camel@localhost.localdomain>
	 <20051220194350.GH3356@waste.org>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 15:06:30 -0500
Message-Id: <1135109190.13138.364.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 13:43 -0600, Matt Mackall wrote:
> > 
> > I bet after a while of running, your performance will still suffer due
> > to fragmentation.  The more fragmented it is, the more space you lose
> > and the more steps you need to walk.
> > 
> > Remember, because of the small stack, kmalloc and kfree are used an
> > awful lot.  And if you slow those down, you will start to take a big hit
> > in performance.
> 
> True, with the exception that the improved packing may be the
> difference between fitting the working set in memory and
> thrashing/OOMing for some applications. Not running at all =
> infinitely bad performance.

Well the best way to see, is to try it out with real applications on
small machines.  I guess I need to pull out my IBM Thinkpad 75c (32
megs, I'll need to only allocate half) and try out the two and see how
far I can push it.  Unfortunately, this test may need to wait, since I
have a ton of other things to push out first.

If someone else (perhaps yourself) would like to give my patches a try,
I would be really appreciate it. :)

> 
> And the fragmentation is really not all that bad. Remember, Linux and
> other legacy systems used similar allocators for ages.

But the performance, was greatly reduced, and the system just booted up.

>  
> > Ingo can answer this better himself, but I have a feeling he jumped to
> > your SLOB system just because of the simplicity.
> 
> And only a config switch away..
> 
> > > This I like a lot. I'd like to see a size/performance measurement of
> > > this by itself. I suspect it's an unambiguous win in both categories.
> > 
> > Actually the performance gain was disappointingly small.  As it was a
> > separate patch and I though it would gain a lot.  But if IIRC, it only
> > increased the speed by a second or two (of the 1 minute 27 seconds).
> > That's why I spent so much time in the next approach.
> 
> Still, if it's a size win, it definitely makes sense to merge.
> Removing the big block list lock is also a good thing and might make a
> bigger difference on SMP.

Well, I guess I can check out the -mm branch and at least port the first
patch over.

>  
> > > > The next patch was the big improvement, with the largest changes.  I
> > > > took advantage of how the kmem_cache usage that SLAB also takes
> > > > advantage of.  I created a memory pool like the global one, but for
> > > > every cache with a size less then PAGE_SIZE >> 1.
> > > 
> > > Hmm. By every size, I assume you mean powers of two. Which negates
> > > some of the fine-grained allocation savings that current SLOB provides.
> > 
> > Yeah its the same as what the slabs use.  But I would like to take
> > measurements of a running system between the two approaches.  After a
> > day of heavy network traffic, see what the fragmentation is like and how
> > much is wasted.  This would require me finishing my cache_chain work,
> > and adding something similar to your SLOB.
> > 
> > But the powers of two is only for the kmalloc, which this is a know
> > behavior of the current system.  So it <should> only be used for things
> > that would alloc and free within a quick time (like for things you would
> > like to put on a stack but cant), or the size is close to (less than or
> > equal) a power of two.  Otherwise a kmem_cache is made which is the size
> > of expected object (off by UNIT_SIZE).
> 
> There are a fair number of long-lived kmalloc objects. You might try
> playing with the kmalloc accounting patch in -tiny to see what's out
> there.
> 
> http://www.selenic.com/repo/tiny?f=bbcd48f1d9c1;file=kmalloc-accounting.patch;style=raw

I'll have to try this out too. Thanks for the link.
> 
> > Oh, this reminds me, I probably still need to add a shrink cache
> > algorithm.  Which would be very hard to do in the current SLOB.
> 
> Hmmm? It already has one.

The current version in Ingo's 2.6.15-rc5-rt2 didn't have one.

> 
> > > For what it's worth, I think we really ought to consider a generalized
> > > allocator approach like Sun's VMEM, with various removable pieces.
> > 
> > Interesting, I don't know how Sun's VMEM works.  Do you have links to
> > some documentation?
> 
> http://citeseer.ist.psu.edu/bonwick01magazines.html

Thanks, I'll read up on this.

> 
> > That looks like quite an undertaking, but may be well worth it.  I think
> > Linux's memory management is starting to show it's age.  It's been
> > through a few transformations, and maybe it's time to go through
> > another.  The work being done by the NUMA folks, should be taking into
> > account, and maybe we can come up with a way that can make things easier
> > and less complex without losing performance.
> 
> Fortunately, it can be done completely piecemeal. 

If you would like me to test any code, I'd be happy to when I have time.
And maybe even add a few patches myself.

-- Steve


