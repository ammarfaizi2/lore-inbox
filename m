Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTBUThQ>; Fri, 21 Feb 2003 14:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTBUThQ>; Fri, 21 Feb 2003 14:37:16 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:63109 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267649AbTBUThO>;
	Fri, 21 Feb 2003 14:37:14 -0500
Date: Fri, 21 Feb 2003 20:46:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030221194640.GS10360@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <20030220161536.F1723@schatzie.adilger.int> <20030221094627.GI31480@x30.school.suse.de> <20030221124108.N1723@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221124108.N1723@schatzie.adilger.int>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:41:09PM -0700, Andreas Dilger wrote:
> On Feb 21, 2003  10:46 +0100, Andrea Arcangeli wrote:
> > On Thu, Feb 20, 2003 at 04:15:36PM -0700, Andreas Dilger wrote:
> > > What we did was set up a "kmap reservation", which used an atomic_dec()
> > > + wait_event() to reschedule the task until it could get enough kmaps
> > > to satisfy the request without deadlocking (i.e. exceeding the kmap cap
> > > which we conservitavely set at 3/4 of all kmap space).
> > 
> > Your approch was fragile (every arch is free to give you just 1 kmap in
> > the pool and you still must not deadlock) and it's not capable of using
> > the whole kmap pool at the same time. the only robust and efficient way
> > to fix it is the kmap_nonblock IMHO
> 
> So (says the person who only ever uses i386 and ia64), does an arch exist
> which needs highmem/kmap, but only ever gives 1 kmap in the pool?
> 
> > > This works for us because we are the only consumer of huge amounts of kmaps
> > > on our systems, but it would be nice to have a generic interface to do that
> > > so that multiple apps don't deadlock against each other (e.g. NFS + Lustre).
> > 
> > This isn't the problem, if NFS wouldn't be broken it couldn't deadlock
> > against Lustre even with your design (assuming you don't fall in the two
> > problems mentioned above). But still your design is more fragile and
> > less scalable, especially for a generic implementation where you don't
> > know how many pages you'll reserve in mean, and you don't know how many
> > kmaps entries the architecture can provide to you. But of course with
> > kmap_nonblock you'll have to fallback submitting single pages if it
> > fails, it's a bit more difficult but it's more robust and optimized IMHO.
> 
> In our case, Lustre (well Portals really, the underlying network protocol)
> always knows in advance the number of pages that it will need to kmap
> because the client needs to tell the server in advance how much bulk data
> is going to send.  This is required for being able to do RDMA.  It might
> be possible to have the server do the transfer in multiple parts if
> kmap_nonblock() failed, but that is not how things are currently set up,
> which is why we block in advance until we know we can get enough pages.
> 
> This is very similar to ext3 journaling, which requests in advance the
> maximum number of journal blocks it might need, and blocks until it can
> get them all.
> 
> The only problem happens when other parts of the kernel start acquiring
> multiple kmaps without using the same reservation/accounting system as us.
> Each works fine in isolation, but in combination it fails.

no, if the other places are not buggy, it won't fail, regardless if they
use your mechanism or the kmap_nonblock. you don't have to use your
mechanism everywhere to make your mechanism work. For istance you will
be fine with the kmap_nonblock fix in combination with your current
code. Not sure why you think otherwise.

I understand it may be simpler to do the full reservation, in ext3 you
don't even risk anything because you know how large the pool is, but I
think for these cases the kmap_nonblock is superior because you have
obvious depdency on the architecture and you're not able to use at best
all the kmap pool (and here there's not a transaction that has to be
committed all at once so it's doable).  still in practice it will work
fine in combination of the other safe usages (like kmap_nonblock) if you
reserve few enough pages at time.

Andrea
