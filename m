Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRKOFfX>; Thu, 15 Nov 2001 00:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280744AbRKOFfN>; Thu, 15 Nov 2001 00:35:13 -0500
Received: from ppp-RAS1-1-87.dialup.eol.ca ([64.56.224.87]:15368 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S280725AbRKOFe5>; Thu, 15 Nov 2001 00:34:57 -0500
Date: Thu, 15 Nov 2001 00:34:34 -0500
From: William Park <opengeometry@yahoo.ca>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011115003434.A25883@node0.opengeometry.ca>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111142041.fAEKfBN15594@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Nov 14, 2001 at 09:41:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 09:41:11PM +0100, Peter T. Breuer wrote:
> Am I making plain the difference between blk_size and blksize?
> 
> blk_size is the number of blocks or KB (which?) in a device. blksize is
> the size of the blocks. Is blk_size in KB or blocks?
> 
> It should be in blocks if the size of a device is to reach 8 or 16TB.
> If it is in KB, we are limited to 2 or 4TB.

I've been following this thread intensely.  I need to use Network Block
Device to get very large network-RAID.  And, resolution to this issue is
of great interest to me. 

Judging by 'driver/block/nbd.c', it counts by BLOCK_SIZE=1204
(BLOCK_SIZE_BITS=10), even though you can set the block size to
[512,1024,...,PAGE_SIZE=4096].  Since NBD counts this 1KB block using
'u64' integer, the ultimate size of filesystem is determined by the
kernel block device support.

Looking at 'fs/block_dev.c', you can set the block size to
[512,1024,...,PAGE_SIZE=4096] also.  But, 'max_block()' returns block
count in whatever block size of the device, not in BLOCK_SIZE:

    static unsigned long max_block(kdev_t dev)
    {
	unsigned int retval = ~0U;
	int major = MAJOR(dev);

	if (blk_size[major]) {
	    int minor = MINOR(dev);
	    unsigned int blocks = blk_size[major][minor];
	    if (blocks) {
		unsigned int size = block_size(dev);
		unsigned int sizebits = blksize_bits(size);
		blocks += (size-1) >> BLOCK_SIZE_BITS;
		retval = blocks << (BLOCK_SIZE_BITS - sizebits);
		if (sizebits > BLOCK_SIZE_BITS)
		    retval = blocks >> (sizebits - BLOCK_SIZE_BITS);
	    }
	}
	return retval;
    }

In particular, if block size is 512, then the block count is multiplied
by 2; and if block size if 4096, then the block count is divided by 4.
It thinks that 'blk_size[][]' is block count in KB.  So, I can only
deduce that block count is in KB.

Also, from 'include/linux/blkdev.h',
    extern int * blk_size[MAX_BLKDEV];
'blk_size[][]' is 'int', which means maximum size of block device is
2^10 x 2^31 = 2^41 = 2TB.  However, because it is always converted to
'unsigned int' for block count calculation, I think you can take it as
4TB.

Am I right?

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
