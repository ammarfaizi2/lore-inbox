Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUJYSLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUJYSLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUJYSKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:10:12 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:45579 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261197AbUJYSH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:07:26 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9: umount problem at shutdown (2.6.7-bk20 was ok)
Date: Mon, 25 Oct 2004 21:07:09 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Cc: viro@parcelfarce.linux.theplanet.co.uk
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200410252107.09813.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My shutdown script is checking whether any "real" filesystems
(i.e. except proc, sysfs etc) are still mounted rw.

In 2.6.7-bk20, which happened to be my favorite kernel for quite
some time, that check did not trigger. However, in 2.6.9 it
triggers more than ~50% of the time. I rewrote script to give me
a shell prompt if it happens:

# mount
rootfs on / type rootfs (rw)
/dev/ide/host0/bus0/target0/lun0/part7 on / type ext2 (ro)
none on /dev type devfs (rw)
none on /proc type proc (rw,nodiratime)
/dev/hda8 on /.share type reiserfs (rw,noatime)

# mount -t ramfs none /sys
	(temp storage for following commands)

# lsof -nP >/sys/lsof-nP
# umount /.share
umount: /.share: device is busy
# strace -o /sys/umount.strace umount /.share
umount: /.share: device is busy

I copied /sys/{lsof-nP,umount.strace} to the hard drive
and rebooted. They are provided below.

But to make long story short, there is not a single
thing which may keep /.share busy. lsof -nP
shows no open files on block dev 3,8 (i.e hda8).
Actually, there are only a handful of processes
still alive, see lsof-nP output below.

It happens randomly and does not seem to require
anything special to happen. At least I see no pattern.
It happens even if I spend as little as 5 mins between
boot and shutdown, doing boring stuff like sshing into
some other box for little tweak.

umount.strace: (NB: /etc/mtab is a symlink to /proc/mounts)

execve("/bin/umount", ["/bin/umount", "/.share"], [/* 4 vars */]) = 0
uname({sys="Linux", node="shadow", ...}) = 0
brk(0)                                  = 0x8051000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/var/app/glibc-2.3/etc/ld.so.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/mmx", 0xbffff220)     = -1 ENOENT (No such file or directory)
open("/lib/i686/libc.so.6", O_RDONLY)   = -1 ENOENT (No such file or directory)
stat64("/lib/i686", 0xbffff220)         = -1 ENOENT (No such file or directory)
open("/lib/mmx/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/mmx", 0xbffff220)          = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0555, st_size=16153080, ...}) = 0
old_mmap(NULL, 1131908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40013000
mprotect(0x4011e000, 38276, PROT_NONE)  = 0
old_mmap(0x4011e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x10a000) = 0x4011e000
old_mmap(0x40124000, 13700, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40124000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40128000
brk(0)                                  = 0x8051000
brk(0x8052000)                          = 0x8052000
umask(033)                              = 022
getuid32()                              = 0
geteuid32()                             = 0
brk(0x8053000)                          = 0x8053000
readlink("/.share", 0xbfffedc0, 4096)   = -1 EINVAL (Invalid argument)
open("/etc/mtab", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40129000
read(3, "rootfs / rootfs rw 0 0\n/dev/ide/"..., 1024) = 206
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x40129000, 4096)                = 0
oldumount("/.share")                    = -1 EBUSY (Device or resource busy)
lstat64("/etc/mtab", {st_mode=S_IFLNK|0777, st_size=12, ...}) = 0
write(2, "umount: /.share: device is busy\n", 32) = 32
_exit(1)                                = ?

lsof-nP:

COMMAND     PID USER   FD   TYPE DEVICE     SIZE      NODE NAME
init          1 root  cwd    DIR    3,7     4096         2 /
init          1 root  rtd    DIR    3,7     4096         2 /
init          1 root  txt    REG    3,7   591816    107534 /app/bash-2.05b/bin/bash
init          1 root  mem    REG    3,7   360212    107661 /app/glibc-2.3/lib/libnss_files-2.3.so
init          1 root  mem    REG    3,7  1164667    107669 /app/glibc-2.3/lib/libnsl-2.3.so
init          1 root  mem    REG    3,7   312114    107672 /app/glibc-2.3/lib/libnss_compat-2.3.so
init          1 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
init          1 root  mem    REG    3,7    50088    107656 /app/glibc-2.3/lib/libdl-2.3.so
init          1 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
init          1 root  255r   REG    3,7      409        57 /init
ksoftirqd     2 root  cwd    DIR    3,7     4096         2 /
ksoftirqd     2 root  rtd    DIR    3,7     4096         2 /
events/0      3 root  cwd    DIR    3,7     4096         2 /
events/0      3 root  rtd    DIR    3,7     4096         2 /
khelper       4 root  cwd    DIR    3,7     4096         2 /
khelper       4 root  rtd    DIR    3,7     4096         2 /
kblockd/0    20 root  cwd    DIR    3,7     4096         2 /
kblockd/0    20 root  rtd    DIR    3,7     4096         2 /
pdflush      45 root  cwd    DIR    3,7     4096         2 /
pdflush      45 root  rtd    DIR    3,7     4096         2 /
pdflush      46 root  cwd    DIR    3,7     4096         2 /
pdflush      46 root  rtd    DIR    3,7     4096         2 /
kswapd0      47 root  cwd    DIR    3,7     4096         2 /
kswapd0      47 root  rtd    DIR    3,7     4096         2 /
aio/0        48 root  cwd    DIR    3,7     4096         2 /
aio/0        48 root  rtd    DIR    3,7     4096         2 /
reiserfs/   279 root  cwd    DIR    3,7     4096         2 /
reiserfs/   279 root  rtd    DIR    3,7     4096         2 /
do_shutdo 12996 root  cwd    DIR    3,7     4096        36 /app/shutdown-0.0.6/script
do_shutdo 12996 root  rtd    DIR    3,7     4096         2 /
do_shutdo 12996 root  txt    REG    3,7   591816    107534 /app/bash-2.05b/bin/bash
do_shutdo 12996 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
do_shutdo 12996 root  mem    REG    3,7    50088    107656 /app/glibc-2.3/lib/libdl-2.3.so
do_shutdo 12996 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
do_shutdo 12996 root    0r   CHR    1,3                  6 /dev/null
do_shutdo 12996 root    1w   CHR    5,1                 18 /dev/console
do_shutdo 12996 root    2w   CHR    5,1                 18 /dev/console
do_shutdo 12996 root  255r   REG    3,7     1429        42 /app/shutdown-0.0.6/script/do_shutdown
hardshutd 13000 root  cwd    DIR    3,7     4096         2 /
hardshutd 13000 root  rtd    DIR    3,7     4096         2 /
hardshutd 13000 root  txt    REG    3,7     1404        43 /app/shutdown-0.0.6/script/hardshutdown
hardshutd 13000 root    0r   CHR    1,3                  6 /dev/null
hardshutd 13000 root    1w   CHR    1,3                  6 /dev/null
hardshutd 13000 root    2w   CHR    1,3                  6 /dev/null
stop_stor 13414 root  cwd    DIR    3,7     4096        36 /app/shutdown-0.0.6/script
stop_stor 13414 root  rtd    DIR    3,7     4096         2 /
stop_stor 13414 root  txt    REG    3,7   591816    107534 /app/bash-2.05b/bin/bash
stop_stor 13414 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
stop_stor 13414 root  mem    REG    3,7    50088    107656 /app/glibc-2.3/lib/libdl-2.3.so
stop_stor 13414 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
stop_stor 13414 root    0r   CHR    1,3                  6 /dev/null
stop_stor 13414 root    1w   CHR    5,1                 18 /dev/console
stop_stor 13414 root    2w   CHR    5,1                 18 /dev/console
stop_stor 13414 root  255r   REG    3,7     1949        44 /app/shutdown-0.0.6/script/stop_storage
sleep     13501 root  cwd    DIR    3,7     4096         2 /
sleep     13501 root  rtd    DIR    3,7     4096         2 /
sleep     13501 root  txt    REG    3,7     5200     61856 /bin/sleep
sleep     13501 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
sleep     13501 root  mem    REG    3,7    69355    107658 /app/glibc-2.3/lib/libcrypt-2.3.so
sleep     13501 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
sh        13511 root  cwd    DIR    3,7     4096        36 /app/shutdown-0.0.6/script
sh        13511 root  rtd    DIR    3,7     4096         2 /
sh        13511 root  txt    REG    3,7   591816    107534 /app/bash-2.05b/bin/bash
sh        13511 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
sh        13511 root  mem    REG    3,7    50088    107656 /app/glibc-2.3/lib/libdl-2.3.so
sh        13511 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
sh        13511 root  mem    REG    3,7   312114    107672 /app/glibc-2.3/lib/libnss_compat-2.3.so
sh        13511 root  mem    REG    3,7  1164667    107669 /app/glibc-2.3/lib/libnsl-2.3.so
sh        13511 root  mem    REG    3,7   360212    107661 /app/glibc-2.3/lib/libnss_files-2.3.so
sh        13511 root    0r   CHR    5,1                 18 /dev/console
sh        13511 root    1w   CHR    5,1                 18 /dev/console
sh        13511 root    2w   CHR    5,1                 18 /dev/console
sh        13511 root  255w   CHR    5,1                 18 /dev/console
lsof      13541 root  cwd    DIR    3,7     4096        36 /app/shutdown-0.0.6/script
lsof      13541 root  rtd    DIR    3,7     4096         2 /
lsof      13541 root  txt    REG    3,7    89404     61828 /bin/lsof
lsof      13541 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
lsof      13541 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
lsof      13541 root    0r   CHR    5,1                 18 /dev/console
lsof      13541 root    1w   REG   0,13        0     29127 /sys/lsof-nP
lsof      13541 root    2w   CHR    5,1                 18 /dev/console
lsof      13541 root    3r   DIR    0,3        0         1 /proc
lsof      13541 root    4r   DIR    0,3        0 887422985 /proc/13541/fd
lsof      13541 root    5w  FIFO    0,7              29132 pipe
lsof      13541 root    6r  FIFO    0,7              29133 pipe
lsof      13542 root  cwd    DIR    3,7     4096        36 /app/shutdown-0.0.6/script
lsof      13542 root  rtd    DIR    3,7     4096         2 /
lsof      13542 root  txt    REG    3,7    89404     61828 /bin/lsof
lsof      13542 root  mem    REG    3,7   832636    107652 /app/glibc-2.3/lib/ld-2.3.so
lsof      13542 root  mem    REG    3,7 16153080    107653 /app/glibc-2.3/lib/libc-2.3.so
lsof      13542 root    4r  FIFO    0,7              29132 pipe
lsof      13542 root    7w  FIFO    0,7              29133 pipe
--
vda

