Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSFTH2e>; Thu, 20 Jun 2002 03:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSFTH2d>; Thu, 20 Jun 2002 03:28:33 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:24558 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293203AbSFTH2a>; Thu, 20 Jun 2002 03:28:30 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 20 Jun 2002 01:26:17 -0600
To: Larry McVoy <lm@work.bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020620072617.GK22427@clusterfs.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020619222444.A26194@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619222444.A26194@work.bitmover.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 19, 2002  22:24 -0700, Larry McVoy wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> > The compute cluster problem is an interesting one.  The big items
> > I see on the todo list are:
> > 
> > - Scalable fast distributed file system (Lustre looks like a
> >    possibility)

Well, I can speak to this a little bit...  Given Lustre's ext3
underpinnings, we have been thinking of some interesting methods
by which we could take an existing ext3 filesystem on a disk and
"clusterify" it (i.e. have distributed coherency across multiple
clients).  This would be perfectly suited for application on a
CC cluster.

Given that the network communication protocols are also abstracted
out from the Lustre core, it would probably be trivial for someone
with network/VM experience to write a "no-op" networking layer
which basically did little more than passing around page addresses
and faulting the right pages into each OSlet.  The protocol design
is already set up to handle direct DMA between client and storage
target, and a CC cluster could also do away with the actual copy
involved in the DMA.  We can already do "zero copy" I/O between
user-space and a remote disk with O_DIRECT and the right network
hardware (which does direct DMA from one node to another).

> "Paul McKenney" <Paul.McKenney@us.ibm.com> writes:
>      Access to Devices Owned by Some Other OSlet
> 
>           Larry mentioned a /rdev, but if we discussed any details
>           of this, I have lost them.  Presumably, one would use some
>           sort of IPC or doors to make this work.

I would just make access to remote devices act like NBD or something,
and have similar "network/proxy" kernel drivers to all "remote" devices.
At boot time something like devfs would instantiate the "proxy"
drivers for all of the kernels except the one which is "in control"
of that device.

For example /dev/hda would be a real IDE disk device driver on the
controlling node, but would be NBD in all of the other OSlets.  It would
have the same major/minor number across all OSlets so that it presented
a uniform interface to user-space.  While in some cases (e.g. FC) you
could have shared-access directly to the device, other devices don't
have the correct locking mechanisms internally to be accessed by more
than one thread at a time.

As the "network" layer between two OSlets would run basically at memory
speeds, this would not impose much of an overhead.  The proxy device
interfaces would be equally useful between OSlets as with two remote
machines (e.g. remote modem access), so I have no doubt that many of
them already exist, and the others could be written rather easily.

>      Access to Filesystems Owned by Some Other OSlet.
> 
>           For the most part, this reduces to the mmap case.  However,
>           partitioning popular filesystems over the OSlets could be
>           very helpful.  Larry mentioned that this had been prototyped.
>           Paul cannot remember if Larry promised to send papers or
>           other documentation, but duly requests them after the fact.
> 
>           Larry suggests having a local /tmp, so that /tmp is in effect
>           private to each OSlet.  There would be a /gtmp that would
>           be a globally visible /tmp equivalent.  We went round and
>           round on software compatibility, Paul suggesting a hashed
>           filesystem as an alternative.  Larry eventually pointed out
>           that one could just issue different mount commands to get
>           a global filesystem in /tmp, and create a per-OSlet /ltmp.
>           This would allow people to determine their own level of
>           risk/performance.

Nah, just use a cluster filesystem for everything ;-).  As I mentioned
previously, Lustre could run from a single (optionally shared-access) disk
(with proper, relatively minor, hacks that are just in the discussion
phase now), or it can run from distributed disks that serve the data to
the remote clients.  With smart allocation of resources, OSlets will
prefer to create new files on their "local" storage unless there are
resource shortages.  The fast "networking" between OSlets means even
"remote" disk access is cheap.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

