Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbREVWsl>; Tue, 22 May 2001 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbREVWsb>; Tue, 22 May 2001 18:48:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57604 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S262877AbREVWsR>; Tue, 22 May 2001 18:48:17 -0400
Message-ID: <3B0AEC76.F5B425F5@evision-ventures.com>
Date: Wed, 23 May 2001 00:47:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222217.AAA79157.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And if we are at the topic... Those are the places where blk_size[]
get's
abused, since it's in fact a property of a FS in fact and not the
property of
a particular device... blksect_size is the array describing the physical
access limits of a device and blk_size get's usually checked against it.
However due to the bad naming and the fact that this information is
associated with major/minor number usage same device driver writers got
*very* confused as you can see below:

./fs/block_dev.c: Here this information should be passed entierly insice
the request.

./fs/partitions/check.c: Here it basically get's reset or ignored


Here it's serving the purpose of a sector size, which is bogous!

./mm/swapfile.c:#include <linux/blkdev.h> /* for blk_size */
./mm/swapfile.c:		if (!dev || (blk_size[MAJOR(dev)] &&
./mm/swapfile.c:		     !blk_size[MAJOR(dev)][MINOR(dev)]))
./mm/swapfile.c:		if (blk_size[MAJOR(dev)])
./mm/swapfile.c:			swapfilesize = blk_size[MAJOR(dev)][MINOR(dev)]


Here it shouldn't be needed
./drivers/block/ll_rw_blk.c: 


./drivers/block/floppy.c:	blk_size[MAJOR_NR] = floppy_sizes;
./drivers/block/nbd.c:	blk_size[MAJOR_NR] = nbd_sizes;
./drivers/block/rd.c: * and set blk_size for -ENOSPC,     Werner Fink
<werner@suse.de>, Apr '99
./drivers/block/amiflop.c:	blk_size[MAJOR_NR] = floppy_sizes;
./drivers/block/loop.c:	if (blk_size[MAJOR(lodev)])
./drivers/block/ataflop.c: *   - Set blk_size for proper size checking
./drivers/block/ataflop.c:	blk_size[MAJOR_NR] = floppy_sizes;
./drivers/block/cpqarray.c:				drv->blk_size;
./drivers/block/z2ram.c:	blk_size[ MAJOR_NR ] = z2_sizes;
./drivers/block/swim3.c:		blk_size[MAJOR_NR] = floppy_sizes;
./drivers/block/swim_iop.c:	blk_size[MAJOR_NR] = floppy_sizes;
./drivers/char/raw.c:	if (blk_size[MAJOR(dev)])
./drivers/scsi/advansys.c:    ASC_DCNT            blk_size;
./drivers/scsi/sd.c:		blk_size[SD_MAJOR(i)] = NULL;
./drivers/scsi/sr.c:	blk_size[MAJOR_NR] = sr_sizes;
./drivers/scsi/sr.c:	blk_size[MAJOR_NR] = NULL;
./drivers/sbus/char/jsflash.c:	blk_size[JSFD_MAJOR] = jsfd_sizes;
./drivers/ide/ide-cd.c:	blk_size[HWIF(drive)->major] =
HWIF(drive)->gd->sizes;
./drivers/ide/ide-floppy.c: *	Revalidate the new media. Should set
blk_size[]
./drivers/acorn/block/fd1772.c:	blk_size[MAJOR_NR] = floppy_sizes;
./drivers/i2o/i2o_block.c:	blk_size[MAJOR_NR] = i2ob_sizes;

In the following they are REALLY confusing it and then compensating for
this misunderstanding in lvm.h by redefining the corresponding default
values.

./drivers/s390/*

And then some minor confusions follow...

./drivers/mtd/mtdblock.c:	blk_size[MAJOR_NR] = NULL;
./drivers/md/md.c:	if (blk_size[MAJOR(dev)])
./arch/m68k/atari/stram.c:    blk_size[STRAM_MAJOR] = stram_sizes;

Basically one should just stop setting blk_size[][] inside *ANY* driver
and anything should still work fine unless the driver is broken...

Well that's the point for another fine kernel experiment I will do
and report whatever it works really out like this in reality 8-)
