Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319540AbSIGXQN>; Sat, 7 Sep 2002 19:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319541AbSIGXQN>; Sat, 7 Sep 2002 19:16:13 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:29688 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319540AbSIGXQM>; Sat, 7 Sep 2002 19:16:12 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 7 Sep 2002 17:18:51 -0600
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lmb@suse.de: Re: [RFC] mount flag "direct" (fwd)]
Message-ID: <20020907231851.GH7887@clusterfs.com>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	Lars Marowsky-Bree <lmb@suse.de>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20020907164631.GA17696@marowsky-bree.de> <200209071959.g87JxKN17732@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209071959.g87JxKN17732@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 07, 2002  21:59 +0200, Peter T. Breuer wrote:
> "A month of sundays ago Lars Marowsky-Bree wrote:"
> > Yes, use a distributed filesystem. There are _many_ out there; GFS, OCFS,
> > OpenGFS, Compaq has one as part of their SSI, Inter-Mezzo (sort of), Lustre,
> > PvFS etc.
> > Any of them will appreciate the good work of a bright fellow.
> 
> Well, I know of some of these. Intermezzo I've tried lately and found
> near impossible to set up and work with (still, a great improvement
> over coda, which was absolutely impossible, to within an atom's
> breadth). And it's nowhere near got the right orientation. Lustre
> people have been pointing me at. What happened to petal?

Well, Intermezzo has _some_ of what you are looking for, but isn't
really geared to your needs.  It is a distributed _replicated_
filesystem, so it doesn't necessarily scale as good as possible for
the many-nodes-writing case.

Lustre is actually very close to what you are talking about, which I
have mentioned a couple of times before.  It has distributed storage,
so each node could write to its own disk, but it also has a coherent
namespace across all client nodes (clients can also be data servers),
so that all files are accessible from all clients over the network.

It is designed with high performance networking in mind (Quadrics Elan
is what we are working with now) which supports remote DMA and such.

> But what I suggest is finding a simple way to turn an existing FS into a 
> distributed one. I.e. NOT reinventing the wheel. All those other people
> are reinventing a wheel, for some reason :-).

We are not re-inventing the on-disk filesystem, only adding the layers
on top (networking, locking) which is absolutely _required_ if you are
going to have a distributed filesystem.  The locking is distributed,
in the sense that there is one node in charge of the filesystem layout
(metadata server, MDS) and it is the lock manager there, but all of the
storage nodes (called object storage targets, OST) are in charge of locking
(and block allocation and such) for files stored on there.

You can't tell me you are going to have a distributed network filesystem
that does not have network support or locking.

> Well, how about allowing get_block to return an extra argument, which
> is the ondisk placement of the inode(s) concerned, so that the vfs can
> issue a lock request for them before the i/o starts. Let the FS return
> the list of metadata things to lock, and maybe a semaphore to start the
> i/o with.

In fact, you can go one better (as Lustre does) - the layout of the data
blocks for a file are totally internal to the storage node.  The clients
only deal with object IDs (inode numbers, essentially) and offsets in
that file.  How the OST filesystem lays out the data in that object is
not visible to the clients at all, so no need to lock the whole
filesystem across nodes to do the allocation.  The clients do not write
directly to the OST block device EVER.

> > What you are starting would need at least 3-5 years to catch up with what
> > people currently already can do, and they'll improve in this time too. 
> 
> Maybe 3-4 weeks more like.

LOL.  This is my full time job for the last 6 months, and I'm just a babe
in the woods.  Sure you could do _something_, but nothing that would get
the performance you want.

> > A petabyte filesystem without journaling? A petabyte filesystem with a
> > single write lock? Gimme a break.
> 
> Journalling? Well, now you mention it, that would seem to be nice. But
> my experience with journalling FS's so far tells me that they break
> more horribly than normal.  Also, 1PB or so is the aggregate, not the
> size of each FS on the local nodes. I don't think you can diagnose
> "journalling" from the numbers. I am even rather loath to journal,
> given what I have seen.

Lustre is what you describe - dozens (hundreds, thousands?) of independent
storage targets, each controlling part of the total storage space.
Even so, journaling is crucial for recovery of metadata state, and
coherency between the clients and the servers, unless you don't think
that hardware or networks ever fail.  Even with distributed storage,
a PB is 1024 nodes with 1TB of storage each, and that will still take
a long time to fsck just one client, let alone return to filesystem
wide coherency.

> No features. Just take any FS that corrently works, and see if you can
> distribute it.  Get rid of all fancy features along the way.  You mean
> "what's wrong with X"?

Again, you are preaching to the choir here.  In principle, Lustre does
what you want, but not with the "one big lock for the whole system"
approach, and it doesn't intrude into the VFS or need no-cache operation
because the clients DO NOT write directly onto the block device on the
OST.  The DO communicate directly to the OST (so you have basically
linear I/O bandwidth scaling with OSTs and clients), but the OST uses
the normal VFS/filesystem to handle block allocation internally.

> Well, it won't be mainstream, for a start, and
> that's surely enough.  The projects involved are huge, and they need to
> minimize risk, and maximize flexibility. This is CERN, by the way.

We are working on the filesystem for MCR (http://www.llnl.gov/linux/mcr/),
a _very large_ cluster at LLNL, 1000 4way 2.4GHz P4 client nodes, 100 TB
of disk, etc.  (as an aside, sys_statfs wraps at 16TB for one filesystem,
I already saw, but I think I can work around it... ;-)

> There is no difficulty with that - there are no distributed locks. All
> locks are held on the server of the disk (I decided not to be
> complicated to begine with as a matter of principle early in life ;-).

See above.  Even if the server holds all of the locks for its "area" (as
we are doing) you are still "distributing" the locks to the clients when
they want to do things.  The server still has to revoke those locks when
another client wants them, or your application ends up doing something
similar.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

