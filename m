Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUA3Qxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUA3Qxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:53:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11546 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261909AbUA3Qx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:53:26 -0500
Date: Fri, 30 Jan 2004 16:53:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs sparse file failure in glibc "make check"
In-Reply-To: <4019D11C.7020706@backtobasicsmgmt.com>
Message-ID: <Pine.LNX.4.44.0401301552470.1441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Kevin P. Fleming wrote:
> 
> I've been tracking down a problem in CVS glibc "make check" and it 
> appears that either it's a bug in tmpfs or an undocumented limitation of 
> tmpfs.
> 
> My system is running 2.6.2-rc2, with 1G of physical RAM (4G highmem mode 
> is enabled in the kernel). The glibc test does the following (snipped 
> from the source because it's a simple test):
> 
> int fd;
> #define TWO_GB 2147483648LL
> 
> ...
> 
>    fd = mkstemp64 (name);
>    ret = lseek64 (fd, TWO_GB+100, SEEK_SET);
>    ret = write (fd, "Hello", 5);
> 
> 
> On my system the temp file is created in /tmp, and tmpfs is mounted on 
> /tmp (with no mount options limiting maximum size or anything of that 
> type). With no swap space turned on, this write() returns ENOMEM.
> 
> With 512MB or 1GB of swap space, it still returns ENOMEM. With 1.5GB of 
> swap space, the write() succeeds. However, this is a sparse file with a 
> total of 6 bytes of content :-)
> 
> I could understand if tmpfs was limiting the file size to half of 
> physical RAM+swap, but the test succeeds at 2.5GB total even though the 
> sparse file is created at 2GB size.
> 
> For now I work around the test failure by pointing glibc to a different 
> filesystem for this test, but I'm wondering why the tmpfs filesystem 
> can't pass this test like a "normal" filesystem does...

Drat.  Thank you for your efforts to track this down and describe it.
I'd call it a bug, a regression from 2.4, rather than an undocumented
limitation (generous of you to allow that interpretation).  Though not
a very urgent one to fix, given you're the first to notice in 18 months.

It's a side-effect of the non-overcommit memory mode (from 2.4-ac)
added in 2.5.30.  That was supposed not to change behaviour so long as
/proc/sys/vm/overcommit_memory remained at its traditional default 0.
But the extra vm_enough_memory checks needed for mode 2 (here the test
in shmem_file_write) have inadvertently imposed this limitation on mode 0.

A workaround is to "echo 1 > /proc/sys/vm/overcommit_memory" (or use
the VM_OVERCOMMIT_MEMORY sysctl), to skip all such tests.  But I don't
pretend that's a decent answer - especially not since vm_enough_memory
became a security_operations function, which may take no interest in
sysctl_overcommit_memory setting.

The difficulty is that conflicting conventions collide here in tmpfs.
In the case of shm and mmap, it's normal to check the full extent of
the mapping when it's set up (because the only way out later is OOM
killing); whereas in the case of a filesystem, it's normal to allow
sparseness and allocate only when written (though mmap of any sparse
file is an old contentious problem: what to do when no space?).

At present, the non-overcommit-memory arithmetic in mm/shmem.c works 
simply by filesize.  You can imagine an alternative accounting method
for the tmpfs mounts, which follows the actual page allocation (as
it already does to enforce its half(-or-whatever%)-of-memory limit).
But that gets more complicated once you mmap the tmpfs file, the two
conventions have to be reconciled in a consistent way (and it would
make a nonsense of strict non-overcommit memory mode to fall back
on the excuse that other filesystems have a sparse mmap problem).

I ought to fix this, but I'm averse to complexity.  I'll mull over
the options before fixing it: please don't hold your breath.

Hugh

