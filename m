Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSGIPBk>; Tue, 9 Jul 2002 11:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSGIPBj>; Tue, 9 Jul 2002 11:01:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57476 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315454AbSGIPBh>; Tue, 9 Jul 2002 11:01:37 -0400
Date: Tue, 9 Jul 2002 11:06:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <15658.61035.450205.832652@charged.uio.no>
Message-ID: <Pine.LNX.3.95.1020709104427.27442B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Trond Myklebust wrote:

> >>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:
> 
>      > I think code that opens a directory as a file is broken. We
>      > have opendir() for that and it returns a DIR pointer, not a
>      > file descriptor.  If the directory was properly opened, one
>      > would never attempt to fsync() it.
> 
>  fsync() is supported on directories on local filesystems as a way of
> ensuring that changes (due to file creation etc) are committed to
> disk. Where is the POSIX violation in that?
> 
>  There is no reason why NFS, which ensures this anyway, should
> not adhere to this convention.
> 
> Cheers,
>   Trond
> -

Well, no. It's not supported. You can't get a valid file-descriptor...

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
    int fd;
    fd = open("/", O_RDWR, 0);
    fsync(fd);
}


execve("./xxx", ["xxx"], [/* 32 vars */]) = 0
brk(0)                                  = 0x804966c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000c000
munmap(0x4000c000, 4096)                = 0
old_mmap(NULL, 644232, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4000c000
mprotect(0x40097000, 74888, PROT_NONE)  = 0
old_mmap(0x40097000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x8b000) = 0x40097000
old_mmap(0x4009d000, 50312, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4009d000
close(3)                                = 0
mprotect(0x4000c000, 569344, PROT_READ|PROT_WRITE) = 0
mprotect(0x4000c000, 569344, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 27544
open("/", O_RDWR)                       = -1 EISDIR (Is a directory)


There are ways to 'cheat' and obtain a file-descriptor that references
a directory, but cheating is against POSIX rules, also.

You can open it read-only. But, Read-Only means that you can't
update it, so fsync means nothing, will return 0 because it is
already "whatever it was" since you can't modify it...

getpid()                                = 27568
open("/", O_RDONLY)                     = 3
fsync(3)                                = 0
_exit(0)                                = ?


My reading is that you need to fsync() every file within a directory
to fsync() a directory. Playing tricks with a directory inode doesn't
do it.

Regardless, POSIX.4 declines to state exactly what "successfully
transferred" means when it states that fsync() doesn't return until
all data has been successfully transferred to the disk or underlying
hardware. This is a real problem for a network file-system where
data that will eventually get to a file-server in the Congo may be
en-route for several minutes.

If an application insists, it is up to the application to determine,
probably once upon startup, just what kind of file synchronization
is supported.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

