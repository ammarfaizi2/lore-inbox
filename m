Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDIQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDIQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDIQgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:36:25 -0400
Received: from bender.bawue.de ([193.7.176.20]:27573 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261356AbVDIQgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:36:00 -0400
Date: Sat, 9 Apr 2005 18:35:52 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2: Promise SATA150 TX4 failures
Message-ID: <20050409163552.GA30263@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just tried 2.6.12-rc2 and I still have the same errors from my SATA
disks as with 2.6.11.  The setup is a bit complex.  The relevant parts (I
think) are:

Adaptec AHA-2940UW SCSI-controller, attached are:
1 harddisk /dev/sda
1 DDS3 streamer /dev/st0

Promise SATA150 TX4 controller, attached are:
2 identical hardisks /dev/sdb and /dev/sdc

/dev/sda consists of the root partition, a swap partition and 4 other
partitions that are physical volumes for dm volume group /dev/vg1

/dev/sdb and /dev/sdc have two partitions each, the first of both make
a RAID-0 array /dev/md0 and the second of both make a md RAID-1 array
/dev/md1

/dev/md0 and /dev/md1 are the physical volumes for dm volume groups
/dev/vg2 and /dev/vg3 resp.

To trigger the failure:
- For all logical volumes in /dev/vg1, /dev/vg2 and /dev/vg3 a snapshot is
  created.
- All snapshots are mounted read-only in a "snapshot hierarchy" under
  /snap.
- A backup to tape is taken using something like:
  find /snap -print | cpio -oaH crc -F /dev/st0
  Backup must go to tape, no problem with /dev/null
- At this point, some additional i/o on the SATA disks cause the whole
  box to hang. Mostly some errors are written to syslog, they are
  always similar:
Apr  9 01:30:35 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }Apr  9 01:30:35 bear kernel: ata2: called with no error (51)!
Apr  9 01:30:35 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Apr  9 01:30:35 bear kernel: sdc: Current: sense key: Medium Error
Apr  9 01:30:35 bear kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Apr  9 01:30:35 bear kernel: end_request: I/O error, dev sdc, sector 43100350
Apr  9 01:30:35 bear kernel: raid1: Disk failure on sdc2, disabling device.
Apr  9 01:30:35 bear kernel: ^IOperation continuing on 1 devices

The errors are always reported for /dev/sdc2, the second device of a
RAID-1 array.  After reboot I am able to raidhotadd the failed partition
without problems.

The problem is 100% reproducible.

The hang is not a "hard hang": X keeps running, the watchdog doesn't hit
but no new processes can be started.  Syslog entries stop after some time
(from a few seconds to several minutes).

The problem appeared somewhere between 2.6.10 and 2.6.11.
2.6.10:		ok
2.6.10-ac8:	ok
2.6.10-ac11:	failed
2.6.11:		failed
2.6.12-rc2:	failed

I'd be glad if there would be a solution for this problem as it prevents
me from using any newer kernel.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-04-09 09:31 /home/jo/.signature
