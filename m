Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131241AbRCUIrg>; Wed, 21 Mar 2001 03:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRCUIr0>; Wed, 21 Mar 2001 03:47:26 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:19708 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131241AbRCUIrM>; Wed, 21 Mar 2001 03:47:12 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103210846.f2L8kIe04539@webber.adilger.int>
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
In-Reply-To: <20010321180607.A11941@linuxcare.com> from Anton Blanchard at "Mar
 21, 2001 06:06:07 pm"
To: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 21 Mar 2001 01:46:17 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard writes:
> I ported lockmeter to PPC and ran a few dbench runs on a quad CPU F50 here.
> These runs were made to never hit the disk. The full results can be found
> here:
> 
> http://samba.org/~anton/ppc/lockmeter/2.4.3-pre3_hacked/
> 
> It was not surprising the BKL was one of the main offenders. Looking at the
> stats ext2_get_block was the bad guy (UTIL is % of time lock was busy for,
> WAIT is time spent waiting for lock):
> 
> SPINLOCKS         HOLD           WAIT
>   UTIL  CON    MEAN(  MAX )  MEAN(  MAX )( %CPU)   TOTAL NAME
>  38.8% 41.0%  7.6us(  31ms)  15us(  18ms)( 7.7%) 1683368 kernel_flag
>  29.2% 50.9%   10us( 400us)  15us( 892us)( 5.4%)  957740  ext2_get_block+0x64

It has previously been discussed to remove the BLK for much (all?) of the
VFS and push the locking into the filesystems.  This would require that
lock_super() actually be an SMP safe locking mechanism.  At this point it
would also be possible to have separate locks for each ext2 group, which
may greatly reduce locking contention as we searched for free blocks/inodes
(really depends on allocation patterns).

With per-group (or maybe per-bitmap) locking, files could be created in
parallel with only a small amount of global locking if they are in different
groups.  The CPU-intensive work (bitmap searching) could be done with
only a bitmap lock.  It may even be desirable to do the bitmap searching
without any locks.  We would depend on the atomic test_and_set() to tell
us if our newfound "free" block was allocated from underneath us, and use
find_next_free_bit() to continue our search in the bitmap.

The group lock would be needed for updating the group descriptor counts,
and a superblock lock for doing the superblock counts.  It may also be
possible to have lazy updating of the superblock counts, and depend on
e2fsck to update the superblock counts on a crash.  I'm thinking something
like updating a "delta count" for each ext2 group (blocks, inodes, dirs)
while we hold the group lock, and only moving the deltas from the groups
to the superblock on sync or similar.  This would reduce lock contention
on the superblock lock a great deal.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
