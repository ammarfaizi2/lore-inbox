Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbREXI6o>; Thu, 24 May 2001 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbREXI6g>; Thu, 24 May 2001 04:58:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263429AbREXI6Z>;
	Thu, 24 May 2001 04:58:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105221841.f4MIf1NC011363@webber.adilger.int>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD  w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105191728140.15174-100000@penguin.transmeta.com>
 "from Linus Torvalds at May 19, 2001 05:32:50 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 22 May 2001 12:41:01 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> There are some strong arguments that we should have filesystem
> "backdoors" for maintenance purposes, including backup. 
> 
> You can, of course, so parts of this on a LVM level, and doing backups
> with "disk snapshots" may be a valid approach. However, even that is
> debatable: there is very little that says that the disk image has to be
> up-to-date at any particular point in time, so even with a disk snapshot
> capability (which is not necessarily reasonable under all circumstances)
> there are arguments for maintenance interfaces.

Actually, the LVM snapshot interface has (optional) hooks into the filesystem
to ensure that it is consistent at the time the snapshot is created.  For
most filesystems, it will call fsync_dev(dev) so that all buffers are written
to disk.  However, for journalled filesystems, LVM needs to write out the
journal and mark the filesystem clean because the snapshot is a read-only
block device.  In this case it calls fsync_dev_lockfs(dev) which will call
the write_super_lockfs() method for the filesystem (if it exists) which
tells the filesystem to flush the journal, block transactions, and mark the
filesystem clean until the unlockfs() method is called.

Reiserfs and XFS both use this to make consistent snapshots of the live
filesystem.  Unfortunately, XFS checks filesystem UUIDs at mount time,
which means you can't mount two copies of the same filesystem (even read-only).

> Things like "lazy fsck" (ie fsck while already running the filesystem) and
> defragmentation simply is not feasible on a LVM level.

Yes, with consistent LVM snapshots you can do fsck on the read-only copy.
In 99.9*% cases you will not detect any errors and you can continue.  If
you _do_ detect an error you probably want to stop everything and fix it
(fsck repairing an in-use filesystem is too twisted and dangerous, IMHO,
and a huge amount of effort for an extremely rare situation).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
