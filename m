Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267790AbTGHWdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbTGHWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:33:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15775 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267790AbTGHWcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:32:13 -0400
Date: Wed, 9 Jul 2003 00:45:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i'm pleased to announce the first public release of the "4GB/4GB VM split"
patch, for the 2.5.74 Linux kernel:

   http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8

The 4G/4G split feature is primarily intended for large-RAM x86 systems,
which want to (or have to) get more kernel/user VM, at the expense of
per-syscall TLB-flush overhead.

on x86, the total amount of virtual memory - as we all know - is limited
to 4GB. Of this total 4GB VM, userspace uses 3GB (0x00000000-0xbfffffff),
the kernel uses 1GB (0xc0000000-0xffffffff). This is VM scheme is called
the 3/1 split. This split works perfecly fine up until 1 GB of RAM - and
it works adequately well even after that, due to 'highmem', which moves
various larger caches (and objects) into the high memory area.

But as the amount of RAM increases, the 3/1 split becomes a real
bottleneck. Despite highmem being utilized by a number of large-size
caches, one of the most crutial data structures, the mem_map[], is
allocated out of the 1 GB kernel VM. With 32 GB of RAM the remaining 0.5
GB lowmem area is quite limited and only represents 1.5% of all RAM.
Various common workloads exhaust the lowmem area and create artificial
bottlenecks. With 64 GB RAM, the mem_map[] alone takes up nearly 1 GB of
RAM, making the kernel unable to boot. Relocating the mem_map[] to highmem
is very impractical, due to the deep integration of this central data
structure into the whole kernel - the VM, lowlevel arch code, drivers,
filesystems, etc.

with the 4G/4G patch, the kernel can be compiled in 4G/4G mode, in which
case there's a full, separate 4GB VM for the kernel, and there are
separate full (and per-process) 4GB VMs for user-space.

A typical /proc/PID/maps file of a process running on a 4G/4G kernel shows
a full 4GB address-space:

 00e80000-00faf000 r-xp 00000000 03:01 175909     /lib/tls/libc-2.3.2.so
 00faf000-00fb2000 rw-p 0012f000 03:01 175909     /lib/tls/libc-2.3.2.so
 [...]
 feffe000-ff000000 rwxp fffff000 00:00 0

the stack ends at 0xff000000 (4GB minus 16MB). The kernel has a 4GB lowmem
area, of which 3.1 GB is still usable even with 64 GB of RAM:

 MemTotal:     66052020 kB
 MemFree:      65958260 kB
 HighTotal:    62914556 kB
 HighFree:     62853140 kB
 LowTotal:      3137464 kB
 LowFree:       3105120 kB

the amount of lowmem is still more than 3 times the amount of lowmem
available to a 4GB system. It's more than 6 times the amount of lowmem a
32 GB system gets with the 3/1 split.

Performance impact of the 4G/4G feature:

There's a runtime cost with the 4G/4G patch: to implement separate address
spaces for the kernel and userspace VM, the entry/exit code has to switch
between the kernel pagetables and the user pagetables. This causes TLB
flushes, which are quite expensive, not so much in terms of TLB misses
(which are quite fast on Intel CPUs if they come from caches), but in
terms of the direct TLB flushing cost (%cr3 manipulation) done on
system-entry.

RAM limits:

in theory, the 4G/4G patch could provide a mem_map[] for 200 GB (!) of
physical RAM on x86, while still having 1 GB of lowmem left. So it gives
quite some legroom. While the right solution for lots of RAM is to use a
proper 64-bit system, there's alot of existing x86 hardware, and x86
servers will still be sold in the next couple of years, so we ought to
support them maximally.

The patch is orthogonal to wli's pgcl patch - both patches try to achieve
the same, with different methods. I can very well imagine workloads where
we want to have the combination of the two patches.

Implementational details:

the patch implements/touches a number of new lowlevel x86 infrastructures:

 - it moves the GDT, IDT, TSS, LDT, vsyscall page and kernel stack up into
   a high virtual memory window (trampoline) at the top 16 MB of the
   4GB address space. This 16 MB window is the only area that is shared 
   between user-space and kernel-space pagetables.

 - it splits out atomic kmaps from highmem dependencies.

 - it makes LDT(s) atomic-kmap-ed.

 - (and lots of other smaller details, like increasing the size of the
   initial mappings and fixing the PAE code to map the full 4GB of kernel
   VM.)

Whenever we do a syscall (or any other trap) from user-mode, the
high-address trampoline code starts to run, with a high-address esp0. This
code switches over to the kernel pagetable, then it switches the 'virtual
kernel stack' to the regular (real) kernel stack. On syscall-exit it does
it the other way around.

there are a few generic kernel changes as well:

 - it implements 'indirect uaccess' primitives and implements all the
   get_user/put_user/copy_to_user/... functions without relying on direct 
   access to user-space. This feature uncovered a number of bugs in the
   lowlevel x86 code already, there was still code that accessed
   user-space memory directly.

 - it splits up PAGE_OFFSET into PAGE_OFFSET_USER and PAGE_OFFSET (kernel)

 - fixes a couple of assumptions about PAGE_OFFSET being PMD_SIZE aligned.

but the generic-kernel impact of the patch is quite low.

the patch optimizes kernel<->kernel context switches and does not flush
the TLB, also, IRQ entry only cases a TLB flush if a userspace pagetable
is loaded.

the typical cost of 4G/4G on typical x86 servers is +3 usecs of syscall
latency (this is in addition to the ~1 usec null syscall latency).
Depending on the workload this can cause a typical measurable wall-clock
overhead from 0% to 30%, for typical application workloads (DB workload,
networking workload, etc.). Isolated microbenchmarks can show a bigger
slowdown as well - due to the syscall latency increase.

i'd guess that the 4G/4G patch is not worth the overhead for systems with
less than 16 GB of RAM (although exceptions might exist, for particularly
lowmem-intensive/sensitive workloads). 32 GB RAM systems run into lowmem
limitations quite frequently so the 4G/4G patch is quite recommended
there, and for 64 GB and larger systems it's a must i think.

Status, future plans:

The patch is a work-in-progress snapshot - it still has a few TODOs and
FIXMEs, but it compiles & works fine for me. Be careful with it
nevertheless - it's an experimental patch which does very intrusive
changes to the lowlevel x86 code.

There are a couple of performance enhancements ontop of this patch that
i'll integrate into this patch in the next couple of days, but i first
wanted to release the base patch.

In any case, enjoy the patch - and as usual, comments and suggestions are
more than welcome,

	Ingo

