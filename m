Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265450AbSJSBdV>; Fri, 18 Oct 2002 21:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265453AbSJSBdU>; Fri, 18 Oct 2002 21:33:20 -0400
Received: from services.cam.org ([198.73.180.252]:64107 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265450AbSJSBdQ>;
	Fri, 18 Oct 2002 21:33:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Date: Fri, 18 Oct 2002 21:32:28 -0400
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
References: <309790000.1034982417@baldur.austin.ibm.com>
In-Reply-To: <309790000.1034982417@baldur.austin.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210182132.28099.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 18, 2002 07:06 pm, Dave McCracken wrote:
> Ok, I've shaken the shared page table code hard, and fixed all the bugs I
> could find.  It now runs reliably on all the configurations I have access
> to, including regression runs of LTP.
>
> I've audited the usage of page_table_lock, and I believe I have covered all
> the places that also need to hold the pte_page_lock.
>
> For reference, one of the tests was TPC-H.  My code reduced the number of
> allocated pte_chains from 5 million to 50 thousand.

This is still failing when starting kde3 here.  Here is what looks different
in the massive straces of kde starting:

---------- fails
[pid   983] getpid()                    = 983
[pid   983] getrlimit(0x3, 0xbffff724)  = 0
[pid   983] close(5)                    = 0
[pid   983] close(3)                    = 0
[pid   983] rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
[pid   983] rt_sigaction(SIGPIPE, {SIG_DFL}, {SIG_DFL}, 8) = 0
[pid   983] chdir("/poola/home/ed")     = 0
[pid   983] brk(0x805d000)              = 0x805d000
[pid   983] open("/usr/lib/ksmserver.la", O_RDONLY) = 3
[pid   983] fstat64(3, {st_dev=makedev(33, 3), st_ino=125820, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8
, st_size=947, st_atime=2002/10/18-21:00:31, st_mtime=2002/08/13-08:32:59, st_ctime=2002/08/22-20:36:41}) = 0
[pid   983] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
[pid   983] read(3, "# ksmserver.la - a libtool libra"..., 4096) = 947
[pid   983] read(3, "", 4096)           = 0
[pid   983] close(3)                    = 0
[pid   983] munmap(0x40014000, 4096)    = 0
[pid   983] open("/usr/lib/ksmserver.so", O_RDONLY) = 3
[pid   983] read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\262"..., 1024) = 1024
[pid   983] fstat64(3, {st_dev=makedev(33, 3), st_ino=125821, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=1
84, st_size=92000, st_atime=2002/10/18-21:09:24, st_mtime=2002/08/13-08:49:39, st_ctime=2002/08/22-20:36:41}) = 0
[pid   983] old_mmap(NULL, 95284, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x41029000
[pid   983] mprotect(0x4103f000, 5172, PROT_NONE) = 0
[pid   983] old_mmap(0x4103f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x15000) = 0x4103f000
[pid   983] close(3)                    = 0
[pid   983] --- SIGSEGV (Segmentation fault) ---
[pid   982] <... read resumed> "", 1)   = 0
[pid   982] --- SIGCHLD (Child exited) ---
[pid   982] dup(2)                      = 6
[pid   982] fcntl64(6, F_GETFL)         = 0x8801 (flags O_WRONLY|O_NONBLOCK|O_LARGEFILE)
[pid   982] close(6)                    = 0
[pid   982] write(2, "kdeinit: Pipe closed unexpectedl"..., 43kdeinit: Pipe closed unexpectedly: Success
---------- ok
[pid  1064] getpid()                    = 1064
[pid  1064] getrlimit(0x3, 0xbffff724)  = 0
[pid  1064] close(5)                    = 0
[pid  1064] close(3)                    = 0
[pid  1064] rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
[pid  1064] rt_sigaction(SIGPIPE, {SIG_DFL}, {SIG_DFL}, 8) = 0
[pid  1064] chdir("/poola/home/ed")     = 0
[pid  1064] brk(0x805d000)              = 0x805d000
[pid  1064] open("/usr/lib/ksmserver.la", O_RDONLY) = 3
[pid  1064] fstat64(3, {st_dev=makedev(33, 3), st_ino=125820, st_mode=S_IFREG|0644, st_nlink=1, st_uid
=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=947, st_atime=2002/10/18-20:55:52, st_mtime=2002/0
8/13-08:32:59, st_ctime=2002/08/22-20:36:41}) = 0
[pid  1064] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
[pid  1064] read(3, "# ksmserver.la - a libtool libra"..., 4096) = 947
[pid  1064] read(3, "", 4096)           = 0
[pid  1064] close(3)                    = 0
[pid  1064] munmap(0x40014000, 4096)    = 0
[pid  1064] open("/usr/lib/ksmserver.so", O_RDONLY) = 3
[pid  1064] read(3,  <unfinished ...>
[pid  1016] <... select resumed> )      = 0 (Timeout)
[pid  1016] gettimeofday({1034989231, 109379}, NULL) = 0
[pid  1016] gettimeofday({1034989231, 109669}, NULL) = 0
[pid  1016] write(3, "=\0\4\0\22\0@\0\0\0\0\0\220\1<\0\232\6\5\0\23\0@\0\0\0"..., 356) = 356
[pid  1016] ioctl(3, 0x541b, [0])       = 0
[pid  1016] gettimeofday({1034989231, 113322}, NULL) = 0
[pid  1016] select(10, [3 5 7 9], NULL, NULL, {0, 395460} <unfinished ...>
[pid  1064] <... read resumed> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\262"..., 1024) = 1
024
[pid  1064] fstat64(3, {st_dev=makedev(33, 3), st_ino=125821, st_mode=S_IFREG|0644, st_nlink=1, st_uid
=0, st_gid=0, st_blksize=4096, st_blocks=184, st_size=92000, st_atime=2002/10/18-21:00:31, st_mtime=20
02/08/13-08:49:39, st_ctime=2002/08/22-20:36:41}) = 0
[pid  1064] old_mmap(NULL, 95284, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x41029000
[pid  1064] mprotect(0x4103f000, 5172, PROT_NONE) = 0
[pid  1064] old_mmap(0x4103f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x15000) = 0x41
03f000
[pid  1064] close(3)                    = 0
[pid  1064] write(6, "\0", 1 <unfinished ...>
[pid  1063] <... read resumed> "\0", 1) = 1
[pid  1064] <... write resumed> )       = 1
[pid  1063] close(5 <unfinished ...>
[pid  1064] close(6 <unfinished ...>
----------

I will send the compete straces to you and wli.

Really would like to see this working!

Ed Tomlinson
