Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129762AbRBPMqJ>; Fri, 16 Feb 2001 07:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRBPMp7>; Fri, 16 Feb 2001 07:45:59 -0500
Received: from mail.valinux.com ([198.186.202.175]:13586 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129762AbRBPMpp>;
	Fri, 16 Feb 2001 07:45:45 -0500
To: alan@lxorguk.ukuu.org.uk
CC: sflory@valinux.com, chip@valinux.com, linux-kernel@vger.kernel.org
cc: sct@redhat.com
In-Reply-To: <E14ThUy-0002ed-00@the-village.bc.nu> (message from Alan Cox on
	Fri, 16 Feb 2001 09:48:17 +0000 (GMT))
Subject: Re: mke2fs and kernel VM issues
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <E14ThUy-0002ed-00@the-village.bc.nu>
Message-Id: <E14TkFk-0007Nz-00@beefcake.hdqt.valinux.com>
Date: Fri, 16 Feb 2001 04:44:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 16 Feb 2001 09:48:17 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   > heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
   > believed to be a known good kernel?  (both 2.2.x and 2.4.x)

   I've not seen the problem on unmodified 2.2.18. The 2.2.17/18 VM does have
   its problems but not these. 2.2.19pre3 and higher have the Andrea VM fixes which
   have worked wonders for everyone so far. 

Note that this only shows up when using mke2fs to create very large
filesystems, and you have relatively little memory.  In this particular
case, for example, we saw it with a system that had "only" 256 megs of
memory, and creating a 72 gigabyte filesystem using a 8x9gb RAID
configuration.

Some folks at IBM (in the Mylex controller group) have found this
problem with 2.2.16, 2.2.18, and with some 2.2.19pre patch (they didn't
say exactly which level of the 2.2.19pre patch they were dealing with).
Some folks claiming that the problem exists under 2.2.18, and we've seen
it with our kernel, which is a 2.2.18 plus some set of 2.2.19pre*
patches.

The problem is that mke2fs issues a *lot* of writes when it is writing
the inode table, and apparently the write throttling isn't completely
working write under those circumstances.  There is a workaround which
easily fixes the problem; if you set the MKE2FS_SYNC environment
variable to some value such as 5 or 10, then after writing every 5 or 10
block groups's worth of inode tables, mke2fs will call sync().  This
workaround did fix IBM's problem, which lends credence to the theory
that the problem is a VM bug related to a lack of sufficient write
throttling.  

I've in the past considered making MKE2FS_SYNC=10 be the default, but
Stephen has requested that I not do this, since it's the best way of
showing off this particular VM bug.

							- Ted

>From IBM/Mylex's bug report:

>The system I used for these tests is a Chardonnay with an AR160
>installed. The FW is 6.00-07 and the BIOS is 6.01-08. The system
>has several various kernel/DAC driver boot configurations set up.
>The RAID drive under test is a 3-drive RAID 5 with 8.6GB drives,
>for a total of 17GB. When one maximum sized partition is created,
>the total number of logical cylinders is 2209.
>
>I also obtained the 2.2.19 patch and upgraded kernel 2.2.18 to 2.2.19.
>
>Note: The first 4 tests fail to at least some extent. Please read each one.
>
>1. Kernel 2.2.16 and DAC driver 2.2.9 - 128MB of main memory.
>   The system fails to complete the creation of an ext2 file system.
>   The process mke2fs (or mkfs) gets terminated instead. Subsequent
>   attempts to create an ext2 file (without rerunning fdisk) fail.
>
>2. Kernel 2.2.18 and DAC driver 2.2.9 - 128 MB of main memory.
>   The ext2 file system is created, but hundreds of VM error messages
>   scroll up on the screen. Expanding the swap space to exceed the
>   memory size does not help (I think it might even be worse).
>
>   I also tried running a copy compare script that loads the drives with
>   heavy I/O. This failed after approximately 20 hours. The system was
>   effectively locked up with VM error messages scrolling up the screen
>   and all alternate terminal screens.
>
>3. Kernel 2.2.16 and DAC driver 2.2.10 - 128 MB of main memory.
>   The system fails to complete the creation of an ext2 file system.
>   The process mke2fs (or mkfs) gets terminated instead. Subsequent
>   attempts to create an ext2 file (without rerunning fdisk) fail.
>
>4. Kernel 2.2.19 and DAC driver 2.2.9 - 128 MB of main memory.
>   The system fails to complete the creation of an ext2 file system.
>   The process mke2fs (or mkfs) gets terminated instead. Subsequent
>   attempts to create an ext2 file (without rerunning fdisk) DO NOT
>   FAIL.
>
>5. Kernel 2.2.16 and DAC driver 2.2.9 - 512 MB of main memory.
>   The system completes the creation of an ext2 file system without
>   any errors.
>
>6. Kernel 2.2.16 and DAC driver 2.2.10 - 512 MB of main memory.
>   The system completes the creation of an ext2 file system without
>   any errors.
>
>7. Kernel 2.2.18 and DAC driver 2.2.9 - 512 MB of main memory.
>   The system completes the creation of an ext2 file system without
>   any errors.
>
>8. Kernel 2.2.19 and DAC driver 2.2.9 - 512 MB of main memory.
>   The system completes the creation of an ext2 file system without
>   any errors.
>
