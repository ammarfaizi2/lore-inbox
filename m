Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSCAUG2>; Fri, 1 Mar 2002 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCAUGT>; Fri, 1 Mar 2002 15:06:19 -0500
Received: from mail.myrio.com ([63.109.146.2]:25334 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S290806AbSCAUGC> convert rfc822-to-8bit;
	Fri, 1 Mar 2002 15:06:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
Date: Fri, 1 Mar 2002 12:04:23 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3BD@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
Thread-Index: AcHBVi/IuduQgUkSTrCa62hDlL6B3gAAphLw
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: <root@chaos.analogic.com>
Cc: "Zwane Mwaikambo" <zwane@linux.realnet.co.sz>,
        "Matthew Allum" <mallum@xblox.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2002 20:05:17.0903 (UTC) FILETIME=[689805F0:01C1C15C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson [mailto:root@chaos.analogic.com] wrote:

>This is on 2.4.17. Once I am up, I can build an ext2 file-system ramdisk-
>image. I can mount it though the loop device and I can read/write to

Beware of ramdisks on 2.4.17!  This kernel has the bug I mentioned.  
It appeared with the new VM in 2.4.10 and was fixed in 2.4.18-pre4.

(I will try out your script on whatever I'm running at the moment.)

The bug has to do with the difference in how the ramdisk driver
allocated (or failed to allocate) pages when accessed directly as
a block device, or indirectly through a filesystem.

For much more detail, search in the archives for a subject line:
"ramdisk corruption problems - was: RE: pivot_root and initrd".

If you must use 2.4.17, the workaround is to dd from /dev/zero to 
/dev/ram0 before running mke2fs, thereby "initializing" all the 
blocks of the device. 
 
The following is a test script which tickled the bug, with the
workaround. 

- - - - - -
#!/bin/bash

# this script assumes /mnt/ramdisk is a valid mountpoint
# ./testdir should have 3-4 MB of reasonably large files.

# freeramdisk is a program that sends the ioctl to deallocate
# the ramdisk.  Not needed unless you are running this test
# after already using the ramdisk.
../rootfs/sbin/freeramdisk /dev/ram0

# this dd is the workaround.  Leave it out to check for the bug
#dd if=/dev/zero of=/dev/ram0 bs=1k count=4000

mke2fs -m0 /dev/ram0 4000
mount -t ext2 /dev/ram0 /mnt/ramdisk
rm -rf /mnt/ramdisk/*

cp -a ./testdir /mnt/ramdisk
umount /dev/ram0

dd if=/dev/ram0 of=ram0.img bs=1k count=4000
dd if=ram0.img of=/dev/ram0 bs=1k count=4000

mount -t ext2 /dev/ram0 /mnt/ramdisk

# if this diff returns anything, your kernel has the bug.
diff -q -r ./testdir /mnt/ramdisk/testdir

umount /dev/ram0
- - - - - -

Torrey Hoffman
