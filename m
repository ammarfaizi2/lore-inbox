Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbRB1Opi>; Wed, 28 Feb 2001 09:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbRB1Op2>; Wed, 28 Feb 2001 09:45:28 -0500
Received: from oker.escape.de ([194.120.234.254]:16928 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S130196AbRB1OpP>;
	Wed, 28 Feb 2001 09:45:15 -0500
To: linux-lvm@sistina.com
CC: linux-kernel@vger.kernel.org
Subject: Bugs in LVM and ext2 + suggestion for fix (was: Problem mounting ext2 fs on LVM)
In-Reply-To: <200102272007.f1RK7aM27545@webber.adilger.net>
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 28 Feb 2001 15:44:12 +0100
In-Reply-To: <200102272007.f1RK7aM27545@webber.adilger.net>; from Andreas Dilger on Tue, 27 Feb 2001 13:07:36 -0700 (MST)
Message-ID: <m21ysi3m0z.fsf@isnogud.escape.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For LKML readers: I had a problem mounting an ext2 FS on LVM with 1K
block size while 4K block size did work.  I'd like answers CC:'ed to
the LVM ML or, if there inapproriate there, to me, since I currently
do not read LKML.

I've read lots of EXT2 and LVM src code and I think it turns out that
there is a bug in both.  Andreas has already given the fix for the
ext2, a suggestion for LVM is below (sorry, no patch, I really know to
little about all the block sizes and buffers of block devices).


Andreas Dilger <adilger@turbolinux.com> writes:

>Urs writes:
>
>> Feb 27 17:04:39 isnogud kernel: VFS: Unsupported blocksize on dev lvm(58,0).
>
> This is an ext2 message when sb->s_blocksize != bh->b_size, even though
> ext2 _should_ set the block size correctly if we get to this point (it
> will call set_blocksize(sb->s_blocksize)).
> 
> Now I see what the problem might be, it is in ext2.  Give it a try and
> let me know how it goes.
> 
> Cheers, Andreas
> ==========================================================================
> --- fs/ext2/super.c.orig	Fri Feb  2 17:12:09 2001
> +++ fs/ext2/super.c	Tue Feb 27 12:53:41 2001
> @@ -787,7 +791,7 @@
> 	  
> 	  sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
> 	  
> -	if (sb->s_blocksize != BLOCK_SIZE &&
> +	if (sb->s_blocksize != blocksize &&
> 	      (sb->s_blocksize == 1024 || sb->s_blocksize == 2048 ||
> 	       sb->s_blocksize == 4096)) {
> 		  /*


I think your patch is right and should be sent to the ext2
maintainers.  The condition to test should indeed be, wether the block
size in the super block is one of the known size 1K, 2K or 4K, and if
it is different from the block size (hardsect_size[]) of the block
device.  If so, the block size of the device (blksize_size[]) should
be set by calling set_blocksize(dev, sb->s_blocksize) and a new
buffer_head obtained by bh=bread(...,sb->s_blocksize)

BTW, can someone tell what the purpose having blksize_size[] and
hardsect_size[] is?


Anyway, I think your patch doesn't solve my problem with LVM, though I
haven't tried it yet.

The problem is, that mounting an ext2 fs on a LV (like on any other
block device), where the ext2 block size is greater than the
hardsect_size of the device causes the ext2 code to call
set_blocksize() on the device which then sets the blksize_size[] entry
for that device.

With LVM, blksize_size[MAJOR] and hardsect_size[MAJOR] point to the
same array, namely lvm_blocksizes[], which are initialized to
BLOCK_SIZE (1024).  

    void __init lvm_geninit(struct gendisk *lvm_gdisk)
    {
	
    	    ...
    	    for (i = 0; i < MAX_LV; i++) {
    		    ...
    		    lvm_blocksizes[i] = BLOCK_SIZE;
    	    }
    
    	    blk_size[MAJOR_NR] = lvm_size;
    	    blksize_size[MAJOR_NR] = lvm_blocksizes;
    	    hardsect_size[MAJOR_NR] = lvm_blocksizes;
    
    	    return;
    } /* lvm_gen_init() */
    
Mounting an ext2 FS therefore causes not only the
blksize_size[MAJOR(dev)][MINOR(dev)] but also the
hardsect_size[MAJOR(dev)][MINOR(dev)] to be increased to the ext2
block size.  And this can't never be reduced to BLOCK_SIZE again,
except by unloading/loading the LVM module which initializes
lvm_blocksizes[].

This means, I can mount an ext2 FS with 1K block size on a specific
major/minor after loading the LVM module.  If I mount a FS with a
larger block size, the hardsect_size[] is increased and from then on I
can only mount file systems with at least the same block size.
I.e. after mounting an ext2 FS with 2K block size, I can only mount 2K
and 4K ext2 file systems.  After mounting 4K ext2 FS I can only mount
4K ext2 file systems.

With a freshly loaded LVM module I do

    isnogud:/root# vgcreate vg0 /dev/sda5; lvcreate -n test vg 0 -L1024
    [...]
    isnogud:/root# mke2fs -q /dev/vg0/test -b 1024
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    isnogud:/root# umount /mnt
    isnogud:/root# mke2fs -q /dev/vg0/test -b 2048
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    isnogud:/root# umount /mnt
    isnogud:/root# mke2fs -q /dev/vg0/test -b 1024
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    mount: wrong fs type, bad option, bad superblock on /dev/vg0/test,
    	   or too many mounted file systems

The kernel log says (I have slighty modified the msg fmt in
ext2/super.c to also print sb->s_blocksize and bh->b_size):

    VFS: Unsupported blocksize on dev lvm(58,0) (1024!=2048).

At this point I can still mount ext2 FS with 2K block size.  OK, now I
mount a FS with 4K block size:

    isnogud:/root# mke2fs -q /dev/vg0/test -b 4096
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    isnogud:/root# umount /mnt

>From now on, I can't mount file systems with 1K or 2K block size,
since the hardsect_size[][] is now 4K:

    isnogud:/root# mke2fs -q /dev/vg0/test -b 1024
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    mount: wrong fs type, bad option, bad superblock on /dev/vg0/test,
    	   or too many mounted file systems
    isnogud:/root# dmesg|tail -1
    VFS: Unsupported blocksize on dev lvm(58,0) (1024!=4096).
    isnogud:/root# mke2fs -q /dev/vg0/test -b 2048
    mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
    isnogud:/root# mount /dev/vg0/test /mnt
    mount: wrong fs type, bad option, bad superblock on /dev/vg0/test,
    	   or too many mounted file systems
    isnogud:/root# dmesg|tail -1
    EXT2-fs: blocksize too small for device.

Because of the wrong? test in fs/ext2/super.c (BLOCK_SIZE instead of
blocksize) the log message "Unsupported blocksize..." is printed
where I assume it should be "EXT2-fs: blocksize too small...", since
the hardsect_size[][] of the LVM device is 2K or 4K which is *not*
unsupported but to large for a file system with smaller blocks.



I think the solution for LVM is to have blksize_size[] and
hardsect_size[] not point to the same lvm_blocksizes[] array, but to
have a separate lvm_hardsect_size[] which is not affected by
set_blocksize().

However, I don't quite understand what the reason for having separate
blksize_size[] and hardsect_size[] is and how the bh->b_size differs
from that.  I assume the hardsect_size[] is the hardware sector size
of the physical device, but what's the purpose of blksize_size[]?
AFAICS, with bread(dev,block,size) I get a struct buffer_head, whose
b_size is set to the size arguement.  I guess via this buffer_head I
can access the device as it would have b_size blocks instead of
hardsect_size[] sectors.

Can two different users access the same block device with different
block sizes if they have an own buffer_head each?  And again, what is
blksize_size[] for, then?


urs
