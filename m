Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277141AbRJLBSC>; Thu, 11 Oct 2001 21:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRJLBRw>; Thu, 11 Oct 2001 21:17:52 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:1540 "EHLO
	gaby.applianceware.com") by vger.kernel.org with ESMTP
	id <S277141AbRJLBRc>; Thu, 11 Oct 2001 21:17:32 -0400
Date: Thu, 11 Oct 2001 18:23:53 -0700 (PDT)
From: <gaby@applianceware.com>
To: <torvalds@transmeta.com>, <mingo@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] for Multiple Device driver - md.c (kernel 2.4.12)
Message-ID: <Pine.LNX.4.33.0110111801490.1143-100000@gaby.applianceware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My name is Jean-Gabriel Rican and I have a kernel problem.

There is a slight limitation in the Multiple Devices driver that I would
like to address here.

Suppose you can hot-swap a hard disk in a system.
Now if you have a degraded Software RAID device (for example a RAID-5 with
one disk failed) and you replace the failed disk on-the-fly you cannot
start reconstruction (with raidhotadd) of the Software RAID device with
the replaced disk because it says it is BUSY.

The solution is to stop the RAID device (raidstop) and [re-]start it with
(raidstart).

This is an inconvenient because if the RAID device is mounted somewhere it
should be first umounted before stopping, user access to the device would
be interrupted and so on. And it is even worse when the RAID has the root
file system on it and you cannot umount it.

My solution and patch to the kernel driver md.c is to remove the drive
from the RAID array if it is faulty and then import it later.
I tested it thoroughly and it seems to work well.
Kernel version is 2.4.12 (latest).

So I submit this patch and hope that it will be accepted.
I have to specify that I am not [yet] member in Linux Kernel Mailing
List.

Thank you,
Jean-Gabriel RICAN

This is the patch:

-----------------------------------------------------------------------
--- drivers/md/md.c.orig	Wed Oct  3 22:27:48 2001
+++ drivers/md/md.c	Thu Oct 11 10:56:45 2001
@@ -2388,9 +2388,18 @@
 	}

 	rdev = find_rdev(mddev, dev);
-	if (rdev)
+	if (rdev && !rdev->faulty)
 		return -EBUSY;

+	if (rdev && rdev->faulty) {
+		err = hot_remove_disk(mddev, dev);
+		if (err == -EBUSY)
+			return -EBUSY;
+		if (err) {
+			MD_BUG();
+			return -EINVAL;
+		}
+	}
 	err = md_import_device (dev, 0);
 	if (err) {
 		printk(KERN_WARNING "md: error, md_import_device() returned %d\n", err);

--------------------------------------------------------------------------

