Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbRGPTA0>; Mon, 16 Jul 2001 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbRGPTAR>; Mon, 16 Jul 2001 15:00:17 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:47599 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267669AbRGPS76>; Mon, 16 Jul 2001 14:59:58 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107161853.f6GIrxdQ002885@webber.adilger.int>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <Pine.LNX.4.33.0107141325460.1063-100000@rossi.itg.ie>
 "from Paul Jakma at Jul 14, 2001 01:27:37 pm"
To: Paul Jakma <paulj@alphyra.ie>
Date: Mon, 16 Jul 2001 12:53:59 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jamka writes:
> On Fri, 13 Jul 2001, Andreas Dilger wrote:
> > put your journal on NVRAM, you will have blazing synchronous I/O.
> 
> so ext3 supports having the journal somewhere else then. question: can
> the journal be on tmpfs?

There are patches for this (2.2 only, not 2.4) but it is not in the core
ext3 code yet.  The ext3 design and on-disk layout allow for it (and the
e2fsprogs have the basic support for it), so it will not be a major change
to start using external devices for journals.

If you are keen to do performance testing (on a temporary filesystem, for
sure), you can hack around the current lack of ext3 support for journal
devices by doing the following (works for reiserfs also) with LVM:

1) create a PV on NVRAM/SSD/ramdisk (needs hacks to LVM code to support the
   NVRAM device, or you can loopback mount the device ;-)  It should be big
   enough to hold the entire journal + a bit of overhead*
2) create a VG and LV on the ramdisk
3) create a PV on a regular disk, add it to the above VG
4) extend the LV with the new PV space**
5) create a 4kB blocksize ext2 filesystem on this LV
6) use "dumpe2fs <LV NAME>" to find the free blocks count in the first group
7) use "tune2fs -J size=<blocks * blocksize> <LV name>" to create the
   journal, where "blocks" <= number of free blocks in first group and
   also <= (number of blocks on NVRAM device - overhead*)

You _should_ have the journal on NVRAM now, along with the superblock and
all of the metadata for the first group.  This will also improve performance
as the superblock and group descriptor tables are hot spots as well.

Of course, once support for external journal devices is added to ext3, it
will simply be a matter of doing "tune2fs -J device=<NVRAM device>".

Cheers, Andreas
---------------
*) For ext3, you need enough extra space for the superblock, group descriptors,
   one block and inode bitmap, the first inode table, (and lost+found if
   you don't want to do extra work deleting lost+found before creating the
   journal, and re-creating it afterwards).  The output from "dumpe2fs"
   will tell you the number of inode blocks and group descriptor blocks.
   For reiserfs it is hard to tell exactly where the file will go, but if
   you had, say, a 64MB NVRAM device and a new filesystem, you could expect
   the journal to be put entirely on the NVRAM device.

**) The LV will have the NVRAM device as the first Logical Extent, so this
   will also be logically the first part of the filesystem.  The PEs added
   to the LV will be appended to the NVRAM device.
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
