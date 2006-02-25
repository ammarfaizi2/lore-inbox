Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWBYVQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBYVQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWBYVQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:16:58 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:38889 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750759AbWBYVQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:16:57 -0500
Message-ID: <4400C94A.7070001@dgreaves.com>
Date: Sat, 25 Feb 2006 21:16:58 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-xfs@oss.sgi.com,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       nathans@sgi.com
Subject: testing 2.6.14-rc4: unmountable fs after xfs_force_shutdown 
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Please help.

I was testing 2.6.16-rc4 and seem to have lost my data filesystem :(
I know it's called scratch - but my wife went and stored data on there -
grrr!
Anyway, I'm now in trouble.

I am running XFS over LVM over a 3-disk RAID5.

Something (libata?) caused some bogus read errors (see kernel-ide for
details) which threw 2 drives out of my raid array:

sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 390716735
raid5: Disk failure on sda1, disabling device. Operation continuing on 2
devices
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 390716735
raid5: Disk failure on sdb1, disabling device. Operation continuing on 1
devices
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:1, dev:sdd1
 disk 1, o:0, dev:sdb1
 disk 2, o:0, dev:sda1
xfs_force_shutdown(dm-0,0x1) called from line 338 of file
fs/xfs/xfs_rw.c.  Return address = 0xc020c0e9
Filesystem "dm-0": I/O Error Detected.  Shutting down filesystem: dm-0
Please umount the filesystem, and rectify the problem(s)
I/O error in filesystem ("dm-0") meta-data dev dm-0 block
0x640884a       ("xlog_bwrite") error 5 buf count 262144
XFS: failed to locate log tail
XFS: log mount/recovery failed: error 5
XFS: log mount failed

After checking with mdadm --examine I was able to reconstruct the array
using the 2 booted devices as they both had the same event count:
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 2
raid5: allocated 3155kB for md1
raid5: raid level 5 set md1 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sda1


I restarted lvm and remounted the drive but it failed like this:
XFS mounting filesystem dm-0
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 390716735
raid5: Disk failure on sdb1, disabling device. Operation continuing on 1
devices
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 390716735
raid5: Disk failure on sda1, disabling device. Operation continuing on 0
devices
RAID5 conf printout:
 --- rd:3 wd:0 fd:3
 disk 1, o:0, dev:sdb1
 disk 2, o:0, dev:sda1
xfs_force_shutdown(dm-0,0x1) called from line 338 of file
fs/xfs/xfs_rw.c.  Return address = 0xc020c0e9
Filesystem "dm-0": I/O Error Detected.  Shutting down filesystem: dm-0
Please umount the filesystem, and rectify the problem(s)
I/O error in filesystem ("dm-0") meta-data dev dm-0 block
0x640884a       ("xlog_bwrite") error 5 buf count 262144
XFS: failed to locate log tail
XFS: log mount/recovery failed: error 5
XFS: log mount failed

I then then rebooted into 2.6.15 (where it's been happy for weeks and
weeks!)
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 2
raid5: allocated 3155kB for md1
raid5: raid level 5 set md1 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sda1

Setting up LVM Volume Groups...
  Reading all physical volumes.  This may take a while...
  /dev/hda: open failed: No medium found
  Found volume group "video_vg" using metadata type lvm2
  1 logical volume(s) in volume group "video_vg" now active

haze:~# mount /scratch
mount: /dev/video_vg/video_lv: can't read superblock

haze:~# xfs_repair -n /dev/video_vg/video_lv
Phase 1 - find and verify superblock...
superblock read failed, offset 0, size 524288, ag 0, rval 0

fatal error -- Invalid argument

haze:~# lvdisplay /dev/video_vg/video_lv
  --- Logical volume ---
  LV Name                /dev/video_vg/video_lv
  VG Name                video_vg
  LV UUID                cg2yc1-dO6V-3GlY-JnhY-4nXi-V85s-WTIFml
  LV Write Access        read/write
  LV Status              available
  # open                 0
  LV Size                372.61 GB
  Current LE             95389
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:0


Any sugestions?

David

-- 

