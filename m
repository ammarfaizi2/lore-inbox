Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRHFKaT>; Mon, 6 Aug 2001 06:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbRHFKaJ>; Mon, 6 Aug 2001 06:30:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35713 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266040AbRHFK37>; Mon, 6 Aug 2001 06:29:59 -0400
Date: Mon, 6 Aug 2001 06:30:03 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806063003.H3862@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806105904.A28792@athlon.random>; from andrea@suse.de on Mon, Aug 06, 2001 at 10:59:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 10:59:04AM +0200, Andrea Arcangeli wrote:
> On Mon, Aug 06, 2001 at 04:41:21PM +1000, David Luyer wrote:
> > crashes for no apparent reason every 6 hours or so.. unless that could
> > be when
> > it hits some 'limit' on the number of mappings allowed? 
> 
> there's no limit, this is _only_ a performance issue, functionality is
> not compromised in any way [except possibly wasting some memory
> resources that could lead to running out of memory earlier].

There is a limit, /proc/sys/vm/max_map_count.
I believe this is what I reported a few weeks ago:
mprotect(2) does not ever attempt to merge segments, even for simple cases.
glibc malloc, if it runs out of normal brk heap, always allocates a fixed
size new heap (I think by default 2MB) aligned to its size and as the
memory is needed it always mprotects the area (e.g. page) which needs to be
allocated, so that it is readable/writeable.
So, e.g. for program which calls malloc(1024) in a loop,
the sequence of syscalls that glibc does once it runs out of brk is basically:
mmap2(NULL, 2097152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x40300000
munmap(0x40400000, 1048576)             = 0
mprotect(0x40300000, 32768, PROT_READ|PROT_WRITE) = 0
mprotect(0x40308000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x40309000, 4096, PROT_READ|PROT_WRITE) = 0
...
mprotect(0x403fd000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x403fe000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x403ff000, 4096, PROT_READ|PROT_WRITE) = 0
mmap2(NULL, 2097152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x40400000
munmap(0x40400000, 0)                   = -1 EINVAL (Invalid argument)
munmap(0x40500000, 1048576)             = 0
mprotect(0x40400000, 32768, PROT_READ|PROT_WRITE) = 0
mprotect(0x40408000, 4096, PROT_READ|PROT_WRITE) = 0
...
mprotect(0x509fd000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x509fe000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x509ff000, 4096, PROT_READ|PROT_WRITE) = 0

Each of these mprotect calls creates a new vma (although just growing the
prev would be sufficient).

This has the bad effect that one can (using malloc(1024)) allocate only a
small fraction of the available virtual address space (e.g. on i386
something like 1.1GB, ie. far less than 2.8GB which can be allocated
if /proc/sys/vm/max_map_count is bumped to say 512000).

Also, there is a bug in mprotect that it does not check max_map_count before
insert_vm_struct unlike mmap.c and other places. So, such malloc(1024) loop
allocates slightly more than max_map_count vma's until it gets hit in the
mmap syscall. But it should not be hard to construct a program which would
eat many times max_map_count (just mmap PROT_NONE most of VA, then mprotect
page by page).

	Jakub
