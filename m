Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268116AbTBMWDB>; Thu, 13 Feb 2003 17:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268117AbTBMWDA>; Thu, 13 Feb 2003 17:03:00 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:31434 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S268116AbTBMWC6>; Thu, 13 Feb 2003 17:02:58 -0500
Subject: Re: Subject: Ordering in FAT filesystem
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: pvijayan@engineer.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Feb 2003 17:09:02 -0500
Message-Id: <1045174142.3133.629.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vijayan Prabhakaran writes:
 
> I'm working on linux FAT filesystem. I'm trying
> to find the order in which the FAT blocks and
> the data blocks are written into the disk.
>
> At the level of device driver, I'm seeing that
> the FAT blocks are written always before the
> corresponding data blocks. Is this just a
> coincidence or is the ordering between FAT and
> data blocks enforced ?

It is coincidence, but you could change that.

The FAT32 layout can support full data integrity
via the phase-tree algorithm. (like Tux2 uses)
This is better than most forms of journalling.
I'll guess the FAT32 layout got the necessary
features to allow safe FAT16-->FAT32 conversion
and/or defragmentation.

The FAT32 superblock (boot sector) contains:

__u32 fat32_length;// sectors/FAT
__u16 flags;       // bit 8: fat mirroring, low 4: active fat
__u8  version[2];  // major, minor filesystem version
__u32 root_cluster;// first cluster in root directory
__u16 info_sector; // filesystem info sector

All in one atomic write, one can...

1. change the active FAT
2. change the root directory
3. change the free space count

That's enough to atomically move from one phase to the next.
You create new directories in the free space, and make FAT
changes to an inactive FAT copy. Then you write the superblock
to atomically transition to the next phase.

In a bit more detail:

Set bit 8 of "flags" (A_BF_BPBExtFlags to Microsoft) to
disable FAT mirroring. Then the low 4 bits are a 0-based
value that indicates which copy of the FAT should be used.

Assume we have 2 copies of the FAT, as is (was?) common.
I'll call them X and Y. When we mount the filesystem,
we disable FAT mirroring and mark FAT X active.

Now we can make changes to FAT Y without affecting
filesystem integrity. Windows will not use FAT Y. As is
usual with the phase-tree algorithm, we use free space
to create a new structure beside the old one.

Time for a phase change:

We have FAT Y, currently inactive, updated on disk.
FAT X is active; it describes the current on-disk state.
We have a new root directory on disk, sitting in free space.
We have a new filesystem info sector on disk, sitting in free space.

We write one single sector, then:

FAT X becomes inactive, and will not be used by Windows.
FAT Y becomes active; it describes the new on-disk state.
The old root directory is marked free in FAT Y. Good!
The old filesystem info sector is marked free in FAT Y. Good!

Once the superblock goes to disk, FAT X may be written to.

You might want these Tux2 filesystem notes:
http://marc.merlins.org/linux/linux.conf.au_2001/Day2/miami2000_daniel_phillips.pdf
http://people.nl.linux.org/~phillips/tux2/phase.tree.tutorial.html
http://people.nl.linux.org/~phillips/tux2/phase.tree.algorithm.html


