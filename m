Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTKQHSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 02:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTKQHSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 02:18:55 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:58632 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S263370AbTKQHSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 02:18:49 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 fork & defunct child.
Message-ID: <1069053524.3fb87654286b5@ssl.buz.org>
Date: Mon, 17 Nov 2003 07:18:44 +0000 (GMT)
From: Keith Whyte <keith@media-solutions.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.8
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm at a loss to get myself out of this one, folks, i really have tried. 
In desperation i am posting to linux-kernel in the hopes that one of you good 
folks has seen this behaviour before.

I have a kernel 2.4.18 install, based on a slackware 8.1 system
This system was installed almost a year ago and within two weeks of being up 
and running, I began to have problems compiling. 
make would fail with the likes of:
make[3]: *** wait: No child processes.  Stop.
make[3]: *** Waiting for unfinished jobs....
make[3]: *** wait: No child processes.  Stop.
make[2]: *** [first_rule] Error 2

i discovered that also, and often, programs like grep echo, cut.. would fork 
and hang. and this was what was spoiling the makes.

in this case (a kernel compile), the following is from ps axf:

17785 pts/0    T      0:00 touch /usr/src/linux-2.4.18/include/linux/ip.h
17786 pts/0    Z      0:00  \_ [touch <defunct>]

I tried reinstalling everything in /lib and other things but only a clean 
reinstallation would fix it, but the problem kept coming back after a few days.

To cut a long story short, after many clean reinstallations, hardware changes, 
and me complaining to the isp about what i thought was dodgy hardware, it 
finally seemed to be working reliably. Now, after some 6 months, the problem 
has returned. 
(this machine is located at a remote isp, i have never seen it, this makes it 
dificult to try a new kernel for example, as if it doesn't come up with nic's 
and all, the isp will charge heavily to intervene and fix it.)

This machine is still running the default kernel and modules and libc's from 
slackware 8.1.

I have made a directory (/sys2), installed some base packages below there, and 
when i chroot /sys2  , I can demonstrate the following:

(i read about strace not following forks or something on linux and i don't 
understand it fully, but why in one case is it doing these lseek and fork 
operations and in the other it isn't?)


in the "normal" system:


root@califas:~# strace /bin/true
execve("/bin/true", ["/bin/true"], [/* 25 vars */]) = 0
brk(0)                                  = 0x8049c2c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20514, ...}) = 0
old_mmap(NULL, 20514, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0h\222\1"..., 1024) = 
1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5029105, ...}) = 0
old_mmap(NULL, 1191168, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
mprotect(0x40134000, 40192, PROT_NONE)  = 0
old_mmap(0x40134000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x119000) = 0x40134000
old_mmap(0x4013a000, 15616, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4013a000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4013e000
munmap(0x40015000, 20514)               = 0
brk(0)                                  = 0x8049c2c
brk(0x8049c46)                          = 0x8049c46
getpid()                                = 17900
open("/proc/17900///////////exe", O_RDONLY) = 3
lseek(3, 12, SEEK_SET)                  = 12
read(3, "p\"\0\0", 4)                   = 4
lseek(3, 0, SEEK_END)                   = 11693
lseek(3, 8816, SEEK_SET)                = 8816
brk(0)                                  = 0x8049c46
brk(0x804a769)                          = 0x804a769
read(3, "\351o\10\0\0\215v\0U\211\345\353\3X\353s\350\370\377\377"..., 2877) = 
2877
close(3)                                = 0
getppid()                               = 17899
fork()                                  = 17901
waitpid(17901,

and it hangs till i kill the strace process


in the chroot system:

root@califas:/# strace /bin/true
execve("/bin/true", ["/bin/true"], [/* 22 vars */]) = 0
brk(0)                                  = 0x8049c2c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14328, ...}) = 0
old_mmap(NULL, 14328, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0h\222\1"..., 1024) = 
1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5029105, ...}) = 0
old_mmap(NULL, 1191168, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40019000
mprotect(0x40132000, 40192, PROT_NONE)  = 0
old_mmap(0x40132000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x119000) = 0x40132000
old_mmap(0x40138000, 15616, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40138000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4013c000
munmap(0x40015000, 14328)               = 0
brk(0)                                  = 0x8049c2c
brk(0x8049c46)                          = 0x8049c46
getpid()                                = 17904
open("/proc/17904///////////exe", O_RDONLY) = -1 ENOENT (No such file or 
directory)
brk(0x8049c2c)                          = 0x8049c2c
brk(0)                                  = 0x8049c2c
brk(0x8049c54)                          = 0x8049c54
brk(0x804a000)                          = 0x804a000
_exit(0)                                = ?


here's a diff -y of those:

execve("/bin/true", ["/bin/true"], [/* 22 vars */]) = 0       | execve
("/bin/true", ["/bin/true"], [/* 25 vars */]) = 0
brk(0)                                  = 0x8049c2c             brk
(0)                                  = 0x8049c2c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such    open
("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such 
open("/etc/ld.so.cache", O_RDONLY)      = 3                     open
("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14328, ...}) = 0    | fstat64(3, 
{st_mode=S_IFREG|0644, st_size=20514, ...}) = 0
old_mmap(NULL, 14328, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015 | old_mmap(NULL, 
20514, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015
close(3)                                = 0                     close
(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3                     open
("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0h\222   read
(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0h\222
fstat64(3, {st_mode=S_IFREG|0755, st_size=5029105, ...}) = 0    fstat64(3, 
{st_mode=S_IFREG|0755, st_size=5029105, ...}) = 0
old_mmap(NULL, 1191168, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,  | old_mmap(NULL, 
1191168, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 
mprotect(0x40132000, 40192, PROT_NONE)  = 0                   | mprotect
(0x40134000, 40192, PROT_NONE)  = 0
old_mmap(0x40132000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE | old_mmap
(0x40134000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE
old_mmap(0x40138000, 15616, PROT_READ|PROT_WRITE, MAP_PRIVATE | old_mmap
(0x4013a000, 15616, PROT_READ|PROT_WRITE, MAP_PRIVATE
close(3)                                = 0                     close
(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_AN | old_mmap(NULL, 
4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_AN
munmap(0x40015000, 14328)               = 0                   | munmap
(0x40015000, 20514)               = 0
brk(0)                                  = 0x8049c2c             brk
(0)                                  = 0x8049c2c
brk(0x8049c46)                          = 0x8049c46             brk
(0x8049c46)                          = 0x8049c46
getpid()                                = 17904               | getpid
()                                = 17900
open("/proc/17904///////////exe", O_RDONLY) = -1 ENOENT (No s | open
("/proc/17900///////////exe", O_RDONLY) = 3
brk(0x8049c2c)                          = 0x8049c2c           | lseek(3, 12, 
SEEK_SET)                  = 12
brk(0)                                  = 0x8049c2c           | read(3, "p\"\0
\0", 4)                   = 4
brk(0x8049c54)                          = 0x8049c54           | lseek(3, 0, 
SEEK_END)                   = 11693
brk(0x804a000)                          = 0x804a000           | lseek(3, 8816, 
SEEK_SET)                = 8816
_exit(0)                                = ?                   | brk
(0)                                  = 0x8049c46
                                                              > brk
(0x804a769)                          = 0x804a769
                                                              > read
(3, "\351o\10\0\0\215v\0U\211\345\353\3X\353s\350\370\377
                                                              > close
(3)                                = 0
                                                              > getppid
()                               = 17899
                                                              > fork
()                                  = 17901
                                                              > waitpid(17901,


Thanks for your help.

Keith.

