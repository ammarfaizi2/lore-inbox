Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRB0D6j>; Mon, 26 Feb 2001 22:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRB0D6T>; Mon, 26 Feb 2001 22:58:19 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:52894 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129550AbRB0D6H>; Mon, 26 Feb 2001 22:58:07 -0500
Message-ID: <3A9B24BE.69777690@coplanar.net>
Date: Mon, 26 Feb 2001 22:53:34 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Carlos Fernandez Sanz <cfernandez@myalert.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Problem creating filesystem
In-Reply-To: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Fernandez Sanz wrote:

> I have just purchased a new HD and I'm getting problems creating a
> filesystem for it. I've done some research and some people claim the problem
> might be kernel related so I'm asking here just in case.
>
> The HD is a Maxtor 80 Gb, plugged to the Promise controller that comes with
> Asus A7V motherboards. The controller is ide2, and the HD is /dev/hde. ide0

how did you get it to recognise this controller?  kernel command line?
stock RH7's kernel 2.2.16-22 doesn't have automatic support.  I'd be
interested to know if 2.2.17-14 does, as I could use this on a system.

>
> and ide1 are working with no problems.
>
> -----------------
> fdisk shows some warnings (but doesn't refuse to create the partition):
>
> [root@alhambra /sbin]# fdisk /dev/hde
> Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
> disklabel
> Building a new DOS disklabel. Changes will remain in memory only,
> until you decide to write them. After that, of course, the previous
> content won't be recoverable.

This is normal for a blank disk; hopefully that's all this is.

>
>
> The number of cylinders for this disk is set to 15871.
> There is nothing wrong with that, but this is larger than 1024,
> and could in certain setups cause problems with:
> 1) software that runs at boot time (e.g., old versions of LILO)
> 2) booting and partitioning software from other OSs
>    (e.g., DOS FDISK, OS/2 FDISK)

this is fine. just a note for the inexperienced.

>
> Warning: invalid flag 0xffffa855 of partition table 5 will be corrected by
> w(rite)

normal - related to first message.

>
>
> Command (m for help): n
> Command action
>    e   extended
>    p   primary partition (1-4)
> p
> Partition number (1-4): 1
> First cylinder (1-15871, default 1):
> Using default value 1
> Last cylinder or +size or +sizeM or +sizeK (1-15871, default 15871):
> Using default value 15871
>
> Command (m for help): p
>
> Disk /dev/hde: 16 heads, 63 sectors, 15871 cylinders
> Units = cylinders of 1008 * 512 bytes
>
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hde1             1     15871   7998952+  83  Linux
>
> Command (m for help): w
> The partition table has been altered!
>
> Calling ioctl() to re-read partition table.
>
> WARNING: If you have created or modified any DOS 6.x
> partitions, please see the fdisk manual page for additional
> information.
> Syncing disks.

although it doesn't look like it's necessary, it's a good idea to
reboot here. (it usually gives a additional error if reboot needed)

>
> ------------------
> When trying to create the filesystem, I get this:
>
> [root@alhambra /sbin]# ./mke2fs /dev/hde1
> mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/hde1: Invalid argument passed to ext2 library while setting up
> superblock

sounds like an overflow.  try using badblocks to verify that the kernel
will allow access to all sectors in the partition.

badblocks -b 1024 -sv `fdisk -s /dev/hde1`

if that works, it looks like overflow in mke2fs or e2fs libraries; try:

delete partition 1 and make 2 more, each half of the disk,

try mke2fs /dev/hde1

if that works try mke2fs /dev/hde2;

if they both work then the overflow is likely the size of the disk;
but you have access to all of it in just two halves, until a fix is found.

>
> -------------------
>
> I'm using
> Linux version 2.2.17-14 (root@porky.devel.redhat.com) (gcc version
> egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Feb 5 16:02:20 EST
> 2001
>
> The IDE controller is
>   Bus  0, device  17, function  0:
>     Unknown mass storage controller: Promise Technology Unknown device (rev
> 2).
>       Vendor id=105a. Device id=d30.
>       Medium devsel.  IRQ 10.  Master Capable.  Latency=32.

Unrelated to disk "problem", you might want to set your PCI latency timer in
BIOS to 64 or more.

>
>       I/O at 0x9000 [0x9001].
>       I/O at 0x8800 [0x8801].
>       I/O at 0x8400 [0x8401].
>       I/O at 0x8000 [0x8001].
>       I/O at 0x7800 [0x7801].
>       Non-prefetchable 32 bit memory at 0xdd800000 [0xdd800000].
> [root@alhambra /proc]#

