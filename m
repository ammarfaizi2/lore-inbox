Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTKJQCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbTKJQCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:02:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:46818 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263938AbTKJQCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:02:47 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Nov 2003 17:02:36 +0100 (MET)
Message-Id: <UTC200311101602.hAAG2an12276.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, konsti@ludenkalle.de
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suppose that booting with boot parameter "hda=remap" should work.

> Seems so...

Good. So there were two problems. One was devfs+hd.c, caused by
the fact that hd.c fails to set devfs_name. And the second was
EZDrive, solved by booting with "hda=remap".

Probably it is a good idea to warn when we see EZD or DM.
A minimal patch would be

--- 2.6.0test9/linux/fs/partitions/msdos.c	Fri May 30 18:12:57 2003
+++ fs/partitions/msdos.c	Mon Nov 10 16:20:11 2003
@@ -425,6 +425,10 @@
 		put_partition(state, slot, start, size);
 		if (SYS_IND(p) == LINUX_RAID_PARTITION)
 			state->parts[slot].flags = 1;
+		if (SYS_IND(p) == DM6_PARTITION)
+			printk("[DM]");
+		if (SYS_IND(p) == EZD_PARTITION)
+			printk("[EZD]");
 	}
 
 	printk("\n");

The next project for you is getting rid of EZD (if you want).
Backup valuable stuff.

Boot a kernel that remaps, say vanilla 2.4.
Print partition table (in sector units) on paper.
  sfdisk -d /dev/hda > hda.pt
gives the full table in a format that sfdisk can restore.
  dd if=/dev/hda of=hdapt bs=1 count=64 skip=446
gives the primary part of the table in binary.
  dd if=/dev/hda of=hdambr bs=512 count=1
gives the entire fake sector 0 (that is, sector 1).
Save the output files somewhere not on hda.

Now boot a kernel that does not remap. Since you won't see
your root filesystem on hda, this should probably be from
a rescue floppy or CD. Recent kernels understand the "hda=noremap"
boot parameter. Make sure no remap is done (e.g., *fdisk
mentions partitions of type 55). Now write the desired partition
table (e.g.
  dd if=hdapt of=/dev/hda bs=1 count=64 seek=446
or
  dd if=hdambr of=/dev/hda
or
  sfdisk /dev/hda < hda.pt
).

That should do it, but be careful that you can boot again afterwards.
Sector 0 has the partition table in bytes 446-509,
a signature in bytes 510-511, and a boot loader in bytes 0-445.
You may have to reinstall LILO or grub or so. In some cases
copying the entire sector 1 to sector 0 will suffice.

Good luck!
Andries
