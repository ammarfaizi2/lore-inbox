Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319085AbSIDHLd>; Wed, 4 Sep 2002 03:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319086AbSIDHLd>; Wed, 4 Sep 2002 03:11:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:64778 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319085AbSIDHLc>; Wed, 4 Sep 2002 03:11:32 -0400
Message-ID: <3D75B344.66D4166@aitel.hist.no>
Date: Wed, 04 Sep 2002 09:16:20 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct" (fwd)
References: <200209032107.g83L71h10758@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> "A month of sundays ago Lars Marowsky-Bree wrote:"
> > On 2002-09-03T18:29:02,
> >    "Peter T. Breuer" <ptb@it.uc3m.es> said:
> >
> > > > Lets say you have a perfect locking mechanism, a fake SCSI layer
> > > OK.
> >
> > BTW, I would like to see your perfect distributed locking mechanism.
> 
> That bit's easy and is done. The "trick" is NOT to distribute the lock,
> but to have it in one place - on the driver that guards the remote
> disk resource.
> 
> > > The directory entry would certainly have to be reread after a write
> > > operation on disk that touched it - or more simply, the directory entry
> > > would have to be reread every time it were needed, i.e. be uncached.
> >
> > *ouch* Sure. Right. You just have to read it from scratch every time. How
> > would you make readdir work?
> 
> Well, one has to read it from scratch. I'll set about seeing how to do.
> CLues welcome.
> 
> > > If that presently is not possible, then I would like to think about
> > > making it possible.
> >
> > Just please, tell us why.
> 
> You don't really want the whole rationale. It concerns certain
> european (nay, world ..) scientific projects and the calculations of the
> technologists about the progress in hardware over the next few years.
> We/they foresee that we will have to move to multiple relatively small
> distributed disks per node in order to keep the bandwidth per unit of
> storage at the levels that they will have to be at to keep the farms
> fed.  We are talking petabytes of data storage in thousands of nodes
> moving over gigabit networks.
> 
> The "big view" calculations indicate that we must have distributed
> shared writable data.
> 
Increasing demands for performance may indeed force a need
for shared writeable data someday.  Several solutions for that is
being developed.
Your idea about re-reading stuff over and over isn't going to help 
because that sort of thing consumes much more bandwith. Caches help
because they _avoid_ data transfers.  So shared writeable data
will happen, and it will use some sort of cache coherency,
for performance reasons.

> These calculations affect us all. They show us what way computing
> will evolve under the price and technology pressures. The calculations
> are only looking to 2006, but that's what they show. For example
> if we think about a 5PB system made of 5000 disks of 1TB each in a GE
> net, we calculate the aggregate bandwidth available in the topology as
> 50GB/s, which is less than we need in order to keep the nodes fed
> at the rates they could be fed at (yes, a few % loss translates into
> time and money).  To increase available bandwidth we must have more
> channels to the disks, and more disks, ... well, you catch my drift.
> 
> So, start thinking about general mechanisms to do distributed storage.
> Not particular FS solutions.
Distributed systems will need somewhat different solutions, because
they are fundamentally different.  Existing fs'es like ext2 is built
around a single-node assumption.  I claim that making a new fs from
scratch for the distributed case is easier than tweaking ext2
and 10-20 other existing fs'es to work in such an environment. 
Making a new fs from scratch isn't such a big deal after all.

To make a historical parallel:
Data used to be stored on sequential media like tapes (or
even stacks of punched cards)  filesystems were developed
for tapes.  Then they made disks.  
Using a disk as a tape with the existing tape-fs'es
worked, but didn't give much benefit.  So we got something
new - block-based filesystems designed to take advantage
of the new random-access media.

The case of distributed storage is similiar, it is fundamentally
different from the one-node case just as random-access media
were different from sequential.

I think a new design that considers both the benefits and
problems of many nodes will be much better than trying to 
patch the existing fs'es.  An approach that starts with
throwing away the thousand-fold speedup provided by caching
isn't very convincing.  

If you merely proposed making the VFS and existing fs'es
cache-coherent,then I'd agree it might work well, but
it'd be a _lot_ of work.  Which is no problem
if you volunteer to do the work.  But simplification
by throwing away caching _will_ be too slow, it certainly
don't fit the idea of getting more bandwith.  

More bandwith won't help if you throw all of it and then some
away on massive re-reading of data. 

Wanting a generic mechanism instead of a special fs 
might be the way to go, but it'd be a generic mechanism
used by a bunch of new fs'es designed to work distributed.

There will probably be different needs for which people
will build different distributed fs'es.  So a 
"VDFS" makes sense for those fs'es, putting the common stuff
in one place.  But I am sure the VDFS will contain cache
coherency calls for dropping pages from cache when 
necessary, instead of dropping the cache unconditionally
in every case.

Helge Hafting
