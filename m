Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277818AbRKDUXD>; Sun, 4 Nov 2001 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278597AbRKDUWy>; Sun, 4 Nov 2001 15:22:54 -0500
Received: from peace.netnation.com ([204.174.223.2]:16650 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277818AbRKDUWu>; Sun, 4 Nov 2001 15:22:50 -0500
Date: Sun, 4 Nov 2001 12:22:48 -0800
From: Simon Kirby <sim@netnation.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mike Black <mblack@csihq.com>, linux-kernel@vger.kernel.org
Subject: Re: Something broken in sys_swapon
Message-ID: <20011104122248.A13561@netnation.com>
In-Reply-To: <00a901c16526$48c64300$1a502341@cfl.rr.com> <Pine.GSO.4.21.0111040702440.20848-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0111040702440.20848-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 07:05:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...Guessing that it had something to do with set_blocksize, I added
this patch to the kernel:

--- linux/fs/block_dev.c.orig	Sun Nov  4 11:35:05 2001
+++ linux/fs/block_dev.c	Sun Nov  4 11:54:39 2001
@@ -95,6 +95,9 @@
 	/* Ok, we're actually changing the blocksize.. */
 	bdev = bdget(dev);
 	sync_buffers(dev, 2);
+	printk("Changing device %02x:%02x block size from %u to %u\n",
+		MAJOR(dev),MINOR(dev),
+		blksize_size[MAJOR(dev)][MINOR(dev)],size);
 	blksize_size[MAJOR(dev)][MINOR(dev)] = size;
 	bdev->bd_inode->i_blkbits = blksize_bits(size);
 	kill_bdev(bdev);

And tried booting again with /dev/hdb2 swap in my fstab...

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Changing device 03:02 block size from 1024 to 2048
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Changing device 03:03 block size from 1024 to 4096
Adding Swap: 265064k swap-space (priority 0)
Changing device 03:42 block size from 10739452 to 4096
attempt to access beyond end of device
03:02: rw=0, want=10555924, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=10555926, limit=4096

It looks like it's not changing 03:02 (/dev/hda2, my root fs), which is
good, but it seems to be trying to change 03:42 (/dev/hdb2) even though
that device doesn't exist (which could also be fine, but it looks like it
wasn't initialized).  I'm guessing blksize_size is statically allocated,
so this isn't a problem.

I wonder what else could cause 03:02 to barf... Hmm.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
