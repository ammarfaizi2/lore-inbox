Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRAHDOU>; Sun, 7 Jan 2001 22:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRAHDOK>; Sun, 7 Jan 2001 22:14:10 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:10324 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132462AbRAHDNz>; Sun, 7 Jan 2001 22:13:55 -0500
Date: Mon, 8 Jan 2001 02:55:30 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: setfsuid on ext2 weirdness (2.4)
Message-ID: <Pine.LNX.3.96.1010108025520.14610B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.. I'm going bananas. It could be a 4am braindeath or a rh7.0 bungholio
but this is annoying:

main(int argc, char **argv)
{
	int fd;
	setfsuid(atoi(argv[1]));
	fd = open("/etc/passwd", O_RDONLY);
	printf("got fd %d\n", fd);
}

[root@wizball /root]# ./setfstest 0 
got fd 3
[root@wizball /root]# ./setfstest 500
got fd 3
[root@wizball /root]# ./setfstest 501
got fd -1

0 is obviously my root user and 500 is my standard user i log-in with. 501
exists (not that that has anything to do with this)

in fact, 0 and 500 are the ONLY ones who let a filesystem op through after
the setfsuid call. all other cause an EACCESS error on the open (or any
other fs op). and yes, the actual filepermissions on /etc and /etc/passwd
are correct.

consequence is that i can't login as any other user (or ftp, or anything
that needs to change the uid's) :(

so... the quick question is... is there anything in EXT2 or VFS that can
cause a quite normal ext2 filesystem on a 2.4.0 kernel to behave remotely
like this ?

strace shows the setfsuid call succeeds and nothing funny happens.

[root@wizball /root]# strace ./setfstest 501
execve("./setfstest", ["./setfstest", "501"], [/* 38 vars */]) = 0
uname({sys="Linux", node="wizball.xxx.yyy.zzz", ...}) = 0
brk(0)                                  = 0x80496c8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=32172, ...}) = 0
old_mmap(NULL, 32172, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\301\1"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=4851725, ...}) = 0
old_mmap(NULL, 1217864, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40020000
mprotect(0x40140000, 38216, PROT_NONE)  = 0
old_mmap(0x40140000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x11f000) = 0x40140000
old_mmap(0x40146000, 13640, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40146000
close(3)                                = 0
munmap(0x40018000, 32172)               = 0
getpid()                                = 1739
setfsuid32(0x1f5)                       = 0
open("/etc/passwd", O_RDONLY)           = -1 EACCES (Permission denied)

.... <cut>....





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
