Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265945AbRFZIVU>; Tue, 26 Jun 2001 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265949AbRFZIVK>; Tue, 26 Jun 2001 04:21:10 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:42985 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S265945AbRFZIUu>; Tue, 26 Jun 2001 04:20:50 -0400
Message-ID: <3B384567.BE3BE0EA@pp.inet.fi>
Date: Tue, 26 Jun 2001 11:18:47 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: Andries.Brouwer@cwi.nl, axboe@suse.de, linux-kernel@vger.kernel.org,
        R.E.Wolff@BitWizard.nl
Subject: Re: loop device broken in 2.4.6-pre5
In-Reply-To: <UTC200106212258.AAA370096.aeb@vlet.cwi.nl> <3B334F39.E25548E0@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem. Please consider applying.

--- linux-2.4.6-pre5/drivers/block/loop.c	Sat Jun 23 07:52:39 2001
+++ linux/drivers/block/loop.c	Tue Jun 26 09:21:47 2001
@@ -653,7 +653,7 @@
 	bs = 0;
 	if (blksize_size[MAJOR(lo_device)])
 		bs = blksize_size[MAJOR(lo_device)][MINOR(lo_device)];
-	if (!bs)
+	if (!bs || S_ISREG(inode->i_mode))
 		bs = BLOCK_SIZE;
 
 	set_blocksize(dev, bs);

Jari Ruusu wrote:
> Andries.Brouwer@cwi.nl wrote:
> >     From: Jari Ruusu <jari.ruusu@pp.inet.fi>
> >
> >     File backed loop device on 4k block size ext2 filesystem:
> >
> >     # dd if=/dev/zero of=file1 bs=1024 count=10
> >     10+0 records in
> >     10+0 records out
> >     # losetup /dev/loop0 file1
> >     # dd if=/dev/zero of=/dev/loop0 bs=1024 count=10 conv=notrunc
> >     dd: /dev/loop0: No space left on device
> >     9+0 records in
> >     8+0 records out
> >     # tune2fs -l /dev/hda1 2>&1| grep "Block size"
> >     Block size:               4096
> >     # uname -a
> >     Linux debian 2.4.6-pre5 #1 Thu Jun 21 14:27:25 EEST 2001 i686 unknown
> >
> >     Stock 2.4.5 and 2.4.5-ac15 don't have this problem.
> >
> > I am not sure there is an error here.
> >
> > The default block size of a loop device is that of the underlying device.
> > There was a kernel bug that was recently fixed, where the block size
> > of a file backed loop device could be essentially random.
> > So, earlier you happened to get blocksize 1024, and you had room for
> > 10 blocks of size 1024.
> > Now you have blocksize 4096, and you have room for 2 blocks of size 4096.
> > There are no fractional blocks at the end of a block device.
> 
> Why can't we keep the default at 1024 regardless of what the block size of
> underlying device is. There are some situations where all of loop device
> must be accessed before it is mounted (at which point the block size is set
> to desired value).

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
