Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135488AbQL3Vlt>; Sat, 30 Dec 2000 16:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbQL3Vlk>; Sat, 30 Dec 2000 16:41:40 -0500
Received: from [24.65.192.120] ([24.65.192.120]:58876 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S135488AbQL3VlX>;
	Sat, 30 Dec 2000 16:41:23 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012302110.eBULAgt04974@webber.adilger.net>
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com>
 "from Linus Torvalds at Dec 30, 2000 12:21:50 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 30 Dec 2000 14:10:41 -0700 (MST)
CC: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> In short, I don't see _those_ kinds of issues. I do see error reporting as
> a major issue, though. If we need to do proper low-level block allocation
> in order to get correct ENOSPC handling, then the win from doing deferred
> writes is not very big.

It should be relatively light-weight to call into the filesystem simply
to allocate a "count" of blocks needed for the current file.  It may
even be possible to do delayed inode allocation.  This would defer
the inode/block bitmap searching/allocation on ext2 until the file
was actually written - only the free_blocks/free_inodes count in the
superblock would be decremented, and we would get ENOSPC immediately
if we don't have enough space for the file.  On fsck, these values are
recalculated from the group descriptors on ext2, so it wouldn't be a
problem if the system crashed with pre-allocated blocks.

It would definitely be a win on ext2 and XFS, and if it isn't possible
on other filesystems, it should at least not be a loss.

We would need to ensure we also keep enough space for indirect blocks
and such, so we need to pass more information than just the number of
blocks added (i.e. how big the file already is).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
