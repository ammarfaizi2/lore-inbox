Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278820AbRKDUdX>; Sun, 4 Nov 2001 15:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKDUdN>; Sun, 4 Nov 2001 15:33:13 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:1664 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S278810AbRKDUdG>;
	Sun, 4 Nov 2001 15:33:06 -0500
Date: Sun, 4 Nov 2001 12:33:00 -0800
From: Simon Kirby <sim@netnation.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mike Black <mblack@csihq.com>, linux-kernel@vger.kernel.org
Subject: Re: Something broken in sys_swapon
Message-ID: <20011104123300.A665@netnation.com>
In-Reply-To: <00a901c16526$48c64300$1a502341@cfl.rr.com> <Pine.GSO.4.21.0111040702440.20848-100000@weyl.math.psu.edu> <20011104122248.A13561@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011104122248.A13561@netnation.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha!  I then tried this patch:

--- linux/fs/block_dev.c.orig	Sun Nov  4 11:35:05 2001
+++ linux/fs/block_dev.c	Sun Nov  4 12:21:51 2001
@@ -84,6 +84,15 @@
 	}
 
 	oldsize = blksize_size[MAJOR(dev)][MINOR(dev)];
+
+	printk("Changing device %02x:%02x block size from %u to %u\n",
+		MAJOR(dev),MINOR(dev),
+		oldsize,size);
+	if (MAJOR(dev) == 0x03 && MINOR(dev) == 0x42){
+		printk("...Refused.\n");
+		return 0;
+	}
+
 	if (oldsize == size)
 		return 0;
 
...And now my system boots fine with /dev/hdb2 swap in the fstab.

In fact, I tried /dev/hdb1 after and then I couldn't read any more from
/boot (which is /dev/hda1).  So, some sort of wraparound is happening
here.  Why would blksize_size[3][2] be affected by blksize_size[3][0x42]?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
