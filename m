Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVERT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVERT6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVERT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:58:07 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:8526 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262324AbVERT5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:57:36 -0400
Date: Wed, 18 May 2005 21:57:48 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.11]: Bugs in handle striped LVM volumes ?
Message-ID: <Pine.BSO.4.62.0505182117060.19853@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-314583864-1116446268=:19853"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-314583864-1116446268=:19853
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT


I just on move from one ATA disk to four SCSI.
During this move I create two RAID1 devices and on top of this devices I 
create neccessary LVM volumes.
After create volumes, make fs structures I'm copy all resources from old 
ATA disk to new volumes, mounting new volumes in /mnt/new I start
"cp -aux / /mnt/new". Copying was finished _without problems_. 
After this I try run "chroot /mnt/new" for adjust configurarion in copied 
resources but during this I was kicked with error message about errors in
/bin/bash :>
After this was generated tons of messages to syslog like:

May 18 17:55:26 test1 kernel: attempt to access beyond end of device
May 18 17:55:26 test1 kernel: dm-2: rw=0, want=11331644016, limit=31457280
May 18 17:55:26 test1 kernel: attempt to access beyond end of device
May 18 17:55:26 test1 kernel: dm-2: rw=0, want=14546609024, limit=31457280
May 18 17:55:26 test1 kernel: attempt to access beyond end of device
May 18 17:55:26 test1 kernel: dm-2: rw=0, want=4311810520, limit=31457280
May 18 17:55:26 test1 kernel: attempt to access beyond end of device
[..]
May 18 17:56:31 test1 kernel: EXT3-fs error (device dm-2): ext3_free_blocks: Freeing blocks not in datazone - block = 1416455501, count = 1
May 18 17:56:31 test1 kernel: Aborting journal on device dm-2.
May 18 17:56:31 test1 kernel: EXT3-fs error (device dm-2): ext3_free_blocks: Freeing blocks not in datazone - block = 1818326127, count = 1
May 18 17:56:31 test1 kernel: ext3_abort called.
May 18 17:56:31 test1 kernel: EXT3-fs error (device dm-2): ext3_journal_start_sb: Detected aborted journal
May 18 17:56:31 test1 kernel: Remounting filesystem read-only
May 18 17:56:31 test1 kernel: EXT3-fs error (device dm-2) in start_transaction: Journal has aborted

For above I'm using striped volume and I suspect this as root of problems 
so I repeat all but on volumes without stripping (remove stripped dm-2 
volume and on the same place was created not stripped)
and in this case all was perfect

My current MD/LVM configuration (without striping):

[root@test1 /]# cat /proc/mdstat
Personalities : [raid1]
md0 : active raid1 sdb2[1] sda2[0]
       1959808 blocks [2/2] [UU]

md2 : active raid1 sdb3[1] sda3[0]
       33776576 blocks [2/2] [UU]

md3 : active raid1 sdd3[1] sdc3[0]
       69762176 blocks [2/2] [UU]

md1 : active raid1 sdd2[1] sdc2[0]
       1959808 blocks [2/2] [UU]

lvm> pvs
   PV         VG         Fmt  Attr PSize  PFree
   /dev/hda2  VolGroup00 lvm2 a-   74,41G  96,00M
   /dev/md2   test1      lvm2 a-   32,21G      0
   /dev/md3   test1      lvm2 a-   66,53G 756,00M
lvm> lvdisplay -v test1
     Using logical volume(s) on command line
   --- Logical volume ---
   LV Name                /dev/test1/root
   VG Name                test1
   LV UUID                6K8754-j5dv-PAV9-FMkY-LMg6-fjUo-7nIRwf
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                15,00 GB
   Current LE             3840
   Segments               2
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:2

   --- Logical volume ---
   LV Name                /dev/test1/home
   VG Name                test1
   LV UUID                dSrvjz-sAnv-zGkW-x0xN-S27U-nlvu-lcAC8t
   LV Write Access        read/write
   LV Status              available
   # open                 1
   LV Size                83,00 GB
   Current LE             21248
   Segments               2
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:3

Striped volume test1/root was created using "lvcreate test1 -n root -L 15G -i2 -I8"
(above was created by simple "lvcreate test1 -n root -L 15G").

Kernel version it is 2.6.11 (from curren Fedora devel .. but I don't see 
in src.rpm any LVM/DM changes compare to vanilla so probably it will be
repeatable on vanilla).

Anyone is using LVM2 stripping on 2.6.11 ?
Anyone known something about bugs in LVM stripping code ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-314583864-1116446268=:19853--
