Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130299AbQK1VMm>; Tue, 28 Nov 2000 16:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130763AbQK1VMd>; Tue, 28 Nov 2000 16:12:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15030 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S130007AbQK1VMT>;
        Tue, 28 Nov 2000 16:12:19 -0500
Date: Tue, 28 Nov 2000 15:41:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, tytso@valinux.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.0-test11 ext2 fs corruption
In-Reply-To: <E2BA5DE1AE9@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0011281520100.11331-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Petr Vandrovec wrote:

> > two ranges? Then it looks like something way below the fs level... Weird.
> > Could you verify it with dd?
> 
> Yes, it is identical copy. But I do not think that hdd can write same
> data into two places with one command...
> 
> vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=722433 | md5sum
> 27+0 records in
> 27+0 records out
> 613de4a7ea664ce34b2a9ec8203de0f4
> vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=558899 | md5sum
> 27+0 records in
> 27+0 records out
> 613de4a7ea664ce34b2a9ec8203de0f4
> vana:/#

Bloody hell... OK, let's see. Both ranges are covered by multiple files
and are way larger than one page. I.e. anything on pagecache level is
extremely unlikely - pages are not searched by physical location on
disk. And I really doubt that it's ext2_get_block() - we would have
to get a systematic error (constant offset), then read the data in
for no good reason, then forget the page->buffers, then get the right
values fro ext2_get_block(), leave the data unmodified _and_ write it.

It almost looks like a request in queue got fscked up retaining the
->bh from one of the previous (also coalesced) requests and having
correct ->sector. Weird.

Linus, Andrea - any ideas? Situation looks so: after massive file creation
a range of disk with the data from new files (many new files) got
duplicated over another range - one with the data from older files
(also many of them). 27 blocks, block size == 4Kb. No intersection
between inodes, fsck is happy with fs, just a data ending up in two
places on disk. No warnings from IDE or ext2 drivers.

Kernel: test11 built with 2.95.2, so gcc bug may very well be there.
However, I really wonder what could trigger it in ll_rw_blk.c - 5:1
that shit had hit the fan there.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
