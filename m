Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLAByz>; Thu, 30 Nov 2000 20:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQLAByq>; Thu, 30 Nov 2000 20:54:46 -0500
Received: from felix.convergence.de ([212.84.236.131]:3081 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129552AbQLABya>;
	Thu, 30 Nov 2000 20:54:30 -0500
Date: Fri, 1 Dec 2000 02:23:52 +0100
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: question about pread
Message-ID: <20001201022352.C31770@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to implement pread for my diet libc.
This is my test program:

  #include <unistd.h>
  main() {
    char buf[1024];
    int fd=open("/etc/passwd",0);
    pread(fd,buf,30,32);
    close(fd);
    write(1,buf,32);
  }

I compiled it against diet libc and glibc and ran it on a powerpc box.
t is the test program linked against diet libc, t1 is the test program
linked against glibc.
Here is the result:

  $ strace ./t1
  execve("./t1", ["./t1"], [/* 19 vars */]) = 0
  brk(0)                                  = 0x100106a8
  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30014000
  open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
  open("/usr/local/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
  stat("/usr/local/lib", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
  open("/usr/X11R6/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
  stat("/usr/X11R6/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
  open("/etc/ld.so.cache", O_RDONLY)      = 3
  fstat(3, {st_mode=S_IFREG|0644, st_size=9729, ...}) = 0
  mmap(NULL, 9729, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30015000
  close(3)                                = 0
  open("/lib/libc.so.6", O_RDONLY)        = 3
  fstat(3, {st_mode=S_IFREG|0755, st_size=992080, ...}) = 0
  read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2(\340"..., 4096) = 4096
  mmap(0xfeea000, 1072860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfeea000
  mprotect(0xffcb000, 151260, PROT_NONE)  = 0
  mmap(0xffda000, 69632, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0xe0000) = 0xffda000
  mmap(0xffeb000, 20188, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffeb000
  close(3)                                = 0
  munmap(0x30015000, 9729)                = 0
  getpid()                                = 11304
  open("/etc/passwd", O_RDONLY)           = 3
  pread(3, "daemon:x:1:1:daemon:/usr/sbin:", 30, 137438953472) = 30
  close(3)                                = 0
  write(1, "daemon:x:1:1:daemon:/usr/sbin:j ", 32daemon:x:1:1:daemon:/usr/sbin:j ) = 32
  exit(32)                                = ?
  $ strace ./t
  execve("./t", ["./t"], [/* 19 vars */]) = 0
  open("/etc/passwd", O_RDONLY)           = 3
  pread(3, "", 30, 137438953472)          = 0
  close(3)                                = 0
  write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32) = 32
  exit(32)                                = ?
  $

How can this be?  Both open the same file and call pread with the same arguments,
yet pread returns 30 for the glibc program and 0 for the diet libc one?!

Can anyone shed some light on this?  What exactly is the calling convention
for pread?  The diet libc pread code appears to work on x86 and sparc
but not on mips and ppc.

I used kernel 2.4.0-test10 on x86 and 2.2.17 on sparc and ppc, for what
it's worth.

stumped,

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
