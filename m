Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUEQXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUEQXCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUEQXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:02:39 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:63138 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S263045AbUEQXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:02:09 -0400
Date: Tue, 18 May 2004 01:02:04 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: ramdisk driver in 2.6.6 has a severe bug
Message-ID: <Pine.LNX.4.44.0405180049040.20775-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have severe problems creating a new root-disk using the ramdisk driver
of kernel 2.6.6 :

[tapebox:root]:(~)# uname -a
Linux tapebox.stokkie.net 2.6.6 #1 Thu May 13 05:48:57 CEST 2004 i686 unknown unknown GNU/Linux

I'm trying to create a new root filesystem from my older version :

[tapebox:root]:(~)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2814216   2579804  53% /
[tapebox:root]:(~)# dd if=/dev/zero of=/dev/ram0 bs=1k count=16384
16384+0 records in
16384+0 records out
[tapebox:root]:(~)# mke2fs -vm0 /dev/ram0 16384
mke2fs 1.35 (28-Feb-2004)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
4096 inodes, 16384 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
2 block groups
8192 blocks per group, 8192 fragments per group
2048 inodes per group
Superblock backups stored on blocks: 
        8193

Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 21 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
[tapebox:root]:(~)# mount -t ext2 /dev/ram0 /mnt/root
[tapebox:root]:(~)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2814216   2579804  53% /
/dev/ram0                15863        13     15850   1% /mnt/root
[tapebox:root]:(~)# ll /tmp/
total 16416
drwxr-xr-x  8 root  root      4096 May 13 03:24 e2fsprog/
drwx------  2 root  root      4096 May 10 20:58 gconfd-root/
drwx------  2 stock stock     4096 May 11 04:00 gconfd-stock/
-rw-r--r--  1 root  root  16777216 May 13 01:27 rootmdk92
[tapebox:root]:(~)# losetup /dev/loop0 /tmp/rootmdk92 
[tapebox:root]:(~)# mount -t ext2 /dev/loop0 /mnt/floppy
[tapebox:root]:(~)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2772536   2621484  52% /
/dev/ram0                15863        13     15850   1% /mnt/root
/dev/loop0               15863      7351      8512  47% /mnt/floppy
[tapebox:root]:(~)# cd /mnt/floppy/
[tapebox:root]:(/mnt/floppy)# ls
bin/   cdrom/  etc/     lib/         mnt/   root/  tag/  usr/
boot/  dev/    floppy/  lost+found/  proc/  sbin/  tmp/  var/
[tapebox:root]:(/mnt/floppy)# cp -ap bin boot cdrom dev etc floppy lib mnt proc root sbin tag tmp usr var /mnt/root      
[tapebox:root]:(/mnt/floppy)# sync
[tapebox:root]:(/mnt/floppy)# sync
[tapebox:root]:(/mnt/floppy)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2772536   2621484  52% /
/dev/ram0                15863      7351      8512  47% /mnt/root
/dev/loop0               15863      7351      8512  47% /mnt/floppy
[tapebox:root]:(/mnt/floppy)# ls /mnt/root/
bin/   cdrom/  etc/     lib/         mnt/   root/  tag/  usr/
boot/  dev/    floppy/  lost+found/  proc/  sbin/  tmp/  var/
[tapebox:root]:(/mnt/floppy)# cd
[tapebox:root]:(~)# sync
[tapebox:root]:(~)# umount /mnt/root 
[tapebox:root]:(~)# dd if=/dev/ram0 bs=1k count=16384 | gzip -v9 > /tmp/rootmdk100.gz
16384+0 records in
16384+0 records out
 99.8%
[tapebox:root]:(~)# ll /tmp/
total 16444
drwxr-xr-x  8 root  root      4096 May 13 03:24 e2fsprog/
drwx------  2 root  root      4096 May 10 20:58 gconfd-root/
drwx------  2 stock stock     4096 May 11 04:00 gconfd-stock/
-rw-r--r--  1 root  root     27705 May 18 00:44 rootmdk100.gz
-rw-r--r--  1 root  root  16777216 May 13 01:27 rootmdk92

Notice that here already rootmdk100.gz is far too small. We proceed :

[tapebox:root]:(~)# gunzip /tmp/rootmdk100.gz 
[tapebox:root]:(~)# losetup /dev/loop1 /tmp/rootmdk100 
[tapebox:root]:(~)# mount -t ext2 /dev/loop1 /mnt/cdrom/
[tapebox:root]:(~)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
/dev/loop0               15863      7351      8512  47% /mnt/floppy
/dev/loop1               15863      7351      8512  47% /mnt/cdrom
[tapebox:root]:(~)# umount /mnt/cdrom 
[tapebox:root]:(~)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
/dev/loop0               15863      7351      8512  47% /mnt/floppy
[tapebox:root]:(~)# ls /mnt/floppy/
bin/   cdrom/  etc/     lib/         mnt/   root/  tag/  usr/
boot/  dev/    floppy/  lost+found/  proc/  sbin/  tmp/  var/
[tapebox:root]:(~)# cd /mnt/floppy 
[tapebox:root]:(/mnt/floppy)# ll
total 35
drwxr-xr-x  2 root root  1024 Jan 29 02:50 bin/
drwxr-xr-x  2 root root  1024 Nov 22  1996 boot/
drwxr-xr-x  2 root root  1024 Nov 23  1996 cdrom/
drwxr-xr-x  3 root root  8192 Mar 29  2002 dev/
drwxr-xr-x  4 root root  1024 Jan 29 01:41 etc/
drwxr-xr-x  2 root root  1024 May 18  1996 floppy/
drwxr-xr-x  6 root root  2048 Jan 28 18:46 lib/
drwx------  2 root root 12288 Jan 29 02:44 lost+found/
drwxr-xr-x  2 root root  1024 Jun 24  1995 mnt/
drwxr-xr-x  2 root root  1024 Nov 22  1996 proc/
drwxr-xr-x  2 root root  1024 Nov 24  1995 root/
drwxr-xr-x  2 root root  1024 Jan 28 18:48 sbin/
drwxr-xr-x  2 root root  1024 Jan 30  1994 tag/
drwxrwxrwt  2 root root  1024 Nov 22  1996 tmp/
drwxr-xr-x  6 root root  1024 Mar 25  2000 usr/
drwxr-xr-x  9 root root  1024 Nov 22  1996 var/
[tapebox:root]:(/mnt/floppy)# du -s .
7351    .
[tapebox:root]:(/mnt/floppy)# cd /
[tapebox:root]:(/)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
/dev/loop0               15863      7351      8512  47% /mnt/floppy
[tapebox:root]:(/)# losetup /dev/loop0
/dev/loop0: [0302]:376868 (/tmp/rootmdk92)
[tapebox:root]:(/)# losetup /dev/loop1
/dev/loop1: [0302]:369478 (/tmp/rootmdk100)
[tapebox:root]:(/)# umount /mnt/floppy 
[tapebox:root]:(/)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
[tapebox:root]:(/)# mount -t ext2 /dev/loop1 /mnt/root 
[tapebox:root]:(/)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
/dev/loop1               15863      7351      8512  47% /mnt/root
[tapebox:root]:(/)# cd /mnt/root/
[tapebox:root]:(/mnt/root)# ll
total 12
drwx------  2 root root 12288 May 18 00:39 lost+found/
[tapebox:root]:(/mnt/root)# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2              5682692   2788940   2605080  52% /
/dev/loop1               15863      7351      8512  47% /mnt/root
[tapebox:root]:(/mnt/root)# 


So basicly i copied all my files from rootmdk92 to the new rootmdk100 ramdisk.
But after copying them and umounting the old ramdisk (rootmdk92) en deleting
 /dev/loop0 , /dev/loop1 (which is /tmp/rootmdk100) loses all its contents.

This is a serious error... anyone know whats wrong?

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

