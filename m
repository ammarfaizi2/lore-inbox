Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274455AbRIYDwr>; Mon, 24 Sep 2001 23:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274457AbRIYDwh>; Mon, 24 Sep 2001 23:52:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29144 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274455AbRIYDw0>;
	Mon, 24 Sep 2001 23:52:26 -0400
Date: Mon, 24 Sep 2001 23:52:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org, andrea@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] invalidate buffers on blkdev_put
In-Reply-To: <251250000.1001387934@tiny>
Message-ID: <Pine.GSO.4.21.0109242333240.21827-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Chris Mason wrote:

> 
> Hi guys,
> 
> I had sent this to Al, but couldn't tell if he hated it, thought it was
> broken, or just didn't think it was required.  So, I opted for wider
> testing.  This only affects 2.4.10pre15+, as it was caused by the blkdev
> changes there.
> 
> Anyway, the bug looks like this:
> 
> dd if=ext2-image-1 of=/dev/ram0
> mount /dev/ram0 /mnt
> umount /mnt
> 
> dd if=ext2-image-2 of=/dev/ram0
> mount /dev/ram0 /mnt
> ls -la /mnt (FS looks corrupted and wrong).
> 
> The problem is that on unmount, the ramdisk's buffer cache isn't cleared
> because bd_openers is still one.  So, even if a new image is copied in, you
> still see the old image's superblock/inodes etc on mount.
> 
> In this case, we want to leave the dirty pages in the page cache, but get
> rid of the buffer cache copies.
> 
> This should not drop any updated data in the ramdisk because
> rd_blkdev_pagecache_IO dirties pages as the higher layers send down
> modified buffer heads (and other rd.c funcs do the same).  Patch is below.
> Linus, please consider (pending lack of nays from Al).

OK, not exactly nay, but...  What you are trying to do is a workaround
for problem that can be solved in somewhat saner way.  Namely, we can
make getblk() return buffres backed by pages from device page cache.

It's _not_ an obvious step.  The most sensitive parts are
	* need to allocate all bdev pages with GFP_BUFFER.  Otherwise
we'll eat flaming death on VM deadlocks.  Doable (we can set ->i_data.gfp_mask)
but may lead to interesting effects wrt VM balancing.
	* implementation of bforget()
	* we'll need to kill buffer hash or deal with the new access path
to page-private buffer_heads.

It's solvable, but not obvious.  It _does_ solve coherency problems between
device page cache and buffer cache (thus killing update_buffers() and its
ilk), but the last issue (new access path to page-private buffer_heads)
may be rather nasty.

