Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261589AbRERW2W>; Fri, 18 May 2001 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbRERW2M>; Fri, 18 May 2001 18:28:12 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:12530 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S261589AbRERW2E>; Fri, 18 May 2001 18:28:04 -0400
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: wnoise
From: wnoise@ugcs.caltech.edu (Aaron Denney)
Newsgroups: mlist.linux.kernel
Subject: Re: java/old_mmap allocation problems...
Date: 18 May 2001 22:09:05 GMT
Organization: California Institute of Technology, Pasadena
Message-ID: <slrn9gb7c0.tk7.wnoise@barter.ugcs.caltech.edu>
In-Reply-To: <linux.kernel.20010518083305.C7657@telecoma.net>
Reply-To: wnoise@ugcs.caltech.edu
NNTP-Posting-Host: barter.ugcs.caltech.edu
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Fri, 18 May 2001 08:33:05 +0200, firenza@gmx.net <firenza@gmx.net> wrote:
> i'm having problems to convince java (1.3.1) to allocate more
> than 1.9gb of memory on 2.4.2-ac2 (SMP/6gb phys mem) or more
> than 1.1gb on 2.2.18 (SMP/2gb phys mem)...
> 
> modifing /proc/sys/vm parameters didn't help either... the fact
> that i can allocate more memory under 2.4 than under 2.2 lets
> me hope that there is some possible kernel/vm tweaking that
> would increase those limits...

Part of it is the way the kernel set's up the processes VM space.  mmaps
that don't ask for a specific address get mapped starting at 0x40000000,
and the stack bottom is at 0xC0000000 - 1 page, and 0xC0000000-0xFFFFFFFF
is reserved for kernel pointers.  This only leaves 2 GB (- mapped in
shared libraries, - stack space) for your mmapping.  Both lowering the
0x40000000, and raising the 0xC000000 are fairly easy to do though.
(I would suggest 0x1000000, and 0xE0000000.  Note that ELF executables
get mapped in around 0x08000000, and that shrinking the kernel address
space too much will make it unhappy.)

In include/asm-i386/page.h, change __PAGE_OFFSET, which also changes 
PAGE_OFFSET, and TASK_SIZE 
In include/asm-i386/processor.h 
TASK_UNMAPPED_BASE
In arch/i386/vmlinux.lds, the def'n of _start (or . in recent kernels) should
be changed to __PAGE_OFFSET + 0x100000.

Part of it is undoubtedly the Java implementation.  I haven't run across
one that will let me use more than 2 GB, even with the above kernel
tweaks, (or on solaris / UltraSparc).

-- 
Aaron Denney
-><-
