Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267486AbRGMUn2>; Fri, 13 Jul 2001 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRGMUnW>; Fri, 13 Jul 2001 16:43:22 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:5884 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267053AbRGMUnG>; Fri, 13 Jul 2001 16:43:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107132041.f6DKfqM8013404@webber.adilger.int>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <200107131820.f6DIKvg190902@saturn.cs.uml.edu> "from Albert D. Cahalan
 at Jul 13, 2001 02:20:57 pm"
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Date: Fri, 13 Jul 2001 14:41:52 -0600 (MDT)
CC: Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert writes:
> How does can any of this even work?
> 
> Say I have N disks, mirrored, or maybe with parity. I'm trying
> to have a reliable system. I change a file. The write goes out
> to my disks, and power is lost. Some number M, such that 0<M<N,
> of the disks are written before the power loss. The rest of the
> disks don't complete the write. Maybe worse, this is more than
> one sector, and some disks have partial writes.
> 
> Doesn't RAID need a journal or the phase-tree algorithm?
> How does one tell what data is old and what data is new?

Yes, RAID should have a journal or other ordering enforcement, but
it really isn't any worse in this regard than a single disk.  Even
on a single disk you don't have any guarantees of data ordering, so
if you change the file and the power is lost, some of the sectors
will make it to disk and some will not => fsck, with possible data
corrpution or loss.

That's why the journaled filesystems have multi-stage commit of I/O,
first to the journal and then to the disk, so no chance of corruption
of the metadata, and if you journal data also, then the data cannot
be corrupted (but some may be lost).

RAID 5 throws a wrench into this by not guaranteeing that all of the
blocks in a stripe are consistent (you don't know which blocks and/or
parity were written and which not).  Ideally, you want a multi-stage
commit for RAID as well, so that you write the data first, and the
parity afterwards (so on reboot you trust the data first, and not the
parity).  You have a problem if there is a bad disk and you crash.

With a data-journaled fs you don't care what RAID does because the fs
journal knows which transactions were in progress.  If an I/O was being
written into the journal and did not complete, it is discarded.  If it
was written into the journal and did not finish the write into the fs,
it will re-write it on recovery.  In both cases you don't care if the
RAID finished the write or not.

Note that for LVM (the original topic), it does NOT do any RAID stuff
at all, it is just a virtually contiguous disk, made up of one or more
real disks (or stacked on top of RAID).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
