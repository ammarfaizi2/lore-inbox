Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRFYAAW>; Sun, 24 Jun 2001 20:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRFYAAN>; Sun, 24 Jun 2001 20:00:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:7691 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265806AbRFYAAE>; Sun, 24 Jun 2001 20:00:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        phillips@bonn-fries.net (Daniel Phillips)
Subject: Re: FAT32 superiority over ext2 :-)
Date: Mon, 25 Jun 2001 02:03:07 +0200
X-Mailer: KMail [version 1.2]
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
        viro@math.psu.edu, phillips@bonn-fries.net, chaffee@cs.berkeley.edu,
        storner@image.dk, mnalis-umsdos@voyager.hr
In-Reply-To: <200106242349.f5ONnhP34041@saturn.cs.uml.edu>
In-Reply-To: <200106242349.f5ONnhP34041@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <0106250203070J.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 01:49, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> > On Monday 25 June 2001 00:54, Albert D. Cahalan wrote:
> >> By dumb luck (?), FAT32 is compatible with the phase-tree algorithm
> >> as seen in Tux2. This means it offers full data integrity.
> >> Yep, it whips your typical journalling filesystem. Look at what
> >> we have in the superblock (boot sector):
> >>
> >>     __u32  fat32_length;  /* sectors/FAT */
> >>     __u16  flags;         /* bit 8: fat mirroring, low 4: active fat */
> >>     __u8   version[2];    /* major, minor filesystem version */
> >>     __u32  root_cluster;  /* first cluster in root directory */
> >>     __u16  info_sector;   /* filesystem info sector */
> >>
> >> All in one atomic write, one can...
> >>
> >> 1. change the active FAT
> >> 2. change the root directory
> >> 3. change the free space count
> >>
> >> That's enough to atomically move from one phase to the next.
> >> You create new directories in the free space, and make FAT
> >> changes to an inactive FAT copy. Then you write the superblock
> >> to atomically transition to the next phase.
> >
> > Yes, FAT is what inspired me to go develop the algorithm.  However, two
> > words: 'lost clusters'.  Now that may just be an implemenation detail ;-)
>
> What lost clusters?
>
> Set bit 8 of "flags" (A_BF_BPBExtFlags to Microsoft) to disable
> FAT mirroring. Then the low 4 bits are a 0-based value that
> indicates which copy of the FAT should be used.
>
> Assume we have 2 copies of the FAT, as is (was?) common. I'll call
> them X and Y. When we mount the filesystem, we disable FAT mirroring
> and mark FAT X active.
>
> Now we can make changes to FAT Y without affecting filesystem
> integrity. Windows will not use FAT Y. As is usual with the
> phase-tree algorithm, we use free space to create a new structure
> beside the old one.
>
> Time for a phase change:
>
> We have FAT Y, currently inactive, updated on disk.
> FAT X is active; it describes the current on-disk state.
> We have a new root directory on disk, sitting in free space.
> We have a new filesystem info sector on disk, sitting in free space.
>
> We write one single sector, then:
>
> FAT X becomes inactive, and will not be used by Windows.
> FAT Y becomes active; it describes the new on-disk state.
> The old root directory is marked free in FAT Y. Good!
> The old filesystem info sector is marked free in FAT Y. Good!
>
> Once the superblock goes to disk, FAT X may be written to.

When can we expect the patch?

--
Daniel
