Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSHAV5W>; Thu, 1 Aug 2002 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSHAV5W>; Thu, 1 Aug 2002 17:57:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:2688 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317592AbSHAV5V>;
	Thu, 1 Aug 2002 17:57:21 -0400
Date: Fri, 2 Aug 2002 00:00:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: dalecki@evision.ag
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
Message-ID: <20020801220031.GA1756@vana.vc.cvut.cz>
References: <C94E6D2807@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C94E6D2807@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 07:07:21PM +0200, Petr Vandrovec wrote:
> On 31 Jul 02 at 22:01, Marcin Dalecki wrote:
> > 
> > Well OK this was my next idea, but apparently you already did the
> > experient on your own. Thanks for the result. I'm still scratching my
> > head and I have already observed this before myself.
> > It's always funny to see what happens when one stops a driver
> > from deliberately disabling IRQs for eons of jiffies :-).
> 
> I currently suspect IRQ handling changes, but maybe someone has
> better idea? Also, I cannot reproduce problem with Seagate UDMA66
> drive switched to UDMA33 mode, so it looks like that problem is 
> timming/firmware (Toshiba MK6409MAV) dependent.

I'd like to apologize to Ingo, his changes were completely innocent.
Problem was triggered by Al's 'block device size cleanups' (currently
cset 1.403.160.5 on bkbits).

Before this change, my system was using 4KB block size when reading
from /dev/hdc1, because of blk_size[][] (which is in 1kB units) of this 
partition was multiple of 2, and so i_size % 4096 was 0.  But after
Al's change partition size is read from gendisk, and not from blk_size,
and gendisk partition size is in 512 bytes units: and, as you can
probably guess, now my partition had i_size % 4096 == 512, and so only
512 byte block size was choosen. And with 512 bytes block size my
harddisk refuses to cooperate.

I was trying to find reason in code, why 512 byte block size should
not work, but I was not able to reveal any. Maybe I/O gurus here
will know?

For now, I'm using patch below. It fixes problems for me, block size = 1024
is sufficient in my configuration. If you have any insights what can be
a problem, please tell me. Problem apparently is not in i_size not being
multiple of 1024: without changing bsize problem still occurs, even if
I shrink i_size down to be multiple of 4K.

After some more testing I found that my other drive (120GB WD) handles
bsize=512 quite happily, so it looks like that just my Toshiba disk
does not like 512B back to back transfers?! Are there any plans to
read from block devices in 4KB blocks for all reads/writes except for
the last partial page?
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

--- linux-2.5.29-c548/fs/block_dev.c.orig	2002-07-31 12:48:23.000000000 +0200
+++ linux-2.5.29-c548/fs/block_dev.c	2002-08-01 23:20:43.000000000 +0200
@@ -608,6 +608,11 @@
 				break;
 			bsize <<= 1;
 		}
+		if (bsize == 512) {
+			printk(KERN_ERR "Found 512b device! Using larger block size...\n");
+			bdev->bd_inode->i_size -= 512;
+			bsize = 1024;
+		}
 		bdev->bd_block_size = bsize;
 		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 		if (p->queue)
