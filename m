Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRCCTQI>; Sat, 3 Mar 2001 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRCCTPt>; Sat, 3 Mar 2001 14:15:49 -0500
Received: from SLASH.REM.CMU.EDU ([128.2.87.44]:24845 "EHLO SLASH.REM.CMU.EDU")
	by vger.kernel.org with ESMTP id <S129675AbRCCTPb>;
	Sat, 3 Mar 2001 14:15:31 -0500
From: agrawal@ais.org
Date: Sat, 3 Mar 2001 15:16:02 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: lingering loopback bugs?
In-Reply-To: <E14Yyrs-0002Wz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10103031303220.15395-100000@SLASH.REM.CMU.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an encrypted filesystem mounted over loopback that I created under
a 2.2.16 kernel. (Using AES, 128 bit key.) Works fine in 2.2.16. Sort of
works under the unpatched 2.4 series. (Mounts okay, but hangs the system
on random blocks.)

Under various 2.4 kernels with Jens' patched, the filesystem fails to
mount. I've tried 2.4.2-loop6, 2.4.2-ac6, and 2.4.2-ac8. All give the same
result. 

If I run losetup, and then fsck the loop device, fsck is happy. But
mounting the device fails.

take2:~# uname -a
Linux take2 2.4.1 #9 Sat Feb 3 05:22:09 EST 2001 i686 unknown
take2:~# losetup -e aes /dev/loop0 /dev/hda12
Available keysizes (bits): 128 192 256 
Keysize: 128
Password :
take2:~# fsck /dev/loop0
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/loop0: clean, 9567/488640 files, 132070/977122 blocks
take2:~# mount /dev/loop0 /mnt
take2:~# umount /mnt
take2:~# losetup -d /dev/loop0
take2:~# exit

take2:~# uname -a
Linux take2 2.4.2-ac8 #2 Fri Mar 2 14:12:44 EST 2001 i686 unknown
take2:~# losetup -e aes /dev/loop0 /dev/hda12
Available keysizes (bits): 128 192 256 
Keysize: 128
Password :
take2:~# fsck /dev/loop0
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/loop0: clean, 9567/488640 files, 132070/977122 blocks
take2:~# mount /dev/loop0 /mnt
mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       or too many mounted file systems
take2:~# fsck /dev/loop0
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09

[1]+  Stopped                 fsck /dev/loop0
take2:~# bg
[1]+ fsck /dev/loop0 &
take2:~# ps ax | grep fsck
  850 pts/0    S      0:00 fsck /dev/loop0
  851 pts/0    D      0:00 fsck.ext2 /dev/loop0
  863 pts/0    S      0:00 grep fsck

