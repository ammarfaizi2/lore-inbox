Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290539AbSAQXtr>; Thu, 17 Jan 2002 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290543AbSAQXtd>; Thu, 17 Jan 2002 18:49:33 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59088 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S290538AbSAQXsf>;
	Thu, 17 Jan 2002 18:48:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 17 Jan 2002 23:48:16 GMT
Message-Id: <UTC200201172348.XAA420548.aeb@cwi.nl>
To: Matt_Domsch@dell.com, tpepper@vato.org
Subject: Re: BLKGETSIZE64 (bytes or sectors?)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@dell.com wrote, and he is right:

    > Is the BLKGETSIZE64 ioctl supposed to return the size of the device in 
    > bytes (as the comment says, and is implemented in all places *except* 
    > blkpg.c), or in sectors (as is implemented in blkpg.c since 2.4.15)?

Yes, in bytes. blkpg.c has to be fixed.
Several people submitted patches. Sooner or later I suppose
this will be fixed.

Then Tim Pepper answered, and he is wrong:

    Wouldn't it be better to do the following (against 2.4.17).

    +            else {
    +                if (hardsect_size[MAJOR(dev)][MINOR(dev)]) {
    +                    ullval *= hardsect_size[MAJOR(dev)][MINOR(dev)];
    +                } else {
    +                    ullval *= 512;
    +                }
                     return put_user(ullval, (u64 *)arg);
    +            }

You see, the 512 here is 512, and has no relation to hardware
sector size. Multiplying with hardsect_size[][] is a bad bug.

Indeed, you can check this in fs/partitions/msdos.c, where
one reads
	int sector_size = get_hardsect_size(to_kdev_t(bdev->bd_dev)) / 512;
	...
	offs = START_SECT(p)*sector_size;
	size = NR_SECTS(p)*sector_size;
	...
	add_gd_partition(...);

So, indeed, we have already multiplied by hardsect_size, struct gendisk
uses sectors of size 512, independent of the hardware, and we must not
again multiply by hardsect_size.

Unfortunately Matt Domsch replied:

    > Yes, I agree.

but he meant: No!

Andries
