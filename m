Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRCCPHQ>; Sat, 3 Mar 2001 10:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRCCPHH>; Sat, 3 Mar 2001 10:07:07 -0500
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:2287 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S129272AbRCCPGx>; Sat, 3 Mar 2001 10:06:53 -0500
Message-ID: <3AA10876.7050906@cs.umanitoba.ca>
Date: Sat, 03 Mar 2001 09:06:30 -0600
From: Steven Brooks <umbrook0@cs.umanitoba.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.9) Gecko/20010228
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: block loop device hangs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When mounting a file using the loopback device, the mount program hangs
for ever.  Other than that, the system is still usable.

Dist: Redhat-7
Kernel: 2.4.2 (compiled with kgcc, i.e. egcs-2.91.66)
CPU: Pentium II 400
Mem: 128MB RAM + 512MB swap
(More information below)

For me, it is 100% reproducable, no matter what I try to mount:
	1. an ISO image from a Win2000 FAT32 partition, from hdb
(IDE/ATAPI drive)
	2. an ext2 image from an ext2 partition, from hdb (IDE/ATAPI
drive)
	3. an ext2 image from a Win2000 FAT32 partition, from hda
(a different IDE/ATAPI drive)

The simplest way for me to reproduce it is:
	dd if=/dev/zero of=t bs=1024k count=1
	mke2fs t
	mount -o loop t /mnt/cdrom

Mount then hangs, and never recovers.  I cannot even kill it using
kill -9.

An strace of mount shows (they all die in the exact same place):
	[...]
	open("t", O_RDWR)                       = 3
	open("/dev/loop0", O_RDWR)              = 4
	mlockall(0x3, 0xbffff848)               = 0
	ioctl(4, LOOP_SET_FD, 0x3)              = 0
	ioctl(4, LOOP_SET_STATUS, 0xbffff828)   = 0
	close(4)                                = 0
	close(3)                                = 0
	rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
	stat64("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7,
	0), ...}) = 0
	open("/dev/loop0", O_RDONLY)            = 3
	lseek(3, 1024, SEEK_SET)                = 1024
	read(3,

(The last line is left unfinished by strace.)

ps auwx shows:
	[...]
	root       818  0.0  1.2  1564 1548 pts/0    DL   08:44   0:00 mount -o 
loop t /mnt/cdrom
	[...]

I have lots of memory available; free shows:
	             total    used    free  shared    buffers   cached
	Mem:        127156  124884    2272       0      19140    49148
	-/+ buffers/cache:   56596   70560
	Swap:       530104      60  530044

Other than that, the system is still fine.  I can umount and mount
other, real block devices (attempting to mount another loopback just
causes another process to hang).

I can't keep up with the kernel traffic.  If you need any more
information, please e-mail me directly.

Thanks,
Steven

--------

/proc/version:
Linux version 2.4.2 (root@minneyar) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #5 Fri Mar 2 08:09:35 CST 2001

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 3
cpu MHz         : 399.327
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 796.26

/proc/modules:
loop                    7584   2 (autoclean)
tdfx                   53104   1
nfsd                   70992   8 (autoclean)
lockd                  49744   1 (autoclean) [nfsd]
sunrpc                 59136   1 (autoclean) [nfsd lockd]
8139too                15104   1 (autoclean)
agpgart                13952   1
nls_iso8859-1           2832   2 (autoclean)
nls_cp437               4352   2 (autoclean)
vfat                   11504   2 (autoclean)
fat                    31744   0 (autoclean) [vfat]
es1371                 26832   0
soundcore               3856   4 [es1371]
ac97_codec              7920   0 [es1371]
usb-uhci               22544   0 (unused)
usbcore                47408   1 [usb-uhci]


