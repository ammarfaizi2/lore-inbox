Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRIHKhO>; Sat, 8 Sep 2001 06:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRIHKgy>; Sat, 8 Sep 2001 06:36:54 -0400
Received: from mailc.telia.com ([194.22.190.4]:49871 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S268926AbRIHKgs>;
	Sat, 8 Sep 2001 06:36:48 -0400
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.4.10-pre5
In-Reply-To: <3B99A8C2.56E88CE3@isn.net>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Sep 2001 12:36:56 +0200
In-Reply-To: <3B99A8C2.56E88CE3@isn.net>
Message-ID: <m2lmjq7yuv.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Garst R. Reese" <reese@isn.net> writes:

> Garstmake[2]: Entering directory `/usr/src/linux/drivers/block'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> rd.c: In function `rd_ioctl':
> rd.c:262: invalid type argument of `->'
> rd.c: In function `rd_cleanup':
> rd.c:375: too few arguments to function `blkdev_put'
> make[2]: *** [rd.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
> Command exited with non-zero status 2

This patch seems to work:

--- linux/drivers/block/rd.c.orig	Sat Sep  8 11:58:19 2001
+++ linux/drivers/block/rd.c	Sat Sep  8 12:21:50 2001
@@ -259,7 +259,7 @@
 			/* special: we want to release the ramdisk memory,
 			   it's not like with the other blockdevices where
 			   this ioctl only flushes away the buffer cache. */
-			if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
+			if ((atomic_read(&rd_bdev[minor]->bd_openers) > 2))
 				return -EBUSY;
 			destroy_buffers(inode->i_rdev);
 			rd_blocksizes[minor] = 0;
@@ -372,7 +372,7 @@
 		struct block_device *bdev = rd_bdev[i];
 		rd_bdev[i] = NULL;
 		if (bdev) {
-			blkdev_put(bdev);
+			blkdev_put(bdev, BDEV_FILE);
 			bdput(bdev);
 		}
 		destroy_buffers(MKDEV(MAJOR_NR, i));

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
