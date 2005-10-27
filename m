Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVJ0U5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVJ0U5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVJ0U5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:57:49 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22920 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932241AbVJ0U5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:57:48 -0400
Date: Thu, 27 Oct 2005 22:57:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: hooanon05@yahoo.co.jp
cc: Unionfs mailing list <unionfs@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS Permission denied instead of EROFS
In-Reply-To: <E1EVAnp-0000p1-Tq@jroun>
Message-ID: <Pine.LNX.4.61.0510272236230.13626@yvahk01.tjqt.qr>
References: <E1EVAnp-0000p1-Tq@jroun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,


I am extending this topic to LKML to post a question that goes beyond the 
scope of unionfs. First, a description:

unionfs depends on filesystems being read-only returning EROFS to properly 
do copyup.
Unfortunately, NFS mounts that are exported with the "ro" flag, and which 
have been imported/mounted with the "rw" flag, either implicit (i.e. 
automatically added by /bin/mount) or explicit using "-o rw", do return 
EACCES instead of EROFS for opening already-existing files with the write 
bit. Or, in other words:


# grep export /etc/exports 
/export *(ro,async,no_root_squash)
# mount localhost:/export /mnt -t nfs -oro
# logout
$ cat /proc/mounts | grep nfs
localhost:/export /mnt nfs ro,v3,rsize=32768,wsize=32768,hard,tcp,lock,addr=localhost 0 0
$ ls -l /mnt/file
-rw-r--r--  1 root root 0 Oct 27 22:42 /mnt/file
$ touch /mnt/file
touch: cannot touch `file': Read-only file system
$ strace -e trace=file touch /mnt/file
open("/mnt/file", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = 
-1 EACCES (Permission denied)
utimes("/mnt/file", NULL) = -1 EACCES (Permission denied)
  ...
touch: cannot touch `/mnt/file': Permission denied


If the file does not exist however, everything is ok:
$ touch /mnt/file
touch: cannot touch /mnt/file': Read-only file system
$ strace -e trace=file touch /mnt/file
open("/mnt/file", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) =
-1 EROFS (Read-only file system)
utimes("/mnt/file", NULL) = -1 ENOENT (No such file or directory)


Which brings me right to question... should mountd or knfsd be adjusted to
refuse a rw mount request if an nfs export is only available as ro? Like it is
already the case with normal block devices:

# strace -e trace=mount mount /dev/hdb /F -o rw -t iso9660
mount("/dev/hd/b", "/F", "iso9660", MS_POSIXACL|MS_ACTIVE|MS_NOUSER|0xec0000,
0x8067cd0) = -1 EROFS (Read-only file system)
mount: block device /dev/hd/b is write-protected, mounting read-only
mount("/dev/hd/b", "/F", "iso9660",
MS_RDONLY|MS_POSIXACL|MS_ACTIVE|MS_NOUSER|0xec0000, 0x80680c8) = 0



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
