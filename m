Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286132AbRLJB5X>; Sun, 9 Dec 2001 20:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286142AbRLJB5O>; Sun, 9 Dec 2001 20:57:14 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:47631 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S286137AbRLJB5I>; Sun, 9 Dec 2001 20:57:08 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Sun, 9 Dec 2001 20:57:08 -0500
To: linux-kernel@vger.kernel.org
Cc: Daniel Freedman <freedman@ccmr.cornell.edu>
Subject: NFS stale mount after chroot...
Message-ID: <20011209205707.A13073@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems like I can generate reproducible stale NFS mounts by mounting
a partition, chroot'ing into that mount, immediately exiting the
chroot, and then finding myself unable to unmount the NFS partition.
I'm pretty sure I've confirmed that nothing is using the partition
(both with fuser and lsof) and even tried to force umount the
partition (which seems like it should definitely umount it, rather
than returning with the same "device is busy" errors), to no avail.
The only method which I've used that seems to be able to get rid of
this NFS mount, is to reboot the NFS client, and clearly that's not a
good one at all.  If I'm missing something obvious here, my apologies
in advance.  Also, if there's any further information I can provide,
I'd be happy to help.  The dump of my procedure follows this message.

Thanks again and take care,
Daniel


--------
On NFS client:
--------

freedman@feynman:/var/space/freedman$ ls -l
total 4
drwxr-xr-x    2 freedman arias        4096 Dec  9 14:46 node1
freedman@feynman:/var/space/freedman$ su
Password: 
feynman:/var/space/freedman# mount -t nfs newton:/var/tftpboot-NFS/ ./node1/
feynman:/var/space/freedman# mount
/dev/hda6 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda5 on /boot type ext2 (rw)
/dev/hda7 on /usr type ext2 (rw)
/dev/hda8 on /var type ext2 (rw)
/dev/hda12 on /var/space type ext2 (rw)
newton:/home on /home type nfs (rw,hard,bg,intr,rsize=8192,wsize=8192,addr=192.168.0.2)
newton:/var/tftpboot-NFS/ on /var/space/freedman/node1 type nfs (rw,addr=192.168.0.2)
feynman:/var/space/freedman# cd node1/
feynman:/var/space/freedman/node1# ls
bin  boot  cdrom  dev  etc  floppy  home  initrd  lib  mnt  opt  proc  root  sbin  tmp  usr  var  vmlinuz
feynman:/var/space/freedman/node1# cd ..
feynman:/var/space/freedman# chroot node1/
feynman:/# ls -l
total 84
drwxr-xr-x    2 45       45           4096 Dec  8 03:06 bin
drwxr-xr-x    2 45       45           4096 Dec 10 01:05 boot
drwxr-xr-x    2 45       45           4096 Dec  8 03:06 cdrom
drwxr-xr-x    5 45       45          20480 Dec  8 03:07 dev
drwxr-xr-x   38 45       45           4096 Dec 10 01:19 etc
drwxr-xr-x    2 45       45           4096 Dec  8 03:06 floppy
drwxrwsr-x    2 45       45           4096 Nov 28 10:25 home
drwxr-xr-x    2 45       45           4096 Dec  8 03:06 initrd
drwxr-xr-x    4 45       45           4096 Dec  8 03:06 lib
drwxr-xr-x    2 45       45           4096 Nov 28 10:25 mnt
drwxr-xr-x    2 45       45           4096 Dec  8 03:06 opt
drwxr-xr-x    2 45       45           4096 Nov 28 10:25 proc
drwxr-xr-x    2 45       45           4096 Dec  8 03:44 root
drwxr-xr-x    2 45       45           4096 Dec 10 01:05 sbin
drwxrwxrwt    2 45       45           4096 Dec 10 01:07 tmp
drwxr-xr-x   11 45       45           4096 Dec  8 18:34 usr
drwxr-xr-x   14 45       45           4096 Dec  9 22:44 var
lrwxrwxrwx    1 45       45             19 Dec  8 20:26 vmlinuz -> boot/vmlinuz-2.4.16
feynman:/# id
uid=0(root) gid=0(root) groups=0(root)
feynman:/# exit
exit
feynman:/var/space/freedman# mount
/dev/hda6 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda5 on /boot type ext2 (rw)
/dev/hda7 on /usr type ext2 (rw)
/dev/hda8 on /var type ext2 (rw)
/dev/hda12 on /var/space type ext2 (rw)
newton:/home on /home type nfs (rw,hard,bg,intr,rsize=8192,wsize=8192,addr=192.168.0.2)
newton:/var/tftpboot-NFS/ on /var/space/freedman/node1 type nfs (rw,addr=192.168.0.2)
feynman:/var/space/freedman# cat /proc/mounts 
/dev/root.old /initrd cramfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda5 /boot ext2 rw 0 0
/dev/hda7 /usr ext2 rw 0 0
/dev/hda8 /var ext2 rw 0 0
/dev/hda12 /var/space ext2 rw 0 0
newton:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=newton 0 0
newton:/var/tftpboot-NFS/ /var/space/freedman/node1 nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=newton 0 0
feynman:/var/space/freedman# umount /var/space/freedman/node1/
umount: /var/space/freedman/node1: device is busy
feynman:/var/space/freedman# fuser ./node1/
feynman:/var/space/freedman# lsof|grep node1         
feynman:/var/space/freedman# umount /var/space/freedman/node1/
umount: /var/space/freedman/node1: device is busy
feynman:/var/space/freedman# umount -f /var/space/freedman/node1/
umount2: Device or resource busy
umount: /var/space/freedman/node1: Illegal seek
feynman:/var/space/freedman# 



-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
