Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDFKtF>; Fri, 6 Apr 2001 06:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRDFKsz>; Fri, 6 Apr 2001 06:48:55 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:51728 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S131477AbRDFKsp>; Fri, 6 Apr 2001 06:48:45 -0400
Date: Fri, 6 Apr 2001 12:48:03 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>, <linux-crypto@nl.linux.org>
Subject: IV calculation, blocksize (and CBC type encryptions) in loop.c
In-Reply-To: <20010405190117.F5187@suse.de>
Message-ID: <Pine.LNX.4.30.0104061104210.1067-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello...

On Thu, 5 Apr 2001, Jens Axboe wrote:
> On Thu, Apr 05 2001, Herbert Valerio Riedel wrote:
> > I've had success w/ your lvm-stack-1 patch on my system...
> > (next thing I'll testing will be w/ the real crypto patch)
> Ok, good so far.

well... after some hours of code reading and experimenting I'm a bit stuck
with the next problem: the blocksize in the loop's transfer function...

I've got this one problem:

for encryption to work, especially the cbc variants (which are the only
one supported for loop encryption by the newest crypt patch), I need to
read the data block with the same block length, which it was written
with....

e.g. since user space programs aren't able to set the blocksize on loop
devices, they use the last active blocksize for that loop device.

on the other hand kernel space code is able to set blocksize... or at
least it seems so...
(btw, does loop_get_bs() return always the same blocksize... ?)

I've noticed that kernelspace filesystem code is able to do so... what

I've tried: I modified transfer_none() to spit out the arguments it got
passed, then I set up a loop device (about 1 gig large), then I created a
filesystem with mke2fs, making sure a blocksize greater than BLOCK_SIZE
was used, then I tried to sync/flush the buffer cache, and then I mounted
that filesystem... (using XFS shows the problem even better, since that
filesystem uses different blocksizes for the different sections)

$ losetup /dev/loop0 /dev/hda1

$ mke2fs -b 4096 /dev/loop0
this showed transfer's were done with size % 1024 == 0...

$ [...flush/sync buffers...]

$ mount /dev/loop0 /mnt/foo
this showed that transfer's were done mostly with size % 4096 == 0
and real_block % 4 == 0

$ umount /dev/loop0

$ mke2fs -b 4096 /dev/loop0
now all transfer's have size % 4096 == 0 and real_block % 4 == 0...

(btw, trying to set the blocksize by ioctl() from user space fails...)

now I could just workaround that problem, by operating on smaller blocks
in the transfer_function, and incrementing that IV by myself...
but then another problem is, that the IV calculation
breaks if the blocksize is set below 1024 byte, and only partial blocks
(as those blocksizes on which IV calculation relays) get processed... :-/

it's quite a mess :-(

you can test for yourself the effects, by making the transfer_xor
scrambling key depending on the real_block argument... (w/o having to
apply the full crypto patches...)

any ideas how to get IV+cbc based crypto 'fixed'?
(btw, I'm talking about block device backed loop setup's, no lvm
involved... just /dev/hda1...)

I hope I've succeeded explaining the problem clear enough...

greetings,
--

