Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUIMM15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUIMM15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUIMM15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:27:57 -0400
Received: from smtp07.auna.com ([62.81.186.17]:17111 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S266547AbUIMM1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:27:30 -0400
Date: Mon, 13 Sep 2004 12:27:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Problems with raid in 2.6.9-rc1-mm4
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1095078447l.13111l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I try to set up a RAID in linux 2.6. I succeeded in one other box, building
a raid5 disk on top of SATA drives.

In this box, I have a 240Gb disk plus two 120Gb ones:

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

As disks are of different sizes, I though about doing a volume with the small
ones, and then a raid with the big.
As stripping on two IDE disks on the same IDE bus is silly, I wanted to
do a linear array. So this is what I would like:

/dev/md1 (raid0) -- /dev/hda1 (240Gb)
                \- /dev/md0 (raid linear) -- /dev/hdc1
                                          \- /dev/hdd1

I built both arrays with:

#!/bin/bash

mdadm -S /dev/md0
mdadm --create --verbose --run \
       /dev/md0 --level=linear --chunk=64 \
       --raid-devices=2 \
       /dev/hdc1 /dev/hdd1

mdadm -S /dev/md1
mdadm --create --verbose --run \
        /dev/md1 --level=0 --chunk=64 \
        --raid-devices=2 \
        /dev/hda1 /dev/md0

But on reboot, md0 is autodetected, but not so md1 ????
Log:

Sep 13 13:12:49 annwn kernel: md: linear personality registered as nr 1
Sep 13 13:12:49 annwn kernel: md: raid0 personality registered as nr 2
Sep 13 13:12:49 annwn kernel: md: raid1 personality registered as nr 3
Sep 13 13:12:49 annwn kernel: md: raid10 personality registered as nr 9
Sep 13 13:12:49 annwn kernel: md: raid5 personality registered as nr 4
Sep 13 13:12:49 annwn kernel: raid5: automatically using best checksumming function: pIII_sse
Sep 13 13:12:49 annwn kernel:    pIII_sse  :  2248.000 MB/sec
Sep 13 13:12:49 annwn kernel: raid5: using function: pIII_sse (2248.000 MB/sec)
Sep 13 13:12:49 annwn kernel: raid6: int32x1    468 MB/s
Sep 13 13:12:49 annwn kernel: raid6: int32x2    585 MB/s
Sep 13 13:12:49 annwn rpc.statd[3113]: statd running as root. chown /var/lib/nfs/sm to choose different user 
Sep 13 13:12:49 annwn kernel: raid6: int32x4    476 MB/s
Sep 13 13:12:49 annwn kernel: raid6: int32x8    355 MB/s
Sep 13 13:12:49 annwn kernel: raid6: mmxx1     1460 MB/s
Sep 13 13:12:49 annwn kernel: raid6: mmxx2     1832 MB/s
Sep 13 13:12:49 annwn kernel: raid6: sse1x1     882 MB/s
Sep 13 13:12:49 annwn kernel: raid6: sse1x2    1609 MB/s
Sep 13 13:12:49 annwn kernel: raid6: sse2x1    1964 MB/s
Sep 13 13:12:49 annwn kernel: raid6: sse2x2    2000 MB/s
Sep 13 13:12:49 annwn kernel: raid6: using algorithm sse2x2 (2000 MB/s)
Sep 13 13:12:49 annwn kernel: md: raid6 personality registered as nr 8
Sep 13 13:12:49 annwn kernel: md: multipath personality registered as nr 7
Sep 13 13:12:49 annwn kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Sep 13 13:12:49 annwn kernel: md: Autodetecting RAID arrays.
Sep 13 13:12:49 annwn kernel: md: autorun ...
Sep 13 13:12:49 annwn kernel: md: considering hdd1 ...
Sep 13 13:12:49 annwn kernel: md:  adding hdd1 ...
Sep 13 13:12:49 annwn kernel: md:  adding hdc1 ...
Sep 13 13:12:49 annwn kernel: md: hda1 has different UUID to hdd1
Sep 13 13:12:49 annwn kernel: md: created md0
Sep 13 13:12:49 annwn kernel: md: bind<hdc1>
Sep 13 13:12:49 annwn kernel: md: bind<hdd1>
Sep 13 13:12:49 annwn kernel: md: running: <hdd1><hdc1>
Sep 13 13:12:49 annwn kernel: md: considering hda1 ...
Sep 13 13:12:49 annwn kernel: md:  adding hda1 ...
Sep 13 13:12:49 annwn kernel: md: created md1
Sep 13 13:12:49 annwn kernel: md: bind<hda1>
Sep 13 13:12:49 annwn kernel: md: running: <hda1>
Sep 13 13:12:49 annwn kernel: md1: setting max_sectors to 128, segment boundary to 32767
Sep 13 13:12:49 annwn kernel: raid0: looking at hda1
Sep 13 13:12:49 annwn kernel: raid0:   comparing hda1(245111616) with hda1(245111616)
Sep 13 13:12:49 annwn kernel: raid0:   END
Sep 13 13:12:49 annwn kernel: raid0:   ==> UNIQUE
Sep 13 13:12:49 annwn kernel: raid0: 1 zones
Sep 13 13:12:49 annwn kernel: raid0: FINAL 1 zones
Sep 13 13:12:49 annwn kernel: raid0: too few disks (1 of 2) - aborting!
Sep 13 13:12:49 annwn kernel: md: pers->run() failed ...
Sep 13 13:12:49 annwn kernel: md :do_md_run() returned -22
Sep 13 13:12:49 annwn kernel: md: md1 stopped.
Sep 13 13:12:49 annwn kernel: md: unbind<hda1>
Sep 13 13:12:49 annwn kernel: md: export_rdev(hda1)
Sep 13 13:12:49 annwn kernel: md: ... autorun DONE.

What is the problem ? The kernel can't detect that md0 is part of an array ?
Is this setup possible at all ?
Do I have to partition md0 and create a 'fd' partition ?

Aside, I have thogut of this a a possible solution: split hda in two, and buid
a raid0 with hda1,hdc1,hda2,hdd1 (hda is faster...). Is this so stupid as it
looks to me (think of rplacinf hda2 when it fails....).


TIA



--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (RC 1) for i586
Linux 2.6.9-rc1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


