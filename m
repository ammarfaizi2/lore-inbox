Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUIKW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUIKW4x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUIKW4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:56:53 -0400
Received: from smtp08.auna.com ([62.81.186.18]:7096 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S267377AbUIKWzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:55:54 -0400
Date: Sat, 11 Sep 2004 22:55:52 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: md on 2.4: array stays dirty ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1094943352l.14488l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Afeter I got a 6 disk radi5 array working fine in 2.6, I started to recycle
some disks for a new array on 2.4.

I had one 240Gb pplus 2 120 Gb disks. My plan was to do something like

/dev/md1 (raid0) -- /dev/hda1 (240Gb)
                 \- /dev/md0 (raid linear) -- /dev/hdc1
                                           \- /dev/hdd1

I partitioned hd[acd]1 as fd (raid autodetect), and built md0.
But I can't get /dev/md0 to appear as 'clean'. I also built md1, and it also
stays 'dirty'.

What I did:

annwn:~# fdisk -l /dev/hd[acd]

Disk /dev/hda: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1       30515   245111706   fd  Linux raid autodetect

Disk /dev/hdc: 120.0 GB, 120034123776 bytes
255 heads, 63 sectors/track, 14593 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdc1               1       14593   117218241   fd  Linux raid autodetect

Disk /dev/hdd: 120.0 GB, 120034123776 bytes
255 heads, 63 sectors/track, 14593 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdd1               1       14593   117218241   fd  Linux raid autodetect


mdadm --create --verbose \
       /dev/md0 --level=linear --chunk=64 \
       --raid-devices=2 \
       /dev/hdc1 /dev/hdd1

mdadm --create --verbose \
        /dev/md1 --level=0 --chunk=128 \
        --raid-devices=2 \
        /dev/hda1 /dev/md0

annwn:~# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.00
  Creation Time : Sat Sep 11 01:12:05 2004
     Raid Level : linear
     Array Size : 234436352 (223.58 GiB 240.06 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Sat Sep 11 19:44:27 2004
          State : dirty
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

       Rounding : 64K

           UUID : fd62583c:b7b086fe:76e46f84:25182f36
         Events : 0.3

    Number   Major   Minor   RaidDevice State
       0      22        1        0      active sync   /dev/hdc1
       1      22       65        1      active sync   /dev/hdd1

annwn:~# mdadm -D /dev/md1
/dev/md1:
        Version : 00.90.00
  Creation Time : Sun Sep 12 00:42:21 2004
     Raid Level : raid0
     Array Size : 479547776 (457.33 GiB 491.06 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 1
    Persistence : Superblock is persistent

    Update Time : Sun Sep 12 00:42:21 2004
          State : dirty
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 128K

           UUID : 3cf80ac5:350d923e:c5d833f6:a92377f9
         Events : 0.1

    Number   Major   Minor   RaidDevice State
       0       3        1        0      active sync   /dev/hda1
       1       9        0        1      active sync   /dev/md0

Kernel is 2.4.28-pre2.

Why are they dirty ?
What is the problem ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (RC 1) for i586
Linux 2.6.9-rc1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


