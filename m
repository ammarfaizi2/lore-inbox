Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280781AbRKOMgQ>; Thu, 15 Nov 2001 07:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKOMgG>; Thu, 15 Nov 2001 07:36:06 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:16142 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S280781AbRKOMfy>;
	Thu, 15 Nov 2001 07:35:54 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111151235.fAFCZQY31248@oboe.it.uc3m.es>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca> from "William Park"
 at "Nov 15, 2001 00:34:34 am"
To: "William Park" <opengeometry@yahoo.ca>
Date: Thu, 15 Nov 2001 13:35:26 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago William Park wrote:"
> On Wed, Nov 14, 2001 at 09:41:11PM +0100, Peter T. Breuer wrote:
> > blk_size is the number of blocks or KB (which?) in a device. blksize is
> > the size of the blocks. Is blk_size in KB or blocks?
> > 
> > It should be in blocks if the size of a device is to reach 8 or 16TB.
> > If it is in KB, we are limited to 2 or 4TB.
> 
> I've been following this thread intensely.  I need to use Network Block
> Device to get very large network-RAID.  And, resolution to this issue is
> of great interest to me. 

Yes, well, you may be the person on whose behalf I started checking it
out.

To put your mind at rest, all devices (partitions, etc.) are limited by
the 32 bit int that holds the number of sectors on a device. This is
31+9 bits of space (i don't know whether negative sectors are counted
as positive :), which is 1 (or 2, if you use unsigned interpretation)
TB.

So the blk_size/blksize business is irrelevant.

> Judging by 'driver/block/nbd.c', it counts by BLOCK_SIZE=1204
> (BLOCK_SIZE_BITS=10), even though you can set the block size to
> [512,1024,...,PAGE_SIZE=4096].  Since NBD counts this 1KB block using
> 'u64' integer, the ultimate size of filesystem is determined by the
> kernel block device support.

This is correct, but it's quite a deep dependence in the kernel.
Though nbd (and my enbd) use 64 bit sizes in their network protocols,
you can't get rid of the limitation just like that. The kernel is
infested with the limit associated with a 32bit sector count. The
32bit KB count in blk_size is also a limit, but never an active one
as the sector count bites first, before the other is reached. The
kernel's VM thinks those sector counts are 32 bit and that sectors
are 512B, which means the person in charge of the VM must handle any
changes.

To tell the truth, counting in 512B sectors is the only sane way to
go.  It sends you mad counting in units of blocks, because that
can be a variable size.

> Looking at 'fs/block_dev.c', you can set the block size to
> [512,1024,...,PAGE_SIZE=4096] also.  But, 'max_block()' returns block
> count in whatever block size of the device, not in BLOCK_SIZE:

It looks to me as though block_dev.c has been "prepared" to be more
flexible, and that it will be a short job to either use 64bit sector
counts for it, or move to counting in blocks. The same work
has not gone into ll_rw_blk.c yet.

> In particular, if block size is 512, then the block count is multiplied
> by 2; and if block size if 4096, then the block count is divided by 4.
> It thinks that 'blk_size[][]' is block count in KB.  So, I can only
> deduce that block count is in KB.

It still is, yes.

> Also, from 'include/linux/blkdev.h',
>     extern int * blk_size[MAX_BLKDEV];
> 'blk_size[][]' is 'int', which means maximum size of block device is
> 2^10 x 2^31 = 2^41 = 2TB.  However, because it is always converted to
> 'unsigned int' for block count calculation, I think you can take it as
> 4TB.
> 
> Am I right?

As far as I can tell. I was trying to ask here if it had changed, but 
evidently it has not.

What is the forward strategy? I see no alternative but moving to 64bit
sector counts. 

Peter
