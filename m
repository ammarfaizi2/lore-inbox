Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUANTmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUANTkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:40:04 -0500
Received: from 216-243-104-183.lobo.net ([216.243.104.183]:55529 "EHLO
	MAIL.INTEGRITY.COM") by vger.kernel.org with ESMTP id S264471AbUANTin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:38:43 -0500
Message-ID: <40059981.5000807@integrityns.com>
Date: Wed, 14 Jan 2004 12:33:21 -0700
From: Fred Feirtag <ffeirtag@integrityns.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030917
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HotSwap IDE: PIO possible; DMA not
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2004 19:40:32.0274 (UTC) FILETIME=[45A40720:01C3DAD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its ALMOST possible to hotswap IDE drives, which make
nice backup devices for raid filesystems.  Unfortunately,
once the .../ide/pci/*.o chipset-specific module is
installed, it becomes wedged with the ide-core module,
making further substitutions impossible without a reboot.
Although it works fine PIO, see below, it would sure be
nice to solve this problem and get it working DMA.

Maybe the "Y" config option for the .../ide/pci/*.o
modules should link them into the ide-core.o module,
if "M" has been selected for ide-core (formerly ide-mod),
because now the "Y" options doesn't link them anywhere,
and probably shouldn't even be allowed, once ide-core is "M."

In /etc/modules.conf:
...
alias hd ide-disk
###below ide-disk ide-detect ide-core serverworks
below ide-disk ide-detect ide-core
...

-bash-2.05b# lsmod
Module                  Size  Used by    Not tainted
sd_mod                 12588   0  (autoclean) (unused)
3w-xxxx                40288   0  (unused)
scsi_mod              101812   2  [sd_mod 3w-xxxx]
-bash-2.05b# fdisk -l /dev/hda
(insert 40 GB disk at this time)
-bash-2.05b# modprobe hd
-bash-2.05b# fdisk -l /dev/hda

Disk /dev/hda: 40.0 GB, 40027029504 bytes
255 heads, 63 sectors/track, 4866 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        16    128488+  83  Linux
/dev/hda2            17       147   1052257+  82  Linux swap
/dev/hda3           148      4866  37905367+  83  Linux
-bash-2.05b# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4866/255/63, sectors = 78177792, start = 0
-bash-2.05b# lsmod
Module                  Size  Used by    Not tainted
ide-disk               18784   0
ide-detect               680   0  (unused)
ide-core              149296   0  [ide-disk ide-detect]
sd_mod                 12588   2  (autoclean)
3w-xxxx                40288   1
scsi_mod              101812   2  [sd_mod 3w-xxxx]
-bash-2.05b# modprobe -r hd
-bash-2.05b# fdisk -l /dev/hda
(remove 40 GB disk and insert 60 GB disk at this time)
-bash-2.05b# modprobe hd
-bash-2.05b# fdisk -l

Disk /dev/hda: 61.4 GB, 61492838400 bytes
255 heads, 63 sectors/track, 7476 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1      7476  60050938+  83  Linux
-bash-2.05b# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 7476/255/63, sectors = 120103200, start = 0
-bash-2.05b# hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)
-bash-2.05b# insmod serverworks
Using /lib/modules/2.4.24/kernel/drivers/ide/pci/serverworks.o
-bash-2.05b# hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
-bash-2.05b# lsmod
Module                  Size  Used by    Not tainted
serverworks            10552   1
ide-disk               18784   0
ide-detect               680   0  (unused)
ide-core              149296   0  [serverworks ide-disk ide-detect]
sd_mod                 12588   2  (autoclean)
3w-xxxx                40288   1
scsi_mod              101812   2  [sd_mod 3w-xxxx]
-bash-2.05b# rmmod ide-disk ide-detect
-bash-2.05b# lsmod
Module                  Size  Used by    Not tainted
serverworks            10552   1
ide-core              149296   0  [serverworks]
sd_mod                 12588   2  (autoclean)
3w-xxxx                40288   1
scsi_mod              101812   2  [sd_mod 3w-xxxx]
-bash-2.05b# rmmod ide-core
ide-core: Device or resource busy
-bash-2.05b# rmmod serverworks
serverworks: Device or resource busy
-bash-2.05b#

--Fred


