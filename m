Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTHUBgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTHUBgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:36:54 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:47753 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S262357AbTHUBgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:36:48 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>
Subject: usb-storage: how to ruin your hardware(?)
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Aug 2003 03:34:48 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

just today, I bought an "USB BAR", a 128MB flash disk. I managed to make
the device unusable and only get scsi-errors from it.

what I did:
the flask disk came with a strange partition table, and fdisk told about
partition not ending on boundaries. so I just deleted the partitions and
put a new one it, spanning the whole flask disk. then I mke2fs /dev/sda1
it, which seemed fine. as next step I wanted to install lilo on the
flask disk, because some boards can boot from USB and I wanted a
bootable linux on the "USB BAR".

now lilo complained about that it would write into the partition table?
why that?! quite strange!

this puzzled me - after all, the device should behave like
a standard scsi-device. so I just played around with /dev/sda, copying
the first 512 byte from /dev/hda to it and installed lilo then. then I
deleted everything again, copied /dev/zero (512 byte) to /dev/sda,
repartitioned, re-mke2fsd etc. etc...

and now all I ever see from the device are scsi-errors, like these:

    : Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00
    :                0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x00
    : I/O error: dev 08:00, sector 0

no matter what I try. I cant even clear this sector by dd if=/dev/zero
of=/dev/sda bs=512 count=1. I even booted the laptop of my collegue,
who has winXP on it, and tried to "format f:" (f: is usb removeable device),
but winXP quits with "error in IOCTL".

kernel version is 2.4.21.

root@themroc:/proc/scsi# cat /scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Prolific Model: UsbFlashDisk     Rev: PROL
  Type:   Direct-Access                    ANSI SCSI revision: 02
root@themroc:/proc/scsi# cat usb-storage-0/0 
   Host scsi0: usb-storage
       Vendor: Prolific Technology Inc.
      Product: USB_Storage
Serial Number: None
     Protocol: 8070i
    Transport: Bulk
         GUID: 067b25170000000000000000
     Attached: Yes

root@themroc:/proc/scsi# dmesg
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 94
usb-storage: Array length appears to be: 97
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xcdb29b94 Out: 0xcdb29b80 Int: 0x00000000 (Period 0)
usb-storage: Found existing GUID 067b25170000000000000000
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3

now, say I make "dd if=/dev/zero of=/dev/sda bs=512 count=1", this will
produce:

root@themroc:/proc/scsi# dd if=/dev/zero of=/dev/sda bs=512 count=1
dd: writing `/dev/sda': Input/output error
1+0 records in
0+0 records out
root@themroc:/proc/scsi# dmesg
....
usb-storage: Bulk status Sig 0x53425355 T 0x26 R 1024 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x27 Trg 0 LUN 0 L 18 F 128 CL 12
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x27 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x3, ASC: 0x11, ASCQ: 0x0
usb-storage: Medium Error: (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 00 00 00 00 00 02 00 
Current sd08:00: sns = 70  3
ASC=11 ASCQ= 0
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 
0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:00, sector 0



oops, a Medium Error :-(

so it's possible to ruin your "USB BAR" flash disk by simply dumping some
random data to /dev/sda, sector 0? not good... I've heard so that e.g.
mke2fs on a compat flash will kill the compact flash, but I've always
been wondering if this is true. now I have the proof ...

is there any way to recover the medium?

thanks in advance,
h.rosmanith
