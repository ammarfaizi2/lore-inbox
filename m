Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSDJAlo>; Tue, 9 Apr 2002 20:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312308AbSDJAln>; Tue, 9 Apr 2002 20:41:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48144 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S312302AbSDJAlm>;
	Tue, 9 Apr 2002 20:41:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204100041.g3A0fSj00928@saturn.cs.uml.edu>
Subject: Re: implementing soft-updates
To: alexis@cecm.usp.br (Alexis S. L. Carvalho)
Date: Tue, 9 Apr 2002 20:41:28 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br> from "Alexis S. L. Carvalho" at Apr 09, 2002 06:46:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis S. L. Carvalho writes:

> Does anyone know of any implementation of soft-updates
> over ext2? I'm starting a project on this for grad school,
> and I'd like to know of any previous (current?) efforts.

That's interesting. Some comments:

It is common for controllers, RAID arrays, and the disks to
mess up your ordering. Power failure during a write has been
known to scribble on random unrelated parts of the disk.
Power failure often creates bad sectors that can only be
fixed by a large write that covers the affected area.

Ext2 has deletion time stamps. These are not really good for
performance, but they help fsck to know what is going on.

While ext2 fsck doesn't guarantee anything, in practice it is far
more reliable than ufs fsck. If you change the algorithms to be
like those used by BSD, then you may lose some of the ability to
recover. Remember, fsck isn't just for power failures. It tries
to piece together a filesystem that has suffered disk corruption
caused by attackers, kernel bugs, fdisk screwups, MS-DOS writing
past the end of a partition, Windows NT Disk Manager, viruses,
disk head crashes, and every other cause you can imagine. If you
change fsck to make BSD-style assumptions about write ordering,
you weaken the ability to deal with disasters.

I'm sure you are aware of ext3. You should also be aware of tux2.
Tux2 uses the phase-tree algorithm to perform atomic updates of
the whole filesystem. Tux2 looks horridly slow at first glance,
but is actually quite fast. The overhead drops to almost nothing
as the number of simultaneous operations goes to infinity.
(the overhead asymptoticly approaches 0.1%) While the operations
tend to cause fragmentation, they also make defragmentation be
really cheap -- you can defragment on-th-fly as part of normal
filesystem operations without any additional IO. There is a
neat trick you can do with the phase-tree algorithm for better
integrity: make every non-leaf node carry checksums for all
directly connected child nodes. (either plain or keyed crypto)
Filesystem-level snapshots are easy with the phase-tree algorithm.

Soft-updates are mainly useful for OS wars. Lots of FUD comes
flying out of the BSD camp. Ext2 horror stories are rare
when you consider just how many millions of users ext2 has.
Soft-updates would make our worst problems even worse. The whole
point of soft-updates is to have fsck and the kernel trust the
metadata a bit more... which is terrible if your VIA motherboard
is mangling your metadata before it hits the disk. Not to say
that doing well in an OS war isn't a useful goal though!

In case you are still thinking about what to do, here are a
few filesystem ideas that you might like:

soft-updates for ext2
ext2 compression (e2compr)
delayed allocation (allocate space only when about to do IO)
while rw mounted: defrag, undelete (not trash bin), grow, shrink, fsck
get tux2 into production shape
use the phase-tree algorithm for FAT32 (hint: active FAT flags)
new phase-tree filesystem, perhaps with JFS or XFS structure
make ext2 extents work
make ext2 handle huge block sizes
mark idle filesystems clean; mark dirty before non-atomic updates
ACLs compatible with NFSv4, fast, and compact
secure deletion (stop root, not the NSA: zero the name, inode...)
tools for in-place filesystem conversion (ufs --> ext2)
HFS+ filesystem
Apple's UID hacks for Darwin (the BSD-like MacOS X kernel)
design a fast way to map from inode number to filename(s)
try larger inodes (example: 168-byte, 3 in 512 bytes, 0,1,2,x,4,5,6,x,8...)
provide real-time file IO (app buffers do not guarantee bandwidth)

BTW, the unbalanced trees can be good. They provide quick access
to file magic (see "file" command) and other header information.
We have read-ahead to take care of the rest of the file.
