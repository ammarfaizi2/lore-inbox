Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTEETvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTEETvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:51:42 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:38290 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S261251AbTEETvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:51:40 -0400
Date: Mon, 5 May 2003 22:04:03 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [IDE] trying to make MO drive work with ide-floppy
Message-ID: <Pine.LNX.4.44.0305052154200.1105-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, Alan,

I've been trying to make my 640 MB ATAPI MO drive work with the
ide-floppy driver. I've patched ide-probe.c and ide-floppy.c for
assigning the MO drive (type ide_optical) to the floppy driver
(patch against 2.4-bkcvs below).

On bootup, the drive now gets reported as:

hde: FUJITSU MCC3064AP, ATAPI OPTICAL drive
hde: attached ide-floppy driver.
hde: No disk in drive
hde: 520192kB, 508/64/32 CHS, 2000 kBps, 512 sector size, 3600 rpm

These values would be correct for a 512 MB MO disk in the drive. So far,
so good.

Upon inserting a 640 MB disk and running 'fdisk -l /dev/hde' I get:

hde: 620704kB, 310352 blocks, 2048 sector size
hde: warning: non 512 bytes block size not fully supported
hde: 618496kB, 151/64/32 CHS, 2000 kBps, 2048 sector size, 3600 rpm
hde: The disk reports a capacity of 635600896 bytes, but the drive only handles 633339904
 hde: unknown partition table

The size and geometry stuff reported first looks good (310352 blocks is 
also reported when using ide-scsi/sd for the drive). The second line
with slightly different size looks wrong, though.

That "non 512 bytes block size" stuff doesn't look encouraging. On
trying 'mount -t ext2 -o ro /dev/hde /mnt/mo', I get:

hde: warning: non 512 bytes block size not fully supported
hde: The disk reports a capacity of 635600896 bytes, but the drive only handles 633339904
 hde: unknown partition table
hde: unsupported r/w request size
end_request: I/O error, dev 21:00 (hde), sector 2
EXT2-fs: unable to read superblock
hde: warning: non 512 bytes block size not fully supported
hde: The disk reports a capacity of 635600896 bytes, but the drive only handles 633339904
 hde: unknown partition table

The disk is formatted as a whole (no partition table) and works just fine
when using ide-scsi.

I cannot test with an MO disk with 512 byte sectors since I don't own 
any.

Are there any plans to support drives with blocksizes != 512 bytes? What 
changes would be needed to make it work? Or do I simply have to live with 
ide-scsi (still broken on 2.5, I assume...)?

Finally, the patch I used:

--- ide-probe.c.orig	Mon May  5 21:25:32 2003
+++ ide-probe.c	Mon May  5 21:25:59 2003
@@ -222,6 +222,7 @@ static inline void do_identify (ide_driv
 				break;
 			case ide_optical:
 				printk ("OPTICAL");
+				type = ide_floppy;
 				drive->removable = 1;
 				break;
 			default:
--- ide-floppy.c.orig	Mon May  5 21:25:45 2003
+++ ide-floppy.c	Mon May  5 21:26:40 2003
@@ -1962,7 +1962,7 @@ static int idefloppy_identify_device (id
 
 	if (gcw.protocol != 2)
 		printk(KERN_ERR "ide-floppy: Protocol is not ATAPI\n");
-	else if (gcw.device_type != 0)
+	else if ((gcw.device_type != 0) && (gcw.device_type != 7))
 		printk(KERN_ERR "ide-floppy: Device type is not set to floppy\n");
 	else if (!gcw.removable)
 		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");

-- 
Ciao,
Pascal

