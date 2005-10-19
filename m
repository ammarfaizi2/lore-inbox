Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVJSQxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJSQxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJSQxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:53:40 -0400
Received: from rs1.theo-phys.uni-essen.de ([132.252.73.3]:40895 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id S1751147AbVJSQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:53:40 -0400
Message-Id: <200510191652.SAA13594@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
MIME-Version: 1.0 (NeXT Mail 4.2mach_patches v148.2)
In-Reply-To: <1129314142.8443.13.camel@lade.trondhjem.org>
X-Nextstep-Mailer: Mail 4.2mach_patches [i386] (Enhance 2.2p3, May 2000)
From: Ruediger Oberhage <ruediger@next12.theo-phys.uni-essen.de>
Date: Wed, 19 Oct 2005 18:52:40 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: NFS client problem with kernel 2.6 and SGI IRIX 6.5
cc: ruediger@theo-phys.uni-essen.de,
       Trond Myklebust <trond.myklebust@fys.uio.no>, 325117@bugs.debian.org
Reply-To: ruediger@theo-phys.uni-essen.de
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
	<1129314142.8443.13.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again.

Some first findings regarding nfs problems:

At first I have to apologize for my memory (again :-)) serving me
wrong: I did state, that the "find /nfsDir -print" problem was
(generally) gone with the 2.6.12 kernel; this is wrong(!).

The problem does exist for both (Debianized) kernels 2.6.8 as well
as 2.6.12 (the details follow below in the 'strace'-dump). The
(find-)problem does NOT exist for the (2.6.12-)kernel delivered on
the KNOPPIX 4.0 DVD!!! So there is a cure for some kernel for this
one. The 'resources'-problem (OpenOffice/Mathematica) still remains
for this kernel, too!

The second thing is, that James Pearson <james-p@moving-picture.com>
was very helpful with SGI IRIX specifics. From that it is now clear,
that my nfs-server uses a "naming=version 1" variant of the xfs-file-
system, where a 'version 2' also exists and is standard with IRIXes
6.5.5 or newer. The problem might (or might not) vanish when
'version 2' is used. The transition, however, requires a total
backup, xfs-reformat, and restore procedure. Such a filesystem also
won't mount at all on IRIX versions prior to 6.5.5 (according to the
man-page). If you're willing and helping, I would still like to find
and remove the cause of the problem. James suggests to have a look
into a 'seekdir'-patch for 2.4 kernels
[http://marc.theaimsgroup.com/?l=linux-kernel&m=108741268200839&w=2],
but its URL
[http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-seekdir.dif]
doesn't seem to be available any longer. Nevertheless 'seekdir' could
be a hot candidate.

I've not yet found the time for the 'tcpdump'-analysis (sorry, but it
will follow), but I did the 'strace' on 'find /nfsdir -print' and
'getdents64', that Trond Myklebust asked to pay attention at, and it
does report different second argument values (512 and 32768) for both
(failing!) kernels:
2.6.8:
getdents64(4, /* 9 entries */, 512)     = 256
_llseek(4, 1826255771, [1826255771], SEEK_SET) = 0
getdents64(4, /* 2 entries */, 512)     = 64
2.6.12:
getdents64(4, /* 9 entries */, 32768)   = 256
_llseek(4, 1826255771, [1826255771], SEEK_SET) = 0
getdents64(4, /* 2 entries */, 32768)   = 64

As written above: for KNOPPIX 4.0 'find' answers in the way expected,
listing lots and lots of directories and files,  without any "Value
too large for defined data type" error!

[The directory has 7 'normal' subdirectories and '..' and '.', no
 regular files in them (the 9 entries?), but lots of them in sub-
 subdirectories of that tree.]


Thanks for any further help - the 'tcpdump' will follow.

Regards,
 Ruediger Oberhage

Please find the 'strace' diagnostics for both (failing) kernels
attached below - it is the same nfs-tree that is called here, for
both kernels:

Version 2.6.8 (Debian):
[Linux host 2.6.8-2-686 #1 Thu May 19 17:53:30 JST 2005 i686 GNU/Linux]
$find /Net/Apps/. -print
/Net/Apps/.
find: /Net/Apps/.: Value too large for defined data type

~$ strace find /Net/Apps/. -print
execve("/usr/bin/find", ["find", "/Net/Apps/.", "-print"], [/* 19  
vars */]) = 0
uname({sys="Linux", node="host", ...}) = 0
brk(0)                                  = 0x8055000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=52022, ...}) = 0
old_mmap(NULL, 52022, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=52022, ...}) = 0
old_mmap(NULL, 52022, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or  
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3,  
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) =  
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1254468, ...}) = 0
old_mmap(NULL, 1264780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =  
0x40025000
old_mmap(0x4014f000, 36864, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0x4014f000
old_mmap(0x40158000, 7308, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40158000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4015a000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4015a2a0,  
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,  
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40018000, 52022)               = 0
brk(0)                                  = 0x8055000
brk(0x8076000)                          = 0x8076000
brk(0)                                  = 0x8076000
time(NULL)                              = 1129736098
open(".", O_RDONLY|O_LARGEFILE)         = 3
fchdir(3)                               = 0
lstat64(".", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
lstat64("/Net/Apps/.", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
chdir("/Net/Apps/.")                    = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,  
-1, 0) = 0x40018000
write(1, "/Net/Apps/.\n", 12/Net/Apps/.)           = 12
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 9 entries */, 512)     = 256
_llseek(4, 1826255771, [1826255771], SEEK_SET) = 0
getdents64(4, /* 2 entries */, 512)     = 64
close(4)                                = 0
write(2, "find: ", 6find: )                   = 6
write(2, "/Net/Apps/.", 11/Net/Apps/.)             = 11
write(2, ": Value too large for defined da"..., 39: Value too large  
for defined data type) = 39
write(2, "\n", 1)                       = 1
fchdir(3)                               = 0
munmap(0x40018000, 4096)                = 0
exit_group(1)                           = ?

#####

Version 2.6.12 (Debian)
 [kernel-image-2.6-686_2.6.12-2.6.12-5.99.sarge1_i386.deb]:
[Linux host 2.6.12-1-686 #1 Mon Sep 12 08:34:03 UTC 2005 i686 GNU/Linux]
~$ find /Net/Apps/. -print
/Net/Apps/.
find: /Net/Apps/.: Value too large for defined data type

~$ strace find /Net/Apps/. -print
execve("/usr/bin/find", ["find", "/Net/Apps/.", "-print"], [/* 18  
vars */]) = 0
uname({sys="Linux", node="host", ...}) = 0
brk(0)                                  = 0x8055000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f59000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=110500, ...}) = 0
old_mmap(NULL, 110500, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f3e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or  
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3,  
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) =  
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1254468, ...}) = 0
old_mmap(NULL, 1264780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =  
0xb7e09000
old_mmap(0xb7f33000, 36864, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0xb7f33000
old_mmap(0xb7f3c000, 7308, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,  
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e08000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e08460,  
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,  
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f3e000, 110500)              = 0
brk(0)                                  = 0x8055000
brk(0x8076000)                          = 0x8076000
brk(0)                                  = 0x8076000
time(NULL)                              = 1129736649
open(".", O_RDONLY|O_LARGEFILE)         = 3
fchdir(3)                               = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/Net/Apps/.", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
chdir("/Net/Apps/.")                    = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,  
-1, 0) = 0xb7f58000
write(1, "/Net/Apps/.\n", 12/Net/Apps/.)           = 12
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=114, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 9 entries */, 32768)   = 256
_llseek(4, 1826255771, [1826255771], SEEK_SET) = 0
getdents64(4, /* 2 entries */, 32768)   = 64
close(4)                                = 0
write(2, "find: ", 6find: )                   = 6
write(2, "/Net/Apps/.", 11/Net/Apps/.)             = 11
write(2, ": Value too large for defined da"..., 39: Value too large  
for defined data type) = 39
write(2, "\n", 1)                       = 1
fchdir(3)                               = 0
munmap(0xb7f58000, 4096)                = 0
exit_group(1)                           = ?

--
H.-R. Oberhage
Mail: Univ. Duisburg-Essen	E-Mail:	oberhage@Uni-Essen.DE
      Fachbereich Physik		ruediger@Theo-Phys.Uni-Essen.DE
      Campus Essen, S05 V07 E88
      Universitaetsstrasse 5	Phone:  {+49|0} 201 / 183-2493
      45141 Essen, Germany	FAX:    {+49|0} 201 / 183-4578
