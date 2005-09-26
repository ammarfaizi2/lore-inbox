Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbVIZPcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbVIZPcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbVIZPcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:32:15 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:14747 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S1751645AbVIZPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:32:15 -0400
Date: Mon, 26 Sep 2005 19:32:02 +0400 (MSD)
From: Evgeny Rodichev <er@sai.msu.su>
To: linux-kernel@vger.kernel.org
cc: er@sai.msu.su
Subject: new megaraid driver problem at Opteron
Message-ID: <Pine.GSO.4.63.0509261854490.9383@ra.sai.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found the problem with the following configuration:

- kernel 2.6.13 compiled for x86_64
- new megaraid driver (megaraid_mm.c - 2.20.2.6, megaraid_mbox.c - 2.20.4.6)
- LSI Logic / Symbios Logic MegaRAID SATA 150-6 RAID Controller
- Dual Core AMD Opteron(tm) Processor 265 AuthenticAMD

The problem looks like read operations are OK, but all write operations
are broken (write data comes to the wrong place?).

It is possible to create partitions, file system (ext2fs), to write files -
all in 32-bit mode (with the same kernel compiled for i686). And after reboot
with x86_64 kernel all data from this filesystem are perfectly readable.

But after attempts to write to this filesystem there are two kinds of result:
(1) no visible changes, and (2) corrupted filesystem.

For example, I am trying to delete partition:

-----------------------------------------------------------------
bash-3.00# fdisk /dev/sdc
Command (m for help): p

Disk /dev/sdc: 1200.2 GB, 1200265101312 bytes
255 heads, 63 sectors/track, 145923 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1         400     3212968+  83  Linux

Command (m for help): d 1
Selected partition 1

Command (m for help): p

Disk /dev/sdc: 1200.2 GB, 1200265101312 bytes
255 heads, 63 sectors/track, 145923 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
bash-3.00#
-----------------------------------------------------------------


OK, looks like partition has been deleted. But


-----------------------------------------------------------------
bash-3.00# fdisk /dev/sdc

Command (m for help): p

Disk /dev/sdc: 1200.2 GB, 1200265101312 bytes
255 heads, 63 sectors/track, 145923 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1         400     3212968+  83  Linux

Command (m for help): q

bash-3.00#
-----------------------------------------------------------------


No any error diagnostics. mke2fs reports the success, but mount can't
recognize the created filesystem. I kindly appreciate any help or ideas -
what may be wrong.


Some relevant information:


bash-3.00# uname -a
Linux opteron 2.6.13 #9 SMP Mon Sep 26 18:22:36 MSD 2005 x86_64 Dual Core AMD Opteron(tm) Processor 265 AuthenticAMD GNU/Linux


>From lspci -v

03:02.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
         Subsystem: LSI Logic / Symbios Logic MegaRAID SATA 150-6 RAID Controller
         Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 9
         Memory at dfcf0000 (32-bit, prefetchable) [size=64K]
         Expansion ROM at dfc00000 [disabled] [size=64K]
         Capabilities: [80] Power Management version 2

>From dmesg:

Sep 26 19:27:52 opteron kernel: megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
Sep 26 19:27:52 opteron kernel: megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
Sep 26 19:27:52 opteron kernel: megaraid: probe new device 0x1000:0x1960:0x1000:0x0523: bus 3:slot 2:func 0
Sep 26 19:27:52 opteron kernel: megaraid: fw version:[713N] bios version:[G119]
Sep 26 19:27:52 opteron kernel: scsi11 : LSI Logic MegaRAID driver
Sep 26 19:27:52 opteron kernel: scsi[11]: scanning scsi channel 0 [Phy 0] for non-raid devices
Sep 26 19:27:53 opteron kernel: scsi[11]: scanning scsi channel 1 [virtual] for logical drives
Sep 26 19:27:53 opteron kernel:   Vendor: MegaRAID  Model: LD 0 RAID0 1144G  Rev: 713N
Sep 26 19:27:53 opteron kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Sep 26 19:27:53 opteron kernel: SCSI device sdc: 2344267776 512-byte hdwr sectors (1200265 MB)
Sep 26 19:27:53 opteron kernel: SCSI device sdc: 2344267776 512-byte hdwr sectors (1200265 MB)
Sep 26 19:27:53 opteron kernel:  sdc: sdc1
Sep 26 19:27:53 opteron kernel: Attached scsi disk sdc at scsi11, channel 1, id 0, lun 0




_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
