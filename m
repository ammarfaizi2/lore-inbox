Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbQK3XjQ>; Thu, 30 Nov 2000 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130990AbQK3XjG>; Thu, 30 Nov 2000 18:39:06 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:16136 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130794AbQK3XjE>; Thu, 30 Nov 2000 18:39:04 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDB0@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'jbglaw@lug-owl.de'" <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Cc: "'viro@math.psu.edu'" <viro@math.psu.edu>
Subject: RE: usbdevfs mount 2x, umount 1x
Date: Thu, 30 Nov 2000 15:08:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]
> 
> On Wed, Nov 29, 2000 at 04:47:27PM -0800, Randy Dunlap wrote:
> > 
> > Summary:  After I mount usbdevfs 2 times, and umount it
> > 1 time, the usbcore module use count prevents it from
> > being rmmod-ed.
> 
> > [root@dragon rdunlap]# lsmod
> > usbcore                50656   2  [uhci]
> 
> > and 'mount' shows no usb or usbdevfs entries listed.
> 
> Are there usbdevfs entries in /proc/mount? Maybe 'umount' removes
> too many entries from /etc/mtab...

Yes, that's how it looks to me also, so maybe it's not a kernel
problem.  Thanks for the tip.

Here's more info, including the strace that Al Viro asked for.
I also made sure that I'm using mount & umount version 2.10o.
Please let me know if you need anything else.

~Randy


1.  Start with empty slate: no modules, no usb mounts:

[root@localhost rdunlap]# lsmod
Module                  Size  Used by

[root@localhost rdunlap]# mount
/dev/hdc5 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hdc7 on /home type ext2 (rw)
/dev/hdc6 on /usr type ext2 (rw)

[root@localhost rdunlap]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hdc1 /boot ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/hdc7 /home ext2 rw 0 0
/dev/hdc6 /usr ext2 rw 0 0

2.  insmod usbcore and mount 'usb':

[root@localhost rdunlap]# insmod usbcore
Using /lib/modules/2.4.0-test11/kernel/drivers/usb/usbcore.o

[root@localhost rdunlap]# cat /etc/fstab
/dev/hdc5 / ext2 defaults 1 1
/dev/hdc1 /boot ext2 defaults 1 2
none /dev/pts devpts mode=0620 0 0
/dev/hdc7 /home ext2 defaults 1 2
/dev/cdrom /mnt/cdrom auto user,noauto,nosuid,exec,nodev,ro 0 0
/dev/fd0 /mnt/floppy auto sync,user,noauto,nosuid,nodev 0 0
none /proc proc defaults 0 0
usb /proc/bus/usb usbdevfs defaults,user 0 0
/dev/hdc6 /usr ext2 defaults 1 2
/dev/hdc2 swap swap defaults 0 0

[root@localhost rdunlap]# mount usb

3.  This gives us:

[root@localhost rdunlap]# lsmod
Module                  Size  Used by
usbcore                52224   1 

[root@localhost rdunlap]# mount
/dev/hdc5 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hdc7 on /home type ext2 (rw)
/dev/hdc6 on /usr type ext2 (rw)
usb on /proc/bus/usb type usbdevfs (rw,noexec,nosuid,nodev)

[root@localhost rdunlap]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hdc1 /boot ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/hdc7 /home ext2 rw 0 0
/dev/hdc6 /usr ext2 rw 0 0
usb /proc/bus/usb usbdevfs rw,noexec,nosuid,nodev 0 0

4.  A second mount (slightly different 'device' name = "usbfs") gives:

[root@localhost rdunlap]# mount -t usbdevfs usbfs /proc/bus/usb

[root@localhost rdunlap]# lsmod
Module                  Size  Used by
usbcore                52224   2 

[root@localhost rdunlap]# mount
/dev/hdc5 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hdc7 on /home type ext2 (rw)
/dev/hdc6 on /usr type ext2 (rw)
usb on /proc/bus/usb type usbdevfs (rw,noexec,nosuid,nodev)
usbfs on /proc/bus/usb type usbdevfs (rw)

[root@localhost rdunlap]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hdc1 /boot ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/hdc7 /home ext2 rw 0 0
/dev/hdc6 /usr ext2 rw 0 0
usb /proc/bus/usb usbdevfs rw,noexec,nosuid,nodev 0 0
usbfs /proc/bus/usb usbdevfs rw 0 0

5.  [root@localhost rdunlap]# strace -xv -o umount.st2 umount usb

gives (strace output at end):

[root@localhost rdunlap]# lsmod
Module                  Size  Used by
usbcore                52224   1 

[root@localhost rdunlap]# mount
/dev/hdc5 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hdc7 on /home type ext2 (rw)
/dev/hdc6 on /usr type ext2 (rw)
<<<<<<<<<<<<<<<<< no usb here >>>>>>>>>>>>>>>>>>>>>>

[root@localhost rdunlap]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hdc1 /boot ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/hdc7 /home ext2 rw 0 0
/dev/hdc6 /usr ext2 rw 0 0
usb /proc/bus/usb usbdevfs rw,noexec,nosuid,nodev 0 0 <---------

6.  Trying to umount the remaining usb mount:

[root@localhost rdunlap]# umount usb
umount: usb: not found

[root@localhost rdunlap]# umount /proc/bus/usb

[root@localhost rdunlap]#  mount
/dev/hdc5 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc1 on /boot type ext2 (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hdc7 on /home type ext2 (rw)
/dev/hdc6 on /usr type ext2 (rw)

[root@localhost rdunlap]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hdc1 /boot ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/hdc7 /home ext2 rw 0 0
/dev/hdc6 /usr ext2 rw 0 0

~~~~~~~~~~~~~~~~~~~~~~ strace of umount usb ~~~~~~~~~~~~~~~~~~~~~~

execve("/bin/umount", ["umount", "usb"], [/* 40 vars */]) = 0
brk(0)                                  = 0x8050d98
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_dev=makedev(22, 5), st_ino=160174, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=64,
st_size=29498, st_atime=2000/11/30-14:33:00, st_mtime=2000/11/21-13:05:44,
st_ctime=2000/11/21-13:05:44}) = 0
old_mmap(NULL, 29498, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40014000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
fstat(4, {st_dev=makedev(22, 5), st_ino=96012, st_mode=S_IFREG|0755,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=1832,
st_size=931348, st_atime=2000/11/30-14:33:00, st_mtime=2000/05/05-12:06:20,
st_ctime=2000/11/16-09:33:30}) = 0
read(4, "\x7f\x45\x4c\x46\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00"..., 4096)
= 4096
old_mmap(NULL, 945852, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4001c000
mprotect(0x400fb000, 32444, PROT_NONE)  = 0
old_mmap(0x400fb000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4,
0xde000) = 0x400fb000
old_mmap(0x40100000, 11964, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40100000
close(4)                                = 0
munmap(0x40014000, 29498)               = 0
getpid()                                = 2860
brk(0)                                  = 0x8050d98
brk(0x8050dd0)                          = 0x8050dd0
brk(0x8051000)                          = 0x8051000
open("/usr/share/locale/locale.alias", O_RDONLY) = 4
fstat64(4, {st_dev=makedev(22, 6), st_ino=80004, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=2265,
st_atime=2000/11/30-14:32:13, st_mtime=2000/05/05-12:03:36,
st_ctime=2000/11/16-09:33:32}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40014000
read(4, "# Locale name alias data base.\n#"..., 4096) = 2265
brk(0x8052000)                          = 0x8052000
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40014000, 4096)                = 0
open("/usr/share/i18n/locale.alias", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/usr/share/locale/en/LC_MESSAGES", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368270, st_mode=S_IFDIR|0755,
st_nlink=2, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=4096,
st_atime=2000/11/30-04:02:07, st_mtime=2000/11/16-09:43:20,
st_ctime=2000/11/16-09:43:20}) = 0
close(4)                                = 0
open("/usr/share/locale/en/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368271, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=44,
st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40014000
close(4)                                = 0
open("/usr/share/locale/en/LC_MONETARY", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368272, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=93,
st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 93, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40015000
close(4)                                = 0
open("/usr/share/locale/en/LC_COLLATE", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368268, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=64,
st_size=29970, st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 29970, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40103000
close(4)                                = 0
open("/usr/share/locale/en/LC_TIME", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368274, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=508,
st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 508, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40016000
close(4)                                = 0
open("/usr/share/locale/en/LC_NUMERIC", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368273, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=27,
st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 27, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40017000
close(4)                                = 0
open("/usr/share/locale/en/LC_CTYPE", O_RDONLY) = 4
fstat(4, {st_dev=makedev(22, 6), st_ino=368269, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=184,
st_size=87756, st_atime=2000/11/30-14:32:13, st_mtime=2000/05/03-12:40:18,
st_ctime=2000/11/16-09:37:34}) = 0
old_mmap(NULL, 87756, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4010b000
close(4)                                = 0
getuid()                                = 0
geteuid()                               = 0
brk(0x8054000)                          = 0x8054000
getcwd("/home/rdunlap", 4094)           = 14
readlink("/home/rdunlap/usb", 0xbfffe8d4, 4095) = -1 ENOENT (No such file or
directory)
open("/etc/mtab", O_RDONLY)             = 4
fstat64(4, {st_dev=makedev(22, 5), st_ino=160368, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=258,
st_atime=2000/11/30-14:29:56, st_mtime=2000/11/30-14:28:43,
st_ctime=2000/11/30-14:28:43}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40018000
read(4, "/dev/hdc5 / ext2 rw 0 0\nnone /pr"..., 4096) = 258
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40018000, 4096)                = 0
oldumount("/proc/bus/usb")              = 0
lstat("/etc/mtab", {st_dev=makedev(22, 5), st_ino=160368,
st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096,
st_blocks=8, st_size=258, st_atime=2000/11/30-14:33:00,
st_mtime=2000/11/30-14:28:43, st_ctime=2000/11/30-14:28:43}) = 0
open("/etc/mtab", O_RDWR|O_CREAT, 0644) = 4
close(4)                                = 0
rt_sigaction(SIGHUP, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGINT, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGILL, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTRAP, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGABRT, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGBUS, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGFPE, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGKILL, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = -1 EINVAL
(Invalid argument)
rt_sigaction(SIGUSR1, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGSEGV, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR2, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGALRM, {0x804b100, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTERM, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGSTKFLT, {0x804b0d0, ~[], 0x4000000}, NULL, 8) = 0
getpid()                                = 2860
open("/etc/mtab~2860", O_WRONLY|O_CREAT, 0) = 4
close(4)                                = 0
link("/etc/mtab~2860", "/etc/mtab~")    = 0
unlink("/etc/mtab~2860")                = 0
open("/etc/mtab~", O_WRONLY)            = 4
fcntl(4, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
close(4)                                = 0
open("/etc/mtab", O_RDONLY)             = 4
open("/etc/mtab.tmp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 5
fstat64(4, {st_dev=makedev(22, 5), st_ino=160368, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=258,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:28:43,
st_ctime=2000/11/30-14:28:43}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40018000
read(4, "/dev/hdc5 / ext2 rw 0 0\nnone /pr"..., 4096) = 258
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40019000
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 0, [0], SEEK_SET)            = 0
write(5, "/dev/hdc5 / ext2 rw 0 0\n", 24) = 24
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=24,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 24, [24], SEEK_SET)          = 0
write(5, "none /proc proc rw 0 0\n", 23) = 23
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=47,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 47, [47], SEEK_SET)          = 0
write(5, "/dev/hdc1 /boot ext2 rw 0 0\n", 28) = 28
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=75,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 75, [75], SEEK_SET)          = 0
write(5, "none /dev/pts devpts rw,mode=062"..., 38) = 38
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=113,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 113, [113], SEEK_SET)        = 0
write(5, "/dev/hdc7 /home ext2 rw 0 0\n", 28) = 28
fstat64(5, {st_dev=makedev(22, 5), st_ino=160367, st_mode=S_IFREG|0644,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=141,
st_atime=2000/11/30-14:33:00, st_mtime=2000/11/30-14:33:00,
st_ctime=2000/11/30-14:33:00}) = 0
_llseek(5, 141, [141], SEEK_SET)        = 0
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40018000, 4096)                = 0
fchmod(5, 0644)                         = 0
write(5, "/dev/hdc6 /usr ext2 rw 0 0\n", 27) = 27
close(5)                                = 0
munmap(0x40019000, 4096)                = 0
rename("/etc/mtab.tmp", "/etc/mtab")    = 0
unlink("/etc/mtab~")                    = 0
_exit(0)                                = ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
