Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbSLLXbA>; Thu, 12 Dec 2002 18:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLLXa7>; Thu, 12 Dec 2002 18:30:59 -0500
Received: from smtp.mailix.net ([216.148.213.132]:65346 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267540AbSLLXa6>;
	Thu, 12 Dec 2002 18:30:58 -0500
Date: Fri, 13 Dec 2002 00:38:44 +0100
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops: 2.5.51 lock_get_status
Message-ID: <20021212233844.GA405@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.51+bk as of 12 Dec 23:00 CET.

tried to strace(4.4) the d4x with follow-fork mode.
d4x is a multi-threaded app using posix advisory locks.
(http://www.krasu.ru/soft/chuchelo/)

The thing calls fcntl, which fails as if the file were locked:

open("/root/linux-2.5.51.tar.bz2", O_RDWR) = -1 ENOENT (No such file or directory)
open("/root/.linux-2.5.51.tar.bz2", O_RDWR|O_CREAT, 0600) = 8
time(NULL)                              = 1039734705
lseek(8, 0, SEEK_END)                   = 2377500
fcntl64(8, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=1}) = -1 EAGAIN (Resource temporarily unavailable)

i cannot guarantee that file wasn't actually locked by,
for instance, a detached and forgotten process of d4x,
because cat /proc/locks got segfault.
Decided it was interesting enough, and reported.

There was an oops in syslog also:

Dec 13 00:13:51 steel kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Dec 13 00:13:51 steel kernel:  printing eip:
Dec 13 00:13:51 steel kernel: c01557b0
Dec 13 00:13:51 steel kernel: *pde = 00000000
Dec 13 00:13:51 steel kernel: Oops: 0000
Dec 13 00:13:51 steel kernel: CPU:    0
Dec 13 00:13:51 steel kernel: EIP:    0060:[<c01557b0>]    Not tainted
Dec 13 00:13:51 steel kernel: EFLAGS: 00010282
Dec 13 00:13:51 steel kernel: EIP is at lock_get_status+0x18/0x210
Dec 13 00:13:51 steel kernel: eax: 00000000   ebx: d7b0f000   ecx: 00000001   edx: 00000001
Dec 13 00:13:51 steel kernel: esi: dbd164e0   edi: 00000000   ebp: d781bed8   esp: d781becc
Dec 13 00:13:51 steel kernel: ds: 0068   es: 0068   ss: 0068
Dec 13 00:13:51 steel kernel: Process cat (pid: 406, threadinfo=d781a000 task=d9e8a740)
Dec 13 00:13:51 steel kernel: Stack: d781bf0c dbd164e0 dbd164e4 d781bf14 c0155aaa d7b0f000 dbd164e0 00000001 
Dec 13 00:13:51 steel kernel:        c024d393 d781a000 00000c00 00000c00 d781bf0c d781bf10 00000c00 00000001 
Dec 13 00:13:51 steel kernel:        d7b0f000 00000000 d781bf38 c016a1b7 d7b0f000 d781bf74 00000000 00000c00 
Dec 13 00:13:51 steel kernel: Call Trace:
Dec 13 00:13:51 steel kernel:  [<c0155aaa>] get_locks_status+0x7a/0x148
Dec 13 00:13:51 steel kernel:  [<c016a1b7>] locks_read_proc+0x37/0x84
Dec 13 00:13:51 steel kernel:  [<c0167f68>] proc_file_read+0xdc/0x17c
Dec 13 00:13:51 steel kernel:  [<c0142b44>] vfs_read+0xc8/0x160
Dec 13 00:13:51 steel kernel:  [<c0142e16>] sys_read+0x2a/0x40
Dec 13 00:13:51 steel kernel:  [<c0108b47>] syscall_call+0x7/0xb
Dec 13 00:13:51 steel kernel: 
Dec 13 00:13:51 steel kernel: Code: 8b 78 08 8b 45 14 50 8b 45 10 50 68 ac d2 24 c0 53 e8 32 bb 

