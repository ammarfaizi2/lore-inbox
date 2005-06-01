Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFAJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFAJhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFAJfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:35:10 -0400
Received: from mgw-ext03.nokia.com ([131.228.20.95]:48012 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S261359AbVFAJeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:34:02 -0400
Date: Wed, 1 Jun 2005 12:13:21 +0300
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: linux-kernel@vger.kernel.org
Subject: Writing large files onto sync mounted MMC corrupts the FS
Message-ID: <20050601091320.GA1472@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 01 Jun 2005 09:13:10.0593 (UTC) FILETIME=[21A55310:01C5668A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people.

I am seeing both VFAT and Ext3 becoming corrupted when using
synchronous mount on MMC card (kernel is 2.6.12-rc2-omap1, HW is a
test board with Omap 1710).  The problem is reproduced by mounting a
MMC card synchronously and copying large file onto it.

Typically I insert vfat/ext3 formatted MMC card and do:
  mount /dev/mmcblk0p1 /media/mmc1 -t vfat -o sync
  cp /lib/libc-2.3.2.so  /media/mmc1
or
  mount /dev/mmcblk0p1 /media/mmc1 -t ext2 -o noatime,sync
  cp /lib/libc-2.3.2.so  /media/mmc1

The results are further below. I have tried to reproduce VFAT problen
in desktop PC with loopback device but to no avail. I have used
different MMC cards but the problem persists. Disabling DMA reduces
the number of error messages or pushes the first occurence a bit
further, but does not remove the problem.

Very similar problem appears when writing a large file onto ext2
formatted MMC card. The problem disappears if I mount asynchronoysly.
Also similarly the problem on VFAT disappears when mounting
asynchronously.

The VFAT problem seems to have appeared around January -- February
this year but it is hard to tell the exact point and changeset. For
ext2 I haven't done similar search.

Because there are two so similar problems appearing with two separate
file-systems, I doubt this is VFAT or Ext3 only problem, but more
likely problem in the mmc driver. It would be good to try this out on
other on some other hardware using the same mmc core code. Has anybody
else seen these?

Regards
Jarkko Lavinen


VFAT problem:
su-18-18:~# mount /dev/mmcblk0p1 /media/mmc1 -t vfat -o sync,rw,noauto,nodev,noexec,nosuid 
ke-recv.c:132: iface: org.kernel.kevent, member: mount, path: /org/kernel/block/mmcblk0/mmcblk0p1
su-18-18:~# cp /lib/libc-2.3.2.so  /media/mmc1
FAT: Filesystem panic (dev mmcblk0p1)
    fat_get_cluster: invalid cluster chain (i_pos 7861)
    File system has been set read-only
FAT: Filesystem panic (dev mmcblk0p1)
    fat_free_clusters: deleting FAT entry beyond EOF
FAT: Filesystem panic (dev mmcblk0p1)
    fat_free: invalid cluster chain (i_pos 7861)
FAT: Filesystem panic (dev mmcblk0p1)
    fat_get_cluster: invalid cluster chain (i_pos 7861)
FAT: Filesystem panic (dev mmcblk0p1)
    fat_free_clusters: deleting FAT entry beyond EOF
FAT: Filesystem panic (dev mmcblk0p1)
    fat_free: invalid cluster chain (i_pos 7861)
cp: Write Error: Input/output error


EXT3 problem:

su-18-18:~# mount /dev/mmcblk0p1 /media/mmc1 -t ext2 -o noatime,sync
ke-recv.c:132: iface: org.kernel.kevent, member: mount, path: /org/kernel/block/mmcblk0/mmcblk0p1
su-18-18:~# cp /lib/libc-2.3.2.so  /media/mmc1
jffs2_get_inode_nodes(): Data CRC failed on node at 0x05eeaee4: Read 0x0e2f9681, calculated 0xbcd5ccf9 (Unclean reboot without syncing, usually harmless)
jffs2_get_inode_nodes(): Data CRC failed on node at 0x05ef66e0: Read 0x1d6fb47e, calculated 0xaf610aef (Unclean reboot without syncing, usually harmless)
EXT2-fs error (device mmcblk0p1): ext2_free_blocks: bit already cleared for block 6771
EXT2-fs error (device mmcblk0p1): ext2_free_blocks: bit already cleared for block 6772
EXT2-fs error (device mmcblk0p1): ext2_free_blocks: bit already cleared for block 6773
EXT2-fs error (device mmcblk0p1): ext2_free_blocks: bit already cleared for block 6774
EXT2-fs error (device mmcblk0p1): ext2_free_blocks: bit already cleared for block 6775
su-18-18:~# 
