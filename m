Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWEVMWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEVMWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWEVMWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:22:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:39642 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750789AbWEVMWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:22:37 -0400
Date: Mon, 22 May 2006 14:21:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
In-Reply-To: <20060522105326.A212600@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>
 <20060522105326.A212600@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,


>> I have noticed that after an upgrade from 2.6.16-rcX -> 2.6.17-rc4, writes 
>> to one (hdc) xfs filesystem have become significantly slower (factor 6 to 
>
>Buffered writes?  Direct writes?  Sync writes?  Log writes?

How would I know? :) "The standard thing".
I shuffled a bit in the source code and the word 'order' is quite often 
around 'barrier', so I thought the 'barrier' option makes the IO 
scheduler strictly ordered, that is, write log first, then data. (like 
ext3's data=ordered). Anyhow, just see below

>You're a bit light on details here.
>
>Can you send the benchmark results themselves please?  (as in,
>the test(s) you've run that lead you to see 6-8x, and the data
>those tests produced).  Also, xfs_info output, and maybe list
>the device driver(s) involved here too.

Drivers
=======
xfs.ko sis5513.ko ide_disk.ko ide_core.ko

xfs_info
========
14:20 shanghai:/root # xfs_info /
meta-data=/dev/hda3              isize=256    agcount=19, agsize=462621 blks
         =                       sectsz=512   attr=1
data     =                       bsize=4096   blocks=8586742, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096  
log      =internal               bsize=4096   blocks=3614, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0
14:20 shanghai:/root # xfs_info /D
meta-data=/dev/hdc2              isize=256    agcount=16, agsize=3821963 blks
         =                       sectsz=512   attr=1
data     =                       bsize=4096   blocks=61151408, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096  
log      =internal               bsize=4096   blocks=29859, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0
14:20 shanghai:/root # fdisk -l /dev/hda

Disk /dev/hda: 40.0 GB, 40020664320 bytes
255 heads, 63 sectors/track, 4865 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1          64      514048+  82  Linux swap / Solaris
/dev/hda2   *          65         588     4209030    c  W95 FAT32 (LBA)
/dev/hda3             590        4865    34346970   83  Linux
14:21 shanghai:/root # fdisk -l /dev/hdc

Disk /dev/hdc: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdc1               1          63      506016   82  Linux swap / Solaris
/dev/hdc2              64       30515   244605690   83  Linux



So here are the results. I have run these tests from single-user mode (-b
bootflag) so that no other userspace programs would interfere.

Script started on Mon May 22 15:32:29 2006
15:32 (none):~ # mount /dev/hdc2 /D -o barrier
15:32 (none):~ # df -Th / /D
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda3      xfs     33G  6.7G   27G  21% /
/dev/hdc2      xfs    234G  142G   92G  61% /D
15:33 (none):~ # cat /proc/mounts
rootfs / rootfs rw 0 0
udev /dev tmpfs rw 0 0
/dev/hda3 / xfs rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hdc2 /D xfs rw 0 0
proc /proc proc rw 0 0

A small nitpick BTW, the barrier flag is not listed in /proc/mounts.

hda is always in nobarrier mode.
<6>hda: cache flushes not supported
<6>hdc: cache flushes supported
<5>Filesystem "hda3": Disabling barriers, not supported by the underlying
device
hdc can do barriers if wanted.


CASE 1: Copying from one disk to another
========================================
Copying a compiled 2.6.17-rc4 tree; 306907 KB in 28566 files in 2090
directories.

15:33 (none):~ # cd /tmp
15:33 (none):/tmp # time rsync -PHSav kernel-source/ /D/kernel-0/ >/dev/null

real	7m31.776s
user	0m7.030s
sys	0m14.450s

I rebooted here (only here - no more reboots below) to get a cold slate.

15:42 (none):~ # mount /dev/hdc2 /D -o nobarrier
15:42 (none):/tmp # rsync -PHSav kernel-source/ /D/kernel-1/ >/dev/null

real	2m14.401s
user	0m7.290s
sys	0m14.900s
15:45 (none):/tmp # umount /D


CASE 2: Removing
================
Remove the copies we created in case 1.

15:45 (none):/tmp # mount /dev/hdc2 /D -o barrier
15:45 (none):/tmp # cd /D
15:45 (none):/D # time rm -Rf kernel-0

real	3m31.901s
user	0m0.050s
sys	0m3.140s
15:49 (none):/D # cd /
15:49 (none):/ # umount /D
15:49 (none):/ # mount /dev/hdc2 /D -o nobarrier
15:49 (none):/ # cd /D
15:49 (none):/D # time rm -Rf kernel-1

real	0m53.471s
user	0m0.070s
sys	0m1.990s
15:50 (none):/D # cd /
15:50 (none):/ # umount /D


CASE 3: Copying to the same disk
================================
Copy a file from hdc2 to hdc2. The result is _extremely_ interesting. So the
'barrier' thing is only relevant for large sets of files, it seems.

15:50 (none):/ # mount /dev/hdc2 /D -o barrier
15:50 (none):/ # cd /D/Video
15:50 (none):/D/Video # ls -l The*
-rw-r--r--  1 jengelh users 6861772800 Mar 17 23:02 TLK3.iso
15:50 (none):/D/Video # time cp TLK3.iso ../tlk-0.iso

real	8m1.051s
user	0m0.670s
sys	0m41.120s
15:59 (none):/D/Video # cd /
15:59 (none):/ # umount /D
15:59 (none):/ # mount /dev/hdc2 /D -o nobarrier
15:59 (none):/ # Kcd /D/Video
15:59 (none):/D/Video # time cp TLK3.iso ../tlk-1.iso

real	7m53.275s
user	0m0.560s
sys	0m40.010s
16:07 (none):/D/Video # cd /
16:08 (none):/ # umount /D
16:08 (none):/ # exit

Script done on Mon May 22 16:08:09 2006



Jan Engelhardt
-- 
