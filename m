Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRCUJnn>; Wed, 21 Mar 2001 04:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131517AbRCUJne>; Wed, 21 Mar 2001 04:43:34 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:23804 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131512AbRCUJnS>; Wed, 21 Mar 2001 04:43:18 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103210941.f2L9fII14166@webber.adilger.int>
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
In-Reply-To: <20010321010559.B27804@sfgoth.com> from Mitchell Blank Jr at "Mar
 21, 2001 01:05:59 am"
To: Mitchell Blank Jr <mitch@sfgoth.com>
Date: Wed, 21 Mar 2001 02:41:17 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank, Jr. writes:
> Andreas Dilger wrote:
> > With per-group (or maybe per-bitmap) locking, files could be created in
> > parallel with only a small amount of global locking if they are in different
> > groups.
> 
> ...and then we can let the disc go nuts seeking to actually commit all
> these new blocks.  I suspect that this change would only be a win for
> memory-based discs where seek time is zero.

No, because the bitmaps are not updated synchronously.  It would be exactly
the same as today, but without the lock contention.  Also, for very large
filesystems, you get into the case where it is spread across multiple
physical disks, so they _can_ be doing I/O in parallel.

> I think that before anyone starts modifying the kernel for this they
> should benchmark how often the free block checker blocks on lock
> contention _AND_ how often the thread its contending with is looking
> for a free block in a _different_ allocation group.

It really depends on what you are using for a benchmark.  Ext2 likes to
spread directories evenly across the groups, so if you are creating files
in separate directories, then you only have 1/number_of_groups chance
that they would be contending for the same group lock.  If the files are
being created in the same directory, then you have other locking issues
like updating the directory file itself.

> > It may also be possible to have lazy updating of the superblock counts,
> > and depend on e2fsck to update the superblock counts on a crash.
> 
> That sounds more promising.
> 
> > , and only moving the deltas from the groups
> > to the superblock on sync or similar.
> 
> If we're going to assume that e2fsck will correct the numbers anyway then
> there's really no reason to update them any time except when marking
> the filesystem clean (umount, remount-ro)  As a bonus, we have to update
> the superblock then anyway.

Well, the numbers in the superblock are what's used for statfs, and will
also to determine if the fs is full.  It would be safe enough to have an
ext2 function call which "gathers" all of the lazy updates into the SB
for use by statfs and such.  For the case of a full filesystem, the block
allocation routines would eventually find this out anyways, once they
search all of the groups and don't find a free block, so no harm done.  I
believe that sync_supers() is called by kupdated every 5 seconds, so
this would be a good time to collect the deltas to the superblock.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
