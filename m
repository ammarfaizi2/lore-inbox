Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270446AbRHNFIg>; Tue, 14 Aug 2001 01:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270450AbRHNFI0>; Tue, 14 Aug 2001 01:08:26 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:45212
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S270446AbRHNFIO>; Tue, 14 Aug 2001 01:08:14 -0400
Message-ID: <003101c1247e$2ebbbfa0$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: debugging a weird devfs/md problem...
Date: Mon, 13 Aug 2001 22:01:31 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a weird situation here... a machine I just configured with two
RAID-5 arrays over the weekend I can now cause to oops at will during
bootup. All I have to do to cause this oops is to move one (or more) of the
IDE drives between the four IDE channels in the box.

Through the use of ksymoops and looking at the code, I have narrowed the
oops down to the call of "partition_name(rdev->old_dev)" in
../drivers/md/md.c, when it has noticed that a drive has been relocated and
it is trying to tell you what happened. In my case, rdev->old_dev contains
major 3, minor 67, and there is no drive there anymore (remember, it's been
moved :-). partition_name then calls into disk_name, which checks to see if
that partition has a non-NULL .de member (meaning there is a devfs handle
for that partition, it has been registered previously). In my case, this
handle should be NULL, but it's not.

I have added a number of debugging statements in various places
(devfs_register_partition and disk_name, mostly), and set up a line printer
console so I can see all the kernel startup messages.
devfs_register_partition is most definitely _not_ being called to register
this partition, but the .de member of the structure is non-NULL anyway.
After adding some code to disk_name to dump out the .de member being
searched for and the previous four in the structure (should be all of them
for the "disk" in question), I find that there is a handle for the disc
itself (even though the disc is not present), and some of the partitions
have handles of 0x00000001 (including one that never existed, even when the
drive was present at that location).

The only other point that I can think to mention is that there are two
RAID-5 arrays in this box, and the oops occurs on the _second_ array to be
found, not the first. The arrays have parallel members on all the drives, so
the exact same "disk has been moved" logic is being followed for the first
array, and working just fine. I'm now wondering if the initialization of the
first array is somehow corrupting the gendisk->part[] structures for this
drive that should not exist...

Anyone have any suggesting as to where to continue looking to find the
problem? I can put a workaround in to get my machine working, but there's
definitely something very weird going on here. Too bad I can't just tell the
kernel to notify me when that particular memory location gets modified...

