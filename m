Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbQKTFxO>; Mon, 20 Nov 2000 00:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbQKTFxE>; Mon, 20 Nov 2000 00:53:04 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55547 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131365AbQKTFw5>; Mon, 20 Nov 2000 00:52:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011200522.eAK5MrK04520@webber.adilger.net>
Subject: Re: ext2 sparse superblocks
In-Reply-To: <3A175226.3A9C3180@holly-springs.nc.us> "from Michael Rothwell at
 Nov 18, 2000 11:08:06 pm"
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Date: Sun, 19 Nov 2000 22:22:53 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell write:
> I'm looking for documentation on Ext2's support for sparse superblocks.
> What it the method uses to reduce the number of superblocks?  How are
> they laid out before vs after sparse_super is enabled?  Any caveats?

In an old-style (non-sparse) filesystem, every block group has a superblock
copy.  Only the superblock in the first group is used in normal cases.  In
a sparse filesystem, superblock copies are in groups 0, 1 and ones that are
powers of 3, 5, and 7.  The primary superblock is in group 0, and backups
are in groups 1, 3, 5, 7, 9, 25, 27, 49, 81, 125, etc.

This greatly reduces the number of superblock copies stored in large
filesystems.  What is actually more important is that group descriptor
backups are only stored in the "sparse" groups as well.  Because the
group descriptor table grows with the size of the filesystem, if there
is a backup copy in each group (as with the old non-sparse layout) it
would eventually fill the entire filesystem.

For a 1kB block non-sparse ext2 filesystem, this happens at 2TB -
basically the entire filesystem is full with metadata, and no room
to put any regular data.  For a 4kB block filesystem, this would
happen at 524 TB.  With sparse filesystems, the metadata will only
take a small percentage of the available space.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
