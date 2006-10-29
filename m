Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWJ2SOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWJ2SOA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWJ2SOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:14:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:15288 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932347AbWJ2SN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:13:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GO4DTR30k2oaCMPe4qPysxBT7HAT0We8aNYi1nlxpuewGGk5q1oAIm57jhgMGIlqDzkK48YPwrmpMGMtRiFxpRbugQb7gfgOetY8TsXEfsauMkRxyh/2x9JB2R2QmomCUycRiWFgTxG8mSoDT5PyGI67+MmLY7waRgVjC+ar7iY=
Message-ID: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
Date: Sun, 29 Oct 2006 19:13:59 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: loading EHCI_HCD slows down IDE disk performance by 50%
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a while ago I filed

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188630

 as it looked like moving from FC3 to FC5 caused a 40%
 drop in IDE disk performance.

After finally finding (a LOT of) time to dig into the issue,
 turns out it's a kernel problem that currently can be
 described as a 50% performance hit for IDE disks, and
 that only shows up when loading the USB2.0 ehci_hcd
 module (I originally didn't have an external USB2.0 disk
 and bought it at the same time I moved from FC3 to FC5).


The problem traces back at least to 2.6.16-rc5-git8, which
 was the kernel du jour at the time I originally reported
 the issue on lkml:

http://www.ussg.iu.edu/hypermail/linux/kernel/0604.1/0046.html

 and is still present in 2.6.19-rc3-git4 (running both FC3
 and FC5) and the current FC6 kernel.

Unfortunately, the uhci_hcd module which also can
 speak to my external USB2.0 disk is too slow to be used
 in place of ehci_hcd... like this:

[root@donkey ~]# uname -a
Linux donkey 2.6.18-1.2798.fc6 #1 SMP Mon Oct 16 14:37:32 EDT 2006
i686 athlon i386 GNU/Linux
[root@donkey ~]# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   66 MB in  3.06 seconds =  21.56 MB/sec
[root@donkey ~]# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   68 MB in  3.07 seconds =  22.18 MB/sec

<okay, replace ehci_hcd with uhci_hcd...>

[root@donkey ~]# modprobe -r ehci_hcd; modprobe uhci_hcd

<and yes, we have full speed back from the IDE disk...>

[root@donkey ~]# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  120 MB in  3.04 seconds =  39.51 MB/sec

<...but the USB2.0 external disk gets a 20x hit performance-wise>

[root@donkey ~]# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:    4 MB in  4.18 seconds = 980.44 kB/sec


Machine is a K7-800 with 512MB RAM, two internal 160GB
 IDE disks, an external 250GB USB2.0 disk, IDE DVD burner.

>From my dmesg under the FC6 kernel:

VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1604N, ATA DISK drive
hdb: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-H552B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(66)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: max request size: 512KiB
hdb: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(66)
hdb: cache flushes supported

...and...

usb 5-4: new high speed USB device using ehci_hcd and address 2
usb 5-4: configuration #1 chosen from 1 choice
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
  Vendor: ST325082  Model: 3A                Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete


Any hints/tips about what to try with this issue will be
 of course very welcome.

Thanks in advance, ciao,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
