Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTLEJwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 04:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTLEJwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 04:52:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:2199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263497AbTLEJwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 04:52:39 -0500
X-Authenticated: #689055
Message-ID: <3FD0555F.5060608@gmx.de>
Date: Fri, 05 Dec 2003 10:52:31 +0100
From: Torsten Scheck <torsten.scheck@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Large-FAT32-Filesystem Bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends:

I already sent a message to the VFAT maintainer, but I decided
to additionally bother this list with a warning. This way some
readers might avoid data loss.


I found a critical FAT32 bug when I tried to store data onto an
internal IDE 160 GB and onto an external USB2/FW-250 GB hard
disk.

 From a certain fill level on, the data clusters of a newly added
file entry get lost after a remount of the filesystem: the
directory entry of the file has the size 0, the data is lost, and
a fsck.vfat -r is needed to remove the unused clusters.

This happens to files residing in newly created directories.
Existing directories (e.g. the root directory) keep the data.  So
directories created after the fill level is reached, seem to be
unable to handle data clusters of file entries correctly.

With my 157 GB FAT32 partition the threshold is here:
/dev/hda2            157071104 135913952  21157152  87% /mnt/hda2

I reproduced the problem with two computers: a notebook with
Debian Testing and Linux Kernel 2.4.22, and a desktop computer
running Knoppix and the latest stable Kernel (2.4.23 #1 SMP Mi
Dez 3 12:46:35 CET 2003 i686 GNU/Linux).


With big external hard disks becoming very popular for data
exchange, I rely on FAT32 filesystems to be able to share data
with MS-Windows users. Within the next months many others might
reach the threshold and encounter data loss, too.  Therefore I
call this bug critical.

See transcript below for details about how to reproduce the bug.

All the best-
Torsten Scheck

------------8<------------8<------------8<------------8<----

# mkfs.vfat -F 32 /dev/hda2
mkfs.vfat 2.10 (22 Sep 2003)

# mount /mnt/hda2/

$ mount
/dev/hda2 on /mnt/hda2 type vfat (rw,umask=000)

$ cd /mnt/hda2

$ df .
/dev/hda2            157071104        16 157071088   1% /mnt/hda2

$ mkdir bigfiles
$ for (( i=1 ; i<=140 ; i++ )) ; do \
   dd if=/dev/zero of=bigfiles/f$i bs=1M count=1024; \
done

$ mkdir testfolder

$ echo "123456" > testfolder/testfile

$ ls -l testfolder/testfile
-rwxrwxrwx    1 t        t               7 2003-12-03 17:03
testfolder/testfile

$ cd

# umount /mnt/hda2

# mount /mnt/hda2

$ ls -l /mnt/hda2/testfolder/testfile
-rwxrwxrwx    1 t        t               0 2003-12-03 17:03
/mnt/hda2/testfolder/testfile

# umount /mnt/hda2

# fsck.vfat -vr /dev/hda2
dosfsck 2.10 (22 Sep 2003)
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
Checking we can access the last sector of the filesystem
Boot sector contents:
System ID "mkdosfs"
Media byte 0xf8 (hard disk)
        512 bytes per logical sector
      16384 bytes per cluster
         32 reserved sectors
First FAT starts at byte 16384 (sector 32)
          2 FATs, 32 bit entries
   39267840 bytes per FAT (= 76695 sectors)
Root directory start at cluster 2 (arbitrary size)
Data area starts at byte 78552064 (sector 153422)
    9816944 data clusters (160840810496 bytes)
63 sectors/track, 255 heads
          0 hidden sectors
  314295660 sectors total
Checking for unused clusters.
Reclaimed 1 unused cluster (16384 bytes).
Checking free cluster summary.
Free cluster summary wrong (641900 vs. really 641901)
1) Correct
2) Don't correct
? 1
Perform changes ? (y/n) y
/dev/hda2: 143 files, 9175043/9816944 clusters
------------8<------------8<------------8<------------8<----

