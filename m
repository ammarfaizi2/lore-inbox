Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132249AbRARJmZ>; Thu, 18 Jan 2001 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbRARJmQ>; Thu, 18 Jan 2001 04:42:16 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:45320 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S132249AbRARJmL>; Thu, 18 Jan 2001 04:42:11 -0500
Message-ID: <3A66BA42.6D4C8476@idb.hist.no>
Date: Thu, 18 Jan 2001 10:41:22 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <200101180039.f0I0du929822@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> Ahh.  What I was missing was that by specifying /dev/md0 as the root device,
> not only do you get an identical map for the kernels, but the root device
> remains /dev/md0 no matter which drive fails and LILO/kernel don't need to
> do anything special to find it.  This assumes the BIOS can boot from /dev/hdc
> to start with (i.e. /dev/hda is totally gone).
> 
> How does MD/RAID0 know which array should be /dev/md0?  What if you had a
> second array on /dev/hdb and /dev/hdd, would that become /dev/md0 (assuming
> it had a kernel/boot sector)?

No problem.  The /dev/md/0 device is made from partitions on various
disks.  With the 0.90-style raid all these partitions have a "raid
superblock"
at the end.  The raid superblock isn't part of the filesystem itself. 
It
stores ID information about which array it belongs to. (And where in the
array
if we are talking raid-0 or raid-5)   Having a /dev/md/1 too is fine. 
It
will record its different number in the raid superblock.
This lets the kernel autodetect all the raid arrays during boot.  This
happens
in a step after detecting the partitions themselves, before mounting
root.

This means you don't need any files to find the raid setup, and the
root filesystem can be mounted on raid without any initrd crap.
Raid devices are just "disks", just like the "real" disks.

The raid superblock also means I could move one of my disks to
another controller and change its scsi ID at the same time - RAID 
and RAID-mounted fses would still come up ok.  Or I could 
move the entire raid set to another machine - if
it doesn't have a /dev/md/0 set already.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
