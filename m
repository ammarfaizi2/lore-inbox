Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUFSTRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUFSTRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUFSTRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:17:22 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:28634 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264515AbUFSTRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:17:13 -0400
Date: Sat, 19 Jun 2004 15:11:18 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sebastian Slota <sebastian@sslota.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Raid issues on Sil 3114 (MB: Abit MAX3, i875 )
In-Reply-To: <200406191701.24787.sebastian@sslota.de>
Message-ID: <Pine.GSO.4.33.0406191447090.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Sebastian Slota wrote:
>#1 - Linux sees the HD's but dont recognises the partitions
...

More accurately, it see the partition table from the first chunk of the
array.

Yes, it's a "meddley" software RAID array.  2.6 does not have the ataraid
code in there anymore.  One is supposed to use "dm" for this now, but
again, there are no supporting code/modules to handle this (yet.)

If you know EXACTLY how the raid is setup and it NEVER changes, then yes,
Linux can be "tricked" into building a software RAID array in a BIOS
compatible manner.

WARNING: Linux is completely unaware of the meddley superblocks at the
         ends of each disk.  If you ever overwrite them, the BIOS and
         other OSes will not see an array.  Either skip the last cylinder
         when partitioning the drive or create all the partitions from
         windows. (which is what I did.)

I do this:
	md=d0,0,2,0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd
		See also: Documentation/md.txt (within the kernel source)
That tells the kernel to build a non-persistent, partitioned RAID0 array
with a 16k stripe (2^2 * 4k) from sda-sdd (in that order) which looks like
this...

[root:pts/6{1}]spork:/[02:59 PM]:fdisk -l /dev/md/d0
Disk /dev/md/d0: 640.1 GB, 640167510016 bytes
255 heads, 63 sectors/track, 77829 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

      Device Boot      Start         End      Blocks   Id  System
/dev/md/d0p1   *           1       72606   583207663+   7  HPFS/NTFS
/dev/md/d0p2           72607       77306    37752750   83  Linux
/dev/md/d0p3           77307       77828     4192965   82  Linux swap
(NOTE: Cyl 77829 is unused.)

(The same is visible from /dev/sda although it's 1/4th the size.)

[root:pts/6{1}]spork:/[03:00 PM]:mdadm --detail /dev/md/d0
/dev/md/d0:
        Version : 00.90.01
  Creation Time : Fri Jun 18 16:41:33 2004
     Raid Level : raid0
     Array Size : 625163584 (596.20 GiB 640.17 GB)
   Raid Devices : 4
  Total Devices : 4
Preferred Minor : 0
    Persistence : Superblock is not persistent

    Update Time : Fri Jun 18 16:41:33 2004
          State : clean, no-errors
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 16K

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       1       8       16        1      active sync   /dev/sdb
       2       8       32        2      active sync   /dev/sdc
       3       8       48        3      active sync   /dev/sdd

[root:pts/6{1}]spork:/[03:08 PM]:df -h /dev/md/d0p1
Filesystem            Size  Used Avail Use% Mounted on
/dev/md/d0p1          557G   72G  486G  13% /mnt/ntfs

--Ricky


