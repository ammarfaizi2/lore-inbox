Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVA0D7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVA0D7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVA0D7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:59:24 -0500
Received: from rain.plan9.de ([193.108.181.162]:44467 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262432AbVA0D7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:59:10 -0500
Date: Thu, 27 Jan 2005 04:59:07 +0100
From: Marc Lehmann <linux-kernel@plan9.de>
To: linux-kernel@vger.kernel.org
Subject: critical bugs in md raid5
Message-ID: <20050127035906.GA7025@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to report a number of problems in the current raid5 code, some of
which are pretty annoying, some of which require a superblock reformat.

Here's my setup:

- dual AMD opteron with 64-bit kernel, 2.6.10/2.6.8.1
- 5 raid disks, 4 standard ide on hda..hdd, one sata-device
  (that setup gives a much higher performance than putting every device
  on it's own ide port).

First, the really bad ones (happened with 2.6.10):

Today, I had a crash that required a hard reset. After the next start, the
raid started to rebuild as expected (and, as usually, at 5 times the speed
that I get when reading from the raid array, but that's an old problem
that I had on 2.4, too).

I only remember that I had all all five disks with an up-to-date sign
[UUUUU] during the whole rebuild, which made sense to me, as the data
should be up-to-date, despite the raid being out-of-sync. I rebooted
during the time, at around 46%. After the next reboot, resyncing properly
continued.

Then the rebuild finished:

   md: md0: sync done.

*immediately* after that line, I got an ide error:

   hda: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
   hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=312581110, high=18, low=10591222, sector=312580370
   ide: failed opcode was: unknown
   end_request: I/O error, dev hda, sector 312580370

I did verify that the disk block indeed was unreadable. The raid did react:

   raid5: Disk failure on hda1, disabling device. Operation continuing on 4 devices
   RAID5 conf printout:
    --- rd:5 wd:4 fd:1
    disk 0, o:0, dev:hda1
    disk 1, o:1, dev:sda1
    disk 2, o:1, dev:hdd1
    disk 3, o:1, dev:hdc1
    disk 4, o:1, dev:hdb1
   RAID5 conf printout:
    --- rd:5 wd:4 fd:1
    disk 1, o:1, dev:sda1
    disk 2, o:1, dev:hdd1
    disk 3, o:1, dev:hdc1
    disk 4, o:1, dev:hdb1

Interestingly, it immediately started to rebuild the array, with only for
disks (/proc/mdstat showed hda1 as F (faulty)):

   .<6>md: syncing RAID array md0
   md: minimum _guaranteed_ reconstruction speed: 0 KB/sec/disc.
   md: using maximum available idle IO bandwith (but not more than 99999 KB/sec)
   for reconstruction.
   md: using 128k window, over a total of 156290816 blocks.
   md: resuming recovery of md0 from checkpoint.

Indeed, /proc/mdstat showed that it had 46% (last checkpoint) already in
sync, while at the same time only showing 4 disks.

I did:

   raidhotremove /dev/md0 /dev/hda1

which worked (rebuild continued, though), then

   raidhotadd /dev/md0 /dev/hda1

which worked (rebuilt continued, though). I then decided to reboot.

After the reboot, I no longer had a raid, because the array was dirty and
degraded.

This is an important bug, IMHO, as it required me to manually mdadm -C the
array, which I am fairly proficient with, but it's still rather risky,
because of the following issues:

Sometimes, when the machine crashes, it seems that a dirty array is just
as unsafe as a degraded array: when the rebuild starts and hits a bad
block somewhere on the disks it chose to read from (bad blocks are very
common during hard crashes, as the disk might not have time to properly
write the block), it will mark the disk as faulty. Unfortunately, as the
array seems to be in some artifical degraded mode, it seems to think yet
another disk is faulty, and then stop working, as it thinks it has lost
two disks - reformat required.

Then, the reformat might be more difficult than necessary, as, of course,
you need to know the "index" numbers of your disks, I mean these numbers:

   md0 : active raid5 hda1[5] sda1[1] hdd1[2] hdc1[3] hdb1[4]

mdadm can be made to print the same numbers. Unfortunately, neither mkraid
nor mdadm have any waay of working with disk indices that are outside the
normal range (i.e. only 0..4 are valid on my 5 disk-array when building,
but every raid failure will give the disks a different number, which is in
no relation to the original order).

That means that every replacement disk will need paper and pencil work, as
the required data is not readily available with user-level commands.

In one case, I ahd two unavailable disks (generated by the problem above)
with indices 5 and 6. Simple guesswork (formatting the array superblocks
in degraded mode - not a very documented thing, readonly-mount, retry
with different order) gave me the correct order, but it's a tedious and
error-prone task.  I'd say many admins might just format the superblocks
in non-degraded mode, and when they detect a problem, it'S already too
late because the sync has already started (although it could be that a
sync will not damage the disks in any way, after all, it's simple xor).

The summary seems to be that the linux raid driver only protects your data
as long as all disks are fine and the machine never crashes.

The last annoying issue is not a bug per se, and has been reported in much
larger detail earlier: my array can rebuild at a top speed of 165MB/s, but
dd or other tools never read more than about 25-35MB/s top, which is much
less than the speed of a single disk - dd'ing from a single disk gives a
speed of >50MB/s, and dd'ing from, say, 4 or 5 disks gives me wlel over
200MB/s).

Of course, this last issue is not critical at all - I am working with this
problem since 2.4 days :)

Thanks for all the good work that alraedy went into linux, though!

Hope this helps,

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
