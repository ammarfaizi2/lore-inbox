Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAPPVb>; Tue, 16 Jan 2001 10:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbRAPPVW>; Tue, 16 Jan 2001 10:21:22 -0500
Received: from mail.crc.dk ([130.226.184.8]:47630 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S129805AbRAPPVL>;
	Tue, 16 Jan 2001 10:21:11 -0500
Message-ID: <3A6466E3.AB55716@crc.dk>
Date: Tue, 16 Jan 2001 16:21:07 +0100
From: Mogens Kjaer <mk@crc.dk>
Organization: Carlsberg Laboratory
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: da, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs client problem in kernel 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem using the nfs client in kernel 2.4.0

My server is an SGI running IRIX 6.5.8

This tiny program, t1.c, displays the problem:

#include <stdio.h>
#include <dirent.h>
main()
{
  DIR *dp;
  struct dirent *de;

  dp=opendir(".");

  while((de=readdir(dp))!=NULL)
  {
    printf("%s\n", de->d_name);
  }
  closedir(dp);
}

It just simply lists the files in the current directory,
no big deal.

If I execute this on my redhat 7.0 machine running kernel 2.4.0,
in a directory exported from the SGI machine, one file is always
missing! This is not a permission problem, there's no problems
doing this from another machine running rh70 and kernel 2.2.16.

The output is:

$ ls -l
-rw-rw-r--    1 mk       carlsber       26 Jan 16 14:03 Makefile
-rwxrwxr-x    1 mk       carlsber    13764 Jan 16 14:10 t1
-rw-rw-r--    1 mk       carlsber      194 Jan 16 14:10 t1.c
-rw-rw-r--    1 mk       carlsber  4509736 Jan 16 13:46 t1.dat

$ ./t1
.
..
t1
t1.c
t1.dat

The Makefile is not listed.

$ strace t1
....
open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=65, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
brk(0)                                  = 0x80496d8
brk(0x8059720)                          = 0x8059720
brk(0x805a000)                          = 0x805a000
getdents64(3, /* 6 entries */, 65536)   = 160
lseek(3, 1547825467, SEEK_SET)          = 1547825467
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40018000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, ".\n", 2.
)                      = 2
write(1, "..\n", 3..
)                     = 3
write(1, "t1\n", 3t1
)                     = 3
write(1, "t1.c\n", 5t1.c
)                   = 5
write(1, "t1.dat\n", 7t1.dat
)                 = 7
getdents64(3, /* 1 entries */, 65536)   = 32
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
_exit(0)                                = ?


Under kernel 2.2.16 I get the following from strace:

open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
fstat64(3, 0xbffff630)                  = -1 ENOSYS (Function not
implemented)
fstat(3, {st_mode=S_IFDIR|0775, st_size=65, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = -1 ENOSYS (Function not
implemented)
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
brk(0)                                  = 0x80496d8
brk(0x804a720)                          = 0x804a720
brk(0x804b000)                          = 0x804b000
getdents64(3, 0x8049710, 4096)          = -1 ENOSYS (Function not
implemented)
getdents(3, /* 6 entries */, 3933)      = 100
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40017000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, ".\n", 2.
)                      = 2
write(1, "..\n", 3..
)                     = 3
write(1, "t1\n", 3t1
)                     = 3
write(1, "t1.c\n", 5t1.c
)                   = 5
write(1, "t1.dat\n", 7t1.dat
)                 = 7
write(1, "Makefile\n", 9Makefile
)               = 9
getdents(3, /* 0 entries */, 3933)      = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
_exit(0)                                = ?

Why do I see this difference?

BTW, I've tried both NFS2 and NFS3 (flag during compile
and nfsvers during mount), no difference.
If I use a Linux NFS server, the problem doesn't show up,
so it is the combination SGI NFS server and Linux 2.4.0
NFS client.

I first noticed this problem because one of the news servers I
use had disappeared from the list in netscape after upgrading to kernel
2.4.0,
and an strace lead me to suspect that readdir had a problem via
NFS to an SGI server.

Is this a kernel 2.4.0 problem or have I forgotten to upgrade
something else in rh70?

Mogens
-- 
Mogens Kjaer, Carlsberg Laboratory, Dept. of Chemistry
Gamle Carlsberg Vej 10, DK-2500 Valby, Denmark
Phone: +45 33 27 53 25, Fax: +45 33 27 47 08
Email: mk@crc.dk Homepage: http://www.crc.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
