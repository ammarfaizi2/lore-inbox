Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUIXIK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUIXIK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268538AbUIXIK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:10:26 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:55462 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S268535AbUIXIJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:09:29 -0400
Date: Fri, 24 Sep 2004 10:09:40 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm2: devmem_is_allowed
In-Reply-To: <1096008029.2612.37.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0409240947230.14340-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Arjan van de Ven wrote:

> On Fri, 2004-09-24 at 00:37, Martin Diehl wrote:
> > Hi,
> > 
> > after switching from working 2.6.9-rc2 to -mm2, X refused to start on my 
> > testbox. It turned out this was because it failed (EPERM) reading from 
> > /dev/mem beyond the 1MB limit.
> 
> can you get me a strace of the failing X server?
> The code as is is as designed; X has no business messing with kernel ram
> over 1Mb, there is nothing there for it to (ab)use.
> (There is PCI memory much higher up but that is allowed again)

See below. I've reduced it to show the critical parts (AFAICS). Please 
tell me if I shall mail you the whole unmodified strace -f output from 
startx.

It looks like it is scanning /dev/mem page-by-page for some reason trying 
to get or identify some 512 page mapping. If /dev/mem does not return 
EPERM after 1MB (i.e. with my patch applied), it scans the whole 192MB of 
physical memory in the box entirely before it continues.

System is XFree86-Mach64-3.3.6-23mdk running behalf of XFree86-4.1.0-17mdk
with glx support, using a Mach64 RagePro 215GP PCI card.

Btw, if reading from /dev/mem is intended to fail above 1MB, it seems 
there might be an off-by-one somewhere, because the read starting at
1048576 (=1024 x 1024) below succeeds. I.e. the first page failing the 
read is page 257 on zero-based page counting, not 256.

HTH,
Martin

---------------

2285  fork()                            = 2286
2286  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
2286  rt_sigaction(SIGTTIN, {SIG_IGN}, {SIG_DFL}, 8) = 0
2286  rt_sigaction(SIGTTOU, {SIG_IGN}, {SIG_DFL}, 8) = 0
2286  rt_sigaction(SIGUSR1, {SIG_IGN}, {0x8049c40, [USR1], SA_RESTART|0x4000000}, 8) = 0
2286  getpid()                          = 2286
2286  setpgid(0, 2286)                  = 0
2286  execve("/sbin/X", ["X", ":0", "-deferglyphs", "16"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
2286  execve("/usr/sbin/X", ["X", ":0", "-deferglyphs", "16"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
2286  execve("/bin/X", ["X", ":0", "-deferglyphs", "16"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
2286  execve("/usr/bin/X", ["X", ":0", "-deferglyphs", "16"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
2286  execve("/usr/X11R6/bin/X", ["X", ":0", "-deferglyphs", "16"], [/* 37 vars */] <unfinished ...>
2286  <... execve resumed> )            = 0
...
2286  write(2, "(--) Mach64: PCI: Mach64 RagePro"..., 107) = 107
2286  iopl(0x3)                         = 0
2286  open("/dev/mem", O_RDONLY)        = 5
2286  lseek(5, 786480, SEEK_SET)        = 786480
2286  read(5, " 761295520", 10)         = 10
2286  close(5)                          = 0
2286  open("/dev/mem", O_RDONLY)        = 5
2286  lseek(5, 786432, SEEK_SET)        = 786432
2286  read(5, "U\252@\353{$/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0x\1\0\0"..., 65536) = 65536
2286  close(5)                          = 0
...
2286  write(2, "[mach64] ", 9)          = 9
2286  write(2, "Using memory file file: /root/tm"..., 46) = 46
2286  open("/root/tmp/glx_P3SgdqZ", O_RDWR|O_CREAT|O_TRUNC|O_EXCL, 0600) = 5
2286  lseek(5, 2097151, SEEK_SET)       = 2097151
2286  write(5, "\0", 1)                 = 1
2286  old_mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 5, 0) = 0xb7149000
2286  mlock(0xb7149000, 3221223447)     = 0
2286  write(2, "[mach64] ", 9)          = 9
2286  write(2, "2 megs of scattered memory at vi"..., 49) = 49
2286  write(2, "[mach64] ", 9)          = 9
2286  write(2, "Locating 512 pages in VM\n", 25) = 25
2286  gettimeofday({1096010897, 786404}, {0, 0}) = 0
2286  open("/dev/mem", O_RDONLY)        = 6
2286  lseek(6, 4096, SEEK_SET)          = 4096
2286  read(6, "\211\315\301\351\2\363\245\211", 8) = 8
2286  lseek(6, 8192, SEEK_SET)          = 8192
2286  read(6, "\0\0\0\0\0\0\0\0", 8)    = 8
2286  lseek(6, 12288, SEEK_SET)         = 12288
2286  read(6, "\0\0\0\0\0\0\0\0", 8)    = 8
2286  lseek(6, 16384, SEEK_SET)         = 16384
2286  read(6, "!l\'\300\0\0\0\0", 8)    = 8
...
2286  lseek(6, 1040384, SEEK_SET)       = 1040384
2286  read(6, "Award So", 8)            = 8
2286  lseek(6, 1044480, SEEK_SET)       = 1044480
2286  read(6, "\20/1?\361\0\0\0", 8)    = 8
2286  lseek(6, 1048576, SEEK_SET)       = 1048576
2286  read(6, "\374\17\1\25B\200*\0", 8) = 8
2286  lseek(6, 1052672, SEEK_SET)       = 1052672
2286  read(6, 0xbffff810, 8)            = -1 EPERM (Operation not permitted)
2286  write(2, "[mach64] ", 9)          = 9
2286  write(2, "read of /dev/mem failed at 0x101"..., 36) = 36
2286  close(6)                          = 0
2286  write(2, "\nFatal server error:\n", 21) = 21
2286  write(2, "Didn\'t find 512 pages", 21) = 21
2286  write(2, "\n", 1)                 = 1

