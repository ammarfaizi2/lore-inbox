Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130322AbQLJJjB>; Sun, 10 Dec 2000 04:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbQLJJiv>; Sun, 10 Dec 2000 04:38:51 -0500
Received: from comet.pacifier.com ([199.2.117.155]:1929 "EHLO
	smtp.pacifier.com") by vger.kernel.org with ESMTP
	id <S130322AbQLJJig>; Sun, 10 Dec 2000 04:38:36 -0500
Date: Sun, 10 Dec 2000 00:35:00 -0800
From: "John D. Rowell" <jdrowell@appwatch.com>
To: linux-kernel@vger.kernel.org
Subject: Weird procfs lockup problem (includes strace dump)
Message-ID: <20001210003500.A17043@jdrowell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a very rare condition, as I only stumbled onto it
twice so far. One was on a production machine, so it was rebooted
right after, but now it's on a test machine so it is still up (with
the problem).

What happens is that when trying to access process information with
the proc filesystem, the current shell just hangs. One can still
connect to the machine (with ssh or telnet) and use it normally, as
long as no program that tries to read the problematic proc entries
are used.

This time the problem seems to be with /proc/1666/exe. If one as
much as tries to ls -l that file the shell locks up.

Here's a strace dump:

yoda:~# strace ls -l /proc/1666/exe
execve("/bin/ls", ["ls", "-l", "/proc/1666/exe"], [/* 16 vars */]) =
0
uname({sys="Linux", node="yoda", ...})  = 0
brk(0)                                  = 0x8053448
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=18364, ...}) = 0
old_mmap(NULL, 18364, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0l\311\1"...,
1024) = 1024
fstat(3, {st_mode=S_IFREG|0755, st_size=1230760, ...}) = 0
old_mmap(NULL, 1177220, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x4001c000
mprotect(0x40131000, 42628, PROT_NONE)  = 0
old_mmap(0x40131000, 28672, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x114000) = 0x40131000
old_mmap(0x40138000, 13956, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40138000
close(3)                                = 0
munmap(0x40017000, 18364)               = 0
getpid()                                = 1865
brk(0)                                  = 0x8053448
brk(0x8053470)                          = 0x8053470
brk(0x8054000)                          = 0x8054000
time(NULL)                              = 976405670
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=24, ws_col=80, ws_xpixel=0,
ws_ypixel=0}) = 0
brk(0x8057000)                          = 0x8057000
lstat("/proc/1666/exe", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("/proc/1666/exe", 


and that's as far as it gets. Programs like ps, top and others just
lock up. Trying to mount proc on another location gets the same
results.

Also, the load on the machine seems to grow by 1 on each lockup
(it's at 11 right now).

This is on linux kernel 2.4.0-test12-pre7, but it also happened once
with a 2.4.0-test6 kernel. Both were patched with the appropriate
reiserfs patches, which do modify some general filesystem include
files so it may be related. The patch used on the current machine is
reiser-3.6.22. 

_jd_

-- 
John D. Rowell      <me@jdrowell.com>        <jdrowell@appwatch.com>
[irc: jdrowell]     http://jdrowell.com      http://appwatch.com
[icq: 6273503 ]     my GPL'd apps            Free Software / Open Source
[pgp: http://jdrowell.com/pgpkey] "I see fat people!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
