Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275336AbRJAR2v>; Mon, 1 Oct 2001 13:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275357AbRJAR2l>; Mon, 1 Oct 2001 13:28:41 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:10136 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S275346AbRJAR2a>;
	Mon, 1 Oct 2001 13:28:30 -0400
Date: Mon, 1 Oct 2001 19:28:56 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110011728.TAA09370@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.4.11-pre1 oops in bdget() -- FIXED
Cc: linux-kernel@vger.kernel.org, mason@suse.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001 08:35:03 -0700 (PDT), Linus Torvalds wrote:
>
>The thing we oops on is the _old_ blksize_size[] array information for the
>floppy, which was loaded as a module and then unloaded - it's ugly that it
>doesn't clean up its copy of the blksize_size array, but the real cause
>for the problem is that bdget() references it before it has opened the
>device.
>
>The (untested) fix is to just remove the line in bdget() that sets
>i_blkbits, as the thing is later set correctly in blkdev_get().

Confirmed. With the patch below I can no longer trigger the oops.

/Mikael

--- linux-2.4.11-pre1/fs/block_dev.c.~1~	Mon Oct  1 11:48:54 2001
+++ linux-2.4.11-pre1/fs/block_dev.c	Mon Oct  1 18:59:16 2001
@@ -345,7 +345,6 @@ struct block_device *bdget(dev_t dev)
 			inode->i_rdev = kdev;
 			inode->i_dev = kdev;
 			inode->i_bdev = new_bdev;
-			inode->i_blkbits = blksize_bits(block_size(kdev));
 			inode->i_data.a_ops = &def_blk_aops;
 			inode->i_data.gfp_mask = GFP_USER;
 			spin_lock(&bdev_lock);
