Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVIFJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVIFJTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVIFJTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:19:23 -0400
Received: from stargate.synerway.com ([84.14.10.249]:56779 "EHLO
	stargate.synerway.com") by vger.kernel.org with ESMTP
	id S932450AbVIFJTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:19:23 -0400
Date: Tue, 6 Sep 2005 11:19:13 +0200
From: Pascal GREGIS <pgs@synerway.com>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi bug with ide tape drives
Message-ID: <20050906091913.GB454@thundax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a big problem that I supposed to be a bug of ide-scsi, eventhough I'm not totally sure of this.

I am using manual tape drives, some of them are real scsi drives and the others are ide drives, on some Linux systems that I recently upgraded to kernel 2.6.12.3.
The problem is that, with this kernel version, when I read from my ide tape drives, the read does not stop, when it has finished with the real tape data, it keeps on reading \0 characters.
This problem is new with the kernel 2.6.12.3, or at least with 2.6.12 (it doesn't happen in 2.6.10 nor in 2.6.11.11) and it does only occur with the ide drives, with the scsi ones it returns correctly. This is why I suppose it is a bug of the ide-scsi module.

I can give some additionnal infos :
$ uname -a 
Linux mybox 2.6.12.3 ...
$ lsmod
Module                  Size  Used by
st                     41888  0 
sg                     40224  0 
ide_scsi               18180  0 
8139too                25856  0 
8139cp                 21248  0 
e100                   38784  0 
sis900                 22144  0 
mii                     6016  4 8139too,8139cp,e100,sis900
sata_sis                7424  0 

I straced a read on the tape, where I previously put a little tar of less than 8kb, 
the result looks like follows :

$ strace dd if=/dev/st0 of=tmp/mynewof ibs=1024
execve("/bin/dd", ["dd", "if=/dev/st0", "of=tmp/mynewof", "ibs=1024"], [/* 15 vars */]) = 0
uname({sys="Linux", node="devlrn1", ...}) = 0
...
close(0)                                = 0
open("/dev/st0", O_RDONLY|O_LARGEFILE)  = 0
close(1)                                = 0
open("tmp/mynewof", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
... (rt_sigaction calls)
read(0, "test/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
write(1, "test/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(1, "test/test_drive.sh\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
read(0, "#!/bin/sh\n\nsource /etc/init.d/fu"..., 1024) = 1024
write(1, "#!/bin/sh\n\nsource /etc/init.d/fu"..., 512) = 512
write(1, "ot/vxaTool ${DRIVE_DEVICE} -C 0\n"..., 512) = 512
read(0, "DRIVE_DEVICE rewind\nif [ $? -ne "..., 1024) = 1024
write(1, "DRIVE_DEVICE rewind\nif [ $? -ne "..., 512) = 512
write(1, "        else\n\t        dd if=/dev"..., 512) = 512
read(0, "nd $?\ndone\n\n# Restoring files\n\ne"..., 1024) = 1024
write(1, "nd $?\ndone\n\n# Restoring files\n\ne"..., 512) = 512
write(1, "${SRC_FILE_NAME}$i ${DST_FILE_NA"..., 512) = 512
read(0, "kup/catalog_control.bash start\ne"..., 1024) = 1024
write(1, "kup/catalog_control.bash start\ne"..., 512) = 512
write(1, "test/validate_reset.sh\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
read(0, "#!/bin/bash\n\n# do not put any sp"..., 1024) = 1024
write(1, "#!/bin/bash\n\n# do not put any sp"..., 512) = 512
write(1, "comp_parent \\( -type d -or -type"..., 512) = 512
read(0, "n command $1, valid commands are"..., 1024) = 1024
write(1, "n command $1, valid commands are"..., 512) = 512
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024

and so on and so on.

I presume it does not succeed to read the file mark at the end of the data.
Or maybe there is no filemark because the previous tar process didn't succeed to put it.
I also straced the tar process, the result is as follows :

execve("/bin/tar", ["tar", "-cf", "/dev/st0", "test/"], [/* 15 vars */]) = 0
uname({sys="Linux", node="devlrn1", ...}) = 0
... (library stuffs)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7dca000
mprotect(0xb7dd9000, 4096, PROT_READ)   = 0
mprotect(0xb7ef1000, 8192, PROT_READ)   = 0
mprotect(0xb7eff000, 4096, PROT_READ)   = 0
mprotect(0xb7f18000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7dca6b0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f01000, 6199)                = 0
set_tid_address(0xb7dca6f8)             = 13619
rt_sigaction(SIGRTMIN, {0xb7dcf3e0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7dcf460, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfe16f3c, 31, (nil), 0}) = 0
clock_gettime(0, {1123863850, 6452000}) = 0
brk(0)                                  = 0x8079000
brk(0x809a000)                          = 0x809a000
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
open("/dev/st0", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(9, 0), ...}) = 0
stat64("/dev/null", {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
lstat64("test", {st_mode=S_IFDIR|0755, st_size=50, ...}) = 0
open("test", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=50, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 4 entries */, 4096)    = 128
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(4, {sa_family=AF_UNIX, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(4, {sa_family=AF_UNIX, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=244, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f02000
read(4, "# Begin /etc/nsswitch.conf\n\npass"..., 4096) = 244
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f02000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=6199, ...}) = 0
mmap2(NULL, 6199, PROT_READ, MAP_PRIVATE, 4, 0) = 0xb7f01000
close(4)                                = 0
open("/lib/libnss_files.so.2", O_RDONLY) = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\33\0\000"..., 512) = 512
fstat64(4, {st_mode=S_IFREG|0755, st_size=125912, ...}) = 0
mmap2(NULL, 37516, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0xb7dc0000
mmap2(0xb7dc8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x7) = 0xb7dc8000
close(4)                                = 0
mprotect(0xb7dc8000, 4096, PROT_READ)   = 0
munmap(0xb7f01000, 6199)                = 0
open("/etc/passwd", O_RDONLY)           = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=1074, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f02000
read(4, "swdmpsu:x:0:0::/:/bin/bash\nroot:"..., 4096) = 1074
close(4)                                = 0
munmap(0xb7f02000, 4096)                = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(4, {sa_family=AF_UNIX, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(4, {sa_family=AF_UNIX, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
open("/etc/group", O_RDONLY)            = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=623, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f02000
read(4, "swdmpsu::0:root,swdmpsu\nroot::0:"..., 4096) = 623
close(4)                                = 0
munmap(0xb7f02000, 4096)                = 0
lstat64("test/test_drive.sh", {st_mode=S_IFREG|0755, st_size=3132, ...}) = 0
open("test/test_drive.sh", O_RDONLY|O_LARGEFILE) = 4
read(4, "#!/bin/sh\n\nsource /etc/init.d/fu"..., 3132) = 3132
fstat64(4, {st_mode=S_IFREG|0755, st_size=3132, ...}) = 0
close(4)                                = 0
lstat64("test/validate_reset.sh", {st_mode=S_IFREG|0755, st_size=1097, ...}) = 0
open("test/validate_reset.sh", O_RDONLY|O_LARGEFILE) = 4
read(4, "#!/bin/bash\n\n# do not put any sp"..., 1097) = 1097
fstat64(4, {st_mode=S_IFREG|0755, st_size=1097, ...}) = 0
close(4)                                = 0
write(3, "test/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 10240) = 10240
clock_gettime(0, {1123863850, 808346000}) = 0
clock_gettime(0, {1123863850, 808543000}) = 0
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
exit_group(0)                           = ?

Pascal


PS: I already tried to join the developper of the ide-scsi module but my mail got rejected.
Also I've not tried it with a 2.6.13 kernel.
Hope someone could fix it if it's not already done.
