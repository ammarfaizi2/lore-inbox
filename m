Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSIAOOW>; Sun, 1 Sep 2002 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSIAOOW>; Sun, 1 Sep 2002 10:14:22 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:54186 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315942AbSIAOOU>; Sun, 1 Sep 2002 10:14:20 -0400
Message-Id: <5.1.0.14.2.20020901151844.03f62cb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 01 Sep 2002 15:19:21 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cantab.net>
Subject: ANN: NTFS 2.1.0a for Linux 2.4.19 and 2.4.20-pre-BK
Cc: linux-ntfs-dev@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new NTFS driver 2.1.0(a) is now available for kernel 2.4.19. NTFS 
2.1.0(a) implements the first steps towards file overwrite support.

Full and incremental patches are available from the Linux NTFS download page:
         http://linux-ntfs.sf.net/downloads.html
and from the Sourceforge project page (also older patches here):
         http://sf.net/project/showfiles.php?group_id=13956&release_id=107961

If you use bitkeeper, you can get NTFS 2.1.0a by pulling from our bitkeeper 
repository (note this is based on Marcelo's current bitkeeper tree so it is 
at 2.4.20-pre5 at the moment and will move forward as Marcelo's repository 
moves forward):
         http://linux-ntfs.bkbits.net/ntfs-2.4

The current code is relatively well tested both for mmap(2) and write(2)
both using existing applications to randomly write to files and using
custom programs to do specialized writes to test boundary conditions.

Still the code has only been run on two machines, so people trying it,
please have backups! I am confident it won't eat your data, but I am not
willing to guarantee it! I have put in an appropriately very scary config
help message to scare off the casual user for the moment...

Features of NTFS 2.1.0(a)
=========================

It is now possible to write over existing files both with mmap(2)
and write(2).

It is now possible to setup a loopback on an NTFS file and then you have
full read/write access to the loopback device. You can create a Linux fs
on the loop device for example and mount it.

This has been a much requested feature because it allows installation of
Linux on an NTFS partition using the loopback trick, i.e. from windows one
creates a large file on NTFS, then one boots Linux (from installation CD,
rescue floppies or whatever) and as root does:

mount -t ntfs -o rw /dev/hda1 /mnt/ntfs
losetup /dev/loop0 /mnt/ntfs/some_dir/preprepared_large_file
mke2fs -j /dev/loop0
mount -t ext3 /dev/loop0 /mnt/new_root
mkdir old_root
<install Linux into /mnt/new_root>
umount /mnt/new_root
losetup -d /dev/loop0
umount /mnt/ntfs

 From now on, you can boot Linux and using a minimal ramdisk loaded via
floppy for example, one just needs to have something simillar to the
following done:

mount -t ntfs -o rw /dev/hda1 /mnt/ntfs
mount -t ext3 -o loop /ntfs/some_dir/preprepared_large_file /mnt/new_root
cd /mnt/new_root
pivot_root . old_root
exec chroot . sh <dev/console >dev/console 2>&1
umount /old-root

[Note you probably cannot umount /old-root but it doesn't matter. It doesn't
disturb anyone... You could always hide it inside root/old_root or something
so users don't see it.]

I haven't actually tried to install Linux in the above way but Richard
Russon (flatcap) tested the loopback/mke2fs/read-write stuff and it
worked fine for him.

Limitations of NTFS 2.1.0(a) overwrite abilities
================================================

- Resident files only written to in memory so far, i.e. writes to files
   smaller than 1kiB won't be permanent. Warnings to that effect are shown
   via printk().

- Filling in of holes/non-initialized areas is not supported yes.

- File resize/truncate not implemented and actively trapped and aborted.

Anyone who tries this new code please let me know how you get on...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

