Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132534AbRDHK6Q>; Sun, 8 Apr 2001 06:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbRDHK54>; Sun, 8 Apr 2001 06:57:56 -0400
Received: from usw-sf-sshgate.sourceforge.net ([216.136.171.253]:57590 "EHLO
	usw-sf-netmisc.sourceforge.net") by vger.kernel.org with ESMTP
	id <S132534AbRDHK5v>; Sun, 8 Apr 2001 06:57:51 -0400
To: linux-kernel@vger.kernel.org
Subject: kgdb for 2.4.3 kernels
Message-Id: <E14mCtC-00031m-00@usw-pr-shell1.sourceforge.net>
From: "Amit S. Kale" <akale@users.sourceforge.net>
Date: Sun, 08 Apr 2001 03:57:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another way of allowing sane access to file system specific
information, statistics and configuration. It involves using the translation
filesystem (http://trfs.sourceforge.net/). An example of filesystem
configuration: configurable forcing data flush for all writes to files in a
filesystem, is implemented and is available for download. It is implemented
for ext2tr filesystem, which is ext2 filesystem with few modifications to use
the translation filesystem.

Filesystem views 
----------------
Filesystem views give information about filesystems and allow users to
configure them. Filesystem views for files and directories residing in the
same filesystem are identical. They are applicable to the whole filesystem.
An example filesystem view fs/config has been provided for ext2tr filesytem.
This view can be used to configure the filesystem to immediately flush data
written to files in the filesystem. 


Uses of filesystem views 
-----------------------
Filesystems can allow users to configure them through filesystem configuration
views. Although ioctls can be used for the same purpose, using views is
better. A comparison of ioctls and translation filesystem views is given on
the translation filesystem webpage. A View that gives information for a
filesystem can be put into the fs view at fs/info. The view can be
instantiated into a directory which contains text files giving filesystem
information. Filesystem statistics can be put into fs/stats.  fs/config view
can be used to configure a filesystem. 

Example of fs/config view 
-------------------------
The ext2tr filesystem (available from downloads page) contains an example
translator for fs/config view. The view instantiates into a directory, which
contains a file forcedsync. This file is used to control data sync behavior
for an ext2tr filesystem. If forcedsync file contains a character 0, flags
specified while opening a file in the filesystem are used to determine whether
data written to the file is immediately flushed to disk. If forcedsync file
contains a character 1, all data written to a file in the filesystem is
immediately flushed to disk regardless of the flags specified while opening
the file. Contents of the file can be checked by reading it and can be changed
by writing to it. A usage of the view is shown below. In the example, dd
command required 0.10 seconds when forcedsync was not enabled. After enabling
forcedsync, dd command required 1.62 seconds because data was being flushed at
each write system call. 

[root@localhost /root]# mkfs -t ext2 /dev/hda5 > /dev/null 
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09 
[root@localhost /root]# mount -t ext2tr /dev/hda5 /mnt0 
[root@localhost /root]# time dd if=/dev/zero of=/mnt0/foo bs=1024 count=100 
100+0 records in 
100+0 records out 
0.00user 0.02system 0:00.10elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k 
0inputs+0outputs (116major+20minor)pagefaults 0swaps 
[root@localhost /root]# umount /mnt0 
[root@localhost /root]# mkfs -t ext2 /dev/hda5 > /dev/null 
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09 
[root@localhost /root]# mount -t ext2tr /dev/hda5 /mnt0 
[root@localhost /root]# /home/amit/developement/trfs/cmds/vcmd/vcmd /mnt0
fs/config -c ls @1/ 
forcedsync 
[root@localhost /root]# /home/amit/developement/trfs/cmds/vcmd/vcmd /mnt0
fs/config -c cat
@1/forcedsync 
[root@localhost /root]# echo 1 | /home/amit/developement/trfs/cmds/vcmd/vcmd
/mnt0 fs/config -c
dd of=@1/forcedsync bs=1 count=1 
1+0 records in 
1+0 records out 
[root@localhost /root]# /home/amit/developement/trfs/cmds/vcmd/vcmd /mnt0
fs/config -c cat
@1/forcedsync 
[root@localhost /root]# time dd if=/dev/zero of=/mnt0/foo bs=1024 count=100 
100+0 records in 
100+0 records out 
0.00user 0.01system 0:01.62elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k 
0inputs+0outputs (116major+20minor)pagefaults 0swaps

--
Amit S. Kale
<akale@users.sourceforge.net>
Linux kernel source level debugger   http://kgdb.sourceforge.net/
Translation Filesystem               http://trfs.sourceforge.net/
