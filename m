Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWBZJod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWBZJod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBZJod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:44:33 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:30188 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751297AbWBZJod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:44:33 -0500
Message-ID: <44017886.5090100@dgreaves.com>
Date: Sun, 26 Feb 2006 09:44:38 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sgi.com>
Cc: linux-xfs@oss.sgi.com,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       nathans@sgi.com,
       LVM general discussion and development 
	<linux-lvm@redhat.com>
Subject: Odd LVM behaviour - was Re: testing 2.6.14-rc4: unmountable fs after
 xfs_force_shutdown
References: <4400C94A.7070001@dgreaves.com> <4401032A.10406@sgi.com>
In-Reply-To: <4401032A.10406@sgi.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you reply to this, please remove xfs/nathan/eric from cc - it's not
xfs at all, it was (if anything) an lvm bug.

Eric Sandeen wrote:

> David Greaves wrote:
>
>> haze:~# mount /scratch
>> mount: /dev/video_vg/video_lv: can't read superblock
>>
>> haze:~# xfs_repair -n /dev/video_vg/video_lv
>> Phase 1 - find and verify superblock...
>> superblock read failed, offset 0, size 524288, ag 0, rval 0
>
>
> First, why can't it be read?  any kernel messages as a result?  can
> you do a simple dd -from- this block device?

Eric, thanks. A good place to look. The dd just produced 0 bytes.
.....OK - thanks, it's fixed now.

It turns out that the md device stopped before the lvm started. So when
lvm did start it must have seen md1 as 0 bytes.
Then when I re-assembled and ran md1, lvm didn't notice.
Confusingly, the lvm userspace tools *did* notice and gave me 'healthy'
reports (I checked that before mailing - I just didn't actually dd the
lvm device - sorry).
The only clue was ages back in the log:

Adding 1004020k swap on /dev/sdc4.  Priority:-1 extents:1 across:1004020k
md: md1 stopped.
md: bind<sdb1>
md: bind<sda1>
md: bind<sdd1>
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table

So at this point lvm is sick - but why do the userspace tools report as
below?

haze:/usr/src/linux-2.6.15# lvm version
  LVM version:     2.01.04 (2005-02-09)
  Library version: 1.01.04 (2005-08-02)
  Driver version:  4.4.0



These commands were issued cronologically and represent my basic diagnosis.

haze:~# mdadm --assemble --run /dev/md1 /dev/sda1 /dev/sdb1
mdadm: /dev/md1 has been started with 2 drives (out of 3).

haze:~# /etc/init.d/lvm start
Setting up LVM Volume Groups...
  Reading all physical volumes.  This may take a while...
  /dev/hda: open failed: No medium found
  Found volume group "video_vg" using metadata type lvm2
  1 logical volume(s) in volume group "video_vg" now active

(/dev/hda is my CDROM which I know I should exclude from the scan!)
(In retrospect I guess I should have stopped and started lvm, not just
started it)
Mount now fails so I start to check things out...

haze:~# cat /proc/mdstat
Personalities : [raid1] [raid5]
md1 : active raid5 sdb1[1] sda1[2]
      390716672 blocks level 5, 64k chunk, algorithm 2 [3/2] [_UU]
haze:~# lvdisplay /dev/video_vg
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

haze:~# pvdisplay /dev/md1
  --- Physical volume ---
  PV Name               /dev/md1
  VG Name               video_vg
  PV Size               372.61 GB / not usable 0
  Allocatable           yes (but full)
  PE Size (KByte)       4096
  Total PE              95389
  Free PE               0
  Allocated PE          95389
  PV UUID               IUig5k-460l-sMZc-23Iz-MMFl-Cfh9-XuBMiq

haze:~# vgdisplay video_vg
  --- Volume group ---
  VG Name               video_vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  19
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               372.61 GB
  PE Size               4.00 MB
  Total PE              95389
  Alloc PE / Size       95389 / 372.61 GB
  Free  PE / Size       0 / 0
  VG UUID               I2gW2x-aHcC-kqzs-Efpd-Q7TE-dkWf-KpHSO7

haze:~# vgck -v video_vg
    Using volume group(s) on command line
    Finding volume group "video_vg"

haze:~# lvscan
  ACTIVE            '/dev/video_vg/video_lv' [372.61 GB] inherit


haze:~# dd if=/dev/md1 of=/dev/null count=5
5+0 records in
5+0 records out
2560 bytes transferred in 0.000260 seconds (9849982 bytes/sec)

haze:~# dd if=/dev/video_vg/video_lv of=/dev/null count=500
0+0 records in
0+0 records out
0 bytes transferred in 0.000211 seconds (0 bytes/sec)

eek!

haze:~# /etc/init.d/lvm stop
Shutting down LVM Volume Groups...
  0 logical volume(s) in volume group "video_vg" now active
haze:~# lvdisplay
  --- Logical volume ---
  LV Name                /dev/video_vg/video_lv
  VG Name                video_vg
  LV UUID                cg2yc1-dO6V-3GlY-JnhY-4nXi-V85s-WTIFml
  LV Write Access        read/write
  LV Status              NOT available
  LV Size                372.61 GB
  Current LE             95389
  Segments               1
  Allocation             inherit
  Read ahead sectors     0

haze:~# /etc/init.d/lvm start
Setting up LVM Volume Groups...
  Reading all physical volumes.  This may take a while...
  /dev/hda: open failed: No medium found
  Found volume group "video_vg" using metadata type lvm2
  /dev/video_vg: opendir failed: No such file or directory
  1 logical volume(s) in volume group "video_vg" now active

(note: this *successful* start contains more error messages than the
failed start at the beginning)

haze:~# dd if=/dev/video_vg/video_lv of=/dev/null count=500
500+0 records in
500+0 records out
256000 bytes transferred in 0.007378 seconds (34697467 bytes/sec)

haze:~# mount /scratch
haze:~#

Success.

David

-- 

