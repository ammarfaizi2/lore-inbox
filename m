Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTJJUIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTJJUIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:08:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:62603 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262590AbTJJUIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:08:11 -0400
Date: Fri, 10 Oct 2003 21:07:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010200749.GA31006@mail.shareable.org>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org> <20031010163300.GC28773@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010163300.GC28773@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 	Platter level doesn't matter.  Storage access level matters.
> Node1 and Node2 have to see the same thing.  As long as I am absolutely
> sure that when Node1's write() returns, any subsequent read() on Node2
> will see the change (normal barrier stuff, really), it doesn't matter
> what happend on the Storage.  The data could be in storage cache, on
> platter, passed back to some other entity.

That's two specifications.  Please choose one!

First you say the storage access level matters, then you say it
doesn't matter, that the only important thing is any two nodes see
each other's changes.

Committing data to a certain level of storage, for the sake of
_storing_ it, is trivially covered by fdatasync().  We won't talk
about that any more.

The other requirement is about barriers between nodes accessing data.

On a single machine, your second specification means the data doesn't
need to hit the disk at all.  On a SAN, it means the data doesn't need
to hit the SAN's storage - nor, in fact does the data have to be
transferred over the SAN when you write it!  Distributed cache
coherency exists for that purpose.

For example, let's imagine 32 processes, 8 per machine, and a giant
shared disk.  Pages in the database are regularly read and written by
pairs of nodes and, because of the way you direct requests based on
keys, certain pages tend to be accessed only by certain pairs of
nodes.

That means a significant proportion of the pages do _not_ need to be
transmitted through the shared disk every time they are made visible
to other nodes - because those page accesses are local to one _machine_
for many transfers.

That means O_DIRECT is using more storage bandwidth than you need to
use.  The waste is greatest on a single machine (i.e. infinity) but
with multiple machines there is still waste and the amount depends on
access patterns.

You should be using cache coherency protocols between nodes - at the
database level (which you very likely are, as performance would
plummet without it) - and at the filesystem level.

"Forcing a read" is *not* a required operation if you have a sound
network filesystem or even network disk protocol.  Merely reading a
page will force the read, if another node has written to it - and
*only* if that is necessary.  Some of the distributed filesystems,
like Sistina's, get this right I believe.

If, however, your shared file does not maintain coherent views between
different nodes, then you _do_ you need to force writes and force
reads.

Your quality database will not waste storage bandwidth by doing
_unnecessary_ reads, if the underlying storage isn't coherent, merely
to see whether a page changed.  For that, you should be communicating
metadata between nodes that say "this page is now dirty; you will need
to read it" and "ok" - along the lines of MESI.

That is the worst case I can think of (i.e. the kernel filesystem/san
driver doesn't do coherence so you have to do it in the database
program), and indeed you do need the ability to flush read pages in
that case.  Ideally you want the ability to pass pages directly
between nodes without requiring a storage commit, too.

Linus' suggestion of "this data is stale" is ok.  Another flag to
remap_file_pages would work, too, saving a system call in some cases,
but doing unwanted reads (sometimes you just want to invalidate) in
some others.  Btw, fadvise(POSIX_FADV_DONTNEED) appears to offser this
already.

Using O_DIRECT always can be inefficient, because it commits things to
storage which don't need to be committed so early or often, and
because it moves data when it does not need to be moved, with the
worst case being a small cluster of large machines or just one
machine.

It's likely your expensive shared disk doesn't mind all those commits
because of journalling NVRAM etc..

To avoid wasting bandwidth to the shared disk associated processing
costs you have to analyse the topology of node interconnections,
specifically to avoid using O_DIRECT and/or unnecessary reads and
writes when they aren't necessary (between local nodes).

You need that anyway even with Linus' suggestion, because there's no
way the kernel can know automatically whether you are doing a
coherence operation between two local nodes or remote ones.  Local
filesystems look like a worthy exception, but even those are iffy if
there's a remote client accessing it over a network filesystem as well
as local nodes synchronising over it.  It has to be an unexported
local filesystem, and the kernel doesn't even know that, because of
userspace servers like Samba.

   ======

That long discussion leads to this:

The best in theory is a network-coherent filesystem.  It knows the
topology and it can implement the optimal strategy.

Without one of those, it is necessary to know the topology between
nodes to get optimal performance for any method (i.e. minimum pages
transferred around, minimum operations etc.).  This is true of using
O_DIRECT or Linus' page cache manipulations.

O_DIRECT works, but causes unnecessary storage commitment when all you
need is synchronisation.

Page cache manipulation may already be possible using fdatasync +
MADV_DONTNEED + POSIX_FADV_DONTNEED, however that isn't optimal
either, because:

Both of those mechanisms do not provide a way to transfer a dirty page
from one node to another without (a) committing to storage; or (b)
copying the data at the receiver.  O_DIRECT does the commit (write at
one node; read at the other), but is zero-copy at the receiver, as
mapped files are generally.  Without O_DIRECT, you'd have to use
application level socket<->socket communication, and there is as yet
no zero-copy receive.  Zero-copy UDP receive or similar is needed to
get the best from this.

Conclusions
-----------

Only a coherent distributed filesystem actually minimises the amount
of file data transferred and copied, and automatically too.

All other suggestions so far have weaknesses in this regard.

Although the page cache manipulation methods could minimise the
transfers and copies if zero-copy socket receive was available, it is
a set of mechanisms that look like it would, after it's implemented in
the application, still be slower than a coherent filesystem just
because the latter can do the combination of manipulations etc. more
easily; on the other hand, resolution of cache coherency by a
filesystem would incur more page faults than doing it at the
application level.  So it is not absolutely clear which can be made
faster with lots of attention.

The end :)

Thanks for getting this far...
-- Jamie
