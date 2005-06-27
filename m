Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVF0U3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVF0U3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVF0U1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:27:23 -0400
Received: from [217.7.64.195] ([217.7.64.195]:60548 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S261656AbVF0UW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:22:59 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: dirty md raid5 slab bio leak
Date: Mon, 27 Jun 2005 22:22:48 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272222.51993.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin.

The machine:

amd64, 2G mem, 4 SATA disks on SiI 3114 [SATALink/SATARaid] Serial ATA 
Controller, configured as md raid5/raid1, using [cfq-scheduler], running 
2.6.12-rc6 (application postgresql)

The story:

This morning the machine was very slow, first check shows that the machine 
swaps and all disk i/o are very slow.

Looking further slabtop shows

 Active / Total Objects (% used)    : 19821561 / 19828316 (100.0%)
 Active / Total Slabs (% used)      : 369737 / 369739 (100.0%)
 Active / Total Caches (% used)     : 80 / 120 (66.7%)
 Active / Total Size (% used)       : 1415795.50K / 1416586.19K (99.9%)
 Minimum / Average / Maximum Object : 0.02K / 0.07K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
9865575 9864690  99%    0.02K  43847      225    175388K biovec-1
9865254 9864654  99%    0.12K 318234       31   1272936K bio
 28755  28755 100%    0.09K    639       45      2556K buffer_head
 16856  16856 100%    0.52K   2408        7      9632K radix_tree_node
 11286  10852  96%    0.21K    627       18      2508K dentry_cache
  5955   5953  99%    0.73K   1191        5      4764K shmem_inode_cache
  5795   3461  59%    0.06K     95       61       380K size-64
  5566   5506  98%    0.17K    253       22      1012K vm_area_struct
  3294   3294 100%    0.66K    549        6      2196K reiser_inode_cache
  3240   3212  99%    0.07K     60       54       240K sysfs_dir_cache
  2046   2046 100%    0.12K     66       31       264K size-128
  2023   1657  81%    0.03K     17      119        68K size-32

*ouch*

I decided to first compile 2.6.12 (final) and reboot the machine to reproduce 
the problem.

During reboot md shows that /dev/sdd are failed. Log:

[...]
Jun 23 11:23:45 c64 ata4: command 0x35 timeout, stat 0xd8 host_stat 0x0
Jun 23 11:23:45 c64 ata4: status=0xd8 { Busy }
Jun 23 11:23:45 c64 SCSI error : <3 0 0 0> return code = 0x8000002
Jun 23 11:23:45 c64 sdd: Current: sense key: Aborted Command
Jun 23 11:23:45 c64 Additional sense: Scsi parity error
Jun 23 11:23:45 c64 end_request: I/O error, dev sdd, sector 234436299
Jun 23 11:23:45 c64 raid5: Disk failure on sdd3, disabling device. Operation 
continuing on 3 devices
Jun 23 11:23:45 c64 RAID5 conf printout:
Jun 23 11:23:45 c64 --- rd:4 wd:3 fd:1
Jun 23 11:23:45 c64 disk 0, o:1, dev:sda3
Jun 23 11:23:45 c64 disk 1, o:1, dev:sdb3
Jun 23 11:23:45 c64 disk 2, o:1, dev:sdc3
Jun 23 11:23:45 c64 disk 3, o:0, dev:sdd3
Jun 23 11:23:45 c64 RAID5 conf printout:
Jun 23 11:23:45 c64 --- rd:4 wd:3 fd:1
Jun 23 11:23:45 c64 disk 0, o:1, dev:sda3
Jun 23 11:23:45 c64 disk 1, o:1, dev:sdb3
Jun 23 11:23:45 c64 disk 2, o:1, dev:sdc3
Jun 23 11:24:39 c64 ATA: abnormal status 0xD8 on port 0xFFFFC200000066C7
Jun 23 11:24:39 c64 ATA: abnormal status 0xD8 on port 0xFFFFC200000066C7
Jun 23 11:24:39 c64 ATA: abnormal status 0xD8 on port 0xFFFFC200000066C7
Jun 23 11:25:09 c64 ata4: command 0x25 timeout, stat 0xd8 host_stat 0x1
Jun 23 11:25:09 c64 ata4: status=0xd8 { Busy }
Jun 23 11:25:09 c64 SCSI error : <3 0 0 0> return code = 0x8000002
Jun 23 11:25:09 c64 sdd: Current: sense key: Aborted Command
Jun 23 11:25:09 c64 Additional sense: Scsi parity error
Jun 23 11:25:09 c64 end_request: I/O error, dev sdd, sector 2640176
Jun 23 11:25:09 c64 raid5: Disk failure on sdd2, disabling device. Operation 
continuing on 3 devices
Jun 23 11:25:09 c64 RAID5 conf printout:
Jun 23 11:25:09 c64 --- rd:4 wd:3 fd:1
Jun 23 11:25:09 c64 disk 0, o:1, dev:sda2
Jun 23 11:25:09 c64 disk 1, o:1, dev:sdb2
Jun 23 11:25:09 c64 disk 2, o:1, dev:sdc2
Jun 23 11:25:09 c64 disk 3, o:0, dev:sdd2
Jun 23 11:25:09 c64 RAID5 conf printout:
Jun 23 11:25:09 c64 --- rd:4 wd:3 fd:1
Jun 23 11:25:09 c64 disk 0, o:1, dev:sda2
Jun 23 11:25:09 c64 disk 1, o:1, dev:sdb2
Jun 23 11:25:09 c64 disk 2, o:1, dev:sdc2
[...]

(next i should look at the machines even i am at linuxtag:-)

Now i readded /dev/sdd[2,3] and everthing worked again (after checking all 
cables).

Looks like a BUG, slab should not be filled up if a disk fails.

Ok, this is a 'needed' testingmachine, but i'm willing to try reproducing it, 
if nobody else are able to do it ;-)

<earny>
