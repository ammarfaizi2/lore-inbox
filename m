Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBNBEL>; Tue, 13 Feb 2001 20:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbRBNBEB>; Tue, 13 Feb 2001 20:04:01 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:64904 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S129336AbRBNBDm>; Tue, 13 Feb 2001 20:03:42 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9D00@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: Andries.Brouwer@cwi.nl, Michael_E_Brown@Dell.com
Cc: Matt_Domsch@Dell.com, freitag@alancoxonachip.com,
        linux-kernel@vger.kernel.org, aia21@cam.ac.uk
Subject: RE: block ioctl to read/write last sector
Date: Tue, 13 Feb 2001 19:00:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > While we can read and write to this sector in the kernel 
> > partition code, we have
> > no way for userspace to update this partition block.
> 
> Are you sure?

I'm not sure, but when I asked about this in January, I suggested having an
IOCTL that get/set blksize_size[MAJOR(dev)][MINOR(dev)], which didn't seem
to work for me.

> I need to read/write the last 512-byte
> sector on an odd-sized disk (IDE and/or SCSI) from user space.  Employing
> suggestions from you and l-k, I have implemented two IOCTLs that get/set
the
> blksize_size[MAJOR(dev)][MINOR(dev)] values (via set_blocksize()).  In my
> application, I read the hardsector size of a disk device (/dev/sdb) via an
> IOCTL, read the current blksize_size, set it to the hardsector size, and
> then continue, resetting blksize_size back to the original value when
done.
> 
> In between, I use fopen64() to open the device /dev/sdb (an odd-sized
disk),
> and lseek64()/fwrite64()/fread64() to write/read the last sector of the
disk
> as reported by the BLKGETSIZE ioctl.  The seek succeeds, however, the
> reads/writes fail.  Writes fail with "No space left on device".  Read
> returns 0, indicating EOF.   If I read/write the N-1th sector this way, it
> works just fine. On even-sized disks, this succeeds both with and
> without calling my new IOCTLs, as expected.  On odd-sized disks, it
> fails in both cases.

Anton Altaparmakov responded:

> I am sure Andries will correct me if I am wrong but here is 
> what I think of the situation at present:
> 
> I suspect that you will find the problem in 
> linux/fs/block_dev.c functions
> block_write() and block_read() which AFAIK only get called 
> when you use
> usermode to read a /dev/* blockdevice as you probably are 
> doing. From the
> kernel these functions AFAIK never get called and hence the problem
> doesn't exist (either way I am surprised that it works as looking at
> generic_make_request() there is a check of simillar type and AFAICS it
> would fail as well for the same reason. I probably don't understand
> something there and/or generic_make_request() is not being 
> called either,
> as it obviously works, since you have tried it).
> 
> In block_write() you find this (lines 58ff in the file in 2.4.0):
> [snip]
>         if (blk_size[MAJOR(dev)])
>                 size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] <<
> BLOCK_SIZE_BITS) >> blocksize_bits;
>         else
>                 size = INT_MAX;
>         while (count>0) {
>                 if (block >= size)
>                         return written ? written : -ENOSPC;
> [snip]
> 
> As you can see when size is calculated blk_size is multiplied 
> by 1024 and
> then divided by 512, effectively blk_size is multiplied by 2.
> 
> The effect of this is that size has the lowest bit always 
> equal to zero
> and hence it always will be even.
> 
> The subsequent check "if (block >= size)" of course is then 
> true and we
> return with -ENOSPC straight away.
> 
> In block_read() you find this (lines 195ff in the file in 2.4.0):
> [snip]
>         if (blk_size[MAJOR(dev)])
>                 size = (loff_t) blk_size[MAJOR(dev)][MINOR(dev)] <<
> BLOCK_SIZE_BITS;
>         else
>                 size = (loff_t) INT_MAX << BLOCK_SIZE_BITS;
> 
>         if (offset > size)
>                 left = 0;
> [snip]
>         if (left <= 0)
>                 return 0;
> [snip]
> 
> And again size is equal to blk_size multiplied by 1024 and 
> hence always
> will be even.

If this analysis is correct (and I think it is), changing the block size
doesn't actually solve the problem.

I've got no problems requiring any IOCTL (either block-size-changing or just
a read/write last sector) to check that a device isn't in use somehow prior
to making these calls.  Changing a disk's partition table while partitions
are actively in use on it isn't generally a good idea.  But, fdisk and other
partition table-changing apps don't do this kind of check now IIRC.


Thanks,
Matt


-- 
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


